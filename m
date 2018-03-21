From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [PATCH v5 0/7] vfio/type1: Add support for valid iova list
	management
Date: Wed, 21 Mar 2018 03:28:16 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191089B15@SHSMSX101.ccr.corp.intel.com>
References: <20180315163509.17740-1-shameerali.kolothum.thodi@huawei.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19108585F@SHSMSX101.ccr.corp.intel.com>
	<20180320165514.0f4cd556@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180320165514.0f4cd556-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
To: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org" <pmorel-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org" <xuwei5-C8/M+/jPZTeaMJb+Lgu22Q@public.gmane.org>, "linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org" <linuxarm-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Alex Williamson [mailto:alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org]
> Sent: Wednesday, March 21, 2018 6:55 AM
> 
> On Mon, 19 Mar 2018 08:28:32 +0000
> "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org> wrote:
> 
> > > From: Shameer Kolothum
> > > Sent: Friday, March 16, 2018 12:35 AM
> > >
> > > This series introduces an iova list associated with a vfio
> > > iommu. The list is kept updated taking care of iommu apertures,
> > > and reserved regions. Also this series adds checks for any conflict
> > > with existing dma mappings whenever a new device group is attached
> to
> > > the domain.
> > >
> > > User-space can retrieve valid iova ranges using
> VFIO_IOMMU_GET_INFO
> > > ioctl capability chains. Any dma map request outside the valid iova
> > > range will be rejected.
> >
> > GET_INFO is done at initialization time which is good for cold attached
> > devices. If a hotplugged device may cause change of valid iova ranges
> > at run-time, then there could be potential problem (which however is
> > difficult for user space or orchestration stack to figure out in advance)
> > Can we do some extension like below to make hotplug case cleaner?
> 
> Let's be clear what we mean by hotplug here, as I see it, the only
> relevant hotplug would be a physical device, hot added to the host,
> which becomes a member of an existing, in-use IOMMU group.  If, on the
> other hand, we're talking about hotplug related to the user process,
> there's nothing asynchronous about that.  For instance in the QEMU
> case, QEMU must add the group to the container, at which point it can
> evaluate the new iova list and remove the group from the container if
> it doesn't like the result.  So what would be a case of the available
> iova list for a group changing as a result of adding a device?

My original thought was about the latter case. At that moment 
I was not sure whether the window between adding/removing 
the group may cause some issue if there are right some IOVA 
allocations happening in parallel. But looks Qemu can anyway
handle it well as long as such scenario is considered.

> 
> > - An interface allowing user space to request VFIO rejecting further
> > attach_group if doing so may cause iova range change. e.g. Qemu can
> > do such request once completing initial GET_INFO;
> 
> For the latter case above, it seems unnecessary, QEMU can revert the
> attach, we're only promising that the attach won't interfere with
> existing mappings.  For the host hotplug case, the user has no control,
> the new device is a member of the iommu group and therefore necessarily
> becomes a part of container.  I imagine there are plenty of other holes
> in this scenario already.
> 
> > - or an event notification to user space upon change of valid iova
> > ranges when attaching a new device at run-time. It goes one step
> > further - even attach may cause iova range change, it may still
> > succeed as long as Qemu hasn't allocated any iova in impacted
> > range
> 
> Same as above, in the QEMU hotplug case, the user is orchestrating the
> adding of the group to the container, they can then check the iommu
> info on their own and determine what, if any, changes are relevant to
> them, knowing that the addition would not succeed if any current
> mappings where affected.  In the host case, a notification would be
> required, but we'd first need to identify exactly how the iova list can
> change asynchronous to the user doing anything.  Thanks,

for host hotplug, possibly notification could be an opt-in model.
meaning if user space doesn't explicitly request receiving notification 
on such event, the device is just left in unused state (vfio-pci still
claims the device, assuming it assigned to the container owner, but
the owner doesn't use it)

Thanks
Kevin
