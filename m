Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD112582
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 13:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680097457; x=1711633457;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1ECuEq3RxoaGdJPU5RL/0ScBBZjS7DS43HITWrSSrm4=;
  b=NtFo2x9HEWfYqe414UXjv7+BDlpZmu8BU6SToLYDZr/ZSBQjyUfGMAmC
   lUeOQc3nGU6Oc8UlBM1FFmr0Vx+CLBhU3VuUaJSiUefQJh9zZRXCRucsH
   Bb/JfX4wBE1qMILCd203E8j7V3fI3trFQhNZaSDF/noeyKaZgeTGNQhS/
   QpB7ZMDFKadmyxpsEK3PJ9cUO3r0oJvKnzt/dtxpNSSoE6PMvjhhvICXn
   GpTcZQ6d95E7/WQ6sRNuwBuziIrbK+cfohytR7LUrnm0xkVxS1aopEP8o
   tQ9GC23jdHK4aZX/6jHUdmnLTx28wNGm8VOnKuXwD5c/fHIVI1F9bwd7E
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343303637"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="343303637"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 06:44:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="858498014"
X-IronPort-AV: E=Sophos;i="5.98,300,1673942400"; 
   d="scan'208";a="858498014"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga005.jf.intel.com with ESMTP; 29 Mar 2023 06:44:16 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 06:44:16 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 06:44:16 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 06:44:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yjtb5hSitM67/eo6aB/A/WySgLYwy/Jh7ywdADsE6fCozfRLSLWR7v55h3lmkhyPo6CbqIb23x5vhxPovxO8MgnuBpmMVYgjiMpOlDL2ZRgnlQP3gMjwaIwN7Q+VDkge3nW7oaePR7NgCOCqsjFVmbhWEZo8ljos41IRIueLxXCgxIKBIxQUfli1O/taPpd3NDzz4tO1vnjkO9/18DN/OFQw9UO28XQjXFpRuEs9T2oty0o59/n2lJvw5Q7DldFrpFlA6y17ZnRXcB4Ypg5jiT8sS4VMrVkdzki0cMQ8qatcl/XGQqt79E4ELCop9wHrS+JNyFGgyxjFzoBKsaXMtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ECuEq3RxoaGdJPU5RL/0ScBBZjS7DS43HITWrSSrm4=;
 b=nYI7WeMfjqTN/IBFfHynKl5kB5cOjrBtV3tVrGMsqtBg+yPhTumVWIgKPGv4NaDWwuKoGrchD6wc9eSFb+vrzhNczumOlE81XfGDz5ZM3qGTHdLA3W7uWum6IxN0inx/uxwb+oXZeKtopXL9s4KSYy0o2dITQbeq4czypMHQkUbLg/OBkKAml7nKGajb97XFHaAlXGzF9i378q+qZD/VJGVeXDifapfcccLSNBb85hP/6xkbF2cQPTKY0emjCeDLpCGKVWGCDaAXTszOFwfjjBrXGTbOYiQdOIWYG0y4k1ToRTzN9jxp2PwQFEHfKpthC3Zm9ulrcfR86TVfUpe/mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by SA3PR11MB8046.namprd11.prod.outlook.com (2603:10b6:806:2fb::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.41; Wed, 29 Mar
 2023 13:44:14 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 13:44:14 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
CC: "Ma, Yongwei" <yongwei.ma@intel.com>
Subject: RE: [PATCH 2/4] iommu/vt-d: Fix operand size in bitwise operation
Thread-Topic: [PATCH 2/4] iommu/vt-d: Fix operand size in bitwise operation
Thread-Index: AQHZYkDwvzy6aIhcVk6C6UvkQyz4Wq8RwV+AgAACfrA=
Date: Wed, 29 Mar 2023 13:44:14 +0000
Message-ID: <MW5PR11MB588113EB056D4DDD1DF379F689899@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-3-tina.zhang@intel.com>
 <5315d7ee-48f4-6810-72c5-9066aa456c24@linux.intel.com>
In-Reply-To: <5315d7ee-48f4-6810-72c5-9066aa456c24@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|SA3PR11MB8046:EE_
x-ms-office365-filtering-correlation-id: b46eafec-fc7c-4f22-ef98-08db305baf6f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wlAhCITDtdWEqpk9DZfPfCmviJoeRMtQRr1UreNPZYpfK51+NixUjMylEFDoD0uoXpwH7A690IcGGAGn49cvjfIfdZPMzHe2rhTYctLHZ/o0sh8tKeNuc7OZT9OruvK0+6QQnqB+OytqlF/BRx6LJ4dM/dB598Fk2lPMjxNfAaN7OqyZp1qQ+QDzofn/gZAKkolLOpuEztKkGKwEj3RfHQxFGgMe+Z+AbBt2B2bpcFVChHZIB1a2e0L8qvGE8yRQBp5QRi0yEaWW/e7m4C8052tLDtO1u72CQ3agCFBLEc/wOJZ5kA9zBvym/lZJITYs5E4NqcIh+tPyOWAL9UaM0cXP/ovChJ+9iHNVPg8hBTswOKqshDO4stkSNYh+PTO7f8PvGQCjK86nGpUCxlG13lSf9NtZcwEDeeeva6uA572+H5ogetVy3+YgusXpW2Hx0HI6nxeHH89kgFa0JMf4nDFQjAJwfiR5XFDOtRykyc2XSQlUt6OeLs/KQm9SOKg5WxgADQjAjfMwLqn8X/1KFERw7IJT3pAe0aVQl1hjXSGIhDeacMi+Xet5hy1ucnO7CbAusJJgk/GAC3AVKKA2VEpcw7v1K0qnEFUG3g5X8ccILBPmExPwUMQxUrEmzBS3
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(8676002)(66946007)(66476007)(66556008)(66446008)(76116006)(41300700001)(2906002)(5660300002)(186003)(83380400001)(38100700002)(86362001)(38070700005)(122000001)(55016003)(33656002)(4326008)(110136005)(478600001)(82960400001)(64756008)(7696005)(71200400001)(52536014)(8936002)(26005)(9686003)(6506007)(53546011)(316002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dTN2ZzBVVTArb3JtRGpWa3lTd1dlME1sdExOY000N0JTbDFlbVpHcEkreGNk?=
 =?utf-8?B?bDRiZWY1WUJtK1F0WStKek1OODJxL25BRmJ5MW9sY0ViSkdjaklub3VDZ0Rn?=
 =?utf-8?B?RU9YdnVtdWR6ak1VVklkclBQYXE1aGRSN2hCd2pRdE9QbStydVRRa0dIVTdU?=
 =?utf-8?B?eU9wcGUwRGh3ZlVvWE1wVjhuRXJhanZ1cFo2Z2J0NjhZdHo0RmZQVG1FY1NT?=
 =?utf-8?B?aEZmQlpRK1BLa0M5VnNQaDNST1ZZeitPYVFKdk1pS1c0cVpiZ2F3UW1ic1dq?=
 =?utf-8?B?d0lGdmdmNVNIUHNHcGV2ZTdvK3MyRmhzRUFlcFNNaFhFbU5ueERsc2FYMjdG?=
 =?utf-8?B?VUVsNzVIM0Uzb1NRblplOTdxQXZVL1BvOXZEMHNIRnVmK0JlcDJ5VlpwK1Zq?=
 =?utf-8?B?NnoveEl6Q0dhcElEL0tzTXRiS0FsRlpzYTBGTWpiZDBYVThac0FMa0g0NEZp?=
 =?utf-8?B?bTk0cEowOFBMY0E4ZXNyaUNGSklwMHJaV1VwUlM2MTVESlhsMzF2Rm5YSmhn?=
 =?utf-8?B?UW8rbEpVcGUycTYxUmdLZWpzNU5BZVluS2ZjdllDd3R1blQrTmY0cG9DYk1I?=
 =?utf-8?B?ckZjeUgyTDR2alF2eGJRSjY2YUJ4dmh0K1J0WFNZWXlkL296MWhtMFdpQXZ0?=
 =?utf-8?B?akdRKzhFUFFkUjNMcTNQSXRaQ0Q3QWY1bU4rbTBMbUlCR2YxRGNiem9scEI5?=
 =?utf-8?B?NjdKRVhNS0JNSmc0NHVtNnJ6RWNXQk10ZDRwMWdBRkpaRGlQOEtTb2cyOEVy?=
 =?utf-8?B?dktDTGMyUkxFUFkwUmtsZk1QU29vMG9SU0hrU0RVanJjNUtKaHRITEdyd3Rx?=
 =?utf-8?B?aHRjSzQ0SWR1MW5ES29VOS9lQ3dmWndoODJvVEtIelVyMUI5anhnYkdvdkJH?=
 =?utf-8?B?SHp3dDcvS1FreEZPOWtVUU8vU09aL3lEa2VJT3M3SnJ0N3VRaC8zdU11Umdy?=
 =?utf-8?B?c2s0RWJaSEx1THVyRHBLd0ZCUmtYYlprdU9QQVZEVmJuZ0hkNlc4THd3R1FD?=
 =?utf-8?B?dndTbytDelVLanNjaHhvQy9relhNdExzaHpaSVJpZW5MRXhva21zWFZ5djJh?=
 =?utf-8?B?YXZMQVZsaElIMHhZbFRWTkk4Vk1BUStuQ0Vsa0xhQTlzN2t2VFZUTml4aUNW?=
 =?utf-8?B?anIwdVRPdjQxNFZxTmpWczlzM1M3UmQyVHI2a3diQTB6TEJhaTcxNnJtY01m?=
 =?utf-8?B?Y0xwbkF0aXhhdi8zUUNzcXJNUWZ3NVBOUGFWc0RoK3FXMTRFNjNHWS96RVFL?=
 =?utf-8?B?VFFrRmVZVTdobjIzZWgwZEpQbTE4RUVWQXJmUUxxOHVJWmQ2SzNPTG5acmhm?=
 =?utf-8?B?OStUUml4WENzdWtETWxtZlR6c0dwNzlPT0x5T1RpQ0hPUTcyeUhhUWFFNzVC?=
 =?utf-8?B?YURBRWFTTi9EeU9HNHJrSmtrdXFZZFV4MDFvZFNZQ1M2Z285Z2F3RWVQVWNM?=
 =?utf-8?B?VUVUOHFUUHpwVVp1S05oL28xT0wwdVlXUk1kNkxsOU51U25CNmsycE9TUWE2?=
 =?utf-8?B?bTR2c3UranNHeDZZTHhKUWp5MnAvR3UxSnExSVpZMUZ6b0dRT2d1MUcxRVg5?=
 =?utf-8?B?WlNwWG1scmR5QzFFazZqK3k4RldWbzFNT0NBSzI1K0JTSzZBTkJqSHE3cHEr?=
 =?utf-8?B?bE1JTlFFK2pwc3BkalphWVFlZDNLaVFoczNGOGtWN0UybmNJRjA1UFhRd0tr?=
 =?utf-8?B?U3VLVnJSUUNoWFYyVDRPLzJ6K01SakNqUHhPRzN0R3RuTWV1OStWM0JTUUQw?=
 =?utf-8?B?dkJBeHNLWXpnVm5DSnQ0ZXNFcWVuQUxSbkdpTS9hNUwyVGF2K1NKa0JCdXZm?=
 =?utf-8?B?MnV0VENOWFllVExZOFNDelJKRUlINktPSU9xRlRxc0FUZ3NaQUZaUHJkenZJ?=
 =?utf-8?B?anhsaGNvanJmSFp0QnpaRXl5Q3pyMzBXRGtMV0ZqcjltTHplOHdqbEU0RS9R?=
 =?utf-8?B?aHRmeWNqWWxaK1FMYzg3ekJuRjhkSklmTXM2eFczTWtxREd4QkJGZUw1ZEI0?=
 =?utf-8?B?QytPc2c0YXpiSHAxMXlTd2lrNVdlUW96K3FKaDAzMGI1ajdCWkFDZEVIK1VQ?=
 =?utf-8?B?YXFUNnJFMnZyZVpySEZLUXI4WDlmNzI1ejV4NmdjdThNUXRFRUo0eU1yWVNY?=
 =?utf-8?Q?AXfs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b46eafec-fc7c-4f22-ef98-08db305baf6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 13:44:14.6355
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zyR1TU4uz6U8pFRKJVygCl9JcM8bbllWJp83kzoWPZvzeW9/qH9wQglvxtnNnv8cOHWs7ouQghWWCWInKYBKZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8046
X-OriginatorOrg: intel.com

SGksDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEJhb2x1IEx1IDxiYW9s
dS5sdUBsaW51eC5pbnRlbC5jb20+DQo+IFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggMjksIDIwMjMg
OTozMyBQTQ0KPiBUbzogWmhhbmcsIFRpbmEgPHRpbmEuemhhbmdAaW50ZWwuY29tPjsgaW9tbXVA
bGlzdHMubGludXguZGV2DQo+IENjOiBiYW9sdS5sdUBsaW51eC5pbnRlbC5jb207IE1hLCBZb25n
d2VpIDx5b25nd2VpLm1hQGludGVsLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRdIGlv
bW11L3Z0LWQ6IEZpeCBvcGVyYW5kIHNpemUgaW4gYml0d2lzZSBvcGVyYXRpb24NCj4gDQo+IE9u
IDIwMjMvMy8yOSAyMDo0NiwgVGluYSBaaGFuZyB3cm90ZToNCj4gPiBUaGUgcGF0Y2ggZml4ZXMg
dGhlIGtsb2N3b3JrIGlzc3VlcyB0aGF0IG9wZXJhbmRzIGluIGEgYml0d2lzZQ0KPiA+IG9wZXJh
dGlvbiBoYXZlIGRpZmZlcmVudCBzaXplIGF0IGxpbmUgMTY5MiBvZiBkbWFyLmMsIGxpbmUgMTg5
OCBhbmQgbGluZSAxOTA3IG9mDQo+IGlvbW11LmMuDQo+ID4NCj4gPiBSZXBvcnRlZC1ieTogWW9u
Z3dlaSBNYSA8eW9uZ3dlaS5tYUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogVGluYSBa
aGFuZyA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gICBkcml2ZXJzL2lvbW11
L2ludGVsL2RtYXIuYyAgfCAyICstDQo+ID4gICBkcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMg
fCA0ICsrLS0NCj4gPiAgIDIgZmlsZXMgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0
aW9ucygtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5j
IGIvZHJpdmVycy9pb21tdS9pbnRlbC9kbWFyLmMNCj4gPiBpbmRleCA2YWNmZTg3OTU4OWMuLjdj
NzdhNTk4ODllYSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2RtYXIuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvZG1hci5jDQo+ID4gQEAgLTE2ODksNyArMTY4
OSw3IEBAIHN0YXRpYyB2b2lkIF9fZG1hcl9lbmFibGVfcWkoc3RydWN0IGludGVsX2lvbW11DQo+
ICppb21tdSkNCj4gPiAgIAkgKiBpcyBwcmVzZW50Lg0KPiA+ICAgCSAqLw0KPiA+ICAgCWlmIChl
Y2FwX3NtdHMoaW9tbXUtPmVjYXApKQ0KPiA+IC0JCXZhbCB8PSAoMSA8PCAxMSkgfCAxOw0KPiA+
ICsJCXZhbCB8PSAoMXVsbCA8PCAxMSkgfCAxdWxsOw0KPiANCj4gSG93IGFib3V0IEJJVF9VTEwo
MTEpIHwgQklUX1VMTCgwKT8NClRoYW5rcyBmb3IgdGhlIGFkdmljZS4gSSBkaWRuJ3Qga25vdyB0
aGV5IGFyZSBtb3JlIHBvcHVsYXIg8J+Yii4gQW55d2F5LCBJIGd1ZXNzIHdlIGNhbiB0cnkgdGhl
bSBpbnN0ZWFkLg0KDQpSZWdhcmRzLA0KLVRpbmENCj4gDQo+IERpdHRvIHRvIG90aGVyIGNoYW5n
ZXMuDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IGJhb2x1DQo+IA0KPiA+DQo+ID4gICAJcmF3X3Nw
aW5fbG9ja19pcnFzYXZlKCZpb21tdS0+cmVnaXN0ZXJfbG9jaywgZmxhZ3MpOw0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUv
aW50ZWwvaW9tbXUuYw0KPiA+IGluZGV4IDdjMmY0YmQzMzU4Mi4uMDg1ZDMxYTc3ZjZmIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvaW9tbXUvaW50ZWwvaW9tbXUuYw0KPiA+IEBAIC0xODk1LDcgKzE4OTUsNyBAQCBjb250ZXh0
X3NldF9zbV9yaWQycGFzaWQoc3RydWN0IGNvbnRleHRfZW50cnkNCj4gKmNvbnRleHQsIHVuc2ln
bmVkIGxvbmcgcGFzaWQpDQo+ID4gICAgKi8NCj4gPiAgIHN0YXRpYyBpbmxpbmUgdm9pZCBjb250
ZXh0X3NldF9zbV9kdGUoc3RydWN0IGNvbnRleHRfZW50cnkgKmNvbnRleHQpDQo+ID4gICB7DQo+
ID4gLQljb250ZXh0LT5sbyB8PSAoMSA8PCAyKTsNCj4gPiArCWNvbnRleHQtPmxvIHw9ICgxdWxs
IDw8IDIpOw0KPiA+ICAgfQ0KPiA+DQo+ID4gICAvKg0KPiA+IEBAIC0xOTA0LDcgKzE5MDQsNyBA
QCBzdGF0aWMgaW5saW5lIHZvaWQgY29udGV4dF9zZXRfc21fZHRlKHN0cnVjdA0KPiBjb250ZXh0
X2VudHJ5ICpjb250ZXh0KQ0KPiA+ICAgICovDQo+ID4gICBzdGF0aWMgaW5saW5lIHZvaWQgY29u
dGV4dF9zZXRfc21fcHJlKHN0cnVjdCBjb250ZXh0X2VudHJ5ICpjb250ZXh0KQ0KPiA+ICAgew0K
PiA+IC0JY29udGV4dC0+bG8gfD0gKDEgPDwgNCk7DQo+ID4gKwljb250ZXh0LT5sbyB8PSAoMXVs
bCA8PCA0KTsNCj4gPiAgIH0NCj4gPg0KPiA+ICAgLyogQ29udmVydCB2YWx1ZSB0byBjb250ZXh0
IFBBU0lEIGRpcmVjdG9yeSBzaXplIGZpZWxkIGNvZGluZy4gKi8NCg0K
