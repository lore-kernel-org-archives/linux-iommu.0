Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FACD2877D2
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760792663; cv=fail; b=VoHAp9ZyIAeartiwqAh6mA62AclzJnIIt5QRWxd3Cwv72Q7HLHRZVmPrEv3qhCuyPIE/RjpWHuuzL6YWKkV/Yi/l7hi8AH2RdhKdcmCrB9GaqmKchL/lF69U/9q9taAeSb1ObJ62grn2IWjtKTNlLxZ+Axo4CokJRekBeT2L5J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760792663; c=relaxed/simple;
	bh=oFRNPeXNAEXwnuV1LGoDQmemodoayw4cu5y414aggkA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bT8QGIodkB5sTbFIzl7xr4pSUQcmGbK3kpa6/Wh37WE9efbtDHYKBycp0TZhaku4T9F+swqP75Be1WNgguzm52z3JCucsZHvq5IG3MC5VGJhU8AenfG3S8HOLbJFj6H5iB+FClYHcOFu5CSOF9GUYdCZeeO0cPGhHzzMPLpcx4Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=RKtNCgpb; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=LD/3uzAi; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="RKtNCgpb";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="LD/3uzAi"
X-UUID: f450a0f4ac2211f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=oFRNPeXNAEXwnuV1LGoDQmemodoayw4cu5y414aggkA=;
	b=RKtNCgpbC1m5fheyBL8Cpd+L9bAR/Rox4IfbfMWNktBBDzNpHxKbFcBkPdDnKjMQSu2SvJo47CYyT800IcFp7pli5UhTnW6AtUAQ+qNEu7YqFXmGIPPBoevAv+sBvj5XNLXV83E1Scoc21yYvsRfGuydE/kdf230bwFMKz9bVfQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:8e11adf7-d1c9-4c83-90d7-746eda8a1a67,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:de1f5a86-2e17-44e4-a09c-1e463bf6bc47,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|52,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f450a0f4ac2211f0ae1e63ff8927bad3-20251018
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
	(envelope-from <zhengnan.chen@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 985646014; Sat, 18 Oct 2025 21:04:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 21:04:13 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 21:04:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v8p3FAR4guEy00u5/909l91UtxlEN1POdesDMSK4lBCgF2s4XlSaFZgmwZy+BNHuR8J81eetF933PG2Vw86EC4B4Tt+8AHzpMuy68Ng9L/43cmH9VK4RqS7/spgcTnZIZXszjP0L5YJpKGwP8K79ZxFfIBo2IjACstpzo3hJSWvDQ3H+xiIXXRpRnqqb63t+Zwls7iZhyEvvywGm5rurZlFZytwZxovPOq9CcPNv3niHF8o8glwEMslvpb05gjfqsRFKxyqAXhPiUWfoLYBjJ08/QlP9ao6WWAhv+bvJ38lm5kWfmyPyHu5+CxXjSkoI42GG1fueYcq5ewICXLX+AA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFRNPeXNAEXwnuV1LGoDQmemodoayw4cu5y414aggkA=;
 b=SFhnt7gDoCuj5Ewj3D6l66mSDUiA4GMRiYsxE4jScpzwYkfgAPKyNkEF9H6+XqkrkuGxx50IAGP36e6X2QK6lSXh+Hmq5rmWIbGfr5TulZTzQN+g61TwqGqmR8x4KaRnuOYqsPYw0jJJfFVCi0UBGivwHbeHHivf1rUUMTUzdJ/YDLD071NbODTW58WOY0ZRMHzM0Z53sMAJjOWE6c/Y5nE+Uv8/UoV3U+4/s5V+lzzVCQaNNdl/QBXu1p/A5MKigy7wjPGRC7iQ/eQRvmipmOYH9y3RQMCQnbv6J/bUsg6ru6/nAGZsV+L6DtvjxmkZfGo5WPDK8atHdEiLSCxExw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oFRNPeXNAEXwnuV1LGoDQmemodoayw4cu5y414aggkA=;
 b=LD/3uzAiggW99U9jJxGrmvr/HVBY6u7qW7s4hV3KaNyNjOcshEAaCHRF6LBl18tPNsGq2W7OjNM/WfCdNHca2cUDbRIbgBEwAQvxBfnZieUl1N0E/w//Q1xAi9lWmUL7rVgJNTet/jDBVgyq764mpt0n8JAa4qCraPhWY7Abkek=
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com (2603:1096:101:ac::12)
 by JH0PR03MB8073.apcprd03.prod.outlook.com (2603:1096:990:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 13:04:12 +0000
Received: from SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0]) by SEZPR03MB7007.apcprd03.prod.outlook.com
 ([fe80::641d:833a:915c:d1f0%5]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 13:04:11 +0000
From: =?utf-8?B?WmhlbmduYW4gQ2hlbiAo6ZmI5b6B5Y2XKQ==?=
	<Zhengnan.Chen@mediatek.com>
To: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	Project_Global_Chrome_Upstream_Group
	<Project_Global_Chrome_Upstream_Group@mediatek.com>, "robh@kernel.org"
	<robh@kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "will@kernel.org"
	<will@kernel.org>
Subject: Re: [PATCH v3 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
Thread-Topic: [PATCH v3 3/5] iommu/mediatek: mt8189: Add APU IOMMUs support
Thread-Index: AQHcPdNh+3rZt2Hle0ONITZTKIoDc7THMjaAgACxgoA=
Date: Sat, 18 Oct 2025 13:04:10 +0000
Message-ID: <903ccd6ee71f179a71a20cead597709dc3e9f507.camel@mediatek.com>
References: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
	 <20251015125532.9041-4-zhengnan.chen@mediatek.com>
	 <e7bd34b9bb34e9bd9538b2ce493e271d4688f4c5.camel@mediatek.com>
In-Reply-To: <e7bd34b9bb34e9bd9538b2ce493e271d4688f4c5.camel@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEZPR03MB7007:EE_|JH0PR03MB8073:EE_
x-ms-office365-filtering-correlation-id: b15044c2-3699-4511-8b44-08de0e46d468
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|366016|376014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?M1BPaGt1bnEzRSs2Vkk0NHVTN3JsaFg0U0ZvMUJyTmdlUExVaENuWFJVbW5L?=
 =?utf-8?B?aFQ5SzhtREh0MnJPeHNIUkdITTJUM05STFlhWWpaTERRRmQvRU9KNHZ0UWxl?=
 =?utf-8?B?N3hjYWRyQkdxV2ZpZUtiNlJDT2k2K2hpc3JBT1ZhWlNiNkxmcnlLU2NTeXV6?=
 =?utf-8?B?WGkyNW9UMUdIRHlWeGJRZ0laa01MaGF4aUdFU3ZzS0ppeTU5UGx2OFdHdFVW?=
 =?utf-8?B?eEZpam9zYU5PQmFVa3VVejlsUmtudmJScjNSSWRreU5pd25kVVVSTjJyVENI?=
 =?utf-8?B?amVFWExqeXdPM3hFekRDcW43dHBsVEdDcUpqSFI1b1ZzTkY1aTNHWGwraW1B?=
 =?utf-8?B?aFFGcldwL3BNYmU5ZTdzU0xhR3FLNk9CRHkxbTBVL3lBeEV4bi9pRXRPYVFn?=
 =?utf-8?B?OHpjdkNkdys0VjZEU0wwbWl0djgwN21lQ25XalY4OG90Nnk0Znk2VUlNUjhr?=
 =?utf-8?B?RG13OWFHZEwvazVvQ096MGNNUmhqd0x4c2dVd3FOMmFJWXhnNTVtQW5GclBB?=
 =?utf-8?B?U1N2N3BiMmFvNllDYm9HU1pBcWR0QnJ3T3ljODdCa2tYK2xSSDFDQVRvdWt3?=
 =?utf-8?B?Q01kNmllTERLNjFNNHQ5STJwZmt5MEFYcXcxVzlhWnFtSVpITGpudm5FUVZu?=
 =?utf-8?B?MUR0Qm5nSDgzY3BCYzlpNFlVRG1CbiswekFLdzQyYW4rVktBYWJwcDA0eVV4?=
 =?utf-8?B?TkpTaVN6bFUzQ05NR1krMEVpV3JZVEZmL1dZd043dUkzRitKNkNVb0tBZ3Vn?=
 =?utf-8?B?QmdoUEhYSHUyU2JPT3Ivc0NQWngvVEk3djhRS01LNWdSVU5ON014Vmp2VG5C?=
 =?utf-8?B?akUwUS9qd0JQQmc5OXNXeXh6TkNSdTFDc2tHVlkvR1JjKzVZTTRzRFZUajEw?=
 =?utf-8?B?ck0yU05QZHFNSmE3VVFDSUxiNmNUMHpZV21HOTlQcEQ5MlJUaE43TFZJZHZB?=
 =?utf-8?B?WjEwT0NrOWo4SUZnSjBYMXhmVEZnMG80ZXZKanIrRHNoZ2x4cUZYd0FSYmhx?=
 =?utf-8?B?WHZBNlYwV01KQk9DelNGd29Zdy9uTHp3cURSK3p1KzgrMUFWWVNQM2J0UUds?=
 =?utf-8?B?d0JNSHg3OHUvaWhLZ1NqQ1lDbjd1RTJGaDQ3eE53ZHZPV1pBTUpXV2toOHNS?=
 =?utf-8?B?ekpNZE4vVGVvUGJmQzFXaUxKZk1NRXRsSUFYMG9jS1dqREpaL2tWakNoWVRM?=
 =?utf-8?B?aS91eGRPOW9Wamp1TjlDQkt6d1loOUVVaGh3VkFKVUdVaVdnQTRFWU9TRkhq?=
 =?utf-8?B?NlRlWXFWOW9Cb2U1LzQrQzhuNU55YVJuVFB5L2lCeklmdXR4U2d4endBdXZ1?=
 =?utf-8?B?RUhaUUdsYkhvSGFXOWIzdXBEQ3Jad1gzTzYrdHdyOTlzcytoMlppbXoxY1F3?=
 =?utf-8?B?YW5pSE9FRXZGQW0yN2svNFJrT1g4TCtsSUZGUXMvckVWeXR5WVRwWU81c05j?=
 =?utf-8?B?VDlGME9IaVAvcnc5Zm85SzhYUkpMY3ZOQllVT2JjM1ZOUmRRN3dkUXBwVXU5?=
 =?utf-8?B?ZnoydFpHOGZkL0VxWWtxTnZ2OHJkc2VVK1FXcWhmd09ncG54WnVUempycmQ0?=
 =?utf-8?B?Zmh0emd0dnlVdzVuQWpYNmMwY0MzVGNSYjJXWVNKaXdJbEhWOXhMS241czJi?=
 =?utf-8?B?OVFDWmM3WndKZnA5OXRVaTNFQjFWVXFSVTBUejQ4V1I3SERhdHlhaGxyZ1JE?=
 =?utf-8?B?QnMrY3I2QWhvQnVzODYzcDRINFdhOFQ3TitwaDNnVnNCR3F6Y2ViMmh5aVBJ?=
 =?utf-8?B?ZEZyLytaakNyNWFNUVNlZEQyOXo4ekcvZXJla0hJTmFqQ0RwdXpQWi9heUJO?=
 =?utf-8?B?SVRJZDFLb1Ntck40N2lXMjZ4R2ROZlpBOWZiLzB0RXlXczArOHc0UEdBWGR5?=
 =?utf-8?B?bml6SFFEQlBtNWxFZDlwYmY3c1NkZjloK1R5V0dBZkdyZURXaTJtZzE3MkRJ?=
 =?utf-8?B?TmU3MjlvV2F5VmRURit4RjZHdGczaFlnU3JkTXl6cmJ4eUpSYzI2cGRXOThR?=
 =?utf-8?B?Y0NOc1VUVWNFMWtIeU5XUXptbkFwazJGY2YwL25QSWRmYmQ2RnRlTjVhdjJZ?=
 =?utf-8?Q?vFwEtf?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR03MB7007.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(366016)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N3hlNXUvaG11N1RwaWFxNm5ESWswQUMycEYyajRyMTlSYjVRaWJ4dFRWTTI0?=
 =?utf-8?B?QjM2NGFWYzc3SFY1YWFUOG9Oc2VuUTRUZU54OFBiL2RkSlR0U0F6bHFxOGIv?=
 =?utf-8?B?VEl5My9HeHpsYzdjUHJ0V0N1OWQvN1NOMnk3VEdLYjU2MXZOR2FVdEEvMmRS?=
 =?utf-8?B?bnBSbGhvaFE0OHZKMkpvV1YzZm53QUd4ZEk3UjJFMG9JYXBKdTg3eksyNUZF?=
 =?utf-8?B?bUhRR2gxakxLblhnTHl2eWRPTk9POXliNDlRZ0JMYk1IMnZMN3EwazNuRGxQ?=
 =?utf-8?B?bjAvR2ZxY0Z2T0grRjIxZFQyclhaRVh1bE42VkdzeE4xZ1gzbVllM29UTGdn?=
 =?utf-8?B?TlYzVjFmb0xkdWtMS3VTa3JVaDM3MTg5RENmemlKZ1BIUm5tS0xHdlZIM1dF?=
 =?utf-8?B?cEVJM2NBNE1lc1BQWmQweVZvNVFlcFl6QWhabGZNVklqUWVHVE41Vit1RGth?=
 =?utf-8?B?SGRYTGlDQ081b3crODZJYnNGT21oVVJRSXk2ejEyV0QwZlpUWTF6YTkvbmpU?=
 =?utf-8?B?QThvOGtzVFFwaHlQVHM1b3UvOEdIWkxESmxGMTk2VzFpZW9SYWkvK3l5Qzdk?=
 =?utf-8?B?b2dNVnRvVVdMNGZjRGVmUVR6MHhsUnZoMmdqMEd3dFZOK1BxSnhNTU9jRHBB?=
 =?utf-8?B?ci9NdStrSzVMNmxSeEVvR0JoeFRidUZic0JEQjg4NEVwUkNPTi83K1ROUDl2?=
 =?utf-8?B?OTVjREg3bXQwbWVPeEZrM0lIbDBDTXY2RDVYMmMySWlHcWhFMXdLVjMzUncy?=
 =?utf-8?B?NjU5TGozbmovcWVWMjFWMmlzQ3VVZ1ArMHhEaS9rWWlRNENiWU9TZWFvc2FT?=
 =?utf-8?B?N1ZvOUJSaG5mY3JjQ0t4L2NPYWFSL01mbXVlMHYvdVFkTytxczlCclFqRUZD?=
 =?utf-8?B?V3crcFBwU29tYlpUamlBcTVVM283cWtHNjMzTWtkdGFqVVU2SXV6VDBvaGh5?=
 =?utf-8?B?c0lnZ0RSZldtTXNlRHhSL0taTlhLdHhCcDhFc3F6eDFsUVpkQytyVzZ6YTJI?=
 =?utf-8?B?RWYyQnVjZDl1cVRkdkdjVnpGVmJBRzFQTFFvYjZOclpSWW5ydUwwTFFwYkFZ?=
 =?utf-8?B?MTRlWkxUUGxEMGlhUFlCR3AvejhRaGlva1lDMUx1bjVhdjBpbVVkbm1hUThN?=
 =?utf-8?B?QThSRW16M2FYTytvSE1mSkRudHEwZ1hkeEVuaWV1UHhpVFIxc200VjMvbmRp?=
 =?utf-8?B?UG5WdHdNd2tiZEg1ZWpUWEtWQ2ZCODdVd09TUGhLUU5uYy96bm1XY2FPM1Zx?=
 =?utf-8?B?ZmR1RkVIMFhlRWxaOHhDYVR2amViYXIwa3k5ZnNCeG0rYVFJM25aT1RoamZM?=
 =?utf-8?B?d0V0Q0Z0eGcxenNOMmRGMjNTb0llNGpyNlAzUVNPNHAwbk1qdG1EbmtYT1Fo?=
 =?utf-8?B?Ym0xNjFjQkZGVDVzMWRuaTJRbm9qckdTcGF5eUZsT2NEL1ZaVXhqclFYbXVm?=
 =?utf-8?B?TDZ3Zy9aNVZCbS9OUUZ0VEk4WVRaR1NQeFQrd0tUOUdmWFlGSDFUSW1SWEdU?=
 =?utf-8?B?QWhObkZkMlhJazRhN1VvVmVlL1I2RzVaMEdma096NHE2RmlaaVVqdy9jVmdL?=
 =?utf-8?B?eHpwOTRWaWw4Tk1ENmZ6RHptNTBubU5wR2JVelExWWpjNms3N3ZTM1EzZTlD?=
 =?utf-8?B?NnRHdjJzcFRkY1dRNmtJdExRUzN5eEd1QWNHU0FRVXFPWDM0RkRRV1NIdjF1?=
 =?utf-8?B?UEJhVy9lU2NIZDZZblEyK0lMVDczVXhaV3pob2lVeWxFeEphSUhuN1hacXV6?=
 =?utf-8?B?cU9abmQwSC9vWjJDWVdRSnNPdzRHVnNnRTlRU2VHVWttWVlqVlFFckZMckxn?=
 =?utf-8?B?MHg0MDZQQ1J5SVRJN1VMM3BPbEFVWHpFUnlVNE1LZkRuSVZKbEhONWpmZjdH?=
 =?utf-8?B?OGVZblFUNXlHMmxjRE9oZCtORmtJRDF0MWU1K3BZT3lyNzIyOWdpRGdCWmtk?=
 =?utf-8?B?Qm1FZS90NFFYSWN6bEN1QjBlOExsWGVXNjg1RUZwS1A5NUlWdytKZWRpQW1N?=
 =?utf-8?B?STNYOFVpMC9qd3llRUV3Y3ZqWmNscmwwMU1lZTlUSStKVHRzaG9XNDY2d2ha?=
 =?utf-8?B?NEJIeDU1MjdYOUl6c0dHVHVGSHNKMmdUa3BDb1hXRVhIVVd3Y3FLbXF4cDZ1?=
 =?utf-8?B?R2x3MGcrRG5mbWViMzBRNlE5WDZIM091aktGRW9wbU90NUlyTGVuaGJGZUVX?=
 =?utf-8?B?dVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A62EF64A9285A24F8140B98DB46BEE29@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEZPR03MB7007.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b15044c2-3699-4511-8b44-08de0e46d468
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 13:04:10.7150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kab/dC97wV5Pv++O8OKWOSPNdhkTmlKA59z+3CH8Il0EaEIO6qO/Mak1uS0qztU78xaMsN5yoTM+BREVF71mrPAJUO3EaLzG5d8srf14Tos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR03MB8073

T24gU2F0LCAyMDI1LTEwLTE4IGF0IDAyOjI4ICswMDAwLCBZb25nIFd1ICjlkLTli4cpIHdyb3Rl
Og0KPiBPbiBXZWQsIDIwMjUtMTAtMTUgYXQgMjA6NTUgKzA4MDAsIFpoZW5nbmFuIENoZW4gd3Jv
dGU6DQo+ID4gQWRkIHN1cHBvcnQgZm9yIG10ODE4OSBBUFUgSU9NTVVzLg0KPiA+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFpoZW5nbmFuIENoZW4gPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0K
PiA+IFJldmlld2VkLWJ5OiBBbmdlbG9HaW9hY2NoaW5vIERlbCBSZWdubyA8DQo+ID4gYW5nZWxv
Z2lvYWNjaGluby5kZWxyZWdub0Bjb2xsYWJvcmEuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L2lvbW11L210a19pb21tdS5jIHwgMzQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMzQgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jIGIvZHJpdmVycy9pb21tdS9tdGtfaW9t
bXUuYw0KPiA+IGluZGV4IDdhZjQ3YzU5YjEwYi4uOTk5ZjdiODU4MTY0IDEwMDY0NA0KPiA+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gPiArKysgYi9kcml2ZXJzL2lvbW11L210
a19pb21tdS5jDQo+ID4gQEAgLTEzOSw2ICsxMzksNyBAQA0KPiA+ICAvKiAyIGJpdHM6IGlvbW11
IHR5cGUgKi8NCj4gPiAgI2RlZmluZSBNVEtfSU9NTVVfVFlQRV9NTQkJKDB4MCA8PCAxMykNCj4g
PiAgI2RlZmluZSBNVEtfSU9NTVVfVFlQRV9JTkZSQQkJKDB4MSA8PCAxMykNCj4gPiArI2RlZmlu
ZSBNVEtfSU9NTVVfVFlQRV9BUFUJCSgweDIgPDwgMTMpDQo+ID4gICNkZWZpbmUgTVRLX0lPTU1V
X1RZUEVfTUFTSwkJKDB4MyA8PCAxMykNCj4gPiAgLyogUE0gYW5kIGNsb2NrIGFsd2F5cyBvbi4g
ZS5nLiBpbmZyYSBpb21tdSAqLw0KPiA+ICAjZGVmaW5lIFBNX0NMS19BTwkJCUJJVCgxNSkNCj4g
PiBAQCAtMTcyLDYgKzE3Myw3IEBAIGVudW0gbXRrX2lvbW11X3BsYXQgew0KPiA+ICAJTTRVX01U
ODE3MywNCj4gPiAgCU00VV9NVDgxODMsDQo+ID4gIAlNNFVfTVQ4MTg2LA0KPiA+ICsJTTRVX01U
ODE4OSwNCj4gPiAgCU00VV9NVDgxODgsDQo+IA0KPiBNb3ZlIGFmdGVyIG10ODE4OC4NCj4gDQpv
aywgaXQgd2lsbCBiZSBmaXhlZCBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KPiBSZXZpZXdlZC1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQo+IA0KPiBUaGFua3MuDQo=
