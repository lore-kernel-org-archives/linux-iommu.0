From: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 03/26] iommu/vt-d: Split up iommu->domains array
Date: Fri, 7 Aug 2015 13:11:56 +0200
Message-ID: <20150807111156.GY14980@8bytes.org>
References: <1438787937-7340-1-git-send-email-joro@8bytes.org>
	<1438787937-7340-4-git-send-email-joro@8bytes.org>
	<1438888809.4023.121.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1438888809.4023.121.camel-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
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

On Thu, Aug 06, 2015 at 01:20:09PM -0600, Alex Williamson wrote:
> On Wed, 2015-08-05 at 17:18 +0200, Joerg Roedel wrote:
> >  static void set_iommu_domain(struct intel_iommu *iommu, u16 did,
> >  			     struct dmar_domain *domain)
> >  {
> > -	iommu->domains[did] = domain;
> > +	struct dmar_domain **domains;
> > +	int idx = did >> 8;
> > +
> > +	if (!iommu->domains[idx]) {
> > +		size_t size = 256 * sizeof(struct dmar_domain *);
> > +		iommu->domains[idx] = kzalloc(size, GFP_ATOMIC);
> > +	}
> > +
> > +	domains = iommu->domains[idx];
> > +	if (WARN_ON(!domains))
> > +		return;
> > +	else
> > +		domains[did & 0xff] = domain;
> >  }
> 
> I'm tempted to suggest using pages here since we're dealing with 2k
> second level arrays, but maybe caring about pointers per page just makes
> that ugly.

The benefit would be that we avoid the slab-overhead while allocating.
But since the VT-d driver is needed on platforms with different
page-sizes, the handling would be indeed more complicated because we
have to split the index at a different point then depending on the
architecture.


	Joerg
