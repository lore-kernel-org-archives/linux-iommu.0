Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2074.outbound.protection.outlook.com [40.107.102.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A591A286D49
	for <iommu@lists.linux.dev>; Mon, 30 Jun 2025 12:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751288197; cv=fail; b=H6VENy5bE0KgLPQAU9ZpMJRMGMTtf0sqzVPDp9eOfMq6EvQ48xJn1Vi6UQRYcA2yg6efeSs+0PTDCMZPvg8x3h1CJPM76CX/ZpRi0aeHB/g3Tx7aA/Azjzw9Okc8lFVIlsgIEe3w2iOTvL9vqrsY5f9+BTg8hDofW7W9zF2idMM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751288197; c=relaxed/simple;
	bh=DubCqwsc3qlJz4t+BIQtxVj8j1gfJbcqOU1HQIeX//g=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:References:
	 In-Reply-To:MIME-Version; b=EHWmai2+yHOyvvzQI/X0wwvVijs3DpKxowRTq8a4XOV0jPeQrNQkB6rwGwlQzghZbcpCvK7kfhFnGrUcCE8/AsR29zubd85wMhgcKskQe+4PInGfU9iec2FsweLnO/6JnuPRgYU3xHTM3Tnk9yAJk9qm8jNCGjo4BBNJgpt1k1A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AEJ4L6Pk; arc=fail smtp.client-ip=40.107.102.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AEJ4L6Pk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NNFX1tqUloWSLRU5CNgHo8utpXdNrabwsI36sLpZ/lq7n7PsEJ9DaPIvVZeCm9Rc+evGEB9FyDWM1F7LqHDCAhs7KK+L1Dj8t5rjb4EOm5CjafGq9lWVUWDXt0NMoXAGK5Xg09D2EEDw1D7KqxTiScEcFvfZtWDsLA6ULj3Uk7BH7iGOZo+yKWPRR28utfqcb6qFFyYlI+cyQI9GuZleQESwjVu+P6TrzlRv+9ZYfrKELs0NN8knyxxJ4woIpz9lcTc5l3FW2tNvPi5PCksgRSdfYJiL8P76GrWC9nvCcfSmBri0nruPrr16nOpOjVqicd0A/ZcY22tfnUrjVtCYrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DubCqwsc3qlJz4t+BIQtxVj8j1gfJbcqOU1HQIeX//g=;
 b=oAe1aK1d0NMlyO9I1cJAkt4u3mdyohhXUsMX6u0V4foh0VW2scpoBsrffbst5jPOnrveHLOtIe96UooEs0bOxu6MEiH3Tf4t2QVK3ledf3+JmbNizW9glWchuD7hfx6ubZh/jnXFFmVyu7BlY8mb1+4BCBKSFkGUhT0JzdSu96Zg1Ch1K9h33B6kXXv5MP5vRgY0Fx6wTCqCZDgjcIE9zygt8X22wcZjiS10TPdaLeVqkENnyUhdOm5X32/o3RrfFPXtyXlmdRoNpWa638Dozz0RrEdGYunX7wp6CZcSAvWyKS/P5HuHqQyuxYevwE2d1OXs8Y0VLr5kqnvgWJu3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DubCqwsc3qlJz4t+BIQtxVj8j1gfJbcqOU1HQIeX//g=;
 b=AEJ4L6PkaUN8aknBBAxr1xYt2+XCUaA9HGBJI+8AQW+85qDsyZ+LY/oYHjZuc+7u7/bwQwl+4tDM+VJ67QtjzIZ0fJD/0hPeJhVQ6TzKSHE2KY9kNXE4PziGNarGojgkr+riyKCTQlROQt0o/xE6INyKXxhQVoPqb23PXux21j68mixnY7ivVRo8117LGQTlmwoc6c2FjBxbXsDrlW3wXOS7XR7V+PGOTj8c/pMZuhYJTYrzmvWjFreWyPShNLc+6sPSHApntSXGlIqepo+nyIRhaWePwZKrx4PZEnJet2U4QQOvgX4ZOncIO6CqaCAnH4ebzdUkW8OSK8wDd1cOCA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SA1PR12MB8724.namprd12.prod.outlook.com (2603:10b6:806:38b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Mon, 30 Jun
 2025 12:56:32 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::6e37:569f:82ee:3f99%4]) with mapi id 15.20.8880.021; Mon, 30 Jun 2025
 12:56:32 +0000
Content-Type: text/plain; charset=UTF-8
Date: Mon, 30 Jun 2025 21:56:28 +0900
Message-Id: <DAZVUN9N4GBT.38B6BX4CN516F@nvidia.com>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <benno.lossin@proton.me>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Valentin Obst"
 <kernel@valentinobst.de>, "open list" <linux-kernel@vger.kernel.org>,
 "Marek Szyprowski" <m.szyprowski@samsung.com>, "Robin Murphy"
 <robin.murphy@arm.com>, <airlied@redhat.com>,
 <rust-for-linux@vger.kernel.org>, "open list:DMA MAPPING HELPERS"
 <iommu@lists.linux.dev>, "Petr Tesarik" <petr@tesarici.cz>, "Andrew Morton"
 <akpm@linux-foundation.org>, "Herbert Xu" <herbert@gondor.apana.org.au>,
 "Sui Jingfeng" <sui.jingfeng@linux.dev>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Michael Kelley" <mhklinux@outlook.com>
Subject: Re: [PATCH v2 1/2] rust: add initial scatterlist bindings
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, <jgg@ziepe.ca>, <lyude@redhat.com>,
 <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250626203247.816273-1-abdiel.janulgue@gmail.com>
 <20250626203247.816273-2-abdiel.janulgue@gmail.com>
 <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
In-Reply-To: <DAZQ9OGC1648.2WWABTO7A7UU6@nvidia.com>
X-ClientProxiedBy: TYBP286CA0046.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:404:10a::34) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SA1PR12MB8724:EE_
X-MS-Office365-Filtering-Correlation-Id: 6013c3c9-8002-4269-f4ed-08ddb7d58981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aU9MTGF3dm9DU0ZVZkcrMFZ2ZkdhTm5pTXN1amJ5UWtWSXFWeEhKTWhSdHpz?=
 =?utf-8?B?NllMM2cxcnJ0Tlk2VUFGakpJalk5dnJlZ0JHRDZkcnFJUmZESGphajJJTGM4?=
 =?utf-8?B?NHI2MFY0Sk50TU9LZVJtMDZGbDcyd0tScTNUKzd5Umh3Rnd6NmxOSDFlTTlv?=
 =?utf-8?B?REx1dUdGVDVrTlVtOXV4bTJmOEVOUGZMaGdwdDBFc09MMjNMeGlvRmFVVStz?=
 =?utf-8?B?NktVcmVEaVJRZmxlYisxekZGcnIvS1RZczAxeXF6bXAvVUxYWkcxRVAvUGEv?=
 =?utf-8?B?dTdoekxMb0hwdmxycVZwcTJ2T2tzOGI5L2Rtam5lTGtOdCsxamp1emZod0RH?=
 =?utf-8?B?NmtHalpocGgyRUZUZC90SUVGTm5heUJxeGRxcEk0c2FhRkg5S0FvbHlZbjBE?=
 =?utf-8?B?N0QrRWkrTElKVk92S0RKdlhwQWtKYmZBNzArdndWaE45SUViem9TMjY4eUMr?=
 =?utf-8?B?Q1llQlVVOW01REU0ZFBnMjR4YkkyRHVFSTF2ODErVVMyUlFPbnQ0dEc0U0x1?=
 =?utf-8?B?VW1xOGxBdERHbmVoK0ZuR2ZVTWJ2Y3Z3RTU0VS9sdUdLNGo1cExyUEg4eUUv?=
 =?utf-8?B?RzF0ai9DWlQweGNoMUpYNTZ1L244RFVZT004aVgrb0N3Z3FtUFg2dXZNOFU5?=
 =?utf-8?B?cEdVRUttbFpkUlU0Wjd3Nzl4Q1poNFVJT1BYcHJEM2plM1pWTjF3akFSQmJD?=
 =?utf-8?B?VmZDWGRSdVA5dGFEekpKVi81WS8zai9rVDVpT0dFbnVaOCtRZEhiOFhoL3c4?=
 =?utf-8?B?ZjVrTjdNMjZmSjdmcC92ZnVLV3NJUmlCRy8zU3l0TlVpbGM3c0ZHRkFhUkQ2?=
 =?utf-8?B?ZHNEZFQ3WE9LeGdHSU5YdlVhT1pTam0zb0Nhai94cEI4VXQ2SHg4UnlCb1J6?=
 =?utf-8?B?TWdVb3lEakZ3UmNCUHk2Z3lYeUkweXhCTzZ2OXdRRU9TYTdKMWFDZ2pTM3Fy?=
 =?utf-8?B?c1RNL3VlQ0VzK05IRExEejV2VUhlY09mRjh0ZzVCVys0ZkFRREo3bUJncVFi?=
 =?utf-8?B?RW9yR1N1SXZqWVlFcXVLUmtqaWFCK2ZMdzVmNWpoWTQ0MGI1b0p3OURmNThX?=
 =?utf-8?B?Wm5rNDFSYVg1WUNEZmkrN2hjem55QXhDYVFDVVhKbVZvYldrSHlNZm1HWmVu?=
 =?utf-8?B?M0FwdUZvZXlBQ3BQazc3NXluSDFUUjJ2WXN1amJqNldnZWpJbU5kRElUalNG?=
 =?utf-8?B?UHoyT05QUDBzdzVaRmNNWHNyTWhwcVVOcDFrRWRJTlVkazVkTHNiVVpyenZR?=
 =?utf-8?B?VlcyM3A2ckpEVGw0b0w3WFlwcmhIZjUwYTNEK2IyM2xaZHB5KytWMmwyWFNp?=
 =?utf-8?B?QXIzNGFNMVd6SmMvR1FVYjBHSS9FaFdpdml1UStWZG9XQkt1SjRRU2VXb2sv?=
 =?utf-8?B?QXZZb0txd2ZzQ05RLy96SkUyTzdwUEFCdEIvWmVoUTZsRGJIQjdSVU9qT25K?=
 =?utf-8?B?cUpoTDlWZDM5YWU3RGJiSWhFVGdZbjFaTU0zWS9GYnNLUUs1djk5WkI0aGd3?=
 =?utf-8?B?OGJPeDUwOVd5QU5UVnIzUzdSV1VsQXM2N2txWW1tZjl1WmdySnVTb1I1MFpX?=
 =?utf-8?B?VDV0Y2g4VjY1a3FlZzVXU09qVWNrNFEydklHR2k1bGoyTjdkam40aEVPWlYy?=
 =?utf-8?B?b0g2bFE4QU9BN3ZtNGVHR1FkVTdQMjJxOHNXeWFKQXBMOWpHTmJha2lxWHVG?=
 =?utf-8?B?Z1VkRVBWK3dCUHJKb3lpNk0zQVJQTDZzY1dQZGRUdkJQNmxYOWdXRUw2Nmg5?=
 =?utf-8?B?a3Z0L3JLQysvQ240Tzd4Yk85dUp5QTV1MUhNZXdUbE1DN3FZYTdNaHZyVW14?=
 =?utf-8?B?R0ZJUkN0NWN5emFVVzZlT28zVHRlclRaK1BTRHZtV0toV01JYW5FblRjY0Nk?=
 =?utf-8?B?dVZNN09NMUtOVG92cTZCbGFYOFJaWlVQd1JLQlNBRjB6U3I1ODROYzY2Rzkz?=
 =?utf-8?Q?uTnqXeaPOaY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB3990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aW9XTTVvdlVBT0dDUEttSXZIaFg1cmJBMm1KaE44YkdlOG9UUmdrMS8zSWk3?=
 =?utf-8?B?NTFmMzV6QXBuYUhWMzJYejc3N1h2ckVhOHFhN3J0MXc3ZlE5VVFheWsyWWFp?=
 =?utf-8?B?eXltSitTc2xzdndBNDcybnc5RGhJV2Nxdm1vQ1AzU0tSZTN4UGoxYnVKOEwx?=
 =?utf-8?B?Snp5d3RKV1ljRlRBdjVVdk1TL09UMTMvcWpuTGR6MEVkc1pIbGNNY1IzWHBa?=
 =?utf-8?B?YzRNVkpGdTMvS3Yrd3lDaXBmSU8xU2JuL1c5djlOWFQzcis3cnFrSEhoOTFP?=
 =?utf-8?B?YWNoaFRIcUgzR1hGbFdPeGlEWjhSaW5iOUN1WkY0eXFLcitIN3lIcmtLcjhP?=
 =?utf-8?B?cWUvL0RZQWNSK3dqN3E3NHhVK3UxdmFnWURINElVSGFHNlorbXNZUTR5K01y?=
 =?utf-8?B?ZFhYZzV0Y3p6Wnd4NmtZek1BazBHV0VnNGtEQitWNEcwc2lZZnpzbXh1Nk1F?=
 =?utf-8?B?U1pIb2F6MVgvRWNjMmIwczlGbCsvTzg4bXlMZk1XTStlTXNtY25Iak9BQUx2?=
 =?utf-8?B?TlRvck5ZRnRIMTkyZ1ZnQVRNL1daQjBLdm96QmZjS1FYdFVyaTlpYjNzdWtI?=
 =?utf-8?B?SVZZVkV2dnVjaTFVenVDMzVZcGg1dStYbjhZTFZrZVhFdFBicFpYb1pOWmta?=
 =?utf-8?B?UDdxYlVQRTBwanZ2U09sV2swQ21TMW5tOG1mMXZ4MWJBanZETUV5TW9qVUR6?=
 =?utf-8?B?d0xraUsrdHBDbWtQQ0FmTEdUWHVkMnN4cHNsS29DdzBVVlYzaklJbktNeUZa?=
 =?utf-8?B?NzkwNHcvQXkwdUFKY01lcHFudUJMd2o4Q01lV041L1p0Q1kra2pva3pmaG1a?=
 =?utf-8?B?WWdqUm1ZRjVkcjcwOUZHNnhNc0ZNdG5LNG00c1M0cmpUY1NLSlpFN3RTd3lL?=
 =?utf-8?B?ZWtydmJkNHRIRVdTS0FCTXZZS0pDb2hZK21waHdpVllOMzNtY29XZXY0Z2xn?=
 =?utf-8?B?V3UzcDFoaE4xcmErWTVwdXJsUmZYc0QrVUxZYVg2ZTlnQXl1eW03cmV2aUhR?=
 =?utf-8?B?SWJWcG40b2haSi9qT3dQMGV6WnUxVUJnL2htb3RPbmlrWGRxY3dvYmVJbVZD?=
 =?utf-8?B?SW01YmpuMlJhZlU2ZmFQK0pYZk1PcG0yaGVwTTg0S0VDYmx2RmFsTXNlY1I3?=
 =?utf-8?B?MG54QXBFanBTZldEbWJrajh1ang1bUQ4ZkplU1VtY3dnR2ZyeFFUWDlkV21Z?=
 =?utf-8?B?ZjUvVTkvOHJjbWJhRUhjR1RpNDlidEt5UUhjOWJMN3VZbm5qc3NjY08xaW4v?=
 =?utf-8?B?NDFMUkxSZXQ4cjZhRnZUeWVnamlKSUEzelBoSmc5bk1OK1pnTW40NTNEOGw4?=
 =?utf-8?B?T1FBNjcwR3ZQeGtZcndZV05oTTBSb3JpWThzSVJUaUJjeUZPYUlMRXJqYUZn?=
 =?utf-8?B?UmxGYUhvN3dGdmxBVkVib3RTL0FITnFqak1PcDBSbDZPaUR5c3VteFV1RGtE?=
 =?utf-8?B?SUpFeXdpanNnRWZqTGtkUE1WNElNak9SL09sSXVwRnFzQ2t5VlU3ZlJ2OU5r?=
 =?utf-8?B?WGQwZFNPQzQyaDZiVnBZc3JpeElOLzg1WEtyNFFpNVY0NVRNb2RwRzdFcEMx?=
 =?utf-8?B?MDVaWnNjWXB4VldndFA3Q01jT01oUlJwTHFvamgxcWlDRlRVYndERWxGT0po?=
 =?utf-8?B?VlNxL0M4MktGUzFRaTJTUS9pVVlHa2x4U1dVbWlDZXVnYWx6MG9yalB2cTVB?=
 =?utf-8?B?T1g4OHY2S3pLaXRyQkt4RWxEVFpzRlZaZ3NqYWVpaXloYXRZVTFmbm9IUDlq?=
 =?utf-8?B?TngzZjkzQ09JZ3FFeng2UWJyQS9nVVYxYXBITEl0dHVLOGFzQ0Fnb2twa3BE?=
 =?utf-8?B?ZFNlcFMwbXZnaHpONXJwTm5qbFhMU3FlYkR0VC9PYmgrQUt3alZtalVJdUd2?=
 =?utf-8?B?VnNndUN2UGhtQnlFRVVySytWZVZxaVJXSmlTSjgreEN3bGJFMUFQZlN2TFYr?=
 =?utf-8?B?dGhXelIxRVkvNm5ONjl4dU9BdndSVHpJamFSNzEvNVdFS25BaVRNbU5DOGhZ?=
 =?utf-8?B?NDJ4VTl5OWlzMG5JYjl1bzZ5UE1YTnVDZDFmZjMwZm92bmIwclhxei9pSFlN?=
 =?utf-8?B?ODMrK2tEbUNObFdKcCs1K1Y1VUR1YWV1YjIwd2dwR3ZqU1pIOXlyd3E3cUVD?=
 =?utf-8?B?UTN6RnVzSUFrWko1TFJBZVFpeG84K3Y1UUhLNGZaQzBsdjJEUldHSmVJdS9r?=
 =?utf-8?Q?2Ul9dgG/GBGxGuOW3ws6rPNlR4ayELDPk6fyKmYbky0V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6013c3c9-8002-4269-f4ed-08ddb7d58981
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 12:56:32.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bb58A3K54JdcG2eg19VOMoOvMtwuE2dX2iIbAhbYW1p2bLHnF4RgjzyqQ2aw0QH2HxcI+J8FAzTEG+WR37nA5A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8724

On Mon Jun 30, 2025 at 5:34 PM JST, Alexandre Courbot wrote:
> I actually have some more comments, but I'd like to understasnd first
> why you decided to drop the typestate. If there is no good reason, I
> think I can provide a more detailed explanation about the design I had
> in mind when thinking about Lyude's usecase - basically, a two-stages
> typestate SGTable type where the first stage is unsafe, but the second
> one leverages SGTablePages and is safe. But going into that explanation
> now would be pointless if the typestate cannot be used for some reason.

After thinking some more about it, I think I can verbalize better my
expectations for this interface (and my problems with this version):

Basically, I believe we should (and can) only need unsafe methods when
using one of the constructors for a SG table. Once the SG table object
is built, nothing in the interface should need to be unsafe, and we
should have access to exactly the features that are safe to use
according to the construction-time invariants. This implies that we have
several constructors, and several types for SG tables - possibly
typestates or completely distinct types as you did in this version.

I wrote a bit of test code trying to match both the requirements of GEM
SHMEM objects (work with an already-existing `sg_table`), and of owned
SG tables ; and I *think* I got something that works by leveraging
`Borrow`. Let me clean up my code after a good night of sleep and I'll
try to elaborate a bit.
