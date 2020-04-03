Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEDCFC2BA12
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 15:26:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12BC206CC
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 15:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12BC206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 7D19385DFF;
	Fri,  3 Apr 2020 15:26:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id riINE6upJMHx; Fri,  3 Apr 2020 15:26:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A30C9861DD;
	Fri,  3 Apr 2020 15:26:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A7D5C1831;
	Fri,  3 Apr 2020 15:26:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE6E8C07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:25:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A73FE2000B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:25:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yKgedFNjFkAp for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 15:25:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by silver.osuosl.org (Postfix) with ESMTPS id ED68F20003
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 15:25:57 +0000 (UTC)
IronPort-SDR: pxqIS77U3PQm61nTtFF7KMQvGsUzjJ+21ac2n7io3x/CkzhMq5gh/ElazCLywaagPNumx7r1uI
 qfJdlmmV8oEA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 08:25:57 -0700
IronPort-SDR: Kz9Xn8SJxTKmlvLgOVwgF5jI27PjXyHYua/KTyfsaNgp7UaJwTPpO4T6SpIItCjULt3DA9tXZf
 t4KOiEnnNfAA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,340,1580803200"; d="scan'208";a="423560866"
Received: from jacob-builder.jf.intel.com (HELO jacob-builder) ([10.7.199.155])
 by orsmga005.jf.intel.com with ESMTP; 03 Apr 2020 08:25:56 -0700
Date: Fri, 3 Apr 2020 08:31:45 -0700
From: Jacob Pan <jacob.jun.pan@linux.intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>
Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Message-ID: <20200403083145.5097d346@jacob-builder>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
Organization: OTC
X-Mailer: Claws Mail 3.13.2 (GTK+ 2.24.30; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Fri, 3 Apr 2020 06:39:22 +0000
"Tian, Kevin" <kevin.tian@intel.com> wrote:

> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, April 3, 2020 4:24 AM
> > 
> > On Sun, 22 Mar 2020 05:32:04 -0700
> > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> >   
> > > From: Liu Yi L <yi.l.liu@linux.intel.com>
> > >
> > > For VFIO IOMMUs with the type VFIO_TYPE1_NESTING_IOMMU, guest  
> > "owns" the  
> > > first-level/stage-1 translation structures, the host IOMMU driver
> > > has no knowledge of first-level/stage-1 structure cache updates
> > > unless the guest invalidation requests are trapped and propagated
> > > to the host.
> > >
> > > This patch adds a new IOCTL VFIO_IOMMU_CACHE_INVALIDATE to  
> > propagate guest  
> > > first-level/stage-1 IOMMU cache invalidations to host to ensure
> > > IOMMU  
> > cache  
> > > correctness.
> > >
> > > With this patch, vSVA (Virtual Shared Virtual Addressing) can be
> > > used safely as the host IOMMU iotlb correctness are ensured.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Signed-off-by: Liu Yi L <yi.l.liu@linux.intel.com>
> > > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > >  drivers/vfio/vfio_iommu_type1.c | 49  
> > +++++++++++++++++++++++++++++++++++++++++  
> > >  include/uapi/linux/vfio.h       | 22 ++++++++++++++++++
> > >  2 files changed, 71 insertions(+)
> > >
> > > diff --git a/drivers/vfio/vfio_iommu_type1.c  
> > b/drivers/vfio/vfio_iommu_type1.c  
> > > index a877747..937ec3f 100644
> > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > @@ -2423,6 +2423,15 @@ static long  
> > vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,  
> > >  	return ret;
> > >  }
> > >
> > > +static int vfio_cache_inv_fn(struct device *dev, void *data)
> > > +{
> > > +	struct domain_capsule *dc = (struct domain_capsule
> > > *)data;
> > > +	struct iommu_cache_invalidate_info *cache_inv_info =
> > > +		(struct iommu_cache_invalidate_info *) dc->data;
> > > +
> > > +	return iommu_cache_invalidate(dc->domain, dev,
> > > cache_inv_info); +}
> > > +
> > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > >  				   unsigned int cmd, unsigned
> > > long arg) {
> > > @@ -2629,6 +2638,46 @@ static long vfio_iommu_type1_ioctl(void  
> > *iommu_data,  
> > >  		}
> > >  		kfree(gbind_data);
> > >  		return ret;
> > > +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> > > +		struct vfio_iommu_type1_cache_invalidate
> > > cache_inv;
> > > +		u32 version;
> > > +		int info_size;
> > > +		void *cache_info;
> > > +		int ret;
> > > +
> > > +		minsz = offsetofend(struct  
> > vfio_iommu_type1_cache_invalidate,  
> > > +				    flags);  
> > 
> > This breaks backward compatibility as soon as struct
> > iommu_cache_invalidate_info changes size by its defined versioning
> > scheme.  ie. a field gets added, the version is bumped, all existing
> > userspace breaks.  Our minsz is offsetofend to the version field,
> > interpret the version to size, then reevaluate argsz.  
> 
> btw the version scheme is challenged by Christoph Hellwig. After
> some discussions, we need your guidance how to move forward.
> Jacob summarized available options below:
> 	https://lkml.org/lkml/2020/4/2/876
> 
For this particular case, I don't quite get the difference between
minsz=flags and minsz=version. Our IOMMU version scheme will only
change size at the end where the variable union is used for vendor
specific extensions. Version bump does not change size (only re-purpose
padding) from the start of the UAPI structure to the union, i.e. version
will __always__ be after struct vfio_iommu_type1_cache_invalidate.flags.


> >   
> > > +
> > > +		if (copy_from_user(&cache_inv, (void __user
> > > *)arg, minsz))
> > > +			return -EFAULT;
> > > +
> > > +		if (cache_inv.argsz < minsz || cache_inv.flags)
> > > +			return -EINVAL;
> > > +
> > > +		/* Get the version of struct
> > > iommu_cache_invalidate_info */
> > > +		if (copy_from_user(&version,
> > > +			(void __user *) (arg + minsz),
> > > sizeof(version)))
> > > +			return -EFAULT;
> > > +
> > > +		info_size = iommu_uapi_get_data_size(
> > > +					IOMMU_UAPI_CACHE_INVAL,  
> > version);  
> > > +
> > > +		cache_info = kzalloc(info_size, GFP_KERNEL);
> > > +		if (!cache_info)
> > > +			return -ENOMEM;
> > > +
> > > +		if (copy_from_user(cache_info,
> > > +			(void __user *) (arg + minsz),
> > > info_size)) {
> > > +			kfree(cache_info);
> > > +			return -EFAULT;
> > > +		}
> > > +
> > > +		mutex_lock(&iommu->lock);
> > > +		ret = vfio_iommu_for_each_dev(iommu,
> > > vfio_cache_inv_fn,
> > > +					    cache_info);  
> > 
> > How does a user respond when their cache invalidate fails?  Isn't
> > this also another case where our for_each_dev can fail at an
> > arbitrary point leaving us with no idea whether each device even
> > had the opportunity to perform the invalidation request.  I don't
> > see how we have any chance to maintain coherency after this
> > faults.  
> 
> Then can we make it simple to support singleton group only? 
> 
> >   
> > > +		mutex_unlock(&iommu->lock);
> > > +		kfree(cache_info);
> > > +		return ret;
> > >  	}
> > >
> > >  	return -ENOTTY;
> > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > index 2235bc6..62ca791 100644
> > > --- a/include/uapi/linux/vfio.h
> > > +++ b/include/uapi/linux/vfio.h
> > > @@ -899,6 +899,28 @@ struct vfio_iommu_type1_bind {
> > >   */
> > >  #define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE
> > > + 23)
> > >
> > > +/**
> > > + * VFIO_IOMMU_CACHE_INVALIDATE - _IOW(VFIO_TYPE, VFIO_BASE + 24,
> > > + *			struct
> > > vfio_iommu_type1_cache_invalidate)
> > > + *
> > > + * Propagate guest IOMMU cache invalidation to the host. The
> > > cache
> > > + * invalidation information is conveyed by @cache_info, the
> > > content
> > > + * format would be structures defined in uapi/linux/iommu.h. User
> > > + * should be aware of that the struct
> > > iommu_cache_invalidate_info
> > > + * has a @version field, vfio needs to parse this field before
> > > getting
> > > + * data from userspace.
> > > + *
> > > + * Availability of this IOCTL is after VFIO_SET_IOMMU.  
> > 
> > Is this a necessary qualifier?  A user can try to call this ioctl at
> > any point, it only makes sense in certain configurations, but it
> > should always "do the right thing" relative to the container iommu
> > config.
> > 
> > Also, I don't see anything in these last few patches testing the
> > operating IOMMU model, what happens when a user calls them when not
> > using the nesting IOMMU?
> > 
> > Is this ioctl and the previous BIND ioctl only valid when configured
> > for the nesting IOMMU type?  
> 
> I think so. We should add the nesting check in those new ioctls.
> 
I also added nesting domain attribute check in IOMMU driver, so bind
guest PASID will fail if nesting mode is not supported. There will be
no invalidation w/o bind.

> >   
> > > + *
> > > + * returns: 0 on success, -errno on failure.
> > > + */
> > > +struct vfio_iommu_type1_cache_invalidate {
> > > +	__u32   argsz;
> > > +	__u32   flags;
> > > +	struct	iommu_cache_invalidate_info cache_info;
> > > +};
> > > +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE,
> > > VFIO_BASE  
> > + 24)
> > 
> > The future extension capabilities of this ioctl worry me, I wonder
> > if we should do another data[] with flag defining that data as
> > CACHE_INFO.  
> 
> Can you elaborate? Does it mean with this way we don't rely on iommu
> driver to provide version_to_size conversion and instead we just pass
> data[] to iommu driver for further audit?
> 
I guess Alex meant we do something similar to:
struct vfio_irq_set {
	__u32	argsz;
	__u32	flags;
#define VFIO_IRQ_SET_DATA_NONE		(1 << 0) /* Data not present */
#define VFIO_IRQ_SET_DATA_BOOL		(1 << 1) /* Data is bool (u8) */
#define VFIO_IRQ_SET_DATA_EVENTFD	(1 << 2) /* Data is eventfd (s32) */
#define VFIO_IRQ_SET_ACTION_MASK	(1 << 3) /* Mask interrupt */
#define VFIO_IRQ_SET_ACTION_UNMASK	(1 << 4) /* Unmask interrupt */
#define VFIO_IRQ_SET_ACTION_TRIGGER	(1 << 5) /* Trigger interrupt */
	__u32	index;
	__u32	start;
	__u32	count;
	__u8	data[];
};

So we could do:
struct vfio_iommu_type1_cache_invalidate {
	__u32   argsz;
#define VFIO_INVL_DATA_NONE
#define VFIO_INVL_DATA_CACHE_INFO		(1 << 1)
	__u32   flags;
	__u8	data[];
}

We still need version_to_size version, but under
if (flag & VFIO_INVL_DATA_CACHE_INFO)
	get_size_from_version();

> >   
> > > +
> > >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU
> > > --------  
> > */  
> > >
> > >  /*  
> 
> Thanks
> Kevin

[Jacob Pan]
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
