Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89317431E69;
	Wed,  1 Jul 2026 22:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944657; cv=none; b=Yzpw0PHOAPnkJ7hcp4WFkardJYqvQLJhLOdrI6gL2mdHzaCaWN4w2f6smvxWMfvgaLhRZFnIICCzCCXnoAp9AwdxclltkfyUPXh1AxPn1Mu82rKleYZgMGSIbj0DRzlJD8vVecwFY06TbfUTePBg5usf2VtXt/n++LsUoO5SIyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944657; c=relaxed/simple;
	bh=MMmb7cQ4l3D7S8pV55IdpLdS4n2+QvNWTz+MTNasu/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kjuOb2lvUK7ZwjABVhp+dFGIke8jkX9uxBsINcOufc9iCfrTKuFwPI284SW6ET7o5E0RTqJWPOqS9f2cM3/bDONLoSMyxq/W3gqZkagJ8bxoBeezcbQqdW+SX36AKqtpT3NP4rhiZCGGcvTjMu3ZHKFcZe05rccMPQPAo0x0pBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WPeoOOQR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WPeoOOQR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 467561F000E9;
	Wed,  1 Jul 2026 22:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782944656;
	bh=2ILB0Bz8lqylo3zNtQHZjdtTG+G4R3NByr8o+uAceO0=;
	h=From:To:Cc:Subject:Date;
	b=WPeoOOQRHxMHhJRuXAb+cjZNbCZqk57LxfZotrhnabuvehXg17X1PjKpWTDhioDyH
	 VBY5XWldBxnYczW8hvarxy+bsYLZAFkk30xKrMwv/9bFwrnA4SYQtNnX0vTSTRzMx0
	 QNGJkgMBHmx2zkzsHSLpjW91cPVzEUb+j4U75zT2vCX90YAT8S2RBUQs+f1s8b2MlC
	 pU8zVmvLfTSOYclbGnO8BgPKLzgT1n8M4U8JuNiWvt+cta8tmzHAg1z1h6UE8g6JRB
	 wQuo354dZ7VzW2SM6tSaKnrwMH4f9qKhlCWhwlpySz9Wja7tQCLKZT5oR7DTVupqLq
	 GSVVepBW+FhKg==
From: Vladimir Zapolskiy <vz@kernel.org>
To: Rob Clark <robin.clark@oss.qualcomm.com>,
	Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sricharan Ramabadhran <quic_srichara@quicinc.com>,
	iommu@lists.linux.dev,
	linux-arm-msm@vger.kernel.org
Subject: [PATCH] iommu/msm: Return -ENOMEM on memory allocation failure in probe
Date: Thu,  2 Jul 2026 01:24:11 +0300
Message-ID: <20260701222411.138514-1-vz@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If dynamic memory allocation in driver's probe function execution fails,
it should be reported to the driver's framework with -ENOMEM error code.

Fixes: 109bd48ea2e1 ("iommu/msm: Add DT adaptation")
Signed-off-by: Vladimir Zapolskiy <vz@kernel.org>
---
 drivers/iommu/msm_iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 0ad5ff431d5b..708baeb29c03 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -720,7 +720,7 @@ static int msm_iommu_probe(struct platform_device *pdev)
 
 	iommu = devm_kzalloc(&pdev->dev, sizeof(*iommu), GFP_KERNEL);
 	if (!iommu)
-		return -ENODEV;
+		return -ENOMEM;
 
 	iommu->dev = &pdev->dev;
 	INIT_LIST_HEAD(&iommu->ctx_list);
-- 
2.51.0

