Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87442264DB
	for <iommu@lists.linux.dev>; Fri, 25 Jul 2025 16:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753459449; cv=fail; b=bjQkRrzWFhIcB8e4M/+CD7OjeKpfOZCgMrwReoVpIsGekuR50Jsif6ukjjOKUW0368HB6DLQD6sGIVGqirRg5/AqN/ug+jmQ/EMgsg8+f1e8Z0wL1D/GUu60Zg7HWyrUIhLeikEjlMbjqEDV/02w3y0oaDmY8oasZEPxqgQmE3U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753459449; c=relaxed/simple;
	bh=LwkALrNXflbuCzH4705AYomAX5TL0kfB704r1SgkBdc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OLmqsjdDXxP63sTJq7XZ00c8Xx5MktSOGH5LIkUx9tg1qydmNQK9/4/KZ8Txzv3EcvgdvpULN3+FiN/sw1hOFhkDX/hveKUpZnKogLaf+JpuXkIACvWb6c0ntcD85enrPJj4sjv2HDGYNfvqofTE4Fcra5bvRM1U9MWlZH6MY+Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DOitb12f; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DOitb12f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QgWNVlbRk9YidnlCROEc43djdo43jVDcDYO9J4y6XPb6qWYGgRIPrr4z+a7n1uECPgW3eKNXA7mWUXju9k75vxy/vgewySMQ3K8e0DxmU7FZ2It5jjHUau/ztjs0ZVZFaPuEoz/H9fWiaE/yCkQM81NlVPfC+ezivIz4ZNZ98s8221WHKnfNB7jN5wZWySjOE1LY/FQvReUdkFN8DoHG3KJojg+aZqfAiM6g+3T9QfYdHWGr4V9zdBJIbQyZF9zpayhigTAY1a7vLiw4k8753m48bcPSCD0OS+cukp7HlYFeFUSZBs5nYSkNAESi9mItJYhCgGupqVavrwHzapapMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXuJBt8uESMxPtma12oy3ryy0D/QoFBH9o+obC74e1E=;
 b=YDmJpPjztS9j0FhzYpJU26Ueb6kTm51+qCwGSUkjOqEhiyVWb/F4gRbLgeoF76Mt2oiAJ7WuzV/ovXXMHDp1+cX65sXpjSLhCb9p8DS2vqNNt2MqGNax4n1ZyD4P7EaAv5NSLMiqqPoDhUbd3HQTLR58lPE+MM4Tz3NofTi1mvISkh8KvqDAyeOAYU6sXudSXYerii9KiJUfkowCzui4oU8FMXsFNqoyeVCNBXf8o94yXxuCBcDn/SBoGYDNeVp3KHHOrV+gD5FnASlfK6Ywc6hUFRthmfs/IfRh97K7cpfSDWJkCwnjRgaPSRVTAZJzLqiUCvu3KPCtrQrqDjfyCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXuJBt8uESMxPtma12oy3ryy0D/QoFBH9o+obC74e1E=;
 b=DOitb12fdwa9Z+Xx7LRMj6gipvVHwy3e/n80yQm/xitOxcFSAVBnXd/wkdxTTaGalBdIcZykq9Kkrz/OkRFBMzeACkyl1e30RSN18WF2PjRbKP25UesPp2MpbmjeMbhkGGGNQns+Lz5RHtLH5Vssezgv25k3WK8kf/rRSZY6xWXyXG59dpeLF1wHCH2GGoAEA6Cm6kbEyaeH4UWK/aJlevFOxDHCmhQc2yguDa4ycwvdA3N1Rs033pFeoFSGNUb37wKuyhNkN1p4k/Mef4yXKL0OOPEp89pDOnYYVGSB6mFgKbpud/krXmsByWxD5Xwv+M8o9g2wC1KP6p9RcNevXw==
Received: from BL1P222CA0022.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::27)
 by IA1PR12MB8310.namprd12.prod.outlook.com (2603:10b6:208:3ff::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.23; Fri, 25 Jul
 2025 16:04:04 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:208:2c7:cafe::ca) by BL1P222CA0022.outlook.office365.com
 (2603:10b6:208:2c7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.24 via Frontend Transport; Fri,
 25 Jul 2025 16:04:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 16:04:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 09:03:41 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Jul
 2025 09:03:41 -0700
Received: from Asurada-Nvidia (10.127.8.14) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Fri, 25 Jul 2025 09:03:40 -0700
Date: Fri, 25 Jul 2025 09:03:39 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Pranjal Shrivastava <praan@google.com>
CC: <jgg@nvidia.com>, <will@kernel.org>, <joro@8bytes.org>,
	<robin.murphy@arm.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/arm-smmu-v3: Replace vsmmu_size/type with
 get_viommu_size
Message-ID: <aIOq2ysFPfZsNUix@Asurada-Nvidia>
References: <20250721200444.1740461-1-nicolinc@nvidia.com>
 <20250721200444.1740461-3-nicolinc@nvidia.com>
 <aIDlsUvF2Xbdelvx@google.com>
 <aIEkZoTOSlQ0nMKd@Asurada-Nvidia>
 <aIEwzM7mKUI8-h9U@google.com>
 <aIKd1owebUNQeN1-@google.com>
 <aIKqaGMMpsIuAVab@Asurada-Nvidia>
 <aIMR6xxR3Jdpy8kX@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <aIMR6xxR3Jdpy8kX@google.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|IA1PR12MB8310:EE_
X-MS-Office365-Filtering-Correlation-Id: b00a2cb5-0501-4c5c-b677-08ddcb94e038
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tym/+y54IxzZ3gRwPP192A/sbKKZNPEeU25WIqr6/myEp3XQKbC0kUac0Lob?=
 =?us-ascii?Q?RWHPjPmBekPmVuwv3884IBN7P+VPuOvuyibj67S4JIB855RCMuW4HgI7Nal3?=
 =?us-ascii?Q?ZRSwNjNZcFGf8FnY/bYn/ScKlRTWn7Y+O0bd8QbfI0tHVoyiaUGMvwgCsGEa?=
 =?us-ascii?Q?kLSNrUHo/en/mgfDE4nRij7giHPdpBy2puPRVrrbFhxvSbpB6FpecvmbdS3K?=
 =?us-ascii?Q?aTU9tjvRoKIlRMT2IYw6NrOPjqx+1iDx/ZA/QMm6pukiB4LWVc7YDCcSus/S?=
 =?us-ascii?Q?8orYNZgdj39UZJtp4egDyGfHXRMmdNkD+ZAhRO+tk2P5ut+cuEYiXY5gtFBr?=
 =?us-ascii?Q?j97TaXl5sSAoIiyVQ/hfbkFrE65uCsbEtFI0LhjHUe6W8Nrupa7u1YeDFEJj?=
 =?us-ascii?Q?9JiSLt3KpYE1jZN0ofm/TXX8THkOddBebsw0IDbBHhhfVfC5BfB7Vin57cOg?=
 =?us-ascii?Q?HhnxkmWunsFB3YHuOVKncRYp0D9r7EHkrEA0jrLG4lxKyxNZe9yYXyQXay5y?=
 =?us-ascii?Q?/vQGHZaBNcAGEevolU/pg0DzvRe31MBfLcBV/oDrREUPnAdTpcOHxaagCa3n?=
 =?us-ascii?Q?vDVfzKky9dLnqb45dujbvxlGqrjSeIEIPFZfY9ydso/tSXV1rU+6xsAkQTj0?=
 =?us-ascii?Q?il6VWclPZ5GuWGoJIc2Pg2EbFf2lCJmKTsTxxtx6mmvIPpqBwWHKIuscLzKh?=
 =?us-ascii?Q?/glQbG5ve4PFkDwaP9DQa3ouG0CRMqsoyb6xIwNNSlqTjUW0aWx9OnX0rvgl?=
 =?us-ascii?Q?l/ejyRtlm2eGZ7tzPsMEgKVETNeaXkXdVV2P88TN8dyjdcZAXNHbKKP2m2A8?=
 =?us-ascii?Q?jkMgq8oxk+1cGYNTePh3A/b+u8aWbD7WNuNlMIqiYKoA9tesPyQO6xG2+KNF?=
 =?us-ascii?Q?3hXP4901fFaTa5BaUkz5T0QPhlEstK+e9XcKkhAp6/lQFY4u248/OGlvAndY?=
 =?us-ascii?Q?Djjpp6XsJba4D+q0igMWeQVTLkEtgUbJxnnmwpSJpJg+Vor4NBPmHBOvB49N?=
 =?us-ascii?Q?EJ5i5tCnpo6NG+J4AqDA+JV1CcaMxbqbCtLSvkMzJFl+8/RHaBJ2nyig7hUU?=
 =?us-ascii?Q?11Jk6fW46FF7PzsuT6mfFpr1NnAxN+01nPtak0APrkPGs7pZwCsvBiuztWCv?=
 =?us-ascii?Q?h4c1kA954C2BfjiNt8galkLDTXKVJVQ8vzk6A4WdIH+7WVhJCjtSkGZCmsqS?=
 =?us-ascii?Q?8JGTvqsYRTMyEJ9Eiwj17iPx13Y7uaDFg7xiKHRSRcIcHZprR0pPzTjAUy33?=
 =?us-ascii?Q?Ez8SQ/nnfi0/UBHqUvPRD3G8Ufkl2pzX2VkCZxcU/QMIXxYOf2Sn5+KNfkXl?=
 =?us-ascii?Q?/ePBDHGnxq3KUZ+BLkTj9XcAlrKfDvFqrI/kwRK3qplQNAfJ1v1x9x94C+Fw?=
 =?us-ascii?Q?9QwfeD3qugeZLkRKDHx01q0jpDdEHCGxFXghH08wrUbmCcP9s0K4MwKw+0lK?=
 =?us-ascii?Q?TXoyoG7ekAwFOnY/6s95YyJEuKYKriG/oN4WUAClxcMqZl/mGDjQXY5yfkJp?=
 =?us-ascii?Q?aEWKNnqmOS+vWeRwy6mNo0rv4FIOgPmU6Lzl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 16:04:03.2095
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b00a2cb5-0501-4c5c-b677-08ddcb94e038
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8310

On Fri, Jul 25, 2025 at 05:11:07AM +0000, Pranjal Shrivastava wrote:
> On Thu, Jul 24, 2025 at 02:49:28PM -0700, Nicolin Chen wrote:
> I'm agreeing with all of it, it's just that the comment says something 
> was rejected in by the size op, which raises confusion as to why we're
> in the init op. The init op rejecting something due to data corruption
> is a different thing..
> 
> I totally get the point about data corruption, i.e.:
> 
> size op -> returned something valid
> <data corruption>
> init op -> rejecting corrupted type
> 
> Wheras I was just trying to understand a case where as per the comment:
> "Unsupported type was rejected in tegra241_cmdqv_get_vintf_size()", 
> i.e. ->size op returned 0, yet we ended up calling the init op

Is the updated one in v4 fine to you?

/*
 * Unsupported type should be rejected by tegra241_cmdqv_get_vintf_size.
 * Seeing one here indicates a kernel bug or some data corruption.
 */

Nicolin
