Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF7A148FE2
	for <iommu@lists.linux.dev>; Fri,  3 May 2024 08:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724846; cv=none; b=R3qY1Qh/mP1CDdXnvf42H+hHDJr+pLf7gMnrWQXnApDTkEwbctOvDcOdwx5Trwy/Xpw40ailx94gnTSp01PG+oEfyeicfk04c3hPHCiu5g+qkE7lpPQisF69TtEmUPScjuhCryDiGRKyCylntdOz83xZQZ8agvJ2t/c/9LgRlug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724846; c=relaxed/simple;
	bh=IEfn+rA7KWKKyDU/jxXAsX8WmECqMPMDg0OqlVECxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Rze+qLCmCOtMA1vy0QiJriU+P/st/3d3odoK75WMsch6xL0ZoDRsAdCQt1DTVp/ESj2e+gNQo8FciIs7yNqKEJdDrg7cTQO0yWuR/H+qWwGUAnnmAqNZCEd9ob8Ac9iK/C8I/K22/mlB8zS9CVs3VOSn0GQg2gORYEYgkpQnJRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xUnjLCoL; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xUnjLCoL"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so48677545e9.3
        for <iommu@lists.linux.dev>; Fri, 03 May 2024 01:27:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714724843; x=1715329643; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6a6lUh+GY188jtaldul0p+3R0GTrct1Qv8MGiWgRPU=;
        b=xUnjLCoLdErp2JR796MdDdJTSDEyKXY8Ly1jIqsld4U/o92tuHa5vtQ5lAvCHF1GYs
         hHy25K438LC+GFEzFtrkj04ijfx5FT1udkZKR3+mG5yRyqynww4QVXHF/rg0dk3+63i+
         5UnXk4Zfg6brUruLyCyJCnfdijvmq235Xfl5gzm4R3uorQeHm2DARWIIPa/VN0MTK7jl
         NzhwFMb/3omJqI599HXxhcj3pqjZ9uB5eiyl8UMKiMSB/Jb1ltlWEdQoPHiNI+F4bGSE
         Ek9tAXpL08i0704Yxh5XUOgPwscON51KYKnLh+6J1hY9GRfaTZOwR2/BHj8rAmKyZzxl
         woTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714724843; x=1715329643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6a6lUh+GY188jtaldul0p+3R0GTrct1Qv8MGiWgRPU=;
        b=WAncFVTc6m4ETiJ/nTRBdQ4qmnTt0r/Q/CkztaiMTEIGwCFSMus0Zy1IAyS9YQq0Y/
         tDbWqfq760UTNV+QOlI6KSN7BVqodH6Jfwwe4cRfwJw2q6BeDeL0ivquE8PUqWzxfUoY
         viqOwKCMGOSVPAL+LVkwKyV4uOL/YA4sEQ4Zn8vZznp1CilhzuCUE5vlX1EDVUjuy05Q
         vHX964E8JWCiCH2iE6xXEhSEoxTpL1hutyBM+enhDHQd9P+QdMnMfV0HPpbC8Vif15W7
         MmiZsjZRVsRbAldnOwWvw8XiHgboZAqmQacioufRxqRjVZEPSEgnYuvshXR1QKp31imf
         ynEw==
X-Forwarded-Encrypted: i=1; AJvYcCXT5QSTCh9MO/9VL9sWoDE4UiVmrEMvYMjtlPMRKIaiF1dKW64RUMeO3tBmE3N3zkaceZJrM8ypSGG7pj/TjO4r6SrrBfE=
X-Gm-Message-State: AOJu0YxOizNPIVi+PCVcuXk1PKREo58QyqO4kFTje/k5weBy6o7GIQvX
	adq+aGD0f6Eo+9snqHQWAuWk+2WAytgcplgzPxVA+hs5jnVK2uPMwxEIFOfokcE=
X-Google-Smtp-Source: AGHT+IH+dWf8de6Y0dzA0LihElBWCS6qe1eDpqaJVWGQWI7rqiM4itGea69KiJ4DSak/Q8qdGVJp/Q==
X-Received: by 2002:a05:600c:4505:b0:41a:a08f:2696 with SMTP id t5-20020a05600c450500b0041aa08f2696mr1673113wmo.12.1714724843540;
        Fri, 03 May 2024 01:27:23 -0700 (PDT)
Received: from ta2.c.googlers.com.com (203.75.199.104.bc.googleusercontent.com. [104.199.75.203])
        by smtp.gmail.com with ESMTPSA id l8-20020a05600c4f0800b0041bfa349cadsm8488050wmq.16.2024.05.03.01.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:27:23 -0700 (PDT)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: m.szyprowski@samsung.com,
	joro@8bytes.org
Cc: will@kernel.org,
	robin.murphy@arm.com,
	krzysztof.kozlowski@linaro.org,
	alim.akhtar@samsung.com,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH] iommu/exynos: trivial use of local dev variable
Date: Fri,  3 May 2024 08:27:20 +0000
Message-ID: <20240503082720.966423-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

exynos_sysmmu_probe() defines:
	struct device *dev = &pdev->dev;
then initializes:
	data->sysmmu = dev;

Replace further &pdev->dev and data->sysmmu use with dev.

Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index d98c9161948a..447cf0d07625 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -774,8 +774,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	__sysmmu_get_version(data);
 
-	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
-				     dev_name(data->sysmmu));
+	ret = iommu_device_sysfs_add(&data->iommu, dev, NULL, dev_name(dev));
 	if (ret)
 		return ret;
 
@@ -806,7 +805,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	 * dma mapping operations on iommu page tables (cpu cache flush)
 	 */
 	if (!dma_dev)
-		dma_dev = &pdev->dev;
+		dma_dev = dev;
 
 	pm_runtime_enable(dev);
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog

