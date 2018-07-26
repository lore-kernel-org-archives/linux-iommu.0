From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated devices
Date: Thu, 26 Jul 2018 03:03:37 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1912826A4@SHSMSX101.ccr.corp.intel.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
	<5B568D5B.5050606@linux.intel.com>
	<ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
	<a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <a530c220-9bf1-05ec-5698-526ccbea127f-5wv7dgnIgG8@public.gmane.org>
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

> From: Jean-Philippe Brucker [mailto:jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org]
> Sent: Thursday, July 26, 2018 3:20 AM
> 
> On 25/07/18 07:19, Tian, Kevin wrote:
> >> From: Tian, Kevin
> >> Sent: Wednesday, July 25, 2018 10:16 AM
> >>
> > [...]
> >>>
> >>> There is another way: as we're planning to add a generic pasid_alloc()
> >>> function to the IOMMU API, the mdev module itself could allocate a
> >>> default PASID for each mdev by calling pasid_alloc() on the mdev's
> >>> parent, and then do map()/unmap() with that PASID. This way we don't
> >>> have to add IOMMU ops to the mdev bus, everything can still be done
> >>> using the ops of the parent. And IOMMU drivers "only" have to
> >> implement
> >>> PASID ops, which will be reused by drivers other than mdev.
> >>
> >> yes, PASID is more general abstraction than mdev. However there is
> >> one problem. Please note with new scalable mode now PASID is not
> >> used just for SVA. You can do 1st-level, 2nd-level and nested in PASID
> >> granularity, meaning each PASID can be bound to an unique iommu
> >> domain. However today IOMMU driver allows only one iommu_domain
> >> per device. If we simply install allocated PASID to parent device, we
> >> should also remove that iommu_domain limitation. Is it the way that
> >> we want to pursue?
> >>
> >> mdev avoids such problem as it introduces a separate device...
> >
> > another thing to think about is to simplify the caller logic. It would
> > be good to have consistent IOMMU APIs cross PCI device and
> > mdev, for common VFIO operations e.g. map/unmap, iommu_
> > attach_group, etc. If we need special version ops with PASID, it
> > brings burden to VFIO and other IOMMU clients...
> 
> Yes, providing special ops is the simplest to implement (or least
> invasive, I guess) but isn't particularly elegant. See the patch from
> Jordan below, that I was planning to add to the SVA series (I'm
> laboriously working towards next version) and my email from last week:
> https://patchwork.kernel.org/patch/10412251/
> 
> Whenever I come back to hierarchical IOMMU domains I reject it as too
> complicated, but maybe that is what we need. I find it difficult to
> reason about because domains currently represent both a collection of
> devices and a one or more address spaces. I proposed the io_mm thing to
> represent a single address space, and to avoid adding special cases to
> every function in the IOMMU subsystem that manipulates domains.

I suppose io_mm is still under iommu_domain, right? this is different
from hierarchical iommu domain concept...

> 
> > For IOMMU-capable mdev, there are two use cases which have
> > been talked so far:
> >
> > 1) mdev with PASID-granular DMA isolation
> > 2) mdev inheriting RID from parent device (no sharing)
> 
> Would that be a single mdev per parent device? Otherwise I don't really
> understand how it would work without all map/unmap operations going to
> the parent device's driver.

yes, that is why I said "no sharing". In that special case, host driver 
itself doesn't do DMA. Only the mdev does. 

> 
> > 1) is what this RFC is currently for. 2) is what Alex concerned
> > which is not covered in RFC yet.
> >
> > In my mind, an ideal design is like below:
> >
> > a) VFIO provides an interface for parent driver to specify
> > whether a mdev is IOMMU capable, with flag to indicate
> > whether it's PASID-granular or RID-inherit;
> >
> > b) Once an IOMMU-capable mdev is created, VFIO treats it no
> > different from normal physical devices, using exactly same
> > IOMMU APIs to operate (including future SVA). VFIO doesn't
> > care whether PASID or RID will be used in hardware;
> >
> > c) IOMMU driver then handle RID/PASID difference internally,
> > based on its own configuration and mdev type.
> >
> > To support above goal, I feel a new device handle is a nice fit
> > to represent mdev within IOMMU driver, with same set of
> > capabilities as observed on its parent device.
> 
> It's a good abstraction, but I'm still concerned about other users of
> PASID-granular DMA isolation, for example GPU drivers wanting to improve
> isolation of DMA bufs, will want the same functionality without going
> through the vfio-mdev module.

for GPU I think you meant SVA. that one anyway needs its own 
interface as what we have been discussing in yours and Jacob's
series.

Here mdev is orthogonal to a specific capability like SVA. It is 
sort of logical representation of subset resource of parent device,
on top of which we can enable IOMMU capabilities including SVA.

I'm not sure whether it is good to combine two requirements closely...

> 
> The IOMMU operations we care about don't take a device handle, I think,
> just a domain. And VFIO itself only deals with domains when doing
> map/unmap. Maybe we could add this operation to the IOMMU subsystem:
> 
> child_domain = domain_create_child(parent_dev, parent_domain)
> 
> A child domain would be a smaller isolation granule, getting a PASID if
> that's what the IOMMU implements or another mechanism for 2). It is
> automatically attached to its parent's devices, so attach/detach
> operations wouldn't be necessary on the child.
> 
> Depending on the underlying architecture the child domain can support
> map/unmap on a single stage, or map/unmap for 2nd level and
> bind_pgtable
> for 1st level.
> 
> I'm not sure how this works for host SVA though. I think the
> sva_bind_dev() API could stay the same, but the internals will need
> to change.
> 

hierarchical domain might be the right way to go, but let's do more
thinking on any corner cases. 

One open is whether iommu domain can fully carry all required 
attributes on mdev. Note today for physical device each vendor 
driver maintains a device structure for device specific info which 
may impact IOMMU setting (e.g. struct device_domain_info in 
intel-iommu, and struct arm_smmu_device in arm-smmu). If we 
want mdev to have a different attribute as its parent device, then 
new representation might be required. But honestly speaking I 
don't think it is a valid requirement now, since physically finally
it is still the IOMMU structure of parent device being configured,
so mdev should just inherit same attributes as parent. If the role 
of mdev representation in current RFC is just to connect iommu_
domain when hierarchical domain is missing, then we might 
instead just make the latter happen...

Let's think more on this direction. btw can you elaborate any 
other complexities when you evaluated this option earlier?

Thanks
Kevin
