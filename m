Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2056.outbound.protection.outlook.com [40.107.237.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B0B481C8
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184957; cv=fail; b=HYrAvZffffBz+375XR80EKzORlqbf84uELoToRRmcPw4d6gm1xoL899FTzYQQp/i8qXt2JjBUHbzd4Ijdj4GJEL8blIErjoNZCEkP4psp58EqpBjYu6dRwYtKdDx/SL3/5YaUJHzIZmCP1iYuM7DH152K7hO/fko3837XjG35HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184957; c=relaxed/simple;
	bh=jmsawivUIVcCj6AJkvSKGUcEYGLl4n/e8WDbnYJuSAY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unHdKshHTchB8xK3G6kSkhmVWd+QG6DWcxM5YhjuRxkl6EwPt36vX+BFc377h6jZgW1c9+qEwTmJ5j3j2F5F7D9ghYhaEbAYJHKqJuz/7STM0ZyIKP+hcZqKlp8ggx9j6fElS9SNLSjzWEPsWKjw1NQ+RMtLe/J9TIKjVVDUvnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QJ1d3Of3; arc=fail smtp.client-ip=40.107.237.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QJ1d3Of3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f4zXL1FOZQm6juWj6mkC7M6+TjzAGXZdJFXG0nwFvKOz/RaMo5qF/SiQo/03V5TSsXXmVgI506Y2y8bMptvWxR8ebCJlSrRNZnvvYGuvlY3YvQtAh1VluIg7juj40VY2ys8gD27CBquKK3wHFJddIH2o1fbG02iIQvGjbxKte3BlbbvDxEK26Z0lXTZG2WlMm/QKTlNDnYuBNE73cVRlh53I/B1cblgeYELyyAsseAM/kPD7t0QHCfSrlSND2rfXP3ZCeBfG25CrUH4PF+5c6XlQw4yv0QOBNPKv7xn/KNUKiqtR+SA7zDvxAr2AAlyTgD8kn5HnXAcJXxMceZyEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CHEY07u0TPNW/k0eTmUTtFmr8m5UgGzdQlSdT23rSIc=;
 b=fDyhxolk8JOWKNEnLk0F2mjTeKMTLo/45ZtOC1/Bnco6nv5IF55KnhOuCCsetLwYB0NfH/qHI1/C0Kc/kAnJzz/ox9NNJldlbcua1ky60hoCPgtzyghyifcnwk38arcPae2JUfwyienUYrtSI1wH0Neej3gAUwO08v55UwYoiTDTIMp0Gud6GpPtJ/7gVcdoAH+YIiEhwa9FctCHdAv7Q6JikXWHMZNWl4qhZ5kMsIYE+qtZAi6na3LS4ylEYRbeDAvSa7P44MiULwBe0Er6a5R9g6beRMf6/UfGFeuWWf6fTB7BZxcqedGr7sUIp/5NXKqqfYoKJunAGo1HieqxCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CHEY07u0TPNW/k0eTmUTtFmr8m5UgGzdQlSdT23rSIc=;
 b=QJ1d3Of3kAC2gq+glxASf61XT+Rr5xrpRRO50rnmcXhJBvgQU4k4RbhqqEe+qE86Yur2j5xIDO9AIYEFW9F3WkH7hsULazhHWtpV2Kkw1c/2NfFyNPtPYDfusG4MXwn++mAVaLJiEvJv7VockyKyegn01JDQc2xPMiXszwKXV9E=
Received: from SJ0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::31)
 by SJ1PR12MB6316.namprd12.prod.outlook.com (2603:10b6:a03:455::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 12:15:53 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b:cafe::1d) by SJ0P220CA0011.outlook.office365.com
 (2603:10b6:a03:41b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 12:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:15:52 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:15:49 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 08/17] iommu/amd: Rearrange GCR3 table setup code
Date: Thu, 25 Jan 2024 12:11:26 +0000
Message-ID: <20240125121135.8217-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|SJ1PR12MB6316:EE_
X-MS-Office365-Filtering-Correlation-Id: 628faef7-c426-4914-b13b-08dc1d9f603d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KhbbvFgXJyVp0RCApopQr9ySS380Ecp8OWEGF/3yn6vslONuNnqpx7OkfYtzDz802/V2qgLFr5eTcNe+1H9JTAn1bhGz9SlBxdbVeDvmAiLjenqAyNPBB5OHQuggrbqkV5hW00ztTcuUXXuuywJVxXgxiTxAO6DxWOmdO1ru5Fc7mgppNjPgJjl0HxrdSg0ANXX0bQzuUZTKkwmguP1Ason2Lhv6qxYdD5bcyPKV+/iedUX+FIG/w8y6cdCcq5EdcWruPul2U53rZ+b/anE2k50vG5Eu5kGRmzA50hb4ukEPXbAPyz6Ul9PTPih5ChnIHeUNWUWzkCEh1r4dv5v6YAI1EBe/Z1Wa+QPWTJpHJuQp9vaNkkUi2i6ifegWjQlc8IOU9t+Z6lhO4W9QzlWA4M2fjjiVXJdmaEw1eGZu+yn1rDk/l+xU/CD9jtNpL25R2ptRoMbNKpXe9/htz8J0tYkWXGAEpt4tlpLuYJbKOFCcRKH1FvCe48546FP2WMws6k2evg/d9v9wlEA7S2Npv5gLgCeKkBmTTukw4+gPfNjhP71qmNttfdpEKA+KJoRqiGztdSloOsc+x17I51a09H6DetoGMJwQCqXAqFeGBFFA9RVLkNxH8mrc5YHvkDFHdV7x5mzhVSGO+j/6yc7oqZl+w4HCj7uCP5z+k9015VRRWtc0zKJ4t9/nZFCpoTzU9LXct7j9Ny2wCW8EG/QF9DnJRNne/cAJr2yXxr9MuQvxJg9u+Ck+gKREJDpZpHulTkDvdDNJYoZ3mnfJk+0p1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(396003)(39860400002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(83380400001)(41300700001)(40460700003)(86362001)(356005)(81166007)(36756003)(82740400003)(36860700001)(426003)(1076003)(2616005)(16526019)(47076005)(26005)(336012)(70206006)(7696005)(110136005)(316002)(70586007)(44832011)(6666004)(54906003)(478600001)(2906002)(4326008)(8676002)(8936002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:15:52.9866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 628faef7-c426-4914-b13b-08dc1d9f603d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6316

Consolidate GCR3 table related code in one place so that its easy
to maintain.

Note that this patch doesn't move __set_gcr3/__clear_gcr3. We are moving
GCR3 table from per domain to per device. Following series will rework
these functions. During that time I will move these functions as well.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 64 +++++++++++++++++++--------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 7fef4d7ed4ee..5367346250ce 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1718,6 +1718,38 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
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
@@ -2742,38 +2774,6 @@ int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
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

