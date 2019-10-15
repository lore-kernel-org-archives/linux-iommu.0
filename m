Return-Path: <SRS0=BRyA=YI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E11BDECE588
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:12:15 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0D120873
	for <iommu@archiver.kernel.org>; Tue, 15 Oct 2019 11:12:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0D120873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5738FC9E;
	Tue, 15 Oct 2019 11:12:06 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id DE05DC77
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:12:02 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com
	[210.160.252.172])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 5E7DD821
	for <iommu@lists.linux-foundation.org>;
	Tue, 15 Oct 2019 11:12:02 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.67,299,1566831600"; d="scan'208";a="28928928"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie6.idc.renesas.com with ESMTP; 15 Oct 2019 20:12:00 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 90761420786F;
	Tue, 15 Oct 2019 20:12:00 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org
Subject: [PATCH v2 4/6] iommu/ipmmu-vmsa: Calculate context registers' offset
	instead of a macro
Date: Tue, 15 Oct 2019 20:11:58 +0900
Message-Id: <1571137920-15314-5-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571137920-15314-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1571137920-15314-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Since we will have changed memory mapping of the IPMMU in the future,
this patch uses ipmmu_features values instead of a macro to
calculate context registers offset. No behavior change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 drivers/iommu/ipmmu-vmsa.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index c60b31d..37bb4b7 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -50,6 +50,8 @@ struct ipmmu_features {
 	bool twobit_imttbcr_sl0;
 	bool reserved_context;
 	bool cache_snoop;
+	unsigned int ctx_offset_base;
+	unsigned int ctx_offset_stride;
 };
 
 struct ipmmu_vmsa_device {
@@ -99,8 +101,6 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 
 #define IM_NS_ALIAS_OFFSET		0x800
 
-#define IM_CTX_SIZE			0x40
-
 /* MMU "context" registers */
 #define IMCTR				0x0000		/* R-Car Gen2/3 */
 #define IMCTR_INTEN			(1 << 2)	/* R-Car Gen2/3 */
@@ -193,7 +193,8 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu, unsigned int offset,
 static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
 				  unsigned int context_id, unsigned int reg)
 {
-	return context_id * IM_CTX_SIZE + reg;
+	return mmu->features->ctx_offset_base +
+	       context_id * mmu->features->ctx_offset_stride + reg;
 }
 
 static u32 ipmmu_ctx_read(struct ipmmu_vmsa_device *mmu,
@@ -937,6 +938,8 @@ static const struct ipmmu_features ipmmu_features_default = {
 	.twobit_imttbcr_sl0 = false,
 	.reserved_context = false,
 	.cache_snoop = true,
+	.ctx_offset_base = 0,
+	.ctx_offset_stride = 0x40,
 };
 
 static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
@@ -948,6 +951,8 @@ static const struct ipmmu_features ipmmu_features_rcar_gen3 = {
 	.twobit_imttbcr_sl0 = true,
 	.reserved_context = true,
 	.cache_snoop = false,
+	.ctx_offset_base = 0,
+	.ctx_offset_stride = 0x40,
 };
 
 static const struct of_device_id ipmmu_of_ids[] = {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
