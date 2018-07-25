From: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v2 6/7] ACPI/IORT: Don't set default coherent DMA mask
Date: Wed, 25 Jul 2018 16:27:47 +0100
Message-ID: <20180725152747.GA5080@red-moon>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<3525869e8e7530128bf9718ae8af7d7564b3c684.1532382222.git.robin.murphy@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <3525869e8e7530128bf9718ae8af7d7564b3c684.1532382222.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, hch-jcswGhMUV9g@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 23, 2018 at 11:16:11PM +0100, Robin Murphy wrote:
> Now that we can track upstream DMA constraints properly with
> bus_dma_mask instead of trying (and failing) to maintain it in
> coherent_dma_mask, it doesn't make much sense for the firmware code to
> be touching the latter at all. It's merely papering over bugs wherein a
> driver has failed to call dma_set_coherent_mask() *and* the bus code has
> not initialised any default value.

Nit: I do not think the driver had a chance to probe and therefore call
dma_set_coherent_mask() before iort_dma_setup() is executed, right ?

Anyway, the patch makes perfect sense:

Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>

> We don't really want to encourage more drivers coercing dma_mask so
> we'll continue to fix that up if necessary, but add a warning to help
> flush out any such buggy bus code that remains.
> 
> CC: Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
> CC: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> CC: Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>
> ---
>  drivers/acpi/arm64/iort.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index bc51cff5505e..08f26db2da7e 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -978,20 +978,20 @@ void iort_dma_setup(struct device *dev, u64 *dma_addr, u64 *dma_size)
>  	int ret, msb;
>  
>  	/*
> -	 * Set default coherent_dma_mask to 32 bit.  Drivers are expected to
> -	 * setup the correct supported mask.
> +	 * If @dev is expected to be DMA-capable then the bus code that created
> +	 * it should have initialised its dma_mask pointer by this point. For
> +	 * now, we'll continue the legacy behaviour of coercing it to the
> +	 * coherent mask if not, but we'll no longer do so quietly.
>  	 */
> -	if (!dev->coherent_dma_mask)
> -		dev->coherent_dma_mask = DMA_BIT_MASK(32);
> -
> -	/*
> -	 * Set it to coherent_dma_mask by default if the architecture
> -	 * code has not set it.
> -	 */
> -	if (!dev->dma_mask)
> +	if (!dev->dma_mask) {
> +		dev_warn(dev, "DMA mask not set\n");
>  		dev->dma_mask = &dev->coherent_dma_mask;
> +	}
>  
> -	size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	if (dev->coherent_dma_mask)
> +		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
> +	else
> +		size = 1ULL << 32;
>  
>  	if (dev_is_pci(dev)) {
>  		ret = acpi_dma_get_range(dev, &dmaaddr, &offset, &size);
> -- 
> 2.17.1.dirty
> 
