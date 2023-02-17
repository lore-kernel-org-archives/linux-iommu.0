Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F797366
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:15:27 +0000 (UTC)
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20230217110844euoutp013444dc6ac1b1fce5001a2e471bad7e2a~EmAilstdV0855708557euoutp012
	for <iommu@lists.linux.dev>; Fri, 17 Feb 2023 11:08:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20230217110844euoutp013444dc6ac1b1fce5001a2e471bad7e2a~EmAilstdV0855708557euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1676632124;
	bh=eY032ATuAoekwnhCtFqCapCOk9QK3pGL35sFLTaXXvw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=bAYWkMgxjMFkGEBrbSaDc+snlDjEktpzYfFLONDWn+5/V/Ak7afw1v5LlHt6tbBK2
	 8wt8SNDgqd7kAabc669a9nqva0nUARjDpHIPr4DUSYcQADmSKzBPY9EI2mkY8qpTjI
	 AROqhCUcPgPp/uriFHDuqEx1W4tf3D0UHogk/q8k=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20230217110843eucas1p12101ccec47107e78ad17b05c032b7241~EmAh8QiY82006820068eucas1p1H;
	Fri, 17 Feb 2023 11:08:43 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id A2.19.01471.B306FE36; Fri, 17
	Feb 2023 11:08:43 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20230217110843eucas1p100af763cda97e4ad1b80cbc06b4f668b~EmAhiZXev2006020060eucas1p1W;
	Fri, 17 Feb 2023 11:08:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
	eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20230217110843eusmtrp1fd688f43829e273516d6e88b5c0b6c44~EmAhhop050504905049eusmtrp1s;
	Fri, 17 Feb 2023 11:08:43 +0000 (GMT)
X-AuditID: cbfec7f2-2b1ff700000105bf-9b-63ef603bc2b1
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms1.samsung.com (EUCPMTA) with SMTP id 66.B8.02722.A306FE36; Fri, 17
	Feb 2023 11:08:42 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20230217110842eusmtip24a4fe4fe7c9d779644aa316fdbf533f3~EmAhAuCeI3253432534eusmtip23;
	Fri, 17 Feb 2023 11:08:42 +0000 (GMT)
Message-ID: <e7aa3a5d-c8f9-ad7d-4c5c-08756c1ab2d3@samsung.com>
Date: Fri, 17 Feb 2023 12:08:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0)
	Gecko/20100101 Thunderbird/102.7.2
Subject: Re: [PATCH] iommu/exynos: add missing set_platform_dma_ops callback
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org, Joerg Roedel
	<joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, lim Akhtar <alim.akhtar@samsung.com>, Lu
	Baolu <baolu.lu@linux.intel.com>
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <Y871a3elCP1gmPQi@ziepe.ca>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFKsWRmVeSWpSXmKPExsWy7djPc7rWCe+TDVY0i1k8mLeNzWLzxK1s
	Fr++WFjMnHGC0aJz9gZ2i72vt7JbzDi/j8ni4IcnrBYtd0wdOD2eHJzH5LFm3hpGj02rOtk8
	7lzbw+Yx72Sgx4vNMxk9+rasYvT4vEnOY+vn2ywBnFFcNimpOZllqUX6dglcGYcOnWAvuClU
	8Xb7IuYGxjn8XYycHBICJhJ7/51k7WLk4hASWMEo0dD4khnC+cIocfLJHBaQKiGBz4wSzcsZ
	YTo+XLzMBFG0nFHi7oI57BDOR0aJrlvNTCBVvAJ2El86F4F1sAioSrz9N5UdIi4ocXLmE7Cp
	ogIpEqdX72EDsYUFfCReXv4A1sssIC5x68l8MFtEQEli366JYAuYBVYySTy93MgKkmATMJTo
	etsF1swpoCFx++s+ZohmeYntb+eA/SAh0M4p8eX0CTaIu10kVvUdYoewhSVeHd8CZctInJ7c
	wwLVwCix4Pd9JghnAjA4nt+C+tpa4s65X0CTOIBWaEqs36UPEXaU2He2hR0kLCHAJ3HjrSDE
	EXwSk7ZNZ4YI80p0tAlBVKtJzDq+Dm7twQuXmCcwKs1CCpdZSP6fheSdWQh7FzCyrGIUTy0t
	zk1PLTbMSy3XK07MLS7NS9dLzs/dxAhMXqf/Hf+0g3Huq496hxiZOBgPMUpwMCuJ8G66+SZZ
	iDclsbIqtSg/vqg0J7X4EKM0B4uSOK+27clkIYH0xJLU7NTUgtQimCwTB6dUA1O2dVXY/A8F
	nB4R5+eldsSfiziVf/359x/rLfKO6X1doyVZrz/N6/P0KRrMeXd5b0k0nH+wJnmz7rwHH1zk
	HrDsuif0pmtRskhDRdjdpVd78/T+BvFdKt+n92KDYxnTaSnTjvk3WpM4qxgLpFTK90xazZnz
	+n5aYbf0IsG+5LtndtSvmm7G4c3z5nzANYZgdgXz524njKTjorfHXw+I4Vv/0nkpV2Xhtcob
	Fz+/vbv5euG/jJmti19oh2h+avARnbDzn2PB6pSu03WzLVeY2Xy/p7xQYsXlQzvb7LOlbi7b
	Fqx45ZphbRqfgTVbcNyStK3ZK6ZNPHAuZvWGNhWhy5kZtUdbU9hPTPCJkrl/wl2JpTgj0VCL
	uag4EQBwya0IzQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLIsWRmVeSWpSXmKPExsVy+t/xe7pWCe+TDf6vs7F4MG8bm8XmiVvZ
	LH59sbCYOeMEo0Xn7A3sFntfb2W3mHF+H5PFwQ9PWC1a7pg6cHo8OTiPyWPNvDWMHptWdbJ5
	3Lm2h81j3slAjxebZzJ69G1ZxejxeZOcx9bPt1kCOKP0bIryS0tSFTLyi0tslaINLYz0DC0t
	9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0Mg4dOsFecFOo4u32RcwNjHP4uxg5OSQETCQ+
	XLzM1MXIxSEksJRR4tTKaWwQCRmJk9MaWCFsYYk/17rYIIreM0r8WPWEBSTBK2An8aVzESOI
	zSKgKvH231R2iLigxMmZEDWiAikSn+/NBYsLC/hIvLz8gQnEZhYQl7j1ZD6YLSKgJLFv10R2
	kAXMAiuZJNombmGH2LaWUeLR0mVgJ7EJGEp0ve0CszkFNCRuf93HDDHJTKJraxcjhC0vsf3t
	HOYJjEKzkBwyC8nCWUhaZiFpWcDIsopRJLW0ODc9t9hQrzgxt7g0L10vOT93EyMwXrcd+7l5
	B+O8Vx/1DjEycTAeYpTgYFYS4d10802yEG9KYmVValF+fFFpTmrxIUZTYGhMZJYSTc4HJoy8
	knhDMwNTQxMzSwNTSzNjJXFez4KORCGB9MSS1OzU1ILUIpg+Jg5OqQYmT5nF+kJrTh5pvFTO
	cnyj0uaAXxKv59y7xpanl/nHJ9T5wnYG/WqT2+sMJ16cYlWi22Se/HGf67Xq6RNvVBf3TA0r
	f6DjGC916PRapjSJyxeqi3Y0bVHbvVNJk99dYcmOvXlTvzpyTj1zJeLj0pVpO1ROJMvM/MrB
	z3fu5gr2YGmn84+aWZWXBE28N/W1ytTYFx1XHB/IbmqYLHiGZ9rJlR3aEn2fGf8pxvSV9T9q
	K7DYNknCQMxf67pxbMlMnhPTLUsChfoslvJFqjzf6MZxlZXt4r0t+77339o93cPQ/wnXY/Ur
	Re+PdoXWO7q3HXL5M3fW+qsBapN/mWjcWH5AMPKntGH9JvE/2tZLlqvZK7EUZyQaajEXFScC
	AJXMicdgAwAA
X-CMS-MailID: 20230217110843eucas1p100af763cda97e4ad1b80cbc06b4f668b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9
References: <CGME20230123093116eucas1p19b8fe8afc4b631debbdc5321c53009e9@eucas1p1.samsung.com>
	<20230123093102.12392-1-m.szyprowski@samsung.com>
	<Y871a3elCP1gmPQi@ziepe.ca>

Hi,

I'm sorry for a delay in replying, but I was busy with other stuff.

On 23.01.2023 22:00, Jason Gunthorpe wrote:
> On Mon, Jan 23, 2023 at 10:31:01AM +0100, Marek Szyprowski wrote:
>> Add set_platform_dma_ops() required for proper driver operation on ARM
>> 32bit arch after recent changes in the IOMMU framework (detach ops
>> removal).
> Thanks for looking into this!
>
> Can you explain more about how this actually solves the problem in the
> commit message? I don't get it.

Exynos DRM driver calls arm_iommu_detach_device(), then 
arm_iommu_attach_device() with a difrent 'mapping', see 
drivers/gpu/drm/exynos/exynos_drm_dma.c Lack of set_platform_dma_ops 
leads to a warning in iommu_group_do_set_platform_dma(). The other case 
of calling arm_iommu_detach_device() is after unsuccessful probe of the 
platform device.


>> diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
>> index 6fc58e89712f..c4955d045855 100644
>> --- a/drivers/iommu/exynos-iommu.c
>> +++ b/drivers/iommu/exynos-iommu.c
>> @@ -1346,8 +1346,10 @@ static void exynos_iommu_release_device(struct device *dev)
>>   		struct iommu_group *group = iommu_group_get(dev);
>>   
>>   		if (group) {
>> +#ifndef CONFIG_ARM
>>   			WARN_ON(owner->domain !=
>>   				iommu_group_default_domain(group));
>> +#endif
>>   			exynos_iommu_detach_device(owner->domain, dev);
>>   			iommu_group_put(group);
>>   		}
>> @@ -1398,6 +1400,9 @@ static int exynos_iommu_of_xlate(struct device *dev,
>>   static const struct iommu_ops exynos_iommu_ops = {
>>   	.domain_alloc = exynos_iommu_domain_alloc,
>>   	.device_group = generic_device_group,
>> +#ifdef CONFIG_ARM
>> +	.set_platform_dma_ops = exynos_iommu_release_device,
>> +#endif
> This is ugly, if you need a set_platform_dma_ops it should not be
> called release... Release is supposed to be about putting the HW back
> to some idle state because we are unplugging the struct device.

Indeed this patch was a bit ugly, I've did it in a bit of hurry. That 
time I've simply checked how it is implemented in other drivers and 
found that it very similar to the release operation, so I did it in 
exynos-iommu that way. I've checked again and indeed there are some 
differences, so I will send a fix in a few minutes.


Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

