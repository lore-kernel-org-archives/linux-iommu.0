Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF2DA2E0FC
	for <iommu@lists.linux.dev>; Thu, 15 Jun 2023 21:25:26 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 457C31FB;
	Thu, 15 Jun 2023 14:26:10 -0700 (PDT)
Received: from [10.57.85.251] (unknown [10.57.85.251])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CC173F663;
	Thu, 15 Jun 2023 14:25:24 -0700 (PDT)
Message-ID: <67aab611-29cd-1a80-d0e2-e5b6523b2785@arm.com>
Date: Thu, 15 Jun 2023 22:25:19 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 3/3] iommu: rockchip: Allocate tables from all
 available memory
Content-Language: en-GB
To: Jonas Karlman <jonas@kwiboo.se>, Joerg Roedel <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, Heiko Stuebner <heiko@sntech.de>
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230615201042.2291867-1-jonas@kwiboo.se>
 <20230615201042.2291867-4-jonas@kwiboo.se>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20230615201042.2291867-4-jonas@kwiboo.se>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-06-15 21:10, Jonas Karlman wrote:
> Newer Rockchip SoCs, RK356x and RK3588, support more then 4GB of memory.

Older ones supposedly did too, e.g. commit 79db45be2b8b ("ARM: dts: 
rockchip: convert rk3288 device tree files to 64 bits"). Are we certain 
that nobody actually has a system with IOMMUv1 and more than 4GB of RAM?

> However, the RK IOMMU driver is using the GFP_DMA32 flag to limit
> allocation of the discovery and page tables into memory below 4GB.
> 
> Let's remove this limitation now that the discovery table address is

Nit: s/discovery/directory/g again

Thanks,
Robin.

> correctly configured for addresses above 4GB.
> 
> Signed-off-by: Jonas Karlman <jonas@kwiboo.se>
> ---
> v2:
> - no change
> 
>   drivers/iommu/rockchip-iommu.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 62be9bf42390..46498fc382ee 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -727,7 +727,7 @@ static u32 *rk_dte_get_page_table(struct rk_iommu_domain *rk_domain,
>   	if (rk_dte_is_pt_valid(dte))
>   		goto done;
>   
> -	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC | GFP_DMA32);
> +	page_table = (u32 *)get_zeroed_page(GFP_ATOMIC);
>   	if (!page_table)
>   		return ERR_PTR(-ENOMEM);
>   
> @@ -1076,7 +1076,7 @@ static struct iommu_domain *rk_iommu_domain_alloc(unsigned type)
>   	 * Each level1 (dt) and level2 (pt) table has 1024 4-byte entries.
>   	 * Allocate one 4 KiB page for each table.
>   	 */
> -	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL | GFP_DMA32);
> +	rk_domain->dt = (u32 *)get_zeroed_page(GFP_KERNEL);
>   	if (!rk_domain->dt)
>   		goto err_free_domain;
>   
