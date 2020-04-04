Return-Path: <SRS0=lnwu=5U=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6523FC2BA17
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 11:36:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3587A2072B
	for <iommu@archiver.kernel.org>; Sat,  4 Apr 2020 11:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3587A2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E220220428;
	Sat,  4 Apr 2020 11:36:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YXRsz2PgnXII; Sat,  4 Apr 2020 11:36:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3A2A520397;
	Sat,  4 Apr 2020 11:36:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 292DAC1AE2;
	Sat,  4 Apr 2020 11:36:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 062F8C07FF
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 11:36:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id F3D4687A22
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 11:36:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cX+PoXlBrUk5 for <iommu@lists.linux-foundation.org>;
 Sat,  4 Apr 2020 11:36:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 251BB877F2
 for <iommu@lists.linux-foundation.org>; Sat,  4 Apr 2020 11:36:13 +0000 (UTC)
IronPort-SDR: h1MQXCa00OQCxlYTbU0kzGMcrPOQieE+itfaamrczvS/Kv8VXSscQsHkbgjhFo/CxZSQBk/eLS
 +JTHHOXInSIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Apr 2020 04:36:12 -0700
IronPort-SDR: 2eP0Nt9qDX4mdk6GECzSVxxk+t0i2u3uat50f2AR8lOiwfkAnoRYsiMOQvmhVG4XY9TIOpcVrs
 VQTg5Oe3Crng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,343,1580803200"; d="scan'208";a="253628078"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by orsmga006.jf.intel.com with ESMTP; 04 Apr 2020 04:36:11 -0700
Received: from fmsmsx119.amr.corp.intel.com (10.18.124.207) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 04:36:11 -0700
Received: from shsmsx103.ccr.corp.intel.com (10.239.4.69) by
 FMSMSX119.amr.corp.intel.com (10.18.124.207) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sat, 4 Apr 2020 04:36:10 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX103.ccr.corp.intel.com ([169.254.4.146]) with mapi id 14.03.0439.000;
 Sat, 4 Apr 2020 19:36:07 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Thread-Topic: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
 userspace
Thread-Index: AQHWAEUdmZ6qeWVhq0GPreoHiPHgtahlqq4AgAF03/CAABRGgIABtdZg
Date: Sat, 4 Apr 2020 11:36:07 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A221B6E@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-4-git-send-email-yi.l.liu@intel.com>
 <20200402120100.19e43c72@w520.home>
 <A2975661238FB949B60364EF0F2C25743A220662@SHSMSX104.ccr.corp.intel.com>
 <20200403112807.30a56c48@w520.home>
In-Reply-To: <20200403112807.30a56c48@w520.home>
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
> Sent: Saturday, April 4, 2020 1:28 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Cc: eric.auger@redhat.com; Tian, Kevin <kevin.tian@intel.com>;
> jacob.jun.pan@linux.intel.com; joro@8bytes.org; Raj, Ashok <ashok.raj@intel.com>;
> Tian, Jun J <jun.j.tian@intel.com>; Sun, Yi Y <yi.y.sun@intel.com>; jean-
> philippe@linaro.org; peterx@redhat.com; iommu@lists.linux-foundation.org;
> kvm@vger.kernel.org; linux-kernel@vger.kernel.org; Wu, Hao <hao.wu@intel.com>
> Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free support to
> userspace
> 
> On Fri, 3 Apr 2020 08:17:44 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > > From: Alex Williamson < alex.williamson@redhat.com >
> > > Sent: Friday, April 3, 2020 2:01 AM
> > > To: Liu, Yi L <yi.l.liu@intel.com>
> > > Subject: Re: [PATCH v1 3/8] vfio/type1: Report PASID alloc/free
> > > support to userspace
> > >
> > > On Sun, 22 Mar 2020 05:32:00 -0700
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > >
> > > > This patch reports PASID alloc/free availability to userspace (e.g.
> > > > QEMU) thus userspace could do a pre-check before utilizing this feature.
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > ---
> > > >  drivers/vfio/vfio_iommu_type1.c | 28 ++++++++++++++++++++++++++++
> > > >  include/uapi/linux/vfio.h       |  8 ++++++++
> > > >  2 files changed, 36 insertions(+)
> > > >
> > > > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > > > b/drivers/vfio/vfio_iommu_type1.c index e40afc0..ddd1ffe 100644
> > > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > @@ -2234,6 +2234,30 @@ static int
> > > > vfio_iommu_type1_pasid_free(struct
> > > vfio_iommu *iommu,
> > > >  	return ret;
> > > >  }
> > > >
> > > > +static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> > > > +					 struct vfio_info_cap *caps) {
> > > > +	struct vfio_info_cap_header *header;
> > > > +	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > > > +
> > > > +	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> > > > +				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING, 1);
> > > > +	if (IS_ERR(header))
> > > > +		return PTR_ERR(header);
> > > > +
> > > > +	nesting_cap = container_of(header,
> > > > +				struct vfio_iommu_type1_info_cap_nesting,
> > > > +				header);
> > > > +
> > > > +	nesting_cap->nesting_capabilities = 0;
> > > > +	if (iommu->nesting) {
> > > > +		/* nesting iommu type supports PASID requests (alloc/free) */
> > > > +		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> > > > +	}
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > >  				   unsigned int cmd, unsigned long arg)  { @@ -
> > > 2283,6 +2307,10 @@
> > > > static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > >  		if (ret)
> > > >  			return ret;
> > > >
> > > > +		ret = vfio_iommu_info_add_nesting_cap(iommu, &caps);
> > > > +		if (ret)
> > > > +			return ret;
> > > > +
> > > >  		if (caps.size) {
> > > >  			info.flags |= VFIO_IOMMU_INFO_CAPS;
> > > >
> > > > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > > > index 298ac80..8837219 100644
> > > > --- a/include/uapi/linux/vfio.h
> > > > +++ b/include/uapi/linux/vfio.h
> > > > @@ -748,6 +748,14 @@ struct vfio_iommu_type1_info_cap_iova_range {
> > > >  	struct	vfio_iova_range iova_ranges[];
> > > >  };
> > > >
> > > > +#define VFIO_IOMMU_TYPE1_INFO_CAP_NESTING  2
> > > > +
> > > > +struct vfio_iommu_type1_info_cap_nesting {
> > > > +	struct	vfio_info_cap_header header;
> > > > +#define VFIO_IOMMU_PASID_REQS	(1 << 0)
> > > > +	__u32	nesting_capabilities;
> > > > +};
> > > > +
> > > >  #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
> > > >
> > > >  /**
> > >
> > > I think this answers my PROBE question on patch 1/.
> > yep.
> > > Should the quota/usage be exposed to the user here?  Thanks,
> >
> > Do you mean report the quota available for this user in this cap info as well?
> 
> Yes.  Would it be useful?

I think so.

> > For usage, do you mean the alloc and free or others?
> 
> I mean how many of the quota are currently in allocated, or alternatively, how
> many remain.  Thanks,

ok, got it, maybe report the remain. thanks.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
