From: Jayachandran C <jnair@caviumnetworks.com>
Subject: Re: [PATCH v3 0/2] Handle Cavium ThunderX2 PCI topology quirk
Date: Fri, 24 Mar 2017 12:44:08 +0000
Message-ID: <20170324124327.GA2525@localhost>
References: <1490172671-2648-1-git-send-email-jnair@caviumnetworks.com>
 <122d7df5-8fde-c6fb-a608-9091dd59e79b@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pci-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <122d7df5-8fde-c6fb-a608-9091dd59e79b@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
To: Jon Masters <jcm@redhat.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org, Alex Williamson <alex.williamson@redhat.com>, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Robin Murphy <robin.murphy@arm.com>
List-Id: iommu@lists.linux-foundation.org

On Wed, Mar 22, 2017 at 11:13:05AM -0400, Jon Masters wrote:
> On 03/22/2017 04:51 AM, Jayachandran C wrote:
> > Hi Bjorn, Alex,
> > 
> > Here is v3 of the patchset to handle the PCIe topology quirk of
> > Cavium ThunderX2 (previously called Broadcom Vulcan).
> > 
> > The earlier discussions on this can be seen at:
> > http://www.spinics.net/lists/linux-pci/msg51001.html
> > https://patchwork.ozlabs.org/patch/582633/ and
> > https://lists.linuxfoundation.org/pipermail/iommu/2016-June/017681.html
> > 
> > The earlier discussion on this patchset had stalled with a suggestion
> > that it may be possible to fix up this quirk by handling the issue in
> > the function argument of pci_for_each_dma_alias(). But at that point
> > all the ACPI and OF code for SMMU and GIC was to merged, and we did not
> > have reasonable codebase to make the changes.
> > 
> > For 4.11, I tried to fix it in both the SMMU and the GIC ITS code based
> > on this suggestion, but after going thru the effort, that does not look
> > like the right approach. I have the code changes at:
> > https://github.com/jchandra-cavm/linux/commits/rid-xlate-fixup
> > if anyone want to look over the code.
> > 
> > The problems with that approach is:
> >  - of the 14 uses of pci_for_each_dma_alias in the function in the kernel
> >    tree, I have to fixup 6 callers (which is all but one ofthe callers
> >    outside x86)
> >  - 4 of these can be reasonably handled (please see the github repo above),
> >    but the calls in drivers/irqchip/irq-gic-v3-its-pci-msi.c and
> >    drivers/iommu/iommu.c cannot be reasonably fixed up.
> >  - Even without the 2 above two changes I can get it to work for now.
> >    But pci_for_each_dma_alias does not work as expected on this platform
> >    and we have to be aware of that for all future uses of the function.
> >   
> > For now, I have ruled out that approach, and I have rebased the earlier
> > patch on to 4.11-rc and submitting again for review. The changes are:
> > 
> > v2>v3:
> >  - changed device flag name from PCI_DEV_FLAGS_DMA_ALIAS_ROOT to
> >    PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT
> >  - updated commit message to make the quirk clearer.
> > 
> > Let me know your comments and suggestions.
> 
> My opinion FWIW is that the quirk you have is one of the least intrusive
> ways of handling this. Generally in the case of ARM servers, we have a
> difference vs. x86 in that the latter usually have a magic RC at the
> top level that everything sits beneath (and then, presumably, Intel
> do some magic for multi-socket to fudge things over Q/UPI so that
> things look nice and boring to software). On ARM, we're typically
> dealing with third party RC IP that's disjoint from other parts of
> the SoC. We're certainly in the process of bolstering the specs to
> set some expectations and greater guidance around topologies that
> we would like to avoid, so I don't see this getting out of hand.
> 

The ACPI specification[1] and the device tree specification[2] have
provisions for mapping RID ranges under an RC to different SMMUs with
an offset to generate StreamIDs. This is also true for the mapping
from RID to ITS and DeviceID. So having multiple SMMUs/ITSs for
devices under the same RC is not really a quirk.

It is also reasonable to have the traversal looking for aliases to
stop at the point where the SMMU or ITS is attached. The quirk flag
is only needed because the information on where the SMMU or ITS is
attached is not available to the pci_for_each_dma_alias implementation.
Usually this is not an issue, but unfortunately on ThunderX2, there
are PCI and PCI/PCIe bridges above this point which causes the
current code to calculate RIDs incorrectly.

Thanks,
JC.

[1] http://infocenter.arm.com/help/topic/com.arm.doc.den0049b/DEN0049B_IO_Remapping_Table.pdf
[2] https://www.kernel.org/doc/Documentation/devicetree/bindings/pci/pci-iommu.txt 
