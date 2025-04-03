Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5122F23F422
	for <iommu@lists.linux.dev>; Thu,  3 Apr 2025 07:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665142; cv=fail; b=qvL9iq/LuDmLu521eeuVQfwcHYpKcmYcTgg6086tTPc0Q+1ZrMhSeqRZ3PaDnHsQfAYQN0/pkrZBOCMZlQjBVbgjP/ZhBsuhzZWmCDb791RJz/N+hCyHfpTqpX3NpAXAIYBo5QjvADbTUOpVNe+xGSitVlVdQu38rnXIsyS7RrY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665142; c=relaxed/simple;
	bh=v2k57w3spyjgMiFCRXiQw0dLjNGClsOUWHQtoY6KCqU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MLWGy88KoGRYpCbcDyk0r22Z/ZBVq6QdcpWow6PiQqBlIVbPe/VIE/cWQsRWZFFISMN8JzsWkfvSsppfbf0tHpRG5uw+NQPYpybaXquAZMVvxP9flCEa53JyAC0FulqGyUzUitQrWFoWVQmi+nHjkOTiv3oWHKFzmU2+6a4cWD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=D7jV/PKh; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=JhM23MSp; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="D7jV/PKh";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="JhM23MSp"
X-UUID: d362d72a105c11f0aae1fd9735fae912-20250403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=v2k57w3spyjgMiFCRXiQw0dLjNGClsOUWHQtoY6KCqU=;
	b=D7jV/PKhxwnK+H3r/pCyYLKa263OYG8nq8LMMGmTD9zJdz2luZ+9bU3aagzFgqMVCFuYHfUvMGfWvXPiy7NoyxT2DMnuEmhTDraFWl9/2HlfIERy508gOUVBEE4gZ0/IuRRsQV0t9Gym+kF/4uR7gvZ/DB80hBX1hmOSUitmsZk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:022eb37f-4de8-49d9-a054-3c0eab4ccbc9,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:0ef645f,CLOUDID:0c602d8d-f5b8-47d5-8cf3-b68fe7530c9a,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: d362d72a105c11f0aae1fd9735fae912-20250403
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1484728856; Thu, 03 Apr 2025 15:25:31 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Thu, 3 Apr 2025 15:25:30 +0800
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Thu, 3 Apr 2025 15:25:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GcN+hHv/Ho77kRox/2sjzZj8P3+njAP1l4nXsLAMzeup8llaeWO90WPrcwvSfOe4zHeWu+3/ZJ24etEC/52yY8Q4R3K0gHAY166qjcMieZOaryaJeGMwLv8utWJrmMmu367glQiUyIUhuirsfhRfE92IuIu1m0Bjfr1HEBw7xy4kJG1lFwp47PIHjJqbOl71Gh3pW+0kZo9TJO9KtLBIFvzItlVbs8YgzhGxqVWK3P1GZrSlsuElpvy8w860Lk6Nwxae3JQRfmc9g2TWKdEujekJ/kfsypUGxLoXCfv3qykqa/rsc/sNuQnpoRG51VzNwG+MpbCasWT35rytQ9b4Ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v2k57w3spyjgMiFCRXiQw0dLjNGClsOUWHQtoY6KCqU=;
 b=Ol+R7IUk47v+AIyyrPAsKurTPIElasynWm+l3ynLBsmlkiJOZcP29bQ4JrSQS+/c6KxF/rFAQ5zKB5Kc6YK7AAVx/mKELRZziH8EQGLK+6eusY9VRGsB9huRSa/CJVMNiVxXyyY5jFKC8ojUVSS0dJBm0EbPvLLJBuJSpwvdDUCoepcPzY7HWji2AvEkjHQxbC6DT7haMCtPteaGfTCUjzTTa5kQSKXqhJZmAvJisG2AQ+iLyDKYyf2l0Flwi6u69aMQt4O6CxrutGTCQZGIA3eBczc/M3lcmZBJMkDg2yheRz5Ogo2Wsp39mQsq5L8BB8gbXV8IgsP3QtVqWR7HIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v2k57w3spyjgMiFCRXiQw0dLjNGClsOUWHQtoY6KCqU=;
 b=JhM23MSp2szsyhxb9yB+PVkK6jJXBLqrla4qY45j/ROt8v7ITt7fSvqRoqPosXyS4Y3RwX8ZJDTsnEyl1LH8D7rnKJtNqORPEhecCK1mdxeg9K5l3c7NrFbabgUgKbzhG8RfPgbDKwoBhTDYs5ugsSvleSEtySSY6LrJgQvbRrs=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB8301.apcprd03.prod.outlook.com (2603:1096:101:1ac::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8583.43; Thu, 3 Apr 2025 07:25:26 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%5]) with mapi id 15.20.8583.041; Thu, 3 Apr 2025
 07:25:25 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "louisalexis.eyraud@collabora.com"
	<louisalexis.eyraud@collabora.com>, "robh@kernel.org" <robh@kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"will@kernel.org" <will@kernel.org>
CC: "jroedel@suse.de" <jroedel@suse.de>, "kernel@collabora.com"
	<kernel@collabora.com>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
Thread-Topic: [PATCH] iommu/mediatek: Fix NULL pointer deference in
 mtk_iommu_device_group
Thread-Index: AQHbnwWYw7AalrKX5kuusJlyJ705FLORlRaA
Date: Thu, 3 Apr 2025 07:25:25 +0000
Message-ID: <ffb19b2e42d3e99990cddaa13264e87561ab26d4.camel@mediatek.com>
References: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
In-Reply-To: <20250327-fix-mtk-iommu-error-v1-1-df969158e752@collabora.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB8301:EE_
x-ms-office365-filtering-correlation-id: cdf6b8cf-2ea0-439f-97eb-08dd7280b3e4
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?ZkxUQ0EwV0xUOG0yVWdrQTY5eStjeVNQRWlCUi9WS2VXY1RmelBhWHJSNXEy?=
 =?utf-8?B?eW5xdXlHNmp5Z0hkdWFiamV3SnZjQzRZVjN5elFyNCtLQ2hXRmtDT0ludUNh?=
 =?utf-8?B?NmVMSzAvME1zRk92SnNyRXc4dGNDUEY5WHg2cUtxa3FTckNnTmhaUDV6SXpD?=
 =?utf-8?B?UU5DcUxSMHNZcTltK0lTS0dJL0UyVXRDU2dMVE42NUhENDhnYm5iY0ZHZDZl?=
 =?utf-8?B?MTFkNTgyTnhEaTFMdEh4LzRneXVncHZwT3hRRFByWnJZZWJmZTNQOGFpNUpp?=
 =?utf-8?B?K1BDOGRvSENZa1ZYcVdnajZuaUMyL2ZqTnN0SkVJcmpyZVk2UExXR0pTLzZ4?=
 =?utf-8?B?UHlGM1hxdzNQcGo1SVZPN1RLWTN4c3JuL2dmaFpNaXc3alRZRXg5RUo2UzhH?=
 =?utf-8?B?VGZsN0t6SUVVQjBSOXhYaVdTYTBBMjVhWVQ0NEdqTElOdThhdjBlNGZTMG5M?=
 =?utf-8?B?eThncUp3M2dBcE1lQU1aeHN4T29DYnV1TytUL3hndzdPYnJyM3M5bzh5cU9Z?=
 =?utf-8?B?K01pRU9sNnlWTzhtbVVmU29XeWxudVBTODF1RUtLNzRxQnpDQVc0eis5QU1t?=
 =?utf-8?B?bDF5bFBmQVBhaXdaZ0o3aW1ZaTc3NjRteWtvMFI0RU44MzhqRVdRNWh6VXVQ?=
 =?utf-8?B?dmxwL01sTzdBQTV4MmZYNkppNlB4SE1xcnRYK20reVBicHpmTTN3YUlVWXpu?=
 =?utf-8?B?ajlLMlFDQ3FrTEFVUkhJUk1EckVORUphaFZzem9SV2V1UlYzTG03ZkNTcm1U?=
 =?utf-8?B?K0hWMzF4VEdCSnV6dW5oQXYvTnNqL05NM3BXeVFpU2MxTTAyNFQveGpVT3Ex?=
 =?utf-8?B?S1h6WFBMSkk2Rk5mTGpwMXpzRmxvYi9HNU81VHFKbCsvSExsR0R6c0pTNmpC?=
 =?utf-8?B?enBXR0s5emZJNTZaT1BMMy94K3RxVXIxbFR4R3JnaGlSNE9tdmFHaTU0ZEw4?=
 =?utf-8?B?djBmdFVZd3ZoYjhxMm0rc1dtMVNUNFJIUURsM21kWnRPdWczWjBlOVBOZjFo?=
 =?utf-8?B?d3RCbm9xbERoL0k1czBUbjZkMDVXVTBnNDZKaU9QOUsxa1VDeFJpRVFMZUts?=
 =?utf-8?B?eDJEa3J1cFZlNk41RFRpR0FpSmJFcTE3WHBuaDZWQjNkS0EvN3hCaUxQakJl?=
 =?utf-8?B?c1hoZ1BJU3RVZnkwa3J5ZXh6MHFFaTlPeHF1UUJJRjFWdG8xZktaV01nZExl?=
 =?utf-8?B?VnV5VlBEc1V6Ui92cmpnTEdMVVRpaGdKalZvb3pzekFqTDJLa1pzS2U4MGVZ?=
 =?utf-8?B?dGN1VHFsdU9mZmwrcU94OVo5bHJlVXNNZGxsYm1wRmdpdTlOenhvcThqSm1F?=
 =?utf-8?B?NTlaWnVJSnpQT3VKaGV0UnZPNDlsdnYrM0hjdGl0Sk9RVXA0d3VzeU1TYUZW?=
 =?utf-8?B?RUc2Z0thVEo3N3A4MXg3a0RLb1AwVU5yQno0MjM1QmZEYnVkOHVoT3g0eVBR?=
 =?utf-8?B?d3hOM0xuaUNFVTN5UWxDY3hJaDhwOHB1aU1kTVRid1dIVndNUHkxcmdxeHRk?=
 =?utf-8?B?TmN5MUlWSnJPZXpvSXpVNVBhQmpOUlVwdTJTOE5IZktPNmtnT0hmL01laHBR?=
 =?utf-8?B?c00zWUlNUERPc3NST3hSMWloSFpLMGU4cHlnaHB3Qkl3MlpyMktnamtBZ0Vy?=
 =?utf-8?B?bVZ6K3N6V3ozc0FtRm5XbFBmbVZNR21DanpKUjZCN1QwWHJ6SVN2d2tVa2VJ?=
 =?utf-8?B?Z0hKazNFQkNKOHBQMnFldEhLNjRHVUVRcUpUV2kza1JVWHQxanpIVkNsa0lP?=
 =?utf-8?B?V1Jxb3hUS0hoaEJoaHVkamo4UHh2WWdZMUt1c0ErU0tmS216cXVBa0ZEUDA3?=
 =?utf-8?B?c2VZUWxhbVdCdldxdCtkNTU0MSswbFIwakhRVm5hSkVxeDV3dUlMMkpHZHhM?=
 =?utf-8?B?ODQ3T2JoVjU1Z3JlOW44TVZhQkJLRUlPN08ySys5UVhNUlVad2Zlems4ckdu?=
 =?utf-8?B?VlFCOVVjQ1NBeWxsREFRN3U5U3ZIcHFPclJBNENxMDBQOFlZcERVUEVzSFlO?=
 =?utf-8?B?eEM1enpqN0Z3PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THNSbUNTWXRvY1E0WjFiSzU1czlzZkhFVUVHNTQ4dW10Y21veFJTUG9RM09a?=
 =?utf-8?B?YmJieHNOckhyNXFEZkRGeSsyYWNXVUNyT1VFOGRKbFE2OFZkc0RFSFhGTVRO?=
 =?utf-8?B?dWgxWnlNSmUxVGNFQS9RVVZaT1hoYkFFcHNISDByZllNTEprNTY4UG5NRkFY?=
 =?utf-8?B?anM0Y3YrRllac1ZNeVlHbThzNHBhaXdnS3JxVWpsczZqdGNVY2cvTzI4Nmtx?=
 =?utf-8?B?WDZqME9SYTJKREtJVVBXMEhrVnVMWVBEWmpreHdBWk9uWStuYTlTWUlvbk5z?=
 =?utf-8?B?RENDT1NBWlRkZ3NjRnRvb3dBczRKNUJRZ0FFaHdwWkx2RWpYcTl2N3pOWEcr?=
 =?utf-8?B?OHNmVXVsbUVRWmp3K2hVRnVFclVSeUdEaUgzZm1PNmQrNXZRUGw4d2d0NDNn?=
 =?utf-8?B?clhpRFY5cVVyb1ZZVE5zRWh2bG90cmFRdVNHSFY2eDgwRmxRbXNkV3RzRVB4?=
 =?utf-8?B?c3VkaDU1TUQ4QVlickVtRHorclVLdFI2bUdrSUFoNFJxZVpzMWhTbEl5cnJN?=
 =?utf-8?B?WlNpaGR5VTRScnNRK1hzemk1dzBrampsOFRxdGVEeU8ySFV3N0VKL1gzQ2hs?=
 =?utf-8?B?Zmo3SFBWQjVHT1hSYytnN1BiT2lGTGV3bTdjTXQxR2pnM2JxUnJQbHEvVFpG?=
 =?utf-8?B?Vm4rWHFIdkN4RERHaThnQXo0aVQ0eHVVQ0dwWGhFUzkwUU10Qmp0SXlwcFdv?=
 =?utf-8?B?MkpxOE00MUNkaFNXRTVVbkpKSkd0RVdhTER0aW43elpiTFk3ejFNbENiRzlC?=
 =?utf-8?B?M091QmU0V1F1NFB4TDFtY1gxZzlGUFRrSGxZQ2R3azJYM1Fsd3ZVelg3SGNU?=
 =?utf-8?B?amFuVkFUYTVjcWhlK0dhRFBCNEZNYjNlRUs5NFYzNDNEcmVYTVQ2a3I5bHk4?=
 =?utf-8?B?VGo4NTE0S1FKTWxPaFJXNi96VlowaGJtSDJGSHBTZkVkQmp2cUdQZWYyekxo?=
 =?utf-8?B?dEpQYXZyU0NPVHhMZGpQM0IzbjlTTytPMGpDM3FiVGlxR0ZtOCttanBOM1VL?=
 =?utf-8?B?aHlRUWlvR1JRV0xWQ3cvTDdxdnlvL2tZclYwcjNBZHFVSDlnYzlKdit1L2hu?=
 =?utf-8?B?RnlxYno0Yk9NMDdoQU4wOU9PM04yV1JLd2RTMXRQblcyS2V2SVBCYks0b2lE?=
 =?utf-8?B?bjM2TlhPbDlFSjkvQ2YvTTFMR0hwOFprdFhJdE9qTEhndjRJbjUxVituaTFp?=
 =?utf-8?B?UXZLajlDd1Y4ajFXNGNhOGxSNm5INGNYZmtudnl4THZkNU1ZZUFhazJnbytz?=
 =?utf-8?B?cXpBeis0QWdJSm01OUJ6clFTM0U3K1RWVVd5SC9LU2ovNlNKdm1OSnVRcnZy?=
 =?utf-8?B?d3h1SlZ1OXJYVGZJTjJkOWJ5MDRJVVRQem9haUNueUQvUzJ2S295eklHN1Vn?=
 =?utf-8?B?Z1hFeGJRZEdUUjU2cU9FZjNzUnZ5dDl2RVJYc0NsVWJKd2JvK2F4R3dBd2tB?=
 =?utf-8?B?Mi9pM1M0UUhxcVpjTk5NUEVpOThGSjJhRkljMm9DSkhRS1pBakYvbW5DSDZ2?=
 =?utf-8?B?YWJMcjN1bUxRbVBnaDZMT2pSR0VrU3BUWkdUSkgxcnZMMDJkS0tOaWlaNjgr?=
 =?utf-8?B?M1FpWkUwbnBuSXdtSGVwYmN0ZkdYNUxMSkVIb0d6MExpaE5GRlU3eDE4SzNE?=
 =?utf-8?B?SDVSN21HVWRtcmlvZnlGWkZsM0QxU3pDb2pMYWdOY1VzUW4yYVFNSTlWTWxB?=
 =?utf-8?B?UTdINU9ySlBCblpnNjB4UXhJajd5d3hVcjFjY3d6bkorK1VHb04rSTFNdEVR?=
 =?utf-8?B?THFhcFR6T1dIcXZGS0MwQ2s5K0Z6N1pKYWRRdForYlE0R1lrc0IvZ3Jub2xk?=
 =?utf-8?B?dnByRVRkQ3lQNUNpdE1EbHhzVE9MOFFnb0E2Z29CQVgyRUp1Z3JldStna2g0?=
 =?utf-8?B?YmhJdm8vZERSaEZUQ3BobGVvZm90RDRVdGR4U01hT0xGbGQ0YS9EQ3VEekVl?=
 =?utf-8?B?YkZtQmYvL0orZVhBVHhuUmwrRXBVNlRqRHlkT0ttWGpmQkp3QkVycjFrRlhS?=
 =?utf-8?B?S0Y0dkYwYVlCOFprSS9rck4wTE9DUFhLTjM5dENFSDMvS3BkS0VHcFRQM0tq?=
 =?utf-8?B?Z1VYYURLUU9kSmlCYXM1YldJTWhROGdsZGNHcEJsZldIV2JtSUF4MlZzYnBl?=
 =?utf-8?Q?To0+NYBwGzhgDA5ZBGVJityCk?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF072F809C8E9543A8046DAC74F4156A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdf6b8cf-2ea0-439f-97eb-08dd7280b3e4
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2025 07:25:25.5799
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GeysDNDchm6/46N5fEZEdXxrC37alFk6tvKEqV2JVLZBKwtJCfqe2IFJ3ynkP6TYQ3vFpcZylButNvIwZAvbGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB8301
X-MTK: N

T24gVGh1LCAyMDI1LTAzLTI3IGF0IDExOjQ2ICswMTAwLCBMb3Vpcy1BbGV4aXMgRXlyYXVkIHdy
b3RlOg0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Igb3Bl
biBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9yIHRo
ZSBjb250ZW50Lg0KPiANCj4gDQo+IEN1cnJlbnRseSwgbXRrX2lvbW11IGNhbGxzIGR1cmluZyBw
cm9iZSBpb21tdV9kZXZpY2VfcmVnaXN0ZXIgYmVmb3JlDQo+IHRoZSBod19saXN0IGZyb20gZHJp
dmVyIGRhdGEgaXMgaW5pdGlhbGl6ZWQuIFNpbmNlIGlvbW11IHByb2JpbmcNCj4gaXNzdWUNCj4g
Zml4LCBpdCBsZWFkcyB0byBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgaW4gbXRrX2lvbW11X2Rl
dmljZV9ncm91cA0KPiB3aGVuDQo+IGh3X2xpc3QgaXMgYWNjZXNzZWQgd2l0aCBsaXN0X2ZpcnN0
X2VudHJ5IChub3QgbnVsbCBzYWZlKS4NCj4gDQo+IFNvLCBjaGFuZ2UgdGhlIGNhbGwgb3JkZXIg
dG8gZW5zdXJlIGlvbW11X2RldmljZV9yZWdpc3RlciBpcyBjYWxsZWQNCj4gYWZ0ZXIgdGhlIGRy
aXZlciBkYXRhIGFyZSBpbml0aWFsaXplZC4NCj4gDQo+IEZpeGVzOiA5ZTNhMmE2NDM2NTMgKCJp
b21tdS9tZWRpYXRlazogQWRhcHQgc2hhcmluZyBhbmQgbm9uLXNoYXJpbmcNCj4gcGd0YWJsZSBj
YXNlIikNCj4gRml4ZXM6IGJjYjgxYWM2YWUzYyAoImlvbW11OiBHZXQgRFQvQUNQSSBwYXJzaW5n
IGludG8gdGhlIHByb3Blcg0KPiBwcm9iZSBwYXRoIikNCj4gU2lnbmVkLW9mZi1ieTogTG91aXMt
QWxleGlzIEV5cmF1ZCA8bG91aXNhbGV4aXMuZXlyYXVkQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0K
PiBUaGlzIHBhdGNoIGZpeGVzIGEgTlVMTCBwb2ludGVyIGRlcmVmZXJlbmNlIHRoYXQgb2NjdXJz
IGR1cmluZyB0aGUNCj4gbXRrX2lvbW11IGRyaXZlciBwcm9iZSBhbmQgb2JzZXJ2ZWQgYXQgbGVh
c3Qgb24gc2V2ZXJhbCBNZWRpYXRlaw0KPiBHZW5pbyBib2FyZHM6DQo+IGBgYA0KPiBVbmFibGUg
dG8gaGFuZGxlIGtlcm5lbCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2UgYXQgdmlydHVhbCBhZGRy
ZXNzDQo+IDAwMDAwMDAwMDAwMDAwMDANCj4gTWVtIGFib3J0IGluZm86DQo+ICAgRVNSID0gMHgw
MDAwMDAwMDk2MDAwMDA0DQo+ICAgRUMgPSAweDI1OiBEQUJUIChjdXJyZW50IEVMKSwgSUwgPSAz
MiBiaXRzDQo+ICAgU0VUID0gMCwgRm5WID0gMA0KPiAgIEVBID0gMCwgUzFQVFcgPSAwDQo+ICAg
RlNDID0gMHgwNDogbGV2ZWwgMCB0cmFuc2xhdGlvbiBmYXVsdA0KPiBEYXRhIGFib3J0IGluZm86
DQo+ICAgSVNWID0gMCwgSVNTID0gMHgwMDAwMDAwNCwgSVNTMiA9IDB4MDAwMDAwMDANCj4gICBD
TSA9IDAsIFduUiA9IDAsIFRuRCA9IDAsIFRhZ0FjY2VzcyA9IDANCj4gICBHQ1MgPSAwLCBPdmVy
bGF5ID0gMCwgRGlydHlCaXQgPSAwLCBYcyA9IDANCj4gdXNlciBwZ3RhYmxlOiA0ayBwYWdlcywg
NDgtYml0IFZBcywgcGdkcD0wMDAwMDAwMTAxMzgwMDAwDQo+IFswMDAwMDAwMDAwMDAwMDAwXSBw
Z2Q9MDAwMDAwMDAwMDAwMDAwMCwgcDRkPTAwMDAwMDAwMDAwMDAwMDANCj4gSW50ZXJuYWwgZXJy
b3I6IE9vcHM6IDAwMDAwMDAwOTYwMDAwMDQgWyMxXSAgU01QDQo+IE1vZHVsZXMgbGlua2VkIGlu
OiBidHVzYiBidHJ0bCBtdDYzMTVfcmVndWxhdG9yIGJ0aW50ZWwNCj4gbXRrX3Zjb2RlY19kZWMN
Cj4gICBidG10ayB2NGwyX3ZwOSBidGJjbSBtdGtfdmNvZGVjX2VuYyB2NGwyX2gyNjQgbXRrX3Zj
b2RlY19kYmdmcw0KPiAgIGJsdWV0b290aCBtdGtfanBlZyBlY2RoX2dlbmVyaWMgbXRrX3Zjb2Rl
Y19jb21tb24gbXRrX2pwZWdfZW5jX2h3DQo+ICAgbXRrX2pwZWdfZGVjX2h3IGVjYyB2NGwyX21l
bTJtZW0gcmZraWxsIHZpZGVvYnVmMl9kbWFfY29udGlnDQo+ICAgdmlkZW9idWYyX21lbW9wcyB2
aWRlb2J1ZjJfdjRsMiB2aWRlb2RldiB2aWRlb2J1ZjJfY29tbW9uIG1jDQo+ICAgbXQ2MzYwX2No
YXJnZXIgbWNwMjUxeGZkIGl0NTIwNSBnb29kaXhfdHMgY2FuX2RldiBwYW5mcm9zdA0KPiAgIGRy
bV9zaG1lbV9oZWxwZXIgZ3B1X3NjaGVkIGx2dHNfdGhlcm1hbCBtdGtfc3ZzIG10a19hZHNwX21h
aWxib3gNCj4gICBzbmRfc29jX2RtaWMgbXRrX3NjcCBtdGtfcnBtc2cgbXRrX3NjcF9pcGkgbXRr
X2NtZHFfbWFpbGJveA0KPiAgIG1lZGlhdGVrX2NwdWZyZXFfaHcgc3BtaV9tdGtfcG1pZiBmdXNl
IGRtX21vZCBpcF90YWJsZXMgeF90YWJsZXMNCj4gICBpcHY2IG1lZGlhdGVrX2RybSB0Y3BjaV9t
dDYzNjAgZHJtX2Rpc3BsYXlfaGVscGVyIGRybV9jbGllbnRfbGliDQo+ICAgdGNwY2kgZHJtX2Rt
YV9oZWxwZXIgZHJtX2ttc19oZWxwZXIgdGNwbSBkcm0gbXRrX211dGV4IG10a19tbXN5cw0KPiAg
IHR5cGVjIHJ0Y19tdDYzOTcgbXRrX2NtZHFfaGVscGVyIHBoeV9tdGtfcGNpZSBwY2llX21lZGlh
dGVrX2dlbjMNCj4gICBkd21hY19tZWRpYXRlayBzdG1tYWNfcGxhdGZvcm0gc3RtbWFjIHB3bV9t
dGtfZGlzcCBwY3NfeHBjcyBwd21fYmwNCj4gICBiYWNrbGlnaHQNCj4gQ1BVOiA1IFVJRDogMCBQ
SUQ6IDEyIENvbW06IGt3b3JrZXIvdTMyOjAgTm90IHRhaW50ZWQgNi4xNC4wLW5leHQtDQo+IDIw
MjUwMzI2ICM0IFBSRUVNUFQNCj4gSGFyZHdhcmUgbmFtZTogTWVkaWFUZWsgR2VuaW8gMTIwMCBF
VkstUDFWMi1FTU1DIChEVCkNCj4gV29ya3F1ZXVlOiBldmVudHNfdW5ib3VuZCBkZWZlcnJlZF9w
cm9iZV93b3JrX2Z1bmMNCj4gcHN0YXRlOiA4MDQwMDAwOSAoTnpjdiBkYWlmICtQQU4gLVVBTyAt
VENPIC1ESVQgLVNTQlMgQlRZUEU9LS0pDQo+IHBjIDogbXRrX2lvbW11X2RldmljZV9ncm91cCsw
eDJjLzB4ZTANCj4gbHIgOiBfX2lvbW11X3Byb2JlX2RldmljZSsweDEzMC8weDQ5MA0KPiBzcCA6
IGZmZmY4MDAwODI3YjM5NzANCj4geDI5OiBmZmZmODAwMDgyN2IzOTcwIHgyODogZmZmZjAwMDBj
MDAyODAwMCB4Mjc6IGZmZmY4MDAwODE2NGYyYjgNCj4geDI2OiBmZmZmMDAwMGNiYzQ3MTMwIHgy
NTogZmZmZjgwMDA4MDk2YTlmMCB4MjQ6IGZmZmY4MDAwODE2NGY1YTgNCj4geDIzOiBmZmZmODAw
MDgyNjg0YjYwIHgyMjogZmZmZjgwMDA4MjdiM2E4MCB4MjE6IGZmZmYwMDAwY2JjNDcxMzANCj4g
eDIwOiBmZmZmZmZmZmZmZmZmZmVkIHgxOTogZmZmZjAwMDBjMTE3YzAxMCB4MTg6IDAwMDAwMDAw
MDAwMDAwMDANCj4geDE3OiA2ZjcwMmQ2MTZkNjQyZDY0IHgxNjogNjU3NDYzNjk3Mjc0NzM2NSB4
MTU6IDAwMDAwMDAwMDAwMDAwMDINCj4geDE0OiAwMDAwMDAwMDAwMDAwMDAwIHgxMzogMDAwMDAw
MDAwMDEyOGQ1NSB4MTI6IDZmNjMyZDYxNmQ2NDJlMzANCj4geDExOiAwMDAwMDAwMDAwMDAwMTAw
IHgxMDogMDAwMDAwMDAwMDAwMDAwMSB4OSA6IDAwMDAwMDAwMDAwMDAyMjANCj4geDggOiAwMTAx
MDEwMTAxMDEwMTAxIHg3IDogZmZmZjAwMDBjMTE3YzAxMCB4NiA6IDMwNmM3NjZmMmM3Mjc0NjEN
Cj4geDUgOiAwMDAwMDAwMDAwMDAwMDAwIHg0IDogZmZmZjAwMDBjMTBhMmRlOCB4MyA6IGZmZmYw
MDAwYzEwYTJlNzANCj4geDIgOiBmZmZmMDAwMGMwMWE0NjAwIHgxIDogMDAwMDAwMDAwMDAwMDAw
MCB4MCA6IGZmZmYwMDAwYzY1NDcwYzANCj4gQ2FsbCB0cmFjZToNCj4gIG10a19pb21tdV9kZXZp
Y2VfZ3JvdXArMHgyYy8weGUwIChQKQ0KPiAgX19pb21tdV9wcm9iZV9kZXZpY2UrMHgxMzAvMHg0
OTANCj4gIHByb2JlX2lvbW11X2dyb3VwKzB4M2MvMHg3MA0KPiAgYnVzX2Zvcl9lYWNoX2Rldisw
eDdjLzB4ZTANCj4gIGlvbW11X2RldmljZV9yZWdpc3RlcisweGQ4LzB4MjJjDQo+ICBtdGtfaW9t
bXVfcHJvYmUrMHgyNzAvMHg1M2MNCj4gIHBsYXRmb3JtX3Byb2JlKzB4NjgvMHhkOA0KPiAgcmVh
bGx5X3Byb2JlKzB4YmMvMHgyYzANCj4gIF9fZHJpdmVyX3Byb2JlX2RldmljZSsweDc4LzB4MTIw
DQo+ICBkcml2ZXJfcHJvYmVfZGV2aWNlKzB4M2MvMHgxNTQNCj4gIF9fZGV2aWNlX2F0dGFjaF9k
cml2ZXIrMHhiOC8weDE0MA0KPiAgYnVzX2Zvcl9lYWNoX2RydisweDg4LzB4ZTgNCj4gIF9fZGV2
aWNlX2F0dGFjaCsweGEwLzB4MTkwDQo+ICBkZXZpY2VfaW5pdGlhbF9wcm9iZSsweDE0LzB4MjAN
Cj4gIGJ1c19wcm9iZV9kZXZpY2UrMHhiNC8weGMwDQo+ICBkZWZlcnJlZF9wcm9iZV93b3JrX2Z1
bmMrMHg5MC8weGM4DQo+ICBwcm9jZXNzX29uZV93b3JrKzB4MTQ4LzB4Mjg0DQo+ICB3b3JrZXJf
dGhyZWFkKzB4MmNjLzB4M2NjDQo+ICBrdGhyZWFkKzB4MTJjLzB4MjA0DQo+ICByZXRfZnJvbV9m
b3JrKzB4MTAvMHgyMA0KPiBDb2RlOiBiNDAwMDUwMCBmOTQwMWMwMSA5MjgwMDI1NCBmOTQwOTgy
MSAoZjk0MDAwMzUpDQo+IC0tLVsgZW5kIHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQ0KPiBg
YGANCj4gDQo+IEkndmUgdGVzdGVkIHRoaXMgcGF0Y2ggb24gTWVkaWF0ZWsgR2VuaW8gNTEwLUVW
SyBhbmQgMTIwMC1FVksgYm9hcmRzDQo+IHdpdGggYSBrZXJuZWwgYmFzZWQgb24gbGludXgtbmV4
dCAodGFnOiBuZXh0LTIwMjUwMzI3KS4NCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21t
dS5jIHwgMjUgKysrKysrKysrKysrKy0tLS0tLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvaW9tbXUvbXRrX2lvbW11LmMgYi9kcml2ZXJzL2lvbW11L210a19pb21tdS5jDQo+IGluZGV4
DQo+IDAzNGIwZTY3MDM4NGEyNGRmMTAxMzBjYmJmZjk1Y2U4ZTBiYzA5MmQuLjE0YWRiOTZhMzdi
YjBkODRiNjMxMTg4ZTQ4ZA0KPiBkOGI5MzY4MjFhNzE3IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJz
L2lvbW11L210a19pb21tdS5jDQo+ICsrKyBiL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4g
QEAgLTEzNzIsMTUgKzEzNzIsNiBAQCBzdGF0aWMgaW50IG10a19pb21tdV9wcm9iZShzdHJ1Y3QN
Cj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgICAgICAgIHBsYXRmb3JtX3NldF9kcnZkYXRh
KHBkZXYsIGRhdGEpOw0KPiAgICAgICAgIG11dGV4X2luaXQoJmRhdGEtPm11dGV4KTsNCj4gDQo+
IC0gICAgICAgcmV0ID0gaW9tbXVfZGV2aWNlX3N5c2ZzX2FkZCgmZGF0YS0+aW9tbXUsIGRldiwg
TlVMTCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJtdGstaW9tbXUu
JXBhIiwgJmlvYWRkcik7DQo+IC0gICAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGdv
dG8gb3V0X2xpbmtfcmVtb3ZlOw0KPiAtDQo+IC0gICAgICAgcmV0ID0gaW9tbXVfZGV2aWNlX3Jl
Z2lzdGVyKCZkYXRhLT5pb21tdSwgJm10a19pb21tdV9vcHMsDQo+IGRldik7DQo+IC0gICAgICAg
aWYgKHJldCkNCj4gLSAgICAgICAgICAgICAgIGdvdG8gb3V0X3N5c2ZzX3JlbW92ZTsNCj4gLQ0K
PiAgICAgICAgIGlmIChNVEtfSU9NTVVfSEFTX0ZMQUcoZGF0YS0+cGxhdF9kYXRhLCBTSEFSRV9Q
R1RBQkxFKSkgew0KPiAgICAgICAgICAgICAgICAgbGlzdF9hZGRfdGFpbCgmZGF0YS0+bGlzdCwg
ZGF0YS0+cGxhdF9kYXRhLT5od19saXN0KTsNCj4gICAgICAgICAgICAgICAgIGRhdGEtPmh3X2xp
c3QgPSBkYXRhLT5wbGF0X2RhdGEtPmh3X2xpc3Q7DQo+IEBAIC0xMzkwLDE4ICsxMzgxLDI4IEBA
IHN0YXRpYyBpbnQgbXRrX2lvbW11X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBk
ZXYpDQo+ICAgICAgICAgICAgICAgICBkYXRhLT5od19saXN0ID0gJmRhdGEtPmh3X2xpc3RfaGVh
ZDsNCj4gICAgICAgICB9DQo+IA0KPiArICAgICAgIHJldCA9IGlvbW11X2RldmljZV9zeXNmc19h
ZGQoJmRhdGEtPmlvbW11LCBkZXYsIE5VTEwsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAibXRrLWlvbW11LiVwYSIsICZpb2FkZHIpOw0KPiArICAgICAgIGlmIChyZXQp
DQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dF9saXN0X2RlbDsNCj4gKw0KPiArICAgICAgIHJl
dCA9IGlvbW11X2RldmljZV9yZWdpc3RlcigmZGF0YS0+aW9tbXUsICZtdGtfaW9tbXVfb3BzLA0K
PiBkZXYpOw0KPiArICAgICAgIGlmIChyZXQpDQo+ICsgICAgICAgICAgICAgICBnb3RvIG91dF9s
aW5rX3JlbW92ZTsNCg0KDQpUeXBvIGhlcmUuIFVzZSBvdXRfc3lzZnNfcmVtb3ZlIGluc3RlYWQg
YW5kIHJlbW92ZSBvdXRfbGlua19yZW1vdmUNCmxhYmVsLiBUaGVuLA0KDQpSZXZpZXdlZC1ieTog
WW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQoNClRoYW5rcyB2ZXJ5IG11Y2ggZm9yIHRo
aXMgcGF0Y2guDQoNCj4gKw0KPiAgICAgICAgIGlmIChNVEtfSU9NTVVfSVNfVFlQRShkYXRhLT5w
bGF0X2RhdGEsIE1US19JT01NVV9UWVBFX01NKSkgew0KPiAgICAgICAgICAgICAgICAgcmV0ID0g
Y29tcG9uZW50X21hc3Rlcl9hZGRfd2l0aF9tYXRjaChkZXYsDQo+ICZtdGtfaW9tbXVfY29tX29w
cywgbWF0Y2gpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHJldCkNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgZ290byBvdXRfbGlzdF9kZWw7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGdv
dG8gb3V0X2RldmljZV91bnJlZ2lzdGVyOw0KPiAgICAgICAgIH0NCj4gICAgICAgICByZXR1cm4g
cmV0Ow0KPiANCj4gLW91dF9saXN0X2RlbDoNCj4gLSAgICAgICBsaXN0X2RlbCgmZGF0YS0+bGlz
dCk7DQo+ICtvdXRfZGV2aWNlX3VucmVnaXN0ZXI6DQo+ICAgICAgICAgaW9tbXVfZGV2aWNlX3Vu
cmVnaXN0ZXIoJmRhdGEtPmlvbW11KTsNCj4gIG91dF9zeXNmc19yZW1vdmU6DQo+ICAgICAgICAg
aW9tbXVfZGV2aWNlX3N5c2ZzX3JlbW92ZSgmZGF0YS0+aW9tbXUpOw0KPiArb3V0X2xpc3RfZGVs
Og0KPiArICAgICAgIGxpc3RfZGVsKCZkYXRhLT5saXN0KTsNCj4gIG91dF9saW5rX3JlbW92ZToN
Cj4gICAgICAgICBpZiAoTVRLX0lPTU1VX0lTX1RZUEUoZGF0YS0+cGxhdF9kYXRhLCBNVEtfSU9N
TVVfVFlQRV9NTSkpDQo+ICAgICAgICAgICAgICAgICBkZXZpY2VfbGlua19yZW1vdmUoZGF0YS0+
c21pY29tbV9kZXYsIGRldik7DQo+IA0KPiAtLS0NCj4gYmFzZS1jb21taXQ6IGJjOTYwZTNlMzJj
OGI5NDBjMTBiMTQ1NTcyNzEzNTVmNjZhZTRkYjENCj4gY2hhbmdlLWlkOiAyMDI1MDMyNy1maXgt
bXRrLWlvbW11LWVycm9yLWFmNmVjMzQ3ZDA1Nw0KPiANCj4gQmVzdCByZWdhcmRzLA0KPiAtLQ0K
PiBMb3Vpcy1BbGV4aXMgRXlyYXVkIDxsb3Vpc2FsZXhpcy5leXJhdWRAY29sbGFib3JhLmNvbT4N
Cj4gDQo=
