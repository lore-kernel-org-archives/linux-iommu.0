Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF541494AB
	for <iommu@lists.linux.dev>; Wed,  4 Sep 2024 08:02:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725436970; cv=none; b=QtvX+I3k5J7clXQezGjHyL6GJ4MMd+KB1NxIDpH8lbUh18YTgP0o/mYWAe8M0xciowi3HdSSWgi9PXbdVdgb/J77uGeikADTpLsYWVSGDCD0t+DimznG3a4aTLp74hH8GWGdZMqJBQhHJ4tv08pjcaY79PXnwUmIg9uFXjqAs3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725436970; c=relaxed/simple;
	bh=dDcdKq7ppSYN4Yv4rxqWl4NK1gtCIBnTvMkiH0xJG6A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EXrHKYSAQDyzRenSOirHFgN3mA1WQXLRWkLMBKaRgP6M+3ad92EY6eN49I+dPMihT8NT8NOmiOgCeUIhc2st0qGVLg+KKFeAdiCEe1IMJScyMTExGEEC8xKvJU9gxW5sabr4Q2U6hQ2kGzyjJzdjifrxL4tj/0OESuWd7d270Go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gzaZ3XFI; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gzaZ3XFI"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-42c7b5b2d01so42833045e9.3
        for <iommu@lists.linux.dev>; Wed, 04 Sep 2024 01:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725436967; x=1726041767; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dbsiPwHzdU7yQfw0bVfDw6SqwSWkWnRdJycvBly0WUw=;
        b=gzaZ3XFIHT+pCVNycohhg032ivyoJFJax4nmhTgnQZyiTsjU/RfCCBTVP+nkMgKwRU
         hBdq5873bV0jYeDRBrWPdb7Tq6LegvACbBxB7opdkXpcqoah/ajl1ycIO5wuTr00BnWc
         DqLdcqLKgKLcBo2vnWl+7+xC7Ru1oRzqDfnYzj3ISZMsyRw0xXM/p7n6ZNjTni/dKTRD
         0ph69924VonytAwKxQtsFTuBdFFLaRBh0A0B+hcexwbZcrMISCpu6AOd/zGay0KPoZ/C
         2Tr7gTQD5BQIy+V2v9VZwapLAYVTfcMcvLgbJJPz7T7P7SzYwMlRbaG7HNwk7crtX7s8
         bpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725436967; x=1726041767;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dbsiPwHzdU7yQfw0bVfDw6SqwSWkWnRdJycvBly0WUw=;
        b=O9DOn8vHif//0Nwyph20ttRj5zxxrGGx7QxcuSEBLhH+mByHc8fDdQy6/H6MOLhPGc
         hvOli1dQsSUGBFQbba/uFasutnZotTPRooCxoIMjsRPbxrDcYfLw4ZwuMcexOnwRopt6
         QSs3SZrdKz6g5C8M8/RpS+jnKKEoWlzLQsY4/QuIliuPZctTc6kQVHE+q10c/0zQsZ6B
         It39NdWlH/jSil2s1CVhu4lS3dUUyKRZTADwWWPFDikR0o1slhPX/FVpMIxOeRlYKhom
         YqXQrigoVO0ogXvgg3R7YMhqcTc1gjvuBml5K9LmO/RGVg2/NloNB2knLsGnt1nQ4Voh
         QitA==
X-Forwarded-Encrypted: i=1; AJvYcCWGZD/VQ5o7kysYei9RAKPJMToly6wHC7cEQGW400a6NFYZjae0lv19OSvJIBFw/XaVUTV46A==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy0/3pIdJLp8wf804F9JOX4sgylvTULjW6FWzmPAaWn6VEjSaTS
	aVeyXK/jZT4EAQ0CLDO9TiogKXZT5h+1GsCmmgOOGDYBR+G8g1KcxCBF0a+87HQ=
X-Google-Smtp-Source: AGHT+IGyDGx5cm2clgCM+58D1DQI6ScWGOORu/UwO/wHkk24NWcrYuEi0RVx30LWqkM6S3wJfZbhMA==
X-Received: by 2002:a05:600c:4512:b0:426:5e8e:aa48 with SMTP id 5b1f17b1804b1-42bb01c1ff9mr187146885e9.22.1725436967102;
        Wed, 04 Sep 2024 01:02:47 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-374b9859486sm12993928f8f.111.2024.09.04.01.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 01:02:46 -0700 (PDT)
Date: Wed, 4 Sep 2024 11:02:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Nate Watterson <nwatterson@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Krishna Reddy <vdumpa@nvidia.com>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] iommu/tegra241-cmdqv: Fix ioremap() error handling in
 probe()
Message-ID: <5a6c1e9a-0724-41b1-86d4-36335d3768ea@stanley.mountain>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ioremap() function doesn't return error pointers, it returns NULL
on error so update the error handling.  Also just return directly
instead of calling iounmap() on the NULL pointer.  Calling
iounmap(NULL) doesn't cause a problem on ARM but on other architectures
it can trigger a warning so it'a bad habbit.

Fixes: 918eb5c856f6 ("iommu/arm-smmu-v3: Add in-kernel support for NVIDIA Tegra241 (Grace) CMDQV")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 03fd13c21dcc..240b54192177 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -772,9 +772,9 @@ __tegra241_cmdqv_probe(struct arm_smmu_device *smmu, struct resource *res,
 	static_assert(offsetof(struct tegra241_cmdqv, smmu) == 0);
 
 	base = ioremap(res->start, resource_size(res));
-	if (IS_ERR(base)) {
-		dev_err(smmu->dev, "failed to ioremap: %ld\n", PTR_ERR(base));
-		goto iounmap;
+	if (!base) {
+		dev_err(smmu->dev, "failed to ioremap\n");
+		return NULL;
 	}
 
 	regval = readl(base + TEGRA241_CMDQV_CONFIG);
-- 
2.45.2

