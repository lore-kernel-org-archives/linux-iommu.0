Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2068.outbound.protection.outlook.com [40.107.237.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556F011CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mr3z0KrI"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P5iwsxWo7XP8DkZZg4v3PIJtUZflWDGXG+OyrSIAwFDuUw1Il3gn/EF8uTGhZdaX54FzcFfQcseCsDt68kw5k0cgkX+b/GrWDA52E0JDcMsrOsIQFfqUy4WO/gt96zEoY3BGBw8BHVpjUH4Lx4JJuPv495CRUXMNWqo949J3sy5yzKhQHHasC2Bc3rZ5PNmA/v+kfhwiX+taWwN5kXSE7sCOCfMFThQS1Ir47CyyE+3KJIzCVTSOtD95lLMdpNkQgc6mBLoq5vljyLBoEVbOK9cZKxXR1THUWNRI27xS955L2Kv4pEaL4HIGK3FUfp30h/6zT6D2NQpxpIQ3JTu7cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JG/9vAjAze9LsAr5nQd+IizsW4JlJRsK776NaEz/UVU=;
 b=QurZWzJ4uNOayDeLXPkOHaLEE2znLi6nOoD3C8c/tT1R/iJRI3yv1DuibCjMCVSwIdWEa1+Jj/6Z3kaDGVuHkvypFyGRyl+vQ1vVG7RReKdYIC5j0peB56SfC9Pr2KbjiZ5tba0j0rUJ5S7BZ6PjoISAgIyEskCDsE+TaJdXXX52OIzgGlm6kly7PUF30h+ywzyv4dTH51pBHUJaf+JtlB4uaYEJwJdci3MMiM+JWKYpBvPPNvKamFlxOFLuTCrI+JMsIKPJGhH1jdox6CXaYPeTro5IlO0JOxrFlR5BnBk7vZtq3U3scuA1JmkSNLMCCk7MhaYTVPR0rl/5Ct57cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JG/9vAjAze9LsAr5nQd+IizsW4JlJRsK776NaEz/UVU=;
 b=mr3z0KrInzm0ZRQfT7T+KG6qtb7muN/RN26NLryco2JnSGg4ps9a0ZIpwqfTaeCOtwTbhpM5QvJeEj9T/TbDHKqP2gyyhCgz5+mVjdd3NJ5zrAwmX/rweqsNR4ChdaZg3Or1SxWl42R51xy3Xe9lLECKCnoFzsm1+y+iS1X2b0g=
Received: from BL1PR13CA0081.namprd13.prod.outlook.com (2603:10b6:208:2b8::26)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Fri, 13 Oct
 2023 15:19:51 +0000
Received: from BL02EPF0001A0FE.namprd03.prod.outlook.com
 (2603:10b6:208:2b8:cafe::e9) by BL1PR13CA0081.outlook.office365.com
 (2603:10b6:208:2b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.16 via Frontend
 Transport; Fri, 13 Oct 2023 15:19:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FE.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:19:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:19:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 08/13] iommu/amd: Rearrange GCR3 table setup code
Date: Fri, 13 Oct 2023 15:16:47 +0000
Message-ID: <20231013151652.6008-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FE:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: 902c693d-cb0d-42f3-42fd-08dbcbffd865
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	K+BwCxhy4E5rUPyMmQwJaS/ZHHEd3NQzJW/9Ds3bNb3aN/3j84KWQbzQXSL5UrvkeYHlRpfOO2nnaw2w+kf2khgc9GEs1bMFjPpd4cJkoolLV9TfVMYQJYm4bwD51D7jIrCyDITthmEUe5VlUQAN4WUrousVafUxe23lteCy6aG2coYIF/o2s4AqAQoqRUnsQRIjUuBWmJS6QKKn8iveMKfEH+CmM0SdF7wE6Fh3/k47dW2KFtqjWAFf5tAQ9XrmcXl6d6pSUATfrW9p75/kuQaucTROaBzVNezcyak9r6mig6t2GeFpOPZggZy8M3rNLEn/WL+aNJwiqbi2rhoPBE4DqkhxH12cWl/bM7uoW8LenM7PEZyTgCucLk5P5f3HBVma9eO5Ww/VHI2aPIjL9Qz0n7chHnAF0kdLBWhiqruBcop3soYkjO6kV4BYTI5n8abA1Tasu140XS7qikdhcl13HS0BchIaGjJynGk2a4AZnXQeKospF9Ee/oWOIa3H8R+SUDz+DZoo+PJpqqQ6k/ON9PJVNE/u6jORcBXW6Gw7PKeVjPAnd7166xsLKt2wpfTUKA7nVXE0CFTdzY/zeQT/rqXf2fapZkMMSOa3FvUvTbQ+GX+rg6feTiDWLxkaOCtlb+1OVVtTetsh3iLjTUEEIupw/NiYRADigrevetQ7sCB9LUik2fMCKLQHQopQFVlBANLHXlqc9yLk/WkquNj0JYWGx4CSd3HiDkZEPzKXG4VGIz7QeExgWADK7qQO/NP7lB5lHAW84r2vCPq4BA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(451199024)(186009)(82310400011)(1800799009)(64100799003)(40470700004)(46966006)(36840700001)(47076005)(83380400001)(40480700001)(40460700003)(16526019)(426003)(336012)(36756003)(2616005)(1076003)(26005)(36860700001)(4326008)(86362001)(2906002)(478600001)(110136005)(8936002)(70586007)(316002)(70206006)(44832011)(5660300002)(8676002)(41300700001)(82740400003)(54906003)(356005)(81166007)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:19:51.0202
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 902c693d-cb0d-42f3-42fd-08dbcbffd865
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

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
index 0c44f3ed0c92..27486b905b6b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1849,6 +1849,38 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
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
@@ -2632,38 +2664,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
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

