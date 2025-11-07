Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011062.outbound.protection.outlook.com [52.101.52.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943231E9B0D
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544757; cv=fail; b=h0shTJ0NwUkfmluezU3/DiNDjfCmr6Mx+do1GTn2Gj2EgY7TXgzNuyKnE1FcVS6LqbXS4J4W5J4GhL2R2nSRQtLITx83J50Y/ixvBNp6p8ZniFfA8Q99OfpHfmeNiFMhS8CflPUYH3bM6NW5MBcweeeudJiqn2XG58ueaX1nmjc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544757; c=relaxed/simple;
	bh=+3c3rvIfAQnYUc35fEOovYmMEF5FaaMPWbaLV9GLIHY=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haKTrghfaZPBafrmIVEZp0m2tlWa7/A3eKsNRHJpeWxxpfMne/O2U9dSsY1a3GNJcW8oJ8NRCXQiTzzQ6SZsANf0/HnUdesxVl/f4zeqbVQDUT+V8GGXn4MfOTzq7cjOmziH7Pe6y7ljuvOmOzNWCguPwepkPYVgscG2AFKjzUE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PD8oE/ul; arc=fail smtp.client-ip=52.101.52.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PD8oE/ul"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1O66+b4kFb+dhfYLAhYoj+I8dUaZiM+m2CeUqupjubaczJBZ/coffKwpSZPhqXT28VRlkKpjcSfvhwnxnxN81P/q+xcUsuw5CLy/rcWPjxA+mpvE0WvCsZ0nAGOLdb7XafMrn43SLKCjUcsxNSbol/7yw8eCOOc/KsPGJtvSw2Ed8tA/BMxrGkddJZZRNkNutJZEutCStWp/xnlAAXz9Irnde/gx+ctvHNY8t1DnAJrBDq+TOBg8fJj+RrmdarEpmnCm09kbdDUPpx/C4hVZ99ufZ6pXQnEScZ7nTVaLaeq0Ew/72CkEgrWLwewaduPjY/ck753oNfC2YG9P7gRPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xbsx73ziLWM+uc7K6mSFexwRv1AKA38YsQrZfRs7Ies=;
 b=BMGHrc7SpG2ZhTNOuHpE/LlZZ/4dITT8+kpBXHxD0bCE/57SdAJoGpki1JMDOicMeyK99xGv3gapmVI/p8bWzbrMENt201+bXz55JSRUda6m+a5reS2qw/A+EcvFtkE5GT9fCzQyqabFEVSvlLd7gWgZE2KksMWC+p8b9aJX1KLzud/Ha/UhLhb2mAbYKZ3pxWzEiqj257UR0bIlRvthiTbSy3TvAikaoK36A69rXsnVUSyK2rjcEtqLigMNddCH1RC38lagBhNmNDQ85bXFAwuwULWu14/7Re3wBmX/5MQazchZB6+8U6E+SOSQhG6SsJJwl8yqjUv0VIDa6zaoQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xbsx73ziLWM+uc7K6mSFexwRv1AKA38YsQrZfRs7Ies=;
 b=PD8oE/uluKjN0cfxp8pvOWVUT4i4E0ZzgPBOhC5Cz/vaAjREtUtYl7zxbeCzY7P+Fw/nmco7mFn6T9PiFk1wUsclom/BKBxDbN9yLAT4jMdwhYM1f3avEWAh0bIgGR5OPZ7ubDl4O/FAY40rzuhbb9GypHHqVUijAQCg1b4dYCGH4VgOCax84Y+8kU7sQBB02aahGdmEnN/ewUHyS3MfFA4l2AzduuUhGfn+9DkxzcxMVfBVBpdvd8z3CECer8nMBvpRr88RieQbB4nIVpFRaWy90rJKL9KJE4j0W2rqpFZZhAFwhTzbtEV04ipuuQqRup/d456FuBD8YAckVNx1Sw==
Received: from DS7PR06CA0047.namprd06.prod.outlook.com (2603:10b6:8:54::27) by
 PH7PR12MB8796.namprd12.prod.outlook.com (2603:10b6:510:272::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 19:45:49 +0000
Received: from CY4PEPF0000E9DA.namprd05.prod.outlook.com
 (2603:10b6:8:54:cafe::81) by DS7PR06CA0047.outlook.office365.com
 (2603:10b6:8:54::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.19 via Frontend Transport; Fri,
 7 Nov 2025 19:45:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9DA.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Fri, 7 Nov 2025 19:45:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 7 Nov
 2025 11:45:29 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Fri, 7 Nov 2025 11:45:28 -0800
Received: from Asurada-Nvidia (10.127.8.11) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 7 Nov 2025 11:45:28 -0800
Date: Fri, 7 Nov 2025 11:45:27 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ryan Huang <tzukui@google.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Joerg
 Roedel" <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, Pranjal
 Shrivastava <praan@google.com>, Kevin Tian <kevin.tian@intel.com>, Lu Baolu
	<baolu.lu@linux.intel.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Daniel Mentz
	<danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix error check in
 arm_smmu_alloc_cd_tables
Message-ID: <aQ5MV0I6hMjVCF63@Asurada-Nvidia>
References: <20251107190917.2858684-1-tzukui@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251107190917.2858684-1-tzukui@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9DA:EE_|PH7PR12MB8796:EE_
X-MS-Office365-Filtering-Correlation-Id: 80a96d0a-3ccf-4645-157d-08de1e36403e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NP9GRzYDg46D29cHlzKXvzDXuKDpWp+6Z2GhxZjO/XrnqtdXjP7wLB6Jfpw0?=
 =?us-ascii?Q?fxUg7aRbX8Oi1mthAnnU3OglkIl6wWHWS8+7aThJsTwrjeo77q8c0CwrHeJb?=
 =?us-ascii?Q?MpcPYk26JO2g8gKQAV7f0XaFncW+5xK0a/qjgxFlwCqRPvQNMul99XkWeyJr?=
 =?us-ascii?Q?FvQV0Ct7RXxY+VPyoL38JZN5QXc5kq+h9qc2l68BZDo0LYafhcV6fZ60RLW2?=
 =?us-ascii?Q?NtANo3TQDKPgFfRVUrk8BZgg1vdmdqA8ij2BRymO74JeSDM/0rgwnBlmhBvD?=
 =?us-ascii?Q?+GDDy0qzYiW7gS+N0pYWD9bjX06VuxqDqfPoeU5c/HKp9vJ44MT9VRBad0Lt?=
 =?us-ascii?Q?svt1aCsiaBJDl0krEQ5439IjZXSk+4cgaZAJ6OWtb+LAZfzsnKCi8uZj9lTo?=
 =?us-ascii?Q?5PgiojfwuEjATU8CNA6RwZ1sWZCrDWaRUFDW/jjOQiQpsKwxR9AW/HYl2VVf?=
 =?us-ascii?Q?CatRrDGSvOzC4PZhxAf6deo5q7Z/yzgDrdU2p177Mxw0L5PQJXx4MNl/e3Ua?=
 =?us-ascii?Q?qtXA4/rsIL3HZsBIs7wJxpWjOyqzCfFt4K3YyJ/L/yrPFP0EBJ34QQtZVdQU?=
 =?us-ascii?Q?PaOqEPU6OHGaAukshnUxl8sWSe0smQ18kPGWZ2YP3SS4YOSeqq+eBd9/dl+m?=
 =?us-ascii?Q?TArHHlyHp0klg5g+mPZkgoewSaXlzw347pSq2YGfrRiR27r+nujH79gwkMQt?=
 =?us-ascii?Q?65oI280qRQ3+1MJTBoEfFZDHj7Kn5m0lJ8NqCNvULYLyjb6uevLPOrwQWEhB?=
 =?us-ascii?Q?bOMFPQW1bBSCUcqi9VP9YEpvamczJ/X5gqgYU6/85ddd+vNUqBqG2Ls8+cGQ?=
 =?us-ascii?Q?6jqTgnkx9ORtFfRjw30l/nJaZgLeI6Fy46gAE5cn+uDjg099uEPbVZevA/dH?=
 =?us-ascii?Q?yywEarlSXRBTkmHzplxIPZbAYdCV8vDPmDBx3Z+0OwFfY2mZPB1tjYeRCcdU?=
 =?us-ascii?Q?T5fTyXGbhxPnpoycait1LsLZkx8MPFojgf+S7kDkvEmjgr+Hb/zO3Gddlkk5?=
 =?us-ascii?Q?+Ijs/UfRBUKVvjzniz3K4Sq7Y49gDeviFyfUUt8d/49MgNFeK983GMaJTrJz?=
 =?us-ascii?Q?2TvmuS3Sg8KcyaxYBGzXDnE0u4XM4SSnJzxfXnF9hDuVcs/gP7vV+ePGS/71?=
 =?us-ascii?Q?UTThoOm7QsKv+0vhvhyYtLLHW+VjLLUOQP2fc39F1Qk55Cm9MACpRkUD2nQv?=
 =?us-ascii?Q?UvK7Ta5caEu3Z05HtU005hTnrGj8aKY5aONXylqBrLZSp4ZVAP+hswiihYmF?=
 =?us-ascii?Q?ajxnHazgnePJMVWZTdBUa//cXOi+opeHblyXUGrDDHTZvzobUMpecjsB5AWl?=
 =?us-ascii?Q?OwDlUVIJHXidz92CFZc/Ih49rcVkhhd2+7ltjo5Ytkes6tnqy7bGbXMXvKi5?=
 =?us-ascii?Q?G0gvx+W10eLUkg9NhsxuzapWpjV5yicklLi3DfwwfewuTwJOWH4x0tlRHiHf?=
 =?us-ascii?Q?E/0Hym9f2/iRXAtKXhZN1bKLn/msvBPT57em8gRcEKVbiGCWdEFoEE3QSIwq?=
 =?us-ascii?Q?Gk0+RBBye8zJUNqiLMIcJ1/nIeWtoE3t75xYj45JKNNCyGlJBWYB8ZaOoal3?=
 =?us-ascii?Q?qcAWmaWjl8HMOTXYFmU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:45:48.7072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80a96d0a-3ccf-4645-157d-08de1e36403e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9DA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8796

On Fri, Nov 07, 2025 at 11:09:17AM -0800, Ryan Huang wrote:
> In arm_smmu_alloc_cd_tables(), the error check following the
> dma_alloc_coherent() for cd_table->l2.l1tab incorrectly tests
> cd_table->l2.l2ptrs.
> 
> This means an allocation failure for l1tab goes undetected, causing
> the function to return 0 (success) erroneously.
> 
> Correct the check to test cd_table->l2.l1tab.
> 
> Fixes: e3b1be2e73db ("iommu/arm-smmu-v3: Reorganize struct arm_smmu_ctx_desc_cfg")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Ryan Huang <tzukui@google.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
