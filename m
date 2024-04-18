Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C47615DBBB
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436609; cv=fail; b=BEQK2dG8UtPDC+F99qeG7Lsz0K4rtcvdjvtHsxViwl3v0CYO6AzT+1syAaME1U3RT8MY/8PpdiYyFJ/kCfyJm8K+7IenqzUwpDFjpe6/cBXwJd6mtyj6NO+a7ZBvGcmm7slBpRKpeWmSTvg9eLeSFWS/5iBJhybcAtXDUEJ8MOI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436609; c=relaxed/simple;
	bh=nSmmBa/l1P9jXiX1kD84zYSAtZwPUQV4P0GafCM8XJM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CY7AqmVcWlc6aquOHxtTD0pTnlsgwXhcavSW2U9vZxIxV/fZrYRjYkzrNpJva9raqP7aw/H+O1yRLVLPANdHGxzL1sxQSzSs1WodYJ2souLPAa/tXQuosZR/iBUZJrJ4wa4zIkosZZPIx7n32uimkW8OX5OFpUpycv7xU82/MJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Qxsy960z; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Qxsy960z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ib8QXKTuA8JZOYAcJtJdKpNaMJBabrgtJfdfyNYgorAiNl6HenvtjQAf1WHLYJVupf9LPsDK7RoEOV9xelH2XE0rsepjGNbGVRoyP2uGJb44q+um61HwGTyoWD6a3TTpXBI46uy8ArWyelazGIIxtzNBIJ4JLePWQeUMVYj6MEOIqLStJeuYN3ubT1plv6CcgxyaUGMhIwnvBzARLx1S3IiyayGGsZR06sXMWy2lbflyObJtuNQmH45JbCv0t16iM51M4YeHGQPjgpbFjnwF1VZw+OKk2YSytrMQszPTgTFBbxMzzgvNJlDsBTRw17/JnxXVmGGdt2ejpTCgp2leNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J9/T+vKesyDuj7E5+WMF8Wk00McdteNeMviDvSCaJgE=;
 b=HOWuudr2ateM6L5NKF/ZbUM46Nawa7qPxqOF5+wRDIFgVW045o9S3IdD+aykUbdBZIElgQMXwzKZAR/fikS6CTjEFianeqoGKOVCxMDW5++T47EoEqtf2ASdxNhs1NRTh5rP6AzgaRGYHnXx0uISOtp4mXhlSZllsKaypr5ZsouRWhwyUzSDXMUjxlwJLOPIupNwXW1Nr7FtEpjNdW93ze4SBzYJjGKrXZf54a7uRR8+ASEdqrVErt+ymEMperB3Es0ICMhy/HNrueJv3JC945oeKed40fU9gZqR2ZhiixlyiZXQOwikjyGF+9X9rI1zxyZ4JVwiE9CA3crHhhT6fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J9/T+vKesyDuj7E5+WMF8Wk00McdteNeMviDvSCaJgE=;
 b=Qxsy960zQvnc63cJHsLN/+n33v6Sj31KaU9AZKoHSjM9nHcsu1LYgR8h4b4GUWq+vKs19YJSbAKXn1xw8tCtYnZy36mOekkK85Dm+n87PgO9Z50ihH1WTYYhM7tXKZ4umoM7GGC3kNFEqJWq2JsGDJh4NByTvHPre6kGQ2X9MXo=
Received: from CH0PR13CA0044.namprd13.prod.outlook.com (2603:10b6:610:b2::19)
 by PH7PR12MB6442.namprd12.prod.outlook.com (2603:10b6:510:1fa::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Thu, 18 Apr
 2024 10:36:44 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:610:b2:cafe::4a) by CH0PR13CA0044.outlook.office365.com
 (2603:10b6:610:b2::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.11 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:43 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:36:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 09/15] iommu/amd: Define per-IOMMU iopf_queue
Date: Thu, 18 Apr 2024 10:33:54 +0000
Message-ID: <20240418103400.6229-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|PH7PR12MB6442:EE_
X-MS-Office365-Filtering-Correlation-Id: febcd40e-4f23-45db-f009-08dc5f937104
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HAhJWX40CF0zTIbyOU8MSh7SL6zZTpBFpUwUaLYbwsf1I3yfGmWYiTA5Uc1HHWrN9wailkB5nzb0lWbAAX0chGgZyyFqJDYzi4gdpfnRU3UfXj30j8FY5FBsYjWXhJ5xSt+T8iSNUlKj6Gu5sCiVg9uLmu2dIH9KtG4r090/Kvo90urm4HKs35GpcQjUR0RVky/lRy5flisMs8s65eH71EtWllSelUtPjwZJwbs+A5/UQrzW4zz04FIxG2OebUb4t7RTk0g0QcKUCJmEJBsqeJn9Asx5tdZYWJPZoWleYvRKfL3OKNsz/7N2GguNy8If60k+bSOnVmAf68BiVoqS25do4NLLkwyJxXp6v0SNMa8ekh8a1AAyhlcNEonF3jHMkD5lbx4IZ6tI85y4IEARf0aFkeb9Rojdc8TxrFDO6cHAUIvkdD0itHmtXf1C4zFZWf69w7L03JVlajghVJNl2aCN/yx1rJ8niur0JF9oDeI+951dO2IBYf1oG4F+yGxEqwuoLw79XuS2UIKYZG6EkshB4GgiHhLkcBPcOW+MdbN6qkG46Y611269ZHCdK/K/hdw+nkZMS7ra+vyQApdD4vuYPaN4TfgtXbrY9FvTGNpeswa/jO2FOjjGpn9ZmvvxQ8Yn00cMww/BGybmcu+rrzxeyNTkbmciTGiFQZF/CZP9eV6grRUBB4sA+bERfmGMdhf8uPkbvLEIz6TUPxD4s3FoGKQlOvVaOEOTsGumQBaJPqJgNsN+iafsaSZg8bAF
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:43.9966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: febcd40e-4f23-45db-f009-08dc5f937104
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6442

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
usage. And add amd_iommu_gt_ppr_supported() check before enabling PPR
log.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 ++++
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 18 +++++++++++++++--
 drivers/iommu/amd/ppr.c             | 31 +++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f8919c54d9ae..66bf20d4a91a 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,6 +46,10 @@ extern int amd_iommu_gpt_level;
 
 bool amd_iommu_pasid_supported(void);
 
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 03442e86ae44..1a014dca7c2e 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -762,6 +762,10 @@ struct amd_iommu {
 	/* DebugFS Info */
 	struct dentry *debugfs;
 #endif
+
+	/* IOPF support */
+	struct iopf_queue *iopf_queue;
+	unsigned char iopfq_name[32];
 };
 
 static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 269446717818..7f9b5c710058 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1639,6 +1639,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2108,6 +2109,16 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
 	if (ret)
 		return ret;
 
+	/*
+	 * Allocate per IOMMU IOPF queue here so that in attach device path,
+	 * PRI capable device can be added to IOPF queue
+	 */
+	if (amd_iommu_gt_ppr_supported()) {
+		ret = amd_iommu_iopf_init(iommu);
+		if (ret)
+			return ret;
+	}
+
 	iommu_device_register(&iommu->iommu, &amd_iommu_ops, NULL);
 
 	return pci_enable_device(iommu->dev);
@@ -2793,10 +2804,13 @@ static void early_enable_iommus(void)
 	}
 }
 
-static void enable_iommus_v2(void)
+static void enable_iommus_ppr(void)
 {
 	struct amd_iommu *iommu;
 
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
 	for_each_iommu(iommu)
 		amd_iommu_enable_ppr_log(iommu);
 }
@@ -3134,7 +3148,7 @@ static int amd_iommu_enable_interrupts(void)
 	 * PPR and GA log interrupt for all IOMMUs.
 	 */
 	enable_iommus_vapic();
-	enable_iommus_v2();
+	enable_iommus_ppr();
 
 out:
 	return ret;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 65db1745f40c..d4e08800beac 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -108,3 +108,34 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		/* TODO: PPR Handler will be added when we add IOPF support */
 	}
 }
+
+/**************************************************************
+ *
+ * IOPF handling stuff
+ */
+
+/* Setup per-IOMMU IOPF queue if not exist. */
+int amd_iommu_iopf_init(struct amd_iommu *iommu)
+{
+	int ret = 0;
+
+	if (iommu->iopf_queue)
+		return ret;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "amdiommu-%#x-iopfq",
+		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
+
+	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iommu->iopf_queue)
+		ret = -ENOMEM;
+
+	return ret;
+}
+
+/* Destroy per-IOMMU IOPF queue if no longer needed. */
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
+{
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+}
-- 
2.31.1

