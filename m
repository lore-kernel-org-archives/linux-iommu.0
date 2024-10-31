Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8AF199FD7
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 09:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730366244; cv=fail; b=b6OktIigDKsOOwA6mlMeBOYWNjWjlhbXxHFFOByVXKerDB70KlplJNxXql8G/yvNZ+/1r1ZOyhfdwtX1kB5mXRar7gzGR8gEYQDBc3pvh6bw1AG7aORhcmAGmbRkRTsafYgvUmLYWDLY7imGDBE7QfTrx7dwJpv1gj1JAGRL2Ok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730366244; c=relaxed/simple;
	bh=s6gqvh9MDsV60q0i55rnyPMj7ZtTOGM/Ilgl0hkZN4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=flI4doN/rFuGXoug4im+bumwh0KsaLUuwnzFWy2w54CTFNvezSjf4/4NlYkoE9w/JYslrvUVVjfrHZ6EPDaz1CbINgSiPBE7+gOVPizpiXLOMTASpvAsGJavJZOQWjFKOHCh+2fpWrm1RsbJZ/8l0Zj+8fyDcijaJYV/GM9LT1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oQP2s+7n; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oQP2s+7n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOBdrpuaEMi/88YDtg4dlfYsSJk/iEqoqMmRnCi7l1Dip8Lcgi/xnU9G0nwp1q/OhiLV7AWzakLuKvHtlxFlklfjW4CXquFJqonylZBIgsSqtcxtwCgMoaA8PTK8U7icWjS8jYukWekelHVW9bD+pWp7q/z2W5JzBdBkZWNP7dv/bCESJMJecNOa3I6BvEs9/Up/lzVZ8AFYeNwb465BwrSS2tGF5PkIQgR+GpV2pXSe1eIZTd3lEeYscSnC6NZhI6AJCqb2lyK4P/hilRDigEB193etpUyJSGQE075sk7IVcaJiQyahQXf27C5NnWsQoLnH2YBMP+YSms1UexO2KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JN16sgb4dfPYvWQ1H+ggOiOmzC7nt0KS3auUgYxkQ2M=;
 b=gz4x+mxu23vqYhNAs5FvbzyhedqZGl9Z46O70OmaT8rk6XPkYj/rsJ6n2VPgpzHloUSn1cNryPVJkZgcaaXKX6nrzf6EenyVYiIQEM1dNGZDE518A6A63Cf4ntOvpBIH04AGu7BpodQOMupvl60WvJVw9trobxL7aMVH6aCPRmHiRoHuwoJxCdhCwTPOcQl3KiWR7U9ZC7AM84ArtrBb+Hg0vpe9a7czO18W3zd3LBD0vvWE5gIS0/ndoZwRILStuAysR2mHgg20e+y9n2Ul1omyhy9jCdFeZjOhudRBaBg1ZHfsj8/DpYR54G9IHPDpYtusMyNyG089SGJZKi8Yhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JN16sgb4dfPYvWQ1H+ggOiOmzC7nt0KS3auUgYxkQ2M=;
 b=oQP2s+7njmk/oSguwH9BSskiss2xQnUx86elkculFVCcv12qGip/YJwdt4cRRi31G4FRT3bjE7T2TVrP2//eNtvMo6ZiJRsrmesx/QxkPXBrwGnfyFVF8yj9dKuF82iF1VVSEIET5mKID5QrgiSK/QEU2Lu9NdLCbZqiGmAjqL4=
Received: from MW4PR04CA0066.namprd04.prod.outlook.com (2603:10b6:303:6b::11)
 by CY8PR12MB7337.namprd12.prod.outlook.com (2603:10b6:930:53::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23; Thu, 31 Oct
 2024 09:17:18 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:303:6b:cafe::37) by MW4PR04CA0066.outlook.office365.com
 (2603:10b6:303:6b::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20 via Frontend
 Transport; Thu, 31 Oct 2024 09:17:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Thu, 31 Oct 2024 09:17:18 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 31 Oct
 2024 04:17:14 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
CC: <joro@8bytes.org>, <robin.murphy@arm.com>, <vasant.hegde@amd.com>,
	<jgg@nvidia.com>, <kevin.tian@intel.com>, <jon.grimm@amd.com>,
	<santosh.shukla@amd.com>, <pandoh@google.com>, <kumaranand@google.com>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v7 10/10] iommu/amd: Remove amd_iommu_apply_erratum_63()
Date: Thu, 31 Oct 2024 09:16:24 +0000
Message-ID: <20241031091624.4895-11-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|CY8PR12MB7337:EE_
X-MS-Office365-Filtering-Correlation-Id: e7aabb31-9ae8-4f05-ee3e-08dcf98cd183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?u2g+ght3KmaRxwdVzdl+bi+q68B4V6fVaPbdKDHobSAPVi9i7bvPkSZJG2ae?=
 =?us-ascii?Q?hcZNQIn2217rGtmbOEmcyRV+mez94E6unj+BHBM20DOD38WWSdf+V1va+6YD?=
 =?us-ascii?Q?vjiQ2nYyvlL9SRqNlJlN7G383GWnUU8b9P9+LieuZoAvYjUtbI/4+24Vxzeg?=
 =?us-ascii?Q?gWGQ3PozgpAc+5XstIvchC0gL87JnzmRTdf2t8f93Jo90vNnnO5JEqIhKSo8?=
 =?us-ascii?Q?BaLd8ICLNywOCYoXAZTdCiv5Uz8RBi6zdiD3e2i1VTplznSOmO42EOdT7um6?=
 =?us-ascii?Q?Eh+QT3d0PTIGtH41YJdmD9rkg0j3TUZm7YZM4n5qdyhyyvPdE4BZCAtREuSV?=
 =?us-ascii?Q?Bzjz01d9Rq1ZYP7Jx4ZVWZigSlPOYjM0orl5R3LRp92HRwMcdE0bKcIzkeZU?=
 =?us-ascii?Q?GRh3Jy2pgPGU3Yr3XtzXlgmR4LotunYKa8tweOnzz7zLDBVyAlybTR7CL/y9?=
 =?us-ascii?Q?LSw0zmO9UCdwJJbhXa0pQSPISFHfSnImh1M1Ow2oNh+vT7JnshzH4+M00957?=
 =?us-ascii?Q?h5DHoWhUYu7BhPMUTLEXLOV/feR1cGkDDCUvnovR9fOEFDOjCZo3stqzkfkk?=
 =?us-ascii?Q?9T6nedxVsX9/5ZYj3PuUV+dymG7a06OxnUOva6HAHFton/xNoaUyiyJ7yyGf?=
 =?us-ascii?Q?c5LQ8tIfENS3QGRCqyf03mjFLUowaJFDBfbFlCvPcrCsFkbgIDjeNkA7d3OE?=
 =?us-ascii?Q?0d6bVO2PkBtegu81WJALdTgUWgPyaSZ2695Xs81iGW/VULHpA/fhbA4+dUvS?=
 =?us-ascii?Q?TP5HQzCSTNytP63GBB2QfIz2itAMa8yIvFF1iWsf1XRKz8WOGVlOLUbYOb7v?=
 =?us-ascii?Q?7odDvLri4xicXkpX0Vev7mTinlRwdNKR4eio3iALXnKBbM0PEiMozFoQzlos?=
 =?us-ascii?Q?/ZJBPFuzkQRx2zK7jh732BRVCDd2CRTnwllDr56U321+Af4Yfc7LqQ8i50jF?=
 =?us-ascii?Q?iIKjeWJHMjP4uG0pFG2Vpuw3MaMa19uvwXqsuoCRoyybaDZO5mL++jA8Bdyo?=
 =?us-ascii?Q?XXGT9QHjFs4FdmPmSbG6h9GgCaQ46/QsLd0erdCGXxuiN1isuV/sGOyzAiEv?=
 =?us-ascii?Q?8sAzShbewqrfYzX/ik1bgKJm1yetDnDY9Ji47EciAOd7wWu9Y1Jk2GZr9EzE?=
 =?us-ascii?Q?5DSlfh1VszXk0htkZyrufXGZ23zDU+HYPgJ7I4udAZPCg+y/No0RJX/ArWRI?=
 =?us-ascii?Q?34VYfhqgGLcZ/CX5+gzW9TfrAj/dqnhDDP3B9NmoRTB0r6FFyTAT/k5KNfg0?=
 =?us-ascii?Q?u/5W1O8SmRAyjlK21GyNI9Hjxz3u9w19TXaWJSp/xBoafjqpMaONivE2gEda?=
 =?us-ascii?Q?F974q+H6DmXgtXkuryrok5AjUvhhr3YPUz9CBvdpB5dB8CHQN0xY4Vn8yfBk?=
 =?us-ascii?Q?8otjjUBvkbxOdPb5OVNbrPH41umZoEBwLP3pty+OW44JNY+L9Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 09:17:18.3871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7aabb31-9ae8-4f05-ee3e-08dcf98cd183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7337

Also replace __set_dev_entry_bit() with set_dte_bit() and remove unused
helper functions.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  1 -
 drivers/iommu/amd/init.c      | 50 +++--------------------------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bfc61f7ed923..7004274bcdda 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,7 +16,6 @@ irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
 			   u8 cntrl_intr, u8 cntrl_log,
 			   u32 status_run_mask, u32 status_overflow_mask);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9f5bda23e45e..046628ba05a9 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1001,38 +1001,6 @@ static void set_dte_bit(struct dev_table_entry *dte, u8 bit)
 	dte->data[i] |= (1UL << _bit);
 }
 
-static void __set_dev_entry_bit(struct dev_table_entry *dev_table,
-				u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	dev_table[devid].data[i] |= (1UL << _bit);
-}
-
-static void set_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __set_dev_entry_bit(dev_table, devid, bit);
-}
-
-static int __get_dev_entry_bit(struct dev_table_entry *dev_table,
-			       u16 devid, u8 bit)
-{
-	int i = (bit >> 6) & 0x03;
-	int _bit = bit & 0x3f;
-
-	return (dev_table[devid].data[i] & (1UL << _bit)) >> _bit;
-}
-
-static int get_dev_entry_bit(struct amd_iommu *iommu, u16 devid, u8 bit)
-{
-	struct dev_table_entry *dev_table = get_dev_table(iommu);
-
-	return __get_dev_entry_bit(dev_table, devid, bit);
-}
-
 static bool __copy_device_table(struct amd_iommu *iommu)
 {
 	u64 int_ctl, int_tab_len, entry = 0;
@@ -1179,17 +1147,6 @@ static bool search_ivhd_dte_flags(u16 first, u16 last)
 	return false;
 }
 
-void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid)
-{
-	int sysmgt;
-
-	sysmgt = get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT1) |
-		 (get_dev_entry_bit(iommu, devid, DEV_ENTRY_SYSMGT2) << 1);
-
-	if (sysmgt == 0x01)
-		set_dev_entry_bit(iommu, devid, DEV_ENTRY_IW);
-}
-
 /*
  * This function takes the device specific flags read from the ACPI
  * table and sets up the device table entry with that information
@@ -2644,9 +2601,9 @@ static void init_device_table_dma(struct amd_iommu_pci_seg *pci_seg)
 		return;
 
 	for (devid = 0; devid <= pci_seg->last_bdf; ++devid) {
-		__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_VALID);
+		set_dte_bit(&dev_table[devid], DEV_ENTRY_VALID);
 		if (!amd_iommu_snp_en)
-			__set_dev_entry_bit(dev_table, devid, DEV_ENTRY_TRANSLATION);
+			set_dte_bit(&dev_table[devid], DEV_ENTRY_TRANSLATION);
 	}
 }
 
@@ -2674,8 +2631,7 @@ static void init_device_table(void)
 
 	for_each_pci_segment(pci_seg) {
 		for (devid = 0; devid <= pci_seg->last_bdf; ++devid)
-			__set_dev_entry_bit(pci_seg->dev_table,
-					    devid, DEV_ENTRY_IRQ_TBL_EN);
+			set_dte_bit(&pci_seg->dev_table[devid], DEV_ENTRY_IRQ_TBL_EN);
 	}
 }
 
-- 
2.34.1

