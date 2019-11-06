Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17775C5DF61
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D468F2178F
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D468F2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 6233FE42;
	Wed,  6 Nov 2019 02:35:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 8D7EEE3B
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 02:35:54 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
	[210.160.252.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id CC2D98A9
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 02:35:53 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.68,272,1569250800"; d="scan'208";a="30937063"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2019 11:35:50 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id A80CD4181863;
	Wed,  6 Nov 2019 11:35:50 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org
Subject: [PATCH v3 5/6] iommu/ipmmu-vmsa: Add helper functions for "uTLB"
	registers
Date: Wed,  6 Nov 2019 11:35:49 +0900
Message-Id: <1573007750-16611-6-git-send-email-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
References: <1573007750-16611-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
This patch adds helper functions ipmmu_utlb_reg() and
ipmmu_imu{asid,ctr}_write() for "uTLB" registers. No behavior change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 8e2ca1c..82da486 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -230,6 +230,23 @@ static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
 	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
 }
 
+static u32 ipmmu_utlb_reg(struct ipmmu_vmsa_device *mmu, unsigned int reg)
+{
+	return reg;
+}
+
+static void ipmmu_imuasid_write(struct ipmmu_vmsa_device *mmu,
+				unsigned int utlb, u32 data)
+{
+	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUASID(utlb)), data);
+}
+
+static void ipmmu_imuctr_write(struct ipmmu_vmsa_device *mmu,
+			       unsigned int utlb, u32 data)
+{
+	ipmmu_write(mmu, ipmmu_utlb_reg(mmu, IMUCTR(utlb)), data);
+}
+
 /* -----------------------------------------------------------------------------
  * TLB and microTLB Management
  */
@@ -275,11 +292,10 @@ static void ipmmu_utlb_enable(struct ipmmu_vmsa_domain *domain,
 	 */
 
 	/* TODO: What should we set the ASID to ? */
-	ipmmu_write(mmu, IMUASID(utlb), 0);
+	ipmmu_imuasid_write(mmu, utlb, 0);
 	/* TODO: Do we need to flush the microTLB ? */
-	ipmmu_write(mmu, IMUCTR(utlb),
-		    IMUCTR_TTSEL_MMU(domain->context_id) | IMUCTR_FLUSH |
-		    IMUCTR_MMUEN);
+	ipmmu_imuctr_write(mmu, utlb, IMUCTR_TTSEL_MMU(domain->context_id) |
+				      IMUCTR_FLUSH | IMUCTR_MMUEN);
 	mmu->utlb_ctx[utlb] = domain->context_id;
 }
 
@@ -291,7 +307,7 @@ static void ipmmu_utlb_disable(struct ipmmu_vmsa_domain *domain,
 {
 	struct ipmmu_vmsa_device *mmu = domain->mmu;
 
-	ipmmu_write(mmu, IMUCTR(utlb), 0);
+	ipmmu_imuctr_write(mmu, utlb, 0);
 	mmu->utlb_ctx[utlb] = IPMMU_CTX_INVALID;
 }
 
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
