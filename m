Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99591372
	for <iommu@lists.linux.dev>; Sat, 28 Jun 2025 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751098170; cv=fail; b=EhWLbGbTWPCx8qadMmLR3lyjOSTRFUERSl9uybeaLvpGD6cubsCFULTmHmLHqO5U8E/Gch1+MqhZ/7cvOagy8Ed7i5qyMt34+H6JGrRrZTY898bNAcsn+HBnlbi8gaqgXZp9RvM88JO3245mMn0fhDbvh5CxD3imzZMjgmlFAyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751098170; c=relaxed/simple;
	bh=+b7bkuffgIlXbI2MnfNJ3rbRy/4bHgI0Aomzxa7izCs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=M7H7ZboIQSG7FsqmeeP3VTkJMyrzgYcWChSgYbLwtLoqOg9GyveLcPYMVU8GouiCyFFZCtfJoTr+ekt5i8jpaMJ9CbYaXT47iE5ZgX2vHNLk6R0+iB+ZG4BHzYNd2uepB9ooY8nRl9Zv+jG7LKrptWeTVAYAH8oZ342H/TRd+sk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=kZmMKjHZ; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fahf8u5u; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="kZmMKjHZ";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fahf8u5u"
X-UUID: 2fcdb3d053f711f0b33aeb1e7f16c2b6-20250628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=+b7bkuffgIlXbI2MnfNJ3rbRy/4bHgI0Aomzxa7izCs=;
	b=kZmMKjHZCNzH0Q+YNdXpEZbBLrsXeHdDWMm4Nglnt2C8Db7YIvyG9iLrEyaJ0IyzrEmoR5A4c8ZBFEH6hIC01S4TXFJoamky+V6WsXPYUADOmQo1YMhXX7t7rfwey7tsDN/CnXIOLowUvEehMYbX1TyuXjb1NBkJ3z+ryLfywgk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.2,REQID:28546209-d8d8-415c-8938-d61bebbb74a8,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:9eb4ff7,CLOUDID:7962a873-15a7-4ae6-ad4b-94c27b45c266,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111,TC:nil,Conte
	nt:0|50,EDM:-3,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,
	OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 2fcdb3d053f711f0b33aeb1e7f16c2b6-20250628
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1682787871; Sat, 28 Jun 2025 16:09:17 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Sat, 28 Jun 2025 16:09:15 +0800
Received: from SEYPR02CU001.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Sat, 28 Jun 2025 16:09:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ju4h/ymKYPdo+KT5vp4nmGM8cGgGuUVWeoNvrOCBExMTRPMNZI9CNQu4hFaujYcQ/k7re3TdTkYy18ueT3W8oFty+3veL9R+/wyZ/qL6ZWkJPKBJw6iV9X88aKFae9NQjgl8dvNfPhdk20UK2zWEqyXAJ57Fo6hD+GxUqSuevaTIhIYnK6mKW4sY9oaOw2MpBo1Km5ZLA6By0Xqvw7fCUYxF0xlnUTHPVuDIcHWyLSWI25He9ufRp3B5V1iyyYPYDI1nus5Tf7oUg878Kcj1IeIA+KIJ3oyK/pRVHhwp8KZX8hGvcX9AQS8kmoj2xqQBBM+GlekITq5QxoY+OKmg8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+b7bkuffgIlXbI2MnfNJ3rbRy/4bHgI0Aomzxa7izCs=;
 b=bVPrCL5O/Bnz+FxbsnPHFKQJA42+SGs54fBDOb6Huuc3pAWUE0wQB4CY5ZMjEMrgR76Km39WkNbWeI/lmT1KxQWaF5I+4dfyvIrsdkewLIm7TGqS7oGFJfCmNcbfDWEZmzh1h/S2oGnF8HKK5c/spVH6cVbviGxo0jBzf+nU1ULLQStpk7/WRbHjEvyVc3tUVcqrBhKE9mc1SgNvoRUicpr9NnzDWLu3VjH8d4Qa2zThs9lBLy2KlnxteucY2G0L1YkGm9JgepokRRVgnTbVtIZfn0Xr6r+Ylqarv926kmRchr/nv6am004feZOdKSFHtVa/dMor85YFrMcOzzClOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+b7bkuffgIlXbI2MnfNJ3rbRy/4bHgI0Aomzxa7izCs=;
 b=fahf8u5uq29pk7dQjZnnEPI/k7yRrCnJsOans6C0ktS/yP3AErUDw6ddwW71bA1BcFBRKavwM+bBUjEY2WSQc1tpZ84+50K5YBuadiw54M2/23UACVUMrxk8hQEJvMsZPOphOcKZDFbHgfjAjbntRMDd0GRIVr9eItqt+YG3uls=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB6651.apcprd03.prod.outlook.com (2603:1096:101:81::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.26; Sat, 28 Jun 2025 08:09:10 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%4]) with mapi id 15.20.8857.026; Sat, 28 Jun 2025
 08:09:10 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "robin.murphy@arm.com" <robin.murphy@arm.com>, "joro@8bytes.org"
	<joro@8bytes.org>, "will@kernel.org" <will@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, "krzysztof.kozlowski@linaro.org"
	<krzysztof.kozlowski@linaro.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/mediatek-v1: Tidy up probe_finalize
Thread-Topic: [PATCH] iommu/mediatek-v1: Tidy up probe_finalize
Thread-Index: AQHb53VEisHr2dLbFkqkI30NqU7XaLQYOO6A
Date: Sat, 28 Jun 2025 08:09:10 +0000
Message-ID: <26474a6747afc1e018a2c99fc5589ef545a26bea.camel@mediatek.com>
References: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
In-Reply-To: <7c78149504900bc6c98a9c48f4418934b72d89ac.1751036478.git.robin.murphy@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB6651:EE_
x-ms-office365-filtering-correlation-id: 87311a11-dd88-4521-a34e-08ddb61b0ffb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?Vm0wTktDeDdSYWdzSzhFdm1GSkZJZkJxMy9pVGVMdlBQbEg3M0F3Zit2d3JN?=
 =?utf-8?B?alQ0RnU5QTRhN2lraTI0dytqL0VWY2FCVHpmbitxYVR5WTNQVmt4eGxTYnVE?=
 =?utf-8?B?Qi9CbzRDemZSV21BM0wxSWZqVDBlYVlNS2oxQzlkOFdVNlJ5aFBKcUtBZjZ5?=
 =?utf-8?B?d1pnZGZTUnBSa1cyYXl2ODlIM29SQnFueVlGdVJwME16YlRWTHdEODlaWFQ0?=
 =?utf-8?B?dStTZWxlb3lRUWFpY29wMGtiZVZYajh5VEZQZmRQaVJINlJpdVBNTEwrcUlW?=
 =?utf-8?B?SjdoVk9TZ0oyYnVqLzZGZlFXWENxZnBVK3IzeXFyU2Q0THd1RnFzSlBFWC9V?=
 =?utf-8?B?ei9naUpBdE9idkdLSnBERzNLaDMyRnZsUDdmZkQ5ak9rd0FTcnk5WDYrYTFz?=
 =?utf-8?B?c0c2aHAyMW1wWDNqSmppU2xXMlhPZ3RVVTdKZTkwYnNqTkN6c1Y2Ykk3QWo2?=
 =?utf-8?B?NzVkY0NBOHRrZ1dWQks0d29uZ05tbGRJbmRSUHJHbE9GdGRVNkVrWVdBOUFs?=
 =?utf-8?B?UW9meEtRYXh1OHRBbm9UNkhtUnhvcGtFUXlsR0ovdE5XRGVjYjk2Sk5oSDNv?=
 =?utf-8?B?enRva2hIb3I0N0NFUERmMTdDc2YwcTdRZUtjY2s0RDhOTnVXbUZ2L0tIcGlF?=
 =?utf-8?B?UUtlbFBZcllYd1Y0R3NyUDNCNWtXRHphaUZtamN4NUdtU2ExeEtCSVoxRFZy?=
 =?utf-8?B?aW1WNVcvWFg2cGJzczVhdUpqTnZ3aFhra1pZd1NNVWxxMUUzOUZjTXFIbEFL?=
 =?utf-8?B?LzB5WTVPRGNxREZDczZPbWJ0bFIvWFh2T1ZQbFYwSVZTeWVVdFZWenpEaU9s?=
 =?utf-8?B?MUhZOW1EbmFDTFhWWERQaTR0T0hPSC9GVmNtek1mOHRQZE93UVRBQVFYTkZi?=
 =?utf-8?B?T2xqOTlraFd4UmxKQjlsMnZZVzZCOWZQTUloKzRuNENBUDh2ZzhIYnc0d2tX?=
 =?utf-8?B?VkxoUHVseUNaNTVYVXVkU0ZaOW9FUnRvb1YxQzlmeUViWEQ4SFlPejdmRVk5?=
 =?utf-8?B?dmdEYTNDV1pjOWpvZDcvSmNjUjBCcDVaNnVGVjdYNGJWS2hUMStTMXZLYXJB?=
 =?utf-8?B?Y2xoRVJCK0RWbHI1aFBYNS8xcy82ZTB3M29EOVVrRlJKc1pJRm5yVDRzcHN6?=
 =?utf-8?B?ZXJuN0E3QW15Rm15WWxkeU93Y0EzTUZsY3E0WW1wRk5vQi9DVHJzZFNFQmtH?=
 =?utf-8?B?KzJPQ01HMm9Ja24wdDRXNE9DVy9ZVG5NM004K2tSYkppUmRxTU9oN2YydTFi?=
 =?utf-8?B?U21PSFJGS0dFRjJ6dm02T2RKSzJFeFE0V21NbUtyOVh0ZzJYOGp6V3Vadlhw?=
 =?utf-8?B?anVLcFRmTEZ4SXJyc1cvV1hUOFlMUnZLVkhTV215Rlo0Z3hwcGdaU3Y3dWR6?=
 =?utf-8?B?Vit2OHNLYmlJbm9zRG1HdExrTk80ejBVaUEvRTJxdEVwMTZrb1pIcHBsYUdD?=
 =?utf-8?B?d1RkTExYZHl2QktlM0Q4SW1NMDM3dUNEeVhMMnh2eDhYbWN4WHhKMWZ6N2c1?=
 =?utf-8?B?NTlaRWo2YlR6NUtvejZ1MW5qd1dZS1FsTUFTcUdkOC9qMlYxY1hId0tUS1Zn?=
 =?utf-8?B?UDNVeWs1N3Erem5oUkRYZGxNV1dTK3RwTG9HV2taNXRsTlFJMnlIMUZhRFZO?=
 =?utf-8?B?ZUcraXoxbzZkeEtCVG12dDZsdlhXWUtPUkdIR3VGdjBkSTVQM1FqYmx4MEgy?=
 =?utf-8?B?eW5JRm5jbFZPbmVKc3FmRGUxdTdqMHl5a3VNYS91YzlTVDg5K2IwVHhpQjZV?=
 =?utf-8?B?b2JCL3d6UUpyWnk2bXpvREh5dTJhL2FDZnF5SVVpVURkOUEzNzUrbGFMVUVL?=
 =?utf-8?B?azVVUnI5ZzBKWDcrQ0JlVnJQZ0pRWW1jblhBbkRIY3dCakRSK2JPTHk1bTRn?=
 =?utf-8?B?UXB2dFVMdDFKc015dm8wSkQyTWFMRU1WTUJGRG1sbG9QSHEwWFp6aU1tMldD?=
 =?utf-8?B?VlU1Y05CYXZia2ovcXAzOEN0d0JSUEtPcy9QV3gxSjBjZGN5aDFnR3REMEFF?=
 =?utf-8?B?eERWeGJBN3dBPT0=?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b1VmK0FmOWhjQnR4dWJ5S3VvdWdURjZ3aHhNYlRmeWhHZVVCd05IOGxxYzJW?=
 =?utf-8?B?dmhWQlRXTnAxWFlwUW04NkpUbUZUbWdqT0dYVk1MVHQ2Uk5DMWYrRjcreElE?=
 =?utf-8?B?NjNLblc0MkRGWWFmT2J3TUgzRlpnWEZHZm1rdFhUWVhQWTdhRkhFWG5WSzV2?=
 =?utf-8?B?WER6UkNNUGVhTmdlVFBRQWFNSXgyWnZUU3NXMGFscW4rU01zeWxodTNOeTd2?=
 =?utf-8?B?cnZmMGR3cDRNVUNIMUpka0hUUHNzN1JqRlEwalhnZXNxb1RXRHFwWmY5ZmhG?=
 =?utf-8?B?eThFT2NaZkhQOFRJMnFYbC93UVBiVHZrQ2g4MXZ0eEhEYjdGZTJzVHhCdUl0?=
 =?utf-8?B?cGlqcVBvajZwSm0xNWZPVnZQSjVWdzd1NGNtZFFsdzRWdHZhN1pTOHo1azdv?=
 =?utf-8?B?VTMrK0c0d3JvRCtPbldQV1VYSjVNR0VPd3R4Y1NMYzA3Z1dOVnN2NTllNTFD?=
 =?utf-8?B?Ziswd3RLNUMrWUFJTWFadHJTTmd6LzI0U2NqcjVPNDd2R0ZnZGJ4RmJYUjVV?=
 =?utf-8?B?SzVReGdyL3ZoTFA2MW5rVldWL1RydURWOXc1MDA4dzN3eVpZNllUN0VqZENZ?=
 =?utf-8?B?QXh0RnNFd3B3TXVDQjQzZzZiR1lsRnhVS2Fsd1d0QWF2cGdLNEFRbUV3VjdJ?=
 =?utf-8?B?eVVjVDZxL21ZMWt4c2RRS0tQZHRvQ1k1Z1VTbWpDTXdub2EvMmw5dkJUbzJu?=
 =?utf-8?B?ZU9sR2o5Q001VEdzOFNEa2F6SkJjZDIzZURnR0VHRTRVREpTWnozQldxVEpE?=
 =?utf-8?B?QzdiWjY1QjZ3dWhsNHgrUFNpSExlOEpCdmt0QmV1WE1sU1BNWWZZZzlUQWxN?=
 =?utf-8?B?eUdjZnNiaTFPZTZxQ3diTS9wTjBpMVhieXZzUjJ2V3VOZExtRHFiMzBiYmhR?=
 =?utf-8?B?cjVFK1N3bnQ5UFNINkFWdUlXdms3YzA1aHFMQUVadTVZazRoUDVXV1g2djJT?=
 =?utf-8?B?YUc1SXhPSjJ2VTBtKzVrak5zUUVTWXRMdVFFSlRSOXFrYndOellSL1dEZFNZ?=
 =?utf-8?B?cWwxTTZHMk96TnJYOS8xM0VXMmVMSCtsTUZldG55Z2VlMVNmV3lzQ3luZHll?=
 =?utf-8?B?STRwVTVod0dodFRLdjRlRWxMb2pYTEZ2UEFRT1pwQ0cxa0Z2RWJXckFZVGJQ?=
 =?utf-8?B?MzV3ZzYrL1dvb1BQT2FEOHhFSERtVVZvdzZRd2pmZDdWRnJrMDQ0ckFtVU1o?=
 =?utf-8?B?Nk92MHc4SDlZQ0xhWmM5VzhIbll3YmFHSUIrYS9oMWpFOTJCbWF2VGNwL3Vv?=
 =?utf-8?B?QjIxaTd1M2gyVC9ReTV3TkN1QytIUmtCTjY1WkZXRlQrZHdoRVVhbk1BNkl5?=
 =?utf-8?B?NjJwOHFPVlpSTFEyeFZrZStPZU41RytIVG4zVGdrdnVwaE5mcjRuZW5DcWZm?=
 =?utf-8?B?MjhvZDdXektldXI1T3VNVE9HckdXajgycStZSngrMVBlbTN0b2NtRzdKN3VD?=
 =?utf-8?B?NWk3YzBmZWFxMVAvSnFxWnlwd3FVbzRXVC92NGJPd2NlR0hITThYMmhFdTVL?=
 =?utf-8?B?YU9VeC83eFJkNlB5UVFLNWRhaVVEb3NENWJiSEFqa2xoOHo3MUhVbXJrQkp3?=
 =?utf-8?B?YzFUZXlHRGpUR3VaQ3RjdVhKTUcwWGNUUFZTRVd0YVlDcXBkRnZQOS9vWHFa?=
 =?utf-8?B?YkJQK0lLYTBFN2t4QW5WeWxJV2hPTnVrVkp4MUl2LzNRTXkwQ0R6bHBtM1Av?=
 =?utf-8?B?ZE5kTXZzckxieXRsRDBUelJyd29jdGdGSkJUZTdpVUE0Rm5jbGtuV3NXYVFT?=
 =?utf-8?B?VjJ1ZzI4cy9UQjhSOGNvOGtOQ1g0Z3FtTFc5anJoRTBWL1N6WnBDckVMa0pQ?=
 =?utf-8?B?d05tc0Q2VWNpcjhhWmZCUDBVSWE2cFdxRktoaUFuY25yZDczeXlQVkVMTzdt?=
 =?utf-8?B?NEk1WjRWTlpzdngyMStyRFdSeDVjYjgvL2wzc21oRkxFTHVKaGhpbzZiT0hu?=
 =?utf-8?B?U3JFYmJJVVpZTUh4MWlBM3hBMlMrOTVqd3JUa012blFHN2VkSzROZk9sYXFI?=
 =?utf-8?B?MUpNNHU4aklUWEwrT2ZRRFVNVlI4VWRFa25vZnFyS3ZRUUZUWC9BU25jemta?=
 =?utf-8?B?OVJoVzdiUFBsWFZETnI5TUhBdllST0prZFhHODE4aU53dE9vKytFa1F6blNZ?=
 =?utf-8?Q?DToH+4rBI3mflZ2ThF8E8Alxb?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BDDF04F3CA9AE94AAFEBDC8E670087DD@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87311a11-dd88-4521-a34e-08ddb61b0ffb
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2025 08:09:10.4556
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Mom/xJU4OWTSmS0Erw6aoJIR+ivvg43KB0BrJdV1fE0OF3Nzsq3vzPmBhPUfxdQ9QiapIhk3lwAl2ok6tprsLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB6651
X-MTK: N

T24gRnJpLCAyMDI1LTA2LTI3IGF0IDE2OjA3ICswMTAwLCBSb2JpbiBNdXJwaHkgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gS3J6eXN6dG9mIHBvaW50cyBvdXQgdGhhdCBhbHRob3VnaCB0aGUgZHJp
dmVyIG5vdyBzdXBwb3J0cw0KPiBDT01QSUxFX1RFU1QNCj4gZm9yIG90aGVyIGFyY2hpdGVjdHVy
ZXMsIGl0IGRvZXMgbm90IGJ1aWxkIGNsZWFubHkgd2l0aCBXPTEgd2hlcmUgdGhlDQo+IHN0dWJi
ZWQtb3V0IEFSTSBBUEkgY2FuIGxlYWQgdG8gYW4gdW51c2VkIHZhcmlhYmxlIHdhcm5pbmcuDQo+
IA0KPiBTaW5jZSB0aGlzIGlzIGVmZmVjdGl2ZWx5IHRoZSBjb3JyZWN0IGludGVudCBvZiB0aGUg
Y29kZSBpbiBzdWNoDQo+IGNhc2VzLA0KPiBtYXJrIGl0IGFzIF9fbWF5YmVfdW51c2VkLCB0aWR5
aW5nIHVwIHNvbWUgY3J1ZnQgaW4gdGhlIHByb2Nlc3MuDQo+IA0KPiBSZXBvcnRlZC1ieTogS3J6
eXN6dG9mIEtvemxvd3NraSA8a3J6eXN6dG9mLmtvemxvd3NraUBsaW5hcm8ub3JnPg0KPiBTaWdu
ZWQtb2ZmLWJ5OiBSb2JpbiBNdXJwaHkgPHJvYmluLm11cnBoeUBhcm0uY29tPg0KDQpSZXZpZXdl
ZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRpYXRlay5jb20+DQoNCj4gLS0tDQo+IA0KPiBTaW5j
ZSBJJ2QgYWxyZWFkeSBnb3QgYXMgZmFyIGFzIHRoaW5raW5nIHRoaXMgdGhyb3VnaCwgSSBmaWd1
cmUgSSBtYXkNCj4gYXMgd2VsbCBzYXZlIEtyenlzenRvZiB0aGUgdHJvdWJsZSBvZiByZXdyaXRp
bmcgaXQgOikNCj4gDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jIHwgOCArKy0tLS0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkNCj4g
DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L210a19pb21tdV92MS5jDQo+IGIvZHJpdmVy
cy9pb21tdS9tdGtfaW9tbXVfdjEuYw0KPiBpbmRleCA2NjgyNDk4MmUwNWYuLjJmYzE4ZTE5NGUx
OSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXVfdjEuYw0KPiArKysgYi9k
cml2ZXJzL2lvbW11L210a19pb21tdV92MS5jDQo+IEBAIC01MDksMTQgKzUwOSwxMCBAQCBzdGF0
aWMgc3RydWN0IGlvbW11X2RldmljZQ0KPiAqbXRrX2lvbW11X3YxX3Byb2JlX2RldmljZShzdHJ1
Y3QgZGV2aWNlICpkZXYpDQo+IA0KPiAgc3RhdGljIHZvaWQgbXRrX2lvbW11X3YxX3Byb2JlX2Zp
bmFsaXplKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIHsNCj4gLSAgICAgICBzdHJ1Y3QgZG1hX2lv
bW11X21hcHBpbmcgKm10a19tYXBwaW5nOw0KPiAtICAgICAgIHN0cnVjdCBtdGtfaW9tbXVfdjFf
ZGF0YSAqZGF0YTsNCj4gKyAgICAgICBfX21heWJlX3VudXNlZCBzdHJ1Y3QgbXRrX2lvbW11X3Yx
X2RhdGEgKmRhdGEgPQ0KPiBkZXZfaW9tbXVfcHJpdl9nZXQoZGV2KTsNCj4gICAgICAgICBpbnQg
ZXJyOw0KPiANCj4gLSAgICAgICBkYXRhICAgICAgICA9IGRldl9pb21tdV9wcml2X2dldChkZXYp
Ow0KPiAtICAgICAgIG10a19tYXBwaW5nID0gZGF0YS0+bWFwcGluZzsNCj4gLQ0KPiAtICAgICAg
IGVyciA9IGFybV9pb21tdV9hdHRhY2hfZGV2aWNlKGRldiwgbXRrX21hcHBpbmcpOw0KPiArICAg
ICAgIGVyciA9IGFybV9pb21tdV9hdHRhY2hfZGV2aWNlKGRldiwgZGF0YS0+bWFwcGluZyk7DQo+
ICAgICAgICAgaWYgKGVycikNCj4gICAgICAgICAgICAgICAgIGRldl9lcnIoZGV2LCAiQ2FuJ3Qg
Y3JlYXRlIElPTU1VIG1hcHBpbmcgLSBETUEtT1BTDQo+IHdpbGwgbm90IHdvcmtcbiIpOw0KPiAg
fQ0KPiAtLQ0KPiAyLjM5LjIuMTAxLmc3NjhiYjIzOGM0ODQuZGlydHkNCj4gDQo=
