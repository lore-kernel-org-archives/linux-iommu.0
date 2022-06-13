Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92C0ECCA473
	for <iommu@archiver.kernel.org>; Mon, 13 Jun 2022 01:25:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 45DBE60EFF;
	Mon, 13 Jun 2022 01:25:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OsVh8DW4-Ugz; Mon, 13 Jun 2022 01:25:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id EB17860E9C;
	Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ED94C002D;
	Mon, 13 Jun 2022 01:25:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A0D06C0039
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0B0AA60E9C
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KGizXtx_Z29q for <iommu@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 01:25:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2060c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::60c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 0C9F160EA3
 for <iommu@lists.linux-foundation.org>; Mon, 13 Jun 2022 01:25:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eg5jiYNI0rX82SwVHG+g29R4lIrCy9UfmcwHPXlzaEca+5k8j5AoM5ZzNtQ0h0EU4/lRdKBOEGrx+pQZpMbDNEogG2BH8rln6fEK4YMzS5eiXFi0pTrUENlUwRkPluNu5IbvbJDOxJ6m5xRcy9bHrrLrSXw7EKLOmmpTLs7u/RSNPV2Mw5sD6eoQUphf8PDoHA/95pywl7ljJmBoyqOFQF0Eql5jjhTuOM9xJGOGoQKrGgy53o+76sX109m/xRk81r1CQimqVXlAcNxybePYFqanszRp3k4ehqE1kzYlRmJB4S4YEgqxrjCsKrQZbjD4andHUdnXuYoJdOevv7xhUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pAhvqGo2Kes4iT3YKl+cF+llkww7E1GKR7rELSB//eE=;
 b=AYHxO6Gy49R4bToNd5SHYehLl9nbuAyMKb/tm2OsWRLKjy+UvvNoMn4sBJ1C+v2gwbs+AnZkmr0WG8r4nK9G83v8rW1hKV+uKPdQO1pFKerROvqplKB0gI8iroqfvB3F+FvRLRZLJm3IF34QtAbezRuGaUabqsbDvSNyKPsdgbXbEgcJndA6XG9ThTIvzAXNxd24rCCEHqmx7Pg0odZ62UJov6M/bDJKTAhPXHn/tGbgt3G2NmkCNbjHDoxjjLrEMMaXMUrU9sqbK4seGmOFAXAmM72EYVweSUniYqs+tF/qkr7Z3R+nWRJoryPwwy3HCPj7ekA7jBhcWmqXLGsBTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pAhvqGo2Kes4iT3YKl+cF+llkww7E1GKR7rELSB//eE=;
 b=B6wpVZKDwMy28j3w+PdnJJwrhFyII3ER4tTcBvAS314fvA9Y9xZi4l6bllsl8u74W6QFXFSrdBldU8NEXog2fWugFeQh2JL4rdOIGEDtO02+ckncG8ZhFJhDmIc3IWWg+We/rsKDCrsNOR8uGfyfTsklaImVS1fxlgBQZGOy+4Y=
Received: from CO2PR04CA0004.namprd04.prod.outlook.com (2603:10b6:102:1::14)
 by DM4PR12MB5327.namprd12.prod.outlook.com (2603:10b6:5:39e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.14; Mon, 13 Jun
 2022 01:25:31 +0000
Received: from CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
 (2603:10b6:102:1:cafe::8c) by CO2PR04CA0004.outlook.office365.com
 (2603:10b6:102:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12 via Frontend
 Transport; Mon, 13 Jun 2022 01:25:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT028.mail.protection.outlook.com (10.13.175.214) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Mon, 13 Jun 2022 01:25:30 +0000
Received: from sp5-759chost.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Sun, 12 Jun
 2022 20:25:20 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH 3/7] iommu/amd: Introduce function to check SEV-SNP support
Date: Sun, 12 Jun 2022 20:24:58 -0500
Message-ID: <20220613012502.109918-4-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
References: <20220613012502.109918-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a14601c1-1fdb-4228-2d3f-08da4cdb9b19
X-MS-TrafficTypeDiagnostic: DM4PR12MB5327:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5327676DF95B29B1C0A9F2DDF3AB9@DM4PR12MB5327.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DZKpMrv68HyMzeJZkj7Yvw/6QGACDcKbETPLidudKlRCgP2W+EEEPPeSGFgZdmgVtMsjoJraTt8nMmS557epnVMq1xOFB2+Dsgd4riHIkG5DhnoHoshpaQcX/z6+j86l0LnzGKqrj2fiYYVKKpl4aNXc2YYwXodlUTu34c5Wg79m7YpbqEtQccRUG+xgsMklC+IaVRhjjigNID06Hv+Ykp6PheeruoNSra+gZCSfVLhRkHyYiJqW7U+RuVjzEyB4Ldx0mRpw7y23Eaai0S51oZ9ANRTOGl9adwTft2Lta05EQ5bi9B7ymJs1PXfbOiJoy/7WOxUb4pdLMmzHsGk/ZfWlBVWW++qh2TzHPWNXyTaKgje42nePNs0UnfJPAA9yKLNWiwXg9aLLsSKkr6LOdut6WdEyxCJBtKG/a01E/lLwzpX4F/91ZMaQpDHyzE1YUAWh3hFD0/1WTXYiu322IxU7oZE3QK9/v4gIhHAx0AeJvs1umh9gmLgRxPYPQmp827Mp0IxaSEmdJKrIShGZ1KaEFcTqzEIjKyCWeskwlcGZZ6CpJezWwHSacrViG+KSP3U7M+1rMimDTI0phMkSkbTDGTRenIGdYkKn8ei3Z0A2fk29N65QWTOL8QrYD+hdgZm+Ckwu3pbPQloZzY1Kyzcn+oMo3q8ho22g8hgi+YeWEBNEKupwVjS6OHTpOtI7t2Q51MMFklkGGB620hkIuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(40470700004)(36840700001)(46966006)(44832011)(6666004)(426003)(47076005)(336012)(2906002)(40460700003)(508600001)(1076003)(186003)(2616005)(86362001)(8936002)(16526019)(7696005)(5660300002)(26005)(82310400005)(36860700001)(356005)(36756003)(54906003)(81166007)(70586007)(70206006)(6916009)(8676002)(4326008)(83380400001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 01:25:30.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a14601c1-1fdb-4228-2d3f-08da4cdb9b19
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT028.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5327
Cc: ashish.kalra@amd.com, Brijesh Singh <brijesh.singh@amd.com>,
 vasant.hegde@amd.com, Ashish Kalra <Vashish.kalra@amd.com>,
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

The SEV-SNP support requires that IOMMU must to enabled. It also prohibits
IOMMU configurations where DTE[Mode]=0, which means the SEV-SNP feature is
not supported with IOMMU passthrough domain (a.k.a IOMMU_DOMAIN_IDENTITY),
or when AMD IOMMU driver is configured to not use the IOMMU host (v1) page
table.

Otherwise, the SNP_INIT command (used for initializing firmware) will fail.

Unlike other IOMMU features, SNP feature does not have an enable bit in
the IOMMU control register. Instead, the feature is considered enabled
when SNP_INIT command is executed, which is done by a separte driver.

Introduce iommu_sev_snp_supported() for checking if IOMMU supports
the SEV-SNP feature, and an amd_iommu_snp_en global variable to keep track
of SNP enable status.

Please see the IOMMU spec section 2.12 for further details.

Tested-by: Ashish Kalra <Vashish.kalra@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++++
 drivers/iommu/amd/init.c            | 39 ++++++++++++++++++++++-------
 drivers/iommu/amd/iommu.c           |  4 +--
 include/linux/iommu.h               |  9 +++++++
 4 files changed, 52 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 328572cf6fa5..6552c0da8f32 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -450,6 +450,9 @@ extern bool amd_iommu_irq_remap;
 /* kmem_cache to get tables with 128 byte alignement */
 extern struct kmem_cache *amd_iommu_irq_cache;
 
+/* SNP is enabled on the system? */
+extern bool amd_iommu_snp_en;
+
 #define PCI_SBDF_TO_SEGID(sbdf)		(((sbdf) >> 16) & 0xffff)
 #define PCI_SBDF_TO_DEVID(sbdf)		((sbdf) & 0xffff)
 #define PCI_SEG_DEVID_TO_SBDF(seg, devid)	((((u32)(seg) & 0xffff) << 16) | \
@@ -999,4 +1002,12 @@ extern struct amd_irte_ops irte_32_ops;
 extern struct amd_irte_ops irte_128_ops;
 #endif
 
+/*
+ * ACPI table definitions
+ *
+ * These data structures are laid over the table to parse the important values
+ * out of it.
+ */
+extern struct iommu_ops amd_iommu_ops;
+
 #endif /* _ASM_X86_AMD_IOMMU_TYPES_H */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 3965bd3f4f67..da32e7bdd1fa 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -88,15 +88,6 @@
 #define IVRS_GET_SBDF_ID(seg, bus, dev, fd)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
 						 | ((dev & 0x1f) << 3) | (fn & 0x7))
 
-/*
- * ACPI table definitions
- *
- * These data structures are laid over the table to parse the important values
- * out of it.
- */
-
-extern const struct iommu_ops amd_iommu_ops;
-
 /*
  * structure describing one IOMMU in the ACPI table. Typically followed by one
  * or more ivhd_entrys.
@@ -166,6 +157,9 @@ static int amd_iommu_target_ivhd_type;
 
 static bool amd_iommu_snp_sup;
 
+bool amd_iommu_snp_en;
+EXPORT_SYMBOL(amd_iommu_snp_en);
+
 LIST_HEAD(amd_iommu_pci_seg_list);	/* list of all PCI segments */
 LIST_HEAD(amd_iommu_list);		/* list of all AMD IOMMUs in the
 					   system */
@@ -3543,3 +3537,30 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr, u8 fxn, u64
 
 	return iommu_pc_get_set_reg(iommu, bank, cntr, fxn, value, true);
 }
+
+bool iommu_sev_snp_supported(void)
+{
+	/*
+	 * The SEV-SNP support requires that IOMMU must be enabled, and is
+	 * not configured in the passthrough mode.
+	 */
+	if (no_iommu || iommu_default_passthrough()) {
+		pr_err("SEV-SNP: IOMMU is either disabled or configured in passthrough mode.\n");
+		return false;
+	}
+
+	amd_iommu_snp_en = amd_iommu_snp_sup;
+	if (amd_iommu_snp_en)
+		pr_info("SNP enabled\n");
+
+	/* Enforce IOMMU v1 pagetable when SNP is enabled. */
+	if ((amd_iommu_pgtable != AMD_IOMMU_V1) &&
+	     amd_iommu_snp_en) {
+		pr_info("Force to using AMD IOMMU v1 page table due to SNP\n");
+		amd_iommu_pgtable = AMD_IOMMU_V1;
+		amd_iommu_ops.pgsize_bitmap = AMD_IOMMU_PGSIZES;
+	}
+
+	return amd_iommu_snp_en;
+}
+EXPORT_SYMBOL_GPL(iommu_sev_snp_supported);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 3e1f0fa42ec3..b9dc0d4b6d77 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -70,7 +70,7 @@ LIST_HEAD(acpihid_map);
  * Domain for untranslated devices - only allocated
  * if iommu=pt passed on kernel cmd line.
  */
-const struct iommu_ops amd_iommu_ops;
+struct iommu_ops amd_iommu_ops;
 
 static ATOMIC_NOTIFIER_HEAD(ppr_notifier);
 int amd_iommu_max_glx_val = -1;
@@ -2368,7 +2368,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
 	return 0;
 }
 
-const struct iommu_ops amd_iommu_ops = {
+struct iommu_ops amd_iommu_ops = {
 	.capable = amd_iommu_capable,
 	.domain_alloc = amd_iommu_domain_alloc,
 	.probe_device = amd_iommu_probe_device,
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 9208eca4b0d1..fecb72e1b11b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -675,6 +675,12 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev,
 void iommu_sva_unbind_device(struct iommu_sva *handle);
 u32 iommu_sva_get_pasid(struct iommu_sva *handle);
 
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+bool iommu_sev_snp_supported(void);
+#else
+static inline bool iommu_sev_snp_supported(void) { return false; }
+#endif
+
 #else /* CONFIG_IOMMU_API */
 
 struct iommu_ops {};
@@ -1031,6 +1037,9 @@ static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
 	return NULL;
 }
+
+static inline bool iommu_sev_snp_supported(void) { return false; }
+
 #endif /* CONFIG_IOMMU_API */
 
 /**
-- 
2.32.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
