Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1D21779B1
	for <iommu@lists.linux.dev>; Tue, 10 Sep 2024 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951579; cv=fail; b=ULUfirwq+mCdxIe+lBzPtISD9FEX8u3FcXnn24cLxguX1ldUdGIUKSLHW8N7Z53JI3W0x6PXXCj2OSCkYef7/t48JCmmjO8dxDU+jS75lgcljx9gZjXu41YQPBeS58xi5OygKp2lL4mVem0uHrteNT63BM4J2lEJ9FbTKB442sM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951579; c=relaxed/simple;
	bh=LEC3auiFxw24XgsVfVzI1Cn4bBMmDcYT/tmgtZhzChs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WtAILj+ls046Fm2No6E/Q7Dp87kqplMDxE9xhoRZFPIoDqUA9r3psYmMg3HNZkcVaJSBdIfS+sAZ/D3vCq2faTphHdaDGPdvsM8xnBR1Np6FdyGV3a4Mykmwoh3IHTvho16khUmy2aRJ6taQ6G6MxM7vT2h7v5b4LDgqD5Ip0Oo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bEU1OlsB; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bEU1OlsB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T/tu1y0h3IzJCA5VV0A4g46PKvUDH6bHkawY/tSBkTK2oelrABRFxQgiKVxlb0cpoDLHFk8rcAai9UCNz3nxkE3elKRuQ1+1ninJ0VjIGf56kw4HQC2PupZ+EfbeCMBIWIV2YjBf2r5V3IK/SzzE43RJyJ034lovhSl8QDhedo9x956MEk0xRCTKVB0FWk9XcKN+epYSDxeCCkiFrGCtAZTIrnDOakox7Pzw0taDGG/mfMjypv04sCNVPiz4SvwirrOLA2u5YwRcnHHN3CFAANfPN5ocIiYfccZ/E5Ba58+DCaDkt7/nIxki1F1B5TpS302BylwXtGMem6tj+VSjlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+7Ux33RSW6Ppnk2Nblhso7zQ7G5HcSw+792zpJaB1g=;
 b=Ncm7GvP7MI0M6tO+HzkHTNvGOKqqhavBDjJ3hVZyxCtUz8QTP4Ia2r82hxSWHs0hMsrLzzi9V/FwH4sQDGyw1ochqXKc2kQC8q6Qs0aLUCyy2+vQI0GHvDkWwYFcqConmgC9ze07tanJxbHMNeYjPblK5hJLaewBQOwXO/tWF0UF7OH/kTSMX/otwdUSEakTtlzHviAymbVE/wGqllpub0P3qQEoxV/ek3bBc8ZEWUYJiDvGBZtUKAgiAsGiagrPSVClWZhuWpu3zF8FDMxbJnMG8Lbd2fHzH5fng0irwNEEQeKe1wRxONs6TbXbFiHUtmeuHdFWDI5C/Ao1tZiHjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+7Ux33RSW6Ppnk2Nblhso7zQ7G5HcSw+792zpJaB1g=;
 b=bEU1OlsBkxhMC4tgoRtfweMb/OUiNLl2vx1OLP31JefyhHsW6T2SdNa5v5HLlStn+LYfyxzHTn1xUkLbXscrAtO+LT1OdZ/wzJ4GzJQBJe+ETEd8diPJHx0bBn1LD8IMJt0FORpmspqU3xP5tUwWR4eRMHhZjyVegjZNtzfECYw=
Received: from MN0PR04CA0010.namprd04.prod.outlook.com (2603:10b6:208:52d::25)
 by DS7PR12MB6287.namprd12.prod.outlook.com (2603:10b6:8:94::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 06:59:34 +0000
Received: from BN2PEPF00004FBA.namprd04.prod.outlook.com
 (2603:10b6:208:52d:cafe::e8) by MN0PR04CA0010.outlook.office365.com
 (2603:10b6:208:52d::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.25 via Frontend
 Transport; Tue, 10 Sep 2024 06:59:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF00004FBA.mail.protection.outlook.com (10.167.243.180) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 10 Sep 2024 06:59:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Sep
 2024 01:59:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 04/10] iommu/amd: Remove unused amd_iommus variable
Date: Tue, 10 Sep 2024 06:58:06 +0000
Message-ID: <20240910065812.6091-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240910065812.6091-1-vasant.hegde@amd.com>
References: <20240910065812.6091-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBA:EE_|DS7PR12MB6287:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4cf036-cd20-49c2-82b0-08dcd1662056
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ro7rRKsRLUDjGAGMn9vGA0IQ8j1UFTj858RZEjRglmSFbwx124lIaHzXC/IL?=
 =?us-ascii?Q?uBzQa6EzDEllQIP56IWiYFuFfjtLHHiGPbCVEsfL1qKuB4xLtKQMPBx6ihuC?=
 =?us-ascii?Q?HOAxhl1K/21teBB0pxUrQQEywNvvTh03qCFnCP95bGESkSRongWAGEsGAOdl?=
 =?us-ascii?Q?eitUGPmO9Yl3PPxalR73rnlqPfs45Puh7vkk0VIb6PZVWP3LwqIIhIViVr6r?=
 =?us-ascii?Q?Fz7R+K4YVXYHCRtL+EINT/+Bv1U5Ir7huaTIeXXPbQdl5/I6RD6Rc2c7/zj/?=
 =?us-ascii?Q?Y0aIygjZxAUssndnXxAyFxTjNwMrnniPkfGsNjt2eYB1GGa2Sv3PE5amdsB/?=
 =?us-ascii?Q?bz/09wn4tbpoT0mhrCq7kAYttphQApd+JLB0D7aOj2OFp1bJCFeAf09nmAIx?=
 =?us-ascii?Q?9zAaHaqJ0sbeADVwOA0xzZtOebsLd87ktmB5s4q/kLOuGWiMTquiX+RPB0WU?=
 =?us-ascii?Q?MgB0sesFdY1f2Pd2zLE57MbRKESQmHBTVwgTQ6nD7QcG5jY7pjhaXvZRIlim?=
 =?us-ascii?Q?wcKRJG5otfbwIt9aIzZcTWReXqT8WFw8c2LJ52MKpda+AUi4Mg6D6PD3RQDg?=
 =?us-ascii?Q?v0axYp4v2XJ3x+wv/LsNZjp9OLjjEXOuofkqPREboHzsZpl95f2dZSPTWWgH?=
 =?us-ascii?Q?I0A1Tupupwh/AycCufljbxmLvyKlvL7lXAPwfz9EKUQz8bS2UvYorbnVFpte?=
 =?us-ascii?Q?rAY7uaf/6jwsvEVPZOnxiSo9USy4L6bO4MBX8e3AmjsR1ycWcsR1tZNgfdMD?=
 =?us-ascii?Q?7PI9Zsu6XywHX/Hi4KoZnNyehhLeCF+lO0rQYleUqphb0FsiYd2WMem2w50Z?=
 =?us-ascii?Q?1omo9cQ8XIs6xNyNK2DVT7dldBdxqwBRWum+ce3Q7zGsMT3xfgsxv/0XAxdP?=
 =?us-ascii?Q?LSw2IBvitMiCE7LnRjfx4ijgAz+ceuJw56iLckKNYpns3i89QDMNldnPt4x1?=
 =?us-ascii?Q?gqGtZttFfuxV0yu6C1f8tTfC3LI/vaDKGpBEkd9qS/8TQfodBeCa8cFHeNHK?=
 =?us-ascii?Q?ekWL70UyBdmahzt2A6EyxSCghW3Wpdv+gjlAgl6PtmEGGNvaZfcS87yWmYj2?=
 =?us-ascii?Q?O8B6oWldETZhxRk166gcvILjRW1q7AKq46OoQDUjPmJRC5PbqcxaCLHl9rAH?=
 =?us-ascii?Q?+XxNwCONUBA80Te/SddMyjmuyfm0jtPZF20hpSpriM138zBu0SnK5LOwvOVL?=
 =?us-ascii?Q?jZHA2iN9o5AmEASsO1hVniDxRGiuWUvdLsBT5+niD2wixP5HfaVpsAbLPKsG?=
 =?us-ascii?Q?iU+cYrPB2KGCX4pgpj8qXx2CvZ+K4/kZUqb/lDYLn1L9UQG0Jepj5YewJhuE?=
 =?us-ascii?Q?5eRZ5MKJSzvuHhDaZkAiQ+hc5XB9BszwDDqfj0ud6eUUmpnoUOvD9ZFfDkbx?=
 =?us-ascii?Q?c6Yrp0eVEJxD639X64HWFvkwlmbmDjCd1Yr/wsaRXXueToO9tyEwGShfZcsN?=
 =?us-ascii?Q?UtfigcIHncfnX11F4UJRlGM7cST73ecQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 06:59:33.8240
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4cf036-cd20-49c2-82b0-08dcd1662056
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6287

protection_domain structure is updated to use xarray to track the IOMMUs
attached to the domain. Now domain flush code is not using amd_iommus.
Hence remove this unused variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ------
 drivers/iommu/amd/init.c            | 6 ------
 2 files changed, 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 0f030a61ceb2..ad6ce13c0b7b 100644
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
index a1156d928bc4..4c6ecef149fd 100644
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
 
@@ -1742,9 +1739,6 @@ static int __init init_iommu_one(struct amd_iommu *iommu, struct ivhd_header *h,
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

