Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2086.outbound.protection.outlook.com [40.107.93.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9392E13FD86
	for <iommu@lists.linux.dev>; Tue, 24 Sep 2024 20:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727211257; cv=fail; b=asGhyNQVTMejZA6cUkEplyPkkgVEyXUopqcNDpzKMgGt+oS9mQtXeEQGmmj8LFaV909ZiS0br/t7/UMEvT8IXZ7Do0HrWImSqHWKGXang2pL6QRaExwK4+2kSvgkzQAZnqqmEk2e7Kbyh/tgzQ6keibUnvSGpV3xer/l8uAHDUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727211257; c=relaxed/simple;
	bh=TZ3VJEd5AJ2ycdI9uaXbKxNpPzcR+zMqS/AX+7gTWtU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RwsoN4rfVJxBZDVW1vkNvfY9zOkTnZFaCEnGQVnjeXd7DsI5+37h1daQRG8CrsmI6GfoMHIUYuDiNGtG2CxJPcFSEsjH2zsjXFcebV/VDA4/G9GATiztClHsQqWLH7hMcz7GZqjCn1x7cAEI0ElWNwWtyCQeS4sWF9+wVOrynAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C+0Yz2qG; arc=fail smtp.client-ip=40.107.93.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C+0Yz2qG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfEYfQJOFUicbftc6TeHiqDC7I30P6C0aEOuQFbYL4y8oBapfvMOur6ZifNstdcneSiB2vfaUdJ2Kl4TTNqO/Qiwy0YyxUKMjauJO/Cb+53rwGZxzPDmFlUu/0PZ90Nu+rbo3R6+Yx4qBSTrZ6oK9zBChGTOTTHkjfYDxJQzFRKPlk5sv17gTmZ9rbLk1PcavOU7zGIS2E6ltlxnfSc4dFuDDkIYVSIomKbLOEWxCDsUIUJ98j03j88J3cEMzbepbCGsvQnz9ambiNfif9/VB0efRWwOGY5jhl1K8qUa+RDIsnxP+eq4BdBpqueoF9S7/GsCajBac5FHoG+Dkxk0sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dr2erQqZoKAJzbqH/ZCcDv7dc0cEcqdw2bdjpVqc4AE=;
 b=K/iIWKTRNOR22GonVq+/WUCf+e8HvJVzUf7BwxlbC5TDBAMiJjNCaMH1l1G8Tn7tkkQx5Kbo678nYYVhW456+b4HU1mf8zbOhpDWhHF3m1ibYnCuv6SAXYAKHWK+qhRJy2Gv1WvHID8NESgQGiOkFu2myKpb6TmGjSzIsxDqxRMhUh0ZXxU/S17paDx1rGS4UY9hZ8Mbb/mqy8PRcY3Bnnns72wOK1g7rZJ64Wwf9Vdze8BRhtXXTgoH5yrfPGlp0PrZxEO/3zsb3aoLLK5zQbRHJaIEpdAWOwBG5fVwh1QRMdpdaKBP0v0wbkQB/1T8K8oH3lmQ87hfgDwDhJ1bpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dr2erQqZoKAJzbqH/ZCcDv7dc0cEcqdw2bdjpVqc4AE=;
 b=C+0Yz2qG34ZmxBZThiZR7pchVYeUsyc0w6lEE09STay1uV8XJwUmYKpAY3V4OWW6fDF4ABmN4imRQB6+Pz7O/eiCRY9dfRDCJiBZ0Z7MzyfMe2NRvXoduNIydi29vdBki5oKwYn19Yw0gB//WFxUCAeGZFkiL4dvgm0BruuCAOX4WYthWNybriVJY0jv0+D99dtf8hfmOP9JPCHSaciejsDjS23GSPvr3zEqdvGtEz2z3LBs6eKo7KVpbmU4BumYmlPt7QvzASSeE1vGWjpK/LzSL1lklVNVARoNxcMX00EGqqa998n/RsJle/EX/rBtgC/5V7ehrHINWvtJPUmnEw==
Received: from SN4PR0501CA0038.namprd05.prod.outlook.com
 (2603:10b6:803:41::15) by MN0PR12MB6150.namprd12.prod.outlook.com
 (2603:10b6:208:3c6::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 20:54:11 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:803:41:cafe::47) by SN4PR0501CA0038.outlook.office365.com
 (2603:10b6:803:41::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Tue, 24 Sep 2024 20:54:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 20:54:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Sep
 2024 13:53:58 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 24 Sep
 2024 13:53:57 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 24 Sep 2024 13:53:57 -0700
Date: Tue, 24 Sep 2024 13:53:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Steve Sistare <steven.sistare@oracle.com>
CC: <iommu@lists.linux.dev>, Jason Gunthorpe <jgg@nvidia.com>, Kevin Tian
	<kevin.tian@intel.com>
Subject: Re: [PATCH V2 3/9] iommufd: pfn reader for file mappings
Message-ID: <ZvMm4xH+2xkeXO0G@Asurada-Nvidia>
References: <1727190338-385692-1-git-send-email-steven.sistare@oracle.com>
 <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1727190338-385692-4-git-send-email-steven.sistare@oracle.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: 623065ff-dbd4-4aa8-647d-08dcdcdb0aa5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mnm37nY8Qf5Z440AjqmAicE4dliBDLPOctK25Qyh1sivewVyDjJJQV9RJk48?=
 =?us-ascii?Q?HZjGH/Rgr1MTDmvrPtpWaOE6fzCdxI3/JBIduko2l0EDFqvyjlzF0NNhBcLf?=
 =?us-ascii?Q?NVXdQ2g9nt39jVGXMDjrMle4gZTXYZ/VuaAZPK4MtbKxEUjaoB4Ir8b09c4f?=
 =?us-ascii?Q?Ck/E/s+KBiI7eyAEyiYXMzVXPmD9b11RWHVGN8KGHPIYnff3rr9Z5VupGscM?=
 =?us-ascii?Q?attMynMPbAQDPj7MtrzbBgj7WU92B8/RDaaqY1PvPyMhPBdgvuKq5EVJVvAj?=
 =?us-ascii?Q?AgArcFGf5zJJw+oARddPWc+JSM1e1GlLtbIermFF8CfZwRtjk50HyWumsIQI?=
 =?us-ascii?Q?Ekzt/KrXdIgJx3M5ceCwvOsrK3MtAyO7heiTZykh7M159892DQuQHUf+blG1?=
 =?us-ascii?Q?yU8r0qDbR1MtRAWa3UHQTbyzbx3mWC0JV3SAQVharPd/nTtKK0vT9E0HJX6Q?=
 =?us-ascii?Q?k76abb2muDs8TWzVQ31c4HsvRI8hRwCvJQjqI95LlK2GUxiw8iVe+QDceM9g?=
 =?us-ascii?Q?c8+n9NGPT+qWL19oCxvaYtUMZwv02oayWIP8EVUiJ+wkIkg4Nt9qbTBHKgd+?=
 =?us-ascii?Q?8UChmPKpz7HCRSeCMcleHW/4Kc5Q5OiWjvzFPFgxopJPxX0L8gD5YHYRu16S?=
 =?us-ascii?Q?6/XXJTKVOUbRJWUSzG2N3sguyLRvqxnWFzPL9UddV/S8fFhMBSAe6F1lVn6s?=
 =?us-ascii?Q?bjH8m/XTGXNCwrnZn7EoDQSGOcCbeGfPhKfuyikq9LQ6cYRoFhKeRnkP4WtS?=
 =?us-ascii?Q?PmFqB4HVJXrMFIeHHaKDHbSseqn8vn1NeDlvVM/Juc+HKbop2TN1RoyfaGox?=
 =?us-ascii?Q?3kvVnAXjEWk/wybpxZoTImqpTXnHlVXoyaRZKrzzy6llOatmijfIH1I5sNK5?=
 =?us-ascii?Q?4TsQgyzOJPNRK8hMtHBuIkZ12bgJTzy6X1cjtPoZHNcofI+JTHi7b92S3o0D?=
 =?us-ascii?Q?NzVOPKKpbP1OQowQM1qZfyBSgU7JS3cXW51wWvT84+ScltYPXXQxY5spK3Rh?=
 =?us-ascii?Q?7CtlmMAb37Km8B8QJDPSPhMznzvU+K4LU1XXH6xzBiWuDkjvJnJW0rIXKGZT?=
 =?us-ascii?Q?VunPrGY9ByNEr1PNB/KQY5uXxX3W6LgAYYFB4P0yjDHy/QcKk04+UgRz9O3S?=
 =?us-ascii?Q?yWbNuuIFtqiwWwPckrJ890Mc12YLs9bduT4ElZOZBVV7nvNqp5FS9Y+CGuXg?=
 =?us-ascii?Q?dBwtEjt4PHs1vvDlQLlHkAcvsoFhJB4cQdvETRQKKmTxu7qJ2gGCvlrR6gsK?=
 =?us-ascii?Q?epPE88kDqoUiUMef+3COkCNjgAk5Ur2pAtU1Kid3PM/mTVhOz95/iR3g1Rvt?=
 =?us-ascii?Q?kDaFcLOK7ZWm0wws9jCt8r9K4eleE7bxlxiJcIGvVF1l/o3ANI8QO7KPVyxP?=
 =?us-ascii?Q?clwMUVV4pmGAAxHMBEgyPHneJGu9?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 20:54:11.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 623065ff-dbd4-4aa8-647d-08dcdcdb0aa5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150

On Tue, Sep 24, 2024 at 08:05:32AM -0700, Steve Sistare wrote:

> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 69822d4..df5ba4f 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -703,19 +703,28 @@ struct pfn_reader_user {
>          * neither
>          */
>         int locked;
> +
> +       /* The following are only valid if file != NULL. */
> +       struct file *file;
> +       struct folio **ufolios;
> +       unsigned long ufolios_len;
>  };

I am not 100% sure. Yet, given the comments at pfn_reader_user:
	/* pfn_reader_user is just the pin_user_pages() path */
which FILE doesn't use, I think we might need a pfn_reader_file
with own set of helpers:
	pfn_reader_file_init
	pfn_reader_file_destroy
	pfn_reader_file_pin
Then their callers should switch-case pages->type to select the
corresponding type of pfn_reader functions.

Maybe USER and FILE don't diff that much. But considering we'll
next add a PHYS type and none of them makes sense to PHYS, there
could be another layer of cleanup at these pfn_reader functions,
v.s. stuffing all FILE-related lines into pfn_reader_user.

Thanks
Nicolin
