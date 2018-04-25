From: Russell King - ARM Linux <linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>
Subject: Re: [PATCH v2 5/5] ARM: Unconditionally enable ARM_DMA_USE_IOMMU
Date: Wed, 25 Apr 2018 11:25:11 +0100
Message-ID: <20180425102511.GP16141@n2100.armlinux.org.uk>
References: <20180425101051.15349-1-thierry.reding@gmail.com>
	<20180425101051.15349-5-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20180425101051.15349-5-thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: nouveau-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 25, 2018 at 12:10:51PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> 
> The ARM_DMA_USE_IOMMU Kconfig option has side-effects that drivers can
> not opt into but have to explicitly opt out of. This can lead to subtle
> bugs that are difficult to track down and not immediately obvious to be
> related to this Kconfig option.
> 
> To avoid this confusion, always enable the option to expose any lurking
> bugs once and allow any regressions introduced by the DMA/IOMMU code to
> be caught more quickly in the future.
> 
> Note that some drivers still use the Kconfig symbol to provide different
> code paths depending on what architecture the code runs on (e.g. 32-bit
> ARM vs. 64-bit ARM which have different and incompatible implementations
> of the DMA/IOMMU integration code), so leave the symbol in place to keep
> those drivers working.
> 
> For the long term, it is preferable to transition everyone to the
> generic DMA/IOMMU integration code in drivers/iommu/dma-iommu.c.
> 
> Signed-off-by: Thierry Reding <treding-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
> ---
> Changes in v2:
> - new patch
> 
>  arch/arm/Kconfig               |  2 +-
>  arch/arm/include/asm/device.h  |  6 ------
>  arch/arm/mm/dma-mapping.c      | 18 ------------------
>  drivers/iommu/Kconfig          |  7 -------
>  drivers/media/platform/Kconfig |  1 -
>  5 files changed, 1 insertion(+), 33 deletions(-)
> 
> diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> index fa0b190f8a38..3c91de78535a 100644
> --- a/arch/arm/Kconfig
> +++ b/arch/arm/Kconfig
> @@ -124,7 +124,7 @@ config NEED_SG_DMA_LENGTH
>  	bool
>  
>  config ARM_DMA_USE_IOMMU
> -	bool
> +	def_bool y
>  	select ARM_HAS_SG_CHAIN
>  	select NEED_SG_DMA_LENGTH

This doesn't work - as has recently been discussed with hch, we can't
globally enable NEED_SG_DMA_LENGTH on ARM - the ARM architecture
pre-dates the addition of the DMA length member in the scatterlist,
and not every machine supports the splitting of the DMA length from
the non-DMA length member.  Hence, this will cause a regression,
sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
