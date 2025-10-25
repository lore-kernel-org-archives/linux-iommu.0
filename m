Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A43B12DA77D
	for <iommu@lists.linux.dev>; Sat, 25 Oct 2025 09:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761383930; cv=fail; b=aBaps18kXfM79S/7M8WK1xpW92H6y7mp/pCQcFSdrWTkyRSVGM+2jdpXWD0fInxf7m45b8NnvoFhroXk3IOR9+p2saqsda3hlhCYaK5IRy64DnXKQlgdlijL7cFObCXtosZ+xh903n4m6FIu+cAGr3Ls+BwcE1Wkv/HDlFbcdtI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761383930; c=relaxed/simple;
	bh=GjlS4c5DGGH1Nhlx2tVgWvAPjjjVcca0scuAZECrtcw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Qfs6+SKLwkJYLQc53xp5kb8yP8RY7bkyC/ue46WAzzjJhl/xdkT/EURXBaq5yjleTP5ICgml5zksZ7hRPo/RPQu+LLb/4hhtkGSgU9PrX7bXUt5OyjHnwTCTsJ5Y9qQ1DVxsuNkaI0H2upjCdciq6NffBv8Lw2YgY3D/XBGnMTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=OebooT2S; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=A8rIyDPM; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="OebooT2S";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="A8rIyDPM"
X-UUID: 96ac09b4b18311f0b33aeb1e7f16c2b6-20251025
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=GjlS4c5DGGH1Nhlx2tVgWvAPjjjVcca0scuAZECrtcw=;
	b=OebooT2Shvpuyi5Z7DkUXM46zf814x20/LxkqTtQguSxRigdfEZ9mMc/LcTIdXH8QCk1xB4tLNzGXiT72lwR2YOtMaaTfgLXmwumeharE6I47AI7DArhrwxV8buFZoYfl9k1PyCvsHT42c8oY98k0Zn8ZtREMOgBmwokyyYtp9U=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:98eb43aa-c4cd-481f-a844-54fb0f26c864,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:478ece3a-b16f-49fc-bb37-560773c432f7,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 96ac09b4b18311f0b33aeb1e7f16c2b6-20251025
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1762966796; Sat, 25 Oct 2025 17:18:37 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 25 Oct 2025 17:18:35 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 25 Oct 2025 17:18:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oGeTxvozjtb9HdkQYhdEDvwuRHwK9cS3NTLTDTtTcFjXgBF5zA2SMn71UKGprYajwZcjyZg1T42Dn23pIyOJl7tA6447toB5TqF76T8ujpgEoKJpHYeQctXmIY4Ht0Wh/AQLbU/OYT6/QIH869FiLQespSZMioCQ8W4tyjDuk4S19soXwwFeVz4c8tE6OTWO7wAeTIaK+5zI+0ELbehqeuWEZUtSq0NF3O1xDbSvskBU8qD0c8UBtqH1E798dAEVK3fh3erenuqAg56CMZYUGUq3gF8sqHaGoumclTbXm9/rzRz0wlUCACA/uRuqWeg/K6TqD1C7RZ/aNduqi0ZYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjlS4c5DGGH1Nhlx2tVgWvAPjjjVcca0scuAZECrtcw=;
 b=D7uZ9YJq4j73jbfjN0MEavVW2sCHc8+fdQOnI4S9VNReZpmOxwbcUFjWOIJ6+k7+WRdrgLlon1zPc9Mi6sgQM+d4W0ZUEUTxfqVO0/MsCVp9hpYtKxATOWJ4fNqEC6tuKMvrywzVgT+Wcy6lkUqGrJ/tD+7wuetfKPcj1NmCkjYjpXSvhOgTfgChNOWXQpXkwuHvjxlIU+8CUKxaiFHBE73srKzZvEnuXPK9ZPAF9DRvLVK+YwJFJSObXc/AUhuIbAQFeqVLTecAUsw/Q851EK0iFGCcX9/smd5pBU/GdD+PJf8kFgEcr42Zh11O0WPCqaPT+s9fSZdFQPRtr0uHPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjlS4c5DGGH1Nhlx2tVgWvAPjjjVcca0scuAZECrtcw=;
 b=A8rIyDPM99EYz3ndS2gn+7a12xn0MZFLLP8OxPbNTPX+f9aT6WpuxxnTJGedYRpwz1wfxxDdF8CfESynB8/vRfU/U/qZHKRnGTcjt97/kTiIuah/2EBckYh74OZ+CKtqdIxHq0hukcSTUqoBu2FG96ndHHhQn3cqNCnTzcDrshI=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 TYZPR03MB6766.apcprd03.prod.outlook.com (2603:1096:400:202::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.15; Sat, 25 Oct
 2025 09:18:34 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9253.013; Sat, 25 Oct 2025
 09:18:34 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "joro@8bytes.org" <joro@8bytes.org>, "will@kernel.org" <will@kernel.org>,
	"johan@kernel.org" <johan@kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"j@jannau.net" <j@jannau.net>, "vdumpa@nvidia.com" <vdumpa@nvidia.com>,
	"robin.murphy@arm.com" <robin.murphy@arm.com>, "m.szyprowski@samsung.com"
	<m.szyprowski@samsung.com>, "wens@csie.org" <wens@csie.org>,
	"thierry.reding@gmail.com" <thierry.reding@gmail.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>, "matthias.bgg@gmail.com"
	<matthias.bgg@gmail.com>, "robin.clark@oss.qualcomm.com"
	<robin.clark@oss.qualcomm.com>, "sven@kernel.org" <sven@kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 07/14] iommu/mediatek: simplify dt parsing error
 handling
Thread-Topic: [PATCH v3 07/14] iommu/mediatek: simplify dt parsing error
 handling
Thread-Index: AQHcQX35QSZuFszr006UCuBURvjnu7TSna+A
Date: Sat, 25 Oct 2025 09:18:34 +0000
Message-ID: <7f00d364a5b07ca23f9b5def42df8ab70bb06cfb.camel@mediatek.com>
References: <20251020045318.30690-1-johan@kernel.org>
	 <20251020045318.30690-8-johan@kernel.org>
In-Reply-To: <20251020045318.30690-8-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|TYZPR03MB6766:EE_
x-ms-office365-filtering-correlation-id: 590b969d-9348-44f6-960b-08de13a778d9
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?UTBtZWs3NDZldEtmbGo1NUJrbkdjM0I3em5tNDZOM1N3b2RwamtSREtBUU5h?=
 =?utf-8?B?d28vZCt2TEd6b1VVcWdYMDlqWWVINFVGb0duRFd0RmhYQ2JSYkRDR1ZmeHBM?=
 =?utf-8?B?MW53Mm14RHNEZUhwTVNzRFR1dU9uL001enZsUDJ5RVVkcHJHcENwSzIwNnR3?=
 =?utf-8?B?QmxBSXkvK2pSenJubWVJcU93ajZnMnFkL2FDYjVoS0dCZUN1U245QlZzMzNO?=
 =?utf-8?B?TUF5Y3pCVVRPb3RoNmVpV3B6Z090amdIV1lUQldiRGNUczVVeXRrWXZRd3RW?=
 =?utf-8?B?c2g0aG9QcFJMSVpqZk9KbFRnU2FOa1FyL0J5eTZXRXpuVXgxV0xsNU1TREJk?=
 =?utf-8?B?Y3I1WGhHTDNzOEl5Qk9nOVh4SlNLNGN3VTl3bldLRlhzREFFV0pULzVCUWdl?=
 =?utf-8?B?bmZ2TGg4Q0R5VzdVczJDSVhLQ0htdTU5SHlYTlR0cnpGeklmVW9OWENTL3FK?=
 =?utf-8?B?MVI0eGE0WFBCK0FWYlowUGVUazkwTDZydXRmeGJwY0Zkb2NkQlAyajVaTXUv?=
 =?utf-8?B?dU9tYVp4Tjd3UGVoN0RJenhza29SeFN4ODZGMHg5cUQ4QVdWR09yWFptS2Z0?=
 =?utf-8?B?eDlqT1NHNEVHV1pFQnF5bG50VENOcUJ5dUhKeHZwVDBESkxrd1lUYjdmMGhI?=
 =?utf-8?B?OHMvRjdBRFM3SG1TYmoyakNiMnY2eWJ4bFpGbEFDMnZ4WHZWQk03RzFxcFkw?=
 =?utf-8?B?STJlNk42TGoxRGFsVWJiM2JDTms0QmJHQTF1SHp6b2RHNWVjOVhNT0RaV04v?=
 =?utf-8?B?M2RGcDZTdmIyNXJuK1dnblcxcFVBN2lqblRYOXhUSFZCRW1PdVltaCs4QzJ4?=
 =?utf-8?B?dE1MNWlLZnE2cTV2NUFzTGgrNjM4VmdCNmR0MUExS3AyaDRzaXRpU1VGV245?=
 =?utf-8?B?VmdIc05VVHBpUmp6eFNxRUlOQ0I3aUswQ1FNalNOeVdmS1NSWi9qa2l6eVhw?=
 =?utf-8?B?OVJDclAvekQ4KzFaRkxiRlQxM1JBVHFiaE95T0h5SWx5YUVMUzJrQ2lza2RO?=
 =?utf-8?B?ZENrczFUL1Bsc29LLzN6ZTdKMThMenkwUTYyMG9OR3RHbmxtVkdnVVVkcHI0?=
 =?utf-8?B?UWQvSlNuU2FrZG1kcWxmdHh0UjFwN0NncSthOUtoL1ZXNGFxSno2MXBhdTNv?=
 =?utf-8?B?SVp0dUtEb1FiV2E2bzMwUlhyUi9lZlRLdFY1U2ZxaUNGRERhZjlQUVJrUGR3?=
 =?utf-8?B?QjJwdTFCUDhhWHJNdzU0RDVnNjR2MXZsYXRsNVVrRXJTcnljMVQ3eDV6ZnJB?=
 =?utf-8?B?RVJiNG9MMDU0SGVXNUpLdUJVcUFjVGpJNFpETUV6a1Y2OEtyOG9Na0FrSXhk?=
 =?utf-8?B?aCs0a09xeDZyRGpDaWl4MjgrTjBEM1oxVEUzcENtT1R5bGgrSlhnM1MvaWtk?=
 =?utf-8?B?YlovT2p0QnhpOHdyRWFDK3A0WGpEWkRnQ09IdzBaM01Ybm9OWDFZeWM1MHBq?=
 =?utf-8?B?SE44WExjdTRaZURSTUtNSURhSTI5L0dFQ3RDT0ZnbkRLRmQyY1A1MXpoZEFP?=
 =?utf-8?B?RmRNRXVaZDh4SWQyaVROa0c2NjIwbXFEQm5jNmVuSldLTk1JYVZzTHAvQ0gw?=
 =?utf-8?B?MnQ5L0FXWkJSZlg5SVZuWlFzTElZSkFSazRRNXlwQTU4aG1IdWZ3MzM0YVFq?=
 =?utf-8?B?Kys3MXJyeHlhQk5WaTgrd0huSEtoUTNjLzA0Wk1zN1B0V3RDTDN0dlRtTm81?=
 =?utf-8?B?NjRjR0trZFVYeXJLbjhJblpkSFo2NkNzbDZka0tYZytxRHhzT3hXbksrYkth?=
 =?utf-8?B?NnBHRW55NWFaTkhUREY1S0VRMUxNMmRoOHRsZzBVOUFaMHc1UGRJVWxBbkI4?=
 =?utf-8?B?MUxLMTNxR2cvK2Fna3JmMTZZMFIwMEFlcUNnYnNUSC9ub2FoNEZPNDdpWDZx?=
 =?utf-8?B?S0RQRG5aMU5BNWU4UzF1ZTFsRDFyZklydkkxaWRqR3IxcUdNU3dCb1dTSS9o?=
 =?utf-8?B?aUV1VXZXY0hZOFVWTXZOTmtibE5RSkwzWVc0TnVzdW5rOGcyUFppZlhJMDh1?=
 =?utf-8?B?eThKUE5wUlBHNXhKZStBMGo1Q2RaTUpEVEhlbDZsemVidlVyYW40YjRUdWZB?=
 =?utf-8?Q?P764sv?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uzk3OHhzL0tPRCtkN2RPdkxpOTRGYnVzelZLVFNsd0hOWnl6UnFMVHRKd1pS?=
 =?utf-8?B?OFFQazh5MUtQYnBYUXA4Y2FDUGlhOFdIYVdsY2pCZXFBWjB0NkRIL0ZGMTd6?=
 =?utf-8?B?UTBwd1BhM2JFQmZmTGtsVWNQUmYyeDdKWEJPeEwwNzZRaHUwRExJWHJuam1o?=
 =?utf-8?B?WkVMNUl3V3o5Q0swKzFmQjJNdnJCQTZZWklwWW1VUko1c2FXRW56b1RKYlFK?=
 =?utf-8?B?RVR4U1hDQVRCbmJyaG1xTnZLUjRrVk91cWcwYTgvWEZISjF1RGJiM0hyeGti?=
 =?utf-8?B?b0RUdURWV2dsenpLZVZ3a0JYeExtUmI3eXZ3cXpKdytYbWRLNjNNdkVEalds?=
 =?utf-8?B?Y1dNenE0bTB2cGU5RUoxTEYwZU9uZXhsRTZ2YTd1ZUQzTlFiQ0ZrSlFuZmJM?=
 =?utf-8?B?UDd6dVJkZHlXcjRxcnlWbWFVTndXZUlIblB1VnZtdjl1SzBBQ3p5TEViSnpF?=
 =?utf-8?B?M1JRZW03b1Z5TElLUXp3eHV5dVFLZldxTDgyNWp3WDQwVTVDNGxucFpTWTJv?=
 =?utf-8?B?UWNkR3dtOG5nWjJtRXplK3Z3cGt3QUNxZk8yM1JtT1ROcTQ4QUsxaVk1NWgr?=
 =?utf-8?B?T3I3ckpkUytmRHhsdzViVjZobzdxR1dFSnBudTh0RFlpTC8zRllRNjN3N2Fz?=
 =?utf-8?B?WmxDYUI5TVFLZUV4VlJtRFFwamNsN0pmaFpoRGhhY01velc4RUVPbi9UdG50?=
 =?utf-8?B?Z3MwVU81djFacHNxei9LeVBWdCtCdGZFb1RueGdtWE5RbGp1K29NZWxxRHds?=
 =?utf-8?B?S2J3QmFaOVUvTVNSQ2lyY0NOY1ZRbCs2U1VJcGFhYlhZM0ptU3YwY0FEL3pT?=
 =?utf-8?B?LytENk1hcVIyamdyZjVJUTBrSWR3c1RBVlFkRkMxMy9uanpoTEdkQlZBaTk5?=
 =?utf-8?B?eU5rTzQ1ZTRmbkVyMnIwazdGN0JROXJEcjl4VGdBcFZwci9hZkJnSzhjNExk?=
 =?utf-8?B?NkF0WHhpS1ZjbWpobjlOTE4yeFdtaE4ySzBuL3k4SXcvTEgrbHkwRlpYSnlM?=
 =?utf-8?B?dWYxTEVZSy9DZTB1Y1k0SG5tR2Z4TW1Ccjc5RzYveWt6U3JUQVFEZXprQnZr?=
 =?utf-8?B?emhMbWZOYWRLeitySW9IaGZ5bDc4c05UaGJLSDFObFVnNHUvbkRSVXpyd0gx?=
 =?utf-8?B?dnN3MURmUmh3NGgxMUxodVVVVjJOTjlTSTk2K0lRb0dXNHRVY1UwSjFXelZP?=
 =?utf-8?B?bll1N0ZrQVNCOUhOaStBT1NhQmJKZW5zR29JVUJkV2RwQTJralViRTJrR0di?=
 =?utf-8?B?YndxY21HdjB5MDM4MHNLMjRxa3FjNFhNZHNjVmo4UjdtdFlTNkl0dC9QQzdp?=
 =?utf-8?B?L2tDbDk5SXk1ODJvWkpTc05UTVhyQmhpMXVnSlMyM1NxVEJVL0t6b2FJZXR2?=
 =?utf-8?B?MVhvM0ZQUmZ5YzNORlIyTVByMGtVRHVucGxNZFVXWWNRdXZDK0dMbVJ1Z0N4?=
 =?utf-8?B?WkR4L2s3dFFiOTlFNHJYaURtakc5U3RjTStKWkFEbzZBeTExNTVtSXBZNEc2?=
 =?utf-8?B?ZTNUdGxGRENROStpc3dKMDFHVm81SWRNL1JuQkJxdWpQNmNtTGJsUGV1bEJZ?=
 =?utf-8?B?bmVTdEx2UDVwK3dVUHd2N0VhTFpKUGFiRSsvY3cvRzh4NXB0WVZydTE2VFBN?=
 =?utf-8?B?S2tkcVE5aHVBTVV6VGREU0JxQjlkQmNTN2tpUzk1Y1N1cTRMWExtNjZrd0dz?=
 =?utf-8?B?M1hGRTdxdmY4UUkrcjg1TkVJbU5qZG5HTHhmakhRQVhTYmZxM3NIOURveDh6?=
 =?utf-8?B?dnhwd2hIK3hPR2MwR25WMmpmRUZUSGtRVHlHUEs2ZXptdkgyS0U5elpybEc0?=
 =?utf-8?B?Um4yWXZXbGxpbW8zQVR4Rk9QSWlpYitrbzNoVzVlNlhtNUJjWmtKVU14M2Vh?=
 =?utf-8?B?Z0RERHJMNnZ5SnhWSmYyVG15UVFMTGw3amxEVXlXby8vQmo5cmNKOVpRb1ZI?=
 =?utf-8?B?aC9PK25SQmwzdmVwWlExaFFDM1JZMlJCcHVuOHBJSUVUUFUrN0FkaUZSUXlR?=
 =?utf-8?B?d3R6Q0Vnb1FYY29NWkptS284TWF3R01uQWZ3TGJjZmo5NlpHWUVBOWVuZGR3?=
 =?utf-8?B?L1FvWFQwVTBidG9QRndycUsvR2xQb1A4Mm9KQ2NXOTBhdnFGUTkxTm55a2hQ?=
 =?utf-8?Q?CZih31/YB8jSswM9r8eHF8Ao0?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0E9A121E7C3CE948BF72FBDF93A2A6C7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 590b969d-9348-44f6-960b-08de13a778d9
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Oct 2025 09:18:34.0639
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoqrvxJy3y7cAp92vbDGAjSybu1TQC9PLB8ySilxj9LAIEi+C7RljN0ciEfr1OEte9krnA3P3qLh/NZ8OfXMhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR03MB6766
X-MTK: N

T24gTW9uLCAyMDI1LTEwLTIwIGF0IDA2OjUzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gQXMgcHJldmlvdXNseSBkb2N1bWVudGVkIGJ5IGNvbW1pdCAyNjU5Mzky
ODU2NGMgKCJpb21tdS9tZWRpYXRlazogQWRkDQo+IGVycm9yIHBhdGggZm9yIGxvb3Agb2YgbW1f
ZHRzX3BhcnNlIiksIHRoZSBpZCBtYXBwaW5nIG1heSBub3QgYmUNCj4gbGluZWFyDQo+IHNvIHRo
ZSB3aG9sZSBsYXJiIGFycmF5IG5lZWRzIHRvIGJlIGl0ZXJhdGVkIG9uIGRldmljZXRyZWUgcGFy
c2luZw0KPiBlcnJvcnMuDQo+IA0KPiBTaW1wbGlmeSB0aGUgbG9vcCBieSBpdGVyYXRpbmcgZnJv
bSBpbmRleCB6ZXJvIHdoaWxlIGRyb3BwaW5nIHRoZQ0KPiByZWR1bmRhbnQgTlVMTCBjaGVjayBm
b3IgY29uc2lzdGVuY3kgd2l0aCBsYXRlciBjbGVhbnVwcy4NCj4gDQo+IEFsc28gYWRkIGJhY2sg
dGhlIGNvbW1lbnQgd2hpY2ggd2FzIHJlbW92ZWQgYnkgY29tbWl0IDQ2MmU3NjhiNTVhMg0KPiAo
ImlvbW11L21lZGlhdGVrOiBGaXggZm9yZXZlciBsb29wIGluIGVycm9yIGhhbmRsaW5nIikgdG8g
cHJldmVudA0KPiBhbnlvbmUNCj4gZnJvbSB0cnlpbmcgdG8gb3B0aW1pc2UgdGhlIGxvb3AgYnkg
aXRlcmF0aW5nIGJhY2t3YXJkcyBmcm9tICdpJy4NCj4gDQo+IENjOiBZb25nIFd1IDx5b25nLnd1
QG1lZGlhdGVrLmNvbT4NCj4gQWNrZWQtYnk6IFJvYmluIE11cnBoeSA8cm9iaW4ubXVycGh5QGFy
bS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9oYW5Aa2VybmVsLm9yZz4N
Cg0KUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsuY29tPg0KDQo=
