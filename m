Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5F1E6FC3
	for <iommu@lists.linux.dev>; Wed,  5 Mar 2025 19:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741204002; cv=fail; b=EvknZxYDXtjQW38cTJMnyNmMRkRQ1nz2CbZqIeaRPEjqpxZSBujE3jbrG4fCDB+yCHzfqxJbuBwEnx8XoX+ykNPz+wmjJvo2Ywys1vRPyqUIm4bdBI566tmwKLbQMDGsRTy2RAVTcmDOuk6nj0TpVqrJgfKovOnIYDoLXjtr1QY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741204002; c=relaxed/simple;
	bh=3jQf2TkhKJMeFfDGX3ny6kQNpvdXikgh7rDSQAqUxng=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k5tUmWsjO4YNIWGRb9G6JBQFc0/yi8oNvpvXbhE3udo3Khxy3bw7gHHUyadVHLG0uPXeXNtwXgeSVFC/YpmjnZTCQsYZLpjwFagS+ntObH97yn7mHJglWoggp2dVTUA5tPMlMF9tHa7HD3ipmPiVozk/ZQMjJsQWGV+ILnN2xQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qq3kj7Pt; arc=fail smtp.client-ip=40.107.93.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qq3kj7Pt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AOQYGCUwvGo4cC7Qlk3Ew4I8mS8WVUTNn1xP1Wa1xIwA8IYFc4vO6YDHKtvuX6hiM+Bq5JxhZDjUpjEcLHeID6s/47PJOX4XtqQkNQN320+3abs0rXuMPhxDcBjrDytPLXL6uZScEE93irdZDbqDv2lvp9RoNfr7HwEWaxtqaa6wYYTXlyJxk6IWqIc7EqZ8CoFqaz/Tq7+lc6lIoowvpWQAts2jTINsEsBFm8R7+SDk+CIG0d0Az1ZAETBXAX17tq+bsB8YRIWo/YNJGFkPa7xvtu2bwnFtD5ykC/0r9boc56J0rxLoCMBlpMW8meSapnwJeoLG8GhHIiRw7LJ/Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L/QTa2tRzjTsRK+rDfj4YO0c0vZaK0hr1T6XotcHvoc=;
 b=j8dOtOeQDBkLX0dqgh+YjnbZuzpF4fzmFAQX0fuX0bGG+0nb0uNjsAKV9OU09xzubBoGiNFlWRg8D+55msXtbl3JNBba9U3cTA6OT58uP8Qyxgw/Y+HK3SNvQXECtesBdG0sjIXVq58qyawTgSjy/8R8H3Uo5UXcc8u7bk+O+kcNy7ZMTbXtJb9rC6lR9SyEgpFTcu98+nR9K6lhf39t+WX2BbixkCmz0tvDLWkklnwuD+iEst8fAB49vvEUGtyHOptrJL2CvLDVnLDDCnFwQQwCVfyXuzSjNfMLF6A2fJLJFZ6kwvDUL1p/8OdfnsdAcqAY4HgygkBrpEwKSYqJHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L/QTa2tRzjTsRK+rDfj4YO0c0vZaK0hr1T6XotcHvoc=;
 b=qq3kj7PtTeYH/elOVoV6ZImX1IltHPhnjvLNrLuAUSNtSLk5PE4iSqdkv6lltDx59XR70nKXiU1QyWiGrsRcH8httuVU1NEWVfYyIyn7HprzewpLr4EyzSDmtFz8Pkh2z18D97z+5porCdRg6AlEcUJ2AcDO6bT9tWZqf2VFSZAzGiBeDdcHorF4RKiyadJ77vGHs1P4S2Znob851ADt81DsnWEjewjjb0+ZgAWYKLueyOt5bh7buDpw0ftvVRXwAR4tXE32bKDJdn0DIglD8BX4kbimsNefilg2V4C0Z1tR66usPgp3w/zHzDEeyfq2Iqg5FEBUuPrxgRH+Y/RO+A==
Received: from CH5PR04CA0020.namprd04.prod.outlook.com (2603:10b6:610:1f4::21)
 by CH1PPFC8B3B7859.namprd12.prod.outlook.com (2603:10b6:61f:fc00::622) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Wed, 5 Mar
 2025 19:46:37 +0000
Received: from DS3PEPF000099E0.namprd04.prod.outlook.com
 (2603:10b6:610:1f4:cafe::e3) by CH5PR04CA0020.outlook.office365.com
 (2603:10b6:610:1f4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Wed,
 5 Mar 2025 19:46:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS3PEPF000099E0.mail.protection.outlook.com (10.167.17.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Wed, 5 Mar 2025 19:46:36 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 5 Mar 2025
 11:46:26 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 5 Mar 2025 11:46:25 -0800
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 5 Mar 2025 11:46:25 -0800
Date: Wed, 5 Mar 2025 11:46:18 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH v1 0/4] iommu/arm-smmu-v3: Allocate vmid per vsmmu
 instead of s2_parent
Message-ID: <Z8iqCpGo1Kx4TAvQ@Asurada-Nvidia>
References: <cover.1741150594.git.nicolinc@nvidia.com>
 <20250305165452.GY133783@nvidia.com>
 <Z8iWqOBga8Xdunac@Asurada-Nvidia>
 <20250305183151.GE133783@nvidia.com>
 <Z8idOr67A0EG1/PN@Asurada-Nvidia>
 <20250305192950.GA354511@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250305192950.GA354511@nvidia.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E0:EE_|CH1PPFC8B3B7859:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f96686-3290-4cdd-c595-08dd5c1e70f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mcNIUgMRv4vDLfJZqVzEwP1ViNC1TytvkcqcN65OpNLInSDdzXrbQPdzw1Rw?=
 =?us-ascii?Q?K+yQ7uQM33mlcV5gaViHh4tcW01tGmwu5X95CpaYnxnWtMeNk9JZ862Q4deM?=
 =?us-ascii?Q?P2XxKN1tjakGC9mlc0g6lvb+wN04GiZe1mkw10guUA+rggYWsiy8cdm9wUrj?=
 =?us-ascii?Q?KquoPS8WZPAX7qm9DjYfiAugLT/DGA7DVElJ1lQZq/AWyh3bSBN/EaCZftvw?=
 =?us-ascii?Q?hmmopbKIJblPzgqzhWBhekahJKSoTbl8JNwLOnDZXMd6xYrt2PbIJ9+mwxqZ?=
 =?us-ascii?Q?rREUvUnu03EF5pZND7kWJuSdvfMB5EJN7RGzH/3eiOB2qTMmVc+U0ClqRI2q?=
 =?us-ascii?Q?0tfyNaFiFn4HNgXpDdgBBSjq4QJ1x0b8UH+tHiGUDjJl/g6h1+BJod3KG0vO?=
 =?us-ascii?Q?booyhdiTbB/dQa4HGx7ZCekCLaNTRV1NuJUOyuJJYghzv2U8IArBLJw8Wc7F?=
 =?us-ascii?Q?zcdwOuOM0nHjV2vbCCJI3fKNmDlTfefH/hbJoEI/dRD/1kIR5LWX6sf02lAx?=
 =?us-ascii?Q?mpCbmMIHjDRH+WcZLW8gsDEs4HRu3MotHKY26Oroz3i+dGikWsNGWGgYcyV7?=
 =?us-ascii?Q?oXXozNAIXrWBHOAQp+uH3d/LG1goG0aj6ajatP1Au6Nxfroz16zv8rJqTNdX?=
 =?us-ascii?Q?vWmeU9LcnvnKuPZGiApbrU/n8SfFvxnzelBW2KOT1zGYzidH7dAchsvIt5gN?=
 =?us-ascii?Q?fyo9zcRXH/kiQqXOOlAzp2Huc9WUut5x2KXgPawrc2N6MsbcF3PawTQhuzYS?=
 =?us-ascii?Q?mj21pnjaE0fDn/CP+wmMIu36bihnj2EeNhs75HKmoh3TkUOt5fJlZaWTaBZS?=
 =?us-ascii?Q?H3UANDOfXB5zQRuA2GBWYlWvbwpKodkxXGmf4oP3jT5qfjqxC2DpQZ26xJpc?=
 =?us-ascii?Q?rj5C/Hs6PkFgs6H7HtinlY9rGABwNm07+1AichCnqZf3so6qRlyNTM99Icga?=
 =?us-ascii?Q?cGy5uvIoZ7qSLZ6xZh/4GRWD+Hc3J0Nbxd2rd+BIUdTuh46bcnGQSyMzeqrc?=
 =?us-ascii?Q?/86c/xHEwsmwqWJSZQ43nyAknTWmI+O5SMSII1IOxpO5rqX8TKcvHYFFNhAT?=
 =?us-ascii?Q?OX7gmLzgB6FMcXj/8MzhbRjcjaIkiAaoSU34XqTF5t9mtktGpglpuEs3VKhh?=
 =?us-ascii?Q?sJ/fiiJZkMJZQtq1v6263tUt9On2CFjN82iHlHWNKW2sbqcFRb3BXP4KVoI3?=
 =?us-ascii?Q?VKnnGgYSaYMR+NlUZCBVd8zfpqeWBTUZTKKybvuytie/unRbE8LgyuhoIjP5?=
 =?us-ascii?Q?6EV5K7to9teZ7YFPEoIIKnLlSE4X2WJFFFyEMhMvRlckrXLVry1vZb/MLOZk?=
 =?us-ascii?Q?8VoIMrKHoeq+HiW+h3ozmi1JBvAw6Mcuu0s1aIAbqoTYVDWSebRboQtWGuvk?=
 =?us-ascii?Q?H7qlVBmSojMIVznkb0orgvw9jSkf8ksJsL9AJuttxRAokKgxecKWI9hM5/vC?=
 =?us-ascii?Q?wDzRH0YUwjgjO6xRqz2ok3weYptEbqr/qgvwgbe4w2GC7vyjsjAZhY0IzYvx?=
 =?us-ascii?Q?N9Bt3/yIZgzRpiM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2025 19:46:36.9041
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f96686-3290-4cdd-c595-08dd5c1e70f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPFC8B3B7859

On Wed, Mar 05, 2025 at 03:29:50PM -0400, Jason Gunthorpe wrote:
> On Wed, Mar 05, 2025 at 10:51:38AM -0800, Nicolin Chen wrote:
> 
> > > I mean a normal S2 domain attaching to multiple devices on multiple
> > > instances.
> > 
> > Oh, I haven't thought about a !nest_parent S2 case.
> > 
> > A nest_parent case will not allow devices to attach the S2 but
> > always to a proxy nested S1 as we discussed previously. So, I
> > think the implementation could be very different?
> 
> It could, and that is what you show here
> 
> But also, it could be the same implementation.

OK.

Obviously I underestimated this part of work.

Implementation aside, this at lease needs some assessment of any
invalidation impact. I should do some extra tracing.

Thanks
Nicolin
