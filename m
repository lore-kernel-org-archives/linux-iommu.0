Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEED935DD1E
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769526487; cv=none; b=HRh17rHXqS3zTfgNH0Ugntq23HKYYOklkQNV3nwDojMCWJZ+2lVzLegpFGxGcG2DhY+OpCQ1Qv/Ojpm1PmRezv9AJOn6AvtN75WXMAsW27YqK/pLNtt4dp3iEqaeCHutluLEKujwIlkrcalBpk04p2fxjjRU5Eq214mdkGYRwsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769526487; c=relaxed/simple;
	bh=94qh2yrWr1/XvEHMK9avGIZyKXmNLY+efsaIfueKJO8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=OfR2rZHqL5eG/VLWlKCQuzk32tXKV1EiS1CHsaU3qtAthYkEUGWs5LnLd3tn3vo2+hSk6k749v17rWnWglt7yABVEBr/K1FgtdFoUx3Xb1j+SMKKjxP9aotrYo8rxCTHMncW9NQoahNnfnCfj+22LJ+WKyFLqh4nn/6XVpZ6WUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=Cou97s3W; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="Cou97s3W"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260127150802euoutp0131b72e8c6b685bd9d9506f327d63d486~OnvXwRWnp2925829258euoutp01V
	for <iommu@lists.linux.dev>; Tue, 27 Jan 2026 15:08:02 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260127150802euoutp0131b72e8c6b685bd9d9506f327d63d486~OnvXwRWnp2925829258euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1769526482;
	bh=bI7n7EMbVTLXkomvFX5EEgGQqwrIiq4zfj25LpKIMGc=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=Cou97s3WqBllpiKXMOmS6E6nyHX8cyRUsq+55z/ymrDXGb3vTEKta+8e89QekioTA
	 hTEyh28KTJ1noDj/M0ONRFNqgVHWLXgHkTH4fJY5Wm+oHflOHeujbfGYiUXK0hbH0O
	 7c6E9uFgQksYxE8gHL1gHsnKGGI2iNTxwrlD5b9E=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260127150802eucas1p15c9f15f01f36d46c5d109e71c41ebad7~OnvXOxVPF1522415224eucas1p1K;
	Tue, 27 Jan 2026 15:08:02 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260127150800eusmtip28d6317572cc161355f75102851645d8e~OnvV-5j8K0406604066eusmtip2u;
	Tue, 27 Jan 2026 15:08:00 +0000 (GMT)
Message-ID: <4df6023e-310b-4da7-95bd-f2952f40a873@samsung.com>
Date: Tue, 27 Jan 2026 16:08:00 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] of: reserved_mem: Allow reserved_mem framework detect
 "cma=" kernel param
To: Rob Herring <robh@kernel.org>, Oreoluwa Babatunde
	<oreoluwa.babatunde@oss.qualcomm.com>
Cc: ye.li@oss.nxp.com, kernel@oss.qualcomm.com, saravanak@google.com,
	akpm@linux-foundation.org, david@redhat.com, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org, surenb@google.com,
	mhocko@suse.com, robin.murphy@arm.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
	quic_c_gdjako@quicinc.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <CAL_JsqKWd2H0bV9Z8REMBYd2hPMTjDO1T4dYehM-QvemB9zrDg@mail.gmail.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20260127150802eucas1p15c9f15f01f36d46c5d109e71c41ebad7
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
X-EPHeader: CA
X-CMS-RootMailID: 20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395
References: <CGME20251210002053eucas1p1d1408ad0fb49a49bf4371687f8df7395@eucas1p1.samsung.com>
	<20251210002027.1171519-1-oreoluwa.babatunde@oss.qualcomm.com>
	<X-TH#1.CAL_JsqL6VVQ7K_ZAbHJ8Gb7ei_jusLx6wRn=AdOVgV50dX0ejQ@mail.gmail.com>
	<99dc91c9-59fd-47c5-b1d9-157bda86ad59@samsung.com>
	<CAL_JsqK5QEZfyRTDY4z88mX_eYENibea1ZM8H_bEfCCsOOwY4A@mail.gmail.com>
	<89f8895f-436d-4a73-a2c8-d61a2f4ee41a@samsung.com>
	<CAL_JsqKWd2H0bV9Z8REMBYd2hPMTjDO1T4dYehM-QvemB9zrDg@mail.gmail.com>

On 26.01.2026 17:33, Rob Herring wrote:
> On Mon, Jan 19, 2026 at 4:38 AM Marek Szyprowski
> <m.szyprowski@samsung.com> wrote:
>> On 18.12.2025 15:42, Rob Herring wrote:
>>> On Thu, Dec 18, 2025 at 3:55 AM Marek Szyprowski
>>> <m.szyprowski@samsung.com> wrote:
>>>> On 10.12.2025 15:07, Rob Herring wrote:
>>>>> On Tue, Dec 9, 2025 at 6:20 PM Oreoluwa Babatunde
>>>>> <oreoluwa.babatunde@oss.qualcomm.com> wrote:
>>>>>> When initializing the default cma region, the "cma=" kernel parameter
>>>>>> takes priority over a DT defined linux,cma-default region. Hence, give
>>>>>> the reserved_mem framework the ability to detect this so that the DT
>>>>>> defined cma region can skip initialization accordingly.
>>>>> Please explain here why this is a new problem. Presumably the
>>>>> RESERVEDMEM_OF_DECLARE hook after commit xxxx gets called before the
>>>>> early_param hook. And why is it now earlier?
>>>>>
>>>>> I don't really like the state/ordering having to be worried about in 2 places.
>>>> I also don't like this spaghetti, but it originates from
>>>> commit 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
>>>> memory regions are processed") and the first fixup for it: 2c223f7239f3
>>>> ("of: reserved_mem: Restructure call site for
>>>> dma_contiguous_early_fixup()").
>>> Honestly, this code wasn't great before. Every time it is touched it
>>> breaks someone.
>> Indeed it got a bit complicated and needs some improvement, but first I
>> want to fix the the reported regression. This patch does this and it
>> looks that there are no ideas how to fix this in a different way. Rob,
>> could I apply it via dma-mapping-fixes?
> Sigh, yes.
>
> Acked-by: Rob Herring (Arm) <robh@kernel.org>

Thanks! It's very late in this kernel rc cycle, but I will try to merge 
it to v6.19, as this issue is really a problem on some systems, see 
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=1116251

I've rebased this patch onto v6.19-rc1, fixed the build break reported 
by kernel test robot by adding a stub for 
cma_skip_dt_default_reserved_mem() if no CONFIG_DMA_CMA is set and added 
following fixes tags:

Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved 
memory regions are processed")
Fixes: 2c223f7239f3 ("of: reserved_mem: Restructure call site for 
dma_contiguous_early_fixup()")

With the above mentioned changes I've applied it to my 
dma-mappping-fixes branch. Let's give it a day or two in the linux-next 
for tests and, if nothing explodes, I will send it at the last minute 
for the merge.

I will try to untangle this spaghetti a bit and cleanup the code in the 
next release cycle.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

