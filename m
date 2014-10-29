From: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Subject: [PATCH v7 1/2] iopoll: Introduce memory-mapped IO polling macros
Date: Wed, 29 Oct 2014 14:13:39 -0700
Message-ID: <1414617220-21493-2-git-send-email-mitchelh@codeaurora.org>
References: <1414617220-21493-1-git-send-email-mitchelh@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1414617220-21493-1-git-send-email-mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

From: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>

It is sometimes necessary to poll a memory-mapped register until its value
satisfies some condition. Introduce a family of convenience macros that do
this. Tight-looping, sleeping, and timing out can all be accomplished using
these macros.

Cc: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Signed-off-by: Matt Wagantall <mattw-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Signed-off-by: Mitchel Humpherys <mitchelh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
---
Changes since v6:
  - No changes. Resending due to changes in the the next patch in the series.
---
 include/linux/iopoll.h | 213 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 213 insertions(+)
 create mode 100644 include/linux/iopoll.h

diff --git a/include/linux/iopoll.h b/include/linux/iopoll.h
new file mode 100644
index 0000000000..21dd41942b
--- /dev/null
+++ b/include/linux/iopoll.h
@@ -0,0 +1,213 @@
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
+#include <linux/errno.h>
+#include <linux/io.h>
+
+/**
+ * readx_poll_timeout - Periodically poll an address until a condition is met or a timeout occurs
+ * @op: accessor function (takes @addr as its only argument)
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @sleep_us: Maximum time to sleep between reads in us (0 tight-loops)
+ * @timeout_us: Timeout in us, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val. Must not
+ * be called from atomic context if sleep_us or timeout_us are used.
+ *
+ * Generally you'll want to use one of the specialized macros defined below
+ * rather than this macro directly.
+ */
+#define readx_poll_timeout(op, addr, val, cond, sleep_us, timeout_us)	\
+({ \
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
+	might_sleep_if(sleep_us); \
+	for (;;) { \
+		(val) = op(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
+			(val) = op(addr); \
+			break; \
+		} \
+		if (sleep_us) \
+			usleep_range((sleep_us >> 2) + 1, sleep_us); \
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+/**
+ * readx_poll_timeout_atomic - Periodically poll an address until a condition is met or a timeout occurs
+ * @op: accessor function (takes @addr as its only argument)
+ * @addr: Address to poll
+ * @val: Variable to read the value into
+ * @cond: Break condition (usually involving @val)
+ * @delay_us: Time to udelay between reads in us (0 tight-loops)
+ * @timeout_us: Timeout in us, 0 means never timeout
+ *
+ * Returns 0 on success and -ETIMEDOUT upon a timeout. In either
+ * case, the last read value at @addr is stored in @val.
+ *
+ * Generally you'll want to use one of the specialized macros defined below
+ * rather than this macro directly.
+ */
+#define readx_poll_timeout_atomic(op, addr, val, cond, delay_us, timeout_us) \
+({ \
+	ktime_t timeout = ktime_add_us(ktime_get(), timeout_us); \
+	for (;;) { \
+		(val) = op(addr); \
+		if (cond) \
+			break; \
+		if (timeout_us && ktime_compare(ktime_get(), timeout) > 0) { \
+			(val) = op(addr); \
+			break; \
+		} \
+		if (delay_us) \
+			udelay(delay_us);	\
+	} \
+	(cond) ? 0 : -ETIMEDOUT; \
+})
+
+
+#define readl_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readl, addr, val, cond, delay_us, timeout_us)
+
+#define readl_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readl, addr, val, cond, delay_us, timeout_us)
+
+#define readb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readb, addr, val, cond, delay_us, timeout_us)
+
+#define readb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readb, addr, val, cond, delay_us, timeout_us)
+
+#define readw_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readw, addr, val, cond, delay_us, timeout_us)
+
+#define readw_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readw, addr, val, cond, delay_us, timeout_us)
+
+#define readq_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readq, addr, val, cond, delay_us, timeout_us)
+
+#define readq_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readq, addr, val, cond, delay_us, timeout_us)
+
+#define readb_relaxed_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readb_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readb_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readb_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readw_relaxed_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readw_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readw_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readw_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readl_relaxed_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readl_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readl_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readl_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readq_relaxed_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(readq_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define readq_relaxed_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(readq_relaxed, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread8_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread8, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16be_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread16be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread16be_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread16be, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32b3_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(ioread32b3, addr, val, cond, delay_us, timeout_us)
+
+#define ioread32b3_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(ioread32b3, addr, val, cond, delay_us, timeout_us)
+
+#define inb_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inb, addr, val, cond, delay_us, timeout_us)
+
+#define inb_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inb, addr, val, cond, delay_us, timeout_us)
+
+#define inb_p_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inb_p, addr, val, cond, delay_us, timeout_us)
+
+#define inb_p_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inb_p, addr, val, cond, delay_us, timeout_us)
+
+#define inw_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inw, addr, val, cond, delay_us, timeout_us)
+
+#define inw_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inw, addr, val, cond, delay_us, timeout_us)
+
+#define inw_p_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inw_p, addr, val, cond, delay_us, timeout_us)
+
+#define inw_p_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inw_p, addr, val, cond, delay_us, timeout_us)
+
+#define inw_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inw, addr, val, cond, delay_us, timeout_us)
+
+#define inw_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inw, addr, val, cond, delay_us, timeout_us)
+
+#define inl_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inl, addr, val, cond, delay_us, timeout_us)
+
+#define inl_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inl, addr, val, cond, delay_us, timeout_us)
+
+#define inl_p_poll_timeout(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout(inl_p, addr, val, cond, delay_us, timeout_us)
+
+#define inl_p_poll_timeout_atomic(addr, val, cond, delay_us, timeout_us) \
+	readx_poll_timeout_atomic(inl_p, addr, val, cond, delay_us, timeout_us)
+
+
+#endif /* _LINUX_IOPOLL_H */
-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
