From: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Subject: Re: 3.16rc3 multiplatform, Armada 370 and IOMMU: unbootable kernel
Date: Mon, 7 Jul 2014 11:30:02 -0700
Message-ID: <20140707183002.GA5947@kroah.com>
References: <20140703135146.GA6898@luxor.wired.org>
	<53B5C61D.2060308@free-electrons.com>
	<53B5CA26.7050405@free-electrons.com> <1936558.QaAG1bYMuD@avalon>
	<20140705150308.GA28791@arch.cereza>
	<20140705205951.GB3678@kroah.com>
	<20140707105818.GA1101@arch.cereza>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140707105818.GA1101-nAQHv47ARr+vIlHkl8J1cg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Ezequiel Garcia <ezequiel.garcia-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Thomas Petazzoni <thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hiroshi.DOYU-xNZwKgViW5gAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Laurent Pinchart <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, Paolo Pisati <p.pisati-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Gregory CLEMENT <gregory.clement-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Florian Vaussard <florian.vaussard-p8DiymsW2f8@public.gmane.org>, Sebastian Hesselbarth <sebastian.hesselbarth-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Jul 07, 2014 at 07:58:18AM -0300, Ezequiel Garcia wrote:
> On 05 Jul 01:59 PM, Greg Kroah-Hartman wrote:
> > On Sat, Jul 05, 2014 at 12:03:08PM -0300, Ezequiel Garcia wrote:
> > > After following Gregory's stacktrace (also reproduced here):
> > > 
> > > [<c02451f8>] (iommu_bus_notifier) from [<c00512e8>] (notifier_call_chain+0x64/0x9c)
> > > [<c00512e8>] (notifier_call_chain) from [<c00514cc>] (__blocking_notifier_call_chain+0x40/0x58)
> > > [<c00514cc>] (__blocking_notifier_call_chain) from [<c00514f8>] (blocking_notifier_call_chain+0x14/0x1c)
> > > [<c00514f8>] (blocking_notifier_call_chain) from [<c01d225c>] (device_add+0x424/0x524)
> > > [<c01d225c>] (device_add) from [<c0186d90>] (pci_device_add+0xec/0x110)
> > > [<c0186d90>] (pci_device_add) from [<c0186e54>] (pci_scan_single_device+0xa0/0xac)
> > > 
> > > I added a few printks and found that the problem is that the iommu_bus_notifier is
> > > called for the 'pci' bus type, which has a null iommu_ops.
> > > 
> > > On 04 Jul 10:47 AM, Laurent Pinchart wrote:
> > > [..]
> > > > 
> > > > We need a quick fix for v3.16, ...
> > > 
> > > Therefore, a quick fix would be to simply check for that:
> > > 
> > > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > > index e5555fc..b712cb2 100644
> > > --- a/drivers/iommu/iommu.c
> > > +++ b/drivers/iommu/iommu.c
> > > @@ -536,6 +536,9 @@ static int iommu_bus_notifier(struct notifier_block *nb,
> > >         struct iommu_group *group;
> > >         unsigned long group_action = 0;
> > >  
> > > +       if (!ops)
> > > +               return 0;
> > > +
> > >         /*
> > >          * ADD/DEL call into iommu driver ops if provided, which may
> > >          * result in ADD/DEL notifiers to group->notifier
> > > 
> > > This (nasty workaround?) patch makes the problem go away.
> > > 
> > > [..]
> > > > > So it also boot well in 3.15 and then failed in 3.16-rc3. I hope it will
> > > > > help the developers of the OMAP IOMMU driver to fix it.
> > > > 
> > > > Thank you. I've had a look at the OMAP IOMMU driver changes between v3.15 and 
> > > > v3.16-rc3, and didn't find at first sight any change that could explain the 
> > > > crash.
> > > > 
> > > > 286f600 iommu/omap: Fix map protection value handling
> > > > 67b779d iommu/omap: Remove comment about supporting single page mappings only
> > > > f7129a0 iommu/omap: Fix 'no page for' debug message in flush_iotlb_page()
> > > > 5acc97d iommu/omap: Move to_iommu definition from omap-iopgtable.h
> > > > 2ac6133 iommu/omap: Remove omap_iommu_domain_has_cap() function
> > > > d760e3e iommu/omap: Correct init value of iotlb_entry valid field
> > > > 
> > > > Could you try reverting those changes and retest ? If the problem doesn't 
> > > > disappear, we'll need to look somewhere else.
> > > > 
> > > 
> > > I reverted the above commits but nothing changed. I'm far from being an expert,
> > > but it sounds odd to have this bus notifier (that got registered for the
> > > platform bus type) called by a pci bus type.
> > 
> > Why wouldn't the PCI bus set this up for its devices?  Are you
> > "assuming" you know the bus type and that's the issue?
> > 
> 
> Thanks for looking at this.
> 
> I guess I snipped the thread and lost most of the information about the panic.
> Here's the original bug report:
> 
> http://www.spinics.net/lists/arm-kernel/msg344059.html
> 
> The problem reported involves enabling OMAP IOMMU driver and not any other IOMMU
> driver. Doing some tracing and adding a few prints, we found that
> omap_iommu_init() sets a bus notifier for the platform bus type:
> 
> omap_iommu_init -> bus_set_iommu -> iommu_bus_init:
> 
> static void iommu_bus_init(struct bus_type *bus, struct iommu_ops *ops)
> {
>         bus_register_notifier(bus, &iommu_bus_nb);
>         bus_for_each_dev(bus, NULL, ops, add_iommu_group);
> }
> 
> But the iommu bus notifier gets called for the 'pci' bus type, which
> has the iommu_ops field NULL (since it hasn't been set for iommu).

So this is what needs to be figured out, how is the notifier being
called with a PCI device?  Who else called iommu_bus_init() for the PCI
bus?

thanks,

greg k-h
