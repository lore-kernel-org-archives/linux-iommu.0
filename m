From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH 08/26] iommu/fsl: Fix checkpatch type CODE_INDENT
Date: Fri, 30 Jan 2015 07:19:40 +0000
Message-ID: <BN3PR0301MB121901CB4657A863EBA512E6EA310@BN3PR0301MB1219.namprd03.prod.outlook.com>
References: <1422455698-3074-1-git-send-email-Emilian.Medve@Freescale.com>
	<1422455698-3074-9-git-send-email-Emilian.Medve@Freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1422455698-3074-9-git-send-email-Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>
Cc: Emilian Medve <Emilian.Medve-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Emil Medve [mailto:Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org]
> Sent: Wednesday, January 28, 2015 8:05 PM
> To: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; jroedel-l3A5Bk7waGM@public.gmane.org;
> Sethi Varun-B16395
> Cc: Medve Emilian-EMMEDVE1
> Subject: [PATCH 08/26] iommu/fsl: Fix checkpatch type CODE_INDENT
> 
> ERROR:CODE_INDENT: code indent should use tabs where possible
> +^I          stash_dest_hint, vcpu);$
> 
> ERROR:CODE_INDENT: code indent should use tabs where possible
> +^I           phys_addr_t ppaact_phys, phys_addr_t spaact_phys,$
> 
> ERROR:CODE_INDENT: code indent should use tabs where possible
> +^I^I          dev->of_node->full_name);$
> 
> ERROR:CODE_INDENT: code indent should use tabs where possible
> +^I^I          dev->of_node->full_name);$
> 
> Signed-off-by: Emil Medve <Emilian.Medve-eDlz3WWmN0ll57MIdRCFDg@public.gmane.org>
> ---
>  drivers/iommu/fsl_pamu.c        | 6 +++---
>  drivers/iommu/fsl_pamu_domain.c | 4 ++--
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> 6b28dd8..7f0181c 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
> @@ -583,7 +583,7 @@ found_cpu_node:
>  	}
> 
>  	pr_debug("stash dest not found for %d on vcpu %d\n",
> -	          stash_dest_hint, vcpu);
> +		 stash_dest_hint, vcpu);
>  	return ~(u32)0;
>  }
> 
> @@ -675,8 +675,8 @@ static void __init get_pamu_cap_values(unsigned
> long pamu_reg_base)
> 
>  /* Setup PAMU registers pointing to PAACT, SPAACT and OMT */  static int
> __init setup_one_pamu(unsigned long pamu_reg_base, unsigned long
> pamu_reg_size,
> -	           phys_addr_t ppaact_phys, phys_addr_t spaact_phys,
> -		   phys_addr_t omt_phys)
> +				 phys_addr_t ppaact_phys, phys_addr_t
> spaact_phys,
> +				 phys_addr_t omt_phys)
>  {
>  	u32 *pc;
>  	struct pamu_mmap_regs *pamu_regs;
> diff --git a/drivers/iommu/fsl_pamu_domain.c
> b/drivers/iommu/fsl_pamu_domain.c index 080ffa4..d5137dd 100644
> --- a/drivers/iommu/fsl_pamu_domain.c
> +++ b/drivers/iommu/fsl_pamu_domain.c
> @@ -682,7 +682,7 @@ static int fsl_pamu_attach_device(struct
> iommu_domain *domain,
>  					 liodn, liodn_cnt);
>  	} else {
>  		pr_debug("missing fsl,liodn property at %s\n",
> -		          dev->of_node->full_name);
> +			 dev->of_node->full_name);
>  			ret = -EINVAL;
>  	}
> 
> @@ -718,7 +718,7 @@ static void fsl_pamu_detach_device(struct
> iommu_domain *domain,
>  		detach_device(dev, dma_domain);
>  	else
>  		pr_debug("missing fsl,liodn property at %s\n",
> -		          dev->of_node->full_name);
> +			 dev->of_node->full_name);
>  }
> 
>  static  int configure_domain_geometry(struct iommu_domain *domain, void
> *data)
> --
> 2.2.2
Acked-by: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
