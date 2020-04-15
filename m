Return-Path: <SRS0=YkH/=57=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBCCC3815B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9481D2078B
	for <iommu@archiver.kernel.org>; Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9481D2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6A84C8511F;
	Wed, 15 Apr 2020 05:29:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PDw2NYvspi11; Wed, 15 Apr 2020 05:29:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EBAF7844A5;
	Wed, 15 Apr 2020 05:29:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DB042C1D7D;
	Wed, 15 Apr 2020 05:29:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 980A3C0172
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93C24844A5
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xd8kco5C_RZP for <iommu@lists.linux-foundation.org>;
 Wed, 15 Apr 2020 05:29:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E3ED084508
 for <iommu@lists.linux-foundation.org>; Wed, 15 Apr 2020 05:29:06 +0000 (UTC)
IronPort-SDR: 90ahRaSGr4IEoN0ZObzV/BC8hsTmChgykFFffwsMmTWaj9D4gFK/EGESa1WeV4zUn+J04lotKW
 /FVLDBzfCEDw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Apr 2020 22:29:06 -0700
IronPort-SDR: kzJs5swUCQyXbXQgnABwQPoXcjozjv8J9h3VYxP0kNLONwAX1xT90OSggwBh9MAw6Os1WzFgCx
 TyeaA+sGLZZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,385,1580803200"; d="scan'208";a="277504206"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga004.fm.intel.com with ESMTP; 14 Apr 2020 22:29:04 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 3/7] iommu/vt-d: debugfs: Add support to show inv queue
 internals
Date: Wed, 15 Apr 2020 13:25:38 +0800
Message-Id: <20200415052542.30421-4-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200415052542.30421-1-baolu.lu@linux.intel.com>
References: <20200415052542.30421-1-baolu.lu@linux.intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Export invalidation queue internals of each iommu device through
the debugfs.

Example of such dump on a Skylake machine:

$ sudo cat /sys/kernel/debug/iommu/intel/invalidation_queue
Invalidation queue on IOMMU: dmar1
 Base: 0x1672c9000      Head: 80        Tail: 80
Index           qw0                     qw1                     status
    0   0000000000000004        0000000000000000        0000000000000000
    1   0000000200000025        00000001672be804        0000000000000000
    2   0000000000000011        0000000000000000        0000000000000000
    3   0000000200000025        00000001672be80c        0000000000000000
    4   00000000000000d2        0000000000000000        0000000000000000
    5   0000000200000025        00000001672be814        0000000000000000
    6   0000000000000014        0000000000000000        0000000000000000
    7   0000000200000025        00000001672be81c        0000000000000000
    8   0000000000000014        0000000000000000        0000000000000000
    9   0000000200000025        00000001672be824        0000000000000000

Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 62 +++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 3eb1fe240fb0..e3089865b8f3 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -372,6 +372,66 @@ static int domain_translation_struct_show(struct seq_file *m, void *unused)
 }
 DEFINE_SHOW_ATTRIBUTE(domain_translation_struct);
 
+static void invalidation_queue_entry_show(struct seq_file *m,
+					  struct intel_iommu *iommu)
+{
+	int index, shift = qi_shift(iommu);
+	struct qi_desc *desc;
+	int offset;
+
+	if (ecap_smts(iommu->ecap))
+		seq_puts(m, "Index\t\tqw0\t\t\tqw1\t\t\tqw2\t\t\tqw3\t\t\tstatus\n");
+	else
+		seq_puts(m, "Index\t\tqw0\t\t\tqw1\t\t\tstatus\n");
+
+	for (index = 0; index < QI_LENGTH; index++) {
+		offset = index << shift;
+		desc = iommu->qi->desc + offset;
+		if (ecap_smts(iommu->ecap))
+			seq_printf(m, "%5d\t%016llx\t%016llx\t%016llx\t%016llx\t%016x\n",
+				   index, desc->qw0, desc->qw1,
+				   desc->qw2, desc->qw3,
+				   iommu->qi->desc_status[index]);
+		else
+			seq_printf(m, "%5d\t%016llx\t%016llx\t%016x\n",
+				   index, desc->qw0, desc->qw1,
+				   iommu->qi->desc_status[index]);
+	}
+}
+
+static int invalidation_queue_show(struct seq_file *m, void *unused)
+{
+	struct dmar_drhd_unit *drhd;
+	struct intel_iommu *iommu;
+	unsigned long flags;
+	struct q_inval *qi;
+	int shift;
+
+	rcu_read_lock();
+	for_each_active_iommu(iommu, drhd) {
+		qi = iommu->qi;
+		shift = qi_shift(iommu);
+
+		if (!qi || !ecap_qis(iommu->ecap))
+			continue;
+
+		seq_printf(m, "Invalidation queue on IOMMU: %s\n", iommu->name);
+
+		raw_spin_lock_irqsave(&qi->q_lock, flags);
+		seq_printf(m, " Base: 0x%llx\tHead: %lld\tTail: %lld\n",
+			   virt_to_phys(qi->desc),
+			   dmar_readq(iommu->reg + DMAR_IQH_REG) >> shift,
+			   dmar_readq(iommu->reg + DMAR_IQT_REG) >> shift);
+		invalidation_queue_entry_show(m, iommu);
+		raw_spin_unlock_irqrestore(&qi->q_lock, flags);
+		seq_putc(m, '\n');
+	}
+	rcu_read_unlock();
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(invalidation_queue);
+
 #ifdef CONFIG_IRQ_REMAP
 static void ir_tbl_remap_entry_show(struct seq_file *m,
 				    struct intel_iommu *iommu)
@@ -490,6 +550,8 @@ void __init intel_iommu_debugfs_init(void)
 	debugfs_create_file("domain_translation_struct", 0444,
 			    intel_iommu_debug, NULL,
 			    &domain_translation_struct_fops);
+	debugfs_create_file("invalidation_queue", 0444, intel_iommu_debug,
+			    NULL, &invalidation_queue_fops);
 #ifdef CONFIG_IRQ_REMAP
 	debugfs_create_file("ir_translation_struct", 0444, intel_iommu_debug,
 			    NULL, &ir_translation_struct_fops);
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
