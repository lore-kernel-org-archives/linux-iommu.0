Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012067.outbound.protection.outlook.com [40.107.209.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A6128AAF9
	for <iommu@lists.linux.dev>; Thu,  9 Oct 2025 23:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760054350; cv=fail; b=uDpySiXALTPNT53lko3stodvsFBBz9sobb0FFCPzQfa3op0zPDspzsA6JcLpDQikSyireoZuOnXhRyPDQumw3iEtUbsHc8gdGpvSGewbO1oHAm+mWEMxS+JaL/q5uixYwa4FnVcHcQ9Wc5+giSIxTFJuHRIWymxdSACVaap/DNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760054350; c=relaxed/simple;
	bh=8FWOQD4lv6MveqPTtoUHsWXORHCb1a5ALm5U2qLhj0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGstszTuyB/nPLt+sy77Ps3PUVm5VM2enDv/B3Lai5bZNgWP0+9caFPwnlEMzA0d5P6vIuL7HWtJjGw6jox6+9Sw7W555XDurIbdPXyOo4EeuGry7qp2aSxLUq5UEcWndJuTHAKS6y5bctvfHyqAK9TfS+zowcTfTsiNL/5E6po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=UDV5luOt; arc=fail smtp.client-ip=40.107.209.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="UDV5luOt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wTCOvr7j8U+tROHZ4BTYJApkQhumzeNInZRIqB+IJjG6hMYscVXjAjh8iRTUf+LOzQDNXFtrEP83xM72LZyegcNlkdRB9xJZa8wBRWs7S19QzcvdwnzmXb5KnyylBRZjBFPaVCbQs/o/Bsj0CHD0CpNjWNXqG2cYOiSvuo++6T4c69lQdI1O4GZYBpnoY3TVWHQIhZhlI4vUuph0gOG2yhS62gJDO407TP6W05ghCI64Rw30ixqg96gIdFfxJZpLtXpy9/53jdK9euxZY+JxcLbzQScsCd7mGw8/zIerUYZxunLV3llc+BoN44EEMHxICS3iXzUtceXF+gYWWiTvwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qbfva/eTRZ3kvBB7tQIrSgyV40JWqCGZBB1z8+gemYg=;
 b=ayfwJ1ofm4V56ICvW+0bpax7VD0ZGqNT61mn7G3wkhbPMsX5Svg3YCqlEwcTrYUJYYBgcaYTJIdHLeJ8jRdGlSLefiuWnmIAVJPcmA9h7DuFFTDBGxmirDcnz6u4OqbfzAkuiN0G0R/iv6lC9GrJCkSrPqnyXdAPMk8jk3RPyP9N+BGL+uAzS2yovn1HZ/4oCtLunORYRmeE+Kik4FwukmaRYP6xQFBxqyxmlf8NTFTL7N5Skbjz43Qu/G257OmorOxTonf1DB9LnEeKNji7pSxo+wL77vKEy+bvUWZ6yo1PMp6U2E7/eUIJ/0tGs85GHxNI6EMsxqN/zEpjQ6hXiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qbfva/eTRZ3kvBB7tQIrSgyV40JWqCGZBB1z8+gemYg=;
 b=UDV5luOtS80qEddmQtFhavwyeDxoKfuT2DZ9kcEa8O/rnzXH3gsSKcgmymGelRJ44eayQCNWVx6iJm/kW+FBT4zSppCI/txfNkcZgD3onwHuZBqsaA797ZAeIEDto8lNlY4iIRR7iwztuoqjQnQQlFzG/hvTi0kb43xUncx1k8w=
Received: from CH5P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::27)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Thu, 9 Oct
 2025 23:58:59 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::87) by CH5P220CA0013.outlook.office365.com
 (2603:10b6:610:1ef::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.10 via Frontend Transport; Thu,
 9 Oct 2025 23:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Thu, 9 Oct 2025 23:58:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 9 Oct
 2025 16:58:53 -0700
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
Subject: [PATCH v3 08/15] iommufd: Introduce data struct for AMD nested domain allocation
Date: Thu, 9 Oct 2025 23:57:48 +0000
Message-ID: <20251009235755.4497-9-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
References: <20251009235755.4497-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: 470e8ee0-ce11-4921-465d-08de078fd07f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IOUeHECkvk70Tlw9ZM0rReavdrvKOakONcsDzm/n/LY+FD+tiYKycibkv/d0?=
 =?us-ascii?Q?pAIuWFVVaVnmu0Nig0H9pKue/zU1NDY4AJWk6rgQsqq4MAeXqzSP+EfOngTV?=
 =?us-ascii?Q?EBuh26H0/vtz1T0+ii3OTm7l6ZWmkp+bWS4FKiIvlHEjJhkQJB6V4eUQ5jQn?=
 =?us-ascii?Q?E5aBTR9UXx3ICslEANEQX4lA4d2fwZYMFxlbO3HErB0v2VZVsB2+EEzMeyER?=
 =?us-ascii?Q?2/vDey85JtN8DLgSjnRTlAoZHnzGxjp4GSk+UcegJKwKVQ0vvLl0GOl2CkOx?=
 =?us-ascii?Q?e5Hsw+HVoGUxpB+awfPp5l7myoNZn6hCq257iBh7f9PvLUVyLcwl6MS0B1lG?=
 =?us-ascii?Q?WU78jBoE0DvI2nvOgKyEoiJUgaczQnwe69QXEte/UJzMaxddlJiUbxzEAT9s?=
 =?us-ascii?Q?aDkMmbsFK3GhJ2JmQKC1/Gsu9pX2WXHYzRHVXMRMwNz2F738W7nY7DoBkXuq?=
 =?us-ascii?Q?cQnlTWvqYS3hEI4MGEqHuvhaxugQGbRmzvoor2AwAs3w/R2BRu1kBMDiRSSI?=
 =?us-ascii?Q?9rVF80uaizhWwDbuFJca/PQ8E6hsxMfUP3E+pQZI19hzgz/DVJ8ut8vxMC/M?=
 =?us-ascii?Q?u5Zz6jRkTuxUjDZNcW8rpyd2OdOpQGFl3OZYxf0r2C3GBuTZ16Bd8nAOefTA?=
 =?us-ascii?Q?s3jZP/9G5zG2qIFeofwe+RgWEYhRrH3bJlCOPky6P3yjz/b3UAe01ywjIwOw?=
 =?us-ascii?Q?7+ums58htPBRLcl4lWF4IH4gdLkPl1ImubDXMyNDcEb+36eLD5XD9hxYc9Tx?=
 =?us-ascii?Q?OEi1FQe+HCTOBhw7xamN5kHe9fzrFKrEpS+TcoNhgxjuiTyN6/yWnJat03Xp?=
 =?us-ascii?Q?nCwqIdb0TST69JUAMzwFguSO62jQSAN9T4pPGCIe0uQ6ttkk105NXYy4T3p9?=
 =?us-ascii?Q?rF+r9eSIzAwdgRe9MS7E0jd/5RnZJn/tkn9EjOG+p+9TNGO//pf3FuXCp7fA?=
 =?us-ascii?Q?nhd8gEwtYsLzPKw4OV52ba7pbSj4D5aJfL8ChrvIlGJsIgCvM81SY7u9Xc6w?=
 =?us-ascii?Q?jy9huAcOwr/jZhzYPbbRMyU+6ZJZnYjrYazt3sbnUTluRsRVsTXOsUAo6vGp?=
 =?us-ascii?Q?n0N6DbL1tautTqbLUKIGMcH/7o9Ups5CzXsj7GvOlhTYhSmV+ysJtlk70W+7?=
 =?us-ascii?Q?Kd8wqEqmQO6PPEKYP6Dc5S39PCPq2d5ulPzhi5DU93SiC33v8Rkmz6UndO8D?=
 =?us-ascii?Q?N1kAZeWiek29OCbtgxfBSBk1k8qPrR9iOSHfNpVx5JzQ4ocT5Vk8EGnwk0rF?=
 =?us-ascii?Q?E/EZ1q+U0tWCxTYkVfK3a5zRmmf9KdvsPrfpK9bFhLPIZB/FCPlJBeaqzWng?=
 =?us-ascii?Q?k58qgezNe3fEvnCYk6FsnJJpI1U2ceBlFPG/sdM6A/XBlejE0VqisMSfQ0w1?=
 =?us-ascii?Q?LYBpBFDwnDiFWV3C4jSRCRIyRA4OYqEKWhsERzLPDp0X0DiXM6YOP35bMg3M?=
 =?us-ascii?Q?6EfssHxlaF1nQTzqmgAIFVbeMAiDM0zJ59OHoiOFRQuonsduYxlx9ei3Jhck?=
 =?us-ascii?Q?mQRaL7ks+EcAJ9Ek2G/BpzBEH6qnABHv3mTWu2p+40aYKYSmYGVKQv6BcG+A?=
 =?us-ascii?Q?CYwHnxwGN7CUR5HgNVo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2025 23:58:59.2119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 470e8ee0-ce11-4921-465d-08de078fd07f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879

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

