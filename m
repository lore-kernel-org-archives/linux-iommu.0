Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B00243A8B
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 18:13:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JWXiGfm+zYSQVNxd/wvyfTYfIahCXSZHjp7NyFujWEW8Ixw5W7TUxEbHpn7D8jxbJO9IQLoS5IzYNPZOutrwBMRm0TYpsQFWLY08bAlyI4CR43RwkqyQmcd/u8CxV6ab0WbKWIUnRHpUrIaX+/636YJ2Yv2omY4UuPWSD8oWfQE8HZT0ie3tsg3yv/OMzxT/gnbOA6I/LN7/4MSBBkLc5ZMVDwOsBDp8I0hQfz8Fy8jhtV+o1Pt34K/SB722ZqDXSaeXDQpzC5WWZiCETYTk1cInuI0CLCBWmPupiOighahnhw0OQ8WaffoBJu2v5lAVHL/0zqWjqqK73k8FypRuXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6/gk30qqAMey7GBsBoO5IzQ88/oA5T5r0T6JNQKV+o=;
 b=AtujzUsERdKKyG5LckS7skcO2oQo3hkkH6zb+RjLuRemecJfMeIVitzmFRNFlcbyRNKa8r0UHg9wQOzbM6f+3lvvKnFq2GIvT+BT0GHQBaYvv1GfQq+tpkRHsER9M53pFgbRWLDNZxkCY0cehzuoeJWeaojvIb0vQb5dB6KDnO78UHn7huhJH+Kg8d2H3YQh6rK4tGMczmqgYdM75CpV1/C+O/M4LNSDvnXlNfEYd75OpFclYlwQPzfVjG+EHE8F2e68N/ENIyNt0vOEFLqRoxVuTMBshYOghZl6bYtsoH0NvGZdHLeB5RlucuKqRIByBtxMHvJGHj+HcaOBUimsyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6/gk30qqAMey7GBsBoO5IzQ88/oA5T5r0T6JNQKV+o=;
 b=tTjYSWNsL7eXQ2fPFzwljtGVNsPHbwgwy/wjUUVce6hGfd4Y7OcQK6zq1JNIMN0OebD7MnzmB+6Xv1N02NXZtoE8HaJ2R6Fm75HkLhNEXkIRrl1P+U9LR/LoOdYRh4jJk+eVOJsunu8Qd1VlfAD9rlNSh5Oi2dfDdRKtr6tsjSI=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB7885.namprd12.prod.outlook.com (2603:10b6:510:28f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 18:13:40 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:13:40 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>, "joro@8bytes.org"
	<joro@8bytes.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
	"Huang2, Wei" <Wei.Huang2@amd.com>, "jsnitsel@redhat.com"
	<jsnitsel@redhat.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index: AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IABBhYAgAC6/zA=
Date: Fri, 22 Sep 2023 18:13:39 +0000
Message-ID:
 <BL1PR12MB5144A7E4B810C58FE9208DE7F7FFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <8d7a8fa9-020c-2b0b-1bfe-0957bffb198b@amd.com>
In-Reply-To: <8d7a8fa9-020c-2b0b-1bfe-0957bffb198b@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ActionId=26cdd999-3a36-4640-a04f-866ad09b9caa;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=true;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-09-22T17:54:17Z;MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB7885:EE_
x-ms-office365-filtering-correlation-id: 72a93117-6fa7-4baa-d034-08dbbb97a5d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 WZPZ7t3qlvexBXa5tcyLbUKXagqneeZpf0cWNNJ60J4xDtwU1UjgIPszlzr/L5nJ+bKLv/QIol/3UmHogCI0HKpAZL83xnRv+C41lAnPKxo/ZR39WRoH+pLxOz+3fGTqZbE/u72UugUeDGGp/QOsHkWT1atnSC/zJ8IfYCN/UKKuIEbRAngNQnERYNc8wztyNO7yk3gCYixmejx0fes9PMVb1GvN7OIiC0MaPg6+iRqqZt4Fw+LHlJau6BwjU/TsRo/68c6Ms5qxDfV9yEXQtrVZNWRIVaC3J60EUYCIW+wR0DW92rV0o3GupqINN6FtnCiAqLjbsilgtPNh9Y1U22+futlyHNpQoa3LSWC6/fWY9biG1ac7RMM8ls94V22bckwJJr+WJCmAOmwnl/BDHmP6UG4hmBCNLF28I8j0QuRMcRs8iipT6K6BUhtQ4CaAcaRVik3foP3+eR1US3Xko9pIKwh3srXg4tVM/i5G+8o5DfNMAMJULcn+2OWome87e7ly15IMtGtjrbgLowICB6ZhHopmebznGah8Cw0UN100YOtq9OZixtDzHFCtcPV6aDdd8AvaKdAaF0yY0x9BWbR79EBBnWzwXBcWFk8fa4zM6OCMEB2ugDOGkOy/ILfX
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(39860400002)(346002)(451199024)(186009)(1800799009)(478600001)(38070700005)(38100700002)(26005)(53546011)(9686003)(55016003)(71200400001)(6506007)(7696005)(122000001)(8936002)(5660300002)(52536014)(4326008)(8676002)(54906003)(41300700001)(64756008)(76116006)(316002)(66946007)(66476007)(66446008)(66556008)(33656002)(86362001)(110136005)(2906002)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VmQyWnJYVERYS3ljSWpvQXVoeTR2SmVVdWJZSXMxUmxGSzBVNGw0bStOaGZp?=
 =?utf-8?B?aHdLYWJwakpETndFYUNITGtlM0ttNHNZbkxqMHE3c3JFWDRUcXV3cmFIZzg3?=
 =?utf-8?B?NzFPKzhIeVFZeTJJckF2eG9LSnBZTnNpYlRCMjE0T1l5VGcxUStVdVllaENn?=
 =?utf-8?B?WHpzajlBTkJzcE1CT3E0SlQwWnNrN1VPOUV5dys4bzlWejJXUXkzUkZMbFVx?=
 =?utf-8?B?VTZvcXFmcVpSV1ovbDRsekE2OUpqaDU3QUN0Vml1MjRleXlMMU8rR0FNbWZ6?=
 =?utf-8?B?M3lXcU9uVXpWb1hQZFk2QjJabjRYZDA1UzBITTJCbEV1cmpaMTl3ejBnckRU?=
 =?utf-8?B?UTBqOG1NVWFmYnFqaWJyVEVLT0FhVnp2b25VL3lLZmFwNWdwT2wyaHk1S1VE?=
 =?utf-8?B?WkFoOWFkdVJ3Z2MyRnEvZG9vL2FyUjBMcllJem1iS0JieFhyRy9TR1JhMFlR?=
 =?utf-8?B?NGJBRTJnWXZOOFY4SmxTa1dRS3RsNjcra0xHVnJud09YdzB0d3ZpVVBWTjBl?=
 =?utf-8?B?c2Z0RXlDYzBxaW1BdmJyMDNQallWcHF1RWZpUEk3UTlwQU16MHNEbmtxV1hV?=
 =?utf-8?B?NmJJTUUyNnFDeC8zcHU3NmFQZldxUDlRVThMZHFDcVVPZStlM2VDaXBpS2Ny?=
 =?utf-8?B?SnlBbFQreER0OHpSRjM5SmZkbk1qZmlFdnljeGg1V3JwVWY4K1F5Tnh0UDV0?=
 =?utf-8?B?cTJLSDA0ckJGTnRsRE9wVVg2U1FZUlpmOVJtQ3V1Y1JnbUFHdVNpMUNkZTAv?=
 =?utf-8?B?UjMxZFhXSGJnbldZRFFWeDU2L09WcmRCbGFnWUw4SjhTWVBtRGNnbzZXSjh3?=
 =?utf-8?B?N3FibmxHb1lDQVBWV0F2bTZ6Um9MN0ErU3FkTFllcWdiTVF6Rng2OWdLTnRt?=
 =?utf-8?B?VkxGTnhoc2o2bmNYb0RhK3puM05ZQ01reGttVlRuWGNQRFNWcDhvaGxWMVN2?=
 =?utf-8?B?ODFzaG0xWHZSeGVZN3U3b2pTTXE0S1hmKzRiblI2dFpFVWdkZ0lBdUZLWEQr?=
 =?utf-8?B?Ri84TFBXYllOQXZDMnNGN2FGS1NLeEhrbnhQZTZQM285Y3U3ajVYOENwd1V2?=
 =?utf-8?B?eGhUcWltT25kS0k0YVFLQTFheEhPYTdkRGliL1V1UytrbCtBejA4OGppRlRl?=
 =?utf-8?B?YmF5NE5DMmh5TFhlbmNYTklXSmVpNFhucVorcDZnTlZxMWFRUFZkbFBrVXp5?=
 =?utf-8?B?OFNUOEk4clhUeFhIai9RSkEvRUFTd21DbGJvTVhWSWp3Rm5nelViWE1jdTZY?=
 =?utf-8?B?SGVUWFpPekxGdzJGSTVmYmo0UThIZzBDKzZ4dWg5SUpkVk8zRTVEM20wb3VC?=
 =?utf-8?B?RE8yRTVJajNBZmN5NjhCb2ViYkI0cjVmUVVZZXZ4cjNoY0ttcW1ERERCT0tw?=
 =?utf-8?B?eis5US9qR04xVEVkbjJEOHFnQXYyRFF5bkVxYXg5dlRPSGxST0FIczc2dXlU?=
 =?utf-8?B?OGhmdFpXcGRkemVjZms2bHRMK0ttTzBGb2RiYS8wZTFFaXNmVEJNcWRMZFFO?=
 =?utf-8?B?Tm1rL1c2RStJWk9ENm1HTHZLMmwzaDMrRDRNVXBwTGdEVit2Wkk0UVFhREFl?=
 =?utf-8?B?U2lzcDlBNUhELzI1MU5qSnFFT2NycGwxVXZkVGEwRjliMTZXck1wU1k4NUNi?=
 =?utf-8?B?SGdxN3FoQ0lURWk4MUNLQmxaU3c5Ti9SWGlxRVIzZ2xTWS9lMU9RRUFGaVBi?=
 =?utf-8?B?dnNNUGNjOGM1dFpSSlFKbmtaeDQ0VVRWSkV5VXJsc25UR2Y5UWo2cjVjeVc0?=
 =?utf-8?B?K0FudFA4cnE0K2xVTVJCVklCSFVuNyt0M3BmV1RVVlhtL2JPNmlhaGR2UjdT?=
 =?utf-8?B?bnN2QXFoQ2xwOTJGNjhId2NpRDlUN2hZSjJ6eWJNK08xMUFLanFjQzNtNEF5?=
 =?utf-8?B?aWpEVWovV2lqS0syNFE5cGl1R0ZVWkhhaUluWGJIamNvUlNyRzVXQmFtUmF4?=
 =?utf-8?B?aXMrb3QwTFBvQTVXOU4zM3Nha1JMbm9tVlRrbzVYZHc1dkZwVWxhSGdzZklo?=
 =?utf-8?B?QUtaOW1kRmpqaW9tU3c0Z2xnRmljN3o4dEorQm9URlBnVHR0dGRQMlNFaDRh?=
 =?utf-8?B?UklZVkJMeUFoMXNXTkJBZFRWSVh0WDdWZkovMWREM0lmc3hNcU5OSWJEMlgx?=
 =?utf-8?Q?5AM8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a93117-6fa7-4baa-d034-08dbbb97a5d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 18:13:39.9558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IZ65GTBqmfiH4lTboiE0CTVyNnBAdM7yB7P7GBUw/uewFGCnOp09kvssUYM/Blnya5kLzzBIWCYJP05CySj95w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7885

W0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxdDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNz
YWdlLS0tLS0NCj4gRnJvbTogSGVnZGUsIFZhc2FudCA8VmFzYW50LkhlZ2RlQGFtZC5jb20+DQo+
IFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIyLCAyMDIzIDI6NDUgQU0NCj4gVG86IERldWNoZXIs
IEFsZXhhbmRlciA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT47IEphc29uIEd1bnRob3JwZQ0K
PiA8amdnQG52aWRpYS5jb20+DQo+IENjOiBpb21tdUBsaXN0cy5saW51eC5kZXY7IGpvcm9AOGJ5
dGVzLm9yZzsgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZQ0KPiA8U3VyYXZlZS5TdXRoaWt1bHBhbml0
QGFtZC5jb20+OyBIdWFuZzIsIFdlaSA8V2VpLkh1YW5nMkBhbWQuY29tPjsNCj4ganNuaXRzZWxA
cmVkaGF0LmNvbTsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gaW9tbXUvYW1kOiBSZW1vdmUgaW9tbXVfdjIgbW9k
dWxlDQo+DQo+IEhpIEFsZXgsDQo+DQo+DQo+IE9uIDkvMjEvMjAyMyA4OjQ1IFBNLCBEZXVjaGVy
LCBBbGV4YW5kZXIgd3JvdGU6DQo+ID4gW0FNRCBPZmZpY2lhbCBVc2UgT25seSAtIEdlbmVyYWxd
DQo+ID4NCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4gRnJvbTogSmFzb24g
R3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPj4gU2VudDogVGh1cnNkYXksIFNlcHRlbWJl
ciAyMSwgMjAyMyAxMDoxNCBBTQ0KPiA+PiBUbzogRGV1Y2hlciwgQWxleGFuZGVyIDxBbGV4YW5k
ZXIuRGV1Y2hlckBhbWQuY29tPg0KPiA+PiBDYzogSGVnZGUsIFZhc2FudCA8VmFzYW50LkhlZ2Rl
QGFtZC5jb20+OyBpb21tdUBsaXN0cy5saW51eC5kZXY7DQo+ID4+IGpvcm9AOGJ5dGVzLm9yZzsg
U3V0aGlrdWxwYW5pdCwgU3VyYXZlZQ0KPiA+PiA8U3VyYXZlZS5TdXRoaWt1bHBhbml0QGFtZC5j
b20+OyBIdWFuZzIsIFdlaQ0KPiA8V2VpLkh1YW5nMkBhbWQuY29tPjsNCj4gPj4ganNuaXRzZWxA
cmVkaGF0LmNvbTsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPg0KPiA+
PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gaW9tbXUvYW1kOiBSZW1vdmUgaW9tbXVfdjIg
bW9kdWxlDQo+ID4+DQo+ID4+IE9uIFRodSwgU2VwIDIxLCAyMDIzIGF0IDAyOjA1OjM3UE0gKzAw
MDAsIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToNCj4gPj4+IFtBTUQgT2ZmaWNpYWwgVXNlIE9u
bHkgLSBHZW5lcmFsXQ0KPiA+Pj4NCj4gPj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0K
PiA+Pj4+IEZyb206IEhlZ2RlLCBWYXNhbnQgPFZhc2FudC5IZWdkZUBhbWQuY29tPg0KPiA+Pj4+
IFNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMjEsIDIwMjMgNTozMiBBTQ0KPiA+Pj4+IFRvOiBp
b21tdUBsaXN0cy5saW51eC5kZXY7IGpvcm9AOGJ5dGVzLm9yZw0KPiA+Pj4+IENjOiBTdXRoaWt1
bHBhbml0LCBTdXJhdmVlIDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT47IEh1YW5nMiwN
Cj4gPj4+PiBXZWkgPFdlaS5IdWFuZzJAYW1kLmNvbT47IGpzbml0c2VsQHJlZGhhdC5jb207IGpn
Z0B6aWVwZS5jYTsNCj4gPj4gSGVnZGUsDQo+ID4+Pj4gVmFzYW50IDxWYXNhbnQuSGVnZGVAYW1k
LmNvbT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA+Pj4+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQu
Y29tPjsgS3VlaGxpbmcsIEZlbGl4DQo+ID4+Pj4gPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+OyBK
YXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0KPiA+Pj4+IFN1YmplY3Q6IFtQQVRDSCB2
MyAxLzVdIGlvbW11L2FtZDogUmVtb3ZlIGlvbW11X3YyIG1vZHVsZQ0KPiA+Pj4+DQo+ID4+Pj4g
QU1EIEdQVSBkcml2ZXIgd2hpY2ggd2FzIHRoZSBvbmx5IGluLWtlcm5lbCB1c2VyIG9mIGlvbW11
X3YyIG1vZHVsZQ0KPiA+Pj4+IHJlbW92ZWQgZGVwZW5kZW5jeSBvbiBpb21tdV92MiBtb2R1bGUu
DQo+ID4+Pj4NCj4gPj4+PiBBbHNvIHdlIGFyZSB3b3JraW5nIG9uIGFkZGluZyBTVkEgc3VwcG9y
dCBpbiBBTUQgSU9NTVUgZHJpdmVyLg0KPiA+Pj4+IERldmljZSBkcml2ZXJzIGFyZSBleHBlY3Rl
ZCB0byB1c2UgY29tbW9uIFNWQSBmcmFtZXdvcmsgdG8gZW5hYmxlDQo+ID4+Pj4gZGV2aWNlIFBB
U0lEL1BSSSBmZWF0dXJlcy4NCj4gPj4+Pg0KPiA+Pj4+IFJlbW92aW5nIGlvbW11X3YyIG1vZHVs
ZSBhbmQgdGhlbiBhZGRpbmcgU1ZBIHNpbXBsaWZpZXMgdGhlDQo+ID4+Pj4gZGV2ZWxvcG1lbnQu
DQo+ID4+Pj4gSGVuY2UgcmVtb3ZlIGlvbW11X3YyIG1vZHVsZS4NCj4gPj4+DQo+ID4+PiBEb2Vz
IHRoaXMgcGF0Y2ggb3IgdGhlIGZvbGxvd2luZyBwYXRjaGVzIG1ha2UgYW55IGZ1bmN0aW9uYWwg
Y2hhbmdlcw0KPiA+Pj4gZm9yIGRldmljZXM/ICBFLmcuLCBkZXZpY2VzIHdoaWNoIHN1cHBvcnRl
ZCBBVFMgd291bGQgaGF2ZSBiZWVuIHB1dA0KPiA+Pj4gaW50byBhbiBpZGVudGl0eSBtYXBwaW5n
IG1vZGUgcHJldmlvdXNseSBJcyB0aGF0IHN0aWxsIHJldGFpbmVkPw0KPiA+Pg0KPiA+PiBIdWg/
IFdoeSB3b3VsZCB3ZSBldmVyIHdhbnQgdG8gZG8gdGhhdD8NCj4gPj4NCj4gPj4gUG9saWN5IGZv
ciB0aGUgZGVmYXVsdCBkb21haW4gYmVsb25ncyBpbiB0aGUgaW9tbXUgc3Vic3lzdGVtIGV4Y2Vw
dA0KPiA+PiBpbiBleHRyZW1lIGNhc2VzLCB0aGUgQU1EIGRyaXZlciBzaG91bGQgbm90IGJlIGRv
aW5nIHJhbmRvbSB0aGluZ3MNCj4gPj4gbGlrZSBmb3JjaW5nIGlkZW50aXR5IGZvciBBVFMgY2Fw
YWJsZSBQQ0kgZGV2aWNlcy4NCj4gPg0KPiA+IEknbSBqdXN0IGNvbmNlcm5lZCBhYm91dCByZWdy
ZXNzaW9ucyBpbiByYW5kb20gZGV2aWNlcyBkdWUgdG8gYSBjaGFuZ2UgaW4NCj4gcG9saWN5IGlu
IHRoZSBJT01NVSBkcml2ZXIuICBQcmV2aW91c2x5IHRoZSBJT01NVSBkcml2ZXIgd291bGQgcHV0
IEFUUw0KPiBjb21wYXRpYmxlIGRldmljZXMgaW50byAxOjEgbW9kZS4gIEFsc28gc29tZSBvZiB0
aGUgZWFybGllciBpbnRlZ3JhdGVkIEdQVXMNCj4gcmVxdWlyZSAxOjEgbWFwcGluZyBmb3IgZGlz
cGxheSBmcm9tIHN5c3RlbSBtZW1vcnkgZHVlIHRvIGhhcmR3YXJlDQo+IGxpbWl0YXRpb25zLiAg
VGhlcmUgd2VyZSBhbHNvIGEgbG90IG9mIHNiaW9zIGJ1Z3MgaW4gdGhlIGNhcnJpem8vcmF2ZW4g
dGltZWZyYW1lDQo+IGJlY2F1c2Ugd2luZG93cyBkaWRuJ3QgZW5hYmxlIHRoZSBJT01NVSBzbyBs
b3RzIG9mIE9FTXMgaGFkIGJvZ3VzDQo+IElPTU1VIEFDUEkgdGFibGVzIHdoaWNoIGRpZG4ndCBj
YXVzZSBwcm9ibGVtcyB3aGVuIDE6MSBtb2RlIHdhcyB1c2VkLg0KPg0KPiBUaGlzIHBhdGNoc2V0
IGlzIG5vdCBtYWtpbmcgZnVuY3Rpb25hbCBjaGFuZ2UgdG8gZGVmYXVsdCBkb21haW4gKGl0IHN0
aWxsIHB1dHMNCj4gUEFTSUQgY2FwYWJsZSBkZXZpY2VzIGluIHBhc3N0aHJvdWdoIG1vZGUuIDEg
eCAxIG1hcHBpbmcpLiBCdXQgSSBkbyBwbGFuIHRvDQo+IG1ha2UgY2hhbmdlcyBhZnRlciBTVkEg
YW5kIGludmFsaWRhdGlvbiBpbXByb3ZlbWVudCBzZXJpZXMgZ2V0cyBtZXJnZWQuDQo+DQo+IENv
dXBsZSBvZiB0aGluZ3MgOg0KPiAgIC0gSWYgZGV2aWNlIHN1cHBvcnRzIG9ubHkgQVRTIChubyBQ
QVNJRCwgUFJJKSwgdGhlbiB3ZSBkb24ndCBmb3JjZSAxIHggMQ0KPiBtYXBwaW5nLg0KPg0KPiAg
IC0gSWYgc3lzdGVtIGlzIGJvb3RlZCB3aXRoIFNNRSAobWVtX2VuY3J5cHQ9b24pLCB3ZSBmb3Jj
ZSBhbGwgZGV2aWNlcyB0byB1c2UNCj4gRE1BIHRyYW5zbGF0aW9uIG1vZGUgYW5kIGlvbW11X3Yy
IG1vZHVsZSBpcyBub3Qgc3VwcG9ydGVkIChubyBQQVNJRA0KPiBzdXBwb3J0KS4NCg0KV2UgYWxy
ZWFkeSBoYXZlIHNvbWUgcXVpcmtzIGZvciBzb21lIEFQVXMgd2hlcmUgeW91IGhhdmUgdG8gcGlj
ayBiZXR3ZWVuIFNNRSBhbmQgZGlzcGxheSBiZWNhdXNlIHRoZSBleHRyYSBJT01NVSBsYXRlbmN5
IGNhdXNlcyBwcm9ibGVtcyB3aXRoIGhpZ2ggcmVzIG1vZGVzIChldmVuIGluIDE6MSBtb2RlKS4N
Cg0KPg0KPiAgIC0gSWYgZGV2aWNlIGlzIGNhcGFibGUgb2YgUEFTSUQsIHRoZW4gd2UgZm9yY2Ug
MSB4IDEgbWFwcGluZy4gTXkNCj4gdW5kZXJzdGFuZGluZyBpcyBkZXZpY2Ugd2FudGVkIHRvIHVz
ZSBpb21tdV92MiBtb2R1bGUgKGVuYWJsZSBQQVNJRC9QUkkpLg0KPiBUaGVyZSBpcyBubyBlYXN5
IHdheSB0byBzd2l0Y2ggZnJvbSBJT01NVSBETUEgdHJhbnNsYXRpb24gbW9kZSAoVjEgcGFnZQ0K
PiB0YWJsZSBtb2RlKSB0byBQQVNJRCBzdXBwb3J0IG1vZGUgKFYyIHBhZ2UgdGFibGUpLiBIZW5j
ZSAxIHggMSBtYXBwaW5nIHdhcw0KPiBlbmZvcmNlZC4NCj4NCj4gRG8geW91IHNlZSBhbnkgaXNz
dWUgaWYgd2UgYm9vdCB0aGVzZSBkZXZpY2VzIHdpdGggVjIgcGFnZSB0YWJsZSBtb2RlIChpdCB3
aWxsDQo+IGdvIHRocm91Z2ggSU9NTVUgRE1BIHRyYW5zbGF0aW9uIG1vZGUpIGFuZCBkb24ndCBz
d2l0Y2ggcGFnZSB0YWJsZQ0KPiBtb2RlIGR1cmluZyBydW50aW1lPyAtT1ItIG9sZGVyIEdQVSdz
IGFsd2F5cyBleHBlY3RzIDEgeCAxIG1hcHBpbmc/DQo+DQoNCkFsbCBvZiB0aGUgaW50ZWdyYXRl
ZCBkZXZpY2VzIEknbSBjb25jZXJuZWQgYWJvdXQgc3VwcG9ydCBBVFMvUFJJL1BBU0lELiAgVGhl
IGlzc3VlIGlzIHRoZSBkaXNwbGF5IGhhcmR3YXJlIG9uIHNvbWUgb2YgdGhlbSByZXF1aXJlcyAx
eDEgbW9kZS4gIEknbSBub3Qgb3Bwb3NlZCB0byBhIDE6MSBxdWlyayBsaXN0IGlmIHRoYXQgaXMg
dGhlIHdheSB3ZSB3YW50IHRvIGdvLg0KDQpBbGV4DQoNCg==
