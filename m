Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E2BA1FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:43:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKHjFkEqKSQn8EA68ADH8ksTMkfGYYHmTPO70H35OFFQuegvMHsLQsJdJUZkdZAZiycP8YCdGId5ddYXdb8h11RJzY0+fZmpYzJTcdKwH0Rz2Vn3Ymo3IoxTEdyYNHi0ZvIY0/LEIvognXTT104GjSrC2E/a+9VClLnI53IM3QIkGEHrvaQd9upGz+Mj2uKw4zzYYpAhYXxeqxgTZw2Mj4ntofToaZkZ9meD3yHblyisJsD4jAYn87r+kOEEo/llb7qBjplHZZJpNHOVIi1OSbQavYoAaQyaWdTvwYdHm/Jtujnn1OXFiuRmjweGCYjZidnj3bgTfy8MsYtASl9aWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0j9uoJnCfqf4xzB+d1/xefxH2l79lQ+yoYoOyQCgGo=;
 b=Pxth8joHM6LCLeYDrz8NAFFbybZUd6a09mNdF17b08ZflbhEX/NcI1kINxW3rJZNzmy+qb7TJUce1U3ndCPABWwiJ5yJcG4vaVTGjEhMWYyYE1oD9axnHTuLm3D4TktQ6Albnv7sHQn4T9mvcerNdpB85gx2zKu3BrqpZsWmIxOgsKhaCQTmG47J0V1V28B5NPu1xMgYKX1VQn1TXynQUZna0aN8mHWc/vc5Q4JN28N+n6Elw1kcH7jnMhDqo6djw12HsC9/yPKWdoRfJYDZi8v16lsDVsYKfVeqOtBE4P3ct8OzDtDDQw165uwe30MJrK8Cb21ZFqvq4xFKoG2khA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g0j9uoJnCfqf4xzB+d1/xefxH2l79lQ+yoYoOyQCgGo=;
 b=K0lrrRbnKZVa06sEWPsMgRuPHTL7MaxNqBiOz3RtlXlt2ogJ9/16b1OR6noI/xBGtfpKIETkiSYeMh/ZdTMTl190HbnXi+AXa/5mcPnlzz90JkILE3FEemCjbaK1rRGIjtk/PTPWV+RcquIoWpBTtDBkQZs5wUDGqWnapU1vcq0=
Received: from CYZPR02CA0024.namprd02.prod.outlook.com (2603:10b6:930:a1::13)
 by CH3PR12MB7596.namprd12.prod.outlook.com (2603:10b6:610:14b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:43:16 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:a1:cafe::31) by CYZPR02CA0024.outlook.office365.com
 (2603:10b6:930:a1::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20 via Frontend
 Transport; Fri, 4 Aug 2023 06:43:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:43:16 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:43:13 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 02/16] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Fri, 4 Aug 2023 06:42:02 +0000
Message-ID: <20230804064216.835544-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|CH3PR12MB7596:EE_
X-MS-Office365-Filtering-Correlation-Id: bc501a48-8d05-4d61-1e5b-08db94b6154d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5YUz9tuY/e11hH3Flg3mn8XZ56UeYDsrZhM/UhC5O+neQrD0qquBR6a+5ab5d5WGUC0UgfrF+bk/4xyEDQ6BQGxe7kvU4P+7lOOPGvtUoZTybLoe+eozNG030B+R4YJB+dTKHlVqTq6IRr8A8Vjc9o6tsPqyYlHBpQBs75mw/t9KsT5AsUzy6k1F32LUUsCu3ZWMTjx6vMGQ8s6dTDzjvQDDwGKh/CQKfwIc4mwHaDOH2dvc2QOltOdjEosmg/6qTuYmys+FWvX3LA33ru6Ihtu0Ohv0vqVxtn7Q2oI+ZXuaFoz98miDJgT6hK4OHlbo05Rkqq3mGKzlu0W2j8C/SxQrwEB1TYR1bvxjCfVto4EfIwrQvr7ZNRHJg2E85yjfbwTNdYjf9dtWwfVZIJanUJUEPMKxa9wh2EAE548w65WH4GINBV78NKVSYsgL4Flf7JYF2tlnmM8+lF3gkcCu6j68tD55TQXpECuUejb6OdISrNgceSyUyOEY774kqipQwXIC9tnMkJ6+oTr7iSW05XRDD9gRf09046cIy63B21UnmdNLd6mO48Uc/PaZ/RYyb2bPwjrh4sCCbTMLUgwd1fKOAJTwpTItdqk8hM8RwPnHIq6uwteu6uNmN47EsPnjsDzL/pmfE+Qsi73ZmtwiaSUUVKnZv7jBMeptnuFwVijPi79KtqlYvvQTytt69TpUn6yX5KRH/gSBnUYmFiwBe7rA4RWuVDu08Sp+kYSVZvgqwW+49hYQTI3tPH0h5KN64/K8Ms0OJ8MtdBleScgAng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(186006)(82310400008)(1800799003)(451199021)(40470700004)(36840700001)(46966006)(2906002)(40460700003)(44832011)(426003)(36756003)(2616005)(16526019)(47076005)(83380400001)(40480700001)(26005)(1076003)(86362001)(336012)(70586007)(70206006)(4326008)(41300700001)(316002)(7696005)(82740400003)(356005)(81166007)(54906003)(110136005)(478600001)(6666004)(8676002)(8936002)(5660300002)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:43:16.4297
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc501a48-8d05-4d61-1e5b-08db94b6154d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7596

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow inclusion in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  4 ++++
 drivers/iommu/amd/init.c            | 10 ++++------
 drivers/iommu/amd/iommu.c           |  2 --
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1930e918188f..13c582a2454a 100644
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
index 56b6cf8bf03f..dd586f69a9d8 100644
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

