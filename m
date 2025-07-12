Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2047.outbound.protection.outlook.com [40.107.223.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EB414D2A0
	for <iommu@lists.linux.dev>; Sat, 12 Jul 2025 02:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752287261; cv=fail; b=ViCTUCk7ksp6gfd4wLaJZFoCu+wZ1XKoVckeisajpl/rSRE4oYsXnlBPADwrxD0yX2IUjKs5sxYuWhjcnnBSAd/Rinw+Xm4wWFcxjxRsHYRmlZ+Jegu8nE/bvr/6WLYwFfn7Kr+dlMUz06L83BSTeqet06G1cBV1JJIs3iazQ+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752287261; c=relaxed/simple;
	bh=Yul1dYfUHsV2l/PQJONgwK+Ig/lObLiHtuD+pjXqr6o=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h5b7A1WPWGdBV0UOzbhhsHtFrLC93lS8mtKRvXkiePXBvO3PCjT35pGUEAI9o53RFAGXrpuP4mIeg85rrMh8fU8bkzOpwP49rZyFgmB+5+2HpBkGF+Zf3K3DE3/gy2nQHFrqQfRPV/pZ3ruq87RjI5f8N5a4RkmihoahZJcT8Nw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=U32HdG9b; arc=fail smtp.client-ip=40.107.223.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="U32HdG9b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WvCQFvFZY5sRjK13ZieP9xY9tweziCZOrQ9yrAPluOQkZFVFwzmCPfyvLMDg3JOLIdnrxyI4wIVTwjDbPvc7jKa+3zd3ISYKcFfrqQ3WgjQZLXlDJiRVEsocTig2eV3Mntj48j5mzxMEFFvd4R4scTzlAAXFSZTDbPuk1jrQ/UcN9MYXULAbKg6p8zazEBnVXom0IzUSrFKbXM0V9TweFfanFnlSC8khJjaOyAlWXIY0KUtx+PTDEnTFSOrOIulqFI1O35AbAJ4p5h9im4AO1a0GWwOZ2NGV64jBos7D9hEm5fZcAUpSqeagFWTGNvYfhrklS99SbRj8/LuqfzqfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7B2HMt5hi1MtjXtswwdx6pDibhKicfz/P9NCwokGzRw=;
 b=kHKgMKoRSbc12Ou/qX30HqOqigyfkcctWcBozf1g5vPW7qCIVAuK4DZRGVb51LVywKv5o20KYUz3VVl5WAFowqRT9MePXH3i4CkEGPpgQgaEC5uCh4kC2cIWaT55/rx0QiDHd7nvH012NSuWuZKteQfl0y1CO3lf0hR7fe/i6VFq2Cfbfs2XUb/NHitgpKHaCDgUZ/Lspnlpd5QfWQQYqD+bcOy/0Ih2zZwziJjc8rB7r28ffqTjRRAJ0cre6Kuu76WGn7iP0kDc5DSTFtC5ePMgh+oz+jmRLlO7H0mTko9MS6OfoEKyVuvQJNck9eyqsLqSKI/FdQm9Bw/GPbLLNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7B2HMt5hi1MtjXtswwdx6pDibhKicfz/P9NCwokGzRw=;
 b=U32HdG9brJxOBzc3wk+rmTlq4lg3g/W5upG03LKpYUhl0vpwY/6zxykvgXDTiA69bHRGUYLoBRf9+ux/Wtg89Imslj3RogOWwXewhbNjLRPMntS09QlTjDCqvY3WzCYdbXXuss37LyxYd8qanFmmwNX9Nd3gqvEQChBa8vz22paLkJ9KeQpbC4o4KWhNnhv8Lw3m2pXPRzNxJG90pnTMiqkRb/uESN0fC0TDp47E34BpjG+8iDA5oMogxnkFi1KF1p3IbgletRv8jDSti2vLBaoIARyRc2CHM7WiuyZD/0TfxZT8QYrmJ5Hurhe22GqYK7E4aaj2nPG7NxHu//JgAg==
Received: from DS2PEPF00004567.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::509) by LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.29; Sat, 12 Jul
 2025 02:27:34 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:92f::1005:0:b) by DS2PEPF00004567.outlook.office365.com
 (2603:10b6:f:fc00::509) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.9 via Frontend Transport; Sat,
 12 Jul 2025 02:27:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Sat, 12 Jul 2025 02:27:34 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 11 Jul
 2025 19:27:32 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Fri, 11 Jul 2025 19:27:31 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 11 Jul 2025 19:27:31 -0700
Date: Fri, 11 Jul 2025 19:27:29 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Xu Yilun <yilun.xu@linux.intel.com>
CC: <jgg@nvidia.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<will@kernel.org>, <aneesh.kumar@kernel.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <robin.murphy@arm.com>,
	<shuah@kernel.org>, <aik@amd.com>, <dan.j.williams@intel.com>,
	<baolu.lu@linux.intel.com>, <yilun.xu@intel.com>
Subject: Re: [PATCH v4 5/7] iommufd/vdevice: Remove struct device reference
 from struct vdevice
Message-ID: <aHHIEWprY+AfJRas@Asurada-Nvidia>
References: <20250709040234.1773573-1-yilun.xu@linux.intel.com>
 <20250709040234.1773573-6-yilun.xu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250709040234.1773573-6-yilun.xu@linux.intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|LV2PR12MB5869:EE_
X-MS-Office365-Filtering-Correlation-Id: bca914d2-b9e1-48b5-457b-08ddc0eba915
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NHqUAZ2Kv4lfFAivva5lrAH0+2U4dlpXa9dO+Hz7JturKuu6Ac35P520tM3/?=
 =?us-ascii?Q?/tl9s8oNm1jaxkRW7I7LiSIVL550iBgwtbOPGI9QGqqSa7gQaZMy6T+uo3eG?=
 =?us-ascii?Q?2N6nVsyArQjTSAHAiiCy7tCErcKEbLqltca3Qqg/E8ycrqlDOgjY3P8KX/bZ?=
 =?us-ascii?Q?rY9RkkX9uW5eCNk3ldwioD1fkLeBnMgyt/6uuv9YcJkzSh9Pv1MqMm+FslU9?=
 =?us-ascii?Q?5FkzM+a9ihhxpYkSgZWSsVXPj9rynGnvoSbhiSHofwtElkwShWCdc0QSfjXw?=
 =?us-ascii?Q?GKqRBvzlH4m6KllLk6ShJCVDOQEbR4VifSSnjRDKmMhIu9nNin5LshrLy9Ep?=
 =?us-ascii?Q?czH8TaXJEWQbIZityL3mxqOc2GaZ9hCGxZwQ30EeRoNp76HQRkPddOzzpqzK?=
 =?us-ascii?Q?fPWDloPsKog+4QjxztYeaF1tvf6JifUVvsriS42OHiZwUqZ4vjruaJWPjVtr?=
 =?us-ascii?Q?wXzoOURb3Me4O2jE24fVJTAo1T3PM+UZSdzfjOveAVsAh0jBOMuZK97GBhAL?=
 =?us-ascii?Q?iOnXDfFe9vzZumtGVG5j8qULm4BsJDYZhKFrIMHCVNUIoiUF/zY2dCeWWWcp?=
 =?us-ascii?Q?QqDQAMbsx9nyGWTg3R9AkRYeIo7DGgkFFLQa2mwSF720KKi/l9hwY8y5cIk1?=
 =?us-ascii?Q?+bp57yyOq1N4SnUBaCjavkIWTHAkrIxac+My3znqLTjj22IfDprGrIJnXRGZ?=
 =?us-ascii?Q?keGv5c1OOekzJHlAQBwBz9AX920wMmpP8AKSsCS7AaDfk+9JJMYaoKzuOZYq?=
 =?us-ascii?Q?5Vw/cc2jZUISnr+4jjlOLrcqaFDu/RoJpnnwhxTRbKrPj4XIwJvu1YoNQdX2?=
 =?us-ascii?Q?yRjRTDjjv/K0GdsNpo5H13tz99GEfm0MIDDSfVDXurx5Pca8wA9Sjmx83kHw?=
 =?us-ascii?Q?E5ot6fR4XXSOR6XNscfSjenURpuY3RIoVRE/o9BvJx4GQIS0+OaS44MUPI5b?=
 =?us-ascii?Q?hZ0prUoX6nD5qsRQdD8CioIycg+IKXFQIfA72jSiDStudHua4GF9u9hxiw1Z?=
 =?us-ascii?Q?RvwcIq7oWkMyi0lQjQDm0B7pCJsgZGdTl8KwDPp7Y+xTpEbpPByna7IqolgM?=
 =?us-ascii?Q?4xrhTRn5X6PDZKg7JiwT473PWkdphL9SDw6ETUvXP8uQ92sWvJekZLi2WdZg?=
 =?us-ascii?Q?ccmbFWZizx6oK2CkGGp2keD8JiSIPwypgYt1hJ0X03CYa0oOXminpk7PB9C7?=
 =?us-ascii?Q?SM9xOf524aQj9S0NkMBjLaR4qvkNMn9/Gez6d4/s72CPoh97qU7EiRJULVY+?=
 =?us-ascii?Q?eGsVp6QxJCZtsFRB6zuyl6Q0QwA848BM6HbKRVk/UYRplh4gb4KCkEOJTDxG?=
 =?us-ascii?Q?q/GFSXcwVZVK1KoS9mqr8i8KwswcxJJ2YIMinWBoECSfmHq9lajBNJ7BwwEx?=
 =?us-ascii?Q?f9J3mO/Enwoxf9BMr9PRYASocSVTeKLjmTD6ZSCJeJJeDr+re2i3oyvZv+Nw?=
 =?us-ascii?Q?kUjtADXR1vpSLSYLM4KmsklXYkxN/nLWrzBS8Ozn52bcI8dU71rgUQos3fB3?=
 =?us-ascii?Q?5Wc+X6tcSVbT/mOhoURaWOEtA4mIKqAHtCvO?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2025 02:27:34.2098
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bca914d2-b9e1-48b5-457b-08ddc0eba915
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5869

On Wed, Jul 09, 2025 at 12:02:32PM +0800, Xu Yilun wrote:
> Remove struct device *dev from struct vdevice.
> 
> The dev pointer is the Plan B for vdevice to reference the physical
> device. As now vdev->idev is added without refcounting concern, just
> use vdev->idev->dev when needed.
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
