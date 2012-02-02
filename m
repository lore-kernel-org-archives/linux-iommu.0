From: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Subject: Re: RFC: Device isolation groups
Date: Thu, 2 Feb 2012 12:24:14 +1100
Message-ID: <20120202012414.GE8700@truffala.fritz.box>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328126919.6937.254.camel@bling.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1328126919.6937.254.camel-xdHQ/5r00wBBDLzU/O5InQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Feb 01, 2012 at 01:08:39PM -0700, Alex Williamson wrote:
> On Wed, 2012-02-01 at 15:46 +1100, David Gibson wrote:
> > This patch series introduces a new infrastructure to the driver core
> > for representing "device isolation groups".  That is, groups of
> > devices which can be "isolated" in such a way that the rest of the
> > system can be protected from them, even in the presence of userspace
> > or a guest OS directly driving the devices.
> > 
> > Isolation will typically be due to an IOMMU which can safely remap DMA
> > and interrupts coming from these devices.  We need to represent whole
> > groups, rather than individual devices, because there are a number of
> > cases where the group can be isolated as a whole, but devices within
> > it cannot be safely isolated from each other - this usually occurs
> > because the IOMMU cannot reliably distinguish which device in the
> > group initiated a transaction.  In other words, isolation groups
> > represent the minimum safe granularity for passthrough to guests or
> > userspace.
> > 
> > This series provides the core infraustrcture for tracking isolation
> > groups, and example implementations initializing the groups
> > appropriately for two PCI bridges (which include IOMMUs) found on IBM
> > POWER systems.
> > 
> > Actually using the group information is not included here, but David
> > Woodhouse has expressed an interest in using a structure like this to
> > represent operations in iommu_ops more correctly.
> > 
> > Some tracking of groups is a prerequisite for safe passthrough of
> > devices to guests or userspace, such as done by VFIO.  Current VFIO
> > patches use the iommu_ops->device_group mechanism for this.  However,
> > that mechanism is awkward, because without an in-kernel concrete
> > representation of groups, enumerating a group requires traversing
> > every device on a given bus type.  It also fails to cover some very
> > plausible IOMMU topologies, because its groups cannot span devices on
> > multiple bus types.
> 
> So far so good, but there's not much meat on the bone yet.

True..

>  The sysfs
> linking and a list of devices in a group is all pretty straight forward
> and obvious.  I'm not sure yet how this solves the DMA quirks kind of
> issues though.

It doesn't, yet.

>  For instance if we have the ricoh device that uses the
> wrong source ID for DMA from function 1 and we put functions 0 & 1 in an
> isolation group... then what?  And who does device quirk grouping?  Each
> IOMMU driver?

I think so.  It'd be nicer to have this in a common place, but I can't
see a reasonable way of doing that - the IOMMU driver really needs to
have control over group allocation.  We can make it easy for the IOMMU
drivers, though by having a common header quirk and flag which the
IOMMU driver can check.

The other thing I'm considering, is if we actually should take a
whitelist approach, rather than a blacklist approach.  Chances are
that when you factor in various debug registers many, maybe most,
multifunction devices won't actually safely isolate the functions from
each other.  So it might be a better approach to have IOMMU drivers
generally treat a single slot as a group unless the specific device is
whitelisted as having function isolation (and SR-IOV VFs would be
whitelisted, of course).

> For the iommu_device_group() interface, I had imagined that we'd have
> something like:
> 
> struct device *device_dma_alias_quirk(struct device *dev)
> {
> 	if (<is broken ricoh func 1)
> 		return <ricoh func0>;
> 
> 	return dev;
> }
> 
> Then iommu_device_group turns into:
> 
> int iommu_device_group(struct device *dev, unsigned int *groupid)
> {
> 	dev = device_dma_alias_quirk(dev);
>         if (iommu_present(dev->bus) && dev->bus->iommu_ops->device_group)
>                 return dev->bus->iommu_ops->device_group(dev, groupid);
> 
>         return -ENODEV;
> }
> 
> and device_dma_alias_quirk() is available for dma_ops too.
> 
> So maybe a struct device_isolation_group not only needs a list of
> devices, but it also needs the representative device to do mappings
> identified.

Perhaps.  For now, I was assuming just taking the first list element
would suffice for these cases.

>  dma_ops would then just use dev->di_group->dma_dev for
> mappings, and I assume we call iommu_alloc() with a di_group and instead
> of iommu_attach/detach_device, we'd have iommu_attach/detach_group?

That's the idea, yes.

> What I'm really curious about is where you now stand on what's going to
> happen in device_isolation_bind().  How do we get from a device in sysfs
> pointing to a group to something like vfio binding to that group and
> creating a chardev to access it?  Are we manipulating automatic driver
> binding or existing bound drivers once a group is bound?  Do isolation
> groups enforce isolation, or just describe it?  Thanks,

So, I'm in the middle of rethinking this in terms of what states the
group can be in.  At minimum we'll need "host kernel" state, where
host drivers bind normally to devices in the group and "opened by
guest" state where the group is in active use by a guest or userspace.
Clearly you can't leave opened by guest state when something has VFIO
fds or equivalents open, and you can't enter opened by guest state
when any host kernel drivers are bound to devices in the group.

We're going to want some transitional states in between those, but
what they should look like is what I'm rethinking.  The previous
drafts had just one state in between; "idle" where host drivers are
excluded from the group but a guest isn't using it yet.  

Both you and David Woodhouse have expressed concern about the
surprisingness of a bunch of host devices vanishing suddenly under
that model.  So that suggests a "leaving host" state where new driver
bounds are prevented, but there might be existing bound drivers.  It
would move to "idle" state when the last host driver is unbound.
Additionally I'm not sure if it makes sense to have a distinction
between "assigned to guest" and "opened by guest" states.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
