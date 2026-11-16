Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.57
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794821498;
	b=5eoJaPT0aQOCgoseZyDzM6W3pxCOuw3I4LH+qgKc5xZizD96dzRU4iAocmQ7jtkIdnhG
	 d/hGwLVzCDVatnB7BicrrhJ0ZbiX81eZLf5hA6gEQs9JP9/oHHCTHHu6Go/47MsyFK09A
	 2vxayHghzZyGeAsibUxQFwUg2fNBlW0QNWlbBqvpAEYU+qJ19aDVF17Ki//toQQ2EK1C7
	 yBz5vMRHCowhxZjh8adXjG82M9rP6RmCoGkBGMW2pUH3FSkJdIlX8wVZnvnkx4FqQ+rN+
	 y1q26ecQB5MoMMFE+EvpkSroDIX7ptF39Ies4Pu0eXQ1DwlmW0335SKqunXU7sF8JSA==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794821498;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:
	 DKIM-Signature:Authentication-Results-Original:Received:Received:
	 Message-ID:Date:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-ClientProxiedBy:MIME-Version:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:x-checkrecipientrouted:
	 NoDisclaimer:X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam-Untrusted:
	 X-Microsoft-Antispam-Message-Info-Original:
	 X-Forefront-Antispam-Report-Untrusted:X-Exchange-RoutingPolicyChecked:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped:
	 X-EOPAttributedMessage:
	 X-MS-Exchange-Transport-CrossTenantHeadersStripped:
	 X-MS-PublicTrafficType:X-MS-Office365-Filtering-Correlation-Id-Prvs:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=U6RLSXoRBAqGV5wV0C1VN62pxQtvQlzppABjVqjGELs=;
	b=KJW1qWjKtbflJax9eC6ahPTJ2YqStezwC/HvlFXOEXz98Xvxf3YBJfo3jeIj1zXRjR2n
	 0H4VjB5zmRBNWeaDAJjQctHMgFcjgUTAtHNKFj4s9gfVgdxqlK7rTlMk0lGU/CFKQvjQm
	 2x69Dah+oUqEQkmCZPVYVBV/iU6oVD6arHwh23jTSXI4Q/7u01lIQ/K2BS/+BNUcOplsJ
	 yRIF/aue6x/txDI5aEU9VrwxfEK0qg/oIrKUUpPHMAeHYRVek1LYHkwyFtcSKnMWiDksC
	 1f429VI0UHMJG0jza41fjrObeuLPsd2oosyfaQq87x7SX5/cF/nuZpt7iCRuxsb759A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gRQvMNsC;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gRQvMNsC;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.69.57
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010057.outbound.protection.outlook.com [52.101.69.57])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A238606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 09:31:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A238606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gRQvMNsC;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=gRQvMNsC
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=UqQe0pvBDBeXeom7BKx+EcIEJzQZC4ed1MRTpvfX8DjrMT5bEx1kyN1DHMuraRIF1vFZmKoOMizfCVWKZ7uTDVjTyBFP5h1TXyyu0kzxzotoG7aijd4w18yueM4wmLt3FYVKHJ6ugrtpIYsl5ZGACIPIXZVSEFH5J9CRyxXYyQkd4VqTWSNgEy0lM3851oCknshldwunMK3JAFoGkcTMyplPi5ec28rjDL9CDXivCVdXVQpcDkwKcMu31HRmbmZ07Fy4z1sJS4vtstBTBMnbTK9cyTr74DO1jo6t7ymb8kkanN17yV5xEq3O6lkZuJY9KPuLsFz6fb4lJMCXO1nGIw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6RLSXoRBAqGV5wV0C1VN62pxQtvQlzppABjVqjGELs=;
 b=ZaT07fQ60o9mwUaPhR48jMr4bbIT4xoyXvOM65V0fkuZgkP/PCw2IUckUdILNZI4hLHR8C//ev3SxI++OtESWDOJtEoSKe7ZLd3F1/2DAnSm9lABQfII5A2L2DlmeQ45N8Hxbyc4G6LzlgQlZ+khlRNbsFAnzXNJq6NcBHup/kW5UG557e70v11zsv2hOgUgO9m+Hg2z703V/RZIlswr85XY3O6oDm9XW/GzpbaysLcXZIrAyIFdAO54arp0wlPeNG4/NIidNahEhVjJzyPdBk3m3M2o72wpkUtannEDQH6fAEDPelhlPMpxFt/fzxv6djKqYqI2pjWQeP6YIMHxjA==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6RLSXoRBAqGV5wV0C1VN62pxQtvQlzppABjVqjGELs=;
 b=gRQvMNsCGAlr+JH4LgIHfyJgLVv9DMiRoFfC4FiEip3pfgIJ7Zx35hLUUbwvKCh8Eq8sGs5TuMbcwd7V4TCt9n/ws4ZdwRYu7xXsyRosymhYJnQKDAuf0qDdO1/9y6SosGzHRobRROqUApvfci8iID2h3jq3SS2R8V+xaQGO3jo=
Received: from AS9PR05CA0302.eurprd05.prod.outlook.com (2603:10a6:20b:491::30)
 by VE1PR08MB5806.eurprd08.prod.outlook.com (2603:10a6:800:1b1::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 09:31:29 +0000
Received: from AMS0EPF00000568.eurprd02.prod.outlook.com
 (2603:10a6:20b:491:cafe::54) by AS9PR05CA0302.outlook.office365.com
 (2603:10a6:20b:491::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 09:31:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF00000568.mail.protection.outlook.com (10.167.242.118) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 09:31:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CvSPAutjgbIHpcyn9bSau2T9bYSqgr9lqvKDABUZN25Iru20L2eS2tSwCvEjA8I40NzHAq/GIJlDS2zr3mL9+8qaGSvEIJmDacoD+5StbY+vuqWpE+R1+6BZwzERhsqmj4enif+3gUE++2+XFlEVpBSi63vBGzJm/dGMibkc7Kv/kD/NzPmZbW4vFHA2hvlFbmgs5J38+v2oJ0r5g4oXBz6xJpPr3SMIqFY1DF+Y5olvgXFSx/KAtNX714/xYTa6ekj6gTPp1RQnd4dMEOUPzoSxMMJQz9VQ3fBrSrYqWg2/Kwwom11ZPyb6xtccBmKeXzUllpsQnBCQ+vPuXguo4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U6RLSXoRBAqGV5wV0C1VN62pxQtvQlzppABjVqjGELs=;
 b=UaSlk0DAG3a+aLQLqzRimG5HgN7wme0/S09tsFkYSadIdL1pUFsVlax7NuNEHguN2mGPmnx8aA2iomEb5z9veBKV8deOOMotsL2czJJqGE6WXUL3jkyfv+MdgDf8fqthDDUisn6X9YwLxrXrv816CvxKRPG1LdrbQ2RKMgx8rJmsKttrINdyMf78/C4uxK8ZNiayDg/moBz04Zhp68Q2A9pDEqqBwZ84tYsrwgZmQcBlB/kOfrd8V2DVzBEDTdJDgicKN5Ymjq0aIByd8Hvc3W5iy8UQp+z9dMEE0UU+TxzY9o4ItPRI9Day7HbK6oVAG3XMoJ0+gEeHoCo/+PlWPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U6RLSXoRBAqGV5wV0C1VN62pxQtvQlzppABjVqjGELs=;
 b=gRQvMNsCGAlr+JH4LgIHfyJgLVv9DMiRoFfC4FiEip3pfgIJ7Zx35hLUUbwvKCh8Eq8sGs5TuMbcwd7V4TCt9n/ws4ZdwRYu7xXsyRosymhYJnQKDAuf0qDdO1/9y6SosGzHRobRROqUApvfci8iID2h3jq3SS2R8V+xaQGO3jo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by GV2PR08MB9231.eurprd08.prod.outlook.com (2603:10a6:150:d3::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Mon, 16 Nov
 2026 09:30:47 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 09:30:47 +0000
Message-ID: <fee16ae7-310a-4f5a-b72f-afaad5627352@arm.com>
Date: Mon, 16 Nov 2026 09:30:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 02/12] iommu/arm-smmu-v3: Init the vmid_map ida before
 the stream table setup
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <5c764fa56a42c0631101f2fb3741e6c010cdfdd3.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <5c764fa56a42c0631101f2fb3741e6c010cdfdd3.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0423.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::14) To PAWPR08MB8959.eurprd08.prod.outlook.com
 (2603:10a6:102:33f::15)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	PAWPR08MB8959:EE_|GV2PR08MB9231:EE_|AMS0EPF00000568:EE_|VE1PR08MB5806:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c6e5ed-7ee9-4dc1-0c9e-08df43c4649e
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|18002099003|22082099003|6133799003|261009223027099003|56012099006|4143699003|10067099003|261022075727099003|261102123227099003|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021135927099003|261021121427099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info-Original:
 4s5plETpkSTPQ7FFkzdoVFLPfAv2yEOcHmpMmM4WBRb5uWnzJlIEu9/Uagi1MMvSa5OOKQqKwC+t8P0zi8JAGiCzHDTa3bwpOUnfhXI9ZFaqGnGfBiiHx3FbYTAG0fZquN6LGt9waYlxlZ5UhkTtE5iz7zYwx8Av6gSYL+zlaGvj/maJfObOaCZclIU1kPXzT8IlXaRhK60GQG6uONw57pT5/IkTqXcS5AbyxE9g7zw1wu1h21YAVoqrGbiw9OkPOazJnSr7U+APvvkP56CYHxVttSRGf1bCu1FCR1HC9NX9VUq+xyAifGNgZZMCpTUdAwEaRpnek7XU0T7NskHbGiBEPlK0Yf1nO2NIU8XOIwOxwKndzx8SbziGyww5UEnTxY3TKo/eDuZU05m9Su1PPPt7rf1KwD/kaaNjZaaXF6mi6GXkdFNGm8DXl6WZIOIHh5iZYDMTkLDTa0jQMCEF8vYa/vYyry+XBRpOJ5CZn6Z6EvsBGi0T4sXH78chtvFggoIsaxRIOHVqEW7rEErK0G9MmsyG5bWE9agt4iSAqAYnmElnhvtduomE0ch7s2gc7h/6uVUtS2wrgifyVnx4eA5XhVDW7E8kfBGszMzmgN5ANMY3CagzckPSrIbTMgBxBTQj/ah+xbZt4AmlqUecBgITNPz3d4Dflhx3lTfsn4U=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(18002099003)(22082099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(10067099003)(261022075727099003)(261102123227099003)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021135927099003)(261021121427099003)(261026121527099003)(11063799006);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 0reD6RlUeJFt7TUN7BD6x4qRrzvCz9DWBIAvyOTirdpSLnMokflDXmem8BEA0KTLSBkdw+L3wcCCH7Vjs/UuLZlE70m4HN4zYUwNNCsDX4O6oydYn+jZhQMvCB6B/GDyC17qxytuZDbfZ5D5HjQJiwXsXitnhvVm5WHFkCM5eQCA3e6ojgeBPYVT97AbpK+ssAaUxkhv0JkDnEbOOe3EC0u+z5+yUuzSrt4No1sEFLU6qaDXzHG9+CeZWHkoKT6YqpFnWAbbhoyou1nIdip0gAwSY2T14Erh8NRSWRIzZq/MOcasHt1RHRX64xtTTGUomYcCfzD6pNq/NyQ7+u1fNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB9231
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF00000568.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	22d8720c-7e63-4df9-226a-08df43c44b6d
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|14060799003|7416014|35042699022|376014|22082099003|18002099003|6133799003|261009223027099003|56012099006|4143699003|11063799006|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261022075727099003|261021123027099003|261021121427099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	ee2zdgQ8IEO9atE+HZcNNTuxofoUvrQItZOPRLIw47yr3eZaulNnAdxkHPhFYSzXQU+cua/dwNoqsl81sCfVyBwyNgBOWK29svBiYpr3TZMhqdtJOjI/GBZSR2y1rhI+hzb6Zh/ls1NWefl6e4szgyddLrDsy27lIbEIBAkjZIvfVrLT5Ei71P/16LQkUlyoDWz4Hmwy7Du/RBW5/CEgXeU7BXT/ig9x8d9JWyZh1gIHIqpjilo142U8T38QParE5Wxu6WUoh2hPTZk7GoOb4geq+GXXysNrX2ArZgb/bVZnnglX31Y6iDj3abzd19gnjf5GLW4UrNXHo1CkqD2mBYE20WOvS2nHpdIpyOLT1YEMfmak5loddDPW8l9ii1oj40qeOoHdnS6xkG0o1DEIUN9K/ZXyD/BqGi546Ux1h5Gnldk3mgM2AtkWZeZxs48ga36xeqpJCVizwHiSBiMSwjr5bokJk8hwKmg2iuz9EU79WFIjpj/QrophjCNAbPuegcZNSUwkuGca+UslesYxkLv0ukoXrCwI8hFpDgF0WM9gNA8vwmYrWfCcdpsswhCQI/SaMBbSMf74TDaI3RAPH71u699ynQvasYU5y/fYyvAp4SFK7+krhs3/fQBb+kt0GhLpj8hh5jxGJjaj13/GIDLRt/7lY25TPeM9swps3LHAkBZMXPKmGCHKTCte6yGbF9CH9gCwaxVEy/YzwC/QUQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(14060799003)(7416014)(35042699022)(376014)(22082099003)(18002099003)(6133799003)(261009223027099003)(56012099006)(4143699003)(11063799006)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261022075727099003)(261021123027099003)(261021121427099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	YrRzfevEq/UO70k93GDKBGoLb0PW9pvhv5mec/4Qaw3btCRjRdzFPWafSqCqFzvIx9y29O2EEe+qKXf4USc42x6+mia6J+Qw1BIXIKkIEDWmmbmbZOJjOkHZKuu8aWwnbVCoQmn3gMOM859ABC92txOMIOAfF1e22tG8lbE4uyAuu8lFsZ6v6YwGKgqhxJEr1MaE+/HZXA6rBvrsH6t0BwVCUXW1IySmWRCHtFvK2DMk+J8FWJXHzDOxdeAkL1sneNbZYc9gO2lKy61u2xYFWgC5ysJE2JWZXt6L80COGS7tpTQ5FZ94bJIbJrPVYGg74iKspof7s/AsCwixxNryclfddb3ERK4ZmKRpnZUbsxW02Fm/gnhToOtYnkEUTY04dq4AFmDWid+dJvjS5dVm4P3QcSgkCmkxuXYVEeOJBiAB5ucp4xCYG0/n8Ka3YnAi
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 09:31:28.9690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c6e5ed-7ee9-4dc1-0c9e-08df43c4649e
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000568.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5806

On 11/2/26 05:19, Nicolin Chen wrote:
> The vmid_map ida is initialized after the stream table setup, along with
> the devres action that destroys it.
> 
> An upcoming change will reserve the crashed kernel's in-use VMIDs in this
> ida, from a kdump kernel's stream table adoption that runs in place of the
> regular setup and returns early.
> 
> Move the ida_init() and its devres registration to the entry of the whole
> function, so that the ida is ready by the time the adoption path runs.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Mostafa Saleh <smostafa@google.com>
> Tested-by: Breno Leitao <leitao@kernel.org>
> Tested-by: Cristian Prundeanu <cpru@amazon.com>
> Tested-by: Shuai Xue <xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Regardless of nitpick, below:

Reviewed-by: John Garry <john.garry@arm.com>

> ---
>   drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 6d4520c473086..5cabbe5652dc6 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -4842,17 +4842,17 @@ static int arm_smmu_init_strtab(struct arm_smmu_device *smmu)
>   {
>   	int ret;
>   
> +	ida_init(&smmu->vmid_map);
> +	ret = devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
> +				       &smmu->vmid_map);
> +	if (ret)
> +		return ret;
> +
>   	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
>   		ret = arm_smmu_init_strtab_2lvl(smmu);
>   	else
>   		ret = arm_smmu_init_strtab_linear(smmu);


You can just have:
	if (smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)
		return arm_smmu_init_strtab_2lvl(smmu);
	return arm_smmu_init_strtab_linear(smmu);

It seems to work ok for later changes in the series.

> -	if (ret)
> -		return ret;
> -
> -	ida_init(&smmu->vmid_map);
> -
> -	return devm_add_action_or_reset(smmu->dev, arm_smmu_destroy_vmid_map,
> -					&smmu->vmid_map);
> +	return ret;
>   }
>   
>   static int arm_smmu_init_structures(struct arm_smmu_device *smmu)

