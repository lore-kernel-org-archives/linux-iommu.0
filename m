Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CC417548
	for <iommu@lists.linux.dev>; Mon, 11 Mar 2024 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710148299; cv=fail; b=WZltE09NIcHrKYUjx3LQx4xGnW4Dy3kSjQmkQAWnWOWq4WzrveEqqFi989I7jv6JFAgj8RApkyH3sWJhDdu4tj4jFf9IPixTgOZapjDtGKB5eKmddihFfr16734aOP4fSebrWDalWO/vhmvMWs/kqOdUKZzQHmt7czGZofxgT7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710148299; c=relaxed/simple;
	bh=eGuANhrkMETHFSpMzclmrpmkZsYZmT9BPOT3Fs+huWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jQ21oWTRH2vhLGst9gD1reYcoZrlyq9ccuIXhNFht+I2fRafcfQOAAhpLzg6cIUiULfO7L/khrYNgJ6JoSv82LRalhVgqTeuW+xWh0jnVAfCKdgoxEHrelAoq3Ez8NJ7i1zFcmhbb3uEsRas/WgfXsPOFrN9MQ7Mvh16LETQSkI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HWUSKsol; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HWUSKsol"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d6CrZuhLS8SwDJV9F9kqhUhYHSwpThE+2Hmb6fRqWlV71yNnpSdILo3+sIZglnVU1jNM+VINVQrBvVeSRLtSNRyF5XQXgAYzDXrv9wQN6LCZvxJA8CmsqRwCbDU9zX++11fMNMpamnFEsdeR6ioMvF044fA/8Av8X/oBeoBiSwBnqUviekP1WIhhC8fhAvPrQFpsN9Wg0j6Z4RBHehcEnlgjHw4oCDj5i+eEkh7lmRxxARqpy9s2u00pWNrIHU6+0SrKZ1kkWShK19OT+91AF92egNJpYnsiqUJleBBH0paGbXNMupd4ViyQlRyJtbWPpXpU8p6rPrniLyDMro41Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zAkbkqcs1u4z/nuWHeU7y5W3b6VwyyD5AsxjdNYmH5g=;
 b=Tc5HERCHzwqx7YpyKBUnpK5hx8n4sW+oE1/E7YEerSH/wK9H/CFpW9TOk/TKS82GLnNpJ6phlpabSL73ZJlGWDUav66AWYPZSHGfqg2WqNgBe11sB/LZt9OCIuwjbLAvrgogY21WNPksVuCDMhlxm9ytzmf5RDP+guRA4QCNw3zgVEFwpclRxGJDdBQ3HYj0L3tNsE1zhofREl7iQI6ZYMDHgpmW2SQLQux5yX346ZLMtXUFM4UWS0gKEKb9WdM9KuKzMltBl5PD7+u99IkFPybq5vHc/b47yIHA6FRivhEjyX1vzEhOTHkSCsiHg/5kFiuN0dRo+0OerCy9XYT/sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zAkbkqcs1u4z/nuWHeU7y5W3b6VwyyD5AsxjdNYmH5g=;
 b=HWUSKsolTQieeKkkJZ2csKeznwKLUr6XkdoNJXk/ZSiKDv152Na6dMAT2/yUWjgyJPX5pCY7itzVjZ4fyG0ZzHMYQREhi5lnQDiws4Ey/jdSAEsQgMVUVssvMvIfGFjh9uutn2sPuAKsbE8gk/x+iC9XBRPADXI6cW0WdOZQoiE=
Received: from MN2PR07CA0022.namprd07.prod.outlook.com (2603:10b6:208:1a0::32)
 by DM6PR12MB4386.namprd12.prod.outlook.com (2603:10b6:5:28f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35; Mon, 11 Mar
 2024 09:11:33 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::32) by MN2PR07CA0022.outlook.office365.com
 (2603:10b6:208:1a0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.35 via Frontend
 Transport; Mon, 11 Mar 2024 09:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7386.12 via Frontend Transport; Mon, 11 Mar 2024 09:11:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 11 Mar
 2024 04:11:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 09/15] iommu/amd: Define per-IOMMU iopf_queue
Date: Mon, 11 Mar 2024 09:08:37 +0000
Message-ID: <20240311090843.133455-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240311090843.133455-1-vasant.hegde@amd.com>
References: <20240311090843.133455-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|DM6PR12MB4386:EE_
X-MS-Office365-Filtering-Correlation-Id: 924a5b87-f615-42c6-8c80-08dc41ab3ef3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AhabgfEU+uVHJe3tMmBSJU/16tLiy3OrykXgiw2c3+BPBO9T33sSyxDSM+kRklvbSVmrScY2sZ3YyzNJn4IYxCUbrOTtUe29CXTDIs20MZrh1dianzb9I1vHDmn87m+ZXfG5CJxGfSlNRedMWZo/xXRv9SO0CdC6q99taQplPh2UZAXRl2WZz91EUPsBv/YrI/YaUMvpEPdW5GGBLEoSjMqbdUQso1JQQ0PV9OnRuAfRXkaKP5wKgx0NZ99PiyL2iiJ6yFIxlJpBztbJO+OFiT0bK0O1q7/cTLmq7RXMzQ2HXtkn/6TkGdSPXRzLhbbQVxoJelmdLFdEQ3+4DCmFDwPpDgpmUxpPoLeRcPZFNzVZJ3PumdPHiSalJrVJRHu3PqYaKtaj9ojxRE9i85vjIB8o9rmozabLThjxB4dzpG81ArxaUq/QOnS0/hNEaZHd3AsjCZhdSWtk3WdWwErntN6rON5L+t+752M5DL6Ic71LPLaNhvjx8IhBzfvIk6GZqo5MbEJ46pzs89T562Ed6xVKPJ1Kt1jc8i87ZsWq8BoMgfqgenC5pQrGke5lMWOS6ZVYc3g0Vdrn1hVPI6b/6jdc6zv2vpMgYc48vatuI4hGbPJXVGztq68YEgHIT8GnHjdBdxWUbA6fxK4AjyNv8EjObwTfjtyj673FJIYWJn1jrxmDvc48vmzNinW8kJN3AEFaSavQHiapTcd4nbBkzbJALh+yACWlnrPqJakpuHaVraUwvNMZochejh4qgRK8
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2024 09:11:33.0660
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 924a5b87-f615-42c6-8c80-08dc41ab3ef3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4386

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
index d39141f81229..264fea716567 100644
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
index 47bcf18ba2c3..c1f61120974f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2107,6 +2108,16 @@ static int __init iommu_init_pci(struct amd_iommu *iommu)
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
@@ -2792,10 +2803,13 @@ static void early_enable_iommus(void)
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
@@ -3133,7 +3147,7 @@ static int amd_iommu_enable_interrupts(void)
 	 * PPR and GA log interrupt for all IOMMUs.
 	 */
 	enable_iommus_vapic();
-	enable_iommus_v2();
+	enable_iommus_ppr();
 
 out:
 	return ret;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index d43a616c0c36..39ea979c7134 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -106,3 +106,34 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
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

