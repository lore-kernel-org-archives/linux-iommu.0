Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EB63D8B
	for <iommu@lists.linux.dev>; Wed, 17 Aug 2022 11:12:08 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D7CD6113E;
	Wed, 17 Aug 2022 04:12:08 -0700 (PDT)
Received: from [10.57.13.141] (unknown [10.57.13.141])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 315443F67D;
	Wed, 17 Aug 2022 04:12:07 -0700 (PDT)
Message-ID: <4f5e43ca-c02a-07bd-0c8e-1a90be49fec9@arm.com>
Date: Wed, 17 Aug 2022 12:12:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 2/3] iova: Remove magazine BUG_ON() checks
Content-Language: en-GB
To: John Garry <john.garry@huawei.com>, joro@8bytes.org, will@kernel.org
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <1660730984-30333-1-git-send-email-john.garry@huawei.com>
 <1660730984-30333-3-git-send-email-john.garry@huawei.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <1660730984-30333-3-git-send-email-john.garry@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2022-08-17 11:09, John Garry wrote:
> Two of the magazine helpers have BUG_ON() checks, as follows:
> - iova_magazine_pop() - here we ensure that the mag is not empty. However we
>    already ensure that in the only caller, __iova_rcache_get().
> - iova_magazine_push() - here we ensure that the mag is not full. However
>    we already ensure that in the only caller, __iova_rcache_insert().
> 
> As described, the two bug checks are pointless so drop them.

In some ways it's logical to have assertions to make sure that callers 
*are* already checking so as not to call incorrectly. However I'm 
inclined to agree that this particular case is very niche, with little 
chance of any new callers being added, so they're not offering much 
value, especially on performance-critical paths.

Acked-by: Robin Murphy <robin.murphy@arm.com>

> Signed-off-by: John Garry <john.garry@huawei.com>
> ---
>   drivers/iommu/iova.c | 4 ----
>   1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
> index 580fdf669922..8aece052ce72 100644
> --- a/drivers/iommu/iova.c
> +++ b/drivers/iommu/iova.c
> @@ -694,8 +694,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   	int i;
>   	unsigned long pfn;
>   
> -	BUG_ON(iova_magazine_empty(mag));
> -
>   	/* Only fall back to the rbtree if we have no suitable pfns at all */
>   	for (i = mag->size - 1; mag->pfns[i] > limit_pfn; i--)
>   		if (i == 0)
> @@ -710,8 +708,6 @@ static unsigned long iova_magazine_pop(struct iova_magazine *mag,
>   
>   static void iova_magazine_push(struct iova_magazine *mag, unsigned long pfn)
>   {
> -	BUG_ON(iova_magazine_full(mag));
> -
>   	mag->pfns[mag->size++] = pfn;
>   }
>   
