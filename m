Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA658BE5
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:30:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dytfbJqgzse+E9kEdX7hfUGdsKbzK+5o740I5lKXVGmO2VpkAdV0sphm7I+HDK9Vuo4tXUO1211nXXxoZG+e5yTDVD1Pn+yJbTQPM67r1rqeydo5n7JQ30OsrNC4QjOlT65pEhVh+iEWgCTqJw71WSCi2ezG4Fu/pEMqluPcupM34aTez/BUSw/bvf7r77ibb4dfPmnQJqTWugm7RjiMrox89mF9xOMG0xpGNopMsNfo7Yqgk2QIpG62piTjKIhcyaRqUok1HAooSHuU5iDlcTwVQGkJF6cMZlHzjAeaoeiY3/UuazqST2ik0H40ttqbe8E1LNkJrPbvG9NrHgllzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6jH2ZFazc+XxkJ+uwtRO/OPwwb55qBZfXlO+3YNZGE=;
 b=BsbPMB9khYbuvpdkeS2KJ7nrorElRb1Rld6VC76Avzhwts6iPQueD6FF+00j/+q4g9Apa6vuu5r4tajiDSh0y0Wnr2e3gCt7XJROUTrilnNhlDmlRuanxIhxDjLwKDQ3ATybos398aENmRIL1a94gG/ky3jkwlsfYtF1AriJg9G/yNcNxPivRZhN3Xf8Vu3j8vPrVywAjn3vhYCRbEZ1EeOdm5I7PNYxWk4QtuJj1pdnGwy6NzTXFqMjJD0Bi0bjieJ+c+HtZCNE0bDe1oEaY31kXsXIVU5rNihIoG20vjdBfulGzZ5hEDip99h4DGBFghhIfVjO/LD1yOSEBsAMiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6jH2ZFazc+XxkJ+uwtRO/OPwwb55qBZfXlO+3YNZGE=;
 b=QLfoyOCfF4qIrpEV8M4NyrGLyvx68URuIv+G0OMLI6WvI+aOZ2PN8iUV2RLpZf481+rmwmeaPpjA1KGK+HMmL8Ij55IwZ6ocSQ836OrOgJvl0gb+j1ZxOX5WMnC5FI/9WUj+H2UTn4uUiMra0T80nDaNv3dMkqMbGLzskQuqW/s=
Received: from CY8PR12CA0057.namprd12.prod.outlook.com (2603:10b6:930:4c::24)
 by CY8PR12MB7635.namprd12.prod.outlook.com (2603:10b6:930:9e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.36; Mon, 19 Jun
 2023 13:30:43 +0000
Received: from CY4PEPF0000EE38.namprd03.prod.outlook.com
 (2603:10b6:930:4c:cafe::f0) by CY8PR12CA0057.outlook.office365.com
 (2603:10b6:930:4c::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:30:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE38.mail.protection.outlook.com (10.167.242.12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.19 via Frontend Transport; Mon, 19 Jun 2023 13:30:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:30:40 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 1/2] iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
Date: Mon, 19 Jun 2023 13:30:07 +0000
Message-ID: <20230619133008.6221-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230619133008.6221-1-vasant.hegde@amd.com>
References: <20230619133008.6221-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE38:EE_|CY8PR12MB7635:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e33785-4be5-4d5f-8673-08db70c9617c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jCPhlVSLxOruxIq+3fpE1Gy8xjIKuxxJ4dtqYcS4jThXs3BlVqMVDUnjL6MczV4vcj3bbzuMRRVqk51irLcOt+Et8B6wreFLPbL+o9aSczNj2s0dnwK5ybO1Cfed47eJ3nmYKvaQFryAg+8MjKuLOP/XGKVKWrySMlun+5CLZSX6Oft8EaBGrVeGwWtDfWKM+Tv5cteQrqRsx6NQOIoLXijrCxWTXS745ZGHfVnJuZLphzAm3Cevj4xoRbncayvKafWmr2vX0LQ3ns16pGLOI2fGN5NoksoK7kFtxrrg6G8tKoCMc5qgK1JoY2DcsRR1031k4mEuqw5EYl8rXxB8El8cHjQyHEeTBOBVODUp3JY/8oClHQv6u+hparntb7A4H5FKTp3oSFn/qhz+A6sIkhDbha61aZhtMPtxdG2pjDznuFjj0FbZGp7vd3HCi1WNA3vkYGLfvVlgwCtdrNHw4N+tBzbkQeXZ/4wCvnxW0cYzQAgekeNFrCvdKTbY06Ic9sg5upntHWrK+SRVZxn/+5syhcs0v38ud7OBkdjp9cn0GTbMwwjDmycy/S8Ipn4O5nBo9L/zJCYJ1U9p5TquNfxsF1b9w1nQzaoD+rcWE5g9p44mLeirMD9Au1BUTUnVvEujideVWyXkBDEJNqkdRluzcyYqV9sP8T1LNyTJJkuZ49nJH8I0PGJ0QyoEYXpJfmy3LFPqO2c5CnSAAHgvvBsSxpvlcW0GT/7UecdeBdKmeb8hCI90Af3hLBnmZdj7Yeopd/aeXDzlV/BZqfHOzg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(356005)(81166007)(82740400003)(40460700003)(478600001)(36860700001)(2906002)(40480700001)(110136005)(6666004)(7696005)(54906003)(316002)(83380400001)(47076005)(82310400005)(426003)(336012)(5660300002)(41300700001)(70206006)(44832011)(70586007)(36756003)(1076003)(26005)(86362001)(2616005)(8676002)(8936002)(16526019)(186003)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:30:42.8251
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e33785-4be5-4d5f-8673-08db70c9617c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE38.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7635

The AMD IOMMU has three log buffers (i.e. Event, PPR, and GA). The IOMMU
driver processes these log entries when it receive an IOMMU interrupt.
Then, it needs to clear the corresponding interrupt status bits. Also, when
an overflow occurs, it needs to handle the log overflow by clearing the
specific overflow status bit and restart the log.

Since, logic for handling these logs is the same, refactor the code into a
helper function called amd_iommu_handle_irq(), which handles the steps
described. Then, reuse it for all types of log.

Reviewd-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 95 +++++++++++++++++++----------------
 2 files changed, 54 insertions(+), 44 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 8c61c19dabc4..f23ad6043f04 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -12,6 +12,9 @@
 #include "amd_iommu_types.h"
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
+irqreturn_t amd_iommu_int_thread_galog(int irq, void *data);
 irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8f299bb0f3ed..75b2df7990c9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -841,57 +841,23 @@ static inline void
 amd_iommu_set_pci_msi_domain(struct device *dev, struct amd_iommu *iommu) { }
 #endif /* !CONFIG_IRQ_REMAP */
 
-#define AMD_IOMMU_INT_MASK	\
-	(MMIO_STATUS_EVT_OVERFLOW_MASK | \
-	 MMIO_STATUS_EVT_INT_MASK | \
-	 MMIO_STATUS_PPR_OVERFLOW_MASK | \
-	 MMIO_STATUS_PPR_INT_MASK | \
-	 MMIO_STATUS_GALOG_OVERFLOW_MASK | \
-	 MMIO_STATUS_GALOG_INT_MASK)
-
-irqreturn_t amd_iommu_int_thread(int irq, void *data)
+static void amd_iommu_handle_irq(void *data, u32 int_mask, u32 overflow_mask,
+				 void (*int_handler)(struct amd_iommu *),
+				 void (*overflow_handler)(struct amd_iommu *))
 {
 	struct amd_iommu *iommu = (struct amd_iommu *) data;
 	u32 status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
+	u32 mask = int_mask | overflow_mask;
 
-	while (status & AMD_IOMMU_INT_MASK) {
+	while (status & mask) {
 		/* Enable interrupt sources again */
-		writel(AMD_IOMMU_INT_MASK,
-			iommu->mmio_base + MMIO_STATUS_OFFSET);
-
-		if (status & MMIO_STATUS_EVT_INT_MASK) {
-			pr_devel("Processing IOMMU Event Log\n");
-			iommu_poll_events(iommu);
-		}
-
-		if (status & (MMIO_STATUS_PPR_INT_MASK |
-			      MMIO_STATUS_PPR_OVERFLOW_MASK)) {
-			pr_devel("Processing IOMMU PPR Log\n");
-			iommu_poll_ppr_log(iommu);
-		}
+		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU PPR log overflow\n");
-			amd_iommu_restart_ppr_log(iommu);
-		}
+		if (int_handler)
+			int_handler(iommu);
 
-#ifdef CONFIG_IRQ_REMAP
-		if (status & (MMIO_STATUS_GALOG_INT_MASK |
-			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
-			pr_devel("Processing IOMMU GA Log\n");
-			iommu_poll_ga_log(iommu);
-		}
-
-		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU GA Log overflow\n");
-			amd_iommu_restart_ga_log(iommu);
-		}
-#endif
-
-		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU event log overflow\n");
-			amd_iommu_restart_event_logging(iommu);
-		}
+		if ((status & overflow_mask) && overflow_handler)
+			overflow_handler(iommu);
 
 		/*
 		 * Hardware bug: ERBT1312
@@ -908,6 +874,47 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		 */
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 	}
+}
+
+irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
+{
+	pr_devel("Processing IOMMU Event Log\n");
+	amd_iommu_handle_irq(data, MMIO_STATUS_EVT_INT_MASK,
+			     MMIO_STATUS_EVT_OVERFLOW_MASK,
+			     iommu_poll_events, amd_iommu_restart_event_logging);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
+{
+	pr_devel("Processing IOMMU PPR Log\n");
+	amd_iommu_handle_irq(data, MMIO_STATUS_PPR_INT_MASK,
+			     MMIO_STATUS_PPR_OVERFLOW_MASK,
+			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
+{
+
+	pr_devel("Processing IOMMU GA Log\n");
+#ifdef CONFIG_IRQ_REMAP
+	amd_iommu_handle_irq(data, MMIO_STATUS_GALOG_INT_MASK,
+			     MMIO_STATUS_GALOG_OVERFLOW_MASK,
+			     iommu_poll_ga_log, amd_iommu_restart_ga_log);
+#endif
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread(int irq, void *data)
+{
+	amd_iommu_int_thread_evtlog(irq, data);
+	amd_iommu_int_thread_pprlog(irq, data);
+	amd_iommu_int_thread_galog(irq, data);
+
 	return IRQ_HANDLED;
 }
 
-- 
2.31.1

