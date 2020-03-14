Return-Path: <SRS0=cr9L=47=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29797C10DCE
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 03:42:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E51942074A
	for <iommu@archiver.kernel.org>; Sat, 14 Mar 2020 03:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E51942074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8770087BDB;
	Sat, 14 Mar 2020 03:42:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id E2AOmas77v2G; Sat, 14 Mar 2020 03:42:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6AFC287BC0;
	Sat, 14 Mar 2020 03:42:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51015C18D3;
	Sat, 14 Mar 2020 03:42:40 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27FC1C0177
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 03:42:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2405288B58
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 03:42:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ddUDlKLoznUD for <iommu@lists.linux-foundation.org>;
 Sat, 14 Mar 2020 03:42:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5ABE8881BE
 for <iommu@lists.linux-foundation.org>; Sat, 14 Mar 2020 03:42:37 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 13 Mar 2020 20:42:36 -0700
IronPort-SDR: N48ZcuvretEFR9Cc6Hb8vLgcYb6dMxTL9Kmis4INdmwHq0eSrDE8NBQWpymQwyK97Hi3WnN753
 l5fLH93dLkXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,551,1574150400"; d="scan'208";a="235495411"
Received: from allen-box.sh.intel.com ([10.239.159.139])
 by fmsmga007.fm.intel.com with ESMTP; 13 Mar 2020 20:42:35 -0700
From: Lu Baolu <baolu.lu@linux.intel.com>
To: Joerg Roedel <joro@8bytes.org>
Subject: [PATCH v2 1/1] iommu/vt-d: Populate debugfs if IOMMUs are detected
Date: Sat, 14 Mar 2020 11:39:59 +0800
Message-Id: <20200314033959.21904-1-baolu.lu@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Cc: iommu@lists.linux-foundation.org, Megha Dey <megha.dey@linux.intel.com>,
 Dan Carpenter <dan.carpenter@oracle.com>
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

From: Megha Dey <megha.dey@linux.intel.com>

Currently, the intel iommu debugfs directory(/sys/kernel/debug/iommu/intel)
gets populated only when DMA remapping is enabled (dmar_disabled = 0)
irrespective of whether interrupt remapping is enabled or not.

Instead, populate the intel iommu debugfs directory if any IOMMUs are
detected.

Cc: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: ee2636b8670b1 ("iommu/vt-d: Enable base Intel IOMMU debugfs support")
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 11 ++++++++++-
 drivers/iommu/intel-iommu.c         |  4 +++-
 2 files changed, 13 insertions(+), 2 deletions(-)

Change log:
v1->v2:
  - Fix lock issue reported by Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index 0a7791934a16..3eb1fe240fb0 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -282,9 +282,16 @@ static int dmar_translation_struct_show(struct seq_file *m, void *unused)
 {
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
+	u32 sts;
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
+		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		if (!(sts & DMA_GSTS_TES)) {
+			seq_printf(m, "DMA Remapping is not enabled on %s\n",
+				   iommu->name);
+			continue;
+		}
 		root_tbl_walk(m, iommu);
 		seq_putc(m, '\n');
 	}
@@ -425,6 +432,7 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 	struct dmar_drhd_unit *drhd;
 	struct intel_iommu *iommu;
 	u64 irta;
+	u32 sts;
 
 	rcu_read_lock();
 	for_each_active_iommu(iommu, drhd) {
@@ -434,7 +442,8 @@ static int ir_translation_struct_show(struct seq_file *m, void *unused)
 		seq_printf(m, "Remapped Interrupt supported on IOMMU: %s\n",
 			   iommu->name);
 
-		if (iommu->ir_table) {
+		sts = dmar_readl(iommu->reg + DMAR_GSTS_REG);
+		if (iommu->ir_table && (sts & DMA_GSTS_IRES)) {
 			irta = virt_to_phys(iommu->ir_table->base);
 			seq_printf(m, " IR table address:%llx\n", irta);
 			ir_tbl_remap_entry_show(m, iommu);
diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
index 693380355dea..ec122b8a746b 100644
--- a/drivers/iommu/intel-iommu.c
+++ b/drivers/iommu/intel-iommu.c
@@ -5130,6 +5130,9 @@ int __init intel_iommu_init(void)
 
 	down_write(&dmar_global_lock);
 
+	if (!no_iommu)
+		intel_iommu_debugfs_init();
+
 	if (no_iommu || dmar_disabled) {
 		/*
 		 * We exit the function here to ensure IOMMU's remapping and
@@ -5225,7 +5228,6 @@ int __init intel_iommu_init(void)
 	pr_info("Intel(R) Virtualization Technology for Directed I/O\n");
 
 	intel_iommu_enabled = 1;
-	intel_iommu_debugfs_init();
 
 	return 0;
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
