Return-Path: <SRS0=Vfdp=LE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C43F2C48BCD
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E88B613BC
	for <iommu@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E88B613BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6D0FD600C6;
	Thu, 10 Jun 2021 02:03:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qm0fGGgEi_2f; Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 43271605E6;
	Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CCDEC000E;
	Thu, 10 Jun 2021 02:03:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F0FBC000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 67559831AC
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BPH0mWTEBTli for <iommu@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:03:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8E8908333F
 for <iommu@lists.linux-foundation.org>; Thu, 10 Jun 2021 02:03:41 +0000 (UTC)
IronPort-SDR: dv/1mZAhOSN6GbVPDsPbXfoYGhmfmmB8eY1oJGaA7FQtbuRc5MDQqNKdhLre7jfVl2TSdsBZUe
 AkPG9QBnAB3g==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="202184261"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="202184261"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2021 19:03:40 -0700
IronPort-SDR: rc8IrLeCVkOCJbSqpdnPwL/8FM0k2/R9FIMllHrI8nYTqT/TL0jRWRcKbDOmuDIYLlhiJ91OQ1
 +9mDYzIibmDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; d="scan'208";a="402500449"
Received: from allen-box.sh.intel.com ([10.239.159.105])
 by orsmga006.jf.intel.com with ESMTP; 09 Jun 2021 19:03:37 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH 14/23] iommu/vt-d: Expose latency monitor data through debugfs
Date: Thu, 10 Jun 2021 10:01:06 +0800
Message-Id: <20210610020115.1637656-15-baolu.lu@linux.intel.com>
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

A debugfs interface /sys/kernel/debug/iommu/intel/dmar_perf_latency is
created to control and show counts of execution time ranges for various
types per DMAR. The interface may help debug any potential performance
issue.

By default, the interface is disabled.

Possible write value of /sys/kernel/debug/iommu/intel/dmar_perf_latency
  0 - disable sampling all latency data
  1 - enable sampling IOTLB invalidation latency data
  2 - enable sampling devTLB invalidation latency data
  3 - enable sampling intr entry cache invalidation latency data
  4 - enable sampling prq handling latency data

Read /sys/kernel/debug/iommu/intel/dmar_perf_latency gives a snapshot
of sampling result of all enabled monitors.

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
Link: https://lore.kernel.org/r/20210520031531.712333-1-baolu.lu@linux.intel.com
---
 drivers/iommu/intel/debugfs.c | 111 ++++++++++++++++++++++++++++++++++
 drivers/iommu/intel/Kconfig   |   1 +
 2 files changed, 112 insertions(+)

diff --git a/drivers/iommu/intel/debugfs.c b/drivers/iommu/intel/debugfs.c
index efea7f02abd9..62e23ff3c987 100644
--- a/drivers/iommu/intel/debugfs.c
+++ b/drivers/iommu/intel/debugfs.c
@@ -16,6 +16,7 @@
 #include <asm/irq_remapping.h>
 
 #include "pasid.h"
+#include "perf.h"
 
 struct tbl_walk {
 	u16 bus;
@@ -31,6 +32,9 @@ struct iommu_regset {
 	const char *regs;
 };
 
+#define DEBUG_BUFFER_SIZE	1024
+static char debug_buf[DEBUG_BUFFER_SIZE];
+
 #define IOMMU_REGSET_ENTRY(_reg_)					\
 	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
 
@@ -538,6 +542,111 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 DEFINE_SHOW_ATTRIBUTE(ir_translation_struct);
 #endif
 
+static void latency_show_one(struct seq_file *m, struct intel_iommu *iommu,
+			     struct dmar_drhd_unit *drhd)
+{
+	int ret;
+
+	seq_printf(m, "IOMMU: %s Register Base Address: %llx\n",
+		   iommu->name, drhd->reg_base_addr);
+
+	ret = dmar_latency_snapshot(iommu, debug_buf, DEBUG_BUFFER_SIZE);
+	if (ret < 0)
+		seq_puts(m, "Failed to get latency snapshot");
+	else
+		seq_puts(m, debug_buf);
+	seq_puts(m, "\n");
+}
+
+static int latency_show(struct seq_file *m, void *v)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd)
+		latency_show_one(m, iommu, drhd);
+	rcu_read_unlock();
+
+	return 0;
+}
+
+static int dmar_perf_latency_open(struct inode *inode, struct file *filp)
+{
+	return single_open(filp, latency_show, NULL);
+}
+
+static ssize_t dmar_perf_latency_write(struct file *filp,
+				       const char __user *ubuf,
+				       size_t cnt, loff_t *ppos)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	int counting;
+	char buf[64];
+
+	if (cnt > 63)
+		cnt = 63;
+
+	if (copy_from_user(&buf, ubuf, cnt))
+		return -EFAULT;
+
+	buf[cnt] = 0;
+
+	if (kstrtoint(buf, 0, &counting))
+		return -EINVAL;
+
+	switch (counting) {
+	case 0:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd) {
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IOTLB);
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_DEVTLB);
+			dmar_latency_disable(iommu, DMAR_LATENCY_INV_IEC);
+			dmar_latency_disable(iommu, DMAR_LATENCY_PRQ);
+		}
+		rcu_read_unlock();
+		break;
+	case 1:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IOTLB);
+		rcu_read_unlock();
+		break;
+	case 2:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_DEVTLB);
+		rcu_read_unlock();
+		break;
+	case 3:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_INV_IEC);
+		rcu_read_unlock();
+		break;
+	case 4:
+		rcu_read_lock();
+		for_each_active_iommu(iommu, drhd)
+			dmar_latency_enable(iommu, DMAR_LATENCY_PRQ);
+		rcu_read_unlock();
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	*ppos += cnt;
+	return cnt;
+}
+
+static const struct file_operations dmar_perf_latency_fops = {
+	.open		= dmar_perf_latency_open,
+	.write		= dmar_perf_latency_write,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 void __init intel_iommu_debugfs_init(void)
 {
 	struct dentry *intel_iommu_debug = debugfs_create_dir("intel",
@@ -556,4 +665,6 @@ void __init intel_iommu_debugfs_init(void)
 	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &ir_translation_struct_fops);
 #endif
+	debugfs_create_file("dmar_perf_latency", 0644, intel_iommu_debug,
+			    NULL, &dmar_perf_latency_fops);
 }
diff --git a/drivers/iommu/intel/Kconfig b/drivers/iommu/intel/Kconfig
index 59be5447b775..43ebd8af11c5 100644
--- a/drivers/iommu/intel/Kconfig
+++ b/drivers/iommu/intel/Kconfig
@@ -28,6 +28,7 @@ config INTEL_IOMMU
 config INTEL_IOMMU_DEBUGFS
 	bool "Export Intel IOMMU internals in Debugfs"
 	depends on INTEL_IOMMU && IOMMU_DEBUGFS
+	select DMAR_PERF
 	help
 	  !!!WARNING!!!
 
-- 
2.25.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
