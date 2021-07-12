Return-Path: <SRS0=b5xv=ME=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242B6C07E9A
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 23:56:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C6BF661158
	for <iommu@archiver.kernel.org>; Mon, 12 Jul 2021 23:56:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C6BF661158
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 822F160812;
	Mon, 12 Jul 2021 23:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AqkcVfHLyaMm; Mon, 12 Jul 2021 23:56:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0D91B60807;
	Mon, 12 Jul 2021 23:56:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE29FC001A;
	Mon, 12 Jul 2021 23:56:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7DA1C000E
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 23:56:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A656E403D5
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 23:56:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e984CCI9gyzr for <iommu@lists.linux-foundation.org>;
 Mon, 12 Jul 2021 23:56:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20366400F6
 for <iommu@lists.linux-foundation.org>; Mon, 12 Jul 2021 23:56:29 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10043"; a="209887068"
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; d="scan'208";a="209887068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jul 2021 16:56:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,235,1620716400"; d="scan'208";a="429846845"
Received: from orsmsx605.amr.corp.intel.com ([10.22.229.18])
 by orsmga002.jf.intel.com with ESMTP; 12 Jul 2021 16:56:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX605.amr.corp.intel.com (10.22.229.18) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Mon, 12 Jul 2021 16:56:27 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Mon, 12 Jul 2021 16:56:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Mon, 12 Jul 2021 16:56:26 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.104)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Mon, 12 Jul 2021 16:56:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i7q6DhBIhyWyUun0nq4Uk7d6ah7RSBPBJvjmm9v4sMsFNt1bIShO6+9KTp4RO4vSeo6+mWwamlVrCxMomrxIcvoaf8N7MIpD+0U+fqFJHn2U3SgY5UNCDjwJVgtEt3gHBXGQ1gyujl10yWUN9Drf9lyZLGQce2erYufHLyNNkS6f2k2gQ2wFB8Torhe4ibbmiQSXOw6lmj6LUBk92tG/5dlLZPq3m1D16v+6nWp4crtQ+lca0oFgxY8q00HaXKL++MdRLHoqGp37fIIZywbeA03E5vrvPNqo84CDCnlRE8Ui1l9eGf0voKAaYSu7+T7HJDtTFaGRQ7t4JpU1aJdxZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdyhzgG8UPvTl0WlEBdPpaYfJ6XkydIC1hBHU5Vh2yQ=;
 b=JEthGul0QS4w5eX3dHy88888AZuTsyR3mHUZvC0KhdjT4kg3VjGyixvliBvlFOrVTV5k3x9heNrmNxt0gZPQHnWMuoKLIUpiqC1MdAEZDn7MiSSBvG5MBLEFXt13p3J0oNNbLfOjxtu5oeh7MM+N864nKUR9B93fXUOjciDRbA17J6nlILucQoO8vjqNqFe4YGD01ceKTtD2G4UHU5HBrrlzSTJu+YwXGO2OL+6nTU2jZLBBM+sqJUqIlL0CctB8WmUPtt69y5XGZnhsGOT38mW8Idzp61eQnY/xOYrFeezEUHdahx1Oms57WenfSQ1o234mvSCzdHOERAiVrzAUrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AdyhzgG8UPvTl0WlEBdPpaYfJ6XkydIC1hBHU5Vh2yQ=;
 b=GWvgBocu/qYUAsdr6nZs5pg97tzcqkIyocv3NqNBugT+7fmMkUphtsKPQTs4N2zDFyMzAYQ/t1wm66oW+In/veV+8mM74MyHgyYkONHuf5dEerErmmZEyG+BgCsWDLPz7e329HazeKlbfBwVOOtHpZ0bVe1kb9yl68hT1Jh9Cag=
Received: from BL1PR11MB5429.namprd11.prod.outlook.com (2603:10b6:208:30b::13)
 by MN2PR11MB4743.namprd11.prod.outlook.com (2603:10b6:208:260::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20; Mon, 12 Jul
 2021 23:56:24 +0000
Received: from BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::ec88:e23e:b921:65ea]) by BL1PR11MB5429.namprd11.prod.outlook.com
 ([fe80::ec88:e23e:b921:65ea%6]) with mapi id 15.20.4308.026; Mon, 12 Jul 2021
 23:56:24 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQAdcmAAAGvGIGAAJH+YAAAKpxYQ
Date: Mon, 12 Jul 2021 23:56:24 +0000
Message-ID: <BL1PR11MB54299D9554D71F53D74E1E378C159@BL1PR11MB5429.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210709155052.2881f561.alex.williamson@redhat.com>
 <BN9PR11MB54336FB9845649BB2D53022C8C159@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210712124150.2bf421d1.alex.williamson@redhat.com>
In-Reply-To: <20210712124150.2bf421d1.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0964f565-9bdf-4bb4-bb8a-08d94590a7c6
x-ms-traffictypediagnostic: MN2PR11MB4743:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4743BC9C09AEB69845D8385F8C159@MN2PR11MB4743.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2hjamZXp5+BW9x7Jt4MMd5mtdBc7H+zYLH9gPgvjBkekFdA7KPY6Lo1yMOSk8EoWKM3QNgvlVCvi4HihWQlCumhTdLNVJrLwYiEIwYzrQk+2HqNmN0jf/h+Z/rGhKVaLYE6L8GjozNm+/D1ktCR+n7ty8IBcnBgWE/pPMVVM0szik9Q1rzXu6D36zeyn3gtDHDmQVURe4foDQyCYxnSdqUYA9R0qh6usdwDEkJ1E2fNWT4ipNj/1Est6iEuKqX78wwzg/skMT+EUzGfPG1kpc9ze747kjG6at+f8DTpHVSrqgSW1pSzJ4cV3Q4VzjXmeUE2jNcdowHHQ9ZIUf1MmkfMGvPS17snu2tJ6WEKo9EdrTBBKTDDJFKui8ww1nhrngiJltbhLxJ1Drk9fwTO5EcAwZsjTolFgBkXOSRiz++jTKkRclYROarf0cVi9IyxtXbGeiImpJosdm1T7DD7L0LY/cdIdlzGJvXb7hwAErzP3AAYTDoi+UDM+bToiJk62wMPbOgfkzoSIZPm+Yda1E1ChOAzGqFGaolKGx7RQXmLE7CeBIm7XsPqJS6YZ9+j6Sh/v+iP26NIcV/jwYqo6SVascuFg2zPmcbiSQxrCvd+2Zi8m6GpN9MPgStu/ISw2m3Qpwuqo2FrLyMxhg8hZcA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR11MB5429.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(39860400002)(136003)(376002)(346002)(396003)(6506007)(76116006)(66446008)(66946007)(478600001)(38100700002)(8936002)(26005)(5660300002)(6916009)(186003)(52536014)(66556008)(66476007)(2906002)(7696005)(316002)(33656002)(64756008)(122000001)(86362001)(7416002)(55016002)(83380400001)(71200400001)(54906003)(4326008)(9686003)(8676002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?He2/UC7ntyi9Lpa+sYqvrqHlQI9xF3FwzCNKb9OeBOnP/nadlsoSy18V/73I?=
 =?us-ascii?Q?sCNFuCLECVk46nFL/JfEVGCxqb5+VRHmZzvECaHb2vTI+ZtbFk1i/DaA4Sgq?=
 =?us-ascii?Q?sOPnCduFysT34Itu4V776o9vMgQejcMNKxNsg1XGgiXKInWQopfPndPJN9W4?=
 =?us-ascii?Q?SFFy2gGBJZwDGDkBdVmu7NpVe7/PYF5ixc68yf7v2kbE8y4y/1jJ7U5enEmW?=
 =?us-ascii?Q?9MxJMWh9k0K9qB1QSocveHdYghmU1iT3NgsnFWFNbTBs2bqAaAO2IEYVI3VC?=
 =?us-ascii?Q?LmhHom9D5qU7aD/y2A+Nv6cykTnKDYUHZupYoFkP5zhu5JFHfDKvkRKhCNNc?=
 =?us-ascii?Q?Sco638Cy87nyKd2oXAQMWJJfR7KwYz+NAq1rxrjDdQvYImGNtjLNqbprLAo1?=
 =?us-ascii?Q?Y9LoyFSHWhbB1lAvzF/h7fLOep8uk+0NDdXb0ZxRd4RYmvPczTNpsX4vdReW?=
 =?us-ascii?Q?sd3Jy9pRddkfNHYb/4kaFJBjmjITvyNvozDSwqS1A2zjcDqKBk1TtpDGCo1L?=
 =?us-ascii?Q?U4M2hQUZLtDFPGwePE17vSJ7mn9tovcGEmEkRCS89pCtXqg9/H1DZnv3E7NQ?=
 =?us-ascii?Q?9UF8zdF6LBRfIMXEHSGu2H1O0HAxIJaDBCT/whxt/bZiMzQWLtQPZ7Vt71z3?=
 =?us-ascii?Q?o9B4qsJ2Y6/nQaQxVt8J9798qj3qxFtf3Lp1Xfsz3HvTJmuyGojIrW4GgTrO?=
 =?us-ascii?Q?EzKLhT/6SvY+rDh3X5d+Y8gskxKk88crOawfMPkGkG44nA6LhNBwcaeURAtT?=
 =?us-ascii?Q?tEtPgQJ4RutQ9oJrcAC1OemYoB0iTdgiB3HtcjW+WrjsCqZHXBZxJlrXACc1?=
 =?us-ascii?Q?Lpod6li7vEb/QS+H2C5hsOtxePHvKYZWQnPPhibIMSClWKMdl0Hk7wYtNkkS?=
 =?us-ascii?Q?y1nw1bdO1stnC01Cben28Qf0yFVUzygngpXBKb3kxtKXmnWUU0eA7UPJFSIj?=
 =?us-ascii?Q?iJkfqL5Uo0DEMyYS/6Hqc/nQmkZouaAWiEtEXX970ZkICcP2KLS/HC2iMCBe?=
 =?us-ascii?Q?MHkUMNd4wENECTfOBqx/HTdSpqdvAk2yDh18PrlisoDjN550klEIYh5p4C/m?=
 =?us-ascii?Q?O+Zm8uu9S3B2TuHWEeB3Ie3Wc5DajmqNYrWFEWlyEPyvw77TddNc4hUfRm8D?=
 =?us-ascii?Q?BCYqHkaOX2ovxLhgWjrQ487Nl26ucI9vTnb3gVvOU2tzElPXBucq7jwBpJkt?=
 =?us-ascii?Q?hZfRlxy+N4+RZSkRCFe6+phXbB01I+8i/COyyW4+LKVIBncDW0hwMfsrE32C?=
 =?us-ascii?Q?0OG2diQWHlhmGJMBTZp4J7WZCBChOqYh+lAxIUdaPLzCVNU65dqvyQwnU/Ez?=
 =?us-ascii?Q?N1fl0Uuw4Iotjnfuzlk/ZgNb?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5429.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0964f565-9bdf-4bb4-bb8a-08d94590a7c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2021 23:56:24.1006 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kKrUaJu/fT/jXQPNMrBZw1qE3dEe0kdyTnJyQD63iOSTfjt6mq5lbROV9c1s1yJPwgGBjAfL60psCj8kyy3A7w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4743
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 Jason Wang <jasowang@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@nvidia.com>,
 "parav@mellanox.com" <parav@mellanox.com>, "Enrico Weigelt,
 metux IT consult" <lkml@metux.net>, David Gibson <david@gibson.dropbear.id.au>,
 Robin Murphy <robin.murphy@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Shenming Lu <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>
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
> Sent: Tuesday, July 13, 2021 2:42 AM
> 
> On Mon, 12 Jul 2021 01:22:11 +0000
> "Tian, Kevin" <kevin.tian@intel.com> wrote:
> > > From: Alex Williamson <alex.williamson@redhat.com>
> > > Sent: Saturday, July 10, 2021 5:51 AM
> > > On Fri, 9 Jul 2021 07:48:44 +0000
> > > "Tian, Kevin" <kevin.tian@intel.com> wrote:
> 
> > > > For mdev the struct device should be the pointer to the parent device.
> > >
> > > I don't get how iommu_register_device() differentiates an mdev from a
> > > pdev in this case.
> >
> > via device cookie.
> 
> 
> Let me re-add this section for more context:
> 
> > 3. Sample structures and helper functions
> > --------------------------------------------------------
> >
> > Three helper functions are provided to support VFIO_BIND_IOMMU_FD:
> >
> > 	struct iommu_ctx *iommu_ctx_fdget(int fd);
> > 	struct iommu_dev *iommu_register_device(struct iommu_ctx *ctx,
> > 		struct device *device, u64 cookie);
> > 	int iommu_unregister_device(struct iommu_dev *dev);
> >
> > An iommu_ctx is created for each fd:
> >
> > 	struct iommu_ctx {
> > 		// a list of allocated IOASID data's
> > 		struct xarray		ioasid_xa;
> >
> > 		// a list of registered devices
> > 		struct xarray		dev_xa;
> > 	};
> >
> > Later some group-tracking fields will be also introduced to support
> > multi-devices group.
> >
> > Each registered device is represented by iommu_dev:
> >
> > 	struct iommu_dev {
> > 		struct iommu_ctx	*ctx;
> > 		// always be the physical device
> > 		struct device 		*device;
> > 		u64			cookie;
> > 		struct kref		kref;
> > 	};
> >
> > A successful binding establishes a security context for the bound
> > device and returns struct iommu_dev pointer to the caller. After this
> > point, the user is allowed to query device capabilities via IOMMU_
> > DEVICE_GET_INFO.
> >
> > For mdev the struct device should be the pointer to the parent device.
> 
> 
> So we'll have a VFIO_DEVICE_BIND_IOMMU_FD ioctl where the user
> provides
> the iommu_fd and a cookie.  vfio will use iommu_ctx_fdget() to get an
> iommu_ctx* for that iommu_fd, then we'll call iommu_register_device()
> using that iommu_ctx* we got from the iommu_fd, the cookie provided by
> the user, and for an mdev, the parent of the device the user owns
> (the device_fd on which this ioctl is called)...
> 
> How does an arbitrary user provided cookie let you differentiate that
> the request is actually for an mdev versus the parent device itself?
> 

Maybe I misunderstood your question. Are you specifically worried
about establishing the security context for a mdev vs. for its parent?
At least in concept we should not change the security context of
the parent if this binding call is just for the mdev. And for mdev it will be
 in a security context as long as the associated PASID entry is disabled 
at the binding time. If this is the case, possibly we also need VFIO to 
provide defPASID marking the mdev when calling iommu_register_device()
then IOMMU fd also provides defPASID when calling IOMMU API to
establish the security context.

Thanks,
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
