Return-Path: <SRS0=wClR=S7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C711C43219
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 16:17:49 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFD320673
	for <iommu@archiver.kernel.org>; Mon, 29 Apr 2019 16:17:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFD320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id B21F722AF;
	Mon, 29 Apr 2019 16:17:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 980D322A2
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 16:14:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id ED9B087B
	for <iommu@lists.linux-foundation.org>;
	Mon, 29 Apr 2019 16:14:38 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
	by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	29 Apr 2019 09:14:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,410,1549958400"; d="scan'208";a="319998209"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
	by orsmga005.jf.intel.com with ESMTP; 29 Apr 2019 09:14:38 -0700
Date: Mon, 29 Apr 2019 09:17:23 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: Auger Eric <eric.auger@redhat.com>
Subject: Re: [PATCH v2 17/19] iommu: Add max num of cache and granu types
Message-ID: <20190429091723.5970e967@jacob-builder>
In-Reply-To: <a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
References: <1556062279-64135-1-git-send-email-jacob.jun.pan@linux.intel.com>
	<1556062279-64135-18-git-send-email-jacob.jun.pan@linux.intel.com>
	<a9f2c804-24a8-03fb-96ac-0c4661870dd5@redhat.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "Tian, Kevin" <kevin.tian@intel.com>, Raj Ashok <ashok.raj@intel.com>,
	Jean-Philippe Brucker <jean-philippe.brucker@arm.com>,
	iommu@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	Andriy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Development issues for Linux IOMMU support
	<iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org
Message-ID: <20190429161723.ieo2fRPEamjNtzFvsvGfZa2y4KEniHTUaI8ZI90xpJw@z>

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
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
