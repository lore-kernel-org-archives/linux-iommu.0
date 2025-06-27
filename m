Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA54D2E8DE5
	for <iommu@lists.linux.dev>; Fri, 27 Jun 2025 15:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036844; cv=none; b=cF9tjYWeHSdoBbecSQJzuH3hI8bl90tTR6rh0dwsEmt/ny+Z3nRe6gmpwH4VC+XnNBiU45JhaenKriDTlEG/KBFspkwd4anGsEfi64zxr3W3pLuBwzteV5d7Jrgl/ZyPtfQ0sJcI69/MfPkZ30z3ycwCquBNYo7mvhNyBajVwf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036844; c=relaxed/simple;
	bh=YBLiQwD2JcIulowafWOsVO78jCU0GAnY0Q+qLWPz6KI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VfgUeNiRXDOGOI4NINY78gpkTljvK/W53+KbNcUqD34ATrDQib4DBccQvhakFA09n3H3xXrFEU8/9pWIsjz1R23RLIxadaJn089ygPPBRE/+bN+kZWaOXilCjPNtPHKfQE9QpYmRLbC+D2R4BW+b/l/SxvAEYtETNuWxb36amAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C92EF1A00;
	Fri, 27 Jun 2025 08:07:04 -0700 (PDT)
Received: from e121345-lin.cambridge.arm.com (e121345-lin.cambridge.arm.com [10.1.196.50])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id B9E403F66E;
	Fri, 27 Jun 2025 08:07:20 -0700 (PDT)
From: Robin Murphy <robin.murphy@arm.com>
To: joro@8bytes.org,
	will@kernel.org
Cc: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	yong.wu@mediatek.com,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] iommu/mediatek-v1: Tidy up probe_finalize
Date: Fri, 27 Jun 2025 16:07:10 +0100
Message-Id: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.39.2.101.g768bb238c484.dirty
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Krzysztof points out that although the driver now supports COMPILE_TEST
for other architectures, it does not build cleanly with W=1 where the
stubbed-out ARM API can lead to an unused variable warning.

Since this is effectively the correct intent of the code in such cases,
mark it as __maybe_unused, tidying up some cruft in the process.

Reported-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Since I'd already got as far as thinking this through, I figure I may
as well save Krzysztof the trouble of rewriting it :)
 
 drivers/iommu/mtk_iommu_v1.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
index 66824982e05f..2fc18e194e19 100644
--- a/drivers/iommu/mtk_iommu_v1.c
+++ b/drivers/iommu/mtk_iommu_v1.c
@@ -509,14 +509,10 @@ static struct iommu_device *mtk_iommu_v1_probe_device(struct device *dev)
 
 static void mtk_iommu_v1_probe_finalize(struct device *dev)
 {
-	struct dma_iommu_mapping *mtk_mapping;
-	struct mtk_iommu_v1_data *data;
+	__maybe_unused struct mtk_iommu_v1_data *data = dev_iommu_priv_get(dev);
 	int err;
 
-	data        = dev_iommu_priv_get(dev);
-	mtk_mapping = data->mapping;
-
-	err = arm_iommu_attach_device(dev, mtk_mapping);
+	err = arm_iommu_attach_device(dev, data->mapping);
 	if (err)
 		dev_err(dev, "Can't create IOMMU mapping - DMA-OPS will not work\n");
 }
-- 
2.39.2.101.g768bb238c484.dirty

