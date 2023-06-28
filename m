Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2067.outbound.protection.outlook.com [40.107.96.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 024A233D7
	for <iommu@lists.linux.dev>; Wed, 28 Jun 2023 05:32:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1xpGZi1VnuW/w16C9ooLc/ODpRGVcqBcq+FuSDpvCwwpNTc2Y+QBhkAkvqWwjmYhd8V2aoQDvex65d2Dvd5pywwtysVKRWbUwjQtic9jm4E1OOZskufQd+8cNuUT9fnTMhI8soR+CSOG4N8NnUusVYL3Nnw2/wHHyHgtHneIh+0ATErhSf+AA2D+ejV1fgn9bhJ9UKnfjSFY5wufkVICq6D6bDq6LzdjBQqitZ69If6swo/6K+65t7yuTPenkyCNp5VSYEFUgXtLvvY6h8n5jCbLhAhYP0RsdHUf2tqpLJsL0CBTbRFIRP95vXGDPMzUm4qcr9P0V4nBBNo8TFN5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6tC6H6lA7iPbkCIhWh9PCIzbTLIqNt0ZH8mcqr7NWV4=;
 b=e6TfFMTJH4/Irkf49+lCWDrK1HHf3/sko9ZWCwyo14ZNhxq5O4U4QidbW/KpxvnMspk18tYwGiw1WQ0Etsue8SRe01NUPjQYUvMISVnJ+E6RDsGHr0izwz5pD7gcriuLzy8+JN1vwRiRlWh18fSecwnJ8i6Xzr80zM522PzlMJMs1JVziHECLcoZ2zljzqXul38S/PECMYomYtm49XlsbglTjGLtpl4rZxJgowmd5/enWs82V4idSAx4iJhMUtk2u0+uPsYDifiwSTMuHlUjF9IDUAVBuP4r/Z2am+YFY5claM8I2EtXFzobfQjsseMnf0L/F1z/Ni2bB3ifmwKj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6tC6H6lA7iPbkCIhWh9PCIzbTLIqNt0ZH8mcqr7NWV4=;
 b=GkgxHeo0RnWBwsdXUxaU+ye/UPc+zZKLTHzC2vuHAOOGfNksRIlc507ysU3v1WcFnVjaQxsvE9MAQMN+xR9VxQ3IELePAAfeqQJeKvbj8ihbJ9BMYZVMRVnnE3Ny5JJyADSSD1p4IglvuMAVFba64rO6qLivlcquOyvwHx+m7Uw=
Received: from BN9PR03CA0068.namprd03.prod.outlook.com (2603:10b6:408:fc::13)
 by MW6PR12MB7088.namprd12.prod.outlook.com (2603:10b6:303:238::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Wed, 28 Jun
 2023 05:32:57 +0000
Received: from BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:fc:cafe::1a) by BN9PR03CA0068.outlook.office365.com
 (2603:10b6:408:fc::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.34 via Frontend
 Transport; Wed, 28 Jun 2023 05:32:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT114.mail.protection.outlook.com (10.13.177.46) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.48 via Frontend Transport; Wed, 28 Jun 2023 05:32:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 28 Jun
 2023 00:32:54 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>,
	<jsnitsel@redhat.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 1/2] iommu/amd: Refactor IOMMU interrupt handling logic for Event, PPR, and GA logs
Date: Wed, 28 Jun 2023 05:32:21 +0000
Message-ID: <20230628053222.5962-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230628053222.5962-1-vasant.hegde@amd.com>
References: <20230628053222.5962-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN8NAM11FT114:EE_|MW6PR12MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: 64dcb2df-86ae-4931-a126-08db779920cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Omm1Fy6fIFqLZBmec22xb3lzios+/TADQoLzbwB1nY8bTANWnGcemiL3/8zWIAsK+zayy4QDPSzKX2bEzrnM8W0iaRAmdZURTeVBJIxqlWeAztKTQxCG31OrPhjyc3KxD5SCEhd9lQbqJGKODrGo8nBaJdAsJcu3GzP+/9nCzou0WPDdwje20LuZC2Up4HirN95PdhEXLMSqD1TLBMHzUfCgt7S6tbqIoFuB3KL5kWgee1GDcD+NxU0u7g+AyrkEUbCxWh9VQAxURncho+ZmH9bFC/Gxj6AG3QV05uG7RtcZkos+q8fGvg4tyxSgHTyas4hq/FK+/9fUa2SzQLvSN3yuIWoBrxitWxES0Z6YQ/BRC25wbHocRS3pbr3dMJuwoiFStH4VoxFOCmLglhT6LiwlKuQqqknzQ1rkCWBFNx90p7fnCb2yAIc7v8sndb7qCbCZIvuBZSnXwbYsrXecUPkePN082W4WSOht/7k+Sp/koklzbpKy4UbP0xTX1+P6WAQjiuhPdUMHTIg5tEnNM6RL0BcBGs1FuG6iViygZb7O71ISyAJcEtzy+beP1KaTMBsbrFUD2h8YmNNghDQpS6L2uyXpxJRl2VVhB8XTHmDSTAMUiwV1bujNXGW/GxQ9k+bBiSsbMJm12revVYymsnEy0Edqu3n+Bn9XdjFelaBW8fe0hlLJbpBx/aRTEucR7Zd2OlD6KBy7E33xp3EvyzXpJmyy5OlISIz1buf8SLjIAbY1L50gF0kHp8t78c7FskHanJmmc9VGXbDW85EimQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(346002)(376002)(396003)(39860400002)(451199021)(46966006)(36840700001)(40470700004)(26005)(5660300002)(70586007)(36756003)(316002)(4326008)(478600001)(70206006)(44832011)(8936002)(8676002)(40460700003)(36860700001)(86362001)(40480700001)(110136005)(54906003)(41300700001)(7696005)(6666004)(82310400005)(2906002)(1076003)(2616005)(186003)(336012)(426003)(82740400003)(356005)(47076005)(81166007)(16526019)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jun 2023 05:32:56.6571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64dcb2df-86ae-4931-a126-08db779920cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT114.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB7088

The AMD IOMMU has three log buffers (i.e. Event, PPR, and GA). The IOMMU
driver processes these log entries when it receive an IOMMU interrupt.
Then, it needs to clear the corresponding interrupt status bits. Also, when
an overflow occurs, it needs to handle the log overflow by clearing the
specific overflow status bit and restart the log.

Since, logic for handling these logs is the same, refactor the code into a
helper function called amd_iommu_handle_irq(), which handles the steps
described. Then, reuse it for all types of log.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde<vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 ++
 drivers/iommu/amd/iommu.c     | 93 +++++++++++++++++++----------------
 2 files changed, 53 insertions(+), 43 deletions(-)

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
index 8f299bb0f3ed..5e9c287b10e0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -841,57 +841,27 @@ static inline void
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
+static void amd_iommu_handle_irq(void *data, const char *evt_type,
+				 u32 int_mask, u32 overflow_mask,
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
-
-		if (status & MMIO_STATUS_PPR_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU PPR log overflow\n");
-			amd_iommu_restart_ppr_log(iommu);
-		}
-
-#ifdef CONFIG_IRQ_REMAP
-		if (status & (MMIO_STATUS_GALOG_INT_MASK |
-			      MMIO_STATUS_GALOG_OVERFLOW_MASK)) {
-			pr_devel("Processing IOMMU GA Log\n");
-			iommu_poll_ga_log(iommu);
-		}
+		writel(mask, iommu->mmio_base + MMIO_STATUS_OFFSET);
 
-		if (status & MMIO_STATUS_GALOG_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU GA Log overflow\n");
-			amd_iommu_restart_ga_log(iommu);
+		if (int_handler) {
+			pr_devel("Processing IOMMU (ivhd%d) %s Log\n",
+				 iommu->index, evt_type);
+			int_handler(iommu);
 		}
-#endif
 
-		if (status & MMIO_STATUS_EVT_OVERFLOW_MASK) {
-			pr_info_ratelimited("IOMMU event log overflow\n");
-			amd_iommu_restart_event_logging(iommu);
-		}
+		if ((status & overflow_mask) && overflow_handler)
+			overflow_handler(iommu);
 
 		/*
 		 * Hardware bug: ERBT1312
@@ -908,6 +878,43 @@ irqreturn_t amd_iommu_int_thread(int irq, void *data)
 		 */
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 	}
+}
+
+irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data)
+{
+	amd_iommu_handle_irq(data, "Evt", MMIO_STATUS_EVT_INT_MASK,
+			     MMIO_STATUS_EVT_OVERFLOW_MASK,
+			     iommu_poll_events, amd_iommu_restart_event_logging);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data)
+{
+	amd_iommu_handle_irq(data, "PPR", MMIO_STATUS_PPR_INT_MASK,
+			     MMIO_STATUS_PPR_OVERFLOW_MASK,
+			     iommu_poll_ppr_log, amd_iommu_restart_ppr_log);
+
+	return IRQ_HANDLED;
+}
+
+irqreturn_t amd_iommu_int_thread_galog(int irq, void *data)
+{
+#ifdef CONFIG_IRQ_REMAP
+	amd_iommu_handle_irq(data, "GA", MMIO_STATUS_GALOG_INT_MASK,
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

