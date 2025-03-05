Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E1419F438
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 19:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741202996; cv=fail; b=HKTHvY0qrvFNu+HJm/bpyzr6PP7wiEv+JEQuxJow+0AE1c+b6biTRrhd6DZXNQcmznPjmix7N9meECILQW+kuHsFwqYRYq6LMjy+HazIwwSJNaDsyMVsScUFSIO2TJZw9iTFhNgzqnm9ovVUvrRxBQJtnJyMvck/i4BgYtXGrqc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741202996; c=relaxed/simple;
	bh=B3cvYi8v82/b1k+8T3awon9M2TxcwyemCI9bEQ9SQw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ObZogxSiNrbRFuE45dcaBlhvtFry7imEDh5pTXxGlfvFZvRCKh4FmZ5ZMZqqjXVKo5a+WBqw/sPF6cl9zC92HucFO3dXgAWZKBipjRT8ypDBUhnb8GEK1tUGjOwClgwUDaE2KS4rVHYoP8M/CzsP/EUpddQ0RKajaA4R8kEk4dI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lhE8fjC0; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lhE8fjC0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abyGwFz4maN8E4Kq3KeVkiRwIYmrZleKVD+Qvt0f8sSzn2klawWPQwVeHFKVwLeq6k9yg+jIOQIQXf1gCMqMLpmIPAkK7nYnK/4wkFz0gyRtr2u9d+EqG1cS3MY3rbzQEVB/7Yvp1obCWbJQqkUuhdAEWgLqcEtL1xqxrxc5fnRDAnK7GIAbc8cX/wgGxNYyfO0n8IxrMwDeGeAIf0WRx0PvbMRGyzp2/1Q77Qxj+MB3Wtc3wmrcsZd+DTOjc4/grieUetwoKr5xDB/wVcFYYFxz2IkOncVJKpqKan3wC6vk2wZhWjxoPKU0PgOuIMMLP+e90nErxmUf1QFooWu5Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9fhe+iq5MNQnYd+Q+WEAREYOMcvtyPkhZmXSGknjpo=;
 b=UtMgtzi4AvXH5q6PMPtP6HtlkeVhXrf6FMDaq71kMn7BoEV9TVvojGl0dBBys3b5AURYz0RvH59/rDkpmyE2+7Aw4AvixToRWbgfxcrpnYj76my+2gzvx3S+7ICDnqDxNvsqwz0NS7223RWDpQ6kJAIL7QnOFONnx+00F8QX73zqYPtOoTgTqMmnQJ9FoRfqeSrDFuQpbID5ksX142vm6gTf1YO87Ts4IXNtGbUSy01qZBYXxDfEPP1ZL61dhJya+ngrJJcQiNgCob269YAdWDHrl/BXOXCWVDGkwdIx8jOL3VHbhwP70ejHb2qnlWZr9SMXKiXFAiYXbNRBxLTTvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9fhe+iq5MNQnYd+Q+WEAREYOMcvtyPkhZmXSGknjpo=;
 b=lhE8fjC0SkFLbq/EPY8sOavULne8MQa64awZzN9bwPjmfGNBxx/g9PcBFUMB5Ob/BP6TPeNSKLJcijVFqQY3Q3c8bWF900tRjNlxQ/4GbZtLCwTbZGP21igWyVEp+z2jGbGkbwxsC0N1kuKrjJes4yxAhxZ2YH7tg9eYRFsjJk8ajMQPPaAjeMA7C0HAUzkF+xg7PvEKM7J+oxJIKpe1u2JPzq+YtxupkuZzLWaHskHxuaz3n+iN2TN3OHXpBI/VLlzmd9eUYhBcFrX0jYFLQqWbhZlB9sU7Y5cBDl6svlY29cbIBtz01jpZCDG2vjI56nk2iV2FPj6knnbCAjNm3Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by MW3PR12MB4442.namprd12.prod.outlook.com (2603:10b6:303:55::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.17; Wed, 5 Mar
 2025 19:29:51 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8511.017; Wed, 5 Mar 2025
 19:29:51 +0000
Date: Wed, 5 Mar 2025 15:29:50 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu
 instead of s2_parent
Message-ID: <20250305192950.GA354511@nvidia.com>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <20250305165452.GY133783@nvidia.com>
 <Z8iWqOBga8Xdunac@Asurada-Nvidia>
 <20250305183151.GE133783@nvidia.com>
 <Z8idOr67A0EG1/PN@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8idOr67A0EG1/PN@Asurada-Nvidia>
X-ClientProxiedBy: BL0PR02CA0070.namprd02.prod.outlook.com
 (2603:10b6:207:3d::47) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|MW3PR12MB4442:EE_
X-MS-Office365-Filtering-Correlation-Id: ac63929f-335a-4c19-6411-08dd5c1c1936
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2gzgAsU3oLF7kjwzXrUO5iNOdiE2SCLdYbM2vZjpTjTSpGO4X5JCMEJUaAEF?=
 =?us-ascii?Q?VErnRqOK5sZ41vKv6jdr3/5Y7keBi/uHDWCHnvDVYwjso4sqBKTgGsqHCfQF?=
 =?us-ascii?Q?RTABY5jFv7xBTZoTutXVk+UOFWMp7/v52NwTzWzTasw8hRiSWrI4L7O/Db9X?=
 =?us-ascii?Q?VEI+XRqyuFXAVyb5Oo8lQ4URHB0yF/u99cUM+dzKy1IzH4CfaWUL7VEfy/IN?=
 =?us-ascii?Q?+/1HXYEkXdN8X2PMfBH8/17bbP9NQfCQws9QcG8pDGHK0+hCbtJ9rXAfryw2?=
 =?us-ascii?Q?Nz8Q5QAXPOLyo8urSIcALdHo3n99BDZXnyRmxsed/BZI14nvuONUoAoHTCo9?=
 =?us-ascii?Q?iS3IjaWbprOFdnQbeL+eHjtUkhvNTdxXcG6NOg8u5LFYri+FIPaP8n3Z58UH?=
 =?us-ascii?Q?J0ahUY/M6+w/qgDajGAYa3IAco/uTZO4YuqIDQtIzQVpn8RNKiBWRzKA1M/c?=
 =?us-ascii?Q?FMVPHB3QK7h2aJiE+3q5ODz4fpW/y9YQXIpwSh7K6wrGPtHKFJs6NZVBJaRg?=
 =?us-ascii?Q?mJjG7ILdCiN6cHoWP3DJA2WOlvaMdZ5umiRTdaHS1GvXtB/sevyOqQT1xobk?=
 =?us-ascii?Q?KrLh/Wre3S+E8MldV5ZLfjbdojfAS0Ta0/JnE4Y2WAruxQvwD6NnW66Eefj2?=
 =?us-ascii?Q?+PTOsytx5U+o3+sX+39zF8fXEzHiJ5C2Slb3FrMxBL67w4PDoywEy9dRYFDd?=
 =?us-ascii?Q?lSgTM6JpRD92jWHLpbY7P0gyc+35Nb8pgBNJ9b4BZUq2hksK6gOnUUKIZZTf?=
 =?us-ascii?Q?7RilgJsNWUn+hAx7ZI4HUJa/8+mQRlupf20xqr8ncXwPqW5cRQ6TfHzcAPDp?=
 =?us-ascii?Q?Zfb45c/0p/Djcsg9aDivKlLyHPaBwbjrSKmKgg4dl90XdoFzPA9/OWRKPveL?=
 =?us-ascii?Q?KwgIYGpTFwKLL3FCwPotoBSN70DgmDyOMLVxhVkz0YtvVaOLIaodf8zQSz6F?=
 =?us-ascii?Q?OdkaTvinTXakoBMjwdwttQMjk2W05NCrXdOxG4eNo78rtTR2/G+bN4R4EsBi?=
 =?us-ascii?Q?n8A/4FH6MfnnfA7YkWMGcUiqFYZMeiucXomksfzfT1hkMM59fm171Iizyidx?=
 =?us-ascii?Q?TjHaR7+0SdKH6BoayjlIbTz9p7JIixma3D8WYKIaz+XEJUt8VcTuNes05JDC?=
 =?us-ascii?Q?/oSwheoy9AwKpAm7AEAT9+wUWASdJT7uv28cKSD0EzoWz71p4d7AMdzycAYn?=
 =?us-ascii?Q?Zfmef5iXQxNzZ5D4KSRYeGKzkKF09+RU0imlGcOz7E07GnO+WdB9R3NgJwJ3?=
 =?us-ascii?Q?+jPmc5UVFANJ7K54jv1uN7kUnXmq/0RZitaCMwB7++yK3HAV3IxZRDvR0sQi?=
 =?us-ascii?Q?b42scWOpUgGKl6C8MeHcp8Jj7/6e+WRqqFHC7hyVgG3ywy7XlmFVp6NFsKHG?=
 =?us-ascii?Q?Xp9mOeokucKcSrQ8lfDVsvst+vrb?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6ztApsXILw9hc/PMq849MXKz7VNYec+KCJG7vEB9e8YlMvBXFboAC731F+Uf?=
 =?us-ascii?Q?Q89t1T9AWyS+IK7Hdmkz5StmHNXfIKZtjIEUWV9YivfLyF5NC8QtrAn8+uGb?=
 =?us-ascii?Q?sjGiP4Z1tepVjx5Y83aSe8g2L6SoV6YQPlEzAe/zVwXlrIhYzYPpNf7R85rC?=
 =?us-ascii?Q?SFHffo3+3UY+xQ5FCIGs1vjHIOaH5Zre5qE5PYo/isckklQ001LUtpoyB5Jw?=
 =?us-ascii?Q?rAQ2UuSFO7wSPTDPOSK3+1a3BGUQaQ7QzOWD5Pctzb/ojwg9SLIdcJBkDz5d?=
 =?us-ascii?Q?z22VHF2VOTiczDa3xFfOrOF+Y6C7hCqQPanwdIUYfvcl8bcIjtR0hT2t63GW?=
 =?us-ascii?Q?7lahZ2hqiJkMRtz3nFZqS5GuhSAxfnhtN9KdHqEUGqzWRnuT3C1AnXg8jO9Z?=
 =?us-ascii?Q?lTaSmlMtz+PdTRlSyOBDqFlaAkIMDRv9dI4Cw0677Kic3Wqv2J3cuAzKaWg4?=
 =?us-ascii?Q?wgWxmtLKdFU09cbk0JWlhgk1vZbfWfvSAZw6obtycCt96Fz23kSRTbWvq4f5?=
 =?us-ascii?Q?64Dr6ZtGBvZ2d6R+DymMajsId1a1R72sdresBZZOhXMdofY2DyvFSBwIulbB?=
 =?us-ascii?Q?OEeXdjbnGEhDu6nWFt3b+PEmbfUfFC0893e3/HtamcSpziU7On6hbBIa+EhQ?=
 =?us-ascii?Q?n8zxnX67wD+1N0BRHhaYa+7Gqj/wR6h51VaDk3t4SA1NOtF06CrN2ia8ACu2?=
 =?us-ascii?Q?5TVScsVrf5Hq3oEJtJzvWQ2jjbQisKMlCvWnLLkt2dbIeWZwV05Oq0LD2TM+?=
 =?us-ascii?Q?Mh8QklopT4rTWO+imIjM9AdwXPsZVXMTMtXtwIR72w7OFIdz81KcpceXqwkn?=
 =?us-ascii?Q?QcIeNgS3AStAjoCJYDI6E5+2uihWS9EWg1edm/cn4P9HQjJNEYZhJDmA35Hs?=
 =?us-ascii?Q?nMtRhHDHnMFgQ4DMWjQLKqUEab3FBWRHXsijnImmQtIbHBFHN96Q/ioZUmbE?=
 =?us-ascii?Q?ZCpsu9AzZw8XKaR8/8jklCPr5X9O64b7ao16k/EowY+yIxhqIvs2sZgeswPm?=
 =?us-ascii?Q?vrW8Nl/cujep2x4A8EG4PXWuDUN6Yi9qszzlxYhHaaa6MpMxtCLREq5Ripcs?=
 =?us-ascii?Q?ulHCPSAxEhqBkpLQSUAV7wGHuZmYBRhoeqVnSh4cUAFFDwhUS9nwG70fK7Dv?=
 =?us-ascii?Q?VZZ27+i+bU2ewahdOl6ZqDJ/1IzciCFeEM5aWP4CoTcff47au71RfSdktlts?=
 =?us-ascii?Q?U19zGpWwgwNymurVbFNjt8f7xPkhhy8zbSIyakeS7eS0rWWcOeJxehJWpBlw?=
 =?us-ascii?Q?P10HbJok3odKIKOKaoxWsHIATGl/o1R2e15O3ePndJU4V3FMXwUsp2TKQ+zo?=
 =?us-ascii?Q?gdq5UJDX2rxu7boet5jx8+8d1DEeW6b3qrnPM89MWa+b+OqKc1TFOXwXHpbF?=
 =?us-ascii?Q?Itf8j+kcItpfrvKLwIOYxSR/qM7+/59CPWSgRHmlYM0wSrMOdNW3dUvb2Eni?=
 =?us-ascii?Q?k6PU0m5KPh6i8SYHSuSCn7qf1KmI4+EmkUmkV6bDZv/hfAFEY0b7Wlls4oZc?=
 =?us-ascii?Q?7C+0KCtf8SuwLnaQt8WAPrIrhTDPDigl/DvQyBNiVH/6ojg5m3BaRWnRItt6?=
 =?us-ascii?Q?8D4IMkHuW11zhZhpyAo=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac63929f-335a-4c19-6411-08dd5c1c1936
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:29:51.0017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p+YtqNB3Sy/dnp2pdxmEXc50N+lQiSSwRxJYWgnJYESBAHHDrQMpIz0QFPWBtmIV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4442

On Wed, Mar 05, 2025 at 10:51:38AM -0800, Nicolin Chen wrote:

> > I mean a normal S2 domain attaching to multiple devices on multiple
> > instances.
> 
> Oh, I haven't thought about a !nest_parent S2 case.
> 
> A nest_parent case will not allow devices to attach the S2 but
> always to a proxy nested S1 as we discussed previously. So, I
> think the implementation could be very different?

It could, and that is what you show here

But also, it could be the same implementation.

Jason
