Return-Path: <SRS0=/wjm=Y6=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB5C5DF60
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:19 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00D4C2178F
	for <iommu@archiver.kernel.org>; Wed,  6 Nov 2019 02:36:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D4C2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id D1303E55;
	Wed,  6 Nov 2019 02:35:56 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 3F1C0E38
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 02:35:55 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com
	[210.160.252.171])
	by smtp1.linuxfoundation.org (Postfix) with ESMTP id 62F4E8A8
	for <iommu@lists.linux-foundation.org>;
	Wed,  6 Nov 2019 02:35:53 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.68,272,1569250800"; d="scan'208";a="30937060"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
	by relmlie5.idc.renesas.com with ESMTP; 06 Nov 2019 11:35:50 +0900
Received: from localhost.localdomain (unknown [10.166.17.210])
	by relmlir6.idc.renesas.com (Postfix) with ESMTP id 8FDFD418186A;
	Wed,  6 Nov 2019 11:35:50 +0900 (JST)
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: joro@8bytes.org
Subject: [PATCH v3 3/6] iommu/ipmmu-vmsa: Add helper functions for MMU
	"context" registers
Date: Wed,  6 Nov 2019 11:35:47 +0900
Message-Id: <1573007750-16611-4-git-send-email-yoshihiro.shimoda.uh@renesas.com>
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
This patch adds helper functions ipmmu_ctx_{reg,read,write}()
for MMU "context" registers. No behavior change.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/iommu/ipmmu-vmsa.c | 32 +++++++++++++++++++++++---------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index 79975e1..c4fcfda 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -190,29 +190,43 @@ static void ipmmu_write(struct ipmmu_vmsa_device *mmu, unsigned int offset,
 	iowrite32(data, mmu->base + offset);
 }
 
+static unsigned int ipmmu_ctx_reg(struct ipmmu_vmsa_device *mmu,
+				  unsigned int context_id, unsigned int reg)
+{
+	return context_id * IM_CTX_SIZE + reg;
+}
+
+static u32 ipmmu_ctx_read(struct ipmmu_vmsa_device *mmu,
+			  unsigned int context_id, unsigned int reg)
+{
+	return ipmmu_read(mmu, ipmmu_ctx_reg(mmu, context_id, reg));
+}
+
+static void ipmmu_ctx_write(struct ipmmu_vmsa_device *mmu,
+			    unsigned int context_id, unsigned int reg, u32 data)
+{
+	ipmmu_write(mmu, ipmmu_ctx_reg(mmu, context_id, reg), data);
+}
+
 static u32 ipmmu_ctx_read_root(struct ipmmu_vmsa_domain *domain,
 			       unsigned int reg)
 {
-	return ipmmu_read(domain->mmu->root,
-			  domain->context_id * IM_CTX_SIZE + reg);
+	return ipmmu_ctx_read(domain->mmu->root, domain->context_id, reg);
 }
 
 static void ipmmu_ctx_write_root(struct ipmmu_vmsa_domain *domain,
 				 unsigned int reg, u32 data)
 {
-	ipmmu_write(domain->mmu->root,
-		    domain->context_id * IM_CTX_SIZE + reg, data);
+	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
 }
 
 static void ipmmu_ctx_write_all(struct ipmmu_vmsa_domain *domain,
 				unsigned int reg, u32 data)
 {
 	if (domain->mmu != domain->mmu->root)
-		ipmmu_write(domain->mmu,
-			    domain->context_id * IM_CTX_SIZE + reg, data);
+		ipmmu_ctx_write(domain->mmu, domain->context_id, reg, data);
 
-	ipmmu_write(domain->mmu->root,
-		    domain->context_id * IM_CTX_SIZE + reg, data);
+	ipmmu_ctx_write(domain->mmu->root, domain->context_id, reg, data);
 }
 
 /* -----------------------------------------------------------------------------
@@ -913,7 +927,7 @@ static void ipmmu_device_reset(struct ipmmu_vmsa_device *mmu)
 
 	/* Disable all contexts. */
 	for (i = 0; i < mmu->num_ctx; ++i)
-		ipmmu_write(mmu, i * IM_CTX_SIZE + IMCTR, 0);
+		ipmmu_ctx_write(mmu, i, IMCTR, 0);
 }
 
 static const struct ipmmu_features ipmmu_features_default = {
-- 
2.7.4

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
