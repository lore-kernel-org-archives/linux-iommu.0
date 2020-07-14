Return-Path: <SRS0=v902=AZ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF6E3C433E3
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 10:12:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77FFD21897
	for <iommu@archiver.kernel.org>; Tue, 14 Jul 2020 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="xloR6YC+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77FFD21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 64A3288E52;
	Tue, 14 Jul 2020 10:12:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xNSjN04CowwS; Tue, 14 Jul 2020 10:12:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A7A9488E50;
	Tue, 14 Jul 2020 10:12:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9193AC0888;
	Tue, 14 Jul 2020 10:12:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8B43C0733
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AB3D38A344
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:12:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WyU5vpOAIR9A for <iommu@lists.linux-foundation.org>;
 Tue, 14 Jul 2020 10:12:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76E398A340
 for <iommu@lists.linux-foundation.org>; Tue, 14 Jul 2020 10:12:53 +0000 (UTC)
IronPort-SDR: 0DhWPr7WwDL96kMAu1aALD47mJB6H+fAal9Um/Jf02fOhqsSpH5ittBX1ojKVS7r/NLZhohgo9
 KKC9ttPxHUbA==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="136317588"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="136317588"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2020 03:12:52 -0700
IronPort-SDR: AX08XsjGxE2Z7stKMtgs3whgCDfVNWV+h68M4joWz+7DPCAR9/zPy445jWA2W5ZkFX9Z49jO5N
 Y7SFkLbkLcIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; d="scan'208";a="324502807"
Received: from orsmsx110.amr.corp.intel.com ([10.22.240.8])
 by FMSMGA003.fm.intel.com with ESMTP; 14 Jul 2020 03:12:52 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX110.amr.corp.intel.com (10.22.240.8) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 03:12:52 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.176)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 14 Jul 2020 03:12:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E3wuaWb8Zm6k2nKfJf9Qr0Amn+f+zXGPP9HixOG5BDnrHize6g3+7IWIJlr7WMS2Sf6ytWMkHoFhxK6tAoDwxp/XMQ6fCBQCThvUmoSZ6XVLrcSqLUrzRMwQOibDrV9fuApfvQifjFBc4IohKKox7ilgsrdp5CqookpILGlzngROKiRUsRhY8qD204Dp3vaLKXh7dydzbkazKl3FTcxdCWnXkF9Qm0MHkmoqyQgAMTVCmLGvzivZouNzC3rwAd8BOD6WZc8jmZ5ItHzap9v/GOk+Mm3fcPn1Ai1+QtWHyijePYsA21fC54tsj3UjbJBqdG/mGCx1Ot7dT0hRaxUG3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdpXGoK+FFwCBETKvGnURfFxSXfOgV3MDhKEhxgETnQ=;
 b=e+3JelzhsWCDtFSgeyJMrKKEV9xnfG6GDwkQTrMsg0y9J2t7ANCRTTJr4Fa8HxAGjkyfK756sTk2GF2cZd6P/FaFD+sIWXcqT84luFTsnPLSB7jP3r7GQCqFtkFb/bbAPbPw7QWiB4LVBObBEvuOHfLl21Ts7Hup54dc2NWgtDKiUAaG4uS9SREBfu/KlD91YX4lyi91zluzsbe40aX6J1ty95yCmKfJildU2yPgTUOFjY4VSAYr7qimuG4R02Zka6CL7eo5XzIi9YpXtgmCP8SVGxxVVGXamrEuxasML46EguJUAZRchsz/4dbIV52P0Y9tFsDAERXo5o/ry+p/Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdpXGoK+FFwCBETKvGnURfFxSXfOgV3MDhKEhxgETnQ=;
 b=xloR6YC+GGockon40kMndkrh3izdFAEbuU5Q4DEy4VpXjC5Pc+pUx5KiwmulqQA2J4HwVyekjLWggLhAd+rImg1zngCGu2FNxIRPtb9Z4hCLP3Oul0M9KTE791ER3Avhs92SWDHxYzXmbPDNaRlDrrf91Hc6QbpVm+IOA2Q75wA=
Received: from CY4PR11MB1432.namprd11.prod.outlook.com (2603:10b6:910:5::22)
 by CY4PR11MB1702.namprd11.prod.outlook.com (2603:10b6:903:2e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Tue, 14 Jul
 2020 10:12:49 +0000
Received: from CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a]) by CY4PR11MB1432.namprd11.prod.outlook.com
 ([fe80::b46e:9dcb:b46b:884a%4]) with mapi id 15.20.3174.026; Tue, 14 Jul 2020
 10:12:49 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Will Deacon <will@kernel.org>
Subject: RE: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Thread-Topic: [PATCH v5 03/15] iommu/smmu: Report empty domain nesting info
Thread-Index: AQHWWD2lVc+q/avNRU2WMQZyTvsTFakFfrYAgAFdguA=
Date: Tue, 14 Jul 2020 10:12:49 +0000
Message-ID: <CY4PR11MB1432226D0A52D099249E95A0C3610@CY4PR11MB1432.namprd11.prod.outlook.com>
References: <1594552870-55687-1-git-send-email-yi.l.liu@intel.com>
 <1594552870-55687-4-git-send-email-yi.l.liu@intel.com>
 <20200713131454.GA2739@willie-the-truck>
In-Reply-To: <20200713131454.GA2739@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.220]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: eb8a1c13-c6f7-453e-9d53-08d827de7699
x-ms-traffictypediagnostic: CY4PR11MB1702:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB17020A1F401752EEA24CAC0EC3610@CY4PR11MB1702.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: umtRxVfMVBzbhzjE34Rju7JgPpc+tA2fo2GCNWL1SdSgEAKNZPo+hibN1ziO3IBVUkJtFsAvqksRWHVt/e1VNy5+56oRORFhlCiTIytend6R2mXBAiIWT2Zh82SeeVwjxfDFr0GBcp0wsie+3ZJUT6PKToylWM4IwJSPQ04mKcSeMWcOdtc7kmga44DCb+Ku8A8JsayQcj3/EGWygdKRRN8midW800ldntV9uE94OZtKdkQZb29iBSV92WGBTS9KQXj480iN0leJcp0liZprjTYAAEULtA6qRBEw991GLyehQdLtPauRTQHk6MA69zdJJVyOyrTsSoHf8MMj7o9gzA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY4PR11MB1432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(2906002)(9686003)(33656002)(8936002)(52536014)(7696005)(66556008)(66476007)(64756008)(66446008)(76116006)(6916009)(66946007)(478600001)(55016002)(83380400001)(6506007)(54906003)(316002)(5660300002)(186003)(26005)(4326008)(8676002)(7416002)(86362001)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: LutDe3Nn90BwVYEuHMm3VUcexDXDUAM+OqPrXtUGNRPRyq3YFrjK2YsYlLHBZolueRfL4Z+wQl3mJ+HaGzA0tef0v13Sk6mXRHP/Mid4X/KgosvQtFOEjZF+BT53uEZOTebmDsYsj1eMPe2pwUtoEKSu8c5uCfJIaFyggaq16wLNNLtSF01rgOmx5tU2f8CDMFar8wv5OvSsq4PVOKo5pd9lvKTafYkMOixKm7UCQfs6QQtnJvol54m7dVAEIxkUguhllFDY6uFm4/dYEMKp1ACt9aN/5+G00X0IkBmqNUwh3GXUv+8yXHyEanMX2JfR/LpQYnY+Yxn+uHBgBoYgRde0vNJW1bmNVxmuAGrME6OViX8mDDrlDKswbbeoDJFlL5GiqLhVLXPobt/xMh97mmBWFFajGAH2DYHXzAyTQCNe8NvRj8YHhqJkyXSRR4T+P1wQbNZP7ed3+/Lukd2r8KLfl/mIss73p+pKJVyCLIlJ2QyoLnA8o/29y3Vl90Se
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb8a1c13-c6f7-453e-9d53-08d827de7699
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2020 10:12:49.7187 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2gN0RhdRA/UBYovUmejkc8irzvqmPYkkz3Z5nD3SdQnaOVxZRvzq5cYQlXotpbJkjlgPTjZyNo/xtmynixZYvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1702
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Wu,
 Hao" <hao.wu@intel.com>, Robin Murphy <robin.murphy@arm.com>, "Tian, 
 Jun J" <jun.j.tian@intel.com>
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

Hi Will,

> From: Will Deacon <will@kernel.org>
> Sent: Monday, July 13, 2020 9:15 PM
> 
> On Sun, Jul 12, 2020 at 04:20:58AM -0700, Liu Yi L wrote:
> > This patch is added as instead of returning a boolean for DOMAIN_ATTR_NESTING,
> > iommu_domain_get_attr() should return an iommu_nesting_info handle.
> >
> > Cc: Will Deacon <will@kernel.org>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > ---
> >  drivers/iommu/arm-smmu-v3.c | 29 +++++++++++++++++++++++++++--
> >  drivers/iommu/arm-smmu.c    | 29 +++++++++++++++++++++++++++--
> >  2 files changed, 54 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> > index f578677..ec815d7 100644
> > --- a/drivers/iommu/arm-smmu-v3.c
> > +++ b/drivers/iommu/arm-smmu-v3.c
> > @@ -3019,6 +3019,32 @@ static struct iommu_group
> *arm_smmu_device_group(struct device *dev)
> >  	return group;
> >  }
> >
> > +static int arm_smmu_domain_nesting_info(struct arm_smmu_domain
> *smmu_domain,
> > +					void *data)
> > +{
> > +	struct iommu_nesting_info *info = (struct iommu_nesting_info *)data;
> > +	unsigned int size;
> > +
> > +	if (!info || smmu_domain->stage != ARM_SMMU_DOMAIN_NESTED)
> > +		return -ENODEV;
> > +
> > +	size = sizeof(struct iommu_nesting_info);
> > +
> > +	/*
> > +	 * if provided buffer size is smaller than expected, should
> > +	 * return 0 and also the expected buffer size to caller.
> > +	 */
> > +	if (info->size < size) {
> > +		info->size = size;
> > +		return 0;
> > +	}
> > +
> > +	/* report an empty iommu_nesting_info for now */
> > +	memset(info, 0x0, size);
> > +	info->size = size;
> > +	return 0;
> > +}
> 
> Have you verified that this doesn't break the existing usage of
> DOMAIN_ATTR_NESTING in drivers/vfio/vfio_iommu_type1.c?

I didn't have ARM machine on my hand. But I contacted with Jean
Philippe, he confirmed no compiling issue. I didn't see any code
getting DOMAIN_ATTR_NESTING attr in current drivers/vfio/vfio_iommu_type1.c.
What I'm adding is to call iommu_domai_get_attr(, DOMAIN_ATTR_NESTIN)
and won't fail if the iommu_domai_get_attr() returns 0. This patch
returns an empty nesting info for DOMAIN_ATTR_NESTIN and return
value is 0 if no error. So I guess it won't fail nesting for ARM.

@Eric, how about your opinion? your dual-stage vSMMU support may
also share the vfio_iommu_type1.c code.

Regards,
Yi Liu

> Will
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
