Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012059.outbound.protection.outlook.com [40.107.200.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0646925A334
	for <iommu@lists.linux.dev>; Thu,  2 Oct 2025 17:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759425310; cv=fail; b=inV8xP6VtW7sy++ooekg1UTn6AaVgoUvUcIqfGu2Jlf9rFXqAxomFaxVf2jQAJpoKn5cX31VUHpg5+QgID/iOfi7rZcAGUQrugAsI/47IXGmTHKdi5DS7uW4nkAnd21jr6yRqNaZgFGEa6bDHrngFPbw6yYVuNWz6irzHeRSAoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759425310; c=relaxed/simple;
	bh=paODFiNuc6OpHe1WxjDOwJAjr6tD/JW9myEMk5HzQ6c=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaLKkoBtcX1AwoNQl0lhY/C81iFH7wmb1y6IIX63aX8KB4QCtm6ns8BiMOrZe0qPTSRNVSTQbpzbg8qXjVLZxnTyWNE4pg0tNvV3/Bftfebjd4YnbuxoSujkoWikTHMKsjBMy+SDbuc/xELBHaX7VJfQM0m3Rwr7NVnBp2sSyys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pNfzCcCI; arc=fail smtp.client-ip=40.107.200.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pNfzCcCI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w3M+/sQvWrduT5bo3ktSRh+haUia/ZLJR9XQv71kmZyxZ4i2cL/AjzMmGiejdKzczJ5Fpw6hN2P3XaBH5vdcIEBlm/OfjcEMD6fylt0CSY3JzTw+PFI2Lnt10GePOT57UFJJrl9VAUMk5fRFT4UqStqdpiZUUPD9qXVe0DRzgFmOj/72jqqEyhb3SoKpSfM0pqddZxmFbDsv3CvX+lPQSgFkzpdYIpcNWHlt0gl6eJhVPGNF5yAVxAFJpD3/J8Qi4/L7qU9RToCVL7q8Mk/DmBoeKxmYyzQIgCH/UEVfJRC7otLx1+lF3Ut/jZS4b8vbd1iJiSk7ie2V9mkDlcHrkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=94/tAp9BQGYNWM7vxEGSDJ2SfG+hM9tgCKj3kEUuVKE=;
 b=vYtwnMJKnxO5RfKqBvNj+9HnMI/2VcQji+nuOGLNQmkNreqycjgX8GjiwgOObTueDoH2sKY2OO3f30F0r/DYPaQ4VdWx0Wb6tDBwGaSFH1UpNF/SDA2BEaaBkBSojR3R/9fDDJe2HFHbnOw1R6lxGPqQEfJS3xhoYo4Zu+5r3jWz/U3j72r2LO4hKtE0KV0WnS8t3MR9F00HnjQ5ScZUUe3tUe5IQHQRwkX94oFNyCeky9YUdFMEh3nZIN1oU6gkb2qrsdsEX9YaMtlghb+TF6pWbDSqZYjY/R4nzmdg25bdXMNbRAG4+MbSonLY2/f+cRNpdHVzfnmdcJ4ZqDyxLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=amd.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=94/tAp9BQGYNWM7vxEGSDJ2SfG+hM9tgCKj3kEUuVKE=;
 b=pNfzCcCIZkNxSfB0Z5TWR/WxQAYzbHS+Q71qZEjDTHdJRItB8tyEoYKhzY3g2TBh4U7Uh5zRGGv7E4R6XDFf7bFyR1VhO6AbRDrtNS1v+SqOnfyhtbx3Zn7FtGvdvIfklo2Mc/xuA4B3Vx6Ekhesi5ZnaDmmRzL8UCuQKSxgauEq1MQPVSnSixsnEERHJgtN5ZI0w+Q+OiPMWoMgMcQL29JxEp5WD7nsrMYAVRWf/wLqU9yf1SJWQSyLPvdxfjiZpdqpWEo0rjGbXdG9BkL7T1BFjhnQHlYi70Neycg7P3KBGlefsFTRI6IZMHCWNE+8iORCAEFvlhFh6pgOJgccUA==
Received: from BN9PR03CA0735.namprd03.prod.outlook.com (2603:10b6:408:110::20)
 by LV8PR12MB9333.namprd12.prod.outlook.com (2603:10b6:408:1fa::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Thu, 2 Oct
 2025 17:14:56 +0000
Received: from BN2PEPF00004FBE.namprd04.prod.outlook.com
 (2603:10b6:408:110:cafe::ae) by BN9PR03CA0735.outlook.office365.com
 (2603:10b6:408:110::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.16 via Frontend Transport; Thu,
 2 Oct 2025 17:14:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF00004FBE.mail.protection.outlook.com (10.167.243.184) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Thu, 2 Oct 2025 17:14:56 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 2 Oct
 2025 10:14:44 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 2 Oct 2025 10:14:43 -0700
Received: from Asurada-Nvidia (10.127.8.9) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 2 Oct 2025 10:14:42 -0700
Date: Thu, 2 Oct 2025 10:14:41 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
CC: <jgg@nvidia.com>, <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>,
	<will@kernel.org>, <joro@8bytes.org>, <kevin.tian@intel.com>,
	<jsnitsel@redhat.com>, <vasant.hegde@amd.com>, <iommu@lists.linux.dev>,
	<santosh.shukla@amd.com>, <sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>
Subject: Re: [PATCH v2 04/12] iommu/amd: Make amd_iommu_device_flush_dte()
 non-static
Message-ID: <aN6zAXsE2QAz8KJG@Asurada-Nvidia>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
 <20251001060954.5030-5-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251001060954.5030-5-suravee.suthikulpanit@amd.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBE:EE_|LV8PR12MB9333:EE_
X-MS-Office365-Filtering-Correlation-Id: 78e2c746-15ad-4a35-3b86-08de01d735c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t60gj4NbUnNehMZmdwIEjajvBPPWm5W79esMNdXWM5FOvVZFxuk+1TRPREYe?=
 =?us-ascii?Q?oeMsx+rjWuJf1l4TXbFc5dclkbiwSfFyeTWAgnN0kuPitW3RLVslxG4tjPgg?=
 =?us-ascii?Q?ZPOQ+mjFbTplO+KRycqoPG48p8nIov0j4Slx48KytkK+v7lfcRHM62LeZ6Wd?=
 =?us-ascii?Q?WyZHHJx5E9rjVAqlWRVY2t49Yb+YOMdlAQgr+2pbYM0Xa4T6l0pupBoEn+s5?=
 =?us-ascii?Q?JZ43q2iCvBtr4UWlxB/GVCi/ZsaJnTYQWqYhKmEvIO07jvwiuV3LDde5dKd+?=
 =?us-ascii?Q?TMCur4mzzdJ/XuAgiDvILuIN517iASLUSzO/EN24WuTgdTaHCAxn34A/CxcY?=
 =?us-ascii?Q?xkkJ78b9vl+PPg8wbZb+dTx0YMpiWpEiCAQeFV21ph1sH/sRus8blR+BTbRL?=
 =?us-ascii?Q?e7/gwQTn1zrutPITnlrwdJgZuZbEio/neBpQB92LpvaG431XcZ9+X9Rt32ut?=
 =?us-ascii?Q?UlUCcL6MqIwYZGlOQu46qZdchw131g4Q+tuGrbPOG0r0Cj9cM+MFpwaEV4VJ?=
 =?us-ascii?Q?o329AcYDRkHlh28g5Wv3DL3EvwCy537kR1hP+1KNAlFhxer1EAWYMTqN6ZtE?=
 =?us-ascii?Q?11sNEjdDMTXE/rjLsKWKJO2FPxs7mYNyTlvR2ULhdsIDvfiM17GME1FPKvHd?=
 =?us-ascii?Q?T5F5RydktpYdxEh73BU7Z7D9pOFgwDOrseAxMLKhEAkdR7LjW09PCxVZZmQy?=
 =?us-ascii?Q?Ucqa3PgHUz+h+5HJxltZbCCO6sAaPPglN3GX13sue+fPbJE8Grb6bofLgfOm?=
 =?us-ascii?Q?5DoK+8NuAjCZ8XamwNeyEHCSNUPWyogp5CupsztyK2Rribfdnu4OCftcY2eq?=
 =?us-ascii?Q?vj15WNg8pkiNfgFRXO3FaAV+arMX+1JcrYG7J/IYmHWXgqRYaaJIJZ2FMzie?=
 =?us-ascii?Q?zjlZYE+Vzfb4zfvqy+ZJw3RS2FkWRbYBR3fbCCIJXSnWkk61U64xsB0y8Aa4?=
 =?us-ascii?Q?VlblBaaqRBz6KvEeRftVtfNGBg+zx1hhelXADb2TXq9grjEaN/69Z5xLbdSi?=
 =?us-ascii?Q?kaFNbMzgDLAvCSFPaLhnzvLlpipccWH1xVY5Jcz17qivvmSESNd6yLtdIg5T?=
 =?us-ascii?Q?Kqz/h3JZSduUJ8obRD5hNRRHBWz3KSsMvY3KBddARtwm52wwyiv/7bWtqJiT?=
 =?us-ascii?Q?qgG3o9Lqoa8gdaAJc+j2EsNqu0fpd+2gyygKzCV9THysc7WHUxORxQ5xJtYH?=
 =?us-ascii?Q?kjiWZ9lWgLbmyisEGLIAZIaaE/KMsI0s10rSLxXijoJVii16bvuiq30NmwA9?=
 =?us-ascii?Q?p8zvXIFABHTepYOdE62BcTWaTkXeW+Y5noHuukqdQtX4+13iP/9P2GzKH0w3?=
 =?us-ascii?Q?dqLKzoVNC5tQp4hYVlIv/sb1ZNfoyOhw2Xq/kvgiyQE+eLOsVeTVpzgITDxR?=
 =?us-ascii?Q?Z9EBBneV08Y0F2SRLYtYtT3RNvxxwniSqPU93o2JBt3ArzRUrWUk6+z+lg2Y?=
 =?us-ascii?Q?yKryKhQvI8mwK6kC4gxUFKjOWnfIqpR3V+PaRWSMswoNlYls3ksm6QUcT3e4?=
 =?us-ascii?Q?+BW8qH03kjSQWa7KvchLucy2l2ixuNFKX9JNXOB//oesHpg3NiKAnbgiq/lQ?=
 =?us-ascii?Q?FpulJvk4HUiTvY/zVTM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2025 17:14:56.3417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78e2c746-15ad-4a35-3b86-08de01d735c8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9333

On Wed, Oct 01, 2025 at 06:09:46AM +0000, Suravee Suthikulpanit wrote:
> To allow reuse in other files in subsequent patches.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
