Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.47
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794826828;
	b=jHYhzr79+kDFUILzLNPeuEuKOAEZiLwXKGBwB5HSSf6dAbSFDXakn//zy/MQEC2cMV4p
	 KAcCaXyaUL1J4NtB5ELo6kTaIBV3zmB0UrVe37xlid3EhuhAf/wlu30jam9seYgWHFS0C
	 S7GOl3mN+FwRGksG5NSlYMYBIDF9idCnEvhg+veI9cQLLshWaUtU7G2yHRhzfBqakcLdl
	 9ocA944DFUJLCP1zzCatmbrmcexVNSwGtOnnANgCmF2w1jQvkHDTGxpVcc4b47J1t90vU
	 lI1oP0ZPzg5dfySnYWOYvb3P4lOGphaycGLlwiDEKya3+frsXSPxP9XAf00IfZHjl2g==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794826828;
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
	bh=i8r0+phAfCQnbmIDqqtnlUUTuVMCRv+O0a85/dEptqw=;
	b=3lm2KL9m/p2c7lWGIupkNxYRj4WMZVeXB6K4KaUFz/PeCC64/SVGLnEbpX0GI8RKpyhr
	 Rj1+eyJ5hnGA3SWfUkk6XP1m0BXEYtMFtjasq1+j8SsxBhWb5xSoZdLW0k1EKXNLGXUmJ
	 46QXZDyjR3yyJN7x7Q3o2SiAGs67nX/Gm5oL8DtDY1DoQdhNHF+q2HFk3jFH2+f1YKAyJ
	 cnTQ7M80djZcIAY/OF87v8tChvG+fz0HMBbKe+Voqz8fhzoQpDWhuSMtsdJOpM1QiTmSB
	 K3huGUpf7knhyal+JxRFnEul/CUMTkRM2BY8FkRZt4Nk4oIfCGam5MltA96LGRNsw+A==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PYf2p8oY;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PYf2p8oY;
	arc=pass header.oldest-pass=2 smtp.remote-ip=40.107.159.47
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617DA606A329
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 11:00:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 617DA606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PYf2p8oY;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=PYf2p8oY
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=r5E2fUP/HBD/rmVnP4xhC0oC0KUzUzlWlDSM1ry0kj2ENUbp8dsBFBOK8zGubeYgEhMBSu/Dwg6fC6rPofR2QUq8jRe3n4MoBmzz6idXllIpVx4e9thTCiKI+s4ZKlktYLaPkGsKsYzYBK4REUS988qjRGehNLNuQSHbuT5huXNNmoBdUjSJl9jhtc/lWsR0eCzbJ0tg+eA83ZmYqLLhmAORRNQjJ4RSEIbR0cvLZwKjIWbq3Z4nAd0SNbvGiy7mGQBih7QIpeGiEPBwiRi/3VgxJ3XVnDRBHRZ5ffRn9xKOTLBYsoGa9be8yr8mWMWbJfrgBEGRyeSdeJafHODUfA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8r0+phAfCQnbmIDqqtnlUUTuVMCRv+O0a85/dEptqw=;
 b=CBcHPUDwGP9fz4m1oXUVsN9N2qyNd4znESG4JznL3HthM6U99ybr8DV7SMfcKfgWILbWRxWpDA/8rLHI38KNwoXOV5dPpXrATf01w6Ua+Qpg+rldYDPiXw4cqnHLOfaUdTa1MNJe2rqqx0APVGiN40wCJPzlnWwog1oZnJz6sUFQgOBUL526BmCWSmwB8EIHeAM7f9FH96cFt3JT5XoGvDHT3Y4tu1R0x9n1ZX5T08ErrilocJjtJWzBwnrjDXRaBBpZQHYGnhs/BOxIVoa13PvTiL7Raet7fxRCuTD5IXCfHAuPaN0wYHFCQYMeygr29EVRBt4C700z1Q4Vv6jYIQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8r0+phAfCQnbmIDqqtnlUUTuVMCRv+O0a85/dEptqw=;
 b=PYf2p8oYVSdt1JS5TcMGCTmVMYMrOnMyOqivy0MP5L1tiL55IWKSja8QK9tFxbLsv5UIm+hs9FLsNOxPtfQzua3NdXh6EI+My8CWIQ4yjy7IXaXQeDrWmcM9D+U9mLSr/A1Ti+mGG5BYXP/nkFNZ0XLREbWUOlCZcV0FJrR3Mho=
Received: from DB8P191CA0020.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::30)
 by AS8PR08MB8490.eurprd08.prod.outlook.com (2603:10a6:20b:567::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 11:00:21 +0000
Received: from DB1PEPF000509ED.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::16) by DB8P191CA0020.outlook.office365.com
 (2603:10a6:10:130::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Mon,
 16 Nov 2026 11:00:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 DB1PEPF000509ED.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.4
 via Frontend Transport; Mon, 16 Nov 2026 11:00:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z3+6rGc5t94dMQuYLmG0brOQUkjL4loKOHNM5kfc27oh2wxkWLhm25yWBKhOO7LNReDYUQILxA1yPzN83UemuCqJJPSpT6yhvlWt06J3utJBm+uykb5xdtAOfBlccqVt5yqnME/dsipi/6XJBCzp1wgr9DNxFJrPOyMU2fa8dQS56nf9jlc+rsoiGtJOtUzTTLfTkGaYZpy3md1oD0smh0/3lcI734mQgaRel71qNooRXbVHBs4plHz7wmd09hgohGsUHxCNGwz2cQV0Nb9NvEyh+rFjTV+XdvRfnbDCxhtBgplekNc6YMVWOoVCCxnM7gYH4OHAUUNO9biAXuvXLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i8r0+phAfCQnbmIDqqtnlUUTuVMCRv+O0a85/dEptqw=;
 b=Klgh+U/uteNlG+wsg4UCLI00kUrOFcuUiXofrJvRmVKZ2G4sKQc7ujs666weanClYxdi7lOjtkoHV4ti8AbbvWarc8O9qHMDqgOd9fFzywmZhUCJbTwvW4T7NfxpjWPaooOyeVeZvXiWHGJ6tvDGyDjUornjBxVJm6uqd6yK0Bsu1WP1jlsGbNrJtrPOjg64fEQ/nRUV/+S23YNEB5A2A8lLirhDrsRD/cpj27xUeYFAGTWFjpjhCZUxXFQFt941LonELAwV3sLb/agYeM47PPZrObjQCxVQOAbtnK8Y8C1uyvvcLfzFcpGHAPYOVZCl2ZywZOcloGVC4FIs8pXjxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i8r0+phAfCQnbmIDqqtnlUUTuVMCRv+O0a85/dEptqw=;
 b=PYf2p8oYVSdt1JS5TcMGCTmVMYMrOnMyOqivy0MP5L1tiL55IWKSja8QK9tFxbLsv5UIm+hs9FLsNOxPtfQzua3NdXh6EI+My8CWIQ4yjy7IXaXQeDrWmcM9D+U9mLSr/A1Ti+mGG5BYXP/nkFNZ0XLREbWUOlCZcV0FJrR3Mho=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by GV4PR08MB11252.eurprd08.prod.outlook.com (2603:10a6:150:2eb::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Mon, 16 Nov
 2026 10:59:43 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Mon, 16 Nov 2026
 10:59:43 +0000
Message-ID: <69c968dc-f371-47a4-b0ff-882e002aaddf@arm.com>
Date: Mon, 16 Nov 2026 10:59:42 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 05/12] iommu/arm-smmu-v3: Add ARM_SMMU_FEAT_EVTQ for
 the event queue
To: Nicolin Chen <nicolinc@nvidia.com>, will@kernel.org, jgg@nvidia.com
Cc: robin.murphy@arm.com, joro@8bytes.org, praan@google.com,
 kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <9744e1695bc597bd9ddb88ace69ffb584b803425.1793593923.git.nicolinc@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <9744e1695bc597bd9ddb88ace69ffb584b803425.1793593923.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0118.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::8) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|GV4PR08MB11252:EE_|DB1PEPF000509ED:EE_|AS8PR08MB8490:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef3f8ed-138b-4a74-9fdb-08df43d0ce8a
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|23010399003|10067099003|4143699003|56012099006|11063799006|261026121527099003|261026140227099003|261028144727099003|261021135927099003|261021121427099003|261022075727099003|261022105027099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 KrRlB3r3Ixyf+nuHsdzLSb2XG8IjvYGkfQjwW1EsHya0WiNsqJqoSM+/C1bVvJ0D35DIeDvaCZ92j36BaU6Xa/tjqaMEVof0VN9mvm3s2IoBAd94osWH+rWHyFtSxpK/SXmDosBAtRmlnWrCbvYSNCMgd20OyDh3YXnvAVB+1YmOXE5u0Tq6Yc2ArMbDl7Tiy8SqT+9enKsjQ7KtW6cw9cF7t7fwYZiF6bCn5myBw6N16JJ3ig5pCf0O4ma535mm/cF1DdfZzQqngQgl8xfdSMoYg7zFJ66+g/UJqvGs47AojhDQm1N9dstFeEgZJ3hch6RPjeOavhJ+aXp1Q8oHmGY2QDGN0NkbX98TsxAjFuSU+0+Bzkw0A9eZLrainSkyLb88iSZ4pXzsHcvv5H3Pjon9heTDfgppBGDeX9taz2EvwnfmYyN57RJNAb5lAvGFudHWRHlIKG984XvHBpZw8s5lG7Y8q7hv8HgUsMW9rsbauKNG9g0K+hiHJmxlFMS6IqXQJkjFPmDJLcAyU0XIe2rRhlBIZLYMu6j7uDuJ+MIIsmdv7ijt0U/nIF5K/vzg2MXPtiaMNucw5yoS9Kak9vmxWpFAKniZG1jwuAnFHD3Wme1Q7VVK0j6y541630S7G9+bAao1011ZQVL1qkN7RaW3EpyaoB63T7P9LQRuT3Q=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(23010399003)(10067099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261026140227099003)(261028144727099003)(261021135927099003)(261021121427099003)(261022075727099003)(261022105027099003)(261102123227099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 Pcvku7VynDVuA7dz96jwabgzeSvhEU8vb+fHfL7scFk5EGJmOUkwmbwNsHqDrdUapEfvtdOuUvoDSL40aFz8cbr3vxYGVkEwJqSd7bFIOY5t7U6lepJlny3ZbL7sYnmXAuX+tGGYuCkg1SFhieNofU/xHAaap77UCUNzOIWXGzMt7yAp1w6K/fV9BXr97K0Tb3GzvlqqoxxL7EIG9XyEI+IKtafbJp0PB1wh7tWUSnQnIxmRcd64yFKwcirvknoE/5a6zKBwQiw0sIZuipa0od44cw0gLko4n6jQKWKnwjTgLJyZgDCbYLr0MXtoko9Vo5L8ZVRI5kL3abIrYoTIyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV4PR08MB11252
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	955adc76-f314-49a0-438e-08df43d0b86b
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|7416014|376014|14060799003|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|4143699003|56012099006|261021121427099003|261021135927099003|261026140227099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261028144727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	1O4t08mfuTVEm/s28RIUPj+4PEb6aRqebpXBbT+iDwEoIl2SP6/1AR2BcfV+mksrtmwAaTB5EJj6DtNNsucGKXO/UrU7cGbNPAMK/n7ZnhNMaohqFRLVuqlKyQvylEE0CRs1um6J/5bJlV/FRjMpvJAf8Xsa2UCoC6j9zmLoan3Pe2PzVvru+LVCP+KM4e8/bjwrlO67v8N9e1HY7uUa8p6SLMRUDrc8lBpx0AWz8E2FUQANrR2sqwl9nnv2xrpOnFUP/muNoFtMgjH+Iw3rVql81HHVxYLg6Nd/oO6y6XEfw1z7vQmO3AiR26lAr62HnzHjjmFeVsDK6NKB1aTNoOvI3r/j8ucbxOiJGgdkl3IGidv+4JXUIxwJIYRtEOlZQHiETMyinxPsZ6cDHjZ/vBem0/Zh6/DbifiNbscwVu1TNOGriLhAaiFVCv+9KiipHTlKXXHSg+QaRJQicKyjRklFbXsyjxiUqCQqsnwwt18wa8oZAAWbX/ZVAw8kijY2lFd/vlassYeWu4KcKNTPOXmiq0zaPgFXrVlXa5INTw4MnC/MHMN4IgNLWex9ur7noE2I2pAWgQWob3kDHokZCu85r7tZq2ryMtQjlodETAWYF9IGNkeLu5rwwUwomGS6XuzNpvGPXCE1J4I5grG0bKun2hRl/l/f6slV5m/NMTrr/Wtb2SduA8ewAGStk8mE5tgB1EPWf4ouDF1gdd1CGw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(35042699022)(7416014)(376014)(14060799003)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021135927099003)(261026140227099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261028144727099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	a6Yl1mphjrqB02bxBdDcvbu7uPEHIR2suXI4UuNU1q1ZUezl3f70ZGF4cqEVcBKbEtHPdVFr1Tl6qAjeIDyOXfOUV9nbrVVdy4KP7MAyCD44K9CQdyxRexhs/dIxmW0dAFtWIBmFkTsjnuuEmcbQr1938cfhyP0CbColMnL/IKe6zFrCRb1bHfUTXlaXBpYxRisN2coBXyfIc7RKhYSulU6jo2zDig39ei2Y0/KAbBGq3WUzAPnli7nalJ4VXgv6lSAfOWFmJVjDuQrGs3u73TnPNjQMDrswQHr4Quv5QQZIDnI6zorrupiDbCPZmJmJbYjIdltTEMV4DRW90wUQ4AdSbgkzupdbit0JIvSIUI6g/mwz7CNOepmSSkQH/pmeZ9IjkUnizVpQZ5H3WT1jp9FkYlioz4u4KNNcPtZ6RwuSbXQOa1S+Cg55IOcuPFRU
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2026 11:00:18.5615
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef3f8ed-138b-4a74-9fdb-08df43d0ce8a
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509ED.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB8490

On 11/2/26 05:19, Nicolin Chen wrote:
> The driver programs and enables the event queue unconditionally, while the
> PRI queue has an ARM_SMMU_FEAT_PRI gating each of its touch points. Yet a
> kdump kernel wants to leave both of the queues alone, which would take an
> is_kdump_kernel() test at every one of those places.
> 
> Add an ARM_SMMU_FEAT_EVTQ that the probe always sets, as the event queue is
> architecturally mandatory, and gate the queue's allocation, its interrupt,
> its MSI vector, and its CR0 and IRQ_CTRL enables on it. A subsequent change
> will turn the queue off in a single place.
> 
> No functional change intended.
> 
> Suggested-by: Jason Gunthorpe<jgg@nvidia.com>
> Suggested-by: Robin Murphy<robin.murphy@arm.com>
> Acked-by: Kiryl Shutsemau (Meta)<kas@kernel.org>
> Reviewed-by: Jason Gunthorpe<jgg@nvidia.com>
> Reviewed-by: Mostafa Saleh<smostafa@google.com>
> Tested-by: Breno Leitao<leitao@kernel.org>
> Tested-by: Cristian Prundeanu<cpru@amazon.com>
> Tested-by: Shuai Xue<xueshuai@linux.alibaba.com>
> Signed-off-by: Nicolin Chen<nicolinc@nvidia.com>
> ---

FWIW, regardless of nitpicking:

Reviewed-by: John Garry <john.garry@arm.com>

>   
> +	/* The event queue is architecturally mandatory, unlike the PRI queue */

nit: I don't see a need to mention PRI

> +	smmu->features |= ARM_SMMU_FEAT_EVTQ;
> +


 > +	if (smmu->features & ARM_SMMU_FEAT_EVTQ) {
 > +		irq = smmu->evtq.q.irq;
 > +		if (irq) {

Again I am wondering if ARM_SMMU_FEAT_EVTQ unset is equivalent to irq == 
0? If we only checked irq != 0, then we would get the useful "no evtq 
irq - events will not be reported!\n" message. I don't think that this 
is printed elsewhere (for no evtq). But maybe I am missing something on 
this.
