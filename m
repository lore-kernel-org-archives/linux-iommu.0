From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] iommu/exynos: Modify error handling
Date: Tue, 9 Aug 2016 17:29:02 +0200
Message-ID: <20160809152902.GC29650@8bytes.org>
References: <20160801061838.GA17805@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160801061838.GA17805@amitoj-Inspiron-3542>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Cc: kgene@kernel.org, k.kozlowski@samsung.com, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, julia.lawall@lip6.fr
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 01, 2016 at 11:48:38AM +0530, Amitoj Kaur Chawla wrote:
> of_platform_device_create returns NULL on error so an IS_ERR test is
> incorrect here and a NULL check is required.
> 
> The Coccinelle semantic patch used to make this change is as follows:
> @@
> expression e;
> @@
> 
>   e = of_platform_device_create(...);
> if(
> -    IS_ERR(e)
> +    !e
>     )
>     {
>   <+...
>   return
> - PTR_ERR(e)
> + -ENODEV
>   ;
>   ...+>
>   }
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  drivers/iommu/exynos-iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Patch didn't apply cleanly against v4.8-rc1, but I fixed it up and it is
now in my tree, thanks.
