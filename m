From: Vivek Goyal <vgoyal-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH v2] PCI: Reset PCIe devices to stop ongoing DMA
Date: Wed, 31 Jul 2013 15:56:23 -0400
Message-ID: <20130731195622.GC1577@redhat.com>
References: <CAErSpo5u8qGALt6C+tuPYXdd2YgyMH6fnPnA+afUteEZ7kY0iw@mail.gmail.com>
	<51B93221.2040505@jp.fujitsu.com>
	<CAErSpo5tVK-Z3aOdMTzab-S8o5zLVtDOFQ8-LSYpUgbrJSsxuw@mail.gmail.com>
	<51BA7BB6.1080104@jp.fujitsu.com> <51EF7466.20703@jp.fujitsu.com>
	<CAErSpo5B7NzVfxwW3bQnfK+iK+DrRsWQd2Cm14z5PWNnRHWL5w@mail.gmail.com>
	<51F5B966.9080405@jp.fujitsu.com>
	<CAErSpo4JtG5qVJb-nCywe3vkft=-cDeRDKn_V92RCZ-sGXpwbg@mail.gmail.com>
	<51F758B6.9090204@jp.fujitsu.com>
	<CAErSpo7TNhQO0dx_xZvF=dU2fSWTFf8x=xUJcEsbadJkv8ktuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAErSpo7TNhQO0dx_xZvF=dU2fSWTFf8x=xUJcEsbadJkv8ktuQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Haren Myneni <hbabu-r/Jw6+rmf7HQT0dZR+AlfA@public.gmane.org>, "open list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org" <ishii.hironobu-+CUm20s59erQFUHtdCDX3A@public.gmane.org>, "Sumner, William" <bill.sumner-VXdhtT5mjnY@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 30, 2013 at 09:59:16AM -0600, Bjorn Helgaas wrote:
> On Tue, Jul 30, 2013 at 12:09 AM, Takao Indoh
> <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> > (2013/07/29 23:17), Bjorn Helgaas wrote:
> >> On Sun, Jul 28, 2013 at 6:37 PM, Takao Indoh <indou.takao-+CUm20s59erQFUHtdCDX3A@public.gmane.org> wrote:
> >>> (2013/07/26 2:00), Bjorn Helgaas wrote:
> 
> >>>> My point about IOMMU and PCI initialization order doesn't go away just
> >>>> because it doesn't fit "kdump policy."  Having system initialization
> >>>> occur in a logical order is far more important than making kdump work.
> >>>
> >>> My next plan is as follows. I think this is matched to logical order
> >>> on boot.
> >>>
> >>> drivers/pci/pci.c
> >>> - Add function to reset bus, for example, pci_reset_bus(struct pci_bus *bus)
> >>>
> >>> drivers/iommu/intel-iommu.c
> >>> - On initialization, if IOMMU is already enabled, call this bus reset
> >>>    function before disabling and re-enabling IOMMU.
> >>
> >> I raised this issue because of arches like sparc that enumerate the
> >> IOMMU before the PCI devices that use it.  In that situation, I think
> >> you're proposing this:
> >>
> >>    panic kernel
> >>      enable IOMMU
> >>      panic
> >>    kdump kernel
> >>      initialize IOMMU (already enabled)
> >>        pci_reset_bus
> >>        disable IOMMU
> >>        enable IOMMU
> >>      enumerate PCI devices
> >>
> >> But the problem is that when you call pci_reset_bus(), you haven't
> >> enumerated the PCI devices, so you don't know what to reset.
> >
> > Right, so my idea is adding reset code into "intel-iommu.c". intel-iommu
> > initialization is based on the assumption that enumeration of PCI devices
> > is already done. We can find target device from IOMMU page table instead
> > of scanning all devices in pci tree.
> >
> > Therefore, this idea is only for intel-iommu. Other architectures need
> > to implement their own reset code.
> 
> That's my point.  I'm opposed to adding code to PCI when it only
> benefits x86 and we know other arches will need a fundamentally
> different design.  I would rather have a design that can work for all
> arches.

I agree. It makes sense to work on a design which works for all
arches.

And that's when I feel that handling this problem at IOMMU level
makes more sense, if we can.

Thanks
Vivek
