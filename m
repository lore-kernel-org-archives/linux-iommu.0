Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EAEC433EB
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 01:18:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9AA207E8
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 01:18:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="w5j8m1tq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9AA207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 551FE85A92;
	Wed, 29 Jul 2020 01:18:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dTIav-kE8AAU; Wed, 29 Jul 2020 01:18:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B506485A56;
	Wed, 29 Jul 2020 01:18:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A570EC004F;
	Wed, 29 Jul 2020 01:18:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 604C7C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 01:18:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 44530203F6
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 01:18:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rln+xvdsy1SQ for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 01:18:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by silver.osuosl.org (Postfix) with ESMTPS id 28FE42039C
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 01:18:07 +0000 (UTC)
IronPort-SDR: XpUnA5uQMnoIOeIQ1bgqBjl/ZwMpUUS6lJcJoJ+XT+bVc9RST2t2UXJ/kokH8qrFTqXJ60NTj8
 H7ARhz0a4sSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="215847194"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="215847194"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 18:18:06 -0700
IronPort-SDR: 75/W5T4kXnOTgKaqT4L3FPniDYA+ig03ttOGrAt/NsZUzmE7q/iI7UxOVl2JqDrhZWB24Oe5zD
 ALR8h70ogp4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="490580183"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
 by fmsmga005.fm.intel.com with ESMTP; 28 Jul 2020 18:18:05 -0700
Received: from orsmsx163.amr.corp.intel.com (10.22.240.88) by
 ORSMSX109.amr.corp.intel.com (10.22.240.7) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 18:18:05 -0700
Received: from ORSEDG001.ED.cps.intel.com (10.7.248.4) by
 ORSMSX163.amr.corp.intel.com (10.22.240.88) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 18:18:05 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Tue, 28 Jul 2020 18:18:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iEvo07CE4AuksEr+W3PtNdAwxM4SRorbEvYdSf4rnw6fiEDYoRZoHCg+acBa4j+jhv+sCsvECwKe0B7SG5wx/jAKUgBDCTTgX4C/E8fqCELG7sYUlW4011gSm3JZ4H/Jlf6/Ypq64LabTrsyEGk6Tk5/N7SVajUbpJ9S1sbfCQmlChEJen5nD5FpWRXYqHQDIe15ToI73H7+Y/yMUQaqYTuO/HMgWvCjZVVgKvptsMkaqeLN5A0/ImhByXxoLT3JeoY3Z6++a4pV6yldeq44wElbv96RY4rNiOMzxZKdp2/Ih7/ZqsoV6CzLnKj/ICYyeJMPKm9Yf5S3NWg6Pg1F/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLrLOH3KKaKzgubAod+XShlOYPMUJlbUxNzsTeuvjlo=;
 b=lwqsDxoqJSAYgxqDPqFX6U54tRFT7hS9LR2o2UUhXh9D2bAXL/Edk75g8cRarisKGS19WvaBOnwFx986I4NBrW3yqHFT2ymjrIm2pVYYHMeaT5r1H2xsFcM8BBOfkrBeogxSOsFpzR3/l+GhkMbqh6rsTi4DEjT2W9/s2KXNpFXdSij6rqLLY8DCIw8rl4OmeWRHEK2PnYjV/28UCkPkIAqX3wmfPvvX7lYdAEHWj6Bf0XomgzgI6/+RYVmHbDC9t/cL+ye7k+t+5MH2aTNFg/NF5/aClPHQ9m+wgTCLlE5hBYhcUatfOrL2ak9KPmv2iCQqVQXnRP08+JXNPW0+8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cLrLOH3KKaKzgubAod+XShlOYPMUJlbUxNzsTeuvjlo=;
 b=w5j8m1tqNhg6GPdGaMRB1Ytc2Bil/QPImMpGrhkpBtSI5hPMoIx9vfmm9HHXO82tF3Yq4ZV+RkQoc1eCIA3lW8KmBu2RtfT4TPv8AyAv+0lUi5YsCc9f4K+5nDZRvg2qh/Qh9Kjp8lpt7ubd39gUXX9Vonyy8p81iHA/Y8Xr8BE=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB1598.namprd11.prod.outlook.com (2603:10b6:301:c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Wed, 29 Jul
 2020 01:18:04 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3216.034; Wed, 29 Jul 2020
 01:18:04 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, Jacob Pan
 <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH v6 1/6] docs: IOMMU user API
Thread-Topic: [PATCH v6 1/6] docs: IOMMU user API
Thread-Index: AQHWYRVd9VIbdjTBFk6+Qau6eMOt+akdZfUAgABgR7A=
Date: Wed, 29 Jul 2020 01:18:04 +0000
Message-ID: <MWHPR11MB1645BA0C8436C3280DBDC5468C700@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1595525140-23899-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1595525140-23899-2-git-send-email-jacob.jun.pan@linux.intel.com>
 <20200728131950.2aff140d@x1.home>
In-Reply-To: <20200728131950.2aff140d@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.209]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1260e725-092b-468f-a9e4-08d8335d3e43
x-ms-traffictypediagnostic: MWHPR11MB1598:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB15985452293E31F7A52C8E298C700@MWHPR11MB1598.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8h9AcCiWnLvb3wehvxe4hmFE46HGU+e/0hzm9CxAsVvxj8HHlwtK0SutI7yZ1m11n3oRloHBEAsMHioLFybYbXRaCmbgytmSs+xoK7etH6GcwAtsZ/wiPJeNOf+oxxdzI4kcXbXK6HVqQgfU+cIlYfD3UIGE4WqU1CGnQ/PyplzSWqvN3Nekz84ljJWzYkwfsxSfiWR9kOGvNsuho6BItJWKAUkgAnTO4u8B7pyQlo4kgSRLVIIUokHt0WVERFjWFLHSm4fumsW7vaoF6lAprVJtUX0RQ+Z3KvaMG/NbsuyCPacv6Ffi8zrSHIwIZoXxeB4ldqcGx5QXFf1+zGnNJA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(39860400002)(366004)(376002)(55016002)(86362001)(76116006)(83380400001)(66946007)(64756008)(66556008)(66476007)(66446008)(110136005)(7696005)(9686003)(8936002)(2906002)(8676002)(6506007)(7416002)(71200400001)(52536014)(186003)(4326008)(33656002)(5660300002)(316002)(54906003)(26005)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: xJiAbeXf10OIRPMeLc+fGi1SYEZIKR8kuXz2cLJ0fmAD7POeejZZomftDCJOA4Xedc93cZ0cOK1A0fMfBiIPHEm0o3NcDrOdqI1/VdGnMR2NGM/lFhXvxzG9t2faOkkEio0gbTWwrriwKcHdDvWP8RjyGW5b8IwMXMpTtqoll8oL9Q0F33L0VguzUyA+0g0i1rbWFKvH4EE0FuAOugU1XhtZ0XlxxHap3D1hRYd+zovq3Thd8n7Ln+E/SR+/erDchFcmhQzA8f7skBEJ/ixHtEvkMyMaBKEcPZPSj+/uGAvkMPW0EwBGdou2Gmezq9O6amcGDKHqi0ZYE8Z35b9lPxCwWSmeRkPlo5LjEFYG6CZl+BchNvgT5K/i3Rg0RB7/LUa+rWSD/t/CUQOKkQgH6u2LakWMyT0EjZV05g9VW0Zk72HDDVoEJcD48e3e4wCjfP5KpcdMu57IOgmN4rzg/3z5nApFyyMiXEKHhcH4MclvIirDoKsLTsQKnIZl6fyxiYSYtLTF/fHSU9pPt7gZ8nB+2Q5kYVzKdvc57SKKioK66jpcQ4LwF4HEkGBdCaptX9PEjFXHeCCdKhv16k8H3x2buCJRsC8pnW6dZmmL21z6dvAhxSHihfVGG0FcsZKoz4eaW0yFFV7DvQ2aTmF6cg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1645.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1260e725-092b-468f-a9e4-08d8335d3e43
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 01:18:04.0592 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: S+X+AWZnWp86G/fnJ22N8XNXN4uQPZ6RyvJ0mwSBWt49D5cC8aZewOHKb8EOKlDcLAaaqA+z7mzBFYh7sCme1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1598
X-OriginatorOrg: intel.com
Cc: "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 David Woodhouse <dwmw2@infradead.org>
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Wednesday, July 29, 2020 3:20 AM
> 
[...]
> > +
> > +For example, IOTLB invalidations should always succeed. There is no
> > +architectural way to report back to the vIOMMU if the UAPI data is
> > +incompatible. If that happens, in order to guarantee IOMMU iosolation,
> 
> isolation
> 
> > +we have to resort to not giving completion status in vIOMMU. This may
> > +result in VM hang.
> > +
> > +For this reason the following IOMMU UAPIs cannot fail without
> > +catastrophic effect:
> > +
> > +1. Free PASID
> > +2. Unbind guest PASID
> > +3. Unbind guest PASID table (SMMU)
> > +4. Cache invalidate
> 
> I'm not entirely sure what we're trying to assert here.  Clearly cache
> invalidation can fail and patch 5/6 goes on to add over a dozen checks
> of the user provided data that return an -errno.  Any user ioctl can
> fail if the user botches the parameters.  So are we just trying to
> explain the feature checking that should allow the user to know
> supported combinations and if they adhere to them, these should not
> fail?  It's not quite worded to that effect.  Thanks,
> 

I guess the above wording is messed by what a UAPI should
behave and whether the vIOMMU reports associated errors.
UAPI can always fail, as you pointed out. vIOMMU may not
have a matching error code though, e.g. on Intel VT-d there is no
error reporting mechanism for cache invalidation. However,
it is not wise to assert UAPI behavior according to vIOMMU
definition. An error is an error. vIOMMU should just react to
UAPI errors according to its architecture definition (e.g. ignore,
forward to guest, hang, etc.). From this matter I feel above
section could better be removed.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
