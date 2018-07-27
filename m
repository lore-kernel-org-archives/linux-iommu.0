From: Grygorii Strashko via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v2 2/7] dma-mapping: Generalise dma_32bit_limit flag
Date: Fri, 27 Jul 2018 12:45:39 -0500
Message-ID: <7872d914-8ea7-06e4-4a0c-489023e098d6@ti.com>
References: <cover.1532382222.git.robin.murphy@arm.com>
	<c1720f0181b66f711e4097d85149757b16a7b0a7.1532382222.git.robin.murphy@arm.com>
Reply-To: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <c1720f0181b66f711e4097d85149757b16a7b0a7.1532382222.git.robin.murphy-5wv7dgnIgG8@public.gmane.org>
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
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, hch-jcswGhMUV9g@public.gmane.org, m.szyprowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Cc: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, x86-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, frowand.list-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org



On 07/23/2018 05:16 PM, Robin Murphy wrote:
> Whilst the notion of an upstream DMA restriction is most commonly seen
> in PCI host bridges saddled with a 32-bit native interface, a more
> general version of the same issue can exist on complex SoCs where a bus
> or point-to-point interconnect link from a device's DMA master interface
> to another component along the path to memory (often an IOMMU) may carry
> fewer address bits than the interfaces at both ends nominally support.
> In order to properly deal with this, the first step is to expand the
> dma_32bit_limit flag into an arbitrary mask.
> 
> To minimise the impact on existing code, we'll make sure to only
> consider this new mask valid if set. That makes sense anyway, since a
> mask of zero would represent DMA not being wired up at all, and that
> would be better handled by not providing valid ops in the first place.
> 
> Signed-off-by: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>

I'd like to note about some possible issue related to this change.

There are some places in kernel where parent DMA configuration is copied 
to the manually created child devices, like:
mfd-core.c
mfd_add_device()
	pdev->dev.parent = parent;
	pdev->dev.type = &mfd_dev_type;
	pdev->dev.dma_mask = parent->dma_mask;
	pdev->dev.dma_parms = parent->dma_parms;
	pdev->dev.coherent_dma_mask = parent->coherent_dma_mask;

Adding or changing generic DMA device properties might affect on such
subsystems/drivers. Have you considered such cases?

-- 
regards,
-grygorii
