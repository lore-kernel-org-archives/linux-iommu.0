Return-Path: <SRS0=1bbG=JU=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14629C433B4
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:07:03 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6FAD761396
	for <iommu@archiver.kernel.org>; Fri, 23 Apr 2021 09:07:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FAD761396
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E6F3460AE3;
	Fri, 23 Apr 2021 09:07:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jsNvY4k9UY0I; Fri, 23 Apr 2021 09:07:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8FD47605F2;
	Fri, 23 Apr 2021 09:07:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 68B2DC000E;
	Fri, 23 Apr 2021 09:07:00 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BFC53C000B
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:06:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8977843BC
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:06:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0b1J4RPPVN7P for <iommu@lists.linux-foundation.org>;
 Fri, 23 Apr 2021 09:06:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A1EBE843AB
 for <iommu@lists.linux-foundation.org>; Fri, 23 Apr 2021 09:06:55 +0000 (UTC)
IronPort-SDR: bCHoXifsyusmGZU5J337KYBMAbqVuA5zBf8mwdmNzDRYpnrIbJbegajR6HJz2Y7Q0ZCDGo7IQR
 PZ5/RrE2YCFA==
X-IronPort-AV: E=McAfee;i="6200,9189,9962"; a="257346285"
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; d="scan'208";a="257346285"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Apr 2021 02:06:54 -0700
IronPort-SDR: c+yvmujciFt6g/xKocRTY9Jy7nPkPmiiqv7GAu2eTfV/6Hv5wWH2VVgYQtQMFAg2bDmNE2p9gl
 XvWJEjqvZXYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,245,1613462400"; d="scan'208";a="424181497"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
 by orsmga007.jf.intel.com with ESMTP; 23 Apr 2021 02:06:53 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Fri, 23 Apr 2021 02:06:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Fri, 23 Apr 2021 02:06:53 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Fri, 23 Apr 2021 02:06:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UO9RgjiMRhUe3dOdO8QovTXLIUMkcLx9CHlhb0UGQGQqqFwJMRo7YsrqE8S2fxSdcDoBPftAWQVI+OclzITPsMTlSrDKjxwnmHqzyI9lqyQPIGttYa07nU56+f19RuK+6B/QrOIlNqV+f//JozL4kWiWpheuKuaMSZIxcTF9YkUL+3zsTrg0bcGjpbsOf8oqM9S4oZX736sU0e/rdc/mLzpu2UvZ3DjBYFUW1UsiBspUid50sVt/Gw4S3rlQj032UvqLEdKgDHpyA+4clSQ7ffLv+rg2eLXTEzJxkX/jazyp73877my6pbvuagBsGIDa0VydaBeiMbq7+Q7SrA4HrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY/fsiSco6i483sTBPZUc1lvSlDhpfwkAWclbYetwIU=;
 b=WP1XECfe/rr4T4wu/lY1Inbnod8xvufqQm0ytZC71XZU+1XDAluA4EtQwVF/NPBGPtOUzmJzI60NBbxT2usWnm9hg9kuP5K3KTbsEd14OPWQfOENgGeWoH4qGhuz8o9GRm1uIYCthNwWBM8ZQMQKxp2l6/YsJa5keKd9uUQ7yg1pLIJmLgZ5l3i2R5rIwDji0v/WIMGgfU6dpWylu6i4Xulx+LBpZ57dFqYtckgyDCTF+AGoksz+ho4asHN9iUk85jhVf5cBuDJmEwp13UGVWZZohjuABq1hFIE+a+FNUZeMVV+8nilyGIHldrzsY52dT+mdr6BekHwLMLi/IwyjWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZY/fsiSco6i483sTBPZUc1lvSlDhpfwkAWclbYetwIU=;
 b=YcIzM+HCHEbybzrsmwXq6+AKyobvUYWj+NycfZlTiSWBoX7F0Yde0GVE1yKg2J2ugLr6/5XUGbIeeNNqYnF0kyuF48+qgZwytd9FnWwrap8IjmrxxWIvwUMBunPDDYshYma03UZBGaSqz+lVMbhq8NBZ4ABra5SRUlUaK3rzfIk=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB5043.namprd11.prod.outlook.com (2603:10b6:303:96::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.22; Fri, 23 Apr
 2021 09:06:45 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.4042.026; Fri, 23 Apr 2021
 09:06:45 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAACiXgIAAVBgAgAAaMwCAAAESAIAABy2AgAAgOYCAFdCAgIAAppUAgADsNgCAACqygIAHsmaAgAAzsYCAAAjdgIAAD/yAgAAcQgCAADqggIAAk6nQgABIUACAASsnkA==
Date: Fri, 23 Apr 2021 09:06:44 +0000
Message-ID: <MWHPR11MB1886E688D2128C98A1F240B18C459@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210415230732.GG1370958@nvidia.com>
 <20210416061258.325e762e@jacob-builder> <20210416094547.1774e1a3@redhat.com>
 <BN6PR11MB406854F56D18E1187A2C98ACC3479@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210421162307.GM1370958@nvidia.com> <20210421105451.56d3670a@redhat.com>
 <20210421175203.GN1370958@nvidia.com> <20210421133312.15307c44@redhat.com>
 <20210421230301.GP1370958@nvidia.com>
 <MWHPR11MB1886188698A6E20338196F788C469@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210422121020.GT1370958@nvidia.com>
In-Reply-To: <20210422121020.GT1370958@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b2384bf6-f38b-412e-b200-08d906371e70
x-ms-traffictypediagnostic: CO1PR11MB5043:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB5043FDAC0BD90BFB44CFD5EA8C459@CO1PR11MB5043.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zMo4hXnlLMaC7bdYgfg685gYUZla+0nxbt/34Ffn7U7+LhzsKhxurVGDdeSND8CpRi5wljxW7MWHzuyGwV97e1K6ePg2ScHmC8yU1Fqg1xiW+9xXjW25kcVTD84gZ6JH8l2E4sq03NxqGlN9N7il5QzfK6Q59YtJ2j48D4h1p3/nMGqVdGKN8osTCyo+lYpw0ieS+jllGhkdgwdOY2UX/4qXmvcqvi24mstomuj0NrtKSr4JCX3kbRBgePHbGINIjfIyfhNF4fHy/DTxD4Zva6wwAf+BEqyJM3kkCXsZhwyFZOJVG2GA+tbVySQlDjQg3oeLyzb44+poRj6Y5XCJH+kmyxXK/oDVWsXHzByWya5+r7ofYk94TcBlyixgwsp6eViFrT4/FS1YRJ1J9kYzDPZ8ccKy8zt0anOskdPgv/LNP5So1NCEp4xec8kIRWg22+C2+2V/JQWSDQHQ9iNtEov8J99MsYyiXoS5+9r8bXllv30nKiYhQjG/ezi3Hnkbty5VAMqAQi3AsPal2eazEd06pdbrh3GswtjNTZSN72z6FklT4pnczrmD58S5d3DQH6ZaQ3qBJ9j78lTUhE7HTxSCGUAR6/RNYw4+wGx1YvE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(136003)(39860400002)(396003)(346002)(376002)(7416002)(122000001)(6506007)(55016002)(9686003)(86362001)(2906002)(4326008)(66446008)(64756008)(71200400001)(7696005)(38100700002)(76116006)(6916009)(8676002)(66556008)(66476007)(66946007)(52536014)(8936002)(478600001)(54906003)(26005)(316002)(83380400001)(5660300002)(186003)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?X0H5G+k802zDFlMImClOAR2u+3Pti1tpisjU/bwPaiqitMjOirnE9rG8ColS?=
 =?us-ascii?Q?BvauLr7CynSGeu0PBelF3v1SpPwLKX8I114Hs3g855BmL69cbkHSohwXFGsT?=
 =?us-ascii?Q?wF1x9gWqownduKngMaar4TbVN7gUpq3wlpPWK1MHzyt0inxPtTIGG7dY4CQM?=
 =?us-ascii?Q?bOJ3x1pLDKATHwWQsliT1eqhUNlSw33gsmSrCMfPXwxT7SaVc+zFlWreMJ6u?=
 =?us-ascii?Q?e2LMdnyPyU5RmGj8cbtgka1oPP0jeRIR7oZqU3NTzZjx/Y13xc/eBfxt6k2M?=
 =?us-ascii?Q?hrvLVTkWrMLvxLPZ8WNCJ+tBKTjW6/R9ZCp+mYN15mV41c+Z1oiVjzSaBogu?=
 =?us-ascii?Q?QHzt/B3ztVfyy4U00vPoLskd0mfrlDj17BbbTmRoXJ74wtAoVgxDm2YDnFFi?=
 =?us-ascii?Q?RCJea/wxdhz6PE8CoDzHeJ2rlx2m1Sc54UfY247RBnFTYAEaJLINPCfz1/Cu?=
 =?us-ascii?Q?lCzUlpjvkdMAxn92J/KOgXKW6So39WRqgq3NJWXprAXjs8TymyH3s/bcfAzN?=
 =?us-ascii?Q?5kmlywlM1gcZkkSWTgTFmQJtJBdMMURmUm5UVFiIzoTBEP5aAJkIFzY/t5FI?=
 =?us-ascii?Q?TVXaStym+j/ydWPCWi8mI3xB4gigap8Xc4S9pwIHW7+WMNv7fZVr5LVY7HsV?=
 =?us-ascii?Q?mrSC+FNoRfEKWqyQdD1Whl3Lyspkz90XAyAGIrruHYMFp1hGwPb8SMCB5tfY?=
 =?us-ascii?Q?xHCv4a1hlmrOqvTI7FKbtkVBAkcWX+XsUIV46jAap78ZXlP/vzIiAijJETxG?=
 =?us-ascii?Q?/8zj5AN4eeyDxerl4PAtCA4OwlZQT1/wVpI5dMmMgl9AJX8FCCK8hBw+k2ma?=
 =?us-ascii?Q?C9IUYF63jXjB4OhtmuWO5Pw/eBCWaCPPdYSvqaBoNAsoUKGOSD9VE2/Tu/aO?=
 =?us-ascii?Q?Mo+A3iEKwbrelmWWPXcF/xpBKIUJaJSD/BFJOcMac4U7b0e+dC1Uw8Gd7Z1i?=
 =?us-ascii?Q?xWERA0Dd3IQ/jPxxDJIGPA5yfXfg83IYyEIeQTR1oR/K5D8e3/cQlmXlasKd?=
 =?us-ascii?Q?FqxQhCPx0p6/wx0wkw29qt3Ls8kWCES5htGcsx2VFwO6IxUEaw51VAw+DLXH?=
 =?us-ascii?Q?Q7PuJOEPLBt1HjvUuyZcbqY/u3kh5a3wDMh2BJ0gLoJsXrvOa2Rs6IIXlaaK?=
 =?us-ascii?Q?sBfVKtcYyb7r8PBedGX/1m9MYapmJXMyANX34paM2UvqA7V7/+zlfr4tq3HK?=
 =?us-ascii?Q?2PcVuPD/B1yQKTOjvHMXZTPv+TVF2vRyFvPfcugL3NxtgBrG5kBAwraval3m?=
 =?us-ascii?Q?pbPAC+pe1HMuQWQpZEn2PJdn2QTKqfEQ91Mz9FVYMZAjLZhDA5IR0htZE8wn?=
 =?us-ascii?Q?akwR1FEUIRsAScVT7Kh/YFXD?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2384bf6-f38b-412e-b200-08d906371e70
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 09:06:44.7758 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mvfxkedzbCixvtep2c+sc643tQGkqkD11bGWioBpmeDf8lpeD27C1fVzdkOv4qrDyhTiB0YvvlTh9jcqgKZk+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5043
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, "Jiang, Dave" <dave.jiang@intel.com>, "Raj,
 Ashok" <ashok.raj@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Johannes Weiner <hannes@cmpxchg.org>, Tejun Heo <tj@kernel.org>,
 "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>, "Wu, 
 Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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

> From: Jason Gunthorpe <jgg@nvidia.com>
> Sent: Thursday, April 22, 2021 8:10 PM
> 
> On Thu, Apr 22, 2021 at 08:34:32AM +0000, Tian, Kevin wrote:
> 
> > Another tricky thing is that a container may be linked to multiple iommu
> > domains in VFIO, as devices in the container may locate behind different
> > IOMMUs with inconsistent capability (commit 1ef3e2bc).
> 
> Frankly this sounds over complicated. I would think /dev/ioasid should
> select the IOMMU when the first device is joined, and all future joins
> must be compatible with the original IOMMU - ie there is only one set
> of IOMMU capabilities in a /dev/ioasid.

Or could we still have just one /dev/ioasid but allow userspace to create
multiple gpa_ioasid_id's each associated to a different iommu domain? 
Then the compatibility check will be done at ATTACH_IOASID instead of 
JOIN_IOASID_FD.

This does impose one burden to userspace though, to understand the 
IOMMU compatibilities and figure out which incompatible features may
affect the page table management (while such knowledge is IOMMU
vendor specific) and then explicitly manage multiple /dev/ioasid's or 
multiple gpa_ioasid_id's.

Alternatively is it a good design by having the kernel return error at 
attach/join time to indicate that incompatibility is detected then the 
userspace should open a new /dev/ioasid or creates a new gpa_ioasid_id
for the failing device upon such failure, w/o constructing its own 
compatibility knowledge?

> 
> This means qemue might have multiple /dev/ioasid's if the system has
> multiple incompatible IOMMUs (is this actually a thing?) The platform

One example is Intel platform with igd. Typically there is one IOMMU
dedicated for igd and the other IOMMU serving all the remaining devices.
The igd IOMMU may not support IOMMU_CACHE while the other one
does.

> should design its IOMMU domains to minimize the number of
> /dev/ioasid's required.
> 
> Is there a reason we need to share IOASID'd between completely
> divergance IOMMU implementations? I don't expect the HW should be able
> to physically share page tables??

yes, e.g. in vSVA both devices (behind divergence IOMMUs) are bound
to a single guest process which has an unique PASID and 1st-level page
table. Earlier incompatibility example is only for 2nd-level.

> 
> That decision point alone might be the thing that just says we can't
> ever have /dev/vfio/vfio == /dev/ioasid

yes, unless we adopt the vfio scheme, i.e. implicitly managing incompatible 
iommu domains in /dev/ioasid.

> 
> > Just to confirm. Above flow is for current map/unmap flavor as what
> > VFIO/vDPA do today. Later when nested translation is supported,
> > there is no need to detach gpa_ioasid_fd. Instead, a new cmd will
> > be introduced to nest rid_ioasid_fd on top of gpa_ioasid_fd:
> 
> Sure.. The tricky bit will be to define both of the common nested
> operating modes.
> 
>   nested_ioasid = ioctl(ioasid_fd, CREATE_NESTED_IOASID,  gpa_ioasid_id);
>   ioctl(ioasid_fd, SET_NESTED_IOASID_PAGE_TABLES, nested_ioasid, ..)
> 
>    // IOMMU will match on the device RID, no PASID:
>   ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);
> 
>    // IOMMU will match on the device RID and PASID:
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);

I'm a bit confused here why we have both pasid and ioasid notations together.
Why not use nested_ioasid as pasid directly (i.e. every pasid in nested mode
is created by CREATE_NESTED_IOASID)?

Below I list different scenarios for ATTACH_IOASID in my view. Here 
vfio_device could be a real PCI function (RID), or a subfunction device 
(RID+def_ioasid). The vfio_device could be attached to a gpa_ioasid 
(RID in guest view, no nesting), a nested_ioasid (RID in guest view, nesting) 
or a nested_ioasid (RID+PASID in guest view, nesting). 

// IOMMU will match on the device RID, no nesting, no PASID:
ioctl(vfio_device, ATTACH_IOASID, gpa_ioasid);

// IOMMU will match on the device (RID+def_ioasid), no nesting, no PASID:
ioctl(vfio_subdevice, ATTACH_IOASID, gpa_ioasid);

// IOMMU will match on the device RID, nesting, no PASID:
ioctl(vfio_device, ATTACH_IOASID, nested_ioasid);

// IOMMU will match on the device (RID+def_ioasid), nesting, no PASID:
ioctl(vfio_subdevice, ATTACH_IOASID, nested_ioasid);

// IOMMU will match on the device (RID+nested_ioasid), nesting, PASID:
ioctl(vfio_device, ATTACH_IOASID_PASID, nested_ioasid);

// IOMMU will match on the device (RID+nested_ioasid), nesting, PASID:
ioctl(vfio_subdevice, ATTACH_IOASID_PASID, nested_ioasid);

> 
> Notice that ATTACH (or bind, whatever) is always done on the
> vfio_device FD. ATTACH tells the IOMMU HW to link the PCI BDF&PASID to
> a specific page table defined by an IOASID.
> 
> I expect we have many flavours of IOASID tables, eg we have normal,
> and 'nested with table controlled by hypervisor'. ARM has 'nested with
> table controlled by guest' right? So like this?
> 
>   nested_ioasid = ioctl(ioasid_fd, CREATE_DELGATED_IOASID,
>                    gpa_ioasid_id, <some kind of viommu_id>)
>   // PASID now goes to <viommu_id>
>   ioctl(vfio_device, ATTACH_IOASID_PASID, pasid, nested_ioasid);
> 
> Where <viommu_id> is some internal to the guest handle of the viommu
> page table scoped within gpa_ioasid_id? Like maybe it is GPA of the
> base of the page table?
> 
> The guest can't select its own PASIDs without telling the hypervisor,
> right?
> 

If the whole PASID table is delegated to the guest in ARM case, the guest
can select its own PASIDs w/o telling the hypervisor. I haven't thought
carefully about a clean way to support this scheme, e.g. if mandating 
guest to always allocate PASIDs through hypervisor even in this case
would it make the uAPI simpler...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
