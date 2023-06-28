Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2077.outbound.protection.outlook.com [40.107.102.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43231878
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:17:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l02RW5sebY74gUAr8pf2ljS84maQpcVwZSHeLMUQd+l+hfDKkDnWmu1/3lFFdSyif9AtBcQHRmDje0cie6on+hyhlhncm8WfkvUGQWR85CzPIp1b86C+OeIytqScx1XvoVF24dDxLisTr0Lz8bk/+ZFtqUK29L1zYWDLqXmTl0Hn7RQ7gli9U7jQakvxpqqs9GwfJ4kS54h4ag69MgC5a5zj83V8LWM9ah8T9uAkc7Uw5mMQ6Xi5qkhQ2Yrox0/sHm3y84fO4Z9T1wK56O2uHwGuBIuHnAuerjp7mJ/0RffidemPoQ6IBDOpL5+dUGKrIlaUSBEmjRZ3F6nbCiBzIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VmnMPX7HVBVFdQ7J3Rm615aniIVDEj5WodVS98nYxs=;
 b=VOmU5up3xnMNBltvHCUqCKB1teu5wKWIQEaO8HosfXNFk097bPZO/YcliN+CEe4squsMI89PXwWL/KNB6bO117Bwoe+VWLWXJLnxW52hYgxew8G360hTP71oVYnU4rTlwr70NtEF1VXS5apka47KdVGaL2J3BvEfdPveG2fgQjd6tH2k8a3bPSEuf/E0RBARFHI15iSC6xKFZhE0a2+vA0zPurpnfMwW2WwG6JhqJg+BpXRZfI16IdvGlYIIQ9Sy27vkncGjTeh82usyZOm/xcwHdouljv0jaGamKJN0cBq1i+GcQgIp9BJpZwEMaDiN/rLj/rxG7B0SEOO0R/37Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VmnMPX7HVBVFdQ7J3Rm615aniIVDEj5WodVS98nYxs=;
 b=Usyt2nUJwQndpQu9damnByPd7z4oLbuwnv7/Tj/KnBeBqCV6KurE2aCckHHoD+yyK0/qD75sK2Sq8yBXHCVvzO2DzPUB/z6On2IXihXaWygaRsqWROO75iUnaEaD8sh1stNCZZmIKP5oTCYDObF04CR9pFhZ/BS6wzarSfTKtvE=
Received: from BY3PR03CA0001.namprd03.prod.outlook.com (2603:10b6:a03:39a::6)
 by PH7PR12MB7114.namprd12.prod.outlook.com (2603:10b6:510:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:17:55 +0000
Received: from DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:39a:cafe::40) by BY3PR03CA0001.outlook.office365.com
 (2603:10b6:a03:39a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.16 via Frontend
 Transport; Wed, 28 Jun 2023 05:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT063.mail.protection.outlook.com (10.13.172.219) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.47 via Frontend Transport; Wed, 28 Jun 2023 05:17:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:17:29 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 2/2] iommu/amd: Handle PPR log overflow
Date: Wed, 28 Jun 2023 05:16:24 +0000
Message-ID: <20230628051624.5792-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628051624.5792-1-vasant.hegde@amd.com>
References: <20230628051624.5792-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT063:EE_|PH7PR12MB7114:EE_
X-MS-Office365-Filtering-Correlation-Id: 67b06cee-72d3-432f-4410-08db77970728
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aE3dNkshgikqgWHSVr3jOWgBmlwWi32weG6j7NV8Nlp57rIafDe9vFM2yhCbkSHc9CrMNULSs9GTxMqwYPwvCBZKJbpo0i0Ok+8BzsQZYALGM2Tao3cHRal7b85f63QmBSFdB8LBupCadcac/cphD4aknIkQafiiXCDQjYI6sRwTrONgLADoskqCcw1ua4YKCodyOIyBA28TazYVZta/PHXjGn91yCFtUOGPZIH+T/KLZ7YgH0WyvQjTznsYys1OhGgkhhtOCcn+7BS5eKCT8S15VeSY9WzLMHwnlRCaxYV6e28de06GQMUK2JBU4KjVuByem4G703OPgpeT1nYE9oQWVG6VU6w5jOKliIO/POEroLrJdTyKswQz+KLXPHojkhAaryYqRTQdWQ2LdIBgC+VJuwHNMnqY67rt3yxeoRjnbD4xoPpMgWYvsDuR3S7C2n0Q2eMMSnr/zjitKHV1sGDz2U154dzIuvtTTPT+cML3LGN5diu1+Iv0+RykcswzDxGQck5dBitDdTtA8HybtYRl/hjEPkL746onftfNujCmArPCd7eJJrk7a/BMJfzeK7/1b74NOhGr82i3OCjIPW6gkkvwD7LlnZ+/puOl5KXOYwrMWHipol3wVZjtZ2C2IYdOH8Y5NAUwLmPnPaSi5GJo2KifdzNbwQbLPS+P7TDQQxsavVOH0GEgrY8rRDiRmnFEA2SjeC6PtAghsAnmHaGX2N/NFKSojL8cgVJ6FuUrN4l1wVN130pywufXGo0XjsV6rzqxHWLhLHeLzOXPhQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(39860400002)(376002)(136003)(451199021)(46966006)(36840700001)(40470700004)(44832011)(5660300002)(4326008)(70206006)(478600001)(36756003)(316002)(70586007)(8936002)(8676002)(2906002)(40460700003)(966005)(110136005)(40480700001)(36860700001)(54906003)(41300700001)(82310400005)(186003)(7696005)(336012)(86362001)(26005)(16526019)(47076005)(6666004)(426003)(356005)(1076003)(81166007)(2616005)(83380400001)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:17:54.5966
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67b06cee-72d3-432f-4410-08db77970728
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7114

Some ATS-capable peripherals can issue requests to the processor to service
peripheral page requests using PCIe PRI (the Page Request Interface). IOMMU
supports PRI using PPR log buffer. IOMMU writes PRI request to PPR log
buffer and sends PPR interrupt to host. When there is no space in the
PPR log buffer (PPR log overflow) it will set PprOverflow bit in 'MMIO
Offset 2020h IOMMU Status Register'. When this happens PPR log needs to be
restarted as specified in IOMMU spec [1] section 2.6.2.

When handling the event it just resumes the PPR log without resizing
(similar to the way event and GA log overflow is handled).

Failing to handle PPR overflow means device may not work properly as
IOMMU stops processing new PPR events from device.

[1] https://www.amd.com/system/files/TechDocs/48882_3.07_PUB.pdf

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 11 +++++++++++
 drivers/iommu/amd/iommu.c           |  9 ++++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 0c35018239ce..8c61c19dabc4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,6 +16,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
+void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 int amd_iommu_init_devices(void);
 void amd_iommu_uninit_devices(void);
 void amd_iommu_init_notifier(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1a4fd6188705..2266badc6d0a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -124,7 +124,9 @@
 #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
 #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
 #define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
+#define MMIO_STATUS_PPR_OVERFLOW_MASK		BIT(5)
 #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
+#define MMIO_STATUS_PPR_RUN_MASK		BIT(7)
 #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
 #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
 #define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 7fab6ecb6295..e78d7c4f41bd 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -799,6 +799,17 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
 			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
 }
 
+/*
+ * This function restarts ppr logging in case the IOMMU experienced
+ * PPR log overflow.
+ */
+void amd_iommu_restart_ppr_log(struct amd_iommu *iommu)
+{
+	amd_iommu_restart_log(iommu, "PPR", CONTROL_PPRINT_EN,
+			      CONTROL_PPRLOG_EN, MMIO_STATUS_PPR_RUN_MASK,
+			      MMIO_STATUS_PPR_OVERFLOW_MASK);
+}
+
 /*
  * This function resets the command buffer if the IOMMU stopped fetching
  * commands from it.
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 102b337c753d..8f299bb0f3ed 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -844,6 +844,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 #define AMD_IOMMU_INT_MASK	\
 	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
 	 MMIO_STATUS_EVT_INT_MASK | \
+	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
 	 MMIO_STATUS_PPR_INT_MASK | \
 	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
 	 MMIO_STATUS_GALOG_INT_MASK)
@@ -863,11 +864,17 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 			iommu_poll_events(iommu);
 		}
 
-		if (status & MMIO_STATUS_PPR_INT_MASK) {
+		if (status & (MMIO_STATUS_PPR_INT_MASK |
+			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
 			pr_devel("Processing IOMMU PPR Log\n");
 			iommu_poll_ppr_log(iommu);
 		}
 
+		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
+			pr_info_ratelimited("IOMMU PPR log overflow\n");
+			amd_iommu_restart_ppr_log(iommu);
+		}
+
 #ifdef CONFIG_IRQ_REMAP
 		if (status & (MMIO_STATUS_GALOG_INT_MASK |
 			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
-- 
2.31.1

