Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D362FDC44
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 14:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756217392; cv=none; b=axUQPgU1DQZYMaAwJtf2VWW5MexHhkZKqYgwxCVCvvq5GbL9CWZQPlsPVLc9X8qPt8D2g8wopDK09Zc6os7ZEbKLm/pqAB5hvlMADh+6abDa8MmuIM4/6APkuLBvroDfLYXgcf8jq2D7TOlkpMGgBw76asCOMWDoJ1q+4inodZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756217392; c=relaxed/simple;
	bh=mMyPwDOjfGJ9XxPaLebdhglVJdFCi4TTrUM+f9VNxgw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=X3/+AnmSAiQYmnrodNTeaZfEDryNUASbFs4+oZg3K9OSBE4l/wMSscKGfxWIY5UrHg0Aj05lEyE8JSjAUheUib9Lcs/jrQeAvnxWIsjEyAb6KfRdatCyEI4LaagOYxrS8E7pmPdCy/z2x/OyyeHAt1bQWHy5wAbEuH7R4G3+dIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=X6J9OUrQ; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="X6J9OUrQ"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20250826140948euoutp014edbc76f532beb43af10adb052dcd8b1~fVmjaBjkG0744307443euoutp01T
	for <iommu@lists.linux.dev>; Tue, 26 Aug 2025 14:09:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20250826140948euoutp014edbc76f532beb43af10adb052dcd8b1~fVmjaBjkG0744307443euoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1756217388;
	bh=wBcHbZvVFk9s7ggVtgAQD1SCZ9nQD0upHN+BmMke/4o=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=X6J9OUrQ7BR5debZpJiXGZcozru4A55OVKrgUE78bZXQkcOtUDojIK7rUUwRiN+PP
	 NppBs+pNEuGrG3XOy6hflYRtDmCXQ2weKnQLFWhrlRueTyxW3IbLm2zxB21B4qNaIo
	 Ebdt812kxsxIs94sfDA0pQIdu2wdXF/MHncWI65I=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20250826140947eucas1p1e89d3b343d1190005a9901f4b5f6189d~fVmjKdmyn1026010260eucas1p1y;
	Tue, 26 Aug 2025 14:09:47 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20250826140946eusmtip1f96cd40ac9cc7376ac863b1e398b0b5e~fVmh-Eunp2654726547eusmtip1N;
	Tue, 26 Aug 2025 14:09:46 +0000 (GMT)
Message-ID: <89954593-8236-464e-8848-e7cdcf639c0a@samsung.com>
Date: Tue, 26 Aug 2025 16:09:46 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: is dma_mapping_error() check necessary for
 dma_alloc_noncoherent()?
To: Baochen Qiang <baochen.qiang@oss.qualcomm.com>, Robin Murphy
	<robin.murphy@arm.com>, Jeff Johnson <jjohnson@kernel.org>
Cc: iommu@lists.linux.dev, "linux-kernel@vger.kernel.org >> linux-kernel"
	<linux-kernel@vger.kernel.org>, "ath11k@lists.infradead.org"
	<ath11k@lists.infradead.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20250826140947eucas1p1e89d3b343d1190005a9901f4b5f6189d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20250826094453eucas1p178ff4a39db0c655f3505128a5cfb0a6a
X-EPHeader: CA
X-CMS-RootMailID: 20250826094453eucas1p178ff4a39db0c655f3505128a5cfb0a6a
References: <CGME20250826094453eucas1p178ff4a39db0c655f3505128a5cfb0a6a@eucas1p1.samsung.com>
	<ff6c1fe6-820f-4e58-8395-df06aa91706c@oss.qualcomm.com>

On 26.08.2025 11:44, Baochen Qiang wrote:
> Hi guys,
>
> I have a driver which allocate noncoherent DMA buffer and get the returned CPU addr tested:
>
> 	vaddr_unaligned = dma_alloc_noncoherent(ab->dev, rx_tid->unaligned_size, &paddr,
> 						DMA_BIDIRECTIONAL, GFP_ATOMIC);
> 	if (!vaddr_unaligned) {
> 		spin_unlock_bh(&ab->base_lock);
> 		return -ENOMEM;
> 	}
>
> while free the buffer
>
> 	dma_free_noncoherent(ab->dev, rx_tid->unaligned_size,
> 			     rx_tid->vaddr_unaligned,
> 			     rx_tid->paddr_unaligned, DMA_BIDIRECTIONAL);
>
> I get below warnings:
>
>   DMA-API: ath11k_pci 0000:03:00.0: device driver failed to check map error[device
> address=0x00000000f3ad7000] [size=639 bytes] [mapped as single]
>   WARNING: CPU: 15 PID: 64303 at kernel/dma/debug.c:1036 check_unmap+0x7e2/0x950
>   RIP: 0010:check_unmap+0x7e2/0x950
>   Call Trace:
>    <TASK>
>    ? free_to_partial_list+0x9d/0x350
>    debug_dma_unmap_page+0xac/0xc0
>    ? debug_smp_processor_id+0x17/0x20
>    ? rcu_is_watching+0x13/0x70
>    dma_free_pages+0x56/0x180
>    [...]
>    </TASK>
>   ---[ end trace 0000000000000000 ]---
>   DMA-API: Mapped at:
>    debug_dma_map_page+0x7c/0x140
>    dma_alloc_pages+0x74/0x220
>    [...]
>
> Checking code gives me the impression that I should do dma_mapping_error() check as well.
> And indeed with below diff the warning is gone:
>
> +       dma_mapping_error(ab->dev, paddr);
>
> However this does not make sense to me since IMO testing the CPU address is good enough, I
> can not imagine a valid case where DMA alloc/map fails while returning a valid CPU
> address, no?
>
> If I was right, should we remove invocation to debug_dma_map_page() in dma_alloc_pages()?

Simply replace "if (!vaddr_unaligned)" with "if 
dma_mapping_error(ab->dev, paddr)" and the debug code will be happy.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

