From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/7] dt-bindings: PCI: Describe ATS property for root
 complex nodes
Date: Mon, 5 Jun 2017 12:20:25 -0500
Message-ID: <20170605172025.qgnocl5ytexnklue@rob-hp-laptop>
References: <20170524180143.19855-1-jean-philippe.brucker@arm.com>
 <20170524180143.19855-3-jean-philippe.brucker@arm.com>
 <20170531172320.3u6bdctv44aqighy@rob-hp-laptop>
 <cd63a2dc-8259-482d-19e9-9db60be866f7@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <cd63a2dc-8259-482d-19e9-9db60be866f7@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-acpi@vger.kernel.org, linux-arm-kernel@lists.infradead.org, iommu@lists.linux-foundation.org, bhelgaas@google.com, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, hanjun.guo@linaro.org, sudeep.holla@arm.com, rjw@rjwysocki.net, lenb@kernel.org, will.deacon@arm.com, robin.murphy@arm.com, joro@8bytes.org, okaya@codeaurora.org, sunil.kovvuri@gmail.com, thunder.leizhen@huawei.com, tn@semihalf.com
List-Id: iommu@lists.linux-foundation.org

On Thu, Jun 01, 2017 at 01:28:01PM +0100, Jean-Philippe Brucker wrote:
> On 31/05/17 18:23, Rob Herring wrote:
> > On Wed, May 24, 2017 at 07:01:38PM +0100, Jean-Philippe Brucker wrote:
> >> Address Translation Service (ATS) is an extension to PCIe allowing
> >> endpoints to manage their own IOTLB, called Address Translation Cache
> >> (ATC). Instead of having every memory transaction processed by the IOMMU,
> >> the endpoint can first send an Address Translation Requests for an IOVA,
> >> obtain the corresponding Physical Address from the IOMMU and store it in
> >> its ATC. Subsequent transactions to this memory region can be performed on
> >> the PA, in which case they are marked 'translated' and (partially) bypass
> >> the IOMMU.
> >>
> >> Since the extension uses fields that were previously reserved in the
> >> PCIe Translation Layer Packet, it seems ill-advised to enabled it on a
> >> system that doesn't fully support ATS.
> >>
> >> To "old" root complexes that simply ignored the new AT field, an Address
> >> Translation Request will look exactly like a Memory Read Request, so the
> >> root bridge will forward a memory read to the IOMMU instead of a
> >> translation request. If the access succeeds, the RC will send a Read
> >> Completion, which looks like a Translation Completion, back to the
> >> endpoint. As a result the endpoint might end up storing the content of
> >> memory instead of a physical address in its ATC. In reality, it's more
> >> likely that the size fields will be invalid and either end will detect the
> >> error, but in any case, it is undesirable.
> >>
> >> Add a way for firmware to tell the OS that ATS is supported by the PCI
> >> root complex.
> > 
> > Can't firmware have already enabled ATS? Often for things like this, not 
> > present means "use firmware setting".
> 
> I don't think it's up to firmware to enable ATS in endpoints, because it
> depends on IOMMU properties (e.g. configured page size). It must also be
> enabled after the PASID capability, which the OS may or may not want to
> enable.
> 
> While endpoints have ATS capability and config register, there is no
> architected mechanism in root complexes as far as I know. So firmware may
> have a mechanism outside the OS scope to toggle ATS in the root complex.
> If there is a bug and firmware cannot enable ATS, then the OS must be made
> aware of it, so that it doesn't enable ATS in endpoints, or else we might
> end up with silent memory corruption as described above. (Lack of ATS may
> slow the system down but shouldn't be fatal.)
> 
> If the SMMU supports ATS, then the root complex attached to it will most
> likely supports ATS. The switch in this patch simply allows firmware to
> confirm that.
> 
> >> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
> >> ---
> >>  Documentation/devicetree/bindings/pci/pci-iommu.txt | 8 ++++++++
> >>  1 file changed, 8 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/pci/pci-iommu.txt b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> >> index 0def586fdcdf..f21a68ec471a 100644
> >> --- a/Documentation/devicetree/bindings/pci/pci-iommu.txt
> >> +++ b/Documentation/devicetree/bindings/pci/pci-iommu.txt
> >> @@ -44,6 +44,14 @@ Optional properties
> >>  - iommu-map-mask: A mask to be applied to each Requester ID prior to being
> >>    mapped to an IOMMU specifier per the iommu-map property.
> >>  
> >> +- ats-supported: if present, the root complex supports the Address
> >> +  Translation Service (ATS). It is able to interpret the AT field in PCIe
> >> +  Transaction Layer Packets, and forward Translation Completions or
> >> +  Invalidation Requests to endpoints.
> > 
> > Why can't this be based on the compatible strings?
> 
> Host controllers like the generic ECAM one should be able to advertise
> ATS, if for instance the virtual IOMMU in Qemu offers a channel for ATS
> invalidation. In that case we would have pci-host-{e,}cam-generic{-ats,}
> compatible strings and double the number of compatible strings each time
> we add a similar capability.

It would not double the compatibles. A given SoC will either support ATS 
or not, right? A given compatible will imply whether ATS is supported or 
not.

pci-host-{e,}cam-generic is a special case. I'm okay with having a 
property for that I suppose. We should not require this property though 
and allow for it to be implied by the SoC specific compatible as well.

Rob
