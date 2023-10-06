Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A36F273FB
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 15:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0C5WPu1r"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ+ixrsR3UCFSOod59rsn6NRjvqA32lDBwwQRIhDrFeWWNZy0Q5lwzvG1zwxg39uzKNVPzsjRYhAYCLDRFeGx83ujRZGRqS0/qXx5lhIyesuc+XcNGUymebGKXeA/LZDVeAH14txwVEQyvCILUfIY7mSuTPf3H2BeJLWKN3ZcFHQvJOG60zRUsB9RkE81p13sxPuHgMik27/Yyn3jJa8k5l6Rg0HJvsqGKRR51ZNAQzcMu+DKQ97PDIzSKGFGpAyO3Qapy5TZ7bvouY6abyd6n5cQcxgS4o5DNHeY26VDoaYXGhEuPWnUKfw6BoDot33NCVjl3SNh7ecG+IL15nWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bzgK3SF9iypF1tUTkPiSLENCx0w/MJiUMLoueECtCks=;
 b=ZPsNHwa6Wta1nk25bIL3QY5GDa8yhkLprBE3dBkmKJUJoDQFf2QwZXuDYfWwkPYQ+v2Fvq8FMWi2mNE35D+J2ysRU95EZ7TGdq6wF/MhzhpMIGZa7tFvONqjSTqQm9PjTnkbNtr2azZBTVPnMNA7eg0D7wsF+VTCHebBrzJGea9EJ3WihTvHgcxuUBt24JJfV7Yx/6q+jhGiG/ovt0K2xO+sK0W3+esxKKlZ8mLi4OMYuAL7MfZIz0LOs/i6H7W/VWCRb8K0+5+OC6kCHIYXh/H2R3Z9bC2EnlfA8X0i9T3ybQIzTIvBAe23xAsaLmFY5MRfWFjTzJ1P2pwpk1SIZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bzgK3SF9iypF1tUTkPiSLENCx0w/MJiUMLoueECtCks=;
 b=0C5WPu1rDXQpdyAL/fLqolCHLR1O/SdyEo69JO8+mFl3GuBJcSl+37dcMBPQyybexx23N5ivSeVbnwnQcfFKYwv0k+lJblN48q28nWz+TnR0HaVn+rk8T5goQ2OS7v4jezbJ42Z/NASdOEazkiivdE05QY8rPucNuAmcxLRY9hE=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by PH0PR12MB7929.namprd12.prod.outlook.com (2603:10b6:510:284::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Fri, 6 Oct
 2023 15:19:17 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%7]) with mapi id 15.20.6838.033; Fri, 6 Oct 2023
 15:19:17 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "joro@8bytes.org"
	<joro@8bytes.org>, Jason Gunthorpe <jgg@nvidia.com>
CC: Baolu Lu <baolu.lu@linux.intel.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "Suthikulpanit, Suravee"
	<Suravee.Suthikulpanit@amd.com>, "Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index:
 AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IAAF7sAgAClRgCAAKDwgIAAA8wAgAABcQCABIDlAIAFGBAAgArHvACAAdJwQA==
Date: Fri, 6 Oct 2023 15:19:17 +0000
Message-ID:
 <BL1PR12MB5144BA503EE1FBB5D4140D55F7C9A@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
 <20230922121812.GM13733@nvidia.com> <ZRFNIsHmKpNmmOc7@8bytes.org>
 <BL1PR12MB514488501F04049C08CB71DAF7C1A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <2ed081f7-36ff-4a56-5a8d-086386d7fcfb@amd.com>
In-Reply-To: <2ed081f7-36ff-4a56-5a8d-086386d7fcfb@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=16556c57-2a49-44e9-8cc1-0b4368843509;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-10-06T15:18:59Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|PH0PR12MB7929:EE_
x-ms-office365-filtering-correlation-id: 7dbbbc1e-84b2-4676-d972-08dbc67f9b81
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 YNvrZFL525BU09W1SqskNA0xqxh6m35HTnv0ScVkoUS/eJY+zKKNS0SFSIBO2fygzs9ZadQRu3DcJeh3sCuuR/pK8lP2n/6Vc+6yOrL5R7178PDMvDw6M9wtkVj3fFq0jriijMLMhUmIW/2nSbsn505rGa70C1foKrdsvyKId0UT1l8eVN1uxyd9yGLtv07dPw5iUoFaVSl6qXbghSKBMBo/SHqapbol6mIDo3FIF4j0LNf6ViKfOz58fgP3vcP8P2ycFxrv24I+clpMsdvWmQjp5tjzWNKuorGDDgFLBIeLjGDZzPPFnZHpx1VnwoABXn14H3sujyZQHo26FekkGTVDSffxeknA/sx3o4jQltJVcg8hy3hwyWxK0KIEJXspWlZH87MBFw5rTbp7a1PGpnFz5S46ZkBSytdq/ZmPLBxc7YxrahrbbLjqaO5P//COvPHTVAgU4/EtfoSwX4jPAa6dkI48D7PpUKGOcyyXZwOqQmObV/btac+8wzetuG0CmKlpO2Oi5vUnshEx/57zjdyPRlyXL/W+xHiKuRAKwKwgCnkf2fbBigzMVPzxOlvfO+Xjevx1BgA+QgdSu6+ShqJJ60VEIzvL/i3uRXHk9Tc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(55016003)(7696005)(83380400001)(26005)(76116006)(66446008)(66476007)(66556008)(66946007)(54906003)(110136005)(64756008)(316002)(8936002)(8676002)(4326008)(5660300002)(41300700001)(6506007)(71200400001)(53546011)(9686003)(2906002)(478600001)(33656002)(38070700005)(38100700002)(122000001)(86362001)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?aDVpQU5IUGVFUmxsTjlBK0ltY1JIYk9JOTFZYTRybzVzVnhYbm1DSXZiRjBZ?=
 =?utf-8?B?UGxYYk0wRGpNU0dGdFUxcitHVmNVaHNuU0JNbmtQZDdmaGNEZUZvYVF6RHFV?=
 =?utf-8?B?QzNjTldpMHF2NCtTVTFaV0hNOGpER0lmaXUzOC8rMEYvb2xHNVdFS3FDbU1W?=
 =?utf-8?B?UWE4SUVoY3NHck00Qi9vSUY1dXJNaUZkbExYVWowa3RPMVdDd1lkYVBuR3pi?=
 =?utf-8?B?MnBvak12TWlBTGcycVcyd0xsQTU0S0diMXQzdFVqVjBVcjVJc2hwNE42aXFp?=
 =?utf-8?B?SlpSMkt4YlYwWVcvdnprL3dwMW91Uys1aXhZc0VhYTVkeHBtTEZ0cGxwbE55?=
 =?utf-8?B?UmxEV2xTZTI0NGlMUy84bU01T2ZRci9iSk1DWFhQNzY3a1lrRkxxOXFRMFVa?=
 =?utf-8?B?QWRROTRmSXFqYmlESkR2NGQxRmZqd0xtc3gzcjV3SldEQ2tNUnlqYTN3S08z?=
 =?utf-8?B?Ly96RHFPenJRbmhSMUhwQjVKczlzdGg1NWd1Qi9udGNYaS9KenZmeDhVUlhQ?=
 =?utf-8?B?QU5vOENlMGFoUlZ6cG9ldGM3cjJsbWMrdXZuMGJvdUZQbFBDWXRlRThBYzhi?=
 =?utf-8?B?M29xUDhhdUJBTzA5WEJ6bWdWMnV0L1VTRGk2WEROa1dPeEc1WU9YOU5Pbzlz?=
 =?utf-8?B?RmFWeFFkZEE2YzI3T20zeGQwdm1kcXJpNUdSM3c2NDJPWDRpZWxtdWtGUjlH?=
 =?utf-8?B?YjFOMzgxWVNFWTBIeXJEbVRuMjBMQWFDTjZoZHNFTkFab2o4emRNcFlBK0Nq?=
 =?utf-8?B?WWtYdXJiUXAwbktJclZUQ25WdmpZWmovbXJSQWpWL2NYeWlUVFVUY0g3cVF2?=
 =?utf-8?B?dFNQRDc3TElQOGtIVTVIRWlkUC9UNjJjQ2ZuUkEyOTdhcWpHTnB6RlBCNXVI?=
 =?utf-8?B?ZThJcjJQMWpGRlJaQTl6NDVMemlBUkM4UGlaRkVHQkRxMmhEV3hvdDZPOS9B?=
 =?utf-8?B?Qis3MWF5OHBhdmZEbldRbysrZDYzd0gvVm54RFlwK2ptaWh6RWJqVmc1WkZx?=
 =?utf-8?B?QUJpWGxQc0ZJZkdaV01BNlE4TEQveHhSWkJYWDNzZVRNeXBtTWEzRTRKYTM0?=
 =?utf-8?B?a3FrSEZjby81N0FEUlYzUWltazhsMDRWbXFKUWk2eUtFbW5GZ0NSTHRxMis5?=
 =?utf-8?B?NDJvTEh0RzE5c3oyNTUrejBNQnVUQkJrV3JESHlBVnVVS0tCVUVmSmt3SHNw?=
 =?utf-8?B?M3ZJM0ZaL0JZZ0F5bG1wcC8zZjVyOTV2OGNGVGdxNUQ1WFAvMWlKMDNLRE4x?=
 =?utf-8?B?N1pVdnZpanpsbnVQZi9OMTFEVktoSEtTMkJCZjlBZ0lZbmlOdEhKLzhpM3B6?=
 =?utf-8?B?RTBmUnh5SWFkSEpaa1Q1SXMySVFCUmNISFlJY2xUdGxOOWdjelNyUlFlTmhL?=
 =?utf-8?B?cDFWWFp4cU1kdWNqL3NKWmpLb2NpN3M4QW5QYlgrd2RlWlp2MVV2L3lod3hr?=
 =?utf-8?B?UjFkWWUrbEJNSkJ6a1ZwVDJnaXZ4Q1dYYm96bWx1SDd3cVphR0kzTGdSd1FW?=
 =?utf-8?B?UTZDckM3SGhEYnJIMmVDeEhCd0ZkRkc0ektCOU1GeW5pTTVqQVN5VmgxMGNK?=
 =?utf-8?B?WnNkN3ZMREQ0YXZFU3lMYlFBQ05IeWszdEQwWkJCV2Y4aUFkNVQ0TDJrSGJ0?=
 =?utf-8?B?RXB6dkxxa3hZSVJoSUhCTnVHS2N2bEdFMldiUDFRdnZ5Z0hPV2syLzJhUWVQ?=
 =?utf-8?B?KzBKNEtQRlNUbGp0UVF6Sm5JTytMcm5aNU5yRGViZXo0K2pib1Axd0NEd0pF?=
 =?utf-8?B?SThkcHl5NFgzcVA4NXBqM1lZVlV4bzIycGtqOFZQSnF3TGlJVlpSQm1RMW9I?=
 =?utf-8?B?UmRNNEVTc2NWK2liNGE0ZjR3cFJIenp5MFA3WlQxT2RrRXlvNU0reGt3YTZh?=
 =?utf-8?B?MWFpWmQrR3Q5MzFpWVdzeWEzOUdIVG1qandGbjV4cEluVDBNMDJ4eHpjYUFI?=
 =?utf-8?B?NGhJWXNzZCtaNUpSNkU3U2x2YytCdkoyZWxBakdzNThyUzJ2c3YwQlQwTGds?=
 =?utf-8?B?UFRoV3RBa1hCSzVhRHYwSVNoUTd3OTF2S3M3ZGptZDNJb1lDNXBSWWJBUDBl?=
 =?utf-8?B?QlVXL0x4K1VKTlhVT0lGWnZIVE9JQi9PdDJYdUtsRTdQNFEreHZ5OVo0Nmwv?=
 =?utf-8?Q?GTCA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dbbbc1e-84b2-4676-d972-08dbc67f9b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Oct 2023 15:19:17.4877
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pmfqLYvTF6haWQz/CnCyf5Q8UyRfMR85WfotKEJQimTqYkN3owHrUkbtsx9yicTOkswzzN5nQbv+tr1SpVnjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7929

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIZWdkZSwg
VmFzYW50IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIE9jdG9iZXIg
NSwgMjAyMyA3OjI5IEFNDQo+IFRvOiBEZXVjaGVyLCBBbGV4YW5kZXIgPEFsZXhhbmRlci5EZXVj
aGVyQGFtZC5jb20+OyBqb3JvQDhieXRlcy5vcmc7DQo+IEphc29uIEd1bnRob3JwZSA8amdnQG52
aWRpYS5jb20+DQo+IENjOiBCYW9sdSBMdSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPjsgaW9t
bXVAbGlzdHMubGludXguZGV2Ow0KPiBTdXRoaWt1bHBhbml0LCBTdXJhdmVlIDxTdXJhdmVlLlN1
dGhpa3VscGFuaXRAYW1kLmNvbT47IEh1YW5nMiwgV2VpDQo+IDxXZWkuSHVhbmcyQGFtZC5jb20+
OyBqc25pdHNlbEByZWRoYXQuY29tOyBLdWVobGluZywgRmVsaXgNCj4gPEZlbGl4Lkt1ZWhsaW5n
QGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS81XSBpb21tdS9hbWQ6IFJlbW92
ZSBpb21tdV92MiBtb2R1bGUNCj4NCj4gSGkgQWxleCwNCj4NCj4NCj4gT24gOS8yOC8yMDIzIDg6
MjIgUE0sIERldWNoZXIsIEFsZXhhbmRlciB3cm90ZToNCj4gPiBbQU1EIE9mZmljaWFsIFVzZSBP
bmx5IC0gR2VuZXJhbF0NCj4gPg0KPiA+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+
PiBGcm9tOiBqb3JvQDhieXRlcy5vcmcgPGpvcm9AOGJ5dGVzLm9yZz4NCj4gPj4gU2VudDogTW9u
ZGF5LCBTZXB0ZW1iZXIgMjUsIDIwMjMgNTowNSBBTQ0KPiA+PiBUbzogSmFzb24gR3VudGhvcnBl
IDxqZ2dAbnZpZGlhLmNvbT4NCj4gPj4gQ2M6IEJhb2x1IEx1IDxiYW9sdS5sdUBsaW51eC5pbnRl
bC5jb20+OyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPj4gPEFsZXhhbmRlci5EZXVjaGVyQGFtZC5j
b20+OyBIZWdkZSwgVmFzYW50DQo+IDxWYXNhbnQuSGVnZGVAYW1kLmNvbT47DQo+ID4+IGlvbW11
QGxpc3RzLmxpbnV4LmRldjsgU3V0aGlrdWxwYW5pdCwgU3VyYXZlZQ0KPiA+PiA8U3VyYXZlZS5T
dXRoaWt1bHBhbml0QGFtZC5jb20+OyBIdWFuZzIsIFdlaQ0KPiA8V2VpLkh1YW5nMkBhbWQuY29t
PjsNCj4gPj4ganNuaXRzZWxAcmVkaGF0LmNvbTsgS3VlaGxpbmcsIEZlbGl4IDxGZWxpeC5LdWVo
bGluZ0BhbWQuY29tPg0KPiA+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYzIDEvNV0gaW9tbXUvYW1k
OiBSZW1vdmUgaW9tbXVfdjIgbW9kdWxlDQo+ID4+DQo+ID4+IE9uIEZyaSwgU2VwIDIyLCAyMDIz
IGF0IDA5OjE4OjEyQU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4gPj4+IElNSE8g
aW9tbXUgZHJpdmVycyBzaG91bGQgbm90IG92ZXJyaWRlIHRoaXMuDQo+ID4+Pg0KPiA+Pj4gSSB0
aGluayBpdCB3YXMgYSBtaXN0YWtlIHRoYXQgaW9tbXUgZHJpdmVycyBjb3VsZCBvdmVycmlkZSB0
bw0KPiA+Pj4gaWRlbnRpdHkgZG9tYWlucy4gSWYgd2UgbmVlZCBxdWlya3MgdGhlbiB0aGUgY29y
ZSBjb2RlIHNob3VsZCBoYXZlDQo+ID4+PiB0aGUgcXVpcmsgbGlzdCwgc2ltaWxhciB0byBob3cg
UENJIHdvcmtzLg0KPiA+Pg0KPiA+PiBTb3VuZHMgcmVhc29uYWJsZSwgYnV0IGlmIHdlIHRyYW5z
aXRpb24gb3ZlciB0byBhbiBpb21tdSBjb3JlDQo+ID4+IGZhY2lsaXR5IGZvciBxdWlya3MsIHdl
IG11c3QgZG8gaXQgaW4gYSB3YXkgdGhhdCBkb2VzIG5vdCBjYXVzZQ0KPiA+PiB0ZW1wb3Jhcnkg
cmVncmVzc2lvbnMgZm9yIGV4aXN0aW5nIGhhcmR3YXJlLg0KPiA+Pg0KPiA+PiBUaGF0IGJlaW5n
IHNhaWQsIEFsZXhhbmRlciwgY2FuIHlvdSBwbGVhc2UgdGVzdCB0aGlzIHNlcmllcyBmb3INCj4g
Pj4gcmVncmVzc2lvbnMgb24gdGhlIG9sZGVyIGhhcmR3YXJlIHRvIG1ha2Ugc3VyZSBub3RoaW5n
IHJlZ3Jlc3NlcyB0aGVyZT8NCj4gPj4NCj4gPg0KPiA+IFdlJ3ZlIHRlc3RlZCB0aGlzIGFuZCBj
YW4gY29uZmlybSBubyByZWdyZXNzaW9ucy4NCj4NCj4gVGhhbmtzISBJIHdpbGwgYWRkIHlvdXIg
J1Rlc3RlZC1ieScuIEhvcGUgeW91IGFyZSBmaW5lIHdpdGggdGhhdC4NCg0KU3VyZS4gIFRoYW5r
cyENCg0KQWxleA0K
