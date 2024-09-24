Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E354026AD0
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 20:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209922; cv=fail; b=Ynuw176MCSvIPcplX+FUBWoqmZa1oxEFbxfSRAbGshZtlSJpQdHM2CNnaiGtt7m+f8irjzrbQE4jWuKljDWtjiAokPmZXm4qpzOEIOJKZPRgN0ZKI/shrEWvbylOaOVpqTyGOlNtlutK1R+hZxYu3XxgqBx7uXJmadIsfnMq9VE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209922; c=relaxed/simple;
	bh=nYE272/9J4WkOkUxOieFE+efd/Pzu34b+9RE0YXQPyY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQH/lhBhrVkfnRlgEKMxnfTwB1NiIwkaGcAzamH8MF4bFa/v5tBmlNBfKsIa9JHNnqo8XDjnsqK0aZ+SCJYK4miyizIx0xHJbZaUCV92r/t8oyEV/Ks/+i5r2HtYs/XxVhfYMyVjjS6t+cK6Y4Uu+UCZatFO16850wDwNu9iuKE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GHWM5+7A; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GHWM5+7A"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVU7iY41SEP7IQchCJG7Y5M96O52PLhABDJtNLIR8Yulv8Sl5WoT07pi7K5TmSLCWkixoPLi+KzAANT1Dc0ab2WfBWTpiac3YAPsFwHCRxTExyb5rfGD1lZ2dwpJaoaOfcpVkRyJ1mQaBesAcVG6H7PeYzyjUo7729qDpQ7jGgRv1ec+cefrkTheIPZ1CJ2dfR5E+MjS5ZQJyuq7Ck9o+JL647qquyVjjaTh5eOf1y0XCX3DeChfK0nDfzHBoqB+b2cVeQ4cwKUYkS1iyjfA6TY0A9LesHwB90WcLrRDXxq+Rk+Od6PoM2xBF0NN/xIGblcGohyF78diZQWH4ajhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gSFg2wXBBWVLLkCCZoo2lCsU6/+qFpGui6K3Fg306hc=;
 b=KpqsFvwDxpSkaoMfP7BJoZmGMHHvxU/D5Ck7EIiZg/ewGs9eTPQOoM2BPyjD1HBVtcLNF9soMtuf2wAWs7L07UGefUAolsG8GGY4V2af0T2xNKlo+js2KLSQIt4rSkqvHxpaBm66YgJKLW+kna5qXKaI+b3OFKEVPyCzDoTrXYTbEnM4xQXd8dvH84F00VFVk2nkrfoYLwiUox4IoKVvPHmRk+SbAn+HPqvK/eJGDvKzgZLjdHGlsmdl4rpMls167emrBr/LeHYpq+NVKifyN63LgimcHHWwtUOqme/J4rIxfvGz/6IQvShln+Ad3AnrpQXq0dMJze41DJaDirnq/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gSFg2wXBBWVLLkCCZoo2lCsU6/+qFpGui6K3Fg306hc=;
 b=GHWM5+7A4ymJGtNDPPgyTGmEo/sKMgT0fYmF9JQEcQpLkm2pXlUcvQrkYlwWNy5vMrH7GLKjHFBPUJoBdRIiw2TL5mCyvYrb0+j5Sl7grDTzY7FP9Mb3zPEUT0B6SR1xoe+xaOreAerSVPkf+QlAg50j49dA98M8LCpKcx4o/1wN+rQtH6h1OyJZYhT5GP0Ccr+MrA6EyxfsN+TWJ1iuu8VP9q4bO8Tjqpi/N12j2wRGI+BWdEeNkgk3Lm/eWZtQFALCpkBiXdBC1Q5m8Zm7cd7jU9EKwc4VoUvK5QvwrJ1RORj0t14rgkq+9V9uKbQvNagTiAbwY7smVAB34TWbMg==
Received: from MN0PR02CA0004.namprd02.prod.outlook.com (2603:10b6:208:530::11)
 by SA1PR12MB5615.namprd12.prod.outlook.com (2603:10b6:806:229::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 20:31:56 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::2f) by MN0PR02CA0004.outlook.office365.com
 (2603:10b6:208:530::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Tue, 24 Sep 2024 20:31:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 20:31:56 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Sep
 2024 13:31:39 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Sep
 2024 13:31:39 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Sep 2024 13:31:38 -0700
Date: Tue, 24 Sep 2024 13:31:37 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V2 2/9] iommufd: generalize iopt_pages address
Message-ID: <ZvMhqXo5MQ24xVND@Asurada-Nvidia>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1727190338-385692-3-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA1PR12MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d852b5a-b573-4713-340b-08dcdcd7eefb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?L3PGUIjlYfW5CBhP8Zwfhm3nZdoV7+eXNX/jURWzhfvaTQ5sLlUydX21ypQg?=
 =?us-ascii?Q?AvBga3z9ZZYdxYoK4GyuQvGEQanpD4CLQfvMX7sY9gyh/PePIWPaGoaJYqbF?=
 =?us-ascii?Q?vpfnJzd0Jrw/pnqpbwnCqNK+RSYDe+spHUoIZcvd9f75h192gcrlUTXHNMu/?=
 =?us-ascii?Q?lhWPnbN3IDJgNleytHvFAZqBeTDpG6TuUmo+ookBQsMfXvqFK1KeGF4tsxze?=
 =?us-ascii?Q?UTApigz9TZRKzIPU8Xm/+eDbDWlXG049kDGNdhvwELAw3Vj1tmkDfeq+GJPp?=
 =?us-ascii?Q?Yg1GsJdrKoK4YjYj3Gx0GH5a3GsScJBYHlj1LSTN0lR5TXgylmQgaYHY1xaK?=
 =?us-ascii?Q?5YpI8lplAb78F9H4WlPKMUHZrHUTDQvnHyTKiAIlodIMpRYu+sd8jDYRA2Pg?=
 =?us-ascii?Q?koi1URbiDBfNOE+hG6FPhjP9YANZo/fJkeyN04bSwISvaWYQaJVVCtrwBvya?=
 =?us-ascii?Q?7yhcx2upJM1Tn38Wb/kR4BRKvLdsRhfgPcNPwVNR8UXqpxPJmLL/kiciNH8G?=
 =?us-ascii?Q?CRjwOZi4V+YfrK4+TcT3XWYzxHQe9bAs0rjIRw/khOXF6j643AjP9cUTMnBa?=
 =?us-ascii?Q?wXDWnel45g7+UnuGwtPIpUM6xlT4/5OU0iZCsUDOwVK5iURej48W9jXq8R5s?=
 =?us-ascii?Q?kcQDOhmUHstAwMwyQtzWWMBDFKAGNTuEmzJcYLZbu9xgIpQTDJbBBeLrQw7j?=
 =?us-ascii?Q?JEvG0kE/O7sCSpSEOln9mM0c8ShLX3S18Dw9oiRyhzUWRbx7wbzEIqVZBUv5?=
 =?us-ascii?Q?80jcGZ2fzxRn9L5nN9dDizEnXRj78FMblPYue57YTKrgIjF0zxmqGgPxZKRy?=
 =?us-ascii?Q?en2gR/Aqk97uIlVgNvoJGz57b8cNcsQtIhm4b4X90ZtRiLARoD0nAx7W8kjQ?=
 =?us-ascii?Q?7xjOdx8gAxxzvu03RDhRCAZdf48W2OCmpIpKQaPL0ErrcRU6g+eryTS1L2ex?=
 =?us-ascii?Q?S8JWg2ms4ex90TtyHtIPi9WySeT+NTKnOcQQeL6paVdESIErDpzhOOsMLLqq?=
 =?us-ascii?Q?ngRKEq60ZERNm3Igy50LHBQMAp+Ek0M/w0rktMsRwxlQj37LHnHUGDY2v3ZA?=
 =?us-ascii?Q?fJRk3W3PX3vjw2AcT1VNf9h56W62c9mTIrvKHvGrMHK8tV4+ZxcQE1gQ+rsb?=
 =?us-ascii?Q?Z3qsIeVZHGMcTr+QCtv+XrlXsWacyyqL4UVqAOBaGNE0biqMF0L/6Q6YM4Zm?=
 =?us-ascii?Q?IxWvnDdaZFv0ose1QPde1SSOmzv791oqIPj1kBc7yVHGqnsNS8hsYKGsD7XE?=
 =?us-ascii?Q?IVLDtFQuk5lRCUgCjxjp5pH4C3/0O9x4xKocmSyovnMUSIgOqioPbrovAzdO?=
 =?us-ascii?Q?ZQw2NSTr79hwZBsNaqaOfxEtxpLYKgIFA+I2wwBU3bi+9Ebt2vgDkhWgS9oy?=
 =?us-ascii?Q?Hftru25LxCZko0LvcO6T/N+tAE/AMC50QiViHBSZKAJ6PG4vG+Mkwd9cgTVW?=
 =?us-ascii?Q?8UGjzwPKNhySD/cGU5VsXRCnmab5ugqU?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 20:31:56.3256
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d852b5a-b573-4713-340b-08dcdcd7eefb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5615

Hi Steve,

Some nitpickings.

On Tue, Sep 24, 2024 at 08:05:31AM -0700, Steve Sistare wrote:
> +static int iopt_map_common(struct iommufd_ctx *ictx,
> +			     struct io_pagetable *iopt,
> +                          struct iopt_pages *pages,
> +                          unsigned long *iova,
> +                          unsigned long length,
> +                          unsigned long start_byte,
> +                          int iommu_prot,
> +                          unsigned int flags)

I think we should follow the existing coding style by combining
lines that could fit within 80 characters each.

>  /**
>   * iopt_map_user_pages() - Map a user VA to an iova in the io page table
>   * @ictx: iommufd_ctx the iopt is part of
> @@ -399,29 +431,15 @@ int iopt_map_user_pages(struct iommufd_ctx *ictx, struct io_pagetable *iopt,
>                         unsigned long length, int iommu_prot,
>                         unsigned int flags)
>  {
[...]
> -       return 0;
> +       return iopt_map_common(ictx, iopt, pages, iova, length,
> +                              uptr - pages->uptr,
> +                              iommu_prot, flags);

The last line could fit into the previous one.

> +enum iopt_address_type {
> +       IOPT_ADDRESS_USER = 0,
> +};
> +
>  /*
>   * This holds a pinned page list for multiple areas of IO address space. The
>   * pages always originate from a linear chunk of userspace VA. Multiple
> @@ -195,7 +199,10 @@ struct iopt_pages {
>         struct task_struct *source_task;
>         struct mm_struct *source_mm;
>         struct user_struct *source_user;
> -       void __user *uptr;
> +       enum iopt_address_type type;
> +       union {
> +               void __user *uptr;              /* IOPT_ADDRESS_USER */
> +       };
>         bool writable:1;
>         u8 account_mode;

We only have one line in the kdoc mentioning the "address" word.
So, I personally prefer "iopt_pages_type" and "IOPT_PAGES_USER",
matching with existing functions iopt_alloc/map_user_pages also.

> +struct iopt_pages *iopt_alloc_user_pages(void __user *uptr,
> +                                        unsigned long length, bool writable)
> +{
> +       struct iopt_pages *pages;
> +       unsigned long end;
> +       void __user *uptr_down = (void __user *) ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);

+	void __user *uptr_aligned =
+		(void __user *) ALIGN_DOWN((uintptr_t)uptr, PAGE_SIZE);
+       struct iopt_pages *pages;
+       unsigned long end;

Thanks
Nicolin
