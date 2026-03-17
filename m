Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012024.outbound.protection.outlook.com [52.101.53.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E4F3AB28C
	for <iommu@lists.linux.dev>; Tue, 17 Mar 2026 11:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773746253; cv=fail; b=d/fEOEBn+4hjqlXvLX8xMrPq3qqvJnURv7gNjTXLPKnMo76qRlGSaCuXRhaxCzNDN8ZkJVzStdhxUGDzlKPC47d9GImZf/vr6heMrrr5nwo+X7WYur1+HiUAYoAWCGtoZxBlhTQwb3MfqZvkVDd+FaCfPRClD/5QqE4/DSaJks0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773746253; c=relaxed/simple;
	bh=TJHTXYiL5lnGbNOxqTrE+nTkEPAfNBn4YXrZbgUvDCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TdOfRr2uvZY2fuZnviaEhtlpTx1mWSUwCNMUm9QSAm0akWF+jIlrGlwGWfmLP1KLaZAU2pnaUW0fkYFenpbVqb82v1NieDaZvmA2w+ZyUpsGwMoyC1qYl1idt8QKr/JTnOE7gz2xbgifNayG0K/WkMRLy8NMl/gwpD2qyan+gRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pFinMaeo; arc=fail smtp.client-ip=52.101.53.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pFinMaeo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f5IiVh0pKMuuYcTflTituaOGYejLrC3+GFfiYGksadzkYL+7cjELYVUj4tHUpfGkLzULcm03rM+GFnjNUyhhCT9WaUxID7SaaTdbt91w8As1kDYgH/qoEPxKiXfqy1It0P3gl1GU81Ig7MOEX5/C8HOT7hQrbKzm0ONX79oRjhTXXHVEBEoj31RYPRwFlUPXPlsX/Mj436E8cd9x4YAlcWNEmkvMQMAS8hNbQVHzYVY+McYhbkzAb0zDcfshIvTOkFFQlWCxYqf2K9ulh0Sdfb1RPjvvUk3SbsvXHRn3kMr8a2oXaOWi9u8D7uCs5356AxuqmD80A3JMuP07CVgdUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gX/TDF4fOwt5u6oOYnQsium0XBgEzPWscW7cHPdChRw=;
 b=ITyOvBU5Lm+zy6PaF4+txv01qDG82drd4tkEIVmS3hO6E/zzOO8FFVx4P1x/aa6YUoKM7mHoh3OZo5zhhUgfxzfdp4aF6nfu2OtH+O+JHHwig3JaLiiewGV5WRs5xUPMjtWmOxe3wLfaq2Txw8pO08W0+084vPnjtoATGhruu5+nVnbOMAXTVEiNd7Qglvu7hOAvjS/kdTR5NPjtQBgncRPEmOghvvGGAuvQBcMNrhyFP33jgt0CQXQ6zngMGgGdw7gyE1RrzngZKrur+ueMLP7QUsADftzy4frVext4U0xaR0y/oH0WEufX/sy2rbX0H/GRA4tr7DshnfzEqeY+zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gX/TDF4fOwt5u6oOYnQsium0XBgEzPWscW7cHPdChRw=;
 b=pFinMaeocHDOLxQQNxucTY659xRLAP7EVUmxNWu2b/JjPfv3R1bvkzZktILiij1ZJYiFsAelE/1poQv4e+cJQwGC46LTv9kpzRIDZMnKuRoQlLKHguuhO6j13RWF3yFUQaJ1CsztfTrfc4ewLA20df9bwKaaFhslBuFNRZsyeZUBVD3FqlOkMeD4Lrt8PbO3EPObFB/UH/uwvax5s8TPK1jochjHwM+JvFgJ46DTEbKCOTUzcp7qc37HWvzx6ce4ajCiRoARepDPT3bQ0gRy4BwQJoqouZPNbSGwf8/xt48HQLmoj1eMjie9OfRISSpptfcCiAUcYP8OicXRc61szg==
Received: from MN2PR05CA0060.namprd05.prod.outlook.com (2603:10b6:208:236::29)
 by BL3PR12MB6404.namprd12.prod.outlook.com (2603:10b6:208:3b4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.13; Tue, 17 Mar
 2026 11:17:22 +0000
Received: from BL6PEPF0001AB4C.namprd04.prod.outlook.com
 (2603:10b6:208:236:cafe::10) by MN2PR05CA0060.outlook.office365.com
 (2603:10b6:208:236::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 11:17:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4C.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 11:17:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:17:05 -0700
Received: from NV-2Y5XW94.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 17 Mar
 2026 04:16:59 -0700
From: Shameer Kolothum <skolothumtho@nvidia.com>
To: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
CC: <joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<baolu.lu@linux.intel.com>, <jgg@ziepe.ca>, <kevin.tian@intel.com>,
	<skhawaja@google.com>, <nicolinc@nvidia.com>, <nathanc@nvidia.com>,
	<mochs@nvidia.com>, <kjaju@nvidia.com>, <skolothumtho@nvidia.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v2 1/2] iommu: Add device ATS supported capability
Date: Tue, 17 Mar 2026 11:16:02 +0000
Message-ID: <20260317111603.101456-2-skolothumtho@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317111603.101456-1-skolothumtho@nvidia.com>
References: <20260317111603.101456-1-skolothumtho@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4C:EE_|BL3PR12MB6404:EE_
X-MS-Office365-Filtering-Correlation-Id: 08c78fbc-1950-4325-694a-08de8416c2ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	hPPAjZUxKVlEcXOATipEYEAC1SHDHW1CroLIo1uPG+zRG8LUuw1wKIyTTS4nmMJWj0qqo45mfaRlAFnG9s4pq/oVHqSS0LMyG2QZrRDkHXmzWj2dqpP2EWrA/0+0GX/xeXbk3uEpRwB9spRfVn/Scrbx2xZHGCIw0JcH5XnY2bsBX+l7jr0fPUKynKQUs1SrgXkUhRU1ML/rzGMPn8171Lf7mnmGu6W3eznO9XNILvUiIjnRlGoa/8cXuZWzruDcZHr2isXRC/Rc0oONDg8r3xfUcJYIj3inXM1PiyQYwvVY/3JOuYt1CuitEoUR+lsGC6ZLeXyC1qQvihnOIN43HHdf87ZAXI8jBSyrjcppbpwgRaVuX99mlpJt4sOC9JOq+2Yajmw1XntqGdFoP8wPzhbFDKaEaPDDbHU5yNxdhhPR8JuHuJ0oWlNBvBZjlK7xh1fLnuoamZ4CLSFUUCRPSKIAPTs9AlaQPhkK2WKNsRq0ZOJVdL7QWfA195G/ejiG9I1q/dBq/pWsL2rPjZyyht/WTQsXFUo/d9io3H54oxZx+I+RzUoNq8hAa3Qx7v+3OBJEZZN0242nA1amifHgbjyIeE+dK4CkGGBwxhQaYVEODYFDMxGhSHUsKsJ4xEq3Rk6C6Z6Z/5tZUnTwn4bt82QpGL8HOeHbRXPUBguFPFUczu98zdkMMyqMJb8UAnf/4iHIiTzb0qI+mhfkMLitlNGJCduGYAOAn4nM1UbsYSw4omaC+9pVmgFxF78JLBQldmCUtb9OCgHMzOJDW4DbpQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aBT9ZP2llKLD1ZLPgIYPF+DlDvkarpmVidTlasupAwF9q5XW075kQdepVhCI4ViojGp3h9UGHDawTWSW3jfPHByZtEdxtyPPRj1XOeSZZoLqSIw5hrPZlahZu9gLv2Jc9BaJrFj9g+MURwEzVqDwuANywNO0Zs1xlDBoYqKgmpTzkVLWkAxhHW+hOceoYGrhgVB65iRw1JmY9pHLTdylUpZr+p02Sjk7dcka6P6/Pf+Sk5qQrbkvixPufTZUoGmYZND9FRRtyhX+ohI20ZnfOjONlaOaD5kOI/5teX5Z8/lMkluVMLnQmFqM9RTliRg+YY8sRkTNmd4aX0j2Cwmh8b7OWRojLXPFWKfB59z8r6/1kUS/tZ4bzIF7nKFcolfD/fhm8T5eAhWEXaBaUnQgY4sGjq+y2/OO7uihkQIWjOEopHpV2XolKu6ywuNgTONu
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 11:17:22.5983
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08c78fbc-1950-4325-694a-08de8416c2ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6404

PCIe ATS may be disabled by platform firmware, root complex limitations,
or kernel policy even when a device advertises the ATS capability in its
PCI configuration space.

Add a new IOMMU_CAP_PCI_ATS_SUPPORTED capability to allow IOMMU drivers
to report the effective ATS decision for a device.

When this capability is true for a device, ATS may be enabled for that
device, but it does not imply that ATS is currently enabled.

A subsequent patch will extend iommufd to expose the effective ATS
status to userspace.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
---
 include/linux/iommu.h                       | 2 ++
 drivers/iommu/amd/iommu.c                   | 6 ++++++
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 3 +++
 drivers/iommu/intel/iommu.c                 | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 54b8b48c762e..33fa39e17f3c 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -271,6 +271,8 @@ enum iommu_cap {
 	 */
 	IOMMU_CAP_DEFERRED_FLUSH,
 	IOMMU_CAP_DIRTY_TRACKING,	/* IOMMU supports dirty tracking */
+	/* ATS is supported and may be enabled for this device */
+	IOMMU_CAP_PCI_ATS_SUPPORTED,
 };
 
 /* These are the possible reserved region types */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..f1814fee5182 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2985,6 +2985,12 @@ static bool amd_iommu_capable(struct device *dev, enum iommu_cap cap)
 
 		return amd_iommu_hd_support(iommu);
 	}
+	case IOMMU_CAP_PCI_ATS_SUPPORTED: {
+		struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+		return amd_iommu_iotlb_sup &&
+			 (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_ATS_SUP);
+	}
 	default:
 		break;
 	}
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 4d00d796f078..dec5cac98f7c 100644
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
+	case IOMMU_CAP_PCI_ATS_SUPPORTED:
+		return arm_smmu_ats_supported(master);
 	default:
 		return false;
 	}
diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
index ef7613b177b9..5dca8e525c73 100644
--- a/drivers/iommu/intel/iommu.c
+++ b/drivers/iommu/intel/iommu.c
@@ -3220,6 +3220,8 @@ static bool intel_iommu_capable(struct device *dev, enum iommu_cap cap)
 		return ecap_sc_support(info->iommu->ecap);
 	case IOMMU_CAP_DIRTY_TRACKING:
 		return ssads_supported(info->iommu);
+	case IOMMU_CAP_PCI_ATS_SUPPORTED:
+		return info->ats_supported;
 	default:
 		return false;
 	}
-- 
2.43.0

