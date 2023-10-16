Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADC208A7
	for <iommu@lists.linux.dev>; Mon, 16 Oct 2023 10:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Ydg9/tU2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a+QcgfcWY75d1z/OojUpwYJ5QszMKH1LL8+8anxlsCTwIGMjrSc6yEYLF0OF1SunSPPukzQm9YMtcqjqtVH98nJmDegEOAv6sNBzyF79aE12k/ienxvzRVmDrl7b3BR4NHQ+zSGA1MCmo/dLxz8ZvAQ8v2qwnaVH3+VXTpfVb4dYuhe9SbDkVuT5ubG0mJ4kvhukQ6rQWQByOwdpOiz58NeT69roRV4uMflwPv5WDZhheSEE30WDejk8GGZZMuDM2eFLtNkTIGubQjzjCzD6TDhHPt/hVOSwR1CHrwti1e33EMJPhRM4NUOK/jmp4d7mZ+c7u/uYVt8N3n6x2jAdEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=axUcD4PDC7gSUja7fWNq7FKTrm9X+DoBoz5lNMxqsEY=;
 b=RBKvfDI9w1ugqCkC4rpcbR3YqJILmPqgp4H/vTBhrYFxAwHrLisgJJDc/SF2UV6KOwo4VLSqO15oQvMyzpKVjEsERFMEtqGh/3qQG1QYalMbgYGmsxGNxv7Egj9T+S0EoEFLdEYKtlOGNtP1PJBi2JOema383OOi7cQHWFhHVX9CeuKWoJUgOsc5Lu5MBjPBhk9SfhQ8gj49wceNvZAbG+UWGeOs/Um5Rehq/lM8HDHFAWfFui6UQUG2I8JWuJvj4a7dlwqBKmHR4oogvll2YAkzf+AsoIkbv02n0cJc5VYrWlbPpOCE/RksYZ5M3o6iG4yemyOhcv/RvxlqfzpnhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=axUcD4PDC7gSUja7fWNq7FKTrm9X+DoBoz5lNMxqsEY=;
 b=Ydg9/tU2x7UOsjNivcC56q0Euym/wTdQNeXJQ4N9Hiw+/opLtpFVjif9Z2e96CpBYZGLFeVTADjXCYcgrSh58LwjrHrPdcfdZGKMegTD7zVePxDL3aAlqZTDd9USpGEvnyx01JQfRks8V8TawcuRL+x0HcqL7FTux+UCJ2Rhaeg=
Received: from BLAPR03CA0108.namprd03.prod.outlook.com (2603:10b6:208:32a::23)
 by SA3PR12MB9199.namprd12.prod.outlook.com (2603:10b6:806:398::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Mon, 16 Oct
 2023 10:48:02 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:208:32a:cafe::bd) by BLAPR03CA0108.outlook.office365.com
 (2603:10b6:208:32a::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Mon, 16 Oct 2023 10:48:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Mon, 16 Oct 2023 10:48:02 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 16 Oct
 2023 05:47:59 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 08/12] iommu/amd: Define per-IOMMU iopf_queue
Date: Mon, 16 Oct 2023 10:43:47 +0000
Message-ID: <20231016104351.5749-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231016104351.5749-1-vasant.hegde@amd.com>
References: <20231016104351.5749-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|SA3PR12MB9199:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b545470-86a1-4f03-028f-08dbce355eb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HJ7hp/nl/9mgy8WOt++b0Cl188fdLOZ9orjX0psXif9s1zT29SpJzKYhWrHI+87AwLISE9t+Ml6NGD3xBCtA6MKQoABYO+zdNlmdDSE9ScAmuwcnzVY4biEzm9YuMKd3TabojXRtmS1+hrc6bAl4zPhwePIsmVdC0LK9JkbysmoWAFSwRPataXwvZHnQORBoHGQR6Bbkrqlm3yOt9apvsMm6eFliOlJAIf9gqalkL1Hz3XgQmOLij3HgLHzztAxY7+YJQskjv+8vZs6m9XAxalEoahFZrdXT/mdGLH0166JaYevumQUa2ZioiB/qiWzDx5Ouc8aI6br9kCcNEWf3XzFWCVvpiGPMlpdhfkoRmsMwY6GqKUeLCle7ZhNfMzuW/GgsLNy3dwDgvlVAPkIDXceGRO6N3saoremaLXpsNkkrLYfeKwIPTeCU0g52AK8qnhnMVo/j8V/QO95vniFhdo4MQuBUDvfR/AswvFH/oqXQLbXdMC/bl4JQcCVU3FDtzg0kSq7YJD9388v6avPOfUk5ZtyA9HYeKjCYwRTgY6B6WKEvym3r6zgt80GQtPcVqETD38+S5MbT9gCYKOQg2bcd0exm/E+Tke231kEw3lljaXZU31GVpCcU/O1JqbpJQME8tVE2P0lpQ12nJcO5Sd+D4sbTuMt7PkkKANsk1LcUyn7o6MSCekxyQLtStctKgZMJ6717OO9uA1eVC/In8wEavPHRqjDLjT44a9bDiHTe7PeUasu1GaTeRgW6CGUtBR3Kuy90+HV6pqGmGy3eLA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(82310400011)(451199024)(64100799003)(46966006)(36840700001)(40470700004)(40460700003)(426003)(336012)(16526019)(26005)(1076003)(2616005)(36860700001)(83380400001)(47076005)(110136005)(54906003)(70206006)(8676002)(4326008)(70586007)(316002)(8936002)(41300700001)(6666004)(44832011)(5660300002)(478600001)(2906002)(7696005)(82740400003)(356005)(81166007)(36756003)(40480700001)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2023 10:48:02.0163
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b545470-86a1-4f03-028f-08dbce355eb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9199

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  4 +++
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            |  5 ++++
 drivers/iommu/amd/ppr.c             | 42 +++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 88a6a2321dd5..63ddfbde8d82 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -55,6 +55,10 @@ bool amd_iommu_pasid_supported(void);
 int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
 void amd_iommu_gcr3_uninit(struct iommu_dev_data *dev_data);
 
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 20961353460d..d55a564fbd50 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -773,6 +773,10 @@ struct amd_iommu {
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
index 05efab64c86a..80b4d3104b70 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2791,9 +2792,13 @@ static void enable_iommus_v2(void)
 {
 	struct amd_iommu *iommu;
 
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
 	for_each_iommu(iommu) {
 		amd_iommu_enable_ppr_log(iommu);
 		iommu_enable_gt(iommu);
+		amd_iommu_iopf_init(iommu);
 	}
 }
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 673fcc30f9dc..9816d7dbcbf0 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -110,3 +110,45 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 		tail = readl(iommu->mmio_base + MMIO_PPR_TAIL_OFFSET);
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
+	unsigned long flags;
+	int ret = 0;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (iommu->iopf_queue)
+		goto out;
+
+	snprintf(iommu->iopfq_name, sizeof(iommu->iopfq_name),
+		 "amdiommu-%#x-iopfq",
+		 PCI_SEG_DEVID_TO_SBDF(iommu->pci_seg->id, iommu->devid));
+
+	iommu->iopf_queue = iopf_queue_alloc(iommu->iopfq_name);
+	if (!iommu->iopf_queue)
+		ret = -ENOMEM;
+
+out:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/* Destroy per-IOMMU IOPF queue if no longer needed. */
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	iopf_queue_free(iommu->iopf_queue);
+	iommu->iopf_queue = NULL;
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+}
-- 
2.31.1

