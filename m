Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2058.outbound.protection.outlook.com [40.107.94.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1C8F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:23:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RTQqkvR4MpMHrizOJRnX3nLFMknTgVuoOgHiA930BSzH039PnWqljlVHs6jJLPLV0Bp5Y0mo3z6mnSaY5Mphxqs3+SqxiBgMzWjzM+sMAiHF3GfTqdvTZ3cOLJe+LJ+GSbOnmSiPRihAYn10NwMMLukBl9qYL7mdeZIsRk7UORB+o9AqdcYB0S7Hw36U4w5xr4JNV+Gvk8H6G4EfPknivpfJu3WrfnfjGO2wCXNCgADTfzr3HA4f8bh95dnsEVNX5QXsjPxjrnHR8MjqNVUwgS23zehU5kqhJJH6LV/q4oN+MsE+1kjGf0PIawjBsQWRn9UVlKwVWq0YQvu1Xy6j8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fM0/d5bt5S+CRZVhRexowRaKhhO1xFZKCoxXhhD0zuw=;
 b=fWanGto4g3/IFWqHurtzyLwT/l1kds5uxmxIR7LcdKeFk8drzKAlz9FTPYBLM6fWLQUgH8DsXqKF6Y4fReofD80ALKuHcoCYt1XUmxaiq6+6qt7164rYl0L431iSBLlDoYQrPtOlHhvQRGADAK7PaLfPMLVZ1I8gSywVazIZn2cmkeh4Z/AjlkGH9oZQO05MIrfTA9Y54lEuZbq3w+eAgD3qu8u10HKr3CeN6f1iJ2/bRqjFQdj0Lciz+nupkUFhL3OOIrBHGLSD2oR0ed73G6qAUso6SX8jy84g/5M0vUkf4+6ftIkg7lHR6Y2Wrs58qITvXDLtAJmyWO2h3wtQew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fM0/d5bt5S+CRZVhRexowRaKhhO1xFZKCoxXhhD0zuw=;
 b=nlgU86vEeYAqGi5q+YjF31yhvlMJd3zIRfe/BrN1fOTa9sDReakiLx8NCpnpGSIcsmWgi6UBJQE79OcnZJP2ZrqwgLVXsxriQAuGlxP0DeDRhjGvRHQmWJRpmYHPe5rapAK0x0C5GCS1pmZO4qKFY2iEWoM3/m/C9wBXuor+Av4=
Received: from CYXPR02CA0089.namprd02.prod.outlook.com (2603:10b6:930:ce::12)
 by DS7PR12MB6334.namprd12.prod.outlook.com (2603:10b6:8:95::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 09:23:05 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:930:ce:cafe::13) by CYXPR02CA0089.outlook.office365.com
 (2603:10b6:930:ce::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.31 via Frontend
 Transport; Thu, 21 Sep 2023 09:23:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.78) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:23:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:23:01 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 02/14] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Thu, 21 Sep 2023 09:21:35 +0000
Message-ID: <20230921092147.5930-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230921092147.5930-1-vasant.hegde@amd.com>
References: <20230921092147.5930-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS7PR12MB6334:EE_
X-MS-Office365-Filtering-Correlation-Id: 7161b8ca-f32e-491e-a041-08dbba845c49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yo+J3sts0mQAEtbfpEwctS80XiHq3VEXzBrv9Pg65v3bkgPs4q05jPEsPmuNK72Q6cT8qitnMZACzLWGmzfGNpwLN8D2MkujIz+vmleib5qfbOCQwRJFdbJOxtPk37eI2K2NwAKT7yy3Xg5EhhGfwGBLNFBDsCxd7CNviK4uNT4fA2ydEBQvm4txv2q2oNCpJbUthaUFJe+6INaEmDtUKZ0+YYnr8mi/KUX2Y+uiW2woTRCKORtWI/Yt+xwBp77xyqYSzW+rxxNArMctL4zhBwyFBjV5J+84BgaTwy8/WEnBku5YuyPtWSJbrWe00NDPFxqZ629ordXYYW3XJ16KG4+uayfGz22+sgm5qqvwDuxb2rm0ly4ZriPRwQlA/9atm1A55btLiwdzOJlYnysKK4UpnW5rlsqLdI7ClyXVj78AmjvKI9uqbFOWSjlc8Xs21az/raDx9yHvNFkLfWDCB56EkaH6Gfktu98omDbN1PGcUlpaji95Jgf/SPab9DgD1PTvsQv0AfyX9ELXGqDT9HqBmCJ7p1x5DlzSkUno3Vv6GMwADjdYH7iQpa1SausFHFYU2pEwkd8bhQvmsOO1j7JJvYd2LZP5fhsxa44lOqR5ULOV7ndDQSoA+p25FVS+aRAF9MXineGmgtFiTlNDPl7aVZu1v72uaPYWGc1fDOf/29p7UpG47a9v9IQ5sbwiAuLBMrPuPYvDI2FhkCs40IXymE+kEIjU4VfKMW+n8vVDUb0b0FoD3YJrfdZC62b0EklYf5SInhtUna0psClT6Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(346002)(396003)(82310400011)(186009)(451199024)(1800799009)(46966006)(40470700004)(36840700001)(6666004)(7696005)(83380400001)(8676002)(5660300002)(8936002)(478600001)(47076005)(426003)(1076003)(2906002)(336012)(54906003)(70206006)(110136005)(316002)(70586007)(44832011)(26005)(41300700001)(4326008)(82740400003)(40460700003)(40480700001)(86362001)(2616005)(356005)(16526019)(36860700001)(36756003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:23:04.8741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7161b8ca-f32e-491e-a041-08dbba845c49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6334

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow inclusion in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 10 ++++------
 drivers/iommu/amd/iommu.c           |  2 --
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 081d8d0f29d5..a8d264026f7f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -451,6 +451,10 @@
 #define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
 #define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
 
+/* Timeout stuff */
+#define LOOP_TIMEOUT		100000
+#define MMIO_STATUS_TIMEOUT	2000000
+
 extern bool amd_iommu_dump;
 #define DUMP_printk(format, arg...)				\
 	do {							\
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 45efb7e5d725..852e40b13d20 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -83,8 +83,6 @@
 #define ACPI_DEVFLAG_LINT1              0x80
 #define ACPI_DEVFLAG_ATSDIS             0x10000000
 
-#define LOOP_TIMEOUT	2000000
-
 #define IVRS_GET_SBDF_ID(seg, bus, dev, fn)	(((seg & 0xffff) << 16) | ((bus & 0xff) << 8) \
 						 | ((dev & 0x1f) << 3) | (fn & 0x7))
 
@@ -985,14 +983,14 @@ static int iommu_ga_log_enable(struct amd_iommu *iommu)
 	iommu_feature_enable(iommu, CONTROL_GAINT_EN);
 	iommu_feature_enable(iommu, CONTROL_GALOG_EN);
 
-	for (i = 0; i < LOOP_TIMEOUT; ++i) {
+	for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
 		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 		if (status & (MMIO_STATUS_GALOG_RUN_MASK))
 			break;
 		udelay(10);
 	}
 
-	if (WARN_ON(i >= LOOP_TIMEOUT))
+	if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
 		return -EINVAL;
 
 	return 0;
@@ -2900,14 +2898,14 @@ static void enable_iommus_vapic(void)
 		 * Need to set and poll check the GALOGRun bit to zero before
 		 * we can set/ modify GA Log registers safely.
 		 */
-		for (i = 0; i < LOOP_TIMEOUT; ++i) {
+		for (i = 0; i < MMIO_STATUS_TIMEOUT; ++i) {
 			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
 			if (!(status & MMIO_STATUS_GALOG_RUN_MASK))
 				break;
 			udelay(10);
 		}
 
-		if (WARN_ON(i >= LOOP_TIMEOUT))
+		if (WARN_ON(i >= MMIO_STATUS_TIMEOUT))
 			return;
 	}
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 95bd7c25ba6f..6fa6a0527d7b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -44,8 +44,6 @@
 
 #define CMD_SET_TYPE(cmd, t) ((cmd)->data[1] |= ((t) << 28))
 
-#define LOOP_TIMEOUT	100000
-
 /* IO virtual address start page frame number */
 #define IOVA_START_PFN		(1)
 #define IOVA_PFN(addr)		((addr) >> PAGE_SHIFT)
-- 
2.31.1

