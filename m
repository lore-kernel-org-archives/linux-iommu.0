From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH 08/18] iommu: Introduce cache_invalidate API
Date: Tue, 9 Apr 2019 09:43:28 -0700
Message-ID: <20190409094328.03731c3c@jacob-builder>
References: <1554767973-30125-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1554767973-30125-9-git-send-email-jacob.jun.pan@linux.intel.com>
        <20190409100718.GE9224@smile.fi.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190409100718.GE9224@smile.fi.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andriy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, Liu@smile.fi.intel.com, Eric Auger <eric.auger@redhat.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Tue, 9 Apr 2019 13:07:18 +0300
Andriy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Mon, Apr 08, 2019 at 04:59:23PM -0700, Jacob Pan wrote:
> > From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
> > 
> > In any virtualization use case, when the first translation stage
> > is "owned" by the guest OS, the host IOMMU driver has no knowledge
> > of caching structure updates unless the guest invalidation
> > activities are trapped by the virtualizer and passed down to the
> > host.
> > 
> > Since the invalidation data are obtained from user space and will be
> > written into physical IOMMU, we must allow security check at various
> > layers. Therefore, generic invalidation data format are proposed
> > here, model specific IOMMU drivers need to convert them into their
> > own format.  
> 
> > +int iommu_cache_invalidate(struct iommu_domain *domain, struct
> > device *dev,
> > +			   struct iommu_cache_invalidate_info
> > *inv_info) +{
> > +	int ret = 0;  
> 
> Redundant assignment.
> 
I am not a security expert but initialization of local variable can be
more secure.
I was looking at this talk.
https://outflux.net/slides/2018/lss/danger.pdf
https://cwe.mitre.org/data/definitions/457.html

> > +
> > +	if (unlikely(!domain->ops->cache_invalidate))
> > +		return -ENODEV;
> > +
> > +	ret = domain->ops->cache_invalidate(domain, dev, inv_info);
> > +
> > +	return ret;
> > +}  
> 

[Jacob Pan]
