From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v2] iommu/ipmmu-vmsa: Restrict IOMMU Domain Geometry to 32-bit address space
Date: Wed, 01 Feb 2017 14:41:28 +0200
Message-ID: <1835710.b18B135Bdu@avalon>
References: <1485861427-23487-1-git-send-email-geert+renesas@glider.be>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <1485861427-23487-1-git-send-email-geert+renesas@glider.be>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Joerg Roedel <joro@8bytes.org>, Magnus Damm <magnus.damm@gmail.com>, Robin Murphy <robin.murphy@arm.com>, Niklas =?ISO-8859-1?Q?S=F6derlund?= <niklas.soderlund@ragnatech.se>, iommu@lists.linux-foundation.org, linux-renesas-soc@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

Hi Geert,

Thank you for the patch.

On Tuesday 31 Jan 2017 12:17:07 Geert Uytterhoeven wrote:
> Currently, the IPMMU/VMSA driver supports 32-bit I/O Virtual Addresses
> only, and thus sets io_pgtable_cfg.ias = 32.  However, it doesn't force
> a 32-bit IOVA space through the IOMMU Domain Geometry.
> 
> Hence if a device (e.g. SYS-DMAC) rightfully configures a 40-bit DMA
> mask, it will still be handed out a 40-bit IOVA, outside the 32-bit IOVA
> space, leading to out-of-bounds accesses of the PGD when mapping the
> IOVA.
> 
> Force a 32-bit IOMMU Domain Geometry to fix this.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> v2:
>   - Add Reviewed-by.
> ---
>  drivers/iommu/ipmmu-vmsa.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
> index 798578f1676480c6..eb8b3df8733b15fb 100644
> --- a/drivers/iommu/ipmmu-vmsa.c
> +++ b/drivers/iommu/ipmmu-vmsa.c
> @@ -424,6 +424,8 @@ static int ipmmu_domain_init_context(struct
> ipmmu_vmsa_domain *domain) domain->cfg.ias = 32;
>  	domain->cfg.oas = 40;
>  	domain->cfg.tlb = &ipmmu_gather_ops;
> +	domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
> +	domain->io_domain.geometry.force_aperture = true;
>  	/*
>  	 * TODO: Add support for coherent walk through CCI with DVM and remove
>  	 * cache handling. For now, delegate it to the io-pgtable code.

-- 
Regards,

Laurent Pinchart
