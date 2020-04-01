Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B8DDC10F26
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:38:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E79220772
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 07:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E79220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DC92D2F850;
	Wed,  1 Apr 2020 07:38:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g3Ejrl9SSSHH; Wed,  1 Apr 2020 07:38:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7DB012F69B;
	Wed,  1 Apr 2020 07:38:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61D8DC1D7F;
	Wed,  1 Apr 2020 07:38:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84FA9C089F
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E6DE88A71
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kyzONYThU3SL for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 07:38:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6FBC288A64
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 07:38:06 +0000 (UTC)
IronPort-SDR: XzKbwmW08gEzboWYKaTgF4nNkU1O+Q/fzRM/3MK1sWHM/FzctshXK/m/8W+UIxUqwtqQ5WuwF4
 I6lLWMWGkznQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Apr 2020 00:38:05 -0700
IronPort-SDR: qJldliYUR2XcyDxWgtedJMpFY/Vo1ZbIs/csueRUNAwXjyk9nBj6TAhYU5VWKZpzXWkQN+A/yk
 grBX2A7Mp/Og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="450443701"
Received: from fmsmsx103.amr.corp.intel.com ([10.18.124.201])
 by fmsmga006.fm.intel.com with ESMTP; 01 Apr 2020 00:38:04 -0700
Received: from fmsmsx120.amr.corp.intel.com (10.18.124.208) by
 FMSMSX103.amr.corp.intel.com (10.18.124.201) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 00:38:04 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx120.amr.corp.intel.com (10.18.124.208) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Wed, 1 Apr 2020 00:38:04 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 15:38:00 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Topic: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
 userspace
Thread-Index: AQHWAEUcqZEEdiOKbEGofjWp2Yic+6hgi66AgANAF4A=
Date: Wed, 1 Apr 2020 07:38:00 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21D5C2@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-6-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF8BC@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF8BC@SHSMSX104.ccr.corp.intel.com>
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
> Sent: Monday, March 30, 2020 7:49 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [PATCH v1 5/8] vfio/type1: Report 1st-level/stage-1 format to
> userspace
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Sunday, March 22, 2020 8:32 PM
> >
> > From: Liu Yi L <yi.l.liu@intel.com>
> >
> > VFIO exposes IOMMU nesting translation (a.k.a dual stage translation)
> > capability to userspace. Thus applications like QEMU could support
> > vIOMMU with hardware's nesting translation capability for pass-through
> > devices. Before setting up nesting translation for pass-through
> > devices, QEMU and other applications need to learn the supported
> > 1st-lvl/stage-1 translation structure format like page table format.
> >
> > Take vSVA (virtual Shared Virtual Addressing) as an example, to
> > support vSVA for pass-through devices, QEMU setup nesting translation
> > for pass- through devices. The guest page table are configured to host
> > as 1st-lvl/
> > stage-1 page table. Therefore, guest format should be compatible with
> > host side.
> >
> > This patch reports the supported 1st-lvl/stage-1 page table format on
> > the current platform to userspace. QEMU and other alike applications
> > should use this format info when trying to setup IOMMU nesting
> > translation on host IOMMU.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 56
> > +++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       |  1 +
> >  2 files changed, 57 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 9aa2a67..82a9e0b 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2234,11 +2234,66 @@ static int vfio_iommu_type1_pasid_free(struct
> > vfio_iommu *iommu,
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_get_stage1_format(struct vfio_iommu *iommu,
> > +					 u32 *stage1_format)
> > +{
> > +	struct vfio_domain *domain;
> > +	u32 format = 0, tmp_format = 0;
> > +	int ret;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (list_empty(&iommu->domain_list)) {
> > +		mutex_unlock(&iommu->lock);
> > +		return -EINVAL;
> > +	}
> > +
> > +	list_for_each_entry(domain, &iommu->domain_list, next) {
> > +		if (iommu_domain_get_attr(domain->domain,
> > +			DOMAIN_ATTR_PASID_FORMAT, &format)) {
> > +			ret = -EINVAL;
> > +			format = 0;
> > +			goto out_unlock;
> > +		}
> > +		/*
> > +		 * format is always non-zero (the first format is
> > +		 * IOMMU_PASID_FORMAT_INTEL_VTD which is 1). For
> > +		 * the reason of potential different backed IOMMU
> > +		 * formats, here we expect to have identical formats
> > +		 * in the domain list, no mixed formats support.
> > +		 * return -EINVAL to fail the attempt of setup
> > +		 * VFIO_TYPE1_NESTING_IOMMU if non-identical formats
> > +		 * are detected.
> > +		 */
> > +		if (tmp_format && tmp_format != format) {
> > +			ret = -EINVAL;
> > +			format = 0;
> > +			goto out_unlock;
> > +		}
> > +
> > +		tmp_format = format;
> > +	}
> 
> this path is invoked only in VFIO_IOMMU_GET_INFO path. If we don't want to
> assume the status quo that one container holds only one device w/ vIOMMU
> (the prerequisite for vSVA), looks we also need check the format
> compatibility when attaching a new group to this container?

right. if attaching to a nesting type container (vfio_iommu.nesting bit
indicates it), it should check if it is compabile with prior domains in
the domain list. But if it is the first one attached to this container,
it's fine. is it good?

> > +	ret = 0;
> > +
> > +out_unlock:
> > +	if (format)
> > +		*stage1_format = format;
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static int vfio_iommu_info_add_nesting_cap(struct vfio_iommu *iommu,
> >  					 struct vfio_info_cap *caps)
> >  {
> >  	struct vfio_info_cap_header *header;
> >  	struct vfio_iommu_type1_info_cap_nesting *nesting_cap;
> > +	u32 formats = 0;
> > +	int ret;
> > +
> > +	ret = vfio_iommu_get_stage1_format(iommu, &formats);
> > +	if (ret) {
> > +		pr_warn("Failed to get stage-1 format\n");
> > +		return ret;
> > +	}
> >
> >  	header = vfio_info_cap_add(caps, sizeof(*nesting_cap),
> >  				   VFIO_IOMMU_TYPE1_INFO_CAP_NESTING,
> > 1);
> > @@ -2254,6 +2309,7 @@ static int
> > vfio_iommu_info_add_nesting_cap(struct
> > vfio_iommu *iommu,
> >  		/* nesting iommu type supports PASID requests (alloc/free) */
> >  		nesting_cap->nesting_capabilities |= VFIO_IOMMU_PASID_REQS;
> >  	}
> > +	nesting_cap->stage1_formats = formats;
> >
> >  	return 0;
> >  }
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index ed9881d..ebeaf3e 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -763,6 +763,7 @@ struct vfio_iommu_type1_info_cap_nesting {
> >  	struct	vfio_info_cap_header header;
> >  #define VFIO_IOMMU_PASID_REQS	(1 << 0)
> >  	__u32	nesting_capabilities;
> > +	__u32	stage1_formats;
> 
> do you plan to support multiple formats? If not, use singular name.

I do have such plan. e.g. it may be helpful when one day a platform can
support multiple formats.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
