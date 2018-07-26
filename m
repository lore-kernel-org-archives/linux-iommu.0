From: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 03/10] iommu/vt-d: Allocate groups for mediated devices
Date: Thu, 26 Jul 2018 16:09:07 +0100
Message-ID: <7ac82074-0c75-e099-365a-73ba19949ab3@arm.com>
References: <1532239773-15325-1-git-send-email-baolu.lu@linux.intel.com>
	<1532239773-15325-4-git-send-email-baolu.lu@linux.intel.com>
	<A2975661238FB949B60364EF0F2C257439CA143E@SHSMSX104.ccr.corp.intel.com>
	<5B568D5B.5050606@linux.intel.com>
	<ccf6890a-30c6-770b-4299-8cabfdc32f2b@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FB9E@SHSMSX101.ccr.corp.intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19127FF05@SHSMSX101.ccr.corp.intel.com>
	<a530c220-9bf1-05ec-5698-526ccbea127f@arm.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D1912826A4@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D1912826A4-0J0gbvR4kThpB2pF5aRoyrfspsVTdybXVpNB7YpNyf8@public.gmane.org>
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
To: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "Liu, Yi L" <yi.l.liu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Kumar,
	Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 26/07/18 04:03, Tian, Kevin wrote:
>> Whenever I come back to hierarchical IOMMU domains I reject it as too
>> complicated, but maybe that is what we need. I find it difficult to
>> reason about because domains currently represent both a collection of
>> devices and a one or more address spaces. I proposed the io_mm thing to
>> represent a single address space, and to avoid adding special cases to
>> every function in the IOMMU subsystem that manipulates domains.
> 
> I suppose io_mm is still under iommu_domain, right? this is different
> from hierarchical iommu domain concept...

Yes, my initial solution is io_mm attached to domains, but in the rest
of the mail yesterday I tried to explore a way to replace io_mm with
child domains instead. In my current patches, io_mm when used for
private PASIDs is basically a lightweight child domain. I don't know
which solution is best or if mdev-aware IOMMU is still preferable. For
the moment I'll keep the private PASID proposal that uses io_mm, until
we've thought a bit more about this.

[...]
>> It's a good abstraction, but I'm still concerned about other users of
>> PASID-granular DMA isolation, for example GPU drivers wanting to improve
>> isolation of DMA bufs, will want the same functionality without going
>> through the vfio-mdev module.
> 
> for GPU I think you meant SVA. that one anyway needs its own 
> interface as what we have been discussing in yours and Jacob's
> series.

Actually I didn't mean SVA. People would like to allocate PASIDs in
kernel drivers and do iommu_map/unmap on them, without binding process
address spaces. Not counting hardware validation, I've actually seen
more demand for private PASID management than for SVA.

See for example the discussion on RFCv2 of SVA, or Jordan's series:
https://www.spinics.net/lists/arm-kernel/msg611038.html
https://lwn.net/Articles/747889/

It would be good if mdev and non-mdev could reuse most of the same code
for private PASID, whatever it turns out to be

> Here mdev is orthogonal to a specific capability like SVA. It is 
> sort of logical representation of subset resource of parent device,
> on top of which we can enable IOMMU capabilities including SVA.
> 
> I'm not sure whether it is good to combine two requirements closely...
> 
>>
>> The IOMMU operations we care about don't take a device handle, I think,
>> just a domain. And VFIO itself only deals with domains when doing
>> map/unmap. Maybe we could add this operation to the IOMMU subsystem:
>>
>> child_domain = domain_create_child(parent_dev, parent_domain)
>>
>> A child domain would be a smaller isolation granule, getting a PASID if
>> that's what the IOMMU implements or another mechanism for 2). It is
>> automatically attached to its parent's devices, so attach/detach
>> operations wouldn't be necessary on the child.
>>
>> Depending on the underlying architecture the child domain can support
>> map/unmap on a single stage, or map/unmap for 2nd level and
>> bind_pgtable
>> for 1st level.
>>
>> I'm not sure how this works for host SVA though. I think the
>> sva_bind_dev() API could stay the same, but the internals will need
>> to change.

Thinking more about this, the SVA case seems a bit nasty. If we replaced
io_mm with iommu_domain for SVA, a child domain would represent a single
process address space, and therefore have multiple parent domains... Not
sure we should go down that road. Maybe we should keep SVA separate, and
keep io_mm to be a wrapper for mm_struct


> hierarchical domain might be the right way to go, but let's do more
> thinking on any corner cases. 
> 
> One open is whether iommu domain can fully carry all required 
> attributes on mdev. Note today for physical device each vendor 
> driver maintains a device structure for device specific info which 
> may impact IOMMU setting (e.g. struct device_domain_info in 
> intel-iommu, and struct arm_smmu_device in arm-smmu). If we 
> want mdev to have a different attribute as its parent device, then 
> new representation might be required. But honestly speaking I 
> don't think it is a valid requirement now, since physically finally
> it is still the IOMMU structure of parent device being configured,
> so mdev should just inherit same attributes as parent. If the role 
> of mdev representation in current RFC is just to connect iommu_
> domain when hierarchical domain is missing, then we might 
> instead just make the latter happen...

Agreed, the mdev would inherit properties of its parent since physically
the IOMMU sees DMA transactions coming from the parent

> Let's think more on this direction. btw can you elaborate any 
> other complexities when you evaluated this option earlier?

I can't think of anything right now - my prototype worked well with
iommu_sva_alloc_pasid, but the goal was mainly for me to understand mdev
using a toy DMA engine, I didn't spend time thinking about corner cases.

Thanks,
Jean
