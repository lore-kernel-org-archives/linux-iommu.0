Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 464A1C352BE
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 06:03:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 192EE21973
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 06:03:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 192EE21973
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id E115687839;
	Fri, 17 Apr 2020 06:03:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yCc-kwAY3rz9; Fri, 17 Apr 2020 06:03:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3FA7487EDB;
	Fri, 17 Apr 2020 06:03:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A5B2C1AE8;
	Fri, 17 Apr 2020 06:03:43 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4363C0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 06:03:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B89DA87EDB
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 06:03:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DBdR3h2QRugq for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 06:03:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CEED487839
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 06:03:40 +0000 (UTC)
IronPort-SDR: WRiiY/YSjUSvECKv8egmqGdPr5YxbiUYZ3onuTG/bQ1eeZ9k14C7DU2o+cmNCYaKFEWggq018o
 t2cQYhFqtV1A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2020 23:03:39 -0700
IronPort-SDR: 3oJfBPD8w2SHu5GVkVWmPFJc87vuY35yXLmk5rjAhOJzer339y32ZGQGwFzeV1X5e+Kd9OhRYN
 3y0MS1cieVfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,393,1580803200"; d="scan'208";a="242903975"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga007.jf.intel.com with ESMTP; 16 Apr 2020 23:03:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 16 Apr 2020 23:03:39 -0700
Received: from fmsmsx608.amr.corp.intel.com (10.18.126.88) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 16 Apr 2020 23:03:38 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 fmsmsx608.amr.corp.intel.com (10.18.126.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 16 Apr 2020 23:03:38 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Fri, 17 Apr 2020 14:03:35 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Topic: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
Thread-Index: AQHWAEUdcc1u01skwUmp6uBHREsZ66hl0sQAgACrzQCAAJWLAIAUkGLA///O0ICAAV9r0A==
Date: Fri, 17 Apr 2020 06:03:35 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A249BF6@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-8-git-send-email-yi.l.liu@intel.com>
 <20200402142428.2901432e@w520.home>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D807C4A@SHSMSX104.ccr.corp.intel.com>
 <20200403093436.094b1928@w520.home>
 <A2975661238FB949B60364EF0F2C25743A231BAA@SHSMSX104.ccr.corp.intel.com>
 <20200416084031.7266ad40@w520.home>
In-Reply-To: <20200416084031.7266ad40@w520.home>
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
> Sent: Thursday, April 16, 2020 10:41 PM
> To: Liu, Yi L <yi.l.liu@intel.com>
> Subject: Re: [PATCH v1 7/8] vfio/type1: Add VFIO_IOMMU_CACHE_INVALIDATE
> 
> On Thu, 16 Apr 2020 10:40:03 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> > Still have a direction question with you. Better get agreement with you
> > before heading forward.
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, April 3, 2020 11:35 PM
> > [...]
> > > > > > + *
> > > > > > + * returns: 0 on success, -errno on failure.
> > > > > > + */
> > > > > > +struct vfio_iommu_type1_cache_invalidate {
> > > > > > +	__u32   argsz;
> > > > > > +	__u32   flags;
> > > > > > +	struct	iommu_cache_invalidate_info cache_info;
> > > > > > +};
> > > > > > +#define VFIO_IOMMU_CACHE_INVALIDATE      _IO(VFIO_TYPE,
> > > VFIO_BASE
> > > > > + 24)
> > > > >
> > > > > The future extension capabilities of this ioctl worry me, I wonder if
> > > > > we should do another data[] with flag defining that data as CACHE_INFO.
> > > >
> > > > Can you elaborate? Does it mean with this way we don't rely on iommu
> > > > driver to provide version_to_size conversion and instead we just pass
> > > > data[] to iommu driver for further audit?
> > >
> > > No, my concern is that this ioctl has a single function, strictly tied
> > > to the iommu uapi.  If we replace cache_info with data[] then we can
> > > define a flag to specify that data[] is struct
> > > iommu_cache_invalidate_info, and if we need to, a different flag to
> > > identify data[] as something else.  For example if we get stuck
> > > expanding cache_info to meet new demands and develop a new uapi to
> > > solve that, how would we expand this ioctl to support it rather than
> > > also create a new ioctl?  There's also a trade-off in making the ioctl
> > > usage more difficult for the user.  I'd still expect the vfio layer to
> > > check the flag and interpret data[] as indicated by the flag rather
> > > than just passing a blob of opaque data to the iommu layer though.
> > > Thanks,
> >
> > Based on your comments about defining a single ioctl and a unified
> > vfio structure (with a @data[] field) for pasid_alloc/free, bind/
> > unbind_gpasid, cache_inv. After some offline trying, I think it would
> > be good for bind/unbind_gpasid and cache_inv as both of them use the
> > iommu uapi definition. While the pasid alloc/free operation doesn't.
> > It would be weird to put all of them together. So pasid alloc/free
> > may have a separate ioctl. It would look as below. Does this direction
> > look good per your opinion?
> >
> > ioctl #22: VFIO_IOMMU_PASID_REQUEST
> > /**
> >   * @pasid: used to return the pasid alloc result when flags == ALLOC_PASID
> >   *         specify a pasid to be freed when flags == FREE_PASID
> >   * @range: specify the allocation range when flags == ALLOC_PASID
> >   */
> > struct vfio_iommu_pasid_request {
> > 	__u32	argsz;
> > #define VFIO_IOMMU_ALLOC_PASID	(1 << 0)
> > #define VFIO_IOMMU_FREE_PASID	(1 << 1)
> > 	__u32	flags;
> > 	__u32	pasid;
> > 	struct {
> > 		__u32	min;
> > 		__u32	max;
> > 	} range;
> > };
> 
> Can't the ioctl return the pasid valid on alloc (like GET_DEVICE_FD)?

Yep, I think you mentioned before. At that time, I believed it would be
better to return the result via a __u32 buffer so that make full use of
the 32 bits. But looks like it doesn't make much difference. I'll follow
your suggestion.

> Would it be useful to support freeing a range of pasids?  If so then we
> could simply use range for both, ie. allocate a pasid from this range
> and return it, or free all pasids in this range?  vfio already needs to
> track pasids to free them on release, so presumably this is something
> we could support easily.

yes, I think it is a nice thing. then I can remove the @pasid field.
will do it.

> > ioctl #23: VFIO_IOMMU_NESTING_OP
> > struct vfio_iommu_type1_nesting_op {
> > 	__u32	argsz;
> > 	__u32	flags;
> > 	__u32	op;
> > 	__u8	data[];
> > };
> 
> data only has 4-byte alignment, I think we really want it at an 8-byte
> alignment.  This is why I embedded the "op" into the flag for
> DEVICE_FEATURE.  Thanks,

got it. I may also merge the op into flags (maybe the lower 16 bits for
op).

Thanks,
Yi Liu
> Alex
> 
> >
> > /* Nesting Ops */
> > #define VFIO_IOMMU_NESTING_OP_BIND_PGTBL        0
> > #define VFIO_IOMMU_NESTING_OP_UNBIND_PGTBL      1
> > #define VFIO_IOMMU_NESTING_OP_CACHE_INVLD       2
> >
> > Thanks,
> > Yi Liu
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
