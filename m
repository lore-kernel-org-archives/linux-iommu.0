Return-Path: <SRS0=Q5U9=VI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5A52C742A1
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:07 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91C5B20863
	for <iommu@archiver.kernel.org>; Thu, 11 Jul 2019 19:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91C5B20863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 76A7753D6;
	Thu, 11 Jul 2019 19:47:54 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id D69084F47
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:02:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mslow2.mail.gandi.net (mslow2.mail.gandi.net [217.70.178.242])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id DE879893
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 17:02:38 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (unknown [217.70.183.197])
	by mslow2.mail.gandi.net (Postfix) with ESMTP id 1F02A3A5C8F
	for <iommu@lists.linux-foundation.org>;
	Thu, 11 Jul 2019 15:03:16 +0000 (UTC)
X-Originating-IP: 92.137.69.152
Received: from localhost (alyon-656-1-672-152.w92-137.abo.wanadoo.fr
	[92.137.69.152]) (Authenticated sender: gregory.clement@bootlin.com)
	by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 22DB71C0017;
	Thu, 11 Jul 2019 15:03:10 +0000 (UTC)
From: Gregory CLEMENT <gregory.clement@bootlin.com>
To: Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH v2 1/4] iommu/arm-smmu: Introduce wrapper for writeq/readq
Date: Thu, 11 Jul 2019 17:02:39 +0200
Message-Id: <20190711150242.25290-2-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190711150242.25290-1-gregory.clement@bootlin.com>
References: <20190711150242.25290-1-gregory.clement@bootlin.com>
MIME-Version: 1.0
X-Mailman-Approved-At: Thu, 11 Jul 2019 19:37:36 +0000
Cc: devicetree@vger.kernel.org, Jason Cooper <jason@lakedaemon.net>,
	Andrew Lunn <andrew@lunn.ch>, Antoine Tenart <antoine.tenart@bootlin.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Gregory CLEMENT <gregory.clement@bootlin.com>,
	Will Deacon <will.deacon@arm.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Nadav Haklai <nadavh@marvell.com>, Rob Herring <robh+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
	Hanna Hawa <hannah@marvell.com>, linux-arm-kernel@lists.infradead.org,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

From: Hanna Hawa <hannah@marvell.com>

This patch introduces the smmu_writeq_relaxed/smmu_readq_relaxed
helpers, as preparation to add specific Marvell work-around for
accessing 64 bits width registers of ARM SMMU.

Signed-off-by: Hanna Hawa <hannah@marvell.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/iommu/arm-smmu.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/arm-smmu.c b/drivers/iommu/arm-smmu.c
index 045d93884164..ac0784b5b675 100644
--- a/drivers/iommu/arm-smmu.c
+++ b/drivers/iommu/arm-smmu.c
@@ -91,9 +91,11 @@
  * therefore this actually makes more sense than it might first appear.
  */
 #ifdef CONFIG_64BIT
-#define smmu_write_atomic_lq		writeq_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					smmu_writeq_relaxed(smmu, val, reg)
 #else
-#define smmu_write_atomic_lq		writel_relaxed
+#define smmu_write_atomic_lq(smmu, val, reg)	\
+					writel_relaxed(val, reg)
 #endif
 
 /* Translation context bank */
@@ -295,6 +297,19 @@ static struct arm_smmu_domain *to_smmu_domain(struct iommu_domain *dom)
 	return container_of(dom, struct arm_smmu_domain, domain);
 }
 
+static inline void smmu_writeq_relaxed(struct arm_smmu_device *smmu,
+				       u64 val,
+				       void __iomem *addr)
+{
+	writeq_relaxed(val, addr);
+}
+
+static inline u64 smmu_readq_relaxed(struct arm_smmu_device *smmu,
+				     void __iomem *addr)
+{
+	return readq_relaxed(addr);
+}
+
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
 	int i = 0;
@@ -495,6 +510,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 					  size_t granule, bool leaf, void *cookie)
 {
 	struct arm_smmu_domain *smmu_domain = cookie;
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
 	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
 	bool stage1 = cfg->cbar != CBAR_TYPE_S2_TRANS;
 	void __iomem *reg = ARM_SMMU_CB(smmu_domain->smmu, cfg->cbndx);
@@ -516,7 +532,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			iova >>= 12;
 			iova |= (u64)cfg->asid << 48;
 			do {
-				writeq_relaxed(iova, reg);
+				smmu_writeq_relaxed(smmu, iova, reg);
 				iova += granule >> 12;
 			} while (size -= granule);
 		}
@@ -525,7 +541,7 @@ static void arm_smmu_tlb_inv_range_nosync(unsigned long iova, size_t size,
 			      ARM_SMMU_CB_S2_TLBIIPAS2;
 		iova >>= 12;
 		do {
-			smmu_write_atomic_lq(iova, reg);
+			smmu_write_atomic_lq(smmu, iova, reg);
 			iova += granule >> 12;
 		} while (size -= granule);
 	}
@@ -584,7 +600,7 @@ static irqreturn_t arm_smmu_context_fault(int irq, void *dev)
 		return IRQ_NONE;
 
 	fsynr = readl_relaxed(cb_base + ARM_SMMU_CB_FSYNR0);
-	iova = readq_relaxed(cb_base + ARM_SMMU_CB_FAR);
+	iova = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_FAR);
 
 	dev_err_ratelimited(smmu->dev,
 	"Unhandled context fault: fsr=0x%x, iova=0x%08lx, fsynr=0x%x, cb=%d\n",
@@ -734,9 +750,11 @@ static void arm_smmu_write_context_bank(struct arm_smmu_device *smmu, int idx)
 		writel_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
 		writel_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
 	} else {
-		writeq_relaxed(cb->ttbr[0], cb_base + ARM_SMMU_CB_TTBR0);
+		smmu_writeq_relaxed(smmu, cb->ttbr[0],
+				    cb_base + ARM_SMMU_CB_TTBR0);
 		if (stage1)
-			writeq_relaxed(cb->ttbr[1], cb_base + ARM_SMMU_CB_TTBR1);
+			smmu_writeq_relaxed(smmu, cb->ttbr[1],
+					    cb_base + ARM_SMMU_CB_TTBR1);
 	}
 
 	/* MAIRs (stage-1 only) */
@@ -1367,7 +1385,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 	/* ATS1 registers can only be written atomically */
 	va = iova & ~0xfffUL;
 	if (smmu->version == ARM_SMMU_V2)
-		smmu_write_atomic_lq(va, cb_base + ARM_SMMU_CB_ATS1PR);
+		smmu_write_atomic_lq(smmu, va, cb_base + ARM_SMMU_CB_ATS1PR);
 	else /* Register is only 32-bit in v1 */
 		writel_relaxed(va, cb_base + ARM_SMMU_CB_ATS1PR);
 
@@ -1380,7 +1398,7 @@ static phys_addr_t arm_smmu_iova_to_phys_hard(struct iommu_domain *domain,
 		return ops->iova_to_phys(ops, iova);
 	}
 
-	phys = readq_relaxed(cb_base + ARM_SMMU_CB_PAR);
+	phys = smmu_readq_relaxed(smmu, cb_base + ARM_SMMU_CB_PAR);
 	spin_unlock_irqrestore(&smmu_domain->cb_lock, flags);
 	if (phys & CB_PAR_F) {
 		dev_err(dev, "translation fault!\n");
-- 
2.20.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
