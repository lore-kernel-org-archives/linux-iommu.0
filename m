Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9ECC433E4
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:18:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70B4E2068F
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 10:18:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="WZgCAFrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70B4E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 34D552154A;
	Mon, 20 Jul 2020 10:18:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id b4cw+pcRHNFy; Mon, 20 Jul 2020 10:18:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id E64B72153E;
	Mon, 20 Jul 2020 10:18:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD858C0894;
	Mon, 20 Jul 2020 10:18:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E865DC016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:18:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D4DF78657C
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gpkkPe2xpp2x for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 10:18:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D313A86233
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 10:18:10 +0000 (UTC)
IronPort-SDR: 9O9SdU1mdUBoW5FEoIDphq/9Ku/jGr6s/AEQXMblSxytg2xiHyS6jgUQNSjCjdRqKCL2Ht2i+s
 1o39IVM7hrkg==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="211427380"
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="211427380"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 03:18:10 -0700
IronPort-SDR: cee4CPk2U0awZsOchZna2M9bkVUe+lg0V1FJLVASw0jsS3YmYHl5bJEihrjZTkAXfMWaZHM2zI
 etV+aogQENPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,374,1589266800"; d="scan'208";a="326023439"
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
 by FMSMGA003.fm.intel.com with ESMTP; 20 Jul 2020 03:18:09 -0700
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 03:18:09 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX162.amr.corp.intel.com (10.22.240.85) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 03:18:09 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.107)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 03:18:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncgBl3G3K3c4bqIyvnJqVXFHS8wMZkEI62tGfbrMT9uSQJeaJ2QeqhZvXiMIeN1LbvL2XrmVRFuaMiFwRbMYoBpvH6JG3oERxW6v5H4AOewFHM3y3EQGM4R43WtHmvGkSA5hbH84lnFv/6tbsKzfwcw9F3uoEM0yWOaeq/VVUycCWBwx2HAoGLZgBNKKcAL7RoS3DJ6GHRq4IV7lpFxImL0WpYXJtq3sKNSqobnv6XYHq2Naj7BMLWzQBbYg1oQZ63f3R2Ht0joD6q7B9hdpDAoIrSTz0gxYpsPrvPsf3kgt56dgwhEAG68BgpbM4zSr+lhHBbtbvKLbvIz1tV6U9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYW6Emf3irXKctjOfgjMxEQvLPfH1QXxqTfq0MxaGvw=;
 b=BqPa74Kq88NnrOl5fQ59HJ4g4vwVao4SL0RIjmkO9M1y0wyLEUkdpW3FShDXV7yRdHAG/zlLX1/U0d9MhryxsNRaSCkOA78EQHBTMfG1eVfo3ZhkKX7Nvn66kmBSnkLEFFCEEywalRz28IDCpZuGWyyUzkpgtTvIsNuboO8gZmxDxnYS3C/I+6PiVHl9AJ0i5K+8cJmLasPChCdA6hcO40QV9hNF7xXNu7nm5jL20BDbSKyNHfU6iGi2DB3+ax/nZfwF8/R+Z7aPxXY/1pPj2008/xojuuOkf1IyBgcWcQFWaFhDhTdXtMwvc946k+I7eSySLw7Oaop1/B3yrFMKiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYW6Emf3irXKctjOfgjMxEQvLPfH1QXxqTfq0MxaGvw=;
 b=WZgCAFrSFh2M7ZSUxSF5xzYXVbsxiz5ECpKNk4g4zrBhl+o+CiUn+C7A0ErX85hIgpO19TcGwXHDtJmOjWh/IuHA1VUkBocW6VI3kfRW3RlpGEC2C8hGaeF8MLP8IHcoUsMOgg24uD6LuoLhWzE9+ErhX4SMaw4GhRH9dXVy2XY=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1434.namprd11.prod.outlook.com (2603:10b6:4:9::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 10:18:08 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 10:18:07 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Topic: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Index: AQHWWD2mfecmeDXWOkCzHg/KKlvw3qkPHIEAgAEt7vA=
Date: Mon, 20 Jul 2020 10:18:07 +0000
Message-ID: <DM5PR11MB14351CB472AEEAFB864A4DFEC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
 <b55a09f7-c0ce-f2ff-a725-87a8e042ab80@redhat.com>
In-Reply-To: <b55a09f7-c0ce-f2ff-a725-87a8e042ab80@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.102.204.45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b0c2b743-8516-4355-470f-08d82c9632ae
x-ms-traffictypediagnostic: DM5PR11MB1434:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB143428779005CC22A63FBBEEC37B0@DM5PR11MB1434.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 14cK+qlcm8CBeqZTvSWMu0ZtuYxpUW7SBrPUmaYALIC1mHFJgWFhJM68Tk7BOdWcSJAFrir7EY3V1IagsGgxwQCq6zVeAM3NGnSusQcjn+2RRakM9CK7gy1F5rqCB6GZoXErNE4v+rA/+Wvbce7Br/yAKhkE2OyIbt+c7GuX5rs10TrD+9cClRCOvzqUPEQJr8a/zQQQbHuFJ3ygvwC2qciiW0qd/Y0Ka+i6cfZNzJaZtjKzGUehu8aaNCavoomAr/0i4818CXjSJ+QCrAO/7KtS7ov2j3RrAGpI+iiIroASQYQUYS0MUaQby/mcnpxxwaHGqldwrexdDlYl9bBVHQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(366004)(346002)(396003)(39860400002)(376002)(71200400001)(316002)(8936002)(7696005)(186003)(6506007)(52536014)(2906002)(86362001)(53546011)(26005)(110136005)(54906003)(478600001)(8676002)(76116006)(83380400001)(64756008)(66946007)(66476007)(66556008)(66446008)(55016002)(5660300002)(9686003)(33656002)(4326008)(7416002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: L2K7jViKne+NhzUItZE9o9Fp7SHTDJI9XNysm2vRWbnK+72G4PN22W3VarmdV+/IK5PwyeWQpQSV6E7lFoMEWW22lZlgtuYTMD+CBAvzaSdna0Uq9j3X/Ae7QefEgai4uzTSey9/qeHWNhVP508vOmWhUSOOxtxJlVBXbXfV/I1RS42ldFtHKqWf2KejN25H+gvJUyyk8W/8jCerPHfYDXpOqiLXqCv8RNlaKFEAEPfMsBrI+WVK/iCn97JcMUP9eaBdx7OjjxKOv6T+Olyua0OUvims/3cnCpQaujuNOChT31BXfYV8+RMMo6KJoEa1vCL2nm/N+FT4peSQBlW99wDUjHZDx0iBRlq1gLytS8koEBK9O/FP9Guxn+vdzJ9A47hBJ2C0yqeBOl8o2aaHrbEOMkN0iqX2A9detZydqrdhnHIDOoWrdzthptI00a0MUnSh+Ys6Pjbp/l+gRhcsVQJJDUcPVFRnKFCoSN6OZpZAPf6kV7JajyfBL8++6rFm
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0c2b743-8516-4355-470f-08d82c9632ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 10:18:07.8604 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bg3DIFXdDUOCQj1T2bLwH8MCDcEyM4QsC/+z0xXkudjGVeLfNNo6topO2H8oWOQZTxUyQ5OKys8MKRdkfY5XMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1434
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
> Sent: Monday, July 20, 2020 12:06 AM
> 
> Hi Yi,
> 
> On 7/12/20 1:21 PM, Liu Yi L wrote:
> > When an IOMMU domain with nesting attribute is used for guest SVA, a
> > system-wide PASID is allocated for binding with the device and the domain.
> > For security reason, we need to check the PASID passsed from user-space.
> passed

got it.

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
> > index 4d54198..a9504cb 100644
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
> > index d2c0e1a..212dee0 100644
> > --- a/drivers/iommu/intel/svm.c
> > +++ b/drivers/iommu/intel/svm.c
> > @@ -319,7 +319,7 @@ int intel_svm_bind_gpasid(struct iommu_domain *domain,
> struct device *dev,
> >  	dmar_domain = to_dmar_domain(domain);
> >
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
> I do not get what the call was supposed to do before that patch?

you mean patch 10/15 by "that patch", right? the ownership check should
be done as to prevent illegal bind request from userspace. before patch
10/15, it should be added.

> > +	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
> >  	if (IS_ERR(svm)) {
> >  		ret = PTR_ERR(svm);
> >  		goto out;
> > @@ -436,6 +436,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> *domain,
> >  			    struct device *dev, ioasid_t pasid)
> >  {
> >  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> > +	struct dmar_domain *dmar_domain;
> >  	struct intel_svm_dev *sdev;
> >  	struct intel_svm *svm;
> >  	int ret = -EINVAL;
> > @@ -443,8 +444,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> *domain,
> >  	if (WARN_ON(!iommu))
> >  		return -EINVAL;
> >
> > +	dmar_domain = to_dmar_domain(domain);
> > +
> >  	mutex_lock(&pasid_mutex);
> > -	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
> > +	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> just to make sure, about the locking, can't domain->ioasid_sid change
> under the hood?

I guess not. intel_svm_unbind_gpasid() and iommu_domain_set_attr()
is called by vfio today, and within vfio, there is vfio_iommu->lock.

Regards,
Yi Liu

> 
> Thanks
> 
> Eric
> >  	if (!svm) {
> >  		ret = -EINVAL;
> >  		goto out;
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
