Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6631D1DE8B8
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 08:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=210.61.82.184
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729497980; cv=fail; b=hcei6aESdjazsGLTl0L9c9mHgMkAgODuNBMPFTfMq8HCHQvJ9IItPXRoh0ZgK2nTSwQOYoO7yFATo8nv6Ig98Bm8MJpq1Uqad0VLkZVOrLpZCdNavszNStoP7mZM9NnLsaYe//NMYYXI123RGdFHMf4NzMzBi4PKIm096DnWSbU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729497980; c=relaxed/simple;
	bh=zM2LGrmeP/3+RQunGvms4umvf2IUBtlaBAmtfxYc880=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gn3AOEuROfqslBDZ2aiFro4k5JNp0HP5APpypLZV6uhS71bXwUm0ryljR6ywHhHa7LEF+fjbESIEDZ+FI3uLnVnZS/gHifAXzzSLQkmM9dhCJARSFF3GYlw72yt7+4yv6JG5XKts/VJf47dGKCXecp6ERQM9bLgL2ztSqsGKGsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=C8Jw9BSS; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=kR7lhdrB; arc=fail smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="C8Jw9BSS";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="kR7lhdrB"
X-UUID: 53976e488f8311efbd192953cf12861f-20241021
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=zM2LGrmeP/3+RQunGvms4umvf2IUBtlaBAmtfxYc880=;
	b=C8Jw9BSS73lS6z1S1Wrp9tAL0AjSKTmwBsxUdAg8xn2CoHY01mgFFndc5QcrrWGYF7JmOtv0HS4nVl/HlM/WL5c4pFbbTzYjVsXx0ct7F9F+nyOlIHR60dwK5ZSVgpPAOWwExb6CJG6PUT2vyX0kGgjmttYZLyiMJHRJ9k+SFw0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:93dc6ef3-9f23-4431-9718-e6b93c792d90,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:51539441-8751-41b2-98dd-475503d45150,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1|-5,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 53976e488f8311efbd192953cf12861f-20241021
Received: from mtkmbs09n2.mediatek.inc [(172.21.101.94)] by mailgw02.mediatek.com
	(envelope-from <yong.wu@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 46314601; Mon, 21 Oct 2024 16:06:07 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 21 Oct 2024 16:06:06 +0800
Received: from HK3PR03CU002.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 21 Oct 2024 16:06:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V4HJcHQQyXF5TciYWZN6Jvdw4ws/TCWdIUre6wfcYTnPcHZdpiuj4IfI/eDn4Gqasxp5bDv5m92BMKkuhR+vm5FYjhEvvdjV31QIeGTaV/X53mouUGWGdZaiROHvNnnJ6O0CWDz2jJ55gsY2eUUOrX4mY+X1ZRmiZxVXHkPQpPbcezTF4ynLrQeYELdEFJJiX53wYzJeUOw+GXyyvHVEIoRHIbnJJtyivvZHXnyQMnP50NyHuT9oqjDf4n94Sx9gO4NHidcSNM99IJwroT2pQXjauwT7LUaj8wmSBA9Lqo56rIYhwMAJrPzE+LLTHhz2DEPcen+gEDLG9PngEk70WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zM2LGrmeP/3+RQunGvms4umvf2IUBtlaBAmtfxYc880=;
 b=YzmykAzRkbuBx60qzlyalpr/Vm5QpEYMrDyYZStEcOomcPw6IEcZGhCd97zjeRdVWwcBXM8J8dQNx7fbJ87jOL59A9bAcMTgmOF1F8NuBQDME75F4WJf4RqxMLwqgKHHk3LmRrQPl8yfNjcx5/9NGrmyglpTa/iFStWes9m4wkyFrmfOAXYC39+z++/0hMq+4LqtU+o3d7ORKhDyR3/s2tPcSBklrxBBmO+jJP/2g/U+C1UFbVDqJUxbM68AtxvBCCbT55DT4iwBbTSO50uew21j5y/V9sMO/JGuu6mXl2IzI4UictiYdsYUxM/TWL1+4X1X9fPHluey62LZjxaZrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zM2LGrmeP/3+RQunGvms4umvf2IUBtlaBAmtfxYc880=;
 b=kR7lhdrB0lcyRBl0GvVKTacJoegWjw0dHaYlzKQuo26cMueyBn8PU+Ls2E04AX1RMFuDPbcd7OX/qbXQQ7Xz3063DZejhPr9/0bUznbWdYJQRu82SG+nPKCtr5CyeQrY4KMTRhyc/pDLv0Bq1T1dFYqlBxD6bwbhNDV0HC+a35Q=
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com (2603:1096:4:142::7) by
 SEYPR03MB7725.apcprd03.prod.outlook.com (2603:1096:101:13d::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 08:06:03 +0000
Received: from SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0]) by SI2PR03MB5885.apcprd03.prod.outlook.com
 ([fe80::683a:246a:d31f:1c0%6]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 08:06:03 +0000
From: =?utf-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>
To: "konrada@google.com" <konrada@google.com>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"wmacek@google.com" <wmacek@google.com>, "robin.murphy@arm.com"
	<robin.murphy@arm.com>, "joro@8bytes.org" <joro@8bytes.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux.dev"
	<iommu@lists.linux.dev>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"will@kernel.org" <will@kernel.org>
Subject: Re: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform
 data
Thread-Topic: [PATCH] iommu/mediatek: Add PGTABLE_PA_35_EN to mt8186 platform
 data
Thread-Index: AQHbIIasc/lq9DUx0UiaA/0COpb4z7KQ3yWA
Date: Mon, 21 Oct 2024 08:06:03 +0000
Message-ID: <f671f8d84b72ffff1d3b66bd2c48b4ffe81df79a.camel@mediatek.com>
References: <20241017112036.368772-1-konrada@google.com>
In-Reply-To: <20241017112036.368772-1-konrada@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR03MB5885:EE_|SEYPR03MB7725:EE_
x-ms-office365-filtering-correlation-id: faa52c6e-019b-4ca7-f875-08dcf1a7352d
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?bVp6dnVWTjlGbkRQM2VlTS95VmNjQjQrK1NrRERtbWcyRXFRSElKYStxcXlL?=
 =?utf-8?B?dUhYdzNzSk5iRGhPRGFpVml0cG1hWGdmdndKdkZha1pkaWV6YUFUT0VPYzZq?=
 =?utf-8?B?dWZBYzZZbTRJMU4rS1hXWXptSnJOYlkxM2pkWFI4bkxJUFRGcnZUSi9sTFlT?=
 =?utf-8?B?MS9RRklaWWE3ZFBmbzBiL0ZoYS9WOSttbzFnK2NxSjRkblBndm9mMGU0dm9Y?=
 =?utf-8?B?N1hPZTR5Z3lHWVBEMTZ0aGVNM2RCOTBXWjU2UnVuR3U3S0hKYkVpVE9jdEhh?=
 =?utf-8?B?RndXdWhyWFliWlNuN09FejdEVkRhNWUwTjRNemVWTmVIVG5iSEJ1TVo5V3Vu?=
 =?utf-8?B?cUJtdHY2MGF2VkRFTnZQY3dYQ2ZmRkxieUVoc0N0QWUyV1pHT2VnZTVCczRB?=
 =?utf-8?B?MHRBNEZ6bnE4K1NZNWRtdU92OVk3TjlvZmdMR2xkejZjWnFhUm0zaXk2WDJw?=
 =?utf-8?B?NUxYOTl3MjY0NWhRYXpJbFpyQjRQOG1oQVBZV2p3V3dRc0Vaekxac0tuYnU2?=
 =?utf-8?B?cUNXRlZLaE93VlBHeDZzbzVzUmF2KzNLR0hqT2JYTUJSRCtDdTdrRml1Y2hS?=
 =?utf-8?B?MG5TU1F4YVBPdHBVdGUxYXRaUERMaWMvOTBqVjN4QXE3M3FsMlByRjhwa05Q?=
 =?utf-8?B?V1hkNUFBdnZ4aU9BaWJ2WDg5ZXZCLzQ1TVFFdzQyeGx2WmQzT2ZpYVRVT3Iy?=
 =?utf-8?B?Y09qY3VwYmE5dHl0SU51d2V2ZXVhclQ4VENWZU1jeXltZDBTQjgvMEN1ZUxF?=
 =?utf-8?B?N1d4cVVFUjFsSW9TK1VIOGlrZ002Y0xpUTRLZkFSODNxUzFmUkNkdlhSNWd2?=
 =?utf-8?B?SVJ2RmNPSTNObUhGTUV3U1FjS0JIa0RhWUVRZm5iZ3VKVXAvWHNOQUE2R1Qz?=
 =?utf-8?B?VGs5bm40dnlMQ3NEQzJ3cEU3U0lRVEZZYWZqUHhBT3paa0lWdGcyWENOZC9v?=
 =?utf-8?B?MnlxU1UxNkUrdUNKN1ROa051bHlBVHRDZ0VZZEhJRUV6TDFqNHZaOHRaYmwr?=
 =?utf-8?B?aUxpWExad0NzeUhRY0c1RVZRSytaUnRFTzFCNXYvdlM0bVlrb2diOUlVRUJj?=
 =?utf-8?B?bldPeXRhL3dSdVhpeEF4bXQ3d1dWVTVZZUMyQ3FvQ1VLYlNvUTZURDd0UTRF?=
 =?utf-8?B?elYxMVFJQk9FUk81MFJZS0NOWDhKSWcxZW5FNHNqR0FYbDhwUTQ5OWkyZjl4?=
 =?utf-8?B?RDNQc1EwWitGZm1jb2hNYkFjdEpSaE9KdFlyWTlnWjBxU2M4LzkvT0YwZkFS?=
 =?utf-8?B?UlQwTEF1eS92Wmo0aUF5TmFxbGpKR0ZuYU1XODNQU1BSK21NYTdMQklHMGww?=
 =?utf-8?B?UEQybVk2KysxRVdpNmI3emFianFyZVJ2cUFkdDUyN1VlbW1MekFBaWREVDVO?=
 =?utf-8?B?T09vR0lpRGJGc2FkT0hpaitKZ0VFM3ptcHk3OXI3aHNoQkREd0tXdXRRTUVZ?=
 =?utf-8?B?ZzV1RjJNYzR0eE01b1I5MVJTL29qM2NGcC9ScHg4NHN2eUJqM2k4c2Q1LzBJ?=
 =?utf-8?B?dXgxdTh5WFJ4NXJPSmpmMmY0OVROU2tjRVVlVG14eW9lYVdzSUovRUV4TjNs?=
 =?utf-8?B?dnlQbzE5T0NaaGRrQ2I1NytnZzJGbUd5eGMzYWIwcFNYODdVRThHeE1CUnBh?=
 =?utf-8?B?UjZKcTVpN2F4cjBUSjYraGROOGNKVHZrK2tzODgreWxIOUJsMVdOZk1xY3Zk?=
 =?utf-8?B?dnhacnNCUVNWb2trOXJkQVVtUWN3MlU2blA1SGYyQmE1b3J2NlJINm9hdStD?=
 =?utf-8?B?bVFqSTQ5QkllaTN1TTJ3VGhJZkdMSFRoQ2lUc3h5dGhZRmppaDBWRkJBUDhZ?=
 =?utf-8?Q?4kc8ySocIJDqKgx74s8Z4C3rMRAIJ+8CTVpW4=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR03MB5885.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RDBlc3N4UmViSDRkVkcxaExIR1FNd3N3anpzMVVNQ2ZXVXlMeDl5SjFWTXFW?=
 =?utf-8?B?NGhmRUJkckNKb1BlWUtWZm5VaHJnSVo1RnVTSUg1NERjTm5uaTVHWUFIM05I?=
 =?utf-8?B?dVZFWS9vT01vVFdPblg0MFZpVytvbXFrUWdlRUNVTWNOSmwwOXNwdDNkNERN?=
 =?utf-8?B?U3JGMjVTcHlOUGRVcDRaRHlWZUJOSGc3VjhRdE1Bd2JxUks0cEJKbDEyWHlk?=
 =?utf-8?B?eER3N3RZb0xzaDNIcmFaOFlGcldCc0ZONDlyQ3dodlZId2o1Y2FCcHZ4U0VB?=
 =?utf-8?B?cVFJWllLQlIyRisvTHBlUy9aYTVXdXZhOXd3UVgwN2JRb3NGR2FGTm9CU21E?=
 =?utf-8?B?SlR6VEV0bSszTjg1STA5cXAvU2I1WXRRaHlGS0Y5TlpPOXRWUVRqV2JnWElK?=
 =?utf-8?B?Q1F0bEZLQUxWVUo3WlJLaDBQRWRFSlgySGlpVUFLa0tUdFk0cW1pWVVvZ2Rr?=
 =?utf-8?B?RHE0Um1WV1hIQlF4WEk1UVozK0FVcXR2L1JxbUl3cS9sZ0FPWjJWck8wMEFq?=
 =?utf-8?B?WjZMNm93MjRnMFB3cFJQNXZ0OUxZVzhQZS96SzJpUmhVNExDaG9jK3g2VlFt?=
 =?utf-8?B?STVrR0pQZk1GejBySWYwYTI5R1A0SE5WYTQ4WWc3WVl0QlcvcjNFL2wzejda?=
 =?utf-8?B?d1JVSDhyNjhFQXZSeWxZeHlLenpUN3NGRFlickJGd20rNDNMMml3S0ZVSTlz?=
 =?utf-8?B?UU1xK0VzM2l2V3VLNXc0aWthRGQrRVV4YmNwaS9JTmVqdVhPbCtxNGFoQ2Vk?=
 =?utf-8?B?R2RpcERYcW4yc2VUN0d0d0RyRXBzdTYzQmJXeXRobFMvVmpYRjNRSUJWN202?=
 =?utf-8?B?ZkhoTU9sSE9IR3lDT1lrODk5dmdhb1FBL2RUZFpZak9ib01WME1vTWptZzdF?=
 =?utf-8?B?UUk2OVNzZTZqaVhseWpLNWlCeVRMdVhxc1hNZ2hsUG13N2hsUXA3K1hncnZT?=
 =?utf-8?B?NlV3SG9iQ1N1WFBVZ0FIQ1ZDa1ovM0NDRHZUcCtDQTFCNHlyWGhZWTV2dUlj?=
 =?utf-8?B?QUZZMk1TQ1BVT0pHdUtReW1zQlFJQUFJR2ZFVmVpNnB0empzakVBeTAvODdv?=
 =?utf-8?B?QlpHeWd1N09NcDBPVHNwYysyenBtUWdweC9RN25KREVvYUlBci9Vamh3R3hh?=
 =?utf-8?B?b2s2VWlhOGJXN2xtaWhEUW13dE0zRnlJaTVlOHJ6a0VPcVlsWkgvQlN6NDZM?=
 =?utf-8?B?WVZLdHNHRitjcVhWQk96L3dwZ0xMYnhsRTFaZGthZElwb0FCOHVoSFlma3VU?=
 =?utf-8?B?ei9CMHhqemlHSHdtM0p0ZHBDbGZrQ1FZZ1g2Z0JKWEFpbXJVYzVBZ25aTmxL?=
 =?utf-8?B?K1FEREZzU3VrdWRNVVN4aS9SY1BIQ2dqSjR6SGxnMkVHNDYza2p3MmJyanMy?=
 =?utf-8?B?R1NScWhHellsM3JqWVpyYXJwY3NBWGpSZzdkeU01NG5yY1BQeklUYVgvRHFI?=
 =?utf-8?B?YjNSbkdUblE5T055c1J3dHExUVBRTExPSjcyNkVBL0lPdFlHZ3lYdmg0cVdo?=
 =?utf-8?B?NWRGRWttNXgvQWExWUxZSDg3eWcvZ0V2WHBCa3ZaY3VER2dCOUdxR2FvdkNp?=
 =?utf-8?B?Tk4vcmxxaUh6cFphbHdJOFJmRjZEREtkeHB4VDV6T1FCa2laWUxMNEh3emFs?=
 =?utf-8?B?R3VuS2xONDhKWmFEbjJzcE14c1ZxcjI3MnpkQUNzY0RJMmFmanhQK3Zna3FS?=
 =?utf-8?B?cFFWb2daVUlzb0QyK1IwZnc1aGpEakh4eG1ISkVZUmVDRnl0b0FlZEVmR0RP?=
 =?utf-8?B?dW81OXBna3hiZHZjWXZiL29OR1dTbTU2MHhnaDF2bHZwM3cwT3JpVnpNY2U1?=
 =?utf-8?B?M1Jid0Zic2hxdVFIZnNFaUhnaldCem9YV3F2cTErTTBRVGV5Y2MrMUdxNUdy?=
 =?utf-8?B?QWorTmZFelFPOU1OMmcyZWcvR0dXNG1QMnZPcDQ1K2RPYVIrQ3pYVjhQQW00?=
 =?utf-8?B?blZNdXd0K1RPMW5lQW9JYWRFY1BLclhremY2RGRxaG44eCtJZVB2QjRzT2lS?=
 =?utf-8?B?RVBQMXZZdHUxbTZndDZYYVdjbnd4cmlwWUo5QW54dUdpNVl5aytPSFFoa0pW?=
 =?utf-8?B?Nk1LQ3R4b2oyVjhwWDJjbWFtRjV2bVd6U2JpZ2NsR1ZTMWZBbUJhVDl5NDZv?=
 =?utf-8?Q?P0mCqAtkNp3Gk9+9VMJ2dpCsy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4E31FF77935FAC4EB08C5D90842EB15A@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR03MB5885.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: faa52c6e-019b-4ca7-f875-08dcf1a7352d
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Oct 2024 08:06:03.3441
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rel/GV+TAb0lbhdI7k5HWk4oL3lKSDzEG9LOcyBie4lKvYUJiLjTsS5jS/Ma1/5yY3S5opGTZWfbeO51oqA3TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR03MB7725
X-MTK: N

T24gVGh1LCAyMDI0LTEwLTE3IGF0IDExOjIwICswMDAwLCBLb25yYWQgQWRhbWN6eWsgd3JvdGU6
DQo+ICAJIA0KPiBFeHRlcm5hbCBlbWFpbCA6IFBsZWFzZSBkbyBub3QgY2xpY2sgbGlua3Mgb3Ig
b3BlbiBhdHRhY2htZW50cyB1bnRpbA0KPiB5b3UgaGF2ZSB2ZXJpZmllZCB0aGUgc2VuZGVyIG9y
IHRoZSBjb250ZW50Lg0KPiAgVGhlIE1UODE4NiBjaGlwIHN1cHBvcnRzIDM1LWJpdCBwaHlzaWNh
bCBhZGRyZXNzZXMgaW4gcGFnZSB0YWJsZQ0KPiBbMV0uDQo+IFNldCB0aGlzIHBsYXRmb3JtIGZs
YWcuDQo+IA0KPiBbMV0gTVQ4MTg2R19BcHBsaWNhdGlvbiBQcm9jZXNzb3IgRnVuY3Rpb25hbCBT
cGVjaWZpY2F0aW9uX3YxLjANCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEtvbnJhZCBBZGFtY3p5ayA8
a29ucmFkYUBnb29nbGUuY29tPg0KDQpSZXZpZXdlZC1ieTogWW9uZyBXdSA8eW9uZy53dUBtZWRp
YXRlay5jb20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL2lvbW11L210a19pb21tdS5jIHwgMiArLQ0K
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9tdGtfaW9tbXUuYyBiL2RyaXZlcnMvaW9tbXUvbXRr
X2lvbW11LmMNCj4gaW5kZXggNmEyNzA3ZmU3YTc4Li5jNDUzMTNjNDNiOWUgMTAwNjQ0DQo+IC0t
LSBhL2RyaXZlcnMvaW9tbXUvbXRrX2lvbW11LmMNCj4gKysrIGIvZHJpdmVycy9pb21tdS9tdGtf
aW9tbXUuYw0KPiBAQCAtMTU5OSw3ICsxNTk5LDcgQEAgc3RhdGljIGNvbnN0IHVuc2lnbmVkIGlu
dA0KPiBtdDgxODZfbGFyYl9yZWdpb25fbXNrW01UODE5Ml9NVUxUSV9SRUdJT05fTlJfTUFYXVtN
VEsNCj4gIHN0YXRpYyBjb25zdCBzdHJ1Y3QgbXRrX2lvbW11X3BsYXRfZGF0YSBtdDgxODZfZGF0
YV9tbSA9IHsNCj4gIC5tNHVfcGxhdCAgICAgICA9IE00VV9NVDgxODYsDQo+ICAuZmxhZ3MgICAg
ICAgICAgPSBIQVNfQkNMSyB8IEhBU19TVUJfQ09NTV8yQklUUyB8IE9VVF9PUkRFUl9XUl9FTiB8
DQo+IC0gIFdSX1RIUk9UX0VOIHwgSU9WQV8zNF9FTiB8IE1US19JT01NVV9UWVBFX01NLA0KPiAr
ICBXUl9USFJPVF9FTiB8IElPVkFfMzRfRU4gfCBNVEtfSU9NTVVfVFlQRV9NTSB8IFBHVEFCTEVf
UEFfMzVfRU4sDQo+ICAubGFyYmlkX3JlbWFwICAgPSB7ezB9LCB7MSwgTVRLX0lOVkFMSURfTEFS
QklELCA4fSwgezR9LCB7N30sIHsyfSwNCj4gezksIDExLCAxOSwgMjB9LA0KPiAgICAge01US19J
TlZBTElEX0xBUkJJRCwgMTQsIDE2fSwNCj4gICAgIHtNVEtfSU5WQUxJRF9MQVJCSUQsIDEzLCBN
VEtfSU5WQUxJRF9MQVJCSUQsIDE3fX0sDQo+IC0tIA0KPiAyLjQ3LjAuMTA1LmcwN2FjMjE0OTUy
LWdvb2cNCj4gDQo=
