Return-Path: <SRS0=8EFN=74=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD847C433E0
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 01:22:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4981920775
	for <iommu@archiver.kernel.org>; Mon, 15 Jun 2020 01:22:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=intel.onmicrosoft.com header.i=@intel.onmicrosoft.com header.b="RFXWwBpM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4981920775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id EAFAE23756;
	Mon, 15 Jun 2020 01:22:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rQ+jrBG-u9X; Mon, 15 Jun 2020 01:22:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 01209235A6;
	Mon, 15 Jun 2020 01:22:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D8589C0888;
	Mon, 15 Jun 2020 01:22:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3ACCCC016E
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 01:22:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 2372E87CB8
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 01:22:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZpluKwFymARR for <iommu@lists.linux-foundation.org>;
 Mon, 15 Jun 2020 01:22:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 17D6C87CB6
 for <iommu@lists.linux-foundation.org>; Mon, 15 Jun 2020 01:22:40 +0000 (UTC)
IronPort-SDR: u3GvAtl9rpFJA6bGdWD3rSfCNOGU3srNXxfMo1wZ24EZ58VMN7utPiLlw0sd2F2gH1hnhKnf0i
 oG7lWKBmhiXg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jun 2020 18:22:39 -0700
IronPort-SDR: bFlKrqjbPMpRTl7bvdE6TFGkjs8imNNvfsOsuuOQvMxGcAZ6cYDakfQcWnf2Gmf82iUtPPNQjY
 pYaISxKME4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,513,1583222400"; d="scan'208";a="475752402"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
 by fmsmga006.fm.intel.com with ESMTP; 14 Jun 2020 18:22:38 -0700
Received: from orsmsx121.amr.corp.intel.com (10.22.225.226) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 18:22:38 -0700
Received: from ORSEDG002.ED.cps.intel.com (10.7.248.5) by
 ORSMSX121.amr.corp.intel.com (10.22.225.226) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Sun, 14 Jun 2020 18:22:38 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.101) with Microsoft SMTP Server
 (TLS) id 14.3.439.0; Sun, 14 Jun 2020 18:22:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/CE2G6MPmGIYqCdfwS09WivnRtDhtgWMa2ek8Zf2/4n/MoRRxYEkyuqnyPXNYs8YOVxgqpTpsf8dEeYGZAMGQyuf5noj9soBVFJynxyFwyDm7NtLOIpVQQdzozajgRb6CXkmFYpDi5mX+m2n7/TwBq0N4v6HxFpz1wydFiRdPq9ViaLwoiXgfwzjyenjR998Ra1kEoqJwySXcaib0/Hz+hfXmwNX+DE6rVXToLoQP9GEgj/w9/VCXfMsa7G7jFCZui0q1coZrfSKycL0urQUP69cHvcffFsQWy3Cil5xr7w9DitO1JAok76U06CENVth01zr0nr67dpfYda7LCJVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDqVpS3Nj6/ifapz+1rwuenn3o19rtH5Qa9qqmcSSVE=;
 b=oK4tfaASJf0LHJxdvAcxX2OBs2VPkDfXJHX4D6RfEk3ue1fyjeMzV1KwSQKNMf0kYkwm2UZuF1JSNa1UVI4eTj0AGWX6Y5eTPy9HUwVIpu/G4Ks1cSeuZiRdnxOejCPvPUdv6GMqgwqN2ee9FC20sCFnPng0QG5EsvTLgc6uS4AFjXyMqrHZnj5mFf4DBCECloRc9bPh0+44uzb9KLIXbjOKQRdCrFmXBcyV4kqGSx8q3LzYh9tKFvreZRRvTCwaeB0Wek+FQHvKKEygoyWmPuXOVG/T43Z9iIlj4Pm95t/UbcuMF/O0CKmUsLmaCXcWWmq3qngBuHG8cZVrF0Ee7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DDqVpS3Nj6/ifapz+1rwuenn3o19rtH5Qa9qqmcSSVE=;
 b=RFXWwBpMdEqeIq7ZRawMkEme80MdObwxcJpNKk+wxzTTVDJuiPIW+lt8BIQfnhqfP21KrJPpRpG8snMkY8vix7rP3YvV8cW+0jGys4KPZUI5x93nFyDF8Xdf4uaqermKsapheRMoDtFpo9j25MN1N9x+Dwnsgycr4UgrEG29YWs=
Received: from MWHPR11MB1645.namprd11.prod.outlook.com (2603:10b6:301:b::12)
 by MWHPR11MB0014.namprd11.prod.outlook.com (2603:10b6:301:64::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.18; Mon, 15 Jun
 2020 01:22:37 +0000
Received: from MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb]) by MWHPR11MB1645.namprd11.prod.outlook.com
 ([fe80::9864:e0cb:af36:6feb%5]) with mapi id 15.20.3088.028; Mon, 15 Jun 2020
 01:22:37 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Topic: [PATCH v2 02/15] iommu: Report domain nesting info
Thread-Index: AQHWP+lAh6LCFwZsRk6rW47Mu2S6h6jTzaSAgADjv4CABDOwQA==
Date: Mon, 15 Jun 2020 01:22:37 +0000
Message-ID: <MWHPR11MB1645A7EBC706AC8A075EA83D8C9C0@MWHPR11MB1645.namprd11.prod.outlook.com>
References: <1591877734-66527-1-git-send-email-yi.l.liu@intel.com>
 <1591877734-66527-3-git-send-email-yi.l.liu@intel.com>
 <20200611133015.1418097f@x1.home>
 <DM5PR11MB143571773B05359FA2F46FB6C3810@DM5PR11MB1435.namprd11.prod.outlook.com>
In-Reply-To: <DM5PR11MB143571773B05359FA2F46FB6C3810@DM5PR11MB1435.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.2.0.6
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.52.196]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82000480-8ea1-4b14-7ead-08d810ca96c4
x-ms-traffictypediagnostic: MWHPR11MB0014:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB00144B4FF1CE823424E1F1488C9C0@MWHPR11MB0014.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 04359FAD81
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0LUNhG/PL3pbutkPYb2kPwV6+0JuP2vA5vK3v9KRM7VmtGOg4GxlUsRVOoruuIzrqN4UZ0AKkXe3kVXaDInhAqhXlkCdck4tWNV5onYK7iW1376aqpwORCffy0759xVoLFf2Zc/7D02tP03hSA0zAUWbmUC+XgV5Y2XN1ElPoFivwkMFEFi1HKgZpXZcjxcx5dY0/rs1lPla2jkvfig75oaTDgU+wWAgEJ9Afr5hlTDW/SV9gYMV35sqQbRMy66dGgPIsGArKy7CM7LQN/ArEbNtnJ4H9Agz+HqAIJ+vr2jFCubaj8ozBUl37leZsSI3VShGnDj5ielE/9gGIYggsw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1645.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(396003)(136003)(366004)(39860400002)(376002)(346002)(66946007)(33656002)(71200400001)(66556008)(64756008)(52536014)(66476007)(66446008)(76116006)(6506007)(8676002)(86362001)(478600001)(7696005)(186003)(8936002)(5660300002)(110136005)(54906003)(316002)(2906002)(26005)(9686003)(4326008)(7416002)(55016002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: dLqypIN2zn3cmuK9rT1twCa5/InKnha1h+vnNBAIgUpDh9vxXENcwQUVYon27rdipjl4AyzowoiOexqtjRmf9+V/xVdpyoAsuQQryGQGF1+GGtTW+E/aG2AClTOj+Rdnxgg25iIfI207+Ey4d1VxKJ595Fuqerzkp5BR/tNvvxwF06BS2/xhO2PIv8ysGDT796wcn4qbDUyB+aIXAaFyabJcK3kHVXR5fWDU5z57pqwEx2GDNVhVEt36zPaF/MRTOEUvtX2KKiueU7RatgTItebG/y1Qyh07fn6L+C8jHzAeh0a4h+o7gc0g6cTWvvY+kTmzy0xa/Y3DDxQBgiSPPekv1PjdxGBtlQonNYQcoPyKeJ7LRhW5kzBWxhf76m/kRLenQXoIb5Lnw2YuBMFQWrmYLwCeC0s1LaOI9jLm5Dd9Et9UCfqCTjCtXLp5U1pvX5CDQZ9kjVrv5CeDTiwkOR/MqN1ZvpIAb+THfobuJ5U=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 82000480-8ea1-4b14-7ead-08d810ca96c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2020 01:22:37.0483 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vFMDjdpZxwijQ/eSzCgnOc2VgXwMjxBFo3L7Ftczk7pjF20NSCqRiYU64w/kykTWENk4okRSHgIxKspqQgMczA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB0014
X-OriginatorOrg: intel.com
Cc: "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Raj,
 Ashok" <ashok.raj@intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
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

> From: Liu, Yi L <yi.l.liu@intel.com>
> Sent: Friday, June 12, 2020 5:05 PM
> 
> Hi Alex,
> 
> > From: Alex Williamson <alex.williamson@redhat.com>
> > Sent: Friday, June 12, 2020 3:30 AM
> >
> > On Thu, 11 Jun 2020 05:15:21 -0700
> > Liu Yi L <yi.l.liu@intel.com> wrote:
> >
> > > IOMMUs that support nesting translation needs report the capability
> > > info to userspace, e.g. the format of first level/stage paging structures.
> > >
> > > Cc: Kevin Tian <kevin.tian@intel.com>
> > > CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > Cc: Alex Williamson <alex.williamson@redhat.com>
> > > Cc: Eric Auger <eric.auger@redhat.com>
> > > Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > > Cc: Joerg Roedel <joro@8bytes.org>
> > > Cc: Lu Baolu <baolu.lu@linux.intel.com>
> > > Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> > > Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> > > ---
> > > @Jean, Eric: as nesting was introduced for ARM, but looks like no
> > > actual user of it. right? So I'm wondering if we can reuse
> > > DOMAIN_ATTR_NESTING to retrieve nesting info? how about your
> opinions?
> > >
> > >  include/linux/iommu.h      |  1 +
> > >  include/uapi/linux/iommu.h | 34
> ++++++++++++++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >
> > > diff --git a/include/linux/iommu.h b/include/linux/iommu.h index
> > > 78a26ae..f6e4b49 100644
> > > --- a/include/linux/iommu.h
> > > +++ b/include/linux/iommu.h
> > > @@ -126,6 +126,7 @@ enum iommu_attr {
> > >  	DOMAIN_ATTR_FSL_PAMUV1,
> > >  	DOMAIN_ATTR_NESTING,	/* two stages of translation */
> > >  	DOMAIN_ATTR_DMA_USE_FLUSH_QUEUE,
> > > +	DOMAIN_ATTR_NESTING_INFO,
> > >  	DOMAIN_ATTR_MAX,
> > >  };
> > >
> > > diff --git a/include/uapi/linux/iommu.h b/include/uapi/linux/iommu.h
> > > index 303f148..02eac73 100644
> > > --- a/include/uapi/linux/iommu.h
> > > +++ b/include/uapi/linux/iommu.h
> > > @@ -332,4 +332,38 @@ struct iommu_gpasid_bind_data {
> > >  	};
> > >  };
> > >
> > > +struct iommu_nesting_info {
> > > +	__u32	size;
> > > +	__u32	format;
> > > +	__u32	features;
> > > +#define IOMMU_NESTING_FEAT_SYSWIDE_PASID	(1 << 0)
> > > +#define IOMMU_NESTING_FEAT_BIND_PGTBL		(1 << 1)
> > > +#define IOMMU_NESTING_FEAT_CACHE_INVLD		(1 << 2)
> > > +	__u32	flags;
> > > +	__u8	data[];
> > > +};
> > > +
> > > +/*
> > > + * @flags:	VT-d specific flags. Currently reserved for future
> > > + *		extension.
> > > + * @addr_width:	The output addr width of first level/stage translation
> > > + * @pasid_bits:	Maximum supported PASID bits, 0 represents no
> PASID
> > > + *		support.
> > > + * @cap_reg:	Describe basic capabilities as defined in VT-d
> capability
> > > + *		register.
> > > + * @cap_mask:	Mark valid capability bits in @cap_reg.
> > > + * @ecap_reg:	Describe the extended capabilities as defined in VT-d
> > > + *		extended capability register.
> > > + * @ecap_mask:	Mark the valid capability bits in @ecap_reg.
> >
> > Please explain this a little further, why do we need to tell userspace about
> > cap/ecap register bits that aren't valid through this interface?
> > Thanks,
> 
> we only want to tell userspace about the bits marked in the cap/ecap_mask.
> cap/ecap_mask is kind of white-list of the cap/ecap register. userspace
> should
> only care about the bits in the white-list, for other bits, it should ignore.
> 
> Regards,
> Yi Liu

For invalid bits if kernel just clears them then do we still need additional
mask bits to explicitly mark them out? I guess this might be the point that 
Alex asked...

> 
> > Alex
> >
> >
> > > + */
> > > +struct iommu_nesting_info_vtd {
> > > +	__u32	flags;
> > > +	__u16	addr_width;
> > > +	__u16	pasid_bits;
> > > +	__u64	cap_reg;
> > > +	__u64	cap_mask;
> > > +	__u64	ecap_reg;
> > > +	__u64	ecap_mask;
> > > +};
> > > +
> > >  #endif /* _UAPI_IOMMU_H */

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
