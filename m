Return-Path: <SRS0=PWDw=5R=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7872C2D0F3
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 05:49:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE7CC2077D
	for <iommu@archiver.kernel.org>; Wed,  1 Apr 2020 05:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE7CC2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 669F88A1D0;
	Wed,  1 Apr 2020 05:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xT17rmkgrohg; Wed,  1 Apr 2020 05:49:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EBE608A1CE;
	Wed,  1 Apr 2020 05:49:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D118EC1AE8;
	Wed,  1 Apr 2020 05:49:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1D22C1AE2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:48:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id AB190887D2
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:48:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4liwss-_Fo5M for <iommu@lists.linux-foundation.org>;
 Wed,  1 Apr 2020 05:48:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id AD65988783
 for <iommu@lists.linux-foundation.org>; Wed,  1 Apr 2020 05:48:58 +0000 (UTC)
IronPort-SDR: yPPpvHlktpBV6lnbMB2bNd0/tjmnw84iAqvR7GySziZEDyqq0WL1rdp6gwncTNgXdgJfVP1eK9
 GmY058x53F3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Mar 2020 22:48:58 -0700
IronPort-SDR: 7F7PdIS2xCZmhzkXLJ3uAcW5TFuJwjdoFIa5fbsUlAHxTjs+DLBgtElBuNQEzzo3uSmyUEzJO4
 hqka6yWk4X3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; d="scan'208";a="238014662"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga007.jf.intel.com with ESMTP; 31 Mar 2020 22:48:57 -0700
Received: from fmsmsx121.amr.corp.intel.com (10.18.125.36) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 22:48:57 -0700
Received: from shsmsx105.ccr.corp.intel.com (10.239.4.158) by
 fmsmsx121.amr.corp.intel.com (10.18.125.36) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 31 Mar 2020 22:48:57 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX105.ccr.corp.intel.com ([169.254.11.213]) with mapi id 14.03.0439.000;
 Wed, 1 Apr 2020 13:48:53 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHWAEUbC4GB74LMekup8jIcF6WIFqhgVMYAgACL5QCAANaCgIAAmyhQgAD31QCAAIZ4AA==
Date: Wed, 1 Apr 2020 05:48:52 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A21C370@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF378@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A2184AE@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D801104@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A21B065@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D803B6A@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D803B6A@SHSMSX104.ccr.corp.intel.com>
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
> Sent: Wednesday, April 1, 2020 1:43 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Tuesday, March 31, 2020 9:22 PM
> >
> > > From: Tian, Kevin <kevin.tian@intel.com>
> > > Sent: Tuesday, March 31, 2020 1:41 PM
> > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > eric.auger@redhat.com
> > > Subject: RE: [PATCH v1 1/8] vfio: Add
> > VFIO_IOMMU_PASID_REQUEST(alloc/free)
> > >
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Monday, March 30, 2020 10:37 PM
> > > >
> > > > > From: Tian, Kevin <kevin.tian@intel.com>
> > > > > Sent: Monday, March 30, 2020 4:32 PM
> > > > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > > > Subject: RE: [PATCH v1 1/8] vfio: Add
> > > > VFIO_IOMMU_PASID_REQUEST(alloc/free)
> > > > >
> > > > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > > > Sent: Sunday, March 22, 2020 8:32 PM
> > > > > >
> > > > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > > > >
> > > > > > For a long time, devices have only one DMA address space from
> > > > > > platform IOMMU's point of view. This is true for both bare
> > > > > > metal and directed- access in virtualization environment.
> > > > > > Reason is the source ID of DMA in PCIe are BDF (bus/dev/fnc
> > > > > > ID), which results in only device granularity
[...]
> > >
> > > >
> > > > > > +
> > > > > > +		switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > > > > > +		case VFIO_IOMMU_PASID_ALLOC:
> > > > > > +		{
> > > > > > +			int ret = 0, result;
> > > > > > +
> > > > > > +			result =
> > vfio_iommu_type1_pasid_alloc(iommu,
> > > > > > +
> > 	req.alloc_pasid.min,
> > > > > > +
> > 	req.alloc_pasid.max);
> > > > > > +			if (result > 0) {
> > > > > > +				offset = offsetof(
> > > > > > +					struct
> > > > > > vfio_iommu_type1_pasid_request,
> > > > > > +					alloc_pasid.result);
> > > > > > +				ret = copy_to_user(
> > > > > > +					      (void __user *) (arg +
> > offset),
> > > > > > +					      &result, sizeof(result));
> > > > > > +			} else {
> > > > > > +				pr_debug("%s: PASID alloc failed\n",
> > > > > > __func__);
> > > > > > +				ret = -EFAULT;
> > > > >
> > > > > no, this branch is not for copy_to_user error. it is about pasid
> > > > > alloc failure. you should handle both.
> > > >
> > > > Emmm, I just want to fail the IOCTL in such case, so the @result
> > > > field is meaningless in the user side. How about using another
> > > > return value (e.g. ENOSPC) to indicate the IOCTL failure?
> > >
> > > If pasid_alloc fails, you return its result to userspace if
> > > copy_to_user fails, then return -EFAULT.
> > >
> > > however, above you return -EFAULT for pasid_alloc failure, and then
> > > the number of not-copied bytes for copy_to_user.
> >
> > not quite get. Let me re-paste the code. :-)
> >
> > +		case VFIO_IOMMU_PASID_ALLOC:
> > +		{
> > +			int ret = 0, result;
> > +
> > +			result = vfio_iommu_type1_pasid_alloc(iommu,
> > +							req.alloc_pasid.min,
> > +							req.alloc_pasid.max);
> > +			if (result > 0) {
> > +				offset = offsetof(
> > +					struct
> > vfio_iommu_type1_pasid_request,
> > +					alloc_pasid.result);
> > +				ret = copy_to_user(
> > +					      (void __user *) (arg + offset),
> > +					      &result, sizeof(result));
> > if copy_to_user failed, ret is the number of uncopied bytes and will
> > be returned to userspace to indicate failure. userspace will not use
> > the data in result field. perhaps, I should check the ret here and
> > return -EFAULT or another errno, instead of return the number of
> > un-copied bytes.
> 
> here should return -EFAULT.

got it. so if any failure, the return value of this ioctl is a -ERROR_VAL.

> 
> > +			} else {
> > +				pr_debug("%s: PASID alloc failed\n",
> > __func__);
> > +				ret = -EFAULT;
> > if vfio_iommu_type1_pasid_alloc() failed, no doubt, return -EFAULT to
> > userspace to indicate failure.
> 
> pasid_alloc has its own error types returned. why blindly replace it with -EFAULT?

right, should use its own error types.

Thanks,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
