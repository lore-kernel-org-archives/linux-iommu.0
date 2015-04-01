From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Wed, 1 Apr 2015 12:53:40 +0100
Message-ID: <20150401115340.GG1552@arm.com>
References: <20150327171946.GL1562@arm.com> <20150331142440.GD22683@8bytes.org>
	<20150331144956.GA24094@arm.com>
	<1427817050.5567.148.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1427817050.5567.148.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Alex, Joerg,

On Tue, Mar 31, 2015 at 04:50:50PM +0100, Alex Williamson wrote:
> On Tue, 2015-03-31 at 15:49 +0100, Will Deacon wrote:
> > On Tue, Mar 31, 2015 at 03:24:40PM +0100, Joerg Roedel wrote:
> > > On Fri, Mar 27, 2015 at 05:19:46PM +0000, Will Deacon wrote:
> > > > Please can you pull the following IOMMU changes for 4.1? They move the
> > > > per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> > > > IOMMUs such as the ARM SMMU to support different page sizes within a
> > > > given SoC.
> > > 
> > > I have some concerns about the direction taken with this patch-set. The
> > > goal for the IOMMU-API is still to have domains that can be attached to
> > > arbitrary devices (even when mappings already exist). But with this
> > > patch-set we move into a direction where a domain can only be used on
> > > IOMMUs that support the page-sizes required by the domain. In the end
> > > this would be visible to the user of the IOMMU-API, which is not what we
> > > want.
> > 
> > But isn't this restriction already the case in practice? For example, if
> > I have a domain with some mapping already configured, then that mapping
> > will be using some fixed set of page sizes. Attaching a device behind
> > another IOMMU that doesn't support that page size would effectively require
> > the domain page tables to be freed and re-allocated from scratch.
> > 
> > So I don't think this patch series leaves us any worse off that we currently
> > are already.
> > 
> > Ths plus points of the patches are that:
> > 
> >   - We can support different page sizes per domain (the ARM SMMU hardware
> >     really does support this and it would be nice to exploit that to gain
> >     better TLB utilisation)
> > 
> >   - We can support systems containing IOMMUs that don't support a common
> >     page size (I believe the arm64 Juno platform has this feature)
> > 
> >   - I don't have to manipulate a const data structure (iommu_ops) at runtime
> >     whenever I find a new IOMMU with a different set of supported page
> >     sizes.
> > 
> > > I can understand the motivation behind these patches, but we need to
> > > think about how this could work with the desired semantics of the
> > > IOMMU-API.
> > 
> > Do we have any code using this feature of the IOMMU API? I don't think it's
> > realistic in the general case to allow arbitrary devices to be attached to a
> > domain unless the domain can also span multiple IOMMUs. In that case, we'd
> > actually need multiple sets of page tables, potentially described using
> > different formats...
> 
> Legacy KVM assignment relies on being able to attach all the devices to
> a single IOMMU domain and the hardware generally supports the domain
> page table being used by multiple hardware units.  It's not without
> issue though.  For instance, there's no hardware spec that requires that
> all the hardware IOMMUs for an iommu_ops must support
> IOMMU_CAP_CACHE_COHERENCY.  That's a per domain capability, not per
> iommu_ops.  If we start with a device attached to an IOMMU that does
> support this capability and create our mappings with the IOMMU_CACHE
> protection flag, that domain is incompatible with other IOMMU hardware
> units that do not support that capability.  On VT-d, the IOMMU API lets
> us share the domain between hardware units, but we might get invalid
> reserved field faults if we mix-n-match too much.

FWIW, legacy KVM assignment is also only supported on x86 so hopefully
the mixing and matching is somewhat limited by the available platforms.

> This is why VFIO had to add support for multiple IOMMU domains within a
> VFIO container.  It used to be that a VFIO container was essentially a
> 1:1 abstraction of an IOMMU domain, but issues like IOMMU_CACHE forced
> us to extend that abstraction.

Agreed. We also need to cater for multiple, heterogenous IOMMUs in the
system too. For example, the new ChromeBit device based on rk3288 contains
both a rockchip iommu (rockchip-iommu.c) *and* an ARM SMMU (arm-smmu.c).
These IOMMUs both deal with masters on the platform bus and they have
separate page table formats.

Granted, this patch series doesn't address that problem, but it doesn't
make it worse either.

> It makes sense to me that supported page sizes has a similar problem to
> IOMMU_CACHE; IOMMU mappings can be made that are dependent on the
> composition of the domain at the time of mapping and there's no
> requirement that all the IOMMU hardware units support the exact same
> features.  VFIO already assumes that separate domains don't necessarily
> use the same ops and we make sure mappings and un-mappings are aligned
> to the smallest common size.  We'll have some work to do though if there
> is no common size between the domains and we may need to add a test to
> our notion of compatible domains if pgsize_bitmap moves from iommu_ops
> (sorry, I forget whether you already had a patch for that in this pull
> request).  Thanks,

The series updates vfio_pgsize_bitmap to use the domains, so dma_do_map
will fail if there's no common page size amongst the IOMMUs referenced
by the container. That preserves the existing behaviour, but I'm not
sure why it's actually required. Couldn't we potentially allow different
domains to use different page sizes? We'd just need to advertise the
page sizes that are large enough to be supported by all domains. iommu_map
will then take care of breaking them down into smaller chunks when required.

On the ARM SMMU, you may have the choice of a few different page sizes but,
once you've chosen one (actually a subset), you can't use the others for
that domain. This is currently a decision made when the first device is
attached to a domain (i.e. when we allocate the initial page table) and we
basically try to find the page size closest to the one in use by the CPU.
See arm_lpae_restrict_pgsizes for the gory details. With the current code,
that means when one domain decides to use a particular subset, we have to
update (const) iommu_ops->pgsize_bitmap and therefore needlessly prevent any
other domain on any other ARM SMMU from using a different set of page sizes.

Joerg: are you still against merging this? If so, what do you need to
see in order to change your mind? This is certainly something that we
need on ARM-based systems and, tbh, the direction that the IOMMU core is
going seems to be towards a N:1 domain:IOMMU mapping anyway (c.f. your
series to embed struct iommu_domain in a driver-private data structure).

Will
