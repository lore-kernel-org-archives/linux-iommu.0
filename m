Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D114AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g476ezzcUFIbUg6W3K6KJ666WMUm+Hope1qjJgqvCkgQJz1nr2SYyIeC0ol2oq7h5+ijo45/014cGaBQIKRKTdbXpl21avzl+5Bxi+9pBs0xeoBrCzhG0rVaTPCwMf7RCdCkiM1oeoSkSCIOAgryT9YlYacdlf04lCL0JO7+O5hOztlbcRArq5V18e/0aiovpA5qZZEJ9hfQ85NjadOESH0B7LnIgrXq7AU+QqhUviqoIlMoHw0AbHz+iciN3cO4zL87+MJPXsU1VH29Fn8LuVoAY8+rYFLzM6eMeD0enfEfm8HOp0XrTLLT82lGkTqoagIzCgYfMgISoKFDwBGktg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DO1kL+6qDeZhHDHxmdM21MsCl5kgFJE4iwzR63WjAvY=;
 b=V9wBV59JH6O6ZU+lhVh2WRls/jF/zs/TXuLqR94jXqriGb8etnT/WsFznjvekqVaJW+gAKhgskqe3FwUjblpQOC1H7DRQlQiIZU/fpuR7dXWz16hqbSGgrua8EYQZsYgw2QbohYOb/l5ysLFPx3JHEnYg/GeKmediM6uiLbc8VyhRPSVhYztX4q71e9U7o3PuqDQRhxwKfMZFJrQR/1n1tbIIxpzEpvsANGNSDQG/CbyvfnBDLH23mKH6iAUHy8sXGoVW4jET7gS1d1KTo3rm9Rn+bdvEbbqZqKcbGBt5YjsIpFjUXGHqYE+aj2tuzWeE0Z9XD2eKZ06IL73jFP4Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DO1kL+6qDeZhHDHxmdM21MsCl5kgFJE4iwzR63WjAvY=;
 b=0J/ZJsdsg4VTFX+3/0olEiK/zAFKMazAARWhThefXtl0K25YYVojHMKfIQ/I+mIoVnLa7R6n8GHr/qmyPTk1+Mi0SOMzz0b0hqELE/BJMiHHw9rzzml5nBriUSDu3G2vgahFA+qivsbRfbI5rNR9uE0Y9SplqGp+J/m0OSkUBNs=
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by SA0PR12MB7091.namprd12.prod.outlook.com (2603:10b6:806:2d5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 10:18:19 +0000
Received: from DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:40:cafe::37) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.26 via Frontend
 Transport; Fri, 9 Jun 2023 10:18:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT101.mail.protection.outlook.com (10.13.172.208) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6477.29 via Frontend Transport; Fri, 9 Jun 2023 10:18:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:18:16 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 1/2] iommu/amd: Generalize log overflow handling
Date: Fri, 9 Jun 2023 10:17:45 +0000
Message-ID: <20230609101746.6412-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230609101746.6412-1-vasant.hegde@amd.com>
References: <20230609101746.6412-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT101:EE_|SA0PR12MB7091:EE_
X-MS-Office365-Filtering-Correlation-Id: f24de90f-f8ad-4c07-24ac-08db68d2d8ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	C2LJBYjc4VT1JNfSUpu7wwiOsCyOVNfTnnLQB+kfaPXJLidJphK6+cZviye+cuOE2amRtqyLkrqTF78kfMfKxr3g14sw6wnJIUJP71c0UzdfF9YA3854OY/zLTpa9GvhfFdC0kbcbwWCr88xqmOW4euqJoJrLPF+6IlcyX1Fzw+ce6SKMZRuAH9qZJohYEaCdP1sECi/imojC+QyVDUrm1kmFmO6aF6Iw0Xf0m9HfrKsO2VfCNFM6P8Ywnvv5/XMoJy1247ZKKdNH8LNhSLB4U8418Rg8d640rWtDukCZI0/FtHiJa7MnMCXXyR+NDUQK0QOZejf/SpZdczFTvwXHPCCiXA42pBBnHikVc+X7ACMY4PMPW48Hyoz5ZK3gqSfZPYug4XQ6XnFvd4NR+dA2/xqz3Y2MUZeMCRvdVK5v/nRoBb3NCt8HbX0SbRBBUQ+W5ZEnAJ8SQKjvW3Tg1NfqrnFZZYYRCKANjkPiWTfJKpmHR2olGBtdYmEOAKUtUSO66nhPAgZqYMcaSqRSIj1mDT6FRjtXltmO8vavHtXGVL7wk/vz0lKw8TLrwcq1aV5tdVm4VXYG0OpCWAUH1wRFNz8F894DW7zJTb9ybUkqtr+JOfS1R6CZMNokvXV/jbQzQV2BLO/2gDYyKHpfA1D02MqUuIzkd2T2Y0AfThkRbfnzYoE+kz162U0xSXxqM99xxi0ZlTQWHfDrJ5qvJmmjZhq/u9VCtMngv6q08jND4gPqT4km7nvlyvh7Bs0/FkEVqBQw+4SHDwPvjMaYEffJQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199021)(40470700004)(46966006)(36840700001)(47076005)(316002)(41300700001)(478600001)(40480700001)(40460700003)(2906002)(36756003)(44832011)(8676002)(86362001)(70586007)(70206006)(5660300002)(8936002)(82740400003)(356005)(81166007)(186003)(110136005)(2616005)(83380400001)(4326008)(6666004)(7696005)(336012)(82310400005)(426003)(54906003)(36860700001)(1076003)(26005)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:18:19.4116
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f24de90f-f8ad-4c07-24ac-08db68d2d8ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT101.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB7091

IOMMU has three different logs (Event, GA and PPR log) and each uses
different buffer for logging. Once buffer becomes full IOMMU generates
overflow interrupt and we have to restart the logs. Log restart procedure
is same for all three logs except it uses different bits in 'MMIO Offset
2020h IOMMU Status Register'. Hence lets move common code to generic
function and individual log overflow handler will call generic function
with appropriate parameters.

Also rename MMIO_STATUS_EVT_OVERFLOW_INT_MASK as
MMIO_STATUS_EVT_OVERFLOW_MASK.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +-
 drivers/iommu/amd/init.c            | 51 ++++++++++++++++++-----------
 drivers/iommu/amd/iommu.c           |  4 +--
 3 files changed, 36 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 364fdaa52e74..318b84cf47f6 100644
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
index c2d80a4e5fb0..3c21e9333899 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -748,38 +748,51 @@ static int __init alloc_command_buffer(struct amd_iommu *iommu)
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
index ad501944d77c..a29548d98b6a 100644
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

