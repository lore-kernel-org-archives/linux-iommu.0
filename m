Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB02AE6A
	for <iommu@lists.linux.dev>; Thu, 20 Mar 2025 22:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510384; cv=fail; b=eT/dF211iklFfgdYvsA7wwaay0o8b6CxEVI/G+awlaFucsV5gxzeTuezNpxpnNfIwZHxzb4o6GotNDm8ln92WUbaouQOKjCPk+PthiJyA0OUMYFat6c+FPn7mWU7T7SZNmFe7/6T7yysF5/VgazGQocQVTEJBO7qeeq3iqz2ij8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510384; c=relaxed/simple;
	bh=0X/RRm0MvHP5RZRWSO3nSKJn3q/u/PSFa6lOQNHULMs=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qdz7/LLOr7muoO7BRvXi6wJMPXWxImj2ZAsq80lhCrELy0dSdsIHwcgAAWl1zAOXPhjhoYFPPnGsqfqGdWcHNTt8i3ZVJ9JdPQ6qeCjve/1cWf7GE0raIAmWhVZPeAsgsoK/A1ElM2rvruEXcOeqZTg6Pn86jxRtXBlLbCyOdys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=N/dO85KF; arc=fail smtp.client-ip=40.107.92.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="N/dO85KF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EsCc0J8ul2cNePgkmBgCMZy1oS2laSg74d5KLq1M2vTEw3yyQz12v3kjgdBTMbVLAI/Wj635OebkS7ryWNgTrKc5VmvnQiXYjXvwZ8ySZN2i7bfesdB39kKXgrHt0s1L4bd2E/L74v8AHGEElVI0GqKi0hCZ1J63ymJLz4QJkwL+g3gSztbidGix2eFjOrNbg96AZRGLvTFK+O91FHuTFNY6wj/3VFXeWPAjhpUXVRlqERC1AaL1STNkwujRervMvQ/YPE5g1ysDFGxBiowJni0iaFT82AG+xcrwmX2d1Q3Q+bYBte6kgDUaD6xnj/zY6J7xPw7M6y+EUbMs7HM5yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jnP5Osbvd2umvCRVMi6tq8aizOZsYK35WZeLVtuR8XQ=;
 b=vlbGazp9yolukcHeUUuIAKIaOV3GY+yFAO4beE6m1Fy4Sp6vV0AqFEJL7OuOS/QEjTEZE+xK4tZ6R9juZ5nXcrMoZDZj9dhA8MhSv7IelFFbb0gu/B3K5uBVMBpoVA0alm+cZrnaJnjNZs7jWOYTBqRNjc12hpWFAUdbu/WTRCVXRwgLYZKQEwnjfgmmQKDqq/Q7RfRjDaRv8jrLT5q+9jxfzs/xbKLffFFeLqN9rFLFz1iHiS5oerPX+v8GnnQw73/gsPCbUCbmif1hgcRoTaMWqwciku4UvBiaXBL3BGDUapDXNSdRHBrngyYnCW2Zzw5f/0bDoxANh8TEyvTWvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jnP5Osbvd2umvCRVMi6tq8aizOZsYK35WZeLVtuR8XQ=;
 b=N/dO85KFlkQ3DDpzCqelz/baJzaHC0W9zM7ZLvfYasyFQ7rflBYl1gBccXr3vUR+FS833l3vvR3FNVOE7BSaB4fr/vWAvSI8+KtdiT/0qVLUMSxbNVHWRTUhymJoWG0lHcj0YuxmQOkOSL/qC33Ow031AfkFjnB19638oS1oBts5sPfen/8T9s7I6x2EfBu2s2GI9anzZm8F+/KhQApLWpIRlUqSAyeJEO2LeBtn2qZ/yGMeYo2CXvLAGraPVlOw2PV0+mPWLzpxwKbvat/upZm3Weckzf4hMkAiPu0OmJVJTks0SYv7LUyxPHcdj0v65IyF9d17qSOBan8OnPwQ0g==
Received: from BYAPR06CA0046.namprd06.prod.outlook.com (2603:10b6:a03:14b::23)
 by PH7PR12MB6787.namprd12.prod.outlook.com (2603:10b6:510:1ad::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Thu, 20 Mar
 2025 22:39:35 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::3f) by BYAPR06CA0046.outlook.office365.com
 (2603:10b6:a03:14b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.34 via Frontend Transport; Thu,
 20 Mar 2025 22:39:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Thu, 20 Mar 2025 22:39:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Mar
 2025 15:36:19 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Mar
 2025 15:36:18 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 20 Mar 2025 15:36:17 -0700
Date: Thu, 20 Mar 2025 15:36:16 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Yi Liu <yi.l.liu@intel.com>
CC: <kevin.tian@intel.com>, <jgg@nvidia.com>, <joro@8bytes.org>,
	<baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>
Subject: Re: [PATCH v10 14/18] iommufd: Allow allocating PASID-compatible
 domain
Message-ID: <Z9yYYAGojJ2OBYCc@Asurada-Nvidia>
References: <20250320134744.5777-1-yi.l.liu@intel.com>
 <20250320134744.5777-15-yi.l.liu@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250320134744.5777-15-yi.l.liu@intel.com>
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|PH7PR12MB6787:EE_
X-MS-Office365-Filtering-Correlation-Id: a154fb7f-9274-4bdc-fd44-08dd68001704
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IT/+1yf+4y962H5ZJM/Ya84nP7AFnA+EeixqyA9ELMhoqrOKiRowrM7QEhbt?=
 =?us-ascii?Q?nGBc5XZhiRymkevVdM6wWrMMh0D7j+0TjxpVxNsLruJhUzoyUc6ib2tROE2V?=
 =?us-ascii?Q?+BROUeiOj4G92kDLc+p5T3QqeeDfg7EwyzUnvWOq7xBiM20s+sq21e6FuCiK?=
 =?us-ascii?Q?c9jJFhtTWWi4CB68DU1pIkaptshDQV6DBSVTWLT4pq5duuB6LDpB2EHqkDq7?=
 =?us-ascii?Q?MVWroQnNTxn17ORETaVsNCI4GmLk1TLsSFSN8P/Uc3BCbZqqO3qZ+2reSTtR?=
 =?us-ascii?Q?H148QiOaYjjNXcjVc6AadP4vXAKqEwgnnz/ndI0Ehnwx6bvU3MnGjCvTPSXk?=
 =?us-ascii?Q?swYYaOnozdOHphFd/T8OrtLyrH7Iw51mzhuVcUhPxS0VEGJBrxer8Z1HbuyO?=
 =?us-ascii?Q?3DFrhqTbqO4PfGw3o8+ha7Xa2mFtIW8xEYEVuB+cHWScEiPDMcflUkAHgpYt?=
 =?us-ascii?Q?JRR0VHzRwNZl8JC7m69+Nb4A04hW+mVDcoh+nMaRNXyrBqUBpprS5b7wdJiZ?=
 =?us-ascii?Q?pPEvkbd6R9pOb1nt0UUGI6HcVLz6SUb5kVINWAVnyKBzGmiYOMXV4Tq5CVzP?=
 =?us-ascii?Q?LVR5tNoHyRnDZpnkzhtzNY2Gkz12P7ZqvaTs+DwAsoF+2Yjz/Mqu0xeOUIby?=
 =?us-ascii?Q?spzlVDtrRet2xGbUNvqLNFJHWzizBIjRmjB5o6odtDLBs0ZhkZGO9BBcSW53?=
 =?us-ascii?Q?Q4FdV9qCwc2a/USwnEzUIVTEYqLE4+ZXrXttkAFSwxY2jCV7LL+l7AgFevxc?=
 =?us-ascii?Q?A1XRL4KADsPuCjKvSy967z3de34HyPxc+9E/FEF8K845oisK28HZjM9tD8iq?=
 =?us-ascii?Q?FtUkkHnBJ2nqJmjov/rL++qY3MQSsIVELIFCtPv/8Scncg8YAKv+o4ibetuB?=
 =?us-ascii?Q?F766rD44X5Wlghl8lr5uJdRtneG288NxF/vkNnZUsdybvVn91W/RiD8wK2Ci?=
 =?us-ascii?Q?37k4zWlAPppE4move8QJwi/naUg7AcDCWoEWilec9PwaVREhPB7szuwbYfXU?=
 =?us-ascii?Q?L2CG0LhGjEUaP09pL4c9zp1KdJKoF6bQNx0EXkVXuOrmjWqaiW1iNfPsv8Z3?=
 =?us-ascii?Q?U/xV+SzoNsgDzKCxfxhvrWnNAkJm3mAtj+unSROxpj8ivXIW/6VYoTDjt6Sw?=
 =?us-ascii?Q?R4zRYtLt8ZsbA5wLf43Zyh+gD07u/YCFDIuJZJ0YUUIob5Y0LBJ2pvQPEKBx?=
 =?us-ascii?Q?ytmHKGmEfZUsMuQcg4ZbobJUzSKx3HYgwhNv3r+qAmJRAjThYNv8Ha1LUL++?=
 =?us-ascii?Q?eiLoYk6F2nX1ns2DplIGDBtkyS+FUZqzafdxPiSy92Y4TDv/LN78xluj9y9g?=
 =?us-ascii?Q?Frw2wAMRffHB2Pwo6Z7N2MkdaOXTHsXTnTNtXT6o7uwY+PaHoNrB5cV706qQ?=
 =?us-ascii?Q?hqtiWzKoC7H008EPKhmi+COg1PiYyuQCMNZCG9uK+5ZZPQTUQdpTsgRpU+0C?=
 =?us-ascii?Q?H9sGkBykVk0agUBBD7UZfYDOJbSjiNpaQhvdHlTMiGtsJoJiHbgjA24xTeMR?=
 =?us-ascii?Q?gyq7+wtS7IPUsD0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 22:39:35.1813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a154fb7f-9274-4bdc-fd44-08dd68001704
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6787

On Thu, Mar 20, 2025 at 06:47:40AM -0700, Yi Liu wrote:
> The underlying infrastructure has supported the PASID attach and related
> enforcement per the requirement of the IOMMU_HWPT_ALLOC_PASID flag. This
> extends iommufd to support PASID compatible domain requested by userspace.
> 
> Signed-off-by: Yi Liu <yi.l.liu@intel.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
