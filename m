Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013070.outbound.protection.outlook.com [40.93.201.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79307382292
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 22:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774303895; cv=fail; b=bW7pfvqpZKJgHQU3LXIQdNvdbUaJbMg+/gjSlgBHqz6mD+C01/+GiUDnf+DNXIWDy2CzF+eBxoWY/PD0wYYGXtgESHsS2xyLe4Y/aKUJVHx2AWe0KCYF7iHT8t0yqU9eF7NDqnm701wTK+3pQ964TnGktWiF+jYimJJMBLn8yl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774303895; c=relaxed/simple;
	bh=W4S2xr15q58WCi5O+DSHvWIpR6LkCRpRu2DQpM13w6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=IwpSUJWjJ13uTNNS4AajmjoM421j4BJW1TD14VLvA7unDpAHiBe8Fbx+oLwLIlEh78Akhm+ybyPwssTggd9qXmgNqgOzYax2u4/bnXNtsySESdJeMPeXDgd/w8Rctx0zT23CG0VuhNNiPPhgyGLF9AfUEKIQxNhMfznzlKW9d4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JDW9WFva; arc=fail smtp.client-ip=40.93.201.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JDW9WFva"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8VbLtKbnPk0fQdqwnObARqTmMRPIWov8iTDjRoe/cdV41yvTnsxBthwm8K1O/TiMvR9IkYrc3f+XORbexvoIs/APlr9lhwKg9RHfTdMuc6/CQZO4oyhurQlt9qupRlR1DbRoSoH0PClYJDQWAbujHimflahofQdoA7pdoi9nepIFeM4C5MHlxio52+RGaI6anNR10S5lvK1azMmFNqOfyNWtonfs6PcLkNeDFeyP+jEqXNz7JkBZ9s5/zI8mh120PdXE3jufOkxFmrjSEa2atndzINhDbdOcOt4j7UeyzgMx0XOtJYvQvNPbPVIhl2evfAsiHfzPp/pc4xoTbmF0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b0BlP/1EgMLtEXaLU6DWd0gsEFCwa44W0PTNIKvPSE=;
 b=jSruPVRiwZdBZHnF4ydJx1uo3XeDQju44ON4CSBRrcA5LxqpUKq5fFpDlNdkCNDV5MPItdRbJHbDS5dQa1GJUd9UNjE8WjPlL4m3ReSmP3yxtW7wAagL3tgzYi4ck3DPMeSCzON+Z7Lc9K+lnXyWalUXwjFdZwKqphf1FAIXL99/Cth2WP4CtIo46R0q8epuPCtXmi17pkyM0DgYEAs764fv5KqjO5Sgw0BItYRVkYKzv02MQGXshLr0lI3U6uU1qHuFjC/VVMbelOsgFFjczBRFrzT2hIR9WsCaeSfyCV0nBRJVRCkZlFBIvjHedYsezl67EcwWwzMxwMRpaKdEXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b0BlP/1EgMLtEXaLU6DWd0gsEFCwa44W0PTNIKvPSE=;
 b=JDW9WFva5Knxg+kCr2lI3Q2LSo76pTCqyWT8vUW0y4aV5/4owcPt4ptMNxQE5ssSFBPZDTRJvfceCazpGeqNxKRQ0yOfQ0R2MYzFgn1yQfwRUvYbMXBKZseUy3BS3gBsOWbdA3HLiGPWgHia2/E60ReSD/dlfU0+DjtvhY18/9knX4fvdUDQC7eMTbEvcKb/5gwwJ+35DUt7xkFMEJx/I/KOjMC61i7sptIAfCAqxoFoe4Nw45SARRllGPBVubGZz+VaNRlqgIm5omd91jXGk1dloAwbSTo6AzjFTlLS1oVUatZhAbdehRv4gbOyAvlNgPCt2Qhb9RmEH3eKuYiDuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB6435.namprd12.prod.outlook.com (2603:10b6:208:3ad::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 22:11:31 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9745.019; Mon, 23 Mar 2026
 22:11:31 +0000
Date: Mon, 23 Mar 2026 19:11:30 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iommu/arm-smmu-v3: Fix typos introduced by
 arm_smmu_invs
Message-ID: <20260323221130.GT7340@nvidia.com>
References: <20260321225041.11090-1-nicolinc@nvidia.com>
 <20260321225041.11090-3-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260321225041.11090-3-nicolinc@nvidia.com>
X-ClientProxiedBy: BL1PR13CA0351.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB6435:EE_
X-MS-Office365-Filtering-Correlation-Id: fabadb69-1702-4c9e-d9ce-08de8929232b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	aTJ4EBMpFDnf56UUNNOCSSv4Kb87eZFre61AgICMNVvXZMHJH1VHEazNswcRrJ+pHISmc6c20NAhqV8HQFTlBxG2h94lhBC5kK3DWEX3z36weaW90qG1FRukDUne5HUphHeXyAO71Nghloc7L6bHess7Xg6Yk3QTm+UFKkEJsY3yRqVmGzSEbI5nZ6t5XXJGR1cxOUKpG3hz4jn9wj38bbph9jGksu5eVQAY6LsWVgYqJEzcKCVGAutbm1IyR0PmRZt+zVwYKM9DIittb06BiNVhdPIok5zu+VgNqfLVnAmcPmcfu7RdYl1CrDPe1/MEkB9kOHN7NCr4VRsOKBz37H/OrQ0/UMfTb9k+nJXhDHuVUyXZNXs+RH3hOu02Rhd+ZSJ94uq+JKsPwEbwTlFRwIC1VZS5ICmaWy7Q451eXLgO+N+JanN/dFe2uhe7PUaSDRdCKxyyycA2R3cyA1jZr9MQNvP79lAQoaM8fGEn01ifWPMuBvBxGPesvneHGWeUbaPsYv2t4omDcV0xGogjbTXmX5EkSq9fX5TMigtqWuhEkkuDSl5749qJLhB3d2/sktvRLQmhyb96XVlnKvul3r7vPDTIarhgOgHRYJ9XxuGw9FOnS7AdAqUAfJOvNpK+Idjsnf5wOhtkAz5JRt5NWCQ44u7mzmNjuzD0y7HzQerTBDfL7k66Oi3y2sTnv/6h6VOhVjcYq00XftDPDvEnyDzsb0jKY/eH/lksBDNg1Zc=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eA/o0DwNwLFI7vEicELiGaMrqWSfwVvym1J4i/BYmBy+BwWEqgcRt5oAR8tg?=
 =?us-ascii?Q?rACoTJZBC1a+nhSmCqb0E7kiFd3omfK/7Qs4n07X821nUuXjsBwvmsElZvsP?=
 =?us-ascii?Q?xH+Yqnl2E5fsAwoAv3Rx5MEheIVOywVhnpaYIZEWoI6buVfVTdPf8HXSitDG?=
 =?us-ascii?Q?IhxJtyvh78VXL9V2p+LoUobvN/hrK0OFZWp9spV72VjRQPhtpEfDW6+PodFQ?=
 =?us-ascii?Q?JpHgd9n2OLO0wTwNGcnkEUF8C3wO4nDn4UPjGJu+SStvXHRmSQKBP7VJj2MY?=
 =?us-ascii?Q?N4NQVURtwO3jILMVsDShnmR9v7jZ3IKcEWpvrhtqETdGI/QXdchJ8gwBzfIJ?=
 =?us-ascii?Q?8Ylq/M7Sso1PDiTCZxPDq8OdBe2n8o+hOJ2pVv7O+mL9cgx9apK2p0+4tUV7?=
 =?us-ascii?Q?dyhKfnzMDuGkcQCZBzIGTywnrQLSm6HOFSAH/16hcrF162+euSwLNi3EyPKv?=
 =?us-ascii?Q?n4AIjcs51ZQ5XXLQSR+TqYHZQeKjMFxHoKRydeV77x1eqL2zQ/qtqWfkDseh?=
 =?us-ascii?Q?Crx733YNAdVCLjNB8qxoLAVBhljXrz8AK7FJcI1IUsY29wk3dm3vhaz3PUkM?=
 =?us-ascii?Q?3ME1/yY3RrIZLvO1nsKvzwPDgBg2gh4n/thkpE6uXxIp947IqUlSwoyYp7jh?=
 =?us-ascii?Q?b2dXe1MCGjJ5frxTmnY5paHYLElHWIAA9at4TizoGzI4wXoirZiv/yKBbP+T?=
 =?us-ascii?Q?ChLzAZHg2VOJlTeZFiwQZgmdoOU1EOiaUq0jZ4FbsL+JddXSuIK/6hyb82XX?=
 =?us-ascii?Q?HR2cf7mQSJarDYR6pkFxuNSihXCrOqjPPAuZsWY+0ZIUYSKmYQQfGi64ykdX?=
 =?us-ascii?Q?cDZsN8N7T/+1arGU2VbYKgIgXZ9k/ETkJD5aWUtxzLDvLkP56q7CfFVJ7ajt?=
 =?us-ascii?Q?G1HKGrIZxH88gqRlzujoRRVESMQGUtmU59RYaQF3DcNZn4H6Qm3OqFgMztgs?=
 =?us-ascii?Q?8KWpj1KQtWOeTcrT+mPiDODUc1XdwzGK+O9Ein0MTguFVF/XoF2kqT2IGaZg?=
 =?us-ascii?Q?WoT1M/HkEjuBfGlKGd9/Is99godnyYFJJ5RIi4zHJgsPKyK7fIAmwcQSH31J?=
 =?us-ascii?Q?Q7SSiGahVPhXxgDmvHRQbr3O00V7aDedLJ1IuLhLmfWyrxroe4+O9pfbJHW4?=
 =?us-ascii?Q?DrM4S1nKo74tCjjx4+ggjrywlxjSWWzl+TogjLCNDXdwFCbtkxirBh8A9pYm?=
 =?us-ascii?Q?eyzIxioXP4BWdYPEBdRSFqYOQw9ZVzFayUHHf9JzmfFl7lNkvfLMC9Ix3pcy?=
 =?us-ascii?Q?/lSI5ynGO+A2LCdu0IFjzgVFk5fHMkiF5J8aLh+oX4tqupCmOxUs9ASqPpsL?=
 =?us-ascii?Q?a9s8y3dnZ7Fmd0RzASZ9wxAgHmEm31UYGUuGr03ViPLvV5rMTsaWU6NCH6I+?=
 =?us-ascii?Q?lVARsXLJHoOm07Fk7Npx+ihGl/Ih+zPTzkgv8ooyAFEF+7VZb6YtozU5bLwk?=
 =?us-ascii?Q?cC9SLZl+ccbmvygYWZUkVMiaejvIExT3qS5gzybXFC9EeqM6d6i8soA1no0O?=
 =?us-ascii?Q?4Tt3zChx8N5xNn+1F6LqUv1F9SFlbgzjfb4ygU9wt4oOrFg3bZqxdqw1uAGo?=
 =?us-ascii?Q?Iw2qLfMwSdUISsmtB9Pqv0fTnwsTxRVbKYczFLDmThR8+kctl3KKTHebKPUM?=
 =?us-ascii?Q?zHXi4HC/7zSBOAJugMNCKW+1/GeQm974vfaGH1/6SozQd95pt1zEZXNINU0R?=
 =?us-ascii?Q?GsU8uU5igkcIUNRQQPGh7pLujDgN2QrceWfRYEQlALIO67X6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fabadb69-1702-4c9e-d9ce-08de8929232b
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 22:11:31.1608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ExTGKDDs25JSx9I+fHBV3M+tNO17up0js9G7WdqU4Hx9WjOBwPbKIoY45wu4mgL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6435

On Sat, Mar 21, 2026 at 03:50:41PM -0700, Nicolin Chen wrote:
> These are introduced by separate commits, so not submitting with a "Fixes"
> line, since they aren't critical.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 6 +++---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)

Some of those might have come from me

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
