Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2055.outbound.protection.outlook.com [40.107.236.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBE738FB0
	for <iommu@lists.linux.dev>; Fri, 28 Feb 2025 01:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740706307; cv=fail; b=LkReb7a9+RX0XYfAJXYfZuGBRKKUmvBEzDLg+51/Q1PDexHdg6pqU/tTHnsRjaXISeupMbkFc29rYTTBFXsLD8T2fcsJWzjdeSNyGvqIKhogW+Cy0IBmk++7hEe5Af+aBDh4lFdymmhc4AC2TrSNqbHYdma54az1cPtEjW2W1Vs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740706307; c=relaxed/simple;
	bh=CNgmeONT2j/RXtHk4xm0PMdblX5C9d7j6Q8Ddd33/vw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ghFDm09GHk5gJbCQiQ2n3euxoKU+uIB7j9xhTu4aaVCui6H5HxuUcb5SqJDEiyjQYPeJCBltpZTL08RQujIwA8jHgBsnvGrUPfZXmGc6tHfkUrCb+xvIyCMFf02su3t/RRjI0FrbwcJ/TRpEa7WlfN3hYO533K2BYOXcOD9nk24=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Se9T+pnw; arc=fail smtp.client-ip=40.107.236.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Se9T+pnw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c6MFJIaea8ZzqHuMXYQbgg/5zcFDmjbdP8eZ2A/tXuUBx+XQ4AD+TRDzW7f74htKuXjHqsKlgUyhhd3l5Z9c+JBy6Qy6N3Oaq1NjPrkE8kH4RjH8YpVqxGYvANYVEZzeYYqtePqx9Y5okAEufPB0ME0hPhyki8dEV3DuD40eClY/Bff9TOLH8FwmpJSU1tR/GI/KYXEk/Zb7eiXEgxdgAZ/vhWV6o47LMWPnj1wdRCCZ4YotLmRIVrqaDqZZbmIq/0yOqmMBn3bVnX/j5k02wqCoeyjyJRPo8U/YCBOxHpMkPWtmxJLKXLmOdavyCl/OjVErDiaypkxYMelccUHGJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uY21R3qbksO092aJw48ZTZceQAevZjZZySmDqKzYxyQ=;
 b=OS9jw5xN9HYN9mSxPZbqoIJdcjyXg0INgLTHa3bU58AvEpgbHIbjYtR3hP1F8t0FzAaC1ewx/YFZdek4mMGxUDamoSlyDfwBO8sUuYgxREbRGsXHWxblTDh/ZsrrHpwNy340eEISByTX20rPCvgl4aYhLhFkQhmjm2sLr+cf9OLtnXkEEUJN7gAaPLgzIgyBCLMCcFJEDtB9Pdm4VLnHCQJzhNWRk8Nw97FT9txo83hG8XlrJe/udFnIpZ5z5QgLWy5WLFNLJtav37S2YNx+BYmzhVX5GL5T7wS5ysr+L9ZRbgOxl+aFyN7lg9xbKrCDO6GxqmSJVsuOTTJ18E2N9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uY21R3qbksO092aJw48ZTZceQAevZjZZySmDqKzYxyQ=;
 b=Se9T+pnwxywhX8HqruGvWdCmwIQ2YgHpE2lX0F5tja7wOoqw1Wche61Rtwd2JgTEZCAp4zpPzEzM/rBz87kI4qw3aa3RustpOuJG8P5AbQZYgJHqk/LbSnyJN9r0+us/+0PKFe6HZkbK6xMWu1ZVq1Rtqyql4odVzLo3Q9XmTlalc4ucsh9/bzprIn5nFnDiC/ADk7kyPV8V+WrT/bwxSGzLbFpXa/BvG802bL/g+a2mKS0CT7wSP6jMyhb6/iRRWHcq0lh7k5wrgHFLWrXGFrseIUCvwUKy3WRDT6DTD6vjso+D/xoCATXAx0VcMfz8ZZISS5pzMnMyVErBb/TgVA==
Received: from SJ0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:a03:3a1::11)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Fri, 28 Feb
 2025 01:31:41 +0000
Received: from SJ1PEPF00001CEB.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::19) by SJ0PR03CA0366.outlook.office365.com
 (2603:10b6:a03:3a1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.23 via Frontend Transport; Fri,
 28 Feb 2025 01:31:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CEB.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Fri, 28 Feb 2025 01:31:41 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 17:31:23 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 27 Feb
 2025 17:31:23 -0800
Received: from Asurada-Nvidia.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 17:31:22 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: <jgg@nvidia.com>, <kevin.tian@intel.com>, <robin.murphy@arm.com>,
	<joro@8bytes.org>, <will@kernel.org>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 1/4] iommu: Add private_data_owner to iommu_domain
Date: Thu, 27 Feb 2025 17:31:15 -0800
Message-ID: <45c03a1bc86528c9194589cc3a5afe3eb2a15c9e.1740705776.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1740705776.git.nicolinc@nvidia.com>
References: <cover.1740705776.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEB:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: 43acd05d-8768-4fed-fe73-08dd5797a719
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Q4QCmVhdfHj1h65gSHeK51+GHJWtsbPGrKflafMFUrOrptxUNVkPnwLtVHt4?=
 =?us-ascii?Q?/EtN6tFiH9UMx2/k9C4Fl3w5Sn/b1fzhE7asEN/3N3a59hViPpTIjpavpH7i?=
 =?us-ascii?Q?F8N4/G7EHwmYVP4gK7e9OiIUBzilzHgbj+wk/kVdceioPxoIbfcqUeVCjEC5?=
 =?us-ascii?Q?4uL+ur52BaKQ14nBp4fAQaxm+sFp/c54kA1qfvv+WRH/vew9oEqYTIsYPZ5O?=
 =?us-ascii?Q?n2v0/PFKvNYYzmulXROyOn8HTRRCdX2hWCf+TgXhccA6UXdCZkG7HUe9C0AF?=
 =?us-ascii?Q?m8v5JREJqUnUdHr1/PpacEjQ0iwnHDVRE/7BpV7Yz5Ar1vuSHrVkxS5ymC9k?=
 =?us-ascii?Q?uiM78lJLcVH1Qc4avWBIoBk7EkJGPaP2vZFsmCHsiLGhvNtEjoNnSO0LRZzB?=
 =?us-ascii?Q?BaskCKZIa32Bsi4k8jvEmRAcTpzfs5G+a90kvSMCT2vIxZuEt71kZJWp3HGV?=
 =?us-ascii?Q?pAE9uf/EL1+lpsMWd0DcdQyyifKPzLj/yK0DWExqsXr31xbCDFuvu5l7sBjS?=
 =?us-ascii?Q?oHp400x+k6nzCJlkuiMMUyRXqXZ4gOe09a3Q2+MCc4Gf53BHyPKqOQCQ8Tre?=
 =?us-ascii?Q?0G2JmZgbeRiTIjFPK77cHg91TxZLX/waVaNhkm/tq330cakAtoX9Ct12rThp?=
 =?us-ascii?Q?Br/ZzbCMj6nNr1iZ7HPFDpeNhM5YT1cjCAwxlqk4Npsccl1OmsHZMSFcZZ0j?=
 =?us-ascii?Q?eoKMh9TS6SoI3bP2D0bD9kllL1R8r+LmTR5EOK0VkraAimqs6XCPnI4X3oLz?=
 =?us-ascii?Q?M2NxrtXqbA39LZxTRgmxurPQi0tQcYaIHJj7P/Ygq4BOkep0bBI+QUmYkGcj?=
 =?us-ascii?Q?o58AS2kH35I0J34KziPLx4xKXi9rAq3mjRzohW60tde40OPEFfd7X/TbO9Bt?=
 =?us-ascii?Q?zzBC2tKWEIj+l2SAkisMSPJJ3lFZBqTBQ8N8F5v/e1CptziaRNRmoyWvirHf?=
 =?us-ascii?Q?uFMyxjivZcgVxnkMb6ozDGO8v0mCpp2SHg3gEF3MDMtlpcSV0GG8svulXfKk?=
 =?us-ascii?Q?KL9iNMwaoi5h0p9vBGjPxrtM3MyZ7EXUoYJDZ77JwOtFn2VRZzXPhiREfRyC?=
 =?us-ascii?Q?B7w7Zm+9KjrMYhgh32wVAZa1lrhB7iTNMdKmX4EZ0kJeCClvFAc5KGYQIBRP?=
 =?us-ascii?Q?p6tufOvmS3jRnVW2gtgNLhLu5h/hJ00RbqX/zMt+XqahUQ6L+6WLdn/C0akK?=
 =?us-ascii?Q?/lK4lDSXw3MG7vCE268Cpn0ZirgWzHl5gadAIgQ//alnL/u0q/iKUEXHwfDF?=
 =?us-ascii?Q?kaqJymzRv+JMucPkBU0kYEyEuApCNotoq/Lq03/1VIelq62SZItic1Avy6SU?=
 =?us-ascii?Q?5IXbSZA1LIOq7PX6X/mzSqEC9MQBuSkG3wEVoTBAteg7v5tVkmmdOXngb6de?=
 =?us-ascii?Q?fy+Lja4rQDbvhyJMyd/JKw7/0nmhFJq+gp0JcMeITR01C/fA8tIwbCTcBxVM?=
 =?us-ascii?Q?AbGBb+c8BS8W/bpcOyj9HzyKEttlcd6hOCiRD/5zFpfVvTdrwsEpEt5WIoe4?=
 =?us-ascii?Q?EKcZRLPGwmKD24I=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2025 01:31:41.0405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43acd05d-8768-4fed-fe73-08dd5797a719
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

Steal two bits from the 32-bit "type" in struct iommu_domain to store a
new tag for private data owned by either dma-iommu or iommufd.

Set the domain->private_data_owner in dma-iommu and iommufd. These will
be used to replace the sw_msi function pointer.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                | 7 ++++++-
 drivers/iommu/dma-iommu.c            | 2 ++
 drivers/iommu/iommufd/hw_pagetable.c | 3 +++
 3 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index e93d2e918599..4f2774c08262 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -209,8 +209,13 @@ struct iommu_domain_geometry {
 #define IOMMU_DOMAIN_PLATFORM	(__IOMMU_DOMAIN_PLATFORM)
 #define IOMMU_DOMAIN_NESTED	(__IOMMU_DOMAIN_NESTED)
 
+#define IOMMU_DOMAIN_DATA_OWNER_NONE (0U)
+#define IOMMU_DOMAIN_DATA_OWNER_DMA (1U)
+#define IOMMU_DOMAIN_DATA_OWNER_IOMMUFD (2U)
+
 struct iommu_domain {
-	unsigned type;
+	u32 type : 30;
+	u32 private_data_owner : 2;
 	const struct iommu_domain_ops *ops;
 	const struct iommu_dirty_ops *dirty_ops;
 	const struct iommu_ops *owner; /* Whose domain_alloc we came from */
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 94263ed2c564..78915d74e8fa 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -403,6 +403,7 @@ int iommu_get_dma_cookie(struct iommu_domain *domain)
 
 	mutex_init(&domain->iova_cookie->mutex);
 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
+	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
 	return 0;
 }
 
@@ -435,6 +436,7 @@ int iommu_get_msi_cookie(struct iommu_domain *domain, dma_addr_t base)
 	cookie->msi_iova = base;
 	domain->iova_cookie = cookie;
 	iommu_domain_set_sw_msi(domain, iommu_dma_sw_msi);
+	domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_DMA;
 	return 0;
 }
 EXPORT_SYMBOL(iommu_get_msi_cookie);
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 7de6e914232e..5640444de475 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -157,6 +157,7 @@ iommufd_hwpt_paging_alloc(struct iommufd_ctx *ictx, struct iommufd_ioas *ioas,
 		}
 	}
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
+	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	/*
 	 * Set the coherency mode before we do iopt_table_add_domain() as some
@@ -253,6 +254,7 @@ iommufd_hwpt_nested_alloc(struct iommufd_ctx *ictx,
 	}
 	hwpt->domain->owner = ops;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
+	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
@@ -310,6 +312,7 @@ iommufd_viommu_alloc_hwpt_nested(struct iommufd_viommu *viommu, u32 flags,
 	}
 	hwpt->domain->owner = viommu->iommu_dev->ops;
 	iommu_domain_set_sw_msi(hwpt->domain, iommufd_sw_msi);
+	hwpt->domain->private_data_owner = IOMMU_DOMAIN_DATA_OWNER_IOMMUFD;
 
 	if (WARN_ON_ONCE(hwpt->domain->type != IOMMU_DOMAIN_NESTED)) {
 		rc = -EINVAL;
-- 
2.43.0

