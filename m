Return-Path: <SRS0=/IpK=5P=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF99CC43331
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2010206E6
	for <iommu@archiver.kernel.org>; Mon, 30 Mar 2020 09:27:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2010206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8462B8843B;
	Mon, 30 Mar 2020 09:27:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 14SW0ZCPsICI; Mon, 30 Mar 2020 09:27:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id A521C88146;
	Mon, 30 Mar 2020 09:27:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99220C1AE8;
	Mon, 30 Mar 2020 09:27:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52A81C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 09:27:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4969F22D22
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 09:27:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qRYXgJBLGwVP for <iommu@lists.linux-foundation.org>;
 Mon, 30 Mar 2020 09:27:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B5F722CC6
 for <iommu@lists.linux-foundation.org>; Mon, 30 Mar 2020 09:27:00 +0000 (UTC)
IronPort-SDR: mHnzoBP8i0Jc/zA1cYVUEcMLk5y9uhPT3k9g+d1jvrdwmFbOpM7Vz4/flyGE6CnMMWsN+ZwAny
 6O8SKV5/8i0Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Mar 2020 02:26:58 -0700
IronPort-SDR: 94phFjaHxIasgNLV5x9F/Y59NUW+TEzHZGsZZBXmxT5JANcvNFzRqoyYNuhAXXiFkCJJGqav4r
 teAmesN35kBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,323,1580803200"; d="scan'208";a="421871454"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 30 Mar 2020 02:26:57 -0700
Received: from fmsmsx113.amr.corp.intel.com (10.18.116.7) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 02:26:56 -0700
Received: from shsmsx153.ccr.corp.intel.com (10.239.6.53) by
 FMSMSX113.amr.corp.intel.com (10.18.116.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 30 Mar 2020 02:26:56 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.225]) by
 SHSMSX153.ccr.corp.intel.com ([169.254.12.89]) with mapi id 14.03.0439.000;
 Mon, 30 Mar 2020 17:26:52 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for
 quota tuning
Thread-Topic: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for
 quota tuning
Thread-Index: AQHWAEUbHl/tnnhWl0eaKvrwJMb1AqhgVzOAgACGb+D//4RdgIAAh3wg
Date: Mon, 30 Mar 2020 09:26:51 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A217D97@SHSMSX104.ccr.corp.intel.com>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-3-git-send-email-yi.l.liu@intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF3C5@SHSMSX104.ccr.corp.intel.com>
 <A2975661238FB949B60364EF0F2C25743A217C68@SHSMSX104.ccr.corp.intel.com>
 <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF46F@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D7FF46F@SHSMSX104.ccr.corp.intel.com>
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
> Sent: Monday, March 30, 2020 5:20 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1 parameter for quota
> tuning
> 
> > From: Liu, Yi L <yi.l.liu@intel.com>
> > Sent: Monday, March 30, 2020 4:53 PM
> >
> > > From: Tian, Kevin <kevin.tian@intel.com>
> > > Sent: Monday, March 30, 2020 4:41 PM
> > > To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> > > Subject: RE: [PATCH v1 2/8] vfio/type1: Add vfio_iommu_type1
> > > parameter
> > for quota
> > > tuning
> > >
> > > > From: Liu, Yi L <yi.l.liu@intel.com>
> > > > Sent: Sunday, March 22, 2020 8:32 PM
> > > >
> > > > From: Liu Yi L <yi.l.liu@intel.com>
> > > >
> > > > This patch adds a module option to make the PASID quota tunable by
> > > > administrator.
> > > >
> > > > TODO: needs to think more on how to  make the tuning to be per-process.
> > > >
> > > > Previous discussions:
> > > > https://patchwork.kernel.org/patch/11209429/
> > > >
> > > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > > Cc: Eric Auger <eric.auger@redhat.com>
> > > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > > ---
> > > >  drivers/vfio/vfio.c             | 8 +++++++-
> > > >  drivers/vfio/vfio_iommu_type1.c | 7 ++++++-
> > > >  include/linux/vfio.h            | 3 ++-
> > > >  3 files changed, 15 insertions(+), 3 deletions(-)
> > > >
> > > > diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c index
> > > > d13b483..020a792 100644
> > > > --- a/drivers/vfio/vfio.c
> > > > +++ b/drivers/vfio/vfio.c
> > > > @@ -2217,13 +2217,19 @@ struct vfio_mm
> > *vfio_mm_get_from_task(struct
> > > > task_struct *task)
> > > >  }
> > > >  EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > > >
> > > > -int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> > > > +int vfio_mm_pasid_alloc(struct vfio_mm *vmm, int quota, int min,
> > > > +int
> > max)
> > > >  {
> > > >  	ioasid_t pasid;
> > > >  	int ret = -ENOSPC;
> > > >
> > > >  	mutex_lock(&vmm->pasid_lock);
> > > >
> > > > +	/* update quota as it is tunable by admin */
> > > > +	if (vmm->pasid_quota != quota) {
> > > > +		vmm->pasid_quota = quota;
> > > > +		ioasid_adjust_set(vmm->ioasid_sid, quota);
> > > > +	}
> > > > +
> > >
> > > It's a bit weird to have quota adjusted in the alloc path, since the
> > > latter
> > might
> > > be initiated by non-privileged users. Why not doing the simple math
> > > in
> > vfio_
> > > create_mm to set the quota when the ioasid set is created? even in
> > > the
> > future
> > > you may allow per-process quota setting, that should come from
> > > separate privileged path instead of thru alloc..
> >
> > The reason is the kernel parameter modification has no event which can
> > be used to adjust the quota. So I chose to adjust it in pasid_alloc
> > path. If it's not good, how about adding one more IOCTL to let user-
> > space trigger a quota adjustment event? Then even non-privileged user
> > could trigger quota adjustment, the quota is actually controlled by
> > privileged user. How about your opinion?
> >
> 
> why do you need an event to adjust? As I said, you can set the quota when the set is
> created in vfio_create_mm...

oh, it's to support runtime adjustments. I guess it may be helpful to let
per-VM quota tunable even the VM is running. If just set the quota in
vfio_create_mm(), it is not able to adjust at runtime.

Regards,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
