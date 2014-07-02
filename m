From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: introduce IOMMU_DOMAIN_HYP domain type
	for hypervisor allocation
Date: Wed, 2 Jul 2014 11:49:02 +0100
Message-ID: <20140702104902.GH18731@arm.com>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
	<1404236553.3225.93.camel@ul30vt.home>
	<20140701180426.GX28164@arm.com>
	<1404242891.3225.144.camel@ul30vt.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1404242891.3225.144.camel-85EaTFmN5p//9pzu0YdTqQ@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Jul 01, 2014 at 08:28:11PM +0100, Alex Williamson wrote:
> On Tue, 2014-07-01 at 19:04 +0100, Will Deacon wrote:
> > On Tue, Jul 01, 2014 at 06:42:33PM +0100, Alex Williamson wrote:
> > > On Tue, 2014-07-01 at 17:10 +0100, Will Deacon wrote:
> > > > Finally, a new IOMMU capability, IOMMU_CAP_HYP_MAPPING, is added so that
> > > > it is possible to check whether or not a domain is able to make use of
> > > > nested translation.
> > > 
> > > Why is this necessarily related to HYPervisor use?  It seems like this
> > > new domain type is effectively just a normal domain that supports some
> > > sort of fault handler that can call out to attempt to create missing
> > > mappings.
> > 
> > Not quite. The idea of this domain is that it provides isolation for a
> > guest, so I'd actually expect these domains to contain pinned mappings most
> > of the time (handling guest faults in the hypervisor is pretty error-prone).
> 
> Hmm, that's exactly what an existing IOMMU domain does and how we use it
> through QEMU and VFIO today.

There is a subtlety here in that VFIO can be used for both KVM device
passthrough and for userspace drivers. The former wants a stage-2 mapping
(to allow nesting) whilst the latter wants stage-1 (since we can't guarantee
cache coherency with a stage-2 mapping in isolation).

> > Perhaps if I explain how the ARM SMMU works, that might help (and if it
> > doesn't, please reply saying so :). The ARM SMMU supports two stages of
> > translation:
> > 
> >   Stage-1: Guest VA (VA) -> Guest PA (IPA, or intermediate physical address)
> >   Stage-2: IPA -> Host Physical Address (PA)
> > 
> > These can be glued together to form nested translation, where an incoming VA
> > is translated through both stages to get a PA. Page table walks triggered at
> > stage-1 expect to see IPAs for the table addresses.
> > 
> > An important thing to note here is that the hardware is configured
> > differently at each stage; the page table formats themselves are slightly
> > different (e.g. restricted permissions at stage-2) and certain hardware
> > contexts are only capable of stage-2 translation.
> > 
> > The way this is supposed to work is that the KVM host would install the VFIO
> > DMA mapping (ok, now I see why you don't like the name) at stage-2. This
> > allows the SMMU driver to allocate a corresponding stage-1 context for the
> > mapping and expose that directly to the guest as part of a virtual, stage-1-only
> > SMMU. Then the guest can install its own SMMU mappings at stage-1 for
> > contiguous DMA (in the guest VA space) without any knowledge of the hypervisor
> > mapping.
> > 
> > To do this successfully, we need to communicate the intention of the mapping
> > to the SMMU driver (i.e. stage-1 vs stage-2) at domain initialisation time.
> > I could just add ARM SMMU-specific properties there, but I thought this
> > might potentially be useful to others.
> 
> If I understand, this is just nesting or two-dimensional paging support
> and you need the lowest level translation to be setup differently
> because the context entries for a stage-1 vs stage-2 page table are
> different, right?

Correct! Other differences include:

  - Slightly different page table format
  - Limited ability to manipulate memory attributes at stage-2 (which can
    affect IOMMU_CACHE mappings, as I mentioned earlier).
  - An implementation can support stage-1 only or stage-2 only if it
    wishes.

> Is it then the case that you can also support a
> traditional one-dimensional configuration where the SMMU is not exposed
> and you'll likely have some QEMU switch to configure which will be used
> for a given guest?

Yup, and this could actually be done at either stage-1 or stage-2 since VFIO
calls iommu_map directly. In the future, we'd like to share the CPU page
tables created by KVM, which would force us to use stage-2.

> The code in 3/3 identifies this as a nested capable domain, so I'm not
> sure why we'd want to make the assumption that it's for hypervisor use
> when a hypervisor can use either type.

Actually, a hypervisor would want to use stage-1 for its own mappings (back
to the IOMMU_CACHE stuff) and stage-2 for guests. Otherwise, I could simply
hack the SMMU driver to always install at the highest available stage.

> > > For this patch, I don't understand why legacy KVM assignment would
> > > allocate a HYP domain while VFIO would use a DMA domain.  It seems like
> > > you're just counting on x86 never making the distinction between the
> > > two.
> > 
> > That's true, but I was also trying to indicate the intention of the mapping
> > so that other IOMMUs could potentially make use of the flags.
> 
> I find that defining an API on intentions is rarely a good idea.  Stick
> with "what does this actually do".  In this case, I think we want an
> interface that either specifies that the domain being allocated is
> nesting capable or we want to be able to set a nesting attribute on a
> domain, which may be possible after it's been allocated for a small
> window before other operations have been done.

Ok, I can work with that. One question that immediately springs to mind is
when you have a stage-2-only SMMU. We can't support nesting, since there's
no stage-1 to give to the guest, but we'd still want to allow
device-passthrough. In this case, perhaps it's best to think of stage-2-only
SMMUs having an identity-map fixed at stage-1?

> If we go the route of defining it at allocation time, I'd probably think
> about adding a new interface, like:
> 
> iommu_domain_alloc_with_features(struct bus_type *bus, u32 features)
> 
> Where features is a bitmap
> 
> #define IOMMU_DOMAIN_FEATURE_NESTING (1U << 0)
> 
> iommu_domain_alloc(struct bus_type *bus) would then just be a wrapper
> with features = 0.  If an IOMMU driver doesn't support a requested
> feature, it should fail so we don't have cases like KVM requesting a
> "HYP" domain when it doesn't need it and the IOMMU drivers don't support
> it.
> 
> It would be a lot less intrusive if we could use iommu_domain_set_attr()
> to enable nesting after allocation though.  This could return error if
> called after the point at which it can be easily enabled.

I'll take another look at set_attr, since I agree that it would be cleaner.

> > > This makes no sense, it's exactly what we do with a "DMA" domain.  I
> > > think the code needs to focus on what is really different about this
> > > domain, not what is the expected use case.  Thanks,
> > 
> > The use-case is certainly relevant, though. I can do device passthrough
> > with a stage-1 mapping for example, but you wouldn't then be able to
> > instantiate a virtual SMMU interface in the guest.
> 
> I think you've switched the definition of stage-1 here to what we
> consider a normal IOMMU domain mapping today, so I'm going to suggest
> that stage-1 vs stage-2 where which is which depends on the type of
> domain allocated is way too confusing.

Agreed; but we do want to support device-passthrough for stage-1-only and
stage-2-only SMMUs. That detail can hopefully be hidden away in the SMMU
driver if we stick to the NESTING flag.

Thanks again for the comments, I'll try and address them for v2.

Will
