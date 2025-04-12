Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A4917E473
	for <iommu@lists.linux.dev>; Sat, 12 Apr 2025 07:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744442018; cv=fail; b=ArRMqJDCk57RpgpSJQ3G5I57RpRbq6eayv2KtyzL0nXGPxW/GyuFQVnOZ3wCv5NkZTUSDSiJu2G8m2+APoYIm13I2VbXCDgNmU/F/J+MS2bSPucdaL89ru6XEYQ6knlXCqA6ysqGym+etTwb67DBlcIjrpc1fFuTszMjj/KTSfw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744442018; c=relaxed/simple;
	bh=d/HlhCzD1/aoxrWXkfhVYicodsUu0mfwA4W0FDWCDnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RB/AjQQmCMFHJOSjjFnPmFV5YmOZtoo7Cf7tsBCnHsjJYVvzeJDJ6tPNE0VtmnGmveHtSFvNgkLWpfmFZ93VIZIyl45MC4kYtbcGDia1j/2vKH1nlA/6XDg9bAHd5piu0WxM9458TZwRpmd3OwcR0tWn1a3vpJPN92bpzczcMaQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OXtbElK6; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=p0Yatvxq; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OXtbElK6";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="p0Yatvxq"
X-UUID: 9fc684c6176d11f08eb9c36241bbb6fb-20250412
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=d/HlhCzD1/aoxrWXkfhVYicodsUu0mfwA4W0FDWCDnw=;
	b=OXtbElK6KfySwK8LJt5sUIWcCXdNcps2Tw7BSmSjOPfZdIdfs/mo99WhE3JHYLhlYx3/CDU53dLXqXBgOJY5JW5tuDVKpk5i2DQ2zyY94vYiAkvni5OgKDIrgNPJdutDZ0z0g2RpsRTKytFv/Gv4/HVfvHYbgvqWX/7pkwOvkoM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:084e8b39-2615-4fe1-8966-e05fbcf574f0,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:91d7848d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 9fc684c6176d11f08eb9c36241bbb6fb-20250412
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1472649485; Sat, 12 Apr 2025 15:13:24 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 12 Apr 2025 15:13:23 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 12 Apr 2025 15:13:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWPbZe8Hr8/gIprUUZ2h0irBa1MNaieiZPYyePv5dGirMxW708OaNi7p6soKsHaQ+REP3VpwRMNVjkFleNj1jg5/K/LYaeVKiZD6b6XFG1kbT2a951rgB+BBUtoKsXC9shyleI7UToYtQeNuUvjks99EkxR1ropVU4Dv5pLpwEkRnel67oYSaJE+kfJhIpN7HiUF1fW09jO+alJAcXgUykHL67gOKGkXRsGF/FPOy+YwCgFo2oefKe9PpfuqIvAR+AYyv5p7G1rDTEZQ185mlHcL/J3TPhGgeBjHIWYWuqTfOeTfieeDXjx90pFfLoul6xIL/WNZPEHcD6YMPhgpjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/HlhCzD1/aoxrWXkfhVYicodsUu0mfwA4W0FDWCDnw=;
 b=nK4rd6vzIZNb5Hd0I3KUBiR5etToZctM0UqrhiRfNvDxBmOdbrqyz0r3B2fi+e0usQTHIwRqQod1zfGuJBfM3Fw3MQ5E7QpH494RiHtOt77NhPuOcEEWK4AF42x0LytaHsKnsppYxAvtd6WXzkgKdnRqmg3kilmcjQRyn8a/JI1D39RDAPq/311FecdIKPhlmhzkCI5cC6rvVCmfpwlm6Nccm/GV8MfWgjH9surPfoZGHP/8tAt666EHdYYlAqGNACut8/4BhCWgXbnfloTqBM/Tq2NGS60p1kaGP0lmPpCC2GPlx1uIyyo3uA7jzcUZC7F1zStA1gxZvSPNs+4w9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/HlhCzD1/aoxrWXkfhVYicodsUu0mfwA4W0FDWCDnw=;
 b=p0YatvxqRXt8zOClGs6UNAkmuBWx1mXuO2DtnglWSPQ/J2rERwv7QyGG0cn8bwvVscjBJo7KgiTZPo8j6nPztjyCK1I3sTGkJuCVMo/0Bv+cmJdVup8Oru45Y7vPOw//3tXIfQ6OGfZjiBXihh8Q2XCeoCUuGJeQJr3I7pnwQUk=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEZPR03MB6596.apcprd03.prod.outlook.com (2603:1096:101:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.23; Sat, 12 Apr 2025 07:13:21 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%5]) with mapi id 15.20.8632.025; Sat, 12 Apr 2025
 07:13:21 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"kernel@collabora.com" <kernel@collabora.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH v1 2/2] iommu/mediatek: Add support for Dimensity 1200
 MT6893 MM IOMMU
Thread-Topic: [PATCH v1 2/2] iommu/mediatek: Add support for Dimensity 1200
 MT6893 MM IOMMU
Thread-Index: AQHbqiarQPyLOV0TK0CwfOLW7l2BYLOfoG8A
Date: Sat, 12 Apr 2025 07:13:21 +0000
Message-ID: <b87ee4066ae403826f43eace44be542c0a00755d.camel@mediatek.com>
References: <20250410144008.475888-1-angelogioacchino.delregno@collabora.com>
	 <20250410144008.475888-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20250410144008.475888-3-angelogioacchino.delregno@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEZPR03MB6596:EE_
x-ms-office365-filtering-correlation-id: ef5cb788-e26e-43b2-bece-08dd799181cd
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|1800799024|376014|7053199007|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?YUhRYmRoc0ZwTjRJYVJkRmhQYWxSY1dQVmtPZUMxMnNmZXlnUVZENlVYQStl?=
 =?utf-8?B?dGllcUVGbmliSlJoZWdvV21OOVg3aDU4dHdwNktiSjMzeG90REJPVHgvK3h0?=
 =?utf-8?B?ME5VU3hHaTgyb3lMTUNMREJjZXVFaS9IUFdNa3lzQmRzdy9kREVMbS8vaWcz?=
 =?utf-8?B?ZytpaDdjTGEySlZGTjhxVUIrOFJ0OFNDdGJHblpHY0szK2pPMzNRdWpLeTZ6?=
 =?utf-8?B?c3RXSVpPME4wU2srelk5ZFk4bkNtWW9qQnZqSGs1NE00eWRId0xUYnBkVXh6?=
 =?utf-8?B?Nk9WTEhMVHZDaVhjdThPSDlhL1gwV2JESHN5ZllScDRqYjJWa1VQVWY0Rkdr?=
 =?utf-8?B?YldPVFk4WW1JeXJERUJBRXdsM2hIM0Jjd0p2T1VFR2xIdUhpR2Nxa3ZzTjlY?=
 =?utf-8?B?V0ptdlVlME9QSnlZNlZYd21WbUt4aEtLOTRRZ2ZOR2dzb2o1SlhzaTBkbG1E?=
 =?utf-8?B?QnFpSFpJeVlQOFNvb0JOcEJueHRVVHIvWmpMSkxtZ3g1VkNDajlIUHZjaTNm?=
 =?utf-8?B?OFVraGhIcGM5OExzUjRxYWg0d0t1Zk1rQmpzVEkwWW1IUitEbEcwUmR5NXRR?=
 =?utf-8?B?V1FBNmhTcnY4OTBiS3VzUndIcDBka3U5Nkptd1U0QkxOQzFJOVZaRlNXZUtv?=
 =?utf-8?B?UCsxNHZKZmgydGptS3VVMU1JRjdRQ1pVNnpHRGwvZFpnbkZ4VlVuSGM3T0xs?=
 =?utf-8?B?cVNBSnRQK2MxaUxSNmlTZlhEbEhaQTFhSE9oazFBdzRzb21nY3JKalJPVTll?=
 =?utf-8?B?ckNIVkcyL3B5Y2NwOVp0LzdTcmtSZDNpeVFkUGxFTjdzeC9BcVBVZ3dDQWJS?=
 =?utf-8?B?SVdBd1NNRDRkZFRxN0YvUUIxRGZjT24zQkoxTXZKNG9DVVYzQmJHQ05tMDBn?=
 =?utf-8?B?ckI1cGtMNVcrdW9UWXh5QjBySmdiWXdNL1c0TzF4U1pZWEdXbHM5dTh5cUl2?=
 =?utf-8?B?T01Mblp3QVBvZlJJcld0U0EyWEVWR0M5Z0R1NDZ6akIralY3aFlkQUZYTkcv?=
 =?utf-8?B?REYrZlVuZWlqRkxOOWUzc21zVVF6SkhxR0RPY1k3R3VOOFhKY2F5Z2Qzd2VT?=
 =?utf-8?B?b1IxeUN5ZVVBVVp3Zi9UUVBXdENrZVhIOHFZamFRMGtjbWREeDdTalFOd2Rm?=
 =?utf-8?B?ODNoOVFKeEZWcHRtY2syYVY0d0JFWHFaRmJ4Ulc3U255VkdmTjF6ampxdlJq?=
 =?utf-8?B?UkhiME1VQzBETUdwV2J6ek9vUmNjT2E2Y0Z5dWQ5K1ZTV2lGcmVMU0JBSG9S?=
 =?utf-8?B?Q01kUUViZmpWN2lBblg5bW0rd0JDbVRkOFlqUGJoTGd0QlpXYVN1UjBFajBp?=
 =?utf-8?B?Tm0ycnlKN2Zud0U2Tk1TOHhGZWQ4MFFNalNvWE5IbzhpK1NJMW02R2NzekFP?=
 =?utf-8?B?cWt4dUhmTFVZYnFZaHRMcW5LOUtYWmhmeFNpZlAxL0lsaDJ3RDE5VklyUGM0?=
 =?utf-8?B?cEN2bnVYcXQ0ZU13eVkrNmdlZ0ZZN1o0SkxpZG90Nmd0T3FiZHpOUjJRb3p3?=
 =?utf-8?B?UnFIN0RRSlA1RERKVkpjR0IwSlVsa1NhbEJNUGludHVVZEYyTTJrVlg4Q0Uz?=
 =?utf-8?B?V1JMQlViR2JoSFRBU2NwTGV1dDgyeHBqZXJYa240cWRUL2RKWEFRZEdMUjR3?=
 =?utf-8?B?WVR0UXlNcnZsVWxhQlJLRFc4NFAvb0RTVUp1VXgvY3lYb2cxTGF0bDM1ME95?=
 =?utf-8?B?TWpIM0F1UmxSL3dpaFEyb2d6TGlUWWNmNzN1NnAzd3Y5ME9zTzJ3TXgzRlpQ?=
 =?utf-8?B?T3BFSlZMc0EwS1RTanRuczBBcEo5MHFwODNxZ3ZZNDRUandJSzdBZ1lsZHRi?=
 =?utf-8?B?QW5pVXMvWlh6TzZtZjhweEZ5Vmx3a3VPNitsa0dFRlAwM3o5Y3NMcUUrQzNt?=
 =?utf-8?B?cjFCZmNJZGdNdTNmUEp4VjBpV3hRNXprb0ZacUJTQmY1Vlk2amQzblorRFI5?=
 =?utf-8?B?OFNtTGp2TGkyR0piR3JFL1pPalIyUW81TDJiamFBVmIxODJGOEw2N2VlU1hS?=
 =?utf-8?Q?JJ36/k3kVS+dBYc2ukj6wr7kwCeZCI=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(1800799024)(376014)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NlFhd2tKMk1NeHNpcTBqbkpVQ2s3OVIrblVjY1l0RXhoNkpnTFdFWHdhNGN4?=
 =?utf-8?B?U1NEY0ZGdXVNU2NQVzZBMEFmQU9MS3RrU3JNcldrK2lvbUxwdTBHTkhhWVFm?=
 =?utf-8?B?QWJKRk15RXRKTG9XWlNha005dVhDQWprVVhTNVpnT3J4ZlhwUzJJQk1zTjNn?=
 =?utf-8?B?dnkxM0MwZDhOcG9VMC90MGd3R21YSTdGZHJLQkdGV01lN1V3SGMwRyt6aU43?=
 =?utf-8?B?b1F0NWp0aXhoN1lGN1lSM1F1emxWb0FZNVJwSit2WkhWUnpRc3YzbVNYaE5P?=
 =?utf-8?B?N3hzQ25UZnBOYVpKZWxQMmNJRzZ1bXBqbmtXYituM29Bdm9SVWJ3Qkw2NXRl?=
 =?utf-8?B?NldiVVQ2QXU0USs1am5pREtVL0RoYXZzZ3FUSVEvREphbFFtejNYL3lwVVcz?=
 =?utf-8?B?MTFiR2RSMDlnd2poaEdtOFRGbG52VzE4anVibmY0eTZCQTFOcVBtRjNkZEs5?=
 =?utf-8?B?Q1lFZTN2V2pKeXBGdnpOZkQrZHNyOVhYL3Rqelk5UzFBcWdhMFA5ckk4ODE3?=
 =?utf-8?B?N2JaOGVaYytUSEppRXl4M1Z0LzJQOXVCWXBmZzd5USt4K05KNm1za1doV3B2?=
 =?utf-8?B?bit4Wk9MMjNoSzYwRTNQYU9CNkhqODBuZ0d1TE45Q254V2dsM1NnbjNGYVBE?=
 =?utf-8?B?UlhJVUNONm5USllyN0VVYVVBZ2dMRnNwMXdoejBBSDAvbmVEYlFobEZGVXhN?=
 =?utf-8?B?Q28wUU03SWkvWHY4V2ZtcWJ2VFR6Nm9uZEoxU0JEbysreTZCd3ZHeGdFQ1hV?=
 =?utf-8?B?WVUzUDcweXhWaHFpNlJ4cVZ0YmNzZkJ1RFlBYTZhb3FHVDVhREUrM0twRHNp?=
 =?utf-8?B?ck5idVY5amEwZmkxS094b0JyOUExcjhFSGpsVWZxNVl1OG5ka29WaXRYcnhh?=
 =?utf-8?B?TEF2cFl2eHpHNVF3UUl0bjI5U3hmR3VISUJmOFRJZUdpL01mSXQ0K20weUZw?=
 =?utf-8?B?Wkxmc0x4OFRMRk1yS0plU0xyVEhmbVgyUXVDSnhpdHpCZEQxSFVFYlh2UHU4?=
 =?utf-8?B?N1NGeUxlcHhJZ0pOTlQxVkQyZVpjVWZMNDNSYlZUWHY0eG1McUxZNEhObkFP?=
 =?utf-8?B?VHB0R0dJWEVnRGovODh0ZDVWT2N4ZEFWejB2VmxZSGw5THBnVHVIbzZyOGp5?=
 =?utf-8?B?cTlXcFZXbG1ydEpCS3ZmR3IrTWZHcWNSUnc2OU1sZ2FSUmxHT3Z2cXQ1VmlE?=
 =?utf-8?B?WFBKeWViZGFVdWZFcjRHK09WdDJVWDNxajZGN2tpKytqWkQrUHN6UVQ5cVhO?=
 =?utf-8?B?cXFuZzQ3ZHVWSFZCYU5ITnNLdVAxZWFFbGNMWkpYVk9lMFl1emE1V01qc3ln?=
 =?utf-8?B?Z3FCVzBydFZSRC9hSWZxb0VDbjNMRTRSMjhhY1poU1BRMGpOV2R2VHVUWlVw?=
 =?utf-8?B?cXoxWk8wRFYzVFhTVmtLbXE4L25zbUtyK0d4dGNwV3FRMHE3c2FRS2JBWHV5?=
 =?utf-8?B?d0V0L2g0V2M4RGNqbjZCMnpHMHFzMWp6Ni9NTFhNY2NHVXZSQnFhSjVQSjBz?=
 =?utf-8?B?Z3BkOXVIV1R6dVdLWHh4YXNOVDk0MnN0OEU0WWVxN2lXR1MrZEs1ays3NXVw?=
 =?utf-8?B?WGg0VHc4K0l6bHQ5RkZLLzFvT2tlUDdQZDZXeEo5M0pkVTFkNVQvNk9iUkpI?=
 =?utf-8?B?bXV3MnViYng4bXVJUnN2MG1LTnZiWnhmNllNMUR3ejF6U0NHNHp3TEM4QVpK?=
 =?utf-8?B?djBQRjh4c2ZiLytWdjJiY1hWSHUrRU5JeWk4b091ZjU2V29WZW11eDhFYm92?=
 =?utf-8?B?d3ZET3phZVZzNkpSemxLK2VIaTZ3emZiK2JXRzJrUXNrZmdNdHVNcnlYNW5Q?=
 =?utf-8?B?M3E3Y3RFL1lDWE1vTXN0bGwxL0tmOWVtT2NjQnV1azdHYzk4bmFaOU9hajkv?=
 =?utf-8?B?MzVQRW1lekdQN1g2TUhZajgwYU1QMTJKN0U4OGlEQ2lwb0RBNE9hdmZxSWZV?=
 =?utf-8?B?UFFQczlzbFZ6SlE1THU5Y3JlenNuT2ttYW56cG1BdXVnbjN0bmMyUFRHN2t1?=
 =?utf-8?B?WTdPdit6cmlKOExYZFJZU2NkN2RLMnVsdDZLUkpXRVRFUitjZlBuUVlDRk1S?=
 =?utf-8?B?djkzYW9HUGc5cVgxZFpNbHp2VUp6aU44dXI2RU1xeTdzYytIdWVnTCtLODhh?=
 =?utf-8?Q?zO/vghK4GCq8l5PKOOBmwwq8W?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9DA31E9E262B104C852C20E98068D631@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5cb788-e26e-43b2-bece-08dd799181cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Apr 2025 07:13:21.1076
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YCyxQMS1bHi6NRlQwd2tpjgEn01FeL3xikNr/IcwV4yZz2o88tdHvQcr2TD5KxGiX47paczm8+jWkAa6q638PA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB6596
X-MTK: N

T24gVGh1LCAyMDI1LTA0LTEwIGF0IDE2OjQwICswMjAwLCBBbmdlbG9HaW9hY2NoaW5vIERlbCBS
ZWdubyB3cm90ZToNCj4gDQo+IEFkZCBzdXBwb3J0IGZvciB0aGUgdHdvIE1NIElPTU1VcyBmb3Vu
ZCBpbiB0aGUgTWVkaWFUZWsgRGltZW5zaXR5DQo+IDEyMDAgKE1UNjg5MykgU29DLCB1c2VkIGZv
ciBkaXNwbGF5LCBjYW1lcmEsIGltZ3N5cyBhbmQgdnB1Lg0KPiANCj4gU2luY2UgdGhlIE1UNjg5
MyBTb0MgaXMgYWxtb3N0IGZ1bGx5IGNvbXBhdGlibGUgd2l0aCBNVDgxOTIsIGFsc28NCj4gbW92
ZSB0aGUgbXQ4MTkyX2xhcmJfcmVnaW9uX21zayBiZWZvcmUgdGhlIG5ld2x5IGludHJvZHVjZWQg
bXQ2ODkzDQo+IHBsYXRmb3JtIGRhdGEsIGFzIHRoZSBsYXJiIHJlZ2lvbnMgZnJvbSBtdDgxOTIg
YXJlIGZ1bGx5IHJldXNlZC4NCj4gDQo+IE5vdGUgdGhhdCB0aGUgb25seSBkaWZmZXJlbmNlIHdp
dGggTVQ4MTkyIGlzIHRoYXQgTVQ2ODkzIG5lZWRzIHRoZQ0KPiBTSEFSRV9QR1RBQkxFIGZsYWcu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+IGFu
Z2Vsb2dpb2FjY2hpbm8uZGVscmVnbm9AY29sbGFib3JhLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFlv
bmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0K
