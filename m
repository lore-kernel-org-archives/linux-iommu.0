Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011015.outbound.protection.outlook.com [52.101.52.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD4A12DC328
	for <iommu@lists.linux.dev>; Thu, 15 Jan 2026 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768457385; cv=fail; b=nv5r3xVV7K91uzKTd8l/FyvwWqcgdOjHxx0QIqq/whO48IyDs/1NzERmQmFcts8El07SeDFeC3dV3Yi4PZVd8XleWU//bNrUiN3oyzsSyyOq9WgSOOh/vAWfyq2pMjJaeDSBfEeEaFEpqiqu4YCMpB1BP/n7oe4KMgVGpCUlKBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768457385; c=relaxed/simple;
	bh=A5QsHig0m+Ij3JP9fDMjVBfWYQneRshHY0MLRjkF7o8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jys/Z++7i8YuVIoWJuUpJq9jF938DdHrspoY1BqjhuvHXS/0Mffixv+4dLu0xVRBTgUXUu2qed4Nr5UwuptMQD3P5XcsemQI6LZSG/EwlnfW8N9K0xze6Z4CCois6+Dhc/KTTHgDJ2PMBn4zrtQzNRNkQwaR1ncLxbS+UR3/bDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XUwyRDZg; arc=fail smtp.client-ip=52.101.52.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XUwyRDZg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A0abvHNwPHcleM/rLTKdM1lS/nxsH8LZ3nJX4ZD3wi258jWst4Z/0eLR66NHVhlafdlwvgc0EgoX649uPknKnTLX3DdxihUbaCQYu87tJUR2WJL2qs1GwqGXmJRXobB+L//FmXHFwf+c7YbN4172zv3rpM6bb2GxQwQ64CJREONsmUWf310IfoRt1V0843HMjy/KGkULSfHwWz5KnLCNtD58DdsxEnnvGwLxEaFc2r6zhresqx+Yt+8ykikbMGimZ9WQQGkUVHZlyTfCehdvRQl1ON4v+Jq8G23LDkz0d7NPGeSJHc7XVKYwe/eJmsLIRRv2WJneNB+tN1lJopnuDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LrNaJhvDsF0g5+fYn65PRYyGcaBwi8+Dw32r7gVt8gc=;
 b=aDewfxak3D5NmFccXlNnCqQqxkaZ8xc8Nmjb42SQH8CsS7YKsAHCMP15OdPkkqzAivCWychjp51Juyxbw2Ue1+5BNuECsk1K/aZEYcOmkKsDndV1/wHtVN+Mf8iCZb2bkM1oevhQMtghLOyMs/Jmtq9UN0foGQpviM/5NnnYVlRUF2d/Zv9ccIR9ypd4a1CYA4JQLTbkrBxVxnxvEuWCI206YGQn4pDkF/hD7GijoEWVoSb+aLVqTX8Z57s9Uz1h//MJ+6x19Hs2BKkGJQKcn+hMKEU04KW2cQdUKHx9mYgqBbSWjqjkT7RGBY87MvPjpkMcgpkyJmlpP3a+XjinHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LrNaJhvDsF0g5+fYn65PRYyGcaBwi8+Dw32r7gVt8gc=;
 b=XUwyRDZgo0biLbuucRti4Bhmt95Bz7KrPrPhlKDWvtHH86Z346YiY9946AoaUAu/zNlhvWA1goykaInh48JfXR0xNErZkB+aDtzOvqySsCPlH9kS6bwSQcDAmhBlsx1goX0n34/XfrIcy6PM1TDtuZtiZyJE2QIx5xllvaxjURY=
Received: from SN1PR12CA0064.namprd12.prod.outlook.com (2603:10b6:802:20::35)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Thu, 15 Jan
 2026 06:09:39 +0000
Received: from SA2PEPF00003F65.namprd04.prod.outlook.com
 (2603:10b6:802:20:cafe::1) by SN1PR12CA0064.outlook.office365.com
 (2603:10b6:802:20::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Thu,
 15 Jan 2026 06:09:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003F65.mail.protection.outlook.com (10.167.248.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Thu, 15 Jan 2026 06:09:39 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 00:09:33 -0600
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
Subject: [PATCH v6 11/13] iommu/amd: Refactor persistent DTE bits programming into amd_iommu_make_clear_dte()
Date: Thu, 15 Jan 2026 06:08:12 +0000
Message-ID: <20260115060814.10692-12-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F65:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: ff63de7e-188a-4914-db8c-08de53fcaadd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b7lePuqAzAdoz8y+PYJf/dE8hqp5SoBIULDJadEFincRqPnD/wrc8MPUMeD1?=
 =?us-ascii?Q?yJYO0NuR2vzDThbJj4rYUytk5U5UzTIv0qLhfKH73ZvD6U4foJ+cGnvpjJ/Y?=
 =?us-ascii?Q?+DiCDmSmZnUIHGh62BEkNyvNYTsHmaj72IwB5hjfhuxMI6ApolAt3fhTB7lz?=
 =?us-ascii?Q?g0c5dnPrXxNXSbzScOsYcG9kEik80vkIIoEg+4QCExkWfc8tCRjRpveQuNd5?=
 =?us-ascii?Q?MR3+FEmc5VjGziVU9ma9L7D8xheQAKbJZkwXCBkJMbaatLQ7dTxov7cv+3Mf?=
 =?us-ascii?Q?OoX05dAcGGXzpQyQSS3QVNdGF42A3NetWvxg//jHLCuRLP8vfGw+gXRZJV7V?=
 =?us-ascii?Q?O+rQvhT0NshJDT04iiFkSeiHapbQnQiC/xPve8mfovwgDUXU9FvodfY++Vec?=
 =?us-ascii?Q?TF5yEb+yxtHOfWCH5IN5GrNB5sBpv8b+epRv7awZ2sq+fCOAESbnz75NeniC?=
 =?us-ascii?Q?EtLheT+nfc6aWHyysXg3eOex3Y7ts4wJq99Evnc+EKE1gfBmJnWk0vlGNV39?=
 =?us-ascii?Q?Pc97RlCWrPZZsUBoHhTPH6QFCAohtd8HD6LiJ56zhrHsZSj5OfFIQ4zM220G?=
 =?us-ascii?Q?AjAnN7OkEoP5mcvboy6ZKEd+hyBCNyYGMRTrNze63yeZnOr1GJQ0wCbUgsfz?=
 =?us-ascii?Q?BDZ4T/cGtATiIVrCccbzSaUF5di7MuQB/TU8lCCn5Y4lxP+qJJndQTeMsrqf?=
 =?us-ascii?Q?anVU1wbxfgLjcLXnnXqTPpRncTZzR6TEaA0sg8LB2Ry6+cWt4+4Wci9LgXRR?=
 =?us-ascii?Q?MsnNjciLwmjTD0IkpTP5Gc5eLRDWolpkr1Z0zM3oyzz/VcuAjo0F/77MI2ms?=
 =?us-ascii?Q?aucQb6PSOsDGLCPrL1rQXyyrr9EP/YLAAN0l38lI5j332v7y1RQwzAYfYzCO?=
 =?us-ascii?Q?iIEd+XW/f2+kZqo2j52u8PJ/+R/C58HhoMUXC3ANa/pEwRtqfoNmSeyZoY0L?=
 =?us-ascii?Q?M013sZrqIFPuFIaqfQZvF1ODTb2R5HFyKvwduOruGLeR14lypCdX8g5Wa4hR?=
 =?us-ascii?Q?g4B7Mj+nlYAXWY80Fntrus6d0S6AaMIWrr7ZrG7Hhl6ZEEmxSKN91BtLuRuK?=
 =?us-ascii?Q?Enb4+jfZh381JMebVKatz8aG2a7w2ogsA8nIM0ch/fV+gYXIx4F/QKD7HJs0?=
 =?us-ascii?Q?9cIdPwTi6R2X/CtU1xBrSQg2BfX+dz/BBl8bBuOq2liHPDwIh3zyn/DVZsBB?=
 =?us-ascii?Q?Fu2fUx6sX047CEC0GGpeWpxVj95MJTihF7ld63NqXE6Mi75vUX//CrnBdWgL?=
 =?us-ascii?Q?ABAu+szE8lQKZY/D73iQ2juWt/3zix9weTsimn3EK8x1xdwkM/Q3bLxzcblS?=
 =?us-ascii?Q?sYgxoyFwyW5B3MYABnH1Bj7Qp8T1zYMCrGxXuv2XVc+wRT6+4bE5KwnCan9g?=
 =?us-ascii?Q?1f3UYcHCEeHDwcavNh3SQI92Dy+ptvUKYUICv3qrizbzl962tJuk5WBqwUGI?=
 =?us-ascii?Q?4zEIWE+Uo+cgddLe3UDE3uRfJ3JrxIDTJIF2VnaeW8UbhhsbL1K2EOvX9KHb?=
 =?us-ascii?Q?Xe9q+ey7lVnlchrUhBfI5gRBywzMdr+jQzeId9S3GJ7fZGP6RcTOulk6NZgn?=
 =?us-ascii?Q?F2yc/1NUC3Z1TTuKAtIpFNSAWh16cYDV4wTj9zUvqOa7ZR1t44iDxMtbmMJM?=
 =?us-ascii?Q?/EXzZqA+xYBQod9rDXZ8V7NvXGWAHbBL2Zt8KGVd+F+bv9AyodkutNtfsU48?=
 =?us-ascii?Q?kQGteg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 06:09:39.6094
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff63de7e-188a-4914-db8c-08de53fcaadd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628

To help avoid duplicate logic when programing DTE for nested translation.

Note that this commit changes behavior of when the IOMMU driver is
switching domain during attach and the blocking domain, where DTE bit
fields for interrupt pass-through (i.e. Lint0, Lint1, NMI, INIT, ExtInt)
and System management message could be affected. These DTE bits are
specified in the IVRS table for specific devices, and should be persistent.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 13 +++++++++++++
 drivers/iommu/amd/iommu.c     | 11 -----------
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index aa29afe96e90..00fc9c6073de 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -197,9 +197,22 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 static inline void
 amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
 {
+	struct dev_table_entry *initial_dte;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
+
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
 	new->data128[1] = 0;
+
+	/*
+	 * Restore cached persistent DTE bits, which can be set by information
+	 * in IVRS table. See set_dev_entry_from_acpi().
+	 */
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	if (initial_dte) {
+		new->data128[0] |= initial_dte->data128[0];
+		new->data128[1] |= initial_dte->data128[1];
+	}
 }
 
 /* NESTED */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index e33076b99aac..dafd34465fc0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2106,7 +2106,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 {
 	u16 domid;
 	u32 old_domid;
-	struct dev_table_entry *initial_dte;
 	struct dev_table_entry new = {};
 	struct protection_domain *domain = dev_data->domain;
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
@@ -2164,16 +2163,6 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	new.data[1] |= domid;
 
-	/*
-	 * Restore cached persistent DTE bits, which can be set by information
-	 * in IVRS table. See set_dev_entry_from_acpi().
-	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
-	if (initial_dte) {
-		new.data128[0] |= initial_dte->data128[0];
-		new.data128[1] |= initial_dte->data128[1];
-	}
-
 	set_dte_gcr3_table(iommu, dev_data, &new);
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
-- 
2.34.1

