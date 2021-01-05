Return-Path: <SRS0=smho=GI=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F1BC433E0
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 05:59:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79AFC229C5
	for <iommu@archiver.kernel.org>; Tue,  5 Jan 2021 05:59:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79AFC229C5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id D54228706D;
	Tue,  5 Jan 2021 05:59:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00haY1Lr1j0j; Tue,  5 Jan 2021 05:59:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9576087059;
	Tue,  5 Jan 2021 05:59:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75943C088B;
	Tue,  5 Jan 2021 05:59:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33B68C013A
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:59:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1685687022
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:59:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nl3g-5XrAgEX for <iommu@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 05:59:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
 by hemlock.osuosl.org (Postfix) with ESMTPS id EE0F386F9E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Jan 2021 05:59:00 +0000 (UTC)
IronPort-SDR: +GBZ71iyon/MA+nwmvG9kDpxUPQtnD4Nq0OVveQBxBJfv4+TL13TZMs0dcMaq13qcjAtT7V90Y
 4kGD98T+fgWQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9854"; a="156841771"
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="156841771"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jan 2021 21:59:00 -0800
IronPort-SDR: gGoBbdypVzfC8MQo2j3PEcwONIgpLchBtJDjSubAquhX6ITLh/V/Hqcwgxs03oAhHnVu/rOyEB
 NdL3znIFHrEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,476,1599548400"; d="scan'208";a="569604764"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP; 04 Jan 2021 21:59:00 -0800
Received: from fmsmsx604.amr.corp.intel.com (10.18.126.84) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 4 Jan 2021 21:59:00 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 4 Jan 2021 21:59:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.1713.5; Mon, 4 Jan 2021 21:58:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfzgtyh5vYFfM5tMhTZ1fOMhyJkmMRPTehaolMlssvPqW6uSSiPmO3oT510fxwgY0nB211t5C+8qO5zNEA/HE+QarFJQ6PVh/xvGvHwNCKIPHuT6NQi0EN1fHhYqj047qdePE/EjJLOyd9omKJmPEj0OCTCF4YeelEpOrXCrT48YdRSbkw8fPoMIU6tMLFyZAnLlRxGxJIONn7VLvIGvgVjl5MTU+ZOJPF8J/7VTC16vnjD7FNZPk2+7Ym8dzrRYzDfkyZwUZZriGVxsCdTy7t9Q/X9kI4b7nx4EkhzS6p/E4FhW89TXw8ZemKmiV0D8xYacdWghpom3xUfjrx7E8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7bj3zz9GYK3V05LB2JcJ3i3ZTilfBgAcvqLqMgTsDU=;
 b=W7kk03FmRA425KWajb9I1C98OrpMMLU2arp/TM7PX3ptWh+iVPUARqqyqm9a7wGb/4cXKXeC6uXPHKaL7nyAHM4zKE3lQlvsW8SJOzOj2dFWK72wzLQQ6CHLhAGyveK8t9qisS1ea63K26atPujnlo24ClPEd3SB6WBCHN5IjT6UMSitiB7WXw9GQzkuAhT+tELx/C/PCZPHAIVPpXcLa/jB0zqaoc8w9EIYTiitrNrt4zQ7C7rGyKg54IQN2Je9Jc7ssxFz24xXvyNC+wbar/4EFTV8DDPBIjtfNuoOY+Er7SS9eckFA2TC5In+g9M/M4UL/Budx997raZwg6KpnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.onmicrosoft.com; 
 s=selector2-intel-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u7bj3zz9GYK3V05LB2JcJ3i3ZTilfBgAcvqLqMgTsDU=;
 b=TU8/nvs0MLhrXZzMARframq+3oeieYxGMR6UAYSJmIJvIxE5xGQtBOcAwplAWNaod4JaZE53v3+1m9C2NOdyvX5penQ0kcl2ERHX9eqiQq8RCy8/aFdhIHhhLfY3yU4ddMj85LBAto9FzMbxrCE7m9hLQUnmFLpbS2Qqxv+nmek=
Received: from DM5PR11MB1435.namprd11.prod.outlook.com (2603:10b6:4:7::18) by
 DM6PR11MB2988.namprd11.prod.outlook.com (2603:10b6:5:63::23) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3721.20; Tue, 5 Jan 2021 05:58:58 +0000
Received: from DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93]) by DM5PR11MB1435.namprd11.prod.outlook.com
 ([fe80::649c:8aff:2053:e93%3]) with mapi id 15.20.3721.024; Tue, 5 Jan 2021
 05:58:58 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, "joro@8bytes.org" <joro@8bytes.org>, 
 "will@kernel.org" <will@kernel.org>
Subject: RE: [PATCH v3 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Thread-Topic: [PATCH v3 2/3] iommu/vt-d: Track device aux-attach with
 subdevice_domain_info
Thread-Index: AQHW3ZJRT5F66rJj7keB49IpQtA/YqoNwMcAgArThRA=
Date: Tue, 5 Jan 2021 05:58:57 +0000
Message-ID: <DM5PR11MB1435FC443BA55D9665795718C3D10@DM5PR11MB1435.namprd11.prod.outlook.com>
References: <20201229032513.486395-1-yi.l.liu@intel.com>
 <20201229032513.486395-3-yi.l.liu@intel.com>
 <604d35d9-ef43-e57c-07e2-59d57d2b7ad1@linux.intel.com>
In-Reply-To: <604d35d9-ef43-e57c-07e2-59d57d2b7ad1@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
dlp-reaction: no-action
dlp-version: 11.5.1.3
dlp-product: dlpe-windows
authentication-results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=intel.com;
x-originating-ip: [192.198.147.207]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4dfa82e8-37fb-49c7-01d0-08d8b13efdfc
x-ms-traffictypediagnostic: DM6PR11MB2988:
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB2988D8671CDD449640CFDFD5C3D10@DM6PR11MB2988.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qVH/56t0stcprnw8V3ljH+xernzdqGJ1C8UZfNrC0tVQ99RTWH4g4xkajcwIws9rkC6gSterN9sgfICQHWdsL4ePcU9DggSl3ePfx8Qikv0lcnwHaVFc5gsWLl5HDQApm0Wfkgb89gmQAXZJNJx0jnrqsUzB435GpifATTX1KMkMCLOIggYHROt0R+SDmQ/ANqUR3pS2XAPSvBee35su7uunuKjypiuNzJwMZdUvF5BBi9Ae+OnA/+mPDyC59JFwml9394sr7XDUUTtUTMhM02K04KwbnmRzQqtbdNE8sIlH4rTsH+F1u1YWCAKE2c00YTFxKcXgCLTXftdMeqGP51dBl1GUfqonyyXoHSywfW74HirtWqgJInLlTf0/2DhOFbAa0iVa9MSutzGz3QSMmp31PMZvIHx1K4Jt8SJKMEjCjEusShhWvcA55PLYkYYyX33mfm612E7C2GIN6+rrHg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM5PR11MB1435.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(376002)(396003)(136003)(366004)(346002)(83380400001)(6506007)(9686003)(316002)(55016002)(4326008)(33656002)(54906003)(52536014)(53546011)(71200400001)(8936002)(110136005)(66476007)(76116006)(66446008)(66556008)(8676002)(64756008)(186003)(86362001)(2906002)(7696005)(26005)(5660300002)(478600001)(66946007)(966005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?utf-8?B?MGNEMGpxZkxpaVd6MUxtVnlKWS9nYjg3MnBWQXNmT2xTcFRmSDdvT3g4cXpv?=
 =?utf-8?B?SnF6UXIyejNDeDNlY1JmMHJHR2NUMUJQeUIyMExiK1hmWUV3cjd2bWkrbEgw?=
 =?utf-8?B?T001TkFGS0lnOEQzQUszejlxL3JYZ1J6eHIzVVNRbnhvZVloalBJQjRYd1pZ?=
 =?utf-8?B?UlZyYmV1eVp1MXNMZHl6eS8xZ1QreURUWUl4K1loY3VHZTdybCtOdnBHeEhW?=
 =?utf-8?B?aHVrK2VORjA1WUlSVS8xbFppNTVBSXp0YjQ0bThkM2dPUC8rVjJUTnlDVEVu?=
 =?utf-8?B?S2lmRUZsb3NDRitjUTV6ZG1yM01KZmdxWURvOHR0UjlRTjJobUVNMjVaK3Qy?=
 =?utf-8?B?M2tnMUY4Y25PNCtacksvYUxOQnAzTXEvdGxYOVRpZ3gzMVgrdUQySDR4V3BV?=
 =?utf-8?B?bWt6bFRyYzEzenB6dUU4UzVtT0trbUxqVXVpL1FRTDQrY1M0TFYzYmVpWEpx?=
 =?utf-8?B?d2dBdjdrU0Z3OEFvLzBnN1AwWFF3d3l5Qlg2REo4VmVaamRWMlAzQmxBbng4?=
 =?utf-8?B?M2dnZDhCQzlIK0FIanB3ZXNtOHJrV1pBdE9odjZjTlhWSXlWUXZYME1YaXRj?=
 =?utf-8?B?dldrMTF4R3RTM3ZCcTBVckpRWCtvN3l3aEk3L1Ftc1lvdGRwS3g4NlZRanBi?=
 =?utf-8?B?VkhpRDM4T0FXTE8rM1R5bmpZcEFFbmdjYVZUTjVGcXR6RW1qOVZJbmJEdzR2?=
 =?utf-8?B?Qm1WWno1ZlBIeVV1SC91a3BjTDBQbHN4eTVjRlpZQXE0c0VQYUhUZDkxQmRv?=
 =?utf-8?B?ek9rTWZYYnBqTDM3NmJwcUJWT3RKZkYvRHlLWlptTnpEY0lUY0hTa3pibm1B?=
 =?utf-8?B?akYyVHNXbkRHREpKWEN6WWtQZVNDZnZYSDVaNWtXN2cxU2pFeVBVYjJhMWdT?=
 =?utf-8?B?M1BiNXZoYVNKZ1Q0QXo5dEFacDlXb2J6RzN2UVlLY3k5TU5uOWxKTmRMUUVJ?=
 =?utf-8?B?ZmZqUTNaS09TK0FodHp6UXVlbTNiTXhXMnFDRnVvdXk1SGd1WXpOU1RUU1Jp?=
 =?utf-8?B?V0JyRG12Wm9pbHBmNm8rQkR2RmF5RzVUUFh2Z0lLZE1XUlBCQTVITGJpNUM5?=
 =?utf-8?B?RGpPVHd3eThsY2w4R2cydW0zb1p4Sy9WbjNDaVRiOVVlY3lZOGVkdTNZZWdx?=
 =?utf-8?B?YkNxS0NPWmkzN0JidnNCMFVpMXUwbFMyc0JadmNra0dXUjgzZzgxMmhER0Fr?=
 =?utf-8?B?ajJ0V3ZkbitOaXdsMGpxaGhoL2pPQnJsakxiajM1QlpuakowRzZYMkhNZEJB?=
 =?utf-8?B?UDBIcURKQUFqZFRncFpHajNBNE0rQ1NaUXU5ZTYvZER0UUVoc2ZzL0JRZXNt?=
 =?utf-8?Q?m+FVW1RurKnxQ=3D?=
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR11MB1435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dfa82e8-37fb-49c7-01d0-08d8b13efdfc
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2021 05:58:57.9035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ds73iTd5rgPzWVtZaYMs/IXKGigx49qdKbCVYB+sqgQTluqas2A+ojs6gyoiMCTMjt5o3OaZNLkHQmMqfkAAyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2988
X-OriginatorOrg: intel.com
Cc: "Tian, Kevin" <kevin.tian@intel.com>, "Raj, Ashok" <ashok.raj@intel.com>,
 "Tian, Jun J" <jun.j.tian@intel.com>,
 "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Sun,
 Yi Y" <yi.y.sun@intel.com>
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

SGkgQmFvbHUsDQoNCj4gRnJvbTogTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4N
Cj4gU2VudDogVHVlc2RheSwgRGVjZW1iZXIgMjksIDIwMjAgNDozOCBQTQ0KPiANCj4gSGkgWWks
DQo+IA0KPiBPbiAyMDIwLzEyLzI5IDExOjI1LCBMaXUgWWkgTCB3cm90ZToNCj4gPiBJbiB0aGUg
ZXhpc3RpbmcgY29kZSwgbG9vcCBhbGwgZGV2aWNlcyBhdHRhY2hlZCB0byBhIGRvbWFpbiBkb2Vz
IG5vdA0KPiA+IGluY2x1ZGUgc3ViLWRldmljZXMgYXR0YWNoZWQgdmlhIGlvbW11X2F1eF9hdHRh
Y2hfZGV2aWNlKCkuDQo+ID4NCj4gPiBUaGlzIHdhcyBmb3VuZCBieSB3aGVuIEknbSB3b3JraW5n
IG9uIHRoZSBiZWx3byBwYXRjaCwgVGhlcmUgaXMgbm8NCj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgXl5eXl4NCj4gYmVsb3cNCg0KbmljZSBjYXRjaC4g8J+Y
iQ0KDQo+ID4gZGV2aWNlIGluIHRoZSBkb21haW4tPmRldmljZXMgbGlzdCwgdGh1cyB1bmFibGUg
dG8gZ2V0IHRoZSBjYXAgYW5kDQo+ID4gZWNhcCBvZiBpb21tdSB1bml0LiBCdXQgdGhpcyBkb21h
aW4gYWN0dWFsbHkgaGFzIHN1YmRldmljZSB3aGljaCBpcw0KPiA+IGF0dGFjaGVkIHZpYSBhdXgt
bWFubmVyLiBCdXQgaXQgaXMgdHJhY2tlZCBieSBkb21haW4uIFRoaXMgcGF0Y2ggaXMNCj4gPiBn
b2luZyB0byBmaXggaXQuDQo+ID4NCj4gPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9rdm0vMTU5
OTczNDczMy02NDMxLTE3LWdpdC1zZW5kLWVtYWlsLQ0KPiB5aS5sLmxpdUBpbnRlbC5jb20vDQo+
ID4NCj4gPiBBbmQgdGhpcyBmaXggZ29lcyBiZXlvbmQgdGhlIHBhdGNoIGFib3ZlLCBzdWNoIHN1
Yi1kZXZpY2UgdHJhY2tpbmcgaXMNCj4gPiBuZWNlc3NhcnkgZm9yIG90aGVyIGNhc2VzLiBGb3Ig
ZXhhbXBsZSwgZmx1c2hpbmcgZGV2aWNlX2lvdGxiIGZvciBhDQo+ID4gZG9tYWluIHdoaWNoIGhh
cyBzdWItZGV2aWNlcyBhdHRhY2hlZCBieSBhdXhpbGlhcnkgbWFubmVyLg0KPiA+DQo+ID4gQ28t
ZGV2ZWxvcGVkLWJ5OiBYaW4gWmVuZyA8eGluLnplbmdAaW50ZWwuY29tPg0KPiA+IFNpZ25lZC1v
ZmYtYnk6IFhpbiBaZW5nIDx4aW4uemVuZ0BpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTog
TGl1IFlpIEwgPHlpLmwubGl1QGludGVsLmNvbT4NCj4gDQo+IE90aGVycyBsb29rIGdvb2QgdG8g
bWUuDQo+IA0KPiBGaXhlczogNjdiOGUwMmI1ZTc2MSAoImlvbW11L3Z0LWQ6IEF1eC1kb21haW4g
c3BlY2lmaWMgZG9tYWluDQo+IGF0dGFjaC9kZXRhY2giKQ0KPiBBY2tlZC1ieTogTHUgQmFvbHUg
PGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCg0KdGhhbmtzLA0KDQpSZWdhcmRzLA0KWWkgTGl1
DQoNCj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0KPiANCj4gPiAtLS0NCj4gPiAgIGRyaXZlcnMv
aW9tbXUvaW50ZWwvaW9tbXUuYyB8IDk1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0t
LS0tDQo+IC0tDQo+ID4gICBpbmNsdWRlL2xpbnV4L2ludGVsLWlvbW11LmggfCAxNiArKysrKy0t
DQo+ID4gICAyIGZpbGVzIGNoYW5nZWQsIDgyIGluc2VydGlvbnMoKyksIDI5IGRlbGV0aW9ucygt
KQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2Ry
aXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+IGluZGV4IDc4ODExOWM1YjAyMS4uZDc3MjBh
ODM2MjY4IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+IEBAIC0xODc3LDYgKzE4Nzcs
NyBAQCBzdGF0aWMgc3RydWN0IGRtYXJfZG9tYWluICphbGxvY19kb21haW4oaW50DQo+IGZsYWdz
KQ0KPiA+ICAgCQlkb21haW4tPmZsYWdzIHw9IERPTUFJTl9GTEFHX1VTRV9GSVJTVF9MRVZFTDsN
Cj4gPiAgIAlkb21haW4tPmhhc19pb3RsYl9kZXZpY2UgPSBmYWxzZTsNCj4gPiAgIAlJTklUX0xJ
U1RfSEVBRCgmZG9tYWluLT5kZXZpY2VzKTsNCj4gPiArCUlOSVRfTElTVF9IRUFEKCZkb21haW4t
PnN1YmRldmljZXMpOw0KPiA+DQo+ID4gICAJcmV0dXJuIGRvbWFpbjsNCj4gPiAgIH0NCj4gPiBA
QCAtMjU0Nyw3ICsyNTQ4LDcgQEAgc3RhdGljIHN0cnVjdCBkbWFyX2RvbWFpbg0KPiAqZG1hcl9p
bnNlcnRfb25lX2Rldl9pbmZvKHN0cnVjdCBpbnRlbF9pb21tdSAqaW9tbXUsDQo+ID4gICAJaW5m
by0+aW9tbXUgPSBpb21tdTsNCj4gPiAgIAlpbmZvLT5wYXNpZF90YWJsZSA9IE5VTEw7DQo+ID4g
ICAJaW5mby0+YXV4ZF9lbmFibGVkID0gMDsNCj4gPiAtCUlOSVRfTElTVF9IRUFEKCZpbmZvLT5h
dXhpbGlhcnlfZG9tYWlucyk7DQo+ID4gKwlJTklUX0xJU1RfSEVBRCgmaW5mby0+c3ViZGV2aWNl
cyk7DQo+ID4NCj4gPiAgIAlpZiAoZGV2ICYmIGRldl9pc19wY2koZGV2KSkgew0KPiA+ICAgCQlz
dHJ1Y3QgcGNpX2RldiAqcGRldiA9IHRvX3BjaV9kZXYoaW5mby0+ZGV2KTsNCj4gPiBAQCAtNDQ3
NSwzMyArNDQ3Niw2MSBAQCBpc19hdXhfZG9tYWluKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0
DQo+IGlvbW11X2RvbWFpbiAqZG9tYWluKQ0KPiA+ICAgCQkJZG9tYWluLT50eXBlID09IElPTU1V
X0RPTUFJTl9VTk1BTkFHRUQ7DQo+ID4gICB9DQo+ID4NCj4gPiAtc3RhdGljIHZvaWQgYXV4aWxp
YXJ5X2xpbmtfZGV2aWNlKHN0cnVjdCBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+IC0JCQkJICBz
dHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gK3N0YXRpYyBpbmxpbmUgc3RydWN0IHN1YmRldl9kb21h
aW5faW5mbyAqDQo+ID4gK2xvb2t1cF9zdWJkZXZfaW5mbyhzdHJ1Y3QgZG1hcl9kb21haW4gKmRv
bWFpbiwgc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3Qgc3ViZGV2X2Rv
bWFpbl9pbmZvICpzaW5mbzsNCj4gPiArDQo+ID4gKwlpZiAoIWxpc3RfZW1wdHkoJmRvbWFpbi0+
c3ViZGV2aWNlcykpIHsNCj4gPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNpbmZvLCAmZG9tYWlu
LT5zdWJkZXZpY2VzLA0KPiBsaW5rX2RvbWFpbikgew0KPiA+ICsJCQlpZiAoc2luZm8tPnBkZXYg
PT0gZGV2KQ0KPiA+ICsJCQkJcmV0dXJuIHNpbmZvOw0KPiA+ICsJCX0NCj4gPiArCX0NCj4gPiAr
DQo+ID4gKwlyZXR1cm4gTlVMTDsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhdXhp
bGlhcnlfbGlua19kZXZpY2Uoc3RydWN0IGRtYXJfZG9tYWluICpkb21haW4sDQo+ID4gKwkJCQkg
c3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAgew0KPiA+ICAgCXN0cnVjdCBkZXZpY2VfZG9tYWlu
X2luZm8gKmluZm8gPSBnZXRfZG9tYWluX2luZm8oZGV2KTsNCj4gPiArCXN0cnVjdCBzdWJkZXZf
ZG9tYWluX2luZm8gKnNpbmZvID0gbG9va3VwX3N1YmRldl9pbmZvKGRvbWFpbiwNCj4gZGV2KTsN
Cj4gPg0KPiA+ICAgCWFzc2VydF9zcGluX2xvY2tlZCgmZGV2aWNlX2RvbWFpbl9sb2NrKTsNCj4g
PiAgIAlpZiAoV0FSTl9PTighaW5mbykpDQo+ID4gLQkJcmV0dXJuOw0KPiA+ICsJCXJldHVybiAt
RUlOVkFMOw0KPiA+ICsNCj4gPiArCWlmICghc2luZm8pIHsNCj4gPiArCQlzaW5mbyA9IGt6YWxs
b2Moc2l6ZW9mKCpzaW5mbyksIEdGUF9BVE9NSUMpOw0KPiA+ICsJCXNpbmZvLT5kb21haW4gPSBk
b21haW47DQo+ID4gKwkJc2luZm8tPnBkZXYgPSBkZXY7DQo+ID4gKwkJbGlzdF9hZGQoJnNpbmZv
LT5saW5rX3BoeXMsICZpbmZvLT5zdWJkZXZpY2VzKTsNCj4gPiArCQlsaXN0X2FkZCgmc2luZm8t
PmxpbmtfZG9tYWluLCAmZG9tYWluLT5zdWJkZXZpY2VzKTsNCj4gPiArCX0NCj4gPg0KPiA+IC0J
ZG9tYWluLT5hdXhkX3JlZmNudCsrOw0KPiA+IC0JbGlzdF9hZGQoJmRvbWFpbi0+YXV4ZCwgJmlu
Zm8tPmF1eGlsaWFyeV9kb21haW5zKTsNCj4gPiArCXJldHVybiArK3NpbmZvLT51c2VyczsNCj4g
PiAgIH0NCj4gPg0KPiA+IC1zdGF0aWMgdm9pZCBhdXhpbGlhcnlfdW5saW5rX2RldmljZShzdHJ1
Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwNCj4gPiAtCQkJCSAgICBzdHJ1Y3QgZGV2aWNlICpkZXYp
DQo+ID4gK3N0YXRpYyBpbnQgYXV4aWxpYXJ5X3VubGlua19kZXZpY2Uoc3RydWN0IGRtYXJfZG9t
YWluICpkb21haW4sDQo+ID4gKwkJCQkgICBzdHJ1Y3QgZGV2aWNlICpkZXYpDQo+ID4gICB7DQo+
ID4gICAJc3RydWN0IGRldmljZV9kb21haW5faW5mbyAqaW5mbyA9IGdldF9kb21haW5faW5mbyhk
ZXYpOw0KPiA+ICsJc3RydWN0IHN1YmRldl9kb21haW5faW5mbyAqc2luZm8gPSBsb29rdXBfc3Vi
ZGV2X2luZm8oZG9tYWluLA0KPiBkZXYpOw0KPiA+ICsJaW50IHJldDsNCj4gPg0KPiA+ICAgCWFz
c2VydF9zcGluX2xvY2tlZCgmZGV2aWNlX2RvbWFpbl9sb2NrKTsNCj4gPiAtCWlmIChXQVJOX09O
KCFpbmZvKSkNCj4gPiAtCQlyZXR1cm47DQo+ID4gKwlpZiAoV0FSTl9PTighaW5mbyB8fCAhc2lu
Zm8gfHwgc2luZm8tPnVzZXJzIDw9IDApKQ0KPiA+ICsJCXJldHVybiAtRUlOVkFMOw0KPiA+DQo+
ID4gLQlsaXN0X2RlbCgmZG9tYWluLT5hdXhkKTsNCj4gPiAtCWRvbWFpbi0+YXV4ZF9yZWZjbnQt
LTsNCj4gPiArCXJldCA9IC0tc2luZm8tPnVzZXJzOw0KPiA+ICsJaWYgKCFyZXQpIHsNCj4gPiAr
CQlsaXN0X2RlbCgmc2luZm8tPmxpbmtfcGh5cyk7DQo+ID4gKwkJbGlzdF9kZWwoJnNpbmZvLT5s
aW5rX2RvbWFpbik7DQo+ID4gKwkJa2ZyZWUoc2luZm8pOw0KPiA+ICsJfQ0KPiA+DQo+ID4gLQlp
ZiAoIWRvbWFpbi0+YXV4ZF9yZWZjbnQgJiYgZG9tYWluLT5kZWZhdWx0X3Bhc2lkID4gMCkNCj4g
PiAtCQlpb2FzaWRfcHV0KGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCk7DQo+ID4gKwlyZXR1cm4gcmV0
Ow0KPiA+ICAgfQ0KPiA+DQo+ID4gICBzdGF0aWMgaW50IGF1eF9kb21haW5fYWRkX2RldihzdHJ1
Y3QgZG1hcl9kb21haW4gKmRvbWFpbiwNCj4gPiBAQCAtNDUzMCw2ICs0NTU5LDE5IEBAIHN0YXRp
YyBpbnQgYXV4X2RvbWFpbl9hZGRfZGV2KHN0cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9tYWluLA0K
PiA+ICAgCX0NCj4gPg0KPiA+ICAgCXNwaW5fbG9ja19pcnFzYXZlKCZkZXZpY2VfZG9tYWluX2xv
Y2ssIGZsYWdzKTsNCj4gPiArCXJldCA9IGF1eGlsaWFyeV9saW5rX2RldmljZShkb21haW4sIGRl
dik7DQo+ID4gKwlpZiAocmV0IDw9IDApDQo+ID4gKwkJZ290byBsaW5rX2ZhaWxlZDsNCj4gPiAr
DQo+ID4gKwkvKg0KPiA+ICsJICogU3ViZGV2aWNlcyBmcm9tIHRoZSBzYW1lIHBoeXNpY2FsIGRl
dmljZSBjYW4gYmUgYXR0YWNoZWQgdG8gdGhlDQo+ID4gKwkgKiBzYW1lIGRvbWFpbi4gRm9yIHN1
Y2ggY2FzZXMsIG9ubHkgdGhlIGZpcnN0IHN1YmRldmljZSBhdHRhY2htZW50DQo+ID4gKwkgKiBu
ZWVkcyB0byBnbyB0aHJvdWdoIHRoZSBmdWxsIHN0ZXBzIGluIHRoaXMgZnVuY3Rpb24uIFNvIGlm
IHJldCA+DQo+ID4gKwkgKiAxLCBqdXN0IGdvdG8gb3V0Lg0KPiA+ICsJICovDQo+ID4gKwlpZiAo
cmV0ID4gMSkNCj4gPiArCQlnb3RvIG91dDsNCj4gPiArDQo+ID4gICAJLyoNCj4gPiAgIAkgKiBp
b21tdS0+bG9jayBtdXN0IGJlIGhlbGQgdG8gYXR0YWNoIGRvbWFpbiB0byBpb21tdSBhbmQgc2V0
dXANCj4gdGhlDQo+ID4gICAJICogcGFzaWQgZW50cnkgZm9yIHNlY29uZCBsZXZlbCB0cmFuc2xh
dGlvbi4NCj4gPiBAQCAtNDU0OCwxMCArNDU5MCw5IEBAIHN0YXRpYyBpbnQgYXV4X2RvbWFpbl9h
ZGRfZGV2KHN0cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+ICAgCQkJCQkJICAgICBk
b21haW4tPmRlZmF1bHRfcGFzaWQpOw0KPiA+ICAgCWlmIChyZXQpDQo+ID4gICAJCWdvdG8gdGFi
bGVfZmFpbGVkOw0KPiA+IC0Jc3Bpbl91bmxvY2soJmlvbW11LT5sb2NrKTsNCj4gPiAtDQo+ID4g
LQlhdXhpbGlhcnlfbGlua19kZXZpY2UoZG9tYWluLCBkZXYpOw0KPiA+DQo+ID4gKwlzcGluX3Vu
bG9jaygmaW9tbXUtPmxvY2spOw0KPiA+ICtvdXQ6DQo+ID4gICAJc3Bpbl91bmxvY2tfaXJxcmVz
dG9yZSgmZGV2aWNlX2RvbWFpbl9sb2NrLCBmbGFncyk7DQo+ID4NCj4gPiAgIAlyZXR1cm4gMDsN
Cj4gPiBAQCAtNDU2MCw4ICs0NjAxLDEwIEBAIHN0YXRpYyBpbnQgYXV4X2RvbWFpbl9hZGRfZGV2
KHN0cnVjdA0KPiBkbWFyX2RvbWFpbiAqZG9tYWluLA0KPiA+ICAgCWRvbWFpbl9kZXRhY2hfaW9t
bXUoZG9tYWluLCBpb21tdSk7DQo+ID4gICBhdHRhY2hfZmFpbGVkOg0KPiA+ICAgCXNwaW5fdW5s
b2NrKCZpb21tdS0+bG9jayk7DQo+ID4gKwlhdXhpbGlhcnlfdW5saW5rX2RldmljZShkb21haW4s
IGRldik7DQo+ID4gK2xpbmtfZmFpbGVkOg0KPiA+ICAgCXNwaW5fdW5sb2NrX2lycXJlc3RvcmUo
JmRldmljZV9kb21haW5fbG9jaywgZmxhZ3MpOw0KPiA+IC0JaWYgKCFkb21haW4tPmF1eGRfcmVm
Y250ICYmIGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCA+IDApDQo+ID4gKwlpZiAobGlzdF9lbXB0eSgm
ZG9tYWluLT5zdWJkZXZpY2VzKSAmJiBkb21haW4tPmRlZmF1bHRfcGFzaWQgPiAwKQ0KPiA+ICAg
CQlpb2FzaWRfcHV0KGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCk7DQo+ID4NCj4gPiAgIAlyZXR1cm4g
cmV0Ow0KPiA+IEBAIC00NTgxLDE0ICs0NjI0LDE4IEBAIHN0YXRpYyB2b2lkIGF1eF9kb21haW5f
cmVtb3ZlX2RldihzdHJ1Y3QNCj4gZG1hcl9kb21haW4gKmRvbWFpbiwNCj4gPiAgIAlpbmZvID0g
Z2V0X2RvbWFpbl9pbmZvKGRldik7DQo+ID4gICAJaW9tbXUgPSBpbmZvLT5pb21tdTsNCj4gPg0K
PiA+IC0JYXV4aWxpYXJ5X3VubGlua19kZXZpY2UoZG9tYWluLCBkZXYpOw0KPiA+IC0NCj4gPiAt
CXNwaW5fbG9jaygmaW9tbXUtPmxvY2spOw0KPiA+IC0JaW50ZWxfcGFzaWRfdGVhcl9kb3duX2Vu
dHJ5KGlvbW11LCBkZXYsIGRvbWFpbi0+ZGVmYXVsdF9wYXNpZCwNCj4gZmFsc2UpOw0KPiA+IC0J
ZG9tYWluX2RldGFjaF9pb21tdShkb21haW4sIGlvbW11KTsNCj4gPiAtCXNwaW5fdW5sb2NrKCZp
b21tdS0+bG9jayk7DQo+ID4gKwlpZiAoIWF1eGlsaWFyeV91bmxpbmtfZGV2aWNlKGRvbWFpbiwg
ZGV2KSkgew0KPiA+ICsJCXNwaW5fbG9jaygmaW9tbXUtPmxvY2spOw0KPiA+ICsJCWludGVsX3Bh
c2lkX3RlYXJfZG93bl9lbnRyeShpb21tdSwgZGV2LA0KPiA+ICsJCQkJCSAgICBkb21haW4tPmRl
ZmF1bHRfcGFzaWQsIGZhbHNlKTsNCj4gPiArCQlkb21haW5fZGV0YWNoX2lvbW11KGRvbWFpbiwg
aW9tbXUpOw0KPiA+ICsJCXNwaW5fdW5sb2NrKCZpb21tdS0+bG9jayk7DQo+ID4gKwl9DQo+ID4N
Cj4gPiAgIAlzcGluX3VubG9ja19pcnFyZXN0b3JlKCZkZXZpY2VfZG9tYWluX2xvY2ssIGZsYWdz
KTsNCj4gPiArDQo+ID4gKwlpZiAobGlzdF9lbXB0eSgmZG9tYWluLT5zdWJkZXZpY2VzKSAmJiBk
b21haW4tPmRlZmF1bHRfcGFzaWQgPiAwKQ0KPiA+ICsJCWlvYXNpZF9wdXQoZG9tYWluLT5kZWZh
dWx0X3Bhc2lkKTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgc3RhdGljIGludCBwcmVwYXJlX2RvbWFp
bl9hdHRhY2hfZGV2aWNlKHN0cnVjdCBpb21tdV9kb21haW4NCj4gKmRvbWFpbiwNCj4gPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oIGIvaW5jbHVkZS9saW51eC9pbnRl
bC1pb21tdS5oDQo+ID4gaW5kZXggOTQ1MjI2ODVhMGQ5Li4wOWM2YTBiZjM4OTIgMTAwNjQ0DQo+
ID4gLS0tIGEvaW5jbHVkZS9saW51eC9pbnRlbC1pb21tdS5oDQo+ID4gKysrIGIvaW5jbHVkZS9s
aW51eC9pbnRlbC1pb21tdS5oDQo+ID4gQEAgLTUzMywxMSArNTMzLDEwIEBAIHN0cnVjdCBkbWFy
X2RvbWFpbiB7DQo+ID4gICAJCQkJCS8qIERvbWFpbiBpZHMgcGVyIElPTU1VLiBVc2UgdTE2DQo+
IHNpbmNlDQo+ID4gICAJCQkJCSAqIGRvbWFpbiBpZHMgYXJlIDE2IGJpdCB3aWRlDQo+IGFjY29y
ZGluZw0KPiA+ICAgCQkJCQkgKiB0byBWVC1kIHNwZWMsIHNlY3Rpb24gOS4zICovDQo+ID4gLQl1
bnNpZ25lZCBpbnQJYXV4ZF9yZWZjbnQ7CS8qIFJlZmNvdW50IG9mIGF1eGlsaWFyeSBhdHRhY2hp
bmcgKi8NCj4gPg0KPiA+ICAgCWJvb2wgaGFzX2lvdGxiX2RldmljZTsNCj4gPiAgIAlzdHJ1Y3Qg
bGlzdF9oZWFkIGRldmljZXM7CS8qIGFsbCBkZXZpY2VzJyBsaXN0ICovDQo+ID4gLQlzdHJ1Y3Qg
bGlzdF9oZWFkIGF1eGQ7CQkvKiBsaW5rIHRvIGRldmljZSdzIGF1eGlsaWFyeSBsaXN0ICovDQo+
ID4gKwlzdHJ1Y3QgbGlzdF9oZWFkIHN1YmRldmljZXM7CS8qIGFsbCBzdWJkZXZpY2VzJyBsaXN0
ICovDQo+ID4gICAJc3RydWN0IGlvdmFfZG9tYWluIGlvdmFkOwkvKiBpb3ZhJ3MgdGhhdCBiZWxv
bmcgdG8gdGhpcyBkb21haW4NCj4gKi8NCj4gPg0KPiA+ICAgCXN0cnVjdCBkbWFfcHRlCSpwZ2Q7
CQkvKiB2aXJ0dWFsIGFkZHJlc3MgKi8NCj4gPiBAQCAtNjEwLDE0ICs2MDksMjEgQEAgc3RydWN0
IGludGVsX2lvbW11IHsNCj4gPiAgIAlzdHJ1Y3QgZG1hcl9kcmhkX3VuaXQgKmRyaGQ7DQo+ID4g
ICB9Ow0KPiA+DQo+ID4gKy8qIFBlciBzdWJkZXZpY2UgcHJpdmF0ZSBkYXRhICovDQo+ID4gK3N0
cnVjdCBzdWJkZXZfZG9tYWluX2luZm8gew0KPiA+ICsJc3RydWN0IGxpc3RfaGVhZCBsaW5rX3Bo
eXM7CS8qIGxpbmsgdG8gcGh5cyBkZXZpY2Ugc2libGluZ3MgKi8NCj4gPiArCXN0cnVjdCBsaXN0
X2hlYWQgbGlua19kb21haW47CS8qIGxpbmsgdG8gZG9tYWluIHNpYmxpbmdzICovDQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpwZGV2OwkJLyogcGh5c2ljYWwgZGV2aWNlIGRlcml2ZWQgZnJvbSAqLw0K
PiA+ICsJc3RydWN0IGRtYXJfZG9tYWluICpkb21haW47CS8qIGF1eC1kb21haW4gKi8NCj4gPiAr
CWludCB1c2VyczsJCQkvKiB1c2VyIGNvdW50ICovDQo+ID4gK307DQo+ID4gKw0KPiA+ICAgLyog
UENJIGRvbWFpbi1kZXZpY2UgcmVsYXRpb25zaGlwICovDQo+ID4gICBzdHJ1Y3QgZGV2aWNlX2Rv
bWFpbl9pbmZvIHsNCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIGxpbms7CS8qIGxpbmsgdG8gZG9t
YWluIHNpYmxpbmdzICovDQo+ID4gICAJc3RydWN0IGxpc3RfaGVhZCBnbG9iYWw7IC8qIGxpbmsg
dG8gZ2xvYmFsIGxpc3QgKi8NCj4gPiAgIAlzdHJ1Y3QgbGlzdF9oZWFkIHRhYmxlOwkvKiBsaW5r
IHRvIHBhc2lkIHRhYmxlICovDQo+ID4gLQlzdHJ1Y3QgbGlzdF9oZWFkIGF1eGlsaWFyeV9kb21h
aW5zOyAvKiBhdXhpbGlhcnkgZG9tYWlucw0KPiA+IC0JCQkJCSAgICAgKiBhdHRhY2hlZCB0byB0
aGlzIGRldmljZQ0KPiA+IC0JCQkJCSAgICAgKi8NCj4gPiArCXN0cnVjdCBsaXN0X2hlYWQgc3Vi
ZGV2aWNlczsgLyogc3ViZGV2aWNlcyBzaWJsaW5nICovDQo+ID4gICAJdTMyIHNlZ21lbnQ7CQkv
KiBQQ0kgc2VnbWVudCBudW1iZXIgKi8NCj4gPiAgIAl1OCBidXM7CQkJLyogUENJIGJ1cyBudW1i
ZXIgKi8NCj4gPiAgIAl1OCBkZXZmbjsJCS8qIFBDSSBkZXZmbiBudW1iZXIgKi8NCj4gPg0KX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KaW9tbXUgbWFpbGlu
ZyBsaXN0CmlvbW11QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2lvbW11
