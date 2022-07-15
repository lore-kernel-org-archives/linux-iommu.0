Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CC9020E0
	for <iommu@lists.linux.dev>; Fri, 15 Jul 2022 07:49:31 +0000 (UTC)
Received: by theia.8bytes.org (Postfix, from userid 1000)
	id 21A4B3D9; Fri, 15 Jul 2022 09:49:29 +0200 (CEST)
Date: Fri, 15 Jul 2022 09:49:27 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	iommu@lists.linux-foundation.org, will@kernel.org,
	yf.wang@mediatek.com, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH -next] iommu/dma: Fix missing mutex_init() in
 iommu_get_msi_cookie()
Message-ID: <YtEcB6717b3d5suQ@8bytes.org>
References: <20220627085533.1469141-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220627085533.1469141-1-yangyingliang@huawei.com>

Adding Robin.

On Mon, Jun 27, 2022 at 04:55:33PM +0800, Yang Yingliang wrote:
> cookie_alloc() is called by iommu_get_dma_cookie() and iommu_get_msi_cookie(),
> but the mutex is only initialized in iommu_get_dma_cookie(), move mutex_init()
> into cookie_alloc() to make sure the mutex will be initialized.
> 
> Fixes: ac9a5d522bb8 ("iommu/dma: Fix race condition during iova_domain initialization")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/iommu/dma-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> index 1910f4f1612b..e29157380c48 100644
> --- a/drivers/iommu/dma-iommu.c
> +++ b/drivers/iommu/dma-iommu.c
> @@ -294,6 +294,7 @@ static struct iommu_dma_cookie *cookie_alloc(enum iommu_dma_cookie_type type)
>  	if (cookie) {
>  		INIT_LIST_HEAD(&cookie->msi_page_list);
>  		cookie->type = type;
> +		mutex_init(&cookie->mutex);
>  	}
>  	return cookie;
>  }
> @@ -311,7 +312,6 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
>  	if (!domain->iova_cookie)
>  		return -ENOMEM;
>  
> -	mutex_init(&domain->iova_cookie->mutex);
>  	return 0;
>  }
>  
> -- 
> 2.25.1
