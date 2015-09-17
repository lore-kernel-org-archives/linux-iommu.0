From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/io-pgtable-arm: Don't use dma_to_phys()
Date: Thu, 17 Sep 2015 15:52:17 +0100
Message-ID: <20150917145216.GJ25634@arm.com>
References: <1c591836f1ec6e676a8889cdccd042650eadb73b.1442499554.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1c591836f1ec6e676a8889cdccd042650eadb73b.1442499554.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <Robin.Murphy-5wv7dgnIgG8@public.gmane.org>
Cc: "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, Sep 17, 2015 at 03:22:20PM +0100, Robin Murphy wrote:
> In checking whether DMA addresses differ from physical addresses, using
> dma_to_phys() is actually the wrong thing to do, since it may hide any
> DMA offset, which is precisely one of the things we are checking for.
> Simply casting between the two address types, whilst ugly, is in fact
> the appropriate course of action.

Urgh... yes.

> We can also reject any device with a fixed DMA offset up-front at page
> table creation, leaving the allocation-time check for the more subtle
> cases like bounce buffering due to an incorrect DMA mask.
> 
> Furthermore, we can then fix the hackish KConfig dependency so that
> architectures without a dma_to_phys() implementation may still
> COMPILE_TEST (or even use!) the code. The true dependency is on the
> DMA API, so use the appropriate symbol for that.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/iommu/Kconfig          |  3 +--
>  drivers/iommu/io-pgtable-arm.c | 16 ++++++++--------
>  2 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
> index 4664c2a..3dc1bcb 100644
> --- a/drivers/iommu/Kconfig
> +++ b/drivers/iommu/Kconfig
> @@ -23,8 +23,7 @@ config IOMMU_IO_PGTABLE
>  config IOMMU_IO_PGTABLE_LPAE
>  	bool "ARMv7/v8 Long Descriptor Format"
>  	select IOMMU_IO_PGTABLE
> -	# SWIOTLB guarantees a dma_to_phys() implementation
> -	depends on ARM || ARM64 || (COMPILE_TEST && SWIOTLB)
> +	depends on HAS_DMA && (ARM || ARM64 || COMPILE_TEST)
>  	help
>  	  Enable support for the ARM long descriptor pagetable format.
>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index 73c0748..e7f9ab9 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -202,11 +202,6 @@ typedef u64 arm_lpae_iopte;
>  
>  static bool selftest_running = false;
>  
> -static dma_addr_t __arm_lpae_dma_addr(struct device *dev, void *pages)
> -{
> -	return phys_to_dma(dev, virt_to_phys(pages));
> -}

Can we keep this helper kicking around, at least to contain the ugliness
of the virt_to_phys + cast?

Will
