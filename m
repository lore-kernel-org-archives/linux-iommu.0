Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0440278156
	for <iommu@lists.linux.dev>; Sat, 18 Oct 2025 06:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760770285; cv=fail; b=aOSY5nAQzbNcPXPworlY83lYSAUrcmKQjRlsevPX1NpOG/u8lndgXQ7CGO8/slN6Hh6a9nfNEm9ugC49uZx/J8IKXYL8iQEjmWWsWVnhzINcEU5Scb9Wobc/rKM0PFnvPGFwiKTDUNdQoce6bY1DG7vOdRT0tVGpVRtvWJGFeRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760770285; c=relaxed/simple;
	bh=5pm5lZ2gugu8S1OTFnmgCjRms0DcDubBqtk8WlZO9jQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=E9NTOLizV7oLi9B99XEN3X24ReroGwH9ZfEO0Ly4HR8TPElbF53AgcbW60KOiNnoyRGcVACWEdwxGYSP2IxhN8C5DpRS45KNd/ojoDWks81T3NG7/Ygh+X7FefLVOSrQnBf52JfY+Se2XPw06ASaZfi0JNdKkqJh6C5JhpxPejo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=CvypfJtY; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=fb+PKnjM; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="CvypfJtY";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="fb+PKnjM"
X-UUID: d8ba9900abee11f0ae1e63ff8927bad3-20251018
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=5pm5lZ2gugu8S1OTFnmgCjRms0DcDubBqtk8WlZO9jQ=;
	b=CvypfJtYBfK8MDDrF3JNGEOg2EqJaIA3EL39jsnbCJgSlQUv0lvnKLZHeqMl8pLoc0G0ExpRGTTI3S5sakka9KvIlaXDrEBl/lCaPLI6nvCc5wreRuYTqO/WItmdddzorcZpVOI2UfV9GImnPMqALoFt4Zm4xMPWqNyNjIMCj7s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.6,REQID:5ef9f0d5-9e33-498c-9430-fd6bd5e5604f,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:a9d874c,CLOUDID:c7938502-eaf8-4c8c-94de-0bc39887e077,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:80|81|82|83|102|110|111|836|888|898,
	TC:-5,Content:0|15|50,EDM:-3,IP:nil,URL:0,File:130,RT:nil,Bulk:nil,QS:nil,
	BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d8ba9900abee11f0ae1e63ff8927bad3-20251018
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 112698040; Sat, 18 Oct 2025 14:51:17 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.26; Sat, 18 Oct 2025 14:51:13 +0800
Received: from SG2PR04CU010.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1748.26 via Frontend Transport; Sat, 18 Oct 2025 14:51:13 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VNIisGuAyzs2DlDd3Kvu4NaMOWaSTrqP7GnYPuoPg3U8HnjAeFrbU3+2d2KUgL42e161M3Dyru4JA0J5Ct/K4zW+XeWuUHSToEJLu5KO2gt3dTBMDcFZVOAZclPsIecT7XxOdIM/fhZJk6kDyqtcn3uEIKE98GDgjIEFpeZXGvPop6yUx+W0Nfz0U9V4DFRuf6AdasZAdY7LDQd4iiwO3zSZKSwYVHFRwxG7QJr2IsXkfUmhocPT0jDu6H4xrpoPvY3jY+w8sLlZz4n+o7E7AUF507hhKGoD0TBSciabaY9JGF8+uXsjin0XA4sOY/5AyGvrmDA237Qml42WxX4tPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5pm5lZ2gugu8S1OTFnmgCjRms0DcDubBqtk8WlZO9jQ=;
 b=bkhtLcsY6F8Z3amcCq/+fCH/APd50oOebWqKYcWsg51SfB7IVHy4ljBAyAQ4beRQqcPa9AhIaKb4dfnQRNmtXKTouGhU1vw+oqs86tnz9gx8aBmUvJigV0Abm8U/1cLIr96b/YhiUThkSBrRUlJGo8nt+vSWvCxBrSXD0mgw1dXLQT6qJlmI87yxYDRL7Vi+/5Pf+a4Nw3RYWj3y9NttxUXmeKoG7C9u6EPUCEnA2M5bXEi5dQJcBXZRNM0L+ExipYmEQ5p17QBJmQcM6gmKOm2LfNSsJQWbiRMnIo6i8zZLxLnnbvKLHobhffa8FP4D0QP7w9VgWO7VlbCKGagiYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5pm5lZ2gugu8S1OTFnmgCjRms0DcDubBqtk8WlZO9jQ=;
 b=fb+PKnjMQztHTutlKp20sMLMZGKOuj7+sWiffyPsKrYGvsZbM/4nJc4QyQbxJzcuu0um3+BfDaXaKJHoGULc2LwfqN784GvFMu5AETrqG/bBCmcFHzkA+BZxk9urGUHLjOlpVR6o93VLe5DerjgoA5nf+w0PzdFqQ3UPXnj9TYY=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 KU2PPFDD2810A4B.apcprd03.prod.outlook.com (2603:1096:d18::42b) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.12; Sat, 18 Oct 2025 06:51:14 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%7]) with mapi id 15.20.9228.014; Sat, 18 Oct 2025
 06:51:14 +0000
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
Subject: Re: [PATCH v2 10/14] iommu/mediatek-v1: add missing larb count sanity
 check
Thread-Topic: [PATCH v2 10/14] iommu/mediatek-v1: add missing larb count
 sanity check
Thread-Index: AQHcN28X5I7EEXajYUGVtDxJGuyIs7THiFGA
Date: Sat, 18 Oct 2025 06:51:14 +0000
Message-ID: <64c2779b8a289e8d91225f5f9f82cc1cf299bc46.camel@mediatek.com>
References: <20251007094327.11734-1-johan@kernel.org>
	 <20251007094327.11734-11-johan@kernel.org>
In-Reply-To: <20251007094327.11734-11-johan@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|KU2PPFDD2810A4B:EE_
x-ms-office365-filtering-correlation-id: 0e98d48e-b7f0-4b03-a889-08de0e12bb00
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700021;
x-microsoft-antispam-message-info: =?utf-8?B?MS92YXRjK3Ric0FiV1dtaXE0UktVQUU3cXdhNHcvc1cxWStzdllJbmZ2aGw5?=
 =?utf-8?B?MTlUSGgzODRDdVlNM2hLUGxOaDhMRHBPSEZubXVzRjdVblBPeGxxQnZvVkRz?=
 =?utf-8?B?RVEvT2Y2VWNWekRnZmtNREgvUkoxUkIyd3VObzlmTUpxUWhFcmRSSmN6emJE?=
 =?utf-8?B?SHpJY0F2OWQySkVsa3RENW02TDFaUXF6SWZQRi9XL2JjVWpKcEEvaW9pWjlN?=
 =?utf-8?B?amI4TTJBaEFLZThtdDh5U2tsQis3WkFLQVZsVlNuRDFvMFIvSk5wUGUzNXp4?=
 =?utf-8?B?dEhJS2tNODR3YmVCME5EdGxjQURCNkxPYWpHY1ZZUnFDM1dhY3NBNTRpSVJ0?=
 =?utf-8?B?T1Y3VUcrMEZwaC9aNlhzR1ltSW5FcTY1c0NGQ3NsRGxjbUhNeG9lQXlSTDQ2?=
 =?utf-8?B?MHBPWHh2SWpvL2JLOE1iMWVKYmZ4RXc2Y2tyVVdoN0w0Ujg0QW02dkl4YVRH?=
 =?utf-8?B?YXcwN09Ebmo3Qmt2SG1aRG5BbG1TQTVmMjE1UWNuUW4vUlRzMzcySTZaSHM0?=
 =?utf-8?B?WnQ2U1NRY3h4WG92eVdPQkNHQzEvNHMxQnZlMFF2VUFEZ1l3ZFI3ZjBaOXRl?=
 =?utf-8?B?YTRVaVlFdXJjejhSSGtGRFFOWi9PbHdoQ1R3cCtFSWtadHdvNWJETkJqam13?=
 =?utf-8?B?enFpb3JoeXJFdk1QVS9BZy9BdUtnQnJCUTVndThJVjZYclpqOGhyNHRsMjZB?=
 =?utf-8?B?TmRJVkJuby92WGZ0NzdRZjB1dllFMXArWG9XTTRablQzV0ZDVTlXT1B0cnFP?=
 =?utf-8?B?S3hGd3hObmVaVkdPU2xHZFFrR2hETDhtREphbDh1QWdxdUhEWFVEbG8rVnJW?=
 =?utf-8?B?Y0FQU3g4RHJZWUJmTXRNc2ROWUFKb0wweGpTbDV5eUpkS3A2ZmF5Q0RuMVhu?=
 =?utf-8?B?RGpVUXc2TWhNSy96MDFCbVZ0OWZwNTRoSkRyYmVZeG53bXFRUEw5aHpWMldJ?=
 =?utf-8?B?aEp5em5HYmZ0STk4Q0QzSENlVUNIVWpveCtNd2U0cTN0UGxyWDBLdUprd04y?=
 =?utf-8?B?V2J5QWpmT091L0dlakwxVFNrR3g3Mjl6ZjlZaEE1Zmg3VTBZNmduamZsWG5y?=
 =?utf-8?B?U1EwNVlubHZOL1NRbGY2VGNKWmxOMCtkMW1MNUJWOTluMjJkRGlBeW1zcHV2?=
 =?utf-8?B?QmFobm1nODVQWnNGdS8rYUR0UThHTjl0b3p4VlJGUDVwcDBBQ1N4Szlmck92?=
 =?utf-8?B?bVcrZURacitvaCtRVjV2dVF0cEp6SFhMZXJRUTVXRldVb01Rckl3bmw4MTJB?=
 =?utf-8?B?YkJQeEJvSHE3cWk0UmVleFdGTVJOVExxUGxsMkowQWYyczJHTVFvd3p6Qjkr?=
 =?utf-8?B?SlZPcGlSek1sUkNUR0VyR29rS3JFcXhSRXF2OGxmc0taQ3JaKzEwUDN3Vyty?=
 =?utf-8?B?MmVhbjkxOUpQVVZtYjZueFJ2cTk5Z2g2d1NmQTg4UWdsd21mTEI0enJyZ1Jr?=
 =?utf-8?B?ZVh2eDZGL0F2SzJETmFlaTBFUFNsVXYvckJ5VzlUaGJ6RituMlZTQnJZeHRP?=
 =?utf-8?B?clRVOUFuOFdNZ3UyMHIxdkdpbU1SUUN0NlJZTkZZQjRoZllvRDF2VkUyd2FL?=
 =?utf-8?B?ZVlrVStqVm1KVmh6SXp6U2YyNGd5NlNoRHg2Q0U5L3dFdUNlY2k5TGozVHZM?=
 =?utf-8?B?VklCamE0THBCbklMb2FKNFkyMlgxVGJCTjBtSDFCTUx4WlVCV0x4RGxOU2Y2?=
 =?utf-8?B?dk0yVlhCbW4yK1NQalcwVWpZcHFKQzh2UGp1cnZtY09IWG12NUlYYXdKQlNj?=
 =?utf-8?B?dHJDMFhnK3NhUmNiL2dYdVNVSlNKdlFlK1ZCZ3JmZldjNEJqeXlNUHdQYkd1?=
 =?utf-8?B?L1JYaCt0TFZzTy8yUGFHMkZ1Z1NZQU5oQUNoVjdJTWtSVUxVTjU3c3BmQXVj?=
 =?utf-8?B?R1E0TElqaDZ0SVFLak9sb0ZtcGgySHN5WkFSS2VaL0V0NGg3dWszODd1dFF3?=
 =?utf-8?B?YnNSdmlwRU1TSFJkZDVKdGJPSjFhRUcyYldJMjJOdUJEckwxU0h6TVlJY3dT?=
 =?utf-8?B?NDRQWDZjTG5NVzZnSlJtUWhtdFRmVnhvdE1NbTllK0lqNmg2bWh0WUwxTU1R?=
 =?utf-8?Q?zMQmNe?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFBaTlpRcE1xVzNpM2FnRGRNL0ZSeFZwSGJ5R3JjS3ZtNE1SM3RPbFZxajdS?=
 =?utf-8?B?MC9Na0plbllGNHNTWnI4dkRuOEFmdmIycHBieWIwdmVHK0EzK05IY05HQlU1?=
 =?utf-8?B?amlTRjNiY21sdWxoWktMUFdES1FvTmhCMndWdW1TcSthS2NRaURuRlNQYTdX?=
 =?utf-8?B?bkhKR3JIM0F2OTl6dHpWaUF6d01HUjNtdk1LMDUxNGcvU0JkTjZCbThYcFVk?=
 =?utf-8?B?WUxzOXByQ1NycnlYazJIcjdZYmk4VE5DQnVCYXM4Y3BYdUNhckNPejZLd2hM?=
 =?utf-8?B?NnJMWGJnM0FyeCtuUTlUME5TbDZTWFpaaTZjbitZVkhtNlgzWkhuNUU0cGdE?=
 =?utf-8?B?ZDdER3ZsSjRBMk5lb2d6bVFITCtuRnl4SlpGWVB3czU4Szg2NmpTb0NJYWht?=
 =?utf-8?B?dTRDZnppNDR2eXgza2VNdTZEMXNwRUoxZUsrdlJyWTBIMnRMdkFab29qeXpV?=
 =?utf-8?B?QUJoQ2FBTkVKOUM0cnZEaTNla0U0RmplQmJIU3hkaGZHYlY0cjlYUHUvaElM?=
 =?utf-8?B?RVhHVkMvZFVNOWlWZFk0dWpmb3VYalZXelBGdFhOZnl0SzFPSG9hQld2UE9J?=
 =?utf-8?B?TUpYSmp0MmRQN255b21ubm9nVU5XWENmV3ZxQ3k1YkpadEZ1Z2YrdXNtTDA1?=
 =?utf-8?B?Wk1JNXJMYnozTUxZMURYZElwMW1RVk9DTVFLbFF1ZitmNGhielVJc2E1Ym1q?=
 =?utf-8?B?Y05CK2pjWk5yVkVIdUJCMm0xWEV3ZFczWHBsS3RrNzc1VS9Qa1NxdTJIdUFl?=
 =?utf-8?B?VTkzOFpCa291R3JyUnVnN1VyWU4zUE0ycDF1Ri9uVjVTZjBoaXNiWjBtTHpK?=
 =?utf-8?B?SC9BYXRhWFlPZW84WU9TV1FzcmlrUGNkZ2M0RkpqelE1MmJTUUp6cGlUOFY3?=
 =?utf-8?B?QnJoSlRFNzEzOUlRMmdTWGVSNVlSL04rRDBZTndQVXZqRnlUWUNMeDFyRDlF?=
 =?utf-8?B?MGdVcGRZUDFMMks2Q1I0K0Foc3R4WTNaaHd0ZmRoNWxMUkZRNlRiTXQ2SU9x?=
 =?utf-8?B?WCtuSkdBUVM2d09LTjRQZmhKTHN1OVlJYVA2N1NkZTVXOFdRb01lRThIbDJl?=
 =?utf-8?B?bzJJbFo0TCtGZG12eDc1eDcxM1NJZ3hrSjdFcHBsVHRRZ1ExdnE5ZnF1M3Yy?=
 =?utf-8?B?Yis2MFh0NXFiYmpvTEU0RFVEUHM2Z3ZYL0hjeVdoNFRQRUtXSlFRYUJUVFNn?=
 =?utf-8?B?eTI5dDVUUkRwU2U2STdwZDhMS3ZvdXV1TVFzY0VmTUNQTXdkY1d6T0Fna3dZ?=
 =?utf-8?B?WVlvdHBMSVVxMzNvTTJXM3FQVnQ1blU0bG1SQU5hRTVuZWZOVGZEbUdYYXVp?=
 =?utf-8?B?NXpaaGx2V0laYWRKenF3OWpPTkNiN3dUWHF1YW1UODBWQ2t3dW55dUVDNGVo?=
 =?utf-8?B?ZHJNZkpJTGJwWlpnQkZwV0dESWV0LzF4VHg2aERzaGJVSndWS1kvbU83bUtT?=
 =?utf-8?B?dDREdkkveUJxNHBzSGJORG0zNWRaOGVwSXVnb1NqdWdXRGtSamR3andPb1N0?=
 =?utf-8?B?V0JoaGxsZDhrRW9iY3g1cSs5UUlnZTN0WlRxc0dsOUs3K2R4RlAvQlZhTyt1?=
 =?utf-8?B?bUx0eU9jQnJyZnp0RWljUnlaeHhDWHFlUzlBaFVPdVRXSFgvOThnM0hKS2cr?=
 =?utf-8?B?alNoQ09FckpmanQrWE5Obi9aK3ZKSFBqbytITFNlNGEvZ3gra2k0TE9iOHJG?=
 =?utf-8?B?VHFBWndqb1VPcllPQ2ZaNXhUbU9ORFNQZlNObFpScGZ2NWJmejluSnhnTmdn?=
 =?utf-8?B?bGZXRHloMTZIWXNISGlhNndoZW9lRUZuVFdSSE0xU2gyQWdJTG1FRkdTTTFx?=
 =?utf-8?B?NXA1MGloZlNVMlZnWSs1cFVSRi9DZTd2YmVTUUxpUklaakRDdktCbjJScDBY?=
 =?utf-8?B?S3lzZDZ4YzRRM1BIV3BFckxiR3RjMlEwZFVnS3Jxalc3bHJHUzI1WTJjeG0v?=
 =?utf-8?B?Tzc4Skpib3VKbFFtM0Q2VGFXcWlwV0Z0WkV6R3ZHa1ZFYWlieHFGSS9ybGlF?=
 =?utf-8?B?bDdsWEZiRnhlS05YYlBRc0dtZlZKT3VBcW1ZT3c1cFN5Nm9BcFRQeDZVaFc3?=
 =?utf-8?B?N0d3ODROUncwQy8rbmhtN3dTdVdqdXpXalBzYTl3b212TVNhTURsZ3E2Qm1z?=
 =?utf-8?B?WURnZkU3U0JzbWFuMWNUTkw1eFNUcnhGenJ4VytaOTZVMVo2Y25mNHNJUU9z?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <69793E99F71D21419EB9B1CA3D2DA2B7@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e98d48e-b7f0-4b03-a889-08de0e12bb00
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2025 06:51:14.2626
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C7+mhZvtpKEXDYIiunUiVRwzGWRj9kJRJEJlD1kJZdyAzeX7xOG8ZngHs/oHQvz4baz4NqjgJm+ngDvQs3CZdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KU2PPFDD2810A4B
X-MTK: N

T24gVHVlLCAyMDI1LTEwLTA3IGF0IDExOjQzICswMjAwLCBKb2hhbiBIb3ZvbGQgd3JvdGU6DQo+
IEV4dGVybmFsIGVtYWlsIDogUGxlYXNlIGRvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFj
aG1lbnRzIHVudGlsDQo+IHlvdSBoYXZlIHZlcmlmaWVkIHRoZSBzZW5kZXIgb3IgdGhlIGNvbnRl
bnQuDQo+IA0KPiANCj4gQWRkIHRoZSBtaXNzaW5nIGxhcmIgY291bnQgc2FuaXR5IGNoZWNrIHRv
IGF2b2lkIHdyaXRpbmcgYmV5b25kIGENCj4gZml4ZWQNCj4gc2l6ZWQgYXJyYXkgaW4gY2FzZSBv
ZiBhIG1hbGZvcm1lZCBkZXZpY2V0cmVlLg0KPiANCj4gQWNrZWQtYnk6IFJvYmluIE11cnBoeSA8
cm9iaW4ubXVycGh5QGFybS5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFuIEhvdm9sZCA8am9o
YW5Aa2VybmVsLm9yZz4NCg0KUmV2aWV3ZWQtYnk6IFlvbmcgV3UgPHlvbmcud3VAbWVkaWF0ZWsu
Y29tPg0K
