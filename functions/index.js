const { onSchedule } = require("firebase-functions/v2/scheduler");
const admin = require("firebase-admin");
const logger = require("firebase-functions/logger");

admin.initializeApp();

function formatDateInTimeZone(date, timeZone) {
    return date.toLocaleDateString("en-US", {
        timeZone: timeZone,
        year: "numeric",
        month: "long",
        day: "numeric",
    });
}

// Scheduled function: runs every day at 9 AM
exports.sendSubscriptionReminders = onSchedule(
    {
        schedule: "00 9 * * *",
        timeZone: "Asia/Karachi",
    },
    async (event) => {
        const usersRef = admin.firestore().collection("users");
        const usersSnap = await usersRef.get();

        for (const userDoc of usersSnap.docs) {
            const userData = userDoc.data();
            const deviceToken = userData.deviceToken;

            const subsSnap = await userDoc.ref.collection("users_subscriptions").get();

            for (const subDoc of subsSnap.docs) {
                const sub = subDoc.data();
                const nextPayment = sub.nextPaymentDate.toDate();

                const reminderDays = {
                    "1 Day Before": 1,
                    "3 Days Before": 3,
                    "1 Week Before": 7,
                }[sub.notificationAlert] || 0;

                // Calculate reminder date
                const reminderDate = new Date(nextPayment);
                reminderDate.setDate(reminderDate.getDate() - reminderDays);

                const today = new Date();

                // Send notification if today is reminder day or payment day
                if (
                    (reminderDate.getFullYear() === today.getFullYear() &&
                        reminderDate.getMonth() === today.getMonth() &&
                        reminderDate.getDate() === today.getDate()) ||
                    (nextPayment.getFullYear() === today.getFullYear() &&
                        nextPayment.getMonth() === today.getMonth() &&
                        nextPayment.getDate() === today.getDate())
                ) {
                    if (deviceToken) {
                        await admin.messaging().send({
                            token: deviceToken,
                            notification: {
                                title: "Subscription Reminder",
                                body: `${sub.subscriptionName} payment is due on ${formatDateInTimeZone(nextPayment, "Asia/Karachi")}.`,
                            },
                        });
                        logger.info(`Notification sent for ${sub.subscriptionName}`);
                    } else {
                        logger.warn(`No device token found for user ${userDoc.id}`);
                    }
                } else {
                    logger.info(`Not reminder day yet for ${sub.subscriptionName}`);
                }
            }
        }
        logger.info("Function finished running.");
        return null;
    }
);
