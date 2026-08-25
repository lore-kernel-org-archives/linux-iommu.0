Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6903D79F1
	for <iommu@lists.linux.dev>; Tue, 25 Aug 2026 20:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787689027; cv=fail; b=UJRoIzgFjoB+e39rLUf2ha8Q3B/X7+rqAeRAKwIxqPWGZK9Uz6L58Fxw6Qs57OgATjz5/hsoMPxWT26PZU1mxdOZpaEwK2LuVaelDuT6JISMHjHwWeInx3DGwTsMGEskl+6BwJuXpqHDiy+tMdT6k4ZbfUIrKHzclDDRLqxStVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787689027; c=relaxed/simple;
	bh=HLg6NtVXcSboyGwFfPhDM3Tv988k5ElTjkRmGy41h2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XFnQUT8dKFFG4ADguHeQ0UwjQdH+oZ1vIQEqltDQl/aWe0NIx696HUtSThr2yrTblC7b0Tph1GWlbheE8ZgYZNjnV+eKLHyEn+SZqU7z8SKjpFRH/biGWPmi0y7+PvoSYt4lLE6VRT2b0NyIGTxV3ZnyaDDX2aoGUr4k4Btxo3w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p08Txfus; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p08Txfus"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dorCrtluVKOk8oBkEQCN0A5XqTVcZAyHxTKkOsmGLI/RFFp9g81Y/id6Ze17JFGuZ2p7C3yTjQ9PC9onSIVexhvhqt24kucqVMDxJClHpxmO9yZkauX4TxL5kda0upG5MU7Uufzlhwcm3pLRFwtT+F2vFwLrTUPFacpr36iRlZBRkUcZI3OsGjtayVz8O4L4PPrbhFA2OrOVeS/Jg2PbWRdDR+SjRYa2g0uHl1GZ6n3JNbjY4R3Fm09QaBLU7ol1f6fvFqluXP5C+SsbgpTpXeCMhRMgpnuaXYP/cVA0rqscX0oO/C0P4K8Qb9+ABJLRu1X08iIEpz7QJPD07JfMew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RlBLqLN7PZPbaq0vvMQPGIEKFry+yToA8785sU2qdgY=;
 b=VAHtTmPWd12AoYgYjT7ySi8HQoxJLiz/26zqg+uWmlGoG84lINtBFixnjCpk1CPedf9miqu8kZeJ+eEBK3+EnN0U5abhG0XzJRHfvSwGG86iDHtTMOFaLjDRRilZRtuPEHA33UhxXZTaY32N9+8o/bhUxFzmSRmWdVkngYzai9aUfRkSXN0QGfOIvHXbeGzzNAvrrops+0Z6O0iOmuL0DgpdVU/YwS7eLOR6njmKFYSFgJSKS2+OyB2Bbjh9/QlMVGvlEut+kedYpNh2/Ra2OMx6SBnelPtwhQhICCi+MmDcuj8dgK66JGGUEgWoNBm5o/ZCHHAoSVVTJsc/X3CNbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RlBLqLN7PZPbaq0vvMQPGIEKFry+yToA8785sU2qdgY=;
 b=p08TxfusYL1SZ+dxn0vG1l8eIfTuIG/oHomL7PrewvQkOYHuGxLHQ02sZHG8AlRtaplKSPWJRGGsA5UhIaHpzR0dyh0fv+xUAVTyD55WY8R5/zrG93UPOA+CzwHGLt37g0MuqhxujS5YfxLOa8Ss3okXBvhOMwXt2hDxRUeTXi7cTL8dH+/P+gDhoLIm3FGlQ/yMK95s+qwnrZKcyAl5+RffNhOn+9hARK/D/zByo/A0ntps5sVewapHCd1IhTrfq5HiZ1ndfzKEOiHy5pJDaTfFBPqLn2dny9zbFqYDztkTT1TX/Lklj2u+rfkMv08Ka5hhxv+4jMzqvD0Gqf3PKA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9757.namprd12.prod.outlook.com (2603:10b6:408:2ed::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 20:17:02 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Tue, 25 Aug 2026
 20:17:02 +0000
Date: Tue, 25 Aug 2026 17:17:01 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Daniel Mentz <danielmentz@google.com>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v9 09/12] iommu/arm-smmu-v3: Implement pm_runtime &
 system sleep ops
Message-ID: <20260825201701.GG3325090@nvidia.com>
References: <20260728210928.1050849-1-praan@google.com>
 <20260728210928.1050849-10-praan@google.com>
 <178767577113.3356902.28128835506777632.b4-review@b4>
 <ao3kxwbwB9GC3EOM@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ao3kxwbwB9GC3EOM@google.com>
X-ClientProxiedBy: CH0PR08CA0029.namprd08.prod.outlook.com
 (2603:10b6:610:33::34) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 6efadba9-e733-41d3-9300-08df02e5d348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|6133799003|4143699003|11063799006|10067099003|56012099006|5023799004|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	EzwW3cEkDNb9uWZym9Gj7uug6Q0gEpxEXFlaN3xtoa6gL5A3TSsa1JByv/tbsVR96nSXlh/O00N+gZVkbYy+qs9lxr5KdIYFWdpgCWHE1JjgWSHo/h28vppbelOc14CaqlQ49MKN5+G87r9w+R9jAcre1fid/FXsw1O7wRAOIQiBiFctU7jDUP5Gv3c+iELUJpprJLq0XdG1XnoNz7lC01G1TDz5Lnxuwtw7y0aOQX55V/Vh62zltakvjRtnDZ3AApAeJPkdNrzYwiBIj0oV/cAovs4XdE4eBbOZsyx18lihqHYlwb1ZM0bT+tbj68+EleLtMF2mByBwVEUbBIdX0BkkmqpleiXnqzqg/EUTyVZLj7osrkCyo2xhBcytDn5aHXhvJju9MrE7tBfmrvPsLpAEPdUEMe1Gu6DObYs1r6RMBtMHZ0U8ywRunB8Abe0O+KhKAoOmjmWdr/FaNkWz1LtzoNGZJjeyO6mXnA1wT5Fz9Wp8Csqi4Ar302l1UFJdVki4nLCGtXHMv+Tlwo13/t0q6MUh7w/7ZFJeoZ5WB9C/Sjzd+PNPzS/fxEYd+EJnAFRQFt3sD7ZulUdr8lpyFacmVTszNIYkS3Bzzinf7go6HGT9SYEct6axBYMeuFFP81+EKXV0J/upQ2nuaTAR7wseKtveGiqFQrwguQ9GSQg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(4143699003)(11063799006)(10067099003)(56012099006)(5023799004)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AFAuQVJCKxnJH2/lUfulCzN9m7vJp/Zo4Rfz1FxlM5m87la8CVDTOUOD05Ab?=
 =?us-ascii?Q?c9nO03fIpmHCxzdfY/+miQEDAlyTx0tVS504rqYu/EKNnk6631m86M/3KskG?=
 =?us-ascii?Q?IQH9dKmZYW+Mb2q4P/mEAVnbsTdVT+D41IJEWuCbW0FUHDHg97H1hY7mxvbf?=
 =?us-ascii?Q?F6cTcjGbsbHAkUxaTSpJUmwPA/Qy9hBahfoMbLuN1/mSFcXdIzCfZNx0XvHw?=
 =?us-ascii?Q?tH5S/kCL8imTesloI+Nhk+kVOaBwvM3CVhCSJPUQvlDUOvX9i1QJCgh8Tzcy?=
 =?us-ascii?Q?4yUem5FGcdjwpaDk5UZ+LNpE63BS3gCpjUGtDUnwL/vi/M9XMqRFoYQo3yec?=
 =?us-ascii?Q?uyl4ey+hRghr0ZKfeCXWmNzTNuLdwe/9NTCPw6DdVjgzq7zwbvpp9+Q+t/rD?=
 =?us-ascii?Q?6Gqgrrpe1P7RhjTUYExzJIWx2cgDodzHW7/Z7L6m66oMRcJgVaRyU8ue1Gzx?=
 =?us-ascii?Q?vDohDu11zotBqXTCCKuLZtVpZejmBsNKUsO47GlaPBoozxSSaVzuUsNvne7Y?=
 =?us-ascii?Q?ECwqSf2a1OX1UElINb0EmcYKJrdwA+4GSHf44On2FlXr0A/iaFi8We2s241r?=
 =?us-ascii?Q?xnL8gXUHWU/lIm2QKXcQ86T2BLr8ljf53E8AYmgh/2k5wGjRXTqh5jGL38A+?=
 =?us-ascii?Q?2XjuwlIJVjaXB0w6PNCyt7h5BFxSsGSTarZyl8qK94ih0YYN0YqosYJ3558/?=
 =?us-ascii?Q?jD1VRo6rgiOO6ObHfWInjO5ChRBDEPxJ2YiVujll1vW0B+RJZKJ/rwaZg+g0?=
 =?us-ascii?Q?9hU7nw6v4T1yoVQVG1/BkKBFc8qCcTjceQ+/WBFL3VRqpQjxv//Byp4t0Flp?=
 =?us-ascii?Q?c9XnMXctCWuZ2dl0185NaF+Nf7ZVwIIj8o8KG3a8drMsm7zVgMCHP+LGYxp4?=
 =?us-ascii?Q?H1AyyVAlYzEOZs7VfwEBrQ8pRbQXVS4NpJjahvnKlwTgHnzhC98phiEG0k+k?=
 =?us-ascii?Q?XQbW6miff7odNcC/XQ3WpJtlRGaKiqKcxNYURiyTUu6YhL8yyD7hhAZIujW9?=
 =?us-ascii?Q?xepuRn+66mremkpZg3t85rTsWYidqifyI1jPmOV6iEZlpnhkmWxP5C3h8plp?=
 =?us-ascii?Q?O7X4GlGvTsBjRJumPaFGA10kERMqG9+o6n/Sa+OXAbMolHkP17p8HqmoVQ0D?=
 =?us-ascii?Q?dqXwf//KRMtBp8ZozHsHHqQU5vwETbSE4owtLsaXEZzHGONnUM60paMYo5yD?=
 =?us-ascii?Q?FPe97r/mgTYOanuL8m1WvAzx/+5VtaAqR9Med7uGjUf/eMfX5DVJXOfI5/A4?=
 =?us-ascii?Q?6q946MsD+8xKeZm5aZlAZfbTbvScEhbJfn4VKsG4Qk/ggMq0jjGJXVqtyiN3?=
 =?us-ascii?Q?/YTQO5kQYfHo2l7ERqn7MMQvzeEyCtszLn2fzqLXMOjHfnyoh4J6C2J+rAuE?=
 =?us-ascii?Q?6ccBcIoZ3kdisCrNNrGn4AIn5R9OotMdPsoUr7GqiV4Ji+IwAY7k4IZ2+xm0?=
 =?us-ascii?Q?julQFc4fUMU+QR8bS78k+/BVDB5rS9gZJnWFTbxxEBYdQMRvqe0R4r4uF/BL?=
 =?us-ascii?Q?W9/K4sVwgTWXhCi0ET+RNZS1yBqwtqY4lIH/1ptnPGWbeh+IymDdJ3PoqJuP?=
 =?us-ascii?Q?NHCzpNi9dAaJBcJZFl/xOAcgMX3upT2DezYnfuR5aoQuyBfllgZR81K4wPoT?=
 =?us-ascii?Q?AD4v+zmQk7KcQC4Jjt9kk43oRU5Pv7Kjs3x95VBbUMHGucDtDVeWewNT4nLf?=
 =?us-ascii?Q?DztH1pkOhtu8KYyLhisr46707R3AKXNdBRHz7TmE1ruyOVh1?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6efadba9-e733-41d3-9300-08df02e5d348
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 20:17:02.7625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: icwyVQXCsasHuomEaOh63QBOEuoq45JMmj9KSuHOC2odxtQGBa4xym48aR5fMW6U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9757

On Tue, Aug 25, 2026 at 06:53:59PM +0000, Pranjal Shrivastava wrote:

> > I agree.. I think there are only two options?
> >  1) After GBPA=Abort ATS requests are blocked, so you could full
> >     invalidate all the device ATC's and now it is safe to ignore
> >     ATC_INV
> >  2) Just don't perform suspend once ATS is activated
> 
> This is a little tricky, I'm leaning towards 1) since edge devices can
> have ATS enabled

Oh really? Surprising..

> However, the EP might've entered it's low power state by the time we 
> reach smmu's suspend. I'm not sure if we should be waking up the EP for
> ATC INV All (or if it would even wake up in such a case?)

Is its power down explicit? Could the PM stuff trigger wiping the ATC
and blocking DMA for a single device before allowing it to power down?

Jason
