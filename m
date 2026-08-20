Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61AF3A4F23;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787253128; cv=none; b=r7q6s9FH+Y+fmfc5W0sk7Fuam9zWoe/+9IwcYxfSKwDJ1iMr+yFHgrV1x4IUcNd5pzcahITFchRaXOHp3sKJcLmMCHiRO7L9TjVBCzAYpKjRUz4PuL8OvvOdaj71vysE+AIulvd4z1sBmycgvWXE9EBdQs3a6QzG+yB5lP8L9wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787253128; c=relaxed/simple;
	bh=ksXb9ni7G9dqEx6LwsW4bBnhqCsne0tIy7naRonbgIY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CGQp0I+sezpn27DwQVE9DfeEHxWaa+eiDNcN40FUI+1T3J/fVji/KfZwawAd/mD9IqIIKymQTE/9rL8bC2Xe2e/n047ExgLwx8DH833we0XtxHSROo23Sw6aBa9NyQHAXzRwwy528fNSzfd4fQxE/ScZitYMMUahcC7A0/m1H90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwqXTZF3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwqXTZF3"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E8FDC2BCC7;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1787253128;
	bh=ksXb9ni7G9dqEx6LwsW4bBnhqCsne0tIy7naRonbgIY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jwqXTZF3KIEQx7y1BPdHwHBcL8P6vtg0jNNIRwLI78V6e6PlRCCWte/vIsoSQAywr
	 hhh9hzwPWcCmBQFAP4sjUF9ZtSQUuvbG/OQEc4fEFV3aRqmDt6nlDPugBshQw6saKf
	 MYf1ZXKGTHwDUR+qxV+WoKq7E8ixwzU5czvH2SoKyR461HqSl0Sa2J/BCQ9PlBSm9Y
	 0Uoc+46mH9SC82te0MM7ZyOVoBT7cOfvlNnF3IZo8QSFBNc+DPLo5A/3utjSR4iRUs
	 c9TcbL2qUBLHO8OGdrQfwKMDd1i4cuOTZPJ5DQAo21bA71tmQcHz9+KTfYlGVeSO6W
	 78LL86kt51O6A==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CAA6C5DF86;
	Thu, 20 Aug 2026 19:12:08 +0000 (UTC)
From: Markuss Broks via B4 Relay <devnull+markuss.broks.gmail.com@kernel.org>
Date: Thu, 20 Aug 2026 22:12:05 +0300
Subject: [PATCH 1/4] iommu/exynos: detect SysMMUs without BLOCK mode
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-exynos-iommu-fixes-v1-1-6bbcd673bb15@gmail.com>
References: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
In-Reply-To: <20260820-exynos-iommu-fixes-v1-0-6bbcd673bb15@gmail.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>, 
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
 Robin Murphy <robin.murphy@arm.com>, Krzysztof Kozlowski <krzk@kernel.org>, 
 Peter Griffin <peter.griffin@linaro.org>, 
 Alim Akhtar <alim.akhtar@samsung.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markuss Broks <markuss.broks@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787253126; l=1479;
 i=markuss.broks@gmail.com; s=20260803; h=from:subject:message-id;
 bh=mOr89jBc1c/3DemuQ56Wmn7lSeAvv7DoZx+sJdo6D2U=;
 b=6nEHQ0bpJYt2EXU7sB+pTrh8uM4qqZlYciy0rMZ3uIIw056/blzZCqnEYUw/BlDczramgZk8s
 D+ueRGcYxxyB9FQi32Q0zQlCTS+8SQDf1EHZSuOANkujC0hVsTMRojF
X-Developer-Key: i=markuss.broks@gmail.com; a=ed25519;
 pk=oKzGUTm30BCDqinRMpiHQqByOx1mp2mwmhg80Mv7Zg4=
X-Endpoint-Received: by B4 Relay for markuss.broks@gmail.com/20260803 with
 auth_id=911
X-Original-From: Markuss Broks <markuss.broks@gmail.com>
Reply-To: markuss.broks@gmail.com

From: Markuss Broks <markuss.broks@gmail.com>

Newer SysMMU instances may not implement BLOCK mode: writing CTRL_BLOCK
does not stop translation, and MMU_STATUS never reports a blocked
state.  The hardware advertises this in CAPA1 bit 15, which the vendor
driver reads as MMU_CAPA1_NO_BLOCK_MODE; the SysMMUs on Exynos8835
are such instances.

Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
---
 drivers/iommu/exynos-iommu.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 874d05f4b396..0319da9fd831 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -143,6 +143,7 @@ static u32 lv2ent_offset(sysmmu_iova_t iova)
 #define CTRL_VM_FAULT_MODE_STALL	BIT(3)
 #define CAPA0_CAPA1_EXIST		BIT(11)
 #define CAPA1_VCR_ENABLED		BIT(14)
+#define CAPA1_NO_BLOCK_MODE		BIT(15)
 
 /* common registers */
 #define REG_MMU_CTRL		0x000
@@ -306,6 +307,7 @@ struct sysmmu_drvdata {
 
 	/* v7 fields */
 	bool has_vcr;			/* virtual machine control register */
+	bool no_block;			/* BLOCK mode not implemented */
 };
 
 #define SYSMMU_REG(data, reg) ((data)->sfrbase + (data)->variant->reg)
@@ -511,6 +513,7 @@ static void __sysmmu_get_vcr(struct sysmmu_drvdata *data)
 	u32 capa1 = readl(data->sfrbase + REG_V7_CAPA1);
 
 	data->has_vcr = capa1 & CAPA1_VCR_ENABLED;
+	data->no_block = capa1 & CAPA1_NO_BLOCK_MODE;
 }
 
 static void __sysmmu_get_version(struct sysmmu_drvdata *data)

-- 
2.55.0


