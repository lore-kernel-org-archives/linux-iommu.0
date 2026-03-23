Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011045.outbound.protection.outlook.com [52.101.62.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CDA313E2C
	for <iommu@lists.linux.dev>; Mon, 23 Mar 2026 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774297113; cv=fail; b=AJDDeZBJ4B5luxYM1s4HhSJZjO/ElxnOZRBTwNJ4oM9z4h7sYVZ3LUqdGPXWuOAKThuHBFEGM7Me/qDEaIXRv3B7uABpbfnf94qyqBQZSHfoXPXYa5JEloBjfxkdpuZ8wHsj9WprjkNemapLQILEgY5Bx+mL1rP/JgoiAWER/h8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774297113; c=relaxed/simple;
	bh=R97elaHGnpepBDWW905xWLXOV0l8vdJNqA1rIOjEasQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap9mr4Y4JGVsDfIepGTJHVGo4RnK6Z5vbAwIkgsKjgQ+SGrjpZDn4022qL/6Yh6Gs7w5S8BCasuDWOc6Uy1MHkuGAnDLgD2R4ZqVXv59yY/kYpbjh2hZCtxMPS4yAYwPEdELiUESSddfdlpVdYhKQjSqR4bJpg4/Y+s0kbezf0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CaYZxnID; arc=fail smtp.client-ip=52.101.62.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CaYZxnID"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jo6IZvfhTWQHx4pqk7hm3SupKCI4MTyaOy5Zn/q6TiTArDU5v+WUnTAqPuf9yaeJ1f80BOTtBGtrJTb2bZhfeOlbORpBWe8wBAOS1PI5yyYwEcAK5xspBt+8ShcR2qsZ43cwi6aXxLn/pnpyqcYNTwZm1qSTOt0/j04s4+ObIpMOs0jUOP7XOC4muw1fcCA6Z8I7cD8UT591M6roa16Ky67Y7clDaCxTWMhi4gxZkYktbX9DhnqigGc5bZjAnAY1gTMifX9wIztVnSUrjpnxzDcK9hWxRCojBw/QcFit8KhajPYD6rAB7Zhqv6NR8BT09bGPBFcdBtF20Ps//k9EDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QCUkOwKsJT3SE8MeW/MEBFk4DgEfqWt8x+Q/nE/M6zE=;
 b=RxZhmQ5CkkLiIk49xKBG65DYLWQLb5VKtdbcJhg3OGj7WFl/bqlL2BRFRCIN0IgfiJV+kwMsiq6AeiZcwBbiPl6eFDAsdVWVr097KIYNvGq6htCNnWXlV5xa/fiH9ZWz0CRLcKN5bl93x6yZKo5VZKCxHUd8G394sxw3ku3igjQ2ofkxw3ZZh3mEkT7qE7oqb8jN4YfUZqFh/arv3sqmuVrNQMMTylbwwJCEpGBb+6p2O/iNtqmz9jpggyj8G0h5Pi7RzY393R8KTwKuj6Qnvdpd4pFebV9cvnXanUXurvyq28HSsbyWMR+ukAO+Mfsd6WEBMt8YkzBceX6htlxbvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCUkOwKsJT3SE8MeW/MEBFk4DgEfqWt8x+Q/nE/M6zE=;
 b=CaYZxnIDlPGj8hDgzGpWRShfJDOnCg8r6ETsvlIgHjzhn+I8LuBgVJlDzW+x8AGiwH9mbWNRQndqOYayU3Z8ij7YZ4yzmWNy6VY6b+HamZaACVis7yrhqlgq4nT+Lo9lq3mptDjDEaNn9Uar/lX6VxVqlL4+6GdKBjR4hg/b3X+maYUzjmAuvwRz2gjlGjeDRttNiFuUGUYEhygcEXQaMhxo5wOu6UwBXhPxgNIefhEaKBpmd4aaHq/3ItlM1MyajgcIbiFC/d9SGrf1m7oUbDpP5m+iI96gfRiHogH9ZRLi/IpvluyT//WJG6mDyEgZNTFZJ/z06nk5rTfuNiT6kA==
Received: from MN2PR18CA0007.namprd18.prod.outlook.com (2603:10b6:208:23c::12)
 by MN0PR12MB6003.namprd12.prod.outlook.com (2603:10b6:208:37f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 23 Mar
 2026 20:18:28 +0000
Received: from MN1PEPF0000ECDB.namprd02.prod.outlook.com
 (2603:10b6:208:23c:cafe::87) by MN2PR18CA0007.outlook.office365.com
 (2603:10b6:208:23c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Mon,
 23 Mar 2026 20:18:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECDB.mail.protection.outlook.com (10.167.242.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 20:18:27 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 13:18:07 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 23 Mar
 2026 13:18:06 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 23 Mar 2026 13:18:06 -0700
Date: Mon, 23 Mar 2026 13:18:04 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, <kevin.tian@intel.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <baolu.lu@linux.intel.com>,
	<jgg@nvidia.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<xueshuai@linux.alibaba.com>
Subject: Re: [PATCH rc v3] iommu: Fix nested
 pci_dev_reset_iommu_prepare/done()
Message-ID: <acGf/IksLZTTcXqf@Asurada-Nvidia>
References: <20260321223930.10836-1-nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260321223930.10836-1-nicolinc@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDB:EE_|MN0PR12MB6003:EE_
X-MS-Office365-Filtering-Correlation-Id: 60f5a710-2d2c-4596-5003-08de891957c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	YfZ2TwaRU2V33sBg0HYrvriOgU1HT3nJpvNtjLuLjF+c60gBFuqgsfZ7glkYHi/SpJg1nvgI02GFF86Bz5gtGSwOI04RSileq8XL93txMJxM0ZVl0HcveacTKgmQLZw+nsOl9xNRnfu98DdEQWhBZFiVeSLloEreZgpfGAYlXyJp8ssmlHNY7N0+4JCKtFBQv+FDl3/6ZpqwQUdvYzDJdh50ynX9A8iH1yM26DkrDsERxI67JUTIyuR6RY6E3KVZuXrhjETCIQxXDfiZYE60oH6+6uo5gfR3afk6qnwmyASXF3zEzCaqJCPT/XVqJPtFje0fYkxOds3gntD6vnqJXBJGkZ3UqJ89KZvQAiJ0+AgT3t/RKPcxhJdD+O40A9gYz4hRkSJBrPKt4dwjDR1p24Lpj0QnB9YHp8gMv5S9bap4LE6QmGZylMNc6Er2cfo4Yn4J1Q3o2vOZYKkdGmhyWerBrai5iEJSHDVz70Z9Vf+yE/9neXkNPUN7p+TxW9cLwuDJfSSbVZXa/IxAedK6mKw2SCr0haWh1RvPJWwY+BPN7Lk3nIdAWCC9VcmnGlctoJL8sbNetGkdSo++JYmdyIAGCftuLpGi7s25vfCC1MMWgIDenczOb7FL7JshWpU7oFP+MpUJBRUF0hExtPl10Vu22TWpwZIjcZsSpzi5g+C7Cii3GX6oZ8AFLVleSic2B97yq99io6Ogk1H9O/5PvSnEE+QFNOv/UAnbEvzdoSDvcQKheL4xfzBycao54d3+Wl/4WOoMM3L/p4S2cpcW8w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vxhKFa5rE8KF5DcnqMY565/+ACfC1HBE7SbmYGOQqwpaFNFSBcP2QBInudhQHBFehv4ecAv6m/pujlh2GiuNaRAH6H5KwxYkD3flDyAkn03Kmxzqt92eSjAgso15p3MHmEKdxJif6iNUOFHQKEvpTt+qCsSQOlv79o+7ghNYI2b8aiHs/ThE+Lr3Ll6v7RzPCdhs7Tkdx80yEVKRQUXD1Nmku7LThtrYCtKkjWIdcR8peKGQ2mzIKCsm5xdn+jAbakRsX/2qW1T+XjuF04x8m13OLBt+svjyD+QOix5jQ7cctVW/nqt61FpKwAzLFwpeGYRV5JS2/CccNpUzFwdj6V0LfKK7z6L5/dujn+OvMFdvk+eC6xmyaMXFy0vOLXW8ceoWrc2CH5kmU9I1zTI5N4txZiORAsgod7GloTe+O1wnsCyOo48owCAmNuZy/Bo3
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 20:18:27.1302
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f5a710-2d2c-4596-5003-08de891957c9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECDB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6003

On Sat, Mar 21, 2026 at 03:39:30PM -0700, Nicolin Chen wrote:
> @@ -61,14 +61,14 @@ struct iommu_group {
>  	int id;
>  	struct iommu_domain *default_domain;
>  	struct iommu_domain *blocking_domain;
> -	/*
> -	 * During a group device reset, @resetting_domain points to the physical
> -	 * domain, while @domain points to the attached domain before the reset.
> -	 */
> -	struct iommu_domain *resetting_domain;
>  	struct iommu_domain *domain;
>  	struct list_head entry;
>  	unsigned int owner_cnt;
> +	/*
> +	 * During a group device reset, @group is attached to @blocking_domain,
> +	 * while its @domain points to the attached domain before the reset.
> +	 */
> +	unsigned int reset_cnt;

I found an issue in the sequent gdev-quarantine series. To fix that,
we would end up with two counters in the iommu_group, which could be
merged if it was named properly in the first place.

So, I plan to rename this 'reset_cnt' to:
+       /*
+        * Number of devices in the group undergoing or awaiting recovery.
+        * If non-zero, concurrent domain attachments are rejected.
+        */
+       unsigned int recovery_cnt;

I will respin a v4 shortly with the renaming.

Thanks
Nicolin
