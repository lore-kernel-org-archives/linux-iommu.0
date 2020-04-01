Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCAF6C18E5B
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:14:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B84420714
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 13:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B84420714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 745EF203BE;
	Wed,  1 Apr 2020 13:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Co2uBcwphDfU; Wed,  1 Apr 2020 13:14:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 18DAE20027;
	Wed,  1 Apr 2020 13:14:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E96F0C1D7F;
	Wed,  1 Apr 2020 13:14:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4061EC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2A0B885E93
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QTaJffmgiHPM for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 13:13:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7E4E685E8C
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 13:13:59 +0000 (UTC)
IronPort-SDR: 97R/JdnlbCuF1HzVUQ0dKd4QgkzEWeGUgFW3nMOPoL2tjLuJFQ6+nKUjUsdF4e27GQDfCfPMxY
 eswKxQ6pvq8Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 06:13:58 -0700
IronPort-SDR: rZNdtC/kYipPD2Ebjt/Fz5xT+31tfE0O32t4WmAu6TY4ZirdoB03QiwzWTZF7D3dDO40r9csoJ
 MErX6EAbTlbA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; d="scan'208";a="295328694"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by FMSMGA003.fm.intel.com with ESMTP; 01 Apr 2020 06:13:58 -0700
Received: from fmsmsx153.amr.corp.intel.com (10.18.125.6) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 06:13:58 -0700
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 FMSMSX153.amr.corp.intel.com (10.18.125.6) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 06:13:58 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.209]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 21:13:54 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Thread-Topic: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Thread-Index: AQHWAEUdmZ6qeWVhq0GPreoHiPHgtahjjLGAgAC7stA=
Date: Wed, 1 Apr 2020 13:13:53 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21DBAF@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
 <1b720777-8334-936e-5edb-802b3dae7b05@redhat.com>
In-Reply-To: <1b720777-8334-936e-5edb-802b3dae7b05@redhat.com>
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Wednesday, April 1, 2020 5:41 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com
> Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
> userspace
> 
> Yi,
> On 3/22/20 1:32 PM, Liu, Yi L wrote:
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > This patch reports PASID alloc/free availability to userspace (e.g.
> > QEMU) thus userspace could do a pre-check before utilizing this feature.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 28 ++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       |  8 ++++++++
> >  2 files changed, 36 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index e40afc0..ddd1ffe 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2234,6 +2234,30 @@ static int vfio_iommu_type1_pasid_free(struct
> vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> > +					 struct vfio_info_cap *caps)
> > +{
> > +	struct vfio_info_cap_header *header;
> > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > +
> > +	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> > +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> > +	if (IS_ERR(header))
> > +		return PTR_ERR(header);
> > +
> > +	nesting_cap = container_of(header,
> > +				struct vfio_iommu_type1_info_cap_nesting,
> > +				header);
> > +
> > +	nesting_cap->nesting_capabilities = 0;
> > +	if (iommu->nesting) {
> > +		/* nesting iommu type supports PASID requests (alloc/free) */
> > +		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> Supporting nesting does not necessarily mean supporting PASID.

here I think the PASID is somehow IDs in kernel which can be used to
tag various address spaces provided by guest software. I think this
is why we introduced the ioasid. :-) Current implementation is doing
PASID alloc/free in vfio.

> > +	}
> > +
> > +	return 0;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2283,6 +2307,10 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		if (ret)
> >  			return ret;
> >
> > +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> > +		if (ret)
> > +			return ret;
> > +
> >  		if (caps.size) {
> >  			info.flags |= VFIO_IOMMU_INFO_CAPS;
> >
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 298ac80..8837219 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -748,6 +748,14 @@ struct vfio_iommu_type1_info_cap_iova_range {
> >  	struct	vfio_iova_range iova_ranges[];
> >  };
> >
> > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  2
> > +
> > +struct vfio_iommu_type1_info_cap_nesting {
> > +	struct	vfio_info_cap_header header;
> > +#define VFIO_IOMMU_PASID_REQS	(1 << 0)
> PASID_REQS sounds a bit far from the claimed host managed alloc/free
> capability.
> VFIO_IOMMU_SYSTEM_WIDE_PASID?

Oh, yep. I can rename it.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
