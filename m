Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13934C433EF
	for <iommu@archiver.kernel.org>; Thu, 16 Jun 2022 01:56:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C6DA440C83;
	Thu, 16 Jun 2022 01:56:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id r340_n4L80lg; Thu, 16 Jun 2022 01:56:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 77C1A40C89;
	Thu, 16 Jun 2022 01:56:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61A34C0039;
	Thu, 16 Jun 2022 01:56:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14DF5C0086
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E9F4440C86
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Tz5i4GmXqjm5 for <iommu@lists.linux-foundation.org>;
 Thu, 16 Jun 2022 01:56:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on20620.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::620])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DDC9440C7B
 for <iommu@lists.linux-foundation.org>; Thu, 16 Jun 2022 01:56:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RmpoFGjr4QNV7/NjtK/JfPoQskpHz78SyPx7EKTYSfAFWu1VxLFBqwCYPOCSrUi7NFk55B/LxamY6WzF4Gu8KgNpk8PHDgE7tA3C47Xys0h1o5+9yLkNarAXxQJQtT6yuf6vNDW5cVOM0m+E+KmFJdxmmIVW5Z5+QOrYX0pGTLRglwGpy0qJCbuhKjW6BetAjlujSNx+DZClATNpABC7Q6nXQCC7TIL0rt+BAYTOSh3MrdrJsED1X9Znr2dfW2dK52llc15+u8wzHFG9NKxvnNJJuERSzs+cvmOOnTRCEksSZLmkAinB3AMu2HS2RwLcTzDX0oUatPpmYiwLwYDm9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmQ4k/fsyIGVD1N7jflDRc3dnImvk8e6waeVA8T0JXg=;
 b=FQyEPpqANDigOmSu0tYDz9uMb+frCNJFwoxwhMBYy6Mja2cSN5XSpQsWE04y56BNADtYkaid5jzNFHcCJafSJ0O0UO8+YnyL8DQ5ahW4yVm9X3JlO416YllcCWQTicldYvvdAN00C7AVzjF11u717mZT5eHT/oLbEZFC4eCzeN5OTk91Jr2cmVEcEiZ0OyaDMmLno75Xps8qdejNEU1aOroqNbdAjtLzrrNIjX2EdlHC0LgP1ykWZ1zLx/RPTUCdSUmPQqpPZScdipZ3CqcEzSScc38Z++EGcdhw0cpUgCtPFaSKGDh799ePJQg23SYW0ucEGhQB/vwzdapKHHawcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmQ4k/fsyIGVD1N7jflDRc3dnImvk8e6waeVA8T0JXg=;
 b=YdHOKVhOx8uaFs1Pv68DMp6EAybwDYpT+LjBF3fN43IzwmXwwhp0vy0e1bgI2WjJ8KjB5K3NAwol3sANPdrUmNsrUZLl5C4qAePwL/VR1ZgKUGmtv2VtEsPBVPqUj/QBZlbQAvaSXaInkJ87zRNjSNz/xUud3DdkYXg/EdIy6JU=
Received: from CO2PR18CA0046.namprd18.prod.outlook.com (2603:10b6:104:2::14)
 by BYAPR12MB3335.namprd12.prod.outlook.com (2603:10b6:a03:dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Thu, 16 Jun
 2022 01:56:27 +0000
Received: from CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:2:cafe::e0) by CO2PR18CA0046.outlook.office365.com
 (2603:10b6:104:2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.15 via Frontend
 Transport; Thu, 16 Jun 2022 01:56:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT025.mail.protection.outlook.com (10.13.175.232) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Thu, 16 Jun 2022 01:56:26 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 15 Jun
 2022 20:55:56 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 4/7] iommu/amd: Introduce function to check and enable SNP
Date: Wed, 15 Jun 2022 20:55:38 -0500
Message-ID: <20220616015541.11207-5-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
References: <20220616015541.11207-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3988cd4-5bd6-4117-dddf-08da4f3b6c73
X-MS-TrafficTypeDiagnostic: BYAPR12MB3335:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB33350951A510E1363F98A184F3AC9@BYAPR12MB3335.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxwwgy8CbB76vKq+mtPhkTAVPqLurenoD4mOIGh/RGDpBzEGPUDwJCmSRe6UyvMdaqt/oEhBEGRcPUW1bi86O0w6/XU1Amc0mOo2sIoW/VznGGUSfTkswD4VLhqzBvrV1BdNymQ+L6ojjn9lDFBdxr4LrHfNGbMQeYSBJwwgyGoTvWeNMaA9mkLgGpv5udU6sI+quSsLSZlLQffD0036qM1Qfqo2tkXrtbwJk2PbT2wRt38aSWmRQFk5GUgJX+29i60hV/cNUyAAeRJUD7+mN/Pum4hObHIcNgCozV6UAhPedAhYBeHZPy3T16PDMACG4yBijrmpBVcgIbrUUxOJiTonk2PxEZ7Mpg2aShuQMP/i7cO82aXrT1wlmsYwyMYd+Kv8P/xd6sQkLHpW/H/wsrktcTWLxbL8r6+XKnCN5ED9MfXv1rNmx3NVILY2aFOqZsgQAq95JPQgV3GJV+xIHWYgd6OWBW/PNETwPhDVKf5fbK//KTGMnaYIoKh+bK+3kVh2h3pJoHi5CSd4oB4IpJ04x8fI9N3L+cS06+LEd14Z5LUZTYiGPkL4VYOkaQaiIOmaYH1J5G/hhMBTEnGRolDYRfhXgoHH/NjLRMHUA6+ADEZNzGUMFirpFkb6d+C2fInoLJ6jJkxqHmyFOrX9JU/Zw6B+KHwjfJzLGFUF25G8kwmCQDagciKPDlK/TFXN/dskbdGL+da2N/4GDtUv3w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(7696005)(6666004)(47076005)(2906002)(70586007)(426003)(54906003)(83380400001)(316002)(40460700003)(36756003)(86362001)(336012)(82310400005)(5660300002)(70206006)(8936002)(81166007)(356005)(26005)(508600001)(186003)(2616005)(16526019)(36860700001)(1076003)(44832011)(4326008)(6916009)(8676002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 01:56:26.5669 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3988cd4-5bd6-4117-dddf-08da4f3b6c73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT025.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3335
Cc: thomas.lendacky@amd.com, ashish.kalra@amd.com,
 Brijesh Singh <brijesh.singh@amd.com>, vasant.hegde@amd.com,
 robin.murphy@arm.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Suravee Suthikulpanit via iommu <iommu@lists.linux-foundation.org>
Reply-To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

From: Brijesh Singh <brijesh.singh@amd.com>

To support SNP, IOMMU needs to be enabled, and prohibits IOMMU
configurations where DTE[Mode]=0, which means it cannot be supported with
IOMMU passthrough domain (a.k.a IOMMU_DOMAIN_IDENTITY),
and when AMD IOMMU driver is configured to not use the IOMMU host (v1) page
table. Otherwise, RMP table initialization could cause the system to crash.

The request to enable SNP support in IOMMU must be done before PCI
initialization state of the IOMMU driver because enabling SNP affects
how IOMMU driver sets up IOMMU data structures (i.e. DTE).

Unlike other IOMMU features, SNP feature does not have an enable bit in
the IOMMU control register. Instead, the IOMMU driver introduces
an amd_iommu_snp_en variable to track enabling state of SNP.

Introduce amd_iommu_snp_enable() for other drivers to request enabling
the SNP support in IOMMU, which checks all prerequisites and determines
if the feature can be safely enabled.

Please see the IOMMU spec section 2.12 for further details.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 ++++
 drivers/iommu/amd/init.c            | 45 +++++++++++++++++++++++++++--
 drivers/iommu/amd/iommu.c           |  4 +--
 include/linux/amd-iommu.h           |  6 ++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 73b729be7410..ce4db2835b36 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -463,6 +463,9 @@ extern bool amd_iommu_irq_remap;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* SNP is enabled on the system? */
+extern bool amd_iommu_snp_en;
+
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
 #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
@@ -1013,4 +1016,6 @@ extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
 #endif
 
+extern struct iommu_ops amd_iommu_ops;
+
 #endif /* _ASM_X86_AMD_IOMMU_TYPES_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 013c55e3c2f2..b5d3de327a5f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -95,8 +95,6 @@
  * out of it.
  */
 
-extern const struct iommu_ops amd_iommu_ops;
-
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
  * or more ivhd_entrys.
@@ -168,6 +166,9 @@ static int amd_iommu_target_ivhd_type;
 
 static bool amd_iommu_snp_sup;
 
+bool amd_iommu_snp_en;
+EXPORT_SYMBOL(amd_iommu_snp_en);
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -3549,3 +3550,43 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+int amd_iommu_snp_enable(void)
+{
+	/*
+	 * The SNP support requires that IOMMU must be enabled, and is
+	 * not configured in the passthrough mode.
+	 */
+	if (no_iommu || iommu_default_passthrough()) {
+		pr_err("SNP: IOMMU is either disabled or configured in passthrough mode.\n");
+		return -EINVAL;
+	}
+
+	/*
+	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
+	 * affect how IOMMU driver sets up data structures and configures
+	 * IOMMU hardware.
+	 */
+	if (init_state > IOMMU_ENABLED) {
+		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
+		return -EINVAL;
+	}
+
+	amd_iommu_snp_en = amd_iommu_snp_sup;
+	if (!amd_iommu_snp_en)
+		return -EINVAL;
+
+	pr_info("SNP enabled\n");
+
+	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
+	if (amd_iommu_pgtable != AMD_IOMMU_V1) {
+		pr_warn("Force to using AMD IOMMU v1 page table due to SNP\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(amd_iommu_snp_enable);
+#endif
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 86045dc50a0f..0792cd618dba 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -71,7 +71,7 @@ LIST_HEAD(acpihid_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-const struct iommu_ops amd_iommu_ops;
+struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -2412,7 +2412,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-const struct iommu_ops amd_iommu_ops = {
+struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.probe_device = amd_iommu_probe_device,
diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
index 58e6c3806c09..d7bee7f09f92 100644
--- a/include/linux/amd-iommu.h
+++ b/include/linux/amd-iommu.h
@@ -206,4 +206,10 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn,
 		u64 *value);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+int amd_iommu_snp_enable(void);
+#else
+static inline int amd_iommu_snp_enable(void) { return -ENODEV; }
+#endif
+
 #endif /* _ASM_X86_AMD_IOMMU_H */
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
