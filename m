From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2 00/15] PCI/iommu: Fix DMA alias problems
Date: Thu, 15 May 2014 11:43:54 -0600
Message-ID: <1400175834.3289.65.camel@ul30vt.home>
References: <20140509151735.8321.22017.stgit@bling.home>
	<CAJtEV7YYB4W_+nZeMgiqZVDV+M4OyFJVBic09z=KbMjOpihnTQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAJtEV7YYB4W_+nZeMgiqZVDV+M4OyFJVBic09z=KbMjOpihnTQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Andrew Cooks <acooks-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>, "open list:PCI SUBSYSTEM" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open list:INTEL
	IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Thu, 2014-05-15 at 07:40 +0800, Andrew Cooks wrote:
> Hi Alex
> 
> On Fri, May 9, 2014 at 11:28 PM, Alex Williamson
> <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> > ....
> >
> > Original description:
> >
> > This series attempts to fix a couple issues we've had outstanding in
> > the PCI/IOMMU code for a while.  The first issue is with devices that
> > use the wrong requester ID for DMA transactions.  We already have a
> > sort of half-baked attempt to fix this for several Ricoh devices, but
> > the fix only helps them be useful through IOMMU groups, not the
> > general DMA case.  There are also several Marvell devices which use
> > use a different wrong requester ID and don't even fit into the DMA
> > source idea.  This series creates a DMA alias iterator that will
> > step through each possible alias of a device, allowing IOMMUs to
> > insert mappings for both the device and its aliases.
> >
> > Hand-in-hand with this is our broken pci_find_upstream_pcie_bridge()
> > function, which is known to blowup when it finds itself suddenly at
> > a PCIe device without crossing a PCIe-to-PCI bridge (as identified by
> > the PCIe capability).  It also likes to make the invalid assumption
> > that a PCIe device never has its requester ID masked by any usptream
> > bus.  We can fix this using the above new DMA alias iterator, since
> > that's effectively what this function was meant to do.
> >
> 
> There are two cases where the DMA requester id seems to use the wrong
> slot (as opposed to function) in the patch I attached to
> https://bugzilla.kernel.org/show_bug.cgi?id=42679
> The original bug reports are listed in the patch.
> 
> Unfortunately, I wasn't able to get test feedback on those two cases,
> but I'm wondering...
> Did I understand correctly that a slot alias is something that could be needed?
> If so, is it a variation of the PCIe-to-PCI bridge case that's already
> covered or will it require a different approach?

Wow, I didn't think that kind of broken was possible.  Maybe instead of
a bitmap of function aliases we could have a single devfn alias for a
device.  That means we'd only be able to support a single alias for a
device, but since I don't think we've seen devices that use more than a
single alias, maybe that's ok.  I'll see what changes we'd need to make
for that, but I probably won't go adding the actual quirk based on those
old reports.  Thanks,

Alex
