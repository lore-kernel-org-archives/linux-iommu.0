Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 818C87C
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 11:55:29 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20221104115522euoutp019a0152130fe4415978286e3617cfa5b5~kX6R8_Y322291322913euoutp01F
	for <iommu@lists.linux.dev>; Fri,  4 Nov 2022 11:55:22 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20221104115522euoutp019a0152130fe4415978286e3617cfa5b5~kX6R8_Y322291322913euoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1667562922;
	bh=0bjJJ72NgE7HBes5ZZXZXgX6KwAQSmQyte75G2LW2ao=;
	h=From:To:Cc:Subject:Date:References:From;
	b=V1Os/pm3Y+9AIiBd8BHTD1gNuSRg4Nuth01nxWtVDDb7tI6IaMN0igoS5xpHFxXVC
	 VWrMdtdmUeInTJzM51A0KYxk90oPmHYBgKA10/khxw4jG2rqEEySzYSBjQPKZGHe3k
	 AWgM9nXJS/6/xIdRFSUZf1DXOT3VG42IV59S4zeM=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20221104115521eucas1p25ff86f7c12bec265f0e303a18bd36c10~kX6RmG-nk2214922149eucas1p2G;
	Fri,  4 Nov 2022 11:55:21 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id 0C.17.19378.9ADF4636; Fri,  4
	Nov 2022 11:55:21 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20221104115521eucas1p2ef149555574e8f6cbd1bb3df0bdbbb20~kX6RHZnjq2320023200eucas1p2D;
	Fri,  4 Nov 2022 11:55:21 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221104115521eusmtrp11dc9d1562fae828dd5ce7f176c062310~kX6RGs-Aa0229402294eusmtrp1O;
	Fri,  4 Nov 2022 11:55:21 +0000 (GMT)
X-AuditID: cbfec7f5-a4dff70000014bb2-0e-6364fda9091c
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id CB.D1.10862.9ADF4636; Fri,  4
	Nov 2022 11:55:21 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20221104115520eusmtip11fc5ba64fce5fac39d4bb74cd5217eee~kX6QlP4Sq2304223042eusmtip1Z;
	Fri,  4 Nov 2022 11:55:20 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Sam
	Protsenko <semen.protsenko@linaro.org>
Subject: [PATCH] iommu/exynos: Fix driver initialization sequence
Date: Fri,  4 Nov 2022 12:55:11 +0100
Message-Id: <20221104115511.28256-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.17.1
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWy7djP87or/6YkGxy5oWnxYN42NotfXyws
	OmdvYLfY+3oru8WM8/uYLNYeuctu8bwPyGq5Y+rA4fHk4Dwmj02rOtk87lzbw+bxYvNMRo++
	LasYPT5vkgtgi+KySUnNySxLLdK3S+DKePT4MHPBMp6KFR8nMTcwruXqYuTkkBAwkTg5rZGt
	i5GLQ0hgBaPEsuVrmCGcL4wSDw8cg8p8ZpRobFrABNPycdkHRojEckaJLduesIAkwFo+XlQA
	sdkEDCW63naxgdgiAjYSV04tAZvELPCXUeLapTmsIAlhAUeJi/P+s4PYLAKqEsumzmYGsXkF
	bCU+/t/EDrFNXmL1hgPMEHYvh8T+u6ldjBxAtovEq4eJEGFhiVfHt0CVy0icntzDArJLQqCd
	UWLB7/tMEM4ERomG57cYIaqsJe6c+8UGMohZQFNi/S59iLCjRMe8vewQ8/kkbrwVBAkzA5mT
	tk1nhgjzSnS0CUFUq0nMOr4Obu3BC5egrvSQaO48yAoJkliJf00H2Scwys1C2LWAkXEVo3hq
	aXFuemqxcV5quV5xYm5xaV66XnJ+7iZGYGo4/e/41x2MK1591DvEyMTBeIhRgoNZSYT307bk
	ZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8bDO0koUE0hNLUrNTUwtSi2CyTBycUg1MXOtifr1K
	dZhtln29/nHcsecxzZuEW6LPPOdd9WbFOw1v9ehv2Rd73RWqbPwv/2rNjFN48Unz6qLFj1UU
	V8T/vKLy7ORF+zCpY8IneeawVbNcl7r0Su9E1frvnd8jpMy0zfqnmwkcOZs27Xdyqu9vrRL2
	aUcPrVhoHfpQJjul8/uMbhEl1Sk8ZVxmxV/tdKwXzXktvDY5aP1z33C22VF6Hv5mZzn+Lend
	purc/+O/utDF0CkLNEJNpknxxVSdlbshXfM66GxF9uHZAX+UD7u3viy7p9rrYz6x4Un9biEf
	QbEd8sKH1nuEh+7Nd3xXUzdjkvubS+xHVfY2r4pb8lfy8P6MDTHNF/Nnhr+On1+mxFKckWio
	xVxUnAgAWjIylHwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrILMWRmVeSWpSXmKPExsVy+t/xu7or/6YkG3Q1s1o8mLeNzeLXFwuL
	ztkb2C32vt7KbjHj/D4mi7VH7rJbPO8DslrumDpweDw5OI/JY9OqTjaPO9f2sHm82DyT0aNv
	yypGj8+b5ALYovRsivJLS1IVMvKLS2yVog0tjPQMLS30jEws9QyNzWOtjEyV9O1sUlJzMstS
	i/TtEvQyHj0+zFywjKdixcdJzA2Ma7m6GDk5JARMJD4u+8DYxcjFISSwlFFiyZXbTBAJGYmT
	0xpYIWxhiT/Xutggij4xSnT2/WQGSbAJGEp0vQVJcHKICNhJXPu8mBmkiFmgkUniwfteRpCE
	sICjxMV5/9lBbBYBVYllU2eDNfMK2Ep8/L+JHWKDvMTqDQeYJzDyLGBkWMUoklpanJueW2yk
	V5yYW1yal66XnJ+7iREYltuO/dyyg3Hlq496hxiZOBgPMUpwMCuJ8H7alpwsxJuSWFmVWpQf
	X1Sak1p8iNEUaN9EZinR5HxgZOSVxBuaGZgamphZGphamhkrifN6FnQkCgmkJ5akZqemFqQW
	wfQxcXBKNTCJrWxT+fiz8bjsSoafl035IkLKHxheqvfUtLDdt+NGD9Mth8g1++9EtuTeEt/2
	mEvg982NNnn73+QqH83husx84qVbczVfa+HOi9Ibsid9+PyvV+y+0oN+teiNLvb3zt7RYkyv
	8Vf+Y//txzHTCd+ObrXs+n2dT7Zz8zn9+yxvLohuMjZ3t5h9OCY9MGb+ut1HLOa9f3/hb98s
	p3Pm37T84tjmv5VNv1Twz7C8niPtftj6j6H9O5wWm88sFN0YdJMl841BiVzTplmTDnfHSeUu
	Mz45q2HaFbEtP8tCJvdOmdlyfvNXo7IJvgEmn7t2uhTG/JmySDN1nvLkYx/eWx+6PWf7PD8p
	JV2NhyIlMt8FlFiKMxINtZiLihMB7q0w8tQCAAA=
X-CMS-MailID: 20221104115521eucas1p2ef149555574e8f6cbd1bb3df0bdbbb20
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20221104115521eucas1p2ef149555574e8f6cbd1bb3df0bdbbb20
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20221104115521eucas1p2ef149555574e8f6cbd1bb3df0bdbbb20
References: <CGME20221104115521eucas1p2ef149555574e8f6cbd1bb3df0bdbbb20@eucas1p2.samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>

Registering SYSMMU platform driver might directly trigger initializing
IOMMU domains and performing initial mappings. That time all common
resources for the SYSMMU driver must be already allocated, so move
platform driver registration to the end of exynos_iommu_init() function.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 45fd4850bacb..85a6a775aea5 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1432,12 +1432,6 @@ static int __init exynos_iommu_init(void)
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
@@ -1446,10 +1440,16 @@ static int __init exynos_iommu_init(void)
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

