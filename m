Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2060.outbound.protection.outlook.com [40.107.220.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF5723AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:37:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9FM8YGqwVudxGEatjUE7AYIu2roum4pqd+h3JszA3PQChg5tQi1arfO0iuftuXiD6mTIwUa4INoS0QajS4Wt2bUTEYU0kj33/bC/Rn0hytgtxT6uxNju5/Yq3ETnwIu+9F9vJiajFIjzLaU9mrMcBcsNtaYRcJx13lNm4tIXUYIAdyyn3VRZMjuWHiruoypFHVrRsuMgq5NQQUBtJcih/+z23UWKkwWkePkcKuJcokNo855qikguNt4JXmD2462gsdlUI4TJW4PAZRFxrgqfwmT7K0cimG9h29OazfwtnpSnm1l33Bvf2Jgi/KLDW+bS+ToAba0zhc8/UtXFTzO4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkkALXGb9nPRYwkNYtpCt+Atuh9Wi8ZARCDN0vK4ucE=;
 b=hydvJQEpXqFnczPKBVPaCHmos2cpTuiuq4Wi0N+VVhlbDKW+PHcU2jdt7DUuByGhGUyr3zd5subgvV8e8LURxAICKVm6sxHFnOIPTdK0ta7JNiQNQ8itpPKXZzLeJ1q+bPGi4wWo7nm2EbPKy6hvw3qWeHBNH5ua7Ndpwn3HRZn7RACsA+BBzq4O7nOh/fbxy9Z2rtC8aa+bhITCAkXBCaa8dWP9YEeLAWm6ax/dLRhHtTCMvt5mpYfS2Lxiei6k8/MmnuMMg0OUQtFAFcWQMJ156ANORA3moOumnUPnFtTN/mWdc10KJaR+1VGl9A0otQE2vpuDhdLbpUkHX7l4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkkALXGb9nPRYwkNYtpCt+Atuh9Wi8ZARCDN0vK4ucE=;
 b=GPFQnuHYEsvYezRY2q7HMvCP5xkyUW4R6yOJH0rp1Z5hcLA+7HSB0ofKCtsqwYVW/EAEu6yUWiAecgVa5L4JoqC0k2KAGMP9ElmL0NVJNurzGRzPYzafsO7pRRL9damW5zepBXJyNBdeLJjfSNGFSIcPbxMtZwMTrZe51EJiBkg=
Received: from MW2PR16CA0070.namprd16.prod.outlook.com (2603:10b6:907:1::47)
 by BN9PR12MB5212.namprd12.prod.outlook.com (2603:10b6:408:11d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:37:18 +0000
Received: from CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
 (2603:10b6:907:1:cafe::79) by MW2PR16CA0070.outlook.office365.com
 (2603:10b6:907:1::47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:37:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT070.mail.protection.outlook.com (10.13.175.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:37:17 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:37:03 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 02/16] iommu/amd: Consolidate timeout pre-define to amd_iommu_type.h
Date: Fri, 28 Jul 2023 05:35:55 +0000
Message-ID: <20230728053609.165183-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT070:EE_|BN9PR12MB5212:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b95ce1d-49b1-4d3f-7d27-08db8f2cb4ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xT+ffuhISu3Psp2fumjkeplG//826GoMKKzvbinEyKzwxrbIta6VJ/sxFpxr2qEeiRjvLtsen5pQ8M41q4wbQTL00TaPWxsj5od8UkDSp/AsMJ/pJP29htkqImY5npbTKEDYP6LQUCtGTt/OWzVQ99Nhi1tdrZt2VMvVHIYjxpIFV+rWOPOAhpWkO6k7saQRtGEYparXqOIV+DANd+9KiW6+a0CgBt4nmgdthjJ9Gxmc4Y9XuhCOJIHjAjss5VOBmI1TzklgrqZlHpol9dkrZjLvQrFQnnpgD9jBbJ3u8fS0vOhBO/0HD+uWw+wXXkIm0ojMj+x6rp07GRyYzHQcWEXckbbQnK8+qB2/Oavbp9R2bN6TETQfJQmkzWCYmlRUg5/gM5pbGbEZNwxq8FcNHnlxK4mj0Hkjjd0TW3KzD0zQqhnPOGoJUgCDr88wFT1kn0kYE/1hLvvJ2Mw1BtyXCT9QLNloQvhPRRyBHMg4KVEc5uNUOgS/mU3p+ngUl0kwGkjwhMSdKSzO/b7DzZt4ESZvKnAvLddiJjLzFIYedyPZpQPV56YxBitEecCrP1iizwyNlS2/jsZ25A/+fpL0hAbfpXW23Q5WiBrKYNLRyr/HGgegG5U2zTXzmjU2eP+D6Nfik2+uhF0ED7n1LWs1V7Gn8w8z13AHDuWXhDB7r5qTlDpc2FrDCgSxWdxXlsmm2xeohO5LjSX/AvjWWFgTQC1lot2iXJLJ+/HOe05tSVDKo9I6Wy2KFyy3Un8lm2Xc3oeqgMMg4xjLShcBxHnOcw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(46966006)(36840700001)(40470700004)(36860700001)(110136005)(6666004)(7696005)(54906003)(26005)(478600001)(83380400001)(40460700003)(36756003)(86362001)(40480700001)(2906002)(356005)(2616005)(426003)(336012)(47076005)(1076003)(186003)(16526019)(8936002)(82740400003)(4326008)(81166007)(44832011)(8676002)(70206006)(70586007)(41300700001)(316002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:37:17.8446
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b95ce1d-49b1-4d3f-7d27-08db8f2cb4ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT070.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5212

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

