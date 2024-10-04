Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DD81E505
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728044210; cv=fail; b=dhdhoQUAsB51qFxKABt3Am2S/lEuoLEqeGQgkHbwOW/rtB5d8/Pla08gK1dy2lmwj4YzN0AyjZvU0RoF6Ipi0TRaaMPvfHB7rHbIBCqNVZ+6vfUDG/jax1Dn5mMHCUQAnEtqcuwgaZpBsc7tdFBHm6MPjeGtctj8gQzzv7H3NhE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728044210; c=relaxed/simple;
	bh=+i5RgYaa9MxrnPNCJjqUfH5SsqtIzqRZ9ceoRfxFmNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=c1r30E0MKO4oyU2xjwNItCeWoO1AKIaKHVa8kjpul6oByv6Ygunoa3ymWqHMqDxBVGfx0WC7CkOFOYkBcYGRSXzculTlpdhykJI0tEqVpKbjDZFyr30muYx+a3tDvfP3sNFUDsR94d9lMhEWAY2LFmbfJ7pTcE+uyBRbnV38vyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=escXugNd; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="escXugNd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VW8RJJeqNoMJw9WrXu1Q5uZJ0QCQfuP0FVCIB70II0tuNaLHzRUyQa7DPb/HEDq4t9TAw0LANeAtEaSg/RpJu8qz/qp5u9lHqe5PDoiGd9mjWhiqUtFuLS4LT+XSGnLmn3VE0ZNoqEu8B8wf6Jcx06VYYGUuxIZ3kZFuurhtZVhEJnobCqAQ7kOkO6qeWkoS64oKYQjeQS8syd+9PNUlcRSx7No3IzMm6uJPlSQU/+KfoFNbbZGZdSTv+U4/cI21hxPGw2rxk7H3Bb7VrYGdooW6KjwgVrDXBm6wDVDmjuPA4WQlhY+mY8y9cNa3gnMGi+RZa52vQNGzNYBY7lql3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+i5RgYaa9MxrnPNCJjqUfH5SsqtIzqRZ9ceoRfxFmNM=;
 b=i6mnfxrT/Gae9nYd4774Ozs56yrmVVc09I3GPCMl7krqG1FwXHLMZxb4dY62qJ2uqp1SxLUWH4KP9gGiRWUO/mw7QazT4GcCYAe/7XpRCTtQJGS9KkXenRqlVf8yB6hAuRK/Zq6eJmVnwCdK+/howAIK+KUO5F0C/d4YNHaUBNYYFcuw9Uz7+kLD2qpzb7D5Hk7he/MFwwLLuh9n6qXg85GDkGLzIHYgYhxOYiRg35WOC17wzkcXsmiP0+po95Z9/E+dMsUWK6M9LYuqb6o8VtugWYBMGvvdhSdbIbfDYcpFU/tAdXg8WUSe+s7SMcy0Rt6qVC6C7QJEFk7SZlaZZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+i5RgYaa9MxrnPNCJjqUfH5SsqtIzqRZ9ceoRfxFmNM=;
 b=escXugNd7F5tWFiecHf7x15FUSlBfjYA3gg8awHQ4mxQ9b649710uKcNCjRNRsXVA4ZA4+BaqIF7709l6TFnrcdnUMMzsyQvSXIsBMA798cWHpFwyRKrNb8Vh+ysdAwveW8p9vvsRaXWmkN/lCh58Dh3h5RdIqnrAxbl7tj9NktF1BdpqW4HivfmF80gThYaABr4UXU2eBkmNt2oyF4YOVk1PJ6MH3aulNlXILP/ILa9X88gZcdkv0SZ4/dWoWul1uzTVx4P4ZZBA24F1M8bnQD41Src8Gyltyu/N+u5zfH/KMdPetbjqWYdpoVzzmwdK8iPAbmBTK6bjvZAMI1JLA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS7PR12MB5912.namprd12.prod.outlook.com (2603:10b6:8:7d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 12:16:45 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 12:16:45 +0000
Date: Fri, 4 Oct 2024 09:16:43 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: [PATCH V2 7/9] iommufd: pfn reader local variables
Message-ID: <20241004121643.GG1365916@nvidia.com>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-8-git-send-email-steven.sistare@oracle.com>
 <77ca78a0-fc84-434f-be8d-d3e9ed53a434@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ca78a0-fc84-434f-be8d-d3e9ed53a434@oracle.com>
X-ClientProxiedBy: BN9PR03CA0590.namprd03.prod.outlook.com
 (2603:10b6:408:10d::25) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS7PR12MB5912:EE_
X-MS-Office365-Filtering-Correlation-Id: 354aeacb-9241-4b15-dc89-08dce46e698e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SQPpFUJ49j/waeS9peF6N0jbAm6+9jGrYpI2AQfSvXUzudSudHGGYb7o1Cqk?=
 =?us-ascii?Q?CB2D1fxZft75FInygQ+KSWloovuX9wZWbXUUsFRrBnmCtoME/xKpBP5noti8?=
 =?us-ascii?Q?HfLyYWcKD56E2IzQwU2wbUb6N9UzA5qxnfls7bsz55Ropn34zb9yPdI+aeEa?=
 =?us-ascii?Q?xQMyQOsoKNmUMJ9cgjYJadyWMAnnmjovNIcdEUcX9zMej+TS68DUWE+v7J8s?=
 =?us-ascii?Q?PuUMud/v+rH45tD+q+EhgA85mSx8JJYAOMqtpwfCy1qp7r/+AGxrYzZiK0Q3?=
 =?us-ascii?Q?24PQfuGQYCWZDPSZDm+u3unTn02iWII18nKjudgq2U/INJYpOLG2gM2Q4nRc?=
 =?us-ascii?Q?x/628KHYFD8jj2dyCfzrZeJhDoT6YLgmLdsNtzIc/bLz/HxOawKfnJSgM4zk?=
 =?us-ascii?Q?Nd8Qplbveig+YLtDHJgLttwQ4YLgdLpcMLwmbYOvOZKaklH9TPmiprQldTFd?=
 =?us-ascii?Q?my+5VKL1XrzDy8x7aHUZbRA+FjGgRxTml2pK8VQJCuD2foQ1xhqkYZiCKrBX?=
 =?us-ascii?Q?SQQh8LsjOJpNxVkWJzOBFDzGvc+iJUVC+VydIf5LSmhx9fk/vFqvyzsXK6/p?=
 =?us-ascii?Q?A9iZI9LMtCEFX/XJe+pg2lm+u02jnxbY2EBQMZBWgwThL1mJXsXx0KnbY1WR?=
 =?us-ascii?Q?SreSBhxaIv0nEg7MgGNqHTcCmDiQT3HVcXSf0/SVfNHDuvulxbEw4d82EHiT?=
 =?us-ascii?Q?SmdOL4sMK7KTgiJqedcLIhzDUusF9uryhtmaXGYOB12kFJrpYBIGZWmSCLyq?=
 =?us-ascii?Q?GhNrv5bj2+3xoGGS0NPJ45LFcdenhrje+e0U3C/zTPhoiIyPmKy7m8I2BXAY?=
 =?us-ascii?Q?Z7mMRumKpx9suU60UZrd4PKqG97jWpKbdHKKnP0I/hXNSUalGoi1emlLnhc0?=
 =?us-ascii?Q?ByOLb+Iz9PV3qqK9TTPSGprruTJc7uhRmcPJcVDmtVi2LeyYWfG/Hfx+82px?=
 =?us-ascii?Q?JI/5g0Yc6LOskgOZTaniMhqQq7LKpl6jAki7ReGn0P3pVc7tlNWkojyeUgFY?=
 =?us-ascii?Q?7+hDeT3jcXzX6QNiCdCfrija4DQtdxKMbQ4BveD8UTT626Xav14odqkuA4f0?=
 =?us-ascii?Q?xCiLwYxXFgNkhdcB6ar2PSdPnbNeFf3tw4kKPMAkTNFB8aOXqRZS9bO5euAV?=
 =?us-ascii?Q?VNwrkbAd2Yva7frA0gcoV2bFDM1BgQiUCgw0dzixlfT865xjTOvLhKV0pKcp?=
 =?us-ascii?Q?nZ02TmaMcuID8qQSWxreVLuxZaqifw6yeBHtLe0TJDxC/16N4kGwXJ/r1mXJ?=
 =?us-ascii?Q?ULJ6c/P9fjWMDVELzJDsvSjy18Fxw7SYuAZl+HET2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UaiB2B3SIPHHphIlEOI8lL+JzBJXs87AqjWZBbZL+wPir3oELten5kOXTnS0?=
 =?us-ascii?Q?J8wApdtv+1n1WjpFyHZjQHrxcA9zhgCjvyfBm8A0zQhc9WtGEyyIvwEJUgMl?=
 =?us-ascii?Q?/byJyHvpGG7SM5CYdZA1qAmu/F1NIrQH5ZDBhzu2OeSMeedSELscmykpf0b8?=
 =?us-ascii?Q?ArIUoNmrNkxztfP3MDPr8m0mMmLGVBt7Od7tKowW254Kke5vv7G7ELxIbVtV?=
 =?us-ascii?Q?h4/6ILyb8xNFYRreQAfkXQO5aL9WwfXnX1UywzYfk68I6nJZOZpFWpPJIAxf?=
 =?us-ascii?Q?lb21TuR0YQPEZofVMI81CiDL2QR1LlrETgWshc6jmaF1G1SWFLYuM1k5k6CB?=
 =?us-ascii?Q?DHIqPhiYPMkFFXuZsE0POMLpZkrAX14cCi5uELhYaNPKI5Q7Odul/yCfv+Qt?=
 =?us-ascii?Q?Vav2/br01qBzz9Nt6a32DxSKBgUMyG0w3+Z8qF/yRLG8MAxw4db/GtYcCRy3?=
 =?us-ascii?Q?BXwkll/SYTON3dBPdTDpDRuJ0ZbwyCR3q4wvp0cRLxnkZJO/S+DPDikCUqql?=
 =?us-ascii?Q?Z65Af/ElbMnXL02WNRvNtxkitcQfozTiXT1ZhZGPlOMaY5x08b8qfE6az4Lf?=
 =?us-ascii?Q?ZD152AfRLXNUBPs7KFN+1WjfOdXE/axsdQomWIbtAYTvAsTVQw6a6B96F1vX?=
 =?us-ascii?Q?HwGbolj2tLpVneN1ILxuNP/ace8quvmMAq8DuOES9iTUhgj8XQ+BQmeVHaIA?=
 =?us-ascii?Q?AZRiIibFO1gpCFVhuP8LXOKOh+0PVmnNP446ScPti9k5gFsdaESOhBZlH9gv?=
 =?us-ascii?Q?oKbWWhfhX6lIakPpBu0HlwPlpIsFU2nsgXewwqghz/o794qAjaBtcAxkXNMf?=
 =?us-ascii?Q?l23LZnA60wcJGGxoVKaFumSaTj3ZrXXuZn3yxnRLBbRB82EJoM/Y2p/BhNiH?=
 =?us-ascii?Q?f3pCOeQKcCE1hnwwqcHMEH4EcisIXYXKs9jAZj20Dw4FHwoIbbMDEvVg0gp6?=
 =?us-ascii?Q?Phoukcx3xV903Nknee5ZbeBQsEERYKu26BprGyekhIbKI5KJDvyJaxhYHxqH?=
 =?us-ascii?Q?hzam/wTlwnku/XS7dxny1w/kDwDB1qsvSVZVG425R4/j6IwpfYCNJzsOls5H?=
 =?us-ascii?Q?W6Bc/nM+pyAYdxFuyhl4vuIUnKi+pPd4SYRfLyMNuM0v84KCnaXBVOSiMK52?=
 =?us-ascii?Q?kSHBASkvH6hqRBNmej7ew6HVsr4rv/gHVC/xrIyIsS230kh7sMrgWzsNky/d?=
 =?us-ascii?Q?/NUEEVIp0ZoujO/kZvUfeRWXQvzD0cOrGYwjqTlfTEaXlrl3HPDwY43hgT5j?=
 =?us-ascii?Q?AMTIW5242K4Hjkj/s9zbVOm0a2JusB5YOlkVAohZsew+ZdCIjW0ebI1IMOTH?=
 =?us-ascii?Q?vhmDDsCHBOIUVtIeK2ZFDkVPDJdcO2esJRlUkBFmLlLZRiJkX0hSX1yVtJb8?=
 =?us-ascii?Q?hAUhDmwTt5Yx+ibkgcpkEkDeB9ganvsIO9TzzxMG/DNHf+Rw5GbD5TGaxtKg?=
 =?us-ascii?Q?03+nU61Xq4LeLQkliH6aiEGEHDDfB+yiylKdsCMva17aCQ/h5jJYR4Wf/T9o?=
 =?us-ascii?Q?Sm94/D48hB5nQ0yQgK1qaKYeGisq8rDGFQi9plmEV8ogsnDpiy8VPrqhtgSP?=
 =?us-ascii?Q?FWVjCO9OZm/UimCF7f4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 354aeacb-9241-4b15-dc89-08dce46e698e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 12:16:44.9578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: evDoTpja1u4aHxz6cRPZePrZu/nXZGfK9iOP6bd2xDmgNSu3NM6i07kCK4iKDW2U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5912

On Wed, Oct 02, 2024 at 01:29:38PM -0400, Steven Sistare wrote:
> Hi Jason, perhaps you missed this patch, since you commented on all
> the others.

It is OK, I wanted to look more closely when you respin it

Jason
