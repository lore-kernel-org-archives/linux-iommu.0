Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48381DC9A3
	for <iommu@lists.linux.dev>; Mon,  7 Jul 2025 07:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751873062; cv=fail; b=XzYFLZuMHBDzMbTRXRnylknOKSJcofEhQ9dHMHNIx26kZTsnjZugX01b1Oif2AKwklCrkz6xZ2wlObYOfV5LmxBhNImoxDnINd73fglLroL9uv8Yq6E2hsSSGVnzMKpQLixiCRd1O8GkeytqAeEaT9NGCyh/xhDWSWM8z+8rXDs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751873062; c=relaxed/simple;
	bh=uE6V12gh9TP2jh5Rp45wc/euvU6AoqI882H4MHWjdQE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rCLZOoWnkXB3Lz8zT7ue1B3mTIQks670BBdAiyFZRQVP8Mhe4IPOA+aplisDErqC6aaJbDP9kzX8xJSSOfyX42hAUdUuzoZJZdvhhXs6jDcpPI2NNDx9EAX/eDN0ToKIankAYKpQeg7GdsVz3xwxZt8f9Y0drptq6InKEGfYdfs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=XFZZs221; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=sA79DgF0; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="XFZZs221";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="sA79DgF0"
X-UUID: 62313ae65b0311f0b1510d84776b8c0b-20250707
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=uE6V12gh9TP2jh5Rp45wc/euvU6AoqI882H4MHWjdQE=;
	b=XFZZs221/1zsAAWImqYd/Urh90Jvfyt8H75zrQoG/YvD+Icm9rlgSJ5FRvQDxW9F3p0UcY8fkzhK6oPmJPsF80spZDvMW+KCT2WOusoAWFAp5e7cRbu8wMgGfWP78dvZQ7euaEUgR5p2m3gYCUyFbp3ettqApSrBVY3puYYTArU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:5c6466db-c255-4f41-a1c3-49d01d483f2f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:813fcb9c-b8a9-480a-b7e5-687022facff7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 62313ae65b0311f0b1510d84776b8c0b-20250707
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 534732547; Mon, 07 Jul 2025 15:24:13 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS09N1.mediatek.inc (172.21.101.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 7 Jul 2025 15:24:12 +0800
Received: from TYDPR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 7 Jul 2025 15:24:11 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vzc7tntkZ2H6gI3A1Aa+VEzSyB5bCeAvMD24VYcD0G1rE8Hl/AMN8OcvpPxaSWfJkH5zHFUB/mJBsN08LVUHSUfsDIzQ0IEMR1HfhVX5l+f7E9Lu/XNEAIyXj2K3RrpAko6JJiO2nlhg/pud91v3JBan+aoEUrILHYyPnR4zxydwZta/R4dFASQAPocsUV1LJKdTHEULtfO9mhxwxYvA6buds5ZOE2IutCoKK0KL+nvCIPuW/E9TSIBIjY3QdYQ60w8UYqAsbmPv+BFEsw84sZMbJObhrxH/f7vHiU2P+/xV6hEiNLTbg4KpFzaExPSiiJLBQwHDQtcbtV7B36F2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uE6V12gh9TP2jh5Rp45wc/euvU6AoqI882H4MHWjdQE=;
 b=X3BfJiSCbxGLVmDQ/eqcWzXmNW0xy13F75ld+zp7Lx3k3HKcPM+erJtQ2YX+IWjdlIzPL3kx9whfvIL/UTMZNurrU4aqezQWZIoEvMFnUxVG5B9bF6O9EIqLs5rF4xIaWf3Z6z0/l+1HyqwpvY41Aw0i/xX041d36EKeUyeJlwRG2tlivrUhK7Hv/Ptnvda9i2rEOCLdXCxMH39xBfFily9o+qjwSkg8K3H4cWRVuG1JDamvDJm9ygscHnabdNRcfzI4//2eY9yILZrEl8oumz9VhiTVBGVeCrnoYrbvJd1GLgy/Wuv3PnmK1qXqSLzzs32+P9BU8yYZh9y8IOJdOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uE6V12gh9TP2jh5Rp45wc/euvU6AoqI882H4MHWjdQE=;
 b=sA79DgF0eCF5z1ervfsrppKsSTDkiilO1WQNc6nFoFuqX3/AWyKl7GZyEhBHQjgtZAkM8gkxYLeafZ+Lfz2hPew0CLuz5bCgmZ0aMF3M/dtQfrGlsbGVVzhRqKpDs5rhyiRfxbpZ6fRnLfc1DBXTwjmmbdKP3u0quk8nASTqjgg=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYUPR03MB7032.apcprd03.prod.outlook.com (2603:1096:400:35e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 7 Jul
 2025 07:24:09 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.8901.024; Mon, 7 Jul 2025
 07:24:09 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Louis-Alexis Eyraud
	<louisalexis.eyraud@collabora.com>, "krzk@kernel.org" <krzk@kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: NULL pointer exception in drivers/memory/mtk-smi.c
Thread-Topic: NULL pointer exception in drivers/memory/mtk-smi.c
Thread-Index: AQHb35sr9sJ0vYwBmUGhzimWIcA3rLQgs4yAgAWtfgA=
Date: Mon, 7 Jul 2025 07:24:09 +0000
Message-ID: <1dbebbf290413eae9af13312028c2d19d3441a09.camel@mediatek.com>
References: <allge3h2abtjfj77idsnwccurxi2jnbcv6qcxar5f5m3jjmpvs@a4mmfghdhtv4>
	 <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
In-Reply-To: <lri2gdwioe3on3unzrnmezv4pnxke6lmixrsvargeupdcywweo@j6xoz36xjdoh>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYUPR03MB7032:EE_
x-ms-office365-filtering-correlation-id: 585de5b1-46aa-4c6e-cc2a-08ddbd2743a4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?d2ZVenFTSGtXRmJKZExHQzRCOUNENzR6cmV5TDlTRFIva3JmK0w3SXNEZFZX?=
 =?utf-8?B?aFJJUGJNNkNxSm5SRjdCS0trT1JiUmkxS2ZJaVJxY1p6aHd3VFQ4WVUzcTBT?=
 =?utf-8?B?bUl1NWk1b3pxTEIrcThpQjhEMTRVSFo2aDgzVEwyTFAxeWVtWEY1dmpyNnpl?=
 =?utf-8?B?VlFUdmM5ZmhJQzNDTkd2QkNlVGpNNDRaQXN0emZSa2lXSTdVVGdVSXFUTUJo?=
 =?utf-8?B?QjU2emE3eGcxTy84VFAvVWVMMWJjQVFEMThiVzlqV1NmZmNFR0RyMHV4T0dQ?=
 =?utf-8?B?eHY0L1I0TVM2WTNlVjZCL0VnNTNQcjErSVBkMUdOb3pDbG1TZitmb3Q2cTQ5?=
 =?utf-8?B?RnRSR1krelQ3dTRUY25zcXFTZll4bjI1ZnZLM1hqbTJUMEtqRkp5TmsvTS9Z?=
 =?utf-8?B?bjFHOFMzTHRkTXg0ck8ySE1IRzNJS1EyNmtGTWFwV3RwaDFVeTNTaXhqaytG?=
 =?utf-8?B?USt5OVlEQnhnVGYwV1JaSmRzd3NNM3FPdWNENjVWdWM3akZsRmNjcnYyK2Rr?=
 =?utf-8?B?eWdkQWViRklvbVpzNVVBZWNEcGlUSDhXVUoyaSt3ZjhLMURMTUcyVld5TmhX?=
 =?utf-8?B?eS8vOWFSbE9ySE9vNkthOWFWUG5PaFBxRURZS2FhblFrb2s1TFZYSEUwWjNr?=
 =?utf-8?B?RkU2V01pbkh1Njc3NnFhNmhZUEZEV25VbmRHM3lZTEx3RytFejZZZXo5bmhD?=
 =?utf-8?B?RCtJUFZpSk10ZHlVVFB3Z2o5alM2aTJnak5xbDZPc1UxMzJoeFRkQzE5R0Z3?=
 =?utf-8?B?RFdvVFZZNWZkV0dhakY2b1ZJc0ZZd2x5bXJUOEV3NG9UbTJhcUlld0R1d2pv?=
 =?utf-8?B?Qm1NaUNiU1RNS1ZFaFpUNG0wcENEcWlTbmsyMGtIYmNnMjJacW11emkrSyt5?=
 =?utf-8?B?akx1R1ZRS3Jzd1NQTW5GWWc3WDZYMnZLR3JEVXNVQkc3cXVEQ1hXV3habTVU?=
 =?utf-8?B?OUhhOHk5dFp2RzMwNXd2VFJXSDVwRFIrRjVxOTAxZ0VIQjVjMTJWcE5RWTE1?=
 =?utf-8?B?NTBqcW1NZ3JFTzlWckRPV3hEbHJFbUloZmxla0hYZWdtVnliOUg5QkFVeGNs?=
 =?utf-8?B?OEJ5R3dZdkVGcWVOb0VTNm5RWkM3TFJIem9sV1JnUFk2TFVkZldBVzFOdzJI?=
 =?utf-8?B?VVlYd1dRU016YjhoWmwvV3d1Qk9XRmRWNG5KQWtQRlJzZFNGU3NlUEpJb3lY?=
 =?utf-8?B?T21OVVFIS3FOZjNiakwySHU3cG5NblJHaHBKM0hBR0V2UHd1OFZXSVV3TUJx?=
 =?utf-8?B?eGhOQ3Exd0pOdzVORCs2R2NySEZTR0FxTU1vZ0lPWWg4UllqdGo0Sm1UOVYv?=
 =?utf-8?B?OExXY01Jb2V2TldzWUU4dHUrdjhRaXpHbENaakZnNVZGRkN6ZEEyU1ZRTUc1?=
 =?utf-8?B?S3VNSDJXOW1zL2Z1NGl2UkJ4V1FrdHFWcXYwWi96QkZMN2RSd1pCckEwbS9u?=
 =?utf-8?B?TXYzN3RaQktlVEVueTk3cjdCNXdaTDJoWnJ3YU5LWVAydHJGcWpVcUFhbEh1?=
 =?utf-8?B?Kzdpc1F5ZHllSGgzUzJhd1M2RGMxaHV5Qk8zUUZVRFBwekNiYXJ0RWtUSDgy?=
 =?utf-8?B?WnZsQjlubUR1cDZjbzFaUjZpRkdqc09qc0lOUHdlSDZNQmF3N1lQWHVVK2U0?=
 =?utf-8?B?V2xTWUFTRXUzbmdRM0RkNExvMVZLQ1l0K0U1dFhrZE5VWEdmWWlNSGQzc056?=
 =?utf-8?B?ZnQzSkRwRGhnQ3FiRjdxSFd6UkRrMUlkVE9Ua0NmM0dEZzVFSDA1ZHI0NXA4?=
 =?utf-8?B?RGd2TUFyVVhoTXY3TU92TGpEYWxxS1NEUEhNUFpqY2hJSklHaUU2bHJHNmVW?=
 =?utf-8?B?bVFXdjBXOS9tOExpSzJzK3pSdHF3SWNIZVBleCs1YUp6NksxSnBRQ2RCcVVL?=
 =?utf-8?B?TVd4TFNsd2gvL1dTVlpkSTJ0THJDSGVKVUZqdk9LZG9IR0cwc3dLam1yRzRJ?=
 =?utf-8?B?N2dDNURUQUNCRXpONU5zRGF0OWp4VTVBU3drVFJoRm83VGJrR1VVWUZrMjZr?=
 =?utf-8?B?RjNHcEY1N2xRPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SG55MmN1N2JZbjl4Rm9lUllaeHFyWEJtcnNsQVcrOGRmeWlkQytLSzJxK095?=
 =?utf-8?B?QitBVVZ4ZU9Mc1FWKzBoRjRQeXhXSmFCVmoyV1NYeHJOWk9GZ0VQS09nMVFO?=
 =?utf-8?B?dHpXbTZ5QS9XUEpWeFVaaHB1aUxsM3RRR1c3TVRwbHlVVXpOZExyakl0OHJF?=
 =?utf-8?B?V0Izd2txMENMc3hlSnRaempMUHR1K0x3eXdhbzFJRTNId2NXZm1YVGtyOUpH?=
 =?utf-8?B?cVJXT01BZEMxV2lQK2NTK3pTR2hxZk5jUzBPM0VkM3VvZEJROXFnSnpreVBq?=
 =?utf-8?B?Q29wZTR0Uk9lSUJ3MHlaSW82bGZQeGJTVXV2VzAwY1E1T2JGUSswYVJCaTFB?=
 =?utf-8?B?TjVTeXNCR1R0aklZeWN3R0dhcVlEQlc0bWVGdzNndlpjakhhRUdiTXVQYzY1?=
 =?utf-8?B?aUR0SUFVSGg0ZzJkZU5aSUlFRys1R3gyVnM4VmVpdTIwS1ZBT0RWak81VGFQ?=
 =?utf-8?B?VG8yOXRIRDdLS1RHNVZZeGlKOE9VbjU2MDJmT0M4VHJSZXlQYlE5NmswYWll?=
 =?utf-8?B?M0RsUnl1WHN0a0dnZ3U2YWJFdExPbmtrd1NaNzNQNTdqYWxqTkU1UjJvMVFQ?=
 =?utf-8?B?aWM2WXhYdE8zNGhiMnhOa3V6Q1Z3Z056bUI2YXBkNnFTL0NOV3Z0U0dDb05R?=
 =?utf-8?B?bXptRDE5UUxzemFQUEhVbDlFaFFaK2tDYWN1T09sWEIraVdFUWQwS09KdWdx?=
 =?utf-8?B?SzRDcHZnTU1vNWljSUdFTUdrQU5DSXYwQVd0bHc2Qmprb1JXeVZ2OFZXM0ZJ?=
 =?utf-8?B?U3RHR0FSSVBUUTJ1UkxQbXlRaXZjWVQzckZWNk5UT1oxWEkzNHlOUlRIZ00r?=
 =?utf-8?B?dm9wcGFCQ3d2M3F3KzU1SGlqWDVBUXd3VjBhZHQrTTFjWTN6M29kZ0hQSkJS?=
 =?utf-8?B?OWtnMElPYlFZQmtsVnI3dm1majd4c25LdEExYld1b01hV0ljbi9WR240T1Aw?=
 =?utf-8?B?aDhpS1pGOEt6dS9FSGZnR01mOXdOK2lRZkF4MUROdHZWK01MV242WUFpOFhm?=
 =?utf-8?B?bVRmRkRmOTI0S3VQWVFYdW1SRUZOUXVUVVVOeGZycllBK3dET21ENmhsUXZG?=
 =?utf-8?B?c29iY0Z4MmhDR00reGxJZnB1ZUdTK2ZBRU55MWFJVkw4bnBpYzBQTVM0MW43?=
 =?utf-8?B?SFU4TTNrOFlxQTB1bWVPc3ZaYUt0M2FuMmQyaGo1alRpN0dJUHQxMHI3YlJ1?=
 =?utf-8?B?c3ZtY2liWm5VZUYvZ1pJc2RxOS90cHBHaUxMcTVjSDZ4TW5ETGd0dWhvUExh?=
 =?utf-8?B?OW9RcmhSR09FVWdIaFBFaXl2UzZWY3Z4emZhMjQ4VFpIbEpEb0NoclkyK05S?=
 =?utf-8?B?MmNYKy9rUVhsOE0vNWVzN3lYQUV6Uk9NVE1aaUlFRHQrY0J0QWczTmNCY201?=
 =?utf-8?B?eHEvbit1NS9rTElzc2FlMTBPYUFWcVF6OVVIUUIwWllIQjFIVnVqY2N2MjRp?=
 =?utf-8?B?TXVFeFg3L2I3ak9pZ3d2dnIyWFk5cjRaZU1tMzhrbmFyK0VmK2lKbkQrQzdr?=
 =?utf-8?B?ZEcxOVJIYk5kemVTTWNxckJKcUNzNWJTcTQrQTVCOFJtd2llVm5Wem1uTE4r?=
 =?utf-8?B?OW1PaEx0OWNnUHFacVR0c0hXc3Jsa3ZzY1FkMXpabGJFN0F1MXVtNjRJMThr?=
 =?utf-8?B?QU5GOExyVVZTYnJTVjJxUUtndnFOejZvdDlMcVZEaEVQM0RURTFncEptR2dK?=
 =?utf-8?B?Nm9tTnluN3NiTGs0Qi95THhkem9TN2gwN1NwdXdOaGRLb05MaVJGTW9XWG5Y?=
 =?utf-8?B?WDBmc0pVaDBERjVvQ2txWGxiem9vejV1MUVoWDRFV1dNS1hCR0ZNdXBZb1p4?=
 =?utf-8?B?aCsxVkJvWWpOaW55alRIZWMxN3BnT050S0IvSmVYdjRDdEZFMmYvT3RNWVpz?=
 =?utf-8?B?RVR0R3VVR3d0dVRvYlB5a2F6cXFTT2ZVejhRWjQ5SnppSlNUelNGR0lyUlJ1?=
 =?utf-8?B?cFRLQUNhSnpOOGZ5RkRWM3pmdHB0WXVjQjFUUDhzYUtjdmFRdnBWRStpdnk3?=
 =?utf-8?B?RGJxVE9ObkR3cER5NW5MaGloZ1FFRjhxNFZEOVBvNkl3R0lYMXVXamJISHVF?=
 =?utf-8?B?RUZoSlhBdVZCOHRPVGZCcWZKWWtiWk9oRXhzellYTzEvbUp5YnJBUDBrV1VF?=
 =?utf-8?Q?L6uezLNfQTg4vjHNgm2KfIf/x?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8B3087566FC2834A8D35022A3303DC88@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 585de5b1-46aa-4c6e-cc2a-08ddbd2743a4
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jul 2025 07:24:09.2628
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ug1fzXIFTYVmm+ONEGMINBcuLPNVVWCiflmfJVPsrGcJwg/+/wtHc816HGt3RAhYAeJyHoYkIaxzfl+CuNN4wA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYUPR03MB7032
X-MTK: N

T24gVGh1LCAyMDI1LTA3LTAzIGF0IDE4OjQxICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90
ZToNCj4gSGVsbG8sDQo+IA0KPiBbZXhwYW5kaW5nIHRoZSBhdWRpZW5jZSBhIGJpdCBhY2NvcmRp
bmcgdG8gdGhlIGRyaXZlcnMgdGhhdCBhcmUNCj4gaW52b2x2ZWQNCj4gbm93IHRoYXQgdGhlIHBy
b2JsZW0gaXMgYmV0dGVyIHVuZGVyc3Rvb2RdDQo+IA0KPiBPbiBUdWUsIEp1biAxNywgMjAyNSBh
dCAwNToxODozMFBNICswMjAwLCBVd2UgS2xlaW5lLUvDtm5pZyB3cm90ZToNCj4gPiBvbiBhIDYu
MTYtcmMyIGtlcm5lbCBydW5uaW5nIG9uIGFuIG10ODM2NS1ldmsgSSBvY2Nhc2lvbmFsbHkgaGl0
DQo+ID4gdGhlDQo+ID4gZm9sbG93aW5nIGR1cmluZyBib290Og0KPiANCj4gSSBpbnZlc3RlZCBz
b21lIHRpbWUgbm93IHRvIHVuZGVyc3RhbmQgdGhlIGlzc3VlLiBTbyBoZXJlIGNvbWVzIHdoYXQN
Cj4gSQ0KPiB1bmRlcnN0b29kLCBtYXliZSB0aGF0IGhlbHBzIHNvbWVvbmUgdG8gc3BvdCB0aGUg
Zml4IHRvIHRoZSBkZXNjcmliZWQNCj4gcHJvYmxlbS4gDQo+IA0KPiBXaXRoIGEgY29uZmlndXJh
dGlvbiB0aGF0IGhhcyBhbGwgZHJpdmVycyBidWlsdC1pbiBidXQNCj4gDQo+IAlDT05GSUdfRFJN
X01FRElBVEVLPW0NCj4gCUNPTkZJR19NVEtfSU9NTVU9bQ0KPiANCj4gYW5kIA0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19p
b21tdS5jDQo+IGluZGV4IGNiOTVmZWNmNjAxNi4uZDQzMjBkYjdjZDJkIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lv
bW11LmMNCj4gQEAgLTEzODcsMTQgKzEzODcsMTUgQEAgc3RhdGljIGludCBtdGtfaW9tbXVfcHJv
YmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gIAkJZ290byBvdXRfbGlzdF9k
ZWw7DQo+ICANCj4gIAlyZXQgPSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIoJmRhdGEtPmlvbW11LCAm
bXRrX2lvbW11X29wcywgZGV2KTsNCj4gIAlpZiAocmV0KQ0KPiAgCQlnb3RvIG91dF9zeXNmc19y
ZW1vdmU7DQo+ICANCj4gIAlpZiAoTVRLX0lPTU1VX0lTX1RZUEUoZGF0YS0+cGxhdF9kYXRhLCBN
VEtfSU9NTVVfVFlQRV9NTSkpIHsNCj4gKwkJbXNsZWVwKDEwMDAwKTsNCj4gIAkJcmV0ID0gY29t
cG9uZW50X21hc3Rlcl9hZGRfd2l0aF9tYXRjaChkZXYsDQo+ICZtdGtfaW9tbXVfY29tX29wcywg
bWF0Y2gpOw0KPiAgCQlpZiAocmV0KQ0KPiAgCQkJZ290byBvdXRfZGV2aWNlX3VucmVnaXN0ZXI7
DQo+ICAJfQ0KPiAgCXJldHVybiByZXQ7DQo+ICANCj4gIG91dF9kZXZpY2VfdW5yZWdpc3RlcjoN
Cj4gDQo+IEkgY2FuIHJlbGlhYmx5IHRyaWdnZXIgdGhlIHJhY2UuDQo+IA0KPiBXaXRoIHRoYXQg
c2xlZXAgaW4gcGxhY2UgaW9tbXVfZGV2aWNlX3JlZ2lzdGVyKCkgY29tcGxldGVzIHF1aWNrbHkN
Cj4gd2hpY2gNCj4gZW5hYmxlcyBwcm9iaW5nIG9mIHRoZSBkZXZpY2VzIHdpdGggZHJpdmVycyBj
b250YWluZWQgaW4gdGhlDQo+IGRybV9tZWRpYXRlayBtb2R1bGUgKGJlY2F1c2UgdGhlIG1vZHVs
ZXMgYXJlIGxvYWRlZCBpbiBwYXJhbGxlbCBvbg0KPiBhIGRpZmZlcmVudCBDUFUpLg0KPiANCj4g
VGhlbiBnZW5lcmljIGRyaXZlciBjb2RlIGNhbGxzIHJlc3VtZSBvbiBhbGwgc3VwcGxpZXJzIGZv
ciBkZXZpY2VzIHRvDQo+IGJpbmQsIGFtb25nIHRoZW0gdGhlIGZvdXIgbGFyYiBkZXZpY2VzLiBI
b3dldmVyIGR1ZSB0bw0KPiBjb21wb25lbnRfbWFzdGVyX2FkZF93aXRoX21hdGNoKCkgbm90IGJl
aW5nIGNhbGxlZCB5ZXQsIHRoZSBsYXJiDQo+IGRldmljZXMNCj4gYXJlIG5vdCB5ZXQgYm91bmQg
dG8gdGhlIGlvbW11IGRldmljZSBhbmQgc28gbGFyYi0+bW11IGlzIHN0aWxsIE5VTEwuDQo+IFRo
ZSBsYXR0ZXIgaXMgYSBwcm9ibGVtIGluIG10a19zbWlfbGFyYl9jb25maWdfcG9ydF9nZW4yX2dl
bmVyYWwoKQ0KPiB3aGljaA0KPiBpcyBjYWxsZWQgZnJvbSBtdGtfc21pX2xhcmJfcmVzdW1lKCku
DQoNCkhpIFV3ZSwNCg0KVGhhbmtzIGZvciB5b3VyIGhlbHAuIEluIHRoaXMgY2FzZSwgaXQgbG9v
a3MgbGlrZSB0aGUgZGlzcCBwcm9iZSBvY2N1cnMNCmJlZm9yZSB0aGUgc21pX2xhcmJfYmluZCBv
cGVyYXRpb24sIHdlIG5lZWQgdG8gbGV0IGRpc3Agd2FpdCBmb3IgdGhlDQpiaW5kIHRvIGNvbXBs
ZXRlLg0KDQotLS0gYS9kcml2ZXJzL21lbW9yeS9tdGstc21pLmMNCisrKyBiL2RyaXZlcnMvbWVt
b3J5L210ay1zbWkuYw0KQEAgLTY2Niw2ICs2NjYsMTAgQEAgc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZA0KbXRrX3NtaV9sYXJiX3Jlc3VtZShzdHJ1Y3QgZGV2aWNlICpkZXYpDQogICAgICAgIGlm
IChNVEtfU01JX0NBUFMobGFyYi0+bGFyYl9nZW4tPmZsYWdzX2dlbmVyYWwsDQpNVEtfU01JX0ZM
QUdfU0xFRVBfQ1RMKSkNCiAgICAgICAgICAgICAgICBtdGtfc21pX2xhcmJfc2xlZXBfY3RybF9k
aXNhYmxlKGxhcmIpOw0KDQorICAgICAvKiBUaGUgbGFyYl9iaW5kIG9wZXJhdGlvbiBtYXkgYmUg
bGF0ZXIgdGhhbiB0aGUgbWFzdGVyIHByb2JlLiAqLw0KKyAgICAgICBpZiAoIWxhcmItPm1tdSkN
CisgICAgICAgICAgICAgICByZXR1cm4gLUVQUk9CRV9ERUZFUjsNCisNCiAgICAgICAgLyogQ29u
ZmlndXJlIHRoZSBiYXNpYyBzZXR0aW5nIGZvciB0aGlzIGxhcmIgKi8NCg0KDQpIaSBBbmdlbG8s
DQogRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb24/DQoNCg0KVGhhbmtzLg0KDQo+IA0KPiBJIGRv
bid0IGtub3cgd2hhdCB0aGUgcmlnaHQgZml4IGhlcmUgaXMsIGJ1dCBtYXliZSBzb21lb25lIGVs
c2UgZG9lcz8NCj4gDQo+IEJlc3QgcmVnYXJkcw0KPiBVd2UNCg==
