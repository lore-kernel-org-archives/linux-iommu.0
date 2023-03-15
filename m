Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44A5193
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 23:25:32 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20230315232525euoutp026fc6f92c63541d9826ec502e87366a18~Mu1LKmMti2824928249euoutp02f
	for <iommu@lists.linux.dev>; Wed, 15 Mar 2023 23:25:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20230315232525euoutp026fc6f92c63541d9826ec502e87366a18~Mu1LKmMti2824928249euoutp02f
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1678922725;
	bh=T1x/vbizTXsn7v+sBg+aNVgDBKdvx4HpQtbkrHHKzZs=;
	h=From:To:Cc:Subject:Date:References:From;
	b=vF+FssT7S9QdmtmQFYovWWV/uq0MICmhUqX4qNva8/TBcDdFVAd9sTaJiglqR4WnB
	 IeJnflUjdQJi0NAY2mx8JyJxs7dLYuciQvxBgGIhSrcrNlGlpND6CYdn6eqphlNe65
	 zAyclF67avBTWG6WjZqhAtLmAUNi3rvg+14mSGls=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230315232524eucas1p1ed87807b4c2f331e26d0b53aa72d1b94~Mu1Ko0L651779617796eucas1p1-;
	Wed, 15 Mar 2023 23:25:24 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id E8.55.09503.4E352146; Wed, 15
	Mar 2023 23:25:24 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32~Mu1J1Xcmx1580315803eucas1p23;
	Wed, 15 Mar 2023 23:25:23 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230315232523eusmtrp254b74c25d8f1dcc4e5da2bbe40fa3d56~Mu1J0zzFd2520825208eusmtrp29;
	Wed, 15 Mar 2023 23:25:23 +0000 (GMT)
X-AuditID: cbfec7f2-ea5ff7000000251f-96-641253e4b806
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 21.FE.09583.3E352146; Wed, 15
	Mar 2023 23:25:23 +0000 (GMT)
Received: from AMDC2765.eu.corp.samsungelectronics.net (unknown
	[106.120.51.73]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230315232523eusmtip213ae8966c7a1a4f150e7df344b4feef2~Mu1JQtIvH0814208142eusmtip2G;
	Wed, 15 Mar 2023 23:25:23 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2] iommu/exynos: Fix set_platform_dma_ops() callback
Date: Thu, 16 Mar 2023 00:25:14 +0100
Message-Id: <20230315232514.1046589-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djP87pPgoVSDM52alk8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8li7ZG77BYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bFrVyeZx59oeNo95JwM9XmyeyejRt2UVo8fnTXIeWz/fZgngjOKySUnNySxLLdK3S+DKOPzl
	C3vBMuGKX9PnMTYw7hToYuTkkBAwkbi4ZC0ziC0ksIJRonumTRcjF5D9hVFi9oGfrBDOZ0aJ
	c/8eMMF0dG64ygaRWM4osbZ1OiNEeyuTxPWXEiA2m4ChRNfbLjYQW0TARuLKqSVgNrPAXiaJ
	3od6ILawgKvEzwsLwVazCKhKfD2/F8zmFbCXuPH2JivEMnmJ/QfPQsUFJU7OfMICMUdeonnr
	bGaImjMcEndvhkHYLhLXm04xQtjCEq+Ob2GHsGUk/u+czwRytIRAO6PEgt/3oZwJjBINz29B
	dVhL3Dn3C+hSDqANmhLrd+lDhB0lbj98zwwSlhDgAzpOEOIGPolJ26ZDhXklOtqEIKrVJGYd
	Xwe39uCFS1Bnekis/f4MGlSxEtNfH2WewKgwC8lns5B8NgvhhgWMzKsYxVNLi3PTU4sN81LL
	9YoTc4tL89L1kvNzNzECE9Xpf8c/7WCc++qj3iFGJg7GQ4wSHMxKIrzhLAIpQrwpiZVVqUX5
	8UWlOanFhxilOViUxHm1bU8mCwmkJ5akZqemFqQWwWSZODilGphYlqzunLSRuSw9Y+az4H1V
	p4tqHC1jZ7/tTmgL6pgif9Z7euOP08mivW4Mz1v6Xr8JzM3pecqz0VFy4+6of0Hai2P6y1pm
	fW95sObvqnK3E+0XfliVHE/RnLTXVlnumUikcp2Pt9CHzolnHb/ckxM5cbI4elmm36ut61sr
	fld/55tzOmuS2pJakeVPc85vl+jYnu1RfPnVkmtVZg8vsifu9y060/Ht/S2vVU4bJbmWl698
	rzY5afXs1YFXv4n0yfY5TWhgmrupRvjKgqdaT1yNUxawn/exv38kb22klUTJ1KnHk+/0nWh8
	y8i8gnfTfPmN8zSZteyy507oPT9FcVv6xdBZb2Jj3tQqbBVkF+RUYinOSDTUYi4qTgQAW2Jg
	UcMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Pd3HwUIpBjeWGls8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8li7ZG77BYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bFrVyeZx59oeNo95JwM9XmyeyejRt2UVo8fnTXIeWz/fZgngjNKzKcovLUlVyMgvLrFVija0
	MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLOPzlC3vBMuGKX9PnMTYw7hToYuTk
	kBAwkejccJUNxBYSWMoo8f4/O0RcRuLktAZWCFtY4s+1LqAaLqCaZiaJVX/WMoIk2AQMJbre
	doE1iwjYSVz7vJgZpIhZ4DCTxKPlS1hAEsICrhI/LyxkBrFZBFQlvp7fC2bzCthL3Hh7E2qD
	vMT+g2eh4oISJ2c+AetlBoo3b53NPIGRbxaS1CwkqQWMTKsYRVJLi3PTc4uN9IoTc4tL89L1
	kvNzNzECo2TbsZ9bdjCufPVR7xAjEwfjIUYJDmYlEd5wFoEUId6UxMqq1KL8+KLSnNTiQ4ym
	QPdNZJYSTc4HxmleSbyhmYGpoYmZpYGppZmxkjivZ0FHopBAemJJanZqakFqEUwfEwenVAOT
	7m7f8mOb257dfx2cKpf24qnWnTrLH+eNu4sfcpkEnT7SfDOpKnDGXy5/Zu1fSyVYV+b2HP8U
	+Weu2KEFTYz1CyPku25YJEfUfdl/ZlV2QMKL4zte3JrUzKSw9dgeb1X5VbuahVr2p+jwJoVY
	8wXe+7Az9pORk9EqSX4mLbWINREsp/zm75U9Y1psGCC6UH3X4sDf6omn3622dfPPndjEePhR
	i437WskpRg9qpa9aRXReX7esKWPjPbEgE4Vl6m997pn/zo773fXD2u17oeD1+Zs8X67Knizo
	NpnRp2PHgvtTTAtyJt9a2KETOTNyt06NdPW7R19ezT58UXDLZ67AM5OWbQks3//Axe5OalOA
	EktxRqKhFnNRcSIA13ZZfxsDAAA=
X-CMS-MailID: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32
References: <CGME20230315232523eucas1p2565ef5954e3b5b451803c6200c8bce32@eucas1p2.samsung.com>

There are some subtle differences between release_device() and
set_platform_dma_ops() callbacks, so separate those two callbacks. Device
links should be removed only in release_device(), because they were
created in probe_device() on purpose and they are needed for proper
Exynos IOMMU driver operation. While fixing this, remove the conditional
code as it is not really needed.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
v2:
- keep set_platform_dma_ops only on ARM 32bit

Some more background why set_platform_dma_ops is needed on ARM 32bit is
available here:
https://lore.kernel.org/all/9a12fcac-c347-5d81-acef-1124c50d0c37@arm.com/
---
 drivers/iommu/exynos-iommu.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 483aaaeb6dae..1abd187c6075 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1415,23 +1415,26 @@ static struct iommu_device *exynos_iommu_probe_device(struct device *dev)
 	return &data->iommu;
 }
 
-static void exynos_iommu_release_device(struct device *dev)
+static void exynos_iommu_set_platform_dma(struct device *dev)
 {
 	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
-	struct sysmmu_drvdata *data;
 
 	if (owner->domain) {
 		struct iommu_group *group = iommu_group_get(dev);
 
 		if (group) {
-#ifndef CONFIG_ARM
-			WARN_ON(owner->domain !=
-				iommu_group_default_domain(group));
-#endif
 			exynos_iommu_detach_device(owner->domain, dev);
 			iommu_group_put(group);
 		}
 	}
+}
+
+static void exynos_iommu_release_device(struct device *dev)
+{
+	struct exynos_iommu_owner *owner = dev_iommu_priv_get(dev);
+	struct sysmmu_drvdata *data;
+
+	exynos_iommu_set_platform_dma(dev);
 
 	list_for_each_entry(data, &owner->controllers, owner_node)
 		device_link_del(data->link);
@@ -1479,7 +1482,7 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.device_group = generic_device_group,
 #ifdef CONFIG_ARM
-	.set_platform_dma_ops = exynos_iommu_release_device,
+	.set_platform_dma_ops = exynos_iommu_set_platform_dma,
 #endif
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
-- 
2.34.1

