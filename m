Return-Path: <SRS0=LOQj=BI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8F5AC433E0
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 02:20:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92B452070B
	for <iommu@archiver.kernel.org>; Wed, 29 Jul 2020 02:20:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="r9jqgMT8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92B452070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 598F12047A;
	Wed, 29 Jul 2020 02:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DI8qMCWwrkrK; Wed, 29 Jul 2020 02:20:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 933B42044A;
	Wed, 29 Jul 2020 02:20:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EFF4C0050;
	Wed, 29 Jul 2020 02:20:54 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD2D7C004D
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 02:20:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id A29E3859F4
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 02:20:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wdUoFPee8AAi for <iommu@lists.linux-foundation.org>;
 Wed, 29 Jul 2020 02:20:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 2C37D858D3
 for <iommu@lists.linux-foundation.org>; Wed, 29 Jul 2020 02:20:52 +0000 (UTC)
IronPort-SDR: hWhHfETKimf/TWaWUI33nrtzR+P2698/DvAPq5nHYy8ImdHfo8iJb0AZypme6xxBwZshetePxd
 1n+ohhIa1AKA==
X-IronPort-AV: E=McAfee;i="6000,8403,9696"; a="215851471"
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="215851471"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jul 2020 19:20:51 -0700
IronPort-SDR: Dy1b5AnQgHy2z42HNq8ZQqxuGMvxIvAfYofj/mX7piStqoo1dU0OlGGxpylfUqa9Z+6CjwgWab
 LltSXK/XkmIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,408,1589266800"; d="scan'208";a="394527816"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga001.fm.intel.com with ESMTP; 28 Jul 2020 19:20:50 -0700
Received: from orsmsx605.amr.corp.intel.com (10.22.229.18) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 28 Jul 2020 19:20:50 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 orsmsx605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 28 Jul 2020 19:20:50 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 28 Jul 2020 19:20:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RE9iB1FLGdTh1GT5p+L1sdeiXN1oCG81SoTKtmqQCpC7RduoXA6QKCsYdNZcKmgCXoXljrbddtE1QZC0UngHCzXeoEZV4xPOurGREgXZmcdshXj/cjDm+lTYKNAEPf7GF3EDiPX9yXbPG5E2wMrN4brOeKGYaMSkrRbej6iqOAAM/S0ebLYwyXmad4JmnWJwq6Rd15eebVbGznFu9FjZIQSoXHaHwegVThyR7rA/UosP54XdDjvTW5RmRs9OJJguCizhFAwr3xiqiT3wTFRG3kiQBzQC6uBAbvr7c2QlMYkt3PbMQsny94kQRpUwTWJk64HtReVg1av26Q8xs+UELQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ln4JpQBeC4lK6b7k46477WuYrp0RaCxvVaO/fxQoi4=;
 b=bt1IS0xrbZvGY1R9z1U7zP2hn+NaTpu2tlN/mbs66FD4fe+B9DBJbMro1SUhIWSI5dU71xpbPQZcYeU667oEL3YGc57EBSMxrC/SV2dEx6/3PMGtO4/GyDTRDdyYSSXOpuGNoJkkTHovZnaCJSq6LueEOQ7xViu2NKV/6Zg6zMvFM/0PnyUOZS11dg+CPMlg10vHLJPUJLoGKnBEguMxaBeRwpkImRcoey6NlG13mLcyVx9p1EiOBvicZh1udJZrXPW20eRwY9g9uhzLOyTQHJEh4drxkSOdR34COcfJ8mUsJ+WovGXRtLMUxC8w+imh80ReHFw7E1SrZOXKmUk+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ln4JpQBeC4lK6b7k46477WuYrp0RaCxvVaO/fxQoi4=;
 b=r9jqgMT8ZzYbHrMQUkAZOB2O3grfI3zgLlMTNfonDQ3O8Kl04rLGaS9AN6TOjMgyT4ehc8qpZtcy5ksj+IvCCtVclhU27GvB2p094NO0B1H+x4IVLNGiAHIMSL5m1HAeVolev4BHXAgT7w8U3Y9fn3nywI/g75EukMDv9IWXmTg=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM5PR11MB1578.namprd11.prod.outlook.com (2603:10b6:4:e::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.16; Wed, 29 Jul 2020 02:20:46 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::9002:97a2:d8c0:8364%10]) with mapi id 15.20.3216.034; Wed, 29 Jul
 2020 02:20:46 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [PATCH v6 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Topic: [PATCH v6 01/15] vfio/type1: Refactor vfio_iommu_type1_ioctl()
Thread-Index: AQHWZKdEWZVxoE+wrUCHRmL6h48nIKkdJTIAgACvF0A=
Date: Wed, 29 Jul 2020 02:20:46 +0000
Message-ID: <DM5PR11MB14352FE9C017BC763181723CC3700@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <1595917664-33276-1-git-send-email-yi.l.liu@intel.com>
 <1595917664-33276-2-git-send-email-yi.l.liu@intel.com>
 <20200728095336.50cd04af@x1.home>
In-Reply-To: <20200728095336.50cd04af@x1.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [117.169.229.51]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3050578c-7a9e-440b-8059-08d8336600eb
x-ms-traffictypediagnostic: DM5PR11MB1578:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB157889CEB90A9CDF03762FCAC3700@DM5PR11MB1578.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:134;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6cpQk0FKzzEyt/63x4345QiYfBUhvU7cGTVmYFt5Jn8lxjKPPqDfnltKWaiJch3YV1ATPQIuB2UMU/TzLWkW96ykHEXx+dRn7nSW3N/yPdU2ncn47MO7+oG0Cla0/Mazqiv4raMrjul2yyU4SM9C9ovXYzCrfgv2acopV5PXPlayvYhJr7dpuhtLqFuDlskpPfhesC21AvAgfPEpUDsu2s3zGKpthb9+IePDqKvXT4irSCCzDq9RuijUhyfQ99OwBPudCXTECcm8TmFjap0/SAvGj8dr8AX8PyxrXdT2UA3GmyFGreMcqve7yUXfNdd6sGeN9xsLJ0caHK1wciJARw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(54906003)(186003)(30864003)(71200400001)(55016002)(9686003)(86362001)(478600001)(7416002)(5660300002)(66446008)(64756008)(316002)(83380400001)(66556008)(66476007)(66946007)(52536014)(8676002)(4326008)(76116006)(7696005)(33656002)(6506007)(6916009)(2906002)(8936002)(26005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: L0ZyveJ6EwMHKZ5W5sEtlHIJOatrIVvx+bz0kxXG7WUSnGQzuqegHdc1OE400dYNHOiILBJwvn8PbHLim/T06IbqH5Eu+H1JjD/pT2PYqKPIwrzVktERzDytxa4MimDu4ohVMbgqzp6/fxNKf4VGqdYflTp1FKVHaDbmeSBPStD7keT+xGkhUlBTifBSmrBdA4oCczwQPsyE/zR95SVSwXki4URNjDhDOkRfkxd6z92WQUUV0Ja7mRZbxUqVWwe+0/XrV8F+NChFET/iQcqaaa0zxAmtO8rroZ7ePmtP2wlUeZwstdYrAAlgzxfLbVRPLBbKIkFx6dR7zffrNmEiborEOuZBHmnoZH84mSKotYUFtSWA/2sh1S8z83GMW8pNY4DJ8m2wrr7e4pLLxafOt6Vqk5MvDTlG0hMfRiJTy8iJQLZ+rJ1tdojLNvPPEWPfab3WxTGVN6xJIFrVccGr5lhbaXAN9fXk0tsxMsYxxSo9T5z8zOfY/lOV5z8ED4uX38nLQEK13SkBigp+zG+xhqzPETOSULRq5XUP+cTKoHOugKEG9CDFw9txTkEmlLJmReQspwdFes/KVMc00ugSR8iwcgYgNy0DUTKFO7/XTQPBCtDElL+UWRBRJ1fsayt/uNz6pisVk7+MV7UXB3Sgkg==
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3050578c-7a9e-440b-8059-08d8336600eb
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2020 02:20:46.6550 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Hy9ogemc1i+dgXKUU1w7ZHxEMpELqTFvetQm6RcZaag9nMSPufWYx+NT92QRN++xkVI1zcaqPVMnNITO+LmuWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1578
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "stefanha@gmail.com" <stefanha@gmail.com>,
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
> Sent: Tuesday, July 28, 2020 11:54 PM
> 
> On Mon, 27 Jul 2020 23:27:30 -0700
> Liu Yi L <yi.l.liu@intel.com> wrote:
> 
> > This patch refactors the vfio_iommu_type1_ioctl() to use switch
> > instead of if-else, and each command got a helper function.
> >
> > Cc: Kevin Tian <kevin.tian@intel.com>
> > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > Cc: Alex Williamson <alex.williamson@redhat.com>
> > Cc: Eric Auger <eric.auger@redhat.com>
> > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > Cc: Joerg Roedel <joro@8bytes.org>
> > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > Reviewed-by: Eric Auger <eric.auger@redhat.com>
> > Suggested-by: Christoph Hellwig <hch@infradead.org>
> > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > ---
> 
> FYI, this commit is already in my next branch and linux-next as of today, you can
> drop it from future series.  Thanks,

got it. thanks. :-)

Regards,
Yi Liu

> Alex
> 
> > v4 -> v5:
> > *) address comments from Eric Auger, add r-b from Eric.
> > ---
> >  drivers/vfio/vfio_iommu_type1.c | 394
> > ++++++++++++++++++++++------------------
> >  1 file changed, 213 insertions(+), 181 deletions(-)
> >
> > diff --git a/drivers/vfio/vfio_iommu_type1.c
> > b/drivers/vfio/vfio_iommu_type1.c index 5e556ac..3bd70ff 100644
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
> > @@ -2529,241 +2546,256 @@ static int vfio_iommu_migration_build_caps(struct
> vfio_iommu *iommu,
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
> > -		minsz = offsetofend(struct vfio_iommu_type1_info, iova_pgsizes);
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
> VFIO_DMA_MAP_FLAG_WRITE;
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
> > -		minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> > +static int vfio_iommu_type1_unmap_dma(struct vfio_iommu *iommu,
> > +				      unsigned long arg)
> > +{
> > +	struct vfio_iommu_type1_dma_unmap unmap;
> > +	struct vfio_bitmap bitmap = { 0 };
> > +	unsigned long minsz;
> > +	int ret;
> >
> > -		if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > -			return -EFAULT;
> > +	minsz = offsetofend(struct vfio_iommu_type1_dma_unmap, size);
> >
> > -		if (unmap.argsz < minsz ||
> > -		    unmap.flags & ~VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP)
> > -			return -EINVAL;
> > +	if (copy_from_user(&unmap, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		if (unmap.flags & VFIO_DMA_UNMAP_FLAG_GET_DIRTY_BITMAP) {
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
> > -				VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP;
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
> > +	minsz = offsetofend(struct vfio_iommu_type1_dirty_bitmap, flags);
> >
> > -		if (dirty.argsz < minsz || dirty.flags & ~mask)
> > -			return -EINVAL;
> > +	if (copy_from_user(&dirty, (void __user *)arg, minsz))
> > +		return -EFAULT;
> >
> > -		/* only one flag should be set at a time */
> > -		if (__ffs(dirty.flags) != __fls(dirty.flags))
> > -			return -EINVAL;
> > +	if (dirty.argsz < minsz || dirty.flags & ~mask)
> > +		return -EINVAL;
> >
> > -		if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > -			size_t pgsize;
> > +	/* only one flag should be set at a time */
> > +	if (__ffs(dirty.flags) != __fls(dirty.flags))
> > +		return -EINVAL;
> >
> > -			mutex_lock(&iommu->lock);
> > -			pgsize = 1 << __ffs(iommu->pgsize_bitmap);
> > -			if (!iommu->dirty_page_tracking) {
> > -				ret = vfio_dma_bitmap_alloc_all(iommu, pgsize);
> > -				if (!ret)
> > -					iommu->dirty_page_tracking = true;
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > -			return ret;
> > -		} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_STOP) {
> > -			mutex_lock(&iommu->lock);
> > -			if (iommu->dirty_page_tracking) {
> > -				iommu->dirty_page_tracking = false;
> > -				vfio_dma_bitmap_free_all(iommu);
> > -			}
> > -			mutex_unlock(&iommu->lock);
> > -			return 0;
> > -		} else if (dirty.flags &
> > -				 VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP)
> {
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
> > +	if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_START) {
> > +		size_t pgsize;
> >
> > -			if (range.iova + range.size < range.iova)
> > -				return -EINVAL;
> > -			if (!access_ok((void __user *)range.bitmap.data,
> > -				       range.bitmap.size))
> > -				return -EINVAL;
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
> > +	} else if (dirty.flags & VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP) {
> > +		struct vfio_iommu_type1_dirty_bitmap_get range;
> > +		unsigned long pgshift;
> > +		size_t data_size = dirty.argsz - minsz;
> > +		size_t iommu_pgsize;
> >
> > -			pgshift = __ffs(range.bitmap.pgsize);
> > -			ret = verify_bitmap_size(range.size >> pgshift,
> > -						 range.bitmap.size);
> > -			if (ret)
> > -				return ret;
> > +		if (!data_size || data_size < sizeof(range))
> > +			return -EINVAL;
> >
> > -			mutex_lock(&iommu->lock);
> > +		if (copy_from_user(&range, (void __user *)(arg + minsz),
> > +				   sizeof(range)))
> > +			return -EFAULT;
> >
> > -			iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> > +		if (range.iova + range.size < range.iova)
> > +			return -EINVAL;
> > +		if (!access_ok((void __user *)range.bitmap.data,
> > +			       range.bitmap.size))
> > +			return -EINVAL;
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
> > +		pgshift = __ffs(range.bitmap.pgsize);
> > +		ret = verify_bitmap_size(range.size >> pgshift,
> > +					 range.bitmap.size);
> > +		if (ret)
> > +			return ret;
> >
> > -			if (iommu->dirty_page_tracking)
> > -				ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > -						iommu, range.iova, range.size,
> > -						range.bitmap.pgsize);
> > -			else
> > -				ret = -EINVAL;
> > -out_unlock:
> > -			mutex_unlock(&iommu->lock);
> > +		mutex_lock(&iommu->lock);
> >
> > -			return ret;
> > +		iommu_pgsize = (size_t)1 << __ffs(iommu->pgsize_bitmap);
> > +
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
> >  		}
> > +
> > +		if (iommu->dirty_page_tracking)
> > +			ret = vfio_iova_dirty_bitmap(range.bitmap.data,
> > +						     iommu, range.iova,
> > +						     range.size,
> > +						     range.bitmap.pgsize);
> > +		else
> > +			ret = -EINVAL;
> > +out_unlock:
> > +		mutex_unlock(&iommu->lock);
> > +
> > +		return ret;
> >  	}
> >
> > -	return -ENOTTY;
> > +	return -EINVAL;
> > +}
> > +
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
> > +	default:
> > +		return -ENOTTY;
> > +	}
> >  }
> >
> >  static int vfio_iommu_type1_register_notifier(void *iommu_data,

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
