Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C6480BFC
	for <iommu@lists.linux.dev>; Mon, 29 Jul 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722277025; cv=fail; b=GSEd1rAkPEIcOwvijRP7aVU4g6VD3FEuLkbXEcGwntIWlQHaTZyoXFNdyQ1ZQRyCgB8mXajwalnImgrA4+jIIVeKJYjp6bxPxlFQsN00+rxzcdahOj2/9T7wwoxKBF0bdEqCZMvh8n/5P79ng0NRM7rwSwB6dP39FYwxhO9rkvE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722277025; c=relaxed/simple;
	bh=L3ZO82k4NwYivujpBL6Nn4BwXITKCeibwGEFMH+6cjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BRUQxiOEFmQw2QDJcpasXxuJt5kK3YOqRrbr4x+2yoJkvlZK/4k/kvu9GYqEbQp13coTl+C65s0QscFnWhJDJBM4hHuDbufz/IDWWwISJWGrXxZwMNymuZbQ+xmn35DvHZ3/3CqfXgreOSUPE//3hIFKWz1C+SeUVnu/09GXmxw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Rd7A25DV; arc=fail smtp.client-ip=40.107.243.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Rd7A25DV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kEHMW3TkO7Y9znthuvGUwbNT9CDq6fCi6jYybPTxx2unazcrZjO4JRSWKGHLfVOkJfjoTTzTRn4dFvSaB4oi2A+PGcLUEq6vx3Y1aH/d8RQRytPTFBgvZMs0pHxfs67sQbPT7RZKMOGvh3neqHSDopFUwCzR2HBtYmOWYg+dLlO1nCfsbtEIX5CQdw/h5TpqWw4SJJnxFUhcWV2w/X6UELnU5xd55su+w9tUtfP9uYe/fDgQ58wplDNcBv+/Ht4W28SeMVbxJuwhSdxoUqqV3/j6mPKwWzGWP9qGJsrz31cSZUf/DRjOBlWSKNnEwlejWTgBjSano6RbxkzgCKWTEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwAxtPuIc+vKFCIg9t+rd+ZlOG8zhC1Fi1gPnXON8dk=;
 b=nQLMdj+/EAwItVLNDfQdiw62ti+HoULE9oZ4aAA29u0syFYWxeS1jVCOBLKY7MTMkZlEbhKG09I64GymzcN7alOxdBKUIfR8al8cbPJ3r7vHuw7oss3H0kUfWjvK3un+Jq07Und4wwrOUdY8Wwvcfzl+2cZ02bMkLDtimFq37jdtl5OeE0m7Jh+N3ccBI/aCG2M33oE4j4d9DV1Udn9AGJXskPVh0qT07xlaPinpIEVV/3LhAZ/G7FXPPeCMmzTJm3LY+cxT5yGVVnsgiUuJa/EalK81g4SwaDUN+274sn5Ndk5ATqZuuXnNSG59fX8kIQyFumqyHkYOx7Ey4zJ40g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HwAxtPuIc+vKFCIg9t+rd+ZlOG8zhC1Fi1gPnXON8dk=;
 b=Rd7A25DVTI5Z4O+Dgk4p9+HS0LAjRxhvk/KuuHQuxFecEsB4uzIm1dFfBx14Mp8xegQNPPzujF3meK2ligC75BSrS++SHUSOutviiNcKkr7+FO9llNJPiaw/8w7KzQlunPV7GHKN5SO8+Rl7TqQ72WXDEbZ7M4JEnOgh3EjDwUOGULF/+F3ANQ6VHnhi+4OTjnTtJzDIp/+iVJ6WMGj0EcPtIqdBXfcR0ZwIhnoaIR4tRoLhvXReT7LAJk8ARP2K4QcG9atCJNBitDcO53o2jIkOIRLwvH9tk9O7WHT6SIKWx4TvvhwgOMPWYxJR81MuxvCsaYEBbcDKEoWVssSyWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by PH0PR12MB5647.namprd12.prod.outlook.com (2603:10b6:510:144::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Mon, 29 Jul
 2024 18:17:00 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7807.026; Mon, 29 Jul 2024
 18:16:59 +0000
Date: Mon, 29 Jul 2024 15:16:57 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: kevin.tian@intel.com, yi.l.liu@intel.com, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommufd/device: Fix hwpt at err_unresv in
 iommufd_device_do_replace()
Message-ID: <20240729181657.GG3371438@nvidia.com>
References: <20240718050130.1956804-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240718050130.1956804-1-nicolinc@nvidia.com>
X-ClientProxiedBy: MN0PR04CA0005.namprd04.prod.outlook.com
 (2603:10b6:208:52d::9) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|PH0PR12MB5647:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d695554-e34c-40cf-f9ea-08dcaffaa329
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?KYvVxST6rmUmHTn/X0AbaWOj4WmTn2vmkoFNkal9H9HgUdpCX5EVM5NiJbWH?=
 =?us-ascii?Q?1754Ez+9JIBqhdAMBX/i3/iVzfMIk18NLADNpSPYCc8/1zCZhem/IqZ8WENf?=
 =?us-ascii?Q?TchZURLnlru+bqXk505Wq4A3m8Qdj5s1LumLeJ2Om6lADh0FNftGXajtYE3r?=
 =?us-ascii?Q?y5O9fKeNFNd5qC+a5nAkwLtRBEN/slT1//K6tCWt+S5BrzmWgvnmekClkuhA?=
 =?us-ascii?Q?nM9mmbfT9aVHiB78VCGQR/lub7tExm71KNG9oV0c0VSdATRrWxGOZ8L/P//r?=
 =?us-ascii?Q?LaBdlf4YLRWlD0AX05B3sXjrzra6FEDT9WxckoECC0ObSrUIHOM3Tjj8hHeC?=
 =?us-ascii?Q?sFN7YVcQY75XfQQx8VdwL2PEjENPcakUdypoM7d0fJQM4sCersRPBjuiQrbI?=
 =?us-ascii?Q?fhaeRm6mskvbZ2cWxDGj+yTCDVHeCrX8uGXdtkl/sHeXE0rYVGPxheGX1562?=
 =?us-ascii?Q?ofKqlxlJBonNpVky72xPo9X+aTBMMz7vvtQDUZ9q8Yp4+/LuyLZnjOwHM2H6?=
 =?us-ascii?Q?1cyRcNyxALrH4YsHHXnXz5tgJkck198+KUUNyZqCrqMHPWEAhNv8PkhGu+1N?=
 =?us-ascii?Q?7FP0iHgn9DQAgpNvDxTUxj7iL6cYA8WWVsAXMYNi8oAe+UGyALC+pV6MDN0U?=
 =?us-ascii?Q?C+d5/rYfVEnsnZMs/BZzdZQQlgHsW2av2F9TqLdA8Y0fnKY9D3K9OHkuu62z?=
 =?us-ascii?Q?UT4y/Sq4dUIl0xJZYn2IqyOfHlSyETl8v/o4vZRidHg0s6vsGmLT1CJzPxFG?=
 =?us-ascii?Q?NMkDiikid61DshWZU24uQXEuuPv5hpRNhILYt8xMzLSSMMfvBhC8TbJC2gf0?=
 =?us-ascii?Q?550IXiHzdYSdzAfLBr/58DSTU31dOM6bCT2l/ZWgJmINyRORkRNUN7k+BzjT?=
 =?us-ascii?Q?Yf0b5RjmyOtSCQy6dTHOpG6dizl8m+Kw1WStMl8duacWoxwjA+LD/sf62e99?=
 =?us-ascii?Q?pbgwXPtlTbccPfmm19/x5G/9292I22cNT/vMk6FJpHHqfLOF1NYlRN9ZE1bE?=
 =?us-ascii?Q?rbBk363nWJ/VyQ9BnKuB5BELcLnc2gfOArs0BHeGNjiKRfQH3GL7ztlTbmGc?=
 =?us-ascii?Q?sBUv9R37M+LNYOyx26FRVVaBQRw8nyMDbYq7Zi/pqRJOJNdWhJolEL8bLdPr?=
 =?us-ascii?Q?Nxd3TgZldf2I0zZsbl0sI7adoXFeqtYbDaBkcq5AfNPUBMGCuVdfaF1/Y0yL?=
 =?us-ascii?Q?rTx8//gpLYdr4YbaUX7aMA8Svr2hxpjBcZsvtdtNPNb+BRN0cGLU6NC1FXs/?=
 =?us-ascii?Q?q7e5xr+/Yffm8iPZ5bv1uSxq859Wg1ZoH5ePNCXs8UpsQ5zS1LNks3vot0Af?=
 =?us-ascii?Q?dwr35RXE4qS4BO0HbjPg0WClcQPIsHSVK+bqJek5lyFAUw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?frv3ISTU3iWzouLNGL9WtMVV+htd0mCJg8Bh2HN9gzgRjEEU1h4qYpYz/47t?=
 =?us-ascii?Q?W6Tip/TmNlO04P2a73WzxLWqshXGRZhMuiX0GlUuneo8xn0QXnHrlCQPnduy?=
 =?us-ascii?Q?Svgxidpyo6/pd3Z2FjeI+b+atr3Tm65On/Ht9DxZO/hxRiMTaUK1OE/Gmwbc?=
 =?us-ascii?Q?1dOGYqwEM1htn6N72IGmGFonTvOqa6DA5FwmEtYWR1BhE3jZoq0ZINsLArmb?=
 =?us-ascii?Q?lRTfZ/WPZlBfmNTdH3zx5aGJwaA55ZKF7IvKvr7la7bhQJzLAtspj7VYtmdd?=
 =?us-ascii?Q?d5nqqiZkvfrTnQtoskBpVjvtpHUCt/u5uifBl6VbXWCKx+yRRnYQH4yFsUh/?=
 =?us-ascii?Q?EXp/LIw7dAOoGsrR2m7qI4Z9GEa5E3c9+6EFOZLq/l/oR6sOSHVHqGEe1BzZ?=
 =?us-ascii?Q?5TME3KcqYQL9dKfRKuMHl1JNe6wGRPBeBpoTcN0WvxhpN9ZXE4RM7RsTAWxD?=
 =?us-ascii?Q?NpEoQ09+/TJlrszckRVE0YFnx85Qcoyryqwy7UpyD1cSZFqxZTDdIiBEiUok?=
 =?us-ascii?Q?ttNpkK+UyhoiMFVJ6nVYv3PAfkuiRaN27XAI2DuZuUHMGSH9SOc4NJa87Qm+?=
 =?us-ascii?Q?FXRS68I03M5JrlbELpBaH7yOtp79DQqvNb8HUEaOlPXoBU59qhwuQWp+nXyo?=
 =?us-ascii?Q?MQC8FsPdTovOAurOzXFk/kFOnfTPn98ndGOJbEkVDeO1v+bLOr/qiVfY473R?=
 =?us-ascii?Q?slrJjvskObZsg3S+uwzXuqxFPPfepd9S0VzytcjPhzEVbkGZ4Y7yopFBV/43?=
 =?us-ascii?Q?R2Vuv2yc5magJWAFO43HrcUHkD/MOS8VptHQrbhn5FEdB7cE1ftiXCRWzj/d?=
 =?us-ascii?Q?xcD/+A9vyHpZbPcY2h0pFQjLqkwDvXOxRBiOwBbroBxKd2d74gsGoKrh1wKn?=
 =?us-ascii?Q?dKtL7v73n058xHUy+V9EZXCkMmapmi64g5b+bHyjaUWCT9X3eJYFGQy+EAAt?=
 =?us-ascii?Q?XFftRsHuadmVjU1FkV2uX3V8gd8Skqg96GCfJkTftM+SoCqpnlqnOXjO7n6D?=
 =?us-ascii?Q?OSNFLCfZ3Lw8b+qQgYyVoV8sSKRs8pTMXV/SpsuqnGRO1C4teesmYAF7wZAW?=
 =?us-ascii?Q?xhalCxNbdNiBG7R4ynha1cHkfebc7o1RzPHhhxjGXe3wF8Vy0Ix5XZOUoJmS?=
 =?us-ascii?Q?czs3vxAYsjI7m7Dd0oHKftzQScak0uISxSJrhDaJ/6AWOjOjWLmZfcr0DI2t?=
 =?us-ascii?Q?RHeRCzuQDpIUsySx1ymCtbzi3UTWs1T0uJx+G6/Sf/WY2CBExSas/tr/ghUJ?=
 =?us-ascii?Q?WK2LHUZYy+Na0SC2CkDHBdcWk6cAGX1/rbEXhwc3lHDH0OmF9tOwc2NlYCwl?=
 =?us-ascii?Q?rluGqd9k7k1y2ppO7PF9/Mc5n5eDGJ40cC15xM4L/SFDvULVpwFJLKQqk8gq?=
 =?us-ascii?Q?H9Y28ihkm6dnyIQ37Hu9Q9LOrN3qRKZdVJ4aqd6/l7zi+apiFpplSM+LD2+o?=
 =?us-ascii?Q?C8BLRsF6KbCj/yyKc31x7B9bIfezNN2blxQXrDg1yWQVNoSgBUo1NYohp/5O?=
 =?us-ascii?Q?G1KP1HDvwxmQA/MnyjwjhWcSX4slYdP6BdKgdD/QTOQB3UcJmbFiboZhC+6J?=
 =?us-ascii?Q?xU9MfqcTLEBth5zlJFYHuc3zhtTm0t0UOJJg/sNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d695554-e34c-40cf-f9ea-08dcaffaa329
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 18:16:59.5591
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKOwTkZRoi7HEY7HFmFK6DU4/Fu99Vr3OOGroymgtfg9jyNxerQDaq540XesUhle
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5647

On Wed, Jul 17, 2024 at 10:01:30PM -0700, Nicolin Chen wrote:
> The rewind routine should remove the reserved iovas added to the new hwpt.
> 
> Fixes: 89db31635c87 ("iommufd: Derive iommufd_hwpt_paging from iommufd_hw_pagetable")
> Cc: stable@vger.kernel.org
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/iommufd/device.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to for-rc thanks

Jason
