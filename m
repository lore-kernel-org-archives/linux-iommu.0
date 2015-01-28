From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v4 1/6] of: iommu: add ptr to OF node arg to
	of_iommu_configure()
Date: Wed, 28 Jan 2015 11:33:00 +0000
Message-ID: <20150128113300.GF1569@arm.com>
References: <1422052359-12384-1-git-send-email-m-karicheri2@ti.com>
	<1422052359-12384-2-git-send-email-m-karicheri2@ti.com>
	<4711364.TTK5TCBdiy@avalon> <54C68C1D.5030605@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54C68C1D.5030605-l0cyMroinI0@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jan 26, 2015 at 06:49:01PM +0000, Murali Karicheri wrote:
> On 01/25/2015 08:32 AM, Laurent Pinchart wrote:
> > Hi Murali,
> >
> > Thank you for the patch.
> >
> > On Friday 23 January 2015 17:32:34 Murali Karicheri wrote:
> >> Function of_iommu_configure() is called from of_dma_configure() to
> >> setup iommu ops using DT property. This API is currently used for
> >> platform devices for which DMA configuration (including iommu ops)
> >> may come from device's parent. To extend this functionality for PCI
> >> devices, this API need to take a parent node ptr as an argument
> >> instead of assuming device's parent. This is needed since for PCI, the
> >> dma configuration may be defined in the DT node of the root bus bridge's
> >> parent device. Currently only dma-range is used for PCI and iommu is not
> >> supported. So return error if the device is PCI.
> >>
> >> Cc: Joerg Roedel<joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
> >> Cc: Grant Likely<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> >> Cc: Rob Herring<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> >> Cc: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
> >> Cc: Will Deacon<will.deacon-5wv7dgnIgG8@public.gmane.org>
> >> Cc: Russell King<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
> >> Cc: Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>
> >> Cc: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>
> >>
> >> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
> >> ---
> >>   drivers/iommu/of_iommu.c |   10 ++++++++--
> >>   drivers/of/platform.c    |    2 +-
> >>   include/linux/of_iommu.h |    6 ++++--
> >>   3 files changed, 13 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> >> index af1dc6a..439235b 100644
> >> --- a/drivers/iommu/of_iommu.c
> >> +++ b/drivers/iommu/of_iommu.c
> >> @@ -133,19 +133,25 @@ struct iommu_ops *of_iommu_get_ops(struct device_node
> >> *np) return ops;
> >>   }
> >>
> >> -struct iommu_ops *of_iommu_configure(struct device *dev)
> >> +struct iommu_ops *of_iommu_configure(struct device *dev,
> >> +				     struct device_node *iommu_np)
> >>   {
> >>   	struct of_phandle_args iommu_spec;
> >>   	struct device_node *np;
> >>   	struct iommu_ops *ops = NULL;
> >>   	int idx = 0;
> >>
> >> +	if (dev_is_pci(dev)) {
> >> +		dev_err(dev, "iommu is currently not supported for PCI\n");
> >> +		return NULL;
> >> +	}
> >> +
> >>   	/*
> >>   	 * We don't currently walk up the tree looking for a parent IOMMU.
> >>   	 * See the `Notes:' section of
> >>   	 * Documentation/devicetree/bindings/iommu/iommu.txt
> >>   	 */
> > Wouldn't it be better to fix this rather than passing the device node pointer
> > to the function ? The solution would be more generic.
> Laurent,
> 
> Will Deacon (Copied here) is working on this as we alteady discussed in 
> this thread. So it will be
> addressed by him in another series.

Well, "working on this" equates to "has it somewhere near the bottom of
a very long list" :)

Will
