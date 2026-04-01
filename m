Received: from mail-m3271.qiye.163.com (mail-m3271.qiye.163.com [220.197.32.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC7738AC8E
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 07:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.32.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775029728; cv=none; b=PmJDYw1ubHCQQS5DVnKkTG32TbndlBtYqkwTnBz7aiBJWNCah6GisSCMj+yowkHlx5aKjwPlYUNszDoC4Ka9zh7yr2WGMnCL8ZJnzMs4UVfVC5x8U7Qw7/peIGsPgm4G2yZCT8X6SHQH8l7k/5G94S0ZjqOg2t10Lj28jm4XOdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775029728; c=relaxed/simple;
	bh=sqRcS6quC4YTXMMkOvtDevT1rJECdUqSqCBcOqSCNtA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=celZJT+MA2vaUMNoYI3RZKaM2Wb41OxTnjIzw4Xav5qBiscwDA0L2frT6pSSleHzyJ3/gtWU1YE6905gqj3mb5v0BaSmhR2BmfI08oXjVJKNx9Ot5yEl43ES/Byff3GnozAOIctp/v9TFL51VsX9W29Rz9VunaeVfLlF82CGwOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=B0fbw+/q; arc=none smtp.client-ip=220.197.32.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="B0fbw+/q"
Received: from [192.168.31.31] (gy-adaptive-ssl-proxy-4-entmail-virt151.gy.ntes [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 391fa097e;
	Wed, 1 Apr 2026 15:48:30 +0800 (GMT+08:00)
Message-ID: <0f285782-b12a-4abd-bca7-b6c549bed59f@rock-chips.com>
Date: Wed, 1 Apr 2026 15:48:30 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/rockchip: fix page table allocation flags for v2
 IOMMU
To: Midgy BALON <midgy971@gmail.com>, iommu@lists.linux.dev
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, heiko@sntech.de,
 jonas@kwiboo.se, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260331075010.1463-1-midgy971@gmail.com>
From: Simon <xxm@rock-chips.com>
In-Reply-To: <20260331075010.1463-1-midgy971@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d4803ed2603ackunm45f6e71b2a8a3ca
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGksdQ1YdQkMfQhhOQhgfSk9WFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=B0fbw+/qEcNcLU2iS4WTUn6bpRy8SWB0IUW17RcFjQZc+R/tBTTASZxZ4jUT2qRVK/TRlKamUouB1f5RE8TzpA6VWcOOvAIatIdI31KnCioaMBWk9kmDYokeYl4ibVVkEtPmy4iQ6dtzZmuLfvF1CrdMVsxuu4xzEcvQr0QIu3g=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=y6yka7GkceGzBUjj8aeJVzPjmvwnWCwQ5Otg+ysj1O8=;
	h=date:mime-version:subject:message-id:from;

Hi Midgy,

在 2026/3/31 15:50, Midgy BALON 写道:
> commit 2a7e6400f72b ("iommu: rockchip: Allocate tables from all
> available memory for IOMMU v2") removed GFP_DMA32 from
> iommu_data_ops_v2, reasoning that RK356x and RK3588 IOMMU v2 hardware
> supports up to 40-bit physical addresses for page tables.  However, the
> RK3568 IOMMU page-table walker uses a 32-bit AXI bus: it cannot access
> physical addresses above 4 GB regardless of the address encoding range.
>
> On boards with more than 4 GB of RAM (e.g. 8 GB LPDDR4X), removing
> GFP_DMA32 causes two distinct failure modes:
>
> 1. Direct allocation above 4 GB: iommu_alloc_pages_sz() may return
>     memory above 0x100000000.  The hardware page-table walker issues a
>     bus error trying to dereference those addresses, causing an IOMMU
>     fault on the first DMA transaction.
Which IP block is hitting this? We'd like to take a look on our end.
> 2. SWIOTLB bounce-buffer poisoning: without GFP_DMA32, page tables land
>     above the SWIOTLB window.  dma_map_single() with DMA_BIT_MASK(32)
>     then bounces them into a buffer below 4 GB.  rk_dte_get_page_table()
>     returns phys_to_virt() of the bounce buffer address; PTEs are written
>     there; the next dma_sync_single_for_device(DMA_TO_DEVICE) copies the
>     original (zero) data back over the bounce buffer, silently erasing the
>     freshly written PTEs.  The IOMMU faults because every PTE reads as zero.
This probably need a separate patch. One way to fix it would be to track the
original L2 page table base addresses in struct rk_iommu_domain,
then have rk_dte_get_page_table() return the tracked address instead of
deriving it from the DTE.
> Restore GFP_DMA32 (and DMA_BIT_MASK(32)) for iommu_data_ops_v2, which
> currently only serves "rockchip,rk3568-iommu" in mainline.
>
> Tested on Radxa ROCK 3B (RK3568, 8 GB LPDDR4X):
>    - MobileNetV1 via RKNN: 5.8 ms/inference (IOMMU mode)
>    - YOLOv5s 640x640 via RKNN: ~57 ms/inference (IOMMU mode)
>    - No IOMMU faults, correct inference results
>
> Fixes: 2a7e6400f72b ("iommu: rockchip: Allocate tables from all available memory for IOMMU v2")
> Cc: stable@vger.kernel.org
> Cc: Jonas Karlman <jonas@kwiboo.se>
> Signed-off-by: Midgy BALON <midgy971@gmail.com>
> ---
>   drivers/iommu/rockchip-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 85f3667e797..8b45db29471 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -1358,8 +1358,8 @@ static struct rk_iommu_ops iommu_data_ops_v2 = {
>   	.pt_address = &rk_dte_pt_address_v2,
>   	.mk_dtentries = &rk_mk_dte_v2,
>   	.mk_ptentries = &rk_mk_pte_v2,
> -	.dma_bit_mask = DMA_BIT_MASK(40),
> -	.gfp_flags = 0,
> +	.dma_bit_mask = DMA_BIT_MASK(32),
> +	.gfp_flags = GFP_DMA32,
>   };
>   
>   static const struct of_device_id rk_iommu_dt_ids[] = {
