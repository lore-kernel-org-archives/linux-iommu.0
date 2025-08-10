Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DED522DA02
	for <iommu@lists.linux.dev>; Sun, 10 Aug 2025 07:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754809807; cv=fail; b=Y0E/iFyIFB/YN2PzzCsNwbz4wqrMAWmWCB6GYHXyQQmVFW/m3sgAfBI1aNAx1G/3KzB50JZj/o9F6Jndrpl6X6+SNCpKUXB+Y1X6EjGmSpyhvOHWf4l77L9y0NTeICiQqZU90KePMcDbyZrdQzlunhPYLkJ6iAzBWhtXPKYJ058=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754809807; c=relaxed/simple;
	bh=oRk/2+QZwLRIHLELleD6PGBL5lSNIQ+gfn6X746qf0Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QeS7q62jyRhL7TjFEQZXUSTvzzeOlBL5dtKGfNCrVp7YKQMGcKZAhBnFOI3kcDXr0jKISBvbBjM+Us7JFnfJYWPHzT0MtI2rtdx2HHPA7Uezsl26DBWGCjkzEoo4zFUGvDDL14e7hcjFghKU9ZwhjM4AtzGwukt+lsa1eX0SXL0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=ZGCVIcGR; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=dm1TCn5H; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="ZGCVIcGR";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="dm1TCn5H"
X-UUID: 054c93c275b911f0b33aeb1e7f16c2b6-20250810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oRk/2+QZwLRIHLELleD6PGBL5lSNIQ+gfn6X746qf0Q=;
	b=ZGCVIcGRHNFoWP6J402ezkrWqcmUGLEU0HSwP4EQprwc5IBttub7CNi4J8aGZ/4DBjKIKjsaYraBLzPJ1QWi4oKBLly8qQzUSjvVTCvhpfdczKyPiQ9X0NbU6oYcZoQOZ1OZotILePHoGuSCdSVquoETm0z4PGvh8lWAcmQv4MI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:5ae69949-1a7c-4c6e-97ee-d0a15f29c960,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:414845a1-1800-4e4f-b665-a3d622db32cf,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 054c93c275b911f0b33aeb1e7f16c2b6-20250810
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 366814201; Sun, 10 Aug 2025 15:09:56 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 10 Aug 2025 15:09:51 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 10 Aug 2025 15:09:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wpxiNWTYaszTILnm0w1Kd4gq2fQK2zq6poKJMy6MrB48JsoRBzFtyNTQrGCinNGQslv6w444jVtxXY+NDknkGi7mT8uB/obk5L+nVlB5bNr0Ru5hi14rMV0Af4v9UihTDqcEvrNJFFa/nJXJiZjJnKwEzO5Sr1iicVNmbQYHDZM0k67Pz4bwJ99Ne0HWsIiSgkodAcawlL2MYG3HejeNL4J3iXH2sanUdD3CEvkvh2MpWtCSXujbXtbAYcfETNyxztW3sRhjZP0t8q/dr1aiJdkaI2BB4I/uDDl0S7+NOL7ihqqB0OV5HC3sxy4PG4onvdDZvRgkLgMqF7O/D5xYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRk/2+QZwLRIHLELleD6PGBL5lSNIQ+gfn6X746qf0Q=;
 b=ZwhIlPPts9xj/ECjDWfPdcViGcZFT8k5IzPaFrK6tq1DgA3hUntKN/pTZ36qfh0TOlkn08XX9VzCyUptZ6Qol1I8XOgmnOl0G0cbl+Uhdg/lJDW6VSZntd6rifRboZiJnAMwqeBAU65PCLPEqrqWcAK+1pGpAdwFOfscbCGl3MQCKd2spb6/6fEJVT8h+jzzvijaFOS2pzjHDa4josDyXJcSuWlwHHAOqBKayu0O5QlTTdDOa3SNosYfvZN9+ilUCMnDD5Zz7lrwjZlaqpddcl9tnRYCpn9L9OcZHJag4KcL28JIB41DZuKNWf2QiWhWtrw1qZqmTD6sRWxOZOEImg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRk/2+QZwLRIHLELleD6PGBL5lSNIQ+gfn6X746qf0Q=;
 b=dm1TCn5H2pdDUYZPPTT7R6PSJMFOt5mi5gv48fIGrkd+OsVBlqQJQoKUx/qyPyD6L8zdGB27GpbVV8d/0b51YWTvTJX2HRtoc0VYPPVF71WEq7HVNcu6ZbmauKaIxE+hqVsI9ENxlZZCKCrM4dq8buRmsdj2/6XRjyVk7AyWNdI=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYSPR03MB7911.apcprd03.prod.outlook.com (2603:1096:400:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:09:53 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:09:53 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH 3/3] iommu/mediatek: Add support for mt8189
Thread-Topic: [PATCH 3/3] iommu/mediatek: Add support for mt8189
Thread-Index: AQHcB4IDePHUpVqALUWTTn7vYTlaurRbfIQA
Date: Sun, 10 Aug 2025 07:09:53 +0000
Message-ID: <7a2105e50f9543c4bd97c9d51aa09baaa3b72ed2.camel@mediatek.com>
References: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
	 <20250807095756.11840-4-zhengnan.chen@mediatek.com>
In-Reply-To: <20250807095756.11840-4-zhengnan.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYSPR03MB7911:EE_
x-ms-office365-filtering-correlation-id: 07bafcf2-06fa-4a71-b76e-08ddd7dce755
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?UDZQU3ozckpkRjRIMW5UcDdrbGk2ejBsWHg4dmo5ZktjN0pqZXpGU2RyQ1ht?=
 =?utf-8?B?R1preXYzNmNyU2ZwSlBCdVdYL3NZMEVKd011RlZUc0RsM0NPbjBYd2xhU3h0?=
 =?utf-8?B?SVNnNEZYWVoweng4dXUzMkFZakdWcnpwTUxySHVrc0VFWG05RFl4N2UxelRI?=
 =?utf-8?B?UGxRVVdtVXI0Si83VS83cnQ5cTdvV3dHaTJKTEx1UEEzMjdmTGhxcjNwZmpn?=
 =?utf-8?B?UkcybFlyVHJPdmk5UVZKN0YyWmVvWUtpa21PVWRxL0RISmg0SklEbE41SnVp?=
 =?utf-8?B?VlB0WXNEVktkYURPN3lwSWgwcmpRT0ZPZkRYYUVjUHMwTTdTRWpBVlJETjZl?=
 =?utf-8?B?V2F4Ny9qeS9pTmZNdzZ2VkVpQU96WSt6d25LaSsxZmlOMnlFSXowaWpuUWta?=
 =?utf-8?B?VjZnSUlSR1pVak8yZzhkRk9FVmFmZzRKMGhuOHl0SlBTaTZWczhsUHFqbjl5?=
 =?utf-8?B?WE5ha0FPc1pXUHJqTUQvNnFhUGF5bHJTWGdxN3FOMnZSWmVTbjlhWFpkMVhv?=
 =?utf-8?B?anZucjR1bUlCWW1ieVdQNGFsOHFCL0tmdytsaklPTWY5WDdYcGZmMjV3RzB0?=
 =?utf-8?B?QnBsL0RxMlBsU2xzYVd0THljZnF2R0lWRFpicnY4MzFzOUE2VzZzVzNadTJS?=
 =?utf-8?B?TUZ5K3hMV0c1cncxS3FmTXpDWDRNNFgwVmhtZEwrUG9WL3d0N0VyTTh5M1pq?=
 =?utf-8?B?ZnRXZmZEYncrbkR4aTJtbytpMzRRYnN2QVBSSHJOVUF5RnhMaWVqUXg1Tjdq?=
 =?utf-8?B?WStNc3F5endvcUhqWlF6UWptb3Vxb3ptVEFQM2NCY2F5YklBYklEcG1xSkpr?=
 =?utf-8?B?S2dPanVXME5oRnhxaUdMUUJtQWJuZ2JQM1FPaGpRZFdMVmQ2QUczUG82d3c1?=
 =?utf-8?B?UW9qQjFFN1VzbDFaSU00ODdvU0ZCTTd1bGlMclhuL0oyYXlaUXdTZmRkVThM?=
 =?utf-8?B?b2FFaTVDRXJwakwxMVhoa3F4R0V6SzJNWnpSOWduZ0xKR0xQUVhFZEZlZXRj?=
 =?utf-8?B?Wm9ncVFsMmtLMkllQzU0bGJtS2swNzdKOHducFBtUmRGYkNDbFFCdGlLR25R?=
 =?utf-8?B?MFhuc1dINTgzdmRrNXdNcDNxb2lqR1RiVVdBdXJINlgyR08ydG5ad2dIQW9E?=
 =?utf-8?B?d29XZ2tWZ2FveUVoakNDbHIxODhubk1iZTBVczNJZFlIdjhqeVRNbk1BcEFp?=
 =?utf-8?B?MllKSm1wQzc4TGtZeWk1UjliT0ZzeFlpMk9jV3FkL3YwN09neXkwNHQvV09q?=
 =?utf-8?B?WmxVdEJpYk9IOXIrV0ZzL2UyM29ucHBEeE92aXg2K3BiZXdnZGRHRlRZNjV1?=
 =?utf-8?B?NXlrcTZxLyttNExaK0xoMjhmcmRiejF2aDhiV2F1TDFzNkVsclhjdm1ZOXZu?=
 =?utf-8?B?SmNITGNrVDJsVHp0ai9vcHdGcmtKdHMrdUpqTXdiaEE4a0ExSkhQNkVHWTZk?=
 =?utf-8?B?LzBZbmVKWmYvczd1UDNISEs0cEhIdC9uQSt6aG9TWEUrbWdTYUUxZXpHeGVH?=
 =?utf-8?B?SlZWNkFDMTFqT01NVmRLb2dVWkt4QmRVWlJIZ3Z1ejVwSmxmWUR1Tmx3OTZH?=
 =?utf-8?B?cGF1RFY5SXpZdFFpNXJvQU9WdVAyRjZIV2hjNE90WENGbklMQjN0d0d2dHdj?=
 =?utf-8?B?Nlk4ZG5SZDFYU21PRXNjMDVRYlNIVHlBMnQvVHU0VWFWYjlKbS9SVmREcXVJ?=
 =?utf-8?B?bkRjMnpLd08vK2pZQkw1QUhZZ2kyTG1ZLy9RcGxBR2hJV0FOR2dsYUhmdkRq?=
 =?utf-8?B?Z2RPOEwwQUhVSkp5VzZicDMxYjRnZ04wMGJWVEdjQXVPczhINkRxNXVYY0xU?=
 =?utf-8?B?OXNqazV3V1VDemticVB0VUF5WTBjR2dlNzhEUHIwNWhlZ1VZMnd0V2k4UHhi?=
 =?utf-8?B?NGpGcmFpRE81Y3d5am90Z0dDblAzZlhOZVRudmNONXhmQ0RuUmt3QUZvZENq?=
 =?utf-8?B?WVhUYURBMjVndDdReERCeFhNZzMrdi95SlhnVkowS1Jpb3NJR1hHNGlzNUxo?=
 =?utf-8?B?b2tldWlmZEdRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZUNOeEkyMDV3Vm5aZG92QThVL1NQWFYxZk43NWpia0V5WVVsM2NieFRZaVEz?=
 =?utf-8?B?d2pnR1F2OERyMCtZNXc4RVh4ODRWenI2TWdZMjlhTmphSG1nOWlERitvQ3ZR?=
 =?utf-8?B?YS9JVEpCWWg2SkxDbm92bkxXaXRuVFpzcXhVZnZ1ZkdianI4YlY2R3ZwZEJ0?=
 =?utf-8?B?a09MV0hmdmhUeFN2S0dpWU9EL2Y2WjIzRnFZUVo0TlE2RTcrWjdRVlRndlE2?=
 =?utf-8?B?RVk4SW5mVFNBbjB2UWtWMHhxZXgwQmZjS2FLSkhwb1g5NVo3YXkzejlLMEt0?=
 =?utf-8?B?UHNad0lNU0dyR0szUHJyNHFYYjRLVDU3eHFrMEVqYVNsa1dETUxRQVZQV00y?=
 =?utf-8?B?UG02K3lpU1J2OGl5djdROWdUeWovQzBoYXVPL2YvQ3V2blRhNGM5dnJwajlN?=
 =?utf-8?B?a3h2NVQ0TUxBdFRZdjFEWThVVWxEQU14c2V4V2VYa1BScmxxSVEwYmtERnJF?=
 =?utf-8?B?cVFUai94OXlUdU4rSDR2c0pLNGVJOWVYdEozbFlmMjNucDhWQVRvQUhQWTh2?=
 =?utf-8?B?YnozdEsyc1ozZmxaaVdvQjFtcjdoc2xvWndxZmgxMFB1MmN2aXNTTHdOMlhz?=
 =?utf-8?B?eDVqQ2VZL3dYKzE1NW5PWWFmSTJHQmN5bXJZb2xianFOdDVEMEpCeGNuUUZj?=
 =?utf-8?B?QjE2QVlyQlBwRzEvcjAwK3pEYzJFZDVSNHN2T3N6UkliMld3R0RBelNjWjYy?=
 =?utf-8?B?UmhESHlvRGVKVGxDWUdUWlo2Q25sTXZtL016eHg4NmZXc1h6aTE4WkVKZUd0?=
 =?utf-8?B?cThOd21IaXREdit3MUh3RitaejhRaVl6TWdONGR3dnBHa1lCbHBnekpHUjdC?=
 =?utf-8?B?ZWNLdjVma2RQY2NxTVhRVTJZUlVLaEM1aVpnclBvNU82UnRReHRJVGI5Rkox?=
 =?utf-8?B?RFQzYkF1WFdmUjdDNW41NFVoWE41blQyNVlMVkZHbnRJejBQVzkrT016NDF4?=
 =?utf-8?B?ekN3bHJoVTBGS3RMQU92emY0NUQ5VDZxcmF3YUpWekdtdFlRQTh1c2VUdEZi?=
 =?utf-8?B?WWU0US9La25HSkhJdFNTS1Z0b2FpWWkxYVZPbWNMdVI0RGNveHYreVdKYkYy?=
 =?utf-8?B?T2NmMWlnSjdSbVcvc2FqcW5IVEpBbEdmdDdOMkVHd3RWRkxKeEJxTE9oQTlB?=
 =?utf-8?B?MGFFOWNtRDdFckcwNVZDTUN6RURZOGxPaTBQS00yQ01SN2ZXazFpcGNKTS84?=
 =?utf-8?B?dXNHdWpsYTQxbm83cDQrZkpBWU9xVzFZdUcydHBsdExVL2dyRVZIMTlnS0tX?=
 =?utf-8?B?MmJBVy95bGlWS0V6SVNRZWx3Z1FVNE1nUWo4NlIvUVBuVVhReExKUHVLTFhx?=
 =?utf-8?B?QnY0K1p3a055bUtha3lsSjUvY3I1TDdLWnVPWmNub0duTUt5Y0RKTUd5Z0dX?=
 =?utf-8?B?VmJ1L0pQMzZVc2NPYkNVeG9OYk1aYjNjV3lHdUJUTHNiam5kR2J4dzJvUXF3?=
 =?utf-8?B?TmI3Z2xxc0JFcVh4Y01TNStrRUxDTElFd2ZJeDR6TjlWYXp5OUN0Z3FDYlJy?=
 =?utf-8?B?dkVqOVhmSUxHdDh1NFk1SkpKL0xZVFFWN2YwSWZ5cDRlQU5BTmIrVUFJMnky?=
 =?utf-8?B?dkluVTQ5eWs1NEFrczE2NXdIQXcrM080aWtUOGRNTWpGUENTcDBVMzJ3WTNr?=
 =?utf-8?B?cU51SzNVdExZeW9SM1ZnTXh0SnlTWi9vbTFObENJbDQyTElHWTl0MVJHWTdt?=
 =?utf-8?B?c0dOQXRIS3M1ZCtWZzQ2RTZydlgybE5tUEpqeWdteTJ2QWdxblhXOW5YRGVO?=
 =?utf-8?B?YTVndnVWZUcxbGFVU3I3Sk85Z1ZuVHNYYkgvaG9kZ3JId0xlL1dlT3NHVkxR?=
 =?utf-8?B?b1FUN2xyNGZvY2VBbk5FVW1SOUYyTWh2N0F5VGQ1d1c2WDFtM3c5bktHZ3Q0?=
 =?utf-8?B?Q3V1ck1aNS8vbTA0SG5LK1R2N3Z4bXJyQlZwQUdCbmhMT0YxY2tiTWMwY0tJ?=
 =?utf-8?B?TXF4bXZNT205cm0wUG9nM1JTY00rcEFNMW9oY3AvNXcwTDBZMUlQM3NCRUZj?=
 =?utf-8?B?VHNPUkV5VERaaXdSSjkraXFhV3pkUWpHdmZvdWxnOHRNNStNMURHRFRwbXZJ?=
 =?utf-8?B?MDFlVnJtWnZTM2djb21qYlYyL055Qyt3M2ExemJSb1MxaUFWMSsxeDhGcmhB?=
 =?utf-8?Q?FOM3E/yONqCq11xScHfzMvqow?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9FA5A87E933BF04A97C9453D506FCA95@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07bafcf2-06fa-4a71-b76e-08ddd7dce755
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2025 07:09:53.0330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pI7X9VzkXgRcSOi3MOZi5FZ76i005XVO7w0Nb+6014CGa1EJCu4YfGFGfZHCk2yUeW77TqHwfuqrsLVEoNgdbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7911
X-MTK: N

T24gVGh1LCAyMDI1LTA4LTA3IGF0IDE3OjU3ICswODAwLCB6aGVuZ25hbiBjaGVuIHdyb3RlOg0K
PiBGcm9tOiAiemhlbmduYW4gY2hlbiIgPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiAN
Cj4gQWRkIHN1cHBvcnQgZm9yIG10ODE4OSBJTkZSQSAmIEFQVSAmIE1NIElPTU1Vcy4NCj4gDQo+
IFNpZ25lZC1vZmYtYnk6IHpoZW5nbmFuIGNoZW4gPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29t
Pg0KDQpTcGxpdHRpbmcgdGhpcyBpbnRvIHRocmVlIHBhdGNoZXMoYXB1L21tL2luZnJhKSBtYXkg
bWFrZSB0aGUgcGF0Y2ggbW9yZQ0KcmVhZGFibGUuDQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11
L210a19pb21tdS5jIHwgNzYNCj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNzYgaW5zZXJ0aW9ucygrKQ0KPiANCg0KW3NuaXBdDQoN
Cj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10ODE4OV9k
YXRhX21tID0gew0KPiArCS5tNHVfcGxhdAk9IE00VV9NVDgxODksDQo+ICsJLmZsYWdzCQk9IEhB
U19CQ0xLIHwgSEFTX1NVQl9DT01NXzNCSVRTIHwNCj4gT1VUX09SREVSX1dSX0VOIHwNCj4gKwkJ
CSAgV1JfVEhST1RfRU4gfCBJT1ZBXzM0X0VOIHwgTVRLX0lPTU1VX1RZUEVfTU0NCj4gfA0KPiAr
CQkJICBQR1RBQkxFX1BBXzM1X0VOIHwgRExfV0lUSF9NVUxUSV9MQVJCLA0KPiArCS5od19saXN0
CT0gJm00dWxpc3QsDQo+ICsJLmludl9zZWxfcmVnCT0gUkVHX01NVV9JTlZfU0VMX0dFTjIsDQo+
ICsJLmJhbmtzX251bQk9IDUsDQo+ICsJLmJhbmtzX2VuYWJsZQk9IHt0cnVlLCBmYWxzZSwgZmFs
c2UsIGZhbHNlLCB0cnVlfSwNCj4gKwkuaW92YV9yZWdpb24JPSBtdDgxOTJfbXVsdGlfZG9tLA0K
PiArCS5pb3ZhX3JlZ2lvbl9ucgk9IEFSUkFZX1NJWkUobXQ4MTkyX211bHRpX2RvbSksDQo+ICsJ
LmlvdmFfcmVnaW9uX2xhcmJfbXNrID0gbXQ4MTg5X2xhcmJfcmVnaW9uX21zaywNCj4gKwkubGFy
YmlkX3JlbWFwCT0ge3swfSwgezF9LCB7MjEvKkdDRV9EKi8sIDIxLypHQ0VfTSovLCAyfSwNCg0K
VGFrZSBjYXJlIHRoZSBmb3JtYXQsIEFkZCBzcGFjZSBhZnRlciAnLyonDQoNCj4gKwkJCSAgIHsx
OSwgMjAsIDksIDExfSwgezd9LCB7NH0sDQo+ICsJCQkgICB7MTMsIDE3fSwgezE0LCAxNn19LA0K
PiArfTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBtdGtfaW9tbXVfcGxhdF9kYXRhIG10
ODE5Ml9kYXRhID0gew0KPiAgCS5tNHVfcGxhdCAgICAgICA9IE00VV9NVDgxOTIsDQo+ICAJLmZs
YWdzICAgICAgICAgID0gSEFTX0JDTEsgfCBIQVNfU1VCX0NPTU1fMkJJVFMgfA0KPiBPVVRfT1JE
RVJfV1JfRU4gfA0KPiBAQCAtMTgyNiw2ICsxODk5LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBv
Zl9kZXZpY2VfaWQNCj4gbXRrX2lvbW11X29mX2lkc1tdID0gew0KPiAgCXsgLmNvbXBhdGlibGUg
PSAibWVkaWF0ZWssbXQ4MTg4LWlvbW11LWluZnJhIiwgLmRhdGEgPQ0KPiAmbXQ4MTg4X2RhdGFf
aW5mcmF9LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWlvbW11LXZkbyIs
ICAgLmRhdGEgPQ0KPiAmbXQ4MTg4X2RhdGFfdmRvfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10ODE4OC1pb21tdS12cHAiLCAgIC5kYXRhID0NCj4gJm10ODE4OF9kYXRhX3ZwcH0s
DQo+ICsJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxtdDgxODktaW9tbXUtYXB1IiwgICAuZGF0
YSA9DQo+ICZtdDgxODlfZGF0YV9hcHV9LA0KPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWss
bXQ4MTg5LWlvbW11LWluZnJhIiwgLmRhdGEgPQ0KPiAmbXQ4MTg5X2RhdGFfaW5mcmF9LA0KPiAr
CXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg5LWlvbW11LW1tIiwgICAgLmRhdGEgPQ0K
PiAmbXQ4MTg5X2RhdGFfbW19LA0KPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTky
LW00dSIsIC5kYXRhID0gJm10ODE5Ml9kYXRhfSwNCj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlh
dGVrLG10ODE5NS1pb21tdS1pbmZyYSIsIC5kYXRhID0NCj4gJm10ODE5NV9kYXRhX2luZnJhfSwN
Cj4gIAl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE5NS1pb21tdS12ZG8iLCAgIC5kYXRh
ID0NCj4gJm10ODE5NV9kYXRhX3Zkb30sDQo=
