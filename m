Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0B93E8342
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 10:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767867537; cv=none; b=b3pAVqmI0Jqj3Nw4Yr5Q2ucRMHKZMBkl6OZPWc7muKRfX8gdF8rrEqSQumr3JIfE2xoDvIxM0o1Xtu6LQh7yyNGXj7nAVp1lpWfPt67TMy9QJ+S3Er1044/R6pRcS+/Yv+k+jb/eZmpw3QeSEa8SC8oVKkfsfqll5hcwryK5tHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767867537; c=relaxed/simple;
	bh=Q7x+l+NLU1XB46+nbLRilHa4lbOaEi9kaMtr51ssDlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=YfLuP6ap/9zCd0UETdPLTRfShqVoaReDAk52srSFcDWTWcAQpONTdyayAxEa88vA5ndXRwi4JkgLA82rGXajuFD2z6ikxWcLUKrrZ4IeTET6k1kEc8lX5z+5ZXHhn7urzLmXBfhhmlYZ6PnCyl5C9pbvjCfiBIAex2TrWAi3lJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=nQmp2Wrb; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="nQmp2Wrb"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260108101851euoutp01503f12eadb64ed9fa0173bcbdadeee23~Iuicv_StD1283612836euoutp01I
	for <iommu@lists.linux.dev>; Thu,  8 Jan 2026 10:18:51 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260108101851euoutp01503f12eadb64ed9fa0173bcbdadeee23~Iuicv_StD1283612836euoutp01I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1767867531;
	bh=3UwJSe3uLNsXe7oucU7Oz3VGHOCgth1YIOuDVSktIXg=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=nQmp2WrbV4ULr/8qBrv746pACax3uPHDU9X6tLaO160mQGSaL4Wnku93hqIAQyP9W
	 s2RWXtpXSn+T0CPTl9sCyYJ/At55jonstCfyuVsHNWIy0jf1aCmtvKpi0OUMrWN3Kq
	 H6rOPwVFEmrju5Z9B51UED3sx8C1EPK9SZvnx/so=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260108101850eucas1p237319ba9ba1942bc5b8f1a8c2f427343~IuicWpP2_0461204612eucas1p2R;
	Thu,  8 Jan 2026 10:18:50 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260108101849eusmtip173c5a97caf04cb2265ba59602f5f78ca~IuibSpebr2509525095eusmtip1j;
	Thu,  8 Jan 2026 10:18:49 +0000 (GMT)
Message-ID: <75518c48-2d15-4087-bf26-dde223286af7@samsung.com>
Date: Thu, 8 Jan 2026 11:18:49 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Skip cache prep for HighMem coherent
 allocations
To: Arnd Bergmann <arnd@kernel.org>, "Aneesh Kumar K.V (Arm)"
	<aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>, Linus Walleij <linusw@kernel.org>,
	Matthew Wilcox <willy@infradead.org>, Suzuki K Poulose
	<suzuki.poulose@arm.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <984c3737-3934-49bc-908e-8d67facd68a6@app.fastmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260108101850eucas1p237319ba9ba1942bc5b8f1a8c2f427343
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260102155138eucas1p1563e460256561f6974079d3de733e895
X-EPHeader: CA
X-CMS-RootMailID: 20260102155138eucas1p1563e460256561f6974079d3de733e895
References: <CGME20260102155138eucas1p1563e460256561f6974079d3de733e895@eucas1p1.samsung.com>
	<20260102155118.2551804-1-aneesh.kumar@kernel.org>
	<94dae28d-82ae-4340-9abd-097e2d08fb9f@samsung.com>
	<984c3737-3934-49bc-908e-8d67facd68a6@app.fastmail.com>

On 08.01.2026 10:55, Arnd Bergmann wrote:
> On Thu, Jan 8, 2026, at 09:38, Marek Szyprowski wrote:
>> On 02.01.2026 16:51, Aneesh Kumar K.V (Arm) wrote:
>>> dma_direct_alloc() calls arch_dma_prep_coherent() to clean any dirty
>>> cache lines from the kernel linear alias before creating a coherent
>>> remapping.
>>>
>>> HighMem pages have no kernel alias mapping, so there are no alias cache
>>> lines to clean. Skip arch_dma_prep_coherent() for HighMem allocations.
>>>
>>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> Indeed this is an overhead to call prep for HighMem pages, but on the
>> other hand highmem support is being phased out according to
>> https://lwn.net/ml/all/20251219161559.556737-1-arnd@kernel.org/ Does it
>> make sense to apply this assuming that it will be removed soon?
> I think "soon" is overstating what the plan is. With my proposed
> series, the majority of current highmem users are changed to no
> longer use it by default, but there are still three ways in which
> users will get highmem for a number of years:
>
> - anything with more than 2GB RAM inevitably uses highmem for
>    the top portion of physical memory. These are much less common
>    than 2GB systems, but are not going away soon.
> - systems with sparse physical memory where the first and last page
>    are more than 2GB apart currently still rely on highmem even
>    if the total RAM is 2GB or less. This happens e.g. on Tegra114
>    or RZ-G1H, IIRC. I have plans to address this in the future.
> - Users that have applications using a lot of virtual memory
>    still have the option to go back to old configurations with
>    CONFIG_VMSPLIT_3G by selecting CONFIG_EXPERT.
>
> On the other hand, my proposed change does mean that we have more
> freedom to optimize for the non-highmem case. I think we can
> require that the CMA area is in lowmem, and we can make the use
> of highmem computationally more expensive if it helps simplify code.

Thanks for the summary, I will apply then this patch as a fix for v6.19-rc.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

