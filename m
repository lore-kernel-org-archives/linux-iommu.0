From: Srinath Mannam via iommu <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Subject: Re: [PATCH v3 0/3] PCIe Host request to reserve IOVA
Date: Fri, 29 Mar 2019 18:51:36 +0530
Message-ID: <CABe79T5MJacansRaR=vtX0hATwms=X2JrJR1Bv=pSz=8B1iRmg@mail.gmail.com>
References: <1548411231-27549-1-git-send-email-srinath.mannam@broadcom.com>
	<c92e07d7-78b2-d4ec-bf1a-29070a9d4145@arm.com>
	<CABe79T7BC9AO3EF23=JjYwXCHDKX5mDYSPzHfpD_tLzX6gukHg@mail.gmail.com>
	<741a4210-251c-9c00-d4a7-bc7ebf8cd57b@arm.com>
Reply-To: Srinath Mannam <srinath.mannam-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <741a4210-251c-9c00-d4a7-bc7ebf8cd57b-5wv7dgnIgG8@public.gmane.org>
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
Cc: poza-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, Ray Jui <rjui-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, BCM Kernel Feedback <bcm-kernel-feedback-list-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Robin,

Thanks a lot for detailed clarification.
I will send next patch set with the changes you suggested.

Regards,
Srinath.

On Thu, Mar 28, 2019 at 9:17 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
>
> On 28/03/2019 10:34, Srinath Mannam wrote:
> > Hi Robin,
> >
> > Thanks for your feedback. Please see my reply in line.
> >
> > On Wed, Mar 27, 2019 at 8:32 PM Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org> wrote:
> >>
> >> On 25/01/2019 10:13, Srinath Mannam wrote:
> >>> Few SOCs have limitation that their PCIe host can't allow few inbound
> >>> address ranges. Allowed inbound address ranges are listed in dma-ranges
> >>> DT property and this address ranges are required to do IOVA mapping.
> >>> Remaining address ranges have to be reserved in IOVA mapping.
> >>>
> >>> PCIe Host driver of those SOCs has to list all address ranges which have
> >>> to reserve their IOVA address into PCIe host bridge resource entry list.
> >>> IOMMU framework will reserve these IOVAs while initializing IOMMU domain.
> >>
> >> FWIW I'm still only interested in solving this problem generically,
> >> because in principle it's not specific to PCI, for PCI it's certainly
> >> not specific to iproc, and either way it's not specific to DT. That
> >> said, I don't care strongly enough to keep pushing back on this
> >> implementation outright, since it's not something which couldn't be
> >> cleaned up 'properly' in future.
> > Iproc PCIe host controller supports inbound address translation
> > feature to restrict access
> > to allowed address ranges. so that allowed memory ranges need to
> > program to controller.
>
> Other PCIe host controllers work that way too - I know, because I've got
> one here. In this particular case, it's not explicit "restriction" so
> much as just that the window configuration controls what AXI attributes
> are generated on the master side of the PCIe-AXI bridge, and there is no
> default attribute. Thus if a PCIe transaction doesn't hit one of the
> windows it simply cannot propagate across to the AXI side because the RC
> won't know what attributes to emit. It may be conceptually a very
> slightly different problem statement, but it still wants the exact same
> solution.
>
> > allowed address ranges information is passed to controller driver
> > through dma-ranges DT property.
>
> And ACPI has a direct equivalent of dma-ranges in the form of the _DMA
> method - compare of_dma_get_range() and acpi_dma_get_range(). Again,
> platforms already exist which have this kind of hardware limitation and
> boot with both DT and ACPI.
>
> > This feature is specific to iproc PCIe controller, so that I think
> > this change has to specific to iproc
> > PCIe driver and DT.
>
> The general concept of devices having inaccessible holes within their
> nominal DMA mask ultimately boils down to how creative SoC designers can
> be with interconnect topologies, so in principle it could end up being
> relevant just about anywhere. But as I implied before, since the
> examples we know about today all seem to be PCIe IPs, it's not all that
> unreasonable to start with this PCI-specific workaround now, and
> generalise it later as necessary.
>
> > Here I followed the same way how PCI IO regions are reserved
> > "iova_reserve_pci_windows". so that this
> > change also specific to PCI.
> >>
> >> One general comment I'd make, though, is that AFAIK PCI has a concept of
> >> inbound windows much more than it has a concept of gaps-between-windows,
> >> so if the PCI layer is going to track anything it should probably be the
> >> actual windows, and leave the DMA layer to invert them into the
> >> reservations it cares about as it consumes the list. That way you can
> >> also avoid the undocumented requirement for the firmware to keep the
> >> ranges property sorted in the first place.
> > This implementation has three parts.
> > 1. parsing dma-ranges and extract allowed and reserved address ranges.
> > 2. program allowed ranges to iproc PCIe controller.
> > 3. reserve list of reserved address ranges in IOMMU layer.
> > #1 and #2 are done using "of_pci_dma_range_parser_init" in present
> > iproc PCIe driver.
> > so that, I listed reserve windows at the same place.
> > #3 requires list of reserve windows so that I add new
> > variable(dma_resv) to carry these
> > reserve windows list to iommu layer from iproc driver layer.
> > The reasons to not use DMA layer for parsing dma-ranges are,
> > 1. This feature is not generic for all SOCs.
> > 2. To avoid dam-ranges parsing in multiple places, already done in
> > iproc pcie driver.
> > 3. Need to do modify standard DMA layer source code "of_dma_configure"
> > 4. required a carrier to pass reserved windows list from DMA layer to
> > IOMMU layer.
> > 5. I followed existing PCIe IO regions reserve procedure done in IOMMU layer.
>
> Sure, I get that - sorry if it was unclear, but all I meant was simply
> taking the flow you currently have, i.e.:
>
> pcie-iproc: parse dma-ranges and make list of gaps between regions
> dma-iommu: process list and reserve entries
>
> and tweaking it into this:
>
> pcie-iproc: parse dma-ranges and make list of regions
> dma-iommu: process list and reserve gaps between entries
>
> which has the nice benefit of being more robust since the first step can
> easily construct the list in correctly-sorted order regardless of the
> order in which the DT ranges appear.
>
> Robin.
