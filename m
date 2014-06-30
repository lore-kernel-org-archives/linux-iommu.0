From: Olav Haugan <ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [RFC/PATCH 3/7] iopoll: Introduce memory-mapped IO polling macros
Date: Mon, 30 Jun 2014 09:51:52 -0700
Message-ID: <1404147116-4598-4-git-send-email-ohaugan@codeaurora.org>
References: <1404147116-4598-1-git-send-email-ohaugan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1404147116-4598-1-git-send-email-ohaugan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, vgandhi-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

It is sometimes necessary to poll a memory-mapped register until its
value satisfies some condition. Introduce a family of convenience macros
that do this. Tight-loop and sleeping versions are provided with and
without timeouts.

Signed-off-by: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
 include/linux/iopoll.h | 114 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 114 insertions(+)
 create mode 100644 include/linux/iopoll.h

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
new file mode 100644
index 0000000..d085e03
--- /dev/null
+++ b/include/linux/iopoll.h
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2012-2014 The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ */
+
+#ifndef _LINUX_IOPOLL_H
+#define _LINUX_IOPOLL_H
+
+#include <linux/kernel.h>
+#include <linux/types.h>
+#include <linux/hrtimer.h>
+#include <linux/delay.h>
+#include <asm-generic/errno.h>
+#include <asm/io.h>
+
+/**
+ * readl_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)
+ * @timeout_us: Timeout in uS, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ */
+#define readl_poll_timeout(addr, val, cond, sleep_us, timeout_us) \
+({ \
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
+	might_sleep_if(timeout_us); \
+	for (;;) { \
+		(val) = readl(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
+			(val) = readl(addr); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range(DIV_ROUND_UP(sleep_us, 4), sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+/**
+ * readl_poll_timeout_noirq - Periodically poll an address until a condition is met or a timeout occurs
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @max_reads: Maximum number of reads before giving up
+ * @time_between_us: Time to udelay() between successive reads
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout.
+ */
+#define readl_poll_timeout_noirq(addr, val, cond, max_reads, time_between_us) \
+({ \
+	int count; \
+	for (count = (max_reads); count > 0; count--) { \
+		(val) = readl(addr); \
+		if (cond) \
+			break; \
+		udelay(time_between_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+/**
+ * readl_poll - Periodically poll an address until a condition is met
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in uS (0 tight-loops)
+ *
+ * Must not be called from atomic context if sleep_us is used.
+ */
+#define readl_poll(addr, val, cond, sleep_us) \
+	readl_poll_timeout(addr, val, cond, sleep_us, 0)
+
+/**
+ * readl_tight_poll_timeout - Tight-loop on an address until a condition is met or a timeout occurs
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @timeout_us: Timeout in uS, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if timeout_us is used.
+ */
+#define readl_tight_poll_timeout(addr, val, cond, timeout_us) \
+	readl_poll_timeout(addr, val, cond, 0, timeout_us)
+
+/**
+ * readl_tight_poll - Tight-loop on an address until a condition is met
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ *
+ * May be called from atomic context.
+ */
+#define readl_tight_poll(addr, val, cond) \
+	readl_poll_timeout(addr, val, cond, 0, 0)
+
+#endif /* _LINUX_IOPOLL_H */
-- 
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
