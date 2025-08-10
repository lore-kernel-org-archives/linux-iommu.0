Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD01A3167
	for <iommu@lists.linux.dev>; Sun, 10 Aug 2025 07:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754809791; cv=fail; b=Cu+v8Nii5Dvcpg6g46l56q8odzhqrHG+qULSOjxCk1UQs+kwzcahRCXPgAb3vrKXepaZsE5EMKjfI8ILzwh4wtF+hnZDypU1obuRKCwZvPlulqXNN6IDQ16ROwzwf083/NjHGMZs64Iv+i3inFNO+rgzdVYIRHGY9MHiFORCMqo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754809791; c=relaxed/simple;
	bh=gmHhZqQyHZf/P6sD460VmOhXI3zffQeBaITrp08Ljzg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PlLjMz8BDFP8ir4rCeliFgH0QfGVqYT6PBCXnotQkJFP5UlYxe7AILTOnU5V53T+QFD1KP28Eqi+gD/1Je1vr6Qyg/3RRiZAhQp05pJR4xgJDPpfyZ2WvHkpKSZIl8Tl3rgsjO84KS4g3mEoGmGYyZ9oLL555f8ecrwaeAWXJSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=N4zjM2yY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=Nb9CWLb/; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="N4zjM2yY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="Nb9CWLb/"
X-UUID: f87be6ac75b811f0b33aeb1e7f16c2b6-20250810
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=gmHhZqQyHZf/P6sD460VmOhXI3zffQeBaITrp08Ljzg=;
	b=N4zjM2yYz9/1zAO1n/prdfQj21e8LgGwEQwBD7tGkWqhiV7Xu+BjE7MyQaMopdhBP+VVLkdTPr83U5kKHY24izqhHF90c6CBzV5pKdzY768I6dU9tBHWc3gbF6ppBa/Zha3x9h4N8+xcVC7L++B9BlWpzpISpJbl/vAyHWZdOnY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:48641c79-01c0-44fe-bf98-f7c0239844a8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:f1326cf,CLOUDID:19dec79d-7ad4-4169-ab95-78e9164f00fe,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:-5,Conten
	t:0|15|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:
	0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: f87be6ac75b811f0b33aeb1e7f16c2b6-20250810
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 101717256; Sun, 10 Aug 2025 15:09:35 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sun, 10 Aug 2025 15:09:29 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sun, 10 Aug 2025 15:09:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Af+cKrcgc3qnWBRhkX2A+y7LWxPrrKkfsFt17l1ai8Dp2ZJz2mmw9HlFRK05eoy0p0ipv90tkZ6Umo7hgVDdvmZGm7k/2IqaxhXx0qhIU/ohUS9fEiu/DQyPNgTL8LeBN0Tus00FaWqRU+X2T8zNmVNdYLZtc8+snLuC3izo2FomLEdCZwMVR63Agf7LVl/i07Gv7hv2d3lC6NKUvuDGNxVtIOYCQ8UbxtcmRXS/qSTxDqsD1XVLW+/cW0fhMKizmbf4Y2xQBoZcrreOuAvK4syOGRuX97wYrGD9y+fx3UsGVPsfa+4AEjDso6umShe6SIKA3UeF6bGa5gm5mng7LA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gmHhZqQyHZf/P6sD460VmOhXI3zffQeBaITrp08Ljzg=;
 b=y/qzFoop8ZOazlfOmuSF0C27xhSjYxa5ao1gAgDd3hvqSoYi5d2n5dD6k3blS1xvhSVi3xQaMzP31EOKp8dvUbQ83WpeGdJMHKUluLSzRSUv3hXo0LLhEK8xO/VW+WKwdAOO3X1aAFwSlCq/uBVtvaHdMDz9EOUnMl7dS6RcpO3iO22ALGE0rRSZ/hNUYga8XH7ycrCAcrj3kBykIKlE3eQWpjKqsByPbrsSXcR+naNH565JCm0PPw32cOrd+//Dn7qE4B5qjxtbWd3P3jbbPPaPqOuSh3xXQKLsF1GKBDlpgx6sCfE2Waahujyh1auKXImUKqc4fj39pW5JCu0Dbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmHhZqQyHZf/P6sD460VmOhXI3zffQeBaITrp08Ljzg=;
 b=Nb9CWLb/AkwRtuAlI5effClZLIaQjUzlxzyPIZ3pPVP/0b6Aec/OBbDp8yC+wL7YXGIArSut302lAN9zi266dbmnyWFX1m6w4foUl/Sl/BZOhtomF9ATplpSJNgP21AuOheOjCyArDsp7buZ4cQJY8uM0XdbVlr2Ar26roxZCpY=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYSPR03MB7911.apcprd03.prod.outlook.com (2603:1096:400:474::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.20; Sun, 10 Aug
 2025 07:09:31 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.9009.018; Sun, 10 Aug 2025
 07:09:30 +0000
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
Subject: Re: [PATCH 2/3] iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
Thread-Topic: [PATCH 2/3] iommu/mediatek: Add a flag DL_WITH_MULTI_LARB
Thread-Index: AQHcB4IAtCWLU2aWl029/NWqp8X1DLRbfGmA
Date: Sun, 10 Aug 2025 07:09:30 +0000
Message-ID: <81fd1269faf43fc91a4f4888c311185b94bb004c.camel@mediatek.com>
References: <20250807095756.11840-1-zhengnan.chen@mediatek.com>
	 <20250807095756.11840-3-zhengnan.chen@mediatek.com>
In-Reply-To: <20250807095756.11840-3-zhengnan.chen@mediatek.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYSPR03MB7911:EE_
x-ms-office365-filtering-correlation-id: 4b9ad36a-ffb9-4f14-667d-08ddd7dcd9ec
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?NmdMLzhmekZ6YXRSbEN5TlhqSTVFUld4b3ViUUd3ZERUbDdjK1BiNjJwa3BX?=
 =?utf-8?B?bVRzb3hsSkRBZTNsaFJDaUNIQXcybVVjOWpRTmVxSUJ4SXlMSGl3RG1wOUcr?=
 =?utf-8?B?LzdOeUM3NlNuakptcHlDWSszL1Z6Nk12RGZIRFJjQVVYZjJIVXRYZHM1NXcv?=
 =?utf-8?B?UnBETG5ZYkhWbE9Od0hQbFVvY1JGV3l5eTdrVmlSallVT1VzMzU4QXYxaVYx?=
 =?utf-8?B?YmdpREN6ZTAvUHUyWnhnaGFnd2d2MjVMSTcyR2Q2VWpGZDFzb0FFLzArdjZt?=
 =?utf-8?B?dk1sVVc5TGRjRDBCR05LR2xEam8vajdielF0UkI0WWU5ckh2K2g4bzBqS1U5?=
 =?utf-8?B?ZHZmM0FFbzU2bTVDbXdobGRvQkNYQktjcTBQeVVwcUNtVmhoRkkrS21Jaisy?=
 =?utf-8?B?V2NnS1NDbEtmeHA1TU1ENVJ4U05VSHN2SzlNZmNRWDZORUd1SlVDTmUrV0Ew?=
 =?utf-8?B?ZSs1VlU2NmdSYlc3TTFGMFlYTkZiZStjS3NoQ2xJTjFOUUY2bDNNNjhBV21U?=
 =?utf-8?B?T1hiL2o1RUZ5RmtxdTJLL2dHZVljek9hcDcxYUFtMW9YNFVYR2lYQ2tsQ2tL?=
 =?utf-8?B?M0ErSmlIS1AwZk9WdGpLcm1LN0FLZ3g2RlJ1Unc1aFdpYm1qb0llcCsrSkV2?=
 =?utf-8?B?N0hKa0Nod095UVU3QWNrV29mUGJjWXZmckJ0eEhTdFFyNnNMRzNWVXgyaTAy?=
 =?utf-8?B?eHBXVWhzZGVLeDljTkVhRG1rYktxN2tuc0VodW92ejRMZlduOWVUS2pxNTZO?=
 =?utf-8?B?TnAxcXRtblI3MzN1Vk5xZEJsOFRoTnV3YUxHYm1aOWtiQjFCMHpDYU1LNG94?=
 =?utf-8?B?eVJ1SXNlcWlHazJ2UGU3ZGt1czg3a3VVeGdhV2d6TkFheXhDT2VFTDc0MEla?=
 =?utf-8?B?WDhucFptTXl6RnBHQ1FvTlpndVRhTWx0ai9GNitacWpnelliSjU0VEJrTnFm?=
 =?utf-8?B?L1Q0dW8xajRtRzFyTUlmY2Q1YU91RUNSemp2VVhMT1BLZDZ2T3RIWTlUMnky?=
 =?utf-8?B?S0RVR1RWYm5CU1VodStVeDlNMGU0MlEwZWMrZlM4L05Fb0RiSmJ5UG1mQnQy?=
 =?utf-8?B?azhNUC85bVA3di9jdkZ5aEtyRGcyRnA3SGJVTHdhck1jTWVBYWUrRWJwc0p6?=
 =?utf-8?B?aitVWjdSZ3RWdTAvaWlIOVMxWDBwbnVxSmxqbHJFeTdwNjZvak1jWWt3YjFG?=
 =?utf-8?B?N2laWGFGSU5IWU5MTVRkajZMbXdJbEpFbmM5dVhUb2pTRE92aDFDRGtldTVT?=
 =?utf-8?B?eEMzL3Q0U0k4aGxlSE9OVTFRVGlBWDFLemJaM2FXa3BuOGR1Znk0SmtkV21U?=
 =?utf-8?B?YXRVK0pJeFlSRDBNeFlpY00xWlZiY2NiRGcwNTR4Qm5zQ0VyUktza29VelJL?=
 =?utf-8?B?alpzK2hrVnhBc0hFZDFsR04wU2dkd0NXMkg3K0VPOXhBRFJ2dzVIMWtLQmlS?=
 =?utf-8?B?SEtEbkt5WXRZallWL1F2OXpaa1VCWEFaaWlEd1FpMWVHWGM5MTk2OGJLVXdy?=
 =?utf-8?B?eDR4aG1EWGxKN09SWW5SNVdRZXN3NEVFcGlrL3g5UnVCZFV2dlR3Tkh0YkZx?=
 =?utf-8?B?YmFpd1YwRmNoYm9INDB1bFlQMGVudkNZeG5QY2R1YlkwVS9mamxmUlI5eEhq?=
 =?utf-8?B?YlcxMHFvTXpwUEpOUHdpMmxsbGkxc0RtRjZrcXhSWWNtVzZ4UUNvaXo1a1hj?=
 =?utf-8?B?Q0pLZVlCTUsxUnorekpZZlZ0VXVrTDdWbXh6NGtPMG52QS9sRmRNMGppNkEz?=
 =?utf-8?B?NUpGLzRONkZXdjZENWFZMHl1aUZqSEI5Y1ROR2NKNkRuOEI2LytQL24wOG5w?=
 =?utf-8?B?MVRmM0ZNQlZaUlZrUXFobnV0ems0Wk51VXlPODBSSU01ZjlYKzhCTzNQanFT?=
 =?utf-8?B?eFk3QUt2bklGVjEzV0dHdFpHbkl1MWxzOHk5TUdWR3JveENIV3dwbkxlS2E0?=
 =?utf-8?B?aEM4VHYzTWdjY1kxbW5iV1J2cWpKMGpGL2hzRTV0OGN4RUZQc0VtMFY1RWt6?=
 =?utf-8?B?ckJGT3ZaSi93PT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Nko4WjBRRnY0OXVUdFBzQ20zTFVKUkR4RDhsNjZNRXJFV01sK1kzTFBxYmZl?=
 =?utf-8?B?dWdYYUx1MUtBMmhzcG1BOHFLVWtYbWxyV2RJa3ZMK0tjbjNuT0VqRnN2SUg2?=
 =?utf-8?B?WUhaaldWZ1ZDM0hXS3hId2xYZ2dQVXhUOWVKVVZxTEdqTWt1aGhpRDBBdTM1?=
 =?utf-8?B?RDd2RW0zOUpPYzJRUDFNaUsrdXo5eGs1WXdQSGQyQzBvM3dIOE5DdnF1eVZk?=
 =?utf-8?B?dllINk5jMmFtclloVjB6dlZRT1JnQWdHd3VIejdOOExQOS9hWWpZeWJOU3JR?=
 =?utf-8?B?VnpwOVVYTmI2YW5zTytzMUhYblgvcUFZbEZYWHZiZnBTYkFETThBazN0ally?=
 =?utf-8?B?VE9oNWVyZzJob0p3dDdnRy92QmMxQk40L0Z1ZlZvdXo4QVB1Q0V4R1F3VS9T?=
 =?utf-8?B?b3pENHRKQUcrcUVTWktHTUJYdHFYVkFkVlExZGNUSmgydVZNVXc5Q1RTNWpa?=
 =?utf-8?B?YUVBdFJ1VlhzTEV1RkxXWFBMdmRzenhIeHFwSFkvaTQzZk1DOUpTR0NFdG5n?=
 =?utf-8?B?ZzBCVlhGSUJ3eWhIYjA5dHJXcWQ3WkdpS1Y1QVk5ZXNRbDFrMDREYkxkVmIy?=
 =?utf-8?B?Q0VvamhYaE5GL29KdllWdG9yM2pyd1EzWllDSEs1QU91YUYwYkE1V1llbTBT?=
 =?utf-8?B?c2lkTzRiZm1JQUtISUFHNWRKRUZoN0ZmbXllSk8xTTFCajBOeGZ3TjNyUjYr?=
 =?utf-8?B?cVBQTmNJQnBTOWR5bUpTL0NET3pFTXB0N2p2OHRESzdhelJtSndaSFMvZ2Fx?=
 =?utf-8?B?UENjZHk4aUU4Tng4ZGIrdnJPWnF3aCtOOWViS1VjZnZ4MXRxV2dQL3l6ZWkx?=
 =?utf-8?B?ZlB4NHJhcUxzOXY1emY0UHJUb0pUOFNtRG5ySkNyUnZyRkZ5TEtJTlJjODRV?=
 =?utf-8?B?VDJMSDZLT2IyWG15SEM3NHhzcVhJZGZqeVgzelZGOXIxc2huTWMrd3hhZmxi?=
 =?utf-8?B?Z3pVTi9JQU1SbmYwaStBYTZSRkFEU044TENBY0tUTG53eFFKajJKQit4VDFk?=
 =?utf-8?B?djVvOWkyME1pNFlkQ1U2V3dTRUxvOGt4Y2lMOHJTeVlhTkFPYjFpcW02L1Rt?=
 =?utf-8?B?dFU1bGFsc3NpVTlFdG5xRmRPWEo2THpOM1EwN2RsaWJmWVpmTFRkRFVjdHFv?=
 =?utf-8?B?cDc2NVBBNnhiZDdRTkdkYjQzbTcwQlZGU21EL0I2aU9GY0JBTjIvaEVIMjE4?=
 =?utf-8?B?bm8yN05OVlZOTlNWSENxdHlvYzgxR3loVFFUbmZrT0hqdTNSaTAyUHBGOVVN?=
 =?utf-8?B?OVlDODJxZ2ZhWktqcWNEbUQ0SHgvMU05U2NtSllmSFJxckl3SGc4MUozVTQ4?=
 =?utf-8?B?cU8wbG5UNkdIMUlSd2lWMThpRDRvQmpGdmNVSXg5bkZYemNQbzdCQ21VSkZj?=
 =?utf-8?B?WW5KcUIwbUtZR01GUyswQ0lnektGQy9xUGZVZUZGdXVFeVdTNGdWbDZTUStn?=
 =?utf-8?B?UjVocmtubjlFZ2Y5MHNVWWhMTE1VdFppOS9rcm1ab3RBamI5Wmt2MEhyK0VR?=
 =?utf-8?B?OTBiQnpBZ2Q2WEdDMEEwUDdNd2wwNFdQNlVZcGplNmFiKzhCUlNYZ0V4TjBa?=
 =?utf-8?B?TDJCQkh6VVhGUG9iWGJidTIwRENFKy91K1pTNFNlNFFJd0lOQUUxSEJjQzBO?=
 =?utf-8?B?SDFVRCtCN3pPWEJpWXM2TzVNU3g3SndBNHZhVHdhWFJuRGg5azk5eGphVW0y?=
 =?utf-8?B?ZDg0Y3RVQndFVno0RENKMURhdk9VZEhSVEN5ZnpSaThDVDdZRDZGV1VLbmpB?=
 =?utf-8?B?dTZhangzd3E2cWoyaCtOd2piZ2VCcXFDTFlUcHFySThCUWVaSDdRWEhxb3h1?=
 =?utf-8?B?djFvMStmSE96bHlRb3pqZWJYdTJqMzRWcEZlMDZXbkgxY2VXcEc0UzJPdFZs?=
 =?utf-8?B?ZFlKN3BhcFdlRDIwS1ZlN0hpRW5xcWFDZGI0eHRCM0tzTTBxYWpvWUZSN0Yz?=
 =?utf-8?B?c2FtdGtnNDNvYWh4Ny9NcjZDTW5FYzVPZ1RNalFTTjUzc2ErQnF5eGNlRGFX?=
 =?utf-8?B?OEVuQlJhd2pTUEVBTGNwYXV2RFNWQUd3ZzJGbVduZG0yQ2V5SkltenJZYTQx?=
 =?utf-8?B?SjZyYUoxVnZPK3MvUmxIOVFWMllxZzhYa2NsRDFpVGNXZTNkbElTR2dvODBT?=
 =?utf-8?Q?0DL9Hktke9ypeDqdUm+qUlg1w?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C0579AB5A1312F4DB332F00C4B17FE53@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b9ad36a-ffb9-4f14-667d-08ddd7dcd9ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2025 07:09:30.5099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6h4pZfIUBcjHbOb3rEWgKQZB7J1ZbbBQyEeZVj9W+LhG9grbQzQShu8l0kHR2Maqz0lIniZWgI3QnCYT72puCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYSPR03MB7911
X-MTK: N

T24gVGh1LCAyMDI1LTA4LTA3IGF0IDE3OjU3ICswODAwLCB6aGVuZ25hbiBjaGVuIHdyb3RlOg0K
PiBGcm9tOiAiemhlbmduYW4gY2hlbiIgPHpoZW5nbmFuLmNoZW5AbWVkaWF0ZWsuY29tPg0KPiAN
Cj4gQWRkIERMX1dJVEhfTVVMVElfTEFSQiBmbGFnIHRvIHN1cHBvcnQgdGhlIEhXIHdoaWNoIGNv
bm5lY3Qgd2l0aA0KPiBtdWx0aXBsZSBsYXJicy4gUHJlcGFyZSBmb3IgbXQ4MTg5LiBJbiBtdDgx
ODksIHRoZSBkaXNwbGF5IGNvbm5lY3QNCj4gd2l0aCBsYXJiMSBhbmQgbGFyYjIgYXQgdGhlIHNh
bWUgdGltZS4gVGh1cywgd2Ugc2hvdWxkIGFkZCBsaW5rDQo+IGJldHdlZW4gZGlzcC1kZXYgd2l0
aCB0aGVzZSB0d28gbGFyYnMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiB6aGVuZ25hbiBjaGVuIDx6
aGVuZ25hbi5jaGVuQG1lZGlhdGVrLmNvbT4NCj4gLS0tDQoNClJldmlld2VkLWJ5OiBZb25nIFd1
IDx5b25nLnd1QG1lZGlhdGVrLmNvbT4NCg==
