Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED25426D5CC
	for <iommu@lists.linux.dev>; Thu, 27 Feb 2025 18:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682724; cv=fail; b=U9TAbMpA8GBjd1W+mipW65aGVPRvHDiCBh54KcNbLL36cZBUpI/7zJZ4eDIVVYyeO5Q6IXa1XURlNgPXJpUfZapgTw5h94vsFwAlyukSFbRE6fmZnV0P9XyiiEqn/JYzDiZKMDBvclVR2Hn9dUCe9jWkcQksCgY3jeTEDV0d+EA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682724; c=relaxed/simple;
	bh=NQrrPff/+Wjc9PlXHqEmVwasUpJhEYYAxrt/H7rk9RA=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rebIu/jCfRtk/3T08xCzJEHe0TaqrXNexFTU5rRcn7XpPBpKHWPCzxZoQoDhjR1AhZ7PtGkZQwL1q2TmsqHZNLK/gmJ8scuOWHqASg8xn5Q3LshotSIs3kDxvtYor6AtM825KNKH5a7wE/Ya55bV0QC4tYVNPqlfusH8ZUcgf6w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=omgq3ny+; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="omgq3ny+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FKayajGdMV8NlgGchkqCKi3rvApjBpzctumA8sqwAGSXHkSfe8/dz9b/ZXCPuzGYYwJ5/f5giL3M+XNycs+IRKYqZ8amdi/dh1huztUaiugcbkk9NyxXSMO+A8KSwKG81rd3r5y2stEub4QtrAyOvWb145PcH0plpvRl4YaY3IyhOv4tvbRRuBI17TAtRKnHPp07PtGtu9zsxb/Xwrv72gDRX/UdBOzzU4LxLUqG94+gFxK9xSJEtB7911ls44/l6CoWr/E79m7ZPIrygdDPEAWCoGokFsfonHlTH4JM2VMVM7g+RP2V1NWXtg9uGqpZn+7YI21aYChffqyjvcNB6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WYH7I7Gg+5oY2t8A39SFTQFnjDLusFkdOV86XY7EbF4=;
 b=v4NjVcKZ8fAuZMg7HARviYwaWqZkeB/LHL5vAXzTZUVf6H/RsmjtvkTVosOrEk05cJ1UWJkVabXZHCJNFkNU2rI7TZo+mKmE8zBJVYncY9DDfZxuo0lp5AA5vVPTB9U1Oqyd1quXZ5EpUA8gziJ32Fne1tsXLNXUAsl6OivmDSmwysSxDP/e89QvsaW2yTCtuCrxukA2hzUX5fZ2rPT+tVo17+qDrsp2GZk6sU/XsSovtr86fbpgTXQ2GBBp67TQ2dtejdl08wl7iyvi1aKPnbDns71j6bITiOY8x2FBp+vY5A6Pjfk6VvMLGDxNGa9BtVyXxQ13fYNlROsd+R0HHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WYH7I7Gg+5oY2t8A39SFTQFnjDLusFkdOV86XY7EbF4=;
 b=omgq3ny+QF6TAS2NnKQy+tsz3B+NKzQ0phhutB4FaXhXRbu3pTz7MsHQvTo4XXGLhceR/AYERSQpAxyKPZPUIsWOgTiNaWQnS/KrT8paOkyFVdl3L64PBIKC9PA2kBzt8pKqE7ZqsXIyliHF4bi3ING+19VfMedZIsdOxXxhu5o2kHBkCFleg9R+h84ax4FplvvQFC0TawPVZM7XIUxv9IHobJZfcNwFq+5QfYOBr0e/h3NaxXXszqXbVYxn0qD+phfRRpGgk978NJHcE4ch1qzjzmas2lVQ420+/AfP1GFCbAumaXaRxjavjFs+F9WJkMFLe+uOjJMP7prXJuOhVA==
Received: from PH0PR07CA0068.namprd07.prod.outlook.com (2603:10b6:510:f::13)
 by SJ0PR12MB7083.namprd12.prod.outlook.com (2603:10b6:a03:4ae::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.23; Thu, 27 Feb
 2025 18:58:39 +0000
Received: from CY4PEPF0000EDD6.namprd03.prod.outlook.com
 (2603:10b6:510:f:cafe::82) by PH0PR07CA0068.outlook.office365.com
 (2603:10b6:510:f::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Thu,
 27 Feb 2025 18:58:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EDD6.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 18:58:38 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 10:58:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 10:58:25 -0800
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 10:58:24 -0800
Date: Thu, 27 Feb 2025 10:58:23 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 05/12] iommufd: Mark PASID-compatible domain
Message-ID: <Z8C1z4003OOmsqKM@Asurada-Nvidia>
References: <20250226114032.4591-1-yi.l.liu@intel.com>
 <20250226114032.4591-6-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250226114032.4591-6-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD6:EE_|SJ0PR12MB7083:EE_
X-MS-Office365-Filtering-Correlation-Id: db3cd660-e8f8-4b0b-01fd-08dd5760bef4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AeOo/BOZrZ9ZPAsN5nKqfdIpyO8rT7iUPBCRTeJ6Z5aqtlYasfMpD7Q5nOFW?=
 =?us-ascii?Q?uPzX8Mwnd2ISB0rYmKmHCSHXhSas9dRDAA9KZcdrdUSIsxy4bwGZ3MMM0VKf?=
 =?us-ascii?Q?jKnzrUuFSi0DjsTh2bYk+a1ovTm5sk6N154Kn9/jw437uL1cpOca9kpGIdct?=
 =?us-ascii?Q?gwurgcdPj6hh0iELB2M4DJXhNF1Yvw1xfvYxXbu+pvlBwzx+vXvcp08ec7Fk?=
 =?us-ascii?Q?e4AsSVg1f3YOyg5INbMdAgGWD7qMy8cLXYFr4tPQKxmH916SakAPHP0y5d9d?=
 =?us-ascii?Q?ptt4ZqTfPr4MVEjPDT/8WvSgU9ttdh/SlVon+bsV+CSnxNuvDxXLEcq2SHGQ?=
 =?us-ascii?Q?pfZ1iR4CfbsXiKsGZCXddCGOvYgUxQQ7T1FeRLAhWvGsgBv9zL0Lc5nIwe67?=
 =?us-ascii?Q?8R+LGOMzRqikfSRl6v36WeK4gdVafr54iJuSKLeFaHhaLIwRlB/tgz0VFofc?=
 =?us-ascii?Q?xBVeesJGogFwFpL2x0d19wSZJPZ3WSXyh1WdUCKmrh1TH8zJz/xvi/vfEGVf?=
 =?us-ascii?Q?U89M1C/Nrb2cYFgRbImX/ZjlGKXocJaJhQJFEcLJ3ptNvyAd0qaWugwzuEPM?=
 =?us-ascii?Q?1sFS6rBkki5vW8lSxc4Qr87ceqe0eLyMmYgOKjBCwlX16U1Kn2ERxqfnnNgH?=
 =?us-ascii?Q?I/52SOBo5MSf0rCp/YX71cLJnoOH5aKl/SXtwZ7EbWpP2qHb8cGk1yXWjLxX?=
 =?us-ascii?Q?uJRl758bimozwvLJC+yY5Gm114LBjoQQu6xuH8UVAxvvDlZF75LG1At2Qj4S?=
 =?us-ascii?Q?upFRvTKc2fhZJx9vwLmfXTuk+iqvQCsFvIWhgD8Qky9UdZBjhBzfxqgqPHz0?=
 =?us-ascii?Q?0AXD4ik9zVodbKQbfSsuwcCicPPykPHT09vxNhjVPMNsPbKZ9ywBJkb/2tDT?=
 =?us-ascii?Q?Fvq3YE4Mq2ZSTSkTJL67dntG/sSQvjQPj8VW66ElT79jT58DuK0b005m1zeT?=
 =?us-ascii?Q?/e4o7h7mO+1lwMe43lbPCbVkemgA21z/uOjE/MG/5ar5KocMlqm9SKh/LGxF?=
 =?us-ascii?Q?uHV8SG5PkP/TXUTm4gDbPp+2nRlZOA5+/qkabSgz6S06PGKAXFUJae0dHdLF?=
 =?us-ascii?Q?IWg+MwBBTfOM5V2itiDfrXoPCPtR1Z3eIY+QtU8xYf9i7BifTifeB2AIR6uH?=
 =?us-ascii?Q?DN1XKOKb3rSnqK5lmiRj6NqoTUP8dgwlx3H92FonsjZRu/vH7LRCYGzMfXD3?=
 =?us-ascii?Q?ZKYckJzkMPzo3IFe1d3YrQP0xapuPKTdSlkdzUQJ8HVi7murWTTnEaA5as1J?=
 =?us-ascii?Q?XJ/zgxsVnaH8saD0bfEa5pkJtixw5HwoJWT511Z0tIM1sNpIS+0eA0Q9RDCL?=
 =?us-ascii?Q?TyIY5VgU43rwZcW4c9cREy3JBmsjDhT3R4uNOm5bTmsk48LDpuho8P0fi+GU?=
 =?us-ascii?Q?3hac6rBM2zx1iKzeSjqK14Gj7NoTuehVQjxt8hoCaxJtbWL56aK7XUdtuR72?=
 =?us-ascii?Q?7p+C1J5keCd4V1kmWSCCd7pJXfO6DEP6z22dDmKfwn1MeijqvGBJI+DMAapH?=
 =?us-ascii?Q?FYrJwDSrmtWBuHU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 18:58:38.7523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3cd660-e8f8-4b0b-01fd-08dd5760bef4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7083

On Wed, Feb 26, 2025 at 03:40:25AM -0800, Yi Liu wrote:
> AMD IOMMU requires attaching PASID-compatible domains to PASID-capable
> devices. This includes the domains attached to RID and PASIDs. Related
> discussions in link [1] and [2]. ARM also has such a requirement, Intel
> does not need it, but can live up with it. Hence, iommufd is going to
> enforce this requirement as it is not harmful to vendors that do not
> need it.
> 
> Mark the PASID-capable domains to prepare for adding this enforcement
> when iommufd PASID support is added.
> 
> [1] https://lore.kernel.org/linux-iommu/20240709182303.GK14050@ziepe.ca/
> [2] https://lore.kernel.org/linux-iommu/20240822124433.GD3468552@ziepe.ca/
> 
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>
 
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
