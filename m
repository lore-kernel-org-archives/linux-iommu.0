Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CC66AD3C
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:24:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KHTqXHwyPk5zfZLom+X8gKVYbcWH1UQM5m4Yrin3SyZ/ZjwX4cPlNb52aZmjRxzb+7BZaITEsajiTtqvcV0r8czhEc8kfCw2YbaW/YbWRZpd4ZfcMsrwpdVUSciPYYB+3VXwFvt0ZHuOImb+aL0Pcxs8HtNApIYniN6clKub1iT4dxJWAvGbLWnfsaJAnSfuaU0Hy8ACwvdy0MZI3qrXJWNMnxbyFVRHPHJlyHI24t37wtAXTme4lxrcGWNMwQznJinjnra2THonUfqVSjdjE5BRhdnilLKHAklLsjzFzVEbrU3uM0EWYiuExUIv4X/9SAsU+a0t1mDnxtzIepbp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nL0ExKqOZH1l3/N+PbUDH3iXskza4LBA4Bg1RQzr/eU=;
 b=NXgHqJ5i3LC3CjHlIdQUowZs23OhyeoHPA6yiVWZ4dOTDG0kWK4aq2ktmPHhutcHTSeRI8jBg60lVLAB0k23F+976uSWKw0GtR5AMX2tgxEgUpAqyBYzAaLL6U2TwtDX3KQGV2e39rKYw9o45liOcH3jCsoj4D8QflvUkwziOl5FZXsUJv/e546ztgN3Khuh5bpneikqzkG3VwXjPJ2/sORwAAF0ovOLWjQcqT7mMVob/VccpGkJ5Mtb2ozhawqsun9wjM9WhLFNlt1yr9VC3r1I4fMRVjxYqwjXfzSK51Lg8Gv90AMsa/E7Jcuszaoy0eoXd3u5zaWiTTWcEs9OpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nL0ExKqOZH1l3/N+PbUDH3iXskza4LBA4Bg1RQzr/eU=;
 b=w1G/UCk5zWXnB5tC8zfW/eJx+BOSMYhP3HdDiGqMS8vvLZJZaPtRbYcMjgSL+DPprhmUU+6rQnqdvqcL6hLleF1HDr+52Pyt4oxIwAKpMpfHs5yVpKvJkK4lxe3iF25waRTSfwhA/KjlJFTCE143sJmHZCm7nV0M3+KiyQT3kwc=
Received: from MW4P222CA0015.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::20)
 by SJ0PR12MB5609.namprd12.prod.outlook.com (2603:10b6:a03:42c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.35; Mon, 19 Jun
 2023 13:24:15 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:114:cafe::b9) by MW4P222CA0015.outlook.office365.com
 (2603:10b6:303:114::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.44 via Frontend
 Transport; Mon, 19 Jun 2023 13:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.35 via Frontend Transport; Mon, 19 Jun 2023 13:24:14 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:24:11 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>, Suravee Suthikulpanit
	<suravee.suthiuklpanit@amd.com>
Subject: [PATCH v2 1/2] iommu/amd: Generalize log overflow handling
Date: Mon, 19 Jun 2023 13:23:45 +0000
Message-ID: <20230619132346.6021-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619132346.6021-1-vasant.hegde@amd.com>
References: <20230619132346.6021-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SJ0PR12MB5609:EE_
X-MS-Office365-Filtering-Correlation-Id: a6750500-4746-4c7f-b3d7-08db70c87a26
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	wnqyu+cCMlJo7o1SbvN4SDjL9laQgQpIpSfUIMWbyPMjDubZxhZYaYaEZ3iYe3vvhJYeGwhJWnMwcvE/sCAk/9MBWM1SkWK4IjMT17UW8qfg95Z2yBqhu0J0dOAQCmnacXz7t8umtCQ6q9R86Qhcq4EWRdjrTpJSPTZf892+DkCew2MQXatKoD3JdA9RS7pXYQo1Ahg9OGYaXVP4+A2d2A3iUevpwUS5qqGqKApIx5Cni+9faC6gG9JzW19Ac3u5mC5MgwK/zfxg7rKkJjjW462Exx9fA0+A2oPDixAj5jI1JTQI+DK8L+PCRz+xI4GjXRu7bn7cvlZZLJgxYpF6KDvNg+yiqsf3FG5HrCywTOjX5wBDijXyKYK0vuJI6EM5tc679VTUce8FnD2mwV/KnPMoXR6drfhg0F1ObbyVFWIdgcsvBdKqkDI98xD5VViokHpb/PpScFojqoGBkpf2XqhAfYLEH9zsmxVoaGnL/rdME4KCxVK6xzNTcUvMw+ROA+b5uW2CU2fazaGrcc1uquz7btmO5CGwuBEJShmYWyQPGuCx+24itIXFca86KbZ5yXZlviQdhM139U+OVGqf1KnJSZAxSmas3LRoM7VfwurUDxUEU5cKgHnodcpS9YRq/jemKCg5oF7E8jzUBl6uqB2njFkBSBTByjaas2dY4dFl9uxcBqXHtDkDHjyM4k2Z7ocXYiwudDLM3qzOd4RFjutVjfvFA+nq8iSOAdTRuXMp0qnxqHci/nhvlc6wyFGRBQ7NGHSLGMAcNZQuFJJ3Og==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(39860400002)(376002)(396003)(451199021)(36840700001)(40470700004)(46966006)(70586007)(82310400005)(186003)(8676002)(70206006)(8936002)(16526019)(82740400003)(5660300002)(110136005)(54906003)(40460700003)(4326008)(6666004)(7696005)(316002)(478600001)(41300700001)(36756003)(26005)(1076003)(40480700001)(336012)(426003)(81166007)(356005)(47076005)(83380400001)(86362001)(2906002)(36860700001)(44832011)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:24:14.6777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6750500-4746-4c7f-b3d7-08db70c87a26
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5609

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
Reviewed-by: Suravee Suthikulpanit <suravee.suthiuklpanit@amd.com>
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

