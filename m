Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011061.outbound.protection.outlook.com [40.107.208.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9082D47DD76
	for <iommu@lists.linux.dev>; Tue,  3 Mar 2026 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772550294; cv=fail; b=PTQksKHzCwEvkPiEgrFUAQOlCkDEFQ3wTgZL11q1DdInVtoi7T2nxwu7dQThb1iGPcuZDxguV60ICe0pd0ZFEkpxR4lM64fTMmmgotUYxooStHBW98H/x9G3+HVOY9FsZEsXIFz1B1e5ssbK7FULay5debogYBX4zoL4yx3vfQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772550294; c=relaxed/simple;
	bh=0JZAnHgRKHIwx5Tj74wt32pD4VM52h1SSrBYMMsrWI0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i8VYTMKlWaBkGSaFzJkUEZrsuUS6pNEDsZuYtA+eN3RPQfOvhwTplAo5uTQJE2Bn41ofvthtBUjJhBi5Nv8LNToVjizUOd1KPI37Lj+uLQTjAWTLH8R2z2pKJzqlsGOm9U9Dcyxp3vW82+3JtwyawaRF+K+2ra1eMLhYfFqei/M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=H78ikMTI; arc=fail smtp.client-ip=40.107.208.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="H78ikMTI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lPYcYfdGbhOCUlqlXkf1sqz6mwc5vSqugykv1lcCM3uYrY7FDwA1kkbyKcUJTaNZJ6RDIJ1zcZUFq5kzU6UOw6+ZUEtfitwMNHv7onPs0hK9fRChRt2OMVT+qf7p7k6IQ26T7R6pCWhXa7ETb9Pf6osEiutu7gaRlnP4YIEMvKUvZCuiLWJBOTEpN28UAIK5rB30V+GP6k8G6FC9if5AreKi4/RepqxM2Ck93i/TlrSWAdA+9hibdn7EZiC61mlR2JsxjdQLkJshVAKdk9wvVYbhgVGInVi+46Jdq5nnb+EeUbR4ZUE6OepAMsyysWjwxlwQY0KQhNUjFltqKLkc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WawexHCp6M4IVssFew2mOmlhQljst41kVLreL4jnZF0=;
 b=v32KD0n3KFTf2TOYtGSswqs8JTO3QW5iDSD9cBisvddvymRlCZ0IdCUOug2VxVCDIg1kaq3mbtnLbey11dhRPd8Ayukdc0FrC6nNc9bSwqoyvQopvI4hBGPCaLyx5CyAJmOPyTbWU/Bhd5iqHzRnLTn5tvigQ5Ru0wkCFzZw3M35VKmfwSWiBEAQOiIDGWy3DWw4HuNpftZ04rLsChJfhL9+S34W89CSTcjAdoJr8M+uG7+TFzaSiHncdCPJ2GoPCmoD/WZAos8/+bNvmdhSdtYxEojY1r/Pg9HJdmo1w2A21UF6nHmyChU4F5LBp8M7LApkmTk3Y+MWCWAR39Z1rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WawexHCp6M4IVssFew2mOmlhQljst41kVLreL4jnZF0=;
 b=H78ikMTItp9e1bGdAc+uEEpAn6JXUzJRtd7hivmcJbhZXtBQXNmX8OuiicnVU7467x+OiHLi0fDuhFret1OdbbEWQ0znz8DMwUaW2+KtLoAosO41kz7ra7A1KdmSwBUCOE5GkvBTR69Q8ytA3ZwSNedGbaeANk1DKvAbGoemow1ur8oa1ovxNZ8ihasYnZcHg67HE8HvdDH4jW7Trr90F+7Q0rUbzfkLR3BWH03FyQURrEKAsv6hujJZ0qd5eZwAM91ScQeYoIxZbAFrZCVrn1NG9ed3ivGiD6UbQmX/t19BbGMkAajlxFJlBqIm0c7vrsnV63bGwoqK8lY0uBCtVQ==
Received: from BYAPR05CA0021.namprd05.prod.outlook.com (2603:10b6:a03:c0::34)
 by LV2PR12MB5893.namprd12.prod.outlook.com (2603:10b6:408:175::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.19; Tue, 3 Mar
 2026 15:04:44 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:a03:c0:cafe::be) by BYAPR05CA0021.outlook.office365.com
 (2603:10b6:a03:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.18 via Frontend Transport; Tue,
 3 Mar 2026 15:04:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Tue, 3 Mar 2026 15:04:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:20 -0800
Received: from NV-2Y5XW94.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Mar
 2026 07:04:17 -0800
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<nicolinc@nvidia.com>, <nathanc@nvidia.com>, <mochs@nvidia.com>,
	<kjaju@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH 1/2] iommu: Add device ATS not supported capability
Date: Tue, 3 Mar 2026 15:03:47 +0000
Message-ID: <20260303150348.233997-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260303150348.233997-1-skolothumtho@nvidia.com>
References: <20260303150348.233997-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|LV2PR12MB5893:EE_
X-MS-Office365-Filtering-Correlation-Id: cef46c12-bbca-4d7f-7ca4-08de793633e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	dmUbNYpL9dFagv4Txm+u8IrquM+ojueGqismJrrpLiM8af78crzeQW6X5CrdeoTpN0MTsekU31U86APHgRNgrAO06l5DxfMY9VNBDIpKWwet7x7iQdCgIO5CVngrH5CEsznYm3HbhAA65VR9KAQvcK3hDKZYYrP8u6N1BZabfTA6vorYqLcWX5IunpWJ8mdwRj0DMKHchesdbyvmk1V9wpfwrbcc9wzK18a0iFiUduFj4s3BJsGg+OaiRkQj/06fb+jbzohXZmgvLBk3eUO7+FxKEUEdri2KjMZBIxCxl2zkIOuuKjNXOjQI4q6LxHKPsfVN1g86wn3y6pEpxOiCxJmyVS8DOiIjTyjqp8UpM8IYc7uryM1PKhpqjJbvNASzb6jsahq/F5qkGVm1MysLYJ/80zrIk/074vR8EWg/y3vWUlkIwxh4kyh693J/Gogjv6ZMe/MSWjMSo+lBMs/I7oHEcP2kCU8OS7HLoNfQCF+C7gSv4isG93HQiGVk2X7oV0owrLNAMNdhPh+x2FaEMXXj9ynufQjGCJVHOsLLxVFkboylcbAKtnZYNAt+afaf2W+U5lJkSCR+5b3X1ZAd3PkXaemUByVBCVziyrxk8yHNrqIeW208Fd4NqTsexHTrU4ChTVQNKPnp5RV2CzVNMNiGwQ8K1kZC2rZGAMSclXd/umoVjdLJl4BnwDci8AvFYzQipc6TSKf/dgWVhAU3vbbd67+uo6TiauC9rB6XxYyWBrLyiW3UHDShcivaE/G5fsGGu76pg5UMTrPdxfpFsOGGXRoq0qHD/p9dk7qdqhQfUC0b9fekHREcJItrgx9ohtQRoD10ezo2tx+f1QyHow==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WCIGUxV8GYjpvLE8UjuSeuoJPHE9sv3sOSLD+DgpR1gfNCNGtDtVcoJEbXms67CcajXQOZwKRame5EMO7iF4/QLUBuSIHhSwXmmQltTYmC73Z5KQSAD+gWZdyWTMCLQYyPmcERdGux6UxVB9cBmfSKP8B7y6YbHLComI2HS8g4WSY0BZaIJVKe3IKYhqsnnfdP8KOx3C4vXeJtVvVEenJQyBcdti0kY8ZR/xPJPhwi50w6OEG7Ds/Dy8puz5fpdwo6EUoGp1/jqOxJmM4IDc1wZrk/KQlGWXriZ1oI/EhtVnXT5n1A6Hpklc7z29/XEXk6X+vCvOr6uHZ4Gnevb4I/DLnWzY2OT8tz16/hfwc6BLpp4TPcFz+e+z2VamqJkBIGZT6GfPpdI/277p/a8gqYMZCeoo2Yn49HY12tp1gkYQNF2los78Hu50fB0ScKFf
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 15:04:43.8092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cef46c12-bbca-4d7f-7ca4-08de793633e7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5893

PCIe ATS may be disabled by platform firmware, root complex limitations,
or kernel policy even when a device advertises the ATS capability in its
PCI configuration space.

Add a new IOMMU_CAP_PCI_ATS_NOT_SUPPORTED capability to allow IOMMU
drivers to report the effective ATS decision for a device.

When this capability is returned true for a device, ATS is not
supported and not used for that device, regardless of the presence
of the PCI ATS capability.

A subsequent patch will extend iommufd to expose the effective ATS
status to userspace.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/iommu.h                       | 2 ++
 drivers/iommu/amd/iommu.c                   | 6 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 drivers/iommu/intel/iommu.c                 | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48c762e..f40ecdc5d761 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -271,6 +271,8 @@ enum iommu_cap {
 	 */
 	IOMMU_CAP_DEFERRED_FLUSH,
 	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
+	/* ATS is not supported and not used on this device */
+	IOMMU_CAP_PCI_ATS_NOT_SUPPORTED,
 };
 
 /* These are the possible reserved region types */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..aa4399b6b6db 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2985,6 +2985,12 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 		return amd_iommu_hd_support(iommu);
 	}
+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED: {
+		struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+		return !(amd_iommu_iotlb_sup &&
+			 (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP));
+	}
 	default:
 		break;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..c20d2454ca14 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -107,6 +107,7 @@ static const char * const event_class_str[] = {
 };
 
 static int arm_smmu_alloc_cd_tables(struct arm_smmu_master *master);
+static bool arm_smmu_ats_supported(struct arm_smmu_master *master);
 
 static void parse_driver_options(struct arm_smmu_device *smmu)
 {
@@ -2494,6 +2495,8 @@ static bool arm_smmu_capable(struct device *dev, enum iommu_cap cap)
 		return true;
 	case IOMMU_CAP_DIRTY_TRACKING:
 		return arm_smmu_dbm_capable(master->smmu);
+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED:
+		return !arm_smmu_ats_supported(master);
 	default:
 		return false;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..0be69695e88a 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3220,6 +3220,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return ecap_sc_support(info->iommu->ecap);
 	case IOMMU_CAP_DIRTY_TRACKING:
 		return ssads_supported(info->iommu);
+	case IOMMU_CAP_PCI_ATS_NOT_SUPPORTED:
+		return !info->ats_supported;
 	default:
 		return false;
 	}
-- 
2.43.0

