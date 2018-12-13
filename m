From: Srinath Mannam via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [RFC PATCH 3/3] PCI: iproc: Add dma reserve resources to host
Date: Thu, 13 Dec 2018 14:47:08 +0530
Message-ID: <CABe79T4fqHoW4rww2jRNNaiirzOqm7dTvap3Eqi1w17SV4j+qQ@mail.gmail.com>
References: <1544593569-8923-1-git-send-email-srinath.mannam@broadcom.com>
	<1544593569-8923-4-git-send-email-srinath.mannam@broadcom.com>
	<117bb87c4567d14f189642b685dd8813@codeaurora.org>
Reply-To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <117bb87c4567d14f189642b685dd8813-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: poza-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
Cc: Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, linux-pci-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Hi Oza,

Thank you for the review.
Please find my comments in lined.

On Thu, Dec 13, 2018 at 11:33 AM <poza-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org> wrote:
>
> On 2018-12-12 11:16, Srinath Mannam wrote:
> > IPROC host has the limitation that it can use
> > only those address ranges given by dma-ranges
> > property as inbound address.
> > So that the memory address holes in dma-ranges
> > should be reserved to allocate as DMA address.
> >
> > All such reserved addresses are created as resource
> > entries and add to dma_resv list of pci host bridge.
> >
> > These dma reserve resources created by parsing
> > dma-ranges parameter.
> >
> > Ex:
> > dma-ranges = < \
> >   0x43000000 0x00 0x80000000 0x00 0x80000000 0x00 0x80000000 \
> >   0x43000000 0x08 0x00000000 0x08 0x00000000 0x08 0x00000000 \
> >   0x43000000 0x80 0x00000000 0x80 0x00000000 0x40 0x00000000>
> >
> > In the above example of dma-ranges, memory address from
> > 0x0 - 0x80000000,
> > 0x100000000 - 0x800000000,
> > 0x1000000000 - 0x8000000000 and
> > 0x10000000000 - 0xffffffffffffffff.
> > are not allowed to use as inbound addresses.
> > So that we need to add these address range to dma_resv
> > list to reserve their IOVA address ranges.
> >
> > Signed-off-by: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/pci/controller/pcie-iproc.c | 49
> > +++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/drivers/pci/controller/pcie-iproc.c
> > b/drivers/pci/controller/pcie-iproc.c
> > index 3160e93..43e465a 100644
> > --- a/drivers/pci/controller/pcie-iproc.c
> > +++ b/drivers/pci/controller/pcie-iproc.c
> > @@ -1154,25 +1154,74 @@ static int iproc_pcie_setup_ib(struct
> > iproc_pcie *pcie,
> >       return ret;
> >  }
> >
> > +static int
> > +iproc_pcie_add_dma_resv_range(struct device *dev, struct list_head
> > *resources,
> > +                           uint64_t start, uint64_t end)
> > +{
> > +     struct resource *res;
> > +
> > +     res = devm_kzalloc(dev, sizeof(struct resource), GFP_KERNEL);
> > +     if (!res)
> > +             return -ENOMEM;
> > +
> > +     res->start = (resource_size_t)start;
> > +     res->end = (resource_size_t)end;
> > +     pci_add_resource_offset(resources, res, 0);
> > +
> > +     return 0;
> > +}
> > +
> >  static int iproc_pcie_map_dma_ranges(struct iproc_pcie *pcie)
> >  {
> > +     struct pci_host_bridge *host = pci_host_bridge_from_priv(pcie);
> >       struct of_pci_range range;
> >       struct of_pci_range_parser parser;
> >       int ret;
> > +     uint64_t start, end;
> > +     LIST_HEAD(resources);
> >
> >       /* Get the dma-ranges from DT */
> >       ret = of_pci_dma_range_parser_init(&parser, pcie->dev->of_node);
> >       if (ret)
> >               return ret;
> >
> > +     start = 0;
> >       for_each_of_pci_range(&parser, &range) {
> > +             end = range.pci_addr;
> > +             /* dma-ranges list expected in sorted order */
> > +             if (end < start) {
> > +                     ret = -EINVAL;
> > +                     goto out;
> > +             }
> >               /* Each range entry corresponds to an inbound mapping region */
> >               ret = iproc_pcie_setup_ib(pcie, &range, IPROC_PCIE_IB_MAP_MEM);
> >               if (ret)
> >                       return ret;
> > +
> > +             if (end - start) {
> > +                     ret = iproc_pcie_add_dma_resv_range(pcie->dev,
> > +                                                         &resources,
> > +                                                         start, end);
> > +                     if (ret)
> > +                             goto out;
> > +             }
> > +             start = range.pci_addr + range.size;
> >       }
> >
> > +     end = ~0;
> Hi Srinath,
>
> this series is based on following patch sets.
>
> https://lkml.org/lkml/2017/5/16/19
> https://lkml.org/lkml/2017/5/16/23
> https://lkml.org/lkml/2017/5/16/21,
>
Yes, this patch series is done based on the inputs of the patches you
sent earlier.

> some comments to be adapted from the patch-set I did.
>
> end = ~0;
> you should consider DMA_MASK, to see iproc controller is in 32 bit or 64
> bit system.
> please check following code snippet.
>
> if (tmp_dma_addr < DMA_BIT_MASK(sizeof(dma_addr_t) * 8)) {
> +                       lo = iova_pfn(iovad, tmp_dma_addr);
> +                       hi = iova_pfn(iovad,
> +                                     DMA_BIT_MASK(sizeof(dma_addr_t) * 8) - 1);
> +                       reserve_iova(iovad, lo, hi);
> +               }
>
> Also if this controller is integrated to 64bit platform, but decide to
> restrict DMA to 32 bit for some reason, the code should address such
> scenarios.
> so it is always safe to do
>
> #define BITS_PER_BYTE 8
> DMA_BIT_MASK(sizeof(dma_addr_t) * BITS_PER_BYTE)
> so please use kernle macro to find the end of DMA region.
>
this change done with the assumption, that end_address is max bus
address(~0) instead
pcie RC dma mask.
Even dma-ranges has 64bit size dma-mask of PCIe host is forced to 32bit.
// in of_dma_configure function
    dev->coherent_dma_mask = DMA_BIT_MASK(32);
And dma-mask of endpoint was set to 64bit in their drivers. also SMMU supported
dma mask is 48-bit.
But here requirement is all address ranges except dma-ranges address
between 0x0 - ~0x0
have to be reserved.
as you suggested I will change ~0 to DMA_BIT_MASK macro it will look
more cleaner.
>
> Also ideally according to SBSA v5
>
> 8.3 PCI Express device view of memory
>
> Transactions from a PCI express device will either directly address the
> memory system of the base server system
> or be presented to a SMMU for optional address translation and
> permission policing.
> In systems that are compatible with level 3 or above of the SBSA, the
> addresses sent by PCI express devices
> must be presented to the memory system or SMMU unmodified. In a system
> where the PCI express does not use
> an SMMU, the PCI express devices have the same view of physical memory
> as the PEs. In a system with a
> SMMU for PCI express there are no transformations to addresses being
> sent by PCI express devices before they
> are presented as an input address to the SMMU.
>
> which is a limitation of iproc controller, please list the limitation in
> detail as it violates SBSA.
Inbound address sent by pcie devices to the host will not be translate
(unchanged) before it comes to
SMMU or directly to PE. but the there is limitation that, few address
ranges are not allowed by
IPROC PCIe RC and those were filtered out. That is the reason forces
this change request.
I will append these details in commit message.

Regards,
Srinath.
>
> Regards,
> Oza.
>
> > +     if (end - start) {
> > +             ret = iproc_pcie_add_dma_resv_range(pcie->dev, &resources,
> > +                                                 start, end);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> > +     list_splice_init(&resources, &host->dma_resv);
> > +
> >       return 0;
> > +out:
> > +     pci_free_resource_list(&resources);
> > +     return ret;
> >  }
> >
> >  static int iproce_pcie_get_msi(struct iproc_pcie *pcie,
>
>
>
>
>
