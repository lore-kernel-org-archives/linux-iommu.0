Return-Path: <SRS0=r5As=AO=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DE3C433E0
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 03:47:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3831120674
	for <iommu@archiver.kernel.org>; Fri,  3 Jul 2020 03:47:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="cWy9qNEv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3831120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F209387C70;
	Fri,  3 Jul 2020 03:47:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1I3ZzC8yx0zb; Fri,  3 Jul 2020 03:46:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8134187AC1;
	Fri,  3 Jul 2020 03:46:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62E4EC0888;
	Fri,  3 Jul 2020 03:46:59 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE918C0733
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:46:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id D753C25075
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:46:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4Snb8KIIfaxM for <iommu@lists.linux-foundation.org>;
 Fri,  3 Jul 2020 03:46:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by silver.osuosl.org (Postfix) with ESMTPS id 3170A248A1
 for <iommu@lists.linux-foundation.org>; Fri,  3 Jul 2020 03:46:55 +0000 (UTC)
IronPort-SDR: pjaZdxLkUE+UvVWZTrLRoAtHhqKAq1rnz21R8769aAGff2pozi3Xk4+clkKigt1rSuQRpn3um0
 aiqtLVLgXvVw==
X-IronPort-AV: E=McAfee;i="6000,8403,9670"; a="165143644"
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="165143644"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Jul 2020 20:46:54 -0700
IronPort-SDR: YZZ+R8sVe8k1qFj8KQNvZeXLdifIDr45Mu67IsR7LIMHy6bqcSEax7RDD7ChYIKSpsaSXrFO4Q
 irZvrqPBEQnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,306,1589266800"; d="scan'208";a="482233378"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by fmsmga005.fm.intel.com with ESMTP; 02 Jul 2020 20:46:54 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 2 Jul 2020 20:46:53 -0700
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 2 Jul 2020 20:46:53 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX151.amr.corp.intel.com (10.22.226.38) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 2 Jul 2020 20:46:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Thu, 2 Jul 2020 20:46:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kShw9uER5ZK5H5m5CsFor6jUUBDVjwiwDSRBryvtgamDh7AjwZOBYMxOySxMkd+YyNnuGTF34NfCKm3b94S5gEijfPhiVxs3Dq8gSJL3fq0pVCrpN8WLZhXQ0zNgXgDUVqG0OLNHUeUi2E7r2fsX9SlhYqqAdRSPtu8XbNAAWeH88xDhvaoM5U5x/dFILBZKVWRT/pgROzh8qUqbeo5h4ZONHxvdLYJR+wn2OtEh0Dq/sZQrXrAFqQiSkrx4FWAUL6q5CHZtREdaOQYzz+cQRv2OvbBPY+hQ/YOlmWEvzK5bLhXwIvaSGK62xVK+Fv5BSe0OedikfNPvGM+rcmIVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGHYCZnqILqpEC0fZb3cPCOerWsct4PM7eKLNYBt8pk=;
 b=h0MZRAjJA2r0RbeMa6VPHRASsZajLoZM1hwMEjCDiHKW/O8K6lLo5qcO3/0+HmRzMCI2F9Qhi/wu0KoKWzqqg/3HdRR9EHmyQTy+YUwujXXCeXwHTwPXlHKbJcQHM1bDgZ3TKyDQ7pVQArVC7+/tlQ8LDTLeEQDcKsbq8+6BDXE60Qg2pae4bC0qGWcYLQNpp1ZV+5uE5lpPqviAZaEBj2iwiYKGeQdb169CC8AJL8p3+heykBrYnpBHcHkdAGhpJxTrqcbekWBhM50v5q2G17V63pXsvFJp2AFjs1IiEs1lEyrdLBboD7fNSugnjTeYsqF0kg/loJ33ih7gjT32og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGHYCZnqILqpEC0fZb3cPCOerWsct4PM7eKLNYBt8pk=;
 b=cWy9qNEvjmrOm4wd4+E7fgmyL/9Ml9AQnctaUOC1bhWJjWD3STfUVy/XGwl75teU/WxNIhAFWB/G+2NqAet+pGOHb0NiILtJ0bCTJr+7ySVWMdkXKinOoeYOzb8P5AdyshZyICJ8q8Na9FFykNbsyq2f+Iz6x41MXmKxNpOlsmk=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4076.namprd11.prod.outlook.com (2603:10b6:5:197::17) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.28; Fri, 3 Jul 2020 03:46:52 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::2c3d:98d9:4e81:c86c%6]) with mapi id 15.20.3131.033; Fri, 3 Jul 2020
 03:46:52 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v3 01/14] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Topic: [PATCH v3 01/14] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Index: AQHWSgRP5alWmuhHv0+o228EmqQebKj02VaAgABmNOA=
Date: Fri, 3 Jul 2020 03:46:51 +0000
Message-ID: <DM5PR11MB143599F220FA4FCA5492B919C36A0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1592988927-48009-1-git-send-email-yi.l.liu@intel.com>
 <1592988927-48009-2-git-send-email-yi.l.liu@intel.com>
 <20200702152101.7eb1e77b@x1.home>
In-Reply-To: <20200702152101.7eb1e77b@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.205]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: dbe28961-be32-49a5-b44c-08d81f03b8ec
x-ms-traffictypediagnostic: DM6PR11MB4076:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4076EC25DA92C0A33EC812A7C36A0@DM6PR11MB4076.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:389;
x-forefront-prvs: 045315E1EE
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgWGPEzEk8s0ZJvLeTDwS9yCrh/+zNdKqbrKUj1CjYgsg8UiiqM+wAc2sDfLQeb5fW7jU06X9EFZxeRizA+czBEVHWxliUJepXPmmRxL5Zd98OdJEXW2zxalC0gTNc7Z+Xsn1YmSNFd1JtW2p8JYWMUgMVJ1rxecZtPorZQK53zsb+E95ibBpIKqBnYSTmsdTmH2wLZzQAUX6s+vM7XmYnz43bwCxfVy0WDcj2pOFz+ZKgQsVn4D+jgVw/G20HyLfTS6k+D2C42xQkAjK0TctKp+chZL5ej9XhYquqTI0DjX/e9h7KVim4tY8+CTis/IXfLPaCLUH4hgq1HGWJB36Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(39860400002)(376002)(346002)(366004)(52536014)(7696005)(186003)(76116006)(2906002)(54906003)(86362001)(66476007)(5660300002)(316002)(66946007)(478600001)(33656002)(66446008)(64756008)(66556008)(6506007)(26005)(8676002)(53546011)(6916009)(30864003)(8936002)(83380400001)(7416002)(55016002)(71200400001)(9686003)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: Jd+cBkStUCfYjmt4vQ1AVLvc+P3XcbTzWzdLif1JZzzqqU2F105xJ7Vb07opwh/uVGILGuNilsr3GyrBUHMcinV1boZGky2HFREY4zmM+lKVhRxzmrOoKY5hb6UOydR15BHjxKJ8/mtGFHqc2UKv0ELNhEXd6GHFMpVxrQzruPE13wCI5jhhGGoqGnXxcwWKD6GMKq7jJNa4qgvw2OXoTrH5kKBBkfvLys7OsebRPNsLSY5X6uoDcIw9+aorqW24SZi2KBrY6JRcvbgEWlBVIeVDrfdZucpx/RtDnSqJweCGM0dKRRS6TECuzkMFWMImYLl2S/OXrE338Vl5288m2WOqMR9bP0RXqH+agy6FMLlvXuqVK96wluMYkxyrBLaNs10SbQyYsoZsy98uVQr0jUdIljlf/xB7kXNPZWk0t8ubpSKaHcm0naWQEAQ9mbtWT1lOnqVqUmAaR//FvoEfiYgmrVjBdggHT4NR3CGe95a8Q0x/Tt0uY+3t49ewMn/L
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbe28961-be32-49a5-b44c-08d81f03b8ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2020 03:46:51.7160 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wlx0tm2plMU1YrTDkMpsfF5so7POcFYIr5gPgHaFDajyk96OZYl3lJyU4aPwtbyGdhLk67hNX+1mStOTJ92oQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4076
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>, "Wu, Hao" <hao.wu@intel.com>, "Tian,
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

> From: Alex Williamson <alex.williamson@redhat.com>
> Sent: Friday, July 3, 2020 5:21 AM
> To: Liu, Yi L <yi.l.liu@intel.com>
> 
> On Wed, 24 Jun 2020 01:55:14 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch refactors the vfio_iommu_type1_ioctl() to use switch
> > instead of if-else, and each cmd got a helper function.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 392
> > ++++++++++++++++++++++------------------
> >  1 file changed, 213 insertions(+), 179 deletions(-)
> 
> I can go ahead and grab this one for my v5.9 next branch.  Thanks,

thanks, that would be great help. I'll monitor your next branch on github.

Regards,
Yi Liu

> Alex
> 
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 5e556ac..7accb59 100644
> > --- a/drivers/vfio/vfio_iommu_type1.c
> > +++ b/drivers/vfio/vfio_iommu_type1.c
> > @@ -2453,6 +2453,23 @@ static int vfio_domains_have_iommu_cache(struct
> vfio_iommu *iommu)
> >  	return ret;
> >  }
> >
> > +static int vfio_iommu_type1_check_extension(struct vfio_iommu *iommu,
> > +					    unsigned long arg)
> > +{
> > +	switch (arg) {
> > +	case VFIO_TYPE1_IOMMU:
> > +	case VFIO_TYPE1v2_IOMMU:
> > +	case VFIO_TYPE1_NESTING_IOMMU:
> > +		return 1;
> > +	case VFIO_DMA_CC_IOMMU:
> > +		if (!iommu)
> > +			return 0;
> > +		return vfio_domains_have_iommu_cache(iommu);
> > +	default:
> > +		return 0;
> > +	}
> > +}
> > +
> >  static int vfio_iommu_iova_add_cap(struct vfio_info_cap *caps,
> >  		 struct vfio_iommu_type1_info_cap_iova_range *cap_iovas,
> >  		 size_t size)
> > @@ -2529,238 +2546,255 @@ static int
> vfio_iommu_migration_build_caps(struct vfio_iommu *iommu,
> >  	return vfio_info_add_capability(caps, &cap_mig.header,
> > sizeof(cap_mig));  }
> >
> > -static long vfio_iommu_type1_ioctl(void *iommu_data,
> > -				   unsigned int cmd, unsigned long arg)
> > +static int vfio_iommu_type1_get_info(struct vfio_iommu *iommu,
> > +				     unsigned long arg)
> >  {
> > -	struct vfio_iommu *iommu = iommu_data;
> > +	struct vfio_iommu_type1_info info;
> >  	unsigned long minsz;
> > +	struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > +	unsigned long capsz;
> > +	int ret;
> >
> > -	if (cmd == VFIO_CHECK_EXTENSION) {
> > -		switch (arg) {
> > -		case VFIO_TYPE1_IOMMU:
> > -		case VFIO_TYPE1v2_IOMMU:
> > -		case VFIO_TYPE1_NESTING_IOMMU:
> > -			return 1;
> > -		case VFIO_DMA_CC_IOMMU:
> > -			if (!iommu)
> > -				return 0;
> > -			return vfio_domains_have_iommu_cache(iommu);
> > -		default:
> > -			return 0;
> > -		}
> > -	} else if (cmd == VFIO_IOMMU_GET_INFO) {
> > -		struct vfio_iommu_type1_info info;
> > -		struct vfio_info_cap caps = { .buf = NULL, .size = 0 };
> > -		unsigned long capsz;
> > -		int ret;
> > -
> > -		minsz = offsetofend(struct vfio_iommu_type1_info,
> iova_pgsizes);
> > +	minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
> >
> > -		/* For backward compatibility, cannot require this */
> > -		capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> > +	/* For backward compatibility, cannot require this */
> > +	capsz = offsetofend(struct vfio_iommu_type1_info, cap_offset);
> >
> > -		if (copy_from_user(&info, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	if (copy_from_user(&info, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		if (info.argsz < minsz)
> > -			return -EINVAL;
> > +	if (info.argsz < minsz)
> > +		return -EINVAL;
> >
> > -		if (info.argsz >= capsz) {
> > -			minsz = capsz;
> > -			info.cap_offset = 0; /* output, no-recopy necessary */
> > -		}
> > +	if (info.argsz >= capsz) {
> > +		minsz = capsz;
> > +		info.cap_offset = 0; /* output, no-recopy necessary */
> > +	}
> >
> > -		mutex_lock(&iommu->lock);
> > -		info.flags = VFIO_IOMMU_INFO_PGSIZES;
> > +	mutex_lock(&iommu->lock);
> > +	info.flags = VFIO_IOMMU_INFO_PGSIZES;
> >
> > -		info.iova_pgsizes = iommu->pgsize_bitmap;
> > +	info.iova_pgsizes = iommu->pgsize_bitmap;
> >
> > -		ret = vfio_iommu_migration_build_caps(iommu, &caps);
> > +	ret = vfio_iommu_migration_build_caps(iommu, &caps);
> >
> > -		if (!ret)
> > -			ret = vfio_iommu_iova_build_caps(iommu, &caps);
> > +	if (!ret)
> > +		ret = vfio_iommu_iova_build_caps(iommu, &caps);
> >
> > -		mutex_unlock(&iommu->lock);
> > +	mutex_unlock(&iommu->lock);
> >
> > -		if (ret)
> > -			return ret;
> > +	if (ret)
> > +		return ret;
> >
> > -		if (caps.size) {
> > -			info.flags |= VFIO_IOMMU_INFO_CAPS;
> > +	if (caps.size) {
> > +		info.flags |= VFIO_IOMMU_INFO_CAPS;
> >
> > -			if (info.argsz < sizeof(info) + caps.size) {
> > -				info.argsz = sizeof(info) + caps.size;
> > -			} else {
> > -				vfio_info_cap_shift(&caps, sizeof(info));
> > -				if (copy_to_user((void __user *)arg +
> > -						sizeof(info), caps.buf,
> > -						caps.size)) {
> > -					kfree(caps.buf);
> > -					return -EFAULT;
> > -				}
> > -				info.cap_offset = sizeof(info);
> > +		if (info.argsz < sizeof(info) + caps.size) {
> > +			info.argsz = sizeof(info) + caps.size;
> > +		} else {
> > +			vfio_info_cap_shift(&caps, sizeof(info));
> > +			if (copy_to_user((void __user *)arg +
> > +					sizeof(info), caps.buf,
> > +					caps.size)) {
> > +				kfree(caps.buf);
> > +				return -EFAULT;
> >  			}
> > -
> > -			kfree(caps.buf);
> > +			info.cap_offset = sizeof(info);
> >  		}
> >
> > -		return copy_to_user((void __user *)arg, &info, minsz) ?
> > -			-EFAULT : 0;
> > +		kfree(caps.buf);
> > +	}
> >
> > -	} else if (cmd == VFIO_IOMMU_MAP_DMA) {
> > -		struct vfio_iommu_type1_dma_map map;
> > -		uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> > -				VFIO_DMA_MAP_FLAG_WRITE;
> > +	return copy_to_user((void __user *)arg, &info, minsz) ?
> > +			-EFAULT : 0;
> > +}
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> > +static int vfio_iommu_type1_map_dma(struct vfio_iommu *iommu,
> > +				    unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dma_map map;
> > +	unsigned long minsz;
> > +	uint32_t mask = VFIO_DMA_MAP_FLAG_READ |
> > +			VFIO_DMA_MAP_FLAG_WRITE;
> >
> > -		if (copy_from_user(&map, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dma_map, size);
> >
> > -		if (map.argsz < minsz || map.flags & ~mask)
> > -			return -EINVAL;
> > +	if (copy_from_user(&map, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		return vfio_dma_do_map(iommu, &map);
> > +	if (map.argsz < minsz || map.flags & ~mask)
> > +		return -EINVAL;
> >
> > -	} else if (cmd == VFIO_IOMMU_UNMAP_DMA) {
> > -		struct vfio_iommu_type1_dma_unmap unmap;
> > -		struct vfio_bitmap bitmap = { 0 };
> > -		int ret;
> > +	return vfio_dma_do_map(iommu, &map); }
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap,
> size);
> > +static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
> > +				      unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dma_unmap unmap;
> > +	struct vfio_bitmap bitmap = { 0 };
> > +	unsigned long minsz;
> > +	long ret;
> >
> > -		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> >
> > -		if (unmap.argsz < minsz ||
> > -		    unmap.flags &
> ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > -			return -EINVAL;
> > +	if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		if (unmap.flags &
> VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> > -			unsigned long pgshift;
> > +	if (unmap.argsz < minsz ||
> > +	    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > +		return -EINVAL;
> >
> > -			if (unmap.argsz < (minsz + sizeof(bitmap)))
> > -				return -EINVAL;
> > +	if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
> > +		unsigned long pgshift;
> >
> > -			if (copy_from_user(&bitmap,
> > -					   (void __user *)(arg + minsz),
> > -					   sizeof(bitmap)))
> > -				return -EFAULT;
> > +		if (unmap.argsz < (minsz + sizeof(bitmap)))
> > +			return -EINVAL;
> >
> > -			if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > -				return -EINVAL;
> > +		if (copy_from_user(&bitmap,
> > +				   (void __user *)(arg + minsz),
> > +				   sizeof(bitmap)))
> > +			return -EFAULT;
> >
> > -			pgshift = __ffs(bitmap.pgsize);
> > -			ret = verify_bitmap_size(unmap.size >> pgshift,
> > -						 bitmap.size);
> > -			if (ret)
> > -				return ret;
> > -		}
> > +		if (!access_ok((void __user *)bitmap.data, bitmap.size))
> > +			return -EINVAL;
> >
> > -		ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> > +		pgshift = __ffs(bitmap.pgsize);
> > +		ret = verify_bitmap_size(unmap.size >> pgshift,
> > +					 bitmap.size);
> >  		if (ret)
> >  			return ret;
> > +	}
> > +
> > +	ret = vfio_dma_do_unmap(iommu, &unmap, &bitmap);
> > +	if (ret)
> > +		return ret;
> >
> > -		return copy_to_user((void __user *)arg, &unmap, minsz) ?
> > +	return copy_to_user((void __user *)arg, &unmap, minsz) ?
> >  			-EFAULT : 0;
> > -	} else if (cmd == VFIO_IOMMU_DIRTY_PAGES) {
> > -		struct vfio_iommu_type1_dirty_bitmap dirty;
> > -		uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> > -				VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> > -
> 	VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> > -		int ret = 0;
> > +}
> >
> > -		if (!iommu->v2)
> > -			return -EACCES;
> > +static int vfio_iommu_type1_dirty_pages(struct vfio_iommu *iommu,
> > +					unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dirty_bitmap dirty;
> > +	uint32_t mask = VFIO_IOMMU_DIRTY_PAGES_FLAG_START |
> > +			VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP |
> > +			VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
> > +	unsigned long minsz;
> > +	int ret = 0;
> >
> > -		minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> > -				    flags);
> > +	if (!iommu->v2)
> > +		return -EACCES;
> >
> > -		if (copy_from_user(&dirty, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap,
> > +			    flags);
> >
> > -		if (dirty.argsz < minsz || dirty.flags & ~mask)
> > -			return -EINVAL;
> > +	if (copy_from_user(&dirty, (void __user *)arg, minsz))
> > +		return -EFAULT;
> > +
> > +	if (dirty.argsz < minsz || dirty.flags & ~mask)
> > +		return -EINVAL;
> > +
> > +	/* only one flag should be set at a time */
> > +	if (__ffs(dirty.flags) != __fls(dirty.flags))
> > +		return -EINVAL;
> > +
> > +	if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > +		size_t pgsize;
> >
> > -		/* only one flag should be set at a time */
> > -		if (__ffs(dirty.flags) != __fls(dirty.flags))
> > +		mutex_lock(&iommu->lock);
> > +		pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> > +		if (!iommu->dirty_page_tracking) {
> > +			ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> > +			if (!ret)
> > +				iommu->dirty_page_tracking = true;
> > +		}
> > +		mutex_unlock(&iommu->lock);
> > +		return ret;
> > +	} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> > +		mutex_lock(&iommu->lock);
> > +		if (iommu->dirty_page_tracking) {
> > +			iommu->dirty_page_tracking = false;
> > +			vfio_dma_bitmap_free_all(iommu);
> > +		}
> > +		mutex_unlock(&iommu->lock);
> > +		return 0;
> > +	} else if (dirty.flags &
> > +			 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> > +		struct vfio_iommu_type1_dirty_bitmap_get range;
> > +		unsigned long pgshift;
> > +		size_t data_size = dirty.argsz - minsz;
> > +		size_t iommu_pgsize;
> > +
> > +		if (!data_size || data_size < sizeof(range))
> >  			return -EINVAL;
> >
> > -		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > -			size_t pgsize;
> > +		if (copy_from_user(&range, (void __user *)(arg + minsz),
> > +				   sizeof(range)))
> > +			return -EFAULT;
> >
> > -			mutex_lock(&iommu->lock);
> > -			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> > -			if (!iommu->dirty_page_tracking) {
> > -				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> > -				if (!ret)
> > -					iommu->dirty_page_tracking = true;
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > +		if (range.iova + range.size < range.iova)
> > +			return -EINVAL;
> > +		if (!access_ok((void __user *)range.bitmap.data,
> > +			       range.bitmap.size))
> > +			return -EINVAL;
> > +
> > +		pgshift = __ffs(range.bitmap.pgsize);
> > +		ret = verify_bitmap_size(range.size >> pgshift,
> > +					 range.bitmap.size);
> > +		if (ret)
> >  			return ret;
> > -		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP)
> {
> > -			mutex_lock(&iommu->lock);
> > -			if (iommu->dirty_page_tracking) {
> > -				iommu->dirty_page_tracking = false;
> > -				vfio_dma_bitmap_free_all(iommu);
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > -			return 0;
> > -		} else if (dirty.flags &
> > -
> VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> > -			struct vfio_iommu_type1_dirty_bitmap_get range;
> > -			unsigned long pgshift;
> > -			size_t data_size = dirty.argsz - minsz;
> > -			size_t iommu_pgsize;
> > -
> > -			if (!data_size || data_size < sizeof(range))
> > -				return -EINVAL;
> > -
> > -			if (copy_from_user(&range, (void __user *)(arg + minsz),
> > -					   sizeof(range)))
> > -				return -EFAULT;
> >
> > -			if (range.iova + range.size < range.iova)
> > -				return -EINVAL;
> > -			if (!access_ok((void __user *)range.bitmap.data,
> > -				       range.bitmap.size))
> > -				return -EINVAL;
> > +		mutex_lock(&iommu->lock);
> >
> > -			pgshift = __ffs(range.bitmap.pgsize);
> > -			ret = verify_bitmap_size(range.size >> pgshift,
> > -						 range.bitmap.size);
> > -			if (ret)
> > -				return ret;
> > +		iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> >
> > -			mutex_lock(&iommu->lock);
> > +		/* allow only smallest supported pgsize */
> > +		if (range.bitmap.pgsize != iommu_pgsize) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +		if (range.iova & (iommu_pgsize - 1)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> > +		if (!range.size || range.size & (iommu_pgsize - 1)) {
> > +			ret = -EINVAL;
> > +			goto out_unlock;
> > +		}
> >
> > -			iommu_pgsize = (size_t)1 << __ffs(iommu-
> >pgsize_bitmap);
> > +		if (iommu->dirty_page_tracking)
> > +			ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > +					iommu, range.iova, range.size,
> > +					range.bitmap.pgsize);
> > +		else
> > +			ret = -EINVAL;
> > +out_unlock:
> > +		mutex_unlock(&iommu->lock);
> >
> > -			/* allow only smallest supported pgsize */
> > -			if (range.bitmap.pgsize != iommu_pgsize) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > -			if (range.iova & (iommu_pgsize - 1)) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > -			if (!range.size || range.size & (iommu_pgsize - 1)) {
> > -				ret = -EINVAL;
> > -				goto out_unlock;
> > -			}
> > +		return ret;
> > +	}
> >
> > -			if (iommu->dirty_page_tracking)
> > -				ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > -						iommu, range.iova, range.size,
> > -						range.bitmap.pgsize);
> > -			else
> > -				ret = -EINVAL;
> > -out_unlock:
> > -			mutex_unlock(&iommu->lock);
> > +	return -EINVAL;
> > +}
> >
> > -			return ret;
> > -		}
> > +static long vfio_iommu_type1_ioctl(void *iommu_data,
> > +				   unsigned int cmd, unsigned long arg) {
> > +	struct vfio_iommu *iommu = iommu_data;
> > +
> > +	switch (cmd) {
> > +	case VFIO_CHECK_EXTENSION:
> > +		return vfio_iommu_type1_check_extension(iommu, arg);
> > +	case VFIO_IOMMU_GET_INFO:
> > +		return vfio_iommu_type1_get_info(iommu, arg);
> > +	case VFIO_IOMMU_MAP_DMA:
> > +		return vfio_iommu_type1_map_dma(iommu, arg);
> > +	case VFIO_IOMMU_UNMAP_DMA:
> > +		return vfio_iommu_type1_unmap_dma(iommu, arg);
> > +	case VFIO_IOMMU_DIRTY_PAGES:
> > +		return vfio_iommu_type1_dirty_pages(iommu, arg);
> >  	}
> >
> >  	return -ENOTTY;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
