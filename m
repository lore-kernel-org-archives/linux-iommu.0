Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=52.101.72.36
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792658521;
	b=Lb/pQIsmbS/9v3dg1+Byx+95Xl6Tle/EQbcsi0N7Uqwk53X2qKuzuNc0cVY+N8P3of0H
	 iKfTB7lAGypCEOxSbu1/bB0YLxS6n4Lj5l7VfG9nbpMvXqQf4DfT1sXZQlPgU041hNN2Q
	 w8envjg26p6DcjPKnOg5RUaL+R6sXevVj0QmbPJvb79OoALQVFU/o5nauQwF3pxr0e/FP
	 yPtPrGV/Qkl71l/4QIRCesmGUT06CIq/EqSkScXLKdqCEQNfGCnaUas7y82FFxh1Yt6Pg
	 7P4C3haf4AAkZmB/HGvhlKS9XzcpV13HRDtLdqNvZ/hLJ49Hp0m9k03O/vLqws8rwHg==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792658521;
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
	bh=K60xDMQPFV93UI9BMaYqlAsPWvMNZxPHLkM/Nx5/tq0=;
	b=BYS6nVzwGVDdE3ZqinUNnVFIBuc8Av3coMTpssr/wOSXXyg/Ubi5t/0Hh9s5hAd5ktRK
	 VYgDZpY1WGatuv5nz8SmhbOt2tj/IVmgNplBBAWMnGcmzU1f7SY2Qu+O996Ex97zX93F4
	 gKoykitKii/tV4XMC0/4OF6denBeXAJsynNbChKHrSQG8G8F8Vx1HB1nCBJdh0wGnpJ+T
	 aF/ybFxwPRGEq1O3GR8l3Hc48wAxi0ISkQnsnGSg/1Ngvfyz9XvMgMbdaGcBGyAq4Rh34
	 mOwQP3Fla56LLawezsAvg+//Xj16s5tHZgiwr62M7xCYp72u8dve0JqjVKHk046LCGg==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bDk9swjY;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bDk9swjY;
	arc=fail smtp.remote-ip=52.101.72.36
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013036.outbound.protection.outlook.com [52.101.72.36])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F4F606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 08:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F4F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bDk9swjY;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=bDk9swjY
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=GcHg77E2noVFjon6fL5J7gXLNH2t335z5rpkHdiK4+Flq384KEWnt4S55yAcTovS8cZNGdoosE0M4OLGieinqxTJUTL909QlDPfaJB4La40Xiz0/kBXQ1kOtLoJ8rST/0W0yPpOxK7xONqZzXcQC4Rt+fS1xcrg49oOoBoR5OnvtZjgh5E2yyAT/A3uThKqu708Xd2JudKSIirvEbBVqBc0o6GQqB8WNG/InSMrDSeVds4an3LoH6Ki3Ld6vwlW+3QZZ6rBJK0mFmfpRtzGw47FDoQdzkLbP7PJozy18xMH+FF7RD+nX2oiQA7aAn4MP2YN1pf0uhlU8NJQD5176Fw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K60xDMQPFV93UI9BMaYqlAsPWvMNZxPHLkM/Nx5/tq0=;
 b=B+b7UCoowmz4kzQLWkYJWfxZTstQa3o3ZP1IOeHl4P2o5CQ152oCbLL44zuLyCN+Gg1DcxDq2OrQ/SqvuLZ3Sus3QfXpepEIjVLbS+0bate3/OF0lPghD74EgjZzYuMVqbOLh1QWf54KRKM2cabvd3TnA1r4zpVM7vW+Nj22PjQaRtB6N3mhYFjnwSQhpV/t7iN++NN8ZfkTADwezEF5/V/Pc8eExMoKp+ASqaxb/PZRLxj71ouruVwfb8Qvn9ar4z1Go30kj6bFyCZQyYldMJBgbWXEMCJ8RNMMTESdD3+6WBZ8KbQZLWkFpZ74glYF2vqjWQWda+p3bKR5xLsBYQ==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K60xDMQPFV93UI9BMaYqlAsPWvMNZxPHLkM/Nx5/tq0=;
 b=bDk9swjYKNL91UolDoJArocfZkVJ6k8a4UciyOQHCiVP6Yx0/G5yZPWiY8Ckly8ZHIaBGDgLL33TnKO+xzgGLMmyjwC+bpMWVbyke1uig5/Rq5pMAEcgmdKNhGy5vkUvU21JNovfTMsg1nEUgtwu2xRDA6rl/O6nB6aobPNs4Vo=
Received: from AS4P192CA0012.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5da::20)
 by AM8PR08MB5633.eurprd08.prod.outlook.com (2603:10a6:20b:1d3::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.14; Thu, 22 Oct
 2026 08:41:54 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5da:cafe::f) by AS4P192CA0012.outlook.office365.com
 (2603:10a6:20b:5da::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 08:41:54 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15
 via Frontend Transport; Thu, 22 Oct 2026 08:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRM/iXRgAu/yo8tjLXm23nj1/723SeR3q4Te66CFbG4wyCAEbmAbYeghqiVr+HNE6NHQSAwO9rDv52i+E/Qp2uiG6fEhm/gvFao1PTbfYeToDD3/hNoe7LSKGvO+1VbaU55Bp/DXLuk42XYoBQjkRT+s3Z/kYLOXZkDKb4FaFjYldESQThY4qg260/LraiFkc36bCEiCStDIy+uMvo8vR2lkRtB6TWlNhsf92+ffbP7Rp7qJzNoqROhRmhPYcmrGC5a+KocUQ4fYPgBvx3aXNYFJ2YyMDEnmJqs+ZWQbK66fm6IDzEyfcYq0icvFPZcsiRkZnlDFksv0b3zS5VmcSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K60xDMQPFV93UI9BMaYqlAsPWvMNZxPHLkM/Nx5/tq0=;
 b=gvg/816FIpcZstK0I4W4MArkHz4WBMchem+ZU0DsO/IAeWNxxzwcTWUjYDZti4DD1+QoFkEaNhLq9vk/BcKkbTMb0TJldmcBr3JfGRUKOL/xOsyj0WMRuedh7j68coDcwQ2EfAZmPn4ovg42R5wP0uGpCW0iYuhmrkAs+9LMGxF3ypi8n8Adzsc1B3210jOtgmowo060ModVcV9x/bKBMvcDjgYb+L9L1QtDzrgOw8XfZSpJx2XCzH1NVjOjlF649NUw8mCWIQBhOsR+4ZhYo+vL+YoCGckiPTdyx63Krt5ynMThnTKdHdC0+XdzZq3RwIIeOs75MyyVFhLEDm06bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K60xDMQPFV93UI9BMaYqlAsPWvMNZxPHLkM/Nx5/tq0=;
 b=bDk9swjYKNL91UolDoJArocfZkVJ6k8a4UciyOQHCiVP6Yx0/G5yZPWiY8Ckly8ZHIaBGDgLL33TnKO+xzgGLMmyjwC+bpMWVbyke1uig5/Rq5pMAEcgmdKNhGy5vkUvU21JNovfTMsg1nEUgtwu2xRDA6rl/O6nB6aobPNs4Vo=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11) by GV2PR08MB791691.eurprd08.prod.outlook.com
 (2603:10a6:150:38b::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 08:41:20 +0000
Received: from GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375]) by GV1PR08MB10691.eurprd08.prod.outlook.com
 ([fe80::dd4e:5d51:17f9:9375%4]) with mapi id 15.21.0546.012; Thu, 22 Oct 2026
 08:41:20 +0000
Message-ID: <ab304d36-c655-4a3b-b1ab-e4b7292bfd24@arm.com>
Date: Thu, 22 Oct 2026 09:41:18 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add ARM_SMMU_OPT_KDUMP_ADOPT
 for kdump kernel
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jgg@nvidia.com,
 praan@google.com, kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <9f500b81-792f-47b9-a8a9-1415ff11b699@arm.com> <atj7XTdjC0CIVDQY@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <atj7XTdjC0CIVDQY@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0207.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::20) To GV1PR08MB10691.eurprd08.prod.outlook.com
 (2603:10a6:150:162::11)
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
	GV1PR08MB10691:EE_|GV2PR08MB791691:EE_|AM2PEPF00070CF7:EE_|AM8PR08MB5633:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5a999b-544b-49d3-725b-08df301852fd
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|261021121427099003|56012099006|11063799006|261021135927099003|4143699003|261009223027099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info-Original:
 E7/fBtzSHaXDyKKCkUxBUS1TeQ4wtMQimX/CTlE/WdSbqi4+JwIFy7uq8sLomj5mUh00nhFm6fEu5WfLrqa15uEpPDORNSCOzTiObUZs4OuKcCICVh098ZQtrdo9MW7anEe0WOwu/jFtn8SNPTcoYZC+s7dFTxO1OvAlIWg1Y6C9RcvS24j2e0qNpb9Rwl30OCN5KmPitXcdnME03HiNR03+da83swiGlBSVkOUNmOBBWsfrfVTvbClnx3an63R+CSgB+lYn4pF2hehB3fsgNThXKRP5amLDMsrlmrlAyj8cMLot53fsAbliX+oVWUMc14WAaSGAz4jrciPlHuYzWhSJDZ9EiUZ5es/xQvodg7Vz463uSFeNMVkfyakIJeq89zRdXbNvKFmGdD2pr7VtrvnXzIOJaeKetfNMZ8b78RzlwaQTWmpvExKAJlhDpQx0uKKDpktjpAT9U0zUSxiw50+3+IuBK4NAlAdmZch4laYDEodCupyXP9/1eYF3a/6xpUxDti9/TLV4Y4SEcG++JMESVW14M7SuPBxYmzqfi+YSXzH1UGqV1iOAS90WZjgUnFKLOG5ooyVCCjrNBgAQAqCP3I4tNypUjTNyTHtmXp1aglI3QxrUoDvP5mvTM3VG13JQ11rnkO4Y7JrPIArvxXGOCiaMX55TbkQ7S0uNg9E=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10691.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(261021121427099003)(56012099006)(11063799006)(261021135927099003)(4143699003)(261009223027099003)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 MuJeeCH8VNukU89fngjtnOrXYD4gVvLoonKf1zEj6zDSyr9OCUeFmxZ8m0ru/bpTwNAv+3Na6GX5Sapu8YsOg5SP7pyvXQgw6Xhs/+TyXA4j5Or3bD20baHqxQg00mr4b4ZKEI1cOWKby6VOmHPpf3b6l/1Ut4/5b+l79jQ0464ghrhIuhqxWqIxOJi1IPxO6X1mdRLtatSzfjcLOW4QZnCQ118LORzlC5iWhOVRUaIL9HSFBwWvvpWfhTF/7JCRQ4kb2EQzOxiWybTxhL5o1DLSenZB4Y8n1tqJcHaUyyBQSxmB+PX5t/cpMHX5REap+gpBAvQJxLjWQ4uEFEYFjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR08MB791691
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	325fea02-ef93-48d0-462c-08df30183ee6
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|35042699022|36860700016|1800799024|14060799003|23010399003|6133799003|22082099003|10067099003|18002099003|261021121427099003|261021135927099003|4143699003|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	+N6YFLJFDPsVj+NUwgC35HYTqxyicin8M07zclrTL8QgkHWKLG4N6iAWgcrQfPu3Xj5T8Wsmun6S78zFNjhzxF4TtkOPtth/d+V1Ba7wRF4U3rUcCQkf5lM50fWQ10/lf+3ejbkrrNReI+5FhnOTeAtBGdsJfhTCCoZeZkyeMf1fVq1VWrhq4A6lp9VqnCS2pX4S6B/a4D8cxlfJ7EShHzg2aUZcrK1uPhbCT709yvBo7MyG9FUkkjgDG52984Jb/XDMssWPur9PSyIkwl0BZMaIRWx1ZZPrRSWNMbkSAo+KPpXnmvDQeODwg/dQXA0jZJXVCZMzQ9ALi6L+zo7TGF3obUK4FKqS4Z3lmR77GsjHejDU3p7kceRGAYy0r1HWqlGqoFuR1g3eq40UTXQdVf1lcHwvSHX0kjolJF6SM/gQKFEVTIm/npfNe+hJcvdrhSobaTg6qemBbMOOxa5cJN72+0B2LFR2XFxst4oFGBvkv9B7sOmacpbG0Q0nryxOJNCfmWK/Wt8qFZUQNdP7dU0+uiFQULh9Ccw1O13UzxugLHTwL5KMvjrcxSs5cMMskViYFLZWddS+TMopzPCm7elMHitQMJYM22nCTk7n1hAfHnJfgU+JdSn4tb5PN9+Pau5CSGkHv8tRZAZrxBuS4QXH3ylom+oIvGKmE9THF0+OPZbdMEbzEm679b1Qlw6lb+/Latj+pkg/KRzNJPOYRw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(35042699022)(36860700016)(1800799024)(14060799003)(23010399003)(6133799003)(22082099003)(10067099003)(18002099003)(261021121427099003)(261021135927099003)(4143699003)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	3oVdIjf3Od4UYMl3tiWaVALz6GTYeu3LJ7TVWf2YpHZSnLOB2UqJubzzMP52BaIyAM2QD6lBFVtpWp1z7GQs86Y0BWYshNo7RWpRiy/wCq0JftZJUnKCjHry3ESH8I+Yly1Yaw0Qq0N52Imsg4ErZ7cngDvRZVRehDWmTEEON6+jpby/990dNRUriGQB6D7oyKODzP2MFK8zcKtlQlRtARF8w+9S83ufIaO7JGAP4doVbMYEcVlxrbRlSQWmAqS+drOQbHkzIVCXbqNIVyJvd01AI6BuVhFL/T+zVmPj/rDRjxaA3FWyiY9/dYHkjbJdgNos8qTztuO/W//8isR4TFMbPOsR+jA7/W75SXgwnkFp5skaY4GK0wVfhkbFsPzvS7hqX/a2b4/kbGrxW49lBq0zZKoqC1Cmmb5pihMKGwRSUh7bU0amLr4D/Y90A1ry
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 08:41:53.8686
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5a999b-544b-49d3-725b-08df301852fd
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB5633

On 10/21/26 18:50, Nicolin Chen wrote:
>> Earlier the event queue feature flag was unset - should we still be going
>> with that decision?
> Yes. EVETQ and PRIQ are disabled in kdump mode, even today:
> 
> 	if (is_kdump_kernel())
> 		enables &= ~(CR0_EVTQEN | CR0_PRIQEN);

ok

> 
>> Did you consider to just re-probe the SMMU driver without trying this
>> adoption method when problems occur?
> You mean -EPROBE_DEFER? 

Yes, and it should play ok with the IOMMU probe ordering "replay" mechanism.

> I don't think it would be cleaner..
> 
> And it would retry the "adopt" mode again? 

No, that's the point. Currently you first try the adopt mechanism; if a 
problem is found there, you fall back to the normal full reset. My idea 
is that if a problem is found with the adopt mechanism, you just 
re-probe with the normal full reset method, so that you don't need to 
undo some adopt work during the probe.

> This is a per-smmu
> option, no global flag. When it re-probes, smmu pointer would
> be reallocated. So it won't disable the adopt path during the
> re-probe.
> 
> Here, we just have three lines to fallback immediately, which
> is much less expensive than a re-probe, IMHO.

ok, if you think so.

BTW, on another point, nobody checks the specific error code returned 
value from arm_smmu_kdump_adopt_strtab(), so you can consider making it 
return a bool.
