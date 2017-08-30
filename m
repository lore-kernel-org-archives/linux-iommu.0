From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 3/3] iommu: s390: constify iommu_ops
Date: Wed, 30 Aug 2017 15:21:47 +0200
Message-ID: <20170830132147.jog4r6barsx6rfvs@8bytes.org>
References: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1503922370-25990-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Arvind Yadav <arvind.yadav.cs@gmail.com>
Cc: m.szyprowski@samsung.com, kgene@kernel.org, krzk@kernel.org, matthias.bgg@gmail.com, gerald.schaefer@de.ibm.com, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Aug 28, 2017 at 05:42:50PM +0530, Arvind Yadav wrote:
> iommu_ops are not supposed to change at runtime.
> Functions 'bus_set_iommu' working with const iommu_ops provided
> by <linux/iommu.h>. So mark the non-const structs as const.
> 
> Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
> ---
>  drivers/iommu/s390-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.
