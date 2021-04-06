Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E22C433B4
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:27:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C021613EB
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:27:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C021613EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id ECA9C8488C;
	Tue,  6 Apr 2021 01:27:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GUmfvpfh9RH8; Tue,  6 Apr 2021 01:27:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id B83D384890;
	Tue,  6 Apr 2021 01:27:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 83678C000C;
	Tue,  6 Apr 2021 01:27:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3128CC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:27:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 17CBF60689
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:27:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZwS_fr2xqXPo for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 01:27:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2662260642
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:27:21 +0000 (UTC)
IronPort-SDR: AeSqzHspP5VgBaxIA8H1Qxc2vF9ypQnbRYFyw3lhJ8yaLpG+ZFANnMLmUp9pcfihf0fKPOl8dd
 crfOlwjC1ybQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="254292186"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="254292186"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:27:20 -0700
IronPort-SDR: SWBQFYd97EZWsTsrNoK8HEQuuad9L7hOeDVDWBHWnCYewNeVnS6AuFGxF/97i1N1CqJJQWYQVx
 z1dfsyBsEFHg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="386361160"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga007.fm.intel.com with ESMTP; 05 Apr 2021 18:27:19 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 18:27:19 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 18:27:18 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 18:27:18 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 18:27:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoiXWt5SiMXUENyk+sZZOACEctj/tsmgAdud7/u055L0LbG1SR+FXQC0/03Ri3XScO6fl0VeJ3UW2E6FAAaua9bMVmg101s40yL/In8TZmH3wnS3tjAM6H7Aj9mb7fq3gIsgcGiXa67M5q1tVEfuX0i6LOzD0UuiQh9ifbmWV2INnecUcZTn+ZHOYSBlshq5EqsTIClyjGXaKYaxbb2HgCLPEEkvC3CKOtEtDUyvCSPXVlkPAyx/HcnseSK3EqviX8Z0kkgBZdzAd5NELWY1kMe5ODcN24u8NI3MWUwC5U0TdDqL98+32PAZacUXwtctlR2Tqa3AmB0Vl2yTUdKrKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6QPV/w37J7WSqMnBWyoO0Tf+WSH04GhtmSithqTso=;
 b=YGpBNHZHdMBJ4EKk+alSP85J6ZCh9ETH/lEggPCOhY5skezEg6Et7mmbsirzLOGDsj76A1Dl6s0or61nSQr8CnQ9mYFle5eAqtpUHwjSFu4YMeJNlQeUxqCQgEKW7tQOgnvrMG0L+nzNsvwo6yyE6/ahVf8iiM9UNHjefxeDE009ErRzZdImV7UCRgdsRd27U8PVPQhZdNvcGarViVe/7jBu34NgKICRTkrZDuybpAt28Z1RfqDenlbkj2AJFl3GXKbF/eKKGv7WjvA7SlHIXTscV+MrLbNzinFTRP/suxhR6CJewgtMdbaO8pkqCqLW84i7sNTd1o2MgBQkCjCxqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mA6QPV/w37J7WSqMnBWyoO0Tf+WSH04GhtmSithqTso=;
 b=BCuBjQMclxQVcS4azO2bY77qNQgCjIUjQr2r8yM7oRiNHjcPlGMWLKTPQzMIgp992NoZ5rIkM78ERJhyxABhYrRW6Ge0ndftAurYyUcf0aiRzc/26BrnVY12gDPgUv1apyUrCaZlcMAuBKexFU2vvwhdYx06NkCZstS766Hl9wQ=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by MWHPR1101MB2077.namprd11.prod.outlook.com (2603:10b6:301:4d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29; Tue, 6 Apr
 2021 01:27:15 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 01:27:15 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACABFtkwIAFviUAgAAWTgA=
Date: Tue, 6 Apr 2021 01:27:15 +0000
Message-ID: <MWHPR11MB1886CF7C11ECE0396A0215078C769@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210319124645.GP2356281@nvidia.com> <YFSqDNJ5yagk4eO+@myrica>
 <20210319135432.GT2356281@nvidia.com> <20210319112221.5123b984@jacob-builder>
 <20210322120300.GU2356281@nvidia.com> <20210324120528.24d82dbd@jacob-builder>
 <20210329163147.GG2356281@nvidia.com>
 <MWHPR11MB188639EE54B48B0E1321C8198C7D9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210330132830.GO2356281@nvidia.com>
 <MWHPR11MB1886CAD48AFC156BFC7C1D398C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405234230.GF7405@nvidia.com>
In-Reply-To: <20210405234230.GF7405@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 98d6c98c-84a4-4060-2ff2-08d8f89b1c81
x-ms-traffictypediagnostic: MWHPR1101MB2077:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR1101MB2077A3B71E7A9A94A3CA07628C769@MWHPR1101MB2077.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2jN2Iu0u32YZEDV1H0xYMRxoLVon5yAYrAwb/fbiiE6fGt79QoEOU+qlQrP426KqtxJhT4BM2XJbgSgrJbdixsl9qqQn/XwC7aERoEsMp/X9FADAj+UHJnumwnZjOgqqzAGnb8N+RPNOre04VpNEckFOCROFBJCrfe4hPhk1y5jMQgel14qHR/iBIoYAWmxA+NIuu3Cpb/GHQk3TYddGlcM9FgSBkj5uZKdOiXQ+mYcSQ8Rt79PQbLXf8lyvF/qblfpSzC0go6hc/DOebSJt+9BQxvA2ttZ1S4/zqtHqYGQYTms/NWi+F/nlqIwQT682AFvHYDjrS/dzyKHw00+z4wRVV8Ulw/aO9qKBNt8ModpTMOODrIYy9fS+F1oCbyB52BNZVqPizkmEY+4mCBslPz8Jpjyjem4tdira5xyMs8yZP1XrLZrLgOWLQ6A2r3hE7BkeRKJ/ubMlPpk6mgcujH1Rp9izt2UHnImT6ylrgTiRSfZODmsUqMn2DjPTQHMSc+vlzgIbYFowYtkDKHc9jN/g4VGLqxngCvF1Dn+Tb8V5G4l/XxEclCHXyKFOQq4TWRrJui67pMgi6kl3W3LxlGPdI3FOTwFXts5mVdcS8hh/lQl+Tdxge7gkVXHfqVcxEE9aYLIkkdT2WkZVGDn8EkxuFjqPCa2LGs4xQ5+hD7k=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(66556008)(66946007)(66446008)(66476007)(64756008)(33656002)(7416002)(5660300002)(478600001)(8936002)(9686003)(76116006)(86362001)(71200400001)(52536014)(55016002)(4326008)(2906002)(316002)(26005)(186003)(38100700001)(8676002)(83380400001)(54906003)(6916009)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?3IVNm91LdyR2bNtlZniYbcxc0zg0cJfTtvJ7oEpfgq4YXRxbwn9ZX1gCoKHt?=
 =?us-ascii?Q?8dnIMPAE89ZKiVVu988J8L5hgIYO7BIaW7Fi0jCo8KTXSTUItEsf7OadNR0J?=
 =?us-ascii?Q?S9gWIki1q9lorSiHokbdeMaXuw7n9ESd98S6V6iIEB5OrfOIJZeTv9TvRw+s?=
 =?us-ascii?Q?tHhI4/2GKqtKwZ3QKRC19NCN2GN8r8CqE2vX9PWnA5P1Sf2oDhuXWiWWIdiE?=
 =?us-ascii?Q?fWpeBYC+dDq1osZ3EK779QSUM/V9VZcDw9Nfd4nn6Hovxx7omcSf+otUGMm7?=
 =?us-ascii?Q?Gl0WJn23BH+IyJfU8+yHH6yzqd73U86Lh2/DZP6VOpx3c1VGY1lGuoqRJj5A?=
 =?us-ascii?Q?xl2MAtMdo8wmFyJ51kkfW3//JfRzAGBvy8CVEN9lwrqfla6GhBkDpdvDxXyv?=
 =?us-ascii?Q?gaZIsJCe6lVuCvDU99fMZL1wYQnOhb7dPdCi5EI411Ayz+cpM3cRTniy9RaI?=
 =?us-ascii?Q?C3fuKMmwOt82uTqcEUjyWtQQ4e9xnOUhw9zhXcgXLa/97bZhNLaAO+xdjDo8?=
 =?us-ascii?Q?cSQ7Jto2+K9qivBS65ADJziExvf7g37ns+MMlRoK2BtRr+5l3wLfHtTrdylW?=
 =?us-ascii?Q?e7Bns2gJHvT3bZSMAXaZgFHcm5o5kHog3oJ+lMFijn6IUAwEr3/TP3kJYRuP?=
 =?us-ascii?Q?L9vblhEIormlXTWBcERpH5IIv8S4S+TGNwmJD3QQVmWHQsJFDWCjjqCNKqky?=
 =?us-ascii?Q?qcmr8SYZPIVHjVI4XeGc6XLEhHar12dZ8K7noPjX8Wpd3rsVPGOWZjmdH4IV?=
 =?us-ascii?Q?5iVKaUDE1nLqmAtgZ7s3mpo6EyRNrVa6efQnwOtP+NTiWYJmwX/5t/Njd9xe?=
 =?us-ascii?Q?kizOaKlPjn9NglmWI+vVu9lEf6+hxHl/tzXwHCWUtU1yyuudKqtymfs+P38Y?=
 =?us-ascii?Q?DWxhwqYSjcySlv1skC0+zN7oNSnndjddj0a6ww+GaPrWM7Bezf6LkuyTS1ou?=
 =?us-ascii?Q?r3UjIqpliVLbs1vU3IcdIiQ9ooKGTabUTDIg81x3ruI5Qi56I8pC1SI6Ocrt?=
 =?us-ascii?Q?rSWsF7mWfcVZs64poWEEeI+SE7Kg/UmfTyaSpiH3k+SUiWWAQKNd+LMH7W3E?=
 =?us-ascii?Q?RZuDZphdqvbQPiIjNQXuOYENtounXVr4EO5Y3GI6dpLuukWS87fhk+WXaRku?=
 =?us-ascii?Q?l9INkpgoke07ALhU24/b/XnV/ccWxwU3jGudtygeOQjbxPJ0CwlfTACkTD8K?=
 =?us-ascii?Q?L8Pzo6k8YWaVKAPmx+fcl5YjjZfxqisa5QSRbuqBMdJEdJ3P3TjaRMHkZc5I?=
 =?us-ascii?Q?YNZelh7UYoXK72qhbWvlFzoByYbfIGyPCe7ubr/GhHh6/z0sJpL+/BOADdR9?=
 =?us-ascii?Q?rVJZ4GYOIL3Ewcw4zLJd6QMN?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d6c98c-84a4-4060-2ff2-08d8f89b1c81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 01:27:15.3973 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qlDdpg0wA+8PIeuWdi4p7MCsq/vRjGkICfn/gU8+lcI31mL4VT8jGFVyZ/mBnIBVEUNCOfQLNh/EOIFgjOTKbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1101MB2077
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, David Woodhouse <dwmw2@infradead.org>,
 Jason Wang <jasowang@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Alex Williamson <alex.williamson@redhat.com>, Li
 Zefan <lizefan@huawei.com>, Johannes Weiner <hannes@cmpxchg.org>,
 Tejun Heo <tj@kernel.org>, "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>, "Wu, 
 Hao" <hao.wu@intel.com>
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

> From: Jason Gunthorpe
> Sent: Tuesday, April 6, 2021 7:43 AM
> 
> On Fri, Apr 02, 2021 at 08:22:28AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Tuesday, March 30, 2021 9:29 PM
> > >
> > > >
> > > > First, userspace may use ioasid in a non-SVA scenario where ioasid is
> > > > bound to specific security context (e.g. a control vq in vDPA) instead of
> > > > tying to mm. In this case there is no pgtable binding initiated from user
> > > > space. Instead, ioasid is allocated from /dev/ioasid and then
> programmed
> > > > to the intended security context through specific passthrough
> framework
> > > > which manages that context.
> > >
> > > This sounds like the exact opposite of what I'd like to see.
> > >
> > > I do not want to see every subsystem gaining APIs to program a
> > > PASID. All of that should be consolidated in *one place*.
> > >
> > > I do not want to see VDPA and VFIO have two nearly identical sets of
> > > APIs to control the PASID.
> > >
> > > Drivers consuming a PASID, like VDPA, should consume the PASID and do
> > > nothing more than authorize the HW to use it.
> > >
> > > quemu should have general code under the viommu driver that drives
> > > /dev/ioasid to create PASID's and manage the IO mapping according to
> > > the guest's needs.
> > >
> > > Drivers like VDPA and VFIO should simply accept that PASID and
> > > configure/authorize their HW to do DMA's with its tag.
> > >
> >
> > I agree with you on consolidating things in one place (especially for the
> > general SVA support). But here I was referring to an usage without
> > pgtable binding (Possibly Jason. W can say more here), where the
> > userspace just wants to allocate PASIDs, program/accept PASIDs to
> > various workqueues (device specific), and then use MAP/UNMAP
> > interface to manage address spaces associated with each PASID.
> > I just wanted to point out that the latter two steps are through
> > VFIO/VDPA specific interfaces.
> 
> No, don't do that.
> 
> VFIO and VDPA has no buisness having map/unmap interfaces once we have
> /dev/ioasid. That all belongs in the iosaid side.
> 
> I know they have those interfaces today, but that doesn't mean we have
> to keep using them for PASID use cases, they should be replaced with a
> 'do dma from this pasid on /dev/ioasid' interface certainly not a
> 'here is a pasid from /dev/ioasid, go ahead and configure it youself'
> interface
> 
> This is because PASID is *complicated* in the general case! For
> instance all the two level stuff you are talking about must not leak
> into every user!
> 

Hi, Jason,

I didn't get your last comment how the two level stuff is leaked into every
user. Could you elaborate it a bit?

and here is one example why using existing VFIO/VDPA interface makes
sense. say dev1 (w/ sva) and dev2 (w/o sva) are placed in a single VFIO 
container. The container is associated to an iommu domain which contains 
a single 2nd-level page table, shared by both devices (when attached to
the domain). The VFIO MAP operation is applied to the 2nd-level page 
table thus naturally applied to both devices. Then userspace could use 
/dev/ioasid to further allocate IOASIDs and bind multiple 1st-level page 
tables for dev1, nested on the shared 2nd-level page table. 

If following your suggestion then VFIO must deny VFIO MAP operations
on sva1 (assume userspace should not mix sva1 and sva2 in the same
container and instead use /dev/ioasid to map for sva1)? and even for 
a sva-capable device there is a window before the guest actually enables 
sva on that device then VFIO should still accept MAP in that window 
and then deny it after sva is enabled by the guest? This all sounds
unnecessary complex while there is already a clean way to achieve it...

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
