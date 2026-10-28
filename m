Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793178022;
	b=KzjXopbQOsHYDBFVIn3vm9UoYbiRP8F2NniA2XmQMZ5CAABE+FSQfasPyAm0W07P7JDt
	 pIm6CLG1VVyj0hUbjxSfy4I0q8wHk2sD9lktiNsTM/HZ9Tt+PmVUsxOUSq4QlOnR1nsZ9
	 UhHz/FEghYjX/M05T9EbL4ikUafUyo40wyP8kXOU5JFbvf49V2mBpurHuqMm1F1zPfDMn
	 9t1RjL8PnsQZq4M1PrFWhj5jVM4wvHDvLfyQybYTlVhR9stwkTuwYy1c4cgGGxpS/NJ3R
	 WJAH/lqbg5e4lGlY15h9n8qmx+tl99J3HXEuPqWbxPoaHFd2x8UwjDdP381BIACLrrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178022;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=xUBEanmvLsCZxxqUO2LYzZZsXYxTAXtc6G9d2RVDe+U=;
	b=NvuCPWefTypMArnH3DVh+EkZXgrndaMIhAhkJtgt0dXqBdFwmg/ewX0JV/+MbDur4++v
	 mgUZWoIdXtz3mtAOL1xvhnatnx7TXohd0QxqodV8uFkL7pWn2y0fHBBazy1bZqUSDHcUz
	 eCgsW0P3L57L/bF/5p8JYcml4ooFLxyQv9U67nAkrbHzdfyb9XWkOg8MdWfPJJo63Fp1I
	 csSZya0l2CAl7dcy+SigbdT7pp6B3v4AbsnobVlhJcunwIkS1VbGSSpYCfoIXetX2Xaq5
	 5JDLDGXiOZWRBPdjLj9vh8yEaYuweoOwBVcJXNsLMgEi/bc7YvLn3GYezzTueJyDgQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9024606A321
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 09:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B9024606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261028090018euoutp026b6ff5a0b52b3057a8e40c94dc96aa27~ipehSrB310704307043euoutp02v
	for <iommu@lists.linux.dev>; Wed, 28 Oct 2026 09:00:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261028090018euoutp026b6ff5a0b52b3057a8e40c94dc96aa27~ipehSrB310704307043euoutp02v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793178018;
	bh=xUBEanmvLsCZxxqUO2LYzZZsXYxTAXtc6G9d2RVDe+U=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=mzpaW7yGaRCdXqKaTA1qvXLqu4Xw8BKIQDLVrdhAhFz8ReuZou/P5pdaoQF3TL9yu
	 KN3u+EPM+QtO9tMn0AgYP6pv7Rta/Y+nN2UcLy4qa4JZGZktt1loKIEuIitgsDTTBL
	 TmqyWOMiaTpynzc42sP/gJjwK6XEtQ2I4fovLT68=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20261028090018eucas1p16fdcb990968a1f4c11cbe93025e277cb~ipegsB_XM0067300673eucas1p1M;
	Wed, 28 Oct 2026 09:00:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261028090017eusmtip2383ec7d9f2b2324bf327f2384e5b0c6c~ipefzOang2938429384eusmtip2E;
	Wed, 28 Oct 2026 09:00:17 +0000 (GMT)
Message-ID: <de164c18-a80f-4081-a91c-c5d9e358e1f1@samsung.com>
Date: Wed, 28 Oct 2026 10:00:16 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [RFC 04/11] dma-mapping: add dma_alloc_attrs_node() and
 dma_alloc_coherent_node()
To: Jakub Kicinski <kuba@kernel.org>
Cc: robin.murphy@arm.com, tglx@kernel.org, dave.hansen@linux.intel.com,
	x86@kernel.org, joro@8bytes.org, will@kernel.org, leon@kernel.org,
	mbloch@nvidia.com, iommu@lists.linux.dev, netdev@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20261027105253.2c3d58a9@kernel.org>
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261028090018eucas1p16fdcb990968a1f4c11cbe93025e277cb
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
X-EPHeader: CA
X-CMS-RootMailID: 20261027022613eucas1p2ac05630160507ff3a887186416e98c30
References: <20261027022528.633359-1-kuba@kernel.org>
	<CGME20261027022613eucas1p2ac05630160507ff3a887186416e98c30@eucas1p2.samsung.com>
	<20261027022528.633359-5-kuba@kernel.org>
	<008d1317-223e-4265-a5a4-4d2a602a2661@samsung.com>
	<20261027105253.2c3d58a9@kernel.org>

On 27.10.2026 18:52, Jakub Kicinski wrote:
> On Tue, 27 Oct 2026 16:24:44 +0100 Marek Szyprowski wrote:
>>> +EXPORT_SYMBOL_GPL(dma_alloc_attrs_node);
>>> +
>>> +void *dma_alloc_attrs(struct device *dev, size_t size, dma_addr_t *dma_handle,
>>> +		gfp_t flag, unsigned long attrs)
>>> +{
>>> +	return dma_alloc_attrs_node(dev, size, dma_handle, flag, attrs,
>>> +				    dev_to_node(dev));
>>> +}
>>>  EXPORT_SYMBOL(dma_alloc_attrs);  
>> Do we really need two exported symbols for dma_alloc_attrs()? I would prefer
>> to make dma_alloc_attrs() a static inline calling dma_alloc_attrs_node().
>>
>> Did I missed something obvious against that?
> License, I associate DMA API with hch so I thought we'd want to make
> the new symbol GPL-only? LMK if I'm overthinking this.

Right, I missed that GPL suffix in the new API.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

