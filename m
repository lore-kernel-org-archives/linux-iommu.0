From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: Re: [PATCH v2 17/19] iommu: Add max num of cache and granu types
Date: Mon, 29 Apr 2019 09:17:23 -0700
Message-ID: <20190429091723.5970e967@jacob-builder>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
        <1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
        <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Auger Eric <eric.auger@redhat.com>
Cc: iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, Alex Williamson <alex.williamson@redhat.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, Yi Liu <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, Andriy Shevchenko <andriy.shevchenko@linux.intel.com>, jacob.jun.pan@linux.intel.com
List-Id: iommu@lists.linux-foundation.org

On Fri, 26 Apr 2019 18:22:46 +0200
Auger Eric <eric.auger@redhat.com> wrote:

> Hi Jacob,
> 
> On 4/24/19 1:31 AM, Jacob Pan wrote:
> > To convert to/from cache types and granularities between generic and
> > VT-d specific counterparts, a 2D arrary is used. Introduce the
> > limits  
> array
> > to help define the converstion array size.  
> conversion
> > 
will fix, thanks
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  include/uapi/linux/iommu.h | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > index 5c95905..2d8fac8 100644
> > --- a/include/uapi/linux/iommu.h
> > +++ b/include/uapi/linux/iommu.h
> > @@ -197,6 +197,7 @@ struct iommu_inv_addr_info {
> >  	__u64	granule_size;
> >  	__u64	nb_granules;
> >  };
> > +#define NR_IOMMU_CACHE_INVAL_GRANU	(3)
> >  
> >  /**
> >   * First level/stage invalidation information
> > @@ -235,6 +236,7 @@ struct iommu_cache_invalidate_info {
> >  		struct iommu_inv_addr_info addr_info;
> >  	};
> >  };
> > +#define NR_IOMMU_CACHE_TYPE		(3)
> >  /**
> >   * struct gpasid_bind_data - Information about device and guest
> > PASID binding
> >   * @gcr3:	Guest CR3 value from guest mm
> >   
> Is it really something that needs to be exposed in the uapi?
> 
I put it in uapi since the related definitions for granularity and
cache type are in the same file.
Maybe putting them close together like this? I was thinking you can just
fold it into your next series as one patch for introducing cache
invalidation.
diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
index 2d8fac8..4ff6929 100644
--- a/include/uapi/linux/iommu.h
+++ b/include/uapi/linux/iommu.h
@@ -164,6 +164,7 @@ enum iommu_inv_granularity {
        IOMMU_INV_GRANU_DOMAIN, /* domain-selective invalidation */
        IOMMU_INV_GRANU_PASID,  /* pasid-selective invalidation */
        IOMMU_INV_GRANU_ADDR,   /* page-selective invalidation */
+       NR_IOMMU_INVAL_GRANU,   /* number of invalidation granularities
*/ };
 
 /**
@@ -228,6 +229,7 @@ struct iommu_cache_invalidate_info {
 #define IOMMU_CACHE_INV_TYPE_IOTLB     (1 << 0) /* IOMMU IOTLB */
 #define IOMMU_CACHE_INV_TYPE_DEV_IOTLB (1 << 1) /* Device IOTLB */
 #define IOMMU_CACHE_INV_TYPE_PASID     (1 << 2) /* PASID cache */
+#define NR_IOMMU_CACHE_TYPE            (3)
        __u8    cache;
        __u8    granularity;

> Thanks
> 
> Eric

[Jacob Pan]
