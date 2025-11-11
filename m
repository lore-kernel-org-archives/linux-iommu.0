Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazolkn19013074.outbound.protection.outlook.com [52.103.74.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258AC2FB973
	for <iommu@lists.linux.dev>; Tue, 11 Nov 2025 01:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.103.74.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762823943; cv=fail; b=HqVDSfIzbmtbXViz9CA2I5fOwcSu4UkaeQH25jpffFwo2a0j6wWTnNDo4+wNeNuSiZB6xZjt2LR6cPElPxUVsASNZH5PBxal9AJtys8rKnxGg+BfLlVlo8ROfWow+1FPim1Sc+twn56Zxi/k9349PYa8k1kgY726PnWSYg/0gEY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762823943; c=relaxed/simple;
	bh=h4umLNwE2izMkz8LqlP7lgmhqxs9jVTwWWMocyH2YTI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IZMNk9uoH4fQmkUxRPOsoMmBrND2+aQ2y7a1LwegqZz2PnnJNtfJSQmlU4gtXs9kYYlFXgECByLgf+XmhSQWbm3HP0l2Csz8fjTAeHyyENRhnY5nWzRhcOaVgCvdsJYzai+NA5VPHXrX04Hd05rGE6kGA//dZuyTXZci0qpAoUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com; spf=pass smtp.mailfrom=hotmail.com; dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b=LDQxts9f; arc=fail smtp.client-ip=52.103.74.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hotmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hotmail.com header.i=@hotmail.com header.b="LDQxts9f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QviAjEk/Eax93w05l9BQ1JiBbyiVCFWVAZQ5p/IdzL+cN/oB8gpso4KWgmlOsJS5RsIoOHLzRnQXfISn8fdLCwKEQIrNAq4GFAliMv9XmVD2TCkNeU0FSZvpSqrd29xl6JVvPfgQkySpB3XQzaCeZXNnsvaewz2H08cEk6RfR6StxuImAqYdgbHxk8XIRUrzGf1OG0uSBPyH7uyjjR0sApE3hgWSbKLH/ieQc4TYzdbTaTSWMvsX6ChvyDdP2fpEllMP1KiEv/8tZn+qIflIG2Dv9FnYbrqqGCTpuA5zI+ftwVzuoA6bMHEHT7v/rxkCAyHhT5iooIpHkBUIe/Vdtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h4umLNwE2izMkz8LqlP7lgmhqxs9jVTwWWMocyH2YTI=;
 b=ymwuv8pFleGCt1keUl8kjpVQV5kqa6JNF5fL/uCXGTh2CTlaBLPxHtlrusSCw+ie5DzDqMTYx+uxMC9srARcTBxdzX/swWNZRUSnmB3fEXcjdMZdHUckQGtRpo0P+dTjEVcL5ZysJSqfBzbO7cm+wS60aMNxOlLhpalcZQJhR1RfIJZm0GyWmk5BHdGBky6astyzypAL8cjDm/BTgQGN7cSai3AdJsiCptkwrvzpKUKWyq8UJGtyYwxz2RNS5Oig3WIPH8LdlTBapH8kRty43BhLomCBaV7Gp+iinQDWe39zLwvZrQtQSE35XE6XLIfbQivGwrx+PI8Le6HL41utsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h4umLNwE2izMkz8LqlP7lgmhqxs9jVTwWWMocyH2YTI=;
 b=LDQxts9fW1IImkJAdDHHnFBCIUhobhpBUA4c7hODXOcPuTxsLblBkgRgIIls7HvIs1EaDIfbkyER87UyEe1aixeLG3A0b9qALCGAM4kHesbOcEr0MAtewmsskMNU94Xq8ZtdplA3kCA03IYf6kQFBc4YdUDFCjtnS10M+dX4b7nOEyup6kWTU4wdxblngVMZdgB+HaQfvIHxCvtU5fAuurt4G6VCjVAyekSZZGImGCnfUNxdLYd1ZonTB0tV8Xere5t0tGlZTdNCXXLbcuFErf4tsEdmpCO6iUs5WQYIkVuNEtNsGnJ1kFppSQVTShBlz5suBaYaVMZZNG63Tgjm1A==
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 (2603:1096:101:4f::13) by TY1PPF4E964F9E4.apcprd01.prod.exchangelabs.com
 (2603:1096:408::323) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Tue, 11 Nov
 2025 01:18:56 +0000
Received: from SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19]) by SEZPR01MB4399.apcprd01.prod.exchangelabs.com
 ([fe80::5145:bf70:5ca0:ee19%6]) with mapi id 15.20.9298.015; Tue, 11 Nov 2025
 01:18:55 +0000
From: Wei Wang <wei.w.wang@hotmail.com>
To: Vasant Hegde <vasant.hegde@amd.com>, "alex@shazbot.org"
	<alex@shazbot.org>, "jgg@nvidia.com" <jgg@nvidia.com>,
	"suravee.suthikulpanit@amd.com" <suravee.suthikulpanit@amd.com>,
	"thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "joro@8bytes.org"
	<joro@8bytes.org>
CC: "kevin.tian@intel.com" <kevin.tian@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: RE: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
Thread-Topic: [PATCH v2 1/2] iommu/amd: Add IOMMU_PROT_IE flag for memory
 encryption
Thread-Index: AQHcTMpGA/9lTKVYuEa2QjS5vGXcw7TrtpoAgAD3lmA=
Date: Tue, 11 Nov 2025 01:18:55 +0000
Message-ID:
 <SEZPR01MB4399DEBB3B5DA122E075899DDCCFA@SEZPR01MB4399.apcprd01.prod.exchangelabs.com>
References:
 <SI2PR01MB439373CA7A023D8EC4C42040DCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <SI2PR01MB439351F0B7E54513710BBD3DDCC7A@SI2PR01MB4393.apcprd01.prod.exchangelabs.com>
 <e6b877d7-91c9-4db7-9c4f-bcf4608e17df@amd.com>
In-Reply-To: <e6b877d7-91c9-4db7-9c4f-bcf4608e17df@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR01MB4399:EE_|TY1PPF4E964F9E4:EE_
x-ms-office365-filtering-correlation-id: aadd2bfc-ad65-4abe-6086-08de20c04891
x-ms-exchange-slblob-mailprops:
 laRBL560oLT/z5vudnqSE/O7qQNjjjS4fkWbseK2xave77reU5BfiM4ULtGCYX4W+troajtO+hBWGmKzf/tEzSNunKWlFsPgC3dMbq0VepIMxOHUhcW3JTAnK8Da4FOH/OyNsL+w0P40LfR21k/O4aQLmuPFojYXBngGGyMncd97lco4bY/MjLRjDIWzCiAvFRKvuOOa/l7YV4zrD/M95vR9Z5+NIM1YxTgsxO9jX/EwxyMtcD6RxXtGqYJA+8/XUPLL5l6YMUY7/KlUIeOpldfaG9I9Wfh+H/inpMPJKZpHV2viZLydLFh2gV8O2QLayGhKJw8QB4DTEwOO0kAxPtWUfuNjk8eIF565878cqF1H5pfR5FDKGdGwnLrmn/8Kn5fdR+s4z4khkPIwdFmKh1r7rcTUWEfL/wrDB4WKFQxBGVbQ/jpeaUOIi3B8UPrCsG4Rmr2rI1oED4gVfFrSAMFzsPfAhstQd9ecO6qQWedY3QiMk/lkGpICxsVVvL1dlk2pP1DBA+/8L6jlgbjqQ6m/RbcPdw1tBzSEq6AGuKbHfbMwDkNWM6Oc09vyjQOWxwHaKymENQ9bqacGxS77xI5QOLOAst8UOvwouSguWRjmDJrn/asB66HWpLHUv2OtQehjgGl9/OhwVjQs0aZW16mPNjQxafORcHQfd3WEZ1g5DXQqf3jhuwb7ZTAsYKwV+/PmKfqDF79s+Eq4NlfC+EacAlqCxGW2kdlML/kDtH/0hmjnTx8nNuoCFpgP3RtqqVtnTVMLSDmQu5/OoFFrfzii8BbvTJN9
x-microsoft-antispam:
 BCL:0;ARA:14566002|31061999003|19110799012|15080799012|51005399006|8060799015|8062599012|13091999003|10112599003|461199028|40105399003|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 =?utf-8?B?bWhOMWxYQ3JMNlYwQVdaWXV5cWREYXlUcFdjdGVSdmErdE5RYi9qcnMyY2do?=
 =?utf-8?B?cElCMk84SnBpNFArZzRIbTNrRitIU0dsc2dRS3ltMFlqZkcycUJxa2t5SzdP?=
 =?utf-8?B?ajZLNFZXS2tXWUNzYTRGWlJoTit5VlQwSWFsdzlRSFRGKytxZTJmV2dRUnFj?=
 =?utf-8?B?cG1MaEpqZ0EwYWhjcnFrZHZwWmFZbldWbFRQNHp4M0Ezc1J6UmhXZk9Xdmh3?=
 =?utf-8?B?NkVhQnhUZUY1SmFWUDFiNG9WVHN2ZlJJU2lKNFhBV2FPc3dVMnYwb3ExVklP?=
 =?utf-8?B?U2ljd1pTclBnMFRweXIzWFM1WFQzL1dUYXdHZVROL3R1c05CMVZPSmlsWS9k?=
 =?utf-8?B?RGs3eC9qdit0T2M0S2dyOFhMMGRHR1dQMUpkY2JuZFV3aktnQ0FITzdCTjFt?=
 =?utf-8?B?TTVpdUJkb2VGWFRob1JvNnpxR0ZqQVA3ZW1IWkY4dGxlQ2JNd0tOU1pGaXRi?=
 =?utf-8?B?NFBXYXdZelJrcUlWR2kvcWxFd21PalRHbktsUVoxb2tQYkxHSTY3eW1XZ0lt?=
 =?utf-8?B?WU1yb003eHAzbUd2S25OY0VpbFF6SVMwdEF1d1ZDdGhqNTA4RzdtRDhNTmxG?=
 =?utf-8?B?d3V4RFp6Z2tyM2RPRk1EM2NsTkZQUFI3UTkyQUNSRVdLUjdoV2k1ZVJoRS9L?=
 =?utf-8?B?a3B5VEJUYkkzMC9oNzdQM0RvQm8rM2tycXE2R1BXMy9ZaDJKdGFpTUg3d2di?=
 =?utf-8?B?VE5rbXZ2V2tac09kNk5udVZJS2d3NTNjYkpPdGRSTGZDZGxlaW5DZGRMTHU1?=
 =?utf-8?B?Ty9rUXc5Qk1QeUI3aFV6UEcwZFpsNTlHTzJTbU5sUndGTTloWWZ1SGlKTkJ2?=
 =?utf-8?B?Ni9tcTRHUy9kTEpYekRTdFhUd0EzS2RaajM1b1NmZk9OQTNrOWZsL3BMa1h0?=
 =?utf-8?B?ZVlBRElZRlRsQjd0MDFKamlvT1RQSHNiUldCcnhvSk50N3IrSU5ic2lzNTdO?=
 =?utf-8?B?Q0hRZnVhNVVRM3pqcjBXVE1lbHlmZTJ6bUpFWTVyUS9yV3g0RHNuMG53Ukxs?=
 =?utf-8?B?YnlBZ3BwNUwwODE5RTZwNkY0dTEvVWczSVpDNnRqc2dGWnQ0NGxzMThVR1VQ?=
 =?utf-8?B?MTRqSnh2SnRURWtsNEV2aHAwWFBGM0x3Ny8yZDVvTXJqWFdLUmgrbittOWFG?=
 =?utf-8?B?OVphaHFtRnZuc2MyUWlLMVAySUlUbGFGWEJFLytlelI0OXNydFQ0OXNKcVM1?=
 =?utf-8?B?WEYxVVNVV2crWU5MSis1Y085MTdYMm93TlFmRGxvOVVBUUVyWGpDd2F4L0lC?=
 =?utf-8?B?Vml5ZzluU2tBZFlHYmducjJ2RzlpSjEwcTNvdDBWTGJoVVhxb2dyS2ZCZnB5?=
 =?utf-8?B?WTFLSFc1NGxVWXRTL1d6SmlvdnlwWnNEak02bk5ZUnBCSjUxUEJFb3BsRlcx?=
 =?utf-8?B?RXo5aDdIdnM4K2EyVXR5RjVWZ0M1Uk43S3puQXJVN0hNdW1VT2lPMzI4WjFN?=
 =?utf-8?B?SC9NdUxrK2NpUW45dG5pN0JqZjlnK3NIQ0JMMVlJYWk5NWhDQjRkcWJWcDVr?=
 =?utf-8?B?UmNUdmFrVUM4MmZGT1FEaGRzNlBzVkxMRUlLcFZmMFNYa3Qzb0dDQnNQVGp1?=
 =?utf-8?B?K1lDNnlodGNGQjFBcklWbkcxUENWR2hUSUh1RXJTc2dyMEM4OTJ6K2FwSmtq?=
 =?utf-8?Q?vxGmxWlAVPBmdRBaw1RvdIZ+GxU6BYOl22FrL4ecglAg=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?UXNXTWVBcEdhTktoYlNUWjIyNkJGQnJ0dDZxS256VEVvNERMKy96ZFdvQWhH?=
 =?utf-8?B?Sk5VVUpMbVVMS1RoYnNBZnpRS0Y4V0R1dmhuRldxRUZobGMra2VWNk1yK1Jp?=
 =?utf-8?B?TGlxMmFCUXVOL0VqdVVxaXNpemZaZkUvajFNZm41YVMrNGllMWZPbW96dStm?=
 =?utf-8?B?dnRSakp4OHhqc0VmblMxVjVHci9FRTJ0eUsyK1hDeGtKbm9JejB1a3MzOHBH?=
 =?utf-8?B?NVV6dEs4NlVocmNlL3U0Z25TRzNad3NtUjVjY1ZneG92b3hrandEOTQrSkZP?=
 =?utf-8?B?RGhDOUM4bXlFeE9qaHBPbEpNTUQ1NmkyOU01S2RZRS9TS0pEQ2pMRTJ4Mk1v?=
 =?utf-8?B?ZWtzdkYvc3BEYUs2aklZMDI4RHkxanFMa1NzNUd3cTEraXEvdk8rUHZRSW5Y?=
 =?utf-8?B?LzVZME1yS3hzWkVVN0QvcVY2ZDZnaTZHMHgwbDkyVExqenFjTjNsRTVnQlBC?=
 =?utf-8?B?aDVQejByUlBsUmVRZTlKRU1LNUxZWkQra3lYTUtPQVZHTHB3K282OWV4cXFn?=
 =?utf-8?B?VjIwL3J3b1FsZEZ5c2pHTE9TaS9IK2IxdmswL3hYQ1NwUzk0b2IxWFRlZnJ1?=
 =?utf-8?B?WVRNMVBHMjZuYjlRUk43a1ArZmRiLzJNQytvcDRiOUZTZmRIQy9ZN2FFWERk?=
 =?utf-8?B?Q015WjVVaG8vS1lkZVp5STdsdHFmUmoyVUJDalQ4OGR6WWt1WXFTSlIzSU1o?=
 =?utf-8?B?UUsvZ2NDeXVWRExsL1k5WEtIN1YzakhHa2tBWW1iMHl4NExHUEx0aFR1bDFT?=
 =?utf-8?B?MWtiWkVHSTBNTFc3ZDZDL2dJS3JUczRjajFEdWxTejVad21mR0pVNWRFZjEr?=
 =?utf-8?B?SERtYjJUSU84QVVzTExQNzFSZnZTQmdNSG1IOFVmdHUwSEFPN3NpZXVQcjNr?=
 =?utf-8?B?VTVLdVI2akVYU0FKQXk2MDg1WmN2dlRYMGdHTU5PelUwNUZSQTRZWGg3S0JS?=
 =?utf-8?B?NHA5bjY1Umh0RUhtVXdRN2U5c3RlRDNJQ2JETlhSQ2J0cXQ3WTNSNWxBMUJz?=
 =?utf-8?B?U1FUMUxFWDgycGxJSmFxNjVNdGUwMzRBVVVFRHBPNWFUVWozVFhRY3dtVUVR?=
 =?utf-8?B?cHk5NDBSYjhCLzJneVpkWFV6YWQyMjM4cTF5dndpSFFDU2R1QWUwcjA5aVFU?=
 =?utf-8?B?K2wzTTczSmJqM012Ym9hd2dpYmJiUStNd3I4SjZjOWNjMEFHbHV3Z2c1dDhS?=
 =?utf-8?B?T1hESzkzT0h2WVpmYnBVMDRKdXVXdGRBak9jUFVhSFFCTExvbGRNQktaMVpr?=
 =?utf-8?B?SUJQMjczcmRrSEdGN0E0WEt6UHREc2RHdlNIcWFhMnNmR1J4eExyempPVlYz?=
 =?utf-8?B?dnYxSThIL3V6dTJyUmtCd1VUcXhIVGJpYkVOU1ZMbXlmY25rT1BCUFNCeDM2?=
 =?utf-8?B?M1dONEE0a2N0OHQwaXJTcTN6YjR0NXg4anVPRldIc20rWDVKaUF1bG1kRlBK?=
 =?utf-8?B?SUVucWVhM0FjQlBtTXBZSStkZXFnYzVHMkhZWW85YXpXUTJpVDVoYjVNU0ty?=
 =?utf-8?B?VkFjdVRZY3JSNXJCUnRIRXZ6azdZMGlKYnFobXJxajMxSkZZS3VEaWtMYlht?=
 =?utf-8?B?b3FiZmNXUWpoRDREY3doMUJ0QzFJbHQ2TjNuZnl1NkJUSVMrSjNva0pZOUlM?=
 =?utf-8?Q?hjiJOT00o5/9MjwOwSRXxeF4dsmmwr4xa4eb4yXHkJ6A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-9052-0-msonline-outlook-827b9.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR01MB4399.apcprd01.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: aadd2bfc-ad65-4abe-6086-08de20c04891
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2025 01:18:55.6398
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPF4E964F9E4

T24gTW9uZGF5LCBOb3ZlbWJlciAxMCwgMjAyNSA1OjU1IFBNLCBWYXNhbnQgSGVnZGUgd3JvdGU6
DQo+IFRvOiBXZWkgV2FuZyA8d2VpLncud2FuZ0Bob3RtYWlsLmNvbT47IGFsZXhAc2hhemJvdC5v
cmc7DQo+IGpnZ0BudmlkaWEuY29tOyBzdXJhdmVlLnN1dGhpa3VscGFuaXRAYW1kLmNvbTsNCj4g
dGhvbWFzLmxlbmRhY2t5QGFtZC5jb207IGpvcm9AOGJ5dGVzLm9yZw0KPiBDYzoga2V2aW4udGlh
bkBpbnRlbC5jb207IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGlvbW11QGxpc3Rz
LmxpbnV4LmRldg0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gaW9tbXUvYW1kOiBBZGQg
SU9NTVVfUFJPVF9JRSBmbGFnIGZvcg0KPiBtZW1vcnkgZW5jcnlwdGlvbg0KPiANCj4gSGkgV2Vp
LA0KPiANCj4gT24gMTEvMy8yMDI1IDc6MzAgUE0sIFdlaSBXYW5nIHdyb3RlOg0KPiA+IEludHJv
ZHVjZSB0aGUgSU9NTVVfUFJPVF9JRSBmbGFnIHRvIGFsbG93IGNhbGxlcnMgb2YNCj4gPiBpb21t
dV92MV9tYXBfcGFnZXMoKSB0byBleHBsaWNpdGx5IHJlcXVlc3QgbWVtb3J5IGVuY3J5cHRpb24g
Zm9yDQo+IHNwZWNpZmljIG1hcHBpbmdzLg0KPiA+DQo+ID4gV2l0aCBTTUUgZW5hYmxlZCwgdGhl
IEMtYml0IChlbmNyeXB0aW9uIGJpdCkgaW4gSU9NTVUgcGFnZSB0YWJsZQ0KPiA+IGVudHJpZXMg
aXMgbm93IHNldCBvbmx5IHdoZW4gSU9NTVVfUFJPVF9JRSBpcyBzcGVjaWZpZWQuIFRoaXMgcHJv
dmlkZXMNCj4gPiBmaW5lLWdyYWluZWQgY29udHJvbCBvdmVyIHdoaWNoIElPVkFzIGFyZSBlbmNy
eXB0ZWQgdGhyb3VnaCB0aGUgSU9NTVUNCj4gPiBwYWdlIHRhYmxlcy4NCj4gPg0KPiA+IEN1cnJl
bnQgUENJZSBkZXZpY2VzIGFuZCBzd2l0Y2hlcyBkbyBub3QgaW50ZXJwcmV0IHRoZSBDLWJpdCwg
c28NCj4gPiBhcHBseWluZyBpdCB0byBNTUlPIG1hcHBpbmdzIHdvdWxkIGJyZWFrIFBDSWUgcGVl
cuKAkXRv4oCRcGVlcg0KPiA+IGNvbW11bmljYXRpb24uIFVwZGF0ZSB0aGUgaW1wbGVtZW50YXRp
b24gdG8gcmVzdHJpY3QgQy1iaXQgdXNhZ2UgdG8NCj4gbm9u4oCRTU1JTyBiYWNrZWQgSU9WQXMu
DQo+IA0KPiBSaWdodC4gUXVvdGUgZnJvbSBBTUQgUHJvZ3JhbW1lcnMgTWFudWFsIFZvbDIsICJh
bnkgcGFnZXMNCj4gY29ycmVzcG9uZGluZyB0byBNTUlPIGFkZHJlc3NlcyBtdXN0IGJlIGNvbmZp
Z3VyZWQgd2l0aCB0aGUgQy1iaXQgY2xlYXIuIg0KPiANCg0KWWVzLCB0aGFua3MuDQoNCj4gPg0K
PiA+IEZpeGVzOiAyNTQzYTc4NmFhMjUgKCJpb21tdS9hbWQ6IEFsbG93IHRoZSBBTUQgSU9NTVUg
dG8gd29yayB3aXRoDQo+ID4gbWVtb3J5IGVuY3J5cHRpb24iKQ0KPiA+IFN1Z2dlc3RlZC1ieTog
SmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlhLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkg
V2FuZyA8d2VpLncud2FuZ0Bob3RtYWlsLmNvbT4NCj4gPiAtLS0+ICBkcml2ZXJzL2lvbW11L2Ft
ZC9hbWRfaW9tbXVfdHlwZXMuaCB8IDMgKystDQo+ID4gIGRyaXZlcnMvaW9tbXUvYW1kL2lvX3Bn
dGFibGUuYyAgICAgIHwgNyArKysrKy0tDQo+IA0KPiBNYXkgYmUgYXBwbHkgc2FtZSBmaXggZm9y
IGlvX3BndGFibGVfdjIuYyBhcyB3ZWxsPyAoT2YgY291cnNlIGZpbGVuYW1lDQo+IGNoYW5nZWQg
d2l0aCBnZW5lcmljIHB0IHNlcmllcykuDQoNClllcy4gSSB3YXMgdW5jZXJ0YWluIGFib3V0IHRo
ZSAxc3Qgc3RhZ2UgbWFwcGluZyBhcyBpdCBoYXMgYSB1c2FnZSBmb3INCkdWQS0+R1BBIG1hcHBp
bmdzLCBhbmQgZm9yIHRoZSB0cnVzdGVkIE1NSU8gY2FzZSwgd2UgZG8gbmVlZCB0aGUNCkMtYml0
IGFkZGVkIHRvIEdQQS4gQnV0IHNpbmNlIHZJT01NVSBpc27igJl0IHN1cHBvcnRlZCBmb3IgU05Q
IGd1ZXN0cywNCmFuZCB0aGUgdHJ1c3RlZCBNTUlPIGlzbid0IHJlYWR5IHlldCwgSSB0aGluayBp
dCBzaG91bGQgYmUgc2FmZSB0byBwcm9jZWVkDQp3aXRoIHRoaXMgbm93LiBUaGUgYWJvdmUgY29u
c2lkZXJhdGlvbiBjYW4gYmUgcmUtdmlzaXRlZCB3aGVuIHRoZSB0cnVzdGVkDQpNTUlPIGdldHMg
bGFuZGVkLg0KDQpJJ2xsIGFkZCBpdCBpbiB0aGUgbmV4dCB2ZXJzaW9uIGFuZCBzZWUgaWYgb3Ro
ZXJzIG1pZ2h0IGhhdmUgYSBkaWZmZXJlbnQNCnBlcnNwZWN0aXZlIG9uIHRoaXMuDQo=
