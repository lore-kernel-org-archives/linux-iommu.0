Return-Path: <SRS0=iLkC=PQ=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFED1C433EF
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 02:07:57 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F1596023B
	for <iommu@archiver.kernel.org>; Thu, 28 Oct 2021 02:07:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6F1596023B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2BC1C824C1;
	Thu, 28 Oct 2021 02:07:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alT2-EsBbEiw; Thu, 28 Oct 2021 02:07:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id E854C82479;
	Thu, 28 Oct 2021 02:07:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BF45EC0019;
	Thu, 28 Oct 2021 02:07:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27435C000E
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 02:07:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 109B6400F1
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 02:07:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=intel.onmicrosoft.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5z4KiZwZ2Ykh for <iommu@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:07:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B9B6400E6
 for <iommu@lists.linux-foundation.org>; Thu, 28 Oct 2021 02:07:54 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10150"; a="230162514"
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; d="scan'208";a="230162514"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2021 19:07:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,188,1631602800"; d="scan'208";a="498160685"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga008.jf.intel.com with ESMTP; 27 Oct 2021 19:07:53 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Wed, 27 Oct 2021 19:07:53 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12 via Frontend Transport; Wed, 27 Oct 2021 19:07:52 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.173)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.12; Wed, 27 Oct 2021 19:07:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ozd7K773CS0qA/cTTNXYcb0+YaChtkoiatA164ieWlRWU4ZfVonns9R1djeQ1trlD15HdRfK4YCyKN4P+Q8l8MK7UHjfsw8Cy6OHO6IOtZGvU+7Vg+qonISyX7vCrzBtWTeTkdEtCvJvZeo2htzVBteOaAfzwSBPQ3ZNrES+rGPyJGdEV4Erj2ffsq8bQnTcsTNBshnWye6xUuzPyC5hwu7P9lX6sQ75jX6k2CAOy6Iyhidm4rHhQb0QUdqKhAV8kuZEyGeOoimukOb58zetSjyVdSowGJyGMsPOayZXh7pOh1a/hRDrqT324imklNtBpk/Ldit2STbKBROxikMtEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+WGW91mYfszMEpTePqiAdGR8Xy6+jjeAxFjVnsvPxAY=;
 b=jzSFwkus6V2TUDx6cFtp7zQ9JpXmQFV7NbFHpTcj8rgStHdOe5QWl/h/ZiPIY8d3wjxcsg7OMiaRpOVV2JWjqFikjvi1pnLtrbFiJ9QzV0Uu8d4v8hqk6dcPvR9FByLNVpa8LOclklymVxOhuY1QisFKWB3d4AUXkZ2ESNG9pjswkB4ZfuYnn4ZhuRWf5QGOi1tDlyuNygVO5NElJtFWHHyNKH1GiaTHqTOe2SKS8gzdzKQmGpkzd7LhMRrR1Tq290C+6/XinmvZ5plY4+JhlLWedPhM65O6k0cf3uWd3y+PwK+4hZjF4iSATEneZQtKE3lKwWjkaZCjqkTV04yZhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+WGW91mYfszMEpTePqiAdGR8Xy6+jjeAxFjVnsvPxAY=;
 b=lggHWBfetiouJezS5no48oxg09Ye/3ocLD5DkSEs5b80oH484SfQO5pMh1AzgoD8uWanxcX5U98Q/mxCD2H+l0XIpEcorQq672jBxBkGxN7YTvmYi/ULpIHYLtNXSEAzNSfB59km2pwoe6j5zoUZ3WzmyDqrXkYMhb3KePREGmY=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN9PR11MB5420.namprd11.prod.outlook.com (2603:10b6:408:101::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4649.13; Thu, 28 Oct
 2021 02:07:46 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::ecad:62e1:bab9:ac81%7]) with mapi id 15.20.4649.014; Thu, 28 Oct 2021
 02:07:46 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: RE: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Topic: [RFC 10/20] iommu/iommufd: Add IOMMU_DEVICE_GET_INFO
Thread-Index: AQHXrSGNbNtRgavabUSKJjvt8l12BauwlhaAgAAouwCAACufAIAAEL4QgACKr4CACtdfoIAA3DaAgBUX8GCAAHivgIAAl4FggAl6ZNCAAXETAIAAHLdQgAYt1oCAA0rdUA==
Date: Thu, 28 Oct 2021 02:07:46 +0000
Message-ID: <BN9PR11MB5433E2A78648049A41C484B78C869@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB54333BDB1E58387FD9999DF18CA39@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210923114219.GG964074@nvidia.com>
 <BN9PR11MB5433519229319BA951CA97638CAA9@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20210930222355.GH964074@nvidia.com>
 <BN9PR11MB5433530032DC8400B71FCB788CB89@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211014154259.GT2744544@nvidia.com>
 <BN9PR11MB543327BB6D58AEF91AD2C9D18CB99@BN9PR11MB5433.namprd11.prod.outlook.com>
 <BL1PR11MB5429973588E4FBCEC8F519A88CBF9@BL1PR11MB5429.namprd11.prod.outlook.com>
 <20211021233036.GN2744544@nvidia.com>
 <BN9PR11MB5433482C3754A8A383C3B6298C809@BN9PR11MB5433.namprd11.prod.outlook.com>
 <20211025233459.GM2744544@nvidia.com>
In-Reply-To: <20211025233459.GM2744544@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-version: 11.6.200.16
dlp-product: dlpe-windows
dlp-reaction: no-action
authentication-results: nvidia.com; dkim=none (message not signed)
 header.d=none;nvidia.com; dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e1b8675b-9cf1-4667-615f-08d999b7bc11
x-ms-traffictypediagnostic: BN9PR11MB5420:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-microsoft-antispam-prvs: <BN9PR11MB5420B8388671EA7622FEA47C8C869@BN9PR11MB5420.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4qiggXGZAz8GAKUZnuhavMWZ7d4UwOIdUlUOPgzze9vyLlh597BH2ScjxUOhHi3bi17qDeXbgo4u2keQH5rVRxI7gyjRKOo2j+a0pPy67M0uEHDqSPdbzuD6sBKlCPpYjCtiu+x22JDHP6kUHfQ7OuSbux3n7s1oUNIMgVz7k3rt8sXtD7+4wQMMVNexEfjNJZvjlqdJFSRfaHK7gmGKzefb2lxSF/nACXutv5+nzvvqxTGB9QQQPSxYzMbkcnS3E3V1rcxCjSYDeAnl7p0EJ2HQvI+bkewMy30P4Xpo1PbBVMInztFMyL8X/E+f1bKvSw/RQkyOvyLQ94P5quKqUjgZeBKJjIiDjXIhzEBwcUI4olFu9DFpV1oJIcGOQCDl1S3BF7hDmXD4oh8xZwnDYs7DKkpCFfho80Xco76HUNL9f5sihVM8Do6XnZWYdYZ6/XZwjSUXRFsJt/M7RPG+n0Byo2mSsQDoV3NNzu+g9GhhNFH/1mV0b/u90srMddlMF/k7bq+9qCGT9npCdLxsJ8YRW9F4F7ryMmJwXnOLRbNPFGT+jxB9iOVrN7K9vDU/JnNXyt/GFTzFy2j/0yRmBz7gNgP1yj0qIeioFkynnu/1r7VjChxHVfcah43fMOeO42VOeGlNl8AxI5DTzDcjgNiRGRybHupV8m7caPzfKQo+RRHdbeqegAuV1YZh+mDSPkAfloOEJwCDsdhLSXFS1Q==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(366004)(7416002)(83380400001)(7696005)(64756008)(66446008)(55016002)(6506007)(4326008)(38100700002)(52536014)(122000001)(71200400001)(316002)(38070700005)(2906002)(8936002)(86362001)(186003)(5660300002)(26005)(66556008)(66946007)(76116006)(8676002)(508600001)(82960400001)(6916009)(9686003)(54906003)(33656002)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?xKecstFExDz/ccZ2yuEGrzZvJxRNBPStwOxdKdkoY3csPgM9ehsKfpr9CxPZ?=
 =?us-ascii?Q?Au96+e0MnRh+8oL3bUKFyWS7I9wWLQDo0uW9IlPuSY2u2qqky8zw8EoHfn/n?=
 =?us-ascii?Q?VhcpxMEJMErJF+AiGc9VUGfhViq6UeNzIGMlFqqvkkHVG35SNHai3tHWLqCU?=
 =?us-ascii?Q?Z4421x4xG31WsTQvFLGdTfLo0JHS8bu7H7gk578Mn8O8ZIKXpuHSKpcLyKY2?=
 =?us-ascii?Q?QVv52NEIPTUpW7SKTdpUMGjEsYAoxVICihdmQeRMJ1Hki2NjBI2QYcGy/QF1?=
 =?us-ascii?Q?eWMzMrMPSM1AIx2u3y7KkZk+VJ+pjKH4NsD1f2EfbA9TsxXn/DUz1QlM30LT?=
 =?us-ascii?Q?LrmZDpM5BcBYEJUjRVXPhLbUaSRgl+x2G9OwFZ3bN5RF+0iNbEu3ztH/9+ov?=
 =?us-ascii?Q?EtfZNPtM0zkGiNhz8WXT1kKRz5zCMn00vpk1xVIkAGnjBZYcjgbb3HYfpzGZ?=
 =?us-ascii?Q?xm2yQp+nS+C+m9eZlY9acmNNx04OVzNoWrmYV7rEHe6egV6bzX4T1s+eK2NP?=
 =?us-ascii?Q?/9Q6Op7AwWul8bz4OvHoHrVvXSdkvzZqsjs9pvP4upQWNVtPcRJICQO8NOuC?=
 =?us-ascii?Q?er48tAEDcRvqNqSNife1LYb7ABmxOKPP4AbO6A+CHi4UT2XLxTVDGrm+NYnx?=
 =?us-ascii?Q?Lf4bpvUg9P0fDUG49A1JHhS0lUVol8EjZTyKZmYKxzNaE4ejJ95mpXvLN0WA?=
 =?us-ascii?Q?eE8HLvshFBcDwBnM25x88leaHOYGmxFDO6/d0de0hh/AuduOPqB1EmNQHg3e?=
 =?us-ascii?Q?gGoCFDRAH9swPnnvrrTb+y4cuThNbNaPHbaiinhsEoy8HDx5a6yH7Q46oT7e?=
 =?us-ascii?Q?IRpc1tp0k36K711iEvkslJFtYuWFujhEDh7L8Kv16h8I2IbfactVjy4GuMxT?=
 =?us-ascii?Q?tLe7aXHQI1spGpgSRxZExwxmxqTdQjszYkvHu9NizP04EB2++xue9OAP7bO8?=
 =?us-ascii?Q?WxK8cTaZD7yvoHBNMz15jvO3sEDmnTq6JS4S3iCfJlHAP//KbfEaPpXKR7q7?=
 =?us-ascii?Q?t7RP8zALve+umVuBslLsQD8qXeRi08fzgaUFxORNcqywwXYEHnTDgS/cccUx?=
 =?us-ascii?Q?DlLQ80CGZl5NleAfISNOukTzSw8PC8ARd9jI8u5QCybp79k15qFc798clTVY?=
 =?us-ascii?Q?H6z+Kr8E3Pk9gxVMq/VpK14EGXuqJ2CMR9xftNX9+xZy/QpqtlB4U9kM1W+n?=
 =?us-ascii?Q?RsapTXGgQtL8s035j/nobKq2sZEE0UVafU0DmJzbHCFYiUtp2D0mYluVv+fp?=
 =?us-ascii?Q?MeWIhr0O0uso2QFz74zXo9rr/Hq/K230pa9xNiWzf1DlZmhHT60b5IxJaEa/?=
 =?us-ascii?Q?ZtnAdnmeHJpFN2RS489HooFCOrTTJIfvQwLujtR2NmcloyF+I5iIgI0OBpF5?=
 =?us-ascii?Q?RWHTy3kOgU7/uBVkuwvUnHxmBiwLdKLwDGdbrOtMTeVME7y3xXDKuXo2ovkF?=
 =?us-ascii?Q?L7A07jF+EOaItlMtUS+5dZfPJbI8XnruI8l7QLvGC2r6aJWExacArtHthgJi?=
 =?us-ascii?Q?zWCOgfgFhNlr8U9sdaTfkZRpjimOMHITSwrYN5PWIs+WIQCYFAb5xJ4YiFgp?=
 =?us-ascii?Q?KkplVmScMaYiK2nuhaKuGwXlvrZ9GzVCPEP+iDqQFiQsJOPBsaNvxJM4gQDR?=
 =?us-ascii?Q?zWnv6nvkom1RohJ0fg/Y0lk=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b8675b-9cf1-4667-615f-08d999b7bc11
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Oct 2021 02:07:46.0407 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACeEfeGiDUy4o6UmIbFfByDaW71eo6jyvNxQLbtwVRupXuwFvDB1uZQjIPMfGpke24keXNnjI1kuUw8XusdfLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5420
X-OriginatorOrg: intel.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "kwankhede@nvidia.com" <kwankhede@nvidia.com>, "hch@lst.de" <hch@lst.de>,
 "jean-philippe@linaro.org" <jean-philippe@linaro.org>, "Jiang,
 Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "corbet@lwn.net" <corbet@lwn.net>, "parav@mellanox.com" <parav@mellanox.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 "lkml@metux.net" <lkml@metux.net>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>, "Tian,
 Jun J" <jun.j.tian@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lushenming@huawei.com" <lushenming@huawei.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "robin.murphy@arm.com" <robin.murphy@arm.com>
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
> Sent: Tuesday, October 26, 2021 7:35 AM
> 
> On Fri, Oct 22, 2021 at 03:08:06AM +0000, Tian, Kevin wrote:
> 
> > > I have no idea what security model makes sense for wbinvd, that is the
> > > major question you have to answer.
> >
> > wbinvd flushes the entire cache in local cpu. It's more a performance
> > isolation problem but nothing can prevent it once the user is allowed
> > to call this ioctl. This is the main reason why wbinvd is a privileged
> > instruction and is emulated by kvm as a nop unless an assigned device
> > has no-snoop requirement. alternatively the user may call clflush
> > which is unprivileged and can invalidate a specific cache line, though
> > not efficient for flushing a big buffer.
> >
> > One tricky thing is that the process might be scheduled to different
> > cpus between writing buffers and calling wbinvd ioctl. Since wbvind
> > only has local behavior, it requires the ioctl to call wbinvd on all
> > cpus that this process has previously been scheduled on.
> 
> That is such a hassle, you may want to re-open this with the kvm
> people as it seems ARM also has different behavior between VM and
> process here.
> 
> The ideal is already not being met, so maybe we can keep special
> casing cache ops?
> 

Now Paolo confirmed wbinvd ioctl is just a thought experiment. 

Then Jason, want to have a clarification on 'keep special casing' here.

Did you mean adopting the vfio model which neither allows the user
to decide no-snoop format nor provides a wbinvd ioctl for the user
to manage buffers used for no-snoop traffic, or still wanting the user 
to decide no-snoop format but not implementing a wbinvd ioctl?

The latter option sounds a bit incomplete from uAPI p.o.v. but it
allows us to stay with one-format-one-ioas policy. And anyway the
userspace can still call clflush to do cacheline-based invalidation,
if necessary.

The former option would force us to support multi-formats-one-ioas.

either case it's iommufd which decides and tells kvm whether wbinvd 
is allowed for a process. 

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
