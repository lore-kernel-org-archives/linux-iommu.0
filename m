From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/vt-d: Only remove domain when device is removed
Date: Fri, 12 Dec 2014 16:56:26 +0100
Message-ID: <20141212155626.GA24292@8bytes.org>
References: <1412074923-6342-1-git-send-email-joro@8bytes.org>
	<1412074923-6342-3-git-send-email-joro@8bytes.org>
	<1415117537.27420.428.camel@ul30vt.home>
	<20141106125405.GI8354@suse.de>
	<1415290565.16601.92.camel@ul30vt.home>
	<20141209121525.GM3762@8bytes.org>
	<20141211163534.GA4765@anatevka.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20141211163534.GA4765-dMAi7lA+vBPDUbYHzcRnttBPR1lH4CV8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Jerry Hoemann <jerry.hoemann-VXdhtT5mjnY@public.gmane.org>
Cc: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <mstowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Jiang Liu <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Hi Jerry,

On Thu, Dec 11, 2014 at 09:35:34AM -0700, Jerry Hoemann wrote:
> On Tue, Dec 09, 2014 at 01:15:25PM +0100, Joerg Roedel wrote:
> > >From d65b236d0f27fe3ef7ac4d12cceb0da67aec86ce Mon Sep 17 00:00:00 2001
> > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > Date: Tue, 9 Dec 2014 12:56:45 +0100
> > Subject: [PATCH] iommu/vt-d: Fix dmar_domain leak in iommu_attach_device
> > 
> > Since commit 1196c2f a domain is only destroyed in the
> > notifier path if it is hot-unplugged. This caused a
> > domain leakage in iommu_attach_device when a driver was
> > unbound from the device and bound to VFIO. In this case the
> > device is attached to a new domain and unlinked from the old
> > domain. At this point nothing points to the old domain
> > anymore and its memory is leaked.
> > Fix this by explicitly freeing the old domain in
> > iommu_attach_domain.
> > 
> > Fixes: 1196c2f 'iommu/vt-d: Only remove domain when device is removed'
> > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > ---
> >  drivers/iommu/intel-iommu.c | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 1232336..9ef8e89 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -4424,10 +4424,13 @@ static int intel_iommu_attach_device(struct iommu_domain *domain,
> >  
> >  		old_domain = find_domain(dev);
> >  		if (old_domain) {
> > -			if (domain_type_is_vm_or_si(dmar_domain))
> > +			if (domain_type_is_vm_or_si(dmar_domain)) {
> 
> 
> JAH>  This path is executed when starting the VM.
> 
> 
> >  				domain_remove_one_dev_info(old_domain, dev);
> > -			else
> > +			} else {
> 
> 
> JAH>  I don't see this path being executed.
> 
> >  				domain_remove_dev_info(old_domain);
> > +				if (list_empty(&old_domain->devices))
> > +					domain_exit(old_domain);
> > +			}

You are right, thanks for testing. The reason is that the check for
domain_type_is_vm_or_si(dmar_domain) uses the new domain and not the old
one. I'll post a new patch.


	Joerg
