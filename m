Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FCAD1878
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:17:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U28U9Bve0hMu75VLI2z4CD0WhdkeaG86BfTtoFj9PFg19jtR+XuAk5meWRz7crMM5jt090XG8Up9u8fPHVee3h8/Fq1jRiqCLhB+VkOgLShjTo9HH/5eY2e+mKH5PRojTjciJLBWl0vdALAWlZAJmeesN87RCPLLd6d3XxN6SHkcVy4PviDPkEOpHLk6LrDK2z+TTiuwKUFrXvnzYp/VOp9C2aPbr6sYXSdnocpqK29pZbRbtjG2JYSpq/OcvCsWDxnCqcRZlaC4rZJMQ4tmEwdV5w4jo3QbN09dWGXNK8yV2g/nLwSfZjTBq4ZM6HC3wNOTU19Zxl7K6DpNMsiMpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Y/3BiZDJyCRCkUHsYwIfpEgwBQoJX5h0NZDRAlxdxw=;
 b=TQZ4XUFBGhfOLXpIgnFSOheMLjUDuyNGZbq0qKODEDwDFcjHKYP6HZoj1msx4xUPZK6KQuWCPUWZMgpamYemC/oOdOhRjnRvTgHfzF+LAnD7mFY3aja7ubSOEaPcSpPORFTlIBhvA5eMn/fHtOkTUsp/mW742RS1xO4Q8aRxT6uw/lQVwmDA4QdaZlZH278ZSRMaJnjj4uwGIFQjaUbtEU4Oih06OES/3kT8+INGSJPhFjfbPAOJk+2zRgmQkln+zEpnfXob4jOI3qPI1Q0pzNanVuxtWBGaPoLdEwpLJjWucmq+itVzzUbvBMVFeP/Dw6nWYcVqV6ppoNuMMRqKBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y/3BiZDJyCRCkUHsYwIfpEgwBQoJX5h0NZDRAlxdxw=;
 b=Du4xOOiaoYKepzanG7VoI4/joiTOoc6lsIjb/ErBySVoDn1ZtGL625QuBJN0MYRqbxGLQTWP0FBiPYjoykrx/1PQHQT+mXl+9VU6i5irZQAJUteGfu1xf3tFNrWa0CmfMbwvIGWgyoGA/JsTNsRngoCdkhr94C9UgBJco8/XdrU=
Received: from DS7PR03CA0057.namprd03.prod.outlook.com (2603:10b6:5:3b5::32)
 by DM4PR12MB7600.namprd12.prod.outlook.com (2603:10b6:8:108::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Wed, 28 Jun
 2023 05:17:16 +0000
Received: from DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b5:cafe::8c) by DS7PR03CA0057.outlook.office365.com
 (2603:10b6:5:3b5::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 05:17:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT107.mail.protection.outlook.com (10.13.172.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 05:17:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:17:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 1/2] iommu/amd: Generalize log overflow handling
Date: Wed, 28 Jun 2023 05:16:23 +0000
Message-ID: <20230628051624.5792-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT107:EE_|DM4PR12MB7600:EE_
X-MS-Office365-Filtering-Correlation-Id: 25615b97-d7e5-46dc-b424-08db7796f073
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lfEoeexVI87crk40iuo7lSKOJW5LlNx0pc2yyuo9zxG5vvU1Ud3M4w8/KnYXkgM4ko1h2mKCE4G0L/l6EjCbLDcSLbPfiTxgvQxlEmHnxV8IBFRt9hkT8A27LVmboTKsJNgcB0oIHmcTDgoneeAs9lacRiGF6c7hIjjxQ8LFDlzNA4q++tIdqC1Y3Yh2hw7UOJ9Uayw42uwWxKDKBJOy6PNGXFGNrRl4CBAKe8wG41vMcM5X6mQautnqVE728f3zDiYsHMpvqyh8ZRSLZzP5REXbWuZFS6DA7HNep4cCZ5ggiqZ5ozOcQqEOjTYAzqpkxCIPjObWZUd28cX4vi3QNcgNc6A0CMPs4KHXWMpfEJvO7q3qmiUXlG9p6dg3ByyhavLag9LXmZ2Em/gKRlD86jdvF8o5675qBMcqPLBNhOgC+oPM1J9vO1dQjP84AUS0O5TbNM1M1NqDduReRU/3r7tZYviFyM6ot3gUOu2JA+evDdsfumhRDhNy9iByz8/KiczqU+fY5FF1OyiOohipu8YhGakOypu5SAI+FQ3iXNTaIT5W9rJ3V1Nd86TRqPzYnRYvStVTN0dtZFpKfsWE6uI1oBiUqFjDd5Ynb4kaJ/GaFcssAWkOQ4c+5vP3fDMsSWsZ0g/QiU7zfI7cqzH/AcQYtdYM/1r+SLe9mZ4omj1P4LZ4U8CodLww4sOTMKVmhqFmVoo7v4jB/sbDY1JNVJGAwBistVI1LGtjhwl5Lg6Wwxast6pNmGnzGZ03PbBQ8aig+yGR78VXXf5GQthe8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199021)(36840700001)(46966006)(40470700004)(36860700001)(82310400005)(26005)(356005)(44832011)(5660300002)(40460700003)(70206006)(86362001)(8936002)(41300700001)(4326008)(316002)(8676002)(81166007)(82740400003)(70586007)(40480700001)(110136005)(47076005)(36756003)(16526019)(186003)(2906002)(83380400001)(1076003)(54906003)(7696005)(6666004)(426003)(336012)(2616005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:17:16.5034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 25615b97-d7e5-46dc-b424-08db7796f073
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT107.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7600

Each IOMMU has three log buffers (Event, GA and PPR log). Once a buffer
becomes full, IOMMU generates an interrupt with the corresponding overflow
status bit, and stop processing the log. To handle an overflow, the IOMMU
driver needs to disable the log, clear the overflow status bit, and
re-enable the log. This procedure is same among all types of log
buffer except it uses different overflow status bit and enabling bit.

Hence, to consolidate the log buffer restarting logic, introduce a helper
function amd_iommu_restart_log(), which caller can specify parameters
specific for each type of log buffer.

Also rename MMIO_STATUS_EVT_OVERFLOW_INT_MASK as
MMIO_STATUS_EVT_OVERFLOW_MASK.

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Reviewed-by: Joao Martins <joao.m.martins@oracle.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +-
 drivers/iommu/amd/init.c            | 51 ++++++++++++++++++-----------
 drivers/iommu/amd/iommu.c           |  4 +--
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 082c57b8c2d6..1a4fd6188705 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -120,9 +120,10 @@
 #define PASID_MASK		0x0000ffff
 
 /* MMIO status bits */
-#define MMIO_STATUS_EVT_OVERFLOW_INT_MASK	BIT(0)
+#define MMIO_STATUS_EVT_OVERFLOW_MASK		BIT(0)
 #define MMIO_STATUS_EVT_INT_MASK		BIT(1)
 #define MMIO_STATUS_COM_WAIT_INT_MASK		BIT(2)
+#define MMIO_STATUS_EVT_RUN_MASK		BIT(3)
 #define MMIO_STATUS_PPR_INT_MASK		BIT(6)
 #define MMIO_STATUS_GALOG_RUN_MASK		BIT(8)
 #define MMIO_STATUS_GALOG_OVERFLOW_MASK		BIT(9)
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index ea0f1ab94178..7fab6ecb6295 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -752,38 +752,51 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
 	return iommu->cmd_buf ? 0 : -ENOMEM;
 }
 
+/*
+ * Interrupt handler has processed all pending events and adjusted head
+ * and tail pointer. Reset overflow mask and restart logging again.
+ */
+static void amd_iommu_restart_log(struct amd_iommu *iommu, const char *evt_type,
+				  u8 cntrl_intr, u8 cntrl_log,
+				  u32 status_run_mask, u32 status_overflow_mask)
+{
+	u32 status;
+
+	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	if (status & status_run_mask)
+		return;
+
+	pr_info_ratelimited("IOMMU %s log restarting\n", evt_type);
+
+	iommu_feature_disable(iommu, cntrl_log);
+	iommu_feature_disable(iommu, cntrl_intr);
+
+	writel(status_overflow_mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
+
+	iommu_feature_enable(iommu, cntrl_intr);
+	iommu_feature_enable(iommu, cntrl_log);
+}
+
 /*
  * This function restarts event logging in case the IOMMU experienced
  * an event log buffer overflow.
  */
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu)
 {
-	iommu_feature_disable(iommu, CONTROL_EVT_LOG_EN);
-	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+	amd_iommu_restart_log(iommu, "Event", CONTROL_EVT_INT_EN,
+			      CONTROL_EVT_LOG_EN, MMIO_STATUS_EVT_RUN_MASK,
+			      MMIO_STATUS_EVT_OVERFLOW_MASK);
 }
 
 /*
  * This function restarts event logging in case the IOMMU experienced
- * an GA log overflow.
+ * GA log overflow.
  */
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
 {
-	u32 status;
-
-	status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
-	if (status & MMIO_STATUS_GALOG_RUN_MASK)
-		return;
-
-	pr_info_ratelimited("IOMMU GA Log restarting\n");
-
-	iommu_feature_disable(iommu, CONTROL_GALOG_EN);
-	iommu_feature_disable(iommu, CONTROL_GAINT_EN);
-
-	writel(MMIO_STATUS_GALOG_OVERFLOW_MASK,
-	       iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
-	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
+	amd_iommu_restart_log(iommu, "GA", CONTROL_GAINT_EN,
+			      CONTROL_GALOG_EN, MMIO_STATUS_GALOG_RUN_MASK,
+			      MMIO_STATUS_GALOG_OVERFLOW_MASK);
 }
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc481080f722..102b337c753d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -842,7 +842,7 @@ amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 #endif /* !CONFIG_IRQ_REMAP */
 
 #define AMD_IOMMU_INT_MASK	\
-	(MMIO_STATUS_EVT_OVERFLOW_INT_MASK | \
+	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
 	 MMIO_STATUS_EVT_INT_MASK | \
 	 MMIO_STATUS_PPR_INT_MASK | \
 	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
@@ -881,7 +881,7 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		}
 #endif
 
-		if (status & MMIO_STATUS_EVT_OVERFLOW_INT_MASK) {
+		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
 			pr_info_ratelimited("IOMMU event log overflow\n");
 			amd_iommu_restart_event_logging(iommu);
 		}
-- 
2.31.1

