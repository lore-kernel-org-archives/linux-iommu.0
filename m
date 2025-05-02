Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD54C1A5B87
	for <iommu@lists.linux.dev>; Fri,  2 May 2025 19:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746215004; cv=fail; b=IG9sr6WL4JIH23ZNEm9NKmybIPH1PvL6Q1w5uXtLWO1IDlxxzCvfaeeyu6Ulz1VweQechaNvUxVU8SfHHPgJQbQ1nZy5mT3zGhhjO4hTENUvIMOo2PhEy9pLowSuItWUui1kDCZ2BjLGTOAWOydn9A1jdrIP7RigZoiNP78ToZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746215004; c=relaxed/simple;
	bh=PKFkmUbclBqwPZk7oZjaXGXF/RnOOwInEZeTIR9798k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLiLJNGTphHsjhWCgsDO1RtF0+GCrhQ5c6ac+bcJUcAa0B8u7G66CLzYyYIVdyyLmvefROq7NmFsJmyUzmsgUFwwu3Dk9HHoxTiEI5TKoBRLVoAFEFWaDbVRLsZGVRCRSzGUDqbieLIcUvnu4EFmI6i8eMFo/J05rSfENbdoGZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=E/TcKo54; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="E/TcKo54"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sNSjZRIJiakoOiNBCIl5NhMeVjWphGRolAQZrdeWx2HOQIq57ksnbIizEt4ZDWIAW5sa/xdG/U7vWU9oqC1+CxmUMacZUri7HJVIyTWGEvXq56H1ITK0T7A4xjx2dcL1bnW+iCpVrETcISrlHvuEVbOE54aUXAjJM8NKza3XmB3H7pnegYdYuXkq0kJAtR8lPSYbwI7W4qYvmeUMQupyBomxVLy75PM+i637rOM0sArZywy9MKvGYXPnl3U5MbGnqMqNP/rU6VnzPGjV2Qn1/GxuO8jTVG7uBnOdi1YNnT31jgL68mf3hF/jG9VQLLX68tgg83qbZCQ1tm7sf2tutw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZCGIIThcwi9M83v2FHkPJfzfB7FUF6cbvN6K3VosAMc=;
 b=RVEvbYIUzduf2xk5vGwAlFM5h939zQR7KsYn2Np01kQnWI95JQu8Ku/uOWDGm9Wz+A+Vn+cINxyUGXOYn2mJinppEw5r4i2GE1HBrmz6JtkGxcPAPDJwvHt0B2LiWBBLMUWJaMYFheRH4u5XEUO9yiYxcm4LjIwzchWoOHl1KaNLsjc7tYcW1RcFH38PhbeltBFKeJUdF51pkbryi5ubNLYP2I0jbi0O7h/xNICxMjkWmwBe8iY8Jp3mqjcnElVL8owBVbrNd0M2GRjSihco/7g+SGNFpoLwOMA1qIY1tP/D1yKBfec+oKTbWtFrC0pFQRyZPqfHVp1LdrbOM93Irg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZCGIIThcwi9M83v2FHkPJfzfB7FUF6cbvN6K3VosAMc=;
 b=E/TcKo54kqNejv024zz0xzQ8FiBEWlY8vfMMx8YbtXHknyYwz9L9Jg5HiVFT/G28pExT/jR1gRYNz3FmMFqecGbEaABYqdcdY60peQzqIZunCN0hXQu28wqyQo6+/NSW/dSLaodEJ0MclydiA59Eg0GBlTQ+HOHysNOy24Kj/jFpegypT2ElxJHfTNGkP1QoNa3qmCzrGz5blq+19OalGzilM2hGRVSxN/Xzk5svcjUpJMYOdQR7FtclWyF3Y1RADqGrJHJh3NCsgPbpKhiKdrw1Y5fNygT3RBqUXYCkCaiH8akylz2UONpO5UGGfMblr9aJhgkuQxAqMdA9tvOkfg==
Received: from BN1PR10CA0001.namprd10.prod.outlook.com (2603:10b6:408:e0::6)
 by MW6PR12MB9000.namprd12.prod.outlook.com (2603:10b6:303:24b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Fri, 2 May
 2025 19:43:19 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:e0:cafe::39) by BN1PR10CA0001.outlook.office365.com
 (2603:10b6:408:e0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Fri,
 2 May 2025 19:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20 via Frontend Transport; Fri, 2 May 2025 19:43:18 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 2 May 2025
 12:43:06 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 2 May
 2025 12:43:05 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 2 May 2025 12:43:05 -0700
Date: Fri, 2 May 2025 12:43:03 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, "Robin
 Murphy" <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Mostafa Saleh
	<smostafa@google.com>, Daniel Mentz <danielmentz@google.com>,
	<iommu@lists.linux.dev>
Subject: Re: [RFC PATCH v2 04/10] iommu/arm-smmu-v3: Cache and restore MSI
 config
Message-ID: <aBUgRyT/nno2MNHk@Asurada-Nvidia>
References: <20250418233409.3926715-1-praan@google.com>
 <20250418233409.3926715-5-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250418233409.3926715-5-praan@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MW6PR12MB9000:EE_
X-MS-Office365-Filtering-Correlation-Id: 262f9ee5-137a-4f51-1ca6-08dd89b196a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lLj37BmHZ9lkwehzChjLdLEDslTL9cy77QE79XUWfsHmGiUGmVQhg2bxyLV7?=
 =?us-ascii?Q?mVh0rswfzdmJOJcngrS1QkhxupIt+s8o8XmWdg5cd1KTm3ikCnCOTPzQEhyh?=
 =?us-ascii?Q?Ujja1f/tAS51GNNAZD6UMfjejD+guMwN1oyGlAP9PO48NcY6LmhUzwX8vp3A?=
 =?us-ascii?Q?3veNatAkbOz1J4S4dRH9CQoPjDpdLNLLYqzZCyFxxp0ZXidYNm/NLvpd5yHv?=
 =?us-ascii?Q?2+L579wJr1BTpK4mOUkkQhBsuMiys6+x2ay3A++7E5TIWPFsQ8Acq55wrWfj?=
 =?us-ascii?Q?/7hr5ecUiJGxXj0Bvv4Q2Q84ClTKITWQSuvB7PWC8d1XYgQxziDeMcKoS1+c?=
 =?us-ascii?Q?PuNJ/kXymVGzohrE4AQiB6xAmqnPGik4XYFc8mAMdTTLTT1o6CpAJoKTBHmV?=
 =?us-ascii?Q?ldWqq5HpO6X6qkVv7bQOLPzaJ6Wdje5EwhQ9/RI36+bJ6br3/LtnumHDMJlF?=
 =?us-ascii?Q?1LSmcmtTuVRTy0JYyd6kc0V1j8pCQdknQcOjhbS1P9PRZUgN7BejDjqEYddD?=
 =?us-ascii?Q?DdvlIzpIV4KJfKTxxJ0xNYj6GYRGqnklXEnvMQVN8YvvyNVeUAvZjIrPgM36?=
 =?us-ascii?Q?zlopB4rZETfwgCWxUAKiec9O8FXzpu1L4HYfM6rPz/gbxqwg7qnwT9G+7DTH?=
 =?us-ascii?Q?5SarQz16NmIQP0dxl9YbE4Fe05qm0ThkbzR64kRxxlASJEDpCF4ZMrhRfofb?=
 =?us-ascii?Q?NDTNdGeID06HJceGTMUCkblaRW4SAilHeNIlVu7vPo2r59OGLKDWhQkj3riq?=
 =?us-ascii?Q?9Ka1Sd+YIP4Nn2FjAUXHdmlPHwb6GdIguNEnQmdGqvegRH3VxOJ1GiD3e3dF?=
 =?us-ascii?Q?FmOIcLeeIGZKGMmekTg3msEI+eNdeRjf06hzsrj0YpvkrXIPGoIdEPMJadLh?=
 =?us-ascii?Q?LDcr2EGeu46U8wQC0ysL+gfu3j6OH4BlDdG9d2AKVBbjgQOKRjCcmn1xiUYn?=
 =?us-ascii?Q?GttbZ6uCXxzjNRgS63JAKw8he/bVRWgpC71tjZwXqrrEPrm21rIzTsKcUxkf?=
 =?us-ascii?Q?N83EkzAVIu3C1bSGcPHBMLYnHidg+tLV6YMw31ueL444lRRaOv+gJiby03+o?=
 =?us-ascii?Q?Xv2KHD878FVJogQDu5CUm9WDfESwojnUcbWXqOZvLV6sTAsKsbILlc66mZ4D?=
 =?us-ascii?Q?ek/0A58tVbYwm6uXN08EXT9HTpqIhHAMvDv8SFgwd0zJQY65kpTbh3SqMZBv?=
 =?us-ascii?Q?sMxWftlq6WN9pYA+ONhPeR8jKMnreYUd4PTYX2Fh7L/MUMKKf3lT4sowNRTZ?=
 =?us-ascii?Q?Sn9aJvnYFtENbfDeKXErvdlzZHpcYTEd6Gk77C/XnojscbnzAtDJakYlznS3?=
 =?us-ascii?Q?dYQoUV5jlBNHdHLv8MtKPulOHAM6YjSPFtFDGR4QRSxtJ+RIvYtH0RkS8J0B?=
 =?us-ascii?Q?APWIwAijeESAhlFpFyh27y7Do9yrkrhrqJCHtovuZj7eXniHvrfO7UDrIQ5D?=
 =?us-ascii?Q?eMP7Mu6CiqKP/zq7nsXr8zBwTUnWL0P3Pjn+AMrUQbv7KZTloNK3JlOwstyg?=
 =?us-ascii?Q?/MGOUlhn6M0jNBaMzPWSkbyZSDPt73jObY+v?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 19:43:18.3777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 262f9ee5-137a-4f51-1ca6-08dd89b196a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9000

On Fri, Apr 18, 2025 at 11:34:03PM +0000, Pranjal Shrivastava wrote:
> +	desc = irq_get_msi_desc(smmu->evtq.q.irq);
> +	if (desc) {
> +		get_cached_msi_msg(smmu->evtq.q.irq, &msg);
> +		arm_smmu_write_msi_msg(desc, &msg);
> +	} else {
> +		dev_err(smmu->dev, "Failed to resume evtq msi");
> +	}

Do we need to check if (smmu->evtq.q.irq) at the top?

And same question to the other irqs.

Thanks
Nicolin
