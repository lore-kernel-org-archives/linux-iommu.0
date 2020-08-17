Return-Path: <SRS0=aSVE=B3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C63B9C433E1
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8557B20758
	for <iommu@archiver.kernel.org>; Mon, 17 Aug 2020 05:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="vuRmKkmY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8557B20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 23BCB80CE0;
	Mon, 17 Aug 2020 05:23:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mp_arVypHGAE; Mon, 17 Aug 2020 05:23:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D4492864F4;
	Mon, 17 Aug 2020 05:23:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B4291C07FF;
	Mon, 17 Aug 2020 05:23:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9CF3C0051
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:23:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C5436880C2
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:23:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RY8UZ6adxNVh for <iommu@lists.linux-foundation.org>;
 Mon, 17 Aug 2020 05:23:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C17BE8809E
 for <iommu@lists.linux-foundation.org>; Mon, 17 Aug 2020 05:23:19 +0000 (UTC)
IronPort-SDR: nRFGPhgyAJY9rYzTA7maSsBZnmaD3c1TAi2GaMvdipxEgplZlqcUl6f+cgGqy0FHhXAx7hvr9d
 P+ky4fC70/eA==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="142262639"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="142262639"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Aug 2020 22:23:18 -0700
IronPort-SDR: 1Nnebh+NYNSen1a0KeoIlEu6syUrcRf+HiyLQ49gQBB1xCiacGtrPwF1XSvvMqC1GdRW+xhI4y
 ls0hsT1NXgww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; d="scan'208";a="296375074"
Received: from unknown (HELO fmsmsx605.amr.corp.intel.com) ([10.18.84.215])
 by orsmga006.jf.intel.com with ESMTP; 16 Aug 2020 22:23:18 -0700
Received: from fmsmsx605.amr.corp.intel.com (10.18.126.85) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sun, 16 Aug 2020 22:23:18 -0700
Received: from fmsmsx124.amr.corp.intel.com (10.18.125.39) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Sun, 16 Aug 2020 22:23:18 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx124.amr.corp.intel.com (10.18.125.39) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 16 Aug 2020 22:23:18 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Sun, 16 Aug 2020 22:23:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f0Vt99yyyApJWP5zk7g0A/8fBxvPGdqrIXZphbPqo23ZExpbdlD06h+bTyATrgV8MLLEEqZYOhAO0iU6mgqE2nQ9a/Ltm+XlJDJnrFN8s9D4W/Nq9zJYuguCL/4cIYDw0Be3pUxIsx8+YqvECY88V5Qsg7LdqMeuAbaSoEt5vKh8JxswEwy1aX60AqRlU85dxZMP3RlwTYDwy18+9KJ6hAdCLuaBPGqqOhlTkqwWrmdkOkiYDEi4xG3a3ZEIiJ/+L1FFUN1qsVW1rGboFqeMmRsKM+nWICqLl03/rlu0D80+sOJJb12hi9nVN7TyLIR7DeUhXsz29ypoHJUsVIbd+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh+zczVGd2vjREclXrZCnA4ANMS6dDy/xU9bqQvFYvs=;
 b=ec6y2EmDaRsMfFvjEdVV+WMhJ8MUt35VhNzI5LmiA3bbukKjBtk/R9ZAMJHqa3W/KfCtY5gEdGJjgDcVQKoJ8vVETB1df9EFNkLjet0eOCxSrQwK2vx1M0m4AAwt8kgt01fqVcDkQpIRDy7VB4NL3AEgugH+adJ0DEkGvaAsurchmwkK5//nS7un3cCz8iZRBDE1MrweXGG9waXqQO+DE5DwDVbuSYJlxjzYHRrnkg5DdkAPaD6iqzaaJIdtzi5hIdVI58PFDHqwRjt3UQ/wR80+K7+xVKikDpMNt2FT7ETInkitEIQhroxPMbUw4mfkFYYtZNapCVp37egHTuI0FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sh+zczVGd2vjREclXrZCnA4ANMS6dDy/xU9bqQvFYvs=;
 b=vuRmKkmYMuOb0JeKoCePHKuSvItGuvlc2Uy8gKYCTNiJk6GZFkN0TQtHlQrD7Jpdi+prwxuANJGIm6/QNm7jjLkAme4a1uT/hQpgJ4uixCQ7ugVxl+LyQFiXSYsJKfCQDLPIPtfwm2YmKzm+W2mnq+ilAiQRV0U7xcyOwzjMuPU=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB3580.namprd11.prod.outlook.com (2603:10b6:5:138::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.22; Mon, 17 Aug 2020 05:23:16 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3283.027; Mon, 17 Aug
 2020 05:23:16 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Auger Eric <eric.auger@redhat.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "baolu.lu@linux.intel.com"
 <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>
Subject: RE: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Topic: [PATCH v6 07/15] vfio/type1: Add VFIO_IOMMU_PASID_REQUEST
 (alloc/free)
Thread-Index: AQHWZKdG9Cu5qyN/2EiULCi4Ic3bNKk5eW0AgAJqFaA=
Date: Mon, 17 Aug 2020 05:23:16 +0000
Message-ID: <DM5PR11MB14353E5E73AC2A2CC84B43C0C35F0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-8-git-send-email-yi.l.liu@intel.com>
 <c60dd620-8cc1-6ecb-8d88-ca5c8d724c7e@redhat.com>
In-Reply-To: <c60dd620-8cc1-6ecb-8d88-ca5c8d724c7e@redhat.com>
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
x-ms-office365-filtering-correlation-id: 26cddb18-6495-4fe8-4d75-08d8426da53a
x-ms-traffictypediagnostic: DM6PR11MB3580:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB3580F6E6C8E788E9465709FDC35F0@DM6PR11MB3580.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYHKd+iHkD7lDDJ5wjDam93sYwdeZ1/zvQoBTUbic9F2OfTIQC30/LJGPfBPhDtDW7f9awHoi4uHuc3oj/vuHlehgjyhi/07q6dhPjT1LHukKJLzcbClt3bLBSvQta0/n1qq6TQGVs7Qig+OGktzjwetm2d711DJX7iB31EsohaczPaylp5SucShPeEV4JP5irKvVWz7FLrBOiAXrCZYk4GCErBud9xsAQVF/z73X+PBgFoVj4xLkaxbmo7Zhu6DVaqWQpB1HsL3x9vwBy7NkYn0FhZaJFplRvWBAijhJ0/msaxGQ2xEqY6YaYeS6oIZfMEwU5af2sMwC+JaY6paY19GDzYi6L9BetjrOEHGpc7c10WIi8E0qTmwKzewxDsaX6n/2A/Y2TBR4dkUzu1bFw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(376002)(136003)(366004)(7416002)(186003)(26005)(8676002)(8936002)(33656002)(4326008)(478600001)(316002)(52536014)(86362001)(9686003)(7696005)(55016002)(5660300002)(83380400001)(66446008)(66556008)(966005)(66476007)(76116006)(71200400001)(54906003)(110136005)(2906002)(6506007)(64756008)(53546011)(66946007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: oIe54rjc014vPmdDCbAh7/XwjOMzZVNICQ8pI0nh9JLGyGjFsqDykeswTqp3YGADci83PpIGQVLVZidAV7S6ZM25/aMemMfZFP3cVSDHs+75wMhTb/WnK4gjYjiDpSvjfMyUUl5Hmgmx8NrSAxvN5p+m0psQhNn80ZuOzpiZeMxh1UDVwzMizjXBaOKBSS79Xn2/AwS86G7rv+ihseIVvd1BkmheVGtI8ZhioLe4irEJnXrxJtcXXScXEwQhGjPDu21bLRWYziWx9Mde8gMBpMuJ7XeatKVkcepiENXrT9oeWbVnan3rrYAI31OB9GkhQ5h9tHzRwO2dOwRNJyRVxtJqK9S1Eq/AiD2rVVmjTEMDrC3gbgx/hNUlqRrKMZ3NqX1FL9/s32RtxXAyBX5dFcb9BGN2akGwkVV7cGhcPW+Kt+wuRT1aLTg7OLezyBqBhXV4FgjBVWP1nvU4YENVw18maOdRlSVlTrwHzNgWBg9f30Enclxl2m3e97yxJbWah07C3luccqKoQXtHKiF2j1eO/B/aMXPjWR4BxU3irHG6jaN01FqotSANC/94AWdSzz94bjX3qSWzdfGFQ87yAklQcrHHASauHg5GsEi3kVC9v+UdgBVWarwCndxVrDB5s/k4UqHIFiMHIx8tl4c/Hg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 26cddb18-6495-4fe8-4d75-08d8426da53a
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2020 05:23:16.2635 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3/LqbBpoMc4vbJYuQ6A4QAMGu+YGRwgeFc3bXw0yir+87CoUTm1IyUuiTcIdn8PkHiw+PBJIKyIMMf6uXLYPbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB3580
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

Thanks, Eric.

Regards,
Yi Liu

> From: Auger Eric <eric.auger@redhat.com>
> Sent: Sunday, August 16, 2020 12:30 AM
> 
> Yi,
> 
> On 7/28/20 8:27 AM, Liu Yi L wrote:
> > This patch allows userspace to request PASID allocation/free, e.g.
> > when serving the request from the guest.
> >
> > PASIDs that are not freed by userspace are automatically freed when
> > the IOASID set is destroyed when process exits.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > ---
> > v5 -> v6:
> > *) address comments from Eric against v5. remove the alloc/free helper.
> >
> > v4 -> v5:
> > *) address comments from Eric Auger.
> > *) the comments for the PASID_FREE request is addressed in patch 5/15 of
> >    this series.
> >
> > v3 -> v4:
> > *) address comments from v3, except the below comment against the range
> >    of PASID_FREE request. needs more help on it.
> >     "> +if (req.range.min > req.range.max)
> >
> >      Is it exploitable that a user can spin the kernel for a long time in
> >      the case of a free by calling this with [0, MAX_UINT] regardless of
> >      their actual allocations?"
> >
> > https://lore.kernel.org/linux-iommu/20200702151832.048b44d1@x1.home/
> >
> > v1 -> v2:
> > *) move the vfio_mm related code to be a seprate module
> > *) use a single structure for alloc/free, could support a range of
> > PASIDs
> > *) fetch vfio_mm at group_attach time instead of at iommu driver open
> > time
> > ---
> >  drivers/vfio/Kconfig            |  1 +
> >  drivers/vfio/vfio_iommu_type1.c | 69
> +++++++++++++++++++++++++++++++++++++++++
> >  drivers/vfio/vfio_pasid.c       | 10 ++++++
> >  include/linux/vfio.h            |  6 ++++
> >  include/uapi/linux/vfio.h       | 37 ++++++++++++++++++++++
> >  5 files changed, 123 insertions(+)
> >
> > diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig index
> > 3d8a108..95d90c6 100644
> > --- a/drivers/vfio/Kconfig
> > +++ b/drivers/vfio/Kconfig
> > @@ -2,6 +2,7 @@
> >  config VFIO_IOMMU_TYPE1
> >  	tristate
> >  	depends on VFIO
> > +	select VFIO_PASID if (X86)
> >  	default n
> >
> >  config VFIO_IOMMU_SPAPR_TCE
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 18ff0c3..ea89c7c 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -76,6 +76,7 @@ struct vfio_iommu {
> >  	bool				dirty_page_tracking;
> >  	bool				pinned_page_dirty_scope;
> >  	struct iommu_nesting_info	*nesting_info;
> > +	struct vfio_mm			*vmm;
> >  };
> >
> >  struct vfio_domain {
> > @@ -1937,6 +1938,11 @@ static void vfio_iommu_iova_insert_copy(struct
> > vfio_iommu *iommu,
> >
> >  static void vfio_iommu_release_nesting_info(struct vfio_iommu *iommu)
> > {
> > +	if (iommu->vmm) {
> > +		vfio_mm_put(iommu->vmm);
> > +		iommu->vmm = NULL;
> > +	}
> > +
> >  	kfree(iommu->nesting_info);
> >  	iommu->nesting_info = NULL;
> >  }
> > @@ -2071,6 +2077,26 @@ static int vfio_iommu_type1_attach_group(void
> *iommu_data,
> >  					    iommu->nesting_info);
> >  		if (ret)
> >  			goto out_detach;
> > +
> > +		if (iommu->nesting_info->features &
> > +					IOMMU_NESTING_FEAT_SYSWIDE_PASID)
> {
> > +			struct vfio_mm *vmm;
> > +			int sid;
> > +
> > +			vmm = vfio_mm_get_from_task(current);
> > +			if (IS_ERR(vmm)) {
> > +				ret = PTR_ERR(vmm);
> > +				goto out_detach;
> > +			}
> > +			iommu->vmm = vmm;
> > +
> > +			sid = vfio_mm_ioasid_sid(vmm);
> > +			ret = iommu_domain_set_attr(domain->domain,
> > +						    DOMAIN_ATTR_IOASID_SID,
> > +						    &sid);
> > +			if (ret)
> > +				goto out_detach;
> > +		}
> >  	}
> >
> >  	/* Get aperture info */
> > @@ -2859,6 +2885,47 @@ static int vfio_iommu_type1_dirty_pages(struct
> vfio_iommu *iommu,
> >  	return -EINVAL;
> >  }
> >
> > +static int vfio_iommu_type1_pasid_request(struct vfio_iommu *iommu,
> > +					  unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_pasid_request req;
> > +	unsigned long minsz;
> > +	int ret;
> > +
> > +	minsz = offsetofend(struct vfio_iommu_type1_pasid_request, range);
> > +
> > +	if (copy_from_user(&req, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (req.argsz < minsz || (req.flags & ~VFIO_PASID_REQUEST_MASK))
> > +		return -EINVAL;
> > +
> > +	if (req.range.min > req.range.max)
> > +		return -EINVAL;
> > +
> > +	mutex_lock(&iommu->lock);
> > +	if (!iommu->vmm) {
> > +		mutex_unlock(&iommu->lock);
> > +		return -EOPNOTSUPP;
> > +	}
> > +
> > +	switch (req.flags & VFIO_PASID_REQUEST_MASK) {
> > +	case VFIO_IOMMU_FLAG_ALLOC_PASID:
> > +		ret = vfio_pasid_alloc(iommu->vmm, req.range.min,
> > +				       req.range.max);
> > +		break;
> > +	case VFIO_IOMMU_FLAG_FREE_PASID:
> > +		vfio_pasid_free_range(iommu->vmm, req.range.min,
> > +				      req.range.max);
> > +		ret = 0;
> > +		break;
> > +	default:
> > +		ret = -EINVAL;
> > +	}
> > +	mutex_unlock(&iommu->lock);
> > +	return ret;
> > +}
> > +
> >  static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  				   unsigned int cmd, unsigned long arg)  { @@ -
> 2875,6 +2942,8 @@
> > static long vfio_iommu_type1_ioctl(void *iommu_data,
> >  		return vfio_iommu_type1_unmap_dma(iommu, arg);
> >  	case VFIO_IOMMU_DIRTY_PAGES:
> >  		return vfio_iommu_type1_dirty_pages(iommu, arg);
> > +	case VFIO_IOMMU_PASID_REQUEST:
> > +		return vfio_iommu_type1_pasid_request(iommu, arg);
> >  	default:
> >  		return -ENOTTY;
> >  	}
> > diff --git a/drivers/vfio/vfio_pasid.c b/drivers/vfio/vfio_pasid.c
> > index befcf29..8d0317f 100644
> > --- a/drivers/vfio/vfio_pasid.c
> > +++ b/drivers/vfio/vfio_pasid.c
> > @@ -61,6 +61,7 @@ void vfio_mm_put(struct vfio_mm *vmm)  {
> >  	kref_put_mutex(&vmm->kref, vfio_mm_release, &vfio_mm_lock);  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_put);
> >
> >  static void vfio_mm_get(struct vfio_mm *vmm)
> >  {
> > @@ -114,6 +115,13 @@ struct vfio_mm *vfio_mm_get_from_task(struct
> task_struct *task)
> >  	mmput(mm);
> >  	return vmm;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_mm_get_from_task);
> > +
> > +int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > +{
> > +	return vmm->ioasid_sid;
> > +}
> > +EXPORT_SYMBOL_GPL(vfio_mm_ioasid_sid);
> >
> >  /*
> >   * Find PASID within @min and @max
> > @@ -202,6 +210,7 @@ int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >
> >  	return pasid;
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_alloc);
> >
> >  void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  			   ioasid_t min, ioasid_t max)
> > @@ -218,6 +227,7 @@ void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  		vfio_remove_pasid(vmm, vid);
> >  	mutex_unlock(&vmm->pasid_lock);
> >  }
> > +EXPORT_SYMBOL_GPL(vfio_pasid_free_range);
> >
> >  static int __init vfio_pasid_init(void)
> >  {
> > diff --git a/include/linux/vfio.h b/include/linux/vfio.h
> > index 31472a9..a355d01 100644
> > --- a/include/linux/vfio.h
> > +++ b/include/linux/vfio.h
> > @@ -101,6 +101,7 @@ struct vfio_mm;
> >  #if IS_ENABLED(CONFIG_VFIO_PASID)
> >  extern struct vfio_mm *vfio_mm_get_from_task(struct task_struct *task);
> >  extern void vfio_mm_put(struct vfio_mm *vmm);
> > +extern int vfio_mm_ioasid_sid(struct vfio_mm *vmm);
> >  extern int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max);
> >  extern void vfio_pasid_free_range(struct vfio_mm *vmm,
> >  				  ioasid_t min, ioasid_t max);
> > @@ -114,6 +115,11 @@ static inline void vfio_mm_put(struct vfio_mm *vmm)
> >  {
> >  }
> >
> > +static inline int vfio_mm_ioasid_sid(struct vfio_mm *vmm)
> > +{
> > +	return -ENOTTY;
> > +}
> > +
> >  static inline int vfio_pasid_alloc(struct vfio_mm *vmm, int min, int max)
> >  {
> >  	return -ENOTTY;
> > diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
> > index 0cf3d6d..6d79557 100644
> > --- a/include/uapi/linux/vfio.h
> > +++ b/include/uapi/linux/vfio.h
> > @@ -1172,6 +1172,43 @@ struct vfio_iommu_type1_dirty_bitmap_get {
> >
> >  #define VFIO_IOMMU_DIRTY_PAGES             _IO(VFIO_TYPE, VFIO_BASE + 17)
> >
> > +/**
> > + * VFIO_IOMMU_PASID_REQUEST - _IOWR(VFIO_TYPE, VFIO_BASE + 18,
> > + *				struct vfio_iommu_type1_pasid_request)
> > + *
> > + * PASID (Processor Address Space ID) is a PCIe concept for tagging
> > + * address spaces in DMA requests. When system-wide PASID allocation
> > + * is required by the underlying iommu driver (e.g. Intel VT-d), this
> > + * provides an interface for userspace to request pasid alloc/free
> > + * for its assigned devices. Userspace should check the availability
> > + * of this API by checking VFIO_IOMMU_TYPE1_INFO_CAP_NESTING through
> > + * VFIO_IOMMU_GET_INFO.
> > + *
> > + * @flags=VFIO_IOMMU_FLAG_ALLOC_PASID, allocate a single PASID within
> @range.
> > + * @flags=VFIO_IOMMU_FLAG_FREE_PASID, free the PASIDs within @range.
> > + * @range is [min, max], which means both @min and @max are inclusive.
> > + * ALLOC_PASID and FREE_PASID are mutually exclusive.
> > + *
> > + * returns: allocated PASID value on success, -errno on failure for
> > + *	     ALLOC_PASID;
> > + *	     0 for FREE_PASID operation;
> > + */
> > +struct vfio_iommu_type1_pasid_request {
> > +	__u32	argsz;
> > +#define VFIO_IOMMU_FLAG_ALLOC_PASID	(1 << 0)
> > +#define VFIO_IOMMU_FLAG_FREE_PASID	(1 << 1)
> > +	__u32	flags;
> > +	struct {
> > +		__u32	min;
> > +		__u32	max;
> > +	} range;
> > +};
> > +
> > +#define VFIO_PASID_REQUEST_MASK	(VFIO_IOMMU_FLAG_ALLOC_PASID | \
> > +					 VFIO_IOMMU_FLAG_FREE_PASID)
> > +
> > +#define VFIO_IOMMU_PASID_REQUEST	_IO(VFIO_TYPE, VFIO_BASE + 18)
> > +
> >  /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
> >
> >  /*
> >
> Looks OK to me
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
>
> 
> Thanks
> 
> Eric

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
