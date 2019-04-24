Return-Path: <SRS0=cQN6=S2=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD02C282CE
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:31 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28151218FD
	for <iommu@archiver.kernel.org>; Wed, 24 Apr 2019 13:55:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28151218FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id C543711F5;
	Wed, 24 Apr 2019 13:55:29 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 1447111DD
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:26 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from michel.telenet-ops.be (michel.telenet-ops.be [195.130.137.88])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id 69AAE854
	for <iommu@lists.linux-foundation.org>;
	Wed, 24 Apr 2019 13:55:24 +0000 (UTC)
Received: from ramsan ([84.194.111.163]) by michel.telenet-ops.be with bizsmtp
	id 4DvM2000w3XaVaC06DvMJA; Wed, 24 Apr 2019 15:55:22 +0200
Received: from rox.of.borg ([192.168.97.57]) by ramsan with esmtp (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMr-00088A-P2; Wed, 24 Apr 2019 15:55:21 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
	(envelope-from <geert@linux-m68k.org>)
	id 1hJIMr-0006Yh-Nf; Wed, 24 Apr 2019 15:55:21 +0200
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Joerg Roedel <joro@8bytes.org>,
	Magnus Damm <damm+renesas@opensource.se>
Subject: [PATCH v3 5/6] iommu/ipmmu-vmsa: Extract hardware context
	initialization
Date: Wed, 24 Apr 2019 15:55:17 +0200
Message-Id: <20190424135518.25150-6-geert+renesas@glider.be>
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
Message-ID: <20190424135517.XqMMapicvJxu12uxEfvdGJ6MTvJTas8jHiRTbaz_YOE@z>

ipmmu_domain_init_context() takes care of (1) initializing the software
domain, and (2) initializing the hardware context for the domain.

Extract the code to initialize the hardware context into a new subroutine
ipmmu_domain_setup_context(), to prepare for later reuse.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
---
v3:
  - Add Reviewed-by,

v2:
  - s/ipmmu_context_init/ipmmu_domain_setup_context/.
---
 drivers/iommu/ipmmu-vmsa.c | 91 ++++++++++++++++++++------------------
 1 file changed, 48 insertions(+), 43 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 3fa57627b1e35562..56e84bcc9532e1ce 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -404,52 +404,10 @@ static void ipmmu_domain_free_context(struct ipmmu_vmsa_device *mmu,
 	spin_unlock_irqrestore(&mmu->lock, flags);
 }
 
-static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+static void ipmmu_domain_setup_context(struct ipmmu_vmsa_domain *domain)
 {
 	u64 ttbr;
 	u32 tmp;
-	int ret;
-
-	/*
-	 * Allocate the page table operations.
-	 *
-	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
-	 * access, Long-descriptor format" that the NStable bit being set in a
-	 * table descriptor will result in the NStable and NS bits of all child
-	 * entries being ignored and considered as being set. The IPMMU seems
-	 * not to comply with this, as it generates a secure access page fault
-	 * if any of the NStable and NS bits isn't set when running in
-	 * non-secure mode.
-	 */
-	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
-	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
-	domain->cfg.ias = 32;
-	domain->cfg.oas = 40;
-	domain->cfg.tlb = &ipmmu_gather_ops;
-	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
-	domain->io_domain.geometry.force_aperture = true;
-	/*
-	 * TODO: Add support for coherent walk through CCI with DVM and remove
-	 * cache handling. For now, delegate it to the io-pgtable code.
-	 */
-	domain->cfg.iommu_dev = domain->mmu->root->dev;
-
-	/*
-	 * Find an unused context.
-	 */
-	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
-	if (ret < 0)
-		return ret;
-
-	domain->context_id = ret;
-
-	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
-					   domain);
-	if (!domain->iop) {
-		ipmmu_domain_free_context(domain->mmu->root,
-					  domain->context_id);
-		return -EINVAL;
-	}
 
 	/* TTBR0 */
 	ttbr = domain->cfg.arm_lpae_s1_cfg.ttbr[0];
@@ -495,7 +453,54 @@ static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
 	 */
 	ipmmu_ctx_write_all(domain, IMCTR,
 			    IMCTR_INTEN | IMCTR_FLUSH | IMCTR_MMUEN);
+}
+
+static int ipmmu_domain_init_context(struct ipmmu_vmsa_domain *domain)
+{
+	int ret;
+
+	/*
+	 * Allocate the page table operations.
+	 *
+	 * VMSA states in section B3.6.3 "Control of Secure or Non-secure memory
+	 * access, Long-descriptor format" that the NStable bit being set in a
+	 * table descriptor will result in the NStable and NS bits of all child
+	 * entries being ignored and considered as being set. The IPMMU seems
+	 * not to comply with this, as it generates a secure access page fault
+	 * if any of the NStable and NS bits isn't set when running in
+	 * non-secure mode.
+	 */
+	domain->cfg.quirks = IO_PGTABLE_QUIRK_ARM_NS;
+	domain->cfg.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K;
+	domain->cfg.ias = 32;
+	domain->cfg.oas = 40;
+	domain->cfg.tlb = &ipmmu_gather_ops;
+	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
+	domain->io_domain.geometry.force_aperture = true;
+	/*
+	 * TODO: Add support for coherent walk through CCI with DVM and remove
+	 * cache handling. For now, delegate it to the io-pgtable code.
+	 */
+	domain->cfg.iommu_dev = domain->mmu->root->dev;
+
+	/*
+	 * Find an unused context.
+	 */
+	ret = ipmmu_domain_allocate_context(domain->mmu->root, domain);
+	if (ret < 0)
+		return ret;
+
+	domain->context_id = ret;
+
+	domain->iop = alloc_io_pgtable_ops(ARM_32_LPAE_S1, &domain->cfg,
+					   domain);
+	if (!domain->iop) {
+		ipmmu_domain_free_context(domain->mmu->root,
+					  domain->context_id);
+		return -EINVAL;
+	}
 
+	ipmmu_domain_setup_context(domain);
 	return 0;
 }
 
-- 
2.17.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
