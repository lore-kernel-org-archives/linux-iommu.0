Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9263220C03F
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 11:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508262; cv=none; b=hH1sH6xUo4+nLT9RC8tLFnNRjDStW03z1UqQhRkZrF1lQlQBSdIQIUy18wbMd2kvzsgKO0DtY7d41kqEF61LKxl1EmgIGeObp37kono3K05a1kGIMlvUExvmHNRyfYtTi00oWaVwk8tYhVleF2yxVfzENTC9HSDS1oOrvlDtxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508262; c=relaxed/simple;
	bh=qmdOynEegirXfs8lbmL3X7qVXIDYPMEWLa24p/5/Rs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=MFEB4QKJM3r3gxWkrXg5MxR5zABBWA0Wh8Pgliu/2kn5w4sgGfsv0nDRMGNuhrSAzd9bPQmy6kX4WBW3itDeBxMSOBc7G7dWLktnKTwRX1qEVWMeGsTt/hhv+xNeOPBiPjGlumG0L6wN8t2ri+SEsZtiwQOIpXIgbATB+5zng2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X79fHcie; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X79fHcie"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250110111805euoutp01c790b811975d80480f705bacd55ad897~ZULiloIoG2332023320euoutp01-
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 11:18:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250110111805euoutp01c790b811975d80480f705bacd55ad897~ZULiloIoG2332023320euoutp01-
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1736507885;
	bh=TgTYwp5m03s4FyCqPfd9OtpPPll4+/G1OU/rptcyx1o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X79fHcie3Zp6MHCo4GkQz36Z0+7eNRl5RXBfIxu6Bxo0u0ixcdka9wmamHeOjYhOK
	 VW0jk1+p5/dYhG3wZqGhcvyiKG2m2NX7XJUaVPvRqdG778zmfZP0OI8/4EFpAEgB+M
	 jB/CkExv3cZmjs38omjHn/Liotp7Y+OAJaxMTSFs=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTP id
	20250110111805eucas1p2a23b1fa9b68c2bdb074900074ccf41b6~ZULiUkxAE1888618886eucas1p2E;
	Fri, 10 Jan 2025 11:18:05 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
	eusmges2new.samsung.com (EUCPMTA) with SMTP id B4.6B.20409.CE101876; Fri, 10
	Jan 2025 11:18:04 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe~ZULiB54Ei2478724787eucas1p2b;
	Fri, 10 Jan 2025 11:18:04 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20250110111804eusmtrp16eae7fee2bfe61c230a77b26b47ad407~ZULiBOKCS3036930369eusmtrp1B;
	Fri, 10 Jan 2025 11:18:04 +0000 (GMT)
X-AuditID: cbfec7f4-c39fa70000004fb9-5f-678101ec8dbd
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id BE.A0.19920.CE101876; Fri, 10
	Jan 2025 11:18:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250110111804eusmtip1d83a3fad2d77bf925e14fa2c4157dd52~ZULhYE6kD3066730667eusmtip1A;
	Fri, 10 Jan 2025 11:18:03 +0000 (GMT)
Message-ID: <d07e82a4-2880-4ae3-961b-471bfa7ac6c4@samsung.com>
Date: Fri, 10 Jan 2025 12:18:02 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/arm-smmu-v3: Use str_read_write helper w/ logs
To: Pranjal Shrivastava <praan@google.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Cc: Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev, Daniel Mentz
	<danielmentz@google.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250107165100.1093357-1-praan@google.com>
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsWy7djP87pvGBvTDfr6zC0mdLQyWfz6YmHR
	OXsDu8Wea8eYLQ5+eMJqMXP/e0aLljumDuweTw7OY/JYM28No8eCTaUem1Z1snm82DyTMYA1
	issmJTUnsyy1SN8ugSuje/lb5oJW/op/x96wNzDe5Oli5OSQEDCRePjiC2MXIxeHkMAKRon/
	T/tZIZwvjBKrpi6DynxmlNjzdCErTMuWk9+YIBLLGSUubPjLAuF8ZJT4c6SFGaSKV8BOYsP8
	FewgNouAqsTFjodQcUGJkzOfsIDYogLyEvdvzQCrERbwlGj5sYYNZJCIwARGiS1/97CBJJgF
	0iWu7j3OAmGLS9x6Mp8JxGYTMJToetsFVsMpYCEx9dAGqBp5ieats5lBBkkIPOCQ+Lx9OQvE
	3S4S2/Z/ZYSwhSVeHd/CDmHLSJye3MMC0dDOKLHg930mCAfojIbnt6A6rCXunPsFtI4DaIWm
	xPpd+hBhR4neT89ZQcISAnwSN94KQhzBJzFp23RmiDCvREebEES1msSs4+vg1h68cIl5AqPS
	LKRwmYXkzVlI3pmFsHcBI8sqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwCR0+t/xLzsY
	l7/6qHeIkYmD8RCjBAezkgivpWxtuhBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFe1RT5VCGB9MSS
	1OzU1ILUIpgsEwenVANTluGRxZb7zn2c8n/XkryNHPeuPS7in7qq+3biNVuny2zOjkvE7k7Z
	v2NT2NtvWe9eB/2c7+An5dG14TRvXY7UoTP6cwLynujNPtVqmszJpF5ecS130Zv70y2qNi6T
	jtRTfFBRcWX1DYmHiiJzn0/giNs/496Lf3qJN3PfFuWVRl3bbSpSIPog82/59Jj698skNU6s
	LORZq7krRFMqS/fL2hX8779OtHq6ZzKrSAm7/cT5fqwbUutPLD31MNFU6NCEJ3rGcrYSwmm5
	8TH5h+SufTqtmMr6glttWTzn3tLu6PgTZ5oNdD14c3w19rz+zmKhGruknMfVc33V0gSzRyHq
	QZmeuqk5mmY2DrtNVh9TYinOSDTUYi4qTgQA+6q9rLEDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHIsWRmVeSWpSXmKPExsVy+t/xu7pvGBvTDR6tUrOY0NHKZPHri4VF
	5+wN7BZ7rh1jtjj44Qmrxcz97xktWu6YOrB7PDk4j8ljzbw1jB4LNpV6bFrVyebxYvNMxgDW
	KD2bovzSklSFjPziElulaEMLIz1DSws9IxNLPUNj81grI1MlfTublNSczLLUIn27BL2M7uVv
	mQta+Sv+HXvD3sB4k6eLkZNDQsBEYsvJb0xdjFwcQgJLGSWe/5vGBJGQkTg5rYEVwhaW+HOt
	iw2i6D2jxLEJO9hAErwCdhIb5q9gB7FZBFQlLnY8ZIaIC0qcnPmEBcQWFZCXuH9rBliNsICn
	RMuPNWCDRAQmMEpsnXKMsYuRg4NZIF1i8rYakBohAXOJuRNugdUzC4hL3HoyH+wgNgFDia63
	XWB7OQUsJKYe2sACUWMm0bW1ixHClpdo3jqbeQKj0CwkZ8xCMmoWkpZZSFoWMLKsYhRJLS3O
	Tc8tNtQrTswtLs1L10vOz93ECIy4bcd+bt7BOO/VR71DjEwcjIcYJTiYlUR4LWVr04V4UxIr
	q1KL8uOLSnNSiw8xmgLDYiKzlGhyPjDm80riDc0MTA1NzCwNTC3NjJXEed0un08TEkhPLEnN
	Tk0tSC2C6WPi4JRqYNofJLLHds2upIeVSyMmvNL4wam/VKH+kV+0z4LenM9RAhNqYopFPO7f
	Uu0zmVEUFVZj2eFqKHesPDRil5yl+mfvHVd483wiX85Se+Si6KkfeTSi9E2L5YxtM3J+v7/F
	yrv5+hcj6aXHTSV/90Qa/Ts38Xb0vAaB7Rs0bpeXTSneve/+qsKkkBXa1wODly1dEPBBZvae
	J05Z1/49TZt+g7GXKWfmWdnis1uSz95iedHkY84Za5P2On2xaKqy6K0zOy+fvBp5c7XVk1MP
	A712hEQnKcRUq/7IDX9x7/7HSYouB0I3S92Timk/wL/w0E2Vj780e2pCszfunbx6dc8JS+8H
	vN8OpYmq8O6Ztlwy5qcSS3FGoqEWc1FxIgC/AA/FQQMAAA==
X-CMS-MailID: 20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe
References: <20250107165100.1093357-1-praan@google.com>
	<CGME20250110111804eucas1p2a5fa56e1a9fabbba5dacd4486517c9fe@eucas1p2.samsung.com>

On 07.01.2025 17:51, Pranjal Shrivastava wrote:
> Adopt the `str_read_write` helper in event logging as highlighted [1].
>
> [1] https://lore.kernel.org/all/20250107130053.GC6991@willie-the-truck/
>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>

This change landed in today's linux-next as commit f2c77f6e41e6 
("iommu/arm-smmu-v3: Use str_read_write helper w/ logs"). It fails to 
build here with arm64/defconfig on my setup. It looks that it misses to 
add the following include:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c 
b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 0e4cbb2c64d7..a0e395da8a88 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,6 +26,7 @@
  #include <linux/pci.h>
  #include <linux/pci-ats.h>
  #include <linux/platform_device.h>
+#include <linux/string_choices.h>
  #include <kunit/visibility.h>
  #include <uapi/linux/iommufd.h>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 34b424c87be0..0e4cbb2c64d7 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1907,7 +1907,7 @@ static void arm_smmu_dump_event(struct arm_smmu_device *smmu, u64 *raw,
>   		dev_err(smmu->dev, "%s %s %s %s \"%s\"%s%s stag: %#x",
>   			evt->privileged ? "priv" : "unpriv",
>   			evt->instruction ? "inst" : "data",
> -			evt->read ? "read" : "write",
> +			str_read_write(evt->read),
>   			evt->s2 ? "s2" : "s1", event_class_str[evt->class],
>   			evt->class_tt ? (evt->ttrnw ? " ttd_read" : " ttd_write") : "",
>   			evt->stall ? " stall" : "", evt->stag);

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

