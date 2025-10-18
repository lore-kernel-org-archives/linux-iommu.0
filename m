Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F449145FE0
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 02:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754544; cv=fail; b=foMZTQTf0gZIPLMrgDnd1DiR+7q1o0kvoR6mieCkLmDzEV5gf4C05WH8vj+S2SEd7G3jy8BARxEQ64siZoarDGLoOLnl5Ujnf1oQrzQUeEiy3WnLfdRsLwuL4ntZ72gPO4DGl1XBTOVPT4bEoSbmKVuqo6/EuR1a/+EKg1zIMVM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754544; c=relaxed/simple;
	bh=fv/bQqdC6P+VoOibmrQ2XXOpYL8pj0nqNRjoJybhMJ0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uWmZMM0y8hc7octS1dHQsYHqtYQ8dhHju7REWue2WbexKPzQ+Og+WGPq01uFm0ECASDTA1+wldCYIhjD2Tc+EMxIMPUn7wx/J3iuvtQVhxoqmpd77QWGL8IXv0UqOY7jHef4ShNYBXal9fJYbv7OO1HDLmx9sM7fHiBMqTEcMZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=BlYNXKaI; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=tv3Nn7YS; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="BlYNXKaI";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="tv3Nn7YS"
X-UUID: 31ee52a2abca11f0b33aeb1e7f16c2b6-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=fv/bQqdC6P+VoOibmrQ2XXOpYL8pj0nqNRjoJybhMJ0=;
	b=BlYNXKaIeo4rWA14+3m44GKFWOHhMZ30mPg0ebqOLMrWOSeHZ64i3A8EIjJtwAUHBK4QbkCC/ypVKlHIc464fThLNRuxHL7gNcuoP71868yUKDtCu6Da+Vauh+uNZjeBHcC0POVfPkhBPlKjvavALmyYq4FNkuo9oDOFYQ2pAuo=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:ebbe19e0-9718-4a97-9300-6279d527a04f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:b21a4cb9-795c-4f99-91f3-c115e0d49051,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 31ee52a2abca11f0b33aeb1e7f16c2b6-20251018
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1028830405; Sat, 18 Oct 2025 10:28:55 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 18 Oct 2025 10:28:52 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Sat, 18 Oct 2025 10:28:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fGxeFZOij5xchISp9+ZZ3dBTuwbkBaRYqYzoWxyc4KlX4+yEiVNJ7yjZ1Vwjr2DeDwo1z+mGWhkafsSDUXUEwuu2lsofmiNZ+9DKyxu7uczYzOS1doh8IhkZiaS94US+bFxlIHKJNqIo2EN/4IkXfDhQyz6szIq+w7vqIRXPY/0S+T8eVy4ZGG4x90/0DXxgvnK24xa8LIMrW2rwzidJbebSsAm3sF6ZV2W0p0riumspKJX0NOidJJsrrKkrJRtAjQGuQPwnFWzZh+eiv+Zcj4/jpYk7vnurZXLK+unoSF0gXfGKkHjGIF4BQYKXSZphyU9lUDQ6DO5uAkdJlDkUHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fv/bQqdC6P+VoOibmrQ2XXOpYL8pj0nqNRjoJybhMJ0=;
 b=k3IV02LfwhZlCFuK153yjMC5n0dlGa/uVtVu/JZPA3xHmkcDlVhMbF2HXV6qja9E05vVrmh5OqZVzxpDJ0v4kP8mQLRCirGV+uU6nvJ9YwPH3qiG9sRmMUNT9W8J58T4nDupw2/I0jsYF6J30ei+WSq3yFS5wtARI6E2F1PtzH0AZERU4lO18faBsjeYWSOeXPky2W3uxdubjljQDUtTDFnEYOg23ygdLxJcICIpHdsKBogFE6GwBtXR0y0/XmzqlI1ku0A1cm7YZ+pt5scOc6X1VKnlZwmADk4CX1K/2ptnE76gJrL6fVlDaxamO7A+McWC1zaPTR54Ynkx+yWVMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fv/bQqdC6P+VoOibmrQ2XXOpYL8pj0nqNRjoJybhMJ0=;
 b=tv3Nn7YSEwaB6zcMQOzuszu7QhG8nbZ8Lm8MbczodQm+6WQL3efCIOVSCjjphQ+CpbvjzRGr5fcuv8grNf6lKky5h3+0rzDIOn3dG9sR5thvZCj2Rgh+Xroai6eTbNiWa4Nind0La6nMyR7vCwiPU/TRM4UTi2qoTbYswPcvZUI=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6789.apcprd03.prod.outlook.com (2603:1096:400:1f6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Sat, 18 Oct
 2025 02:28:47 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 02:28:47 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH v3 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
Thread-Topic: [PATCH v3 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
Thread-Index: AQHcPdNVrf3UXhFs90CKnQevvltEEbTHMjUA
Date: Sat, 18 Oct 2025 02:28:47 +0000
Message-ID: <e7bd34b9bb34e9bd9538b2ce493e271d4688f4c5.camel@mediatek.com>
References: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
	 <20251015125532.9041-4-zhengnan.chen@mediatek.com>
In-Reply-To: <20251015125532.9041-4-zhengnan.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6789:EE_
x-ms-office365-filtering-correlation-id: a89118a5-28b7-4fc3-ad73-08de0dee10fb
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?c2dQTTE1MTZoNEs4YnRuTjQzQmZCRnB0RndpUklPZU5kdVozcXF6YlZNUmN0?=
 =?utf-8?B?WXYyZ3FJb3RFSXpyTFNaT3VVNXdtakhaUWo1S2lDWkZiWHZnS1JYR2xsVmp0?=
 =?utf-8?B?eVZTTExKQ1BKOVdHWUJkdjVET3Axb1JucG5saEZHOHluUk1lNWkxOENZd2g4?=
 =?utf-8?B?Q2pNR2Qydno0SzNvRjVJOVV0QXEwU0Z1bjloYVZtaGptckhkZ052TGtnRDAw?=
 =?utf-8?B?NFMzeGh2Y0RjNEFydXhKU252bVd3OWc4U1ptVDhCZWxpL2MxV0diRmJ5RnZu?=
 =?utf-8?B?K2tvT09lSitsbEorVnIwaU1hSmd4c0RyRWdYejRUeEpqQmpSaS92YTBnbzVL?=
 =?utf-8?B?VTYxSmpjaHk5dnRveVVkRGo0ZXZBbTM3TVV5cXNxN3BodzlUSjVPUFpTQjF2?=
 =?utf-8?B?VW5sbkdRV2lUM0hEZmYvNUFwU20zb3p1T0dLR1hBSWpXSnNoV3lqMkIyeVhB?=
 =?utf-8?B?TDZtS0xNRHZvUnk3MG9QS24wNlQyYk5YQ0pES1dyNS9ZSkw3aUNoTW9WYkVR?=
 =?utf-8?B?V2xuY2cydGVGT1NzeXZDS0dkTWVQWElPTjl3RHMxcUtzd1ZaZHlQZ3BXcHA1?=
 =?utf-8?B?ditXRkp6cWdOV3lTRnpGK2ROMjQzbHpBMkIyRE1JL0FtTW9HTm1pWU1uZVM3?=
 =?utf-8?B?VzdFTlpYNzhWZmtYZ3ozdFlqSVNjVlVtZmNqL0hjZ2ttdzBVU0M5aUsvTmJh?=
 =?utf-8?B?SXhwTlRLdFpFZUJHSUlzcWVTWEhZZkdFUmRDYXFVNDN4Y0wxeVYrcDhGM3hw?=
 =?utf-8?B?Q3VvYVJXVWVMT0RRNTd5aU5qUkdIUWdwSlNEbUVuaU9pdWw1Z3ppU3A1bmxy?=
 =?utf-8?B?ZHFMb1loTGJvM3huZnBuUDhHR3R0REF1T2UzVjFISG8veVJNSWg1VTBnZ1Z4?=
 =?utf-8?B?RWk1Y29KR2hlWEh0aVB5QVlKaCtiSlNGRnNQZ2JCLzZJTnV0NWVzNXJwVnhm?=
 =?utf-8?B?ODNZSUJOWjYyNlMyam9oWkFWQnExYWZDSDZSWWFEU1pPa3lKRTdtRldsZFEx?=
 =?utf-8?B?MDl5UnNzZUhHcGNFcFpjb0g0TG8yV04wa2c4ZU8wbjZyUXgvZSt4OThlQ0pX?=
 =?utf-8?B?WEhQR1B5Wm9FSVRwSXNpaXl4Ulppd1ljRFppYkRYS2ZwYjFkdG1PYk1wbytV?=
 =?utf-8?B?RHEzZDJiUE1MRWUxY2U3VjlRQ3BDZnZmc0dVb1oxT0pvRkpIWVFmOFBMQytP?=
 =?utf-8?B?T2I5RHhRWW54ZXYxQkNBWjlHc0JzNjF1bnplTGxjVENGWlh0QXZucEJ0M3VZ?=
 =?utf-8?B?emhBdUlsWEdwL25xUVhiTlhnOVF2elFsVVFITHZYU0FGa3c5WjJMTGg1b0RN?=
 =?utf-8?B?c0ZJUXZXeStpOG9SczJKREFrTThSNXhHb2RZTndJSEpLSFEvZG0vbGd1bks5?=
 =?utf-8?B?ZnZaOUxCSW1sSGpEc3ZIR08zVUVnaGQ5RlFoRUQ0OTFUWjN4UVNzWkFPZjRQ?=
 =?utf-8?B?eGZqVkZCa2VMWlNhblJJNGh6R1dtcXNQWjFYWGptNktHK3pTS1haRmIzb3E1?=
 =?utf-8?B?d1R4L0xWOGQrc3BKb0haalV6bWMvNTBUS2FHWEQ4R3E4d1NoeVBjS0FpQWtV?=
 =?utf-8?B?Mk9ZY1J0M28waGkzcGNsaUY4MFlSYzN1TmhJVDlyUVgzV2tHRGd3V2o3MCs3?=
 =?utf-8?B?dHBodHE2RDNiZjJkQ0VHYWkwdDMxTXlDY1pPcmg3MnU2bk0vTTVTY0gvWlBO?=
 =?utf-8?B?RVQyYVZiNWJhZktENktYWmpvcGJXQnd4R09PeDAyVFQrY05kRGhWaWxDYkJl?=
 =?utf-8?B?djA4RDhrZmlRRG9vaUg2blIzUGUvSHR4dWJSN3hXcnV5eGYweWp3OFllUTh2?=
 =?utf-8?B?Rm1BbkI5YXZ5UGxweWRsdGhrMjR2MUgyN092K1ByYUZRY2NYNXhhcWh3NnE2?=
 =?utf-8?B?eElKWU4yaGFpQlAzZHZFZDhrLzVGVlZrYlh1ak9aZndwNTA2dmRYNG9PaU1P?=
 =?utf-8?B?WmVMb005b2NSYWxYVzRnd0xEQ1dQcGltVFphbjFpaE9EenBiMnRwaExRYlZx?=
 =?utf-8?B?My9KYjkxSUM3MVBIUmZnTXQxNjFtRHUrdmE5TzNjQStZaXM5Skl6aUhZdW9C?=
 =?utf-8?Q?aRNtZT?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3k5SHJQVFJnOEtwWDc4MzlPQyttc2sxUWhFRm00SUwxZ2UwdFlmTmJRUXpv?=
 =?utf-8?B?YVBVeUx5YjR5ZWRCTHpuT056TlpCa0ZjeHFFczNUSGZOTyt0cFZuSFBDMldr?=
 =?utf-8?B?YjAxcmxTeFFVRDBLY0tZMU1jbEJjVDkxQ3NUajVra3NhOUVUVThvclFMVjRB?=
 =?utf-8?B?cHAybGEwMXdCMVB2QWx2T1IraWExaHdsQ09tbCttejYzRUtaY0lEN0VKWjlq?=
 =?utf-8?B?UHoyc1oyOWRoa21RMk8vdE5CN0VOMCtWTjYvNklGbUZuTlpKakdFaU5Md0VB?=
 =?utf-8?B?Sm5iQ3ZFOEZnS2F0ZFJNRkNtV2hoNWhmUkpGTlZnUHpnZzBHb0F4TXF5VEhr?=
 =?utf-8?B?N0FTY1RYZnJ6Z1Q3VVltWFR4MDluOFE3QkRUeDNzRnFjMytJV3BaOS9VWlJa?=
 =?utf-8?B?MGVMTTV1SVVVVHAwUzAvZHdUS0lsR2VkOFZBNnhMTFFkUTVxV0laTTRFdmxN?=
 =?utf-8?B?ZTJUTjE5ZG0vRG9NOHRQSCs0bU1WM2JLb2haMTBtb25EbDFEVm4xS0pQY3Jj?=
 =?utf-8?B?Vk55Z2VDbDAzVUh0NUZQeGsvNCs1THcyQ2w3OFpiZnN6bEFCQStrUEd3OUgw?=
 =?utf-8?B?RXJvTEcvTWdDQWNpOXhjYlhWdmlqcUF0OVFKUUQrU2krRmlPNDRDWEcwcXZi?=
 =?utf-8?B?RnFCQzFSUWZ2YjQ1NXdPT2VKQm5BeFl5eWdYVDVRWk9KS283Z1ZPNlIxRHAw?=
 =?utf-8?B?NG1hVnplREFVbG1FTE5xY0RhaFpWOG5lZFQzN2hUSkVsb29ONDJlOVpQdXNm?=
 =?utf-8?B?M3Q2NVlPK1FGeE0xUFBldDUvQUFNN3pmVGhBK0Z3dSttUlI4YjZaQ2VSdGdp?=
 =?utf-8?B?MVh0a21LMXlsTHBjREZqZUJ4YjFHSWhsVzExMzJwQ1p5TjczQnFEcmFiUDA3?=
 =?utf-8?B?YTJTTWZBTjk4Y2dQV0NGeWdZL2VvcmM5b0I5eEJKZm02WjlNZEZSUTh1ZXIr?=
 =?utf-8?B?MG9vUXBXOHhiYmVxZkhlYnlBSm9LYjVhUldnOUQ2YlJ1KzJoT2pmZ2JmOFdY?=
 =?utf-8?B?YWFMV3A2VGVMcnErK1JKVDdTcmdReE1xVG01ZGpMWUU5cXZsbHdkTEIxZkto?=
 =?utf-8?B?VE96WmdCNTRSQ1VQTEtTaUpCV1NoS0orTndZQlRxdkpGdkU0dVFuZFJBczVu?=
 =?utf-8?B?OGlxSlV0eUd3R1V0QVluQW1WOFU3OHpjM00zazRjN3VNNEpzbnhZZjBEVVR3?=
 =?utf-8?B?MXE5TnIvaUZHYkhLNEExa3pMTGZlK1RXZ2hSZHljcDQ4MzhLYmpPQUdzUCtx?=
 =?utf-8?B?UGIyWjVnQmV3WEhEcmxXc2lqRHdZeHNoVU1FUFg1b3ViSDhROURMT1hCVlRs?=
 =?utf-8?B?YnNycnEvTUtZb3RKdi94ZmJCNUZaeExEb0hwdHdwKzJyaTNPSXJJTFlGemR0?=
 =?utf-8?B?WDFlK0J6M3RzZHQzSVdpNFhMY0RwZmxvZi9CR0hGeFBqYkEzOEZLcmNuY1V0?=
 =?utf-8?B?ZEszNmw4N1N0WnBKaEEzQ0pTNFpEbnBNcDZjRTEwbWlqVFRmbjRnOXhoR1RV?=
 =?utf-8?B?V004MlNyRzVYWkEwaGlTRVdIdUVEVi9XdUJOVGJkWTBQSTRJMkJFbEVKbk1l?=
 =?utf-8?B?VTd4ekZEK2JKcDliOWxudXlVdytrVUZ1VXJyeFZjb1dwbFQ1MFN6N3FXOFlI?=
 =?utf-8?B?OVFxUHBuL2ZvWSt5b1pWRVRYV1FPd0JrNzlFaU5PU2xGRzRkQVp4WFFEZFFi?=
 =?utf-8?B?elhhRkQ1a0R5ZzJMN2FVZ0I3eE1pRFc0Vi9zaGFGOVd3OXpGRzdrVndURlps?=
 =?utf-8?B?NThBdG9sd0VLdGdsVVd0Sk0yekJtSnByeXJlbk9td1pnNlMrK1E0Vllzdm9I?=
 =?utf-8?B?d2RlWi9kbVRjZ2lPVER3OGpsR01zMWc3SG1HOHRKckNOTHVuMFd5WUdPamJM?=
 =?utf-8?B?S2drZ3g0bDhJRWlFRnhPV1hSalNjOUhVcFErWDdmMmY0dWJGN0hpVWJZazRj?=
 =?utf-8?B?K3Zwa3dpOUd3T0ZLWFJjSHB2WFRHOFpJQ0sweHJ3bXlDSlJGdGpvVDRNNVZx?=
 =?utf-8?B?NDZkVzNpR2dZRGx0UjVaVUN1OEQwRndiSUEreTdYbDZvQTNncGlmMEI0QUpt?=
 =?utf-8?B?TW5HeXBHT2NPYmoyVUdSKzFDZkxXbE5ibWY4dEgrMkN6MmVwYmxrajFaUmY0?=
 =?utf-8?Q?frMoBYyJ+0KcOipgpf/jjfEt1?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <FA30E60BB0139F4D92C957331E3DD6B0@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a89118a5-28b7-4fc3-ad73-08de0dee10fb
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 02:28:47.0939
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +HWZuGQuvqrVvYAiDTxpG9t06cgm5DvZ/aVsY57c2dNt9Ubby9utjD6aBj3rJrBDVTFqcaPV0VxZx8BEE3auLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6789
X-MTK: N

T24gV2VkLCAyMDI1LTEwLTE1IGF0IDIwOjU1ICswODAwLCBaaGVuZ25hbiBDaGVuIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgbXQ4MTg5IEFQVSBJT01NVXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBaaGVuZ25hbiBDaGVuIDx6aGVuZ25hbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gUmV2aWV3ZWQt
Ynk6IEFuZ2Vsb0dpb2FjY2hpbm8gRGVsIFJlZ25vIDwNCj4gYW5nZWxvZ2lvYWNjaGluby5kZWxy
ZWdub0Bjb2xsYWJvcmEuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMg
fCAzNCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IGluZGV4IDdhZjQ3YzU5YjEw
Yi4uOTk5ZjdiODU4MTY0IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5j
DQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gQEAgLTEzOSw2ICsxMzksNyBA
QA0KPiAgLyogMiBiaXRzOiBpb21tdSB0eXBlICovDQo+ICAjZGVmaW5lIE1US19JT01NVV9UWVBF
X01NCQkoMHgwIDw8IDEzKQ0KPiAgI2RlZmluZSBNVEtfSU9NTVVfVFlQRV9JTkZSQQkJKDB4MSA8
PCAxMykNCj4gKyNkZWZpbmUgTVRLX0lPTU1VX1RZUEVfQVBVCQkoMHgyIDw8IDEzKQ0KPiAgI2Rl
ZmluZSBNVEtfSU9NTVVfVFlQRV9NQVNLCQkoMHgzIDw8IDEzKQ0KPiAgLyogUE0gYW5kIGNsb2Nr
IGFsd2F5cyBvbi4gZS5nLiBpbmZyYSBpb21tdSAqLw0KPiAgI2RlZmluZSBQTV9DTEtfQU8JCQlC
SVQoMTUpDQo+IEBAIC0xNzIsNiArMTczLDcgQEAgZW51bSBtdGtfaW9tbXVfcGxhdCB7DQo+ICAJ
TTRVX01UODE3MywNCj4gIAlNNFVfTVQ4MTgzLA0KPiAgCU00VV9NVDgxODYsDQo+ICsJTTRVX01U
ODE4OSwNCj4gIAlNNFVfTVQ4MTg4LA0KDQpNb3ZlIGFmdGVyIG10ODE4OC4NCg0KUmV2aWV3ZWQt
Ynk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQpUaGFua3MuDQo=
