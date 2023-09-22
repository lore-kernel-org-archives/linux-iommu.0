Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83A544483
	for <iommu@lists.linux.dev>; Fri, 22 Sep 2023 18:08:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bwA6flQFSk46mqz9O7fRbcR2Q8v5grQkPy/clSWc06ElGoufykafpr/W8ijhOthmgbEjgOEYeA+Zw5tgHX84CpTh4xriFRf5VpAyNo/K/AYDtKqdYseZa12U27HMBb0jNNmN//KG6Q3/JNU6S8Hvlap7UqtgzB30PovjuCCFZewfYa2pGfI3pzn2lXImKDljIs5Djzr4Zq40d7SNPip5copv119VF4i+bll9MKPHFXpZZN3FvcJJRhldvKTDjIQWlNgcnoZvbwW1dm+/I7/k4TkO/7b3CXMPxGvtxZrvweGUJI3MHzrZW04P9moFIILicDW22P0aAXBNs9dYyWWKRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gf2F5qnEQCJFcg7V3ddKx5JXgiGSARo1nP3XEZk4VJg=;
 b=PI6ugfIa9BOZsSnKQjYyfKob5B1kxZPwaWLe4LxlpxduBGzfbyz58d7Yd1JaL8zkN0vB5q4otsV07u7T6AAPezNCQhyXgyTM4231sRMqVqKSFEGdHjizEFPgZbYZvOdrO+TqQIn2CD0GMsLs1YqcneOg4n6/28dkl0MsSWoBmtfIgTARMOJhQqyRPkWj80qzNwtr2xyoPxO61ZZDtL+nMuPZ7gibCLDE68IB/ixqtBxdVR0Kq8NPz9gjW6lKKta4ZpF+uYLe+4uglSANi0dHWugYAFCHR/rElRKy5fiFXL4dAB/E++pkvJMCJNQihWqkDVM2/U6XEI0nmF9ue8NktQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gf2F5qnEQCJFcg7V3ddKx5JXgiGSARo1nP3XEZk4VJg=;
 b=x8YjyWMtae/1JHdY3nRQN41mrilW68zcCAgijnzi+Gjb6EMac7SHCLe1KCpKAtYL8Dw7JC4/G5KthFbr/qmkl/oL+u+6C5Pbz11sa9cF8pPtYRHT7BcovbYEUy4a5mHILXnUFGxlaWH0ve07tZP4UZjKNznQtBxCVSLIDqwmDtg=
Received: from BL1PR12MB5144.namprd12.prod.outlook.com (2603:10b6:208:316::6)
 by DS7PR12MB6143.namprd12.prod.outlook.com (2603:10b6:8:99::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Fri, 22 Sep
 2023 18:08:38 +0000
Received: from BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2]) by BL1PR12MB5144.namprd12.prod.outlook.com
 ([fe80::a2bb:870f:8aaa:1ba2%6]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 18:08:37 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: Baolu Lu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Hegde, Vasant" <Vasant.Hegde@amd.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "joro@8bytes.org" <joro@8bytes.org>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>, "Huang2, Wei" <Wei.Huang2@amd.com>,
	"jsnitsel@redhat.com" <jsnitsel@redhat.com>, "Kuehling, Felix"
	<Felix.Kuehling@amd.com>
Subject: RE: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Topic: [PATCH v3 1/5] iommu/amd: Remove iommu_v2 module
Thread-Index:
 AQHZ7G6D8C15gDSmGUyI0hSW7LwfLrAlT/OwgAAC/YCAAA660IAAF7sAgAClRgCAAKDwgIAAA8wAgABiRuA=
Date: Fri, 22 Sep 2023 18:08:37 +0000
Message-ID:
 <BL1PR12MB51441FC4303BD0442EDB7A9CF7FFA@BL1PR12MB5144.namprd12.prod.outlook.com>
References: <20230921093140.6162-1-vasant.hegde@amd.com>
 <20230921093140.6162-2-vasant.hegde@amd.com>
 <BL1PR12MB5144C5ADC106D450EA73C511F7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921141415.GN13733@nvidia.com>
 <BL1PR12MB51449627A11B2BDA55B97C8CF7F8A@BL1PR12MB5144.namprd12.prod.outlook.com>
 <20230921163154.GO13733@nvidia.com>
 <19c7c139-b002-384f-5766-b87a8013029e@linux.intel.com>
 <20230922115927.GI13733@nvidia.com>
 <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
In-Reply-To: <a4770035-9f1a-3bff-2ff2-d6b9c81e2c0b@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=95cad348-4fe9-4780-9385-692cb11a4e3a;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-09-22T18:04:54Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5144:EE_|DS7PR12MB6143:EE_
x-ms-office365-filtering-correlation-id: caf67086-5b6f-4010-3415-08dbbb96f1d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 gDFaJvAm8RSb5Uw4rjetuCC/DxMpJawgjnoMuikFnPyTQZkXA9WOjQPIkQBiM2uRGyl6mqsMp68R6XfjcTjRguz6LP3I3G1hvmlCDop6oD7ZAxi7JWKpE3JlsFeo3XPNJXU8YCWe+eVfzDPTmKYKDY2y1Y9tZy54S2QuA/HW7dpC4w7+AVdU1PinWDCO1IQCsNapPoLnreCWCqPqmbsFpYDGzf+fK20r4CTNCAAEjWvtpODruMj/vwaV0emmeuETeaQz452FITyyxRoMwOzobNyq+6+0OHKifvtaq6sVfgitZIRMYydTjnUFCYJpQybBSwSFMXLu5NkjWmS/TLyyRlKqpshEo4uMu4CTo+4XmYbtaDVMWRa6JOeZl9hoGvJ5JE143s8VEgQFXb4I4XbIzYwnCDyFDXQvoBb3Vuih32ixGqpFXUv1s1RzndgeoJz4FpudfjEchDUHIAaKGCZfeC0WRJzN1oWcj0ML34dLBEKc3e2Ftvq8/RcmOqpnyfPa+gYtal359ZzQRtUus/8+VFNJrGpxDIy28C83vs3a/cnlq2VesNFY/1ZX+Xxs7PxEn0fqYt79tOIJUYH5HdAL+yAT62JcLU7ZUz9PiblFxOje1lCXicL1O1sJAnKfQO1D
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5144.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(376002)(39860400002)(136003)(366004)(186009)(1800799009)(451199024)(83380400001)(478600001)(6506007)(53546011)(7696005)(71200400001)(9686003)(4326008)(52536014)(66556008)(8936002)(54906003)(316002)(66446008)(64756008)(66946007)(66476007)(110136005)(26005)(5660300002)(2906002)(8676002)(76116006)(86362001)(122000001)(33656002)(55016003)(38100700002)(41300700001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Wk1PazNwRnJNMnVQTlZFRlhicWFmQTFrdGZMMDd0dzdKSXNSZWtzUDJsL1A5?=
 =?utf-8?B?VkpVUm1odjRYdlJmeURaM29uRldmVkNxcnJWU09wN2hwNEVKWURWOUhGNkFT?=
 =?utf-8?B?VmIvSFg1ZkNaTk44MFhCMzlCcEswUnVsT3I5UEFhTGhRaE50SENGUXFkRWpV?=
 =?utf-8?B?UTNoK3E0eHFYaEJFZ2hSNkhGc3JGMVNLbUt4eDlwUmR3WHlLRFlHZ2VkYXc5?=
 =?utf-8?B?ZVdJd0xQVkpwMk1ybEtodVhNMUc4WTlHN3VCRUMyWkRqb2MveEp0KzJxWFR6?=
 =?utf-8?B?d1R6OGh6MzFLQUdwRWhySTRyNVppdTJ4ZjJvTTBrc1hiOUNHcndkcGdpVlpt?=
 =?utf-8?B?Wm50QmlkM2c0WHpXSWFVd2VqZUNEVksyMHVRMThqK3hBWEpQQW5PR3lWOVFo?=
 =?utf-8?B?RjBUYS9KblhwSllNRkgwYTM3SG1sMU5IYzlGS2ptQ214VTJyZ1NoWlZsQ0VC?=
 =?utf-8?B?V2lNY3c3TE53K0V1dEJMTlpoUmtQWTNZSjZMSm8wcHdieGRIOFRNRUtOWEFs?=
 =?utf-8?B?MVBRMEE1VnBTOGVWMmNPeEEzZUREd2pZY3hjdFdXQ0RsMDk0SWVtSlAxWnJ5?=
 =?utf-8?B?K2hIQ1lLcHM3a2ZWWXRWRXAvZkFrVmJTR2ZaQXdwdlN3ZkZ2YlB5M0lLbTRU?=
 =?utf-8?B?ZThtUDZBS2l2dithOTkraFl2YklHeTNoOTh1RGJuaHlGMkJjTFp3RVJBS1M1?=
 =?utf-8?B?cEU5Y2FwK2ZtLzA1VlJKVUJRMUI0Tm1QdVphdG0wN3R3a3lOb25ZRWlIOU5v?=
 =?utf-8?B?T1oxOW1jL1F0WVVLQ05PcURPRE05Ni9yUjhRd1g2TFdlY3EyL0cvT2QyRHlu?=
 =?utf-8?B?RTBGNnNSbjg1S0NhSFR1Yys4L25uTmM2Y1VpNzhzZEp0cEhuS2FuQTVkN21G?=
 =?utf-8?B?dWl6eXFyYjVkbzg0eENtOXF4aFF5dlBXNW10Z3FaaGdzbUhwSi94VVlOQUFU?=
 =?utf-8?B?RW0rZ3grazJ0VmI3emRTYnBJVXJMbEJEQ3k3a0lOd0pDa1J1UVhINnJWZzc0?=
 =?utf-8?B?NDJRQmdaSjB2akRPVnN0K1FwOEJwaVpjUEx3Y3FwVHhtZTJEbk5INTBSMTlF?=
 =?utf-8?B?OVFrbWVPYkwveWQ2TkVXZXh6REVxbzVHSDhxN1hVYnorbzlRYldDaEN5Zitw?=
 =?utf-8?B?aDBEVVJOcmVkTElxUmdhTHBsS3FNaGRUNkhLbHJ2WC8vdE8vbE5CNExqNWho?=
 =?utf-8?B?Z20vVWxTbDhPQVlGd2Q3Z1lLWVRxejhNZkxhdmJMbWVJOVZxek1RaWpMeWFU?=
 =?utf-8?B?S2xwRlk4Y1EwM21BSkFaRzdtVzYzTkhPNk5nNit6WVlObGFWaXhOYkVlbHhm?=
 =?utf-8?B?UTBNZ29HWmZQdmgyQm5Hdk5VUjQ3bnhyc0tjSXRwTEdNRUpKalg0R3hFRUhz?=
 =?utf-8?B?dS81bk9QcjBvblNIRVFpSk5od0t4NjhQUkpBc1RQeHpzRERJUVE4TGtXajQ4?=
 =?utf-8?B?U2ZMQTQwQk8rR0srZlhxMmN3TG1tMFpMRXFaOExNOGZNblJVdkFHbll2Y0hk?=
 =?utf-8?B?TWtCd24zTG8yLzhMOVgxSXVBejgzN1dLQzF2ZDRWaWhURkdWbGYzY2tDTllP?=
 =?utf-8?B?d2FHRjFFcHI1ZkpvQzZGa0NEWkYzcGlGRENxbHFUNVBsay96Sm93TWpqS3BD?=
 =?utf-8?B?SFBlS1RSQkttdmVhOFpUWTlaRUdMMlJGVzhkOVMwbDVIajFoRHc3Y0hJYmVU?=
 =?utf-8?B?OTl1bjVRZzRVZ0xFK21DZy9Fbjd3QU15Qmd3MDlCdjlpMkJ4cHlwU2tDNWJ3?=
 =?utf-8?B?Z3BoTlE3aGxxenFTamVoZjZXWUJXcHhLOTl4dEZuOFBPaER0dnk4M1Bmc2p3?=
 =?utf-8?B?NDBJaFI4NzRaalh5TTJGT0J4K1JMU0xYNk1DNjBIa3hubjlSTnNsdUpzZndi?=
 =?utf-8?B?eFNQbHFQV3V2VVVWK3BaSW9LbEhNNitjNmZXazJ0dXJKSXlFejNmRTl3RmZF?=
 =?utf-8?B?WHlZYzQxM3hJT0dKSmlBR2Zsb1p5NUl4Vk43ZXFybmg2MmpBSGlHc2tDQ3Rp?=
 =?utf-8?B?K2x3SWRYeHM1Z2hJZXFKMmVSQ2JSckVIY0J0K004Wk5nb2JDZGhyQkQzWHM5?=
 =?utf-8?B?VTdKWlppeW5ReHpLVHVOYlhDeXE1R2pmRkJwcGp3YlJFL2N6SDhVcVRYdXBn?=
 =?utf-8?Q?gl2c=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: caf67086-5b6f-4010-3415-08dbbb96f1d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 18:08:37.9152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sidkFtVIFOs+fXvnI/FSlavMJg6RYOtfEFlr7cYhq8nt9VEj2jbTR+g+TI/FMNKfnjZxG1eZ7+OFa373cGDIGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6143

W1B1YmxpY10NCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCYW9sdSBM
dSA8YmFvbHUubHVAbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBGcmlkYXksIFNlcHRlbWJlciAy
MiwgMjAyMyA4OjEzIEFNDQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0BudmlkaWEuY29tPg0K
PiBDYzogYmFvbHUubHVAbGludXguaW50ZWwuY29tOyBEZXVjaGVyLCBBbGV4YW5kZXINCj4gPEFs
ZXhhbmRlci5EZXVjaGVyQGFtZC5jb20+OyBIZWdkZSwgVmFzYW50IDxWYXNhbnQuSGVnZGVAYW1k
LmNvbT47DQo+IGlvbW11QGxpc3RzLmxpbnV4LmRldjsgam9yb0A4Ynl0ZXMub3JnOyBTdXRoaWt1
bHBhbml0LCBTdXJhdmVlDQo+IDxTdXJhdmVlLlN1dGhpa3VscGFuaXRAYW1kLmNvbT47IEh1YW5n
MiwgV2VpIDxXZWkuSHVhbmcyQGFtZC5jb20+Ow0KPiBqc25pdHNlbEByZWRoYXQuY29tOyBLdWVo
bGluZywgRmVsaXggPEZlbGl4Lkt1ZWhsaW5nQGFtZC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFU
Q0ggdjMgMS81XSBpb21tdS9hbWQ6IFJlbW92ZSBpb21tdV92MiBtb2R1bGUNCj4NCj4gT24gMjAy
My85LzIyIDE5OjU5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gRnJpLCBTZXAgMjIs
IDIwMjMgYXQgMTA6MjM6MjZBTSArMDgwMCwgQmFvbHUgTHUgd3JvdGU6DQo+ID4NCj4gPj4gMSkg
UENJIGRldmljZSBzdXBwb3J0cyBBVFMgYnV0Km5vKiAgUEFTSUQNCj4gPj4gICAgIEluIHRoaXMg
Y2FzZSwgQVRTIG9ubHkgbWVhbnMgYSBUTEIgY2FjaGUgaW4gdGhlIGRldmljZSwgYW5kIGl0IGRv
ZXMNCj4gPj4gICAgIG5vdCBtYWtlIG11Y2ggc2Vuc2UgdG8gY2FjaGUgdGhlIDE6MSBtYXBwaW5n
cyBpbiB0aGUgZGV2aWNlLiBFdmVuDQo+ID4+ICAgICB3b3JzZSwgdGhlIEFUUyB0cmFuc2xhdGlv
biByZXF1ZXN0cyBjb3VsZCBwcm9iYWJseSBjYXVzZSBJL08NCj4gPj4gICAgIGNvbmdlc3Rpb24g
aW4gY29ybmVyIGNhc2VzLiBUaGVyZWZvcmUsIHRoZSBiZXN0IGNob2ljZSBpcyBwcm9iYWJseSB0
bw0KPiA+PiAgICAgZGlzYWJsZSBBVFMgb24gdGhlIGRldmljZS4NCj4gPiBOb3BlLiBXZSBoYXZl
IGltcG9ydGFudCB1c2UgY2FzZXMgd2hlcmUgQVRTIG11c3QgYWx3YXlzIGJlIG9uLiDwn5mBDQo+
DQo+IE9oLCBJIGRpZG4ndCBrbm93IHRoYXQuIFRoYW5rIHlvdSBmb3IgbGV0dGluZyBtZSBrbm93
Lg0KPg0KPiA+DQo+ID4gWW91IG1pZ2h0IG1ha2UgdGhpcyBhcmd1bWVudCBpZiBBQ1MgaXMgYWxz
byBub24taXNvbGF0aW5nIHRob3VnaC4uDQo+ID4NCj4gPiBSZWdhcmRsZXNzIEkgdGhpbmsgd2Ug
bmVlZCB0byBnZXQgaW50byBhIHBvc2l0aW9uIHdoZXJlIHRoZSBpb21tdSBjb3JlDQo+ID4gaXMg
ZGVjaWRpbmcgaWYgUFJJIG9yIEFUUyBpcyBlbmFibGVkIGZvciBhIGRldmljZSwgbm90IHRoZSBp
b21tdQ0KPiA+IGRyaXZlci4NCj4NCj4gQWdyZWVkLiBJIGV2ZXIgaGFkIGEgc2VyaWVzIHRvIGFj
aGlldmUgdGhpcyBhbmQgaXQgbWF5IGJlIHRpbWUgdG8gcmV2aXNpdCB0aGVtLg0KPg0KPiBPbmUg
YWRkaXRpb25hbCBjb25jZXJuIGlzIGhvdyB0aGUgY29yZSBrbm93cyB3aGV0aGVyIEFUUyBzaG91
bGQgYmUNCj4gZW5hYmxlZC4gSW4gbXkgcHJldmlvdXMgZGVzaWduLCB0aGUgSU9NTVUgY29yZSB0
dXJucyBvbiBBVFMgYnkgZGVmYXVsdCBpZg0KPiB0aGUgZGV2aWNlIGlzIGNhcGFibGUgb2YgaXQs
IGJ1dCB0aGUgZHJpdmVyIGNvdWxkIGVuYWJsZS9kaXNhYmxlIGl0IGZyb20gaXRzIGRyaXZlcg0K
PiBwcm9iZSgpIGNhbGxiYWNrLg0KPg0KPiBEb2VzIGl0IG1ha2Ugc2Vuc2U/DQoNClllcyBwbGVh
c2UhICBXZSBoYXZlIGEgbnVtYmVyIG9mIGRpc2NyZXRlIFBDSSBkZXZpY2VzIHdoaWNoIHN1cHBv
cnQgQVRTIHdoZXJlIHdlIGhhdmUgdG8gZXhwbGljaXRseSBkaXNhYmxlIGl0IHZpYSBQQ0kgcXVp
cmtzIGJlY2F1c2UgQVRTIFRMQiBpbnZhbGlkYXRpb25zIHdpbGwgaGFuZyB0aGUgY2FyZCB3aXRo
b3V0IHNvbWUgd29ya2Fyb3VuZHMgaW4gdGhlIGRyaXZlciBiZWluZyBkb25lIGZpcnN0LiAgSWYg
dGhlIGRyaXZlciBjb3VsZCBzZWxlY3Qgd2hlbiB0byBlbmFibGUgQVRTLCB3ZSBjb3VsZCByZW1v
dmUgdGhvc2UgcXVpcmtzIGFuZCByZS1lbmFibGUgQVRTIG9uIHRob3NlIGRldmljZXMuDQoNCkFs
ZXgNCg==
