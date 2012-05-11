From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 02/13] iommu: IOMMU Groups
Date: Fri, 11 May 2012 17:58:31 -0600
Message-ID: <1336780711.12477.199.camel@bling.home>
References: <20120511222148.30496.68571.stgit@bling.home>
	<20120511225541.30496.34751.stgit@bling.home>
	<20120511233950.GB9335@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20120511233950.GB9335-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Greg KH <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>
Cc: kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, B07421-KZfg59tc24xl57MIdRCFDg@public.gmane.org, aik-sLpHqDYs0B2HXe+LvDLADg@public.gmane.org, benh-XVmvHMARGAS8U2dJNN8I7kB+6BGkLq7r@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, agraf-l3A5Bk7waGM@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, chrisw-69jw2NvuJkxg9hUCZPvPmw@public.gmane.org, B08248-KZfg59tc24xl57MIdRCFDg@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, avi-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, benve-FYB4Gu1CFyUAvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, david-xT8FGy+AXnRB3Ne2BGzF6laj5H9X9Tb+@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Fri, 2012-05-11 at 16:39 -0700, Greg KH wrote:
> On Fri, May 11, 2012 at 04:55:41PM -0600, Alex Williamson wrote:
> > IOMMU device groups are currently a rather vague associative notion
> > with assembly required by the user or user level driver provider to
> > do anything useful.  This patch intends to grow the IOMMU group concept
> > into something a bit more consumable.
> > 
> > To do this, we first create an object representing the group, struct
> > iommu_group.  This structure is allocated (iommu_group_alloc) and
> > filled (iommu_group_add_device) by the iommu driver.  The iommu driver
> > is free to add devices to the group using it's own set of policies.
> > This allows inclusion of devices based on physical hardware or topology
> > limitations of the platform, as well as soft requirements, such as
> > multi-function trust levels or peer-to-peer protection of the
> > interconnects.  Each device may only belong to a single iommu group,
> > which is linked from struct device.iommu_group.  IOMMU groups are
> > maintained using kobject reference counting, allowing for automatic
> > removal of empty, unreferenced groups.  It is the responsibility of
> > the iommu driver to remove devices from the group
> > (iommu_group_remove_device).
> > 
> > IOMMU groups also include a userspace representation in sysfs under
> > /sys/kernel/iommu_groups.  When allocated, each group is given a
> > dynamically assign ID (int).  The ID is managed by the core IOMMU group
> > code to support multiple heterogeneous iommu drivers, which could
> > potentially collide in group naming/numbering.  This also keeps group
> > IDs to small, easily managed values.  A directory is created under
> > /sys/kernel/iommu_groups for each group.  A further subdirectory named
> > "devices" contains links to each device within the group.  The iommu_group
> > file in the device's sysfs directory, which formerly contained a group
> > number when read, is now a link to the iommu group.  Example:
> > 
> > $ ls -l /sys/kernel/iommu_groups/26/devices/
> 
> <snip>
> 
> As you are creating new sysfs files and directories, you need to also
> add the proper Documentation/ABI/ files at the same time.

I'll update.  Thanks,

Alex
