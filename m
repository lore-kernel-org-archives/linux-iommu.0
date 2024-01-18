Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452ADB641
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563421; cv=fail; b=KkHa3CJbYgxG4mBH1QKHSbCDLkzWU7t5QQ0CCpXGmZkcbOFu1p4LsC4AOzOBosRwaWSRkaWaZpeWDtRwI6d5edLvCs4+40noG8nGZ8pTLPxGxT0IJPLP4gjZ+69H/oCHzQz1TT+XFT2rIB+NKSeRZ/R9gpkbjwg+DhqucXvfMh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563421; c=relaxed/simple;
	bh=9NBliNMx0X8LGaJdVIt7k6VgBfu9OQzcQaT/hEdEI+0=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=uPTDA2Od6q7sHDCLmAU5gSzhEln24LBjNyeCphIc4DmrvbPGOheG0oWBCX0gKZRgHb9dJqvXF/gE6WFGKgAzmHJus+jJYbQ1/a5Qw6tgumd7oXpnN0IuJhCuISjeKuUuLSa/xBNl0/u3aET5aYsYiz7EP/SKAhoKAvyImjDCAME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=t7X5kmYj; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="t7X5kmYj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6kCzGGzJ/B+Cc1uusbrfs22phEN9JNi7umVhRMGvTridO0+UdZxS7NfOhcVx3lCHWwMWnCXWfRSWbKt5brsSd+TJ9Z+KAIWpCE7j9+9/fv14wNMaWdCmwdKXTOHgawI7FbHHTuXYV6pSwtl6wrH0aW/3aLVT3j2ehrRlqLz99BG+nEN5ODfdq1spYZqjuNMPFL3Y20tYxz1azIzFJfgjQLRf3XlXYNiNJGvb+LQP/gkgyCD6Ois0v+/1yHZkDZ1/CKflB0ol21cJIqQQargCFW2lu6RmV+v7sr+Jei5i6rW2tSIuh+nWPvVMLOYXdcww4SHJ++CbWBLpHkfZ7YzFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cidfoLED6z25LU81q5WsOyOelN2X1KgUrCNoknprVnA=;
 b=j4bfv6hGIv6xasa+Wwl2nGdGHgTtsJw7S0Tek/VFxLNNMZ3h02lNxn2m8o97DUp8S5XOpvc9BtkWKwPlY9IPEbgBp905CPALqDWOd6vrA7rYbShS1nOVx24LBBh7k8/XVtL40AEUqAqcCO2N8byknmnMTqi1bErY/AZM90ATT61C1YrI9NG4jc8o9kPBhUG2xnYyEjXA4yc/acsALW66AYrmg16J2jJNdDNpDDPhur9gE4plt+0rwXGRib+DoHZ9tnmbal1qV43Id++RdjZuhB0S0y0mQsvnaZQWw76jVTW8K6a7sSB8BA0A/jItnSD/AV5tLkTa/qVWzkyRal3GKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cidfoLED6z25LU81q5WsOyOelN2X1KgUrCNoknprVnA=;
 b=t7X5kmYjJLtf9qpf0Ep1tliyyExY9S0CQruEAVpju9tuGBXYWZCK6UiOzQz7n5WjWN/xD/hoKcwV2x6NEsYc8YbkY/W3V2JNbylmNqq8wtEmzNfofcQp0flC2UhmvOABK7kpAQo+v0ujyh3hli8h02qbVWBPMEzR1PcNXsxtNkk=
Received: from SA9PR13CA0115.namprd13.prod.outlook.com (2603:10b6:806:24::30)
 by PH8PR12MB6817.namprd12.prod.outlook.com (2603:10b6:510:1c8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:36:57 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:24:cafe::a6) by SA9PR13CA0115.outlook.office365.com
 (2603:10b6:806:24::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Thu, 18 Jan 2024 07:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:36:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:36:54 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 06/14] iommu/amd: Define per-IOMMU iopf_queue
Date: Thu, 18 Jan 2024 07:33:31 +0000
Message-ID: <20240118073339.6978-7-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|PH8PR12MB6817:EE_
X-MS-Office365-Filtering-Correlation-Id: 81a31420-3f69-44df-a348-08dc17f83ffc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IC6pYO8xAWpo2krslTbNSAUck9As/hJbJ87L6A5bD4q1KJ306ASZbe6YM7L62DfaYtrCDHGo1ilaN2m2Ha06BAPwMIBervBfthnI+Riw1/Snbhe19KQPHCV4llYHgCWu9rcXVgvjvtsmtpzm8XciFuFztljjQafWH3fVwhYoViQdfr6qxDDJTvpZOtSCD+o5G7F+ek5z43rJ/EiXT+aKkkkhwIp0WSwwcSh0xlPdAwlzaIytM6Ns8GFd5T2A6EihxdSfRJD8Z4EuzuV95MG6x3Da4vrHJSDgwQHGkq0WJfPqA2J446kJkvH48YOY9lQntISZSxReRiLEJhjdRGHoVY8+zMpQQ0OyygAXyntrZcMT67LnfBHY4T7aUYWKtXyIWl6S7AJsSrWtgQIh+coSqEr7Bdu7hyw/P/0DrXI0x07qns5mhJbJNklhMgrW54ep7/DvcaJOccZUqTXT29WZ7NIdTcf3N+uEma10OFs+EJo9BEO+cKxzocqjlCqcNS+6uEoeaX1gNPjd46quBOZ6+L3HHOUA+Ik0AYE7pWlgR7aoHnhPwzMibhuiDW1P3FHKFKLV2HNHobVNy0Y5oUCcpKgokIzJzsbpDepWJWq2sk5ja16JH3JEij1XNTxQlRW23InBG9Z2qQVa/6Y6LCZC8+3G9eGb/co89u3KvA7aKHcA6J2fpuGsMW0X1s9W80cuRyE1Dj+3I5ELzAbim0goZFMJ/CV/5ZN2yMYsfr4e+L/LVw4COBGWYafGbURy70iT3WpoLhYkrf8wzBD3h8c6Fw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(136003)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(41300700001)(26005)(336012)(16526019)(83380400001)(426003)(86362001)(36756003)(82740400003)(81166007)(356005)(44832011)(8936002)(8676002)(4326008)(5660300002)(7696005)(1076003)(2616005)(47076005)(36860700001)(54906003)(70586007)(70206006)(316002)(110136005)(2906002)(6666004)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:36:57.1992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81a31420-3f69-44df-a348-08dc17f83ffc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6817

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

AMD IOMMU hardware supports PCI Peripheral Paging Request (PPR) using
a PPR log, which is a circular buffer containing requests from downstream
end-point devices.

There is one PPR log per IOMMU instance. Therefore, allocate an iopf_queue
per IOMMU instance during driver initialization, and free the queue during
driver deinitialization.

Also rename enable_iommus_v2() -> enable_iommus_ppr() to reflect its
usage.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       |  5 ++++
 drivers/iommu/amd/amd_iommu_types.h |  4 +++
 drivers/iommu/amd/init.c            | 12 ++++++---
 drivers/iommu/amd/ppr.c             | 42 +++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 353d59111cb2..f9e921cf97ca 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -45,6 +45,11 @@ extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
 bool amd_iommu_pasid_supported(void);
+
+/* IOPF */
+int amd_iommu_iopf_init(struct amd_iommu *iommu);
+void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d5786c33aee6..f3a0c3756d0d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -770,6 +770,10 @@ struct amd_iommu {
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
index d25a706adcfc..426db9ea3718 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1638,6 +1638,7 @@ static void __init free_iommu_one(struct amd_iommu *iommu)
 	amd_iommu_free_ppr_log(iommu);
 	free_ga_log(iommu);
 	iommu_unmap_mmio_space(iommu);
+	amd_iommu_iopf_uninit(iommu);
 }
 
 static void __init free_iommu_all(void)
@@ -2789,12 +2790,17 @@ static void early_enable_iommus(void)
 	}
 }
 
-static void enable_iommus_v2(void)
+static void enable_iommus_ppr(void)
 {
 	struct amd_iommu *iommu;
 
-	for_each_iommu(iommu)
+	if (!amd_iommu_gt_ppr_supported())
+		return;
+
+	for_each_iommu(iommu) {
 		amd_iommu_enable_ppr_log(iommu);
+		amd_iommu_iopf_init(iommu);
+	}
 }
 
 static void enable_iommus_vapic(void)
@@ -3130,7 +3136,7 @@ static int amd_iommu_enable_interrupts(void)
 	 * PPR and GA log interrupt for all IOMMUs.
 	 */
 	enable_iommus_vapic();
-	enable_iommus_v2();
+	enable_iommus_ppr();
 
 out:
 	return ret;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index d43a616c0c36..1eb0b737afb5 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -106,3 +106,45 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
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

