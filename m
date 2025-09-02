Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2050.outbound.protection.outlook.com [40.107.92.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFE92DCF5D
	for <iommu@lists.linux.dev>; Tue,  2 Sep 2025 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756818625; cv=fail; b=Y1SNlkqDKjHD6d/Mlo1aaYcySQoQQppgeMo32aDkmPpYa2o9YTOp1H0uK8ZEIdMSg8PWa1QHcgiV/r0B+BDiLVRfaGeZpmLyy/Y4nknTlowJmnMH9KEuBpxWC1LGTFxROz1D88TpWpggbKox05U1SVY2tQ77bcR6cVC/4IafQXI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756818625; c=relaxed/simple;
	bh=qNzOTx7Iz4CQZRuV4l5ikZDfDrMYdazRouWFhHKmzXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Lbc+jqmQny9pkEV6fj7fP4xb3uc+tlOxo3S04XmT4RfdW9oelBM179Q737yzU5zao2OVrPUpTuBqinj2TUHPm4k0b9clz+JVKb9skZtoV5mp6wCjhXkE0MqNdmDHB1jIt3BJsaXifbSfZyA1K3T9nBNc7ha0WL5ZJVp75Cl38ig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iHGKMIGv; arc=fail smtp.client-ip=40.107.92.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iHGKMIGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fbVwuZHdNeQmjFY6Lf5VcIZAoNccwXX3mxGsdHUeMJ2rSZi45TOmAS01D8Dk+s8jHiy8D6QgOXXqzwyk6nmitWcaJSAsFFrNWcI5jKWNZbQ+zWxklxUON5wTtvwAKDm+fFeIoYe3+QA8lM0lwsnB1DX6WRYDWjKKCN8QOYFrpT77BpjOMhS3WNpT/ReZxjzHfFEluab6dxkkKl1JAj2zwW/dXwHzW44lYQU6oQtDjEJt7nFPE/PpyZcIsDSIq9FxULZqHcqsNWgoYxlU/hgDJNUZgtgnM7jjHDQBB6zVt6mfiM6mKgT5KgvaToJA7KZihvVA+ylWbb8sFKa7vv95Jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UImsYKeFbayG4Ek19TIroJWZMxRsvAQBNV6xq4pZMyU=;
 b=aR/WeuyblweFo4Abx/kM8gmVd6D8kcsukVDz4rwTmhN72sTlmt03uZ0JyWvVXMLuqBKLfOFUq/5wEx+OQ0VR8G6KZrnaAU1KmpnyOA0iI9ipE/OgACQg16hP98ANsPYYFk0gHyZSTm+xGvjXUtiL13fvjioeS4bIgR6ui2xThhOJdAauCdaMr9n53xqcL5vsV25k5939mDSS7Z+Qnwq3xe1xDXxr0il3OJnX9BeUhErx/ecerozjnj+VNxk8K7bQKactsFHWLlXL7QrmmOJ5QejEjvARD0vxNSdaBQ2KZEUmgCJlL1m8srCAkMUyvtIsK5mX9UXxRMUyzY+lWwmKMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UImsYKeFbayG4Ek19TIroJWZMxRsvAQBNV6xq4pZMyU=;
 b=iHGKMIGvRezardHYze8ZhZ/Eb70y3PDVq6gwWn2QkZq4C4EGdWsf95vQonmApFqEofw60C/p0gQJrv/qplfaL2kdZdhQG3r+yDoz9ydAz9yUm0mE5LoPk/Uevi4Nwr1qiTVa8zY5pTu0kCVmSKxtEPgiV4uj72+mwKTjT5g+qsiZgp/w5i68pC0GA2+MZyKed6XyW1UBL3gnSUYSeNyQQCnioFG02wqKIf3KhKoDFTZgdAgC/jWcfFfnaqCm0CUEUwWWhB7mTSYkhmHpzsQCCFl6zBEKvDF2QoJ3otGRFElNCeSKFe/nRzILZm0BuEaE/63xkfHutnWgqbUGRJs5og==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by IA1PR12MB6458.namprd12.prod.outlook.com (2603:10b6:208:3aa::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 13:10:20 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 13:10:20 +0000
Date: Tue, 2 Sep 2025 10:10:19 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com
Subject: Re: [PATCH 2/8] iommu/amd: Making device attach / detach helpers
 non-static
Message-ID: <20250902131019.GI186519@nvidia.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
 <20250820113009.5233-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820113009.5233-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::15) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|IA1PR12MB6458:EE_
X-MS-Office365-Filtering-Correlation-Id: 7117bb99-43e1-4b1d-e08d-08ddea22119c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cF1EXOizBy+MOFcUcPsOqVQocPwEaM9X+D6/bwv6sWIy+Sw4vvNOr8EeyxnU?=
 =?us-ascii?Q?XyoNu33KFRt4DKkIvzMLTvFJIHKPandDYT99L6guSo+yhknMxpwlVUIrc29h?=
 =?us-ascii?Q?RWK+gcRGRUibp19Q1BBDyl5q46dYsIhn4gM9nn4rQm8L0kogSQQspiEhNw46?=
 =?us-ascii?Q?OOdskiw50fBLTRRHErsILdqa8D8Umn6E+oq95ixSntf9Fn/Lo6t7cn8+gazj?=
 =?us-ascii?Q?ZNtoR52Z8WDmyld2rhsy3BitfLEEIMgk0RHB4YHtzPXO2fW1iK6VO/RLFlhX?=
 =?us-ascii?Q?+WbzcdH63SPsPhIYER3Rbb3HyZ+wg6uKNq0+Lh5QC4cFR1L7xALCKdBTSmYm?=
 =?us-ascii?Q?VFfSkJWZC2Wi4nDeAEQYAE5CIVYnyOt0BqClpOw4weslBepTbo79SG6HIDCr?=
 =?us-ascii?Q?FWnJFiNkK6naoYn1OykPFLZnB8jTENDsyTb4h6t+9qwYLiUVZ/V/8tIFVtQ9?=
 =?us-ascii?Q?j4g2Fwe2Fgje3Y9MjrSOM8h7vkPe+zdWF2jOJ7od2+gRmAhA3eEfudSIN8zm?=
 =?us-ascii?Q?bEhEr4Bu3dkjqjresbhuzO44/EYkvBLFhNLXftXW2/4EA4Fsakq3KaLFHL+h?=
 =?us-ascii?Q?30SjtZz85QxZv3SBL4+CvWtgyf9VWUoQm2YDpKHaYh54W7p2qYAYLxJ3zr1u?=
 =?us-ascii?Q?7H6PrMQz7MUtUQaD6rTMEmUjbgRCNci3AQP1WnE+na0LabK7FQyoV38EtgBA?=
 =?us-ascii?Q?0fPy269o7ZMmxii8Zly9l+eqnG7fHJCB9/J3pzxAMJBzyoIvyJqr+upbo66K?=
 =?us-ascii?Q?I5H8LZNVnhVrUzXTAHtIBTIXGFCrZojhmgz5sr59sce8xJjH/S0bnslIZH2p?=
 =?us-ascii?Q?WBrY6H3XVvuc9aA20By+neWz2x38cuBgvRSTKJI93FG0W+4spxRsXigYJ6Vk?=
 =?us-ascii?Q?7PSxEwgWOHTc143CwRLBUk3NSjobg7yBUbvG0MxGw0Kuqf6EpsnRKW+7yZCw?=
 =?us-ascii?Q?wwkYGmj16REojQGzeWRsOKIZIrriAFmpAI3lVhAJLYPpX+27xZD20sSetW9j?=
 =?us-ascii?Q?Xv4R7ZGQ1kbKjtY1NUzXfADjB3gStRktTXNJTjg5rrON3d8gRX3fFqgG3pkk?=
 =?us-ascii?Q?IM5rS9udZ2hi5WsHOjh9DQLhzVBCIKlOahUnLvUnoRL6B/kEqoTOvp+t/m9G?=
 =?us-ascii?Q?D+Yni6nMrNzydh3peJoSHACbI+vYAHynlpnZs45B9FpcaDyoVtjzpcpgBd2U?=
 =?us-ascii?Q?ISRUhwg/YtfoY8U3Z53WRig62Uo5geZRPgzwsIXwp+lEHs4Wuun8FuP9enI2?=
 =?us-ascii?Q?z4EhIJLYXjmlu2PWfl8ETl+5xdTvhCUhXsDeqnfDpAlqp0i0upDB3fal3g9B?=
 =?us-ascii?Q?f6QN0f2qdmZSos7x7CI+IXVnM1KCOrdDlJAY6ih/S+i9kDuNmcj7HhG3kgv7?=
 =?us-ascii?Q?Ypa7PENP62eJUxHB68ic3ACycb47YZtI0fetR8s0b8i4mI2LPw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BPvvNKY5HooZ7wEGTkpkhoPSto7lGa3Gguch54BI2G2R3ZTz7+yDYc+yCTj2?=
 =?us-ascii?Q?goFh33luH6NMXhGlRqDiQ1oY+8kWXPrWlMF7ka2z5oylB/7fnoTMQwBb4GP5?=
 =?us-ascii?Q?QQhuWycGIVIdVw6idXhaH9FCAbBG92AHLoeqBVDdyxVToMQfv5dSRodmfAOi?=
 =?us-ascii?Q?N24H9oGQaQyQ6fkPIpjcNAwFbXmNKfhpJbPOAJDjLhpD9ngyC70roiPaF1LB?=
 =?us-ascii?Q?tUmB16CRLBN0Bw4v+Ii3M8gBPWtLWs/5rZqqDAq9P22Asv9X3SM5xOlkogde?=
 =?us-ascii?Q?/9lfpAIZLF/MuwoHHz6ZVtx3B7EufkHsr+qu12z+Anw/Is1q8kHTNUiMWu8T?=
 =?us-ascii?Q?sgFDHfRgKHHGILCz5+jasR8ADqyp9s5ZBN8h1gfD8CJqJ5ZfS+QAqY8mrL2X?=
 =?us-ascii?Q?AXM5UKdb5gae3UD96eLYizbtdoN/8TET5DdTWQbxEyJNAS8DvBoPUpwJ3sa3?=
 =?us-ascii?Q?aW2feQ55M7lKmx4abFi4KLCBGTs4Z3SvZvDxWPkR6hbsKCXsu+MWsFGtgZo0?=
 =?us-ascii?Q?mbR7v59oIAdxpkWZ+nX1BTFZFNqdTyoSJz48Jz19MILQGI/hkcPrlZsbG0mW?=
 =?us-ascii?Q?baouo4p/M26vpx/QqD7xCZNedNyOU1W1X0ClyOdxi8uGTCdRzUv7N0clJvXJ?=
 =?us-ascii?Q?QNTWem2qzxNPNho6geOHZ5HSEPjlAMkqPsg0NBcAP5xD1KheHiLx+yD/bUP9?=
 =?us-ascii?Q?ZlaxZ7/RSQvak5fwKPUc3BKDKvXv8R+jfOONGxK+i4HOlIM9XHPdwuM0FsjE?=
 =?us-ascii?Q?EkMCh6ZJrVEnUXSEQ9oUtaEGQy0K1LK5lhF8nqOtR5auAiYMtol9kR4+F0Dk?=
 =?us-ascii?Q?HlYKWletNf7Nw/kMPkED4zM4M6rY6UbOmjFuVAV+XsCzTu4JuNGF/aSk5QLv?=
 =?us-ascii?Q?gJpWAi0QHbl83tIYJuk7tWkDMac0SxvoN+krJZ2pi7mgg+byv8yHKVaA5TMP?=
 =?us-ascii?Q?94kD3z1SrMeBcaEHrnXKCvNR/pWLgZVg/+sgnROfUwdeV33KHTYAvc9/+HNl?=
 =?us-ascii?Q?uADhojJuv+fCBiUQm3iC1rpKD/eTrwSKe8PhumUh2S1hd/5EtEy2QMTDRked?=
 =?us-ascii?Q?8/jIA4/UeuY0nMVe0sgSstE7l4j0nGa8CzFrHJ9G39sdQ9QPtRa4g7DsXj35?=
 =?us-ascii?Q?/J6FL3KxC9yS3/c1wub5P1hVwlT9UZAG9bf9HJbZxd9eC9RgDXea6vlE/UBL?=
 =?us-ascii?Q?MOpxdNhbHgBgJw7zWYVx32vjpCOGLQo1mi4seOpwRwPWyE8LprF6DfpYuJWy?=
 =?us-ascii?Q?EeZqSKihiSEh2QpddkSC3CWUksE9ybaoJoJDv2ye0Bu2AGmNkspicDT05sVf?=
 =?us-ascii?Q?48V7Hxv6JVJyxCbRVo3ptp6JLPK5ITkrrDZElYrs5NQ2Rlkyt4UkHqoW+K63?=
 =?us-ascii?Q?aX97WYhFkDL4ThRdladTskJWXPjLUdNGELeJJiNy6Hhv5NTx4wGhRYVd/RJt?=
 =?us-ascii?Q?X7BIznXk+SlmSZCajhyaszlonPRYH2QAGQ/Yls5csuM7M5IGqpPu8m6rAcRO?=
 =?us-ascii?Q?2wrvL1TFZ0kgD2c/s2pcseyqd/8OrrilNgZg1XarK3rD5xFHNrbVuffNVMel?=
 =?us-ascii?Q?eZuGFO8Ka9ni2PkcUgk=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7117bb99-43e1-4b1d-e08d-08ddea22119c
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 13:10:20.3654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DLe1a52AY2K8uUnh4GVA5KL57pEi8f9OrXaaYM+QgST2ksLknd+FfCx1ubZnfHam
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6458

On Wed, Aug 20, 2025 at 11:30:03AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h |  2 ++
>  drivers/iommu/amd/iommu.c     | 11 +++++------
>  2 files changed, 7 insertions(+), 6 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

> -static int attach_device(struct device *dev,
> -			 struct protection_domain *domain)
> +int __amd_iommu_attach_device(struct device *dev, struct protection_domain *domain)

Though it would be nice to see a clearer name for this than __

Jason
