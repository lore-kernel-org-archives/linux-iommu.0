From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Qemu-devel] [RFC PATCH 1/8] iommu: Introduce bind_pasid_table
	API function
Date: Fri, 28 Apr 2017 17:04:58 +0800
Message-ID: <20170428090458.GB15484@sky-dev>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-2-git-send-email-yi.l.liu@intel.com>
	<c042bf90-d48b-4ebf-c01a-fca7c4875277@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c042bf90-d48b-4ebf-c01a-fca7c4875277-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Wed, Apr 26, 2017 at 05:56:45PM +0100, Jean-Philippe Brucker wrote:
> Hi Yi, Jacob,
> 
> On 26/04/17 11:11, Liu, Yi L wrote:
> > From: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > 
> > Virtual IOMMU was proposed to support Shared Virtual Memory (SVM) use
> > case in the guest:
> > https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg05311.html
> > 
> > As part of the proposed architecture, when a SVM capable PCI
> > device is assigned to a guest, nested mode is turned on. Guest owns the
> > first level page tables (request with PASID) and performs GVA->GPA
> > translation. Second level page tables are owned by the host for GPA->HPA
> > translation for both request with and without PASID.
> > 
> > A new IOMMU driver interface is therefore needed to perform tasks as
> > follows:
> > * Enable nested translation and appropriate translation type
> > * Assign guest PASID table pointer (in GPA) and size to host IOMMU
> > 
> > This patch introduces new functions called iommu_(un)bind_pasid_table()
> > to IOMMU APIs. Architecture specific IOMMU function can be added later
> > to perform the specific steps for binding pasid table of assigned devices.
> > 
> > This patch also adds model definition in iommu.h. It would be used to
> > check if the bind request is from a compatible entity. e.g. a bind
> > request from an intel_iommu emulator may not be supported by an ARM SMMU
> > driver.
> > 
> > Signed-off-by: Jacob Pan <jacob.jun.pan-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  drivers/iommu/iommu.c | 19 +++++++++++++++++++
> >  include/linux/iommu.h | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 50 insertions(+)
> > 
> > diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> > index dbe7f65..f2da636 100644
> > --- a/drivers/iommu/iommu.c
> > +++ b/drivers/iommu/iommu.c
> > @@ -1134,6 +1134,25 @@ int iommu_attach_device(struct iommu_domain *domain, struct device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(iommu_attach_device);
> >  
> > +int iommu_bind_pasid_table(struct iommu_domain *domain, struct device *dev,
> > +			struct pasid_table_info *pasidt_binfo)
> 
> I guess that domain can always be deduced from dev using
> iommu_get_domain_for_dev, and doesn't need to be passed as argument?
> 
> For the next version of my SVM series, I was thinking of passing group
> instead of device to iommu_bind. Since all devices in a group are expected
> to share the same mappings (whether they want it or not), users will have

Virtual address space is not tied to protection domain as I/O virtual address
space does. Is it really necessary to affect all the devices in this group.
Or it is just for consistence?

> to do iommu_group_for_each_dev anyway (as you do in patch 6/8). So it
> might be simpler to let the IOMMU core take the group lock and do
> group->domain->ops->bind_task(dev...) for each device. The question also
> holds for iommu_do_invalidate in patch 3/8.

In my understanding, it is moving the for_each_dev loop into iommu driver?
Is it?

> This way the prototypes would be:
> int iommu_bind...(struct iommu_group *group, struct ... *info)
> int iommu_unbind...(struct iommu_group *group, struct ...*info)
> int iommu_invalidate...(struct iommu_group *group, struct ...*info)

For PASID table binding from guest, I think it'd better to be per-device op
since the bind operation wants to modify the host context entry. But we may
still share the API and do things differently in iommu driver.

For invalidation, I think it'd better to be per-group. Actually, with guest
IOMMU exists, there is only one group in a domain on Intel platform. Do it for
each device is not expected. How about it on ARM?

> For PASID table binding it might not matter much, as VFIO will most likely
> be the only user. But task binding will be called by device drivers, which
> by now should be encouraged to do things at iommu_group granularity.
> Alternatively it could be done implicitly like in iommu_attach_device,
> with "iommu_bind_device_x" calling "iommu_bind_group_x".

Do you mean the bind task from userspace driver? I guess you're trying to do
different types of binding request in a single svm_bind API?

> 
> Extending this reasoning, since groups in a domain are also supposed to
> have the same mappings, then similarly to map/unmap,
> bind/unbind/invalidate should really be done with an iommu_domain (and
> nothing else) as target argument. However this requires the IOMMU core to
> keep a group list in each domain, which might complicate things a little
> too much.
> 
> But "all devices in a domain share the same PASID table" is the paradigm
> I'm currently using in the guts of arm-smmu-v3. And I wonder if, as with
> iommu_group, it should be made more explicit to users, so they don't
> assume that devices within a domain are isolated from each others with
> regard to PASID DMA.

Is the isolation you mentioned means forbidding to do PASID DMA to the same
virtual address space when the device comes from different domain?

Thanks,
Yi L
 
