Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7672723AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:36:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JjeBymJinaWLdFFYUPuU1NfadseocMZi/s12LIqiLuL1scWNeN2YEMS4s2kdXUXfDjHkTeYT3A/7HZgdTuuXnTZ+jUywi5PstE4KeGNFzvtYs/9a2Qv0ZZ5ggQes8XbNLYaTb/cohBBlhZi1wfWuSv+fe6Szk25qoYIBtMznzV8Je/4uClUxRlKMgiHxnjTXcBsIhYEkDZRIaIT1ANNks1uBn7k04U/uesyaKtJjyDWG7QtlL1BE6aE5PJcwd1oJkbYdqR5JF2t6pHhafwE21FzNwKdgUxfN2lRDLikjUvm1Ow3Z2WObvOLqRM3fQXob/UQCSD0lVLcJX/c3h7U5Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hi5WjxCxf/F8XBkzLTJSjPWbJNn2cuuKeB7YoP/qOTI=;
 b=LvssT6SQNgoywvb11ipEFSMhKdHKZYoAkVuzY9vheJ2l5PvuKeVn/h6nQtyQGpwCUyxifDJTjKUQNFrMBWHMEvYcqEuXPWFuW2T6HonmzReqIZJFIuOtUgiHc/Iao7RCLFXQVOR5wF9zZysGo/uboge+do3/+fvFI/JoObGjSob+Ix7qzUty2WaKTQDd/MkpBPEnGfgpxNt1wOM6tMnLlixsD/q0pZC6ZBEmYspNFhfTQqTgeZuAvkvNtqmeRSid1ZO9cpWsC9QThDmj4+no9fpZFJFuepst708079S3Z2q/XeDwTGhaAD5AfXHBnULHRD514JOuagREdQGOo2zDxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hi5WjxCxf/F8XBkzLTJSjPWbJNn2cuuKeB7YoP/qOTI=;
 b=TPZDqv+DjvsKj8eGqVpbQJFYDA5LGPqlv/5fJyzOyP8qwy8Bkhx8TSIrz2D0r18sGTLf5SAp6G0RbwzVXNbxFpjWKd1Ht05ECHARzlpHWsNXnl+/+h2qVSGXx53xWfI05Sq5iIqAsYjyUQeFjrtFg4Qi0fKgHQAo40fiELr2BQM=
Received: from MW4PR03CA0283.namprd03.prod.outlook.com (2603:10b6:303:b5::18)
 by MW3PR12MB4538.namprd12.prod.outlook.com (2603:10b6:303:55::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:36:52 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::54) by MW4PR03CA0283.outlook.office365.com
 (2603:10b6:303:b5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:36:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:36:50 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:36:47 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 01/16] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Fri, 28 Jul 2023 05:35:54 +0000
Message-ID: <20230728053609.165183-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|MW3PR12MB4538:EE_
X-MS-Office365-Filtering-Correlation-Id: 190b0adf-1a73-4a15-7cc9-08db8f2ca479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tsqXDDUNY3K9Kr8tIAatXJCA4QbH1C8T5Zn0oe8aOl2L1N7eUt6QGTtEt6G+l+0l6Zh1YBtPvwSvwdhrzHkyYEV46/YLvT8EjUCq6k8fxZM6kkR2FF484VmkVxI8+XbRCv1Z/UhDkBDiR2J/hPTindNLQbRkC3bokNVZbvzKRPnB+YFZ2VMR7tk6omlZ9PvcGvOpN+TcBfUppkQw+5qNPQzJ5BCBg7CjFJgV4grqOhk0UP3kyFxLIuk/wD3gBUpMd1d5vkdmb0rKcGrGlJ6w97c1qMN5SXxBZfuE3akiVFUhy5MaUYGiBDgY4hFN+U4EFrYkqcwgYc95AVwtHHcKwOC/XGr4yMBY8VAUxC6GZ2ATQyBcdy9FYJm86y/9AhoniAybsas958w9ffIGyWh2NNkD1nT0obaFlvMFivsQNeEwVsB62sX4h014GXKoy7dufAtoV9CYcMQSAlcfd5L7TZqiv3RfnYbMUX1twZs/AB51vkGSJSkd9Yw1NttqhO17M1LjAR/no5PLqW/GJQNF8/VIhgA0JwIGCyhmAdNzBi6GLeUggiTqaKIyLw0ecxhV0W4fc/39rZFnzi0ktHyGvB0IzF+mrWgCqDNNjJLRA1qc84JtV3Q8xEqCcLZUcb5RCIwwRWY00Vo5epPOA+hQljO0ZrLLBT727cWWIkzXJ0PBCyRNYhIaoINmrnCiY4ykmLDCOMyle85NPpTsOpQr/Ym6lbeGhcdwyXVjBYnZhdrLQXjCa2RMIzK5pBFPrLmWFKu9aFsiSvh07Vipj9FZYw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(136003)(376002)(39860400002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(6666004)(82740400003)(478600001)(356005)(7696005)(47076005)(83380400001)(1076003)(26005)(4326008)(54906003)(70206006)(70586007)(81166007)(110136005)(426003)(336012)(2616005)(16526019)(36860700001)(186003)(44832011)(8936002)(8676002)(316002)(40460700003)(5660300002)(2906002)(41300700001)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:36:50.2409
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190b0adf-1a73-4a15-7cc9-08db8f2ca479
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4538

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 -
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f23ad6043f04..6bf55de9fbeb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -108,7 +108,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->iop.pt_root, root);
 	domain->iop.root = (u64 *)(root & PAGE_MASK);
 	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 781ab9c2ea70..1930e918188f 100644
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

