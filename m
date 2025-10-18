Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 169F328EB
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 02:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760754511; cv=fail; b=I4L5INe2gNm26/k0hEjzgikozVemCPtlmAoIqQwudayJzOC8N3V6W6JIoDQ3TDDHGuTfmyyBQwi03QjIoyIu1J/quClWcWbLGJ0MPgP7VyS+enuzHBsrjHiziQCMm4gUSGbKHjEsePatTEIcSc/t+S48KfKae4wLCuf7UA2Qz5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760754511; c=relaxed/simple;
	bh=+jCq8kfN1HYE9O8A8TM76sgjwFMt8GJ2W3nALiPm9Pg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DAf2uMLtE7Dzmr0/NyZZT6dXsZqkcjHN0naQ6kcZUnwQzTtjR8IFAINGfmjevacF8WM6QUFIOmLpcK+YZdCAAxa81wi+P9wv2HhTFVfT3zYDQQ/fD5ecUdCNLMoI7oGcKWD5661mJmNL7OslanVBnaHILSaaVsZn2CnUsYRZWFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OENhO3Qj; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=CIM5Yd7p; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OENhO3Qj";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="CIM5Yd7p"
X-UUID: 1ea0a0a6abca11f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+jCq8kfN1HYE9O8A8TM76sgjwFMt8GJ2W3nALiPm9Pg=;
	b=OENhO3Qjf4FeO05xdDGd0KAl1tKh6po57wrbh73yc0S4i0DO6Eaw9Za9zNvZDg0KkTUqWNq66bnBg/83hyQ2tioZFzW4VCcgXtljYmGzze5qrJbp6wHIKEjDWuiIJty6tdqi9/9MqQwQTJn/jAVYm61Mxn8TvMHj4FoN5op5J3A=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:d8088364-ec80-4a43-83e8-a92874de738a,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:50748402-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 1ea0a0a6abca11f0ae1e63ff8927bad3-20251018
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1611171602; Sat, 18 Oct 2025 10:28:23 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 10:28:20 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1748.10 via Frontend Transport; Sat, 18 Oct 2025 10:28:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mgq+hYl24gLbuvDQ4RKYTHCIKNgFFIDLaMbTBoadfvePLbC1ApUz8cqRhLGEPsQ4tl8igyxCFijd1cwEzHOrdmVp7pR619soEXcAcxe4v11ul+Q4Zil+Xav0++lFWTthRu8Vq8mW02Y6YCUyeecfNbec7N4WX11F3DRX9BJfbP9P47XDKEsuhEADNlE3u/KIncf4YfSCTvtjiOWrZ6+0ziVDulDwLUPLmQPzZwUJ9ciRdeCUhc2iYsOvRzscgMyjA0sb0izhjU38m/ZZQUr0khPVJwC5p6eKkTUx/r1CQoaTJsZ73aAczzJI9HVn3WsK6U0esVn50mELCrwtHgvaEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+jCq8kfN1HYE9O8A8TM76sgjwFMt8GJ2W3nALiPm9Pg=;
 b=JK3RD6g+SzssaRgqEyWNvXOiWKI8Cagj8lwBgXGqldkhwLYL8dISBLpxSqeDlsnrmazQMfCewi18Qcl1cau3W4gbkqAmQ6p+/8BX1MEfUfI+BiTwL7DK8/oGjOE9Ay3iZW1d+zIdGK5b4W5m19yDqa7d4Yz9aXK3IkoFHZAZUya0W4wDMk35yyh5qpA5hCnI0maBfbjam3eEvvZCBVd5Up1wMVp3k5YqVQONguRSaJvqsIh8nUq2gDzJVufbQqMr8GfVtz48FD4bHdC3ERk2qT0tfhDrkHqUkPpsdEM9J/JOO4WRLWVWnZMkc7haqRXR8z5cotlA5d6qWVflRG0l8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jCq8kfN1HYE9O8A8TM76sgjwFMt8GJ2W3nALiPm9Pg=;
 b=CIM5Yd7plG/7LHbmXlQKZIEQuUcX0x8KoWJYit5VTWAZr10CaeVME8Ph0dBrsaHkxUoUPda7v9TPjjnPVZ6osHgK8RaAv5w4fIddu7S2/iXNSl/jA2lJyBU9PvJWQs8FTeFbEVICkU2//Kg3B/4GYynFDVQ9My/XZuMBM/kJ/i0=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TY0PR03MB6982.apcprd03.prod.outlook.com (2603:1096:400:276::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.14; Sat, 18 Oct
 2025 02:28:15 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 02:28:14 +0000
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
Subject: Re: [PATCH v3 5/5] iommu/mediatek: mt8189: Add MM IOMMUs support
Thread-Topic: [PATCH v3 5/5] iommu/mediatek: mt8189: Add MM IOMMUs support
Thread-Index: AQHcPdNfDehblhBmiEiqvddlnmrSubTHMg2A
Date: Sat, 18 Oct 2025 02:28:14 +0000
Message-ID: <fffce8fcf485bb8e00c539d3200139cb2f70cc36.camel@mediatek.com>
References: <20251015125532.9041-1-zhengnan.chen@mediatek.com>
	 <20251015125532.9041-6-zhengnan.chen@mediatek.com>
In-Reply-To: <20251015125532.9041-6-zhengnan.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TY0PR03MB6982:EE_
x-ms-office365-filtering-correlation-id: 7bb0365d-65a3-4430-db87-08de0dedfd86
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?QnNrYVBBUG14ak1rZWVya0tLRGhBcGZqUW5Gc0htUmxJT3R4WjNKVTNuZmxI?=
 =?utf-8?B?LzM1TThuRUtMeUN4S0dBVFhBbTAwNzVKdUZ6elhkOVJCWEFSOEJYNmxkajVM?=
 =?utf-8?B?b09ROFlhVEtOMDNOSTMwckpMSzg5T24wZ09YZlpkYkc3ejdlcTVhaGxEdllG?=
 =?utf-8?B?cGlZbHM5WDFsK0pVUUtESG4zUnBPK3hKOVoyUXNNYjlNdGRZeGFTem04RWFw?=
 =?utf-8?B?ZXlPa0FoZXIvcHBSTVhPaFFpRTZCZDZ5QnBHcWdLVm96OEdvUWNkd1hrTlVN?=
 =?utf-8?B?cVJkd2FhNDF1UEJZUHJWWElsNnNNS0ZBd2ZhZXJhc1JvR3MzZ1J6Tnc3UitH?=
 =?utf-8?B?N1ZoY3g3eUdzekg1cDR3aUdtbytUKzl3VjRZV2lJN3NCWGhoZzA0Wm5rd0lC?=
 =?utf-8?B?N0QvZEVSS2xhQ2padmEwbVoyQy9kYzZ5bjhIMkEyRVgwSzFhZTN4RlVybEpn?=
 =?utf-8?B?R3loMXNPaUY0Zk8xcEppMU9QMXdZbEJNMEYzWDA4LzdqandzNlB2Wmx1RGJY?=
 =?utf-8?B?d01ORE43a0kzcWxNQ2RHMlBhQmMxUXVLK0pGNENhSlQ1K3REcXhEbHViMGRy?=
 =?utf-8?B?UlFGeE9raW9OdnNReWZOTXYwTkwrQnhFOFRMcUxncWRyTm81UkdNTGNLYUpt?=
 =?utf-8?B?Uk5aQ1ltdW1RWlkxRjhKM2xSWGlNZVJwSHJJdGtRRmV2STZyREZCQ1Y5b0F2?=
 =?utf-8?B?bjNia3FNVVc3NUJTNllER0hPazJWMUFiL0dxa3NGVndhRWpZeXc4T3RWdXpP?=
 =?utf-8?B?WUF1MFo4U0taang3QnhCTml6aFBSWmQ0ZE82dnFnU3g5SW9vVCtYSzBHcVVZ?=
 =?utf-8?B?RXltTzJjVFRqWGd4dkhjN3RZTW1xKzJGSDQyQzBhc3lFQjJ0bitHTGg0eENl?=
 =?utf-8?B?M1dUTFhVTHk2M25iWSs0dU9aSGZrcHMwdWNVNFplbFNSZ1dCNEM3WDd3UzZw?=
 =?utf-8?B?dUNVeSsxaHJtY3ZhMm1qZklvNWI2THg3WUVsU2FuT1VNVjkxTlkxZDlRdyt2?=
 =?utf-8?B?TVdGbHJyWXFYVjJqNTdLZ05iL2p5NXVsd3dGdjZEY3VJR1p2MGNnbHJ5dW5K?=
 =?utf-8?B?eDRjbnltK0x1Ylp1WEtKYThwTy9sa0ZOM0k2MlV3b1VYQUdOZVlVNGN2eDls?=
 =?utf-8?B?RHhkRjc1QTFyWWZzc1IyNndCWkpKREpocVFrc3RIWExidTliajBrbzIxWUU3?=
 =?utf-8?B?OHlHaitKcExsQVZqdzJHVUhTUmRvdFgva2Rzc1hneXBnY0RVVXcrWUN4U0lU?=
 =?utf-8?B?djI4Ri9zTFdOOXV5TkhoVFdtZy85akZFb0lXVVpxUWl1WHJWNDZ0UkMvTnRW?=
 =?utf-8?B?Vm9yekQ5b29Jc1p4SlFsNFlMWU5mT1NsUzVZRXlUd2Q5eFBoT2gzK3BsQ1JU?=
 =?utf-8?B?YUFMVi9TME5uMTQ3ak8xd0pGb1pwZGx1bTA4bUUrdGFMOEs0anVvd3RKaUJV?=
 =?utf-8?B?d0F5bTIrTVR5dGN1amJZVytZaGVvNHJhdmh4QWs1eXBPNHlPaGFyRWhOK3Rw?=
 =?utf-8?B?S0pFUmM4K2dSZXFoMDZnRyt5dGYzM3F6dnU0dUxLUE8xY2lCZE1SeCs1K1dR?=
 =?utf-8?B?bFBMc0xrMFZ5TU9kQjg2OVRuWkJGaWVFQ0pDUWNPK1NDNi9LR1MvTHEvNE9s?=
 =?utf-8?B?KytrcUtPV1R3OGNNcjJkVkthcWY0Qm50VE1ubmc5dC96SUpKbWdRam9nTVZG?=
 =?utf-8?B?Ky9iV1lPdkV6Qmg2MTA4LzZzNGVIcDkvNzN2VTFnNVFvR2hCUWl5Rk5yK1Zi?=
 =?utf-8?B?eGZiVFFxa2ZPWTkwOEpMNkpkc0FFbDdtT1JFeDVTZzlaUWRxdzBSRGFsRDNx?=
 =?utf-8?B?NlV5RitlRFJtUG1rL1ZzK1Fqb3JLc3pOU2YxajR6b0k5RGIwdHQ4blowUnVB?=
 =?utf-8?B?b2RDYnh2L3Evb2QxeXNuaXVFanZnM1ZYSlNQNHc4VXdlTWNNZkJEUnZUYTNK?=
 =?utf-8?B?REFSUVcvN0pySDJhRWZXc2ROd2pvdDBYdXYvaXlhcVYrQVBhcUlIQkhGQ1Rk?=
 =?utf-8?B?bjIreVA4K21pQlpzLzVBbS9pSlNXbG02TFNVRGEyeGdRYzI4ODBPeUJJTTZa?=
 =?utf-8?Q?kuOjEk?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z3k4TlVVMWM1Zk5FVGxCdkFvL3RwTndYWER4WkZ6aWp0OUxkL3NESkZQckk5?=
 =?utf-8?B?MVU0RkNyNHFmR0EyVnFvRDhyMExIMmF0bENhUUE1cDEwUEJPVHJtMWZ1VVdh?=
 =?utf-8?B?QTZMeXQreFkrbnNLYndjWGFJN3lwbzVVMExvWlE0MU9GMWFJQWtoNGZWNXE5?=
 =?utf-8?B?U2thN1VKZFJZT2dndjFrT25mMzh6d211WXgrUlNtczlhcUlrWWkrQVByUEts?=
 =?utf-8?B?Zk4wMndNWnpqVkRTRU1Ma1gyaE8xWFgxbVN5eGJ2RDd1bldEMkp2U0V5Z2ZC?=
 =?utf-8?B?SG1LQ01HdUY5OCtRWFZ6ckttb0JFdVFOcjNIOVltNGVhc2ltSHIvb1gvajRo?=
 =?utf-8?B?OTBlWDlvMzIvVXVuUFdNVndVOFpiZHhib3RKK285WFcvTDdqc3pCTTE0N295?=
 =?utf-8?B?SnB3SFhEYjJmVlcxK2kwYWFwVHQvamZCeHlUcGxVR3M3c1dLSXBxVDVEQ2da?=
 =?utf-8?B?eFV5Yk9KQ2U3Ukc4TjBEWUx3ZXczbXd2cnA3RjAvNnlzTnJXb1Z5amJTaWs1?=
 =?utf-8?B?bHp4Z2hvaGJTQ1dmbklSU2kxbEdvK1VMVGUycUJaNG9JdW16akU3TEdOY2t6?=
 =?utf-8?B?cjNYdUJ3ODRDSSttUC9kWEVMeFplU1NJQjVuRlE4WUNxQW81SlQ2WDZFRnBl?=
 =?utf-8?B?RDIvYmJXdzRzdjlRUi80RFBlaFpjUkRybTNtVlRiMkZ4cU1NaTZFeHh4Mzlx?=
 =?utf-8?B?cmFpME43OE03Ym1GTEpUYWZpNGY4NkdFQXVvNzNxa0t6Wmwyd3lwZ2VwejZP?=
 =?utf-8?B?cTBoNHdLVnRGZ0pBQTBnR0xkRk1MSjN5SWtnNW5mRXpzNVprZ1hQVTlsM0dF?=
 =?utf-8?B?YXVsYnYyTmZTTzk0aVMvRHhub2xkL2l5cVBzQUdQVmNaTnNLL2Y2T3IwZ1lP?=
 =?utf-8?B?NXZvU3NMUUJndWxwWTllOWduVUhpdDB3VFRNUldjUElqVHh6OTBwU3g3R2Na?=
 =?utf-8?B?cWxVRmRKUkUwU3A0cCtHZXpCWndja3hSVnQvcnZ2a1lwVW1CZEN6cU9TQ3Nr?=
 =?utf-8?B?Mm5WTTN3dlpIalJaYXlHK1B1dmlEUmdEOTNUcEdIUzZkUFFEQmFVbEVuTFNF?=
 =?utf-8?B?THowcmdlY2lDT3RDMFA4azBSSHZncmR5aTEzUS83RjVSZktHdEQ3aDk1Q0V1?=
 =?utf-8?B?SzJnN3cvUUQ3TjhtODVBa201VjZ0UXhsV3Z3QUwxSHhCcVBOdTVxMWVYS3Nu?=
 =?utf-8?B?em5Vek5nSjZqbEs5OGpFbVBHK2RrWDJGTFZMUEE0UnV2bmJ4Y0x0SUxKU0ha?=
 =?utf-8?B?QWJSZHhCTVd3d3I4NDRvMjRUK1BHQ1BUMGlIOFV0QzQ0TkEzY2lLRnM0aWRj?=
 =?utf-8?B?NjRzKzVtTG5kamJsKzdKOThtUEE2OTlsVjhXRlJ0QjlpazJ6RmMwNEF0Slhm?=
 =?utf-8?B?WHlJS0l6eEdnejc2SkUrdG9EdEVZcnhvQXhPWUN0bVhKZlVCRTJRV0xTZldX?=
 =?utf-8?B?cUxrSmttVmVmeEttQUlvMUJjd1FpeVBpY3BsLzcxSUcxTWVQMlZUZ0VOTWhs?=
 =?utf-8?B?cFJQOTdNajVRejB2WnBKdkxielZiRHFYYkR1eEFFdGFzbWhNVXFYOWhsQVF2?=
 =?utf-8?B?ODluemZJbndWTUpsNWV3eTg1SDl5dzhNYTlzUDl3NUw5RXFvRGp2c1dHT1Fv?=
 =?utf-8?B?c3dkWjVKVk5CTTI5c0dFMmJ4UEg1QjV2U1AwbEovY1FpekM2bVZ4T1pYTUVk?=
 =?utf-8?B?ZE1TNXJZMFE2K1lCb1dRZkNBVWEwWnFBMktPVW9pSG9xUWFGbG9mams2TWY2?=
 =?utf-8?B?V0p5NHZYUndvMWtWWXdhVGQwTFVuRUZGSmZ5N3E1aFpvUDBZK3phNnZhVDhy?=
 =?utf-8?B?ZHMxSExJK0h6eGdLMlBQSUpxcHl1clBGeHhNaElkdWlFY2VmT1NjbXVBQk5u?=
 =?utf-8?B?V2lGUWNzR21XdkFUdTZzclYzSzY5a3RvcThMRVltOWZaTGJqT1Y0WlVnOUZZ?=
 =?utf-8?B?YWhRa0NJd3RsYmRhK0ZRUDBNT01pOXFzODhIT1J5OWlLbE1YUlNMVjgvSlc3?=
 =?utf-8?B?MmhxMVpteWRNN3hTaVI2N1hmcE1PRWtramRaU3BhZFExaWVVWFQ0N1hkZTJJ?=
 =?utf-8?B?MXlSWDU3QmZDTlBaTUNUK214cUVkN3FiNi9jVWs5aCtVTzNOc1BpeXVMNlBo?=
 =?utf-8?Q?MJwXE2iKazrV2UXdIe1T1XVZB?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D562F8E951EF2A408C8D35E634FEACF4@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bb0365d-65a3-4430-db87-08de0dedfd86
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 02:28:14.4985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Lrj9tZti12unmvNewYR78u6DJHjEJnBVj+WwrF0Hz3S24ZY3IXk6Sr/j4LsbngQfxsnTFStKooVIKF2fDXxfkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR03MB6982
X-MTK: N

T24gV2VkLCAyMDI1LTEwLTE1IGF0IDIwOjU1ICswODAwLCBaaGVuZ25hbiBDaGVuIHdyb3RlOg0K
PiBBZGQgc3VwcG9ydCBmb3IgbXQ4MTg5IE1NIElPTU1Vcy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IFpoZW5nbmFuIENoZW4gPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1i
eTogQW5nZWxvR2lvYWNjaGlubyBEZWwgUmVnbm8gPA0KPiBhbmdlbG9naW9hY2NoaW5vLmRlbHJl
Z25vQGNvbGxhYm9yYS5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyB8
IDI4ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIDEgZmlsZSBjaGFuZ2VkLCAyOCBp
bnNlcnRpb25zKCspDQoNClJldmlld2VkLWJ5OiBZb25nIFd1IDx5b25nLnd1QG1lZGlhdGVrLmNv
bT4NCg0K
