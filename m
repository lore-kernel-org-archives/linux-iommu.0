Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C10D4C75
	for <iommu@lists.linux.dev>; Mon, 21 Aug 2023 10:48:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f8r6WoO5eIEqvDQM7ffZTfjd9L9RE+mH31ftR3zVlYs09pjWPoVQQ+6pxkgI81pFupMBijOd49sCKbsezsF9wmlxJHHXXoKHKXUfyIOaBxRsUEu75MPrnoJ2qoiZ/461Mo29FqFvcFITxnxtcMCgGSIkr+PSEY+NeF4v1L0qhvB0jecgs4bhoK+l4OfeXQIKWa2q0w6hr60AYD5vafNk96kaWyPD7wNgWF+S6zEh3DEjiQjonuNKm2Vw99MfDCxz5YuA+oIusBQKUKvss+p4H3v4xFE8Oo/mq8aXxOe6SGF6RxIEolDeG4EbvSPUATuWi79T6eDbosK/PFqvbTBVug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pElkGujnLz3J8sXMu/rmx7ry59DpByHUKiGjqX/8VJ0=;
 b=lvBq53I4JqTzUk8wcgQpao08ZCa2y/Nbm10WWgOvjWT7Zp8WPJ4z+z5G1cswZZNidjo4eaDMT15zbT4NOv8UH2W9BOJvpxXPkU/M5p84flyYaih1xgSE6eCjPOEghMN/bj/rDeD5ME7tonJqEFRhwb3rZOU7dc6CWpqT3SI7GGcPm+mlRC8vtkqrk1kA3OZsk3w7OHtev+t8DTrv9vAEMHV+ry1jI2tLQVCK3iO2vaKnQEzGZWMjWSqIOhDp8s7/GRUCrnpLdosVoc9kj2xJN9YFAahQHHxzHrkRBuGQa1+ulu5t+9PqSa7GLvptUsbCRdDHmz1QZVvL0CmfdL3liw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pElkGujnLz3J8sXMu/rmx7ry59DpByHUKiGjqX/8VJ0=;
 b=D8uEY0tDnVQHhUYZ1DneP7On12GD16u4KySpc2TpKt/GpBoVULymTUHmx+GM/O9QaZA0KoGBChbprB2v5aF4pyXA+bbwrfB/x6HHB9ii48STtoUGfbFxZu9YCQe0RebhAFiCh3+BI79bNzvEXz4Gp5H6zQKONDw0NUksxxMq6Bw=
Received: from SA1PR04CA0022.namprd04.prod.outlook.com (2603:10b6:806:2ce::17)
 by CY5PR12MB6057.namprd12.prod.outlook.com (2603:10b6:930:2e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 10:48:57 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:2ce:cafe::d1) by SA1PR04CA0022.outlook.office365.com
 (2603:10b6:806:2ce::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20 via Frontend
 Transport; Mon, 21 Aug 2023 10:48:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Mon, 21 Aug 2023 10:48:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 21 Aug
 2023 05:48:27 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 14/14] iommu/amd: Initialize iommu_device->max_pasids
Date: Mon, 21 Aug 2023 10:42:27 +0000
Message-ID: <20230821104227.706997-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230821104227.706997-1-vasant.hegde@amd.com>
References: <20230821104227.706997-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CY5PR12MB6057:EE_
X-MS-Office365-Filtering-Correlation-Id: cea0abf3-f7b2-4445-5f02-08dba234386a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	fm2UVmw8TrkphDKu+kPboUkQVPhsGjrUI/Ag5tflY64EF9sLhZaudmE51Q4O8np+mvQjrfQ+zD07Cf1pN96T7fLSKN27VwDyAUlwfuqe60mz0nBCb31dV0w8KgzJKiCxiu/900/lqHctSTC3QFdzloPlHoudlY1O3D4zv2ouS9To3Etrw7i4tdOBUgz6P8iJcuLXGEuxEcdYWW3IRP5NdNiOd6iHJ4NnVVGlZXfERoKl/xD3XmWjkM2U3MmZ/iVsE+gN1+LjjJvf7B6UCiSJTczI7XqJLF8Ec5Klsw8hJjKNeV7tnAffGRmwNU/JKnnVbfCpUE3yO3LMYjlaCbJiBFS0gkm75ZzBIksMpBxK3lfbxSOs6zu3aPcBhjeGA+7cRbE/jt9zOIwPSOgN4rpDR7rYXbYbGJs/w/VgbSU48pC9a4L9JzLP5bDFfYE1ARyy94L4WfWTdsDDNyj8VtnTNGALRzjCrnAyUJeN6ZOW+4Ps9bqbcEedFx0dvldDqZKRGKjGq7T+Oae0ZoBXNJNu5szpAfEQ1INt0lYRN5rTLCp7twECdnGhR113iIgdPBsEOM81GHeCM8rgpmrzAPIRXKeERUY5stF4RE+ke9UjUoU2tvbCerqr6z/GnAryMj/ZOqd5NK2ik6894S+UjGXmwurP2aBIkTeqHZgZkrJhnYjfpEiVxbvQ82Qx3mBI1bCNJ2Qi2lUS4EMVP5ny57QXVAVMyhtzCbSHf8avLHWRrajWll7dq8dJtXjC+i0KikStwFCb3gmDVEVDMO/9MqkGNA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(39860400002)(396003)(82310400011)(451199024)(186009)(1800799009)(36840700001)(40470700004)(46966006)(2906002)(83380400001)(7696005)(40480700001)(5660300002)(44832011)(336012)(426003)(16526019)(26005)(86362001)(36860700001)(47076005)(8676002)(2616005)(8936002)(4326008)(70206006)(316002)(54906003)(70586007)(110136005)(478600001)(82740400003)(356005)(81166007)(40460700003)(41300700001)(36756003)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 10:48:57.0926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cea0abf3-f7b2-4445-5f02-08dba234386a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6057

Commit 1adf3cc20d69 ("iommu: Add max_pasids field in struct iommu_device")
introduced a variable struct iommu_device.max_pasids to track max
PASIDS supported by each IOMMU.

Let us initialize this field for AMD IOMMU. IOMMU core will use this value
to set max PASIDs per device (see __iommu_probe_device()).

Also remove unused global 'amd_iommu_max_pasid' variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 3 ---
 drivers/iommu/amd/init.c            | 9 ++-------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c6d47cb7a0ee..5be563d55ad6 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -886,9 +886,6 @@ extern unsigned amd_iommu_aperture_order;
 /* allocation bitmap for domain ids */
 extern unsigned long *amd_iommu_pd_alloc_bitmap;
 
-/* Smallest max PASID supported by any IOMMU in the system */
-extern u32 amd_iommu_max_pasid;
-
 extern bool amd_iommu_force_isolation;
 
 /* Max levels of glxval supported */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 06b319006ce2..463e68a88b17 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -185,8 +185,6 @@ static int amd_iommus_present;
 bool amd_iommu_np_cache __read_mostly;
 bool amd_iommu_iotlb_sup __read_mostly = true;
 
-u32 amd_iommu_max_pasid __read_mostly = ~0;
-
 static bool amd_iommu_pc_present __read_mostly;
 bool amdr_ivrs_remap_support __read_mostly;
 
@@ -2080,16 +2078,13 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 
 	if (check_feature(FEATURE_GT)) {
 		int glxval;
-		u32 max_pasid;
 		u64 pasmax;
 
 		pasmax = amd_iommu_efr & FEATURE_PASID_MASK;
 		pasmax >>= FEATURE_PASID_SHIFT;
-		max_pasid  = (1 << (pasmax + 1)) - 1;
-
-		amd_iommu_max_pasid = min(amd_iommu_max_pasid, max_pasid);
+		iommu->iommu.max_pasids = (1 << (pasmax + 1)) - 1;
 
-		BUG_ON(amd_iommu_max_pasid & ~PASID_MASK);
+		BUG_ON(iommu->iommu.max_pasids & ~PASID_MASK);
 
 		glxval   = amd_iommu_efr & FEATURE_GLXVAL_MASK;
 		glxval >>= FEATURE_GLXVAL_SHIFT;
-- 
2.31.1

