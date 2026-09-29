Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012009.outbound.protection.outlook.com [52.101.53.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B4836B932
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 02:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790650406; cv=fail; b=p9gSrcJr2fI9xFEJ3MKaLkGmwMpUcOufAWxI9H421bxRbuR0ps2ARHkl5m+ONYzF9rsiU/Xs61dc9Vv05bjpH+cR330yjbc+KcFR8slUwnt2gZ7DVQEkXnriG/QcbU4qzEnKtkucEtrKcRlAFQlWM5BfAlgmIvaW7/5wmmFv9Yw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790650406; c=relaxed/simple;
	bh=yiQQZNCZzGOJOtEBx//oJld3UVloPTbdtek6Zh986sc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eZJvk6AsArhUGn6GGFwUsXCLyr+xtw7j6RYL4Kx6YWyY2EKDKYpSm8tm8Mc/DWT06IuVfkkqvViaibUkzQy8y4yLRRKugrUOS3+mTZqgWE0qgjAzKHboSss5drK7akWm51qXN5qdtdYb/R6bv5vmZXihfQvHahJh1VKkNNOseTo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2/IRUn00; arc=fail smtp.client-ip=52.101.53.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2/IRUn00"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nB6EFxiq9i1M5fxsNHrtcwEYpp7WwbR67SHUedECpf4nQmWd3Qfx1xlmZC4Aq/ie4GWQRxfvkehXU6T+jf9gQBEAGEzBH+Ca4n5OTx6neNuqVOYoxg+r/1JAQlHI8F9XvrniE/R7jlVfdJSnLmdUL4Gf239A9m4YT5FYRYA0abo334USyZfXj2trV8l4wL37CFpxyGrhYUUZLPE2ghR5rKQ6ibZyXudJ7Ah1JeAGirKmZ2t2A34+gMhgmly28aZWhuCm7iB2L4RRKFt3zduMHVZxVeisW91mMqNDrmzvvUgjqci8OerZVcIMbSB7rsYHOG4c1elp8dMtZf6Vu4dCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yiQQZNCZzGOJOtEBx//oJld3UVloPTbdtek6Zh986sc=;
 b=CxXsKZDxPuafS3ZBOXI3os1UwQLixbwIaVxZt8QJpPp1J4QA4s+qnvQhGgSCFsi1gKEiy4Mnt5edz3e3sCrJeNlPKc97d75SdZdBlaEqJa+wol+m20z8wkZrdoY53+jqwWbPm3DzNGJ7bfbGyN9Ymopt1onxw/+61nTA3F8PPs2AnDAG5lsa+Wpo46RgldlhMrFXJ2PmG5YMVcBQ1Wy4CBr+h3g5cD4jj+EdY75UsACu7OtMYEfabTHe/x2N+tApCMXnxOySBT2X0ML60Ljw9ZfkeIcDCiSnVq0sRhdj1f+8AN2OLMlFErrga/msaL7eF7qJQqR0MAry9SdpNdDavA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yiQQZNCZzGOJOtEBx//oJld3UVloPTbdtek6Zh986sc=;
 b=2/IRUn00lfgK9LsXt62+iTSa4zWWU532SArycPHIJCeNz23+/y+5YWaLU12XjVLKWyYUhSghD37TWhLUABnijOCjm7oUZPjdLr926N3FqQsAvXRQDaVF5d0LHkPjS03xktqTcSy2GcFIqCnAVVb3FcBPZVAC4b+224+N/XVzWPM=
Received: from BN9PR12MB5146.namprd12.prod.outlook.com (2603:10b6:408:137::16)
 by DS2PR12MB9566.namprd12.prod.outlook.com (2603:10b6:8:279::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 02:53:22 +0000
Received: from BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23]) by BN9PR12MB5146.namprd12.prod.outlook.com
 ([fe80::535a:591e:27f6:c23%7]) with mapi id 15.21.0451.022; Tue, 29 Sep 2026
 02:53:21 +0000
From: "Deucher, Alexander" <Alexander.Deucher@amd.com>
To: "Limonciello, Mario" <Mario.Limonciello@amd.com>, Jason Gunthorpe
	<jgg@ziepe.ca>
CC: Mario Limonciello <superm1@gmail.com>, Joerg Roedel <joro@8bytes.org>,
	"amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
	"Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>, "Hegde, Vasant"
	<Vasant.Hegde@amd.com>, Will Deacon <will@kernel.org>, Robin Murphy
	<robin.murphy@arm.com>, "open list:AMD IOMMU (AMD-VI)"
	<iommu@lists.linux.dev>, Jatin Kataria <jkataria@netflix.com>, Boqun Feng
	<boqunf@netflix.com>, "Derek J . Clark" <derekjohn.clark@gmail.com>
Subject: RE: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Thread-Topic: [PATCH v2 1/2] iommu/amd: Add PerfOpt IOMMU performance
 optimization support
Thread-Index:
 AQHdP0hFuRX9gX0eG02fXTx4eFXgL7beb5MAgACOawCAAFZFAIAAC/uAgACeowCAAB/CAIAD5vSAgAA5C4CAABu8gIAAANuAgACeurA=
Date: Tue, 29 Sep 2026 02:53:21 +0000
Message-ID:
 <BN9PR12MB5146DB6F1FE1434E4A2B4EB4F78C2@BN9PR12MB5146.namprd12.prod.outlook.com>
References: <20260908041207.38113-1-mario.limonciello@amd.com>
 <20260908041207.38113-2-mario.limonciello@amd.com>
 <20260924225018.GB16465@ziepe.ca> <arYf3iJW7hfTua__@8bytes.org>
 <20260925122848.GD163130@ziepe.ca>
 <4560d7d3-4d67-457d-bcd7-2176bd850bd4@amd.com>
 <20260925223928.GE163130@ziepe.ca>
 <ab1cdd64-3390-480a-8d41-a942e8b2e120@gmail.com>
 <20260928120831.GF163130@ziepe.ca>
 <34bcdf7a-82b1-43cb-8409-735ebef3fa97@amd.com>
 <20260928171157.GI163130@ziepe.ca>
 <d0f7e245-829c-471c-bf91-f3a0994f5fa4@amd.com>
In-Reply-To: <d0f7e245-829c-471c-bf91-f3a0994f5fa4@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Enabled=True;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_SetDate=2026-09-29T02:45:40.0000000Z;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Name=AMD
 Public
 v26;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_ContentBits=3;MSIP_Label_2d0b1989-8fc8-4a69-bcac-d46889461ba5_Method=Privileged
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5146:EE_|DS2PR12MB9566:EE_
x-ms-office365-filtering-correlation-id: 6f3d3cdc-c12d-4ff8-e884-08df1dd4d2d0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|23010399003|18002099003|22082099003|38070700021|11063799006|56012099006|10067099003|4143699003;
x-microsoft-antispam-message-info:
 71IJJjGr8KZ3wDt9zAZYtOZnZWfk4ldDMc+6uT6JFUX1aOWraLnzf2HUh53Sjw0K46fR8QO1uTwQdJlnbBZfudmKIitA39N446Qy1EjFy2ihbX5ZFIAkWoYX3GDv6KOZynpEyN81DLehYT8FW/jSVSyk38NYP4LuoTm/MVvps0ST1nRVv2VXA3nmeyxPzP46gpJLOe0UvFyGBS2VlJ61sCuVpBx+C/y47DdBAHIciXOQpH7ZAbH25ZBmXloK8SbIZaAEt0h15666W1UQwS+WZoMJ75PzFD0xxRWkZsukmMj1m2fASDlc/ewRRnexzsGm0Ek1FJXn+YmKSSH/nHfZC1RBpP+edPfLsqEsRyeQ1o/Zjf/0gpBAT+dP+QPiuQ3ExZj40OX71geX0qJQLDp/rsxm0Ymlv9H7ZzGWeswgKUKiUY0iU5vw9ENfE+IUOgmDncDgqBfX46fmpxT71uKnmoCUvc+9ZKn4W3vTgGvFpeudUoc+TxUn4Sc2zJhSG9i2xK5RT9xy6XEsyKRFfFwj0iApNBK8xed2dvPn+6JDmUdFB7kqUlssTiU5lPy5COTh53vQLUq1x3mgw+RZgQEZk8IqfHispWBp766YXTi+lIGeDz58k7QUlbX5zC7GU4NLVPNGyBF2ObP0nz4jEpwU482+BSNqoITpuJhBBdolXZRIkmId2RXcB6VX6W9A4kTueCY9AWh7GExRGx1AJpJ0JJm5wg7PDZqMeStgTaLQPt4=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5146.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(38070700021)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NGYwVUZScmt1Ni93clZWSHZuTGpEMWx0a1RxWEkxSGxCRGtwaFd0N0ttZWRm?=
 =?utf-8?B?djdKRy9WNno2NSsxOHM3S1QvNCtGUmpDeS90MHcvUGMvTEtzUTJ0VUk3NWpN?=
 =?utf-8?B?MXl1UGtZUkMxbUZwTHJrZFB0anhiMkFRMk9Wa2x4bjdBaCtKSzRQbjVNZmht?=
 =?utf-8?B?VUNCOU9LY1VJOUJ0bk9tYnAwSlhJSmxSVnJ4RW4vRTFMSXhQeDVNT0RrUjRI?=
 =?utf-8?B?dVZBM0dOQ21uczRKT3QyZGhKK1I1SHdKRUQvRTFyQlZOWXRXbS96Z2JPVEdq?=
 =?utf-8?B?bHo2QXhXUzh4RXEvYzBMZ2MrMG90bDB6Y1MwSjBNMFY5YWJjeGlicGNMSWFK?=
 =?utf-8?B?RVFZNTdwZnRaNVZjNzlhM1FRYWhRaXRlSlZWaDU2b1VuVGdZcjBJeTk5VjE0?=
 =?utf-8?B?elBvZGk4c2JZclNURmhhaXZrTktyMEhGejN5Q0R0UU9NSlNISzNQR1NZWWZG?=
 =?utf-8?B?WHlPZFBYS3BQWm1qak1INVhzRTRraWVvYjM0ekphOFRnTytHbnFQazhJZlFS?=
 =?utf-8?B?d0NuZTVVWjgxRFVMbjlIU2Vsc09IbU1aUGNvYXNsNGhUeCtKbUtYeDRnb0t5?=
 =?utf-8?B?UnFhdnJKN0RSdUc5Z1R6NXF4YWZYRHc2YUtjREI2VXlSSkFUNkhWOHJWb2lN?=
 =?utf-8?B?bkpBcEpHRmNsYWhwcERjL3VNc05LZ2VRNzdITnZFOXJTYzVFN0owUkt5ZTgx?=
 =?utf-8?B?SUI5SHljbi9LdFVQalZ1TEs3NXArNHROa0cvZEtqaVVvTUlNc1pTK3RPUVRs?=
 =?utf-8?B?Qlk1TXZmMFVPWWFteU9EQXVYZ296blpHQjA1REo2ZnQvQ2JJOUtCdUMvZ3Ay?=
 =?utf-8?B?NzRMdWxteC9NU21OYUd1eFBFMGIrZVMrVExtMlBJWUI1REJVd1VqamRNeGZH?=
 =?utf-8?B?RUgrMnE5U0VsdzRIK016dy9VYmMyQzlQVTMxZW1kTXg5WkNDenRNNGI1d3U3?=
 =?utf-8?B?Zk1tY1ZDRE1yeGdENk8zcUsyZEVZeVpEaGpmQnVLN2hidEFvRmJmU2FiQUgx?=
 =?utf-8?B?bzBsN0FpenA3dDd4UGcrL1FxcXl2eVJnUWxTdG5WcHJ1MERFRW1SR0g3dGIr?=
 =?utf-8?B?OVBWZ3RCNXV4MWFTbTNESktrdTB0TnBlZjFyZGdEUHpnT3BJN3dlVXpsa0Vl?=
 =?utf-8?B?WDNwV3RYZDBVSG95NlIxR1lrSXlkUkVoeDQ4TTZsdXVkYy9tMGozQkREdTYw?=
 =?utf-8?B?R1hZSTI1bDNJcnh1a2xZY3g2Tlc3bkZQWEwzYmlMWFQrR3pqL0E5ZThpRFd2?=
 =?utf-8?B?WEt5N0ZEUlFwbFpsU1ZvSUg0TUQ5VWkyU2JXeGljUFZUQWtRL0tXTU9TZ09p?=
 =?utf-8?B?YmlUWjFjVVBoZmE0NFJqZWsxa0t5Y3c2UDdnN3BTUzcwNUJXcFNSUXJiYUZn?=
 =?utf-8?B?TmV1Vy9kd1U1STIxY1ZIWFBXU1NGVm15QllhS2Z6d0VzaWtOYTN6MW1qeWZH?=
 =?utf-8?B?V25WWWJsK25zc095RGRDUnFGWDBrbzMwM3hwajBFZUYyenlmZ04vMWtma0xV?=
 =?utf-8?B?VEpwTG5INHRQbHpMSGVIYzhGUkhUL0xZUGsvWmVNN0QrcWJhcklLMDg4TkV4?=
 =?utf-8?B?TkdrTmVtN2JzRkFIZlZvQzliT2V0UmZLWmJ4VjNkbFkrVlo5aFgyTE9UeDJz?=
 =?utf-8?B?VGlFRDBPcWQyRUpHUzNESEpvdnFuRGxmRXgxdWVBVHkyNWthS1R5T0RiaGZy?=
 =?utf-8?B?OXlRcVB4YitvKy94ZWV2cTl4ajZjWHo4dDcwQS9xSEt0ZFJqOEtSNDc1Z0hZ?=
 =?utf-8?B?bDhMQ1JYYytjNy9WNWlodHhnTERDdTFMNjU0clJvckZSbHYxUkdNdEZNVS9Y?=
 =?utf-8?B?ZE5Mcm1uM3hmY3N5OWYxVEE1UStCWTdvWEF4OHYva1NhYjN2dHMvdFJOUlpY?=
 =?utf-8?B?WHRZeG4zRFk4dG5RV0Q5UHg3UHhqcldJamFaRUI2RDFzUGhoVy9xUlJpRmc2?=
 =?utf-8?B?SExRKzJOMkxaN1FTSE8zVUEwVmM2ei9rM3RHL3BwYk03bitGUGFxdzM4anIx?=
 =?utf-8?B?dkFTMlVaT25xazdzYW5qVVJEekdCUWFzV1pVa2czRTZJMURBa0FzOUR6Rldh?=
 =?utf-8?B?U1Y0RmlybnZ3b3A1VjBWUktuejhSTVJFMWs1bFhJMUQ5dnkwa0VFNFhwc2pD?=
 =?utf-8?B?NmV2YmdJM0tLTFVzaEhoUy9XTlJuNzhVcGI2VmRPVzhnT3dkb0ZGNTJWWlZ6?=
 =?utf-8?B?akh1ZlVjZU5mb3NPSkNONHlNN2xNN3htSEpyd085eHR6bnE2WTJ1cDkxTHBx?=
 =?utf-8?B?RXNWY0xuQ29vWm5ONVBzcEJ1Z2JHSnJIdURuOENXTXM0Ylp5cVRtN0NpMzF6?=
 =?utf-8?Q?Mumb/zm2rZdIHTxjGN?=
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
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5146.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f3d3cdc-c12d-4ff8-e884-08df1dd4d2d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Sep 2026 02:53:21.6812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TNv2Jn2ndRRfiY+9BOP7rfHBbdttTyZjVJdVqZ0mZ36OvY7mA+x67T3KfM8BFJN9FWA1H9bc86nOF1BSpKiwSA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9566

UHVibGljDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGltb25jaWVs
bG8sIE1hcmlvIDxNYXJpby5MaW1vbmNpZWxsb0BhbWQuY29tPg0KPiBTZW50OiBNb25kYXksIFNl
cHRlbWJlciAyOCwgMjAyNiAxOjE1IFBNDQo+IFRvOiBKYXNvbiBHdW50aG9ycGUgPGpnZ0B6aWVw
ZS5jYT47IERldWNoZXIsIEFsZXhhbmRlcg0KPiA8QWxleGFuZGVyLkRldWNoZXJAYW1kLmNvbT4N
Cj4gQ2M6IE1hcmlvIExpbW9uY2llbGxvIDxzdXBlcm0xQGdtYWlsLmNvbT47IEpvZXJnIFJvZWRl
bA0KPiA8am9yb0A4Ynl0ZXMub3JnPjsgYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc7IFN1
dGhpa3VscGFuaXQsIFN1cmF2ZWUNCj4gPFN1cmF2ZWUuU3V0aGlrdWxwYW5pdEBhbWQuY29tPjsg
SGVnZGUsIFZhc2FudA0KPiA8VmFzYW50LkhlZ2RlQGFtZC5jb20+OyBXaWxsIERlYWNvbiA8d2ls
bEBrZXJuZWwub3JnPjsgUm9iaW4gTXVycGh5DQo+IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IG9w
ZW4gbGlzdDpBTUQgSU9NTVUgKEFNRC1WSSkNCj4gPGlvbW11QGxpc3RzLmxpbnV4LmRldj47IEph
dGluIEthdGFyaWEgPGprYXRhcmlhQG5ldGZsaXguY29tPjsgQm9xdW4gRmVuZw0KPiA8Ym9xdW5m
QG5ldGZsaXguY29tPjsgRGVyZWsgSiAuIENsYXJrIDxkZXJla2pvaG4uY2xhcmtAZ21haWwuY29t
Pg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gaW9tbXUvYW1kOiBBZGQgUGVyZk9wdCBJ
T01NVSBwZXJmb3JtYW5jZQ0KPiBvcHRpbWl6YXRpb24gc3VwcG9ydA0KPg0KPg0KPg0KPiBPbiA5
LzI4LzI2IDEyOjExLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+ID4gT24gTW9uLCBTZXAgMjgs
IDIwMjYgYXQgMTA6MzI6NDFBTSAtMDUwMCwgTWFyaW8gTGltb25jaWVsbG8gd3JvdGU6DQo+ID4N
Cj4gPj4gQWN0dWFsbHk7IG5vLiAgYW1kZ3B1IGhhcyBtaWdyYXRlZCBhd2F5IGZyb20gUENJIElE
cyBhbmQgcHJvYmVzIGJhc2VkDQo+ID4+IG9uIHRoZSAiQVRJIHZlbmRvciIgKyAiZGlzcGxheSBj
bGFzcyIgaW5zdGVhZC4gIEFzIHBhcnQgb2YgdGhlIHByb2JlDQo+ID4+IHNlcXVlbmNlIHRoZXJl
IGlzIHNvbWV0aGluZyBjYWxsZWQgYW4gSVAgZGlzY292ZXJ5IHRhYmxlIHB1bGwgZnJvbQ0KPiA+
PiB0aGUgcGxhdGZvcm0gdGhhdCBpZGVudGlmaWVzIGFsbCBJUCBibG9ja3MgaW4gdGhlIGhhcmR3
YXJlLg0KPiA+DQo+ID4gT2gsIHNvIHRoYXQgYmlnIHRhYmxlIGlzIG5vdCBwcm9jZXNzaW5nIHBj
aSBpZHMuLiBPSw0KPiA+DQo+ID4+IFRoaXMgSVAgZGlzY292ZXJ5IHRhYmxlIHdpbGwgaW5kaWNh
dGUgZ3JhcGhpY3MgSVAgYW5kIHRoYXQgaXMgbWFwcGVkDQo+ID4+IHRvIHJlbGV2YW50IGRyaXZl
ciBjb2RlLiAgU28gZm9yIGV4YW1wbGUgR0MgMTEuNS4xIGlzIHdoYXQgeW91IGZpbmQNCj4gPj4g
aW4gYSBTdHJpeCBIYWxvIEFQVS4gIElmIGEgZnV0dXJlIEFQVSBoYWQgZXhhY3RseSB0aGUgc2Ft
ZSBncmFwaGljcw0KPiA+PiBJUCBidXQgYSBkaWZmZXJlbnQgZGlzcGxheSBJUCBpdCB3b3VsZCBz
dGlsbCBiZSBHQyAxMS41LjEuDQo+ID4NCj4gPiBNb3ZlIHRoaXMgc3R1ZmYgdG8gZHJpdmVycy9m
aXJtd2FyZSBhbmQgaW9tbXUgYW5kIEdQVSBjYW4gYWNjZXNzIGl0DQo+ID4gdG9nZXRoZXI/DQo+
ID4NCj4gPiAiSVAgZGlzY292ZXJ5IHRhYmxlIiBzdXJlIHNvdW5kcyBsaWtlIGEgcGxhdGZvcm0g
ZmlybXdhcmUgZGF0YWJsb2IgdG8NCj4gPiBtZSBhdCBsZWFzdD8NCj4gPg0KPiA+IEphc29uDQo+
DQo+IFllczsgaXQgY29tZXMgZnJvbSBwbGF0Zm9ybSBmaXJtd2FyZS4NCj4NCj4gQWxleCwgd2hh
dCBkbyB5b3UgdGhpbmsgb2YgZG9pbmcgdGhpcz8NCg0KSXQncyBub3QgcGxhdGZvcm0gc3BlY2lm
aWMsIGl0J3MgQU1EIEdQVSBzcGVjaWZpYy4gIEl0IGFsc28gZXhpc3RzIG9uIGRHUFVzIHdoaWNo
IHdpbGwgd29yayBpbiBhbnkgcGxhdGZvcm0uICBJIGd1ZXNzIHdlIGNvdWxkIHB1dCBzb21lIHNv
cnQgb2YgZGF0YSB0YWJsZSBpbiB0aGVyZSBmb3IgdGhpcyBzb3J0IG9mIHRoaW5nIGJ1dCBhcyBp
dCBzdGFuZHMgdG9kYXksIEkgZG9uJ3QgcmVhbGx5IHNlZSBpdCBhcyBiZWluZyBtdWNoIGRpZmZl
cmVudCBmcm9tIFBDSSBJRHMgd2l0aCByZXNwZWN0IHRvIHRoZSBJT01NVS4gIEkgdGhpbmsgSVZS
UyB0YWJsZXMgd291bGQgYmUgYSBiZXR0ZXIgZml0IGZvciB0aGlzIHNpbmNlIHRoZXkgYXJlIHN1
cHBvc2VkIHRvIGRlc2NyaWJlIHRoZSBiZWhhdmlvciBvZiB0aGUgSU9NTVUgd2l0aCByZXNwZWN0
IHRvIHRoZSBkZXZpY2VzIHByZXNlbnQgb24gdGhlIHN5c3RlbS4NCg0KQWxleA0KDQo=
