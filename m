Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2072.outbound.protection.outlook.com [40.107.237.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A381DE3A8
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 18:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742493847; cv=fail; b=EzdHIW9aQ/HAWpmol8eBJNpbUOyVfg/RO/Bw3RsacSEtoEd+ijyFLf7cKr7n+7ZM2c9IbwJngls7dwFZS0wE27A+mQ1LUxGehReqZ7oX/kF92AI1ey6HukCLQqYmq3FX40G6MWZl7OVH0GXIRc+OCEGWpCCQcvmCNRMde4kmD0Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742493847; c=relaxed/simple;
	bh=EQEEyzYFl1ByebCaGZ9h+dbQ362RtsJ4+OwfKUVfXNs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qoWdenrBacLIiZfUF9RLD0RQfpNKavDdQoa1bwDxS2Y+bJM8GG0wx55qJGudM3hEiDE8jmEZwIXmMKXWWraNf8aBlY9j4JJawQI8i1DBu9xvlrrgNoeX4Md5SO7NXZDOf6lSvtCSSP1uWy68fHVziT9UOSBs1ETPPnJsANMq4/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kBPobxf9; arc=fail smtp.client-ip=40.107.237.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kBPobxf9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AFY4zv3P1tX9SH1yxWX+JbHXCMgHabFmsamhOQtYxPoy8HJn1FVkDBeRoLL6ShBlwGvawbFOi7b5UohEiqfDpgDg0VNR4UYJPetL7MY/fVG6UpWz9QPL0dnQGpR7PtgpJwjA31hINkVFXWRgIJ0aHDZS9EJ6a/oEb0SGHAzeN8/aIothqekdKQbUAATHtiU9jFOOlTgG1JzzEBtSVZcihxHQovZZfcdvj1Rq7mpBDL5Sao86XdvKTMPpQrIm7Gu/+jtD0k5SIcw6rcbTb+hCgbeYIZ66zT2nZSaja/UIk7zF8fCxDhi3R0vr5WJ1q45Q0cjGF8dvKISLUZP/Hw6hTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wCZfz4p18mQPB5OFMzZpn6G7gtWKq3Pfcoll6QvrezE=;
 b=I/2dYeDXsBKiRmM0fA5rDZHothThELCe4QXXv9cjpksTVD+wkGq+YQ2zaYcqsXSWCchub8sgcat3crmvDHjT5yF//jPVt3U9Ew5phH7zgBdyj6uz6cIZcV/zrmvyuApBvi/fG1TAYTC2tZjmDdS8N2aC3AbRXULuJLFziEDn7ZkADmyqHXt452jVF9nYrGS8UVicbTb3eFRr5MVqOY8tNwAshER1riBb6ZsKtjru9Oc6ImWErV65YYNYb2LNN0ZFF+PzTwO1+CGDGfQGjZByZpxTQKEV9otYq9XcARC2TJ873RmGPIl0xCeOIvnDPCqAP7NmaVbWefQOvXLFGCpl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wCZfz4p18mQPB5OFMzZpn6G7gtWKq3Pfcoll6QvrezE=;
 b=kBPobxf9lJArpN3oaumNw4aaZk7smQfQuvqJbQ0P4Ss93LHazeKpxsV3DCg27bfxkdXJoR12JqDvUHBwJsGB9tzlTMG55UMeXZIKZzoEWMJZNILGl6Wgwepe1/m+p7XhYVEV/WhJXa3It1SzhRcvf0GqkY1GwzGdI37188lC66gHMqMMaiLMr8Y+0KreKEfKnhTI1B82lxXbR35K1zifS2C31ORT/+NCKoGU+FPCLspeNUryp7SMHFPhyw5P50lkcPb6o+L0097o1H7R82j6hMRSgxvAdryejbZZWmvZIeK1efIp93LA52FQ2bjSJOkrZRJU5Z4sl3tZIhnE+RlJrA==
Received: from SN7PR04CA0119.namprd04.prod.outlook.com (2603:10b6:806:122::34)
 by DM4PR12MB8475.namprd12.prod.outlook.com (2603:10b6:8:190::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.29; Thu, 20 Mar
 2025 18:03:59 +0000
Received: from SN1PEPF0002BA4F.namprd03.prod.outlook.com
 (2603:10b6:806:122:cafe::5) by SN7PR04CA0119.outlook.office365.com
 (2603:10b6:806:122::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.35 via Frontend Transport; Thu,
 20 Mar 2025 18:03:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002BA4F.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 18:03:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 11:03:44 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 11:03:43 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 11:03:43 -0700
Date: Thu, 20 Mar 2025 11:03:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 07/18] iommufd/device: Wrap igroup->hwpt and
 igroup->device_list into attach struct
Message-ID: <Z9xYfdSprb1JIMbE@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-8-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-8-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4F:EE_|DM4PR12MB8475:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b05bd95-0d37-48da-ce5c-08dd67d9968d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zFOOrsHQNpJKaTewq0pT2JmL4ZaDbfF5q518FzH7Zaix7LyRyEwybJny5ho/?=
 =?us-ascii?Q?03rIVulCLbYi/xQhTUA6aV6b+4pTsr/Zr7iUYodWuqkjVjOZ9zvrhk2DwSyU?=
 =?us-ascii?Q?1Kb+fkgo7tG3EGLLfUT3A3AXJc7nA84svrIWhfCJVuNM6VKmTevWp6tE7fkq?=
 =?us-ascii?Q?S4zBAC36QcaHOXokLVrU92u+z0jsQt3PhCk4bOSUM0ivUPY6PuAsX+T+Q7F4?=
 =?us-ascii?Q?ZOp3PCXwS2dA9MjsV6ARGLrzuviKvyxj7Wp98h+cweSLACqAgEQMjZXzQU3E?=
 =?us-ascii?Q?8FwegjD/eUGeSjPpavqMlyUTX69Pt4EW0tUYRRZ26UzlK/DfJZeH7iILgJUW?=
 =?us-ascii?Q?xBt5niz07y4pgRepeCAsJE+6IA2Q60ls7WqbfsxojnWyzlmULqmfc7ND3KPQ?=
 =?us-ascii?Q?fmvUPGOYGaSTOsX2E5kI+woo3A0/72BTjwyxmLbhd4D3Ol7ku3G+3f/6eYHI?=
 =?us-ascii?Q?q4rcwOsMeIuH5dbx/MQ64BB0pSy6n3FAltycpf68ziLtkh1MjWG9SSLkup6F?=
 =?us-ascii?Q?TkGXshq/AdztuAix+P6XnsMBMdORO8tRGKiM41parT+oFB+tkxCz9/jCBvRY?=
 =?us-ascii?Q?IiR6Dq+Zty6ib7VChgxNNCYUXmndzttJM3TcAn2dkO99riexq9Ea4swELlO2?=
 =?us-ascii?Q?Ny6G1xX2JSr2p2LRtXfWWsPT0eBMedl0bfdcKWvE1EhqAVy5Tr9VyWa/hcda?=
 =?us-ascii?Q?ZyTeJGv8zXaDvFaJKoZflG4TSgpR1mN0aJuzbqBgQB3wK4WCHZb1+2zxkZyw?=
 =?us-ascii?Q?641DYLvusjqvVdetKBy0KiEJlj4G2U9kwlgj3YzfRHJgnypT2JpWaExw54K2?=
 =?us-ascii?Q?SROax4wiHvU0PiEWDYhC+/9wqePZgWUM/BmgsxuKt0irGuG6Ps0Hn1TYlgcG?=
 =?us-ascii?Q?AQDm81Rug9qhLtUgw0zxEmqsbSmllca+w6I/sA9iOrulmHj8JUFQnv3JLSwY?=
 =?us-ascii?Q?3/VygJY1R8LoWmX+zo8ww4uqrmR/nhekMLATdrxCYwW87DK6up6D2SEY22/L?=
 =?us-ascii?Q?z/XRpzreDUhjAfmsZvD+ULVrfH3eufWUiIjE0wAG++X0BVunzuCcjd/RliTi?=
 =?us-ascii?Q?Nc9gNvDlxmLqZ7/N9vV6vy0TbUypBLj7F+4rstUB40CvGkWvqechVn6BWmVi?=
 =?us-ascii?Q?NYE3UfmPPbffYyCJ64R074bE9kTYzCFh0uiLG7MdbTalnRFMlKImzLYRBxX/?=
 =?us-ascii?Q?gGbR0Fi1L2yBc6Uuw6KP9E6X0mMZnuzcC+ZKLofFBR/Xg3ag5b/u50vbikFs?=
 =?us-ascii?Q?1DO72SUT0jKuO4H3VFE+ePidaj40GVhX05jklJwo1IIq/jdDWsWjHdq7JNpZ?=
 =?us-ascii?Q?jY3nvcBEZF7pMYwfe7Etp7EwsJZCX47dCwPZbViaOdR88yR3o2RxZJ/3lajK?=
 =?us-ascii?Q?VhFP6mpShPT57GnU2DKmnQVS/KO4zpkEd2tFoTPD4CkNimXbq+fVXLjUnzBu?=
 =?us-ascii?Q?/Cen/NIDL5lhbW+OXh8ZujU2Fz38F5DKtD0SomF7A5CoarQX1JtgYS3oop19?=
 =?us-ascii?Q?FV2XQ9/JDkHT8HM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 18:03:58.6355
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b05bd95-0d37-48da-ce5c-08dd67d9968d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA4F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8475

On Thu, Mar 20, 2025 at 06:47:33AM -0700, Yi Liu wrote:
> The igroup->hwpt and igroup->device_list are used to track the hwpt attach
> of a group in the RID path. While the coming PASID path also needs such
> tracking. To be prepared, wrap igroup->hwpt and igroup->device_list into
> attach struct which is allocated per attaching the first device of the
> group and freed per detaching the last device of the group.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
