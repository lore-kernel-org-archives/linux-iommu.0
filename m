Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E237C2C0
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 23:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680133262; x=1711669262;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=yubtVr/5fgvpKIUAD3rdf4tpsibQjeuQxPc5Jn0FaJM=;
  b=EhV9dVhiFjQVuVsE3+jZbTSw1Cmzr2IXYNecPhNKlmzkCXkf1BDsobHW
   o4HMJeECLKF9jGBDHCuRIVcr9w/nMV16YHgHGjhBgRWTMXd2UGQxkmLgC
   bxtnhujArF8AZJRZyTqlpKMBhn6Xjh5AlNUs7VcaG4XEuTomOTpfYtfcV
   TcNBZZo7sPuVxhIghNbn8BR5niieWgfCZQFx2/ARel5Cz0JanubbXad5l
   TdaJamdr/030wEVMKiW4O1phBafkxfJtwVsib34Wa7YeLeTauwLPi+i0o
   pO3+dl4Vogd4uqrnRa7zbk+GoaQw4jJB8yqtUc+FLLwe/Z72znve6QAkz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="427300715"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="427300715"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:41:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="634660120"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="634660120"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga003.jf.intel.com with ESMTP; 29 Mar 2023 16:41:01 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 16:41:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 29 Mar 2023 16:41:00 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.42) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.21; Wed, 29 Mar 2023 16:41:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InJDRNB33mzP2AF7iFbUBrcttIZGOfdmn9NBZGDYhaN9qw7vHrQ2+dAyH+m3KlAeqFXTQyCP5+onxI+Cf4B5iLE/o9QdyaUnR4fO6aatdovzaNR6aQKNpItg+d3bIKhmnRVgyTvEtg4THE1qrIkTfjEd+KEwFgsDhbXSAI8QsSi7VKVdyAkLIrkSrSRZmLKZKL5hR6sDcKrVaVIBy+QHksmiKCXw57ka/acH+b2QBaWs1cV+gvYcG379wR8IhOcu6i+/riUn1wnIxczMmNj2xn8JcQIEmZFgYZEX8piV+RsZPaoMbMfL5oythzHJx/pyrCRvXNfO2ntAfzXE2bPS0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yubtVr/5fgvpKIUAD3rdf4tpsibQjeuQxPc5Jn0FaJM=;
 b=e4ttyB8pYZ4EitI0H6/dsefiL4qCu9dED+XvOlHzyjz6XDtNLvGuNzxQqmsmWn/aDpwYXJDSj78ZEQBidJw1bCJJm1u0n20JpBhyl/aIC0lDBI9IxECRQVRriAyYa2NlCf4XvB/Q35rvl4luwsVT6rSwyY/kXRyMRvEXmz9z74wzeUp3FWWXIEwNHR2db4E42pZx5yzS6oAP7EQUZxXClwae1xbnTEpfkCDNxVdRB3CQobKIA+X6Kuz77d5y/1cHwXgYB70CoR8o7oxsOfQ9R7bAs/MTEBjkXC8oqChI4on5s0gcvUH8DG2E2Qq4Gd3DFnpnhMXBStZ0DP92fS1zLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by BN9PR11MB5449.namprd11.prod.outlook.com (2603:10b6:408:11e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6222.33; Wed, 29 Mar
 2023 23:40:58 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6e3:782b:3976:5005%4]) with mapi id 15.20.6222.035; Wed, 29 Mar 2023
 23:40:58 +0000
From: "Zhang, Tina" <tina.zhang@intel.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: RE: [PATCH 3/4] iommu/vt-d: Fix quoted string split across lines
Thread-Topic: [PATCH 3/4] iommu/vt-d: Fix quoted string split across lines
Thread-Index: AQHZYkDz50nBrwMgLUqlAxIlbElioq8RwuuAgACm0vA=
Date: Wed, 29 Mar 2023 23:40:57 +0000
Message-ID: <MW5PR11MB5881A48A86443D530380846889899@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230329124654.2698853-1-tina.zhang@intel.com>
 <20230329124654.2698853-4-tina.zhang@intel.com>
 <96c82f7e-89ab-afc4-32e8-10fbaca3be2a@linux.intel.com>
In-Reply-To: <96c82f7e-89ab-afc4-32e8-10fbaca3be2a@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|BN9PR11MB5449:EE_
x-ms-office365-filtering-correlation-id: abf67d64-931f-4b15-d7e5-08db30af0bf7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lMNZ0ZEgAuKPeyf0oJV3MZOc9PjdTD4BuWlp+vjTUpAOKSm9Zr3BdP4MgFeWivdFmkS5yfWmM8qG5XHiqHbEumcwQ9LZIjNoBVaTIOUfI1Ajj98T3/m6sPHvLNRLbqf32Iv+l6r1qeNbZxBdlPcpsV84SvjMlgxQW4es212jN0yxG/kzWYh4Yp/POpraY1u0qkMG25Z08wZ5EsJFImF1p29cb4yooIiazJlr/GMza7HwwXlTHOCdywY4ky8oiUsxv+cwo6expg3OfGLs56myYyzdhGpZbfhElgSrQF2VU8bjzQMsikFug6cjQnYPUTsjIAC0adtOu/THdmMM63Wz0ndZg4+0xlxv/VkspMsSLRiL+X5ZqZf159S+8iPLCEbPr1l7Dqlz0Z7py2Ap80hOuBKhh2Iuo+UvYKElhAxmbbJN0FFIIi85cwbwz2+2rG6Uz6On0ygOPJgX302/gOWrIHhKgauptIQ0BI65yohJGU74yCZb8Vnay5/UvKhp+LNKjZAPIt01Yq42XayMVwHUtEHpIqNUN1Zpj3qQ6dxoYbJAQC46Cf23QHDUftjqX5oHsGW0na3yCT5dymzMeIFfD7cNXQyiDjuTtZETyapI4jcl+MJphPp1le8BiJL/+cZM
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(366004)(346002)(136003)(376002)(451199021)(64756008)(7696005)(8936002)(478600001)(66946007)(110136005)(316002)(9686003)(6506007)(53546011)(71200400001)(26005)(52536014)(66446008)(66476007)(2906002)(8676002)(76116006)(186003)(66556008)(41300700001)(122000001)(33656002)(55016003)(82960400001)(38070700005)(38100700002)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?T3ZWRlA0dzRleXZwWmptMzJBaGl6dGl0dTZtSUt3M2REbFNOSmVCdWRndWNG?=
 =?utf-8?B?R2VjQlBGWWdQdUpnOElSR0VqZ1ZVQ29IU3VZa01VKzU3VlVkdTlHUG8xeStU?=
 =?utf-8?B?WFQ3NnFGV0ptOGdQaWJFRFRiY080Z3dMTENTTHVwUXdadVl3RUpRblMvNWxk?=
 =?utf-8?B?c2lFcmxnVG5hQ1F5bmlOZit1eTJDTS8zajVYd2VDRkNjR016dmNWbHZDcThU?=
 =?utf-8?B?QzBhcXlJOGROTTIwMUpOdG95TVNlMFZySkRPNCs5bGlzNTdqbUExNjlsc2lC?=
 =?utf-8?B?emd1RWZzeGJ1RW9NcmlPZ2t5ODNXOStxOG1VeTRMc1BVa1NxMTZUNldsZ212?=
 =?utf-8?B?RUlJY1puSzZ5dDhGaGMwOWNjNXBTUDBzbVBRNnNmSU1JU0NzeVRHK1pwMVJm?=
 =?utf-8?B?MjVzWEVVbHN1dW0wcFNBaGxpS2VZK2RGQ2gzVnlxN2JjOFV4NTR6bktEVklx?=
 =?utf-8?B?VHBkM1JsOHhOYktWREZBSzZQY3RUZWpqeGpTUEdlOVdCTlEvVFcxOXhya2Vh?=
 =?utf-8?B?UERXUDFZTWxPSkIzNHNaSEw1MUZCbFpJNlEyR29RVlVIeU4zbm5hSXhmd0Uz?=
 =?utf-8?B?QW5nOC9wV2pKbEtOYTNudUI3SEhobUtIdVpldlJ1NHZBT3M0MGkwZ3lWcE56?=
 =?utf-8?B?eU5qVUY5TlU2QWtCTzFGQjBkd2RuSm0vUzF2V2x6VDkxOTEwWllPRXVPZ2tl?=
 =?utf-8?B?R2U2bHY1aWhhbXBoTUYyYTVqbkY5TklYSFNka204OGFEdlJxYmt2emhBQXQ0?=
 =?utf-8?B?ZmpmcE1peTZnSVhOaHBoWEpic25HMFhVM2tIRXFENlhMcVZEMHNQWG13ZE94?=
 =?utf-8?B?NS9zZ3VDUy9hNkFQWkRFTjNhUndiekRqeGM3SXpKTE9lMDZ6UUU4bHl0T0N1?=
 =?utf-8?B?c3Q5VEZNKzRETDdVRlFqQ3FQUUsxK3I5c2FMTmxjUUM2RVhCc201dDRER2VS?=
 =?utf-8?B?QjJLcjRuYXk2L3drOTNXSEkwaVhoTFNFZHdqV1NVdmZEQXlkcDA2V1AwWkZH?=
 =?utf-8?B?VWdYUlZGcysrY2UxMmI2SUdjVHRaN01ZcFdHZ0RrYW1qSHBtMzJTdldMSHNC?=
 =?utf-8?B?dWtXMTJqMVRFWWxxWk1kQ2ZqY29oK3dnQ1VYTzZ3dzE4Z3R6cU1RcG1IVWRY?=
 =?utf-8?B?WjVJa3ZGbnVuU21kb0EyZEtBdkNmcVJxMGtDejR4RHpmOUlQb2V2aGgzVzMw?=
 =?utf-8?B?Z3FLSkhkZVVoSE5mVkY4a25TNVlISm55MS9oUEdMNStxbTFUU3pON1JxZUIr?=
 =?utf-8?B?Z1FRNWpRTzdrVEk3b1hoeU54VFNWSGlIczl6OVArVHVrRDUyWFYrNXVaVGQz?=
 =?utf-8?B?a2cxRGQ3OVhUZEp5RmxLL2lpSUlKaThHOFlySGw1TVNsak1RUjk4ZXIvZ29z?=
 =?utf-8?B?THdZQlVvRHRZUzVWZWhjWXEyYzFxeGttM29naEFtejBQWmhJakZJRWZLYXhJ?=
 =?utf-8?B?TnBGVG5HWEJTandXVzQ1dExKQnpXRzJlY1g4bHNtenp3d3pkcXJpMnBkNkJ0?=
 =?utf-8?B?SnliazhlNlgxVUp3T2FIQ0tDQWY4RHM4TjZseTB0WTE4aEt3SXdVREVlbHo4?=
 =?utf-8?B?VWFSTVFET0FFZ3ZKQ0xoZWVMMEVGMTJlU1liTDFiZ1dOcHpseUk0eE9EM0lm?=
 =?utf-8?B?UWxoMkJNWGkwOEkwcVdiZ3pvaEZ3RnN5bzIyTHZMMCtxN0pSQmxKek1jRVR2?=
 =?utf-8?B?SVh1YXhpZ3lVK2l3VDlyeTAyTVdESk1BWlpEZmhEUC9sTW9DUXppSlhvRGVl?=
 =?utf-8?B?a3l5WUVpR0pjZmQzQW1RRmFob3NmempINm1FTVdlY1k1S2pQQ2J2WHdNcXBa?=
 =?utf-8?B?TU9TaGtRZXk1WWJRMWI1dTR5OVNRd1ROSWlEY1pDT1NVbWI2TkdmWURYd1Zv?=
 =?utf-8?B?aS9TZlFNTVNiVzNKeHNmZW5hbVhEOHNrZDkzcXdyYytIMUs2amNKM05EeVRl?=
 =?utf-8?B?MkdYc3R5amQzb25rb05LdUtsTDByTUtmby9zdGZsWUVkdEwvb1lKZ1BRSU5U?=
 =?utf-8?B?d3RkeFZsNGdwQUV5b3RvdmdkRzdlWlNUeDFjRTVSTkVhbzZSQktuM2NBWUE2?=
 =?utf-8?B?cGx0QTZzOHVUYmVJMHBPUUdmUDErS2pvMm1xNkc2THN6bzdud1F0RnlsOE04?=
 =?utf-8?Q?dJ8c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: abf67d64-931f-4b15-d7e5-08db30af0bf7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Mar 2023 23:40:58.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgdR2JOUeDmM9laDdKRSpBzsNTkln2CyL16cTh2IYE1UKJTy6HSfD+HHGR6pDuhV5d6EJ/YxN/KyYerpfsNkKw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5449
X-OriginatorOrg: intel.com

SGksDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmFvbHUgTHUgPGJh
b2x1Lmx1QGxpbnV4LmludGVsLmNvbT4NCj4gU2VudDogV2VkbmVzZGF5LCBNYXJjaCAyOSwgMjAy
MyA5OjM4IFBNDQo+IFRvOiBaaGFuZywgVGluYSA8dGluYS56aGFuZ0BpbnRlbC5jb20+OyBpb21t
dUBsaXN0cy5saW51eC5kZXYNCj4gQ2M6IGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbQ0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIIDMvNF0gaW9tbXUvdnQtZDogRml4IHF1b3RlZCBzdHJpbmcgc3BsaXQg
YWNyb3NzIGxpbmVzDQo+IA0KPiBPbiAyMDIzLzMvMjkgMjA6NDYsIFRpbmEgWmhhbmcgd3JvdGU6
DQo+ID4gVGhpcyBwYXRjaCByZXNvbHZlcyBjaGVja3BhdGNoIHdhcm5pbmdzIGZvciBpbnRlbCBp
b21tdSBkcml2ZXIuDQo+ID4NCj4gPiBXQVJOSU5HOiBxdW90ZWQgc3RyaW5nIHNwbGl0IGFjcm9z
cyBsaW5lcw0KPiA+IAlwcl9lcnIoIiVzOiBpb21tdSB3aWR0aCAoJWQpIGlzIG5vdCAiDQo+ID4g
CQkic3VmZmljaWVudCBmb3IgdGhlIG1hcHBlZCBhZGRyZXNzICglbGx4KVxuIiwNCj4gDQo+IFdl
IHNob3VsZCBoYXZlIGF2b2lkZWQgdGhpcyBjb2RlIHN0eWxlIGF0IHRoZSBiZWdpbm5pbmcuIEJ1
dCBpdCBhbHJlYWR5IGFwcGVhcnMNCj4gaW4gTGludXMncyB0cmVlLiBJdCBkb2Vzbid0IG1ha2Ug
bW9yZSBzZW5zZSB0byBmaXggaXQgbm93Lg0KUmlnaHQuIFdlIHNhdyB0aGlzIGlzc3VlIHdoZW4g
d2UgdHJpZWQgdG8gbW92ZSB0aGUgbG9naWMgaW50byBhbm90aGVyIGZpbGUgZGVkaWNhdGVkIGZv
ciBpbyBwYWdlIHRhYmxlIGhhbmRsaW5nLiBPSy4gSSdsbCBjaGVycnktcGljayB0aGlzIHBhdGNo
IGludG8gdGhhdCBzZXJpZXMuDQoNClJlZ2FyZHMsDQotVGluYQ0KPiANCj4gQmVzdCByZWdhcmRz
LA0KPiBiYW9sdQ0KPiANCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFRpbmEgWmhhbmcgPHRpbmEu
emhhbmdAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9pb21tdS9pbnRlbC9pb21t
dS5jIHwgMyArLS0NCj4gPiAgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBkZWxl
dGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBpbmRleCAwODVkMzFhNzdmNmYu
LjI4NmJiMTc5NzNhNCAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11
LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L2ludGVsL2lvbW11LmMNCj4gPiBAQCAtNDI5NCw4
ICs0Mjk0LDcgQEAgc3RhdGljIGludCBpbnRlbF9pb21tdV9tYXAoc3RydWN0IGlvbW11X2RvbWFp
bg0KPiAqZG9tYWluLA0KPiA+ICAgCQkvKiBjaGVjayBpZiBtaW5pbXVtIGFnYXcgaXMgc3VmZmlj
aWVudCBmb3IgbWFwcGVkIGFkZHJlc3MgKi8NCj4gPiAgIAkJZW5kID0gX19ET01BSU5fTUFYX0FE
RFIoZG1hcl9kb21haW4tPmdhdykgKyAxOw0KPiA+ICAgCQlpZiAoZW5kIDwgbWF4X2FkZHIpIHsN
Cj4gPiAtCQkJcHJfZXJyKCIlczogaW9tbXUgd2lkdGggKCVkKSBpcyBub3QgIg0KPiA+IC0JCQkg
ICAgICAgInN1ZmZpY2llbnQgZm9yIHRoZSBtYXBwZWQgYWRkcmVzcyAoJWxseClcbiIsDQo+ID4g
KwkJCXByX2VycigiJXM6IGlvbW11IHdpZHRoICglZCkgaXMgbm90IHN1ZmZpY2llbnQgZm9yIHRo
ZQ0KPiBtYXBwZWQNCj4gPiArYWRkcmVzcyAoJWxseClcbiIsDQo+ID4gICAJCQkgICAgICAgX19m
dW5jX18sIGRtYXJfZG9tYWluLT5nYXcsIG1heF9hZGRyKTsNCj4gPiAgIAkJCXJldHVybiAtRUZB
VUxUOw0KPiA+ICAgCQl9DQoNCg==
