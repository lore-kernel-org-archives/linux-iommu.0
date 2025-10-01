Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013017.outbound.protection.outlook.com [40.107.201.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245852D7DFC
	for <iommu@lists.linux.dev>; Wed,  1 Oct 2025 06:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759299046; cv=fail; b=bK2atZrOjkpp2ocdFb9gorS+zRw+xskWIJ5prgnwgynoPth3QXDmg7LLXpXRSXXGvW69jjjHltjPi5D99u7JqKQ/chXLeDiuIogTsr2G60SMg2jxB/FaLsitdBj1kZcjUOcTdxWOm91oHiKSXDGksFq66BI6iX9hGJyV0Z+ponI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759299046; c=relaxed/simple;
	bh=eevyJza4/bKpggHNiepHW7bBTWmqsMwMSJY/ty1caGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LQx42Zw0tRnFYnmfbblEi2QE+k2FjEbuzVNFX4IH4ALTOGWwiTpwatWVAESDMGtxvPvjlZibI7ubSSlfE1C7xtMmtCVhXoNlE+/tBVv0YrKgF2mIh6zEb7Gg+klujYOgeyY2aHB3xdQF11Id/posxWSVJVdoRI8SZe6fXA8CfxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gkYB+FFA; arc=fail smtp.client-ip=40.107.201.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gkYB+FFA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rBtXgsWKwsiYsviVV1jE4t4buImSAarQAipiFYkp2npaUwLaAIjOJsKyQ5cc4dXwOUnxdV/6pPI0RmHINM4usxLAOYs9L02VRoCyoN20yERY60KsvF+dcDfJTqMoCuGyc69SQgqAof1YsQ2gM/bwPTN1aLsawleiyM1ILHZOeF6x/uBnyQNzCiCy92apnCNnuACp8zJ1y9KOpBk0ZFD4aEgeUbZQV7hYw0bOXeqlJRM2+SB1zLxeeskcBhnMmJACTV2o4mpOBERvQmQW5/XDonlCHxEqrCMNSaXqwd5oTSOxTU8HBxGkgIWRtDX/5Afi1ZRDtblEt3hIl6SvSkNKUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5j8N4ivWLf9ApwfD7paQZkt67l1FDv5m91f4vG6+d9I=;
 b=dnCj7A3E/PSJAYHDjewIV9wgbG6j+GWFIPSGjgz/BDarsBIS7A5dbDUpEqtEZNpu8x/ALRvNAZNvr7+31AhAG9IJ6RMK42D+c6aCEkGSpAZoBgpjS/RMiDFmrCQNWHMGIrFQ5rdYPEo0OBxiGdNiL4Ha21P0bV8PGtBkI0GNUEQ6rbQ2iESqNvpqWUk9bK5fBMzWOGuIAaOhY9T+/DAuadSIjNq5ciK37dVpI5ivs7RAhO59sPnD9/SQS+EkoRwdeWuO57AUsiAsJfG37QzSAD8TVhXsvfjw/Aet+O/qQOROvaRxmRznp+Ze3ohiVVrvld1BlUpKgEkSQ+gRvrhGdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5j8N4ivWLf9ApwfD7paQZkt67l1FDv5m91f4vG6+d9I=;
 b=gkYB+FFANA8d08UAzvtjuga1srzYJg101/Iga+BdL0owDLELs9WW19OyIZkvGq/8qKyWcpI5KeWV/JJPwMqvsMGuwT6NS0RuroOh+5UTkq+euW2gZ/woWpc1cDK721Iw43uk9dczA8gjJuYE7JhnI3BX3zKx75EicTZhGVxdjmQ=
Received: from SN7PR04CA0117.namprd04.prod.outlook.com (2603:10b6:806:122::32)
 by CH3PR12MB9431.namprd12.prod.outlook.com (2603:10b6:610:1c1::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 06:10:42 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::93) by SN7PR04CA0117.outlook.office365.com
 (2603:10b6:806:122::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.14 via Frontend Transport; Wed,
 1 Oct 2025 06:10:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 06:10:42 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 30 Sep
 2025 23:10:36 -0700
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
Subject: [PATCH v2 05/12] iommu/amd: Make amd_iommu_update_dte256() non-static
Date: Wed, 1 Oct 2025 06:09:47 +0000
Message-ID: <20251001060954.5030-6-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
References: <20251001060954.5030-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CH3PR12MB9431:EE_
X-MS-Office365-Filtering-Correlation-Id: cac0fa00-aeeb-48cc-b599-08de00b1406e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rQY7L8PfXj86bOl3CXTje55YiM3ZuZ+CJ8vYUhQxrYW+2TncUcG8Ocg9utcS?=
 =?us-ascii?Q?pJYs3Dc6IuycTn1PnaSOT7JDZvIDo23/0wAqsOOeNOMTm+EczVlULkfVug1E?=
 =?us-ascii?Q?ufVT9oSWppOnNFzgz5wC9W8gOdbjpdwLFLE6h4hmuK3+qofzUWj85Zp/adzu?=
 =?us-ascii?Q?sk9jt3hEHMyGA6t2W7arELqp0b9GvJoCrRfXGxZKS8NR9JGabMHs37fKDpIZ?=
 =?us-ascii?Q?icayScEx2g8PnWD/ugHgiD+kgq6XZyrZrhd3nFXRs92caJGGIKFTWgc9I5NN?=
 =?us-ascii?Q?D7K4/rej42loku+FHTNF76OtgD1p1K44IgOrK5y/Mw0LFV5RdK0X4mu+fClo?=
 =?us-ascii?Q?zU0oBDh4UNCKVsFir2iS7Qd5RYb/R53GGU3WyKe6wW4VKkSt1euFxBZMFkY+?=
 =?us-ascii?Q?OwIDO5uR86P9AI4KNtL46QXgGggb1ATVxxL5xZHVWDJUtJecubYf/hA2fWJm?=
 =?us-ascii?Q?iIy2X6gTAsBp+wQel6UYqbxkrqH5OtJOP4ntFHOHhYXxqmzdDsAb6OtnsaOi?=
 =?us-ascii?Q?b3CRPLGCMhISHSbvotKPO94K+CM/gVI1R5GZkBNkFF15QQNrV/8Ti9P6WFIj?=
 =?us-ascii?Q?aiELhW+enzc4HZarNPyKo8SuHIIPcQDVs63KcHr7uP4pDPB8oL1+7EPMQF1W?=
 =?us-ascii?Q?uf3AiTIcWcu0kvbKjEApl4P2U5nQFsGUuOD5Hwb2IV2lPq4HDeCNMdykoxRD?=
 =?us-ascii?Q?q+NngvFabgYyYnOOB0HJ8frVnSW1RiUPyW3HDsAif6WZONGg06hEIjAgOqBL?=
 =?us-ascii?Q?Txr6URH1QNRwRqhPpPy8oPE923Cbi1ecF5RcLgpisuJ2yGSX71PDTbLLuACp?=
 =?us-ascii?Q?kNNs5BZxCTVbUvanJQCFsFgtl0fjCaxATCvGmZpoGBdi7FpXsGPGEIuylHM2?=
 =?us-ascii?Q?+PMHO/omIkeRa+JDQR5zqSTpY8fbIPcQwXmrSLLlQ8YB+KS2lrzjgCGtSCPd?=
 =?us-ascii?Q?UwcWFMVHI4JbbeHmStwzvEeLeD8lkC41oqLOW+v4epjCZz32n7KvrvO4riMF?=
 =?us-ascii?Q?75s7YFA+tKYnXsNVIJ1PnEKkPYY6zOvDlM6OBH6yaPqDOLMCiX1+xRktbsbV?=
 =?us-ascii?Q?P9xokXmDbmchI7FNoVBCNPjLtwPjFy0ELS9wWJLI3hP4eoVp4tJMkhsc1JKZ?=
 =?us-ascii?Q?t4EDggkua0gqIy+cP12jXFkPEE3HONWzmAzSN5KuG7x7FL4B6PlYxbowf9jb?=
 =?us-ascii?Q?hWcKcOj713KuTcjb385fgbt2krVXVPlnc+IJy79JGKpqe7BfRQr6TTkxReWt?=
 =?us-ascii?Q?dZNFva7HaPvbjE+XsnA2FuBJ86OOR3c5Wm5aIl5RzMJr0avyUWgQFbbnfzg5?=
 =?us-ascii?Q?cXKLDQBckL70KLUGBhx+AFchniJE8GGf1jnq8Y0y6GtYXLaWNAuiFhZppuNU?=
 =?us-ascii?Q?5KKQ1o6DElyhRzN43aQmF9A67epDfqoXE1tHKVcpxrNUWBu3yBGlF1FH144d?=
 =?us-ascii?Q?xSbh6wWvy+A4O3z+3ibF9HY9vLtbcRzlVESx4OwlbheEkmUN77agLmRZCOIe?=
 =?us-ascii?Q?wOEwAeQrmFTeSLCjTTK25KT5TcyXG0vhg7j5kXwjvG4dspfrBNCcTnUnANof?=
 =?us-ascii?Q?OXx3fCtLj5PDMunFPdg=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 06:10:42.2667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cac0fa00-aeeb-48cc-b599-08de00b1406e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9431

To allow reuse in other files in subsequent patches.

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

