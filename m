Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B1EC282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:36 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60EC7218FD
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60EC7218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id F23501209;
	Wed, 24 Apr 2019 13:55:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 2974F11D7
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [195.130.137.89])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 681BB82E
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:23 +0000 (UTC)
Received: from ramsan ([84.194.111.163]) by laurent.telenet-ops.be with bizsmtp
	id 4DvM2000L3XaVaC01DvMAC; Wed, 24 Apr 2019 15:55:21 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMr-000882-LY; Wed, 24 Apr 2019 15:55:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMr-0006YY-JY; Wed, 24 Apr 2019 15:55:21 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v3 2/6] iommu/ipmmu-vmsa: Prepare to handle 40-bit error
	addresses
Date: Wed, 24 Apr 2019 15:55:14 +0200
Message-Id: <20190424135518.25150-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190424135518.25150-1-geert+renesas@glider.be>
References: <20190424135518.25150-1-geert+renesas@glider.be>
Cc: linux-renesas-soc@vger.kernel.org, iommu@lists.linux-foundation.org,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190424135514.IyZAd7sInhWXboalZOTbcF4Hy2XyAC1VyjBuHd0CLvQ@z>

On R-Car Gen3, the faulting virtual address is a 40-bit address, and
comprised of two registers.  Read the upper address part, and combine
both parts, when running on a 64-bit system.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
Apart from this, the driver doesn't support 40-bit IOVA addresses yet.

v3:
  - Add Reviewed-by,

v2:
  - Merge IMEAR/IMELAR.
---
 drivers/iommu/ipmmu-vmsa.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 9f2b781e20a0eba6..f2061bd1dc7b8852 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -186,7 +186,8 @@ static struct ipmmu_vmsa_device *to_ipmmu(struct device *dev)
 #define IMMAIR_ATTR_IDX_WBRWA		1
 #define IMMAIR_ATTR_IDX_DEV		2
 
-#define IMEAR				0x0030
+#define IMELAR				0x0030	/* IMEAR on R-Car Gen2 */
+#define IMEUAR				0x0034	/* R-Car Gen3 only */
 
 #define IMPCTR				0x0200
 #define IMPSTR				0x0208
@@ -522,14 +523,16 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 {
 	const u32 err_mask = IMSTR_MHIT | IMSTR_ABORT | IMSTR_PF | IMSTR_TF;
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
+	unsigned long iova;
 	u32 status;
-	u32 iova;
 
 	status = ipmmu_ctx_read_root(domain, IMSTR);
 	if (!(status & err_mask))
 		return IRQ_NONE;
 
-	iova = ipmmu_ctx_read_root(domain, IMEAR);
+	iova = ipmmu_ctx_read_root(domain, IMELAR);
+	if (IS_ENABLED(CONFIG_64BIT))
+		iova |= (u64)ipmmu_ctx_read_root(domain, IMEUAR) << 32;
 
 	/*
 	 * Clear the error status flags. Unlike traditional interrupt flag
@@ -541,10 +544,10 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 
 	/* Log fatal errors. */
 	if (status & IMSTR_MHIT)
-		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%08x\n",
+		dev_err_ratelimited(mmu->dev, "Multiple TLB hits @0x%lx\n",
 				    iova);
 	if (status & IMSTR_ABORT)
-		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%08x\n",
+		dev_err_ratelimited(mmu->dev, "Page Table Walk Abort @0x%lx\n",
 				    iova);
 
 	if (!(status & (IMSTR_PF | IMSTR_TF)))
@@ -560,7 +563,7 @@ static irqreturn_t ipmmu_domain_irq(struct ipmmu_vmsa_domain *domain)
 		return IRQ_HANDLED;
 
 	dev_err_ratelimited(mmu->dev,
-			    "Unhandled fault: status 0x%08x iova 0x%08x\n",
+			    "Unhandled fault: status 0x%08x iova 0x%lx\n",
 			    status, iova);
 
 	return IRQ_HANDLED;
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
