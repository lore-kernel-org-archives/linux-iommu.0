Return-Path: <SRS0=NW7i=JD=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A1BC43460
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:02:14 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B57B9613E3
	for <iommu@archiver.kernel.org>; Tue,  6 Apr 2021 01:02:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B57B9613E3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7530B84AB8;
	Tue,  6 Apr 2021 01:02:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJeEkwePJ5hI; Tue,  6 Apr 2021 01:02:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44B76849C7;
	Tue,  6 Apr 2021 01:02:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1E728C000B;
	Tue,  6 Apr 2021 01:02:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5869FC000A
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:02:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3F10040456
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:02:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S_6x9zU3rb81 for <iommu@lists.linux-foundation.org>;
 Tue,  6 Apr 2021 01:02:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 27B9040453
 for <iommu@lists.linux-foundation.org>; Tue,  6 Apr 2021 01:02:09 +0000 (UTC)
IronPort-SDR: SExINAzr2UWZiiAd3xX4/re2MxDO4Cb3QmD1DSGVW8xDZYphBua4EINzI9owJ+7VM+Oi9E90W1
 seDbA+5BVhQw==
X-IronPort-AV: E=McAfee;i="6000,8403,9945"; a="254289651"
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="254289651"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Apr 2021 18:02:08 -0700
IronPort-SDR: w8gbAZwA02TunwosbcTGSybjMHVcyDDffuFFhU4W+EjIWEj0hMOE+KLVxl33bXCeu9TfMyn7dX
 BbexOS8MZKkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,308,1610438400"; d="scan'208";a="420964635"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga008.jf.intel.com with ESMTP; 05 Apr 2021 18:02:08 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 5 Apr 2021 18:02:08 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2
 via Frontend Transport; Mon, 5 Apr 2021 18:02:08 -0700
Received: from NAM04-BN3-obe.outbound.protection.outlook.com (104.47.46.55) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2106.2; Mon, 5 Apr 2021 18:02:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RgaKr9r7VdC6apo8jElzPif6wdxH+jR2q3sVUvUjravRCigRobI+YD5/Q2e/4Bvf887uiEENnzOjTupAvspRbO4Au4rnjxepbyJgljvSYjwWJljp138Sjn1gCS4MyMJgbkKwQrK3CNUX5W7z18kpdxI1w7kCkdX1vb+HxVcJbHqKomNHf6+woPegLwtFD7MmR88zTdXWHXgDlUdtorqr3cQp1LcYPVNyhSavTO3LQxlo3ai7ntccvAw+nNrp3WdFXEuU2+zsp98yWyeA0hu3BeEA3PzE0OYCQ2G4+Vv3KwHJ7jq32r1Otycv7UttVE6ghb/eTu02yq/oYhRpSQ8EzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W18thJHCY3A303kxEQoYf2tjtFuH0F60bQaLur9KHcU=;
 b=LjNlSvvQOdvu2AVaXjChehoi1Dl673pdTfAdgptIz+cjioFdAp9SADvgezWGAgc+bfKlSegdPAbGJzp4s5daXyv7IaV9nZYc7wdDeQjll9cbjRM+C7y7ZZEw0CTe3QEZyuSXERrHvYatxCFb567GWcKGfYL+ipagt5fPiKer6xle36wRx5sWEoDHqaa1od7Wx9DSq7WQFvsEAc1y+/lGQmQBPSQUv52tr7pRQepuM0DbMnplpXZ/dnwMdP1qvtx7THk0KYbeKO/6CKKFOqRYzn9dSJj7UkD3sBBWG82HRgjqT5O86WG3qnDNxmbyYsIk72LT5GWvay912ROdQbYMxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W18thJHCY3A303kxEQoYf2tjtFuH0F60bQaLur9KHcU=;
 b=tZy0Cng3qi78auCv/IurcaGlLvDmgOS3Ra4BEfIXEJbRNkxViAFxybiGqtRBo8yzeVhd7qTeSuL3G3eRSdNhSSjJi9Zc07tHKSks/9wdExj7uNgZlDeRlL3kJ69jvB6YDuEv0HnRrNufOC1Rpv3hgDFaDkP/57zwlMgdxiuJ8Q4=
Received: from MWHPR11MB1886.namprd11.prod.outlook.com (2603:10b6:300:110::9)
 by CO1PR11MB4932.namprd11.prod.outlook.com (2603:10b6:303:98::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Tue, 6 Apr
 2021 01:02:06 +0000
Received: from MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29]) by MWHPR11MB1886.namprd11.prod.outlook.com
 ([fe80::75b0:a8e9:60cb:7a29%9]) with mapi id 15.20.3999.032; Tue, 6 Apr 2021
 01:02:06 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and allocation
 APIs
Thread-Topic: [PATCH V4 05/18] iommu/ioasid: Redefine IOASID set and
 allocation APIs
Thread-Index: AQHXDZub0CDG82VGXUmLEYgvMuPs4KqKkLIAgACg94CAAC72gIAAD04AgAADogCAAErUgIAETQEAgAOaswCAB7C3gIAAhxQwgADYDACAATCSAIAAVGMAgAELsQCAAHeZAIAAF3gAgAABVICAAAfXAIAAANyAgAEpdBCABcWUAIAAEDLQ
Date: Tue, 6 Apr 2021 01:02:05 +0000
Message-ID: <MWHPR11MB18863645C2C63A89BBA200B08C769@MWHPR11MB1886.namprd11.prod.outlook.com>
References: <20210330132830.GO2356281@nvidia.com>
 <BN6PR11MB40688F5AA2323AB8CC8E65E7C37C9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210331124038.GE1463678@nvidia.com>
 <BN6PR11MB406854CAE9D7CE86BEAB3E23C37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401114648.GX1463678@nvidia.com>
 <BN6PR11MB406858FAC3821B84CCC4D30DC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401131533.GD1463678@nvidia.com>
 <BN6PR11MB4068C1A040FF61B4A9ABBD9BC37B9@BN6PR11MB4068.namprd11.prod.outlook.com>
 <20210401134641.GG1463678@nvidia.com>
 <MWHPR11MB1886C0804A0240998C110EE58C7A9@MWHPR11MB1886.namprd11.prod.outlook.com>
 <20210405233946.GE7405@nvidia.com>
In-Reply-To: <20210405233946.GE7405@nvidia.com>
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
x-ms-office365-filtering-correlation-id: 1469b6f9-a43f-44bf-4d28-08d8f89798d6
x-ms-traffictypediagnostic: CO1PR11MB4932:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CO1PR11MB493269C87B12401197E8FF038C769@CO1PR11MB4932.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2+BGplM+yhAfuZaAE5RRB5qlDGJQdMyA/HR3ZjYnKC4c53SfG6CbhMtxlHEBNTmoNC0FS9FkqvUFG1YUu664ZgLezVG2dKzuBZVt/peRCldCiLbjt9k15BVcfYqVD1INc/msIDznNhZRC3Z4pFCpAYf8xx+kvj/48Eh65BddT+yE60sKFXEQZxnxfzSdj4R7/HQBCBA6Uo12jWYFx4iR6QFk9GVqQihLlpyQe5vrB+is79jdCE40IussJWpjwu62LvWOrTKsKtKMjoWEVgHBzPg5GF+hQsofhmemJOUbGAu/luD2vgheHZdhE5H13XjKo7jsdOvjg54l8s6di5abkQUH5PhUorxxdUtEDPDkGH20Yxp1PruCT0qV01vzlaoAS/+Q34RQIQwRnLoSYuFKpYULb/KDs4AWiRGn+5FbHKhSDIg9ykLpIjAhgmvY0PFth1/blWsaXk9ajy6/sWBfie8SnaMWdyrUBrXTfNENj8TLm2eJfprgU5yEz0D10xMWk48Emf5ALDv+Zrd30ehQM+di8kOaYDkEvJ0A/Je+Nqr+q7aIuWRVbcoRhSf4XAdkPlpjXmjcK3g2QK9IdHeSiId+Xu6hc0yL4QzZCAJIzbAXknjzVLHFS7n2KP4A90Rs8jZvrE1AvRwuSY10VkbkAt3U2I5cAVAKftwzeA+lQQ8=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR11MB1886.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(346002)(376002)(136003)(39860400002)(396003)(366004)(7416002)(54906003)(2906002)(186003)(26005)(38100700001)(316002)(33656002)(5660300002)(6916009)(8936002)(76116006)(83380400001)(86362001)(66446008)(66556008)(64756008)(66476007)(478600001)(66946007)(71200400001)(8676002)(52536014)(7696005)(4326008)(6506007)(55016002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?MBSr8xmpGVEYuFnp48qGe+8QqZqds4/XTahr0CD+f6IsAV+95PznxXTk7+cd?=
 =?us-ascii?Q?wu3H0GIdSB3SX2ZTbEWhBzmNA1Jl0rzOjws5NT+Xi4vO83h7X7V7ceip46PW?=
 =?us-ascii?Q?tGJ59qcFe2jwIMSdgPQTRKGk19stQSATZfpPWmdMMrlk6uQjBEPH9iJy0Zss?=
 =?us-ascii?Q?m6LPLhVWs/DlpfsAdsKrV/48UrtB5e9/y4/GGSqk99tbLfZnvC2S3jt5sK4T?=
 =?us-ascii?Q?5iZOSkuBJla7Nmx8VwjKbbryA8c8pF+mOvLHO2+jHr3iGpJEqjsRfuC9ZjQ1?=
 =?us-ascii?Q?aKxQ/feXxI2goMZ42rXY7Q6KkljWGA3T4zZ8QTgnfPft9A2yvzytjza29wfw?=
 =?us-ascii?Q?ceYfoC5rot9Az3NSUoSjx7yztrv1oUYrAlmIKCJnCoYuFbaBDAvy8VBEJaU5?=
 =?us-ascii?Q?G70zD5xfrYUirPDlsfkfOM3+3+NIO1GmsFnOLA0jomWjIPj+K3+FJm4lOHRX?=
 =?us-ascii?Q?L8+gUpg63K6ar8qOaHmfN+Mma+hKPpRLCw8n8KW0laYEf01UK2kqCvTGrahd?=
 =?us-ascii?Q?g3Xk1K7V5EUDQuVXr7zzeS57SdfC9dj83FkDN2zc6Pr2DDN06MePFdllVoYh?=
 =?us-ascii?Q?uc2Ujh5P7/veKLmpkXQYodyNzLwlyBGkjWyi60yoJiEdkILSq45LTS1wjxpC?=
 =?us-ascii?Q?2turZwxZpSdiO99XI/vtChmz0ELcn/BpSq2ciIfAxuPQ8TpaMshMPCIynJpv?=
 =?us-ascii?Q?1e12irf3FagrdJQHwIo6iRJ84B1B46r3Iy/L92wHEVovRoohE2U6r5APiFOG?=
 =?us-ascii?Q?q8K5BS4tyxIHLacN3uEP4GrXiTmkk/ZQCSPt+qzimoQDVshpYMLrC/hE0JMN?=
 =?us-ascii?Q?sj0R8iAsKlSKkhSpOt5BV7BMf9Gd0fMdFlAz2kaNV4SbUKA3p1FKK1iHs//j?=
 =?us-ascii?Q?Hw2BFO/Sl56R+cIU+XcxWmv8wPkgXKJ67/fknE5SRDcGpaegwbHiYqxKIZq9?=
 =?us-ascii?Q?Zlho5GTgy2h+OZKotveCiCaLBWJHQbVcz8DXbn0cpPVbQyyHK7LQvdtsS7lo?=
 =?us-ascii?Q?W+zm20cW6eym9APMbYOzrkO36d0JuyybQLsakeCFoSA4QRJHLBfmk87KGAl/?=
 =?us-ascii?Q?IWhpJaqWzJ1a7tvb9iSnyskP2VqVfn0ib0x0SG1r6jSm8cd1fxJyW36Z8/G+?=
 =?us-ascii?Q?VtRVfXbF55u/8/25vCUcnVpFK8xOX4RC419EUgcvnBbxzoyWrDjnrSC/rSt/?=
 =?us-ascii?Q?8aB5LYdaO4ljZ0W/E8q2/GgJuyOyPcx3GBkMgSvYLfQlr/FqGqd1ykf+kLSv?=
 =?us-ascii?Q?rND1xaljxcMs2zHK9c/K05r70ARTX7Lr8QJNn+4eZRRs3tYytLRGlVteJ5hX?=
 =?us-ascii?Q?NgfEHzSAGtSAodulxEEISXid?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR11MB1886.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1469b6f9-a43f-44bf-4d28-08d8f89798d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2021 01:02:05.9907 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zAUviVwg0lJ922GQco0pypA1QXpBMrGnPi397iHgGSJYrA6SEIwDXvDXKSg/yHJsPc123j9EYC7srAMvSSAzuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4932
X-OriginatorOrg: intel.com
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Li Zefan <lizefan@huawei.com>, Alex Williamson <alex.williamson@redhat.com>,
 "Raj, Ashok" <ashok.raj@intel.com>, Jonathan
 Corbet <corbet@lwn.net>, Jean-Philippe
 Brucker <jean-philippe@linaro.com>, LKML <linux-kernel@vger.kernel.org>, "Jiang,
 Dave" <dave.jiang@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
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
> Sent: Tuesday, April 6, 2021 7:40 AM
> 
> On Fri, Apr 02, 2021 at 07:58:02AM +0000, Tian, Kevin wrote:
> > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > Sent: Thursday, April 1, 2021 9:47 PM
> > >
> > > On Thu, Apr 01, 2021 at 01:43:36PM +0000, Liu, Yi L wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > Sent: Thursday, April 1, 2021 9:16 PM
> > > > >
> > > > > On Thu, Apr 01, 2021 at 01:10:48PM +0000, Liu, Yi L wrote:
> > > > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > > > > Sent: Thursday, April 1, 2021 7:47 PM
> > > > > > [...]
> > > > > > > I'm worried Intel views the only use of PASID in a guest is with
> > > > > > > ENQCMD, but that is not consistent with the industry. We need to
> see
> > > > > > > normal nested PASID support with assigned PCI VFs.
> > > > > >
> > > > > > I'm not quire flow here. Intel also allows PASID usage in guest
> without
> > > > > > ENQCMD. e.g. Passthru a PF to guest, and use PASID on it without
> > > > > ENQCMD.
> > > > >
> > > > > Then you need all the parts, the hypervisor calls from the vIOMMU,
> and
> > > > > you can't really use a vPASID.
> > > >
> > > > This is a diagram shows the vSVA setup.
> > >
> > > I'm not talking only about vSVA. Generic PASID support with arbitary
> > > mappings.
> > >
> > > And how do you deal with the vPASID vs pPASID issue if the system has
> > > a mix of physical devices and mdevs?
> > >
> >
> > We plan to support two schemes. One is vPASID identity-mapped to
> > pPASID then the mixed scenario just works, with the limitation of
> > lacking of live migration support. The other is non-identity-mapped
> > scheme, where live migration is supported but physical devices and
> > mdevs should not be mixed in one VM if both expose SVA capability
> > (requires some filtering check in Qemu).
> 
> That just becomes "block vPASID support if any device that
> doesn't use ENQCMD is plugged into the guest"

The limitation is only for physical device. and in reality it is not that
bad. To support live migration with physical device we anyway need 
additional work to migrate the device state (e.g. based on Max's work), 
then it's not unreasonable to also mediate guest programming of 
device specific PASID register to enable vPASID (need to translate in
the whole VM lifespan but likely is not a hot path).

> 
> Which needs a special VFIO capability of some kind so qemu knows to
> block it. This really needs to all be layed out together so someone
> can understand it :(

Or could simply based on whether the VFIO device supports live migration.

> 
> Why doesn't the siov cookbook explaining this stuff??
> 
> > We hope the /dev/ioasid can support both schemes, with the minimal
> > requirement of allowing userspace to tag a vPASID to a pPASID and
> > allowing mdev to translate vPASID into pPASID, i.e. not assuming that
> > the guest will always use pPASID.
> 
> What I'm a unclear of is if /dev/ioasid even needs to care about
> vPASID or if vPASID is just a hidden artifact of the KVM connection to
> setup the translation table and the vIOMMU driver in qemu.

Not just for KVM. Also required by mdev, which needs to translate
vPASID into pPASID when ENQCMD is not used. As I replied in another
mail, possibly we don't need /dev/ioasid to know this fact, which 
should only care about the operations related to pPASID. VFIO could
carry vPASID information to mdev. KVM should have its own interface
to know this information, as you suggested earlier.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
