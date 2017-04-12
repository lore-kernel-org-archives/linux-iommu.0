From: Jayachandran C <jnair-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v4 2/2] PCI: quirks: Fix ThunderX2 dma alias handling
Date: Wed, 12 Apr 2017 18:10:34 +0000
Message-ID: <20170412181034.GA3671@localhost>
References: <1491225304-3559-1-git-send-email-jnair@caviumnetworks.com>
	<1491225304-3559-3-git-send-email-jnair@caviumnetworks.com>
	<20170411012847.GA15291@bhelgaas-glaptop.roam.corp.google.com>
	<20170411071047.GA3610@localhost>
	<20170411134125.GA31773@bhelgaas-glaptop.roam.corp.google.com>
	<20170411152702.GA2910@localhost>
	<20170412162118.GC25197@bhelgaas-glaptop.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170412162118.GC25197-1RhO1Y9PlrlHTL0Zs8A6p5iNqAH0jzoTYJqu5kTmcBRl57MIdRCFDg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <helgaas-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Jon Masters <jcm-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 12, 2017 at 11:21:18AM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2017 at 03:27:02PM +0000, Jayachandran C wrote:
> > On Tue, Apr 11, 2017 at 08:41:25AM -0500, Bjorn Helgaas wrote:
> > > [+cc Joerg]
> > > 
> > > On Tue, Apr 11, 2017 at 07:10:48AM +0000, Jayachandran C wrote:
> > > > On Mon, Apr 10, 2017 at 08:28:47PM -0500, Bjorn Helgaas wrote:
> > > > > Hi Jayachandran,
> > > > > 
> > > > > On Mon, Apr 03, 2017 at 01:15:04PM +0000, Jayachandran C wrote:
> > > > > > The Cavium ThunderX2 arm64 SoCs (called Broadcom Vulcan earlier), the PCI
> > > > > > topology is slightly unusual. For a multi-node system, it looks like:
> > > > > > 
> > > > > > [node level PCI bridges - one per node]
> > > > > >     [SoC PCI devices with MSI-X but no IOMMU]
> > > > > >     [PCI-PCIe "glue" bridges - upto 14, one per real port below]
> > > > > >         [PCIe real root ports associated with IOMMU and GICv3 ITS]
> > > > > >             [External PCI devices connected to PCIe links]
> > > > > > 
> > > > > > The top two levels of bridges should have introduced aliases since they
> > > > > > are PCI and PCI/PCIe bridges, but in the case of ThunderX2 they do not.
> > > > > > In the case of external PCIe devices, the "real" root ports are connected
> > > > > > to the SMMU and the GIC ITS, so PCI-PCIe bridge does not introduce an
> > > > > > alias. The SoC PCI devices are directly connected to the GIC ITS, so the
> > > > > > node level bridges do not introduce an alias either.
> > > > > > 
> > > > > > To handle this quirk, we mark the real PCIe root ports and node level
> > > > > > PCI bridges with the flag PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT.  With this,
> > > > > > pci_for_each_dma_alias() works correctly for external PCIe devices and
> > > > > > SoC PCI devices.
> > > > > > 
> > > > > > For the current revision of Cavium ThunderX2, the VendorID and Device ID
> > > > > > are from Broadcom Vulcan (14e4:90XX).
> > > > > 
> > > > > Can you supply some text here about why we want to apply this patch?
> > > > > E.g., does it avoid making unnecessary IOMMU mappings, improve
> > > > > performance, avoid a crash, etc?
> > > > 
> > > > If this is for the commit message, I hope the following is ok:
> > > > 
> > > > "With this change, both MSI-X and IO virtualization work correctly on
> > > > Cavium ThunderX2. The GIC ITS driver gets the correct device ID to
> > > > configure MSI-X, the SMMUv3 driver gets the correct Stream IDs for PCI
> > > > devices, and the IOMMU groups are setup correctly."
> > > 
> > > This doesn't get at what the actual problem is.  I'm hoping for
> > > something like "without this change, we set up an IOMMU mapping for
> > > requestor ID X, but device DMA uses requestor ID Y because ...., which
> > > results in an IOMMU fault"
> > 
> > Ok. I hope this would be better:
> > 
> > "Without this change, the last alias seen while traversing the PCI
> > hierarchy will be used as the RID to generate the device ID for ITS
> > and stream ID for SMMU. This in turn causes the MSI-X generated by the
> > device to fail since the ITS expects to have translation tables based
> > on the actual PCIe RID and not the (irrelevant) alias. Similarly, the
> > device DMA also fails when SMMU is enabled due to incorrect value in
> > SMMU translation tables"
> 
> This description is true, but I don't think it addresses the real
> problem.  I think the real problem is that your IOMMU code doesn't
> handle aliases correctly, and by ignoring these invalid aliases, we
> happen to map an alias that works for the builtin devices.  But that's
> only because we got lucky (those devices use a single RID and they're
> not behind bridges that optionally take ownership).
> 
> It would make sense to me if we fixed the IOMMU code to map *all* the
> aliases, which should be enough to make your devices work.  If we then
> wanted to apply a patch like this on top, it would be simply an
> optimization that avoids unnecessary IOMMU mappings.

The issue that the IOMMU code does not handle valid aliases is
unrelated to what I am trying to fix. The quirk is to make sure
that invalid aliases are not seen on ThunderX2 while doing
pci_for_each_dma_alias().

The DMA and MSI-X requests leave the PCI/PCIe hierarchy at the point
where the SMMU (or ITS) is attached, i.e. at the bridge marked with
PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT. The quirk ensures that we don't look
for aliases above that point.

The toplevel bridge is marked PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT since
the on-chip devices are directly connected to the ITS (they do not
use SMMU).

The top two levels of bridges are not real PCI bridges but just
PCI bridge-like things that were added to tie the whole hierarchy
together for configuration and enumeration. They do not handle
PCI/PCIe transactions in the traditional sense.

I think my problem description is still not correct, maybe:
"The SMMU (and ITS) expects to device tables to use the RID seen
at the bridge they are associated with. Currently the
pci_for_each_dma_alias() code traverses beyond this point and
generates incorrect aliases due to the PCI and PCI/PCIe bridges
above. This causes MSI-X interrupts and device DMA to fail since
the SMMU and ITS tables to be setup with incorrect IDs"

> > > I suspect the reason this patch makes a difference is because the
> > > current pci_for_each_dma_alias() believes one of those top-level
> > > bridges is an alias, and the iterator produces it last, so that's the
> > > one you map.  The IOMMU is attached lower down, so that top-level
> > > bridge is not in fact an alias, but since you only look at the *last*
> > > one, you don't map the correct aliases from lower down in the tree.
> > 
> > Exactly. The IORT spec allows a range of RIDs to map to an SMMU, which
> > means that a PCI RC can multiple SMMUs, each handling a subset of RIDs.
> > 
> > In the case of Cavium ThunderX2, the RID which we should see on the RC
> > - if we follow the standard and factor in the aliasing introduced by the
> > PCI bridge and the PCI/PCIe bridge - is not the RID seen by the SMMU (or
> > ITS).
> > 
> > But, if we stop the traversal at the point where SMMU (or ITS) is
> > attached, we will get the correct RID as seen by these.
> 
> There is a single "correct RID" for your builtin SATA and USB, but in
> general there is no single RID.

In case of external PCIe devices too, the RID (or aliases) seen to the
point where SMMU or ITS is connected (i.e, the bridge marked with flag
PCI_DEV_FLAGS_BRIDGE_XLATE_ROOT) are correct.
 
> > > Stopping the iterator earlier happens to make the last alias be one of
> > > the correct ones, but it doesn't solve the problems of quirked devices
> > > that can use multiple requester IDs, and it doesn't solve the problem
> > > of PCIe-to-PCI bridges that optionally take ownership of transactions.
> >  
> > If these happen below the point where the SMMU is attached, we will
> > consider the last alias introduced, which should be ok. If they are
> > above, the alias introduced is not relevant.  Devices with multiple
> > aliases is not handled anywhere in ARM code, so I don't think we should
> > consider that here.
> 
> I think we *should* consider it here.  The multiple alias situation is
> generic PCIe, independent of ARM.  If you want to support arbitrary
> PCIe plugin devices, you have to handle it.  I think any device with a
> quirk that calls pci_add_dma_alias() will currently fail on your
> system.  And I think devices behind a bridge that optionally takes
> ownership of DMA transactions will also fail.
 
The issue that IOMMU code does not handle all aliases has to be addressed
separately (and Robin seems to be looking at this from his response).

And even when that is addressed, this quirk is still needed on ThunderX2,
as I pointed out above.

Hope I am still not missing the point, and thanks for your patience here.
JC.
