Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894FB2D8372
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457352; cv=fail; b=HcTYJMDmevUMZlnRRPGtH2sXog5oy/Oi4qz0Qu0W5FW6/mgrp60rFU8QXKSNQiw12zaxUs+oXvp40JpIPHGqurG2E4bZVmxUcBjWN/JdaqjBMNAjlTihTvIauGwBDGb6aZ22sPFB1QDaC7d0g4jSmNT2lcY7gEXhZmTlBF3QcHg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457352; c=relaxed/simple;
	bh=CvTGr3zhrSdTS7yWboiJi2FRwOPHC38YAxXAP/sveq0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M23DALRoQaTLZpWCpHVusPwI0rRV0rPO3Yr2hJL4Qn4bpQFHRLzDjRL1P1ASRhxCJ3AGPrqjEDAuBHnrj9z0WwLXkmtu3nXnzWJ8DOKcSZny8J7kTkgrNzE+xNU1Yx5YJ5BIlVoclJwXMJ4nHzPcHA3WvcETh9stL9IeRecuYV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QRx+TFkS; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QRx+TFkS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCOjjiZSdnq2GUep7+euDZiEeblHOumfqrWJV1s1KTQjLlewSBL/FvyTfvJsdATXnkyMEp1HybjjqDKhh5TB0p7WpOu3I5t6UL9Zkkd3yV61T+QjAqJ78ECvZXFmZdCzOhn7UXdr90kRW39zOE4JtIdn376jUAtsPXxx7cr6u1TtmGRha4jbO0rbqGiLbjvOTTP7ARj5uDER63LVBMWmOCXAhLYB+lG1rnBKyyn+p7mfFtVJPeSz8RTOAYoM8M/loWe5z0ohxTdmx2ChhODRjppgKR98WtECmPoTfGJtqoMJm2Q4jS/yFPFcHvbw0yjIHGg9xnt0wgkzMTe+vYBSVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZlR8CiAy5HrhukKNc33sCqFdfksok7tMp79bTJkb8OY=;
 b=MEmjeW/CrybGBE5syfy5q3zVYaedL6jbb0NjjZiJbe9k27QGxy/rg3ZjLEe0oWKG5UcrXctTFLK4SVXZHEpvZXyWZUv9eZZdEoapIZeiICSbdbdtSX3QEeslpBNzHydW2JpH4pTCXh/862FnXcdpwpT8zt49ZMivoJDfT906Bz2N19ZDEdhvsO7Hc781+hitN8WHCgkJEX0G09n0jBAzOgDOZMzWf+oc2EZ0W+Bu1iXAg9nH/iCeXBt4GKUY4+//ZjzxjqnyIQSPWY23WAaUTrzZrLs565rLgbEIKKfOJYjZo05pEWtaroOYsfzwTVHQR5uOTj1ILLu6bp6A6AWSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZlR8CiAy5HrhukKNc33sCqFdfksok7tMp79bTJkb8OY=;
 b=QRx+TFkSeGDhGwrMquF0rnPYLW+LxQ30S0OmFL8Zv7piGVYxZLXNWTXoqgDFk8sH90zFLqRf99wzjUvKUAOhU8KNu/Wjl1QPvdfKEROjpgr+u9zk+GNKfxZIW7XCOAfemIclmWcoIIt/J82wsmW/pqkdJIJrdcwcYIyeerzMx+w=
Received: from SA9PR13CA0056.namprd13.prod.outlook.com (2603:10b6:806:22::31)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Thu, 15 Jan
 2026 06:09:06 +0000
Received: from SA2PEPF00003F66.namprd04.prod.outlook.com
 (2603:10b6:806:22:cafe::ca) by SA9PR13CA0056.outlook.office365.com
 (2603:10b6:806:22::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:09:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F66.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:08:58 -0600
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
Subject: [PATCH v6 05/13] iommufd: Introduce data struct for AMD nested domain allocation
Date: Thu, 15 Jan 2026 06:08:06 +0000
Message-ID: <20260115060814.10692-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F66:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: 3570f0bd-7067-4c9d-c26d-08de53fc96e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w9xRK7klWu9NmjWlp8ojglnf5taER3xXjjwTwjOhjGIQwFssXkq0wydPwOpq?=
 =?us-ascii?Q?JefFIiVY5Tiwin22OKil7Op9fsEC63Njgix4AgBtGR744VJ1lfzUeCE5ze8z?=
 =?us-ascii?Q?MjYOlfDvZ/X5wPBO0CXOqGCwUTPuGU2rDKWGq/veN8FF0EBWIEKz4/5KANgB?=
 =?us-ascii?Q?Gc0fjPP5IJ50WRo98+oZfbBF2A2SwKIgsMGlZtZb0Mbo2Z7GX/7FXLO4+VGj?=
 =?us-ascii?Q?5PsKnN13hMx6TwzuIiB8td/rR9ZDbb05SA6v6qUKkyzeuGYNb3b9MjhPNHW8?=
 =?us-ascii?Q?n+H/OcCLECZtIBvtQ3CkckqpreK6uFzmCO1lc8lhRdbPuZVVpUJ3cq5VZtkf?=
 =?us-ascii?Q?jRg5FkjbprXkX7DzYptMrbnQVMcdqwjWDwttu9Ad/4e+DrulMG130LF3K+tR?=
 =?us-ascii?Q?z0scsHA7lk1l4ahgiJyLW5d90mvARdNwRnNTDXwu3S2esJmPmGmTSESmCtjp?=
 =?us-ascii?Q?ReZkZZiwk6xlBPVDdsQTIfRUiOUKKdwlEoiRTlSxbuPZpSAnEdJM3uz5zMCS?=
 =?us-ascii?Q?OLZPh5JAQeBQmAo+Tea9alvyILi39/1LtRrTST0qBMH+cR5I/j7byZrWEbkk?=
 =?us-ascii?Q?7FQhIgQBrd85PW56AKUgVgLQU5brV1+6T9NwUqgo7aUcSgJwR1jGKOe+cOmn?=
 =?us-ascii?Q?eDM3gp/tKibZ4lWJdxmWYvs6pVHj7NIzlSM2jqIl6Uiyn3P39upvhBpuD6WY?=
 =?us-ascii?Q?md9pF9Lg39bOzWS+qmLM0dcCo3yR1KpSi4dT+eNozMZVfcAdxxJWpoKMI1K3?=
 =?us-ascii?Q?UhRJJn17X+m8jivEEqHelxu4C9MBPnkewHXfdR5Im3aZtz4Fj++VJte2eP+T?=
 =?us-ascii?Q?AbggzmQgFXl3f8Md2fi9PJUy0lbu6zh2TUHRX49nCBx4Bvktz1OCNkaFJUx1?=
 =?us-ascii?Q?RALxjwQ1LtyhYK3+ulqo2C5Ui3x0u4Aj9qWAdudFSt7KobmVbRF2kO8848RP?=
 =?us-ascii?Q?ScqObKc+LhZbNA7KUBI+c4Bg8ckYsNX13QTJLlSn7I9pfVd0jXqPUefu/jRq?=
 =?us-ascii?Q?rG6Gp4ytNZ5hweMcWGfAwmcsxpHYoMStY4fbN4kEur3pCobhE1ALAxqT/ND/?=
 =?us-ascii?Q?/dPHnJoElLJgJwZXUQF1zUQBzCCQ+8YgOWgKNf8Msk4aywUbFRD4jCow3Ekw?=
 =?us-ascii?Q?kCFJ2jV+9wCEcZG5mCQH7Dk3C5Ht6gFiGg+I5tkqywHTxRGduYjr93+FV7Y8?=
 =?us-ascii?Q?dT9NPXAbZeUMzWHaJcuvDCWTyEzSvl+e/gOSa//iMyTT2j7N9/yIhPWI7nYM?=
 =?us-ascii?Q?MfVefatj26GOgXskCEXEMXHiHbNoZLxvwm3mtjxmulKY5snMVFPaOe+OxMh3?=
 =?us-ascii?Q?EZStjlg9Np81nOxUMYMkuIxwjCPhUB3A+jOqxgIgd2TTM7llniP1yhXI8FpK?=
 =?us-ascii?Q?TZMDYUibA3EBCmHq2IWhNx38duLSXmXXIz4CU9tOPbF/MzvHm0PSuOODUi9h?=
 =?us-ascii?Q?DCOgP4mmKDCcXWVtKpGMecxPIPR+DMEUv7gvchZSybCA4/ojUjI4dmV5e/Qi?=
 =?us-ascii?Q?18aH84EFrwDcXiIaiWIorB5SXk95XINrzjdODk5V/NNpHmYAJhXhdq5JeBMG?=
 =?us-ascii?Q?LIV2lETMQAr4dlC8giURwWzjGp3SW3Odk8Yc3w5ttIXmidZOUSu6vhQVztz9?=
 =?us-ascii?Q?waclnWtbNHB4O4U68Amvatpz7pvVTWM1dHlM7ymSd4w6NFpHJUUIBgDe39Al?=
 =?us-ascii?Q?Bx49Dw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:06.1292
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3570f0bd-7067-4c9d-c26d-08de53fc96e5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

Introduce IOMMU_HWPT_DATA_AMD_GUEST data type for IOMMU guest page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Reviewed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 3db37f6042a0..1dafbc552d37 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -465,16 +465,27 @@ struct iommu_hwpt_arm_smmuv3 {
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

