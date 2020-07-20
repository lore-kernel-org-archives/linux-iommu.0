Return-Path: <SRS0=yPOf=A7=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3200EC433E1
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:55:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBFE422B4D
	for <iommu@archiver.kernel.org>; Mon, 20 Jul 2020 12:55:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="A3ilxDU+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE422B4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A106E85B18;
	Mon, 20 Jul 2020 12:55:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XAIGA9gWskis; Mon, 20 Jul 2020 12:55:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E2A8185A74;
	Mon, 20 Jul 2020 12:55:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B8B6EC0894;
	Mon, 20 Jul 2020 12:55:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18CE6C016F
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:55:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0090F87E88
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:55:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SP4NcaFWCV2e for <iommu@lists.linux-foundation.org>;
 Mon, 20 Jul 2020 12:55:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D9A6C87E81
 for <iommu@lists.linux-foundation.org>; Mon, 20 Jul 2020 12:55:46 +0000 (UTC)
IronPort-SDR: a5vqlm9xd1s3vRK+VND+K1nD/4i2VGIR8ZmYBwDckpDbDrKcFmn0uHlrIE7VCbvu2sLJQ/UTWT
 uHOcEkLes3og==
X-IronPort-AV: E=McAfee;i="6000,8403,9687"; a="214579811"
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="214579811"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2020 05:55:46 -0700
IronPort-SDR: JTZscmiM3M2/kRoY6nFvzqRMVgx81rXAkbbJnHvnzUxTHp5ub2XpI//lZqUIVsXx/njP3t7bVw
 D4Mj8m6Go6Ww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,375,1589266800"; d="scan'208";a="283503680"
Received: from fmsmsx106.amr.corp.intel.com ([10.18.124.204])
 by orsmga003.jf.intel.com with ESMTP; 20 Jul 2020 05:55:45 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 FMSMSX106.amr.corp.intel.com (10.18.124.204) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 20 Jul 2020 05:55:45 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 20 Jul 2020 05:55:45 -0700
Received: from FMSEDG002.ED.cps.intel.com (10.1.192.134) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 20 Jul 2020 05:55:44 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (104.47.38.54) by
 edgegateway.intel.com (192.55.55.69) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Mon, 20 Jul 2020 05:55:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MCckEqySA+ujNi/qIkoYrxVEhqGfGHdETbR2DyGCshPS5UnFsbkM9Py4w+Q8cimGyK+29MFW43JAt9eMmyr1Ty+B8/oZOdNTHHfjsgJ5Ja5zOLaMuDSk6KoYYCQs+ChphXIG7Twmn/brE5q/tIbaOtRkrnu4K49N77KOGvb1RD4V7DsANZ+Baq60U2Yb+WYtmCktzQL/bHwdw76kLjKPr3FPNVFXUNirmfUzKNN1QCRqsnMVt5TUurVouRJYxsYpDUx2QASzQ9qdJNqpOPebFF7cZ3Yqd7qPRCAEqEPEOftxarPo2Y1ZTakGjzrlhHoGYZci6bQciPVnkc7+7QwJrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gchef5zTAnKNtG6eRQWbmEr3MSanqeVCFwDyHt+j1Ms=;
 b=BSoxKC+rO71wmSDUekAPIAcORXPW+cN1iNs9wY2CFHvWB657z57GzQEKHV3wCnw/TVw01JzpgRAlGRT9+2jx8ZN7H41YU8jwGwHXNrbT3plnlP7fNNsM2uVks/Qp8NB0tIHZ53CBBpHL1vXCecjTHsREuH61E3cWoSCelFYF9tHOLbIzz56u8ic5YGugD+9cShwyoK6Y8rt2XWdqWb4KYaSVra/6CuQN+x+BKhxvu6maC7OJn5cgbmIdGj14BfCUoFY82SeuVH75OmSJW5nCKbtqEOszNE5utAbHcCoRTdf1ooPQIcqzXhg/q7bLVHiw3+W5SE+8+WpWzFex5kMwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gchef5zTAnKNtG6eRQWbmEr3MSanqeVCFwDyHt+j1Ms=;
 b=A3ilxDU+mdsYldmWVf23NnL39IDT6d+1x0K9E/Q1Kf0DRcOJtDqjUmx2GmyuZb7m/oXgzyxD5v7yWHE8u73YBvHvX8M6hEU/u5bPZkSspBiBYn8K6mE48imnV54qD4UYAWU6UXNgP3ylvfGaAYY/cPaR3K1cYxTgCg4Ad3hAWLk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3994.namprd11.prod.outlook.com (2603:10b6:5:193::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.17; Mon, 20 Jul 2020 12:55:42 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3195.025; Mon, 20 Jul
 2020 12:55:42 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Topic: [PATCH v5 09/15] iommu/vt-d: Check ownership for PASIDs from
 user-space
Thread-Index: AQHWWD2mfecmeDXWOkCzHg/KKlvw3qkPHIEAgAEt7vCAACpBgIAAA2nQ
Date: Mon, 20 Jul 2020 12:55:42 +0000
Message-ID: <DM5PR11MB1435E4B45DA5D78151A28426C37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-10-git-send-email-yi.l.liu@intel.com>
 <b55a09f7-c0ce-f2ff-a725-87a8e042ab80@redhat.com>
 <DM5PR11MB14351CB472AEEAFB864A4DFEC37B0@DM5PR11MB1435.namprd11.prod.outlook.com>
 <e31c2b5e-b3c1-b42d-a280-83ed61f311c0@redhat.com>
In-Reply-To: <e31c2b5e-b3c1-b42d-a280-83ed61f311c0@redhat.com>
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
x-ms-office365-filtering-correlation-id: 3f2d3282-817a-466a-fc08-08d82cac3602
x-ms-traffictypediagnostic: DM6PR11MB3994:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB399450C9216843F5D4B3B379C37B0@DM6PR11MB3994.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DAYZhLD4KZbV0oSb8ANLdcovUVAyziQ7ZQ6SpplUta35cJK4Wn5nnpLQBJ99e43fQZAku6COTBcPkBIMeBt/4P2pmEy/wQeS/Pxt2rjJvPQp/oypoDkmY+qnu1vQocjNxeoZoXCGx+OIm7rCn1/HQ7lL5SoRGHIeJ/0iFMoG2tllngbK4NfQOzprwPT2jNQKCHglyR6waTOcNKlRPkxGQuFe6ZbteWEMxCNhk7FgKyvJr27E0Vdk4gmpqRZ3kPgdkQyMoXbZ6LZ/6twBNJtBbRLue6rae164CpDSfKx/TwlZSzmfXVpad56CM73UwKdb3eSDnPZiQobQRpelOvHPpg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(366004)(26005)(8936002)(478600001)(2906002)(55016002)(66946007)(5660300002)(6506007)(9686003)(66556008)(66446008)(52536014)(76116006)(64756008)(86362001)(66476007)(53546011)(110136005)(186003)(83380400001)(7696005)(316002)(7416002)(54906003)(71200400001)(8676002)(33656002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: I7hKczPQMlUuCzqPYuxqmkTXwSTSzLL/HXi5msN02YI2AB8iLohwDpz0fCRQBNEMtz8yYpuGfL6NTAnHkxNAnyAb9RLxeTnrUeef4WkjujC/cmfinW0Ts/MBNFEvMBpgGBH1ROPq7m0RUyhuDcpbsj2HuVAyPuZjjeEKQCSAFYGnjsEWsaI9XWy1A7SAPWOBA8VmsEXYgxmmndm/BPOXLxqh2YIJidTGRCGGIFGqFlu8Ri0osT1udV0uP1iGT7+/AFRYAJaaRjLuXfbG68cz9buKtl1M8jQi9o8zYfIKmCIx0Pngnq+mPI+e07kl59gLg+rMVlxbk8JbwfHQAtUq4oPwHTyPI9lwTbhTRUFeL9BVGWV7DZb92u7UgJUC5g0vxa4gOfaxa+rUBUT8NkTCfyFd9SQTg4ko7mmMiwFEUM7AnhMcB+jn7pkgs+SrfFGrjgN19bK3YNvULv54zhxGsop2BJ3Pp1nS2L0L8k/4/06mJhTrAL7BD/TzcAjrLib0
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f2d3282-817a-466a-fc08-08d82cac3602
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2020 12:55:42.4367 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: COTC1M+M7FiP+wgq2Xj2UloVcnqoJSt0kL9eWu1+K0RnyqOIzeqTAnCzvPpY+1jfvuXUBeLOWyql6Jkk2WLocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3994
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

Eric,

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Monday, July 20, 2020 8:38 PM
> 
> Yi,
> 
> On 7/20/20 12:18 PM, Liu, Yi L wrote:
> > Hi Eric,
> >
> >> From: Auger Eric <eric.auger@redhat.com>
> >> Sent: Monday, July 20, 2020 12:06 AM
> >>
> >> Hi Yi,
> >>
> >> On 7/12/20 1:21 PM, Liu Yi L wrote:
> >>> When an IOMMU domain with nesting attribute is used for guest SVA, a
> >>> system-wide PASID is allocated for binding with the device and the domain.
> >>> For security reason, we need to check the PASID passsed from user-space.
> >> passed
> >
> > got it.
> >
> >>> e.g. page table bind/unbind and PASID related cache invalidation.
> >>>
> >>> Cc: Kevin Tian <kevin.tian@intel.com>
> >>> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> Cc: Alex Williamson <alex.williamson@redhat.com>
> >>> Cc: Eric Auger <eric.auger@redhat.com>
> >>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> >>> Cc: Joerg Roedel <joro@8bytes.org>
> >>> Cc: Lu Baolu <baolu.lu@linux.intel.com>
> >>> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> >>> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> >>> ---
> >>>  drivers/iommu/intel/iommu.c | 10 ++++++++++
> >>>  drivers/iommu/intel/svm.c   |  7 +++++--
> >>>  2 files changed, 15 insertions(+), 2 deletions(-)
> >>>
> >>> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> >>> index 4d54198..a9504cb 100644
> >>> --- a/drivers/iommu/intel/iommu.c
> >>> +++ b/drivers/iommu/intel/iommu.c
> >>> @@ -5436,6 +5436,7 @@ intel_iommu_sva_invalidate(struct iommu_domain
> >> *domain, struct device *dev,
> >>>  		int granu = 0;
> >>>  		u64 pasid = 0;
> >>>  		u64 addr = 0;
> >>> +		void *pdata;
> >>>
> >>>  		granu = to_vtd_granularity(cache_type, inv_info->granularity);
> >>>  		if (granu == -EINVAL) {
> >>> @@ -5456,6 +5457,15 @@ intel_iommu_sva_invalidate(struct iommu_domain
> >> *domain, struct device *dev,
> >>>  			 (inv_info->granu.addr_info.flags &
> >> IOMMU_INV_ADDR_FLAGS_PASID))
> >>>  			pasid = inv_info->granu.addr_info.pasid;
> >>>
> >>> +		pdata = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> >>> +		if (!pdata) {
> >>> +			ret = -EINVAL;
> >>> +			goto out_unlock;
> >>> +		} else if (IS_ERR(pdata)) {
> >>> +			ret = PTR_ERR(pdata);
> >>> +			goto out_unlock;
> >>> +		}
> >>> +
> >>>  		switch (BIT(cache_type)) {
> >>>  		case IOMMU_CACHE_INV_TYPE_IOTLB:
> >>>  			/* HW will ignore LSB bits based on address mask */
> >>> diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
> >>> index d2c0e1a..212dee0 100644
> >>> --- a/drivers/iommu/intel/svm.c
> >>> +++ b/drivers/iommu/intel/svm.c
> >>> @@ -319,7 +319,7 @@ int intel_svm_bind_gpasid(struct iommu_domain
> *domain,
> >> struct device *dev,
> >>>  	dmar_domain = to_dmar_domain(domain);
> >>>
> >>>  	mutex_lock(&pasid_mutex);
> >>> -	svm = ioasid_find(INVALID_IOASID_SET, data->hpasid, NULL);
> I meant while using INVALID_IOASID_SET instead of the actual
> dmar_domain->ioasid_sid. But I think I've now recovered, the asset is
> simply not used ;-)

oh, I think should be using dmar_domain->ioasid_sid from the beginning.
does it look good so far? :-)

Regards,
Yi Liu

> >> I do not get what the call was supposed to do before that patch?
> >
> > you mean patch 10/15 by "that patch", right? the ownership check should
> > be done as to prevent illegal bind request from userspace. before patch
> > 10/15, it should be added.
> >
> >>> +	svm = ioasid_find(dmar_domain->ioasid_sid, data->hpasid, NULL);
> >>>  	if (IS_ERR(svm)) {
> >>>  		ret = PTR_ERR(svm);
> >>>  		goto out;
> >>> @@ -436,6 +436,7 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> >> *domain,
> >>>  			    struct device *dev, ioasid_t pasid)
> >>>  {
> >>>  	struct intel_iommu *iommu = intel_svm_device_to_iommu(dev);
> >>> +	struct dmar_domain *dmar_domain;
> >>>  	struct intel_svm_dev *sdev;
> >>>  	struct intel_svm *svm;
> >>>  	int ret = -EINVAL;
> >>> @@ -443,8 +444,10 @@ int intel_svm_unbind_gpasid(struct iommu_domain
> >> *domain,
> >>>  	if (WARN_ON(!iommu))
> >>>  		return -EINVAL;
> >>>
> >>> +	dmar_domain = to_dmar_domain(domain);
> >>> +
> >>>  	mutex_lock(&pasid_mutex);
> >>> -	svm = ioasid_find(INVALID_IOASID_SET, pasid, NULL);
> >>> +	svm = ioasid_find(dmar_domain->ioasid_sid, pasid, NULL);
> >> just to make sure, about the locking, can't domain->ioasid_sid change
> >> under the hood?
> >
> > I guess not. intel_svm_unbind_gpasid() and iommu_domain_set_attr()
> > is called by vfio today, and within vfio, there is vfio_iommu->lock.
> OK
> 
> Thanks
> 
> Eric
> >
> > Regards,
> > Yi Liu
> >
> >>
> >> Thanks
> >>
> >> Eric
> >>>  	if (!svm) {
> >>>  		ret = -EINVAL;
> >>>  		goto out;
> >>>
> >

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
