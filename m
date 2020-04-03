Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82E15C43331
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 06:39:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505942073B
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 06:39:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505942073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 246D787FC4;
	Fri,  3 Apr 2020 06:39:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r6u-cJE7Fi62; Fri,  3 Apr 2020 06:39:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3AA6F87C03;
	Fri,  3 Apr 2020 06:39:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 256A6C1D74;
	Fri,  3 Apr 2020 06:39:31 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C534FC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 06:39:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B387188E5F
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 06:39:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KYbfR3aqIMIL for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 06:39:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8965588E49
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 06:39:27 +0000 (UTC)
IronPort-SDR: ccRK4ljTc4jyDhvGlZqtR30MIRkVIZ/QZBI2uQBIMk3BmxNbmuaY9T8Jvfj4wiyfxjda1A0NPF
 IvaRBiZnRnog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2020 23:39:27 -0700
IronPort-SDR: 5iJVXddH3lIvhNSOFpH5j5+FVVo7ULZsXV/1r9WoGmk/jPiwzGKCuNLTnZmwP3WOYSGHBK+4Tp
 NBWBdm1amtvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,338,1580803200"; d="scan'208";a="243358799"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga008.jf.intel.com with ESMTP; 02 Apr 2020 23:39:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Apr 2020 23:39:26 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Apr 2020 23:39:25 -0700
Received: from shsmsx154.ccr.corp.intel.com (10.239.6.54) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Apr 2020 23:39:25 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX154.ccr.corp.intel.com ([169.254.7.214]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 14:39:22 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>
Subject: RE: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHWAEUdbUtKvEWiiEiZu1SnRvWegKhl0sQAgAEuFaA=
Date: Fri, 3 Apr 2020 06:39:22 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
In-Reply-To: <20200402142428.2901432e@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Tian, Jun J" <jun.j.tian@intel.com>, "Wu,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 3, 2020 4:24 AM
> 
> On Sun, 22 Mar 2020 05:32:04 -0700
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@linux.intel.com>
> >
> > For VFIO IOMMUs with the type VFIO_TYPE1_NESTING_IOMMU, guest
> "owns" the
> > first-level/stage-1 translation structures, the host IOMMU driver has no
> > knowledge of first-level/stage-1 structure cache updates unless the guest
> > invalidation requests are trapped and propagated to the host.
> >
> > This patch adds a new IOCTL VFIO_IOMMU_CACHE_INVALIDATE to
> propagate guest
> > first-level/stage-1 IOMMU cache invalidations to host to ensure IOMMU
> cache
> > correctness.
> >
> > With this patch, vSVA (Virtual Shared Virtual Addressing) can be used safely
> > as the host IOMMU iotlb correctness are ensured.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 49
> +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       | 22 ++++++++++++++++++
> >  2 files changed, 71 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> b/drivers/vfio/vfio_iommu_type1.c
> > index a877747..937ec3f 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2423,6 +2423,15 @@ static long
> vfio_iommu_type1_unbind_gpasid(struct vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_cache_inv_fn(struct device *dev, void *data)
> > +{
> > +	struct domain_capsule *dc = (struct domain_capsule *)data;
> > +	struct iommu_cache_invalidate_info *cache_inv_info =
> > +		(struct iommu_cache_invalidate_info *) dc->data;
> > +
> > +	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)
> >  {
> > @@ -2629,6 +2638,46 @@ static long vfio_iommu_type1_ioctl(void
> *iommu_data,
> >  		}
> >  		kfree(gbind_data);
> >  		return ret;
> > +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> > +		struct vfio_iommu_type1_cache_invalidate cache_inv;
> > +		u32 version;
> > +		int info_size;
> > +		void *cache_info;
> > +		int ret;
> > +
> > +		minsz = offsetofend(struct
> vfio_iommu_type1_cache_invalidate,
> > +				    flags);
> 
> This breaks backward compatibility as soon as struct
> iommu_cache_invalidate_info changes size by its defined versioning
> scheme.  ie. a field gets added, the version is bumped, all existing
> userspace breaks.  Our minsz is offsetofend to the version field,
> interpret the version to size, then reevaluate argsz.

btw the version scheme is challenged by Christoph Hellwig. After
some discussions, we need your guidance how to move forward.
Jacob summarized available options below:
	https://lkml.org/lkml/2020/4/2/876

> 
> > +
> > +		if (copy_from_user(&cache_inv, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		if (cache_inv.argsz < minsz || cache_inv.flags)
> > +			return -EINVAL;
> > +
> > +		/* Get the version of struct iommu_cache_invalidate_info */
> > +		if (copy_from_user(&version,
> > +			(void __user *) (arg + minsz), sizeof(version)))
> > +			return -EFAULT;
> > +
> > +		info_size = iommu_uapi_get_data_size(
> > +					IOMMU_UAPI_CACHE_INVAL,
> version);
> > +
> > +		cache_info = kzalloc(info_size, GFP_KERNEL);
> > +		if (!cache_info)
> > +			return -ENOMEM;
> > +
> > +		if (copy_from_user(cache_info,
> > +			(void __user *) (arg + minsz), info_size)) {
> > +			kfree(cache_info);
> > +			return -EFAULT;
> > +		}
> > +
> > +		mutex_lock(&iommu->lock);
> > +		ret = vfio_iommu_for_each_dev(iommu, vfio_cache_inv_fn,
> > +					    cache_info);
> 
> How does a user respond when their cache invalidate fails?  Isn't this
> also another case where our for_each_dev can fail at an arbitrary point
> leaving us with no idea whether each device even had the opportunity to
> perform the invalidation request.  I don't see how we have any chance
> to maintain coherency after this faults.

Then can we make it simple to support singleton group only? 

> 
> > +		mutex_unlock(&iommu->lock);
> > +		kfree(cache_info);
> > +		return ret;
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 2235bc6..62ca791 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -899,6 +899,28 @@ struct vfio_iommu_type1_bind {
> >   */
> >  #define VFIO_IOMMU_BIND		_IO(VFIO_TYPE, VFIO_BASE + 23)
> >
> > +/**
> > + * VFIO_IOMMU_CACHE_INVALIDATE - _IOW(VFIO_TYPE, VFIO_BASE + 24,
> > + *			struct vfio_iommu_type1_cache_invalidate)
> > + *
> > + * Propagate guest IOMMU cache invalidation to the host. The cache
> > + * invalidation information is conveyed by @cache_info, the content
> > + * format would be structures defined in uapi/linux/iommu.h. User
> > + * should be aware of that the struct  iommu_cache_invalidate_info
> > + * has a @version field, vfio needs to parse this field before getting
> > + * data from userspace.
> > + *
> > + * Availability of this IOCTL is after VFIO_SET_IOMMU.
> 
> Is this a necessary qualifier?  A user can try to call this ioctl at
> any point, it only makes sense in certain configurations, but it should
> always "do the right thing" relative to the container iommu config.
> 
> Also, I don't see anything in these last few patches testing the
> operating IOMMU model, what happens when a user calls them when not
> using the nesting IOMMU?
> 
> Is this ioctl and the previous BIND ioctl only valid when configured
> for the nesting IOMMU type?

I think so. We should add the nesting check in those new ioctls.

> 
> > + *
> > + * returns: 0 on success, -errno on failure.
> > + */
> > +struct vfio_iommu_type1_cache_invalidate {
> > +	__u32   argsz;
> > +	__u32   flags;
> > +	struct	iommu_cache_invalidate_info cache_info;
> > +};
> > +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE, VFIO_BASE
> + 24)
> 
> The future extension capabilities of this ioctl worry me, I wonder if
> we should do another data[] with flag defining that data as CACHE_INFO.

Can you elaborate? Does it mean with this way we don't rely on iommu
driver to provide version_to_size conversion and instead we just pass
data[] to iommu driver for further audit?

> 
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU --------
> */
> >
> >  /*

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
