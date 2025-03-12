Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7ECA202C27
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 12:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741783703; cv=none; b=cH+DeOdjXPYNQMQ5zQ13lHC6V7jqbo34jBoUZ1oDY0FbCGEiw3p5Ys5x1KvWTSUHrRVOdiElmZEOCOoqXfhEjWW2aV98ZPiKaojuXYo5mvbbByq1BWHN6/3NZjq5cMnfY+VIcy+/ThTiZkCDJuynwsnDoO/Ay+eup/Ggd2U9uzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741783703; c=relaxed/simple;
	bh=oq/UI1w2F5BqykxGx/4fvue02EnRRofo99oV9ZN4bQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=oAQwV37ou+SAf6J0E4MsL9Pppq2RrkfT2AUm1EbMzM02oAIM7mv1xtpCpF6tVgC7qghsodgvg0M49RYfk4p8cycEIZx6x7rpXWSv0T2lXuTiWtvBAVoWNC5eL062QXlABzGd88nLKFbwR2Nf0XnodD+dkb4AJk/Hh0J2D66GNBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=N8r+c/+U; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="N8r+c/+U"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20250312124818euoutp028d5a3805234df36db104dc6c439ef0c6~sDwu38_ZF1061010610euoutp02U
	for <iommu@lists.linux.dev>; Wed, 12 Mar 2025 12:48:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20250312124818euoutp028d5a3805234df36db104dc6c439ef0c6~sDwu38_ZF1061010610euoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1741783698;
	bh=iWoONCuNdWB43HWVONiz9IiYuuz5nXxtgBCvDvHvs/I=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=N8r+c/+UANhSXbeBWPqfumwCbCz3TiXnWkgpbpjjETqjCmarLbuy73KeBPhYVih4h
	 FdriN2Np5bv/qkgwGSB/TvrHzCjaJflUJSp3f1Lp2aV20vwBEPU01jkNxIk6uYU24Z
	 rtJAWFXG3fZfUpAuT2qBelBLLdVde0Hr5j6LlwiE=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTP id
	20250312124818eucas1p1fa0a3c3cee70486cac0d6e49b437164a~sDwuxf4KB0264702647eucas1p1G;
	Wed, 12 Mar 2025 12:48:18 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
	eusmges1new.samsung.com (EUCPMTA) with SMTP id 72.19.20821.29281D76; Wed, 12
	Mar 2025 12:48:18 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250312124818eucas1p18f3281af8a088be8264430010828aa7f~sDwuXByEd0204402044eucas1p1T;
	Wed, 12 Mar 2025 12:48:18 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
	eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
	20250312124818eusmtrp22a5466c800afe950906df18c91bbb7f8~sDwuShm_k1651216512eusmtrp2H;
	Wed, 12 Mar 2025 12:48:18 +0000 (GMT)
X-AuditID: cbfec7f2-b11c470000005155-d9-67d182923ff6
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
	eusmgms2.samsung.com (EUCPMTA) with SMTP id E4.05.19654.29281D76; Wed, 12
	Mar 2025 12:48:18 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20250312124817eusmtip2e02453169321dfa10b0fe3f0c45af440~sDwthzP_Q2900229002eusmtip29;
	Wed, 12 Mar 2025 12:48:17 +0000 (GMT)
Message-ID: <6f6e2eaa-9f56-4400-a555-7264d4596233@samsung.com>
Date: Wed, 12 Mar 2025 13:48:16 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-mapping: fix missing clear bdr in
 check_ram_in_range_map()
To: Baochen Qiang <quic_bqiang@quicinc.com>, robin.murphy@arm.com,
	justin.he@arm.com, hch@lst.de
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20250307030350.69144-1-quic_bqiang@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djPc7qTmi6mGxzbpmGxcvVRJotfXyws
	np74w25xedccNouHP38wWRz88ITVgc1jzbw1jB4vNs9k9Nh9s4HNY+KeOo/Pm+QCWKO4bFJS
	czLLUov07RK4MlZd+chc8FK44uikQywNjGf4uxg5OSQETCTWbV3C2MXIxSEksIJR4vyi/UwQ
	zhdGiT1PnrFAOJ8ZJbrWvWaEaela/AmqZTmjxJRnb9ggnI+MEgunvGcHqeIVsJPoO94MZrMI
	qEo0zZjBAhEXlDg58wmYLSogL3H/1gywGmGBUIn3/zvANogIJEkceLoCLM4sYC5xdPpxZghb
	XOLWk/lMIDabgKFE19suNhCbU8BWYvaqdUwQNfIS29/OYQY5SELgAofExg+HmSHOdpFYCXWQ
	hICwxKvjW6BsGYn/O+czQTS0M0os+H0fypnAKNHw/BbU09YSd879AlrHAbRCU2L9Ln2IsKPE
	waV3mUDCEgJ8EjfeCkIcwScxadt0Zogwr0RHmxBEtZrErOPr4NYevHCJeQKj0iykYJmF5M1Z
	SN6ZhbB3ASPLKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMDEc/rf8U87GOe++qh3iJGJ
	g/EQowQHs5II72rbC+lCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeRftb00XEkhPLEnNTk0tSC2C
	yTJxcEo1MHFFru00udT3qFigMeNT2ZGZUfFrHTfN+zndhz3rsSD/YoawmZ9Zm2pjfCoK9rSt
	Cp1+7PL9wP+shd/uSR6b5u0+RSjxdmmawPaJRW/mGfov/7C7fnHkzturgz6ci18fx7u5XF6l
	842FHk/irhtvIp/pi2v4s7M9vFeyOme9cXlpGnNt2YVJJV6dyZu9VvnPa2FWPPla5FjQ7h2n
	LoblLGFdLtvurO/A3xCXsffhsg1ai1xvPLON14tJVZoiunr/WQf7/ZmzX9jvbhb4wvVn0uGc
	x0JsXhWukvPOn3mW4Ob2oLt04wc9l9ldyk7vpB359PaEsF9nE3yz59j00rsl8ydFLAku4Psj
	kRg+sZ0jSYmlOCPRUIu5qDgRAHgVR0qrAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrFIsWRmVeSWpSXmKPExsVy+t/xe7qTmi6mGyx7xm6xcvVRJotfXyws
	np74w25xedccNouHP38wWRz88ITVgc1jzbw1jB4vNs9k9Nh9s4HNY+KeOo/Pm+QCWKP0bIry
	S0tSFTLyi0tslaINLYz0DC0t9IxMLPUMjc1jrYxMlfTtbFJSczLLUov07RL0MlZd+chc8FK4
	4uikQywNjGf4uxg5OSQETCS6Fn9i7GLk4hASWMooMeXsYhaIhIzEyWkNrBC2sMSfa11sEEXv
	GSXWn7rHCJLgFbCT6DvezA5iswioSjTNmMECEReUODnzCZgtKiAvcf/WDLAaYYFQiff/O8B6
	RQSSJPauOc8GYjMLmEscnX6cGWLBBEaJv/d+MUIkxCVuPZnPBGKzCRhKdL3tAmvgFLCVmL1q
	HRNEjZlE19YuqHp5ie1v5zBPYBSaheSOWUhGzULSMgtJywJGllWMIqmlxbnpucVGesWJucWl
	eel6yfm5mxiBkbbt2M8tOxhXvvqod4iRiYPxEKMEB7OSCO9q2wvpQrwpiZVVqUX58UWlOanF
	hxhNgYExkVlKNDkfGOt5JfGGZgamhiZmlgamlmbGSuK8bFfOpwkJpCeWpGanphakFsH0MXFw
	SjUwJR3sbV0sUSTO2Wl8cP/k98mnfRe/PmYp7Waoxskmu2bSD8M7DFkCvCWnjgRIb+9/3riv
	NGxJxL7ZGut3h7XfZ3R6m7n4laz4jdWqj7b2l6T3Hxfru7xFYJJQ7iFmn50Lfn77dE6wYX30
	v6DSs9NXCxUcEey11jz19nfy/dl39xdzsMl+T9q08lPpwRdb7v9uk+rjyzZ4ozG1jm9n4TuW
	16X+i29eX3uo5+U3zUu5up1Zj6+8TnISXn1Tbu2J/57zm7iyq8VMJRcKudbafQmYdfloUCmb
	f+GaX6y7G85OO925aPWquWxFTkf9z/Kd/FWxY+apbu8TnsJnvmt4i0+ptHX690u11vDlPHY7
	m9Cjs5VYijMSDbWYi4oTAYhJzGE9AwAA
X-CMS-MailID: 20250312124818eucas1p18f3281af8a088be8264430010828aa7f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250307030416eucas1p1503a42196fbcb4bbc561ada50683981b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20250307030416eucas1p1503a42196fbcb4bbc561ada50683981b
References: <CGME20250307030416eucas1p1503a42196fbcb4bbc561ada50683981b@eucas1p1.samsung.com>
	<20250307030350.69144-1-quic_bqiang@quicinc.com>

On 07.03.2025 04:03, Baochen Qiang wrote:
> As discussed in [1], if 'bdr' is set once, it would never get
> cleared, hence 0 is always returned.
>
> Refactor the range check hunk into a new helper dma_find_range(),
> which allows 'bdr' to be cleared in each iteration.
>
> Link: https://lore.kernel.org/all/64931fac-085b-4ff3-9314-84bac2fa9bdb@quicinc.com/ # [1]
> Fixes: a409d9600959 ("dma-mapping: fix dma_addressing_limited() if dma_range_map can't cover all system RAM")
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>

Thanks, applied to dma-mapping-fixes branch.

> ---
>   kernel/dma/direct.c | 28 ++++++++++++++++++----------
>   1 file changed, 18 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 5b4e6d3bf7bc..b8fe0b3d0ffb 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -584,6 +584,22 @@ int dma_direct_supported(struct device *dev, u64 mask)
>   	return mask >= phys_to_dma_unencrypted(dev, min_mask);
>   }
>   
> +static const struct bus_dma_region *dma_find_range(struct device *dev,
> +						   unsigned long start_pfn)
> +{
> +	const struct bus_dma_region *m;
> +
> +	for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> +		unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +
> +		if (start_pfn >= cpu_start_pfn &&
> +		    start_pfn - cpu_start_pfn < PFN_DOWN(m->size))
> +			return m;
> +	}
> +
> +	return NULL;
> +}
> +
>   /*
>    * To check whether all ram resource ranges are covered by dma range map
>    * Returns 0 when further check is needed
> @@ -593,20 +609,12 @@ static int check_ram_in_range_map(unsigned long start_pfn,
>   				  unsigned long nr_pages, void *data)
>   {
>   	unsigned long end_pfn = start_pfn + nr_pages;
> -	const struct bus_dma_region *bdr = NULL;
> -	const struct bus_dma_region *m;
>   	struct device *dev = data;
>   
>   	while (start_pfn < end_pfn) {
> -		for (m = dev->dma_range_map; PFN_DOWN(m->size); m++) {
> -			unsigned long cpu_start_pfn = PFN_DOWN(m->cpu_start);
> +		const struct bus_dma_region *bdr;
>   
> -			if (start_pfn >= cpu_start_pfn &&
> -			    start_pfn - cpu_start_pfn < PFN_DOWN(m->size)) {
> -				bdr = m;
> -				break;
> -			}
> -		}
> +		bdr = dma_find_range(dev, start_pfn);
>   		if (!bdr)
>   			return 1;
>   
>
> base-commit: 7eb172143d5508b4da468ed59ee857c6e5e01da6

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

