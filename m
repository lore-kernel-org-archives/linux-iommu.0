Return-Path: <SRS0=H7Zn=I4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D175DC433C1
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:37:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05F5761601
	for <iommu@archiver.kernel.org>; Tue, 30 Mar 2021 01:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05F5761601
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A55B840420;
	Tue, 30 Mar 2021 01:37:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6npLNI_oTBcr; Tue, 30 Mar 2021 01:37:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id F299440342;
	Tue, 30 Mar 2021 01:37:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3550C000B;
	Tue, 30 Mar 2021 01:37:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8E014C000A
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:37:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E24440345
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:37:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ht8bvLJq-Nk1 for <iommu@lists.linux-foundation.org>;
 Tue, 30 Mar 2021 01:37:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D3BC640342
 for <iommu@lists.linux-foundation.org>; Tue, 30 Mar 2021 01:37:11 +0000 (UTC)
IronPort-SDR: 8WE6A89Jjit+TfEEIXJTLFFoDvDzQegb7sGgQN36rnYgmyaiwTiW9LU5K+XlW2yJM460ho1nnh
 Sf1a9c9AktiA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="253003760"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="253003760"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Mar 2021 18:37:10 -0700
IronPort-SDR: DAq3BOq63HR36KpRxjjD/Tskz1GtEd0jOFtS4u809OyrahHovcPE45wck/WBrvsWG2MVMHm/WA
 b7CqysoCVR3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; d="scan'208";a="411366567"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by fmsmga008.fm.intel.com with ESMTP; 29 Mar 2021 18:37:09 -0700
Received: from orsmsx609.amr.corp.intel.com (10.22.229.22) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:09 -0700
Received: from orsmsx606.amr.corp.intel.com (10.22.229.19) by
 ORSMSX609.amr.corp.intel.com (10.22.229.22) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:09 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 29 Mar 2021 18:37:09 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.172)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 29 Mar 2021 18:37:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I3jSQOJD2AELzzxgA5gb/khIUvevxAlcDSNe2W346WPzXB/njVKH4X/0P1qQj0akR7gHataNmIAp7ELQLTZxgVLvWV7OXD1oaw4UMCfco9ZJ8M260L0QzwjC026UFH6GR9nhMtz+f/q+aaVY+ecNv8RsojP/NjI16X4D81Ia1hLb/hdCM4D2zMJ+GLP0HE2gkpO2mZ8vge9tejNhJeeX5saNplC7BtuLUzgtXDNcwhbq2mDRqJ3maPhI0Ytu8rdnwpjrCngp/v5/ntkodT1p8E7FuMuyxOiXIBeP/zOWzORKrf8qinbT8abKbxgmiaExKj8WLNx1xMANvV3ch2EDiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkHWlLZVWbmowEFXz5ft+/3LXDayE8Wc7U1U+7L7cI=;
 b=mA0Oz6UvmcAlKOjZyMI2KE3UIdqS5G9r+QroGGkJhz9jxPQM3CltgnT6SvTvaokfDvl0aBFJjVZmMXep0QtN5yawEqm3R/KjHlbNpJcQTHq8lh4IOmaud3cTScOf3sq+SsvmrLc+tbAlGkFJqYrpbSyc7H5I1TgR5wgqphukKPXOe2+m7s9g9bZ4VJvW/0OhbroUjTMSDqWU/3B6gW3UmXjEGshiqar7j3BT0cMXU9QV5T16h7xhfjb6vqx3p5/vgvmm2SZMRcnibYzQB1sWmyNXZiwTRnZ72JJ3ljvsprY4YWTzqEPBIjO4faG5KsqFWX+yFWoB01ykgkNdn+3org==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CdkHWlLZVWbmowEFXz5ft+/3LXDayE8Wc7U1U+7L7cI=;
 b=bdK+9ya/HGBnsE+oNNS/y5E/1/NCnEUAwU7ul2Sa6iU2BHR27pOzlibm+aXZqSoGwYWmii3Z1X7ftYZkfOKAE3z8rr/r+zUvj+raSJu3/jjAuCl3GNoC/kKXPDk7xTTQzpA2OeBXqBpXyE3F2dVm5pn8g1Co22G/rZHC6bHaOvU=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2368.namprd11.prod.outlook.com (2603:10b6:300:7a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.24; Tue, 30 Mar
 2021 01:37:06 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3977.033; Tue, 30 Mar 2021
 01:37:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQw
Date: Tue, 30 Mar 2021 01:37:05 +0000
Message-ID: <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <1614463286-97618-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1614463286-97618-6-git-send-email-jacob.jun.pan@linux.intel.com>
 <20210318172234.3e8c34f7@jacob-builder> <YFR10eeDVf5ZHV5l@myrica>
 <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
In-Reply-To: <20210329163147.GG2356281@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.219]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d95e420c-a2b8-46c6-2fb6-08d8f31c5399
x-ms-traffictypediagnostic: MWHPR1101MB2368:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2368E87D6BF0BDCA842A484A8C7D9@MWHPR1101MB2368.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TUzgiBOynposWtwjYxhsfUeR5DQpBoIAaxB+7o3bSY5FCdeQBuPg3WdWQU++KKF65YTBFsRMQG/OA/Fft4jrLCEIAV3vlGWWLQHIm9SXgdLsqe8JzLyv2lFOH1l22V1zWNdwqOGQYYyqc5yeYIBc54YWDx+uadWG7cAVuKcXUVcvfts6d0pY0AEFfb5smXrZ1pmZJH56vEwlbHRruAfyIK/LPY4fNy2dzUvy2iPYVVqGk/Gxxo0GWKZ69oF3eE9HJpW0gNAkyZsjrUBUmNsaJ5sEkcQs44j+fbJG8xNS6//VBxdNwhw4lcM0cEQBU0rvJ65vFEZj6jrBfD4ohbLhDVo32AA9tUzS34neJq2pcmHRQvagMFajemYXrx4kmVCSppcBcd7vUVPCa/WEdZtH2jSjua3DEaZbVQzFeva6UGG1bBjwhZWv+V2D1vdTYl1Qw+Nkr7nAZwsL/FxKMtBQsLyJosEa67QbmN6EZMfTYxkVFm9DIt21nEuujj1q4lgk003U4OIDT1W1/yHgSwnmz4CJ61sPmgRWjmULSYrFSI6d9QYyvRe2pQD+tTw//8/c4ZmH8T2dl9KXG/RxVFO9e4XWyzdssAufLv0BtZbPgtyfwByu4WjXRaM7qXT2+9BBGO6+Lv3Ge+yA0enoK2leYOpkdVDAOz8bmi2m1UTjRCw=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(376002)(136003)(396003)(346002)(39860400002)(366004)(5660300002)(86362001)(4326008)(71200400001)(478600001)(7416002)(55016002)(9686003)(7696005)(8676002)(8936002)(83380400001)(38100700001)(6506007)(2906002)(52536014)(76116006)(66556008)(66946007)(66476007)(110136005)(64756008)(33656002)(66446008)(26005)(316002)(186003)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?OmhA7/QLPIVqxM1m87x3os6llPm3iJjDZpHI8gYCYxL4Y8AtNOsoavbSAsPz?=
 =?us-ascii?Q?VH1rHGwrJlw0t8Djk6DHvUged6tDfGHRamYgEwyXgBDFIIBv8a9lHKtpsaoX?=
 =?us-ascii?Q?Ltv1TThU9AOMmjLFvuDHQvpTvv2pIJ8VwnlmWkqi2G8h99JGNB40TCevxp2D?=
 =?us-ascii?Q?5/KDaTvKSsWUq39/1eNRohe0YJvHF4m0LlNT0gl0b5IIhEPL/2iSje9/UGUK?=
 =?us-ascii?Q?17+7IJoUcptbfshK5YmVDXHzSM5Xg0g6B3Ck9j2GROqQwaVO+piZcFyTnqaB?=
 =?us-ascii?Q?iouAs/IeiZ8djBsXcDpxWtjqI0QZIg9oDs+crwbrMb7NC6r9H6zD8Vlsr3Rk?=
 =?us-ascii?Q?+dyMWsj5WVZsZUmVaYyhF9LY41myEuDDnPryKTphu3iju+96V/uOAZpPEQ8j?=
 =?us-ascii?Q?2rmCXLAd5l/I6HiVzlZGu5ziKAzbq1O4sw5AtNfoMvjwWjs9tvYA5uJ4SmCM?=
 =?us-ascii?Q?Izno363lCCU+ist/EzfYFkaaQJZZpOEb6b1KOYSvCT/qIsKD5apVa1FK1c3s?=
 =?us-ascii?Q?X5xlIncgldtaxlaBSt/n5XfpdZ0jfXuhn+9MZq/jE9pcwDCIldP4pDpZmh2N?=
 =?us-ascii?Q?e/iwISkpY2kdPHDoRWNQRmA0d3meiHomoRm4uozhP13g8pXFeB+eczW7TxKS?=
 =?us-ascii?Q?nUl2lkWkhXMUQSurVa2bvtVlD+EZAjVbySmVoEaL+j1/A+U/aUO/KxxBAbxF?=
 =?us-ascii?Q?iwXRFO/X+m1ghyKkBRsm1UMzH7WysmlTw2fmPkcI5Q2sdnvKVXCxj7hqezlu?=
 =?us-ascii?Q?ZXyq06+7DoD2cpvqh1ZQUAcs5o0XUvwISTmyGXhlHxWO9M3VMONra7b1pzMM?=
 =?us-ascii?Q?Sa5Cs18V58VE8Fe07ESmkdLmJAS3TyJcDkUp6hBlb/QLrbUOCNeWN28SV4m2?=
 =?us-ascii?Q?aOq2ZZx1/rTiTucBtiAzIQxlsDcI4H15oVcgAUbcl6X+N7lOC+7vA6+PAFvi?=
 =?us-ascii?Q?Fk543bV1vketgwFy/HDy3p38282OxhiZdB4uC0bkPQ81CHpeKOFFE7QnSAzT?=
 =?us-ascii?Q?z1cYdi7LpG7YCxO8LPKd/5yaUMRyMZXtg0k7R9fEbE8+a50K2Zam11CWngEN?=
 =?us-ascii?Q?E8Ve2OZs+vQ1SfOdyVXUI/zyNOUv9nVRyJ3feNR4KP657ELZBJfaM1M61nj+?=
 =?us-ascii?Q?5ixaExn8853Wo440bctulCBrAH//JQq25vA368TCOkwZ5ltuKFigjMwZz8h0?=
 =?us-ascii?Q?66REwEcMj6PjOxPbRkRUmet2rNPW1GhU+cPnx7tQzAuEG3vN9JETSmvRQunY?=
 =?us-ascii?Q?0fugwnsYqSXtU39JAAnKr6RFWLCkLE8xGGLe6wX59fDJi41NBfY4TCKReiZq?=
 =?us-ascii?Q?95lYWI8df8wibuNsiOcuTuXR?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d95e420c-a2b8-46c6-2fb6-08d8f31c5399
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Mar 2021 01:37:05.8427 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lwXGlk6qWC0ODbRPYdrTJas9ZGUnBw/GCW7ncaNc51P0F9Pew/iRBVDpNGZs6b33SMRo9m/PkrVSwDjoZ5O5bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2368
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, Alex
 Williamson <alex.williamson@redhat.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 LKML <linux-kernel@vger.kernel.org>, "Jiang, Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Li Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 "Wu, Hao" <hao.wu@intel.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Tuesday, March 30, 2021 12:32 AM
> 
> On Wed, Mar 24, 2021 at 12:05:28PM -0700, Jacob Pan wrote:
> 
> > > IMHO a use created PASID is either bound to a mm (current) at creation
> > > time, or it will never be bound to a mm and its page table is under
> > > user control via /dev/ioasid.
> > >
> > True for PASID used in native SVA bind. But for binding with a guest mm,
> > PASID is allocated first (VT-d virtual cmd interface Spec 10.4.44), the
> > bind with the host IOMMU when vIOMMU PASID cache is invalidated.
> >
> > Our intention is to have two separate interfaces:
> > 1. /dev/ioasid (allocation/free only)
> > 2. /dev/sva (handles all SVA related activities including page tables)
> 
> I'm not sure I understand why you'd want to have two things. Doesn't
> that just complicate everything?
> 
> Manipulating the ioasid, including filling it with page tables, seems
> an integral inseperable part of the whole interface. Why have two ?

Hi, Jason,

Actually above is a major open while we are refactoring vSVA uAPI toward
this direction. We have two concerns about merging /dev/ioasid with
/dev/sva, and would like to hear your thought whether they are valid.

First, userspace may use ioasid in a non-SVA scenario where ioasid is 
bound to specific security context (e.g. a control vq in vDPA) instead of 
tying to mm. In this case there is no pgtable binding initiated from user
space. Instead, ioasid is allocated from /dev/ioasid and then programmed
to the intended security context through specific passthrough framework
which manages that context.

Second, ioasid is managed per process/VM while pgtable binding is a
device-wise operation.  The userspace flow looks like below for an integral
/dev/ioasid interface:

-----------initialization----------
- ioctl(container->fd, VFIO_SET_IOMMU, VFIO_TYPE1_NESTING_IOMMU)
- ioasid_fd = open(/dev/ioasid)
- ioctl(ioasid_fd, IOASID_GET_USVA_FD, &sva_fd) //an empty context
- ioctl(device->fd, VFIO_DEVICE_SET_SVA, &sva_fd); //sva_fd ties to device
- ioctl(sva_fd, USVA_GET_INFO, &sva_info);
-----------runtime----------------
- ioctl(ioasid_fd, IOMMU_ALLOC_IOASID, &ioasid);
- ioctl(sva_fd, USVA_BIND_PGTBL, &bind_data);
- ioctl(sva_fd, USVA_FLUSH_CACHE, &inv_info);
- ioctl(sva_fd, USVA_UNBIND_PGTBL, &unbind_data);
-----------destroy----------------
- ioctl(device->fd, VFIO_DEVICE_UNSET_SVA, &sva_fd);
- close(sva_fd)
- close(ioasid_fd)

Our hesitation here is based on one of your earlier comments that
you are not a fan of constructing fd's through ioctl. Are you OK with
above flow or have a better idea of handling it?

With separate interfaces then userspace just opens /dev/sva instead 
of getting it through ioasid_fd:

- ioasid_fd = open(/dev/ioasid)
- sva_fd = open(/dev/sva)

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
