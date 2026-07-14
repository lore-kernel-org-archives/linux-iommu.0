Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD22C3D3CF0
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784009010; cv=none; b=hzNg3808ulHm9W+wigwED1N+EFmo1Vk93xxMBaa8CrHpyMMe9Llt2DBuB72iFMoFco4WjVRCC1QDJNB3Zd/kcH2JFSzeMpy7ESbwlYNqyrUn1nYFBD9hXpbIHoiYQYroxxyoIhJdZjTdnlr5V4bZmvse+GDyJtveCMoEf0XyUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784009010; c=relaxed/simple;
	bh=COk2wX2jZD2d1qPp4lpPQ8FViO903xhrrRx35WjWdBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:From:In-Reply-To:
	 Content-Type:References; b=bNmGuwxHKo5nTMQV3S6J/7YSPt7TMgHtb8WoSyOOe7LAc2CcsBaRBPIp0XK8ONgt7m6lClgNkqmYBsaExxoQptOz9VfeXix41kTBdi5zwyVz/PikKVk4pp2uIH/0xvo9vcdFoOLM90cjXTlmt2v43HV+2tToZIXWUfqBzgMn74E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=LcPyg8h2; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LcPyg8h2"
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260714060326euoutp015b81c4ed544ac17034729d2c420c0d5e~CEr1R1k4t1284012840euoutp01p
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 06:03:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260714060326euoutp015b81c4ed544ac17034729d2c420c0d5e~CEr1R1k4t1284012840euoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784009006;
	bh=KypV5XK/i5AsnFlkCRUYoYt76EM3bVkCa2DsWaCExGo=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=LcPyg8h20ro764c8dkiKZP0bWxk2m0Hl2LRrz+3BEGwkfeVRzDsZPsvYcQWWMrJKS
	 6x+SZpomRWoj/xeAf2KIMkQSdxruRIa0k2HpT1idhshVDtSU7YYx4KcqG1FVNGsAVp
	 Kk+p0ia8SURLZphdr+ueDTa/rC7XxFOBDjCbP1Po=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260714060326eucas1p2f7547611257961d9a1e96db1fbc9285c~CEr04H8Xl1399113991eucas1p2M;
	Tue, 14 Jul 2026 06:03:26 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
	20260714060325eusmtip192d532ed69f133cf9753eeda5bd08839~CEr0aQdeL0881908819eusmtip1g;
	Tue, 14 Jul 2026 06:03:25 +0000 (GMT)
Message-ID: <ccfb5781-9964-4812-a67b-121ea6f79648@samsung.com>
Date: Tue, 14 Jul 2026 08:03:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] dma-direct: Improve readability of the
 dma_direct_map_sg() for P2PDMA case
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>, Luis Chamberlain <mcgrof@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Logan Gunthorpe <logang@deltatee.com>,
	Christoph Hellwig <hch@lst.de>, Li RongQing <lirongqing@baidu.com>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20260713083022.1110993-1-m.szyprowski@samsung.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260714060326eucas1p2f7547611257961d9a1e96db1fbc9285c
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24
X-EPHeader: CA
X-CMS-RootMailID: 20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24
References: <CGME20260713083036eucas1p12b33a500ff4fef0b5d8db94f694bdb24@eucas1p1.samsung.com>
	<20260713083022.1110993-1-m.szyprowski@samsung.com>

On 13.07.2026 10:30, Marek Szyprowski wrote:
> Improve readability of the sg_dma_len assignment in the P2PDMA cases by
> removing duplicated code, which was a direct result of the d0d08f4bd7f6
> ("dma-direct: Fix missing sg_dma_len assignment in P2PDMA bus mappings")
> fix. No functional change.
>
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Link: https://lore.kernel.org/all/20260604071856.GA245424@unreal/
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Pushed to dma-mapping-for-next.
> ---
>  kernel/dma/direct.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 4391b797d4db..d8219efe3273 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -486,15 +486,14 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>  				goto out_unmap;
>  			}
>  			break;
>  		case PCI_P2PDMA_MAP_BUS_ADDR:
>  			sg->dma_address = pci_p2pdma_bus_addr_map(
>  				p2pdma_state.mem, sg_phys(sg));
> -			sg_dma_len(sg) = sg->length;
>  			sg_dma_mark_bus_address(sg);
> -			continue;
> +			break;
>  		default:
>  			ret = -EREMOTEIO;
>  			goto out_unmap;
>  		}
>  		sg_dma_len(sg) = sg->length;
>  	}

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

