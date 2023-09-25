Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2041.outbound.protection.outlook.com [40.107.92.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DD81D68C
	for <iommu@lists.linux.dev>; Mon, 25 Sep 2023 16:31:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XK1OGSSh+8hxHQ/sKqMpS9FvGonIQbaRsbWJm8JgANiBVVakWIJZCxjRirOFmNQn0W0jyLpKYegyjcKBDj/dXHuDkohjkkcMZ+HdX5jnaTZIHt8QgwlaOAvRBCEmPjCyxpSeXEfGRPtCcA2WML3WR+UlJPAtsyV1qhmH82rdNCYA95CHSVXZ8Mg09EMfSSOVqnan9CDPPDC0jPXsDL85YtCaReXLhKCrjqjytk0+281WgvoBMQcHQ2dA/UVRytBSXSq0zmC1ysR9ZX7avofxw4iEQXq8DYGlzrg0dRr7LBYtOGhhX5jb6tQJCzO6QziVepizTJhm8+kIgTQaH0X1YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sGTEddE1gKweANwICZf1Tdd9GBope7BsVSHpusOwguY=;
 b=VPILZ09028YAwCYwrfkaBrTlnlKlFWmShs4Ktl04s+AqUniVH9Wsw1q5Irr47PqPQfQRV+poZIsh134DHXIihSbqoqyAccl328oHkxfsKyWHs8J1CVzOjjPFx2aHgJiLkAAVBRdoap4KYbNcrGP50bYATmgiUhL90/2pqfq/89cy4cym4jMdRcSuPHCsxP165LpOcaVraeXWfDR0kCBCR5MAAYlA7iiGihdl52OhvAxPwJmbWzZk2mK1YdduiwmLQLfKfmP+FIz5ej9DGdKYxUu9O0GqtFHE6Ds/iO6sOMY/zTHtAFtu1ipmUIFtKUjlYK+bC1wSREHIoXSNv2S9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sGTEddE1gKweANwICZf1Tdd9GBope7BsVSHpusOwguY=;
 b=gE5p2q9jDkMGQZfDSGeJmy4BxbYBnQXegzY9jWJohPD6L/2zmfUcNwd+xr47iazFVpibl6fFqWF40Diodt7mKbqgKesBqaC/KQVn0CBLRCyhsCw8BI1pWHthUlJVTnE9P8dUlTEojy4vBSsgW9o7YK4DoUk4Yk8B687v7bXgCt0=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by SJ0PR12MB5469.namprd12.prod.outlook.com (2603:10b6:a03:37f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 16:31:50 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 16:31:50 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index:
 AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IAAF7sAgAClRgCAAGyegIAANHwAgATsioCAABXmcA==
Date: Mon, 25 Sep 2023 16:31:50 +0000
Message-ID:
 <BL1PR12MB5144CE1D387F3903D121AAA9F7FCA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <f738e94d-1c1f-94e1-c4e3-752671af3c90@amd.com>
 <20230922120002.GJ13733@nvidia.com>
 <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
In-Reply-To: <c7014abb-2c8e-fc3f-5cae-75060c8dcaf5@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=93a337d4-45c3-4903-a012-15d22a6abf69;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-25T16:30:09Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|SJ0PR12MB5469:EE_
x-ms-office365-filtering-correlation-id: 5ab4cce9-1f6f-44dc-70f6-08dbbde4eb96
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jCbWdKXG4XroEAre/f/jmI9fKGEtRo/GYx94TsqdV9DghhXCSKL99PJ6+uYGGu5wqVdmYAJC0J/RIKOSnR+3InlPpVjQ3WET/IKdwjKlYKQeq7YAIU35gnJ1sv9IcIXqtz/nkN6oaG+8k36bvYpWmuPHlCQoxnDbtYY175N59+5IBRJNxyd1QU+3bDbIJKcWU0y04+qJOIfbWYIsgwkDrdjsaSFAlOJAnR0YVMIxaep7Vyu4gguL6rzz2ITqt/7k8hufT9s7B47h8wKDnLvOA48birhvbRsmfpVuWf/Z3EYIBvBHVRY2CoXDHGdl8Tq+EidqtpUA+sxQdPzS4eIy7J7cFbuWR+YvHh1HkoikoCJs1QwL+jyHlR6AvHadx7orOtAzHh/bweXWxuwyLd3Aske1j8f99lXzKZ+6v/0VD6p6P+bZLPjNop1OpH6/wWcMuSx6AnbMAjjZX5Nlnd8YQucg6dReNUC19MECksn3yfFj/mb9zOFVCewdJHvWMDbjdKUlmEzchmp+howMpdTJKId6sUgd2ALOZGIueouOFG4+sH3hXoPan5S7O0fqmhJGpkI20sc0f/cUApj8lPzKpbaYhA+dp8jN+Iy/CjGUm1g=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(1800799009)(451199024)(186009)(9686003)(7696005)(53546011)(6506007)(8676002)(83380400001)(478600001)(64756008)(5660300002)(110136005)(52536014)(2906002)(71200400001)(66476007)(76116006)(54906003)(66446008)(66946007)(316002)(66556008)(41300700001)(4326008)(8936002)(26005)(38070700005)(33656002)(122000001)(86362001)(38100700002)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXZaZ0tWNXphYjRBaU9lVkkxN205WE5JNmhLTHR3TXd0VjhYWnQ5czA3RWl6?=
 =?utf-8?B?VXZ6cGxudjZIeWJhczFhY1drSkZ5ZkJtdjkzUllQZTMvQWtNVE1nTmZ5VDRC?=
 =?utf-8?B?Z3JWaUdocTA0V1ZscnZ2RnM1c2xVbzRtUG1uZ2pUSGMwNnJSMXAvUG5DUUcz?=
 =?utf-8?B?QXQyR1dhSm9mazFoUThodTBIZTFrSlg0eHFOR0RxNTJrRUl3aGhnMDA3b3BL?=
 =?utf-8?B?WGpLZ0E1dDFBTUhaQ0RjU1lVWTZWMGg5MGlxWDFsNWdlL2NvU1VVUkEvNisy?=
 =?utf-8?B?WFY3b3ZKaHBNeXVwdVJwSUlkL0JZZFViRlc1MDI2ZGEvOVdFaWQyMXVXZzZT?=
 =?utf-8?B?akcxcytROTF2Nm43TnFoK3FVUWJIeHd0bkVGQkFBb05JL3VZQm5kUG9OTUln?=
 =?utf-8?B?eFZtZTJvYzI2VWh1c0tneUI0OXJ0NWl4R01LV0pTb29lVFhvMEMyT3ZDYnVm?=
 =?utf-8?B?ZHgwQjZ0NVNmMm5oQTFMcFNGV3FnbXBNTDc4R1lTWnpMait2eHhnSU1mMG1r?=
 =?utf-8?B?RElmcEtsK3VJcThQUXk2UXNWUlhVaGdDcnYrNTNIZjFKQ1ZxTGpCblBDMHJl?=
 =?utf-8?B?WVdVV3dVZnNqWFg1MnNjVDlMNzQrSXlSYW9MOEtRY3QvRHpzazdxWElCekxi?=
 =?utf-8?B?NDVsaFB1bWp0TUVzb1V4TmRBMnRreE5wVjhZSk5JRVlUaVhzSFNBNFhEQytS?=
 =?utf-8?B?eHhpbTc1bFo3QWJZUisyZEFvdjJHczFQVlh4MWREWFhUYU15aDdNVW1QcXp3?=
 =?utf-8?B?b3ZsWXVMSVlCQmZRbEZNQWJJbVRBcTUvN2RqU1JMQ2tJbXlScWtBMVJzUGNp?=
 =?utf-8?B?MHhEcnAzdCtna3FmQ3liNnlEV2pManRlcHN6VkNxZmNiWE5OZDBIZjhEeXBS?=
 =?utf-8?B?MGgwSXdJeDNyK1VHMTVQSHBlV3Bkekl0d051MVUzZ3YrTk5IaTRISEZodXlJ?=
 =?utf-8?B?MjhjVHp1azN0aG5FSzd3dERhVmVsNkRWaTFDejAzR2xmajE4MVdIMURkdFdG?=
 =?utf-8?B?QmdSOUhsQWpTNTFHamI3cFJSRDZwUFlvM1FNNGo0STAxc3prVjRkb1JBZTh5?=
 =?utf-8?B?Z3hsZU5BMDBFdjZGcXNWMTFNdmd1UHo1bFJDeEMrSUgrNUIzVnFEd2k2bmdD?=
 =?utf-8?B?NW01Q1VhS2hqeHZEWmtGSkRjcjl0b09CVGxleWFtNmJWTVRndEVNdlBaNCtM?=
 =?utf-8?B?NkxoWTVCb2dqU3ZjOWw2TERlM1NPL0dObnhFbUVzcy92bGNNNndBbmlaL3VS?=
 =?utf-8?B?TFBQbmg2NE0xdHRPbzA0V0VEMXJCelBwdXg3ZmNSNXdIWXVRV0MyeWpDM3c0?=
 =?utf-8?B?S2J4WUNaSVpmQzIrNVFyaEN5aVRuaG5uQmhmNkFpeWN4VS9mdUkxQzZ5Z1Iw?=
 =?utf-8?B?VTM3eHlleENIY3NJZVhndDFkd0FYRjltekVqMVQvVkVYR04zRmdoN20yUDBZ?=
 =?utf-8?B?Rk9Dcml1cThHSmh2YTExdTNsVGFpMEtLbnpIK3BGVjlYK3NZYWxGdGliTG1H?=
 =?utf-8?B?bmwzZmZyeU0rNnVad0lrUmpEVGdGdHQ1cHU5clRDbnBBcVhhTmVPOEgrZVNR?=
 =?utf-8?B?M3JOOWxiSks5WTV0Uk1NN1pmRTcwUjM4TUNuaEJYcWU0bTl5UkRnMURQUXFF?=
 =?utf-8?B?VHRiNU5XUEo2Z05JN0tZQTlFelVCdjNLUGxRL2dGOStFRGZVekUraXZiVW5l?=
 =?utf-8?B?TVlYWWpTQUI2azdpZFdaSjNSdm1EZ0dZTDZqYlRUaGt3d3QvMHF5K1ZtY2E3?=
 =?utf-8?B?czlXT0FENWIxbkdJMG8yTEJNQzlnTjRHdGhKVGd0ajk0dHhGN3V5eHdRNURY?=
 =?utf-8?B?a3YzclF5QXVDS3pqUHkxUzNBdnJjZ1E0ZFBnYmxWaGI3ckxJYUdTQVJhdVpx?=
 =?utf-8?B?OStaQWsyMFNxRGYvamU1Mm1aalk3Y3VlMGhhb2gwTkVyRUdWcm4rTkR5NUlX?=
 =?utf-8?B?bjFHdnk1a2FLL2JKVzFsU2VpRTdJWk12UlJTYkg0UzM1K2VXRFJpcHNDNHo1?=
 =?utf-8?B?Y210djRWUnR3c0lDKzFsWE1paHpHaHlJVlpZT25wMGRkSzU0RjBGM0Nyd1l2?=
 =?utf-8?B?OHlVMkVZd3QyUUVuYmoyeFdUQXBRMEZwWXZuMy9odnRmQlk5V3FVM2Y4NnQ0?=
 =?utf-8?Q?8hCE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5144.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ab4cce9-1f6f-44dc-70f6-08dbbde4eb96
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 16:31:50.5332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Rw6NNdJUUwQ1JtR6FsRiPFfiwiIJQP0JWbWTag4GsTvRiLdKikmjvdO330kuKoLhvDiJQkG3RN/CsJ9DwNdHZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5469

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWdkZSwg
VmFzYW50IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT4NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1iZXIg
MjUsIDIwMjMgMTE6MTIgQU0NCj4gVG86IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+
DQo+IENjOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgRGV1Y2hlciwgQWxl
eGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29tPjsgaW9tbXVAbGlzdHMubGludXgu
ZGV2OyBqb3JvQDhieXRlcy5vcmc7DQo+IFN1dGhpa3VscGFuaXQsIFN1cmF2ZWUgPFN1cmF2ZWUu
U3V0aGlrdWxwYW5pdEBhbWQuY29tPjsgSHVhbmcyLCBXZWkNCj4gPFdlaS5IdWFuZzJAYW1kLmNv
bT47IGpzbml0c2VsQHJlZGhhdC5jb207IEt1ZWhsaW5nLCBGZWxpeA0KPiA8RmVsaXguS3VlaGxp
bmdAYW1kLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB2MyAxLzVdIGlvbW11L2FtZDogUmVt
b3ZlIGlvbW11X3YyIG1vZHVsZQ0KPg0KPiBKYXNvbiwNCj4NCj4gT24gOS8yMi8yMDIzIDU6MzAg
UE0sIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPiBPbiBGcmksIFNlcCAyMiwgMjAyMyBhdCAw
MjoyMjoxMVBNICswNTMwLCBWYXNhbnQgSGVnZGUgd3JvdGU6DQo+ID4+PiAyKSBQQ0kgZGV2aWNl
IHN1cHBvcnRzIEFUUyBhbmQgUEFTSUQNCj4gPj4+ICAgIEluIHRoaXMgY2FzZSwgQVRTIGlzIHJl
cXVpcmVkIGZvciBQUkksIHNvIHdlIHNob3VsZCBlbmFibGUgaXQNCj4gPj4+IGV2ZW4gaWYNCj4g
Pj4+ICAgIHRoZSBkZWZhdWx0IGRvbWFpbiBoYXMgYmVlbiBjb25maWd1cmVkIHRvIFBBU1NUSFJP
VUdIIG1vZGUuDQo+ID4+DQo+ID4+IElNTyB3ZSBzaG91bGQgZW5hYmxlIEFUUyBhbG9uZyB3aXRo
IGVuYWJsZV9mZWF0dXJlKFBSSSkuDQo+ID4NCj4gPiBEZWZpbmF0ZWx5IG5vdC4gQVRTIGlzIHZh
bHVhYmxlIGFuZCBpbXBvcnRuYXQgd2l0aG91dCBQUkkuDQo+DQo+IEkgZ2V0IHRoYXQuIEJ1dCBJ
IGFtIG5vdCBzdXJlIHdoZXRoZXIgSSB1bmRlcnN0b29kIHRoZSB1c2VjYXNlIHdoZW4gZG9tYWlu
IGlzDQo+IGluIHBhc3N0aHJvdWdoIG1vZGUuIERvIHlvdSBoYXZlIGFueSB1c2VjYXNlIHRvIGVu
YWJsZSBBVFMgd2hlbiBkZXZpY2UgaXMNCj4gaW4gcGFzcyB0aHJvdWdoIG1vZGU/DQoNCkl0IHNo
b3VsZCBzdGlsbCByZWR1Y2UgbGF0ZW5jeS4gIEV2ZW4gaW4gMToxIG1vZGUsIHRoZXJlIGlzIHN0
aWxsIGFuIGFkZHJlc3MgbG9va3VwIHRoYXQgY2FuIGJlIGNhY2hlZC4NCg0KQWxleA0K
