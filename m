Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 721DDC2D0F2
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 08:08:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB3620772
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 08:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB3620772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1E575898BF;
	Wed,  1 Apr 2020 08:08:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rLxpbMeHi0KC; Wed,  1 Apr 2020 08:08:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C838898C0;
	Wed,  1 Apr 2020 08:08:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4D2FBC1D7F;
	Wed,  1 Apr 2020 08:08:50 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E310FC089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:08:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DA04526244
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:08:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k87bQllTQ22z for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 08:08:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by silver.osuosl.org (Postfix) with ESMTPS id 6F96B26230
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 08:08:47 +0000 (UTC)
IronPort-SDR: KJkH718M3avFRajUTYEC8zqu2PePKtvnOluP60vOdFgerQ+5rC4awTV2X9ARIf17heGN1SHHLr
 4ALn3GkVxZ0g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 01:08:45 -0700
IronPort-SDR: mwM3RxJRD+DVCxZE5KarfzNMdsG3eTHzmHS0RP/MhIuUhmtMTrh6x84pFxiRjdy8GJdCnL38Yv
 YepXiuOFnS/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,331,1580803200"; d="scan'208";a="242158349"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by fmsmga008.fm.intel.com with ESMTP; 01 Apr 2020 01:08:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 01:08:45 -0700
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 1 Apr 2020 01:08:44 -0700
Received: from shsmsx101.ccr.corp.intel.com (10.239.4.153) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 1 Apr 2020 01:08:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX101.ccr.corp.intel.com ([169.254.1.129]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 16:08:40 +0800
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Topic: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Index: AQHWAEUcrRt83jyTNECgMYM7VBywiqhg9Y6ggAJ0uwCAAIq3IP//fViAgACGYyA=
Date: Wed, 1 Apr 2020 08:08:40 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D19D803F9F@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF8BC@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D5C2@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803F42@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21D793@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A21D793@SHSMSX104.ccr.corp.intel.com>
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Wednesday, April 1, 2020 4:07 PM
> 
> > From: Tian, Kevin <kevin.tian@intel.com>
> > Sent: Wednesday, April 1, 2020 3:56 PM
> > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
> > userspace
> >
> > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > Sent: Wednesday, April 1, 2020 3:38 PM
> > >
> > >  > From: Tian, Kevin <kevin.tian@intel.com>
> > > > Sent: Monday, March 30, 2020 7:49 PM
> > > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > > Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1
> > > > format to userspace
> > > >
> > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > Sent: Sunday, March 22, 2020 8:32 PM
> > > > >
> > > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > > >
> > > > > VFIO exposes IOMMU nesting translation (a.k.a dual stage
> > > > > translation) capability to userspace. Thus applications like QEMU
> > > > > could support vIOMMU with hardware's nesting translation
> > > > > capability for pass-through devices. Before setting up nesting
> > > > > translation for pass-through devices, QEMU and other applications
> > > > > need to learn the supported
> > > > > 1st-lvl/stage-1 translation structure format like page table format.
> > > > >
> > > > > Take vSVA (virtual Shared Virtual Addressing) as an example, to
> > > > > support vSVA for pass-through devices, QEMU setup nesting
> > > > > translation for pass- through devices. The guest page table are
> > > > > configured to host as 1st-lvl/
> > > > > stage-1 page table. Therefore, guest format should be compatible
> > > > > with host side.
> > > > >
> > > > > This patch reports the supported 1st-lvl/stage-1 page table format
> > > > > on the current platform to userspace. QEMU and other alike
> > > > > applications should use this format info when trying to setup
> > > > > IOMMU nesting translation on host IOMMU.
> > > > >
> > > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > > ---
> > > > >  drivers/vfio/vfio_iommu_type1.c | 56
> > > > > +++++++++++++++++++++++++++++++++++++++++
> > > > >  include/uapi/linux/vfio.h       |  1 +
> > > > >  2 files changed, 57 insertions(+)
> > > > >
> > > > > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > > > > b/drivers/vfio/vfio_iommu_type1.c index 9aa2a67..82a9e0b 100644
> > > > > --- a/drivers/vfio/vfio_iommu_type1.c
> > > > > +++ b/drivers/vfio/vfio_iommu_type1.c
> > > > > @@ -2234,11 +2234,66 @@ static int
> > > vfio_iommu_type1_pasid_free(struct
> > > > > vfio_iommu *iommu,
> > > > >  	return ret;
> > > > >  }
> > > > >
> > > > > +static int vfio_iommu_get_stage1_format(struct vfio_iommu *iommu,
> > > > > +					 u32 *stage1_format)
> > > > > +{
> > > > > +	struct vfio_domain *domain;
> > > > > +	u32 format = 0, tmp_format = 0;
> > > > > +	int ret;
> > > > > +
> > > > > +	mutex_lock(&iommu->lock);
> > > > > +	if (list_empty(&iommu->domain_list)) {
> > > > > +		mutex_unlock(&iommu->lock);
> > > > > +		return -EINVAL;
> > > > > +	}
> > > > > +
> > > > > +	list_for_each_entry(domain, &iommu->domain_list, next) {
> > > > > +		if (iommu_domain_get_attr(domain->domain,
> > > > > +			DOMAIN_ATTR_PASID_FORMAT, &format)) {
> > > > > +			ret = -EINVAL;
> > > > > +			format = 0;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +		/*
> > > > > +		 * format is always non-zero (the first format is
> > > > > +		 * IOMMU_PASID_FORMAT_INTEL_VTD which is 1).
> For
> > > > > +		 * the reason of potential different backed IOMMU
> > > > > +		 * formats, here we expect to have identical formats
> > > > > +		 * in the domain list, no mixed formats support.
> > > > > +		 * return -EINVAL to fail the attempt of setup
> > > > > +		 * VFIO_TYPE1_NESTING_IOMMU if non-identical
> formats
> > > > > +		 * are detected.
> > > > > +		 */
> > > > > +		if (tmp_format && tmp_format != format) {
> > > > > +			ret = -EINVAL;
> > > > > +			format = 0;
> > > > > +			goto out_unlock;
> > > > > +		}
> > > > > +
> > > > > +		tmp_format = format;
> > > > > +	}
> > > >
> > > > this path is invoked only in VFIO_IOMMU_GET_INFO path. If we don't
> > > > want
> > > to
> > > > assume the status quo that one container holds only one device w/
> > > vIOMMU
> > > > (the prerequisite for vSVA), looks we also need check the format
> > > > compatibility when attaching a new group to this container?
> > >
> > > right. if attaching to a nesting type container (vfio_iommu.nesting
> > > bit indicates it), it should check if it is compabile with prior
> > > domains in the domain list. But if it is the first one attached to
> > > this container, it's fine. is it good?
> >
> > yes, but my point is whether we should check the format compatibility
> > in the attach path...
> 
> I guess so. Assume a device has been attached to a container, and
> userspace has fetched the nesting cap info. e.g. QEMU will have a
> per-container structure to store the nesting info. And then attach
> another device from a separate group, if its backend iommu supports
> different formats, then it will be a problem. If userspace reads the
> nesting cap info again, it will get a different value. It may affect
> the prior attched device. If userspace doesn't refresh the nesting
> info by re-fetch, then the newly added device may use a format which
> its backend iommu doesn't support.
> 
> Although, the vendor specific iommu driver should ensure all devices
> are backed by iommu units w/ same capability (e.g. format). But it
> would better to have a check in vfio side all the same. how about your
> opinion so far?:-)
> 

I think so. 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
