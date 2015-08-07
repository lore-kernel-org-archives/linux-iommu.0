From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 01/26] iommu/vt-d: Keep track of per-iommu domain ids
Date: Fri, 7 Aug 2015 13:07:01 +0200
Message-ID: <20150807110700.GX14980@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
	<1438787937-7340-2-git-send-email-joro@8bytes.org>
	<1438888792.4023.118.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438888792.4023.118.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, jroedel-l3A5Bk7waGM@public.gmane.org, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On Thu, Aug 06, 2015 at 01:19:52PM -0600, Alex Williamson wrote:
> On Wed, 2015-08-05 at 17:18 +0200, Joerg Roedel wrote:
> > From: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > 
> > Instead of searching in the domain array for already
> > allocated domain ids, keep track of them explicitly.
> > 
> > Signed-off-by: Joerg Roedel <jroedel-l3A5Bk7waGM@public.gmane.org>
> > ---
> >  drivers/iommu/intel-iommu.c | 51 +++++++++++++++++++++++----------------------
> >  1 file changed, 26 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/iommu/intel-iommu.c b/drivers/iommu/intel-iommu.c
> > index 0649b94..c3c5167 100644
> > --- a/drivers/iommu/intel-iommu.c
> > +++ b/drivers/iommu/intel-iommu.c
> > @@ -378,6 +378,9 @@ struct dmar_domain {
> >  	DECLARE_BITMAP(iommu_bmp, DMAR_UNITS_SUPPORTED);
> >  					/* bitmap of iommus this domain uses*/
> >  
> > +	u16	iommu_did[DMAR_UNITS_SUPPORTED];
> > +					/* Domain ids per IOMMU */
> 
> Maybe a spec reference here to justify u16 that the 2.3 vt-d spec only
> supports up to 16bit domain IDs.

Makes sense, I added a reference to the VT-d spec, section 9.3.

> > +	num = domain->iommu_did[iommu->seq_id];
> > +
> > +	WARN_ON(num == 0);
> 
> Return -ENODEV and let the caller decide if that's an error?  Then we
> could safely call this over all all iommus.

Changed that too, but not -ENODEV but just a plain return. The callers
do not care about errors anyway.


	Joerg
