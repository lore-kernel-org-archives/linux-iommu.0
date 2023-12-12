Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD31B56B93
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aee/3NEe"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=czhVIaPMlSmh1Km7XfV1sWXBT/8ZPOZ76Yq/qN75DNI2GnQajwoNAnJGfVjapzVZWpmp/4x/7cJ/ivz3iX1AH1xBPHb13h/yZHp0jr7CYiyR+wYDDHp6suUwUJOqPqtXUBfEuWckT+wpotWjnNqdEdltscyIBtvq5ubaClBwYWuFXDrXvDv/l9ps/ji0z6CR9vWCBlpTjBtUxKhahrQkrtYK80daMhSTzyg0hSZ4pHrl56KY3iE9dNBGzfRp7j3KyFeVFQGjiUkT4Ew+aBQ/FlHiWLYGB83o2LsRM2TQCFd978BKsjRBV92Djk4jeb6JkC80yY2fncpFkm4HcAwPzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7sTuDh2P+WhwCfO1tOUmrLJ558gCXhjK67Y1pw6Yy0=;
 b=NZ0JcFVupGD3MUtpgbvH36ESfshBkc/vvgdht+EXCax9gzZswm4wAiEupVSGHCoQZ6y2WyrxxgZsqvm9XJEgDwhqX/vy8Wi4a/YO/bPgRg8F1t7/qf3z+dc0Fi6v6G4lb6Vdp+qFZu02NBMXHFvhJ+oIwxptx3P1R4SmxSfEH/ZJIx3sc8UBsLSbQjSEYB9krVd1//4peLyhJLZRa5ydTesFJje/kVLYhkoNq8zQ8IEjQ/QsLAD75T6UzRbogDaz4Xs3OTBaA4AiXN2KzflkiACq4EH/Sij/RN/qqFp1UZxcO0XvVBBHUMtRIClqDlO75cQ02sMbYz8xrmsEUR2Qrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7sTuDh2P+WhwCfO1tOUmrLJ558gCXhjK67Y1pw6Yy0=;
 b=aee/3NEee8ThTzFhw/5IQw03tw2b7bhACu3m/Fd45GjlgezsSb5tXUp6y8+m3CjGE5FVzCQViObdZCs/wm20430aCC+2xmXOt2Fm2uEbFBMad+G0WgnqX76b6YgsRy9OCHVA82JcbQ/UxTkXSPq0Jg9zYKEjJvdAklklSq0XmBc=
Received: from SJ0PR13CA0186.namprd13.prod.outlook.com (2603:10b6:a03:2c3::11)
 by BL3PR12MB6378.namprd12.prod.outlook.com (2603:10b6:208:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:56:35 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::e8) by SJ0PR13CA0186.outlook.office365.com
 (2603:10b6:a03:2c3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Tue, 12 Dec 2023 08:56:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.26 via Frontend Transport; Tue, 12 Dec 2023 08:56:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:56:31 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 09/16] iommu/amd: Rearrange GCR3 table setup code
Date: Tue, 12 Dec 2023 08:52:17 +0000
Message-ID: <20231212085224.6985-10-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|BL3PR12MB6378:EE_
X-MS-Office365-Filtering-Correlation-Id: 66f2c7be-2fa9-477d-0a49-08dbfaf03e5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	x3hGbEq1VD7qLR2YFJGVNKmxgDKSaZSM/UeOYWrUH1I9JUwXPH6S2xBrZftA0r0ykGEYGXYcmeYTW0quYqV5Pbab07jGTuOC2sLCc35uB6upejVLk9zeimSI45ClrDrKRbT90SstuLEKZNB4mi8jlHsoIm+U3ZoPLBzfWrKSNQsj5/GReytZWL7CFBuIjsAZEzHloyx4M39bThyzLNMWJUNV7J0XbqDA9T2qKZjeJW4PgF2IFReZ/b7nzyOcRVA1DCJ6+ZYg4l+mcao1TQETwohHhGf28TcCEMSRD4wwGxL7K+c2AZls17V1e0tZwL7ij94vlAQjTGxq6iEVPASDaYsTrYoyoUb9r+gTvTwhVXvjLFbHRqwXqRums1AoQW4bovgTMZlkYy8Hlinl+fE5v8LQ4ttGeWd0PdUEImUWXfAGGyQPjIye7m0mQ5I0tw9ogm39t7TGxgiVWUPZv6yCqwyQlM6A0NCOmvBTuuAuYf24Jf20qkX6AhBlWb16B7ejX2DjuyI8VbGb/zb07tXzBj/I7Ve1PCR/D/flipfxLEbu7o8M6SEWU/aI8QkvGSKUhwW0Ni2JMgs61Bw4ygriJ5ZduZbpD4VYDWha3cKHhcsqLl7hyDa9zg/s5mdrE0njHJ6scshT6PAEO3UZXCDWmDeha4xyUBk+cs3CtnUyOfeFmIrID4ELQtUo9BIJkY34eJqG97+hclDEopOj6gAndumw5PiFUUEdq8ALZaoA4bpb3NZYDfCr0TvHOSpAp5DbCuQcfbS381eMwzPKNeeZCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(39860400002)(136003)(230922051799003)(451199024)(82310400011)(1800799012)(64100799003)(186009)(36840700001)(40470700004)(46966006)(2906002)(478600001)(1076003)(26005)(7696005)(6666004)(426003)(336012)(2616005)(16526019)(41300700001)(36860700001)(86362001)(40480700001)(40460700003)(36756003)(356005)(81166007)(54906003)(316002)(5660300002)(110136005)(47076005)(70206006)(70586007)(44832011)(4326008)(83380400001)(8936002)(8676002)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:56:34.6587
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66f2c7be-2fa9-477d-0a49-08dbfaf03e5b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6378

Consolidate GCR3 table related code in one place so that its easy
to maintain.

Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
GCR3 table from per domain to per device. Following series will rework
these functions. During that time I will move these functions as well.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 578462a2325b..85a30b1614de 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1764,6 +1764,38 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
+static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
+{
+	int index;
+	u64 *pte;
+
+	while (true) {
+
+		index = (pasid >> (9 * level)) & 0x1ff;
+		pte   = &root[index];
+
+		if (level == 0)
+			break;
+
+		if (!(*pte & GCR3_VALID)) {
+			if (!alloc)
+				return NULL;
+
+			root = (void *)get_zeroed_page(GFP_ATOMIC);
+			if (root == NULL)
+				return NULL;
+
+			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
+		}
+
+		root = iommu_phys_to_virt(*pte & PAGE_MASK);
+
+		level -= 1;
+	}
+
+	return pte;
+}
+
 static void set_dte_entry(struct amd_iommu *iommu,
 			  struct iommu_dev_data *dev_data)
 {
@@ -2806,38 +2838,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
 	return ret;
 }
 
-static u64 *__get_gcr3_pte(u64 *root, int level, u32 pasid, bool alloc)
-{
-	int index;
-	u64 *pte;
-
-	while (true) {
-
-		index = (pasid >> (9 * level)) & 0x1ff;
-		pte   = &root[index];
-
-		if (level == 0)
-			break;
-
-		if (!(*pte & GCR3_VALID)) {
-			if (!alloc)
-				return NULL;
-
-			root = (void *)get_zeroed_page(GFP_ATOMIC);
-			if (root == NULL)
-				return NULL;
-
-			*pte = iommu_virt_to_phys(root) | GCR3_VALID;
-		}
-
-		root = iommu_phys_to_virt(*pte & PAGE_MASK);
-
-		level -= 1;
-	}
-
-	return pte;
-}
-
 static int __set_gcr3(struct protection_domain *domain, u32 pasid,
 		      unsigned long cr3)
 {
-- 
2.31.1

