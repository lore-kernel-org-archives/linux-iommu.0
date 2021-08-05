Return-Path: <SRS0=+AsR=M4=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9F9C4320A
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 00:37:04 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38A0B61040
	for <iommu@archiver.kernel.org>; Thu,  5 Aug 2021 00:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 38A0B61040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E83EE40385;
	Thu,  5 Aug 2021 00:37:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rMt3Xw2UKYz9; Thu,  5 Aug 2021 00:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 98B5B40379;
	Thu,  5 Aug 2021 00:37:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B156C001A;
	Thu,  5 Aug 2021 00:37:02 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5389EC000E
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 00:37:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2B0D240383
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 00:37:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tFPQl9l7yLAA for <iommu@lists.linux-foundation.org>;
 Thu,  5 Aug 2021 00:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 030D640379
 for <iommu@lists.linux-foundation.org>; Thu,  5 Aug 2021 00:36:59 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10066"; a="201226071"
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; d="scan'208";a="201226071"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Aug 2021 17:36:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; d="scan'208";a="668524399"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
 by fmsmga006.fm.intel.com with ESMTP; 04 Aug 2021 17:36:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 4 Aug 2021 17:36:39 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10; Wed, 4 Aug 2021 17:36:38 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.10 via Frontend Transport; Wed, 4 Aug 2021 17:36:38 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2242.10; Wed, 4 Aug 2021 17:36:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnMLB1GsdNPGZs5OjZezIGGMTiRJBAAlz2QqsvnDQtvA1SuNOQs70xGI+7FrEoupxvUJQoCdpurhdUnSHWB09yf118bDsOyW/juXUFzz8GCd5LJClFESLT507Ghy/lQaDiNO38mEg7wgWA1AcU9CSCbuEJULduXrNED7Kf34nwxGPKKbWDV470HXrTgSNBEVWPKbM9mkysA0DpNltnxkxYnfETY+Z+6GR8e/nXqg9QY8veulL4hjaITa2dN9x1fAxEENggRvtNMflYlOFKlzKvWzIUWLYfc9DfCYq7MkyDF78bCAOTHzg+mDvlso+/6DI6vDG0xvZEiVSdEfAzcCsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqv34iTwzse7AYCVgD5ayZvqk+eLcaqEzlyGXC7lCN0=;
 b=JDEZSmv35Gozfks2t640Hhkz5z4o+3/IOCu5LS5SaTNav537OKRkWHG/C7YG72J5eXGsilkAuPy9lLZkD9UuGaCkQIP92hW4OuGi3ttX9d981PIwBEZgyImbsGlxgr1tKyroGBwQ45S2EJZt23K1RSw6YNL1fUvZSqOOl5+jatq5vJ+ZaSclqf3mUHdtE+eG+uDMkvmMhwOFVElXE/AFzdogYoAM9qdVyexNcgBw1EDID9E9NzhA5c89Fas8rD94I0SWkPW357P3Yz90sZXZRUvUaeL35GdsQwjxJ54/4nW19C0zzFInr767p8II1BaUbS8XkB0KqPyLjoaoYC6Aqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tqv34iTwzse7AYCVgD5ayZvqk+eLcaqEzlyGXC7lCN0=;
 b=HCQeZsqXtbG5h1bVyxf3S5Ly0xe4R1dJ/m1u297QP3p/0yoJzkPhSxpibA/RUPWMm2wUycCZnC/3ZwU8lXdBsAh/yzcagHDhVaCpXjkEzS5ca+eiPyflbreY75Uumuhoau6h1JTK0+VuIxfcvoyyZcwrv5cAPjXqznITUVI+fBI=
Received: from BN9PR11MB5433.namprd11.prod.outlook.com (2603:10b6:408:11e::13)
 by BN6PR11MB0052.namprd11.prod.outlook.com (2603:10b6:405:69::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18; Thu, 5 Aug
 2021 00:36:31 +0000
Received: from BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134]) by BN9PR11MB5433.namprd11.prod.outlook.com
 ([fe80::fd4b:cdde:6790:134%8]) with mapi id 15.20.4373.026; Thu, 5 Aug 2021
 00:36:31 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, Jason Gunthorpe
 <jgg@nvidia.com>, "Alex Williamson (alex.williamson@redhat.com)"
 <alex.williamson@redhat.com>, Jean-Philippe Brucker
 <jean-philippe@linaro.org>, David Gibson <david@gibson.dropbear.id.au>,
 "Jason Wang" <jasowang@redhat.com>, "parav@mellanox.com"
 <parav@mellanox.com>, "Enrico Weigelt, metux IT consult" <lkml@metux.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Shenming Lu <lushenming@huawei.com>,
 Joerg Roedel <joro@8bytes.org>
Subject: RE: [RFC v2] /dev/iommu uAPI proposal
Thread-Topic: [RFC v2] /dev/iommu uAPI proposal
Thread-Index: Add0lrMH87IsTsl5Rp6WN1oQU6kGMQUsvqiAAA+DMpA=
Date: Thu, 5 Aug 2021 00:36:31 +0000
Message-ID: <BN9PR11MB5433453DED3546F5011C3BDD8CF29@BN9PR11MB5433.namprd11.prod.outlook.com>
References: <BN9PR11MB5433B1E4AE5B0480369F97178C189@BN9PR11MB5433.namprd11.prod.outlook.com>
 <b83a25de-7c32-42c4-d99d-f7242cc9e2da@redhat.com>
In-Reply-To: <b83a25de-7c32-42c4-d99d-f7242cc9e2da@redhat.com>
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
x-ms-office365-filtering-correlation-id: 99b9db05-5617-493c-05ce-08d957a91263
x-ms-traffictypediagnostic: BN6PR11MB0052:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB005220D5E9EA93195214FA158CF29@BN6PR11MB0052.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sC+vaMd7e6/E9lvQuwRf4fGrwf9fUhV7quPOIDd7slkEkpHMJfQYjLVRJ4norL8E91L0eOaAI7NmDXIsSTA3y9AHo5bSB8zOaeXHsgvnkG5FATJNkK7Ao1C8AjTpPxoUImhmdzEMwxk13UZSHj87bn9Jpw36GhCY7gOo2rlmXPYGUFCIoWiClac9a8SbuEZcULeoYN08+duBugY+2bKY+5QREwD9GXuYgPVVI69TDE50YbK1rhNoKhx8aheU68rcAfknzMBJJOTcoLl1xI7yfY9HXlI8nJjwNdWNvK776bcM5vjnz6cVlOOpiFQuNZEYnZh7n8VNP5taltglKi6NOvGocd3RyO3mP7lp2tM/eSFTxkX6Cm/Qi3DVLFFvf0y+76Wy7wvlSVzmYPgBgTnjv0O3oXh5cgmWpiaJPDCF9KA5V8pOjU7cmNnjebBQYfb5NJ0zv4gQO2C7+r057MNU/0I79GBis/kQrY8kLNcSgAOiPOM6XCEKGu4w1Q5DhhgOBL2N2X3I6MPZFqoNTcuY+scENyQvl6myctmQhCxXR0ITWmCqbR2PtLb9RN+0fUic5dI0X2cMyQpvY+qYmt5kVc8U9vtLcR5WgOCZgMGkUJsGUsOFXRy0Dbc2L+AZMl7QBrPLz3bpLKcSDuQA0zqXmc1HWa3oAotoKpMtgJwgijp8ad9pSuu9FE+OaHaaGz2I7kKgqNCWXCousavGcMwlrdvwxA2dyN/Vh5dMSA7kXMM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN9PR11MB5433.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(396003)(39860400002)(136003)(376002)(186003)(54906003)(55016002)(921005)(33656002)(9686003)(8676002)(38100700002)(5660300002)(4326008)(71200400001)(122000001)(26005)(478600001)(83380400001)(110136005)(66446008)(76116006)(66476007)(66946007)(7696005)(64756008)(316002)(52536014)(7416002)(86362001)(2906002)(8936002)(6506007)(38070700005)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SEtFbkVWazdpZkV4TWttS1c0UjR5WWp4S1E2anZmUHd1NzVUTlJQL0lndmhL?=
 =?utf-8?B?RlZMaXZqVzMrekpMQXVTK3dHc1pKbXhnUzV5MEVIRlJ4enBES2ZkWEZ5aFZx?=
 =?utf-8?B?WEVjeFBuc21kWEtiWmV6YXZVZWJZcEFrQjFtbnZmSnp3WkQvQkV5Ymp2ZWlt?=
 =?utf-8?B?MW4zV2ZJWFBzWmZ5ZG02ME43V2hqRGxQR1BBRUFqUkh4RHJWVTVkTUFveXRr?=
 =?utf-8?B?WkZRK3l6WkRmdW1EeDlaWTRWOWlGekVpbktFZXc2ZFc4N00rczQ2RGw2MldX?=
 =?utf-8?B?SjBqeHJOdk5veVEwdUcyVXFtby9YdUw5S0tTZnAybHROdnhJbVMvZ25aMWk0?=
 =?utf-8?B?eTBlVkVSbHhPUWVEZWZ2U2V3TEcydGRXaVdMdjc0WklVeHdhMW5xckEwanR2?=
 =?utf-8?B?OUNjQ2JvMXYrZDFDKytBS0RKYzc0dGFxNUdWeU5PS09IbWlMczU2dTFULzBs?=
 =?utf-8?B?LzVOOHdjbTVFTE5zdlVKNXNOOHBPekw3MlBMWFY4OU5CYnJTN1l5RU9xQnFu?=
 =?utf-8?B?QjBnS2hqM3VlcDNyOVBGV1dMbE9meEpla2F6Mmdrdi9JRjVKZUU2VU1DYnF1?=
 =?utf-8?B?MjdRM0FRYjNuMnY3UUJXdTA2YTU1RTlVbzZkSHZqWnJtTEs2WUZaT0kzaEw0?=
 =?utf-8?B?RHhsdzZkM0xpS3dEamZQRFZkWXlWOUN2MEJ5SGxtQWYybHd6N3dqd21TeVhZ?=
 =?utf-8?B?WGRuK0E1WlNNSnlwL3lhSmdxSjJGV1NoZmw1WG8raW1KSzJmTzBzRVhXb2ZY?=
 =?utf-8?B?WTZ2KzJrSWhmUFIxZHQwN1BzWHlUOFhtcVpjY0N3R01BQkpjWXNBQVk3UG1s?=
 =?utf-8?B?eUNpMTFDNnZGMnp3Vi9CVVBwUzFRRUNmYjlWN3E2QmhNYlQyTTFtN29qeFY2?=
 =?utf-8?B?elFZdFE3LzFCOG5LWkh0MW1IdFRMWlpHQ01OVm1iUWZzczdKQW9PamJwa2Zk?=
 =?utf-8?B?aGVqYU9oOHJ6SDdQV3RRblhkL1RjY0pSOGVKMTRKdlVuK3VBNSs5S0ExMnJs?=
 =?utf-8?B?UTU4MXVBNWdwZ0F4MGFOYm9mK3RLakovZXFpSHpPSFQzY00zUlVSVFlsc2FI?=
 =?utf-8?B?NHJSL2xOYXpqbnlqYlpjWEVKakdHUDFYWFVLMUZzLys0dXlnVkdGckdHUUpZ?=
 =?utf-8?B?UThLcjI5ZWhMWml0eHZWNGN2cE5obVIyS3YrRDRnbVFHa0FLRVdCL2hGL1Yx?=
 =?utf-8?B?QnIvcXFiUUxFUWIzQ2hNcHN0QXhYY3ZCSlF5UkNrOXNjYzFTQ3ZDVFloajVI?=
 =?utf-8?B?Y3hWNmxUTTVjWklSdFFYaUE5ZVkxbmg0MXVKRWt5Q1NDSHZ1M1FHOFJVRWVy?=
 =?utf-8?B?d3hNc3pRci9KRFFWU0h5R0RDNFJPVVFzK0VZcTN0NnBMVk56UHlmOWl0RXho?=
 =?utf-8?B?MmNYT0dNcU15L0Q1Sy9NY0tibm5PdUJJVExlTDJNRG5LMzdoYkhCelhHTXZS?=
 =?utf-8?B?R3htc3Jrc1FLT0RhcldobldlZGY3MjRKZG56d2VGWEFTMDBGY3pHUzc5ODYz?=
 =?utf-8?B?SStCOHRldnFGczhUNHREZVYrVVNFeTFzcmFkTDZsNU82YXZUR0RicDQvVmxR?=
 =?utf-8?B?OG14TzJITTF5VElQSjVxVjNOSFNwa2Q0Wll1VkVYc2lScno0amJoeVRLRi9m?=
 =?utf-8?B?d2ZSUHNpNzJ5TC8vOFlXbzZmemV4R25KU0J1TSs4ejE0cDVIc2hYSDloRHgw?=
 =?utf-8?B?bWxUVXpVaDJmWVNKb0lMVm92TFRRUEpmVXlXTUNJYzJoeVIrcWN3V1E4Wktv?=
 =?utf-8?Q?tewOi+f/RDrsOQeTfdnyMOracCg2pvSeuq9Xqpj?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5433.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99b9db05-5617-493c-05ce-08d957a91263
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2021 00:36:31.7741 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hP9+T6Guj3C4O6WtBDCLviPFBPMiZB/gGeKRA9INiOXsf4AItm9y5WBwHtMshclnhYyxbxpSGRbOwXZknctQdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB0052
X-OriginatorOrg: intel.com
Cc: "Jiang, Dave" <dave.jiang@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 David Woodhouse <dwmw2@infradead.org>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Kirti
 Wankhede <kwankhede@nvidia.com>, Robin Murphy <robin.murphy@arm.com>
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

> From: Eric Auger <eric.auger@redhat.com>
> Sent: Wednesday, August 4, 2021 11:59 PM
>
[...] 
> > 1.2. Attach Device to I/O address space
> > +++++++++++++++++++++++++++++++++++++++
> >
> > Device attach/bind is initiated through passthrough framework uAPI.
> >
> > Device attaching is allowed only after a device is successfully bound to
> > the IOMMU fd. User should provide a device cookie when binding the
> > device through VFIO uAPI. This cookie is used when the user queries
> > device capability/format, issues per-device iotlb invalidation and
> > receives per-device I/O page fault data via IOMMU fd.
> >
> > Successful binding puts the device into a security context which isolates
> > its DMA from the rest system. VFIO should not allow user to access the
> s/from the rest system/from the rest of the system
> > device before binding is completed. Similarly, VFIO should prevent the
> > user from unbinding the device before user access is withdrawn.
> With Intel scalable IOV, I understand you could assign an RID/PASID to
> one VM and another one to another VM (which is not the case for ARM). Is
> it a targetted use case?How would it be handled? Is it related to the
> sub-groups evoked hereafter?

Not related to sub-group. Each mdev is bound to the IOMMU fd respectively
with the defPASID which represents the mdev.

> 
> Actually all devices bound to an IOMMU fd should have the same parent
> I/O address space or root address space, am I correct? If so, maybe add
> this comment explicitly?

in most cases yes but it's not mandatory. multiple roots are allowed
(e.g. with vIOMMU but no nesting).

[...]
> > The device in the /dev/iommu context always refers to a physical one
> > (pdev) which is identifiable via RID. Physically each pdev can support
> > one default I/O address space (routed via RID) and optionally multiple
> > non-default I/O address spaces (via RID+PASID).
> >
> > The device in VFIO context is a logic concept, being either a physical
> > device (pdev) or mediated device (mdev or subdev). Each vfio device
> > is represented by RID+cookie in IOMMU fd. User is allowed to create
> > one default I/O address space (routed by vRID from user p.o.v) per
> > each vfio_device.
> The concept of default address space is not fully clear for me. I
> currently understand this is a
> root address space (not nesting). Is that coorect.This may need
> clarification.

w/o PASID there is only one address space (either GPA or GIOVA)
per device. This one is called default. whether it's root is orthogonal
(e.g. GIOVA could be also nested) to the device view of this space.

w/ PASID additional address spaces can be targeted by the device.
those are called non-default.

I could also rename default to RID address space and non-default to 
RID+PASID address space if doing so makes it clearer.

> > VFIO decides the routing information for this default
> > space based on device type:
> >
> > 1)  pdev, routed via RID;
> >
> > 2)  mdev/subdev with IOMMU-enforced DMA isolation, routed via
> >     the parent's RID plus the PASID marking this mdev;
> >
> > 3)  a purely sw-mediated device (sw mdev), no routing required i.e. no
> >     need to install the I/O page table in the IOMMU. sw mdev just uses
> >     the metadata to assist its internal DMA isolation logic on top of
> >     the parent's IOMMU page table;
> Maybe you should introduce this concept of SW mediated device earlier
> because it seems to special case the way the attach behaves. I am
> especially refering to
> 
> "Successful attaching activates an I/O address space in the IOMMU, if the
> device is not purely software mediated"

makes sense.

> 
> >
> > In addition, VFIO may allow user to create additional I/O address spaces
> > on a vfio_device based on the hardware capability. In such case the user
> > has its own view of the virtual routing information (vPASID) when marking
> > these non-default address spaces.
> I do not catch what does mean "marking these non default address space".

as explained above, those non-default address spaces are identified/routed
via PASID. 

> >
> > 1.3. Group isolation
> > ++++++++++++++++++++
[...]
> >
> > 1)  A successful binding call for the first device in the group creates
> >     the security context for the entire group, by:
> >
> >     * Verifying group viability in a similar way as VFIO does;
> >
> >     * Calling IOMMU-API to move the group into a block-dma state,
> >       which makes all devices in the group attached to an block-dma
> >       domain with an empty I/O page table;
> this block-dma state/domain would deserve to be better defined (I know
> you already evoked it in 1.1 with the dma mapping protocol though)
> activates an empty I/O page table in the IOMMU (if the device is not
> purely SW mediated)?

sure. some explanations are scattered in following paragraph, but I
can consider to further clarify it.

> How does that relate to the default address space? Is it the same?

different. this block-dma domain doesn't hold any valid mapping. The
default address space is represented by a normal unmanaged domain.
the ioasid attaching operation will detach the device from the block-dma
domain and then attach it to the target ioasid.

> >
> > 2. uAPI Proposal
> > ----------------------
[...]
> > /*
> >   * Allocate an IOASID.
> >   *
> >   * IOASID is the FD-local software handle representing an I/O address
> >   * space. Each IOASID is associated with a single I/O page table. User
> >   * must call this ioctl to get an IOASID for every I/O address space that is
> >   * intended to be tracked by the kernel.
> >   *
> >   * User needs to specify the attributes of the IOASID and associated
> >   * I/O page table format information according to one or multiple devices
> >   * which will be attached to this IOASID right after. The I/O page table
> >   * is activated in the IOMMU when it's attached by a device. Incompatible
> 
> .. if not SW mediated
> >   * format between device and IOASID will lead to attaching failure.
> >   *
> >   * The root IOASID should always have a kernel-managed I/O page
> >   * table for safety. Locked page accounting is also conducted on the root.
> The definition of root IOASID is not easily found in this spec. Maybe
> this would deserve some clarification.

make sense.

and thanks for other typo-related comments.

Thanks
Kevin
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
