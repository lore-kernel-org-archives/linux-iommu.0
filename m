Return-Path: <SRS0=J+1i=42=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F1DC10F29
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC4472253D
	for <iommu@archiver.kernel.org>; Mon,  9 Mar 2020 20:43:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC4472253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B2F83872EA;
	Mon,  9 Mar 2020 20:43:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JTQ30g_NKqez; Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 99F808730B;
	Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8531EC1D87;
	Mon,  9 Mar 2020 20:43:21 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22B77C0177
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 1FBD887264
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wZIlcAG8O06M for <iommu@lists.linux-foundation.org>;
 Mon,  9 Mar 2020 19:53:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AFC6A872F0
 for <iommu@lists.linux-foundation.org>; Mon,  9 Mar 2020 19:53:17 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 09 Mar 2020 12:53:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,534,1574150400"; d="scan'208";a="234104036"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
 by fmsmga007.fm.intel.com with ESMTP; 09 Mar 2020 12:53:17 -0700
From: Megha Dey <megha.dey@linux.intel.com>
To: dwmw2@infradead.org, baolu.lu@linux.intel.com,
 iommu@lists.linux-foundation.org
Subject: [Patch V1 1/2] iommu/vt-d: Fix debugfs register reads
Date: Mon,  9 Mar 2020 13:09:46 -0700
Message-Id: <1583784587-26126-2-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1583784587-26126-1-git-send-email-megha.dey@linux.intel.com>
References: <1583784587-26126-1-git-send-email-megha.dey@linux.intel.com>
X-Mailman-Approved-At: Mon, 09 Mar 2020 20:43:19 +0000
Cc: Megha Dey <megha.dey@linux.intel.com>, megha.dey@intel.com
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

Commit 6825d3ea6cde ("iommu/vt-d: Add debugfs support to show register
contents") dumps the register contents for all IOMMU devices.

Currently, a 64 bit read(dmar_readq) is done for all the IOMMU registers,
even though some of the registers are 32 bits, which is incorrect.

Use the correct read function variant (dmar_readl/dmar_readq) while 
reading the contents of 32/64 bit registers respectively.

Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/iommu/intel-iommu-debugfs.c | 40 +++++++++++++++++++++++--------------
 include/linux/intel-iommu.h         |  2 ++
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/iommu/intel-iommu-debugfs.c b/drivers/iommu/intel-iommu-debugfs.c
index c1257be..0a77919 100644
--- a/drivers/iommu/intel-iommu-debugfs.c
+++ b/drivers/iommu/intel-iommu-debugfs.c
@@ -33,38 +33,42 @@ struct iommu_regset {
 
 #define IOMMU_REGSET_ENTRY(_reg_)					\
 	{ DMAR_##_reg_##_REG, __stringify(_reg_) }
-static const struct iommu_regset iommu_regs[] = {
+
+static const struct iommu_regset iommu_regs_32[] = {
 	IOMMU_REGSET_ENTRY(VER),
-	IOMMU_REGSET_ENTRY(CAP),
-	IOMMU_REGSET_ENTRY(ECAP),
 	IOMMU_REGSET_ENTRY(GCMD),
 	IOMMU_REGSET_ENTRY(GSTS),
-	IOMMU_REGSET_ENTRY(RTADDR),
-	IOMMU_REGSET_ENTRY(CCMD),
 	IOMMU_REGSET_ENTRY(FSTS),
 	IOMMU_REGSET_ENTRY(FECTL),
 	IOMMU_REGSET_ENTRY(FEDATA),
 	IOMMU_REGSET_ENTRY(FEADDR),
 	IOMMU_REGSET_ENTRY(FEUADDR),
-	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PMEN),
 	IOMMU_REGSET_ENTRY(PLMBASE),
 	IOMMU_REGSET_ENTRY(PLMLIMIT),
+	IOMMU_REGSET_ENTRY(ICS),
+	IOMMU_REGSET_ENTRY(PRS),
+	IOMMU_REGSET_ENTRY(PECTL),
+	IOMMU_REGSET_ENTRY(PEDATA),
+	IOMMU_REGSET_ENTRY(PEADDR),
+	IOMMU_REGSET_ENTRY(PEUADDR),
+};
+
+static const struct iommu_regset iommu_regs_64[] = {
+	IOMMU_REGSET_ENTRY(CAP),
+	IOMMU_REGSET_ENTRY(ECAP),
+	IOMMU_REGSET_ENTRY(RTADDR),
+	IOMMU_REGSET_ENTRY(CCMD),
+	IOMMU_REGSET_ENTRY(AFLOG),
 	IOMMU_REGSET_ENTRY(PHMBASE),
 	IOMMU_REGSET_ENTRY(PHMLIMIT),
 	IOMMU_REGSET_ENTRY(IQH),
 	IOMMU_REGSET_ENTRY(IQT),
 	IOMMU_REGSET_ENTRY(IQA),
-	IOMMU_REGSET_ENTRY(ICS),
 	IOMMU_REGSET_ENTRY(IRTA),
 	IOMMU_REGSET_ENTRY(PQH),
 	IOMMU_REGSET_ENTRY(PQT),
 	IOMMU_REGSET_ENTRY(PQA),
-	IOMMU_REGSET_ENTRY(PRS),
-	IOMMU_REGSET_ENTRY(PECTL),
-	IOMMU_REGSET_ENTRY(PEDATA),
-	IOMMU_REGSET_ENTRY(PEADDR),
-	IOMMU_REGSET_ENTRY(PEUADDR),
 	IOMMU_REGSET_ENTRY(MTRRCAP),
 	IOMMU_REGSET_ENTRY(MTRRDEF),
 	IOMMU_REGSET_ENTRY(MTRR_FIX64K_00000),
@@ -127,10 +131,16 @@ static int iommu_regset_show(struct seq_file *m, void *unused)
 		 * by adding the offset to the pointer (virtual address).
 		 */
 		raw_spin_lock_irqsave(&iommu->register_lock, flag);
-		for (i = 0 ; i < ARRAY_SIZE(iommu_regs); i++) {
-			value = dmar_readq(iommu->reg + iommu_regs[i].offset);
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_32); i++) {
+			value = dmar_readl(iommu->reg + iommu_regs_32[i].offset);
+			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
+				   iommu_regs_32[i].regs, iommu_regs_32[i].offset,
+				   value);
+		}
+		for (i = 0 ; i < ARRAY_SIZE(iommu_regs_64); i++) {
+			value = dmar_readq(iommu->reg + iommu_regs_64[i].offset);
 			seq_printf(m, "%-16s\t0x%02x\t\t0x%016llx\n",
-				   iommu_regs[i].regs, iommu_regs[i].offset,
+				   iommu_regs_64[i].regs, iommu_regs_64[i].offset,
 				   value);
 		}
 		raw_spin_unlock_irqrestore(&iommu->register_lock, flag);
diff --git a/include/linux/intel-iommu.h b/include/linux/intel-iommu.h
index 4a16b39..980234a 100644
--- a/include/linux/intel-iommu.h
+++ b/include/linux/intel-iommu.h
@@ -123,6 +123,8 @@
 
 #define dmar_readq(a) readq(a)
 #define dmar_writeq(a,v) writeq(v,a)
+#define dmar_readl(a) readl(a)
+#define dmar_writel(a, v) writel(v, a)
 
 #define DMAR_VER_MAJOR(v)		(((v) & 0xf0) >> 4)
 #define DMAR_VER_MINOR(v)		((v) & 0x0f)
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
