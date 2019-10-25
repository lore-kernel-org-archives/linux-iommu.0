Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B92A4CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:20:45 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A30C2070B
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:20:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A30C2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 5CE2113A6;
	Fri, 25 Oct 2019 11:20:45 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 4F4A313A5
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:20:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id C41AC87B
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:20:43 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 04:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="210694329"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
	by orsmga002.jf.intel.com with ESMTP; 25 Oct 2019 04:20:42 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
	FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:20:42 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
	fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:20:42 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
	SHSMSX152.ccr.corp.intel.com ([10.239.6.52]) with mapi id
	14.03.0439.000; Fri, 25 Oct 2019 19:20:40 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHVimn1O4LuhvsTnkSBp1bprAulHadqjiuAgACo1uA=
Date: Fri, 25 Oct 2019 11:20:40 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0D7C23@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-2-git-send-email-yi.l.liu@intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5D04AD@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D04AD@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZmZkY2FkMjMtYWM2YS00YTgxLTliMWItZmUyNmY3NzdkNGU4IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiWTVIcmVmVHR4NUZLUVhIbFloVG95UGRQZEVQOTJxRXJiU3F5Y2o2Y2VyRkFaY1hTeElzbW9GZDFudE5qT1h2ayJ9
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Sun, Yi Y" <yi.y.sun@intel.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Kevin,

> From: Tian, Kevin
> Sent: Friday, October 25, 2019 5:14 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [RFC v2 1/3] vfio: VFIO_IOMMU_CACHE_INVALIDATE
> 
> > From: Liu, Yi L
> > Sent: Thursday, October 24, 2019 8:26 PM
> >
> > From: Liu Yi L <yi.l.liu@linux.intel.com>
> >
> > When the guest "owns" the stage 1 translation structures,  the host
> > IOMMU driver has no knowledge of caching structure updates unless the
> > guest invalidation requests are trapped and passed down to the host.
> >
> > This patch adds the VFIO_IOMMU_CACHE_INVALIDATE ioctl with aims at
> > propagating guest stage1 IOMMU cache invalidations to the host.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@linux.intel.com>
> > Signed-off-by: Eric Auger <eric.auger@redhat.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 55
> > +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       | 13 ++++++++++
> >  2 files changed, 68 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 96fddc1d..cd8d3a5 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -124,6 +124,34 @@ struct vfio_regions {
> >  #define IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)	\
> >  					(!list_empty(&iommu->domain_list))
> >
> > +struct domain_capsule {
> > +	struct iommu_domain *domain;
> > +	void *data;
> > +};
> > +
> > +/* iommu->lock must be held */
> > +static int
> > +vfio_iommu_lookup_dev(struct vfio_iommu *iommu,
> > +		      int (*fn)(struct device *dev, void *data),
> > +		      void *data)
> 
> 'lookup' usually means find a device and then return. But the real purpose here is to
> loop all the devices within this container and then do something. Does it make more
> sense to be vfio_iommu_for_each_dev?

yep, I can replace it.

> 
> > +{
> > +	struct domain_capsule dc = {.data = data};
> > +	struct vfio_domain *d;
[...]
> 2315,6 +2352,24 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >
> >  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> > +	} else if (cmd == VFIO_IOMMU_CACHE_INVALIDATE) {
> > +		struct vfio_iommu_type1_cache_invalidate ustruct;
> 
> it's weird to call a variable as struct.

Will fix it.

> > +		int ret;
> > +
> > +		minsz = offsetofend(struct
> > vfio_iommu_type1_cache_invalidate,
> > +				    info);
> > +
> > +		if (copy_from_user(&ustruct, (void __user *)arg, minsz))
> > +			return -EFAULT;
> > +
> > +		if (ustruct.argsz < minsz || ustruct.flags)
> > +			return -EINVAL;
> > +
> > +		mutex_lock(&iommu->lock);
> > +		ret = vfio_iommu_lookup_dev(iommu, vfio_cache_inv_fn,
> > +					    &ustruct);
> > +		mutex_unlock(&iommu->lock);
> > +		return ret;
> >  	}
> >
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 9e843a1..ccf60a2 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -794,6 +794,19 @@ struct vfio_iommu_type1_dma_unmap {
> >  #define VFIO_IOMMU_ENABLE	_IO(VFIO_TYPE, VFIO_BASE + 15)
> >  #define VFIO_IOMMU_DISABLE	_IO(VFIO_TYPE, VFIO_BASE + 16)
> >
> > +/**
> > + * VFIO_IOMMU_CACHE_INVALIDATE - _IOWR(VFIO_TYPE, VFIO_BASE +
> > 24,
> > + *			struct vfio_iommu_type1_cache_invalidate)
> > + *
> > + * Propagate guest IOMMU cache invalidation to the host.
> 
> guest or first-level/stage-1? Ideally userspace application may also bind its own
> address space as stage-1 one day...

Should be first-level/stage-1. Will correct it.

Thanks,
Yi Liu

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
