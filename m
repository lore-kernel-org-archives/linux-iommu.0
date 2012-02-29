From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: RFC: Device isolation groups
Date: Wed, 29 Feb 2012 12:30:55 -0700
Message-ID: <1330543855.29701.180.camel@bling.home>
References: <1328071614-8320-1-git-send-email-david@gibson.dropbear.id.au>
	<1328126919.6937.254.camel@bling.home>
	<20120202012414.GE8700@truffala.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120202012414.GE8700-MK4v0fQdeXQXU02nzanrWNbf9cGiqdzd@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: David Gibson <david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, 2012-02-02 at 12:24 +1100, David Gibson wrote:
> On Wed, Feb 01, 2012 at 01:08:39PM -0700, Alex Williamson wrote:
> > On Wed, 2012-02-01 at 15:46 +1100, David Gibson wrote:
> > > This patch series introduces a new infrastructure to the driver core
> > > for representing "device isolation groups".  That is, groups of
> > > devices which can be "isolated" in such a way that the rest of the
> > > system can be protected from them, even in the presence of userspace
> > > or a guest OS directly driving the devices.
> > > 
> > > Isolation will typically be due to an IOMMU which can safely remap DMA
> > > and interrupts coming from these devices.  We need to represent whole
> > > groups, rather than individual devices, because there are a number of
> > > cases where the group can be isolated as a whole, but devices within
> > > it cannot be safely isolated from each other - this usually occurs
> > > because the IOMMU cannot reliably distinguish which device in the
> > > group initiated a transaction.  In other words, isolation groups
> > > represent the minimum safe granularity for passthrough to guests or
> > > userspace.
> > > 
> > > This series provides the core infraustrcture for tracking isolation
> > > groups, and example implementations initializing the groups
> > > appropriately for two PCI bridges (which include IOMMUs) found on IBM
> > > POWER systems.
> > > 
> > > Actually using the group information is not included here, but David
> > > Woodhouse has expressed an interest in using a structure like this to
> > > represent operations in iommu_ops more correctly.
> > > 
> > > Some tracking of groups is a prerequisite for safe passthrough of
> > > devices to guests or userspace, such as done by VFIO.  Current VFIO
> > > patches use the iommu_ops->device_group mechanism for this.  However,
> > > that mechanism is awkward, because without an in-kernel concrete
> > > representation of groups, enumerating a group requires traversing
> > > every device on a given bus type.  It also fails to cover some very
> > > plausible IOMMU topologies, because its groups cannot span devices on
> > > multiple bus types.
> > 
> > So far so good, but there's not much meat on the bone yet.
> 
> True..

Any update to this series?  It would be great if we could map out the
functionality to the point of breaking down and distributing work... or
determining if the end result has any value add to what VFIO already
does.  Thanks,

Alex
