Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46FBA100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:16:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSke9I/HWbXbHTrHfOwDwBPXhvGjeepiCOw0naxVDBRD/UtxSFmm9XC12XO0k2hw+9fRtKnfzuwhS+jwPo1UXUweFBA3yMBhZ2DUbfb8O9st5m6n1GOXK3fBtCUa+lY+xISxTVzALVmQnv0HkPpTy3pXupxNhlc5rOoh4pOessAsc4WRqYrBETDCjoBVDBpewWLXr0uEYJ/Y2LcWziKfY6PSXc2N/80Ls4vADJtuO2l0ZLH6iHPgdM/xQHf9h4PIXA+cdCgRfUjIDDtSmCsE1+3craGNZsgfjswTKzep85C1BSF7P2SW1D+UwXeLfsCVPTeTloh5Y6LEo+X74S0nlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lJbcUKvyPb1VKFWBonCFtFrsKIRk7FOhOHKW0+0mxQ=;
 b=iErz5H7Jfs6j9Fkn1cvUBHZOQHH7s3dRscuNhnCGmWTnhZVOcxUyuJAuiYGQhUAynACrosJCwUUykxYDgk1yklaboDjtEYyyWlY1WqngekNDtyDRH/wmZeE44w0p/koAq55SGWHs7mwlg5GuDYKbKKF97xuTG3imbc5RRjhFdN1G9msFtXvGaMJNM4VPAQZbdayiDecGFGaFnN4H8YaVeExlDhhBC50YnAh+4avlo3yds8m03K630qhbps4cQnZGfD/eABHaXA+5wz87pPpv08f20XxLYF2ndNjFpV5k+OY9WrjsslPq/5RL+5gR1Ce5gXtpSqLGqUEkejz7HWX1+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lJbcUKvyPb1VKFWBonCFtFrsKIRk7FOhOHKW0+0mxQ=;
 b=ItiYBWPF/ftEbZI+0Z69Acq00UzAEwPBHXwh7IdndGELBi4zGNfAHXn6cEXHyaguJazvvyfvK40WzhfII11sUT3fzHpaFlx62WXc0DPi+b1DV8aRpHlJCqaayI8yWnCXiceByEHFebz7xAclpR2EOGZV25eRGdn9GlNUqJBAf2s=
Received: from SJ0PR03CA0150.namprd03.prod.outlook.com (2603:10b6:a03:33c::35)
 by PH7PR12MB8124.namprd12.prod.outlook.com (2603:10b6:510:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31; Wed, 12 Jul
 2023 14:16:23 +0000
Received: from DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:33c:cafe::f2) by SJ0PR03CA0150.outlook.office365.com
 (2603:10b6:a03:33c::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.32 via Frontend
 Transport; Wed, 12 Jul 2023 14:16:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT112.mail.protection.outlook.com (10.13.173.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.22 via Frontend Transport; Wed, 12 Jul 2023 14:16:23 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:16:21 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 02/21] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Wed, 12 Jul 2023 14:14:57 +0000
Message-ID: <20230712141516.154144-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT112:EE_|PH7PR12MB8124:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ad22586-4e40-4c56-8213-08db82e2925d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3rgwuopw1DJSAz4J/ZCw/XZJsJfXYnmBqErb3Zvc6hGcD3z3dF7vLwbaDbJ7PVWPmtqHhRZZWWfBV6jIcculKIBUn/4geeizjVXffcTErrR/b50Vg/OQuxI3nHoB/J5nxFPcgUbWysEvIZN0xAvrybY30YLtO7XlKspEvAMeV97l/+XZTJCjGo3yZUrcuKsnEgYGaauWD1Jsl4AW728Q4X4+amGizxVAZ0HONXKxPgtgHu1aF3GUdCbV57jopiQ6jNuEbkCcUyfTJBMTbO/VwMUB+Pfa+RrzEei7kFVfdilEmK+zKE18LlEi4iWN/+02PRXIGoaU6j54z+3sD8+WasxJiC1v8rG1M7xDqYlVWjzCqtc2durrMAf9Muzmt/oVQ82b63+WXdPOMwvl6H5oOVOvWN09+/c08NOkII4Z9XS19e/Tk7IS3W2aVLMcHAVa2APY/9+lT33CHbPeUppMAqeAK09Twk1z+64OgSKrfO4m8WdFSZ0GuYyY8JjGjgGs0zgDkgOOrFk7GUwkWeLKnfmsZkwhMhCSXGDVIZjHJpbArCwaqcXfFK67eOKFQTezPxbgp8Mwi+s0p6aOVBUeiEdTCpvmWoOU7lLpzULLcrF4Rsbz3bPOvTOBeyc5o+D9qSjRiEWNa1UUgkEf75F4eWjDoE/argtmtUfurdylFcoIz5j1n3yc87KFX5Fs9CW2kPD1z+QUbHsorOxig1juCn+HqqUAZFWbhXlQ9XdrIEn/pebWt8bC5zkuQiVRfp/Ji6sUDuTYY9khl7zp2+C++g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(136003)(39860400002)(451199021)(40470700004)(46966006)(36840700001)(44832011)(4326008)(70586007)(70206006)(316002)(2906002)(41300700001)(478600001)(8936002)(8676002)(5660300002)(54906003)(110136005)(36860700001)(40460700003)(7696005)(6666004)(40480700001)(26005)(1076003)(186003)(336012)(36756003)(83380400001)(426003)(47076005)(16526019)(82740400003)(356005)(81166007)(82310400005)(2616005)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:16:23.1941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ad22586-4e40-4c56-8213-08db82e2925d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8124

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To allow inclusion in other files in subsequent patches.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
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

