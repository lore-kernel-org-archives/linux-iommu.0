From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 3/4 v4] iommu/fsl: Add iommu domain attributes required
 by fsl PAMU driver.
Date: Mon, 5 Nov 2012 17:56:07 -0600
Message-ID: <1352159767.28279.11@snotra>
References: <1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1352114361-25192-3-git-send-email-Varun.Sethi@freescale.com>
	(from Varun.Sethi@freescale.com on Mon Nov  5 05:19:20 2012)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: joerg.roedel@amd.com, iommu@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, timur@freescale.com, Varun Sethi <Varun.Sethi@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 11/05/2012 05:19:20 AM, Varun Sethi wrote:
> Added the following domain attributes required by FSL PAMU driver:
> 1. Subwindows field added to the iommu domain geometry attribute.
> 2. Added new iommu stash attribute, which allows setting of the
>    LIODN specific stash id parameter through IOMMU API.
> 3. Added an attribute for enabling/disabling DMA to a particular
>    memory window.
> 
> 
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> ---
> changes in v4:
> - Updated comment explaining subwindows(as mentioned by Scott).
> change in v3:
> -renamed the stash attribute targets
>  include/linux/iommu.h |   36 ++++++++++++++++++++++++++++++++++++
>  1 files changed, 36 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index f3b99e1..e72f5e5 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -44,6 +44,34 @@ struct iommu_domain_geometry {
>  	dma_addr_t aperture_start; /* First address that can be  
> mapped    */
>  	dma_addr_t aperture_end;   /* Last address that can be  
> mapped     */
>  	bool force_aperture;       /* DMA only allowed in mappable  
> range? */
> +
> +	/**
> +	 * There could be a single contiguous window tha maps the entire
> +	 * geometry or it could be split in to multiple subwindows.

...or it could be a normal IOMMU that supports arbitrary paging  
throughout the aperture.

> +	 * Subwindows allow for supporting physically discontiguous  
> mappings.

...in the absence of arbitrary paging.

> +	 * This attribute indicates number of DMA subwindows supported  
> by
> +	 * the geometry.

s/indicates number/indicates the number/

>   If there is a single window that maps the entire
> +	 * geometry, attribute must be set to "1". A value of "0"  
> implies
> +	 * that there are 256 subwindows each of size 4K. Value other  
> than
> +	 * "0" or "1" indicates the actual number of subwindows.

No, a value of "0" indicates that this mechanism is not in use at all,  
and normal paging is used.  PAMU specific things like "256 subwindows"  
must not be a default value in a generic API.

In the case of PAMU, if you specify 0 here, the aperture is limited to  
1 MiB because that is the limit of PAMU's ability to simulate arbitrary  
paging with subwindows, but this is only the limit of one  
implementation.  It's not part of the API.

-Scott
