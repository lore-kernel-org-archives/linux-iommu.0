Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3434A14AA6
	for <iommu@lists.linux.dev>; Fri,  9 Jun 2023 10:18:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VZ+WBiBFDggJSboWpGGAnCN847FK+aXkDakYbX5+reZnIiL99nNBncaFXXXWmj8yP+zvBTVfVeWnwvcwH/WfqVb6NQFAUx6zKHevF1RPXQ2xJGhK0Gimt9GhZtBoEXjXZas4+QSMThgM4qGYZwQz/bGVSnR/qshuHbqS64bex3v+sal7nBtlgWICE5jjr3t2A14jFaBNb3S3mX2D9TBzL/aMvXkbLqPRxUNhXxecccv5xdsk8YFD9uZm55NRs+HXXq+X8mHmptph9PaQEHwgGo3NZsAkVkJiNxBxYhtC1SUrMqA4kGQfFitry+7BM001KeOVSd0ou4ksdob7+vGWUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VyektckbhH+E3SE6u5rfACOAGQ9X4Lq+KEC5UaHrtn8=;
 b=APEjhQQdb2HEqzuToYFDdRB7nsud+2PmS6k4I2y4kkRaxlMCICUnLgiPjrRJIimCxwyZz2DfHmUE6MOZYaQWyB9EILYWDSKYDjOo9s4PblE9eUDswRJ2axCU+FhMJxzonlQaSFLb//EYm9nlHaT/KFEGmyVfvq6m4zov1UNGJZTnZ2h+Kl9HyokXDTstCg/fmjEdQ+amu5ZnWCRJ6XSh28r0Ge2SZcPRjsOQ+b73EXl13hGYzoMpPL/mPODmWboZgQ5Re2QbOwSi9oMl9p1QhdYpRlvFTmH7RzRiWF2ClMzTXD9K3Nqy5lUNDjqqljN6rN6/fj/+x3h5sXwtjBMRtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VyektckbhH+E3SE6u5rfACOAGQ9X4Lq+KEC5UaHrtn8=;
 b=sF25J+Xbiz8jDWzA4L48yoA9Mj1bzlQvCwMYvQO/gl3yR1eugGW5oHWfilZjkH+Ry9xu03ak0ubXdi+RZ8aFtOHu32GJcQ69e1kSRqlAkIY7y9UXgz3i23nKRqBxkHnTO4Bv3Ijx6hVLQKTrwMD8A14jQOufTv9T88XZUq3kLlo=
Received: from SJ0PR03CA0371.namprd03.prod.outlook.com (2603:10b6:a03:3a1::16)
 by DM4PR12MB6662.namprd12.prod.outlook.com (2603:10b6:8:bb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.36; Fri, 9 Jun
 2023 10:18:34 +0000
Received: from DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:3a1:cafe::d6) by SJ0PR03CA0371.outlook.office365.com
 (2603:10b6:a03:3a1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.26 via Frontend
 Transport; Fri, 9 Jun 2023 10:18:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT078.mail.protection.outlook.com (10.13.173.183) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Fri, 9 Jun 2023 10:18:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Jun
 2023 05:18:31 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <joao.m.martins@oracle.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 2/2] iommu/amd: Handle PPR log overflow
Date: Fri, 9 Jun 2023 10:17:46 +0000
Message-ID: <20230609101746.6412-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT078:EE_|DM4PR12MB6662:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b819aa4-c021-4717-b41c-08db68d2e1bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SO6kC14GmKBtVzJQoz7nI2mk/E7NFng9vpWTi1PhMrZl8vlyLCHg96sYVutOuS/85ATdQ/jDJXtwrgt+utRMrkl2A57CcjbHZxpzDpKj0al/TrCuixrWY6eFg7+jSXTMko4b8ZeAjq05PYt4SUB3nDPxFCtjmR2bPPvnGFGuyMxtdR993lq4XpSnB0PE5YmA8jecVfsqm94g5MhWKfM5iHOm1aqcoMMirKM8R91yzp6+PTDk55npgLn75mJGYN34SE3u9avrUKkzd9uNT8Nvurl5NpLqyQ63krI1tAe+p1Fm6yxfTPExxzxtAGXgkzJZteVedVEp3MeKrPlDOdknT+WTTMdNJsid2ZElhFPFolmyccX2h/iP4yh3FOubDjXwFVz57WcOk5GUf+b0t4r80Q5kNUgwEQTPI3zvMlqChAk+2VVh3hZLYzEAUcM7NsOYF/5G6EC+0fR+QJPR2J59HTcWXYlj3XVM3R7L34DtXiSXyzDtuXRfKqKeQGXWkxjVagSHz6vbx4d7FgFEfFDsWJtUb2kZag4hcoNjn9E/QCW1OymxObrULFSfXUSzbISHqOXIUu6zylapjyMSOXBPpF4jEJN7OX+NNUgatLnJ1P6RYa9LMMk16oqMiWdqPPjNgg/X6TIai23ZwmJOSD9UhkI1kKpB3Hhd4gK61pCftsEq16tG1PWL42hR4m6brkeS7IAPyJag+pB7k8dyOtAMttuBRXpX5s3+jDSrEGOq+lwFAU4d6O8kwyZ24Zbcm9Bt79/nEePIkqFGFvGWuneFjA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(396003)(136003)(451199021)(46966006)(36840700001)(40470700004)(26005)(1076003)(16526019)(336012)(2616005)(426003)(966005)(83380400001)(47076005)(36860700001)(186003)(82310400005)(6666004)(70206006)(82740400003)(2906002)(70586007)(81166007)(356005)(7696005)(40460700003)(44832011)(8676002)(8936002)(5660300002)(110136005)(54906003)(36756003)(478600001)(86362001)(41300700001)(40480700001)(316002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2023 10:18:34.1871
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b819aa4-c021-4717-b41c-08db68d2e1bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT078.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6662

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

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h |  2 ++
 drivers/iommu/amd/init.c            | 11 +++++++++++
 drivers/iommu/amd/iommu.c           |  9 ++++++++-
 4 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 317d5c26c614..156f57b4f78c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -16,6 +16,7 @@ irqreturn_t amd_iommu_int_handler(int irq, void *data);
 void amd_iommu_apply_erratum_63(struct amd_iommu *iommu, u16 devid);
 void amd_iommu_restart_event_logging(struct amd_iommu *iommu);
 void amd_iommu_restart_ga_log(struct amd_iommu *iommu);
+void amd_iommu_restart_ppr_log(struct amd_iommu *iommu);
 void amd_iommu_set_rlookup_table(struct amd_iommu *iommu, u16 devid);
 
 #ifdef CONFIG_AMD_IOMMU_DEBUGFS
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 318b84cf47f6..a993e1bdb70b 100644
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
index 3c21e9333899..9908cd4f1c31 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -795,6 +795,17 @@ void amd_iommu_restart_ga_log(struct amd_iommu *iommu)
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
index a29548d98b6a..3c179d548ecd 100644
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

