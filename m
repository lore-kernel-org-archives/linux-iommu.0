Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06EFC433EF
	for <iommu@archiver.kernel.org>; Thu, 10 Feb 2022 12:29:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7379340606;
	Thu, 10 Feb 2022 12:29:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jLX1S9bP4w1e; Thu, 10 Feb 2022 12:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 143564055F;
	Thu, 10 Feb 2022 12:29:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDBE7C0011;
	Thu, 10 Feb 2022 12:29:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ED404C000B
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 12:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CDF6F4090C
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 12:29:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LgoSNP-dPdBK for <iommu@lists.linux-foundation.org>;
 Thu, 10 Feb 2022 12:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp4.osuosl.org (Postfix) with ESMTP id B9925408CF
 for <iommu@lists.linux-foundation.org>; Thu, 10 Feb 2022 12:29:10 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DBE11113E;
 Thu, 10 Feb 2022 04:29:09 -0800 (PST)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com
 [10.1.196.40])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2229C3F73B;
 Thu, 10 Feb 2022 04:29:09 -0800 (PST)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Subject: [PATCH] iommu: Remove trivial ops->capable implementations
Date: Thu, 10 Feb 2022 12:29:05 +0000
Message-Id: <8413578c6f8a7cf75530b00cba8f10f5b88f8517.1644495614.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.28.0.dirty
MIME-Version: 1.0
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

Implementing ops->capable to always return false is pointless since it's
the default behaviour anyway. Clean up the unnecessary implementations.

Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Spinning this out of my bus ops stuff (currently 30 patches and
counting...) since it would be better off alongside Baolu's cleanup
series to avoid conflicts, and I want to depend on those patches for
dev_iommu_ops() anyway.

 drivers/iommu/msm_iommu.c  | 6 ------
 drivers/iommu/tegra-gart.c | 6 ------
 drivers/iommu/tegra-smmu.c | 6 ------
 3 files changed, 18 deletions(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 06bde6b66732..22061ddbd5df 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -558,11 +558,6 @@ static phys_addr_t msm_iommu_iova_to_phys(struct iommu_domain *domain,
 	return ret;
 }
 
-static bool msm_iommu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static void print_ctx_regs(void __iomem *base, int ctx)
 {
 	unsigned int fsr = GET_FSR(base, ctx);
@@ -672,7 +667,6 @@ irqreturn_t msm_iommu_fault_handler(int irq, void *dev_id)
 }
 
 static struct iommu_ops msm_iommu_ops = {
-	.capable = msm_iommu_capable,
 	.domain_alloc = msm_iommu_domain_alloc,
 	.domain_free = msm_iommu_domain_free,
 	.attach_dev = msm_iommu_attach_dev,
diff --git a/drivers/iommu/tegra-gart.c b/drivers/iommu/tegra-gart.c
index 6a358f92c7e5..bbd287d19324 100644
--- a/drivers/iommu/tegra-gart.c
+++ b/drivers/iommu/tegra-gart.c
@@ -238,11 +238,6 @@ static phys_addr_t gart_iommu_iova_to_phys(struct iommu_domain *domain,
 	return pte & GART_PAGE_MASK;
 }
 
-static bool gart_iommu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static struct iommu_device *gart_iommu_probe_device(struct device *dev)
 {
 	if (!dev_iommu_fwspec_get(dev))
@@ -276,7 +271,6 @@ static void gart_iommu_sync(struct iommu_domain *domain,
 }
 
 static const struct iommu_ops gart_iommu_ops = {
-	.capable	= gart_iommu_capable,
 	.domain_alloc	= gart_iommu_domain_alloc,
 	.domain_free	= gart_iommu_domain_free,
 	.attach_dev	= gart_iommu_attach_dev,
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index e900e3c46903..43df44f918a1 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -272,11 +272,6 @@ static void tegra_smmu_free_asid(struct tegra_smmu *smmu, unsigned int id)
 	clear_bit(id, smmu->asids);
 }
 
-static bool tegra_smmu_capable(enum iommu_cap cap)
-{
-	return false;
-}
-
 static struct iommu_domain *tegra_smmu_domain_alloc(unsigned type)
 {
 	struct tegra_smmu_as *as;
@@ -967,7 +962,6 @@ static int tegra_smmu_of_xlate(struct device *dev,
 }
 
 static const struct iommu_ops tegra_smmu_ops = {
-	.capable = tegra_smmu_capable,
 	.domain_alloc = tegra_smmu_domain_alloc,
 	.domain_free = tegra_smmu_domain_free,
 	.attach_dev = tegra_smmu_attach_dev,
-- 
2.28.0.dirty

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
