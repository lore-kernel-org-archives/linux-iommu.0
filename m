Return-Path: <SRS0=CWSE=5Y=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E6B4C2BB1D
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 00:52:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C3D20753
	for <iommu@archiver.kernel.org>; Wed,  8 Apr 2020 00:52:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C3D20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 18E57204A4;
	Wed,  8 Apr 2020 00:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nsCPE53EU8p6; Wed,  8 Apr 2020 00:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB7BE2035C;
	Wed,  8 Apr 2020 00:52:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BE1EBC1AE2;
	Wed,  8 Apr 2020 00:52:53 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7469FC0177
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 00:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5E3D086807
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 00:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id X0oMvLeZT7GS for <iommu@lists.linux-foundation.org>;
 Wed,  8 Apr 2020 00:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A0D75867A5
 for <iommu@lists.linux-foundation.org>; Wed,  8 Apr 2020 00:52:51 +0000 (UTC)
IronPort-SDR: +HVrxBU2WTjhTNmtHd62+0CTGw/13SV/B+V441InHBtRWRdro4SolHCj29Aq2+q9tqCN75YnjI
 JjLP8FxUc+qw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Apr 2020 17:52:50 -0700
IronPort-SDR: G67qDOZKuI/83JH0ScQGkQc6hUuOr7cuVFOpZqC7524k9bmWiG6T5E7YXwnpgnIxrhfspIM2Fz
 rBHzVQ8kzxrg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,357,1580803200"; d="scan'208";a="297096372"
Received: from fmsmsx105.amr.corp.intel.com ([10.18.124.203])
 by FMSMGA003.fm.intel.com with ESMTP; 07 Apr 2020 17:52:50 -0700
Received: from fmsmsx154.amr.corp.intel.com (10.18.116.70) by
 FMSMSX105.amr.corp.intel.com (10.18.124.203) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 17:52:49 -0700
Received: from shsmsx106.ccr.corp.intel.com (10.239.4.159) by
 FMSMSX154.amr.corp.intel.com (10.18.116.70) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 7 Apr 2020 17:52:49 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX106.ccr.corp.intel.com ([169.254.10.89]) with mapi id 14.03.0439.000;
 Wed, 8 Apr 2020 08:52:46 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHWAEUbC4GB74LMekup8jIcF6WIFqhlp7CAgAGFhmCAAAzHgIAFwXRA
Date: Wed, 8 Apr 2020 00:52:46 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A225A3C@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <20200402115017.0a0f55e2@w520.home>
 <A2975661238FB949B60364EF0F2C25743A220B62@SHSMSX104.ccr.corp.intel.com>
 <20200403115011.4aba8ff3@w520.home>
In-Reply-To: <20200403115011.4aba8ff3@w520.home>
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
> Sent: Saturday, April 4, 2020 1:50 AM
> Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
> 
> On Fri, 3 Apr 2020 13:12:50 +0000
> "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> 
> > Hi Alex,
> >
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Friday, April 3, 2020 1:50 AM
> > > Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
> > >
> > > On Sun, 22 Mar 2020 05:31:58 -0700
> > > "Liu, Yi L" <yi.l.liu@intel.com> wrote:
> > >
> > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > >
[...]
> > > >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> > > >  				   unsigned int cmd, unsigned long arg)
> > > >  {
> > > > @@ -2276,6 +2333,53 @@ static long vfio_iommu_type1_ioctl(void
> > > *iommu_data,
> > > >
> > > >  		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> > > >  			-EFAULT : 0;
> > > > +
> > > > +	} else if (cmd == VFIO_IOMMU_PASID_REQUEST) {
> > > > +		struct vfio_iommu_type1_pasid_request req;
> > > > +		unsigned long offset;
> > > > +
> > > > +		minsz = offsetofend(struct vfio_iommu_type1_pasid_request,
> > > > +				    flags);
> > > > +
> > > > +		if (copy_from_user(&req, (void __user *)arg, minsz))
> > > > +			return -EFAULT;
> > > > +
> > > > +		if (req.argsz < minsz ||
> > > > +		    !vfio_iommu_type1_pasid_req_valid(req.flags))
> > > > +			return -EINVAL;
> > > > +
> > > > +		if (copy_from_user((void *)&req + minsz,
> > > > +				   (void __user *)arg + minsz,
> > > > +				   sizeof(req) - minsz))
> > > > +			return -EFAULT;
> > >
> > > Huh?  Why do we have argsz if we're going to assume this is here?
> >
> > do you mean replacing sizeof(req) with argsz? if yes, I can do that.
> 
> No, I mean the user tells us how much data they've provided via argsz.
> We create minsz the the end of flags and verify argsz includes flags.
> Then we proceed to ignore argsz to see if the user has provided the
> remainder of the structure.

I think I should avoid using sizeof(req) as it may be variable
new flag is added. I think better to make a data[] field in struct
vfio_iommu_type1_pasid_request and copy data[] per flag. I'll
make this change in new version.

> > > > +
> > > > +		switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > > > +		case VFIO_IOMMU_PASID_ALLOC:
> > > > +		{
> > > > +			int ret = 0, result;
> > > > +
> > > > +			result = vfio_iommu_type1_pasid_alloc(iommu,
> > > > +							req.alloc_pasid.min,
> > > > +							req.alloc_pasid.max);
> > > > +			if (result > 0) {
> > > > +				offset = offsetof(
> > > > +					struct vfio_iommu_type1_pasid_request,
> > > > +					alloc_pasid.result);
> > > > +				ret = copy_to_user(
> > > > +					      (void __user *) (arg + offset),
> > > > +					      &result, sizeof(result));
> > >
> > > Again assuming argsz supports this.
> >
> > same as above.
> >
> > >
> > > > +			} else {
> > > > +				pr_debug("%s: PASID alloc failed\n", __func__);
> > >
> > > rate limit?
> >
> > not quite get. could you give more hints?
> 
> A user can spam the host logs simply by allocating their quota of
> PASIDs and then trying to allocate more, or by specifying min/max such
> that they cannot allocate the requested PASID.  If this logging is
> necessary for debugging, it should be ratelimited to avoid a DoS on the
> host.

got it. thanks for the coaching. will use pr_debug_ratelimited().

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
