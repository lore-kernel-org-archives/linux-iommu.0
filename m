Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AAD94C64
	for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 16:55:56 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id b26so3383978wrc.2
        for <iommu@lists.linux.dev>; Thu, 14 Jul 2022 09:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S2fOwRS7PBfoQ/JKwgWoKuZEaYFo7PU9A3pBuSjiPrw=;
        b=FJYTZoClCTlgrArGKeLYT8JUYfT6a60vzX4X3MgwAp51q4tyoTeo+z3gFLcTsZ2bEo
         j5hT5ULynZb3pQJxareXMpi7f4RSaQGIqIRmviSi/4Xus+TNZzAs7hp452FuzBLFcg7w
         ywRqEzWxw2c5kKbfm7iRwREbZpU/D9Jbff+gcPJmQI20iQSSqv+5mKOSIMME1uH6Csqf
         4IHfl34HFOIAJvzJabWhKe77UZiHWzC+CtPvYvqQXckMhS4zPEQZF4UX1Zw1vDU0/CAt
         dPiIkVHGtob3+NZ66Xeonz4SYNmBVvCx8iC2hnD+CoOV7FIha5uMQbJ52A7oHmZvbs3I
         60LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S2fOwRS7PBfoQ/JKwgWoKuZEaYFo7PU9A3pBuSjiPrw=;
        b=f80AXIoeAoNNjZdyMNp4sCrAABr5yILuGBlG0uvV4nusoFznsSkPtlGWWyeAxfTYkm
         XLSwMhx9T91yxS6I9RBrX89IdPFsS9BHMap4egih4GatxJR7IWEW3epRJrpYkRqVfNAO
         SOS4I78EuN+iRI1/LID5jjgQGd0u5AD4XRiXEoXCBAfc6O3fq9hvKKvf6RGTWdF0nu28
         sg2ZXhCM44iOQH1Wei0FT6lqCFKUTGXLF4KRTKIV1zIonstkN5cTTVpHeqF5YK9wMLjw
         nMtIIh3a4d6YeI6uEKUKp2v/EIxyh1pI0XejX72IzEBQpTtJH+eT4i/A/46r69QlN3o8
         UtSA==
X-Gm-Message-State: AJIora+5vAV5nguu5Nt3GGjwW2nE7jdxlrnivtrpc1gCEpt1MniXFxwg
	Hm5FbUdCka7o3txiUZRafGbPOA==
X-Google-Smtp-Source: AGRyM1uOCE0ebi2E5Ao34myU6FQDDLS+28S7amW2//dWGnRsQjZ0isNECaLLQ5j97W3z0Vyo//ZQ7g==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr8725414wri.626.1657817754857;
        Thu, 14 Jul 2022 09:55:54 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id z8-20020a1c4c08000000b003942a244f40sm5706762wmf.25.2022.07.14.09.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 09:55:54 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] iommu/exynos: Handle failed IOMMU device registration properly
Date: Thu, 14 Jul 2022 19:55:46 +0300
Message-Id: <20220714165550.8884-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220714165550.8884-1-semen.protsenko@linaro.org>
References: <20220714165550.8884-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If iommu_device_register() fails in exynos_sysmmu_probe(), the previous
calls have to be cleaned up. In this case, the iommu_device_sysfs_add()
should be cleaned up, by calling its remove counterpart call.

Fixes: d2c302b6e8b1 ("iommu/exynos: Make use of iommu_device_register interface")
Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
Changes in v3:
  - Added Marek's Acked-by tag
  - Added Krzysztof's R-b tag
  - Added "Fixes" tag, as suggested by Krzysztof

Changes in v2:
  - (none) This patch is new and added in v2

 drivers/iommu/exynos-iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 8f80aaa35092..c85db9dab851 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -629,7 +629,7 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
 	if (ret)
-		return ret;
+		goto err_iommu_register;
 
 	platform_set_drvdata(pdev, data);
 
@@ -656,6 +656,10 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	pm_runtime_enable(dev);
 
 	return 0;
+
+err_iommu_register:
+	iommu_device_sysfs_remove(&data->iommu);
+	return ret;
 }
 
 static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
-- 
2.30.2

