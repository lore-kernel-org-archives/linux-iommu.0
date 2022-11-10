Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB991A490
	for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 15:44:21 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221110154413euoutp018f420c9184a5cd1c5d9f69af6071a42a~mQ50C_0mm3076930769euoutp01Z
	for <iommu@lists.linux.dev>; Thu, 10 Nov 2022 15:44:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221110154413euoutp018f420c9184a5cd1c5d9f69af6071a42a~mQ50C_0mm3076930769euoutp01Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1668095053;
	bh=RTlqPRPkAF90sJzQgDeIHX/QvRtLXffz+QWdpPDpvu0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=PPBY9FdTlPCZiQNo3z/VV6Xob5CEgAjsIceYhT70gwsSPo21nGDLq/ANakprb+rkf
	 wj51s8xPdpSgd5l0McPwGjvin6zks7jbepzjokg5SEFqLrrAk2fUg43JGbPa7v83Kh
	 Wu0Xb5Ahjg+06UM/k7ZtqFF3mC/mbz38M5EoKZn8=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221110154413eucas1p272965ba486543310ee03f7b39be7e985~mQ5zwOBmE3053030530eucas1p2-;
	Thu, 10 Nov 2022 15:44:13 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 6A.C8.09561.D4C1D636; Thu, 10
	Nov 2022 15:44:13 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221110154412eucas1p26182a3d691584b577ddced9a1287df60~mQ5zRAH4K1747017470eucas1p2y;
	Thu, 10 Nov 2022 15:44:12 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20221110154412eusmtrp201742c1069475873496966eb17dc1b29~mQ5zQbXZ32581425814eusmtrp2R;
	Thu, 10 Nov 2022 15:44:12 +0000 (GMT)
X-AuditID: cbfec7f2-0b3ff70000002559-72-636d1c4d29d7
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 4E.10.09026.C4C1D636; Thu, 10
	Nov 2022 15:44:12 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221110154412eusmtip1c91bac3ccf25c9263887bb4091735d2c~mQ5yycaMz2203222032eusmtip1N;
	Thu, 10 Nov 2022 15:44:12 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sam
	Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH v2] iommu/exynos: Fix driver initialization sequence
Date: Thu, 10 Nov 2022 16:44:07 +0100
Message-Id: <20221110154407.26531-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrFIsWRmVeSWpSXmKPExsWy7djP87q+MrnJBntm8Fg8mLeNzeLXFwuL
	ztkb2C32vt7KbjHj/D4mi7VH7rJbPO8DslrumDpweDw5OI/JY9OqTjaPO9f2sHm82DyT0aNv
	yypGj8+b5ALYorhsUlJzMstSi/TtErgyOtYaF1wUqtix8ztLA+MJ/i5GTg4JAROJpsWv2LsY
	uTiEBFYwSvxa+58RwvnCKHFxwVyozGdGiUPb/jDDtMy7PYcNIrGcUeLf9EYmuJaeZ6/BqtgE
	DCW63naxgdgiAjYSV04tAetgFvjLKHHt0hzWLkYODmEBF4m2XywgNSwCqhJPTp4Hq+cVsJVY
	vusAO8Q2eYnVGw4wg/RKCHRySMxrPckGkXCROHzxFAuELSzx6vgWqAYZif875zNBNLQzSiz4
	fR/KmcAo0fD8FiNElbXEnXO/2ECuYBbQlFi/Sx8i7CjRv3wXM0hYQoBP4sZbQZAwM5A5adt0
	qDCvREebEES1msSs4+vg1h68cAkaQh4SzxYtYgWxhQRiJRa3zmGcwCg3C2HXAkbGVYziqaXF
	uempxYZ5qeV6xYm5xaV56XrJ+bmbGIHJ4fS/4592MM599VHvECMTB+MhRgkOZiURXm6N7GQh
	3pTEyqrUovz4otKc1OJDjNIcLErivGwztJKFBNITS1KzU1MLUotgskwcnFINTDHnnj7VSpm4
	RUGD9ZHu0YLZpzw13a63Nm1Mvcx4zXHDJ7WNkou/Cqy70JdpXFgfP/eWnPoV/+tlB7a4/BIT
	t9Se/6VfPnrvx/4/C+NNTabHl93WFM/as6hSZOkasYwzpk4i6SULnq89bponscP3V1zIysxv
	fz3fyGmdDaudw7LmxH2mA0b9uqad/X3XOnsrhYI/733/eanwrjKLWr11oj/dDwrJ2cxXVrNP
	/LVl//MW7n9q5279feokHZG+/s3yWc45XS0778964/I1fR7PuSeHz7XN7Tgabhy6YDOvUX7c
	j9LA1Wwi/Ods2d+tDFLe3Hp9t8Nr58f1a803GdZfc/39yGxxz7GND363mAamximxFGckGmox
	FxUnAgBtpP8KfQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPLMWRmVeSWpSXmKPExsVy+t/xu7o+MrnJBlPv6Vg8mLeNzeLXFwuL
	ztkb2C32vt7KbjHj/D4mi7VH7rJbPO8DslrumDpweDw5OI/JY9OqTjaPO9f2sHm82DyT0aNv
	yypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
	i/TtEvQyOtYaF1wUqtix8ztLA+MJ/i5GTg4JAROJebfnsHUxcnEICSxllLh0ZDsbREJG4uS0
	BlYIW1jiz7UuqKJPjBJd2/aCJdgEDCW63naBNYgI2Elc+7yYGaSIWaCRSeLB+17GLkYODmEB
	F4m2XywgNSwCqhJPTp4Hq+cVsJVYvusAO8QCeYnVGw4wT2DkWcDIsIpRJLW0ODc9t9hIrzgx
	t7g0L10vOT93EyMwJLcd+7llB+PKVx/1DjEycTAeYpTgYFYS4eXWyE4W4k1JrKxKLcqPLyrN
	SS0+xGgKtG8is5Rocj4wKvJK4g3NDEwNTcwsDUwtzYyVxHk9CzoShQTSE0tSs1NTC1KLYPqY
	ODilGpj2dtienb695oHfeb6CVBNmmezlUapm2vcDJ7l9dd/bqnzqWMP2M1YnisrPNW813bfQ
	RJL5pM3jVwcqphse6K24sEFAI/Xzc1bFT9cafS++LpGx2uKzr/rXz8qFIvMXbNl6L3/3WoGg
	wlUc3cknt5wvjPUSnbdFiltjcntkSCH3yfVt8j4Rf6wst0XFZmk8XNThFfIrJGKf49ozwolL
	Lczuf7vg4+cV5rYjc1dbyNmeg5+Mbmq9u+fL+XKW7d3/L1QPc6onn3GJm+q2pr2wS81+6m+9
	jhuP2MN33pz6e8bx5ENSE1ROz3f+Ze5aset0fvZDrvzqtCdtF85Ovl3yJvMwz5wb7EtuMnSc
	6D755EKbEktxRqKhFnNRcSIAFMdDodICAAA=
X-CMS-MailID: 20221110154412eucas1p26182a3d691584b577ddced9a1287df60
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221110154412eucas1p26182a3d691584b577ddced9a1287df60
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221110154412eucas1p26182a3d691584b577ddced9a1287df60
References: <CGME20221110154412eucas1p26182a3d691584b577ddced9a1287df60@eucas1p2.samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Registering a SYSMMU platform driver might directly trigger initializing
IOMMU domains and performing the initial mappings. Also the IOMMU core
might use the IOMMU hardware once it has been registered with
iommu_device_register() function. Ensure that all driver resources are
allocated and initialized before the driver advertise its presence to the
platform bus and the IOMMU subsystem.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 45fd4850bacb..b0cde2211987 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -708,10 +708,6 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
-	if (ret)
-		goto err_iommu_register;
-
 	platform_set_drvdata(pdev, data);
 
 	if (PG_ENT_SHIFT < 0) {
@@ -743,11 +739,13 @@ static int exynos_sysmmu_probe(struct platform_device *pdev)
 
 	pm_runtime_enable(dev);
 
+	ret = iommu_device_register(&data->iommu, &exynos_iommu_ops, dev);
+	if (ret)
+		goto err_dma_set_mask;
+
 	return 0;
 
 err_dma_set_mask:
-	iommu_device_unregister(&data->iommu);
-err_iommu_register:
 	iommu_device_sysfs_remove(&data->iommu);
 	return ret;
 }
@@ -1432,12 +1430,6 @@ static int __init exynos_iommu_init(void)
 		return -ENOMEM;
 	}
 
-	ret = platform_driver_register(&exynos_sysmmu_driver);
-	if (ret) {
-		pr_err("%s: Failed to register driver\n", __func__);
-		goto err_reg_driver;
-	}
-
 	zero_lv2_table = kmem_cache_zalloc(lv2table_kmem_cache, GFP_KERNEL);
 	if (zero_lv2_table == NULL) {
 		pr_err("%s: Failed to allocate zero level2 page table\n",
@@ -1446,10 +1438,16 @@ static int __init exynos_iommu_init(void)
 		goto err_zero_lv2;
 	}
 
+	ret = platform_driver_register(&exynos_sysmmu_driver);
+	if (ret) {
+		pr_err("%s: Failed to register driver\n", __func__);
+		goto err_reg_driver;
+	}
+
 	return 0;
-err_zero_lv2:
-	platform_driver_unregister(&exynos_sysmmu_driver);
 err_reg_driver:
+	platform_driver_unregister(&exynos_sysmmu_driver);
+err_zero_lv2:
 	kmem_cache_destroy(lv2table_kmem_cache);
 	return ret;
 }
-- 
2.17.1

