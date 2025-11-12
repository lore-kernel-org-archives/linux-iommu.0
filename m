Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 571C0357A3B
	for <iommu@lists.linux.dev>; Wed, 12 Nov 2025 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762971969; cv=fail; b=CiISD50fsqB7DQFVDYNmKiQ3Mr9YuDPp26jQ8jaYb839xrh16TDt/o2yruOtpFQCRw1bwVdN+woDYpradssw//bCIC+tGNHeyjMhuIa4hizd84Pzp5Ic3PhzgN3OJV9NgvZ+4rkZ6J112C5zefzq27tJje39XV5pzArKhYLYWSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762971969; c=relaxed/simple;
	bh=PwipERzvypGFKK974dmFNGG04FJ50B9n/u9Kr2h55MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q78qLgP1e8nwt0u2nWxUaNM4lHEgd2VH9nkEkkuBScUuOGZJIJVRQ9ZeAu8YmmCLjQXMrfPqthNefUz43QEl+GfDNDGbGvfkZj0SZX/mKri5BxFPOOO968ls/AZO0W6t/gP0PLiK5KcDDjJBxLCVwJEqHJgM4mIuQBT0SazDYfo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sY/aIqtq; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sY/aIqtq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YEMqahslG6HhN4u0u3gJ2DsDq7mVb6c8ANNvSNeyY2EMmSmqGeJoN9/QqECanTkYzgrBDPx2P+n1+uK1B4E5KWz6H60GW6ENJg3f0BUc9d/DXbL/k3GPKMoN1srrd7/5DvjRFjyQLLlvaqRVerCvpsHmziefqqtllymWl8AHF1039JOoStZW3m4iAVWiTAgkX61g68fa59v/H+Qc9HXSa+zj4zMyjFXh10nVd0OhwmLA07FjbRBcX+rH16y68jcq9a9TG2SuG5sWd3FhUK5iBH4pdFuA78eaNmFKFsMiVmpcPd1YQpouT774WFVt90tSCLcAYtyirHWQV/2/+yyyPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+6vf/6vi7INSJxGt98mVgh+kcYeknuH5XHqzZZ5js4=;
 b=sfstIBbT53wS7AHsu2lBPeuURPP69W7c6vrvQR618uwKkAErIUlMMCVqPtOVD/TnmFB5psH+WyW1Y0TqIbnbE2khXs2XJGhFZNUhbw5xqQMvx79SJybUSIOUw56MClHKUi+uPztqEJy4cBNc3KnhiEYioa8DCh0/L00OobXeXA14FHsd8cKuWDZrSxF8qBbICW49ZIrTyIRaMCf4wJynWEJq0cLWL1qN4Zwtr/rE8QH4vXTQYrA61U1pxlCa/B8EcnfSlZspsVi6nfNmjtvjAToLgNBNbOhNIlGsi8HmbUkJI9oJEx6Jlp6g/4LUgN5SYSgn5x3aMaSBfVQ5N/cHvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+6vf/6vi7INSJxGt98mVgh+kcYeknuH5XHqzZZ5js4=;
 b=sY/aIqtqomKiHavrN5aGgYr4Cjaw8DqOWJKFEAjlCENDtXBIYHzzRK0cBIDxHsp9B5pWFOgBxS7eRIzReeYf/EG7PfqZKppRzKbSB4++XJHNz9auF7nuPU8oMzWuZosnZiHFKctwBB7WZGL9n8f/kzGxjTN0JuPzn8sIThjrIkM=
Received: from IA4P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::13)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 18:26:01 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:208:558:cafe::d8) by IA4P220CA0002.outlook.office365.com
 (2603:10b6:208:558::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Wed,
 12 Nov 2025 18:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 18:26:01 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 12 Nov
 2025 10:25:55 -0800
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
Subject: [PATCH v5 06/14] iommufd: Introduce data struct for AMD nested domain allocation
Date: Wed, 12 Nov 2025 18:24:58 +0000
Message-ID: <20251112182506.7165-7-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
References: <20251112182506.7165-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: d0c9f849-bc41-44e8-3b8a-08de2218ee9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|7416014|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TkG7jyVDDX8oCoj4i90r5XNM332AlM/I4Nd3sizQUHvNtTXGkt3qJNrzfg8Z?=
 =?us-ascii?Q?1Xwv38RxMpVWVDDQnhoTpD7HNeBCWcd4IC0ufqyJ3GK0sgsCMuyCqPrdIVLs?=
 =?us-ascii?Q?5nnC458ADJDma2/76Okwi5YOyYvSPuXNmgzoXVHHylhRkqy6L66sgfbneQA2?=
 =?us-ascii?Q?qqr4r43g4XpM0DWwOQaQm2CjD27K6g7aW6DwAA7w1OsoaPFDW/WqxeqgpTt+?=
 =?us-ascii?Q?HNMl5/7D/HFJRRcZpse31iGeE5DaogTwOh1YHyKWJB+qpPsA52ReR2BRZ8fD?=
 =?us-ascii?Q?HfxY8aTmfMaCUpemd9W2+2A0ymE2ddYFfGuLSt/FcOX5Wg9VZd2yw3Mivj74?=
 =?us-ascii?Q?z7RxuIJYbCuHCZEmr4TCWTBqSWXNeUumGUcjcSBKcSxsT5AcxFarRzvcc9oh?=
 =?us-ascii?Q?xuaHpSZ9tmgWQJFfb+QEUPMpiCEIszDEYrw1dB0F0p/DlZNkL88k1GXu6VF4?=
 =?us-ascii?Q?3sOSNGlO3RGkVRfN9bfA943QXNJN+lB4ro53mvKXfQavndA9y6h+B17JdQoT?=
 =?us-ascii?Q?ZcH9Za9SQYZn61+F9k2ZolHIVpLHZe2z3V5f0bVPiIwRgiSCky0lFkJQijTA?=
 =?us-ascii?Q?wVunSuJr7BmWXQYamWVGSFj/SvkVerb4UxaFziOmoRHs2ydAG2VhIjKD6eV8?=
 =?us-ascii?Q?KRhUhIAoJo6sWT35iP+jdTP1oDJJTZeTCt6tJmHIWi0GfI5KlRWM7IdLV3tN?=
 =?us-ascii?Q?1DLuKo/vCP0dppnk7+uGuGOVoPJXfPPqqJXHpb19Biw8ffCZGYbkQ9uWj07C?=
 =?us-ascii?Q?WmU2ofkOSO6enyLG2+N4gKExOsom/9NVtDpDFmfbM4lMDNYVHcueXlhbKk4g?=
 =?us-ascii?Q?XAgw1felrlZp+JzCtws6eAvFMikSsktrJbKGQPgOaopdQa2RUBzCe5Y65oNi?=
 =?us-ascii?Q?msn3xgJy7obNDHaE9nwO8TkADgfxWp0LXd0IEI+RQyPXbS1leuuR/SaABg5i?=
 =?us-ascii?Q?ve3tIeYS1yvKMd/vc8cv79YbCLAtaZW3KhxRSLg47AwEcTkYRE8IVrxGgch5?=
 =?us-ascii?Q?n/k+2ht9b9scexwXfxVzGYy63DVLhtKM4EvUlvlrtJFeTEui7j8rcf5nBc1B?=
 =?us-ascii?Q?stlPZfhy5dYvfDIeCDwq/sYzv7EQIsjgdXwjZ9vmieLuh2kzmDoYs+DXgyQz?=
 =?us-ascii?Q?NFdQyEmeMfof4wFpF3CM9hrtpYrMSJvh3gFdHkmbufvA/WctZEniUpUhE1Tr?=
 =?us-ascii?Q?Lqpk7zPgib2iyOSTROPHYufDVi55F2bJGx/DzPjJ7XR8DWwkUKsM0J1cG2LS?=
 =?us-ascii?Q?Vw3C6FIACUWFoWvp51n9AtH+yQ0KpaZMc/39fdgO2gfZPTDAXdK2RLVNN1WA?=
 =?us-ascii?Q?AkfMwEdlpUAGqN+wCHwsbXIZQMsDQ9hwl5TnIxC/0xK5GAUDhXnMrwrp0PmN?=
 =?us-ascii?Q?JGe3HW/6U5sNXlMIja2JYQTpETIU4J0Ob7zamReL/ZApKDuJXfTjqKwoynE/?=
 =?us-ascii?Q?b862kkxJppvKF/MMNQ5Wg1guRyXVuXRSXAkUvNSVczMHbGwGx0UwMFov8Tyf?=
 =?us-ascii?Q?cj5PEtfTB0+/ZJQekt773RmF8PUG9oJ1TdkVtGeFbBYzlv38AK2CHPwW/9pt?=
 =?us-ascii?Q?b7bgXWD2QZWsclhN2yU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(7416014)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 18:26:01.0651
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0c9f849-bc41-44e8-3b8a-08de2218ee9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498

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

