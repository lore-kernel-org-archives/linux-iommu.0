Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD9221ADAE
	for <iommu@lists.linux.dev>; Tue, 14 Jan 2025 23:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736897357; cv=fail; b=VA66+QcrOuYteNfJtQLptgEt336x6jbQuph9uLtHlHsV/ODW6PGfmJac+xMwUIp2EQBv0ZoBYQMrV8GCdHpVfhRNJpoiw543zu/fkEzx1RyIAhx6h4QKGFiAOYKd8dn4dPfTKBoUpwZHBG/JwJh+4uw8QUMLzkTYjKxW4pBigNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736897357; c=relaxed/simple;
	bh=M2eevhMsH4/ETU4aGMoD8+PsxmP+bl7o6RSGCaf81jQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I/+etgCBwcRalgFGnSs8RipMF87q7zZE49gK+BKENmn3mbigpzUwpN9+j2B26e05QamempfafBj8ySaUVX2g56PkgY5MZGgJeHUyNesdlRdGamXiuVyqJFrlaB9tMZWg8KcqxZ+nBMDu76479kB5DKI75J6EN3/84kRfF4No1pE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KcJfPk9b; arc=fail smtp.client-ip=40.107.93.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KcJfPk9b"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqqdE+nJjCB6rZSTKCKWpMfjZ+KalrGxBPD0ksjyv8ucZOPUNtfFA+XVwPknZrwACz+PAt+xwrmN5jw4QpBqthiVsvCJszItjY5RUFrtu9BWfkyLwAD5S31nc+EsMgq5zDKPfLilCA7iTKwgW2LpAguOIddVu/h1Ro3osCXSSJduylliteXis8mVy2JW3+H6cuc1oKkIpkWXpPloOrABwAbgEaXnxTwGiXHL4HmeG+rFbUfn5ATcbvHGitH/lyuDNBUDCuFHbBBfHCxrnTlSLmgFBtvc9sRvEYifzjPrw3/5/CqMXaKN9xkKgOohoDpC0XkfrjYwbk1+ej177cVJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rd3FWEIA6UFiFcDoLOjsL+8YohzwjGdu+qXhh9Kt5xU=;
 b=cUNWdSDymeSo9FE/k7+Y9CdUhsTKIaG+Uqpb7hyeDOpGv7O5NGOR9BcFhKygEy43ojTLzNZAGnoHLdmKhalBPWtzxiYBOTotu5Et+7VK1oH0ghUnVaTQUyhqrkRIHGlgQ+IywBrTfK7cSaNHRKCCh3pU8iyDrA8iAC6qmQjv1+pGNXX2jWmTNBjgCv6TZ2HwPG43rZ1ybs35TiWYB7qLyZWOIlQABSKa3AgBle1Cn7dNnRDeMsvRcAtLkUKYHdbKpRsP/fzOuWPz5Hksq0qwAXQdm4cXrH28jiJUz7uaJFs83DJLUS2O5IwQPd68aP0rVDiXq5jvLZqsQ2K8wXN1tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rd3FWEIA6UFiFcDoLOjsL+8YohzwjGdu+qXhh9Kt5xU=;
 b=KcJfPk9bu/QZOgvsyxuMIZpUxn6EPz2MySJQAo7mIT2MLSbZNWsqHO65fc6BY8B1rL9j32WwIeE+VNWWhYhJu0KlRq5Gx1vgQfWUajoUyQcmndi987P/QTrK80Ui+0uo64UtmR59WU3BFuoyyGGrbAX8utPDCcH3khLaN5NS2MwgAXXMuJdJQ7GQ9oIzzP4SPlVW6soEgw+XX4EZH23sBiiux6DY+ZpxGmHUesD8d6TvVenH82PUknDhrUtJ2cNxDP8sLsxZOZEwWF4PJu/4eDxAmH4Ws6EXreTMAF1laWr4BXmR/Oy1E78VA0mCPn4zlcbLBautOu8kXe2FXItNrQ==
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by IA0PR12MB8932.namprd12.prod.outlook.com (2603:10b6:208:492::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Tue, 14 Jan
 2025 23:29:11 +0000
Received: from SJ1PEPF00002325.namprd03.prod.outlook.com
 (2603:10b6:a02:ee:cafe::2e) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.18 via Frontend Transport; Tue,
 14 Jan 2025 23:29:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002325.mail.protection.outlook.com (10.167.242.88) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Tue, 14 Jan 2025 23:29:10 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 14 Jan
 2025 15:29:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 14 Jan 2025 15:29:03 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 14 Jan 2025 15:29:02 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>
CC: <baolu.lu@linux.intel.com>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <joro@8bytes.org>, <will@kernel.org>,
	<robin.murphy@arm.com>
Subject: [PATCH rc 0/2] iommufd/fault: Two bug fixes prior to vEVENTQ
Date: Tue, 14 Jan 2025 15:28:43 -0800
Message-ID: <cover.1736894696.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002325:EE_|IA0PR12MB8932:EE_
X-MS-Office365-Filtering-Correlation-Id: 65e4a582-2c54-4507-64b9-08dd34f33fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I4DdkLJ7tH8PSIv5RAtaPZ+G+tJ3+YqN9Qu1tIDR7fEOSHwfUyICRXCgb4uz?=
 =?us-ascii?Q?xhsb18mKqDp91VCgFYOvK7UB84cAdwMf4PJoObuSjV2Sr5Y2s/3aUHDspkdv?=
 =?us-ascii?Q?KuLhm+6Wi5LdiFqcT+3hv74qvffhdMLiEhNMv/hR7bMvSPa4fp9qIY6ljDyp?=
 =?us-ascii?Q?1hIo9cDIdkZGSKxsMD2/Ja0p7uWGf34HcqsbZnmFLQ8OeCD9ZY25YTnVuXph?=
 =?us-ascii?Q?5PPQWAAu66hMvWzQDIo01HbeVlreOax+q+BII6Srb0NWQogOdPEO/2FCGIdH?=
 =?us-ascii?Q?N9EcHEybV5HpV7NQh+MuJQA7WcexwqfvGgyTsm9i7BlzWqWHHOZgThB/TPnb?=
 =?us-ascii?Q?SNFjF7e88sNRBUsPvfekrXZLS7eh9ZOXFA4+gMFxeby3FTHhoA/ZmipViPph?=
 =?us-ascii?Q?LI8NxQbbMsANFAb3n90oolTcwEuDMEaesFqTBrPTzKFlG1VWdf2s3kI6uBXI?=
 =?us-ascii?Q?XUiPhxfNDQh0yLJKiyGjK4LSUFQa0F3zZ55vZ1QgLVaryZDW1uvNc9BNabTo?=
 =?us-ascii?Q?dK2P1mcCHe/8VpXlxqXbei0tFlFgxuNoywvMYU5uzIT/Z4pNLA1VIQzhSOjt?=
 =?us-ascii?Q?6S5ORsCjw/liAmjDWAXoxZThtzKQN+2XzYKV7dxTQ+bbm+N5+UWUKXeNlg91?=
 =?us-ascii?Q?uSStGzXdTlbs+4G7j4sifaUCzjRBJoUIUr4Hf7HYnQVlhwBK5TSPKEBWyTgH?=
 =?us-ascii?Q?1orIPk3wkESZayZaqo1H2aFWS1N8f1E/44vQPxzoJ+pMbSk+GHtn2CXcITus?=
 =?us-ascii?Q?z/LIScPyH/r8ZuCGvpep3IlfgtGEIfB+k6P6kwHxkirP9q0lJh5qnrMGV1RG?=
 =?us-ascii?Q?3FtxdqPTbZq5b88ZhgmKQhp+mEAtkNkD0TfKUdBHFGXvyrI5bOeU9XZwzjeV?=
 =?us-ascii?Q?ep5PqRbacTkX8OGDJQrmOpLDNhvbtmWcKy9z7oAfCbO25qP9bMzho9Q2GUk/?=
 =?us-ascii?Q?e/ZANbCEJBuknv4sofD579tx7t54xzrNxCpnfjurOYM0zPzyVxslUHbMLEnt?=
 =?us-ascii?Q?znx+GuflynGe2Kga6IPRQi5E68dgnOS8ct8KEA/EjlCbh7vZKDCEul+kfo63?=
 =?us-ascii?Q?BXG2AdhpBDjK7WwHPl57zc4SkMFT3a5i7dONAUDLfcC8kixcrElYOY0ssUnA?=
 =?us-ascii?Q?PSLUARvzKHRJEs0t+qJ+nQ0e/pVMhJXzRQ8FNtd4+QZ/QUrbEvFT2PKPgHKH?=
 =?us-ascii?Q?+3d6AgE8mgqxvf3AoMzqeTOJjWRBAb+qzwF2um8V2sXgntw45NqlFq7WYlya?=
 =?us-ascii?Q?Ab+76JvFFxxcNzCsyshN3Je145UqPOPXSRoJhm8sCFilhnMrkvaCnrp9L6fT?=
 =?us-ascii?Q?H4FRFzW0R0NlOe3AIdlhZq/jKF8NaLfOrhw30VGbjpCSCAzUEuG5VrMcq+PP?=
 =?us-ascii?Q?FUKrCJPbA3OBH4Zc6+RHes8bSDi3v9TUeUQdfZyY3qay4r2s/Q/8TlSqCCGL?=
 =?us-ascii?Q?OFfKa8sMwE+jusEyFwuLXH+T1SCwSrQ1/znSS2afzxYjoBzib0Lfg/Elwv3y?=
 =?us-ascii?Q?bhESBnL8ntInFew=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2025 23:29:10.6282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65e4a582-2c54-4507-64b9-08dd34f33fac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002325.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8932

It is too late to get the vEVENTQ series merged in this cycle, while some
bug fixes for the fault.c file can go in first. These fix two small bugs.

I will send vEVENTQ v6 later to get reviewed. And hopefully that can get
merged in the early weeks of the next cycle.

Thanks
Nicolin

Nicolin Chen (2):
  iommufd/fault: Destroy response and mutex in iommufd_fault_destroy()
  iommufd/fault: Use a separate spinlock to protect fault->deliver list

 drivers/iommu/iommufd/iommufd_private.h | 26 +++++++++++++
 drivers/iommu/iommufd/fault.c           | 51 ++++++++++++++++---------
 2 files changed, 58 insertions(+), 19 deletions(-)

-- 
2.43.0

