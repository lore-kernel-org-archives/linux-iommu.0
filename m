From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: [RFC PATCH 03/20] intel_iommu: add "svm" option
Date: Thu, 4 May 2017 13:37:50 -0700
Message-ID: <20170504203750.GA7308@otc-nc-03>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
	<1493201210-14357-4-git-send-email-yi.l.liu@linux.intel.com>
	<20170427105317.GE1542@pxdev.xzpeter.org>
	<20170504142853.1537028c@t450s.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170504142853.1537028c-1yVPhWWZRC1BDLzU/O5InQ@public.gmane.org>
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
Cc: tianyu.lan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, "Liu, Yi L" <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, kevin.tian-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, kvm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, jasowang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, qemu-devel-qX2TKyscuCcdnm+yROfE0A@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jacob.jun.pan-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, May 04, 2017 at 02:28:53PM -0600, Alex Williamson wrote:
> On Thu, 27 Apr 2017 18:53:17 +0800
> Peter Xu <peterx-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org> wrote:
> 
> > On Wed, Apr 26, 2017 at 06:06:33PM +0800, Liu, Yi L wrote:
> > > Expose "Shared Virtual Memory" to guest by using "svm" option.
> > > Also use "svm" to expose SVM related capabilities to guest.
> > > e.g. "-device intel-iommu, svm=on"
> > > 
> > > Signed-off-by: Liu, Yi L <yi.l.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
> > > ---
> > >  hw/i386/intel_iommu.c          | 10 ++++++++++
> > >  hw/i386/intel_iommu_internal.h |  5 +++++
> > >  include/hw/i386/intel_iommu.h  |  1 +
> > >  3 files changed, 16 insertions(+)
> > > 
> > > diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> > > index bf98fa5..ba1e7eb 100644
> > > --- a/hw/i386/intel_iommu.c
> > > +++ b/hw/i386/intel_iommu.c
> > > @@ -2453,6 +2453,7 @@ static Property vtd_properties[] = {
> > >      DEFINE_PROP_BOOL("x-buggy-eim", IntelIOMMUState, buggy_eim, false),
> > >      DEFINE_PROP_BOOL("caching-mode", IntelIOMMUState, caching_mode, FALSE),
> > >      DEFINE_PROP_BOOL("ecs", IntelIOMMUState, ecs, FALSE),
> > > +    DEFINE_PROP_BOOL("svm", IntelIOMMUState, svm, FALSE),
> > >      DEFINE_PROP_END_OF_LIST(),
> > >  };
> > >  
> > > @@ -2973,6 +2974,15 @@ static void vtd_init(IntelIOMMUState *s)
> > >          s->ecap |= VTD_ECAP_ECS;
> > >      }
> > >  
> > > +    if (s->svm) {
> > > +        if (!s->ecs || !x86_iommu->pt_supported || !s->caching_mode) {
> > > +            error_report("Need to set ecs, pt, caching-mode for svm");
> > > +            exit(1);
> > > +        }
> > > +        s->cap |= VTD_CAP_DWD | VTD_CAP_DRD;
> > > +        s->ecap |= VTD_ECAP_PRS | VTD_ECAP_PTS | VTD_ECAP_PASID28;
> > > +    }
> > > +
> > >      if (s->caching_mode) {
> > >          s->cap |= VTD_CAP_CM;
> > >      }
> > > diff --git a/hw/i386/intel_iommu_internal.h b/hw/i386/intel_iommu_internal.h
> > > index 71a1c1e..f2a7d12 100644
> > > --- a/hw/i386/intel_iommu_internal.h
> > > +++ b/hw/i386/intel_iommu_internal.h
> > > @@ -191,6 +191,9 @@
> > >  #define VTD_ECAP_PT                 (1ULL << 6)
> > >  #define VTD_ECAP_MHMV               (15ULL << 20)
> > >  #define VTD_ECAP_ECS                (1ULL << 24)
> > > +#define VTD_ECAP_PASID28            (1ULL << 28)  
> > 
> > Could I ask what's this bit? On my spec, it says this bit is reserved
> > and defunct (spec version: June 2016).
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=d42fde70849c5ba2f00c37a0666305eb507a47b8
> 
> Do we really need to emulate the buggy implementation?  Seems like we
> could just pretend bit28 never happened here and use bit40 instead.
> 

Agree, bit28 can be gone.  
