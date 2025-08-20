Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2041.outbound.protection.outlook.com [40.107.212.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0E2E3AE3
	for <iommu@lists.linux.dev>; Wed, 20 Aug 2025 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755689460; cv=fail; b=Dtp0iw6JonxTAU1FqtnG4o1vaznRAlFJ5CW+RbFGwhIvV/kGh3j1cpYjaGD42e0JdAIYhcPu6W9wyqCB0ZD16EBqNJIHbr54bVTHmyiVr4CrBVsbiUPH0hn6+GgC+b1KOdOPwZDzJl88BELXJrx9IDSkNz4ismdJA/HVzqlR3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755689460; c=relaxed/simple;
	bh=GuUS+V6/Kq+K6Q9lYzGYTp9rbAFZFi1y+Fmn06kyv2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=THJrQuBlIaMn2I5rNOAxnsZPeklWr9i237bkdxUCNjbf1fbhC2z9a5vM8NNWcwhgzTta3hzLgdelU/0d3UHy4yAH8JBYhavuumc4/enDALOzl9EO/1S8vjp7bn+ImSYXHYdgqT0hOZ2SQbajZXJXnHXUvpNJFXaUl6fd2f/ZV8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lXSCVdPn; arc=fail smtp.client-ip=40.107.212.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lXSCVdPn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qsmqPswGU592fhWeJcJiR618l91T9GmjNtMAIPbN0Lgv+utDAqUSrk/z6JrT4YP1rkFmqpzZ+LWFgqyTvcYu31s6SeC1FMs1JGrOd0YMIXUT0UUpqx1EM1OmDdYbujbP7dSHMIAYdM0h7EshlYu+y8s+y+Jv//GkTykH2VSB+ZYN1Pd0kl27K3+JeeiD/kx1EmkXohGbTGo0MYuGHsTE6XCoFOIQFeHe3VHYWNFMN+0hudJ59dkUrpnHXwCrww9fqznq7zZ8F30i5Lkdb7aoWUxji5CnQXEjuA+svopygNPx9V3LOgNIwEqlmd1izqwWj+mfLJ3LFc80CYASEVeDtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/o2GSEeWwviTNPDK8lA51t4p3LtCF2qDdXcD0CKUhdc=;
 b=qFDzXZW3EFkjnljNM5KkMGTlvZ2+WMpa427mkqRZb9RHACqRcI3QvtlZ0C0mDZib8rhiLoUxy2hVQJ6tYzgYAuTNy6qqOJtilA8R6m1zmvUkDUEFosPUF/4fxQQQ01791lIVzNvEIKl4QSmE4T4/hHoUqxeyDj9R5OWVWf5DQD68Bhzg24du0XeWocjmRpYTq7FEnyLJ2eoMr/1FA1x/iYdhWqf/bMO5lFMuUJIo+bSOJY9xR+7yYulGraembTa/GlMNNMMOcY/k3vS52xpfJFLroNCZBhBBZ3bkYv9vKUypVlICIIQ2lLlRjNZSsMuPQFQsBUa2XyrWP0GfouT/LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/o2GSEeWwviTNPDK8lA51t4p3LtCF2qDdXcD0CKUhdc=;
 b=lXSCVdPn01OU1Dl5U471kx+s4OhjkQeYyrMIJdePBM2kQ2yQNMVwrkcfaeWDNlCgSpKKYSozo1c8zECjwFnfLFOERqtR50sxiSDYw1HOCsFqb80O5PvaxnzJSd38Axc5LQQDzUQPkQexI8fOoAmvAhbTd5TMKwxzVMhlsreNPB0=
Received: from BLAP220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::10)
 by IA1PR12MB7496.namprd12.prod.outlook.com (2603:10b6:208:418::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 11:30:55 +0000
Received: from BN3PEPF0000B374.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::76) by BLAP220CA0005.outlook.office365.com
 (2603:10b6:208:32c::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 11:30:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B374.mail.protection.outlook.com (10.167.243.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 11:30:54 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 06:30:49 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH 5/8] iommufd: Introduce data struct for AMD nested domain allocation
Date: Wed, 20 Aug 2025 11:30:06 +0000
Message-ID: <20250820113009.5233-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
References: <20250820113009.5233-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B374:EE_|IA1PR12MB7496:EE_
X-MS-Office365-Filtering-Correlation-Id: bfd9a445-1cac-406e-8a1b-08dddfdd0677
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hxkzaDvY2fp1o7CgbhHuUQRGgc016oGI5ScO7etKePpWXNukiENbf+yLK+d+?=
 =?us-ascii?Q?3tWFRD209gTb8dYXOtZEm9l+5g6aQWAdW1XsKwV9Wim61W1evp+wVNdcDlPr?=
 =?us-ascii?Q?kHwx0Dy78fA4givoT18G1jv8OWZhRnGwKUB0jQFH+BiaDJbj3z/TDbAif8sz?=
 =?us-ascii?Q?2gv4cAbWtTswy81+ICEaTkcdKcLCtV8AZL/Jh1S8rihGbETImWFW0GsvLo/X?=
 =?us-ascii?Q?cIz2Ccdr4xo8N4uOg/DTeX2f1jGIVF3crWzj8+lPudiAfpWwfhvviM1Wv2tH?=
 =?us-ascii?Q?xkMghKzVBbS/yoSFxRXFT0Z8wpRKEUYWkshzgxZ6j6V2bCj2435Zf6JG8OY5?=
 =?us-ascii?Q?KynuXBhoA5hzawijF+bAlkUsuhtlrthiKGjq71sHTsMbZoJdSFcof/8vIY/c?=
 =?us-ascii?Q?zskxc8VkOWlZVAe81jA6D77iE6KfO/BNENrsF7JPMFkzQiB+lKSU27VW20tF?=
 =?us-ascii?Q?KJhj8RGZEgFbhqzqqA+iZsDlz5dcv1vikCOVlz7e5netBPzZeDpw3MProZ2n?=
 =?us-ascii?Q?q4hiJqY4xy9naWgLSz/XoX70zdxIXf9M0loqJFakzH0wqtL6jf+sT8c8n9vi?=
 =?us-ascii?Q?6IKtJpA5OprBXXym4mOtYVj0IANzyEbyAHkXu/BsZUoyXQsX4Ywf5F/B8mU2?=
 =?us-ascii?Q?MPMznxzeQErm5LcznBlreSfZs+/9hmquXWUriLzlk6ymyX3eude3jSj2+u6q?=
 =?us-ascii?Q?eo3Vx2w3QsKkaN5GgCb9fqTNBbpnfAM2op05r/YY6yC8YzFh9cvSpEfe7Zwo?=
 =?us-ascii?Q?KZE4XvFLdygy8b8UoKjww0ZeJAhxi+ySDyaeY2CTsvMvhYgM8FPCNePQvIo3?=
 =?us-ascii?Q?uWGfxj0045udlUQoaJ7sV+b1qVXS2E4p01j+Zs+SY/4mRFJHoQTfg4lOxa+0?=
 =?us-ascii?Q?2u0K++e05y02nyglho0JX29p8NMiDrNnQ3TocfWoJXwhophLwi7814gZFWvb?=
 =?us-ascii?Q?sdalK7jiwEiLAb5R3V9Or3caSEql1z5fCEwszqWxec0wAFJCbggY/vT+qAHo?=
 =?us-ascii?Q?re+yIPvo80REt6JHY/W2n2JEDHfvY4QY505B5wQOQR0CZy4Pl9UxYqgUo3k4?=
 =?us-ascii?Q?b74f53OwlZUhgBB1BBa1CnhwuLMvQGZZYEQM4lcoJ7/6PZ0toDlTdjO6rf1P?=
 =?us-ascii?Q?j+w4fTm8+wmrFve7GPfIta61GuDYSHaZarcSTQstmipAGhlwpNHVu585FSQd?=
 =?us-ascii?Q?bV9AU1gekRqH7ZFNTp+lEVdoPNbsT1wSNPtX4YC2w2st/hTlai2cPFkD2igV?=
 =?us-ascii?Q?EwhvsZjia5aWHHsP4xOSdXm0BLoy9lZvRhWJ8LMq/orPtN95F0y6nRJkw4fg?=
 =?us-ascii?Q?62scRk10LN1EgWaAmKc+plu4hSsfbKLciXeJVIFFo9esXdAAC0vG9qElernc?=
 =?us-ascii?Q?LuVlNviirLHqLsUk8gQQkoUjy6Y7cZNxv7I8QqzIiiPXXmCylRWid2D2Dqmj?=
 =?us-ascii?Q?LsWJkQELljLlkFwYVcykhxLdyvmf7t2hoDSSFM3CmjturTnnF95hrA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 11:30:54.5313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bfd9a445-1cac-406e-8a1b-08dddfdd0677
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B374.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7496

Introduce IOMMU_HWPT_DATA_AMD_V2 data type for AMD IOMMU v2 page table,
which is used for stage-1 in nested translation. The data structure
contains information necessary for setting up the AMD HW-vIOMMU support.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 include/uapi/linux/iommufd.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/uapi/linux/iommufd.h b/include/uapi/linux/iommufd.h
index 0f7212f9e0ce..a12353488c83 100644
--- a/include/uapi/linux/iommufd.h
+++ b/include/uapi/linux/iommufd.h
@@ -455,16 +455,27 @@ struct iommu_hwpt_arm_smmuv3 {
 	__aligned_le64 ste[2];
 };
 
+/**
+ * struct iommu_hwpt_amd_v2 - AMD IOMMU specific user-managed
+ *                            v2 I/O page table data
+ * @dte: Guest Device Table Entry (DTE)
+ */
+struct iommu_hwpt_amd_v2 {
+	__aligned_u64 dte[4];
+};
+
 /**
  * enum iommu_hwpt_data_type - IOMMU HWPT Data Type
  * @IOMMU_HWPT_DATA_NONE: no data
  * @IOMMU_HWPT_DATA_VTD_S1: Intel VT-d stage-1 page table
  * @IOMMU_HWPT_DATA_ARM_SMMUV3: ARM SMMUv3 Context Descriptor Table
+ * @IOMMU_HWPT_DATA_AMD_V2: AMD IOMMUv2 page table
  */
 enum iommu_hwpt_data_type {
 	IOMMU_HWPT_DATA_NONE = 0,
 	IOMMU_HWPT_DATA_VTD_S1 = 1,
 	IOMMU_HWPT_DATA_ARM_SMMUV3 = 2,
+	IOMMU_HWPT_DATA_AMD_V2 = 3,
 };
 
 /**
-- 
2.34.1

