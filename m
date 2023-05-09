Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D3A19921
	for <iommu@lists.linux.dev>; Tue,  9 May 2023 21:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D65DCC4339B;
	Tue,  9 May 2023 21:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1683667188;
	bh=+vRrwIe1+/o1cUB17pTvCBZYLyydI8RuSE2s+ReV9AA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UN/t1eNlOVAMDfOpZz2i1p2ZytbUSdnYjy96S3tnv+wYWTJL6dNLffZiLTFTHYaMM
	 3tjbZB/vLXd+AGISuCc97+FaGMzAyzNCRXf79KGuMuqGtXMDjI3yy835EwxEIrRYEC
	 W2vqPS/lpPJrxix4qPy5dGCojXYj2/0uH3CP8NqxTukgeohTV4OtZ2tc18d/ASCUxC
	 N8di2Auo1alDnKCCBgrTGWSsllnPfZKZ2lZJAq6FaqQB8pbWHpjI4oMriFuWBMuoFk
	 FpgdAFxMPXaictDywjzA0wUlWOCX4gT1WlaMUjhdjmUO3GPNh3Au7quYCM7cAJxbHJ
	 CDJSglWBXmFNg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <jroedel@suse.de>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	joro@8bytes.org,
	baolu.lu@linux.intel.com,
	jgg@ziepe.ca,
	robh@kernel.org,
	jon@solid-run.com,
	vladimir.oltean@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev
Subject: [PATCH AUTOSEL 6.3 12/18] iommu/arm-smmu: Drop if with an always false condition
Date: Tue,  9 May 2023 17:19:20 -0400
Message-Id: <20230509211928.21010-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230509211928.21010-1-sashal@kernel.org>
References: <20230509211928.21010-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit a2972cb89935160bfe515b15d28a77694723ac06 ]

The remove and shutdown callback are only called after probe completed
successfully. In this case platform_set_drvdata() was called with a
non-NULL argument and so smmu is never NULL. Other functions in this
driver also don't check for smmu being non-NULL before using it.

Also note that returning an error code from a remove callback doesn't
result in the device staying bound. It's still removed and devm allocated
resources are freed (among others *smmu and the register mapping). So
after an early exit to iommu device stayed around and using it probably
oopses.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
Link: https://lore.kernel.org/r/20230321084125.337021-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iommu/arm/arm-smmu/arm-smmu.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index 2ff7a72cf3772..f4a36533ae478 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -2195,9 +2195,6 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return;
-
 	if (!bitmap_empty(smmu->context_map, ARM_SMMU_MAX_CBS))
 		dev_notice(&pdev->dev, "disabling translation\n");
 
@@ -2218,9 +2215,6 @@ static int arm_smmu_device_remove(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
-	if (!smmu)
-		return -ENODEV;
-
 	iommu_device_unregister(&smmu->iommu);
 	iommu_device_sysfs_remove(&smmu->iommu);
 
-- 
2.39.2

