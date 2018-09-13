From: "Tian, Kevin" <kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [RFC PATCH v2 00/10] vfio/mdev: IOMMU aware mediated device
Date: Thu, 13 Sep 2018 00:19:44 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D191300D06@SHSMSX101.ccr.corp.intel.com>
References: <20180830040922.30426-1-baolu.lu@linux.intel.com>
	<380dc154-5d72-0085-2056-fa466789e1ab@arm.com>
	<aa1ff748-c2ec-acc0-f1d9-cdff2b131e58@linux.intel.com>
	<3602f8c1-df17-4894-1bcc-4d779f9aa7fd@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3602f8c1-df17-4894-1bcc-4d779f9aa7fd-5wv7dgnIgG8@public.gmane.org>
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
To: Jean-Philippe Brucker <jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org>, Lu Baolu <baolu.lu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Kirti
	Wankhede <kwankhede-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Bie, Tiwei" <tiwei.bie-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Kumar, Sanjay K" <sanjay.k.kumar-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Sun, Yi Y" <yi.y.sun-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "Pan,
	Jacob jun" <jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

> From: Jean-Philippe Brucker
> Sent: Thursday, September 13, 2018 1:54 AM
> 
> On 12/09/2018 03:42, Lu Baolu wrote:
> > Hi,
> >
> > On 09/11/2018 12:22 AM, Jean-Philippe Brucker wrote:
> >> Hi,
> >>
> >> On 30/08/2018 05:09, Lu Baolu wrote:
> >>> Below APIs are introduced in the IOMMU glue for device drivers to use
> >>> the finer granularity translation.
> >>>
> >>> * iommu_capable(IOMMU_CAP_AUX_DOMAIN)
> >>>    - Represents the ability for supporting multiple domains per device
> >>>      (a.k.a. finer granularity translations) of the IOMMU hardware.
> >>
> >> iommu_capable() cannot represent hardware capabilities, we need
> >> something else for systems with multiple IOMMUs that have different
> >> caps. How about iommu_domain_get_attr on the device's domain
> instead?
> >
> > Domain is not a good choice for per iommu cap query. A domain might be
> > attached to devices belonging to different iommu's.
> >
> > How about an API with device structure as parameter? A device always
> > belongs to a specific iommu. This API is supposed to be used the
> > device driver.
> 
> Ah right, domain attributes won't work. Your suggestion seems more
> suitable, but maybe users can simply try to enable auxiliary domains
> first, and conclude that the IOMMU doesn't support it if it returns an error
> 
> >>> * iommu_en(dis)able_aux_domain(struct device *dev)
> >>>    - Enable/disable the multiple domains capability for a device
> >>>      referenced by @dev.
> 
> It strikes me now that in the IOMMU driver,
> iommu_enable/disable_aux_domain() will do the same thing as
> iommu_sva_device_init/shutdown()
> (https://www.spinics.net/lists/arm-kernel/msg651896.html). Some IOMMU
> drivers want to enable PASID and allocate PASID tables only when
> requested by users, in the sva_init_device IOMMU op (see Joerg's comment
> last year https://patchwork.kernel.org/patch/9989307/#21025429). Maybe
> we could simply add a flag to iommu_sva_device_init?

We could combine, but definitely 'sva' should be removed :-)

> 
> >>> * iommu_auxiliary_id(struct iommu_domain *domain)
> >>>    - Return the index value used for finer-granularity DMA translation.
> >>>      The specific device driver needs to feed the hardware with this
> >>>      value, so that hardware device could issue the DMA transaction with
> >>>      this value tagged.
> >>
> >> This could also reuse iommu_domain_get_attr.
> >>
> >>
> >> More generally I'm having trouble understanding how auxiliary domains
> >> will be used. So VFIO allocates PASIDs like this:
> >
> > As I wrote in the cover letter, "auxiliary domain" is just a name to
> > ease discussion. It's actually has no special meaning (we think a domain
> > as an isolation boundary which could be used by the IOMMU to isolate
> > the DMA transactions out of a PCI device or partial of it).
> >
> > So drivers like vfio should see no difference when use an auxiliary
> > domain. The auxiliary domain is not aware out of iommu driver.
> 
> For an auxiliary domain, VFIO does need to retrieve the PASID and write
> it to hardware. But being able to reuse
> iommu_map/unmap/iova_to_phys/etc
> on the auxiliary domain is nice.
> 
> >> * iommu_enable_aux_domain(parent_dev)
> >> * iommu_domain_alloc() -> dom1
> >> * iommu_domain_alloc() -> dom2
> >> * iommu_attach_device(dom1, parent_dev)
> >>    -> dom1 gets PASID #1
> >> * iommu_attach_device(dom2, parent_dev)
> >>    -> dom2 gets PASID #2
> >>
> >> Then I'm not sure about the next steps, when userspace does
> >> VFIO_IOMMU_MAP_DMA or VFIO_IOMMU_BIND on an mdev's
> container. Is the
> >> following use accurate?
> >>
> >> For the single translation level:
> >> * iommu_map(dom1, ...) updates first-level/second-level pgtables for
> >> PASID #1
> >> * iommu_map(dom2, ...) updates first-level/second-level pgtables for
> >> PASID #2
> >>
> >> Nested translation:
> >> * iommu_map(dom1, ...) updates second-level pgtables for PASID #1
> >> * iommu_bind_table(dom1, ...) binds first-level pgtables, provided by
> >> the guest, for PASID #1
> >> * iommu_map(dom2, ...) updates second-level pgtables for PASID #2
> >> * iommu_bind_table(dom2, ...) binds first-level pgtables for PASID #2
> >>>
> >> I'm trying to understand how to implement this with SMMU and other
> >
> > This is proposed for architectures which support finer granularity
> > second level translation with no impact on architectures which only
> > support Source ID or the similar granularity.
> 
> Just to be clear, in this paragraph you're only referring to the
> Nested/second-level translation for mdev, which is specific to vt-d
> rev3? Other architectures can still do first-level translation with
> PASID, to support some use-cases of IOMMU aware mediated device
> (assigning mdevs to userspace drivers, for example)

yes. aux domain concept applies only to vt-d rev3 which introduces
scalable mode. Care is taken to avoid breaking usages on existing
architectures.

one note. Assigning mdevs to user space alone doesn't imply IOMMU
aware. All existing mdev usages use software or proprietary methods to
isolate DMA. There is only one potential IOMMU aware mdev usage 
which we talked not rely on vt-d rev3 scalable mode - wrap a random 
PCI device into a single mdev instance (no sharing). In that case mdev 
inherits RID from parent PCI device, thus is isolated by IOMMU in RID 
granular. Our RFC supports this usage too. In VFIO two usages (PASID-
based and RID-based) use same code path, i.e. always binding domain to
the parent device of mdev. But within IOMMU they go different paths.
PASID-based will go to aux-domain as iommu_enable_aux_domain
has been called on that device. RID-based will follow existing 
unmanaged domain path, as if it is parent device assignment.

> 
> >> IOMMUs. It's not a clean fit since we have a single domain to hold the
> >> second-level pgtables.
> >
> > Do you mind explaining why a domain holds multiple second-level
> > pgtables? Shouldn't that be multiple domains?
> 
> I didn't mean a single domain holding multiple second-level pgtables,
> but a single domain holding a single set of second-level pgtables for
> all mdevs. But let's ignore that, mdev and second-level isn't realistic
> for arm SMMU.

yes. single second-level doesn't allow multiple mdevs (each mdev
assigned to different user process or VM). that is why vt-d rev3
introduces scalable mode. :-)

> 
> >> Then again, the nested case probably doesn't
> >> matter for us - we might as well assign the parent directly, since all
> >> mdevs have the same second-level and can only be assigned to the same
> VM.
> >>
> >>
> >> Also, can non-VFIO device drivers use auxiliary domains to do
> map/unmap
> >> on PASIDs? They are asking to do that and I'm proposing the private
> >> PASID thing, but since aux domains provide a similar feature we should
> >> probably converge somehow.
> >
> > Yes, any non-VFIO device driver could use aux domain as well. The use
> > model is:
> >
> > iommu_enable_aux_domain(dev)
> > -- enables aux domain support for this device
> >
> > iommu_domain_alloc(dev)
> > -- allocate an iommu domain
> >
> > iommu_attach_device(domain, dev)
> > -- attach the domain to device
> >
> > iommu_auxiliary_id(domain)
> > -- retrieve the pasid id used by this domain
> >
> > The device driver then
> >
> > iommu_map(domain, ...)
> >
> > set the pasid id to hardware register and start to do dma.
> 
> Sounds good, I'll drop the private PASID patch if we can figure out a
> solution to the attach/detach_dev problem discussed on patch 8/10
> 

Can you elaborate a bit on private PASID usage? what is the
high level flow on it? 

Again based on earlier explanation, aux domain is specific to IOMMU
architecture supporting vtd scalable mode-like capability, which allows
separate 2nd/1st level translations per PASID. Need a better understanding
how private PASID is relevant here.

Thanks
Kevin
