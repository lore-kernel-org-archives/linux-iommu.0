From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated devices
Date: Wed, 25 Jul 2018 02:16:00 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19127FB94@SHSMSX101.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
	<5B568D5B.5050606@linux.intel.com>
	<ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <ccf6890a-30c6-770b-4299-8cabfdc32f2b-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker
> Sent: Tuesday, July 24, 2018 7:31 PM
> 
> Hi Baolu,
> 
> On 24/07/18 03:22, Lu Baolu wrote:
> > Hi,
> >
> > On 07/23/2018 12:44 PM, Liu, Yi L wrote:
> >>> From: Lu Baolu [mailto:baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org]
> >>> Sent: Sunday, July 22, 2018 2:09 PM
> >>>
> >>> With the Intel IOMMU supporting PASID granularity isolation and
> protection, a
> >>> mediated device could be isolated and protected by an IOMMU unit.
> We need to
> >>> allocate a new group instead of a PCI group.
> >> Existing vfio mdev framework also allocates an iommu group for
> mediate device.
> >>
> >> mdev_probe()
> >>   |_ mdev_attach_iommu()
> >>        |_ iommu_group_alloc()
> >
> > When external components ask iommu to allocate a group for a device,
> > it will call pci_device_group in Intel IOMMU driver's @device_group
> > callback. In another word, current Intel IOMMU driver doesn't aware
> > the mediated device and treat all devices as PCI ones. This patch
> > extends the @device_group call back to make it aware of a mediated
> > device.
> 
> I agree that allocating two groups for an mdev seems strange, and in my
> opinion we shouldn't export the notion of mdev to IOMMU drivers.
> Otherwise each driver will have to add its own "dev_is_mdev()" special
> cases, which will get messy in the long run. Besides, the macro is
> currently private, and to be exported it should be wrapped in
> symbol_get/put(mdev_bus_type).

There is only one group per mdev, but I agree that avoiding mdev
awareness in IOMMU driver is definitely good... We didn't find a
good way before, which is why current RFC was implemented that 
way.

> 
> There is another way: as we're planning to add a generic pasid_alloc()
> function to the IOMMU API, the mdev module itself could allocate a
> default PASID for each mdev by calling pasid_alloc() on the mdev's
> parent, and then do map()/unmap() with that PASID. This way we don't
> have to add IOMMU ops to the mdev bus, everything can still be done
> using the ops of the parent. And IOMMU drivers "only" have to implement
> PASID ops, which will be reused by drivers other than mdev.

yes, PASID is more general abstraction than mdev. However there is
one problem. Please note with new scalable mode now PASID is not
used just for SVA. You can do 1st-level, 2nd-level and nested in PASID
granularity, meaning each PASID can be bound to an unique iommu
domain. However today IOMMU driver allows only one iommu_domain 
per device. If we simply install allocated PASID to parent device, we 
should also remove that iommu_domain limitation. Is it the way that
we want to pursue?

mdev avoids such problem as it introduces a separate device...

> 
> The allocated PASID also needs to be installed into the parent device.
> If the mdev module knows the PASID, we can do that by adding
> set_pasid(mdev, pasid) and clear_pasid(mdev, pasid) operations to
> mdev_parent_ops.
> 

Thanks
Kevin
