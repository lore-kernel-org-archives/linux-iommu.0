Return-Path: <SRS0=3N47=YS=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E76F5CA9EBD
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:16:48 +0000 (UTC)
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org [140.211.169.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC22E2054F
	for <iommu@archiver.kernel.org>; Fri, 25 Oct 2019 11:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC22E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from mail.linux-foundation.org (localhost [127.0.0.1])
	by mail.linuxfoundation.org (Postfix) with ESMTP id 76FB313A6;
	Fri, 25 Oct 2019 11:16:48 +0000 (UTC)
Received: from smtp1.linuxfoundation.org (smtp1.linux-foundation.org
	[172.17.192.35])
	by mail.linuxfoundation.org (Postfix) with ESMTPS id 7330413A5
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by smtp1.linuxfoundation.org (Postfix) with ESMTPS id E798487B
	for <iommu@lists.linux-foundation.org>;
	Fri, 25 Oct 2019 11:16:46 +0000 (UTC)
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
	by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	25 Oct 2019 04:16:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,228,1569308400"; d="scan'208";a="210693430"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
	by orsmga002.jf.intel.com with ESMTP; 25 Oct 2019 04:16:45 -0700
Received: from fmsmsx112.amr.corp.intel.com (10.18.116.6) by
	FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:16:45 -0700
Received: from shsmsx102.ccr.corp.intel.com (10.239.4.154) by
	FMSMSX112.amr.corp.intel.com (10.18.116.6) with Microsoft SMTP Server
	(TLS) id 14.3.439.0; Fri, 25 Oct 2019 04:16:44 -0700
Received: from shsmsx104.ccr.corp.intel.com ([169.254.5.166]) by
	shsmsx102.ccr.corp.intel.com ([169.254.2.176]) with mapi id
	14.03.0439.000; Fri, 25 Oct 2019 19:16:43 +0800
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Tian, Kevin" <kevin.tian@intel.com>, "alex.williamson@redhat.com"
	<alex.williamson@redhat.com>,
	"eric.auger@redhat.com" <eric.auger@redhat.com>
Subject: RE: [RFC v2 2/3] vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Topic: [RFC v2 2/3] vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
Thread-Index: AQHVimn7Rf6XEKLwVUSEQeOMJH4V9adqnLmAgACUdcA=
Date: Fri, 25 Oct 2019 11:16:42 +0000
Message-ID: <A2975661238FB949B60364EF0F2C25743A0D7BD8@SHSMSX104.ccr.corp.intel.com>
References: <1571919983-3231-1-git-send-email-yi.l.liu@intel.com>
	<1571919983-3231-3-git-send-email-yi.l.liu@intel.com>
	<AADFC41AFE54684AB9EE6CBC0274A5D19D5D05D5@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <AADFC41AFE54684AB9EE6CBC0274A5D19D5D05D5@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-product: dlpe-windows
dlp-version: 11.2.0.6
dlp-reaction: no-action
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiN2U1MGIzZmQtNTFmNy00YWY0LThlZGQtZjcxNzFhYWRkMzNjIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiVHFmdkM4Q1ZsaWRGbG1kQWlTd1c3eTU1ZzRcLzhCcFZJZjBhMVg4c09DWFV2eWtcL3VTNjJWbGtRQ2xyRTNlb1dFIn0=
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Cc: "Raj, Ashok" <ashok.raj@intel.com>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"jean-philippe.brucker@arm.com" <jean-philippe.brucker@arm.com>,
	"Tian, Jun J" <jun.j.tian@intel.com>,
	"iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
	"Sun, Yi Y" <yi.y.sun@intel.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.12
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
Sender: iommu-bounces@lists.linux-foundation.org
Errors-To: iommu-bounces@lists.linux-foundation.org

Hi Kevin,

> From: Tian, Kevin
> Sent: Friday, October 25, 2019 6:06 PM
> To: Liu, Yi L <yi.l.liu@intel.com>; alex.williamson@redhat.com;
> Subject: RE: [RFC v2 2/3] vfio/type1: VFIO_IOMMU_PASID_REQUEST(alloc/free)
> 
> > From: Liu Yi L
> > Sent: Thursday, October 24, 2019 8:26 PM
> >
> > This patch adds VFIO_IOMMU_PASID_REQUEST ioctl which aims to passdown
> > PASID allocation/free request from the virtual iommu. This is required
> > to get PASID managed in system-wide.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 114
> > ++++++++++++++++++++++++++++++++++++++++
> >  include/uapi/linux/vfio.h       |  25 +++++++++
> >  2 files changed, 139 insertions(+)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index cd8d3a5..3d73a7d 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2248,6 +2248,83 @@ static int vfio_cache_inv_fn(struct device
> > *dev, void *data)
> >  	return iommu_cache_invalidate(dc->domain, dev, &ustruct->info);  }
> >
> > +static int vfio_iommu_type1_pasid_alloc(struct vfio_iommu *iommu,
> > +					 int min_pasid,
> > +					 int max_pasid)
> > +{
> > +	int ret;
> > +	ioasid_t pasid;
> > +	struct mm_struct *mm = NULL;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +	mm = get_task_mm(current);
> > +	/* Track ioasid allocation owner by mm */
> below is purely allocation. Where does 'track' come to play?

ioasid_set is kind of owner track. As allocation is separate with
bind, here set the "owner" could be used to do sanity check when
a pasid bind comes.

> > +	pasid = ioasid_alloc((struct ioasid_set *)mm, min_pasid,
> > +				max_pasid, NULL);
> > +	if (pasid == INVALID_IOASID) {
> > +		ret = -ENOSPC;
> > +		goto out_unlock;
> > +	}
> > +	ret = pasid;
> > +out_unlock:
> > +	mutex_unlock(&iommu->lock);
> > +	if (mm)
> > +		mmput(mm);
> > +	return ret;
> > +}
> > +
> > +static int vfio_iommu_type1_pasid_free(struct vfio_iommu *iommu,
> > +				       unsigned int pasid)
> > +{
> > +	struct mm_struct *mm = NULL;
> > +	void *pdata;
> > +	int ret = 0;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!IS_IOMMU_CAP_DOMAIN_IN_CONTAINER(iommu)) {
> > +		ret = -EINVAL;
> > +		goto out_unlock;
> > +	}
> > +
> > +	/**
> > +	 * REVISIT:
> > +	 * There are two cases free could fail:
> > +	 * 1. free pasid by non-owner, we use ioasid_set to track mm, if
> > +	 * the set does not match, caller is not permitted to free.
> > +	 * 2. free before unbind all devices, we can check if ioasid private
> > +	 * data, if data != NULL, then fail to free.
> > +	 */
> 
> Does REVISIT mean that above comment is the right way but the code doesn't follow
> yet, or the comment itself should be revisited?

Sorry, it's a mistake... should be removed. It's added in the development phase
for remind. Will remove it.

> 
> should we have some notification mechanism, so the guy who holds the reference to
> the pasid can be notified to release its usage?

Do you mean the ioasid itself to provide such a notification mechanism?

Currently, we prevent pasid free before all user (iommu driver, guest) released
their usage. This is achieved by checking the private data, in which there is
a user_cnt of a pasid. e.g. struct intel_svm. A fresh guest pasid bind will allocate
the private data. A second guest pasid bind will increase the user_cnt. guest pasid
unbind decreases the user_cnt. The private data will be freed by the last guest
pasid unbind. Do you think it is sufficient? or we may want to have a notification
mechanism to allow such pasid free and keep the user updated?

Thanks,
Yi Liu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
