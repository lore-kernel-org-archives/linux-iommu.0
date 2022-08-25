Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2076.outbound.protection.outlook.com [40.107.101.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9109F1C30
	for <iommu@lists.linux.dev>; Thu, 25 Aug 2022 06:46:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQPjqLdmY7hgOj2gBXDuyQYhVv5L5tSWiXjPLti2UO6ZqPhqB2sOGhlW7apY8Yhyd2DQV19k+9ifCgtq31gZ/udRli8eH6+WtQbTGWQBsW5TAKlE7GwCIbZARrGDhnoYIfv3YckBqkG5vfpTDZrdB9xCIhN3ZD7Z47H1dnjV+sIpj3gyoRKR5x96hOOvTn01hcOIXy0YLMGUOsv9uHu6Ln0uH99JPsGRpF6/1qUlZx6vYzYz7XQ8qD4pr+pV1VjwOg3bAaiGt+rdiM2B3bgjSdvM5MKjunCHdhm6GNzBF38+Spg196mmujYxuYyzQt5OVm6uyWNRKtqj7YrKtjNzXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NjIURrQuKhCmjW0Z5JGMZ7jxb0ohNJePS3EiWABXH58=;
 b=RbqA4EJ/aCeh+NxBIID7yIqQ3ISh9cmUbdrSv77yO9kYmlLIttvQEOcZkO6ReH6c64JNz9qZskteqnQH5+37UeKzywUzP5aL3Z9SKdips68imcMypIUKNKOH6dE57LP9ZinBFZw1HJkjQKz34wgwhC6Rfmsl7RU+ieDA6xvHx2iYNuD7uWWrBq/9gudRDrlMe/LaLcYhvRj8Ie198LWITnJMHLXvYeOysmzo1YOPYZH32J4Wvs+cSxHSVbKU4/CU1Tnc/+oT+/4d2pxwbzNT9FwdfKcuQTUt8PNU0+EUd0z/Q0loKxNC17f+jMjk1IHH65XE52C9NyAlLK2IP75GWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NjIURrQuKhCmjW0Z5JGMZ7jxb0ohNJePS3EiWABXH58=;
 b=1vLMDxeOjOtXwpbwjCwKdA4zN0XethDlvpJEhX1/l1c/BMsZQs0Vdvw4uK6dMIsSZWIGTVHxn0q+wwq3ThEC0VLl4efyxFDq7kHDXe98l++EkVmSwg68sEH620COs2e5ApRWTFISM5L7I/sbwizcUk+gWcz0xf1WQg6V3XvGtwc=
Received: from DM5PR08CA0049.namprd08.prod.outlook.com (2603:10b6:4:60::38) by
 DM6PR12MB4154.namprd12.prod.outlook.com (2603:10b6:5:21d::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.14; Thu, 25 Aug 2022 06:46:04 +0000
Received: from DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:60:cafe::8a) by DM5PR08CA0049.outlook.office365.com
 (2603:10b6:4:60::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15 via Frontend
 Transport; Thu, 25 Aug 2022 06:46:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT010.mail.protection.outlook.com (10.13.172.222) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Thu, 25 Aug 2022 06:46:04 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 25 Aug
 2022 01:46:02 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <robin.murphy@arm.com>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 9/9] iommu/amd: Add command-line option to enable different page table
Date: Thu, 25 Aug 2022 06:39:39 +0000
Message-ID: <20220825063939.8360-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825063939.8360-1-vasant.hegde@amd.com>
References: <20220825063939.8360-1-vasant.hegde@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: 02bba0d1-bd36-4722-658f-08da86657b3c
X-MS-TrafficTypeDiagnostic: DM6PR12MB4154:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kjuWlVCGo7BpGOtJhxvZyNs6nmZK5GjbcCmUU9HIxUPq5iJfPqpInBzJRxsEaD1L2zX6dZaBtrn8qDIt4HlG9Qd4vJR05amK/lIKMjEzPDXmN3jLxUkXJwgGp9b2aOauOsLIG6y3330LCnc91R7IoSWUpTvqHawHxaTZ+li8stEFU7yFuRVuZYU4MXunRH6P1SliSzO5niV0X0KQ6tITVTCcy4NJX84EjLzUqZe9oLrtibpb59d4juFMSWQiLH4oBGuKKP9ON8lE74fFtWKIXfIoXwxxaxMXP84hZA3SiAwMm2eGRfhJXofvD4g9EwJwy8WffbDHOYANrz5Ox6Z7pRJ/lbDWprmV5R3Blx6u5m47E6fjODr/SCWlkBkSdcJkaN+CsazDWQ6pNQH/G7qun75Gi7Z0ahWFlL8BOa/EXJRp7NRnvsou6B0bjjo1xHSskNQm0gIDUPjLBlZPq03UfENjBca9XABBOg5qojZSeu7QyeerGi6FxS+Cuo/GMd6DqVUh55bTh9n2+YO9sAoFsBnLqZaOu3lvemq2wfUnqE6AvjWv1LLTJaFLKZJpLxEHFkKRADQEm6L7HbkqGVAZBj7SvVfrRLBRkuzcZLhDPdC27KeE0g1G3RZam1rWv4T2gJc5bL/321+9iC/SUXbGwmMYgwdCjGmdbPqDr4z9CiSb3DmEr9RIJ42ykZ6wbHntgZ8lDGVdSB3DGUHQvppS9sExPH4MZTJv8NTU6DkReTfRUsTD44Xy3nPdBG5TCkMML6mViqbq7+WqSYUSEu7rW0nxsxpIrwUdJ+YBwV5ZfRI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(396003)(376002)(346002)(36840700001)(40470700004)(46966006)(186003)(356005)(1076003)(2616005)(81166007)(16526019)(336012)(4326008)(36860700001)(40460700003)(426003)(47076005)(8936002)(82740400003)(8676002)(70586007)(70206006)(83380400001)(44832011)(82310400005)(2906002)(40480700001)(6666004)(5660300002)(478600001)(41300700001)(7696005)(316002)(26005)(86362001)(54906003)(110136005)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 06:46:04.2627
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02bba0d1-bd36-4722-658f-08da86657b3c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT010.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4154

Enhance amd_iommu command line option to specify v1 or v2 page table.
By default system will boot in V1 page table mode.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
Changes in v2:
  - Removed separate command line option and enhace amd_iommu option

 .../admin-guide/kernel-parameters.txt         |  2 ++
 drivers/iommu/amd/init.c                      | 23 +++++++++++++++----
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index d45e58328ce6..d1919bf4f37a 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -321,6 +321,8 @@
 			force_enable - Force enable the IOMMU on platforms known
 				       to be buggy with IOMMU enabled. Use this
 				       option with care.
+			pgtbl_v1     - Use v1 page table for DMA-API (Default).
+			pgtbl_v2     - Use v2 page table for DMA-API.
 
 	amd_iommu_dump=	[HW,X86-64]
 			Enable AMD IOMMU driver option to dump the ACPI table
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 2ed23fd16014..621815e73771 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3348,17 +3348,30 @@ static int __init parse_amd_iommu_intr(char *str)
 
 static int __init parse_amd_iommu_options(char *str)
 {
-	for (; *str; ++str) {
+	if (!str)
+		return -EINVAL;
+
+	while (*str) {
 		if (strncmp(str, "fullflush", 9) == 0) {
 			pr_warn("amd_iommu=fullflush deprecated; use iommu.strict=1 instead\n");
 			iommu_set_dma_strict();
-		}
-		if (strncmp(str, "force_enable", 12) == 0)
+		} else if (strncmp(str, "force_enable", 12) == 0) {
 			amd_iommu_force_enable = true;
-		if (strncmp(str, "off", 3) == 0)
+		} else if (strncmp(str, "off", 3) == 0) {
 			amd_iommu_disabled = true;
-		if (strncmp(str, "force_isolation", 15) == 0)
+		} else if (strncmp(str, "force_isolation", 15) == 0) {
 			amd_iommu_force_isolation = true;
+		} else if (strncmp(str, "pgtbl_v1", 8) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V1;
+		} else if (strncmp(str, "pgtbl_v2", 8) == 0) {
+			amd_iommu_pgtable = AMD_IOMMU_V2;
+		} else {
+			pr_notice("Unknown option - '%s'\n", str);
+		}
+
+		str += strcspn(str, ",");
+		while (*str == ',')
+			str++;
 	}
 
 	return 1;
-- 
2.31.1

