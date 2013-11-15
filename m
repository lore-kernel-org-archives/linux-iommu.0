From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
	matched cpu nodes
Date: Fri, 15 Nov 2013 03:16:53 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D0A5B0AE8@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1384457440.2144.15.camel@haiying-laptop>
	<1384467025.1403.210.camel@snotra.buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1384467025.1403.210.camel-88ow+0ZRuxG2UiBs7uKeOtHuzzzSOjJt@public.gmane.org>
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
To: Scott Wood <scottwood-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Haiying Wang <Haiying.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Cc: "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Haiying/Scott,
Forgot to mention this, the PAMU driver has to handle stash destination settings both for power and dsp cores (on B4 platform). For the dsp cores we would expect the physical core id (not controlled by Linux). To make the interface consistent, I would expect the caller (for iommu_set_attr) to pass the physical core id.

Regards
Varun

> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Friday, November 15, 2013 3:40 AM
> To: Wang Haiying-R54964
> Cc: joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linuxppc-
> dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org; Sethi Varun-B16395
> Subject: Re: [PATCH] iommu/fsl_pamu: use physical cpu index to find the
> matched cpu nodes
> 
> On Thu, 2013-11-14 at 14:30 -0500, Haiying Wang wrote:
> > In the case we miss to bring up some cpus, we need to make sure we can
> > find the correct cpu nodes in the device tree based on the given
> > logical cpu index from the caller.
> >
> > Signed-off-by: Haiying Wang <Haiying.Wang-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
> > ---
> >  drivers/iommu/fsl_pamu.c |    3 ++-
> >  1 files changed, 2 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c index
> > cba0498..a9ab57b 100644
> > --- a/drivers/iommu/fsl_pamu.c
> > +++ b/drivers/iommu/fsl_pamu.c
> > @@ -539,6 +539,7 @@ u32 get_stash_id(u32 stash_dest_hint, u32 vcpu)
> 
> Should probably also s/vcpu/cpu/g as vcpu makes no sense outside of
> virtualization code.
> 
> >  	u32 cache_level;
> >  	int len, found = 0;
> >  	int i;
> > +	u32 cpuid = get_hard_smp_processor_id(vcpu);
> 
> s/cpuid/phys_cpu/ or similar
> 
> -Scott
> 
