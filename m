From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [GIT PULL] iommu: Kill off pgsize_bitmap field from struct
	iommu_ops
Date: Tue, 31 Mar 2015 09:50:50 -0600
Message-ID: <1427817050.5567.148.camel@redhat.com>
References: <20150327171946.GL1562@arm.com>
	<20150331142440.GD22683@8bytes.org> <20150331144956.GA24094@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150331144956.GA24094-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org" <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org" <laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, "Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org" <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2015-03-31 at 15:49 +0100, Will Deacon wrote:
> On Tue, Mar 31, 2015 at 03:24:40PM +0100, Joerg Roedel wrote:
> > Hi Will,
> 
> Hi Joerg,
> 
> > On Fri, Mar 27, 2015 at 05:19:46PM +0000, Will Deacon wrote:
> > > Please can you pull the following IOMMU changes for 4.1? They move the
> > > per-iommu_ops pgsize_bitmap field into the iommu_domain, which allows
> > > IOMMUs such as the ARM SMMU to support different page sizes within a
> > > given SoC.
> > 
> > I have some concerns about the direction taken with this patch-set. The
> > goal for the IOMMU-API is still to have domains that can be attached to
> > arbitrary devices (even when mappings already exist). But with this
> > patch-set we move into a direction where a domain can only be used on
> > IOMMUs that support the page-sizes required by the domain. In the end
> > this would be visible to the user of the IOMMU-API, which is not what we
> > want.
> 
> But isn't this restriction already the case in practice? For example, if
> I have a domain with some mapping already configured, then that mapping
> will be using some fixed set of page sizes. Attaching a device behind
> another IOMMU that doesn't support that page size would effectively require
> the domain page tables to be freed and re-allocated from scratch.
> 
> So I don't think this patch series leaves us any worse off that we currently
> are already.
> 
> Ths plus points of the patches are that:
> 
>   - We can support different page sizes per domain (the ARM SMMU hardware
>     really does support this and it would be nice to exploit that to gain
>     better TLB utilisation)
> 
>   - We can support systems containing IOMMUs that don't support a common
>     page size (I believe the arm64 Juno platform has this feature)
> 
>   - I don't have to manipulate a const data structure (iommu_ops) at runtime
>     whenever I find a new IOMMU with a different set of supported page
>     sizes.
> 
> > I can understand the motivation behind these patches, but we need to
> > think about how this could work with the desired semantics of the
> > IOMMU-API.
> 
> Do we have any code using this feature of the IOMMU API? I don't think it's
> realistic in the general case to allow arbitrary devices to be attached to a
> domain unless the domain can also span multiple IOMMUs. In that case, we'd
> actually need multiple sets of page tables, potentially described using
> different formats...

Legacy KVM assignment relies on being able to attach all the devices to
a single IOMMU domain and the hardware generally supports the domain
page table being used by multiple hardware units.  It's not without
issue though.  For instance, there's no hardware spec that requires that
all the hardware IOMMUs for an iommu_ops must support
IOMMU_CAP_CACHE_COHERENCY.  That's a per domain capability, not per
iommu_ops.  If we start with a device attached to an IOMMU that does
support this capability and create our mappings with the IOMMU_CACHE
protection flag, that domain is incompatible with other IOMMU hardware
units that do not support that capability.  On VT-d, the IOMMU API lets
us share the domain between hardware units, but we might get invalid
reserved field faults if we mix-n-match too much.

This is why VFIO had to add support for multiple IOMMU domains within a
VFIO container.  It used to be that a VFIO container was essentially a
1:1 abstraction of an IOMMU domain, but issues like IOMMU_CACHE forced
us to extend that abstraction.

It makes sense to me that supported page sizes has a similar problem to
IOMMU_CACHE; IOMMU mappings can be made that are dependent on the
composition of the domain at the time of mapping and there's no
requirement that all the IOMMU hardware units support the exact same
features.  VFIO already assumes that separate domains don't necessarily
use the same ops and we make sure mappings and un-mappings are aligned
to the smallest common size.  We'll have some work to do though if there
is no common size between the domains and we may need to add a test to
our notion of compatible domains if pgsize_bitmap moves from iommu_ops
(sorry, I forget whether you already had a patch for that in this pull
request).  Thanks,

Alex
