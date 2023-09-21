Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D148F55
	for <iommu@lists.linux.dev>; Thu, 21 Sep 2023 09:22:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jo1OV041Y3a7cBY9eH5CHD44ipVX6Xvs0WEJ0gwdaZL9+TSH7Zwmxv9gZnHnIW4pR70U9KebDnx8oeHswu4ybvGXiUnPWU28EIAfcJMiDgN3rJqlmA8VPIBzCvC7/QIvC37nEyFtLswjR3U0dl/tVwdLiw7Mbmqy0M97r+r2PIpB9mbnTt4q9tPIW+mdW9lJ6ip9GIP8M0HM1uXgRu9v7JQh2dlDkfPtaLjm0qlP/9HhHJ0iicaM1pm6R7ydtYAHeNGDrBpYtbqyzdyZdPbNkUIdwC8n5jILYOYTsYI13CJ/krJzpyCBccJgVAnnBIdhHSpr5KSuTimf1r32txPw1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itf9njyLE14uiPCnk9JM0sX6rrKSExA9ARk/n3C9a4U=;
 b=PPkoauErki5F75sCywCSFrjPhG3JGxhahRaKbOvCez3lMe1Aa7JxhTY1Z0V0Q8uImTR9bsLoYKawCvinV0279fGT1XU7z6X9UyGz6/P+nfiHfj9M3EaMT4YNIq8prTNTSvYzhCuwrRCx84l6Rjlwil0tRXhXiCCU0ugYg5jK6QN0sY2cV43x+I5IakCHadqM0laOLbL1gQAU9NaGGAtIUHgexJDATGqN6FuoNnCPMf1vcUOl7uUgXPY6cNry6V9ozcI7OMu7bfV2unQdxcMgFEU2e9/EDTBsbXdMi3IU0vL2ofZA3JtosZKvqEt/RpC+hkLyNJPnQBIB5vBLxBbpjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itf9njyLE14uiPCnk9JM0sX6rrKSExA9ARk/n3C9a4U=;
 b=0rouQgvC2RQVw3OChRL0enazeq3bBlgXoEtbna1itjZaq+N5iWkhla8RTLdvkPZ7WtaHyYw3Wjd2sIQLZdzwNPJtAVxRZDPJiAViofZUf/rpDg1wo2+ZL9s/d2ej9IVq/E2xw+EfPpWI0RCkSzFi6YJiINxBzIBryQnTSWyEXLA=
Received: from CY5PR13CA0013.namprd13.prod.outlook.com (2603:10b6:930::11) by
 IA0PR12MB7698.namprd12.prod.outlook.com (2603:10b6:208:432::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 21 Sep
 2023 09:22:48 +0000
Received: from CY4PEPF0000E9D5.namprd05.prod.outlook.com
 (2603:10b6:930:0:cafe::ab) by CY5PR13CA0013.outlook.office365.com
 (2603:10b6:930::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.9 via Frontend
 Transport; Thu, 21 Sep 2023 09:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D5.mail.protection.outlook.com (10.167.241.76) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Thu, 21 Sep 2023 09:22:47 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 21 Sep
 2023 04:22:44 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 01/14] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Thu, 21 Sep 2023 09:21:34 +0000
Message-ID: <20230921092147.5930-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D5:EE_|IA0PR12MB7698:EE_
X-MS-Office365-Filtering-Correlation-Id: 21532528-3f08-4dd1-15d0-08dbba845226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1D1dXvCoorfkqeO1dcBn5re+CuW6OBOLsIBP9l2uMKCXtnefMexo0kbzixQINxa1UxSJ3nmTfQLXmzSd98Uh82t6U7NIll/1J/P7EsoYCbgnL5KqoVDjSqYPdhc7H591+uLyd6Y5tzL74z5YJS/dVsd+f9gNu36/XgXnTyVaDAXqds7pzuqz8aYCCS1ufiffdf3+ZcaR2qTEKG0i4wXTZiuvjMooENXpBCiNdAXj9We0QpOADfL15+PAkkGxTu5/Y+Qpyc9A7J/woOHgptDV+fu1weKJ7ZJ2BnKihyU1mCt7hbi4k0ncs4d8xobekqUnlvm4bHPVwmP8KD3RySDrHvxWT0CSacXFcNptE/kJNwXZeFhx5OM1nY2x7G1Z95vEFXheixsrqHYs4M2+ijM4aGacb6Ey6tsdPCZtJZIivmU5p+IbQFYU2iR0EEd7okSCqCpt2zfVhne6gJCCQ6R1yC1Ptj338NGsoLrOuhAkGrSFkVKnxruyWFtDrev9fHcv20fZwhz50GIbiAjxTOSPkRwXdQdsLaxtFKkri2lAZWRUSTIpXtZJrfO7AC4oSTj2QzH79lTBAv41+Y1HBh0zm+lR/K7WDj9yEFJxs20OlKv/4kpebOS2wIZfxw6q9UL6KQeH/RcYK/uchsxXcuZd3gx7v2ZsYmYXIN9BDrGirRbSqLTF4ZEVpCQJsE9CSA3ZNAkcfAskp2rzioCkPVwBW2KQ0+wJhmaayzkT0TC2qjyut5rSbm6abXdoHnRemxuHXOszhZmfDppbfARYNG5aCQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(82310400011)(186009)(1800799009)(451199024)(36840700001)(40470700004)(46966006)(7696005)(6666004)(426003)(5660300002)(8936002)(83380400001)(8676002)(336012)(44832011)(47076005)(26005)(2906002)(41300700001)(316002)(16526019)(54906003)(70206006)(1076003)(70586007)(110136005)(2616005)(4326008)(86362001)(40460700003)(36756003)(82740400003)(356005)(36860700001)(81166007)(40480700001)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 09:22:47.8796
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21532528-3f08-4dd1-15d0-08dbba845226
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7698

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 -
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index e2857109e966..c5090e00b3aa 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -105,7 +105,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->iop.pt_root, root);
 	domain->iop.root = (u64 *)(root & PAGE_MASK);
 	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7dc30c2b56b3..081d8d0f29d5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,7 +544,6 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
-	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
-- 
2.31.1

