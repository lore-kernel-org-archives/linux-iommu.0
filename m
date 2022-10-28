Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594AD12286
	for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 19:12:55 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z18so4225842edb.9
        for <iommu@lists.linux.dev>; Fri, 28 Oct 2022 12:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=deMSZFUhvNmRdIfYG/C3RyBQaijBl5jkuXDMUwHOSfU=;
        b=ITbfN5eFzSlarpfm6uqKJEMWgyggUQN+lNoa9zCXhXHPcYfNQJ2H4hx+xTBeYE/llo
         EdEPh1b27nTt6KvLrJ/pXVkD/pE6Yz54gTQr4bhyvozC0Npne1qN92uZnXET0cx4JVOV
         OIf32eGS4HV6oBvFTlBRqHsc1vSKR4Yndk7FovaFMDVlH9jKv407c77vFEGoKLKx3Lpx
         00aMv/M7su9Eomf1x27yzLxJ55SMvdXcI4yW8UlWN/xobQg71hnNUCLuWRFSUVrw6eCy
         XpaKyIlbOpZ7lYMhXVK8NXHed8YPZKN5BmVRib+GQqe8JN35zRS6UFEVsrCGmh/Hne4d
         RvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=deMSZFUhvNmRdIfYG/C3RyBQaijBl5jkuXDMUwHOSfU=;
        b=ISkZbCoxkojP76hOF9nR0XTe1NwVGDBj24DNO8FjEsXl2yaYt7XUC+eq6GMeiMubOL
         g9viTDSf7G638DToozXAMPbLHvJH+rolixIkVBg7dMlW6YIXyylOW2wnJMwohbIPH+eP
         Xsw9FB7zA1QByEJM/YpJlfmOQ0hiwwfKd/ZBHtK+JBAqZZ5M5gvtZGKcbpDIhRsKXCie
         xR1qvqXMuPwzReIxbsKVvfo8sBGGRLMyunuP6aE3mbsoZJrHIulCpJ61oYjQ3iqhKpaR
         jKucd01nHZ4vlUniKEOL4sDJx9XdTOTpdvbmf0KBqUsUc0rEABXixAdehFd64NrBCsrY
         mXTA==
X-Gm-Message-State: ACrzQf0cKGK3UZ+flgjFaBxNK2ZocYHfgPmo7wuhM+kMCj+DdzPoyhjt
	PSYr3Ny7MxgKEnzKpRNusyVDfA==
X-Google-Smtp-Source: AMsMyM6avMFshulH77RloU/mF32waXGsMPKerdgE9UbPWuVeBJIddF1PsG+b3odsc165qF4xXhcX6A==
X-Received: by 2002:a05:6402:430a:b0:462:2e05:30b5 with SMTP id m10-20020a056402430a00b004622e0530b5mr920629edc.246.1666984373603;
        Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
Received: from localhost (cgw.msart-bajzova4.ke.cust.o2bs.sk. [90.176.4.227])
        by smtp.gmail.com with ESMTPSA id kz2-20020a17090777c200b0079dbf06d558sm2487737ejc.184.2022.10.28.12.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:12:53 -0700 (PDT)
From: Sam Protsenko <semen.protsenko@linaro.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Janghyuck Kim <janghyuck.kim@samsung.com>,
	Cho KyongHo <pullip.cho@samsung.com>,
	Daniel Mentz <danielmentz@google.com>,
	David Virag <virag.david003@gmail.com>,
	iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org
Subject: [PATCH 4/4] iommu/exynos: Rearrange the platform driver code
Date: Fri, 28 Oct 2022 21:12:43 +0200
Message-Id: <20221028191243.31721-5-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221028191243.31721-1-semen.protsenko@linaro.org>
References: <20221028191243.31721-1-semen.protsenko@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the platform_driver code to the bottom of the driver, as it's a
canonical form for that. No functional change.

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
---
 drivers/iommu/exynos-iommu.c | 359 +++++++++++++++++------------------
 1 file changed, 179 insertions(+), 180 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 57492db877e2..af1c8ddcf5e4 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -641,186 +641,6 @@ static void sysmmu_tlb_invalidate_entry(struct sysmmu_drvdata *data,
 	spin_unlock_irqrestore(&data->lock, flags);
 }
 
-static const struct iommu_ops exynos_iommu_ops;
-
-static int exynos_sysmmu_probe(struct platform_device *pdev)
-{
-	int irq, ret;
-	struct device *dev = &pdev->dev;
-	struct sysmmu_drvdata *data;
-	struct resource *res;
-
-	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	data->sfrbase = devm_ioremap_resource(dev, res);
-	if (IS_ERR(data->sfrbase))
-		return PTR_ERR(data->sfrbase);
-
-	irq = platform_get_irq(pdev, 0);
-	if (irq <= 0)
-		return irq;
-
-	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
-				dev_name(dev), data);
-	if (ret) {
-		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
-		return ret;
-	}
-
-	data->clk = devm_clk_get(dev, "sysmmu");
-	if (PTR_ERR(data->clk) == -ENOENT)
-		data->clk = NULL;
-	else if (IS_ERR(data->clk))
-		return PTR_ERR(data->clk);
-
-	data->aclk = devm_clk_get(dev, "aclk");
-	if (PTR_ERR(data->aclk) == -ENOENT)
-		data->aclk = NULL;
-	else if (IS_ERR(data->aclk))
-		return PTR_ERR(data->aclk);
-
-	data->pclk = devm_clk_get(dev, "pclk");
-	if (PTR_ERR(data->pclk) == -ENOENT)
-		data->pclk = NULL;
-	else if (IS_ERR(data->pclk))
-		return PTR_ERR(data->pclk);
-
-	if (!data->clk && (!data->aclk || !data->pclk)) {
-		dev_err(dev, "Failed to get device clock(s)!\n");
-		return -ENOENT;
-	}
-
-	data->clk_master = devm_clk_get(dev, "master");
-	if (PTR_ERR(data->clk_master) == -ENOENT)
-		data->clk_master = NULL;
-	else if (IS_ERR(data->clk_master))
-		return PTR_ERR(data->clk_master);
-
-	data->sysmmu = dev;
-	spin_lock_init(&data->lock);
-
-	__sysmmu_get_version(data);
-
-	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
-				     dev_name(data->sysmmu));
-	if (ret)
-		return ret;
-
-	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
-	if (ret)
-		goto err_iommu_register;
-
-	platform_set_drvdata(pdev, data);
-
-	if (PG_ENT_SHIFT < 0) {
-		if (MMU_MAJ_VER(data->version) < 5) {
-			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
-			LV1_PROT = SYSMMU_LV1_PROT;
-			LV2_PROT = SYSMMU_LV2_PROT;
-		} else {
-			PG_ENT_SHIFT = SYSMMU_V5_PG_ENT_SHIFT;
-			LV1_PROT = SYSMMU_V5_LV1_PROT;
-			LV2_PROT = SYSMMU_V5_LV2_PROT;
-		}
-	}
-
-	if (MMU_MAJ_VER(data->version) >= 5) {
-		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
-		if (ret) {
-			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
-			goto err_dma_set_mask;
-		}
-	}
-
-	/*
-	 * use the first registered sysmmu device for performing
-	 * dma mapping operations on iommu page tables (cpu cache flush)
-	 */
-	if (!dma_dev)
-		dma_dev = &pdev->dev;
-
-	pm_runtime_enable(dev);
-
-	return 0;
-
-err_dma_set_mask:
-	iommu_device_unregister(&data->iommu);
-err_iommu_register:
-	iommu_device_sysfs_remove(&data->iommu);
-	return ret;
-}
-
-static void exynos_sysmmu_shutdown(struct platform_device *pdev)
-{
-	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
-	struct device *dev = &pdev->dev;
-	int irq = platform_get_irq(pdev, 0);
-
-	devm_free_irq(dev, irq, data);
-	pm_runtime_force_suspend(dev);
-}
-
-static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	struct device *master = data->master;
-
-	if (master) {
-		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
-
-		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
-			dev_dbg(data->sysmmu, "saving state\n");
-			__sysmmu_disable(data);
-		}
-		mutex_unlock(&owner->rpm_lock);
-	}
-	return 0;
-}
-
-static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
-{
-	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
-	struct device *master = data->master;
-
-	if (master) {
-		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
-
-		mutex_lock(&owner->rpm_lock);
-		if (data->domain) {
-			dev_dbg(data->sysmmu, "restoring state\n");
-			__sysmmu_enable(data);
-		}
-		mutex_unlock(&owner->rpm_lock);
-	}
-	return 0;
-}
-
-static const struct dev_pm_ops sysmmu_pm_ops = {
-	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
-	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
-				pm_runtime_force_resume)
-};
-
-static const struct of_device_id sysmmu_of_match[] = {
-	{ .compatible	= "samsung,exynos-sysmmu", },
-	{ },
-};
-
-static struct platform_driver exynos_sysmmu_driver = {
-	.probe	= exynos_sysmmu_probe,
-	.shutdown = exynos_sysmmu_shutdown,
-	.driver	= {
-		.name		= "exynos-sysmmu",
-		.of_match_table	= sysmmu_of_match,
-		.pm		= &sysmmu_pm_ops,
-		.suppress_bind_attrs = true,
-	}
-};
-
 static inline void exynos_iommu_set_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
 {
 	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
@@ -1427,6 +1247,184 @@ static const struct iommu_ops exynos_iommu_ops = {
 	}
 };
 
+static int exynos_sysmmu_probe(struct platform_device *pdev)
+{
+	int irq, ret;
+	struct device *dev = &pdev->dev;
+	struct sysmmu_drvdata *data;
+	struct resource *res;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	data->sfrbase = devm_ioremap_resource(dev, res);
+	if (IS_ERR(data->sfrbase))
+		return PTR_ERR(data->sfrbase);
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq <= 0)
+		return irq;
+
+	ret = devm_request_irq(dev, irq, exynos_sysmmu_irq, 0,
+				dev_name(dev), data);
+	if (ret) {
+		dev_err(dev, "Unabled to register handler of irq %d\n", irq);
+		return ret;
+	}
+
+	data->clk = devm_clk_get(dev, "sysmmu");
+	if (PTR_ERR(data->clk) == -ENOENT)
+		data->clk = NULL;
+	else if (IS_ERR(data->clk))
+		return PTR_ERR(data->clk);
+
+	data->aclk = devm_clk_get(dev, "aclk");
+	if (PTR_ERR(data->aclk) == -ENOENT)
+		data->aclk = NULL;
+	else if (IS_ERR(data->aclk))
+		return PTR_ERR(data->aclk);
+
+	data->pclk = devm_clk_get(dev, "pclk");
+	if (PTR_ERR(data->pclk) == -ENOENT)
+		data->pclk = NULL;
+	else if (IS_ERR(data->pclk))
+		return PTR_ERR(data->pclk);
+
+	if (!data->clk && (!data->aclk || !data->pclk)) {
+		dev_err(dev, "Failed to get device clock(s)!\n");
+		return -ENOENT;
+	}
+
+	data->clk_master = devm_clk_get(dev, "master");
+	if (PTR_ERR(data->clk_master) == -ENOENT)
+		data->clk_master = NULL;
+	else if (IS_ERR(data->clk_master))
+		return PTR_ERR(data->clk_master);
+
+	data->sysmmu = dev;
+	spin_lock_init(&data->lock);
+
+	__sysmmu_get_version(data);
+
+	ret = iommu_device_sysfs_add(&data->iommu, &pdev->dev, NULL,
+				     dev_name(data->sysmmu));
+	if (ret)
+		return ret;
+
+	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
+	if (ret)
+		goto err_iommu_register;
+
+	platform_set_drvdata(pdev, data);
+
+	if (PG_ENT_SHIFT < 0) {
+		if (MMU_MAJ_VER(data->version) < 5) {
+			PG_ENT_SHIFT = SYSMMU_PG_ENT_SHIFT;
+			LV1_PROT = SYSMMU_LV1_PROT;
+			LV2_PROT = SYSMMU_LV2_PROT;
+		} else {
+			PG_ENT_SHIFT = SYSMMU_V5_PG_ENT_SHIFT;
+			LV1_PROT = SYSMMU_V5_LV1_PROT;
+			LV2_PROT = SYSMMU_V5_LV2_PROT;
+		}
+	}
+
+	if (MMU_MAJ_VER(data->version) >= 5) {
+		ret = dma_set_mask(dev, DMA_BIT_MASK(36));
+		if (ret) {
+			dev_err(dev, "Unable to set DMA mask: %d\n", ret);
+			goto err_dma_set_mask;
+		}
+	}
+
+	/*
+	 * use the first registered sysmmu device for performing
+	 * dma mapping operations on iommu page tables (cpu cache flush)
+	 */
+	if (!dma_dev)
+		dma_dev = &pdev->dev;
+
+	pm_runtime_enable(dev);
+
+	return 0;
+
+err_dma_set_mask:
+	iommu_device_unregister(&data->iommu);
+err_iommu_register:
+	iommu_device_sysfs_remove(&data->iommu);
+	return ret;
+}
+
+static void exynos_sysmmu_shutdown(struct platform_device *pdev)
+{
+	struct sysmmu_drvdata *data = platform_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+	int irq = platform_get_irq(pdev, 0);
+
+	devm_free_irq(dev, irq, data);
+	pm_runtime_force_suspend(dev);
+}
+
+static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
+
+	if (master) {
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
+
+		mutex_lock(&owner->rpm_lock);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "saving state\n");
+			__sysmmu_disable(data);
+		}
+		mutex_unlock(&owner->rpm_lock);
+	}
+	return 0;
+}
+
+static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
+{
+	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
+	struct device *master = data->master;
+
+	if (master) {
+		struct exynos_iommu_owner *owner = dev_iommu_priv_get(master);
+
+		mutex_lock(&owner->rpm_lock);
+		if (data->domain) {
+			dev_dbg(data->sysmmu, "restoring state\n");
+			__sysmmu_enable(data);
+		}
+		mutex_unlock(&owner->rpm_lock);
+	}
+	return 0;
+}
+
+static const struct dev_pm_ops sysmmu_pm_ops = {
+	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
+	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
+				pm_runtime_force_resume)
+};
+
+static const struct of_device_id sysmmu_of_match[] = {
+	{ .compatible	= "samsung,exynos-sysmmu", },
+	{ },
+};
+
+static struct platform_driver exynos_sysmmu_driver = {
+	.probe	= exynos_sysmmu_probe,
+	.shutdown = exynos_sysmmu_shutdown,
+	.driver	= {
+		.name		= "exynos-sysmmu",
+		.of_match_table	= sysmmu_of_match,
+		.pm		= &sysmmu_pm_ops,
+		.suppress_bind_attrs = true,
+	}
+};
+
 static int __init exynos_iommu_init(void)
 {
 	struct device_node *np;
@@ -1460,6 +1458,7 @@ static int __init exynos_iommu_init(void)
 	}
 
 	return 0;
+
 err_zero_lv2:
 	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
-- 
2.35.1

