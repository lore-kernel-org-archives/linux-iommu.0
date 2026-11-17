Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.83.39
ARC-Seal: i=3; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794926097;
	b=jWgwhywg/IGMek43r5PzdlyXVFji1Mc7+NJecpFLcnt4pW5GaXiOfwYHOGyG28Nxx6J/
	 QvMQbJDxX17X3Ty1ukHjPQEG1hznAvYoZSpNZqozSHyswAXiNvudrj5ob/WoybL/AAAi4
	 6fUj6urBcUY6Bko8rCOJ2Dyqtlb2BC91c4lyKEY75dH4vxe9hjzi7nWpYgOtMJYs0sv+D
	 wfjMga8fdyk255uNgfERoxV5Xhs8+KdVcwGU/7qgSeLuVkwtBj+bXAsLopbWarDXUB7B7
	 OBJRdWntDDQfKQUNHldtwdVBlUreoQeywoR9XuTBgMMgYSSpsQBxj81jyotnboJDNLQ==
ARC-Message-Signature: i=3; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794926097;
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
	bh=DYKoFwWK9isrmNevCYir5sjZ9MpPzTzZAiqQptwh3Aw=;
	b=Hx0hwUhRzPxdY8fC6as3TksaiYshppOG7m+KRhGMcKkMr0u60uuYmbtYFJig69upRSqV
	 NLEdMAcKNnxC3oAj5AcdkMjTyD4jHfmsUkmy1N1gfqdtFIiLzmb8m3Lb1kwfDnNudY5sM
	 ZEPkTSP78jWoqLFsvzHvA+9Ey+zDJDOhknkXwNrk6kjwf/aZEtrREpKk5cXVvnA3gQ/UN
	 TtnpnMAE6XL0UIRL2uHgA/ICpODu00A6xWdUJEMLDTn8nqMbwBKwQIy/67BgFeoonAstg
	 ZpOk4xUa9MmS56QR8CIQf+m9y0yQKxc8ycmnQ22HlqzB1w65Utoc59GNfzP3cQNpTcQ==
ARC-Authentication-Results: i=3; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NiH1yyYe;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NiH1yyYe;
	arc=pass header.oldest-pass=2 smtp.remote-ip=52.101.83.39
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013039.outbound.protection.outlook.com [52.101.83.39])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8254860A6F6D
	for <iommu@lists.linux.dev>; Tue, 17 Nov 2026 14:34:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8254860A6F6D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NiH1yyYe;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=selector1 header.b=NiH1yyYe
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=ci/uXi8sPMdjlNU0ybFkLP+PXeFJel/PsLPs8FxtiAfw7mOv6PcTCdmIR0HkX+OwBgapSWIQGEZwCnfy/XkEdezwXNELVc6A3sYd/M5YYYeMro7z+IacVd5ZMG/aoHi4Z8YsSI+P5jJbD3a5lN4d1xBQsko2f4iffhqpQPZK3iB+KJChnUtFYCRYy2/+OSPPDhmcYmAa5JGzPvcVvXwoUXKxa8ka2X8w72UW+sZQBI9M/hsIfUW7KUgfEw+OD5UqZV9V5JFiD2lywk0Cw2+l9XIv56l3h7L42F5lWCGEueJ2z/ShS24aMhpeO9z/tL/CaMCMq4ZogTgK4Nrj+E5Trg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYKoFwWK9isrmNevCYir5sjZ9MpPzTzZAiqQptwh3Aw=;
 b=lSa2OX7rK8wi+Hm+li8rErV0QKu9qkfNoqBIbK8xfl1mEl2tVaaqU4l1EG8H67o7fIf1Jd0MfjFI2MVQx4TbYOy4CdVkHAwl1UsDdhqH349xd6IvXB6WyCUPbmLhC87igGKQOI1Aogd4op73/Rnlc3fL1lwuIWCerK8KrKH9JuY110QF13KtBPxerAcTkcmiDqj945YqYqC9YEhgVTwL8XmTKttUaUwVCs51PIR2D51yqXbXt6zQl9qn0WOAW3ACtUYfLD468a7hYh8Lkysqfbkd9vHHNE9mFn+hQEEdtXjrgJaknvowQMjCPAwKxeID3TUzmGnGycmVhpz9puisUg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=nvidia.com smtp.mailfrom=arm.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=arm.com; dkim=pass
 (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYKoFwWK9isrmNevCYir5sjZ9MpPzTzZAiqQptwh3Aw=;
 b=NiH1yyYeGHAIDHhKTuJpNu9Qr1ZGI5rhOqL3WBPlSuhUEokWZq+1qahox5cH50dexec9l+Scz7cr96d5l9/4jFWATVutmXJQNf4WszI2sOpnn90CLVvYOHoWzZUkmQ7t6wRLmtiW3qUv1QkThhEJr2RLsWhc8Ly08CjvoarGs6Q=
Received: from AM6P191CA0051.EURP191.PROD.OUTLOOK.COM (2603:10a6:209:7f::43)
 by PA6PR08MB11287.eurprd08.prod.outlook.com (2603:10a6:102:514::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.10; Tue, 17 Nov
 2026 14:34:47 +0000
Received: from AM7PEPF00000055.EURPRD83.prod.outlook.com
 (2603:10a6:209:7f:cafe::3c) by AM6P191CA0051.outlook.office365.com
 (2603:10a6:209:7f::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.10 via Frontend Transport; Tue,
 17 Nov 2026 14:34:47 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 4.158.2.129) smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AM7PEPF00000055.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.0
 via Frontend Transport; Tue, 17 Nov 2026 14:34:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G4Cwow4hekg9+8PurSHvokcowN0KKxXqJv39kYthQPRChL7Xy63+jr2IrOEaHzM2P8QdnqWZPIRyoex2uAGya2bJy63F8BzGlgJdeL5uKZK4A6LG8nusvbMm01eUWkTXldUuAhNTGo6xTYTcLxyzO0i7Ssspq3CEwz/2H4eLnKE1t5uIKlWg1163DZj7DUt+L04pAlC4R5WiUan1HdVKt8GDG61696a246wL0ONUGlrPdpsBxGDwDQ3i9WmPhUqf7+AY9N9qWYW8QY0mMZb/wc+rVRsxfyX8yQWsX6XRF12tJuMkIPespRcrxLK5jg0CPFfOprQ/6uekcYw52zN+Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DYKoFwWK9isrmNevCYir5sjZ9MpPzTzZAiqQptwh3Aw=;
 b=BdmdRMpxoO+LlXbMxXXN723pZ4w3ZLapFKcHx2WHeS471JEmfOc/iMcEJP69RYIXxo1nE+tb+NBbS2jJr+XlEMTTa3Kqn3q2YUv5iAkTpBYDd2fXTTzYyurIZ9YIuu+yPKQmEKop8XH+k+PUPnFJTWd1LcQl/lRpaTyFH9GHVXR9nS96HMkjVYNZszRCxBa0ltom/4pv9+dfcnHEAL2FTKAhvJ4IyNBdM+cFS0wEGJDZg6XTeyB/KpYaBTJmsKI6jpTNIDX1k5aol88fmJL7hwi7fwwC87Huqkma3R60xFfx41vhPSaLZiw83OTrBbNSKX/QntijhOl6dNV0k5Bivg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DYKoFwWK9isrmNevCYir5sjZ9MpPzTzZAiqQptwh3Aw=;
 b=NiH1yyYeGHAIDHhKTuJpNu9Qr1ZGI5rhOqL3WBPlSuhUEokWZq+1qahox5cH50dexec9l+Scz7cr96d5l9/4jFWATVutmXJQNf4WszI2sOpnn90CLVvYOHoWzZUkmQ7t6wRLmtiW3qUv1QkThhEJr2RLsWhc8Ly08CjvoarGs6Q=
Authentication-Results-Original: mx.microsoft.com 1; dkim=none (message not
 signed) header.d=none;dmarc=none action=none header.from=arm.com;
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com (2603:10a6:102:33f::15)
 by PAVPR08MB8941.eurprd08.prod.outlook.com (2603:10a6:102:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Tue, 17 Nov
 2026 14:34:06 +0000
Received: from PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f]) by PAWPR08MB8959.eurprd08.prod.outlook.com
 ([fe80::71d3:7b21:3594:e33f%7]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 14:34:06 +0000
Message-ID: <4154cfd8-e877-45a7-bf1a-45e2ae560e93@arm.com>
Date: Tue, 17 Nov 2026 14:34:05 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 11/12] iommu/arm-smmu-v3: Skip RMR bypass for kdump
 adoption
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jgg@nvidia.com, robin.murphy@arm.com, joro@8bytes.org,
 praan@google.com, kevin.tian@intel.com, smostafa@google.com,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, jamien@nvidia.com, kas@kernel.org,
 Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>,
 xueshuai@linux.alibaba.com
References: <cover.1793593923.git.nicolinc@nvidia.com>
 <22a06965287dd478ee92f8028ae8ac27e054555d.1793593923.git.nicolinc@nvidia.com>
 <4cf391ff-804a-46a1-8d3e-d0ff8442841f@arm.com> <avtYhjyAarKdi33b@nvidia.com>
Content-Language: en-US
From: John Garry <john.garry@arm.com>
In-Reply-To: <avtYhjyAarKdi33b@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0238.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::11) To PAWPR08MB8959.eurprd08.prod.outlook.com
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
	PAWPR08MB8959:EE_|PAVPR08MB8941:EE_|AM7PEPF00000055:EE_|PA6PR08MB11287:EE_
X-MS-Office365-Filtering-Correlation-Id: 507a96ef-c956-4362-a844-08df44b7edd7
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|18002099003|22082099003|6133799003|261009223027099003|11063799006|4143699003|56012099006|261102123227099003|261028144727099003|261026140227099003|261026121527099003|261021121427099003|261022075727099003|261022105027099003|261021135927099003|10067099003;
X-Microsoft-Antispam-Message-Info-Original:
 ocvHrtV4VL2UL6mREvH/rALvFTvqaw//Z2eY99/GEkJHCoT4RSJpCxQh+oI7GujWqekqN+YMUlblxGs4QRkiuvgsCqlnoqT46ymzuHt9iYaw+O4dR3lPmYEqcuEcYSfO13xoK8YIWirIrNhMuWn5RnXYfQTUFmHHTwC56qzeDykGsrhlDIcvplMb1WftTBfcrfsm7wZ18pNYl/mU99tgjjurJ+KK2LuYlcFAtUxJjRgVuUrQPVFVpoc6WkINmEdvIsKVtYM73EIYWLJNQm6ov3yJuT7Ky4IoKyCaAzTVfgLiryh/ZNtjSAhkSalZgL/hBr/xhGWn4kMMj/aTEZ9yV56IHVyWLhI4lJjEOtHhwdvTzvih1TwfNdtCWg9KZgntEYbdxB/5DzpO6dTJsiUas9iVOYE29JElF+87lxID/2GkCUv08uZ3j9N37qADkpGhh1tYkA1mUKwISwNokzQfqXfCMVdoC/ExzjWD84ELWvRDv2TE7Rm/PWapDVx/HLxoXXH9EZSmVBgdQ2uKgTSK1aIMupnrOkjkmWzoqZHAiwqi1iuRhG4/o4sva6DevCDm6F3APHC1mYxoOWlMqRBKOAcyCLPJtMlks/dQ1X46dkULzGhpQoa7+ZkflaTKeP7M7lNVX30Pvw43YKZvo3vtHf8GT7TKlYxt8hJ1G+wnsqE=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR08MB8959.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(18002099003)(22082099003)(6133799003)(261009223027099003)(11063799006)(4143699003)(56012099006)(261102123227099003)(261028144727099003)(261026140227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261022105027099003)(261021135927099003)(10067099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 yBv3IfjjaemvFCnxLRoN3ge/zm34zrk6jPI/SZDnqcOVeuWetAYmiG5qrkdT7faq7F7N1igrGI99DrYiQNaRbY+uGTetI/nrgTI/WiQYkqQMOvy1ZBjQpRR2LP7UYeE8kzO0dMoRMdESyb0AN0uWu2VD6x9n3i3wVXt6IzchwymEderaa40jIqAuhJoOngzEystTNmcWFMQx+sho+ajEocRzzYzcGt910T30cLy4iRfT3klRB6rglfUQE/j9nZqwRaISJpZ+BU85wUW0e7PDr9HnHZ+rp9r+ZujeDdNYlgMeo771TqlN7dZG4AgC5f7xLn2DnO7ZwI8TQL4ZRnjzFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB8941
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AM7PEPF00000055.EURPRD83.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	8808d374-5e06-4e0c-2769-08df44b7d5c5
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|14060799003|36860700016|23010399003|35042699022|261026121527099003|22082099003|18002099003|6133799003|4143699003|11063799006|10067099003|56012099006|261026140227099003|261028144727099003|261021135927099003|261102123227099003|261022105027099003|261022075727099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	IhHxR4z2gH96UA9gPUhaLGpPtwYYgWyTZay/di3fFaSk/7jGOOqBEGY4z0Q/s/ggOjApZqYd6KJO7XqfWEAxArdFNBuuAfX990zrcsY70fs4Zj/BDA8wtwcvSuTqA4sqZBD1+RaWha1fx0rNvFrGLxU05rsd7B2eiEsHssxaQsf0SozwpaYd8NDzTe8vDbe5HVHtzujYma0VpjYr2eQSvWE7OvkZAGNIR1y7nNE2fICkou9sa4p/Opd/QXVZqq4CXq4ACdMGln/fqPwspOmS222Kl6gdhKl8KMHLi23/JG6eeFryfGTz9yN3z31Rk7uwydfpbAb2b86uMJ6G+C6ltn59ZEV9LBh/D7PZpSBGJQ8V0z5u3pIotIV3+lc8ysr6HBm8UxIKdr9zRY+YIHTeUo6TTop69a8/hGYIcog5A7ubfDrYRYP/3lEUQ2uiP/uSulGtQFYeaenHpg4yEa/O0+5TWuVVOWISFDOh2TuvuTmTCJoDsRfmw0l4Ph+f7wM9s7PHW+UL2W3+33X1PiYYud2VQMVPIomV4sYkR8KL6XTzZa5LR1zi68OaIXroEob+3Cv/QV/YGlA1KhdUdf05360lbqqIQ39FU+Y0j1nNYod4qVbq02RZ+DxkGEOOjp0E6cj3BQFqMniNTR1Rj8Q17RtEqMrPijVqfJ6EHyQo/w3j5Uoim0SCDL1JaQantPeUC9DMpUdbQF6OFobgVDH9Cw==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(14060799003)(36860700016)(23010399003)(35042699022)(261026121527099003)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(261026140227099003)(261028144727099003)(261021135927099003)(261102123227099003)(261022105027099003)(261022075727099003)(261021121427099003)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fkKKDjTyysuwfVXwAWLSeQBRBc3KeFiDG0F59BYDLMQt5PTghPwJz41aQiD/EINYQA9898tpTvXAdJWzZHU5U83FuKf6BCUzT2WrDmJGZJOexTMPWNFRDVO8lZOeZUDQ6VjXgOysv+lrWCZYCA0bs0aTqHguwg9jqi7XPdoN8VKAGM6R8/gxQc6Ng7d4beLY8Dar3FoqBZvmsPufEoe9ONfB745h8D5xxSxOWjAkyAZhk1iO5/oYMiK8Q/0P5kXVsxEbg40dh4gsAWb0JfKtRSoUuaw5j2IuyyXpqcqAaKgS6VGnpgjHKhf7ygeaVXqF3LuvxkTs75c0Rvv9gra+GKVRTi7Zl8nLv4xZIhpbNVhbFKgen+oLAgx8lzBEo0ormgTqRLyfSbCaUKWFBXqf2NV3hTpMFueEieWRf2gIfe6WCnu96OzMy3mUrrU6pi9Z
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 14:34:46.8995
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 507a96ef-c956-4362-a844-08df44b7edd7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000055.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB11287

On 11/16/26 19:24, Nicolin Chen wrote:
>>> adoption keeps the crashed kernel's table live. Rewriting the
>>> +	 * adopted STE here could expose an in-flight fetch to a transient V=0
>>> +	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
>>> +	 */
>>> +	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
>>> +		return;
>>> +
>>>    	INIT_LIST_HEAD(&rmr_list);
>>>    	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
>> Did you consider if we should sanitise the adopted ste against what
>> iort_get_rmr_sids() returns? I suppose that would add even more complexity.
> It's not necessary: both crashed and kdump kernels installed them
> from the same IORT. If STE is translated, they are mapped as 1:1.
> It's certainly not worth the complexity.

BTW, are those regions described in a file(s) in sysfs? I thought that 
they were, but I can't find it, so I guess that they don't (exist).

Thanks,
John
