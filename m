From: "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
Subject: Re: [Qemu-devel] [RFC PATCH 02/20] intel_iommu: exposed
	extended-context mode to guest
Date: Fri, 28 Apr 2017 17:55:26 +0800
Message-ID: <20170428095526.GC15484@sky-dev>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-3-git-send-email-yi.l.liu@linux.intel.com>
	<20170427103221.GD1542@pxdev.xzpeter.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170427103221.GD1542-QJIicYCqamqhazCxEpVPD9i2O/JbrIOy@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Apr 27, 2017 at 06:32:21PM +0800, Peter Xu wrote:
> On Wed, Apr 26, 2017 at 06:06:32PM +0800, Liu, Yi L wrote:
> > VT-d implementations reporting PASID or PRS fields as "Set", must also
> > report ecap.ECS as "Set". Extended-Context is required for SVM.
> > 
> > When ECS is reported, intel iommu driver would initiate extended root entry
> > and extended context entry, and also PASID table if there is any SVM capable
> > device.
> > 
> > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > ---
> >  hw/i386/intel_iommu.c          | 131 +++++++++++++++++++++++++++--------------
> >  hw/i386/intel_iommu_internal.h |   9 +++
> >  include/hw/i386/intel_iommu.h  |   2 +-
> >  3 files changed, 97 insertions(+), 45 deletions(-)
> > 
> > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > index 400d0d1..bf98fa5 100644
> > --- a/hw/i386/intel_iommu.c
> > +++ b/hw/i386/intel_iommu.c
> > @@ -497,6 +497,11 @@ static inline bool vtd_root_entry_present(VTDRootEntry *root)
> >      return root->val & VTD_ROOT_ENTRY_P;
> >  }
> >  
> > +static inline bool vtd_root_entry_upper_present(VTDRootEntry *root)
> > +{
> > +    return root->rsvd & VTD_ROOT_ENTRY_P;
> > +}
> > +
> >  static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
> >                                VTDRootEntry *re)
> >  {
> > @@ -509,6 +514,9 @@ static int vtd_get_root_entry(IntelIOMMUState *s, uint8_t index,
> >          return -VTD_FR_ROOT_TABLE_INV;
> >      }
> >      re->val = le64_to_cpu(re->val);
> > +    if (s->ecs) {
> > +        re->rsvd = le64_to_cpu(re->rsvd);
> > +    }
> 
> I feel it slightly hacky to play with re->rsvd. How about:
> 
> union VTDRootEntry {
>     struct {
>         uint64_t val;
>         uint64_t rsvd;
>     } base;
>     struct {
>         uint64_t ext_lo;
>         uint64_t ext_hi;
>     } extended;
> };

Agree.
 
> (Or any better way that can get rid of rsvd...)
> 
> Even:
> 
> struct VTDRootEntry {
>     union {
>         struct {
>                 uint64_t val;
>                 uint64_t rsvd;
>         } base;
>         struct {
>                 uint64_t ext_lo;
>                 uint64_t ext_hi;
>         } extended;
>     } data;
>     bool extended;
> };
> 
> Then we read the entry into data, and setup extended bit. A benefit of
> it is that we may avoid passing around IntelIOMMUState everywhere to
> know whether we are using extended context entries.

For this proposal, it's combining the s->ecs bit and root entry. But it
may mislead future maintainer as it uses VTDRootEntry. maybe name it
differently.

> >      return 0;
> >  }
> >  
> > @@ -517,19 +525,30 @@ static inline bool vtd_context_entry_present(VTDContextEntry *context)
> >      return context->lo & VTD_CONTEXT_ENTRY_P;
> >  }
> >  
> > -static int vtd_get_context_entry_from_root(VTDRootEntry *root, uint8_t index,
> > -                                           VTDContextEntry *ce)
> > +static int vtd_get_context_entry_from_root(IntelIOMMUState *s,
> > +                 VTDRootEntry *root, uint8_t index, VTDContextEntry *ce)
> >  {
> > -    dma_addr_t addr;
> > +    dma_addr_t addr, ce_size;
> >  
> >      /* we have checked that root entry is present */
> > -    addr = (root->val & VTD_ROOT_ENTRY_CTP) + index * sizeof(*ce);
> > -    if (dma_memory_read(&address_space_memory, addr, ce, sizeof(*ce))) {
> > +    ce_size = (s->ecs) ? (2 * sizeof(*ce)) : (sizeof(*ce));
> > +    addr = (s->ecs && (index > 0x7f)) ?
> > +           ((root->rsvd & VTD_ROOT_ENTRY_CTP) + (index - 0x80) * ce_size) :
> > +           ((root->val & VTD_ROOT_ENTRY_CTP) + index * ce_size);
> > +
> > +    if (dma_memory_read(&address_space_memory, addr, ce, ce_size)) {
> >          trace_vtd_re_invalid(root->rsvd, root->val);
> >          return -VTD_FR_CONTEXT_TABLE_INV;
> >      }
> > -    ce->lo = le64_to_cpu(ce->lo);
> > -    ce->hi = le64_to_cpu(ce->hi);
> > +
> > +    ce[0].lo = le64_to_cpu(ce[0].lo);
> > +    ce[0].hi = le64_to_cpu(ce[0].hi);
> 
> Again, I feel this even hackier. :)
> 
> I would slightly prefer to play the same union trick to context
> entries, just like what I proposed to the root entries above...

would think about it.

> > +
> > +    if (s->ecs) {
> > +        ce[1].lo = le64_to_cpu(ce[1].lo);
> > +        ce[1].hi = le64_to_cpu(ce[1].hi);
> > +    }
> > +
> >      return 0;
> >  }
> >  
> > @@ -595,9 +614,11 @@ static inline uint32_t vtd_get_agaw_from_context_entry(VTDContextEntry *ce)
> >      return 30 + (ce->hi & VTD_CONTEXT_ENTRY_AW) * 9;
> >  }
> >  
> > -static inline uint32_t vtd_ce_get_type(VTDContextEntry *ce)
> > +static inline uint32_t vtd_ce_get_type(IntelIOMMUState *s,
> > +                                       VTDContextEntry *ce)
> >  {
> > -    return ce->lo & VTD_CONTEXT_ENTRY_TT;
> > +    return s->ecs ? (ce->lo & VTD_CONTEXT_ENTRY_TT) :
> > +                    (ce->lo & VTD_EXT_CONTEXT_ENTRY_TT);
> >  }
> >  
> >  static inline uint64_t vtd_iova_limit(VTDContextEntry *ce)
> > @@ -842,16 +863,20 @@ static int vtd_dev_to_context_entry(IntelIOMMUState *s, uint8_t bus_num,
> >          return ret_fr;
> >      }
> >  
> > -    if (!vtd_root_entry_present(&re)) {
> > +    if (!vtd_root_entry_present(&re) ||
> > +        (s->ecs && (devfn > 0x7f) && (!vtd_root_entry_upper_present(&re)))) {
> >          /* Not error - it's okay we don't have root entry. */
> >          trace_vtd_re_not_present(bus_num);
> >          return -VTD_FR_ROOT_ENTRY_P;
> > -    } else if (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)) {
> > -        trace_vtd_re_invalid(re.rsvd, re.val);
> > -        return -VTD_FR_ROOT_ENTRY_RSVD;
> > +    }
> > +    if ((s->ecs && (devfn > 0x7f) && (re.rsvd & VTD_ROOT_ENTRY_RSVD)) ||
> > +        (s->ecs && (devfn < 0x80) && (re.val & VTD_ROOT_ENTRY_RSVD)) ||
> > +        ((!s->ecs) && (re.rsvd || (re.val & VTD_ROOT_ENTRY_RSVD)))) {
> > +            trace_vtd_re_invalid(re.rsvd, re.val);
> > +            return -VTD_FR_ROOT_ENTRY_RSVD;
> 
> Nit: I feel like we can better wrap these 0x7f and 0x80 into helper
> functions, especially if with above structure change...

yep, would add helper function.

> (will hold here...)
> 
> Thanks,
> 
> -- 
> Peter Xu
> 
