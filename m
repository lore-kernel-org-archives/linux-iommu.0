Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,URI_WP_DIRINDEX autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB547C43331
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:52:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EEA120714
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:52:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EEA120714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 792C587D33;
	Wed,  1 Apr 2020 07:52:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5xQcwwk2irh; Wed,  1 Apr 2020 07:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CFBA48798A;
	Wed,  1 Apr 2020 07:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AD848C1D7F;
	Wed,  1 Apr 2020 07:52:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A65C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:52:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id ACC41869F2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id riDvw6ibjyti for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 07:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 47310869D3
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:52:04 +0000 (UTC)
IronPort-SDR: T7Y8lL3rfPIzAgNIxxo/xAPrnBERSj2L0kcxf4E0qOhAqMXbRsj7eZrdMbv1fRFUqfxLdVxd9M
 v4sH/9mbFP0w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 00:52:03 -0700
IronPort-SDR: qjalB6i8rzSE1cNafZFtUEwCxr3AD+Ct8Vt4cK9JUv1EJgQwpxJlbROb+h7ao7o/id78UvK6qb
 ahaUhs5mco5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="359774634"
Received: from fmsmsx107.amr.corp.intel.com ([10.18.124.205])
 by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2020 00:52:03 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx107.amr.corp.intel.com (10.18.124.205) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 00:52:03 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 00:52:03 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 00:52:03 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 15:51:59 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed mdevs
Thread-Topic: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Index: AQHWAEUdm3FJ38v7KEeZ+HXvm2TTUKhgpNwAgANOv6A=
Date: Wed, 1 Apr 2020 07:51:58 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21D71A@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-9-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FFA90@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FFA90@SHSMSX104.ccr.corp.intel.com>
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
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

> From: Tian, Kevin <kevin.tian@intel.com>
> Sent: Monday, March 30, 2020 9:19 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed
> mdevs
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Sunday, March 22, 2020 8:32 PM
> >
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> > are used to achieve flexible device sharing across domains (e.g. VMs).
> 
> are->is

got it.

> > Also there are hardware assisted mediated pass-through solutions from
> > platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> > Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> > backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> > In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-
> > domain concept, which means mdevs are protected by an iommu domain
> > which is aux-domain of its physical device. Details can be found in
> > the KVM
> 
> "by an iommu domain which is auxiliary to the domain that the kernel driver
> primarily uses for DMA API"

yep.

> > presentation from Kevin Tian. IOMMU-backed equals to IOMMU-capable.
> >
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> > Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> >
> > This patch supports NESTING IOMMU for IOMMU-backed mdevs by figuring
> > out the physical device of an IOMMU-backed mdev and then invoking
> > IOMMU requests to IOMMU layer with the physical device and the mdev's
> > aux domain info.
> 
> "and then calling into the IOMMU layer to complete the vSVA operations on the aux
> domain associated with that mdev"

got it.
> >
> > With this patch, vSVA (Virtual Shared Virtual Addressing) can be used
> > on IOMMU-backed mdevs.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > CC: Jun Tian <jun.j.tian@intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 23 ++++++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 937ec3f..d473665 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -132,6 +132,7 @@ struct vfio_regions {
> >
> >  struct domain_capsule {
> >  	struct iommu_domain *domain;
> > +	struct vfio_group *group;
> >  	void *data;
> >  };
> >
> > @@ -148,6 +149,7 @@ static int vfio_iommu_for_each_dev(struct
> > vfio_iommu *iommu,
> >  	list_for_each_entry(d, &iommu->domain_list, next) {
> >  		dc.domain = d->domain;
> >  		list_for_each_entry(g, &d->group_list, next) {
> > +			dc.group = g;
> >  			ret = iommu_group_for_each_dev(g->iommu_group,
> >  						       &dc, fn);
> >  			if (ret)
> > @@ -2347,7 +2349,12 @@ static int vfio_bind_gpasid_fn(struct device
> > *dev, void *data)
> >  	struct iommu_gpasid_bind_data *gbind_data =
> >  		(struct iommu_gpasid_bind_data *) dc->data;
> >
> > -	return iommu_sva_bind_gpasid(dc->domain, dev, gbind_data);
> > +	if (dc->group->mdev_group)
> > +		return iommu_sva_bind_gpasid(dc->domain,
> > +			vfio_mdev_get_iommu_device(dev), gbind_data);
> > +	else
> > +		return iommu_sva_bind_gpasid(dc->domain,
> > +						dev, gbind_data);
> >  }
> >
> >  static int vfio_unbind_gpasid_fn(struct device *dev, void *data) @@
> > -2356,8 +2363,13 @@ static int vfio_unbind_gpasid_fn(struct device
> > *dev, void *data)
> >  	struct iommu_gpasid_bind_data *gbind_data =
> >  		(struct iommu_gpasid_bind_data *) dc->data;
> >
> > -	return iommu_sva_unbind_gpasid(dc->domain, dev,
> > +	if (dc->group->mdev_group)
> > +		return iommu_sva_unbind_gpasid(dc->domain,
> > +					vfio_mdev_get_iommu_device(dev),
> >  					gbind_data->hpasid);
> > +	else
> > +		return iommu_sva_unbind_gpasid(dc->domain, dev,
> > +						gbind_data->hpasid);
> >  }
> >
> >  /**
> > @@ -2429,7 +2441,12 @@ static int vfio_cache_inv_fn(struct device
> > *dev, void *data)
> >  	struct iommu_cache_invalidate_info *cache_inv_info =
> >  		(struct iommu_cache_invalidate_info *) dc->data;
> >
> > -	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
> > +	if (dc->group->mdev_group)
> > +		return iommu_cache_invalidate(dc->domain,
> > +			vfio_mdev_get_iommu_device(dev), cache_inv_info);
> > +	else
> > +		return iommu_cache_invalidate(dc->domain,
> > +						dev, cache_inv_info);
> >  }
> 
> possibly above could be simplified, e.g.
> 
> static struct device *vfio_get_iommu_device(struct vfio_group *group,
> 	struct device *dev)
> {
> 	if  (group->mdev_group)
> 		return vfio_mdev_get_iommu_device(dev);
> 	else
> 		return dev;
> }
> 
> Then use it to replace plain 'dev' in all three places.

yes, better for reading. thanks.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
