Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC1821ABAC
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760117076; cv=none; b=oFy4nm2OUIMuv2W3Ks/6gQYpwm5r2ORo/sGGu6JV5HjJqDDONf50mONt6C7qqZnJnBS461KCYOFT/WECgWcSp8qGC2V3HNTQ9ENDWyiS52fn0WERrKRt+A3VCvosDva5QeYHTVBdHf2I0ir8VrPELYu1fv1R4Uysk0HDvwE/h5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760117076; c=relaxed/simple;
	bh=5hiZIrWLL0dsWutE1BeXFfmcVtDxybMWLs8vsm2o+dY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=Db+u+WKGimLE64iaXWuLP5Nv6BhZYnAgJ1vECHk3g/64RmwdI0cSFBgslxEF0AOrh3MbIUroPpINpBPn6cbRVd3NqKZVUnidS5qA1a06uiS6qi5UCu1A7qg+m7K/Hu07Om1R1ptoyW/3SH3Y/dXEPeceYt+OJkhWWsaRd6GL/i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=cG7VsJL1; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="cG7VsJL1"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20251010172425euoutp01e5203edbc4d049e6789bcaf3e92dac84~tMSUrpPQC1680316803euoutp01z
	for <iommu@lists.linux.dev>; Fri, 10 Oct 2025 17:24:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20251010172425euoutp01e5203edbc4d049e6789bcaf3e92dac84~tMSUrpPQC1680316803euoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1760117065;
	bh=QXEP0g6tg/h/jFfO58lrELlWh5ONcV16srL2AqNzFmo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=cG7VsJL1TTN1MfZNT63iuc2hb5bfDdiKemrWb4DlT84pcSlXQZlUKf/cINGHNxGHo
	 VXAC0g0Hl/z86ubAgX+8JsS68WaYE2BM3b+WX/AGQcxzf9d6IDrIqcxXmdjnpmQqwZ
	 Qm8kaBSMcAdPvlcNLvu5VfepiZ5iRhzuhi7loAr0=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20251010172424eucas1p1aa27ffbc4632902061b09b167d064da3~tMSTrLJrO0295602956eucas1p1y;
	Fri, 10 Oct 2025 17:24:24 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20251010172423eusmtip2790c7cef85f1b547b63fa7e804dcb4bf~tMSTTWH241080710807eusmtip2I;
	Fri, 10 Oct 2025 17:24:23 +0000 (GMT)
Message-ID: <78ad60af-aa9e-4909-95fb-d4441fd944b4@samsung.com>
Date: Fri, 10 Oct 2025 19:24:23 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-debug: don't report false positives with
 DMA_BOUNCE_UNALIGNED_KMALLOC
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org, Robin Murphy
	<robin.murphy@arm.com>, Christoph Hellwig <hch@lst.de>, Andrew Morton
	<akpm@linux-foundation.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <aOjipm1vCJpgQQq1@arm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20251010172424eucas1p1aa27ffbc4632902061b09b167d064da3
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f
X-EPHeader: CA
X-CMS-RootMailID: 20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f
References: <CGME20251009141522eucas1p2c89eadd93fb571c557d3d70975d8ae4f@eucas1p2.samsung.com>
	<20251009141508.2342138-1-m.szyprowski@samsung.com>
	<aOjipm1vCJpgQQq1@arm.com>

On 10.10.2025 12:40, Catalin Marinas wrote:
> On Thu, Oct 09, 2025 at 04:15:08PM +0200, Marek Szyprowski wrote:
>> @@ -594,7 +595,9 @@ static void add_dma_entry(struct dma_debug_entry *entry, unsigned long attrs)
>>   	if (rc == -ENOMEM) {
>>   		pr_err_once("cacheline tracking ENOMEM, dma-debug disabled\n");
>>   		global_disable = true;
>> -	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC)) {
>> +	} else if (rc == -EEXIST && !(attrs & DMA_ATTR_SKIP_CPU_SYNC) &&
>> +		   !(IS_ENABLED(CONFIG_DMA_BOUNCE_UNALIGNED_KMALLOC) &&
>> +		     is_swiotlb_allocated())) {
> Maybe use is_swiotlb_active(entry->dev) instead for completeness. Either
> way:
>
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Thanks for suggestion. is_swiotlb_active() looks a bit more appropriate 
in this context.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

