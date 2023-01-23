Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB69A4F
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 09:31:24 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230123093116euoutp01faf29f13b00456a69f51a8f47c3527dc~85jUFdtHc1295412954euoutp01k
	for <iommu@lists.linux.dev>; Mon, 23 Jan 2023 09:31:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230123093116euoutp01faf29f13b00456a69f51a8f47c3527dc~85jUFdtHc1295412954euoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1674466276;
	bh=4zV+eG9XbXpFrZW9hlNXTuBt/h9eAz60gaf5VjB/OIc=;
	h=From:To:Cc:Subject:Date:References:From;
	b=RbMFD4ta7/6KM5RljtQU/LHpVWr+l7rVbh+ZVc/MJXBp+AMAkQ+UdfxMhzI22IB8j
	 eyEb7aP5d8DvBvTGDMBM3e2t+y69ImII+3i7y6go9EeNkf0+ie+ExXKFYXFMfxQkHK
	 SgHwj3a8DMbAkl8RIgwS5vq8XvTSA7kax5VjNo3k=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230123093116eucas1p137e58e30a755dd783c46dc3c04a2fa08~85jTupqKz1918919189eucas1p1J;
	Mon, 23 Jan 2023 09:31:16 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id 4F.6A.13597.4E35EC36; Mon, 23
	Jan 2023 09:31:16 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9~85jTdo1NZ1918919189eucas1p1G;
	Mon, 23 Jan 2023 09:31:16 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20230123093116eusmtrp2bf3a9e709b94b7f3b795b39ce4b89d12~85jTc8l4O3141931419eusmtrp26;
	Mon, 23 Jan 2023 09:31:16 +0000 (GMT)
X-AuditID: cbfec7f4-1f1ff7000000351d-af-63ce53e4a0a5
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id 5C.06.00518.4E35EC36; Mon, 23
	Jan 2023 09:31:16 +0000 (GMT)
Received: from AMDC2765.digital.local (unknown [106.120.51.73]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230123093115eusmtip20321ffdb202fbd9a701979b1b180ce12~85jS3ke5U0807508075eusmtip2_;
	Mon, 23 Jan 2023 09:31:15 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, lim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH] iommu/exynos: add missing set_platform_dma_ops callback
Date: Mon, 23 Jan 2023 10:31:01 +0100
Message-Id: <20230123093102.12392-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.39.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djPc7pPgs8lG8z7JGnxYN42NovNE7ey
	Wfz6YmExc8YJRovO2RvYLfa+3spuMeP8PiaLtUfuslsc/PCE1aLljqkDl8eTg/OYPNbMW8Po
	sWlVJ5vHnWt72DzmnQz0eLF5JqNH35ZVjB6fN8l5bP18myWAM4rLJiU1J7MstUjfLoEr4+3U
	+UwF17gqvs4SaGDs4Oxi5OSQEDCRmNl0i6WLkYtDSGAFo0TTUxjnC6PE3ptPWSGcz4wSN7t7
	mWBalrw+wwaRWM4o0Xd9IULL8m/fGUGq2AQMJbredrGB2CICNhJXTi0B62AW2MMkseXlPXaQ
	hLCAh8TZA7/AxrIIqErMuf6fFcTmFbCVWDF1BTvEOnmJ1udboeKCEidnPmEBsZmB4s1bZzOD
	DJUQOMMhcWLRY0aIBheJaR+6WCFsYYlXx7dADZKR+L9zPhNEQzujxILf96GcCYwSDc9vQXVb
	S9w59wvoVg6gFZoS63fpQ4QdJfadbWEHCUsI8EnceCsIcQSfxKRt05khwrwSHW1CENVqErOO
	r4Nbe/DCJWYI20NiweQDYHEhgViJQ6ses05gVJiF5LVZSF6bhXDDAkbmVYziqaXFuempxUZ5
	qeV6xYm5xaV56XrJ+bmbGIHp6vS/4192MC5/9VHvECMTB+MhRgkOZiUR3jOLTycL8aYkVlal
	FuXHF5XmpBYfYpTmYFES59W2PZksJJCeWJKanZpakFoEk2Xi4JRqYGpZ9cfvWJ5+sel9lwCW
	V0rtF7RXXtP7cjv2acN8/R5R5ayPW5/P9PPnVP97vPCR1KFPZ71DivZJhImfCNyz9ne0uc79
	nf+C83UbSu8uje3xlMySljx5bc406auuhnzbFjql7jmhfyOi9P6Z+5uMdBeb60/r+XlUxO35
	dcagkxmpJ7IeSeasClys+9s5LeNiViP3Pcvs6FfLNXjsJs3XWBsgY3Lhb8HyG11/DL5/XFAZ
	vjnt1/UfvZmhiXMtGRMeequ2KdodcfsuOctNabFPS0VsyNtJp+wb1yRyrDu8Z7HWjTvZ6a01
	PSHOGxmealbrlfcmmqg/O9GQdu7txl/Ppmf9vcAs6Xj61OxJgk7d15RYijMSDbWYi4oTAdcH
	hLTGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupgkeLIzCtJLcpLzFFi42I5/e/4Pd0nweeSDa7O5bB4MG8bm8XmiVvZ
	LH59sbCYOeMEo0Xn7A3sFntfb2W3mHF+H5PF2iN32S0OfnjCatFyx9SBy+PJwXlMHmvmrWH0
	2LSqk83jzrU9bB7zTgZ6vNg8k9Gjb8sqRo/Pm+Q8tn6+zRLAGaVnU5RfWpKqkJFfXGKrFG1o
	YaRnaGmhZ2RiqWdobB5rZWSqpG9nk5Kak1mWWqRvl6CX8XbqfKaCa1wVX2cJNDB2cHYxcnJI
	CJhILHl9hq2LkYtDSGApo0Tz6mdsEAkZiZPTGlghbGGJP9e6oIo+MUqsP/GZGSTBJmAo0fW2
	C6xBRMBO4trnxcwgRcwCh5gkXu6ZB1YkLOAhcfbALyYQm0VAVWLO9f9gU3kFbCVWTF3BDrFB
	XqL1+VaouKDEyZlPWEBsZqB489bZzBMY+WYhSc1CklrAyLSKUSS1tDg3PbfYSK84Mbe4NC9d
	Lzk/dxMjMEq2Hfu5ZQfjylcf9Q4xMnEwHmKU4GBWEuE9s/h0shBvSmJlVWpRfnxRaU5q8SFG
	U6D7JjJLiSbnA+M0ryTe0MzA1NDEzNLA1NLMWEmc17OgI1FIID2xJDU7NbUgtQimj4mDU6qB
	qVjl/LFfrE8F/wv4rX5+QXxGl1X5+bS7xWlzH5k0PjeVk7zyXIjJ5HaYoUwQ4/3Gl74bN77/
	Izijwa/O+0G4bNnDlQ0vpxaXHa/n+sqbw2L4lrFAxTeLS+qYZ4OxhK1VirxpSXXvnduXtlwJ
	/ccptmq39+bNaTO86sQLJx6c8bTy3OfUVNZpO2cWF5k7O52bLb8uTuJ6YlNb3h3+OccF1vkv
	eKjpmWae6X3n8KlFUw8m7Wnf1jalzHP2FZclrr1vnv42D/Kq3JvE4/TIJ31DLV9IqO2y6/0v
	33094n61pvZT783DHGL1sSEe7zQutT45Kiu95NeKHVIhLc/P/LzX3v0ub87/wIuHq9Qbiies
	VGIpzkg01GIuKk4EAHhK0SobAwAA
X-CMS-MailID: 20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9
References: <CGME20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9@eucas1p1.samsung.com>

Add set_platform_dma_ops() required for proper driver operation on ARM
32bit arch after recent changes in the IOMMU framework (detach ops
removal).

Fixes: c1fe9119ee70 ("iommu: Add set_platform_dma_ops callbacks")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 drivers/iommu/exynos-iommu.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index 6fc58e89712f..c4955d045855 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1346,8 +1346,10 @@ static void exynos_iommu_release_device(struct device *dev)
 		struct iommu_group *group = iommu_group_get(dev);
 
 		if (group) {
+#ifndef CONFIG_ARM
 			WARN_ON(owner->domain !=
 				iommu_group_default_domain(group));
+#endif
 			exynos_iommu_detach_device(owner->domain, dev);
 			iommu_group_put(group);
 		}
@@ -1398,6 +1400,9 @@ static int exynos_iommu_of_xlate(struct device *dev,
 static const struct iommu_ops exynos_iommu_ops = {
 	.domain_alloc = exynos_iommu_domain_alloc,
 	.device_group = generic_device_group,
+#ifdef CONFIG_ARM
+	.set_platform_dma_ops = exynos_iommu_release_device,
+#endif
 	.probe_device = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-- 
2.39.0

