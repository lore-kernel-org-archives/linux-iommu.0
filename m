Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B4A3C4B79
	for <iommu@lists.linux.dev>; Fri, 11 Sep 2026 10:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123425; cv=fail; b=fKqwdyaJnzWYL690aV0b8XABEgKdyLiIIUH4dBRX4hkPJ18c5hl3bUZ31LWAL2fE/KJCA8a3YNM9LM3fW7zx193dpQAwSVSHu9QL4n0oYCZw4W7vX3FjpxJRtSzkNo2fzVuSBNX729dcOXSBBFgsOs122soXplMNyqjrGQcCrHo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123425; c=relaxed/simple;
	bh=xsb9uWIUQ35pmPTupyOYi1MQUUNcV6EYM0pXVrGDA8Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=scj2sOnRrzWgIhlOMcTtj1g/ORCJRteltNysb9IVj+yvi440ez5O607g4mpOWBb+yUKJAPvu2G4hXoRtNLQV2OMSN/95mzml1XfoIb0Ze3EpDZVw0eV5TAHt6u2zX3hTxd1f9QqJYK/4m7/irVMu3m0Nbm6rYectgQLhY+W8AXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eyILr3Nu; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eyILr3Nu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScdWzKVJQ02TnPFq7kz08ELrGcuFtUcFY6Uu5dppPZZjRRKpYIC7eFn52+V8NvmfZpEsJshmP0KeNH6yA7u1VvIqsa0wt4wEZyuVN0yxTq7oit5Fw9v6SeWOi8pdMkewO79CxWq0k8FsWW46vqQKnCb3cdCJ0utCwPuF4n3K4ug4JR17hzBjR8L6g/a1laEOP69/0gEiO9VmsIeDgQyQbyH4waVp6MVehOAKEIKIOEhUZLhS2+8qDDnr/N1D3lZSNFNpGWj3t312EVqjeGh+Khncn82B2fehy48MdHx7By12C4VtDF3ZjN+0S1MPACZ4qp8RVSu/VGvUudE5V6BjRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VuqidPT/zQ5edpjb+4iJfHCKHlC1iyJreAhcKLsUBU0=;
 b=r+4X207Lblh3kfrZJ3rvz1hfZIuEHtAii4MEGHSjWXzsJ9Z9gVxRPqmYROrwuEfzFXjQZp4Am3A95zZYYOTLF7jBArSvQlXm0izcGPMWugkq82tUDd0bWYyzD6WwewVzcFUgs0q9lJIR1uxZvVr3MXz2LmF3BdjKtb2MmihLmD41EvHX+hLfcNluv+eYQ+BebDMFZkZs8NybF3W3yETy+a4fALE57fzDrbfuuwpUEZw+cZ0ph+EKMtXAJPdPxt7xXi+BqGmxbTeme8yM9vQGJkA90pFG/Oa+MNG4EtiChfXL+us280gXadPr3hkanKgpiraO7EHRruTTCxAYnhwJlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VuqidPT/zQ5edpjb+4iJfHCKHlC1iyJreAhcKLsUBU0=;
 b=eyILr3NudK4/lUDCsFiIHU9NEWTbpMrmrW9p5M8/XuXZbcPfFFDcvsfvFO5Sa+vyaTDL8qIzkdPhLLR4qX87meStNKJM6WkCVL8Hbp6ccS2OGeJ16q3wNUUBUXI1ZVjOmQ2yrbj1ALwCW8zt9g454TSThkEospJ2/KXD7CU06M0=
Received: from BL1PR13CA0008.namprd13.prod.outlook.com (2603:10b6:208:256::13)
 by CY8PR12MB8216.namprd12.prod.outlook.com (2603:10b6:930:78::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.10; Fri, 11 Sep
 2026 10:43:37 +0000
Received: from BN7PEPF000000A3.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::9a) by BL1PR13CA0008.outlook.office365.com
 (2603:10b6:208:256::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.7 via Frontend Transport; Fri, 11
 Sep 2026 10:43:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN7PEPF000000A3.mail.protection.outlook.com (10.167.248.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 10:43:36 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 11 Sep
 2026 05:43:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH] iommu/amd: Move GA log allocation to init
Date: Fri, 11 Sep 2026 10:43:17 +0000
Message-ID: <20260911104317.5183-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb08.amd.com
 (10.181.42.217)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A3:EE_|CY8PR12MB8216:EE_
X-MS-Office365-Filtering-Correlation-Id: e786bc60-8448-4f4c-ede0-08df0ff188d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|10067099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	feJPOGKJbbcrf4m//HUaKr/33KFsAzt02yviunHW2o87MpM7pkX4if33Ik3X5k4w2Q8mGZsjDxrSxhNLAiJoXM7qqhZxZWQpKrGXPKbTUee5+t5jY1ufXrTwlCfs/O32ZLKhykIY/jRUazOwMve0ktDmwjtHzMaRvgknCSwMb9OF4zAQwW0TFzk6ccx4mc+BMZNFSLlSm9oNQE2pjoSpsucVUgx+hw0aTEVr7GcFfw/4Nnff4ozJSd/yrOfC4/FGvhQ3a2bwXvdsXt0BX4sRAKCSC4hPKj+AvozRKNaiC6PJZMvkWl25BEk28qTegNnrRBm4nnPylV1nXKk4zqO7wFdXETfGmeUyoCDsoLXAdKS0H+4uEIQl8QB9lOzbFpevDBgeF/J1vcr2Jxrbt70TL+3EA5TnFITvrHVT9gtdVOIFFpXPhdf0wk9ZlT5pMiM+9OB0ljDhNjY4Eprsj3GmlFwbqf9Jee0/3BYprsPGTjfupAEFX8FrbaAFj340NlNwgBbdh1GjLNKaErG9uSCaKKxDjMo3DOU44XZiT4EF1t7cITe3lAGF49EOsmYNfhgg+v7R7C2r71JprsNUiVUpBecE16HcFWopEued42YJ0X1ndMIO65L1GvRYUAug4gDsbCgqLfVvQqHs6mOo2RZbXzKWB/dXgbTk1c59TpS+aLR0TbV6R0jiFhnqu3KTme/Xzny4YAUWX1MTWDDchzWhjQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(10067099003)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zbWU/Q3X8b64Na6DhnpClOMLwEA0JvQZqoAIZBR1co92f3gtEEafVN6c/0n02l2t3hlD1bepgMznkF7JB8Z/hjbaO5zx4XBXz3ZRPYBgiIFMC3gLhkoMbRIljCHkv+uN0F+m8enqOMDiqGSOOZqx5zRKoKXzRUGuDW3hpZhGqBIEZqqEaj+XZyctVISjuENoS6s8uh09aE3EdKR1GxsIm+Djungve/8dRoPHHp2b+fYaedLpFMbj4PHIo9Clo8qmRq8WcbDARN33lLtN6Atb7JdpQWb45G2hKSNjxZ3YwwSxVdJzbH0RXSm7Bz0EOugZoXsDlGh8DGnd7UbBUwyLAQwLEs89EtjRbN7X3OEnUoigxKOpFMz+vsIH+JoMB5qkxcLLuXY55FTu1KJSScTBtpP9ZZ2rn+wYuZ04+rmpN6xOaRYXOcLwmWXsfoVUjOWh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 10:43:36.6857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e786bc60-8448-4f4c-ede0-08df0ff188d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8216

Currently GA log buffer allocation is done at the time of enabling ga
log. This mixes capability checking, resource allocation, and hardware
enablement into a single late stage code path.

Move capability checking and buffer allocation to init path:
  - check_vapic_support(): Checks AVIC support

  - alloc_ga_log(): Rename iommu_init_ga_log() as alloc_ga_log(). It will
    allocate the GA log and GA log tail buffers for a given IOMMU. Remove
    redundant checks inside alloc_ga_log().

  - enable_iommus_vapic() is simplified - it handles enabling GA log and
    GAM/SNPAVIC support for IOMMUs.

Finally update iommu_ga_log_enable() return value from int to bool as
return value is used in boolean context only.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---

Base commit: adbd8a08208 from iommu/fixes branch.

-Vasant

 drivers/iommu/amd/init.c | 74 +++++++++++++++++++++++-----------------
 1 file changed, 42 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 8a410d4aa370..3c72701d2306 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -916,13 +916,13 @@ static void free_ga_log(struct amd_iommu *iommu)
 }
 
 #ifdef CONFIG_IRQ_REMAP
-static int iommu_ga_log_enable(struct amd_iommu *iommu)
+static bool iommu_ga_log_enable(struct amd_iommu *iommu)
 {
 	u32 status, i;
 	u64 entry;
 
 	if (!iommu->ga_log)
-		return -EINVAL;
+		return false;
 
 	entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
 	memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
@@ -946,35 +946,31 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 	}
 
 	if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
-		return -EINVAL;
+		return false;
 
-	return 0;
+	return true;
 }
+#endif /* CONFIG_IRQ_REMAP */
 
-static int iommu_init_ga_log(struct amd_iommu *iommu)
+static int alloc_ga_log(struct amd_iommu *iommu)
 {
+#ifdef CONFIG_IRQ_REMAP
 	int nid = iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 
-	if (WARN_ON_ONCE(!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir)))
-		return -EINVAL;
-
-	if (iommu->ga_log && iommu->ga_log_tail)
-		return 0;
-
 	iommu->ga_log = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, GA_LOG_SIZE);
 	if (!iommu->ga_log)
-		goto err_out;
+		return -ENOMEM;
 
 	iommu->ga_log_tail = iommu_alloc_pages_node_sz(nid, GFP_KERNEL, 8);
-	if (!iommu->ga_log_tail)
-		goto err_out;
+	if (!iommu->ga_log_tail) {
+		iommu_free_pages(iommu->ga_log);
+		iommu->ga_log = NULL;
+		return -ENOMEM;
+	}
+#endif
 
 	return 0;
-err_out:
-	free_ga_log(iommu);
-	return -EINVAL;
 }
-#endif /* CONFIG_IRQ_REMAP */
 
 static int __init alloc_cwwb_sem(struct amd_iommu *iommu)
 {
@@ -2152,6 +2148,27 @@ static void __init late_iommu_features_init(struct amd_iommu *iommu)
 	}
 }
 
+/* Must be called after SNP support check is complete (iommu_snp_enable()) */
+static bool check_vapic_support(void)
+{
+	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
+		return false;
+
+	if (!check_feature(FEATURE_GAM_VAPIC)) {
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+		return false;
+	}
+
+	if (amd_iommu_snp_en &&
+	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
+		pr_warn("Force to disable Virtual APIC due to SNP\n");
+		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
+		return false;
+	}
+
+	return true;
+}
+
 static int __init iommu_init_pci(struct amd_iommu *iommu)
 {
 	int cap_ptr = iommu->cap_ptr;
@@ -2196,6 +2213,12 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (check_feature(FEATURE_PPR) && amd_iommu_alloc_ppr_log(iommu))
 		return -ENOMEM;
 
+	if (check_vapic_support()) {
+		ret = alloc_ga_log(iommu);
+		if (ret)
+			return ret;
+	}
+
 	if (iommu->cap & (1UL << IOMMU_CAP_NPCACHE)) {
 		pr_info("Using strict mode due to virtualization\n");
 		iommu_set_dma_strict();
@@ -3010,22 +3033,9 @@ static void enable_iommus_vapic(void)
 	if (!AMD_IOMMU_GUEST_IR_VAPIC(amd_iommu_guest_ir))
 		return;
 
-	if (!check_feature(FEATURE_GAM_VAPIC)) {
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-		return;
-	}
-
-	if (amd_iommu_snp_en &&
-	    !FEATURE_SNPAVICSUP_GAM(amd_iommu_efr2)) {
-		pr_warn("Force to disable Virtual APIC due to SNP\n");
-		amd_iommu_guest_ir = AMD_IOMMU_GUEST_IR_LEGACY_GA;
-		return;
-	}
-
 	/* Enabling GAM and SNPAVIC support */
 	for_each_iommu(iommu) {
-		if (iommu_init_ga_log(iommu) ||
-		    iommu_ga_log_enable(iommu))
+		if (!iommu_ga_log_enable(iommu))
 			return;
 
 		iommu_feature_enable(iommu, CONTROL_GAM_EN);
-- 
2.31.1

