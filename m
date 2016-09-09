From: Magnus Damm <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 4/8] of: dma: Split of_configure_dma() into mask and ops
	configuration
Date: Fri, 9 Sep 2016 15:53:41 +0900
Message-ID: <CANqRtoRVRrP9dc3qc-xSE_Wct2HPznzzi1hdrHeC8h2gA=JcKg@mail.gmail.com>
References: <1470696550-3416-1-git-send-email-sricharan@codeaurora.org>
	<1470696550-3416-5-git-send-email-sricharan@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1470696550-3416-5-git-send-email-sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Aug 9, 2016 at 7:49 AM, Sricharan R <sricharan-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
> From: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
>
> The of_configure_dma() function configures both the DMA masks and ops.
> Moving DMA ops configuration to probe time would thus also delay
> configuration of the DMA masks, which might not be safe. To avoid issues
> split the configuration in two to allow keeping masks configuration at
> device add time and move ops configuration to device probe time.

Hi Sricharan, Laurent, everyone,

I'm currently having a look at this series. Want to give it a spin
with the IPMMU driver, however it takes a bit of time to wrap around
my head on init ordering issues with both OF method and standard
platform device setup on two different architectures...

FWIW, here's some cosmetic feedback for this patch to begin with:

In the patch title and commit message you probably want to do perform
a s/of_configure_dma()/of_dma_configure()/g.

> Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>
> ---
>  drivers/of/device.c       | 48 ++++++++++++++++++++++++++++++++++-------------
>  drivers/of/platform.c     |  6 ++++--
>  drivers/pci/probe.c       |  3 ++-
>  include/linux/of_device.h | 11 +++++++++--
>  4 files changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/of/device.c b/drivers/of/device.c
> index 1c843e2..e1fad50 100644
> --- a/drivers/of/device.c
> +++ b/drivers/of/device.c
> @@ -71,7 +71,7 @@ int of_device_add(struct platform_device *ofdev)
>  }
>
>  /**
> - * of_dma_configure - Setup DMA configuration
> + * of_dma_configure - Setup DMA masks and offset
>   * @dev:       Device to apply DMA configuration
>   * @np:                Pointer to OF node having DMA configuration
>   *

The hunk above should be "of_dma_configure_masks" to make the
documentation match the function name.

> @@ -82,13 +82,11 @@ int of_device_add(struct platform_device *ofdev)
>   * can use a platform bus notifier and handle BUS_NOTIFY_ADD_DEVICE events
>   * to fix up DMA configuration.
>   */
> -void of_dma_configure(struct device *dev, struct device_node *np)
> +void of_dma_configure_masks(struct device *dev, struct device_node *np)
>  {
> -       u64 dma_addr, paddr, size;
> -       int ret;
> -       bool coherent;
> +       u64 dma_addr, paddr, size, range_mask;
>         unsigned long offset;
> -       const struct iommu_ops *iommu;
> +       int ret;
>
>         /*
>          * Set default coherent_dma_mask to 32 bit.  Drivers are expected to

Thanks,

/ magnus
