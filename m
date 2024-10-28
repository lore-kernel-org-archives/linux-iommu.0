Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241971D416E
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730115223; cv=fail; b=InEibkxutRFNDKn4bSDdCgRitMSoMf6BLzqxQMpP7q/txKq27DIz+lWkr9rW4Nz90VIaqCTllGdv/GOv94Gb2L2rWM6nq24KTkZDi2S7DxrMCt4n2RlJcTOuAyrv93gqilRrSVDV13//pguPYY1zbXXsHcns8MWBj3yIj7xfHP8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730115223; c=relaxed/simple;
	bh=wXchW5Z6iu4s+Ez6Xck0yoI1W1ub8PlrwJAU7fm0vY8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=e4K+bdbjHmQxW541CcIbF1goPZXcU1Zv9MSnct3RDNiPLsyjXtiZ8bLUgjhuU5KoaZAGh0DU0OMdGU3NhtBncz21zhE7WAXaEY2/d5X7O4xlBOxJ+tqrjbKul2jqTSFvaHahchzdwReYONaguAncrWuCTQKiYIjbjswMBpnoXOY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jvxL6oJY; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jvxL6oJY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NC7C2QXZeVux2dLtwJApgwAqw8UdWH+d11CVwRq8Ss3mA6uRt29Sbtjf8HiB1lUkhS1Zc5y5+u2Jd9TxPa1G5UWJSzWuVXZccmeglcYemyX7X/C22aRbWNa/8ny7KU0pSDSw7Oq1APoQOWSvlnZGxOJSae1+OVv4d28uUGwU/D/osmAl3Gymu/HupmrZu+yJmDYkSFswkb0bo9EC5kjqJUe1wXYYqnyPFgmKcP5x/yRSkNkKADllZKRLNdqq2NZ+Yhraru9Kk7Pn+uA1UhjBuyrfu2mJfRBFJVg+JvvqY9dA23XJSoHE9W6YXwM2AkS3yS8HOnkuYkB1doNJIYBLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pk/XRk55P6nmdNYUh1mZgdVbWkN9gJE9fVEHcwnVmuc=;
 b=oeUMmhiRdtOfxnaf3qKAYCNrR655TAbSwAgakF/rMULcPv5yeSoIN/DMQmX77ObWKx0/+QHMyN1pNEHsZKL3lhxEqBbnh/Co3kkS/qZ71jbSPKtBlk8g7Fc+mG3Mi36jTz17JNLrrtzPWciu15sYkCmBXGL7XIa/kyc0rrErEI0Rq2XyYQBPHNClEO74alL2ehH3g5w59+THotNRtBa6KB5RXM2FGSpB3+Dr4cGAfhKgXwaT7qYrgGA42PWqAnwFAmlXPOBMU86nqgQsNifUmSesdUEzNTAXUMNbU6ja4zx9d1fG93IFf3pXcoFUKbGhEu13auNqNz6AoQJF9TNBVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pk/XRk55P6nmdNYUh1mZgdVbWkN9gJE9fVEHcwnVmuc=;
 b=jvxL6oJY06PxeSGZOpNJhNT+jM7U6zdF0QQGvt1txaV0gqDYxBlm0MhlWwNQtayVyjWdopwLNSuhiRFCg7gssch2PCtyH9bOHdcGFYA4LLb9XrKfdFuGLZoXgc49kI/PepvhVfOOBxJNtfgUARh9FhCH3TwfXoG7LpFi9w3HvUo=
Received: from SA9PR13CA0015.namprd13.prod.outlook.com (2603:10b6:806:21::20)
 by IA0PR12MB8974.namprd12.prod.outlook.com (2603:10b6:208:488::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Mon, 28 Oct
 2024 11:33:37 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:21:cafe::a9) by SA9PR13CA0015.outlook.office365.com
 (2603:10b6:806:21::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.13 via Frontend
 Transport; Mon, 28 Oct 2024 11:33:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8093.14 via Frontend Transport; Mon, 28 Oct 2024 11:33:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 06:33:33 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, Vasant Hegde
	<vasant.hegde@amd.com>, Joerg Roedel <jroedel@suse.de>, Jason Gunthorpe
	<jgg@nvidia.com>
Subject: [PATCH v4 05/12] iommu/amd: Remove unused amd_iommus variable
Date: Mon, 28 Oct 2024 11:31:41 +0000
Message-ID: <20241028113148.5774-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028113148.5774-1-vasant.hegde@amd.com>
References: <20241028113148.5774-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|IA0PR12MB8974:EE_
X-MS-Office365-Filtering-Correlation-Id: 41ac65f1-f8e9-42e8-b7f6-08dcf7445cdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xjuYZNNGy/2E/YsgnrjaFvvP29n+m5fsW84nqJe+V7WE59x3CvSrgfQEiG6G?=
 =?us-ascii?Q?81PwaxtIji6MFFvLN0j03NLRrj2Wm7WvT9j4zAieYiezHblUAhQYUisGWYek?=
 =?us-ascii?Q?tFYiIPnGjepoQghS/kGdejuUzqBnapK0WR5SeRMc6OcA+ViwYlo6EwW06BFg?=
 =?us-ascii?Q?uuYRrSeJPfzDLfuH86tsBF5jsvEjmGTAFhjqFumntKDM3m3I8O9wfsrRXDsP?=
 =?us-ascii?Q?NFe8a2lSj6Fgn93EBzEAu1Hfz//AgcIY7pJ1QvkPQXnvCvb9eiiYC0qtxfVd?=
 =?us-ascii?Q?ftvsHsb6u+KXxwCv5lGFkYuTKtN24g0vAqZ01CyvcsduhOGAfzWktGvoXnJq?=
 =?us-ascii?Q?1+5RVuCu0MpmFQUx1spNfvR837Sm9uKDAPDPmEKjIxM5xVpwcO/Y12kHRRNF?=
 =?us-ascii?Q?PsuonunCek24GoDEmrlnPo9mKNaOmTwKPWCVjryLGvQfz8Tfde9tDyTxWM1N?=
 =?us-ascii?Q?Z2HQmFVBJDehoxwwisA0QcPfPVfxV7V7KadiVYkkd390HxAHwxhWhHyB08xF?=
 =?us-ascii?Q?r3Rtr0ZPeH9qzd8yz2HMLXWqMOObxl1hu2MY/5B2LJkMs57dnWK2mdKGecj6?=
 =?us-ascii?Q?GxghlLxuOTYFOWXQid9JcR84nv6iKLdaw44Hjne0EFsSzsa8k17DsyKfWjMV?=
 =?us-ascii?Q?hhXAk7lwGGa3bLxNfYkw44dCQszq5UDi194p1DaBxDLQjM3CHDvthzKHz2YA?=
 =?us-ascii?Q?e5hAZW9cw6Q4UUUg9/q/Wz00VbbYJX/rzOgemVTPLVOjoLdKdvO0mORpmFOW?=
 =?us-ascii?Q?c4obfS9sQPkVYHxhF6LAAZV+0ylyyUbIHutWmGBC0Hqgj9PvIvQUUi8hThHi?=
 =?us-ascii?Q?grFMIQQjmAnxH23hebgOK5ofJ1EvmNPo0ZACyHUCmPQvrsZbiBwX09ALZs7l?=
 =?us-ascii?Q?WCTCZ2EFgsUieuASwNTlt2j6B9Dp5gs4AaoFor1xzLXLbUlvCBTQ2yVjaUiB?=
 =?us-ascii?Q?NQPZosIcI6pZhRt+dsAI6YxFBTv70UHby9KJITfcFttZZUtH7b8k4vi2bI9i?=
 =?us-ascii?Q?K5m/BLQepJx7o+1tTtkK2or1iOzRa+mtnzBFvV4RBFyY4KkOPrgacAknzdaa?=
 =?us-ascii?Q?hUPbv1hKgxyz0PUm/aRYBtE9balkVdNg5mooMwdFS0Bw8IuYONSifWeXH8Kc?=
 =?us-ascii?Q?Zb5AkvpTZAcuf54L7mlDI0PVvYBR/7/VD0uAvXqENGUW2AslfzQP4PUm1J0S?=
 =?us-ascii?Q?YRZA21MbjMELmL4q1phPMIHdBMn/R+WPEnX7FsalyuSkLtVKQzvUEbAfzC4l?=
 =?us-ascii?Q?5Az4ES3Es9WByCkSKu/AyYeAiT0egHGRStulP76ER2OCpnsPAYQhoESf2Fcs?=
 =?us-ascii?Q?moigqVgf/ZM349Ds2SvQagxlVrPoxVPxcP+fz0BBe/UnweJ82j/4kXa9QaA3?=
 =?us-ascii?Q?vcFufR5Wqeb8vifYqHtowXgs9U65S5AuVv21OV3dL9DBShBruA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 11:33:36.6635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41ac65f1-f8e9-42e8-b7f6-08dcf7445cdc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8974

protection_domain structure is updated to use xarray to track the IOMMUs
attached to the domain. Now domain flush code is not using amd_iommus.
Hence remove this unused variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f88f6e4e910f..f44de5f31625 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -877,12 +877,6 @@ extern struct list_head amd_iommu_pci_seg_list;
  */
 extern struct list_head amd_iommu_list;
 
-/*
- * Array with pointers to each IOMMU struct
- * The indices are referenced in the protection domains
- */
-extern struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /*
  * Structure defining one entry in the device table
  */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8922c0b63316..ad593908513b 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -177,9 +177,6 @@ LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
 
-/* Array to assign indices to IOMMUs*/
-struct amd_iommu *amd_iommus[MAX_IOMMUS];
-
 /* Number of IOMMUs present in the system */
 static int amd_iommus_present;
 
@@ -1743,9 +1740,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
 		return -ENOSYS;
 	}
 
-	/* Index is fine - add IOMMU to the array */
-	amd_iommus[iommu->index] = iommu;
-
 	/*
 	 * Copy data from ACPI table entry to the iommu struct
 	 */
-- 
2.31.1

