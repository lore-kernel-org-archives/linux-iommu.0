Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010038.outbound.protection.outlook.com [52.101.56.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF86E25A2BB
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011064; cv=fail; b=bVgGjdmQtfbU+Ipn5erMLUM4qXT5PTGxuhTd+YkK8HnH5fGPHtXmWavCTJNqOypl500sLUW/Ei/VJBVk3yerpJ57q156R1cRx8qhf1YiOcW1JRLxEYaOcQnKk3IfNLcivcF0G+vSHAvDsOlWTDmZjA5kUmTA1+AYZJt1QIxEpMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011064; c=relaxed/simple;
	bh=gn6xpLP1QjIQG6ns6GPR0XtG7tjfWq8j9jgl5AS97I8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPUHzenZkNhDJSX9DDITyZCugoIH748kO6eH8lOmmdoPEiKYx4D6CRHsJNHzK98/cO5ku6vaVMW7DcgvCJkWr4bpI7+qahC6teCk6M1axKn7F+vp916g5KMvMDBNoF/ZnPEavAZDHPTREUOHiUPFr6Y9ROJa8OlHGHH03VgWMbc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CP0hXxqX; arc=fail smtp.client-ip=52.101.56.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CP0hXxqX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HPT7lZHSO9gkv4eMToJ7Hw0WK55dmEQfDUOs58dtn2jUg/ib77n8pgkpRQLShTlntz1XTEgUhOj5SHfHEowJ8PNLp6yiKOfyvkpO2eUrP3hp1W2mjImRpjzdCRxEIEWI5szj00K7j71Vy/Tug32wPfMYtyHBni1Dsv6jBPc+QSY2NB97V+Y7EIpfqOvSZK2q53NKvE8rIIDof1hnABT0/dwRXOppRZyyqvWSnDVIEXiXrOTtOuK4PtJOPZ9rYHcc3XciAR+rz6803PQ7siK9F7pLodhsrBBm//YFrp6p4kX5cFPavRNChYmvaUsOXYQyVY5p4sPD0CeaEn5LFnB0Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DZhN/4ljDXwl7CFS2tNrXY+OE2PYoXg9r/V4Je9hjI=;
 b=HDTYkSe85Ig92l8gFGHFT9F4yvCZLaW6lpP2meBdKwuJ7FDfYB5t0uDAo9pG20YofC/QGgBCJyqzRFQhcwhFbbdPNc9/lnEX9foDoJI6y7OpE3wtlJklnktYg+s6WAeGdTSYv6O5D81woAfe5zCgQcdGb9nJLFggfL/gTmK21uY1MrEwlDiJus6qGfgi57vHsXZLYVvaVlaDf92LKY9aLUJm8j85rzbZdkQsoFYYgOwTPlVyvqjlM6bWuZ9R+hwbJT269K1dNNZfs/tgVIJaPdRvkcDYYfqu94YkimNiiR8PYcTdZhDMfdSijxbpmTCU0dDSAT+yFarcwP+nEHUBSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DZhN/4ljDXwl7CFS2tNrXY+OE2PYoXg9r/V4Je9hjI=;
 b=CP0hXxqX8fEtTLdAA5SGDa5kJ+3Zz/wJe/kM2NN2YP1epwbACXHu/21Oh/Pay4PfLy5QZazJWWvIFlyDCsAdk6MrDkS6YaI0NMndbU+Dq2gwwrQYO7UXjzuWtJgTtHeho1hiZNarb95JmTeR6CUkxarTzH1RpkHn16oHbmcCzyo=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by SN7PR12MB7786.namprd12.prod.outlook.com (2603:10b6:806:349::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:44:18 +0000
Received: from BN3PEPF0000B071.namprd04.prod.outlook.com
 (2603:10b6:408:f9:cafe::fb) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Tue,
 21 Oct 2025 01:44:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B071.mail.protection.outlook.com (10.167.243.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:44:18 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:12 -0700
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
Subject: [PATCH v4 05/16] iommu/amd: Make amd_iommu_update_dte256() non-static
Date: Tue, 21 Oct 2025 01:43:13 +0000
Message-ID: <20251021014324.5837-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B071:EE_|SN7PR12MB7786:EE_
X-MS-Office365-Filtering-Correlation-Id: a2067b98-2515-4280-b5e8-08de1043597a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Bknk+kRmj33PX/x/c1yFljNOGBftYLjMvDgd/lg+PbVnKUIfs1A53ZGwtVoH?=
 =?us-ascii?Q?zRxHC0uABLTnL3tcmL44HS2AfURjVRpHJYP74+y4pwpBCsw5pnv0A8l87L2I?=
 =?us-ascii?Q?GI7mRAFdKO+B5F1qdbIPjnw3OiU+/wDhvSiBm1yZ5hM1r9xbBB27D4eB1wuy?=
 =?us-ascii?Q?3GAZc2qkBKbAZiipAki5Kuj4XyJe1qz3TfcY8yFnNb0CVV9GRvqM+BK40PPM?=
 =?us-ascii?Q?OwlTYDFN/vzJBUUYiXTe2dkKacbU6Yx6qd65jUAewhL8Isx+v8dxNUgPra04?=
 =?us-ascii?Q?eH00x6OTNpKEjijE0ScLFS6E1IHbyR4cg/vBRgQsBOcigVBHPeTyW0SswAvM?=
 =?us-ascii?Q?5xjXiYab2swmQ8wjsbbOw0/0rCYYoqfU1hffcdmWfJGfN6U4GyGGpzPK8+wi?=
 =?us-ascii?Q?8111ysIWS3YCLl/N7w5ci3MjUXNVizvUcNa55UpIVUWnGLPpIjp13VomJSm/?=
 =?us-ascii?Q?40kk6udKm8S0YKrCmt3a7rPlLJ4u30QRCEf1NND/0w2Pjt1PkDq7UX/jorOG?=
 =?us-ascii?Q?BHYxy9EbsbnhgilgYetjIdNLeOdE5W9RED44Ca2VTvLCGT+NxWhvyEfzS/Uf?=
 =?us-ascii?Q?fSTTwh+2H6laNheCuKOsR6HfKLE7kM6ZJXO3kQOgU0bSsWszGx4prp9ltwSc?=
 =?us-ascii?Q?FCNrW8sdKm5mDUAg51C3UZK+VfXvxfr4tdlRCImR8/ePyeTu/wc4Nrjf+Twm?=
 =?us-ascii?Q?+wcai0sIZRPEFsmi7AaQahkQZld0+82r9eAUOynZ9+Xk/CVFEy2BXN4eZcKG?=
 =?us-ascii?Q?UIpAWvwpDIZjRslRuSaK6mgOgMSUxjA1teNdpY/cwGkU6pjml8PF4kmWGGds?=
 =?us-ascii?Q?tq8WTQgsQ67A+LtFKInFecaevQeR5wjCLzEdHS1i2yWSVDi0DnKhKiSEh+BJ?=
 =?us-ascii?Q?+rnPvKwGWIybwUiRB4V80flt1bcM9QnlbFw2sMedlG8GCXtO7Yu0Xzm67mtN?=
 =?us-ascii?Q?BCofFBzsawoY/eid01Am9YKP7xqqraoQGkalrXpncHL8OD5GLOAHCZ1eaHs9?=
 =?us-ascii?Q?fSG5XchhA7VnyMqytrFVaTGQFEesjDQYQRBGrmh2g+F2/KJmIJtMutJAHBrW?=
 =?us-ascii?Q?AZY4PMpmDUgf1NoteoIrn5kHFAaw2vRrUbmYPGPHHa93dRG6ZsagHXbBrwS0?=
 =?us-ascii?Q?tQRo/VkF84KiHT+tmoVVtigqkkS+Cqo56SuCglFY5TTxIdvIXs2ya01JC+7O?=
 =?us-ascii?Q?G4ajawmEk68cr/KTRPhouCQqKQuAuXj79wkVk6J2tlrW6tPxHASkqfJ8ziiG?=
 =?us-ascii?Q?GbjCHUlqaW8oL3uuoNbBCbGnQ7oqcep+gXHdwbdxIL2RjN+Y9CNnIhyLdw6u?=
 =?us-ascii?Q?RDiu/DNYsG8zXmO0PdCbZByxVsDqjEhlr44xkBAHxq6zTwvE7zto061V+DPp?=
 =?us-ascii?Q?gstIgquxn2aUsOkOx4N8grC91p9M4HR6rwlc9mUjLWMioHaMSmEpWZ8A0Fce?=
 =?us-ascii?Q?iq1DzmAuiDlDWXNgTF3w4G0xJjHB/YEsIO1GK6NARToYQsHFmmHlrz4qjo/d?=
 =?us-ascii?Q?YZ5jc6kZstWOnjcuH9QXp42Cvtz2BL3uk+DscmAnCaBAkRYAgnhNDditaQB2?=
 =?us-ascii?Q?iRCyJMbUBr+oMwn7Jyo=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:44:18.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a2067b98-2515-4280-b5e8-08de1043597a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B071.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7786

This will be reused in a new iommufd.c file for nested translation.

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     | 11 ++++++-----
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 079fb1d44c00..eb46e8914eaf 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -190,5 +190,8 @@ struct iommu_dev_data *search_dev_data(struct amd_iommu *iommu, u16 devid);
 
 /* DTE */
 int amd_iommu_device_flush_dte(struct iommu_dev_data *dev_data);
+void amd_iommu_update_dte256(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new);
 
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fad74d2bc1b1..3f2c61509b60 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -132,8 +132,9 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
  * This function is used only by code, which updates DMA translation part of the DTE.
  * So, only consider control bits related to DMA when updating the entry.
  */
-static void update_dte256(struct amd_iommu *iommu, struct iommu_dev_data *dev_data,
-			  struct dev_table_entry *new)
+void amd_iommu_update_dte256(struct amd_iommu *iommu,
+			     struct iommu_dev_data *dev_data,
+			     struct dev_table_entry *new)
 {
 	unsigned long flags;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
@@ -413,7 +414,7 @@ static int clone_alias(struct pci_dev *pdev, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
-	update_dte256(iommu, alias_data, &new);
+	amd_iommu_update_dte256(iommu, alias_data, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
 out:
@@ -2109,7 +2110,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte256(iommu, dev_data, &new);
 
 	/*
 	 * A kdump kernel might be replacing a domain ID that was copied from
@@ -2130,7 +2131,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
 	make_clear_dte(dev_data, dte, &new);
-	update_dte256(iommu, dev_data, &new);
+	amd_iommu_update_dte256(iommu, dev_data, &new);
 }
 
 /* Update and flush DTE for the given device */
-- 
2.34.1

