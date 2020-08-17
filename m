Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA761C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 05:39:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 672A2206FA
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 05:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="ZXtRVW1l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 672A2206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 258702152C;
	Mon, 17 Aug 2020 05:39:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAuZXS2+bOXa; Mon, 17 Aug 2020 05:39:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 92DFF204F9;
	Mon, 17 Aug 2020 05:39:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78241C088E;
	Mon, 17 Aug 2020 05:39:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 59DCEC07FF
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:39:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 33BD7204B2
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:39:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NNYUiJ3wMJWB for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 05:39:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by silver.osuosl.org (Postfix) with ESMTPS id 0DF4620494
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:39:01 +0000 (UTC)
IronPort-SDR: VUF9A+ZBQZMhCoIiEC/HD2tm9xWnreqQI6zozrw7vjzinLLoTtw2QVujCAKj6gDPWPo0JOPzcN
 XzZE0mKdUl7Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="216161833"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="216161833"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2020 22:39:01 -0700
IronPort-SDR: qfiRvER/F4bb+I39rGvahTcS34Nq2Xuw/RnhGYLeZ2sFsHEc3isS3EZLt5DVq6sU0vy/kMurR7
 /C+aJe6qWDZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="370463670"
Received: from unknown (HELO fmsmsx606.amr.corp.intel.com) ([10.18.84.216])
 by orsmga001.jf.intel.com with ESMTP; 16 Aug 2020 22:39:00 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Aug 2020 22:39:00 -0700
Received: from fmsmsx125.amr.corp.intel.com (10.18.125.40) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 16 Aug 2020 22:39:00 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 FMSMSX125.amr.corp.intel.com (10.18.125.40) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Aug 2020 22:39:00 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Sun, 16 Aug 2020 22:39:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TOMKDnq13uFekBQkH/ULQnRBoZ2cd785JPOU5M0BX2vzwLTavWVszeemyq7QGE/s39ccfsm+v9oD8nzhX46Yz4GuTPTkNxKmUpwUwpIOY8yOlv70ZpRSn3KuLnVGiw7mge6/O6pdf4TzA1N+ceplkBaekFA3CK25RglTQiNjUBKvXA9464JCVpEgwhKnEs1NGOj020v7WmRfE+PASX4ZBYIM6N9OJ1y7nRVN/qGtghEACEwJuhtKEY+PHx/Rmx9KuWdwgYdtdReAqfnm3lU4/P9a0oJnTFpPjB4/LwlgTbnTbn6cn87uW8XDPRQMQOuLbNemxP1xZYaYh1Gvl2l5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJWFwhIB3w8jbWQHWlBqOjklBwORKfLlf0TsLp22n30=;
 b=J5Zqk0xxALsRAYnioRkGSGIfHDFpEEXMfA6haCzh9xGYjtsr51+S94I+w/xgUw9Y6MjKkPMkOIxSs79b//BP1r/0jasbZ3+3diE2lmD3YgTXbvke7o2FQmVClJ8BdI8RSK72meklzD9VDqwcB7KjpBw0zDltbR/KPvc7dttjmzUWfhfbOVu6Cy5tbFqxSnw+gWm8FJnaAFHhMO/cDF2Syxe/rNrodda1T1aO+yZgu7TQ1KU/x6RtKkwYfIMUfS6hF90HL+YIQ3MOkf5YjGIiWKidKSgpmFglytuy/SvYik5985ji0rxdHd4Yr2itWWtuHM2s42fT2+GhEqqOuiQQuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cJWFwhIB3w8jbWQHWlBqOjklBwORKfLlf0TsLp22n30=;
 b=ZXtRVW1lMvT/5MV2Xc0HaME32fyAkAn56XK5Gtd9bTyYE7zym3BD6d7GjtB0z6ZvEXg4j3PnSIV5aaQur33/4darMNwRWbdhG0uCXnDpBxs8t8jQzRMeBGQFdTmqZOlD92inMNhPxkXP/cXxpI2MaNsyfQqv5SKHSPl0Lb40azc=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1996.namprd11.prod.outlook.com (2603:10b6:3:13::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.16; Mon, 17 Aug 2020 05:38:58 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 05:38:58 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Topic: [PATCH v6 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Index: AQHWZKdJno5Pta00J0+9WfqaijTt46k5eXWAgAJtvmA=
Date: Mon, 17 Aug 2020 05:38:58 +0000
Message-ID: <DM5PR11MB14350F2817594E7895AD8A80C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-10-git-send-email-yi.l.liu@intel.com>
 <0db97d4a-7c74-9fac-0763-0ed56dcc5eaa@redhat.com>
In-Reply-To: <0db97d4a-7c74-9fac-0763-0ed56dcc5eaa@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.230.130]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b47ea57e-4287-4030-0b39-08d8426fd6bf
x-ms-traffictypediagnostic: DM5PR11MB1996:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1996372362A76840D6A460A7C35F0@DM5PR11MB1996.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BDuhQNSQJkG5oiX4ChaR1OJNuslcrNhQc4Qig9t6TwJdv/1ZVEBpMBMPFiham3w5nCoaxJPSr7SSRgXu+fOC2psQxr826aWCaNDIxn7dHadzYcwz0PNWEgVjGa+UYNC/ctROp0GIJGuatCf0l+zdWcC7/j79QlpxSAGgZA9V2r9c/eW4DErSKzI43AHClwGObKPhGmwsVGwxUDuPbv6RFlI50cyrlb+KwN+PIpUa5Fwvn3tluo601KM//iwQ3mIwvpk+YuJ724vgETGcBEYKxaKjI3XitTJ4wNMXOLFtliH1k26WRwshAPCQi/gOqFG7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(396003)(346002)(376002)(39860400002)(136003)(26005)(66446008)(64756008)(71200400001)(66556008)(66476007)(7416002)(8676002)(9686003)(2906002)(66946007)(55016002)(76116006)(86362001)(5660300002)(186003)(8936002)(316002)(33656002)(478600001)(6506007)(52536014)(7696005)(53546011)(83380400001)(54906003)(110136005)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: PevVbgu3khApubuGMqtPlRWzO0CiUXlCGh3HBeJDsoyx1iAQL5Z0dklLmnTtKlXq/0Ze78S2lrGHx12vxEpBVNzcE1VMpUR45TcRw2WAxLpplzh+zwB9IBFePnjot6ZB9UlY3g3IRQk17xVyA1t/mB3ColWpxLrPaCX8T+RbpwPCCGH8Wt9pCOaeDHfqNnvMipUUhqN6VqCGV8sjKaIgqXMl0esJfciDy1uCabYFAzgplokf4SacpZKfM3JsJgOwOs+984/2g3vBRXTNwHyQl85IZjDd9mzbAhprF1zPIY4sOVTcBCCGtfFb4zlDql6X25BXIrR2jsRAReUUJQzWwNRH2BlDMVGrMdYy7dtma7xc+87JL1lgLnrLxkFDhkqSR41k2jG+nrLsu/tvqzh6jfW9RqMRK3NCSEDJxf7prPRKd6AB0APITgdMlCDV0jfvzivMf3hkWYxo4jMildDJJF99/2AV4GfSnEb9rJOzs14s+4hJb5mIpBM9J+63tWAszQAkC53MfmtBcMwYGgtmkXT3sbUlmAIjAmfM88+YApSLIYZSGcDYttGU7w5fouJ2LtZwYbyou/Gse4QNrJGExhFu9EeWRtj+Pez/O849t0+gx7ICgtOdoBtEzfebgYTA3KuhLo26ctlzAxequ1yi6g==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b47ea57e-4287-4030-0b39-08d8426fd6bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 05:38:58.2423 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xZH/cbenLmHV9yW197wchgSJKA8JdwG7gTg483bfoyN40wIghrulkdzVFYnOMogN8dAsLfvBurBrbWB7Cj+xVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1996
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>,
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

Hi Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Sunday, August 16, 2020 12:30 AM
> 
> Hi Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > When an IOMMU domain with nesting attribute is used for guest SVA, a
> > system-wide PASID is allocated for binding with the device and the domain.
> > For security reason, we need to check the PASID passed from user-space.
> > e.g. page table bind/unbind and PASID related cache invalidation.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> >  drivers/iommu/intel/iommu.c | 10 ++++++++++
> >  drivers/iommu/intel/svm.c   |  7 +++++--
> >  2 files changed, 15 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> > index b2fe54e..88f4647 100644
> > --- a/drivers/iommu/intel/iommu.c
> > +++ b/drivers/iommu/intel/iommu.c
> > @@ -5436,6 +5436,7 @@ intel_iommu_sva_invalidate(struct iommu_domain
> *domain, struct device *dev,
> >  		int granu = 0;
> >  		u64 pasid = 0;
> >  		u64 addr = 0;
> > +		void *pdata;
> >
> >  		granu = to_vtd_granularity(cache_type, inv_info->granularity);
> >  		if (granu == -EINVAL) {
> > @@ -5456,6 +5457,15 @@ intel_iommu_sva_invalidate(struct iommu_domain
> *domain, struct device *dev,
> >  			 (inv_info->granu.addr_info.flags &
> IOMMU_INV_ADDR_FLAGS_PASID))
> >  			pasid = inv_info->granu.addr_info.pasid;
> >
> > +		pdata = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> > +		if (!pdata) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		} else if (IS_ERR(pdata)) {
> > +			ret = PTR_ERR(pdata);
> > +			goto out_unlock;
> > +		}
> > +
> >  		switch (BIT(cache_type)) {
> >  		case IOMMU_CACHE_INV_TYPE_IOTLB:
> >  			/* HW will ignore LSB bits based on address mask */
> > diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> > index c85b8d5..b9b29ad 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -323,7 +323,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
> struct device *dev,
> >  	dmar_domain = to_dmar_domain(domain);
> >
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
> > +	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
> A question about the locking strategy. We don't take the
> device_domain_lock here. Could you clarify whether it is safe?

I guess it is better to take the same lock as what iommu_domain_set_attr()
takes. thanks for catching it. :-)

> 
> >  	if (IS_ERR(svm)) {
> >  		ret = PTR_ERR(svm);
> >  		goto out;
> > @@ -440,6 +440,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> *domain,
> >  			    struct device *dev, u32 pasid)
> >  {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *dmar_domain;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm;
> >  	int ret = -EINVAL;
> > @@ -447,8 +448,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> *domain,
> >  	if (WARN_ON(!iommu))
> >  		return -EINVAL;
> >
> > +	dmar_domain = to_dmar_domain(domain);
> > +
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
> > +	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> same here.

same.

Regards,
Yi Liu

> >  	if (!svm) {
> >  		ret = -EINVAL;
> >  		goto out;
> >
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
