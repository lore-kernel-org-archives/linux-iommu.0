Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9B223B62B
	for <iommu@lists.linux.dev>; Tue, 14 Oct 2025 07:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426427; cv=fail; b=vGEHDmKmPIA2rM0bZy4HOQg0iO5dYOsvDjqKYsP2+Y4lI0bGP1I4uPUx/VTLpz/4lf1jVQzGL+KjJqHoqdrKxs98pnL+Q62uQZNLCPN3O0QtmQguPmPUTgdhFwXnYqBR9dy4YmuSJS5es9xGDRv34O3k5oTPyUXPtXMe/3S65QE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426427; c=relaxed/simple;
	bh=E5FWR6ZdpJSGt2wrEfFCPeuWzV6s8s5YKKCzR+eFbd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uq5hVKrqeI7guSY9WwZy5t7wDxVBuWkmAl3lx9xBKvH1GoCU+nI3rILOglMYm7AVMOFEF0zJn3NzSau+uqv9l8GgJf1s8gmbJwAVs/zwSyJG0ELIlbePzrXARBUC2Zf08rQzP6Qm8MX+2A1+A1HEwqZOOLXKKE3QRRznYuRyV9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OyIdYCCJ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=b5XhiX1b; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OyIdYCCJ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="b5XhiX1b"
X-UUID: 3b1c2556a8ce11f0ae1e63ff8927bad3-20251014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=E5FWR6ZdpJSGt2wrEfFCPeuWzV6s8s5YKKCzR+eFbd4=;
	b=OyIdYCCJEF6ADp0pssRGu2YfLl9faGJqN8huIHgRCIuTh3jNCFEfBRas8tOQP3dgYgZVnJfs5i33l714N3zdlTI+sktZjX2BqkboKqlKeDlMPuvgc3G2roSYu9lQtifE03io3HXZSL0BJXynj9uYTlnDWaDX7FOZi+hYJB0SqT8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:56eef1be-fb12-42fc-86bd-45418507c177,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:3a460951-c509-4cf3-8dc0-fcdaad49a6d3,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|52,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3b1c2556a8ce11f0ae1e63ff8927bad3-20251014
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 271435789; Tue, 14 Oct 2025 15:20:15 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Tue, 14 Oct 2025 15:20:14 +0800
Received: from SG2PR04CU009.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Tue, 14 Oct 2025 15:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RrQ6q+HUZXsOF1PCraAMcuxq7xr9JwI/GIWgrZxXteHfTs+FJ98TMdGc98b91z5n0dei1ZeHLvSHwBpsZSX2iF2z1JX84pGM5S0IfC491yUSeda41iIlX8loRZzwnLAiXl0eZrLI91zb9NmxsBAmhQc02g6bhktc/h2AU0uPgsH3D9gTEvFALkD6NY0BTEFVD5BN9JCjvehGAoIriW36Z7AiWrQwRvZuc0cuOcfN+kd2eTQpPMhRBpjzP7KhCfWWMFIek8qFw9Ay4UDTTsJUovnrwN9NccoVFhz2/Se/7Z2e17NqcxxVTj6B/9Go3ZtReubmWFVQ01Wd0TQgAOO0SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5FWR6ZdpJSGt2wrEfFCPeuWzV6s8s5YKKCzR+eFbd4=;
 b=N9iUK6aHfKMm7XSY9EXU+5H2gaetjAWbwvPus7uVGrDlFo7ttJnn9CTphntRSMpo5rM0PgkEijfZ+gs5Y1JNZNClk6oCLKZ7jeKS653SXoh7VExSvCV2M8WwAUnj35o2XO3LArgH8Qab0MIhqOSpnJU0wlMLK8waEopvvwzqSNw7jCjccozCzUkOVyTEq02M7uA44uj6FnnG33L8CiJoPmCgB2G3F1dtldhzpcl7w9eW0zjMmnLiNFi79mTx/aCFYCO+E3KmK2iMgqjp8VUR3nRQ4m4RvyMbGhPu+HKmgE0IrYEZZfR+cBJl5nrWAf8d2tC4mrJ8hTvCNuZb59az/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5FWR6ZdpJSGt2wrEfFCPeuWzV6s8s5YKKCzR+eFbd4=;
 b=b5XhiX1bKCXs1k567s6OU2YCgNlhbROHh2+tt+91qBF/DFhbmsZY8G+EPa5ekJyMZNzcVjrCfc73j9DcTfLLbQSR1Q43ImOC5WWXugCnmFsa8Egp4yYtHw6+1pDXEgYzRkLe05jJZJjPgkxM3Cswnt4SkrqbMfHOftdUXAFZZ2E=
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12)
 by SG2PR03MB6730.apcprd03.prod.outlook.com (2603:1096:4:1d5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Tue, 14 Oct
 2025 07:20:11 +0000
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0]) by SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0%5]) with mapi id 15.20.9203.009; Tue, 14 Oct 2025
 07:20:11 +0000
From: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?=
	<Yong.Wu@mediatek.com>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"robh@kernel.org" <robh@kernel.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"will@kernel.org" <will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH 3/3] iommu/mediatek: Add support for mt8189
Thread-Topic: [PATCH 3/3] iommu/mediatek: Add support for mt8189
Thread-Index: AQHcB4IDPWaO7/0zTU+K5si+53ACQrRbfIWAgGYqaIA=
Date: Tue, 14 Oct 2025 07:20:11 +0000
Message-ID: <534001b9c846e8d3164008fb92fb6f845b54fb4b.camel@mediatek.com>
References: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
	 <20250807095756.11840-4-zhengnan.chen@mediatek.com>
	 <7a2105e50f9543c4bd97c9d51aa09baaa3b72ed2.camel@mediatek.com>
In-Reply-To: <7a2105e50f9543c4bd97c9d51aa09baaa3b72ed2.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7007:EE_|SG2PR03MB6730:EE_
x-ms-office365-filtering-correlation-id: dc690b9d-2a47-4802-54a9-08de0af21cb7
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?ZC9ueFlRNHpCdHVOUlpoa2duRVdjZXZXOEJZTk5SNE1YWkpiOVl3VWdaeVlU?=
 =?utf-8?B?eHFtamN1aUNzQ3Q5dWtjdXhPY1VTazdKYjNvVmZEcTRJVUZXVHlTcko4T2s2?=
 =?utf-8?B?VHp5NVhScGpxaGNITy9uaWZvTjB1dmRlZ1B6dXJ4MGw3WXBjdnBtUis3SU8r?=
 =?utf-8?B?MDBRRmVVT1pmcDJTNnpwK0JDaXBvQnlZZEIrWnY2b28rc254QXlsYzh6dVN6?=
 =?utf-8?B?eFZ5K1cxLzhUY3ZZOG5Qa0I0K1NOZ3ZqbHAxbERkRVlFQU1PZVBSamZudEF5?=
 =?utf-8?B?bmlEZEJmaXZpdGNHTnN6amU2cDNNU3RSaXdoSHBOZEY3THIzQnFBSHlnL3JM?=
 =?utf-8?B?Z1hrN0Y3cE5GZHNDbUlxNnhLSWE4TUtybVpzUVVOWjVFaUtwUUNaUUtESlk0?=
 =?utf-8?B?VHNxdjk0aE42cUg2Zmpzck80Z0FPdnNpd0VsU0MreXV5alNxTXVuVmF5UFhG?=
 =?utf-8?B?Tm5BVkdYVlNOVTZRTFhwbkhBb240a1BHSzhNb1Q2ODRtc0dFTmVxTU53UjNo?=
 =?utf-8?B?Y1BJN0VqdTUzV0Zib1prZUF2Z1EyQ1kyRElvUDFZWmpyQ2hITFdqK2Z0YTRN?=
 =?utf-8?B?Rm4wVzdFSzN0SW1ndzU5YVFKT0M2RVJGMmVCSkt6eDdBZTZIVm5PTjY1N0Zv?=
 =?utf-8?B?d0JOQlRRaFg3RlV0YlZubUxiRDlpTkFteVVwSi9YNUp0VHVBWWVTUkdtbHY0?=
 =?utf-8?B?eVJSYlBhbC9pKzBvc1dhRGRkZzFnNVVNZ2d2VkxOMlltQVprT2RoVW9Bc1lZ?=
 =?utf-8?B?UUpWUlZkK2Z2TStOQUJob1I1OEZYcGFqcHJ3SS85UUprb1R6SHVONkxqeFJo?=
 =?utf-8?B?dGVKOWlCeXNYazVjck81aEJEN1FqRTNKTjI0L3FFTWRjOG54YkdtbnZ2ZWJO?=
 =?utf-8?B?WE51TE13QjQxUVF2Q2ErcFFyeXpld1FDZzY4RnRFL0wzbzZVZUhwL3BwWTA0?=
 =?utf-8?B?c09iZzd0cUhDWlplbUUvVzlMcTNEUVlVa0dVcmpVOXpWSGRvTStaeHpHb3hL?=
 =?utf-8?B?d2U4bGhLT2Y0Unk5c0Q5MGVNeVVwUmErZm5tQitZQlNka0JCcHhWRGlWdFYx?=
 =?utf-8?B?R1ZtQUhTc2FHV1AyaDNPd3BMazR0NGZoYzREcmt3VFZDc2xScVJOZEhHUVJz?=
 =?utf-8?B?ZHhSZWF3UjYxYk9scnhkQWlGK3BqUmJxdGo3bCtDc1dtWmEzVUJ0cll6R3RU?=
 =?utf-8?B?ZHBoMzM2Um1MbzFUb21Zenh4Y3haM2Q4c0pRQTY5Q2l6R3ZBTGVVUy9JVzJU?=
 =?utf-8?B?eW1wRE1CMEZZaW1hQXNNMDcvMTljYTlEVTkxOGIyelVpR0swbXNjcXorK3RU?=
 =?utf-8?B?RUZrMzFvT0huaVl2dGVYZkFITTVvY0FsR0wwTHNJbmNCSlJTRC9KTUhWdGR2?=
 =?utf-8?B?clJxUC9BU2FsUldtR05GN2xxeTMvdGRTUW5ORlErRlpOcmVyeHh2UjNzcFRt?=
 =?utf-8?B?b3lxWk5DQkZ4cDBjdzdkWG02K0dJM0o1WUJEaFBqTDFaeFBMVFkxYTRQYTNN?=
 =?utf-8?B?S1ExQ2ExMkJ0dWpISGJ6M2xycDZGVnBZK3dsNGgyTGRpN1NpT2V0d0hWY0p5?=
 =?utf-8?B?b2I1bThyY2ErTDBoUWZZa29lajIyaktRdHpjZFgzZU1mZUE5UCtLTXhHbXRP?=
 =?utf-8?B?VkkxU1Irbm15cVdjSE0yOFI3RkhobXhiRGFVZFJZVXlCUlF3YklVWXRHcWM3?=
 =?utf-8?B?ZEZScG5WRUI2ZSsyS0RpMThlSlVWYWwzK1MrQkpIMmlhbnFsdURLcEdXQTA2?=
 =?utf-8?B?Z1NwV2ZMaW5lOWx0SVVSSC9HNkJGcUdFWkpjWXh2ejkvdXpqNXRnZ01EdklL?=
 =?utf-8?B?Tnh3TFJOakRkdFhTTHNBNndYTmVLSldYLzBFcXZQVGEvc3JBM0NXdGJtczBB?=
 =?utf-8?B?TEtOMWFVK1ZKZzFrMmlCeEFWRlhkNklGMktWNUVkOGFFTDE1UEI0cituRXVR?=
 =?utf-8?B?VWFmRDdBREZWV0FaVDlDTFpVZ3IzUERDa1hGTTBxcGthUXF2ZlBGc05PV2VZ?=
 =?utf-8?B?YmNFaU52QURWT3NGUnRmSVE0N2RBK0hEbS93UWVlM3VRS1RQUVZkUm5DWi8z?=
 =?utf-8?Q?RuRYax?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7007.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3dHR0xJQTBsenZPUDF1ZFlJMmtkR09rMUhndWJjSERhaFhBUHRMVkVXMkk3?=
 =?utf-8?B?RnRhUDkxSzl0OGh3VnQrd1FCSmIwaFhHUjVrdno1dGF1dzY3Rnk5bU1BellS?=
 =?utf-8?B?TXNXKyt5S3lIVUhZNGk3aGlGK3BZSjc1dW03elZTUzBtODFqUG0rSXI1Ykoz?=
 =?utf-8?B?ZWlDYjIxRU5LNjAwZ3dTSHlMRnY2ZkZNTGRwVXlrejljbzFIQ3JsN0pBNEtO?=
 =?utf-8?B?OEhsMnRuRDFXemNkV0tsSGtGVjZNbFZ2dy9BZWdRK0Q4TUY3dm1VOW14d3Fq?=
 =?utf-8?B?N3h5Z3FQRWRUR1IzSVdKTzhFaFBBWnRrS0cxV00zRW5ZVmNKUzMxcDlOdWRT?=
 =?utf-8?B?WmpKU2pUelpSYzFZaklneEtSQUd4dEpoQnI0MzBJRDVwc1o5aCtMTnhOZnBT?=
 =?utf-8?B?RUEwc0MzWi9XMEc3RzNCWW01QU9oWkpvd2NiOW94Y1puU2hHdzJZSExuUnpL?=
 =?utf-8?B?Zll5S1kwVjN3ak43RS9JZWlUMWRsL2EyWTFaRVJhRzc2MmxWK2RQOW81T3hs?=
 =?utf-8?B?YWdOTVFnbWduRFdvSWlHK0FiTkRWZjg5KzRMSm4xY0ZMUnFLekxUWUVaeDhw?=
 =?utf-8?B?UmE5ajZ0RDczY0dXbnphancwSTBvZWZxSzlWamxqSVY3NURiS2lNQTZSdk1H?=
 =?utf-8?B?UUpwdmllS3BlYU1xdTBTY29VV1Q1V0lVb1padjhYWjU1K2o5d1h6KytvVFRE?=
 =?utf-8?B?Zlh0cDZ6dWtROFBUZys3Zkx3eEszUmtoWjVUS0J2UEUvV0FtL1gvNnNBUnZw?=
 =?utf-8?B?b2dpZnE5cy9QSnZaVmFNVXozbmF4NkVwRFNaQzdXUmZ5aFNNc3hwT1ZDejZY?=
 =?utf-8?B?YW9tdVhvUzZHdnRvZGlhYzFCMjFIeGMvOXJHZCtaTXZyS0RMa3c1Z052aVJ3?=
 =?utf-8?B?RTNRTkZpUkZQVUNBNGhQWDE1S3ErdnQvNis2ZDJGRzVIWkNVdll2ZkpSWTRs?=
 =?utf-8?B?T290amNraHQ5YVAwaXdNZ3J2ajF1eGpBTTNWa05uYk1KRUYwTDNKN2lUL09x?=
 =?utf-8?B?RWFMa0tCSVprYjREbVU4SjRNaGRJUlRTZitHaXFOc3pkaDZMeGNwZTdUK3JP?=
 =?utf-8?B?V0Q5SXFyQldPUWhOKytkOEhETnUvNHo4eGNKRjFhSzlOQllVVlpmbzNSYkhK?=
 =?utf-8?B?UjVsZEk2aWVLQlpkN2lFa08xOFh1MkQvRkJyWVdpQXJ0SDlscDFSYzV3TEwx?=
 =?utf-8?B?Z0tkemJxenVLQWMzOEw3allSSjVCWE1yY29vWFNoY3FGT1R3elFmRzN4aHlr?=
 =?utf-8?B?MHZ2b0lXV3NQczJzOG84SnMvMDdjdDcvWmRxeUR5YThYTEtJZDArZE80TXRG?=
 =?utf-8?B?dTZBbGpzVXRNbkdjaG1FdWlOOWVGMXlQM0ZQQTZoVTZnVFdMVXM3MEhaTVU4?=
 =?utf-8?B?eGlEcC9sNHhsd3NqenNoMFlxQ3ZBdEJ4RVc0ZzNhS3JtWUdhQVptcEorWDc4?=
 =?utf-8?B?V1BHeC82S0diVnU0WVdxWTFvY1BXU1dGbS9GN0ZZR3psNXNRV1duMDFsSnRk?=
 =?utf-8?B?V2R1R2QxY25rekNwZ2tSNTNqWTZJUHNjaG1LeUhpc0dwMXpMY3hUS3ZyL1A3?=
 =?utf-8?B?V2N1a3pzTE04a1llNUt4YmJEYWFMeUFFSDZaaXBUMGFVSTBHNDVoR0JrRXdY?=
 =?utf-8?B?dkcvLzdvR0swQXJqaWpVU25XTGp2SUoxT3RZRk1FeGF3Rlg4eWQxdXUzMXFy?=
 =?utf-8?B?ek0vdW1IeTl4QTR2VCtWMXJDYTBxYXhiTlZtUUFjVUVlZUpveWV1TzZFZy95?=
 =?utf-8?B?ekp1WndRMHhSWjBsTWxTTlFVUmE0VzJDQjl5a00vMENPWC9NU0NmWThzbUFa?=
 =?utf-8?B?TUd0QmlUTSswcEljSDY1alJHTURtQVJGeXZmTFpwSm4wVkl4WDZkSkhlT2Nw?=
 =?utf-8?B?ZzdXcXFVZ0pVZDlINXFHQnQrQXZ4RHdrV1hBbGhBU3lYdXdZWjlZY0hTWFZp?=
 =?utf-8?B?S1Z2VmZoeVZ3a0kwQytiYi9xS3FTK0xQcVRHVVIxN0gyclVjemx0UDQ2Qmd2?=
 =?utf-8?B?OVBlN1lQenc2TnFDTVlCK0Q4SlZoUS8xOW9hdEhpZk0zTGxsM2ZRWGlJQitu?=
 =?utf-8?B?cnltMUswV0FoUTQ1Y3lGZ1F6bTMyd3RjTnZNdk5abmtKMXAxMFlwWFpxTnZI?=
 =?utf-8?B?OVI0bExUTGwxT2xWSkxYVEVpcHNVSVJ3ZGRnenhQaDhnUzF5Y0xMNDRuLzhl?=
 =?utf-8?B?V3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CDDDFA5667254540BDC5324D6CC5F60F@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7007.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc690b9d-2a47-4802-54a9-08de0af21cb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Oct 2025 07:20:11.3261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yqeglZOrhZml68kXerrt7dEDhvr14i0YQGDYff9mLRBAhnSAlDeSLuYcx50h9JVUux7rhjtAkLKHNcAUKbVpMIyMCQaj8mKR1VcFJ/QWlV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR03MB6730

T24gU3VuLCAyMDI1LTA4LTEwIGF0IDA3OjA5ICswMDAwLCBZb25nIFd1ICjlkLTli4cpIHdyb3Rl
Og0KPiBPbiBUaHUsIDIwMjUtMDgtMDcgYXQgMTc6NTcgKzA4MDAsIHpoZW5nbmFuIGNoZW4gd3Jv
dGU6DQo+ID4gRnJvbTogInpoZW5nbmFuIGNoZW4iIDx6aGVuZ25hbi5jaGVuQG1lZGlhdGVrLmNv
bT4NCj4gPiANCj4gPiBBZGQgc3VwcG9ydCBmb3IgbXQ4MTg5IElORlJBICYgQVBVICYgTU0gSU9N
TVVzLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IHpoZW5nbmFuIGNoZW4gPHpoZW5nbmFuLmNo
ZW5AbWVkaWF0ZWsuY29tPg0KPiANCj4gU3BsaXR0aW5nIHRoaXMgaW50byB0aHJlZSBwYXRjaGVz
KGFwdS9tbS9pbmZyYSkgbWF5IG1ha2UgdGhlIHBhdGNoDQo+IG1vcmUNCj4gcmVhZGFibGUuDQo+
IA0Kb2ssIGkgd2lsbCBzcGxpdCB0aGUgcGF0Y2ggaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KPiA+
IC0tLQ0KPiA+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgNzYNCj4gPiArKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDc2IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gDQo+IFtzbmlwXQ0KPiANCj4gPiArDQo+ID4gK3N0YXRpYyBj
b25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODlfZGF0YV9tbSA9IHsNCj4gPiAr
CS5tNHVfcGxhdAk9IE00VV9NVDgxODksDQo+ID4gKwkuZmxhZ3MJCT0gSEFTX0JDTEsgfCBIQVNf
U1VCX0NPTU1fM0JJVFMgfA0KPiA+IE9VVF9PUkRFUl9XUl9FTiB8DQo+ID4gKwkJCSAgV1JfVEhS
T1RfRU4gfCBJT1ZBXzM0X0VOIHwgTVRLX0lPTU1VX1RZUEVfTU0NCj4gPiA+IA0KPiA+IA0KPiA+
ICsJCQkgIFBHVEFCTEVfUEFfMzVfRU4gfCBETF9XSVRIX01VTFRJX0xBUkIsDQo+ID4gKwkuaHdf
bGlzdAk9ICZtNHVsaXN0LA0KPiA+ICsJLmludl9zZWxfcmVnCT0gUkVHX01NVV9JTlZfU0VMX0dF
TjIsDQo+ID4gKwkuYmFua3NfbnVtCT0gNSwNCj4gPiArCS5iYW5rc19lbmFibGUJPSB7dHJ1ZSwg
ZmFsc2UsIGZhbHNlLCBmYWxzZSwgdHJ1ZX0sDQo+ID4gKwkuaW92YV9yZWdpb24JPSBtdDgxOTJf
bXVsdGlfZG9tLA0KPiA+ICsJLmlvdmFfcmVnaW9uX25yCT0gQVJSQVlfU0laRShtdDgxOTJfbXVs
dGlfZG9tKSwNCj4gPiArCS5pb3ZhX3JlZ2lvbl9sYXJiX21zayA9IG10ODE4OV9sYXJiX3JlZ2lv
bl9tc2ssDQo+ID4gKwkubGFyYmlkX3JlbWFwCT0ge3swfSwgezF9LCB7MjEvKkdDRV9EKi8sIDIx
LypHQ0VfTSovLCAyfSwNCj4gDQo+IFRha2UgY2FyZSB0aGUgZm9ybWF0LCBBZGQgc3BhY2UgYWZ0
ZXIgJy8qJw0KDQpvaywgaSB3aWxsIGFkanVzdCB0aGUgZm9ybWF0IGluIHRoZSBuZXh0IHZlcnNp
b24uDQoNCj4gDQo+ID4gKwkJCSAgIHsxOSwgMjAsIDksIDExfSwgezd9LCB7NH0sDQo+ID4gKwkJ
CSAgIHsxMywgMTd9LCB7MTQsIDE2fX0sDQo+ID4gK307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29u
c3Qgc3RydWN0IG10a19pb21tdV9wbGF0X2RhdGEgbXQ4MTkyX2RhdGEgPSB7DQo+ID4gIAkubTR1
X3BsYXQgICAgICAgPSBNNFVfTVQ4MTkyLA0KPiA+ICAJLmZsYWdzICAgICAgICAgID0gSEFTX0JD
TEsgfCBIQVNfU1VCX0NPTU1fMkJJVFMgfA0KPiA+IE9VVF9PUkRFUl9XUl9FTiB8DQo+ID4gQEAg
LTE4MjYsNiArMTg5OSw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lkDQo+ID4g
bXRrX2lvbW11X29mX2lkc1tdID0gew0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRlayxt
dDgxODgtaW9tbXUtaW5mcmEiLCAuZGF0YSA9DQo+ID4gJm10ODE4OF9kYXRhX2luZnJhfSwNCj4g
PiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTg4LWlvbW11LXZkbyIsICAgLmRhdGEg
PQ0KPiA+ICZtdDgxODhfZGF0YV92ZG99LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRpYXRl
ayxtdDgxODgtaW9tbXUtdnBwIiwgICAuZGF0YSA9DQo+ID4gJm10ODE4OF9kYXRhX3ZwcH0sDQo+
ID4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OS1pb21tdS1hcHUiLCAgIC5kYXRh
ID0NCj4gPiAmbXQ4MTg5X2RhdGFfYXB1fSwNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0
ZWssbXQ4MTg5LWlvbW11LWluZnJhIiwgLmRhdGEgPQ0KPiA+ICZtdDgxODlfZGF0YV9pbmZyYX0s
DQo+ID4gKwl7IC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10ODE4OS1pb21tdS1tbSIsICAgIC5k
YXRhID0NCj4gPiAmbXQ4MTg5X2RhdGFfbW19LA0KPiA+ICAJeyAuY29tcGF0aWJsZSA9ICJtZWRp
YXRlayxtdDgxOTItbTR1IiwgLmRhdGEgPSAmbXQ4MTkyX2RhdGF9LA0KPiA+ICAJeyAuY29tcGF0
aWJsZSA9ICJtZWRpYXRlayxtdDgxOTUtaW9tbXUtaW5mcmEiLCAuZGF0YSA9DQo+ID4gJm10ODE5
NV9kYXRhX2luZnJhfSwNCj4gPiAgCXsgLmNvbXBhdGlibGUgPSAibWVkaWF0ZWssbXQ4MTk1LWlv
bW11LXZkbyIsICAgLmRhdGEgPQ0KPiA+ICZtdDgxOTVfZGF0YV92ZG99LA0K
