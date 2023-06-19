Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2069.outbound.protection.outlook.com [40.107.96.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930D2AD3C
	for <iommu@lists.linux.dev>; Mon, 19 Jun 2023 13:24:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cP6Q/qsXKeQZr66AP1cpNCkmu5RRK4OS1KkhleW3vyQSUBRSSYVE5F8XeZBM7qPh43WDEYslg6qBU0m4cdXlu0+2RJW+aLKmt7dr78SH5pYX/3fmh+sy95XVkkRV4Ut4sGlbP6BrlTl6ccWjUSYmJxWr5fdXadMEFbr6FrK/8PWlajxZF5RqfeEbXhtkQwyzyiEz8UhnNnNxc9cqXVVoL5W+LFuzbWn9ryBPHe1n95zn9nSQXtfVycZ+LsVAui2q4bfK4LT4PFCYmnYNPjad0qKmLH8iNzaZ+dCr6ThqHfKD8fDPprOBiixkEFsiO2ua8Y6acvd2QO0qPvQnF/ryKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EAyF/6vyEXsDZpCE/0xAYXezLW0B8p7VFpoGWMxwXhw=;
 b=SnSEw7ZjVI9WwkvfEzjDRCjTXGi0k4FvefkCHfX5rbNF/g8AKGKwfPh4632hStGLeY3O2uNny6xbylUC2k4EqZAX2QVd8tYDg5dloATNkiX0LivkLpaetB3V6zVxht5Mg3JLfXcKvFZoktNDEafU9ZpIiehXuYZPULJ1OWUK41RuprkYYMBewqMSpIAbZxU62GYa/JbqDn+ESla+FnHk0A9IAtz+rzdBBFABrp6InZZe4ecruayocBqQLgvZjw67qBmXUu5IjDQuU4DyFfu9Ch+pGbDHp6PCuJqiBVA1XGK5qNGW2xseEeecicAdp1mJ0xOgJ8fka3rfWr/t5IDi8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EAyF/6vyEXsDZpCE/0xAYXezLW0B8p7VFpoGWMxwXhw=;
 b=Qf0ILRxWmhp97cRxsaGdtcsfmNPd1/lQmKJihox68ZCJH+2J4edArbUxPwkPzixKKAJxmMPQZ864nEav4dhZO7sAcJ1P3W37qsNPHPb2bC3W2Mdslv1GJ/keBOlfc0NpF3DL/NS8M3xy89tbuw4Fv897EmzSBAvUaMTxewvjq/Q=
Received: from MW4PR03CA0277.namprd03.prod.outlook.com (2603:10b6:303:b5::12)
 by LV3PR12MB9188.namprd12.prod.outlook.com (2603:10b6:408:19b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Mon, 19 Jun
 2023 13:24:30 +0000
Received: from CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::31) by MW4PR03CA0277.outlook.office365.com
 (2603:10b6:303:b5::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37 via Frontend
 Transport; Mon, 19 Jun 2023 13:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT103.mail.protection.outlook.com (10.13.174.252) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6500.37 via Frontend Transport; Mon, 19 Jun 2023 13:24:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 19 Jun
 2023 08:24:26 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Jerry Snitselaar <jsnitsel@redhat.com>
Subject: [PATCH v2 2/2] iommu/amd: Handle PPR log overflow
Date: Mon, 19 Jun 2023 13:23:46 +0000
Message-ID: <20230619132346.6021-3-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT103:EE_|LV3PR12MB9188:EE_
X-MS-Office365-Filtering-Correlation-Id: f12e57db-307d-4f11-e2e0-08db70c88307
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TMS7bUpo1WljGRj9vNAmc2z5lHERQA8jvf9bpfH5zFNiXJLVJrBY4n5tyaMIUvYeLyQYxS38JZ/yr0AvnyU7c2l05N/9uYLAvetjFwkw1oUfGzdiI0PE/jDJMeF9ZdgIK96v63N2GBbMMcPvQw+nrTRLabvpvP06f1+4ueu+/lk9F46VychQoVd0CC9pH++PDaC9+2NpAoWC0idhc14fHRs4NHMXRswKPi4aI35lAVBGGcVosB/jjvYTNt/WlQRHD/OkJe8pkwiJk3BQmrJH9T+f7d/0uHhH+C6zz8LX9uMtlygk6dOo78gTrzCZRSvT9dWUbi0kBIHFUF51IObthjL6nVM/+uMWSqRJ9fpqcMJ1/wmuEcZaZAek0VSHDP420X1KYqmmjJtJdC+/pa0XvDOTf55ZMGmbWwf0BR7uQEPyr8zN7XZ3uikwY2TYZ6E14C02QYKq6nQTh3t5JxcsNDvjKk4maBuK0Tv2d9FjuUZ8Ixltl0fkyB0SowGOVRsXpn11ZX88hienBW/GL9BUEIopvgEKmZZ8o9Rov+c3vpqTaAL3UBs+59+2G1wVEeB96l3QgXPt6KeKsKeP9S9k3HeGivb5TtX8gV1tUr19JomVdHivcVV5/aM16Ojz9wWaFgJ+RDyzz7Cek9m6aYv4CmgnJf7RnJ1DfolSZ1OtAJOsTqfDmVSdujxWkIARIiV3DnY7DQdMf9tYuwcyZWsduJjI38qHuQ189ZeRH1f0bR01WSw4MNsz/imOTJv4I6XvN1Oblb+PO3GOmcubWH9+Vw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(478600001)(40480700001)(2906002)(40460700003)(966005)(54906003)(7696005)(6666004)(81166007)(2616005)(356005)(47076005)(336012)(426003)(110136005)(86362001)(36756003)(26005)(186003)(1076003)(16526019)(70586007)(8936002)(8676002)(70206006)(82310400005)(5660300002)(44832011)(316002)(36860700001)(4326008)(82740400003)(83380400001)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2023 13:24:29.5440
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f12e57db-307d-4f11-e2e0-08db70c88307
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT103.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9188

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

