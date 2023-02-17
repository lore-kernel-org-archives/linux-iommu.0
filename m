Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2135692
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:21:45 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230217112143euoutp01da8cf6a33108adddf49fd6b0a4728cd8~EmL4KlT9v2433924339euoutp01G
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:21:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230217112143euoutp01da8cf6a33108adddf49fd6b0a4728cd8~EmL4KlT9v2433924339euoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1676632903;
	bh=+uOpsJCb+Nz9liQB+kMqji9vblPsM55cQXn1mbsU4F0=;
	h=From:To:Cc:Subject:Date:References:From;
	b=lUt59TRmq5ziJ3073xYX9wiA4TFSM/ZhOPgrYk0AsvCsWywmkDXI0z4WBW3kG+F1+
	 HvaDFzide34pc785EoBqDTR7yKnwFaflywpcuvtyH8IDUiz2h/h/aGlDD0ELZ/aPza
	 kD3vRDp2Z3j/pJs1HDO9/JK/rU4ykQ/LTP12wqmk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230217112140eucas1p178afa3ad5cc3e92f3c09b7339c9cbe02~EmL1iJ-Jk2773627736eucas1p1N;
	Fri, 17 Feb 2023 11:21:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges3new.samsung.com (EUCPMTA) with SMTP id CE.D3.61197.4436FE36; Fri, 17
	Feb 2023 11:21:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230217112140eucas1p1703b82cfcdb933f07baa154183845986~EmL1J4ceV1036610366eucas1p1K;
	Fri, 17 Feb 2023 11:21:40 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230217112140eusmtrp233be37adf77008a1df1522ba82d13087~EmL1I0UfW2334023340eusmtrp2Y;
	Fri, 17 Feb 2023 11:21:40 +0000 (GMT)
X-AuditID: cbfec7f5-7c5ff7000000ef0d-b4-63ef6344fae1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 8F.8D.00518.3436FE36; Fri, 17
	Feb 2023 11:21:39 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230217112139eusmtip28c25a8baa540d8515329c27011c372ab~EmL0kK9yh1230512305eusmtip2H;
	Fri, 17 Feb 2023 11:21:39 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, lim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] iommu/exynos: Fix set_platform_dma_ops() callback
Date: Fri, 17 Feb 2023 12:21:29 +0100
Message-Id: <20230217112129.18879-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.39.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7ouye+TDZ4cFbV4MG8bm8XmiVvZ
	LH59sbCYOeMEo0Xn7A3sFntfb2W3mHF+H5PF2iN32S0OfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LSqk83jzrU9bB7zTgZ6vNg8k9Gjb8sqRo/Pm+Q8tn6+zRLAGcVlk5Kak1mWWqRvl8CV8Xx7
	G0vBJaGKa89XsTcwfubvYuTkkBAwkVjwbDV7FyMXh5DACkaJr0f3MkE4Xxgl1i+awwLhfGaU
	6Dv1gRWmZe/DVjaIxHJGidP/TiG0HNizjxGkik3AUKLrbRcbiC0iYCNx5dQSsA5mgT1MElte
	3mMHSQgLOElcnLmCCcRmEVCVeL3rFVicV8BWYuubiVDr5CUuHpnHDBEXlDg58wkLiM0MFG/e
	OpsZZKiEwAUOicbOmSwQDS4Sc/d0MEPYwhKvjm9hh7BlJP7vnM8E0dDOKLHg930oZwKjRMPz
	W4wQVdYSd879ArqVA2iFpsT6XfogpoSAo8TyeTwQJp/EjbeCEDfwSUzaNp0ZIswr0dEmBDFD
	TWLW8XVwWw9euAR1jYdEz81bYO8KCcRKdBxaxj6BUWEWks9mIflsFsIJCxiZVzGKp5YW56an
	FhvnpZbrFSfmFpfmpesl5+duYgSmq9P/jn/dwbji1Ue9Q4xMHIyHGCU4mJVEeDfdfJMsxJuS
	WFmVWpQfX1Sak1p8iFGag0VJnFfb9mSykEB6YklqdmpqQWoRTJaJg1OqganaL/ivfe3ilEWx
	wfPY90/3zV7yO4nRrv1w9iZVtZMh/MyZBhqZKSyfLzBLzL7SfnBD5HzDXPOS7BcXWcoSr06I
	K+tbXhKzeUrmWptsNeEcp12iz1vKvsnNO3dVMuDpvU7nxS4SHMtCD9xJSc5RvuElWfftaeQq
	yVLNyH7ty7G8vNfuzbcUdl/I/2zRNaW8ogReXi9DyU8x39XSJx/iY326Y6dwpOOVxRt57A9b
	7XTQZ9WrObvh2TGOqxsrV1Qk86pcn1F7M4T1dGK70VH27RvTm+e+lf6ywZJ10sHQswf6Z3w1
	P/uiSzNJ5U28cGPQnb64j7flmpdtOZAa/3fdr+v975PnG4vy6H2MuKzarcRSnJFoqMVcVJwI
	AOu6PUTGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4PV3n5PfJBuuOWVk8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8li7ZG77BYHPzxhtWi5Y+rA5fHk4DwmjzXz1jB6
	bFrVyeZx59oeNo95JwM9XmyeyejRt2UVo8fnTXIeWz/fZgngjNKzKcovLUlVyMgvLrFVija0
	MNIztLTQMzKx1DM0No+1MjJV0rezSUnNySxLLdK3S9DLeL69jaXgklDFteer2BsYP/N3MXJy
	SAiYSOx92MrWxcjFISSwlFHi3f3zzBAJGYmT0xpYIWxhiT/XuthAbCGBT4wSF89GgdhsAoYS
	XW8h4iICdhLXPi9mBhnELHCISeLlnnlgg4QFnCQuzlzBBGKzCKhKvN71ih3E5hWwldj6ZiLU
	AnmJi0cg6nkFBCVOznzCAmIzA8Wbt85mnsDINwtJahaS1AJGplWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiBUbLt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO+mm2+ShXhTEiurUovy44tKc1KL
	DzGaAt03kVlKNDkfGKd5JfGGZgamhiZmlgamlmbGSuK8ngUdiUIC6YklqdmpqQWpRTB9TByc
	Ug1M7hNyUt7+YGcPZqjKWNxq939pFMOt2CVNWjaCC04I1mmlLDvUHnt12aptmk/6nZ2ZZR8a
	C/z3OqrN9CZZV3bu5K/7vm7XsN67+1+x3uHlbRKcnGt8Ti2bVCPuzrfISpxFxVjkPYOS9o7r
	1VfPtGybxRgc07dsibPIxxRm66VTKq5eNas4pDz56hGjXb4brA2mKMnsTlgnFujwJb7f5rMJ
	B+/r9TMeOW6uVd9yb5pO+6ZLefeW+q3fFicSOVOquCYkfcqqmQJXgj5seh75+e+pd0WavtOa
	ijq3xvDsO8rsIvRbpkVPbZ9+r/XVBd9zdEo57+xnZT9golscPe/Oh8ks0hOKb5yZeUBi1S71
	R5/FlViKMxINtZiLihMBdekHghsDAAA=
X-CMS-MailID: 20230217112140eucas1p1703b82cfcdb933f07baa154183845986
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230217112140eucas1p1703b82cfcdb933f07baa154183845986
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230217112140eucas1p1703b82cfcdb933f07baa154183845986
References: <CGME20230217112140eucas1p1703b82cfcdb933f07baa154183845986@eucas1p1.samsung.com>

There are some subtle differences between release_device() and
set_platform_dma_ops() callbacks, so separate those two callbacks. Device
links should be removed only in release_device(), because they were
created in probe_device(). While fixing this, remove the conditional code
as it is not really needed.

Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
Fixes: 189d496b48b1 ("iommu/exynos: Add missing set_platform_dma_ops callback")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 483aaaeb6dae..4141625542ef 100644
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
@@ -1478,11 +1481,9 @@ static int exynos_iommu_of_xlate(struct device *dev,
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.device_group = generic_device_group,
-#ifdef CONFIG_ARM
-	.set_platform_dma_ops = exynos_iommu_release_device,
-#endif
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
+	.set_platform_dma_ops = exynos_iommu_set_platform_dma,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
 	.of_xlate = exynos_iommu_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
-- 
2.39.1

