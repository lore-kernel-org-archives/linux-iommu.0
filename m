From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [patch] /drivers/iommu/amd_iommu.c: variable unmap_size could be
 uninitialized
Date: Thu, 31 May 2018 11:44:15 +0200
Message-ID: <20180531094415.GR18595@8bytes.org>
References: <CABvMjLS3xMmMCSk4Y9Q1rd3398B4kqRi69mn7igPzx6Kt=83cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CABvMjLS3xMmMCSk4Y9Q1rd3398B4kqRi69mn7igPzx6Kt=83cw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yizhuo Zhai <yzhai003@ucr.edu>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Chengyu Song <csong@cs.ucr.edu>, Zhiyun Qian <zhiyunq@cs.ucr.edu>
List-Id: iommu@lists.linux-foundation.org

Hi Yizhuo Zhai,

thanks for your patch, but I think there is a better way to fix that.
Please see below.

On Wed, May 30, 2018 at 11:02:54PM -0700, Yizhuo Zhai wrote:
> Variable "unmap_size" is supposed to be initialized in function fetch_pte.
> However, it's uninitialized if fetch_pte returns NULL. And "unmap_size" is used
> outside the return check. 
> 
> From 377ccb647d3c6c6747f20a242b035bafc775c3be Mon Sep 17 00:00:00 2001
> 
> Signed-off-by: From: "yzhai003@ucr.edu" <yzhai003@ucr.edu>
> ---
>  drivers/iommu/amd_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd_iommu.c b/drivers/iommu/amd_iommu.c
> index 8fb8c73..774e057 100644
> --- a/drivers/iommu/amd_iommu.c
> +++ b/drivers/iommu/amd_iommu.c
> @@ -1500,7 +1500,7 @@ static unsigned long iommu_unmap_page(struct
> protection_domain *dom,
>        unsigned long page_size)
>  {
>   unsigned long long unmapped;
> - unsigned long unmap_size;
> + unsigned long unmap_size = 0;

That is not sufficient because fetch_pte is called in a loop, and when
it returns NULL then unmap_size keeps the value of the previous
invocation.

So from looking at the code, it is better to set page_size=0 in
fetch_pte at the very beginning, before the function can return NULL.


Thanks,

	Joerg
