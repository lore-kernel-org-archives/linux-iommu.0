Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85AA138A72B
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 09:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780910026; cv=none; b=Y0qjUuvMKykyQcrVHG6KLNpaelg+vFMn5iU90DVYNd756AWlkGu8URRHvdtnjAL70TmcBsSpeFy3+djVkHk2KFT5K3gcdq7qPY0T8grUkWparxlf527mYEL42Tr13GNef6+oJvcS5bRIIUaiUNPSIDHmjrvNcqundA7Rb2jziYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780910026; c=relaxed/simple;
	bh=fXRaIH7G5I/CJQmH/yV/VJE8LdcbwzpBIBhaAGzGxQE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=kBinHJDAtmkHaPiBKt+Dpt2CPkqSlYiGWlGyInmSs0lCGMa4Q8W+4+NuKCBRYM7hDpNKvItfTHsqz+rSWlr8qMaTWY4e2BkvYRJa9YA9iGuhOXlKDzdycpi6H2OYZ1llmtXpmKYis9S2D381eFqjndZBElokrU3bW1n2zoNl+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=AZ64TEi3; arc=none smtp.client-ip=210.118.77.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="AZ64TEi3"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20260608091341euoutp0208676e16af8010c400a970010abac3ad~3EDqtaQMp1821918219euoutp02E
	for <iommu@lists.linux.dev>; Mon,  8 Jun 2026 09:13:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20260608091341euoutp0208676e16af8010c400a970010abac3ad~3EDqtaQMp1821918219euoutp02E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1780910021;
	bh=pLOka3cfdFyJbdnNVzmj0WLUciaMGtcVVnmR+UwEEQU=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=AZ64TEi30oMTpDqY8UobC66MDLhC4S7beA9BGec+woiCx65Bqt2oRromNmpfrpn8V
	 9QU+xdCppfH1jZgKPUSqHjZDzo8aNdcIN1sFkT9yjuawcVfSinwyCv/y5m1SWzi+qZ
	 MsDWElVu5kTgax298Lze05cQwFPm4XwOOkE278Vc=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
	20260608091341eucas1p12fe29f238227562cb2cb44b27600bf58~3EDqZ6hKp2978129781eucas1p13;
	Mon,  8 Jun 2026 09:13:41 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260608091340eusmtip2adbe0fecda225c8937409868b3a652fa~3EDp6Fr8J0947509475eusmtip2e;
	Mon,  8 Jun 2026 09:13:40 +0000 (GMT)
Message-ID: <ad25bfe7-feb8-427d-8b0f-f9828e18a917@samsung.com>
Date: Mon, 8 Jun 2026 11:13:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-mapping: direct: fix missing mapping for
 THRU_HOST_BRIDGE segments
To: Leon Romanovsky <leon@kernel.org>
Cc: lirongqing <lirongqing@baidu.com>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>, Bjorn Helgaas <bhelgaas@google.com>,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, hch@lst.de
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260604071856.GA245424@unreal>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260608091341eucas1p12fe29f238227562cb2cb44b27600bf58
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260603013739eucas1p2acd3cd59c1083639deb58723d57558af
X-EPHeader: CA
X-CMS-RootMailID: 20260603013739eucas1p2acd3cd59c1083639deb58723d57558af
References: <CGME20260603013739eucas1p2acd3cd59c1083639deb58723d57558af@eucas1p2.samsung.com>
	<20260603013723.2439-1-lirongqing@baidu.com>
	<d5b8f939-02d5-4016-9ccb-dd0be0714abb@samsung.com>
	<20260604071856.GA245424@unreal>

On 04.06.2026 09:18, Leon Romanovsky wrote:
> On Wed, Jun 03, 2026 at 06:25:22PM +0200, Marek Szyprowski wrote:
>> On 03.06.2026 03:37, lirongqing wrote:
>>> From: Li RongQing <lirongqing@baidu.com>
>>>
>>> In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
>>> incorrectly used 'break' instead of falling through to MAP_NONE.
>>> As a result, segments traversing the host bridge skipped the required
>>> dma_direct_map_phys() call entirely, leaving sg->dma_address
>>> uninitialized and leading to DMA failures. Fix this by using
>>> 'fallthrough;'.
>>>
>>> Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
>>> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
>>> Signed-off-by: Li RongQing <lirongqing@baidu.com>
>> Applied to dma-mapping-fixes, thanks!
> The change looks correct, but it will be better if this change will
> improve d0d08f4bd7f6 ("dma-direct: Fix missing sg_dma_len assignment in
> P2PDMA bus mappings") too.
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..e98b6547c950 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -489,9 +489,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>                 case PCI_P2PDMA_MAP_BUS_ADDR:
>                         sg->dma_address = pci_p2pdma_bus_addr_map(
>                                 p2pdma_state.mem, sg_phys(sg));
> -                       sg_dma_len(sg) = sg->length;
>                         sg_dma_mark_bus_address(sg);
> -                       continue;
> +                       break;
>                 default:
>                         ret = -EREMOTEIO;
>                         goto out_unmap;
>
This makes the code a bit more consistent, but it doesn't fix any bug, so I would prefer it as a separate patch, which would go to -next.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

