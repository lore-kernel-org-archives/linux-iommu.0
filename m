Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012019.outbound.protection.outlook.com [40.107.209.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5621257821
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011082; cv=fail; b=uOXt0D/6o3FWMPXeim9BRQWdMAD92rWRQauAAf4Y/bjhXfbFQh6REVlDcLOyykm4NLSNpR7BjmEHZio4sLD/oaQD1bkSmESaifvTWz5rdjmKsvX2GkgMlJwNfybj03Mxc+cagu77ly7AKdO/OUZCUNJthGMlDQyqsToszzokNv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011082; c=relaxed/simple;
	bh=8FWOQD4lv6MveqPTtoUHsWXORHCb1a5ALm5U2qLhj0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tKOuZXwhjCqhWItm4ut/ueX1XfbZAME8nJ+ZpdmoVBmGE4RftAwY7S/A9WSyet3Ahumry6FflvZns1q3rIS4FdRKK8Hvw5E7VFocjWeUp8T37Xd7s+Hi9iYQ+1TlUwIw2PJbFuco5KHGCJJUImVBCdMnhxZcFrycl0QZ4iwinNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Nmy2zYTH; arc=fail smtp.client-ip=40.107.209.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Nmy2zYTH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gv3p8mxvxzVEGGuAFwAL1HjRGU2I7IKqnzwxVbHDlNNwZW7L+cR5QpsZX+Mdc9zkIU4y7VFSaJ6Yucl9pwU2t9ehvX3s+oQ2vx+ExuaYFccMh3lk+imCl1cNNckRUQ4bL+elR27Vfo1ZPABsOsomJCPKxa2d0bwjJXRRgTiUkvS6qyovjkqhZTEcoTJg4tlQBgnbv7zlvlfydL/xsnA+c5WoKfLpYK2AAXy5ti3n0QNSrk+GoGauaoinvzxrFL7n1hRoNIDzyP7RiXGbXigB9jblY10F0dn3u9+fZ55m6W/pLtvcq2ufjAEt4HLdId77r4+luzOAfDNP2fRmTBcFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbfva/eTRZ3kvBB7tQIrSgyV40JWqCGZBB1z8+gemYg=;
 b=leGsej55w2t0JjzYSXfiEZXXRVUkpAJfHE5FAeXX/IFxPAu3PFU9R0lDZJA7q0qbsR1Z9SzpsgkPrjav9n0faC2ULbISjzWZWOKajn/eR0mQmo5T3kY21n28BaqCgNGOyyKB5yTfePaUOIJf6bPL3ZQBnqYODu0ZtqurdCYe8dKhuyUdJSOq1vhzcLW5pdsnXJ6bhmaHmWwO1L8vYzpKK2vks0V+NIBK0/8tmgKz17ngsbtfBCHGBmAR+6aEZz/CaTD8E9VuqQ9Ztv0yGVFAv66h+QtKiRxguWmHEBRYdwyxTktGzuGXqEXgLvM5kAUBTibRola4tnFUSGoMmHRmMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbfva/eTRZ3kvBB7tQIrSgyV40JWqCGZBB1z8+gemYg=;
 b=Nmy2zYTHuHSL6crwS2ixjzeL5tDulXzXQQnE89HHPCFOQkjzn03UScWKrBsajCIC5aMxhUzJU3LC6AJVPPsFMPzQTdQrqNiRHDwbbU2wDI+kEm6VVtmmnTzFtKbzfrliVlZcx2tGLnosWbOi8/T0+wpfdWHReXY9TQ28ujlVQqA=
Received: from MN0P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:531::24)
 by SN7PR12MB7884.namprd12.prod.outlook.com (2603:10b6:806:343::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:35 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:208:531::4) by MN0P222CA0015.outlook.office365.com
 (2603:10b6:208:531::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 01:44:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:35 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:29 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 08/16] iommufd: Introduce data struct for AMD nested domain allocation
Date: Tue, 21 Oct 2025 01:43:16 +0000
Message-ID: <20251021014324.5837-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|SN7PR12MB7884:EE_
X-MS-Office365-Filtering-Correlation-Id: 3408676f-ea0d-4297-b8c3-08de10436378
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|1800799024|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QgwZoxczG6mZzn1Sl8cWJ75xtyvOLyvAC6qnrE85lUmZVznttRn2mVmu6frN?=
 =?us-ascii?Q?2ATKC4dnuCOjd7ivIA/+bXjawgbYXbuMb86uzmyHOGOB7VVGBFSErWwUhMo8?=
 =?us-ascii?Q?IiXjUe0cIozeNNzue7ULBzCCbhdYGzXTOw8GRHriRvn+0CxMPidHeoMu5D1H?=
 =?us-ascii?Q?U0BYPen2YcqD3MLI8IVxayLlgWA4+qmgWXhgwHsqHNJTBscZcEXH8rl8lS2h?=
 =?us-ascii?Q?6NqkQ3mXha+ZNk3JEKG5GdnQmKxO+dz6DPTArBLGnJK4t1bXuwyiDulZJ8KG?=
 =?us-ascii?Q?2qf1lLzidJuWUhSLsUdqrnGJUMGmTVKcjEUGfOXZt9KnCzy29ayaSjYvMVTu?=
 =?us-ascii?Q?DXqpKQ+JnKtUIcqxbjhEYaGBDyQajfKCd7yh6c79+xdqdXdjAYSKmUzLfPZ8?=
 =?us-ascii?Q?Fko/vrAnEG90AAYOMkc/hRHxKyRtUEYrC+pmSsd6ewFD2neLLFvNT6oQHpYG?=
 =?us-ascii?Q?Q2i1DVQKybnL6suw/SMBLlX8FcsMI5KHrZoARhDoNFMSeDXOTP5gnTZRfRE/?=
 =?us-ascii?Q?CZp4011oKx1j+9HmFgJ1HQGwcM1A7PXIJZC5TqxUqIiLXGArsTet1xZYCb5T?=
 =?us-ascii?Q?HS0uVtEai4vkom/kX8nIGrE46dQENOXd9V/TMolLUVLwH8JvCHAOINKaguiT?=
 =?us-ascii?Q?7ifJ967iyQR9mhDX9z75EE2+eyNItwBFhQJPxPsw0HETPaX0KnYvGlBbdgt9?=
 =?us-ascii?Q?07gbnFjcJYNlipAhZIk3GWbyGCN+uhSdoIsSxwrobmoYJsDEyw/voN7gwRbg?=
 =?us-ascii?Q?gvxGrwXwXTA4cAQadUJjfubMaDLKCb83Fcd3qyzGbLygaR++qO5olTHuXu9u?=
 =?us-ascii?Q?OXu8sDibx25Cvsbt10kl2Cb3jCiw4xdKVzw1JF4YcjnS5F6ggAnWfoLhTCP1?=
 =?us-ascii?Q?25pR+4gkrWMUByY0uAInEP+Po3aRjgnvrmUurOjZ6Zbn4bEwZYf1Rd4X6y9n?=
 =?us-ascii?Q?QutG16jgA2VnhlmE7yfUDsqEh2B/SKkY7+SO3SgXEGcykWuDlcKyPb18pYBN?=
 =?us-ascii?Q?u7xq42fct87tOGresFrxOqZajdGMwPRVzgsI5nos0VdUwTiCqdT3Ah9hM8Ii?=
 =?us-ascii?Q?nCPoV1dohJ7EW3nwpDMtJtxW0GVVLCmvI/iYmyBbad2sjOxr27oneFXJJs8d?=
 =?us-ascii?Q?hjKQCv1qjJzVPdk0HsyZrKsZ7jQ/z2RZOYUgJ+dxeiVoMm5Hh+FimQXdIoZx?=
 =?us-ascii?Q?kMwrcbw8ptRj/o2Mr3qS/Sxc0enkoSUOqh5SYJyDQme+gD2nQv+jtlchycTb?=
 =?us-ascii?Q?R5O0rIroOvFGZ84uK+tdcnPK+fj2Pif8GTZIMHu2x3JkKCJPHjyaZrNngcr+?=
 =?us-ascii?Q?3OanUQUQ+35GLMUiwAkfuQl2Ki3x1kvvL9Ve3JcHCKtMcHvEEf0UgOqxR23Q?=
 =?us-ascii?Q?JyAIDkJSGswW0VUCsQlyOu0sDtJp+UIulx0p/xED8lVU0oARvz1mR7JPjkN7?=
 =?us-ascii?Q?E3nlCZxu9KT6POQPTloTNno/XcU54JgjbTYmSCeH3+3i+AMsLZJDeIi892Nh?=
 =?us-ascii?Q?h+no1cRtWtrJC0Gc0UoR1vomJ7FMFJ5SHkzbRlASD90dmABDm2CaKkH/lsSP?=
 =?us-ascii?Q?qBsrPH5qe2NFNZD88DA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(1800799024)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:35.0476
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3408676f-ea0d-4297-b8c3-08de10436378
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7884

Introduce IOMMU_HWPT_DATA_AMD_GUEST data type for IOMMU guest page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index efb52709c0a2..d111ee1dc572 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -455,16 +455,27 @@ struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
 };
 
+/**
+ * struct iommu_hwpt_amd_guest - AMD IOMMU guest I/O page table data
+ *				 (IOMMU_HWPT_DATA_AMD_GUEST)
+ * @dte: Guest Device Table Entry (DTE)
+ */
+struct iommu_hwpt_amd_guest {
+	__aligned_u64 dte[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
+ * @IOMMU_HWPT_DATA_AMD_GUEST: AMD IOMMU guest page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
+	IOMMU_HWPT_DATA_AMD_GUEST = 3,
 };
 
 /**
-- 
2.34.1

