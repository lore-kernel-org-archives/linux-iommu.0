From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 21/33] iommu/vt-d: Make get_domain_for_dev() take struct
	device
Date: Mon, 14 Apr 2014 15:52:52 -0600
Message-ID: <1397512372.3060.16.camel@ul30vt.home>
References: <1395422354-19762-1-git-send-email-David.Woodhouse@intel.com>
	<1395422354-19762-22-git-send-email-David.Woodhouse@intel.com>
	<1397510541.3060.15.camel@ul30vt.home>
	<1397511643.19944.217.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1397511643.19944.217.camel-Fexsq3y4057IgHVZqg5X0TlWvGAXklZc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "Woodhouse, David" <david.woodhouse-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, 2014-04-14 at 21:40 +0000, Woodhouse, David wrote:
> On Mon, 2014-04-14 at 15:22 -0600, Alex Williamson wrote:
> > 
> > > +             if (dev_tmp) {
> > > +                     if (pci_is_pcie(dev_tmp)) {
> > > +                             bridge_bus = dev_tmp->subordinate->number;
> > > +                             bridge_devfn = 0;
> > > +                     } else {
> > > +                             bridge_bus = dev_tmp->bus->number;
> > > +                             bridge_devfn = dev_tmp->devfn;
> > > +                     }
> > > +                     spin_lock_irqsave(&device_domain_lock, flags);
> > > +                     info = dmar_search_domain_by_dev_info(segment, bus, devfn);
> > 
> > 
> > bus and devfn are uninitialized here, CID 1197747 & 1197746.  Thanks,
> 
> Oops. That should be using bridge_bus and bridge_devfn, shouldn't it?
> 
> Will fix; thanks.
> 

Yep, I think it was supposed to be bridge_*.  Thanks,

Alex
