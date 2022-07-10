Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B9B7B
	for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 23:06:08 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id be14-20020a05600c1e8e00b003a04a458c54so2089218wmb.3
        for <iommu@lists.linux.dev>; Sun, 10 Jul 2022 16:06:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eG4cDXpCwPd5e9f6H24dRQy0mExW1bAeq7MJJ7YjfTc=;
        b=vKgGjeledgKSvbyvudX5W+WP80Jb5rPkTbE5n4lbDLPTYE1R3td4O1Fh2SIRlWsChs
         zNTctxShh7Q0kUWdIvbCbYZY/ghIjcQDxK5qWLSBgHWPm4Rq7lhHUI8Qn/0LmLfmZtvf
         PLWzfMbYIvCzuqIyGECbXxu9A7kzHlJTlhGr3okDBUAdxWjXo0WaZ9Ga94A/cNp837TS
         GRkfALXaNHLXDqdxKO9Ky+8WwKvxCSBjLlJuixhEZ8lqjNdhiBSoBY5thpYIwv9vhKCT
         mNXwinWjmp7CAMs7NcESNaD3xu8w/PJ/YkhF3BY7wmXcz9FHZhKivcjVnQQS7lHbSDT6
         pFEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eG4cDXpCwPd5e9f6H24dRQy0mExW1bAeq7MJJ7YjfTc=;
        b=lJjYRHL2c7UJ50AwoP1Ec3YaQBXlabWxVZ8ppN26bktyfYXRwJUnpSEff3aGuWTn/j
         OnWaeRx+qCuKLcSyrZCmndDaHvHdeAdCgSKB1HU1mhgEPrYmMMC5u57oeMV0ezVEf5AR
         qHkKjtNEb/GzYdVLKkyQIuy2RH0A2ihTutbauX9j3vcpYFOK0hq4AS2jqxY8o2cJpXeM
         uYx/E9/Qdd9eCaQ45BqcIGJzH+7et6bCYFXEgz8pbD/mN7vquSxQW3WMGByvvGRFmV+B
         l4cWl63vTRSGXBwzkCSwljpMyk5rQk/RjaDhMZOFdoA1qggI5fb6xOs0CkBgjELxuAc6
         UlZQ==
X-Gm-Message-State: AJIora/qcEOUI1G1y330LyRiOyW7xBrqQyr6MUQrGfzFBOQRMgkBMsfN
	o7l8+pw8tZYn8I+fEt7rIk/FfQ==
X-Google-Smtp-Source: AGRyM1tn3eeoTDSPR6nUcb7hLnN1jy33xtCICi4w0wZfKNEp3alCe02khff0VldwrNkL1Z8Yh+gQOQ==
X-Received: by 2002:a7b:cb03:0:b0:39e:e826:ce6d with SMTP id u3-20020a7bcb03000000b0039ee826ce6dmr12559153wmj.102.1657494367129;
        Sun, 10 Jul 2022 16:06:07 -0700 (PDT)
Received: from localhost ([31.134.121.151])
        by smtp.gmail.com with ESMTPSA id m22-20020a7bcb96000000b003a2cf5eb900sm2687143wmi.40.2022.07.10.16.06.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 16:06:06 -0700 (PDT)
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
Subject: [PATCH v2 2/7] iommu/exynos: Handle failed IOMMU device registration properly
Date: Mon, 11 Jul 2022 02:05:58 +0300
Message-Id: <20220710230603.13526-3-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220710230603.13526-1-semen.protsenko@linaro.org>
References: <20220710230603.13526-1-semen.protsenko@linaro.org>
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

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
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

