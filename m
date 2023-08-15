Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B149510788
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:23:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HMgsbHsX+/SZ02kI8lILrvIwMMYL22cuATRd8WLRW/i68xZb1uuVBzvwwOt/K9tCO6ypsGVlwGH1Ik7JmpURvFIyxH7OvtYylO8+ukGVFUS9rJDBQ1hteXXVX5qZIod6v2jCg0NhaeFUUDGZaClX894b3+EYZYGeFpaCh5iLzBwfAwexFHS2IBrQ+PV8UfDHv65sgZ65iuVvXUUD+TIpsdTsGtGNIDKEc1nwtblc08q8PBnH68UlNVFYyQmmt1qFsqAbQbFii7Y981W/hM9afvffAAanOKY92SI9EJ4vf0NcIYhrW+JlBg/7A5vHTkc6cF35L1YysNC7BXz2ZZ2M3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gDJrvFvQUqrh2dJK3yHHY43pdNtgTXAwUpBLDdxL9U=;
 b=J56tZWzLO4b4DlbSpedYXdEZ7CRlIjkUTwgnUXkFURAmockTDwEpxIcly127HcsZcQ4J5UNgDKZzd9KbNuItQsWTNNz43BivPTPojKrXUa7BEQ/DkKJMBCsIUaAnYrLVSG+r0jtILeOcsxBcDNSRMZjke/HYm4sEvJ9dPjoI83v8xoYfIoi4MgPh+BLam31xx2Ca7LN3dhvdxRrJNApQCB2xXxfJzLMNq0LQpSdqG8teNqgkKaRchwyKYqvRBAitD1trO7imyilfm/oZiGSwoVQyAum2ilUlHcZHSqxks30vR/dkPIKJt6mRs/YlpbdEsSdtcEw93W7bU+tp1TV5Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gDJrvFvQUqrh2dJK3yHHY43pdNtgTXAwUpBLDdxL9U=;
 b=2v9pElymVYAr5TZTwdvht4RZud/RhMcvhPsqP168X08dMPa4q8gQLJZfEZPICCe0tiPfQWGTpfdLkp5PZMe9PtGetJ4JoNTuXYD8NBKeeWXGn3+38Lvm28/ZRzNTvlL1M0a8HZVmyjlnuocu7sMJ0urssS2oBG1ODtznb1sCD4s=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by MW4PR12MB7360.namprd12.prod.outlook.com (2603:10b6:303:22b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:23:09 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::c5) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 10:23:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:23:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:23:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 02/14] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Tue, 15 Aug 2023 10:21:50 +0000
Message-ID: <20230815102202.565012-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|MW4PR12MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: c9a41053-a8fa-4c63-8f00-08db9d799f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tm81zyquQRFTsOvROz1B/8eVOq137mY0qKXppQ0I7DSn+XAj7lav2r5M8Sw8W79pB6c2vecZ7miCOPr0sYPBd41FKpUgfUddn4rM1y7Bapzs4MzHKhK+yXi3/LumsZrlnmI9IM93DrvyNYCW3I0Nq7Y46K9L3OQUVxA50vtMriCQ5+C5Fe47aRjv2/OcWIdLGsX9APVdg3Qpul7jOrhDp9rx8Mu5OoDhijf9gCQ8kPTrUbh/ue0pvPlLvHGyHHAhZrSbAMAbaLq3GlZOHfXuCLzt0P/VVuDcSlbVereLWhllYl9YkzFmaakIgrEACJaZkFZqfkwjE7AZPHfplVrpOhkN9MXb30NeOfHIhG60zDUOVNvrqBdKbQGHDem/BTac5fBD9PPWi5ThZhCYsSGnqUc/r2QRs8nQTPxddxB7ZXdMJZ0K7lqw7AS1m45DFT2mYTiGJbj4gHHLQDi+jPxZzE/1Qz/6y3h23WQr6G7pMFnIiRGfSFLu3uwVRYNbI1WXriFSBvtE9yYCt6CjmEwbk2XrR8jkVWvZatIyzAijK8cKLfub/re5KJ/XiqOqaWmldC0H5IfF5DIPWj2WLR1Pk60aztSprtwLAIaSfuyXvz809JhnkBLuQexkTzy6nZANfa9kM3SxNhrysBZ65k7Jw8AztoKHkp1r3w9OZStaMbIhnjDJugtJCU/1oLwB0xjY0dI1kVm9cTj36/EiZWQfcDWvniJAF9V75EHSH3Ma1B5QyxksMSHJ+GksnWr22q9dFqQhP610RhaYwo1HXoMqqUHV3TD32YW3LZ64u8XNcoBu/395epUd+xcfH/ccSxmL
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(346002)(39860400002)(396003)(1800799006)(186006)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(110136005)(6666004)(478600001)(70586007)(70206006)(7696005)(26005)(1076003)(2616005)(336012)(426003)(40480700001)(54906003)(8676002)(44832011)(4326008)(41300700001)(316002)(8936002)(5660300002)(16526019)(82740400003)(356005)(81166007)(36756003)(86362001)(47076005)(83380400001)(2906002)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:23:09.0889
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c9a41053-a8fa-4c63-8f00-08db9d799f4f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7360

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

