Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013027.outbound.protection.outlook.com [40.93.196.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DE344102A
	for <iommu@lists.linux.dev>; Mon, 29 Jun 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782747755; cv=fail; b=b4g+ZUVNvxV/byQiOapTmt6HAmWN0E9RPeB9H11JHYw4FXdADQMbtUe6dk3uFIX/rAfxvO6iiA4jILev7AOlhfEH26y+k8n/z2cA3P7QlaV5q09ixx3GxwFy0sfgrewTsjJqW8hAExJFtNXFy9EywHNfc4Z39sZDgO9aufUW2rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782747755; c=relaxed/simple;
	bh=CCVjfsnbSIg8nytiZjfvngyEhhjn2c66NdFvGXq04Zw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L86zHdx1djfZ1Oz/8vjARMAAOhSto9/gDA8hBWSquHEjRDTgzD4qY4ed4ztYaTe9xnOc01508YCiES2L/puhw/jO/IcCqEszcWZ+B5CkG7hG1myQGszI1P+NsRBORPls1t/WDQAl4ABhBNk6tfA3SX/O4H+rVNvPr6UtJVZmv98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HDqyu+Ti; arc=fail smtp.client-ip=40.93.196.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HDqyu+Ti"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U3ooLAci3BLG62bN+1ClJ3ehpccNllHKY7+C50kEwS+fogDRhLSnoXp4CHihLZXDynKWP/e2lND+Iqz7dzQwLqFM/fcfp2UW9rqsamCoQrCC0gDNgmBzGGeXoc86oc7rwLbBUzeQLXgdNC7rzwfMq6d2ybyVS+Cm4owg3/JownUsMwGhfAj4WFF9+TUxIQJT+5d3KkRiUsr0h0M/xCk2Q+X+AOC8jdmVe8F0S+l52yHXJk6wTcWrR+rN4AtgIcmp+ZKNm2cjnIcNGHm1Y5HRux7xm0SQ2S9+ru6quwfASIUf+TrKgPLeb0yAmoEYzyMdqVUlQzdx7i9ozOUg4dMoew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S3eQYwIeXbpX10I5eUnaBbDSfXip045K5E9HTcj+fn8=;
 b=QaY2KdlxBR/QcW+heVOdEWuy/g8n+YsC0oZMqix5Hrc8TzRjsq5/1kGuCC02MclkviJwjRUnRWpBx/1nfQfgNCSlwTVdEXvKFN4yY8xVqlT5M7C+/84m0zMgsul1qZaI3vdoVYKMuigibPTHRwfUE1+940p/aWU2V6VK7bGIS9y9tYVbBX9KULqcwi6A6++Md6Pw69IcRczfKEp32uLj/cf8Rdj0BCzsv4PlxD/T5Y0vI3kxeXTriTcNfvpJfBU0mB7NJdD98pHXQrIc+/5U6mVpv8MrH7IpifwNX8F9FsZVWMSgYSebVVdGXLQEZ4zkKs9SbXQ5UgNPdDM4LUs1qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S3eQYwIeXbpX10I5eUnaBbDSfXip045K5E9HTcj+fn8=;
 b=HDqyu+TiSajtweCPm8N2J5Xlata40O5k6i4Hgkgt4DtSghuF25EtFw94mkl65WsRsaBg0rtIcW6A1KpvjPoKQxCu2okHH3M4SVPM3SoePkmR5AxLkf6K4GIxk4vF1dAHI8CODCF/wevhO/VuQF3uX2uTR2Nml5odeeon1OcrKA4=
Received: from SJ0PR03CA0258.namprd03.prod.outlook.com (2603:10b6:a03:3a0::23)
 by DM4PR12MB6064.namprd12.prod.outlook.com (2603:10b6:8:af::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 15:42:29 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::31) by SJ0PR03CA0258.outlook.office365.com
 (2603:10b6:a03:3a0::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 15:42:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 15:42:28 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 10:41:56 -0500
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 08:36:49 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v3 12/22] iommu/amd: Pass iommu and devid to amd_iommu_make_clear_dte()
Date: Mon, 29 Jun 2026 15:35:25 +0000
Message-ID: <20260629153535.15775-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|DM4PR12MB6064:EE_
X-MS-Office365-Filtering-Correlation-Id: 335c38bd-9a82-4b2b-c0d8-08ded5f506cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|7416014|23010399003|376014|1800799024|11063799006|22082099003|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	o2Mgyih4DDsjkuRKAQEkOkQ59/Akwr8KzxRbpm1G7d6fq4EiwcMzr4F9CDmxvKVObgzIH/UNljMH0W9tz9KDFgYIlRrbcY45w6IMax1Kt2Pv1enc9+iTYiRocmjH82BHE3E6J/FjwksCyKWPLkMjWrVLIOq8KuXJC0r8M53d3culN33QOumv4QDn8cdWYkZ2uAhqAcIrNKW03s7T/v8UdxoLzJKvYURIl/dQjvt5qdHTifO1ZKmb99H41169FppcpXCTe51yLir0H2G0On/kw/k4yedmMCfAS+Gu4NOKiPnXiyyCM9lpO2X/ZjyYW6Y7xPBZ7Em10sGktmcBG6DK6D14pTHFl43aE/VhVPYSd6Bf33zFlLqlh48d+qrGTTxbBKbx91awH9zRF87svTBDD+ZcDhHC+iIG2j3/HlB2pDduxw0wYxPTgi0GCUFStHzDgNXIQXjPMYT91MGeZWZ5oCy8QDjK6l2gHqoO0StCgyWxknHHCNRGkAWhmxXWjTx/NyK16M+qjrXknmWGuHn0kDCGy7+5IwEkUkpnWMmZrJ559l9u752EtiKBBl6S26zN6vIiakI82RdSkpt8tXpJeMt/HvWHK3O8iKZwcDiqb76ngZ87O18JBMLvdmDDwu7OrdPhyYtr/7pyBKCeZ+dq9Om074HwgloVydSHeRBwO7xGrMvqx89WGkGIOEKUc672iz8IUEARXhqp4D2iyikKnA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(7416014)(23010399003)(376014)(1800799024)(11063799006)(22082099003)(18002099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	KVMycsMvSGJULdqy0Aue/DOGOsfflf6rwGXjSVm3xmn9BBU5FIywztD+Xtl/TxZS3f286IYHXWJ7/mI1j7N6OZpgPoRjyqtMzEfDgRRsKaj8f33F8ywlvogTJe9eKnT89V8zQjusry+qEd1M1pi6/FD6Bn9GhLyTl3E64bCJFGiDwNQLoCgBU9v2fn7PgPdpfRszOrdibk6Vv0SsvU5YnOD1Ceckjz4a54BTgl6snu4AK/xnMRzWPeZwPX0Upr2mz6VqQ7LvA1+LHPdQyYS1w245Jlk+Q8JfTsugjcxrGnGOWM1mSaKu+gQjlV3TA3IWR4eCvms4u4so2Bzz5fwefgbV5L4bZqII3oPni2DeuUQl1Ao9+krNnmiQy7EoXU60r+ByezazEUHN1z2Pz9Pnkb8RCGvMOq5xYY94hSwsNCvzKatn//tfuoZm9RF3SLAl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 15:42:28.9935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 335c38bd-9a82-4b2b-c0d8-08ded5f506cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6064

Take struct amd_iommu and device ID explicitly instead of deriving
the IOMMU from struct iommu_dev_data.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 6 +++---
 drivers/iommu/amd/iommu.c     | 4 ++--
 drivers/iommu/amd/nested.c    | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 20000722451f..269d0f448b9d 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -217,10 +217,10 @@ void amd_iommu_update_dte(struct amd_iommu *iommu,
 int amd_iommu_completion_wait(struct amd_iommu *iommu);
 
 static inline void
-amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry *new)
+amd_iommu_make_clear_dte(struct amd_iommu *iommu, u16 devid,
+			 struct dev_table_entry *new)
 {
 	struct dev_table_entry *initial_dte;
-	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
 
 	/* All existing DTE must have V bit set */
 	new->data128[0] = DTE_FLAG_V;
@@ -230,7 +230,7 @@ amd_iommu_make_clear_dte(struct iommu_dev_data *dev_data, struct dev_table_entry
 	 * Restore cached persistent DTE bits, which can be set by information
 	 * in IVRS table. See set_dev_entry_from_acpi().
 	 */
-	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, dev_data->devid);
+	initial_dte = amd_iommu_get_ivhd_dte_flags(iommu->pci_seg->id, devid);
 	if (initial_dte) {
 		new->data128[0] |= initial_dte->data128[0];
 		new->data128[1] |= initial_dte->data128[1];
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 55257cf12bac..b9063a7d6a6e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2253,7 +2253,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
 	struct dev_table_entry *dte = &get_dev_table(iommu)[dev_data->devid];
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 
 	old_domid = READ_ONCE(dte->data[1]) & DTE_DOMID_MASK;
 	if (gcr3_info->gcr3_tbl)
@@ -2285,7 +2285,7 @@ static void clear_dte_entry(struct amd_iommu *iommu, struct iommu_dev_data *dev_
 {
 	struct dev_table_entry new = {};
 
-	amd_iommu_make_clear_dte(dev_data, &new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
 	amd_iommu_update_dte(iommu, dev_data, &new);
 }
 
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 5b902598e68a..81a5ae00225e 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -200,7 +200,7 @@ static void set_dte_nested(struct amd_iommu *iommu, struct iommu_domain *dom,
 		return;
 
 	parent = ndom->viommu->parent;
-	amd_iommu_make_clear_dte(dev_data, new);
+	amd_iommu_make_clear_dte(iommu, dev_data->devid, new);
 
 	/* Retrieve the current pagetable info via the IOMMU PT API. */
 	pt_iommu_amdv1_hw_info(&parent->amdv1, &pt_info);
-- 
2.34.1

