From: "Allan, Bruce W" <bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: DMA_ALIAS_DEVFN issue
Date: Sat, 15 Nov 2014 17:10:47 +0000
Message-ID: <804857E1F29AAC47BF68C404FC60A1846586CE16@ORSMSX105.amr.corp.intel.com>
References: <CAErSpo7m9xMy9buOmF==8H_VSkBBqPZD1_OCPYjEz_1Q1n4y0Q@mail.gmail.com>
	<1416064996.27937.177.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1416064996.27937.177.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> -----Original Message-----
> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Saturday, November 15, 2014 7:23 AM
> To: Bjorn Helgaas
> Cc: Allan, Bruce W; linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; iommu-cunTk1MwBs/ROKNJybVBZg@public.gmane.org
> foundation.org
> Subject: Re: DMA_ALIAS_DEVFN issue
> 
> On Fri, 2014-11-14 at 21:25 -0700, Bjorn Helgaas wrote:
> > [+cc Alex, add a subject]
> >
> > On Fri, Nov 14, 2014 at 6:49 PM, Allan, Bruce W <bruce.w.allan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> wrote:
> > > Let's try this again as plain text...
> > >
> > > For a PCIe device with SR-IOV support enabled (e.g. the PF device ID
> > is 0xf001 at 0000:07:00.0 and the 16 VFs have device ID 0xf002 at
> > 0000:07:01.0 through 0000:07:02.7), if the hardware attempts a DMA
> > read/write of memory that was mapped by the PF devfn but instead uses
> > a requester id of one of the VF devfns (enabled but not yet assigned
> > to a VM) it fails and generates log messages similar to:
> > >
> > > [  416.800881] dmar: DRHD: handling fault status reg 2
> > > [  416.800887] dmar: DMAR:[DMA Read] Request device [07:02.2] fault
> addr ffff0000
> > > DMAR:[fault reason 02] Present bit in context entry is clear
> 
> This is exactly what IOMMU isolation is meant to do.  A buffer mapped
> for one device should not be accessible from another device.  It really
> doesn't matter if the devices are related as VF/PF, VF/VF, or PF/PF.
> 
> > > Shouldn't a DMA alias quirk that sets the
> > PCI_DEV_FLAGS_DMA_ALIAS_DEVFN flag and dma_alias_devfn to the PF
> devfn
> > for all VF devfns work-around this issue, or am I misunderstanding
> > what a DMA alias quirk is supposed to do?  If a DMA alias quirk cannot
> > resolve this, what is the most appropriate way to handle this?
> 
> The buffer needs to be mapped for each VF.  If for some reason the VF
> needs implicit access to a PF mapped buffer then this devices is
> completely broken from an isolation perspective and using DMA aliases to
> fix it means that individual VFs will never be assignable to guests.
> Thanks,
> 
> Alex

Hmm, that...is unfortunate.  Thanks Alex for the clarification, and thanks Bjorn for
adding Alex and a proper subject to the thread.

Bruce.
