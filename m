Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8208C433EF
	for <iommu@archiver.kernel.org>; Tue, 10 May 2022 15:44:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4DD5D60F38;
	Tue, 10 May 2022 15:44:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QAosNX_Ahuw8; Tue, 10 May 2022 15:44:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3503960AE2;
	Tue, 10 May 2022 15:44:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 07112C0039;
	Tue, 10 May 2022 15:44:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6313BC002D
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 15:44:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4FFB0400DB
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 15:44:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=kernel.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FVWEValLsW_s for <iommu@lists.linux-foundation.org>;
 Tue, 10 May 2022 15:44:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 456F640022
 for <iommu@lists.linux-foundation.org>; Tue, 10 May 2022 15:44:39 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 5C964B81DFA;
 Tue, 10 May 2022 15:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D421BC385C9;
 Tue, 10 May 2022 15:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652197475;
 bh=EdXBI+t7Z+CJBmYfgvbfu0giiu3XH2CkqB+Azf5RDVQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=FhgVLwiWX3Zw+Cz/naVTbyrGDbD9nH7rBAEtt+UDu7w1JJ0kP+wDsXLIN7zVDOcEQ
 fZFJlsskN7pAxtRBHqfhjPQQRzNyzx2DZmy0ErHbvBUOLsyg6TPbl3m/di2EV5SMUR
 7429xNfoY6vd+OnSIkWJ+ULDCOYSOnj5xg+HQque5eDiTWLFWhDFkbuhlBCnPgDOao
 atBN6B+4nBxq9or5BJlbqCm5nWiP2lUyeYb37PwHWAg/3oOpdYy2zEjIw0vriIqOhN
 YDKNr/rlJ9kxY4+82LdfxwXpRIr+EX6CLXxqqnE1bnck4ZugpqRw4/W0ZxwSTiHOFC
 2B+WDMFB1vpdg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/19] iommu: arm-smmu: disable large page
 mappings for Nvidia arm-smmu
Date: Tue, 10 May 2022 11:44:13 -0400
Message-Id: <20220510154429.153677-3-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220510154429.153677-1-sashal@kernel.org>
References: <20220510154429.153677-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Cc: Sasha Levin <sashal@kernel.org>, Will Deacon <will@kernel.org>,
 Ashish Mhetre <amhetre@nvidia.com>, iommu@lists.linux-foundation.org,
 Pritesh Raithatha <praithatha@nvidia.com>, thierry.reding@gmail.com,
 linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 linux-arm-kernel@lists.infradead.org
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

From: Ashish Mhetre <amhetre@nvidia.com>

[ Upstream commit 4a25f2ea0e030b2fc852c4059a50181bfc5b2f57 ]

Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
entries to not be invalidated correctly. The problem is that the walk
cache index generated for IOVA is not same across translation and
invalidation requests. This is leading to page faults when PMD entry is
released during unmap and populated with new PTE table during subsequent
map request. Disabling large page mappings avoids the release of PMD
entry and avoid translations seeing stale PMD entry in walk cache.
Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
Tegra234 devices. This is recommended fix from Tegra hardware design
team.

Acked-by: Robin Murphy <robin.murphy@arm.com>
Reviewed-by: Krishna Reddy <vdumpa@nvidia.com>
Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
Link: https://lore.kernel.org/r/20220421081504.24678-1-amhetre@nvidia.com
Signed-off-by: Will Deacon <will@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 30 ++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
index 01e9b50b10a1..87bf522b9d2e 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
@@ -258,6 +258,34 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
 			dev_name(dev), err);
 }
 
+static int nvidia_smmu_init_context(struct arm_smmu_domain *smmu_domain,
+				    struct io_pgtable_cfg *pgtbl_cfg,
+				    struct device *dev)
+{
+	struct arm_smmu_device *smmu = smmu_domain->smmu;
+	const struct device_node *np = smmu->dev->of_node;
+
+	/*
+	 * Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
+	 * entries to not be invalidated correctly. The problem is that the walk
+	 * cache index generated for IOVA is not same across translation and
+	 * invalidation requests. This is leading to page faults when PMD entry
+	 * is released during unmap and populated with new PTE table during
+	 * subsequent map request. Disabling large page mappings avoids the
+	 * release of PMD entry and avoid translations seeing stale PMD entry in
+	 * walk cache.
+	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
+	 * Tegra234.
+	 */
+	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
+	    of_device_is_compatible(np, "nvidia,tegra194-smmu")) {
+		smmu->pgsize_bitmap = PAGE_SIZE;
+		pgtbl_cfg->pgsize_bitmap = smmu->pgsize_bitmap;
+	}
+
+	return 0;
+}
+
 static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.read_reg = nvidia_smmu_read_reg,
 	.write_reg = nvidia_smmu_write_reg,
@@ -268,10 +296,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
 	.global_fault = nvidia_smmu_global_fault,
 	.context_fault = nvidia_smmu_context_fault,
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.init_context = nvidia_smmu_init_context,
 };
 
 static const struct arm_smmu_impl nvidia_smmu_single_impl = {
 	.probe_finalize = nvidia_smmu_probe_finalize,
+	.init_context = nvidia_smmu_init_context,
 };
 
 struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
-- 
2.35.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
