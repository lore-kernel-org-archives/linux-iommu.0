From: Alex Williamson <alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [RFC PATCH 1/3] iommu: introduce IOMMU_DOMAIN_HYP domain type
	for hypervisor allocation
Date: Tue, 01 Jul 2014 13:28:11 -0600
Message-ID: <1404242891.3225.144.camel@ul30vt.home>
References: <1404231017-10856-1-git-send-email-will.deacon@arm.com>
	<1404236553.3225.93.camel@ul30vt.home> <20140701180426.GX28164@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140701180426.GX28164-5wv7dgnIgG8@public.gmane.org>
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
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, 2014-07-01 at 19:04 +0100, Will Deacon wrote:
> Hi Alex,
> 
> Thanks for having a look.
> 
> On Tue, Jul 01, 2014 at 06:42:33PM +0100, Alex Williamson wrote:
> > On Tue, 2014-07-01 at 17:10 +0100, Will Deacon wrote:
> > > Some IOMMUs, such as the ARM SMMU, support two stages of translation.
> > > The idea behind such a scheme is to allow a guest operating system to
> > > use the IOMMU for DMA mappings in the first stage of translation, with
> > > the hypervisor then installing mappings in the second stage to provide
> > > isolation of the DMA to the physical range assigned to that virtual
> > > machine.
> > > 
> > > In order to allow IOMMU domains to be allocated for second-stage
> > > translation, this patch extends iommu_domain_alloc (and the associated
> > > ->domain_init callback on struct iommu) to take a type parameter
> > > indicating the intended purpose for the domain. The only supported types
> > > at present are IOMMU_DOMAIN_DMA (i.e. what we have at the moment) and
> > > IOMMU_DOMAIN_HYP, which instructs the backend driver to allocate and
> > > initialise a second-stage domain, if possible.
> > > 
> > > All IOMMU drivers are updated to take the new type parameter, but it is
> > > ignored at present. All callers of iommu_domain_alloc are also updated
> > > to pass IOMMU_DOMAIN_DMA as the type parameter, apart from
> > > kvm_iommu_map_guest, which passes the new IOMMU_DOMAIN_HYP flag.
> > > 
> > > Finally, a new IOMMU capability, IOMMU_CAP_HYP_MAPPING, is added so that
> > > it is possible to check whether or not a domain is able to make use of
> > > nested translation.
> > 
> > Why is this necessarily related to HYPervisor use?  It seems like this
> > new domain type is effectively just a normal domain that supports some
> > sort of fault handler that can call out to attempt to create missing
> > mappings.
> 
> Not quite. The idea of this domain is that it provides isolation for a
> guest, so I'd actually expect these domains to contain pinned mappings most
> of the time (handling guest faults in the hypervisor is pretty error-prone).

Hmm, that's exactly what an existing IOMMU domain does and how we use it
through QEMU and VFIO today.

> Perhaps if I explain how the ARM SMMU works, that might help (and if it
> doesn't, please reply saying so :). The ARM SMMU supports two stages of
> translation:
> 
>   Stage-1: Guest VA (VA) -> Guest PA (IPA, or intermediate physical address)
>   Stage-2: IPA -> Host Physical Address (PA)
> 
> These can be glued together to form nested translation, where an incoming VA
> is translated through both stages to get a PA. Page table walks triggered at
> stage-1 expect to see IPAs for the table addresses.
> 
> An important thing to note here is that the hardware is configured
> differently at each stage; the page table formats themselves are slightly
> different (e.g. restricted permissions at stage-2) and certain hardware
> contexts are only capable of stage-2 translation.
> 
> The way this is supposed to work is that the KVM host would install the VFIO
> DMA mapping (ok, now I see why you don't like the name) at stage-2. This
> allows the SMMU driver to allocate a corresponding stage-1 context for the
> mapping and expose that directly to the guest as part of a virtual, stage-1-only
> SMMU. Then the guest can install its own SMMU mappings at stage-1 for
> contiguous DMA (in the guest VA space) without any knowledge of the hypervisor
> mapping.
> 
> To do this successfully, we need to communicate the intention of the mapping
> to the SMMU driver (i.e. stage-1 vs stage-2) at domain initialisation time.
> I could just add ARM SMMU-specific properties there, but I thought this
> might potentially be useful to others.

If I understand, this is just nesting or two-dimensional paging support
and you need the lowest level translation to be setup differently
because the context entries for a stage-1 vs stage-2 page table are
different, right?  Is it then the case that you can also support a
traditional one-dimensional configuration where the SMMU is not exposed
and you'll likely have some QEMU switch to configure which will be used
for a given guest?

The code in 3/3 identifies this as a nested capable domain, so I'm not
sure why we'd want to make the assumption that it's for hypervisor use
when a hypervisor can use either type.

> > IOMMUs supporting PCI PRI (Page Request Interface) could
> > potentially make use of something like that on bare metal or under
> > hypervisor control.  If that's true, then could this be some sort of
> > iommu_domain_set_l2_handler() that happens after the domain is
> > allocated?
> 
> I'm not sure that's what I was aiming for... see above.
> 
> > For this patch, I don't understand why legacy KVM assignment would
> > allocate a HYP domain while VFIO would use a DMA domain.  It seems like
> > you're just counting on x86 never making the distinction between the
> > two.
> 
> That's true, but I was also trying to indicate the intention of the mapping
> so that other IOMMUs could potentially make use of the flags.

I find that defining an API on intentions is rarely a good idea.  Stick
with "what does this actually do".  In this case, I think we want an
interface that either specifies that the domain being allocated is
nesting capable or we want to be able to set a nesting attribute on a
domain, which may be possible after it's been allocated for a small
window before other operations have been done.

If we go the route of defining it at allocation time, I'd probably think
about adding a new interface, like:

iommu_domain_alloc_with_features(struct bus_type *bus, u32 features)

Where features is a bitmap

#define IOMMU_DOMAIN_FEATURE_NESTING (1U << 0)

iommu_domain_alloc(struct bus_type *bus) would then just be a wrapper
with features = 0.  If an IOMMU driver doesn't support a requested
feature, it should fail so we don't have cases like KVM requesting a
"HYP" domain when it doesn't need it and the IOMMU drivers don't support
it.

It would be a lot less intrusive if we could use iommu_domain_set_attr()
to enable nesting after allocation though.  This could return error if
called after the point at which it can be easily enabled.

> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -49,6 +49,10 @@ struct iommu_domain_geometry {
> > >  	bool force_aperture;       /* DMA only allowed in mappable range? */
> > >  };
> > >  
> > > +/* iommu domain types */
> > > +#define IOMMU_DOMAIN_DMA	0x0
> > > +#define IOMMU_DOMAIN_HYP	0x1
> > > +
> > >  struct iommu_domain {
> > >  	struct iommu_ops *ops;
> > >  	void *priv;
> > > @@ -59,6 +63,7 @@ struct iommu_domain {
> > >  
> > >  #define IOMMU_CAP_CACHE_COHERENCY	0x1
> > >  #define IOMMU_CAP_INTR_REMAP		0x2	/* isolates device intrs */
> > > +#define IOMMU_CAP_HYP_MAPPING		0x3	/* isolates guest DMA */
> > 
> > This makes no sense, it's exactly what we do with a "DMA" domain.  I
> > think the code needs to focus on what is really different about this
> > domain, not what is the expected use case.  Thanks,
> 
> The use-case is certainly relevant, though. I can do device passthrough
> with a stage-1 mapping for example, but you wouldn't then be able to
> instantiate a virtual SMMU interface in the guest.

I think you've switched the definition of stage-1 here to what we
consider a normal IOMMU domain mapping today, so I'm going to suggest
that stage-1 vs stage-2 where which is which depends on the type of
domain allocated is way too confusing.

> I could rename these IOMMU_CAP_STAGE{1,2}, but that then sounds very
> ARM-specific. What do you think?

Very much so, IOMMU_CAP_NESTING, DOMAIN_ATTR_NESTING?  Thanks,

Alex
