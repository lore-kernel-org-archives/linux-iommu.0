Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14695221
	for <iommu@lists.linux.dev>; Wed, 16 Oct 2024 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729057035; cv=fail; b=VxpXaY0h+ToTLf0G+92Lez0WZoQdwueXdPfSztPGyYPAqy76t9zLPk3O/8iUMrHYk7DvW9L40wz12FU/au121sSlm/UUYlriDagRQO9odcNbzjEXSYBSBAwkcCOS0dPyboU5FG5qCHGEwLnabPAr0r0QiPTKdmy6XS63eEJYR0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729057035; c=relaxed/simple;
	bh=ydkOqLzpgZkuOUJgiusZj6e5fuH3/bEWLPcRq7fcpaI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=drXDyS945H/TKWgf6OsTkbHCuRa8goBfrwmqPVHWXKDSqmi2CmAMTQmvF0x7guu7Z12jTxB65xWsIagx1XlLPp+2mqPKuOF60opd1ygaA2j7HWIek081HRO9lhabFYK1lx6ln2KLgSrERfmKQYroKTX10zvvOfZpLS6U6b7zEiY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=jy/f/UZK; arc=fail smtp.client-ip=40.107.95.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="jy/f/UZK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbfpvcc/+S63nnqJ6ZAx+BBHWMOizEU+M/uoGQh8IRBz5rJNavCSqDywcZ/QbIb9i2W1PYDZ6dJWFcm63ZZbXFWCJZfDrIgc8UgFDdIRal4+JcDK1gksA/i3QtCVaZ5sOCPYRBh1yzHGEdM+6xHua5d+V4S0FcEEAwtEH2N31b4AEUzLQJI1pKGiVTKsoT7nUjVBURZel5jqRpOmnfJIy0Zuu/2gNiQuoELQOqhglPndNl68BdkjpalFVd3e/F40VC2FV8JPTrQOoradHc2LTVjRP+1VZ5mby6HjURI+fNBIao65kI+M6ZcpjiovoHhqN/dvSPAauxmTviHKykh68g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbKrVrtI4bIa34gImmUiwErGJ24XoGoJIxXVTqj1xKw=;
 b=Gupe4mALTPuaYGpHU/5b7YAH481NpceHpkGWxcsIS2jUgAjel7RByFgHnI/n16sH5r7lBxrsl4Xn8yvK2+mCIjrRgrviK9SyLi7cOK8ypcf27mFFvI0ukJ7tFQ+c8pSXyYADZ0hiPP4OIeQJnwmWoP5/J8Ush18Iw01yonHXXzcEGJxXgl+imwjmWZ2J1atO7uRVT7fywGYqJt/ty++MyiLBXCv3gPiIS7t6SJecVNrrKRp6RBjqkli4iwNg6Vhn0M+mGusMmUQL/nZgvC5HDL6XafC6EQCZvhNUhCvW8h5OhnRfT47a056/ZZxcMJiM7Z3PEFGFbG0xcxhY/Zhn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbKrVrtI4bIa34gImmUiwErGJ24XoGoJIxXVTqj1xKw=;
 b=jy/f/UZKrOvvJNn0IcbFVqvVXQS/BQBTdwyH6IJY7jwLEZMIUvyIJEQ/B16KVSPDo0UcmzF6lecMHI5Se81HVb5b7K3hhoUCCoFDe9m1a3+foCn1i6ijobh3J+/W1J7MPgX/9IZSeiAJ0fsxEtofI1Br1+78jH2urFnJSgqWwk4=
Received: from LV3P220CA0014.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::14)
 by IA1PR12MB8224.namprd12.prod.outlook.com (2603:10b6:208:3f9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.26; Wed, 16 Oct
 2024 05:37:10 +0000
Received: from BN3PEPF0000B075.namprd04.prod.outlook.com
 (2603:10b6:408:234:cafe::e4) by LV3P220CA0014.outlook.office365.com
 (2603:10b6:408:234::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17 via Frontend
 Transport; Wed, 16 Oct 2024 05:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B075.mail.protection.outlook.com (10.167.243.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Wed, 16 Oct 2024 05:37:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 16 Oct
 2024 00:37:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Joerg
 Roedel" <jroedel@suse.de>
Subject: [PATCH v3 04/10] iommu/amd: Remove unused amd_iommus variable
Date: Wed, 16 Oct 2024 05:34:55 +0000
Message-ID: <20241016053501.97497-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241016053501.97497-1-vasant.hegde@amd.com>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B075:EE_|IA1PR12MB8224:EE_
X-MS-Office365-Filtering-Correlation-Id: 07602efc-acde-415a-c553-08dceda49485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eZwpp3ZBHFF/M4ypepVBxB0ZGDwphLulifvP1PhOeFKRen9bWIqcGZP9ECoB?=
 =?us-ascii?Q?m11F12ymc6vJT/WieGX991NI1x6tEQpGQ7SwunTB4y8AaMsVE7T5OHFd3eTt?=
 =?us-ascii?Q?yTv+kV0vxKMTnfXsZdSskWc9yx6h5FdeCcNWgICqNGuYrrVLCU9WVhQz9pvA?=
 =?us-ascii?Q?9oRYvMPq+pg72xQHPryCIr5gfC3mGaxk6LYXWETT8n1Z4MbyhKZn50AqT2XN?=
 =?us-ascii?Q?Jpia8vZ0b2INmztsLJ/jJ7X/xqLcREFRE7JFSzQnbjjUQ1UJeQPotpEoxdP4?=
 =?us-ascii?Q?M4eFFckt5Pppj/vo8G8q8Bd6Tng3/Q7u7d173EzR5ybeBR/90fQQTWC0RA5C?=
 =?us-ascii?Q?kArVTdrBw41AoKiQt2oLlkr3aUUhHOMlEZNKvD1AE4R9u4KtsgLlBmZT6579?=
 =?us-ascii?Q?PmWnV1CiFEhTCDpuDH3gm8PbWfR1w1WnGOzYy05RCvdhK/cOYbSn5R+w59oE?=
 =?us-ascii?Q?Y8KlQgDZILkN04xyo3THTdD++rNjFYYhlpnb/OuD3BKYRiE9+8PDlsJFbB0+?=
 =?us-ascii?Q?rieNdVKQoEiHnjkGTgdgd/c+NXC+eBd6EIm7TlPp8vcD65V8vYE3Nr/3USGv?=
 =?us-ascii?Q?Qj7p+ku++5kfu9acYsjBc3XLzV7OMOXkzlvRoWjKs3Nifa9f9ZpofNRorZpY?=
 =?us-ascii?Q?QHSumPd48KxTXYlNf2Ote+kvL8aLz6AgCT3ptcDWzKRAtLu/oqhVbGhlVnx1?=
 =?us-ascii?Q?JUrsymKjrsoKYAUuWX9scxXwCFj2OnZaS6PI50T2QFo9mgh1SlzSmyUy46JY?=
 =?us-ascii?Q?1IuypqENlkUOJkwC5Pbar+sGaoCaw18SPM3dF6JW6LrqXzUD9C0rhAbXVgne?=
 =?us-ascii?Q?s0mquO6TNkFm/Y0mwI2JPcIeHI53FvpJ08ZmYaEm1GlwQis0l1pPEMeYbAcj?=
 =?us-ascii?Q?HLZ7jOoELOmyq9FVTSj2uDX5X9yOU2208OzXB2OX1sXDNByRjjZQc5TmIdiw?=
 =?us-ascii?Q?a7/Eo3ldvLUFNTniSK9qsVk3LKyns6jpavEJQNjbswnYouDHZkaIIoShRodh?=
 =?us-ascii?Q?5cyjDiD39nkKUUc3y0QrN2kYsAr2P47deQDYzFt63rNErWNoN0/RTIw2+bjx?=
 =?us-ascii?Q?GsU88UQ9nOS5J2BKj2L2YL2gK2/5EyxlCifeU0iG0KFLFch2g9vyV/YSni6y?=
 =?us-ascii?Q?wUC5X1mdfTXS0z6hoVPCNsBO5UFX9oKgzVSRuoxF6npnMVUNBMp9onimjtUA?=
 =?us-ascii?Q?WNuXX9KBYWNgd6kQIrfTzFlDOZfBgX7M5G2KjGAWKgsgLG8jV5JmpCw4VGr2?=
 =?us-ascii?Q?9ACNaP9r2I26il5xW6mF3m+XXF0rkwAVoO+urel2B59QTf2cj+ou4E2X03IF?=
 =?us-ascii?Q?X499n5HygYwzmRyMJWF76XcRuY8h4APDY5So+I+1kVT42CDSYLlKSX/nti8R?=
 =?us-ascii?Q?9yDYSaY=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2024 05:37:10.1200
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07602efc-acde-415a-c553-08dceda49485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B075.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8224

protection_domain structure is updated to use xarray to track the IOMMUs
attached to the domain. Now domain flush code is not using amd_iommus.
Hence remove this unused variable.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Joerg Roedel <jroedel@suse.de>
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

