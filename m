Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2046.outbound.protection.outlook.com [40.107.243.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87DE6174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:43:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jOyiA1gAzNDeoLcORIVTPsYc9b1NORQ4+G22H0Y1ZDRJA+7bAZvk31+ORjrDfIrjyD5VZ989ey5Evs2wvyPPzbt2ga11/0rmWfzLW+H1AvzuDcffYslSlF+AaTzdHzf+PKcmXcJbs64zk2I9Ye0TmZN++gffcVHpZDl6jtgrq0uu/VB+QH3BuKSgFLJr7MARvCvsFtTGbeUtEKu+3HMOgbeMA0BdXHvwJMaqA7bAZfOoF9OtsBZcFscI8/UElesW4lhyPXvs6a8RsxWaGOcABtQCpvOGLTsfJOTOdSntKmPdQ411puZk/FXhF531BAUsCrLFWhPCHas1/podUO2WBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AKyGGvkwC3YNzi+PAqqvrA+hLWPYiMw2RCfSKulWtdk=;
 b=lRpRqlPw1RXT66z8OmXi7lThmbk2a+6dpo2ah81Xjt6OkhWspoGYrw/V8PgEw/IexU3L5nLq/ZzGj3LyAhrm8ChmRt9RofawKvTQBO+5pozsOeq/lDfRXTgTnc+gcMsqlU3Eiq/SebsKVlnv6s/RH5yYmJutwVLIB5fKM9KVLOJLU1PPEOgxUlUBC6xfd7dZAvPvl1+L6Yq+5WTq7edIu0X0KAQXBleM3gr7Gt41zUOE/5iiqofAnOi2pc9B6yVo//LjsF3q93H2Xq+SkqDEhgl58s3Fpu/Ly1qREHEfmfNmSYLumIKMearbh4D8y9bpjM81SzhdgzWS6/IxeoPFAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AKyGGvkwC3YNzi+PAqqvrA+hLWPYiMw2RCfSKulWtdk=;
 b=1vx+Uvz2OCSkpRBKLKCp/li9aRARwBefnGy0D0YM0lZH2/4piTQLMQastoTK5KiEJqOppnu/5kJIxREf5+lwlovyiOwVPZXW5r2HguBWEo4Um7unF/pOjRgiamtP9piK6hLm27V0mayTbheUP6CNQdSu1f3F+bAMrSxn7yIhMYA=
Received: from MW2PR16CA0037.namprd16.prod.outlook.com (2603:10b6:907:1::14)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:43:02 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::61) by MW2PR16CA0037.outlook.office365.com
 (2603:10b6:907:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:43:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:42:58 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 08/10] iommu/amd: Refactor protection_domain helper functions
Date: Wed, 16 Aug 2023 17:40:29 +0000
Message-ID: <20230816174031.634453-9-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816174031.634453-1-vasant.hegde@amd.com>
References: <20230816174031.634453-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: b237e468-8647-4f0c-e69c-08db9e803cc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E9AfM/algJc1oURfDnMwZ4sMJokxACPz+nvape3gM7dkCkkssmaGrUkvoYnF/TXtj/mAmXC6p4GCFXGZH+K6fqahc2I7sraAXu7GpxrGT8q4FMRrGix5WWJMkm488CPcu3lfy6wFbf8KH11tN2OCEuHhd4NRxov1q9UkKO7OvuxGr2iqet4N9myNixYAvRPMaf7yhSY/55DQ5O/OqdoznUqdZgcjvNuDgPr0FlDycJBBt6f8QhjnErWA3Z1maYWOyqv50CQS5EJ5AcZUIfF/eWHoKmpdWteR594AE8REomVU2QUgqNVwm7gbKbtFA559A0Az5vC8I4sDTRqT1wOIyu/aUIs4DcXrdrstLEwEgNBNiFxjxurCrQHly3kzfvpeHs3u4GF8KI2v/ftBP3c6QrTa5LA2vD1HVcd9+W4BY0ZIsXMH7TfPSGUZb40SjzMXqCBKDqARY1gIT1KKOIZ6/LYqOsQPD0shc+BA4O2fFDNZ5yKQZnfJskT/FxACHcrFYP/o8R7FGKewIYe5V0D7ZdDdR8Bjr0QFn4dlxnKIxVTtiMtwctW2aLRQogasS6iQ6T5nbwnN1CXYk74wBxaxX96/xcG0TYFE+PmTc3erC+OdBIFFm2SvSqiEbHlrXRAYcWpuIkaB2+OwlWM5KuCIJGEtHpPhVqOTFfdVmMp2bRX26/oRmipLVD6VgdzMCvlusK9tjwMVJMbpwfw/Sm7g3QU24SiOMARcVSjY4tbqJ2b2CCC9hSk4kamGIn46j5LYa7SzrIvIAmHvXykzKrnzQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:43:01.3928
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b237e468-8647-4f0c-e69c-08db9e803cc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 421f827fc24b..be68d77861f5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2126,9 +2126,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2156,15 +2153,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

