Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792669965;
	b=fiwEuMjprBe+80z8hucSSbZvczouiafSIi1FP/he/SVUatWO5tUvA3APdVs7LW2X1CDR
	 kRuzZllwRsrQTZm7Rcnf4vFJv5f/9Cw9Iwg/Lc43tftyqEe4qeulu2XVMcoBudMWw8qx4
	 cXJ6b5Aam+YsS1x43puFspDd3F63JmCjXmleCkd6XRmHYFyfc/QpmIgxzNwmzEm+oxkBa
	 Xd2ZSzSQsYNXcYoBPmM0S7Ut5hR2E659zcrGF4S91RVvZNNxmiVutz8Ag1tmrV4GSCfr+
	 Gt829aMcxAttVlZr77T8RtuYQ5glsAUpFpMdaOzoqnqCiTuPeetHk2TZGiEUiR+ANvw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792669965;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-ClientProxiedBy:MIME-Version:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=K1TXoLFaax3NixVYrokYXhhJXX+iQCpUFZnQIWOixR8=;
	b=pjkXODE5AeNp2PVSRWO56dYBSRX1O6TyEuWMKorWvnlb24rs469s9YkjtQeabF01cAiT
	 Vjd0UFNyxJwPtLMrI4f8+E45r9kpa8vmZT33fB88S2SSKrn5Nvo+wYjQGt8omRLGv9hXy
	 ShrzRWsEe+Zpk7OWpzP8Dys2Hn7nqa43PzfF+5jYJfDRRNasJZmHFQG9Wot3lEvi5OxPM
	 ZehTSXU7MOQk2QWBFF9x2bxm9adSNvG1bqMq8zT1HsblK6rm9K+Vw2PoG7Hq+n+Fod9oS
	 lwC6r/CTF+kiPYu6jQhFfMP2IOG6dXkgpKPeAT3kqsOj3xpNm2gxRCl/lwFmR5UJECQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lbIM08N1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.209.45
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012045.outbound.protection.outlook.com [40.107.209.45])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CC6606A31A
	for <iommu@lists.linux.dev>; Thu, 22 Oct 2026 11:52:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6CC6606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lbIM08N1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RTaTWWVNQ0nLYtNfx1sd0KcwuE5snSDze/Pub7WO7nbw/dYmFi1gb5/kIFKRpjHQvVyYQfNAVpthG365RhlACArsrSByqXfSD9AhtRdIVg/R8FtAeENNU+X6t2M8g5Lyc2PlT0q8+f0PGJAuZNNVRVDnIf71zqSDq+nwtMqkpULaI3dFQwIrsEIJfnDPuONCkWFLh0LgYyo4C10DobVpyb8km2QxMGfPSjjnjwWM6Or4u2HKPmSHI1KrdHgRIqW/9Oi9OHx+UWvXAOCs2vRxURphtUJB8UBpOkvJZG6/MMZLnMr5twxZtAlZY6QVA8gQ/IQdA9JscBycY74+q3BvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K1TXoLFaax3NixVYrokYXhhJXX+iQCpUFZnQIWOixR8=;
 b=UrWeGarF7M+QjqytooKnQfJgRXb7o28iIdm0UU8KE/lI0FrbgSE8CX2Lgh2VNnJEcFE03L5umfcNZkB+wMvtZL4LxilK+amwQaS2QVD06rYReH6HlzPfx12c7509/SIoMtaRRjjCj1/s8pDn49yqjAyhyxNRKQbKCclSmSGWBzN5908zO1yMhSUbZujlLzRr0W9FQbpsB0CigB67d30bAN37ke+DJLxd4MwouTMSIkBYi1OVC+sIQi7r7xee0VziirzS16RaJZ86Vfr0f8q3m5jfUR9Vs8HYVhWI/79Dcup+Zjb2Wcilkz27iAkdgFMzhvArJ2CUpUdYQP16y5T91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K1TXoLFaax3NixVYrokYXhhJXX+iQCpUFZnQIWOixR8=;
 b=lbIM08N1NsbaTLiUNRl1rIV6OIQAJpLFKiEyAr0xxy3i9TL6nKHlmnfJ1QF2RcG28Qf2zJ8O/o6wFNsOt1iMrzJA5a26jzPBNbZTdyT94ieNhSJMayxf4ksyA07z0/WMddh2Xn1yV5jrYe7NUPEvhrqTXbTju/D1pYg8LqTNBruizCpyOLasElZfuInhLU/sBJMdKUzCu+SqC4J1Z0YCuE3zxp/KlZ0CPXbG2WwY3cAIGEf7Y7E347sLYVD4t0Uo2WJ8b5frE4HgYty6NS+h93Vu5XWujsE93QI4Y1hbbBfntPosksLKF4jnSSYMn7P1NGrwLsqQx5vvs5PrMCEyDA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12) by LV5PR12MB9804.namprd12.prod.outlook.com
 (2603:10b6:408:303::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 11:52:41 +0000
Received: from CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d]) by CHBPR12MB731189.namprd12.prod.outlook.com
 ([fe80::b0e5:123d:fe06:e10d%6]) with mapi id 15.21.0546.016; Thu, 22 Oct 2026
 11:52:40 +0000
Date: Thu, 22 Oct 2026 08:52:39 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Alistair Popple <apopple@nvidia.com>,
	Christian Koenig <christian.koenig@amd.com>,
	Dongwon Kim <dongwon.kim@intel.com>,
	dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Leon Romanovsky <leonro@nvidia.com>, linaro-mm-sig@lists.linaro.org,
	linux-media@vger.kernel.org,
	Matthew Brost <matthew.brost@intel.com>,
	Simona Vetter <simona.vetter@ffwll.ch>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH RFC 01/26] dma-buf: Introduce DMA-buf mapping types
Message-ID: <20261022115239.GY3008132@nvidia.com>
References: <1-v1-b5cab63049c0+191af-dmabuf_map_type_jgg@nvidia.com>
 <b5d1bc79fae01fd9b511e06ed796130314ff841b.camel@linux.intel.com>
 <20261021123755.GL3008132@nvidia.com>
 <atmurtZOhKwwGjV3@nvdebian.thelocal>
 <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6eeb6257a6ab3b5db384aeb255623a11cb09c603.camel@linux.intel.com>
X-ClientProxiedBy: YT4PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d7::15) To CHBPR12MB731189.namprd12.prod.outlook.com
 (2603:10b6:610:33d::12)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHBPR12MB731189:EE_|LV5PR12MB9804:EE_
X-MS-Office365-Filtering-Correlation-Id: 7487a292-723e-49d6-f601-08df3032f95e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|366016|261021121427099003|56012099006|4143699003|11063799006|261013131602099003|18002099003|10067099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	I0uXCa2aX9ENhqQ+sQJmexZoV0txkGLvPQHpScCwFasq33yv8i3ZwwIeJDGZd5EyIsQPGDC1s7aw6AZ7hdFP+00RwrQX6BKIpPO9rdxEehgwFatzsr6XnD+tPYo+nkzhDbwDEBT9/eIu2E1byRxJ4d1/dqqjFysczSN5F7hamXRhoEUwWIWRBC0zjdbaosIEpK0KR/lpqiVG9rf3KbTmY6rOgyc/E99FbuL9yp9PukzpB78tjHADMbrQ5j4wqXQwpgMM1loVE2gly2CP+dpfs0csUL3Q3oIvu76U+5ePbanymd7VJosRWC9pxU14itgTEmoE+z8fjTtWeMtjqeec4iX3Yb6y0UJylwGv0Xjjqs/i+tOTbZDS5Z3Q0PVXMB7oFUnkS5R6n0yGp4Ins9K5t2/jQIqEM1BJmCu1hLRF629nBt+rXW5pZKbKFljpRDh+jICdX14Mbk7wN++78xk/tQ6+UXlwGTO+rxchdxFwrqznduwsq8se3AQSBj32YilwEwi7gmsDtHsyR8bjycFjjZPxNHYRIscGu+L07bGIynzjYW0xB1M/snO57JDsPAhSZpYL2OgH4hJcfosqbYleLhAw/uCwxT6+OOfGQeBQL+UBF/Q1QA2eHQqWlwZ9qFRpN70aSZEFWhOFp3OtudPNDx5qtHUzOQ/JchNPA98MJBY=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CHBPR12MB731189.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(366016)(261021121427099003)(56012099006)(4143699003)(11063799006)(261013131602099003)(18002099003)(10067099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VzhnMWN4MS9wUHJRVUN4WjYzblV4aERnNzRwNzM4eFNLMHEzUmRDVXJjRktw?=
 =?utf-8?B?b1JoSEZWUDgyaE9vRFhMWktOYitSMHNmUDFCTm4zamNqajAveE9PTzJweUFm?=
 =?utf-8?B?a1ZEU1ZBUEFrblBlUFdjRlBMWnUvUVJCT29iblFmZk5EdXk5elZaeGFudVdn?=
 =?utf-8?B?V0tDOXB2YTJXVDFCYmhPRmgyUGg2RDh5a1MwWmYvTGV1UUswS0NnbGhiMUJk?=
 =?utf-8?B?eWhlY0RTekVRSjNWWHUyQ0M0anl4NXdIQ3NMcWFJK1h1MGRLVXVjRmVxOVJF?=
 =?utf-8?B?c1ZpRXRrV2RMQ3phVHZiZ0tUK1lmSkdXWllHazcyQmxqdjJIL2M0YzZVSnFm?=
 =?utf-8?B?MGFvcnNGYVBZU3VBc2EwSTZYSWRZaEU4ckRQQkRsTnBIa2NtVHlxcXhhemFn?=
 =?utf-8?B?aHZVK3FYaDFrNDNwNklEbTBZaC93cVFubDRRQXdicCtUM0toSVVGTjdOU0E4?=
 =?utf-8?B?NFYxcVBUaVB5S2hoazBmMWZOVXFoYVdaVTFoWk8zejllZ3JuYWp5MzZXMzcw?=
 =?utf-8?B?Sk9URXphNU1TcGZ4UzBLb1BQS2dvaG5rNXJsZDBQaXpxVjVjN21YdU82ZGFl?=
 =?utf-8?B?SmozanpDdlRydTRuVHFzOHpHczI1cEFVQ2JiVEMySjREaGFGMFZqY2pNVVZE?=
 =?utf-8?B?ekFZVmpwcHR0Z2REdHBWVVZjZzJjc2Q1SkUrWGYzQVNTVlpUN2hGZ2NCZzgw?=
 =?utf-8?B?MW9uWjU0Q1dNckZwVFlXS2UzOXpSSm1OZlJ0OWJsUTgxSWhVOFFOOURZcU9j?=
 =?utf-8?B?cFNXbUNqbU02dW94NFQ2Y0FDK3dJVXUvNnJpNmJuNTFYZlh6VkEzK1o2ajBu?=
 =?utf-8?B?NDJZTmlteGZ0d21HL3piczY4cEl6SVRtMHY4QmlOK3krSVh5eEFLSHE0bHZF?=
 =?utf-8?B?U0lHSHJJcjJML3JwZ1I3QUJFc0tvWXd0MDVDSi9nY1lNb0tXcWoyM2k3cWwv?=
 =?utf-8?B?N0dteW9ka25VeWdTYzFyZnIwN3MrbksrYkFiVVBKWjNiSGtOaHNjMmtEakI2?=
 =?utf-8?B?TG1iZENmaXhSRHFhb1RvU0luQXZJWHZtMk01SEhpM2YzMHdLWis0RnYxajJC?=
 =?utf-8?B?NXMrTHlrNk0zNTQ0WDRDNmFxbm5DaGxVWDYrcnFYMW95ME0rNnRJMjEyeGNE?=
 =?utf-8?B?RGRET0IyaUI4UG1DaFlwS21SRGlFYmo4V05YTEgyS2c0d1lBYldVT29Dd2kv?=
 =?utf-8?B?TjdYNnNmbXRJY1hidDVqSkxBVjhPazlNSDk3MzJrQ045RnlTY3krTDNBZDYx?=
 =?utf-8?B?WHVFUGl6SXBtRm44T1FTY0xJdHZoK1VNeGtWcXg2MlFMaS9zRzUxQ2YvbWww?=
 =?utf-8?B?S1hwQm8vWXF1RlZuNEFpckN2SFpQeTlDNWN2Nm10OFh2ejBJVmpBblFzcnAy?=
 =?utf-8?B?YVVCM1BwQ0o4Z3pySWZLWVNLQjdWTlVSSUUyZG9sQmZ2cEFmY0d6NFdEa2RO?=
 =?utf-8?B?VFROMldmTjZmSmw5NnZCcVUwZ1RUMXMyNUV6ZmliSjJsWjlNVG1oR2hadHla?=
 =?utf-8?B?RWpMYTRtY1BCL09aWTJ0TklLTzhlN2FUVVhoYWFoYlRLYTB3bE1XeUx6d0Fz?=
 =?utf-8?B?TTFxZGxwbWZsM3AvMHhtVDJoVE96ZFVJZjYydVVTK3N2RGlicFRkVnZSR2NF?=
 =?utf-8?B?NDlvUnBGSVhPb096MUl0N0VhNnVuN2RqajVpdjFFRGE1eGdUd2tBM25WSXpt?=
 =?utf-8?B?ZWFQd0E0WjFYekVWczJxYjhkdE9kRXlnRFRPc2RvcU1DL3l1WTFuT2ErZ2Nx?=
 =?utf-8?B?VnA2Q1pwQzIrL0IrZDRhV3B1QzQySjRjdjNiTTZqbVgxaGhXSk1TZlpUVEpJ?=
 =?utf-8?B?dHVEcjdISlk5QXg1VWVVdFlreVJ2TnBMeGdSMnZQTjF1WFZjSmZoNVRTdURu?=
 =?utf-8?B?VjVWbC81c2VCOFJXNzlDQVdPS2NwOUVqMURZT0JRSjVkV0M1VE9Ydk9yRGsy?=
 =?utf-8?B?TXFNbzlqS0xxSnpOOUNtajFock5tbWVGVG1hOXljdlNBWmY5WEFFZFFoWTda?=
 =?utf-8?B?TEFvaHg2cVphaDV4emFmTUNLcXl0Mk94ZGdXL1QvNEZVaHJqY0pZRnZ3VTdn?=
 =?utf-8?B?U2NkT0F5TkhNUStTdXBEOVJtdXM5MHp4SExtQm4wdGZqWVRXS1R5Q2JBc2hS?=
 =?utf-8?B?N2oxdjkvL01rOFZIdExFdHYyVGtzOC9KL2krU3NndGhHM3hYSjRLQkJLRFBK?=
 =?utf-8?B?TWFNL0hQcG9tWXFnQ0N0N2VtM2dGVDFQZVhiMzdwZCs4LzNIYUVwcFBlOFZN?=
 =?utf-8?B?K3ExbW0wOVBtTU5SbVliS1JIQWlXK1QzQ0ZBcXRXTVBDUTdYa21FbmtYdGRW?=
 =?utf-8?Q?cUKGjAB8monUVysgtr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7487a292-723e-49d6-f601-08df3032f95e
X-MS-Exchange-CrossTenant-AuthSource: CHBPR12MB731189.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 11:52:40.1546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qv7GCeyTTOCV/+LWGlNOlTXCVr9+lBYXYBfCDSSIFpAh5pamLXdut1wtWmK5mYUG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9804

On Thu, Oct 22, 2026 at 09:25:55AM +0200, Thomas Hellström wrote:
> > Attachment could also scan existing attachments to preferentially
> > pick matching
> > mapping_types that are compatible with existing attachments, thus
> > avoiding
> > invalidation where possible.
> 
> Current design appears to be that attach only determines the set of
> theoretically possible mapping types, disregarding other attachments. 
> Taking other attachments into account is also problematic because the
> dma-resv lock is not held.

Stating my restriction in a different way, the attach may start with
{ualink, pcie} as options. Then we do the first map and select ualink.

Then we get an invalidation and do a second map. Here we need a way to
change the mapping type options to {ualink}.

The exporter would have to make the memory visible on ualink to
succeed the map.

> Looking at current GPU drivers, what you describe above is typically
> done at pin() time, but if some importers want an early very likely
> decision on what mapping_type to use, one could introduce a separate
> function that match the mapping_types, but that would be very similar
> to the map() function but without returning a sgt/mapping, or a pin()
> without actually pinning. One could reuse the invalidate_mappings()
> callback to indicate the mapping type is no longer valid?

I don't know that anyone needs a very early decision, but mlx5
certainly needs something like the above flow..

Jason
