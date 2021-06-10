Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D086CC48BCF
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 901D36140F
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 901D36140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5832583466;
	Thu, 10 Jun 2021 02:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KX3yBryHDIpG; Thu, 10 Jun 2021 02:03:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1330E83267;
	Thu, 10 Jun 2021 02:03:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEEDDC000E;
	Thu, 10 Jun 2021 02:03:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B391FC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 945C9831AC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ACKhh24KoYPs for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 87B2C83211
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:37 +0000 (UTC)
IronPort-SDR: lpmMFqHVMGHS3SFnSeKhgnmyFMn7xhyONlD1+DO4szFnw0xrdaseOz03pxhCAjfOxmIZXTfiTW
 ZAKiTykiCcYA==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184255"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184255"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:37 -0700
IronPort-SDR: 6CMGDlSZ1abseH1nyyYMLREQOmtpnYMVQMqzB3hMuCFWpBq+Z3rHMxvf16BSSFdVcZU7iutNsp
 jkdTlgI9ZXig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500431"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:34 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 13/23] iommu/vt-d: Add common code for dmar latency
 performance monitors
Date: Thu, 10 Jun 2021 10:01:05 +0800
Message-Id: <20210610020115.1637656-14-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
References: <20210610020115.1637656-1-baolu.lu@linux.intel.com>
MIME-Version: 1.0
Cc: Fenghua Yu <fenghua.yu@intel.com>, Ashok Raj <ashok.raj@intel.com>,
 Aditya Srivastava <yashsri421@gmail.com>, Randy Dunlap <rdunlap@infradead.org>,
 YueHaibing <yuehaibing@huawei.com>,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 iommu@lists.linux-foundation.org, Colin Ian King <colin.king@canonical.com>,
 Will Deacon <will@kernel.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

The execution time of some operations is very performance critical, such
as cache invalidation and PRQ processing time. This adds some common code
to monitor the execution time range of those operations. The interfaces
include enabling/disabling, checking status, updating sampling data and
providing a common string format for users.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
---
 include/linux/intel-iommu.h  |   1 +
 drivers/iommu/intel/perf.h   |  73 +++++++++++++++
 drivers/iommu/intel/perf.c   | 166 +++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/Kconfig  |   3 +
 drivers/iommu/intel/Makefile |   1 +
 5 files changed, 244 insertions(+)
 create mode 100644 drivers/iommu/intel/perf.h
 create mode 100644 drivers/iommu/intel/perf.c

diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 98b04fa9373e..f5cf31dd7280 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -621,6 +621,7 @@ struct intel_iommu {
 	u32		flags;      /* Software defined flags */
 
 	struct dmar_drhd_unit *drhd;
+	void *perf_statistic;
 };
 
 /* Per subdevice private data */
diff --git a/drivers/iommu/intel/perf.h b/drivers/iommu/intel/perf.h
new file mode 100644
index 000000000000..fd6db8049d1a
--- /dev/null
+++ b/drivers/iommu/intel/perf.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * perf.h - performance monitor header
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ */
+
+enum latency_type {
+	DMAR_LATENCY_INV_IOTLB = 0,
+	DMAR_LATENCY_INV_DEVTLB,
+	DMAR_LATENCY_INV_IEC,
+	DMAR_LATENCY_PRQ,
+	DMAR_LATENCY_NUM
+};
+
+enum latency_count {
+	COUNTS_10e2 = 0,	/* < 0.1us	*/
+	COUNTS_10e3,		/* 0.1us ~ 1us	*/
+	COUNTS_10e4,		/* 1us ~ 10us	*/
+	COUNTS_10e5,		/* 10us ~ 100us	*/
+	COUNTS_10e6,		/* 100us ~ 1ms	*/
+	COUNTS_10e7,		/* 1ms ~ 10ms	*/
+	COUNTS_10e8_plus,	/* 10ms and plus*/
+	COUNTS_MIN,
+	COUNTS_MAX,
+	COUNTS_SUM,
+	COUNTS_NUM
+};
+
+struct latency_statistic {
+	bool enabled;
+	u64 counter[COUNTS_NUM];
+	u64 samples;
+};
+
+#ifdef CONFIG_DMAR_PERF
+int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type);
+void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type);
+bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type);
+void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type,
+			 u64 latency);
+int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size);
+#else
+static inline int
+dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
+{
+	return -EINVAL;
+}
+
+static inline void
+dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type)
+{
+}
+
+static inline bool
+dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type)
+{
+	return false;
+}
+
+static inline void
+dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 latency)
+{
+}
+
+static inline int
+dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
+{
+	return 0;
+}
+#endif /* CONFIG_DMAR_PERF */
diff --git a/drivers/iommu/intel/perf.c b/drivers/iommu/intel/perf.c
new file mode 100644
index 000000000000..faaa96dda437
--- /dev/null
+++ b/drivers/iommu/intel/perf.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0
+/**
+ * perf.c - performance monitor
+ *
+ * Copyright (C) 2021 Intel Corporation
+ *
+ * Author: Lu Baolu <baolu.lu@linux.intel.com>
+ *         Fenghua Yu <fenghua.yu@intel.com>
+ */
+
+#include <linux/spinlock.h>
+#include <linux/intel-iommu.h>
+
+#include "perf.h"
+
+static DEFINE_SPINLOCK(latency_lock);
+
+bool dmar_latency_enabled(struct intel_iommu *iommu, enum latency_type type)
+{
+	struct latency_statistic *lstat = iommu->perf_statistic;
+
+	return lstat && lstat[type].enabled;
+}
+
+int dmar_latency_enable(struct intel_iommu *iommu, enum latency_type type)
+{
+	struct latency_statistic *lstat;
+	unsigned long flags;
+	int ret = -EBUSY;
+
+	if (dmar_latency_enabled(iommu, type))
+		return 0;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	if (!iommu->perf_statistic) {
+		iommu->perf_statistic = kzalloc(sizeof(*lstat) * DMAR_LATENCY_NUM,
+						GFP_ATOMIC);
+		if (!iommu->perf_statistic) {
+			ret = -ENOMEM;
+			goto unlock_out;
+		}
+	}
+
+	lstat = iommu->perf_statistic;
+
+	if (!lstat[type].enabled) {
+		lstat[type].enabled = true;
+		lstat[type].counter[COUNTS_MIN] = UINT_MAX;
+		ret = 0;
+	}
+unlock_out:
+	spin_unlock_irqrestore(&latency_lock, flags);
+
+	return ret;
+}
+
+void dmar_latency_disable(struct intel_iommu *iommu, enum latency_type type)
+{
+	struct latency_statistic *lstat = iommu->perf_statistic;
+	unsigned long flags;
+
+	if (!dmar_latency_enabled(iommu, type))
+		return;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	memset(&lstat[type], 0, sizeof(*lstat) * DMAR_LATENCY_NUM);
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+
+void dmar_latency_update(struct intel_iommu *iommu, enum latency_type type, u64 latency)
+{
+	struct latency_statistic *lstat = iommu->perf_statistic;
+	unsigned long flags;
+	u64 min, max;
+
+	if (!dmar_latency_enabled(iommu, type))
+		return;
+
+	spin_lock_irqsave(&latency_lock, flags);
+	if (latency < 100)
+		lstat[type].counter[COUNTS_10e2]++;
+	else if (latency < 1000)
+		lstat[type].counter[COUNTS_10e3]++;
+	else if (latency < 10000)
+		lstat[type].counter[COUNTS_10e4]++;
+	else if (latency < 100000)
+		lstat[type].counter[COUNTS_10e5]++;
+	else if (latency < 1000000)
+		lstat[type].counter[COUNTS_10e6]++;
+	else if (latency < 10000000)
+		lstat[type].counter[COUNTS_10e7]++;
+	else
+		lstat[type].counter[COUNTS_10e8_plus]++;
+
+	min = lstat[type].counter[COUNTS_MIN];
+	max = lstat[type].counter[COUNTS_MAX];
+	lstat[type].counter[COUNTS_MIN] = min_t(u64, min, latency);
+	lstat[type].counter[COUNTS_MAX] = max_t(u64, max, latency);
+	lstat[type].counter[COUNTS_SUM] += latency;
+	lstat[type].samples++;
+	spin_unlock_irqrestore(&latency_lock, flags);
+}
+
+static char *latency_counter_names[] = {
+	"                  <0.1us",
+	"   0.1us-1us", "    1us-10us", "  10us-100us",
+	"   100us-1ms", "    1ms-10ms", "      >=10ms",
+	"     min(us)", "     max(us)", " average(us)"
+};
+
+static char *latency_type_names[] = {
+	"   inv_iotlb", "  inv_devtlb", "     inv_iec",
+	"     svm_prq"
+};
+
+int dmar_latency_snapshot(struct intel_iommu *iommu, char *str, size_t size)
+{
+	struct latency_statistic *lstat = iommu->perf_statistic;
+	unsigned long flags;
+	int bytes = 0, i, j;
+
+	memset(str, 0, size);
+
+	for (i = 0; i < COUNTS_NUM; i++)
+		bytes += snprintf(str + bytes, size - bytes,
+				  "%s", latency_counter_names[i]);
+
+	spin_lock_irqsave(&latency_lock, flags);
+	for (i = 0; i < DMAR_LATENCY_NUM; i++) {
+		if (!dmar_latency_enabled(iommu, i))
+			continue;
+
+		bytes += snprintf(str + bytes, size - bytes,
+				  "\n%s", latency_type_names[i]);
+
+		for (j = 0; j < COUNTS_NUM; j++) {
+			u64 val = lstat[i].counter[j];
+
+			switch (j) {
+			case COUNTS_MIN:
+				if (val == UINT_MAX)
+					val = 0;
+				else
+					val /= 1000;
+				break;
+			case COUNTS_MAX:
+				val /= 1000;
+				break;
+			case COUNTS_SUM:
+				if (lstat[i].samples)
+					val /= (lstat[i].samples * 1000);
+				else
+					val = 0;
+				break;
+			default:
+				break;
+			}
+
+			bytes += snprintf(str + bytes, size - bytes,
+					  "%12lld", val);
+		}
+	}
+	spin_unlock_irqrestore(&latency_lock, flags);
+
+	return bytes;
+}
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index a37bd54c5b90..59be5447b775 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -3,6 +3,9 @@
 config DMAR_TABLE
 	bool
 
+config DMAR_PERF
+	bool
+
 config INTEL_IOMMU
 	bool "Support for Intel IOMMU using DMA Remapping Devices"
 	depends on PCI_MSI && ACPI && (X86 || IA64)
diff --git a/drivers/iommu/intel/Makefile b/drivers/iommu/intel/Makefile
index ae236ec7d219..fa0dae16441c 100644
--- a/drivers/iommu/intel/Makefile
+++ b/drivers/iommu/intel/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_DMAR_TABLE) += dmar.o
 obj-$(CONFIG_INTEL_IOMMU) += iommu.o pasid.o
 obj-$(CONFIG_DMAR_TABLE) += trace.o cap_audit.o
+obj-$(CONFIG_DMAR_PERF) += perf.o
 obj-$(CONFIG_INTEL_IOMMU_DEBUGFS) += debugfs.o
 obj-$(CONFIG_INTEL_IOMMU_SVM) += svm.o
 obj-$(CONFIG_IRQ_REMAP) += irq_remapping.o
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
