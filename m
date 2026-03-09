Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39C4F3A784E
	for <iommu@lists.linux.dev>; Mon,  9 Mar 2026 14:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773065187; cv=fail; b=teAFPHhJ6e3Vw5vLOdIjLezFbYcLvrc+q1xVG+OSd3uoSYcFcGnSD6TCi/+qBKxzYOc0yBi3jrTymIzLtXKbP+HL7kVMzpbEsVQZ+S4BeowoohlWZHcTjxOyj8SUr0Kh71jJGgljnIJUEMPLY+bWEqwTpMOm1oiRzD7o4n1dy44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773065187; c=relaxed/simple;
	bh=/OPbAFQXcP0fD8Fst+Au5STe6tfi8KBZkPOgrBkeX8A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXMFcCHrWiDMItRc52oLNAyUVCrXk6PMgbdYiStdl08uCsrWwsRMDzwKtS+BHf7Z84GTsNIeZmf8S6s9uwmh1TWzyK7Bji1bVEyPxN8cB+vJW+parAhI+MRycyu5KjM02Vtish9bmzl37En4hlutuUHYoKzNAZJ29KkkCDTk9Ac=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Rm3NKl9z; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Rm3NKl9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yBYqKGPx3Cw3omK1IF12iwe0h/2N9+WBvAijWFyT3OInAkOyFPnlLA6lcrUb3lNk7o8XSt9C4eQCSleLtR3VJ/pQeW8bZdDe42Pt4TJ1EPrJCRpMtB0Kl+uJWubemZR4Yt0LJzg2mS2MC9OgUan8B9DBxGdf4eiFPMAHq/h+VW4Gxhcg772Ha0r4k+sgMfeoIIvrQrXCVZ7HPBIkxsIdLVM4/TPcitISOBmHtdAXv22KHXctC3PdTTKou8nzk5BTSb5o7omtEr2zmTY/fiH/YTVme0e7t3jzpiuCKr1DTGJAumPDpTjcGEZIX+fp/0mHyk1JUh4BQCnoGpibOZlZKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YNhZ7znjOV/+PmFkuQHKpAar49Abhc6Bsat99B8uG8U=;
 b=W7CiF/Mi8XncLRUZpTauZaGbmtpKW2eXtPAaoSZc4wEFgcGOLTk3i38Fklx4FeBQPdWlhbpA7UzrPfkyHjU2b+BFv7muwQ4X05DplUXkwcQRjkaHw/Wm1XxOKtInzzjUW7BRcvQxLdKrMtp2MIH7GQe9RdtQYIgpF28cgHLN5qgygY7EIw7jr42bXvM/OQGRAVquyqmU2cZg1YXqkjebAKiQW/FaDNisrTFwDqQ559fgKsgb+GRJeRTDvzl8Ow+KPVOzW25/VaptsILLXkTgYO59OFlOWJdzMl/X/4r8lJvWbw4uowkEna216nsXD5XTzCeaPjK7Aw64Ddlcf/kMBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YNhZ7znjOV/+PmFkuQHKpAar49Abhc6Bsat99B8uG8U=;
 b=Rm3NKl9z/9q5AOCW2TMSW3uO53eiVcw/ZYVwRKQcs7KLsa/1shJYvIctWldDdnSIntH3VusL+No9rUxgZafxJA2OaR2cpYPD73+AO/zHaHKuIAZjCZ/AKAwgxk0JADsJ/VodQsPGzloH/0l3H2zsaFI6PKdAHfaHgL4SiRGT74c=
Received: from SJ0PR03CA0062.namprd03.prod.outlook.com (2603:10b6:a03:331::7)
 by DM4PR12MB7598.namprd12.prod.outlook.com (2603:10b6:8:10a::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Mon, 9 Mar
 2026 14:06:20 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::a8) by SJ0PR03CA0062.outlook.office365.com
 (2603:10b6:a03:331::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.24 via Frontend Transport; Mon,
 9 Mar 2026 14:06:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 14:06:20 +0000
Received: from BLRANKISONI.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 9 Mar
 2026 09:06:16 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>
CC: <vasant.hegde@amd.com>, <suravee.suthikulpanit@amd.com>,
	<joro@8bytes.org>, <will@kernel.org>, <robin.murphy@arm.com>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/2] iommu/amd: Adhere to IVINFO[VASIZE] for address limits
Date: Mon, 9 Mar 2026 14:05:28 +0000
Message-ID: <b1dc7207fbfc46d6bad89bc484d2034cd2bdd2db.1773058553.git.Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1773058553.git.Ankit.Soni@amd.com>
References: <cover.1773058553.git.Ankit.Soni@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DM4PR12MB7598:EE_
X-MS-Office365-Filtering-Correlation-Id: de44a677-b9ed-45c3-f911-08de7de50a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024;
X-Microsoft-Antispam-Message-Info:
	mPi4bcSe8a0AjlvLZn04FNUliAYXWWbIof/gJ0aIajAVV4byIZh87Fq6so3yzUuqdeJmgegXD8fq8MKw1T6lHSqNCk4VV/EfJsoIPVM7zIdjHWnIu5lm6rh9ex+ZICicdDsvk3+IcNmFhOPX26o60uyyuuf8DpI/HMQcVfmzRxC3gCwLHxQG7giSmzDnW9JycEo+xY7oxHtGzFEUdbY8/rfxhrUjvqhvLNvWfRfKGH7xGCUJNNFBs0fkl2Q6dOTXfZ2etA5vYlOQCAVsFSR8dl3XNdXV0N1ae/7+fFd5hjvp3uCH5vS1lf/2iNjkYTPOvA7uBpbQmav6b2/05V9wefyt0Iss3oCLAnn7g7Ps4kqfXn9I4RYaDc7goKVan4mGcfR1MAiBuc/3Ra3Hb1YuiIltwjIZOE46Zjdq6X7l6kI6pIbcC/zZwExyUuDGpZ+xONQ1ItJUiyQTN9fSEu/y4pn1El8g3SwVa5PxTRoB6Xp/2DdvXlYOzC/H33OoyGKR8HoUTUjGj4ZaJwJH9EZLp2TOYNov63IXzMhf+/3VDkPMBBwa/eRfGYG8lnnjDY0YRp6SQxuM2xYZnj7hU+5Tw7Y8PcKSyiIQDv4tVzU+pc+qeYSjVhmpBeCAkmsgCYRx+9v9hA5yD1RCZnboecOI8aLm58IwAY5MpV0cJ6WjfoUkFC3epZnxGLVFFushjLxTxknQockzqlvAVpmg6yZUZhhgi7DWCzt33MOsD/3NME3N27DwxGbw5N471oskkhUQsA/0TM/R9MctqbRiytY93A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	x7Lc7oB0fOa0wezcjexVPqSSggQslxpEm3CIhGVNASmZOVExmmFGMmphqYzQrM0EFPcepZGsEJuiBFP9jX35tjYt5NcmKwlrxbgQPVatH5J1eiH8TGfrIiPY635iR624SiSY8v49Ec8CxdV2hfvWuwwRzIAYU4Xwb9mh21bAOX7luET6W/KEm/N6x/2f9orUlkr4W5LKk/FsPKiiO8SvX2g01upW6dIEEZqyB3+kCE2qSlByk5MRnoJNgsL0gIO9ZN0timnQ2iPfCtIsu1uX9cFlA7JqQ5tG5x5XRghF++kmf9zWk/+Ab1fB+R5dM4UHeUHBhRSyKXjTE3FBkQdiW4hUY+K1bM3QbcG87YHwz3CUyUd4V3H97tUlmhd3ftYx+Jn/zxnv9yCbXbpvz/8M6Lg+gutZp6LRIUhkXgRf7ujf2i3k1pd+9eDJNxV26y5O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 14:06:20.2687
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de44a677-b9ed-45c3-f911-08de7de50a16
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7598

ACPI IVRS IVHD’s IVINFO field reports the maximum virtual address
size (VASIZE) supported by the IOMMU. The AMD IOMMU driver currently
caps this with pagetable level reported by EFR[HATS] when configuring
paging domains (hw_max_vasz_lg2). On systems where firmware or VM
advertises smaller or different limits, the driver may over-advertise
capabilities and create domains outside the hardware’s actual bounds.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +-
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/init.c            | 13 +++++++++----
 drivers/iommu/amd/iommu.c           |  3 +--
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 1342e764a548..f915938a3a08 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,7 @@ int amd_iommu_enable_faulting(unsigned int cpu);
 extern int amd_iommu_guest_ir;
 extern enum protection_domain_mode amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
-extern u8 amd_iommu_hpt_level;
+extern u8 amd_iommu_hpt_vasize;
 extern unsigned long amd_iommu_pgsize_bitmap;
 extern bool amd_iommu_hatdis;
 
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c685d3771436..6a85a38d34bd 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -395,6 +395,7 @@
 #define IOMMU_IVINFO_OFFSET     36
 #define IOMMU_IVINFO_EFRSUP     BIT(0)
 #define IOMMU_IVINFO_DMA_REMAP  BIT(1)
+#define IOMMU_IVINFO_VASIZE	GENMASK_ULL(21, 15)
 
 /* IOMMU Feature Reporting Field (for IVHD type 10h */
 #define IOMMU_FEAT_GASUP_SHIFT	6
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index f3fd7f39efb4..e874a4135d5c 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -152,8 +152,8 @@ bool amd_iommu_dump;
 bool amd_iommu_irq_remap __read_mostly;
 
 enum protection_domain_mode amd_iommu_pgtable = PD_MODE_V1;
-/* Host page table level */
-u8 amd_iommu_hpt_level;
+/* Virtual address size */
+u8 amd_iommu_hpt_vasize;
 /* Guest page table level */
 int amd_iommu_gpt_level = PAGE_MODE_4_LEVEL;
 
@@ -3188,7 +3188,7 @@ static int __init early_amd_iommu_init(void)
 	struct acpi_table_header *ivrs_base;
 	int ret;
 	acpi_status status;
-	u8 efr_hats;
+	u8 efr_hats, max_vasize;
 
 	if (!amd_iommu_detected)
 		return -ENODEV;
@@ -3218,6 +3218,10 @@ static int __init early_amd_iommu_init(void)
 
 	ivinfo_init(ivrs_base);
 
+	max_vasize = FIELD_GET(IOMMU_IVINFO_VASIZE, amd_iommu_ivinfo);
+	if (!max_vasize)
+		max_vasize = 64;
+
 	amd_iommu_target_ivhd_type = get_highest_supported_ivhd_type(ivrs_base);
 	DUMP_printk("Using IVHD type %#x\n", amd_iommu_target_ivhd_type);
 
@@ -3240,7 +3244,8 @@ static int __init early_amd_iommu_init(void)
 		 * efr[HATS] bits specify the maximum host translation level
 		 * supported, with LEVEL 4 being initial max level.
 		 */
-		amd_iommu_hpt_level = efr_hats + PAGE_MODE_4_LEVEL;
+		amd_iommu_hpt_vasize = min_t(unsigned int, max_vasize,
+					 (efr_hats + PAGE_MODE_4_LEVEL - 1) * 9 + 21);
 	} else {
 		pr_warn_once(FW_BUG "Disable host address translation due to invalid translation level (%#x).\n",
 			     efr_hats);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 81c4d7733872..e8d15ac9b2bd 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2712,8 +2712,7 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
 	else
 		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE);
 
-	cfg.common.hw_max_vasz_lg2 =
-		min(64, (amd_iommu_hpt_level - 1) * 9 + 21);
+	cfg.common.hw_max_vasz_lg2 = amd_iommu_hpt_vasize;
 	cfg.common.hw_max_oasz_lg2 = 52;
 	cfg.starting_level = 2;
 	domain->domain.ops = &amdv1_ops;
-- 
2.43.0

