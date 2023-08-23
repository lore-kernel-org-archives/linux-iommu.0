Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB1DEBA48
	for <iommu@lists.linux.dev>; Wed, 23 Aug 2023 12:03:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUi4LEFjrT4DtxJuKNyhnm5838LUn99qTBxE8xMQcTiVRXzz1U/dREIuL9Kf3fUn9hqAGc3tLMDsZb62tBDquf4XRM2scRP0WoqVudUMpItaPGkQbzkCALw+ES7kqobjG6F2dWtng9fJ7D/BSzETWuBVXrMLKguapvmFunjmCyZVqcGLOwxBEUq2ESnxGfH1TCRoe9scZuJ4WasSL1xAtWNcy0Cr9B3rhnqhCGeKL5pBMl4O7IOgOJiqAbr+NUqONTFe1igjYe4YNYTR4sZXZMP787nyWNtjkT8UFktSoyEFcaePx+as+nfgWBqevJP3DSCgW6yyhjpigyR3sWy8mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=du03hBn1uzOEAShWoNNufYeUTe/TcvJHO6c2uGueHwM=;
 b=Hylf4r0tLmd9s+PZGU4tywVRz5SqewAKnCffRjrGaEEvDALdcLkHa4r6WtdXk3xrfGP5e7gQr9GO0Iu4LbQkb6LqvHVLtRuU+qIG4HxD5tf+bmwGuKUe9Z5u9wJN8Pzb+OBQbSuYUMdNmroHzJ/7okIkb+iFmYvECSvHVxGsKH7zKP121FfRiUUgi9VRpvKj4bs6wu9KscQMmQbPfX1XUlgYjF+zOMw0nXK2vjTlLA3TTcqJHIRY4v98uwvXSEa3bSBr5Dml3vSQU/e9EPX3F0ren3Ivj+tCGDX3Dasuwm/Cwrqi0s1PE2ZnqT60dlcIWTUx6z0sremUM+Rp567ySQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=du03hBn1uzOEAShWoNNufYeUTe/TcvJHO6c2uGueHwM=;
 b=ibR/NOF4wrYAx03WWyEQxU+utwV67s2Pv+ZiIPKqI1OR3s37Yq1vKBkEC1JF+/l1g02thM9DKUlxa44IQVzS365lV9J5rS5NREqsBHTly1FHHueVHF3GI5fU9pokLwyEB5DtRBMP9uX3KuGXKw5nZmVXGQoe4BRY+Sqt6fsN8cU=
Received: from BYAPR06CA0012.namprd06.prod.outlook.com (2603:10b6:a03:d4::25)
 by PH7PR12MB6668.namprd12.prod.outlook.com (2603:10b6:510:1aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 12:03:37 +0000
Received: from CO1PEPF000042A7.namprd03.prod.outlook.com
 (2603:10b6:a03:d4:cafe::e7) by BYAPR06CA0012.outlook.office365.com
 (2603:10b6:a03:d4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 12:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A7.mail.protection.outlook.com (10.167.243.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 23 Aug 2023 12:03:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 07:03:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 01/10] iommu/amd: Rename amd_iommu_v2_supported() as amd_iommu_sva_supported()
Date: Wed, 23 Aug 2023 12:02:12 +0000
Message-ID: <20230823120230.727935-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230823120230.727935-1-vasant.hegde@amd.com>
References: <20230823120230.727935-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A7:EE_|PH7PR12MB6668:EE_
X-MS-Office365-Filtering-Correlation-Id: ed3b4f84-3ba0-4055-2810-08dba3d0fbd6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	FUrU3oN6twUC44Wrl4cMcZE3ZU6+56pAoIDW5p07Xq6gjg4DgnQitFscLdxVig1KEg01504CirQjXv9k4qmcizn0/z5Zm1gbVrthpU0DA+xmc269wFUatE0ET9CjPl3OF98vXp8owaS06qu45XwOw0mERMae+U5iQAJfdMQU610FnZyVbYYGrD1rZ67fjxToLgue5vcm/RpEiiJvgalMh0CZfCvRGIcBhXoeikq1LsZRMH8nwvQMjZ3siNM80ZxIhS+NcHxJRZ6yT3a7QgMILfCBvh+mve8Dr8UmK51GLWYQL6bXfxdaPvPLPc8NNoa0j7AamuZrYXQb2SFY9sRxqFIJmLynsUUNtBQ01XsVO8O7G4+HSRXV/tmITpSPLo9PFbWtuBuBUfwz/NJT5npo9045LDPuKlKfrs6SpQOQ0k6q3JZvByTr56ujsqrM82EACFbIPdKRta6YYme3Xsrq2H9Stk9p9UeNb5Qsmvh5PZpzVQZbhspXJ9+uVPbIZwUnyAvuBAK+J+O+XJlreXLPR1690KXoks2NEwVI7+zOOg45PWSZ9Pl1Q39rU8giuWms3L7pruVpt/6K3UtTOD8nQkmpZ8yKe4nBSQKz+xJQZkMi/z8ZU28R0O7j/9X5lGJuHI1GMsTL4h3km/b8sAt4sD3s2bARVnD3AJ0oq7lfbc2G3NSBkFifFS5TpiukTknNUcfu1mFdR3aEls9ul1c4awNHsSQfbhazPwaxztLo/Qg1OowjGHPcqt3gedrCzTbt9tCV5/yGHq5A7TFjIR0I0g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(1800799009)(186009)(82310400011)(451199024)(36840700001)(40470700004)(46966006)(54906003)(316002)(70586007)(70206006)(110136005)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(81166007)(82740400003)(478600001)(6666004)(40480700001)(83380400001)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(44832011)(5660300002)(16526019)(26005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 12:03:37.5135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed3b4f84-3ba0-4055-2810-08dba3d0fbd6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042A7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6668

To reflect its usage. No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h | 2 +-
 drivers/iommu/amd/init.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 92fba9bda3d2..f236d540c917 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -41,7 +41,7 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
-bool amd_iommu_v2_supported(void);
+bool amd_iommu_sva_supported(void);
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
 bool amd_iommu_pc_supported(void);
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 64bcf3df37ee..3820ae738088 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3652,7 +3652,7 @@ __setup("ivrs_ioapic",		parse_ivrs_ioapic);
 __setup("ivrs_hpet",		parse_ivrs_hpet);
 __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 
-bool amd_iommu_v2_supported(void)
+bool amd_iommu_sva_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
 	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
-- 
2.31.1

