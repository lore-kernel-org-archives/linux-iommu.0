Return-Path: <SRS0=meaX=6A=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C8AC2BB85
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:40:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16614206B9
	for <iommu@archiver.kernel.org>; Thu, 16 Apr 2020 10:40:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16614206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C712F84C99;
	Thu, 16 Apr 2020 10:40:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fduQCtc+2Hd7; Thu, 16 Apr 2020 10:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id F2F2B84C09;
	Thu, 16 Apr 2020 10:40:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D15DEC1AE8;
	Thu, 16 Apr 2020 10:40:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 21E8DC0172
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:40:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1BFC987568
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U+lDNcvqqJp0 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Apr 2020 10:40:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 386C687263
 for <iommu@lists.linux-foundation.org>; Thu, 16 Apr 2020 10:40:09 +0000 (UTC)
IronPort-SDR: xfeFP48bx+QtR6IzGLxEmv7vDxMxOKqdqXbaKdfkyolVxqlYOKq61rvBFX2XO4t54n67E++VCq
 BOxpVqKYsQWA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 03:40:08 -0700
IronPort-SDR: xNHXCsemG8ocpE+IioNARwcyCC2nV/4MzsdvoKLGtCR7+CYIAKlmQEHwym/WVaKMczxdRNkkGx
 LTzmLvUYZQng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,390,1580803200"; d="scan'208";a="332798286"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by orsmga001.jf.intel.com with ESMTP; 16 Apr 2020 03:40:08 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 03:40:07 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 03:40:06 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 18:40:04 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>
Subject: RE: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHWAEUdcc1u01skwUmp6uBHREsZ66hl0sQAgACrzQCAAJWLAIAUkGLA
Date: Thu, 16 Apr 2020 10:40:03 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A231BAA@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
 <20200403093436.094b1928@w520.home>
In-Reply-To: <20200403093436.094b1928@w520.home>
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

Hi Alex,
Still have a direction question with you. Better get agreement with you
before heading forward.

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, April 3, 2020 11:35 PM
[...]
> > > > + *
> > > > + * returns: 0 on success, -errno on failure.
> > > > + */
> > > > +struct vfio_iommu_type1_cache_invalidate {
> > > > +	__u32   argsz;
> > > > +	__u32   flags;
> > > > +	struct	iommu_cache_invalidate_info cache_info;
> > > > +};
> > > > +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE,
> VFIO_BASE
> > > + 24)
> > >
> > > The future extension capabilities of this ioctl worry me, I wonder if
> > > we should do another data[] with flag defining that data as CACHE_INFO.
> >
> > Can you elaborate? Does it mean with this way we don't rely on iommu
> > driver to provide version_to_size conversion and instead we just pass
> > data[] to iommu driver for further audit?
> 
> No, my concern is that this ioctl has a single function, strictly tied
> to the iommu uapi.  If we replace cache_info with data[] then we can
> define a flag to specify that data[] is struct
> iommu_cache_invalidate_info, and if we need to, a different flag to
> identify data[] as something else.  For example if we get stuck
> expanding cache_info to meet new demands and develop a new uapi to
> solve that, how would we expand this ioctl to support it rather than
> also create a new ioctl?  There's also a trade-off in making the ioctl
> usage more difficult for the user.  I'd still expect the vfio layer to
> check the flag and interpret data[] as indicated by the flag rather
> than just passing a blob of opaque data to the iommu layer though.
> Thanks,

Based on your comments about defining a single ioctl and a unified
vfio structure (with a @data[] field) for pasid_alloc/free, bind/
unbind_gpasid, cache_inv. After some offline trying, I think it would
be good for bind/unbind_gpasid and cache_inv as both of them use the
iommu uapi definition. While the pasid alloc/free operation doesn't.
It would be weird to put all of them together. So pasid alloc/free
may have a separate ioctl. It would look as below. Does this direction
look good per your opinion?

ioctl #22: VFIO_IOMMU_PASID_REQUEST
/**
  * @pasid: used to return the pasid alloc result when flags == ALLOC_PASID
  *         specify a pasid to be freed when flags == FREE_PASID
  * @range: specify the allocation range when flags == ALLOC_PASID
  */
struct vfio_iommu_pasid_request {
	__u32	argsz;
#define VFIO_IOMMU_ALLOC_PASID	(1 << 0)
#define VFIO_IOMMU_FREE_PASID	(1 << 1)
	__u32	flags;
	__u32	pasid;
	struct {
		__u32	min;
		__u32	max;
	} range;
};

ioctl #23: VFIO_IOMMU_NESTING_OP
struct vfio_iommu_type1_nesting_op {
	__u32	argsz;
	__u32	flags;
	__u32	op;
	__u8	data[];
};

/* Nesting Ops */
#define VFIO_IOMMU_NESTING_OP_BIND_PGTBL        0
#define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL      1
#define VFIO_IOMMU_NESTING_OP_CACHE_INVLD       2
 
Thanks,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
