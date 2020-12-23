Return-Path: <SRS0=5yIV=F3=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F83FC433DB
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 03:59:37 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248DF22518
	for <iommu@archiver.kernel.org>; Wed, 23 Dec 2020 03:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248DF22518
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CA5B7872CF;
	Wed, 23 Dec 2020 03:59:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zpsJnenr1pNs; Wed, 23 Dec 2020 03:59:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF8D5872B7;
	Wed, 23 Dec 2020 03:59:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3430C1787;
	Wed, 23 Dec 2020 03:59:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08A15C0893
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:59:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id F34738558F
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:59:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dvfj4JlOK5zf for <iommu@lists.linux-foundation.org>;
 Wed, 23 Dec 2020 03:59:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DD6488558A
 for <iommu@lists.linux-foundation.org>; Wed, 23 Dec 2020 03:59:32 +0000 (UTC)
IronPort-SDR: Fp7P0tWNtCpqRCisOqTsXACbAu+Gy4NpRw6U2+ZU6W3rQEh/8qA7wxwyPWyyA9UO91RZIjLvxb
 JUaIWuYN+Jbw==
X-IronPort-AV: E=McAfee;i="6000,8403,9843"; a="163680677"
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="163680677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Dec 2020 19:59:30 -0800
IronPort-SDR: f7fwjzrlZ7d1calEUgZyu7zHxvSaXYQoea6+vyI9ObXThkMTJWMHI/Ad7O5t3I5JDkIOJ6JYqo
 8a7VkgH56j/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,441,1599548400"; d="scan'208";a="342046357"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga003.jf.intel.com with ESMTP; 22 Dec 2020 19:59:30 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 22 Dec 2020 19:59:29 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 22 Dec 2020 19:59:29 -0800
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (104.47.37.59) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Tue, 22 Dec 2020 19:59:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg05siDC2a+FO+YkuCZMlNgaQYJyv5r1r/Odj8tnAAcwrkz4taexqCYob/dIr26rhqF2khL1EiZuUKz6FDOL0HJFegzC9bmRT9G0PGudQ6l87DR+rsLM0dHJrM+4t+5YAx0hmyEgHF42wEm3gq6rszCNVvVOaF0NE41tvb5nwo4kAP3rs/KBL04NCIGAZjqpx0k0pF6W8peQqrxUgO/j88JbyzStNffnP1+pLNn+yibxRBmDnC7jVE9jMs+8+yZs1qVAH+Vij1u4Jxy/zEIU6zs6pDJtZacfbdds9MUCTAxR5vztO4KXkEgtwh/62a6vHzCnxCw+WWQWp7HqOVCOYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBvBj3BYjfP2uSLuo28ojjAf43ZZE2aYelZYJnu+6/I=;
 b=CYDiPxHsxVHzxEL2pcW5WR0V79zLR/mB2WlWR82cAKYoxidNqu8BeSz9pIlGoNcH63jqxrsXDqw1oXktLIiqulLgQnE/ujtjm6IvCh3NgiBvi4spp9DTOa5eeDexgrgEw0TM5GfUSJ0W17DTa0DjYpNyTGuWIObbdRG0dOvxNOdMKsWtehZhtp7XiBUDCJ8nsm6J0cte4e5KIoaQ7D3nFvALKFRMbkjXRFFCH4fKoZapIhRJOMxiDz6QFO2qXJtALmbCfvzwRTlxy6UFjLmEvlagxvuO/HZFZzwTmXl5de42nP1b2B0qZZ7Vj7SU4T7C8RbgL/205eA+goQSwm76uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bBvBj3BYjfP2uSLuo28ojjAf43ZZE2aYelZYJnu+6/I=;
 b=Y99LtGGbu4UVWoJQ8KxIBJVJC9DgUrIN7RzFMPowY/n+iT0DaTCwWlNlkscSClBYgAYbRLTfiZrYLLjZ+ziPo43u/vkT0r0H2OlCZ2lJOr7QRYzVfXg8O9zz5RcApkmCK99Z2XKhm75nGU1BNSd7uhpft3EfS+Io++FAPKNhrI4=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB4347.namprd11.prod.outlook.com (2603:10b6:5:200::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3676.33; Wed, 23 Dec 2020 03:59:27 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3676.033; Wed, 23 Dec 2020
 03:59:27 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: "Pan, Jacob jun" <jacob.jun.pan@intel.com>
Subject: RE: [PATCH 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info.
Thread-Topic: [PATCH 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info.
Thread-Index: AQHW1ZqBJ3x1UHRRz0aA2JjJR7/K5aoDlNkAgAB/e1A=
Date: Wed, 23 Dec 2020 03:59:27 +0000
Message-ID: <DM5PR11MB1435173888D48C2C894E1603C3DE0@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201220000352.183523-1-yi.l.liu@intel.com>
 <20201220000352.183523-3-yi.l.liu@intel.com>
 <20201222122128.233d928d@jacob-builder>
In-Reply-To: <20201222122128.233d928d@jacob-builder>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.55.46.39]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 56a6e6ab-fada-47cc-568c-08d8a6f724af
x-ms-traffictypediagnostic: DM6PR11MB4347:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB4347D14EF5ABB5EC67282CCDC3DE0@DM6PR11MB4347.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lf5AgfzoxRcMyo6ZGYw3fgefntTuVvjeIpQI0bbRw+wCBi266LWOZEVs/3m2bl7TmLWIK01ivg8hRliKuMsShz9qFDtEjjMZUJPvAe6uBomDckaLPEoKbZFHJ1oxPn0O8+bBI8w1IMdAxGV9gpeG8Fo+34BSvhRUI6fthJiYcQ7CPW4j+E916nEr7+hObgvzQFYwcZHRkmV/dEcTeCUEWBzkiiRlteLm8VLlVk+HEd7Ys6brrxtvwYdOM2wEZidEclDIdbnH6IiLJnzDc9YXvEmkxSVc2uVAkUJcX7HMHuwisYjRCoRDAHrDUobPborjBF6PsOZRnEJU8i/TmD6Ufp27FjFIbFSeztL0cG5I0O9oTmV2D/0hlqp0GqW2h6NDElTc1YUek9BU0QOj3zsgI6cv8H+CvDfZEI1TPuyH52mvytq/m1GWVS5w3atw4gCFmfE6x21yPZRqnqIx+/aWVA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(396003)(366004)(376002)(136003)(966005)(6506007)(5660300002)(4326008)(66446008)(8676002)(478600001)(64756008)(8936002)(26005)(186003)(52536014)(66556008)(66946007)(76116006)(6636002)(66476007)(316002)(71200400001)(55016002)(54906003)(6862004)(2906002)(9686003)(33656002)(83380400001)(86362001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?Vm9uTnFpQmFkZTBCeWptbXlMVVZwbjJQRE9Hd3ZYNko1ai9tbDZscWFFanEz?=
 =?utf-8?B?cEc5MGFIdUZPUlZsZGM3endoamREdHVjZkZrQ0N6dkw2bTU0VWtTS3V5c1I1?=
 =?utf-8?B?WXkvVWt1WUxhTVJqTytiQU1CYWNJeUtYWGJmVnBDUVU1TVVCUTVyL1pVVGkx?=
 =?utf-8?B?bENqcWZDQWNEODlvSzI4MGhUcEVDSFJTQmwvb2RWNlVNMXpOQ0tobTNDbC9m?=
 =?utf-8?B?cS9zU2dnMHp1eVVvVVlxY3o4a25DOWNCNmZTY3BnV2hjdDFyUXZ4cXdxNCtR?=
 =?utf-8?B?UEl4bFY2OC8yQXY2Z0QzTFBvR0pNdG42QUxyQWN0U1FhR2U3VkxYNXFIRHdo?=
 =?utf-8?B?TlNmN2pFamZRZDl5eThrYUc1NFp3Y210QkhlSHI5SzZlTlF0c21yU1FuMEhB?=
 =?utf-8?B?SW9EZU4vVnNHVnQ3U2dCREhuWHp3cHZFeWFBdFlxMTZIcXBlM0NIMXZkV0Jz?=
 =?utf-8?B?Zm0rT0VnUHEyNTB5RWFrSGpzUm93K0ljaEIxd2VLb2hjTGhHT1hhY1Qvb3lJ?=
 =?utf-8?B?VkEvUGlCTVlnR1Q3Um5XVFVKNTBnc1lIaUNMRzliTEJIc1BIRlVaMW9salV1?=
 =?utf-8?B?NmhRaHFDNGl6V3p4emJNbXNFa1lkbk1vRk8vaWhJcXA1a01uSm1YbWNEbmtt?=
 =?utf-8?B?d2lJQ3ZBMXpsNEJjYk0yYmRRbiswMWduakkwOWVWekF5SHZqak4zU0dBdTND?=
 =?utf-8?B?UkRUbTErYzNBTERnNTRybVV5bjh2K3pyR3JoQlFxUnVFNDExVnBYdEs2T2Fv?=
 =?utf-8?B?SzVYdjdraWhTSEdXUW12YWNwWDNiVWVYYVRqTUpLM1FLVzZOSlhrVWhVUkVy?=
 =?utf-8?B?ZC9SdGMvY2t1Tmp1VnZxWXd1c284dE0yQjRiUnZzWjFvNk5nZWtyUlI2THFM?=
 =?utf-8?B?Nk5IdEJLeTZqWmJaNjhuZkhPaHgySnlPU1ROWEVHanJSQXdNNVlBNzFyK2ls?=
 =?utf-8?B?WjVWeGcrYkhONnhVdHRHd3BvbWtoRFRJSEREV2ZRaDR5QnYrTk0vbEkydHJI?=
 =?utf-8?B?SEhjMmYyTVpXMlJQTHVacFVYc0NjSHF3WlN4c3JmaUhFRXUvTVh1ZmtHZTMv?=
 =?utf-8?B?Zkp4NGoxR1BudmNZalBjd2xibXdQUC90ZHlSQWlxRnlNRkpNN0FKNDdnTk8z?=
 =?utf-8?B?ajdLd2FCSFpiTzZjbkhvUnpBVCtSYkVURmJnL3dVUlQ3T3RKaXpuUjFtZGl4?=
 =?utf-8?B?K1RDVTRqZlNkNWg5RFVEbE9lSm9OSDBEcFZGc3dlVU1ucStjd1JETUl0bjYw?=
 =?utf-8?B?eDllSU9hWEhlZTRWS0RqOEpSNWFOU3JGY3pQNDJVb3YxdDAzK1dYMTEwY2FV?=
 =?utf-8?Q?SrU3MnecX+i9I=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56a6e6ab-fada-47cc-568c-08d8a6f724af
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2020 03:59:27.4119 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m//mEwU75Nejsheo3WDduZOWs4nc0ZBsSd9CHigBdhvWIZBx+hkLevQcIhuxaoaBdjN+YmPQ40UZYeVgeEb3Sw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4347
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Guo, Kaijie" <kaijie.guo@intel.com>,
 "Raj, Ashok" <ashok.raj@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "Pan,
 Jacob jun" <jacob.jun.pan@intel.com>, "will@kernel.org" <will@kernel.org>,
 "Tian, Jun J" <jun.j.tian@intel.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

SGkgSmFjb2IsDQoNCj4gRnJvbTogSmFjb2IgUGFuIDxqYWNvYi5qdW4ucGFuQGludGVsLmNvbT4N
Cj4gU2VudDogV2VkbmVzZGF5LCBEZWNlbWJlciAyMywgMjAyMCA0OjIxIEFNDQo+DQo+IEhpIFlp
LA0KPiANCj4gT24gU3VuLCAyMCBEZWMgMjAyMCAwODowMzo1MSArMDgwMCwgTGl1IFlpIEwgPHlp
LmwubGl1QGludGVsLmNvbT4gd3JvdGU6DQo+IA0KPiA+IEluIGV4aXN0aW5nIGNvZGUsIGlmIHdh
bnRpbmcgdG8gbG9vcCBhbGwgZGV2aWNlcyBhdHRhY2hlZCB0byBhIGRvbWFpbiwNCj4gPiBjdXJy
ZW50IGNvZGUgY2FuIG9ubHkgbG9vcCB0aGUgZGV2aWNlcyB3aGljaCBhcmUgYXR0YWNoZWQgdG8g
dGhlIGRvbWFpbg0KPiA+IHZpYSBub3JtYWwgbWFubmVyLiBXaGlsZSBmb3IgZGV2aWNlcyBhdHRh
Y2hlZCB2aWEgYXV4aWxpYXJ5IG1hbm5lciwgdGhpcw0KPiA+IGlzIHN1YmRldmljZSwgdGhleSBh
cmUgbm90IHRyYWNrZWQgaW4gdGhlIGRvbWFpbi4gVGhpcyBwYXRjaCBhZGRzIHN0cnVjdA0KPiBI
b3cgYWJvdXQgIkluIHRoZSBleGlzdGluZyBjb2RlLCBsb29wIGFsbCBkZXZpY2VzIGF0dGFjaGVk
IHRvIGEgZG9tYWluIGRvZXMNCj4gbm90IGluY2x1ZGUgc3ViLWRldmljZXMgYXR0YWNoZWQgdmlh
IGlvbW11X2F1eF9hdHRhY2hfZGV2aWNlKCkuIg0KDQpsb29rcyBnb29kLiB3aWxsIHJlZmluZSBh
Y2NvcmRpbmdseS4g8J+Yig0KDQo+IA0KPiA+IHN1YmRldmljZV9kb21haW5faW5mbyB3aGljaCBp
cyBjcmVhdGVkIHBlciBkb21haW4gYXR0YWNobWVudCB2aWENCj4gYXV4aWxpYXJ5DQo+ID4gbWFu
bmVyLiBTbyB0aGF0IHN1Y2ggZGV2aWNlcyBhcmUgYWxzbyB0cmFja2VkIGluIGRvbWFpbi4NCj4g
Pg0KPiA+IFRoaXMgd2FzIGZvdW5kIGJ5IHdoZW4gSSdtIHdvcmtpbmcgb24gdGhlIGJlbHdvIHBh
dGNoLCBUaGVyZSBpcyBubyBkZXZpY2UNCj4gPiBpbiBkb21haW4tPmRldmljZXMsIHRodXMgdW5h
YmxlIHRvIGdldCB0aGUgY2FwIGFuZCBlY2FwIG9mIGlvbW11IHVuaXQuIEJ1dA0KPiA+IHRoaXMg
ZG9tYWluIGFjdHVhbGx5IGhhcyBvbmUgc3ViLWRldmljZSB3aGljaCBpcyBhdHRhY2hlZCB2aWEg
YXV4LW1hbm5lci4NCj4gPiBUaGlzIHBhdGNoIGZpeGVzIHRoZSBpc3N1ZS4NCj4gPg0KPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2t2bS8xNTk5NzM0NzMzLTY0MzEtMTctZ2l0LXNlbmQtZW1h
aWwtDQo+IHlpLmwubGl1QGludGVsLmNvbS8NCj4gPg0KPiA+IEJ1dCBsb29rcyBsaWtlLCBpdCBk
b2Vzbid0IGFmZmVjdCBtZSBvbmx5LiBTdWNoIGF1eGlsaWFyeSB0cmFjayBzaG91bGQgYmUNCj4g
PiB0aGVyZSBmb3IgZXhhbXBsZSBpZiB3YW50aW5nIHRvIGZsdXNoIGRldmljZV9pb3RsYiBmb3Ig
YSBkb21haW4gd2hpY2ggaGFzDQo+ID4gZGV2aWNlcyBhdHRhY2hlZCBieSBhdXhpbGlyYXkgbWFu
bmVyLCB0aGVuIHRoaXMgZml4IGlzIGFsc28gbmVjZXNzYXJ5Lg0KPiBQZXJoYXBzOg0KPiBUaGlz
IGZpeCBnb2VzIGJleW9uZCB0aGUgcGF0Y2ggYWJvdmUsIHN1Y2ggc3ViLWRldmljZSB0cmFja2lu
ZyBpcw0KPiBuZWNlc3NhcnkgZm9yIG90aGVyIGNhc2VzLiBGb3IgZXhhbXBsZSwgZmx1c2hpbmcg
ZGV2aWNlX2lvdGxiIGZvciBhIGRvbWFpbg0KPiB3aGljaCBoYXMgc3ViLWRldmljZXMgYXR0YWNo
ZWQgYnkgYXV4aWxpYXJ5IG1hbm5lci4NCg0KeWVwLiBCYW9sdSBhbHNvIHN1Z2dlc3RlZCBzdWNo
IHJlZmluZS4gd2lsbCB0d2VhayBpbiBuZXh0IHZlcnNpb24uDQoNClJlZ2FyZHMsDQpZaSBMaXUN
Cg0KPiANCj4gPiBUaGlzIGlzc3VlIHdpbGwgYWxzbyBiZSBmaXhlZCBieSBhbm90aGVyIHBhdGNo
IGluIHRoaXMgc2VyaWVzIHdpdGggc29tZQ0KPiA+IGFkZGl0aW9uYWwgY2hhbmdlcyBiYXNlZCBv
biB0aGUgc3VkZXZpY2UgdHJhY2tpbmcgZnJhbWV3b3JrIGludHJvZHVjZWQgaW4NCj4gPiB0aGlz
IHBhdGNoLg0KPiA+DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBYaW4gWmVuZyA8eGluLnplbmdAaW50
ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpbiBaZW5nIDx4aW4uemVuZ0BpbnRlbC5jb20+
DQo+ID4gQ28tZGV2ZWxvcGVkLWJ5OiBMaXUgWWkgTCA8eWkubC5saXVAaW50ZWwuY29tPg0KPiA+
IFNpZ25lZC1vZmYtYnk6IExpdSBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+ID4gQ28tZGV2
ZWxvcGVkLWJ5OiBMdSBCYW9sdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEx1IEJhb2x1IDxiYW9sdS5sdUBsaW51eC5pbnRlbC5jb20+DQo+ID4gLS0tDQo+
ID4gIGRyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyB8IDkyICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0NCj4gLS0tDQo+ID4gIGluY2x1ZGUvbGludXgvaW50ZWwtaW9tbXUuaCB8
IDExICsrKystDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgOTAgaW5zZXJ0aW9ucygrKSwgMTMgZGVs
ZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gaW5kZXggYTQ5YWZhMTE2NzNj
Li40Mjc0YjRhY2MzMjUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jDQo+ID4gKysrIGIvZHJpdmVycy9pb21tdS9pbnRlbC9pb21tdS5jDQo+ID4gQEAgLTE4ODEs
NiArMTg4MSw3IEBAIHN0YXRpYyBzdHJ1Y3QgZG1hcl9kb21haW4gKmFsbG9jX2RvbWFpbihpbnQN
Cj4gZmxhZ3MpDQo+ID4gIAkJZG9tYWluLT5mbGFncyB8PSBET01BSU5fRkxBR19VU0VfRklSU1Rf
TEVWRUw7DQo+ID4gIAlkb21haW4tPmhhc19pb3RsYl9kZXZpY2UgPSBmYWxzZTsNCj4gPiAgCUlO
SVRfTElTVF9IRUFEKCZkb21haW4tPmRldmljZXMpOw0KPiA+ICsJSU5JVF9MSVNUX0hFQUQoJmRv
bWFpbi0+c3ViX2RldmljZXMpOw0KPiA+DQo+ID4gIAlyZXR1cm4gZG9tYWluOw0KPiA+ICB9DQo+
ID4gQEAgLTUxNzIsMzMgKzUxNzMsNzkgQEAgaXNfYXV4X2RvbWFpbihzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHN0cnVjdA0KPiA+IGlvbW11X2RvbWFpbiAqZG9tYWluKSBkb21haW4tPnR5cGUgPT0NCj4g
SU9NTVVfRE9NQUlOX1VOTUFOQUdFRDsNCj4gPiAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUN
Cj4gPiArdm9pZCBfYXV4aWxpYXJ5X2xpbmtfZGV2aWNlKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9t
YWluLA0KPiA+ICsJCQkgICAgc3RydWN0IHN1YmRldmljZV9kb21haW5faW5mbyAqc3ViaW5mbywN
Cj4gPiArCQkJICAgIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiArew0KPiA+ICsJc3ViaW5mby0+
dXNlcnMrKzsNCj4gPiArfQ0KPiA+ICsNCj4gd2h5IHBhc3MgaW4gbW9yZSBhcmd1bWVudHMgdGhh
biBzdWJpbmZvPyB0aGUgZnVuY3Rpb24gbmFtZSBkb2VzIG5vdCBtYXRjaA0KPiB3aGF0IGl0IGRv
ZXMsIHNlZW1zIGp1c3QgcmVmY291bnQgaW5jLg0KPiANCj4gPiArc3RhdGljIGlubGluZQ0KPiA+
ICtpbnQgX2F1eGlsaWFyeV91bmxpbmtfZGV2aWNlKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWlu
LA0KPiA+ICsJCQkgICAgIHN0cnVjdCBzdWJkZXZpY2VfZG9tYWluX2luZm8gKnN1YmluZm8sDQo+
ID4gKwkJCSAgICAgc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdWJpbmZvLT51
c2Vycy0tOw0KPiA+ICsJcmV0dXJuIHN1YmluZm8tPnVzZXJzOw0KPiBkaXR0by4gd2h5IG5vdCBq
dXN0DQo+ICAJcmV0dXJuIHN1YmluZm8tPnVzZXJzLS07DQo+IA0KPiA+ICt9DQo+ID4gKw0KPiA+
ICBzdGF0aWMgdm9pZCBhdXhpbGlhcnlfbGlua19kZXZpY2Uoc3RydWN0IGRtYXJfZG9tYWluICpk
b21haW4sDQo+ID4gIAkJCQkgIHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgew0KPiA+ICAJc3Ry
dWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGdldF9kb21haW5faW5mbyhkZXYpOw0KPiA+
ICsJc3RydWN0IHN1YmRldmljZV9kb21haW5faW5mbyAqc3ViaW5mbzsNCj4gPg0KPiA+ICAJYXNz
ZXJ0X3NwaW5fbG9ja2VkKCZkZXZpY2VfZG9tYWluX2xvY2spOw0KPiA+ICAJaWYgKFdBUk5fT04o
IWluZm8pKQ0KPiA+ICAJCXJldHVybjsNCj4gPg0KPiA+ICsJc3ViaW5mbyA9IGt6YWxsb2Moc2l6
ZW9mKCpzdWJpbmZvKSwgR0ZQX0FUT01JQyk7DQo+ID4gKwlpZiAoIXN1YmluZm8pDQo+ID4gKwkJ
cmV0dXJuOw0KPiA+ICsNCj4gPiArCXN1YmluZm8tPmRvbWFpbiA9IGRvbWFpbjsNCj4gPiArCXN1
YmluZm8tPmRldiA9IGRldjsNCj4gPiArCWxpc3RfYWRkKCZzdWJpbmZvLT5saW5rX2RvbWFpbiwg
JmluZm8tPmF1eGlsaWFyeV9kb21haW5zKTsNCj4gPiArCWxpc3RfYWRkKCZzdWJpbmZvLT5saW5r
X3BoeXMsICZkb21haW4tPnN1Yl9kZXZpY2VzKTsNCj4gPiArCV9hdXhpbGlhcnlfbGlua19kZXZp
Y2UoZG9tYWluLCBzdWJpbmZvLCBkZXYpOw0KPiBvciBqdXN0IG9wZW5jb2RlIHN1YmluZm8tPnVz
ZXJzKys/DQo+ID4gIAlkb21haW4tPmF1eGRfcmVmY250Kys7DQo+ID4gLQlsaXN0X2FkZCgmZG9t
YWluLT5hdXhkLCAmaW5mby0+YXV4aWxpYXJ5X2RvbWFpbnMpOw0KPiA+ICB9DQo+ID4NCj4gPiAt
c3RhdGljIHZvaWQgYXV4aWxpYXJ5X3VubGlua19kZXZpY2Uoc3RydWN0IGRtYXJfZG9tYWluICpk
b21haW4sDQo+ID4gLQkJCQkgICAgc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICtzdGF0aWMgc3Ry
dWN0IHN1YmRldmljZV9kb21haW5faW5mbyAqDQo+ID4gK3N1YmRldmljZV9kb21haW5faW5mb19s
b29rdXAoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sIHN0cnVjdA0KPiBkZXZpY2UNCj4gPiAq
ZGV2KSArew0KPiA+ICsJc3RydWN0IHN1YmRldmljZV9kb21haW5faW5mbyAqc3ViaW5mbzsNCj4g
PiArDQo+ID4gKwlhc3NlcnRfc3Bpbl9sb2NrZWQoJmRldmljZV9kb21haW5fbG9jayk7DQo+ID4g
Kw0KPiA+ICsJbGlzdF9mb3JfZWFjaF9lbnRyeShzdWJpbmZvLCAmZG9tYWluLT5zdWJfZGV2aWNl
cywgbGlua19waHlzKQ0KPiA+ICsJCWlmIChzdWJpbmZvLT5kZXYgPT0gZGV2KQ0KPiA+ICsJCQly
ZXR1cm4gc3ViaW5mbzsNCj4gPiArDQo+ID4gKwlyZXR1cm4gTlVMTDsNCj4gPiArfQ0KPiA+ICsN
Cj4gPiArc3RhdGljIGludCBhdXhpbGlhcnlfdW5saW5rX2RldmljZShzdHJ1Y3QgZG1hcl9kb21h
aW4gKmRvbWFpbiwNCj4gPiArCQkJCSAgIHN0cnVjdCBzdWJkZXZpY2VfZG9tYWluX2luZm8gKnN1
YmluZm8sDQo+ID4gKwkJCQkgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gIHsNCj4gPiAgCXN0
cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm8gPSBnZXRfZG9tYWluX2luZm8oZGV2KTsNCj4g
PiArCWludCByZXQ7DQo+ID4NCj4gPiAgCWFzc2VydF9zcGluX2xvY2tlZCgmZGV2aWNlX2RvbWFp
bl9sb2NrKTsNCj4gPiAgCWlmIChXQVJOX09OKCFpbmZvKSkNCj4gPiAtCQlyZXR1cm47DQo+ID4g
KwkJcmV0dXJuIC1FSU5WQUw7DQo+ID4NCj4gPiAtCWxpc3RfZGVsKCZkb21haW4tPmF1eGQpOw0K
PiA+ICsJcmV0ID0gX2F1eGlsaWFyeV91bmxpbmtfZGV2aWNlKGRvbWFpbiwgc3ViaW5mbywgZGV2
KTsNCj4gPiArCWlmIChyZXQgPT0gMCkgew0KPiA+ICsJCWxpc3RfZGVsKCZzdWJpbmZvLT5saW5r
X2RvbWFpbik7DQo+ID4gKwkJbGlzdF9kZWwoJnN1YmluZm8tPmxpbmtfcGh5cyk7DQo+ID4gKwkJ
a2ZyZWUoc3ViaW5mbyk7DQo+ID4gKwl9DQo+ID4gIAlkb21haW4tPmF1eGRfcmVmY250LS07DQo+
ID4NCj4gPiAtCWlmICghZG9tYWluLT5hdXhkX3JlZmNudCAmJiBkb21haW4tPmRlZmF1bHRfcGFz
aWQgPiAwKQ0KPiA+IC0JCWlvYXNpZF9mcmVlKGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCk7DQo+ID4g
KwlyZXR1cm4gcmV0Ow0KPiA+ICB9DQo+ID4NCj4gPiAgc3RhdGljIGludCBhdXhfZG9tYWluX2Fk
ZF9kZXYoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sDQo+ID4gQEAgLTUyMDcsNiArNTI1NCw4
IEBAIHN0YXRpYyBpbnQgYXV4X2RvbWFpbl9hZGRfZGV2KHN0cnVjdA0KPiBkbWFyX2RvbWFpbg0K
PiA+ICpkb21haW4sIGludCByZXQ7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiA+ICAJ
c3RydWN0IGludGVsX2lvbW11ICppb21tdTsNCj4gPiArCXN0cnVjdCBkZXZpY2VfZG9tYWluX2lu
Zm8gKmluZm8gPSBnZXRfZG9tYWluX2luZm8oZGV2KTsNCj4gPiArCXN0cnVjdCBzdWJkZXZpY2Vf
ZG9tYWluX2luZm8gKnN1YmluZm87DQo+ID4NCj4gPiAgCWlvbW11ID0gZGV2aWNlX3RvX2lvbW11
KGRldiwgTlVMTCwgTlVMTCk7DQo+ID4gIAlpZiAoIWlvbW11KQ0KPiA+IEBAIC01MjI3LDYgKzUy
NzYsMTIgQEAgc3RhdGljIGludCBhdXhfZG9tYWluX2FkZF9kZXYoc3RydWN0DQo+IGRtYXJfZG9t
YWluDQo+ID4gKmRvbWFpbiwgfQ0KPiA+DQo+ID4gIAlzcGluX2xvY2tfaXJxc2F2ZSgmZGV2aWNl
X2RvbWFpbl9sb2NrLCBmbGFncyk7DQo+ID4gKwlzdWJpbmZvID0gc3ViZGV2aWNlX2RvbWFpbl9p
bmZvX2xvb2t1cChkb21haW4sIGRldik7DQo+ID4gKwlpZiAoc3ViaW5mbykgew0KPiA+ICsJCV9h
dXhpbGlhcnlfbGlua19kZXZpY2UoZG9tYWluLCBzdWJpbmZvLCBkZXYpOw0KPiA+ICsJCXNwaW5f
dW5sb2NrX2lycXJlc3RvcmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+ICsJCXJl
dHVybiAwOw0KPiA+ICsJfQ0KPiA+ICAJLyoNCj4gPiAgCSAqIGlvbW11LT5sb2NrIG11c3QgYmUg
aGVsZCB0byBhdHRhY2ggZG9tYWluIHRvIGlvbW11IGFuZCBzZXR1cA0KPiA+IHRoZQ0KPiA+ICAJ
ICogcGFzaWQgZW50cnkgZm9yIHNlY29uZCBsZXZlbCB0cmFuc2xhdGlvbi4NCj4gPiBAQCAtNTI3
MCw2ICs1MzI1LDcgQEAgc3RhdGljIHZvaWQgYXV4X2RvbWFpbl9yZW1vdmVfZGV2KHN0cnVjdA0K
PiA+IGRtYXJfZG9tYWluICpkb21haW4sIHN0cnVjdCBkZXZpY2VfZG9tYWluX2luZm8gKmluZm87
DQo+ID4gIAlzdHJ1Y3QgaW50ZWxfaW9tbXUgKmlvbW11Ow0KPiA+ICAJdW5zaWduZWQgbG9uZyBm
bGFnczsNCj4gPiArCXN0cnVjdCBzdWJkZXZpY2VfZG9tYWluX2luZm8gKnN1YmluZm87DQo+ID4N
Cj4gPiAgCWlmICghaXNfYXV4X2RvbWFpbihkZXYsICZkb21haW4tPmRvbWFpbikpDQo+ID4gIAkJ
cmV0dXJuOw0KPiA+IEBAIC01Mjc4LDE0ICs1MzM0LDI2IEBAIHN0YXRpYyB2b2lkIGF1eF9kb21h
aW5fcmVtb3ZlX2RldihzdHJ1Y3QNCj4gPiBkbWFyX2RvbWFpbiAqZG9tYWluLCBpbmZvID0gZ2V0
X2RvbWFpbl9pbmZvKGRldik7DQo+ID4gIAlpb21tdSA9IGluZm8tPmlvbW11Ow0KPiA+DQo+ID4g
LQlhdXhpbGlhcnlfdW5saW5rX2RldmljZShkb21haW4sIGRldik7DQo+ID4gKwlzdWJpbmZvID0g
c3ViZGV2aWNlX2RvbWFpbl9pbmZvX2xvb2t1cChkb21haW4sIGRldik7DQo+ID4gKwlpZiAoIXN1
YmluZm8pIHsNCj4gPiArCQlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXZpY2VfZG9tYWluX2xv
Y2ssIGZsYWdzKTsNCj4gPiArCQlyZXR1cm47DQo+ID4gKwl9DQo+ID4NCj4gPiAtCXNwaW5fbG9j
aygmaW9tbXUtPmxvY2spOw0KPiA+IC0JaW50ZWxfcGFzaWRfdGVhcl9kb3duX2VudHJ5KGlvbW11
LCBkZXYsIGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCwNCj4gPiBmYWxzZSk7DQo+ID4gLQlkb21haW5f
ZGV0YWNoX2lvbW11KGRvbWFpbiwgaW9tbXUpOw0KPiA+IC0Jc3Bpbl91bmxvY2soJmlvbW11LT5s
b2NrKTsNCj4gPiArCWlmIChhdXhpbGlhcnlfdW5saW5rX2RldmljZShkb21haW4sIHN1YmluZm8s
IGRldikgPT0gMCkgew0KPiA+ICsJCXNwaW5fbG9jaygmaW9tbXUtPmxvY2spOw0KPiA+ICsJCWlu
dGVsX3Bhc2lkX3RlYXJfZG93bl9lbnRyeShpb21tdSwNCj4gPiArCQkJCQkgICAgZGV2LA0KPiA+
ICsJCQkJCSAgICBkb21haW4tPmRlZmF1bHRfcGFzaWQsDQo+ID4gKwkJCQkJICAgIGZhbHNlKTsN
Cj4gPiArCQlkb21haW5fZGV0YWNoX2lvbW11KGRvbWFpbiwgaW9tbXUpOw0KPiA+ICsJCXNwaW5f
dW5sb2NrKCZpb21tdS0+bG9jayk7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCXNwaW5fdW5sb2NrX2ly
cXJlc3RvcmUoJmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+ICsNCj4gPiArCWlmICgh
ZG9tYWluLT5hdXhkX3JlZmNudCAmJiBkb21haW4tPmRlZmF1bHRfcGFzaWQgPiAwKQ0KPiA+ICsJ
CWlvYXNpZF9mcmVlKGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCk7DQo+ID4gIH0NCj4gPg0KPiA+ICBz
dGF0aWMgaW50IHByZXBhcmVfZG9tYWluX2F0dGFjaF9kZXZpY2Uoc3RydWN0IGlvbW11X2RvbWFp
biAqZG9tYWluLA0KPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11Lmgg
Yi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgNCj4gPiBpbmRleCA5NDUyMjY4NWEwZDkuLjFm
YjNkNmFiNzE5YSAxMDA2NDQNCj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgN
Cj4gPiArKysgYi9pbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmgNCj4gPiBAQCAtNTM3LDcgKzUz
Nyw3IEBAIHN0cnVjdCBkbWFyX2RvbWFpbiB7DQo+ID4NCj4gPiAgCWJvb2wgaGFzX2lvdGxiX2Rl
dmljZTsNCj4gPiAgCXN0cnVjdCBsaXN0X2hlYWQgZGV2aWNlczsJLyogYWxsIGRldmljZXMnIGxp
c3QgKi8NCj4gPiAtCXN0cnVjdCBsaXN0X2hlYWQgYXV4ZDsJCS8qIGxpbmsgdG8gZGV2aWNlJ3MN
Cj4gPiBhdXhpbGlhcnkgbGlzdCAqLw0KPiA+ICsJc3RydWN0IGxpc3RfaGVhZCBzdWJfZGV2aWNl
czsJLyogYWxsIGRldmljZXMnIGxpc3QNCj4gPiBhdHRhY2hlZCB2aWEgYXV4LWF0dGFjaCAqLyBz
dHJ1Y3QgaW92YV9kb21haW4gaW92YWQ7CS8qIGlvdmEncw0KPiA+IHRoYXQgYmVsb25nIHRvIHRo
aXMgZG9tYWluICovDQo+ID4gIAlzdHJ1Y3QgZG1hX3B0ZQkqcGdkOwkJLyogdmlydHVhbCBhZGRy
ZXNzICovDQo+ID4gQEAgLTYzNiw2ICs2MzYsMTUgQEAgc3RydWN0IGRldmljZV9kb21haW5faW5m
byB7DQo+ID4gIAlzdHJ1Y3QgcGFzaWRfdGFibGUgKnBhc2lkX3RhYmxlOyAvKiBwYXNpZCB0YWJs
ZSAqLw0KPiA+ICB9Ow0KPiA+DQo+ID4gKy8qIEF1eCBhdHRhY2ggZGV2aWNlIGRvbWFpbiBpbmZv
ICovDQo+ID4gK3N0cnVjdCBzdWJkZXZpY2VfZG9tYWluX2luZm8gew0KPiA+ICsJc3RydWN0IGRl
dmljZSAqZGV2Ow0KPiA+ICsJc3RydWN0IGRtYXJfZG9tYWluICpkb21haW47DQo+ID4gKwlzdHJ1
Y3QgbGlzdF9oZWFkIGxpbmtfcGh5czsJLyogbGluayB0byBwaHlzIGRldmljZQ0KPiA+IHNpYmxp
bmdzICovDQo+ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIGxpbmtfZG9tYWluOwkvKiBsaW5rIHRvIGRv
bWFpbiBzaWJsaW5ncw0KPiA+ICovDQo+ID4gKwlpbnQgdXNlcnM7DQo+ID4gK307DQo+ID4gKw0K
PiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgX19pb21tdV9mbHVzaF9jYWNoZSgNCj4gPiAgCXN0cnVj
dCBpbnRlbF9pb21tdSAqaW9tbXUsIHZvaWQgKmFkZHIsIGludCBzaXplKQ0KPiA+ICB7DQo+IA0K
PiANCj4gVGhhbmtzLA0KPiANCj4gSmFjb2INCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby9pb21tdQ==
