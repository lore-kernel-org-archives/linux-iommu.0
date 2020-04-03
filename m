Return-Path: <SRS0=dWuT=5T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URI_WP_DIRINDEX autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B346BC2BA16
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 13:39:35 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CEF0206F5
	for <iommu@archiver.kernel.org>; Fri,  3 Apr 2020 13:39:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CEF0206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 47B4D88E41;
	Fri,  3 Apr 2020 13:39:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6EHH4C4dyCX8; Fri,  3 Apr 2020 13:39:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9110C88DF2;
	Fri,  3 Apr 2020 13:39:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78EC5C1831;
	Fri,  3 Apr 2020 13:39:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D3AFC07FF
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:39:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2BE0286D95
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:39:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id njFI3z_ahCBg for <iommu@lists.linux-foundation.org>;
 Fri,  3 Apr 2020 13:39:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 47E7486D7B
 for <iommu@lists.linux-foundation.org>; Fri,  3 Apr 2020 13:39:32 +0000 (UTC)
IronPort-SDR: H1yYjULCnrL+Ln3N1kv/iKoaZ/TaGLdWB60r90Hc8SaVybtE+lm0aQ/34JS57gPY6USNdHcDwr
 SuQkp5KzfoOQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Apr 2020 06:39:31 -0700
IronPort-SDR: 8GigXOadN4Q1oxFpOj79P+I8YV4QiER2FMPqfIQPp/S4zJTejr2TmdkwG9/FItHsUKUdrfzqzW
 Apt8v/rBmVtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,339,1580803200"; d="scan'208";a="238885929"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga007.jf.intel.com with ESMTP; 03 Apr 2020 06:39:29 -0700
Received: from fmsmsx126.amr.corp.intel.com (10.18.125.43) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 06:39:29 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX126.amr.corp.intel.com (10.18.125.43) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Apr 2020 06:39:29 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Fri, 3 Apr 2020 21:39:27 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed mdevs
Thread-Topic: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed
 mdevs
Thread-Index: AQHWAEUdm3FJ38v7KEeZ+HXvm2TTUKhl1VgAgAGinHA=
Date: Fri, 3 Apr 2020 13:39:26 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A220BCF@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-9-git-send-email-yi.l.liu@intel.com>
 <20200402143342.1e10c498@w520.home>
In-Reply-To: <20200402143342.1e10c498@w520.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, 
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun, Yi
 Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>
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

Hi Alex,

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 3, 2020 4:34 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [PATCH v1 8/8] vfio/type1: Add vSVA support for IOMMU-backed
> mdevs
> 
> On Sun, 22 Mar 2020 05:32:05 -0700
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > Recent years, mediated device pass-through framework (e.g. vfio-mdev)
> > are used to achieve flexible device sharing across domains (e.g. VMs).
> > Also there are hardware assisted mediated pass-through solutions from
> > platform vendors. e.g. Intel VT-d scalable mode which supports Intel
> > Scalable I/O Virtualization technology. Such mdevs are called IOMMU-
> > backed mdevs as there are IOMMU enforced DMA isolation for such mdevs.
> > In kernel, IOMMU-backed mdevs are exposed to IOMMU layer by aux-domain
> > concept, which means mdevs are protected by an iommu domain which is
> > aux-domain of its physical device. Details can be found in the KVM
> > presentation from Kevin Tian. IOMMU-backed equals to IOMMU-capable.
> >
> > https://events19.linuxfoundation.org/wp-content/uploads/2017/12/\
> > Hardware-Assisted-Mediated-Pass-Through-with-VFIO-Kevin-Tian-Intel.pdf
> >
> > This patch supports NESTING IOMMU for IOMMU-backed mdevs by figuring
> > out the physical device of an IOMMU-backed mdev and then invoking IOMMU
> > requests to IOMMU layer with the physical device and the mdev's aux
> > domain info.
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
> > diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> > index 937ec3f..d473665 100644
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
> > @@ -148,6 +149,7 @@ static int vfio_iommu_for_each_dev(struct vfio_iommu
> *iommu,
> >  	list_for_each_entry(d, &iommu->domain_list, next) {
> >  		dc.domain = d->domain;
> >  		list_for_each_entry(g, &d->group_list, next) {
> > +			dc.group = g;
> >  			ret = iommu_group_for_each_dev(g->iommu_group,
> >  						       &dc, fn);
> >  			if (ret)
> > @@ -2347,7 +2349,12 @@ static int vfio_bind_gpasid_fn(struct device *dev, void
> *data)
> >  	struct iommu_gpasid_bind_data *gbind_data =
> >  		(struct iommu_gpasid_bind_data *) dc->data;
> >
> > -	return iommu_sva_bind_gpasid(dc->domain, dev, gbind_data);
> > +	if (dc->group->mdev_group)
> > +		return iommu_sva_bind_gpasid(dc->domain,
> > +			vfio_mdev_get_iommu_device(dev), gbind_data);
> 
> But we can't assume an mdev device is iommu backed, so this can call
> with NULL dev, which appears will pretty quickly segfault
> intel_svm_bind_gpasid.

I don't think the non-iommu backed mdev will not be in the
iommu->domain_list. right? But, yeah, from this function p.o.v
, it is still necessary to do a check. How about adding a check
on the return of vfio_mdev_get_iommu_device(dev)? If iommu_device
is fetch, the mdev should be iommu-backed. does it make sense?

Regards,
Yi Liu

> 
> > +	else
> > +		return iommu_sva_bind_gpasid(dc->domain,
> > +						dev, gbind_data);
> >  }
> >
> >  static int vfio_unbind_gpasid_fn(struct device *dev, void *data)
> > @@ -2356,8 +2363,13 @@ static int vfio_unbind_gpasid_fn(struct device *dev,
> void *data)
> >  	struct iommu_gpasid_bind_data *gbind_data =
> >  		(struct iommu_gpasid_bind_data *) dc->data;
> >
> > -	return iommu_sva_unbind_gpasid(dc->domain, dev,
> > +	if (dc->group->mdev_group)
> > +		return iommu_sva_unbind_gpasid(dc->domain,
> > +					vfio_mdev_get_iommu_device(dev),
> >  					gbind_data->hpasid);
> 
> Same
> 
> > +	else
> > +		return iommu_sva_unbind_gpasid(dc->domain, dev,
> > +						gbind_data->hpasid);
> >  }
> >
> >  /**
> > @@ -2429,7 +2441,12 @@ static int vfio_cache_inv_fn(struct device *dev, void
> *data)
> >  	struct iommu_cache_invalidate_info *cache_inv_info =
> >  		(struct iommu_cache_invalidate_info *) dc->data;
> >
> > -	return iommu_cache_invalidate(dc->domain, dev, cache_inv_info);
> > +	if (dc->group->mdev_group)
> > +		return iommu_cache_invalidate(dc->domain,
> > +			vfio_mdev_get_iommu_device(dev), cache_inv_info);
> 
> And again
> 
> > +	else
> > +		return iommu_cache_invalidate(dc->domain,
> > +						dev, cache_inv_info);
> >  }
> >
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
