Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33B12C08D5
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 07:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764575484; cv=none; b=aH259rgQ7Hlkh8iKMSuNrXDvtT6AldD4yJSS3+JUYIfyohFvtofqULwGWdW3COhxzOiZjzJEt8GxyotB53c6s9XeV19Qw0+Ou9uV36mT3nMdlIR0FQNmPavBlOwkRx5Wm9Qhgyk6VZrTKo3qYUin3LWDOqehVjBlt6dAqYkpDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764575484; c=relaxed/simple;
	bh=/ZJ2ugv0V4jr8DpprkrfoRhMoitKaURZS/txd0wECwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=JIS2HheOdIGo/5pt2IO9YaaXhBVP2zrmRKCIz+R/qRMitEjf+D1zVe2gToFrRyjO2e5ATOt0YU5Iicyn+AylcrMkNCKKhPo3SxzFbfIq7QnQyKe1eTq0v8U+6XofjKtmFlIMMUr4aCUuUk7gN1VGvYdEJQc2pFCN5cHvKquruGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=OnVfzf5I; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="OnVfzf5I"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251201075118euoutp01ff8adbfddfd71273e54b858409ee6feb~9CAyFamUW1901219012euoutp01g
	for <iommu@lists.linux.dev>; Mon,  1 Dec 2025 07:51:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251201075118euoutp01ff8adbfddfd71273e54b858409ee6feb~9CAyFamUW1901219012euoutp01g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1764575478;
	bh=Gff9kc5iCvetWdJWK5B5jhJfee8ZUuI2y3EEzh79HdA=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=OnVfzf5INngnqM6yF7UZgnhv6TS5jliieo+iwMG4xq1b1UTSZSDhTKM3malvYoEYr
	 0USjD58uLHEWYvCjOCg/N1YdHFbQ4ryBS4fT7DWQ2AWEMHC2IP+5g5aMocMKVzughm
	 S0wEj3Lzgp6CEo3iuBxK6flduspMhjOqzqxZlYxI=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251201075118eucas1p1b321d3225172a3cf78b20c4d4f988cda~9CAxy9yly1849318493eucas1p1s;
	Mon,  1 Dec 2025 07:51:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251201075117eusmtip203c1b003ae05cf23f36aefe48df73016~9CAw40JxZ0920209202eusmtip2J;
	Mon,  1 Dec 2025 07:51:17 +0000 (GMT)
Message-ID: <be70bdc4-bddd-4afe-8574-7e0889fd381c@samsung.com>
Date: Mon, 1 Dec 2025 08:51:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v4] of: reserved_mem: Restructure call site for
 dma_contiguous_early_fixup()
To: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>, Ye Li
	<ye.li@oss.nxp.com>, robh@kernel.org, robin.murphy@arm.com
Cc: saravanak@google.com, quic_obabatun@quicinc.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, william.zhang@broadcom.com, kernel@oss.qualcomm.com,
	will@kernel.org, djakov@kernel.org, aisheng.dong@nxp.com, joy.zou@nxp.com,
	frank.li@nxp.com, jason.hui.liu@nxp.com
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <306596c4-cc91-4500-b705-50e619e9f38e@oss.qualcomm.com>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20251201075118eucas1p1b321d3225172a3cf78b20c4d4f988cda
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
X-EPHeader: CA
X-CMS-RootMailID: 20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf
References: <CGME20250806172503eucas1p264d6731c73592fcc380b0dcc21cdeadf@eucas1p2.samsung.com>
	<20250806172421.2748302-1-oreoluwa.babatunde@oss.qualcomm.com>
	<416dbaed-a68f-4edb-a20c-94cb4c53c748@samsung.com>
	<cef8f9eb-88aa-4771-b25b-2cfd1ac2c387@oss.nxp.com>
	<3b0cc36d-0f7e-4d07-949f-fce670170247@samsung.com>
	<306596c4-cc91-4500-b705-50e619e9f38e@oss.qualcomm.com>

On 01.12.2025 07:31, Oreoluwa Babatunde wrote:
> On 11/28/2025 4:43 AM, Marek Szyprowski wrote:
>> On 26.11.2025 02:37, Ye Li wrote:
>>> On 8/11/2025 7:07 PM, Marek Szyprowski wrote:
>>>> On 06.08.2025 19:24, Oreoluwa Babatunde wrote:
>>>>> Restructure the call site for dma_contiguous_early_fixup() to
>>>>> where the reserved_mem nodes are being parsed from the DT so that
>>>>> dma_mmu_remap[] is populated before dma_contiguous_remap() is called.
>>>>>
>>>>> Fixes: 8a6e02d0c00e ("of: reserved_mem: Restructure how the reserved
>>>>> memory regions are processed")
>>>>> Signed-off-by: Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>
>>>>> Tested-by: William Zhang <william.zhang@broadcom.com>
>>>> Thanks, applied to dma-mapping-fixes branch.
>>>>
>>>> Best regards
>>> Hi Oreoluwa,
>>>
>>> We observed this patch causing kernel boot hang on iMX6 (armv7)
>>> platforms if using "cma=" kernel parameter. It only happens when the
>>> size assigned in
>>> "cma=" parameter is smaller than cma default size in dts.
>>>
>>> For example, we use "cma=96M" in command line and below reserved
>>> memory node (160M) in dts.
>>>
>>>          reserved-memory {
>>>                  #address-cells = <1>;
>>>                  #size-cells = <1>;
>>>                  ranges;
>>>
>>>                  linux,cma {
>>>                          compatible = "shared-dma-pool";
>>>                          reusable;
>>>                          size = <0xa000000>;
>>>                          linux,cma-default;
>>>                  };
>>>          };
>>>
>>> The root cause is this patch moving the dma_contiguous_early_fixup
>>> from rmem_cma_setup to __reserved_mem_alloc_size. rmem_cma_setup can
>>> skip the cma reserved memory if command line has cma parameter.
>>> However, the __reserved_mem_alloc_size won't do it. So this leads to
>>> have two cma regions added to dma_mmu_remap, one from dts, the other
>>> from command line. But the reserved memory of memblock that only
>>> records the cma from command line is inconsistent with dma_mmu_remap.
>>> The dma_contiguous_remap clears the MMU paging for the region of
>>> dma_mmu_remap firstly, then create a new mapping by iotable_init. For
>>> the cma from dts, this causes incorrect memory mapping cleared. Then
>>> any allocation from memblock in iotable_init hitting to the area will
>>> meet MMU mapping issue.
>>>
> Hi Ye Li,
>
> Thanks for pointing this out. From what I see in the code, if "cma="
> kernel parameter is being used to configure the default cma region, then we
> should skip adding the DT defined region to dma_mmu_remap array.
>
> I will work on a fix which does this and share here when it is done.

I wonder how to avoid adding more such checks to 
drivers/of/of_reserved_mem.c and making this code even more tangled and 
spaghetti-like... I've briefly scanned that code and it is already quite 
hard to follow, especially after commits 8a6e02d0c00e ("of: 
reserved_mem: Restructure how the reserved memory regions are 
processed") and 2c223f7239f3 ("of: reserved_mem: Restructure call site 
for dma_contiguous_early_fixup()")... I wonder how many reserved memory 
regions are used on real machines? Maybe instead of complicating this 
code even more it is enough to make this configurable via Kconfig and 
restore pre-8a6e02d0c00e version?

>>>  From commit, I don't understand what issue does this patch fix. Can
>>> you look into the regression and provide a fix patch.
> Please see below conversation for details on the original issue this patch fixes:
> https://lore.kernel.org/all/5aa94f41-c689-443b-8665-c6913ff5ba8f@broadcom.com/

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

