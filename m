Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2046.outbound.protection.outlook.com [40.107.102.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C4F56B9B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VgAEj2T3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B44UdcyB2lQop91wcIVuvK0NlHDBHV9e+ca/ymKxrnRjw/e3gJ68q+Tz6W+mtnPIWbKY+USuHqotWe1lqmuYpHQLMJx1Gk1ctxa/+V/NEfVDuDv5DVLnc30irGJemMQYrQ1jPzrWAnYJorxEg8PTQxhpxV2udhFdTIKt4IizDSeg2mMx0YNs878WPSt9Q+68YGa52CV/qlgvDrY4qNGxSISuZZ+QD2Rt9YbujAJZVjU1X0011bfkApxqrTX3UysiPBubJVfmdzqZNCcjBa6P3NfpD3eimfINI6jbXDHpk2LL9KxcRtWPYoTuBI5U8Pif0Jlst6nTvkC5n/fNUBHhRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oRCV8hg4QXOyJAxOLooJbwZm9/TcG3hn8RysKuAfBw=;
 b=Btu4GSAsBECuHj2UuPlf/NMN/MfjC9ofZDY0CYtPXWlULWithSs9VtzxLSG/8fY+D3moC8YYjrzHdO4+caZ9lBBerD6p0p9eIcKx3OvRHNjiJe4Qn6VXOpZ+yc0EvdU6kf7woWa9jKNYtX9YNalIB53p41KE46s1j9uSHL7GXEarhVkY8753Ub9OKW49m5LY41FsY+NUXt9S7uM9IbMob1m3brCjaSV8wlU30XdTqkmRcyn0LjUik1dJ6iZzI3lr3KSfKEfe9tjKihZspf9bvG2sknc/q14mI2ja3csqxTuWgfYtDege22eS5j6nyaMMB8UnlG4XRA41AQgSXs8NKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oRCV8hg4QXOyJAxOLooJbwZm9/TcG3hn8RysKuAfBw=;
 b=VgAEj2T3sVxOCV3/N7SR2asggiWZW/YbZReUh8pv/4ltB1R+xBYA5bUn04RWhuyCUAdrGm5izlpVEXLfFaaAdFcwx1QO+i+lAJ+2TzXKuLNBZDdJLr8uAD/2bT3RXTSHJlOQvFH3EcQ8gXbqzb7j9S24JVJDrRznq8HDzRO22bs=
Received: from MW4PR03CA0120.namprd03.prod.outlook.com (2603:10b6:303:b7::35)
 by MN2PR12MB4222.namprd12.prod.outlook.com (2603:10b6:208:19a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:57:48 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::22) by MW4PR03CA0120.outlook.office365.com
 (2603:10b6:303:b7::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:57:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:57:46 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:57:43 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 12/16] iommu/amd: Refactor protection_domain helper functions
Date: Tue, 12 Dec 2023 08:52:20 +0000
Message-ID: <20231212085224.6985-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|MN2PR12MB4222:EE_
X-MS-Office365-Filtering-Correlation-Id: 1baa4f5f-50f0-414b-bfcf-08dbfaf06965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+l8se/G/A0uLasWwNscxCIXbcDfx1ukD8sT2/mV0/320LWpmMxbwe2ajEfLIznk88EJ+sr7D6V5MrQqhCswMDS1SbPxHoSy2/ppS3qPG9ESJ8/hE6oL+ZKi1R5pOXZguD+ybX4TI7PsEyRA4umsV//GCPyiUquTRH5VI8guLpb4Sz/vJLv02odCPiw/LcgUcn876VppXw6oyr1XgTAgHHHG7/sFDB+XoCJwKMKoNIQbPbFEXFqssIOKJFSqzoG4umfpP+TNltIQMHaW177bkLxLc6GTJR+NMTXGbjWbT3o4kylS/+FDcvf8yCGs+7BNFajo0qrzhH4DkRsLSEVtp0knGi9J1o9Cd3ErUk2JKnKdsThMKy3guy5q2I+36t+dqnmuoTyMUWHXVNu/s+fnzmAcGQVPEC2pz3TXWH2/6017N678Ri8BcryccErzqdAxfOlggupU51/THyaohtkpED+oCMLxzoqAhlNzkPY0gAG6v93CkuBunFunJUTHS++izJkxBNdSlM/B9xoMWn5q3SU161R5r2jajUZbIrGZOkU6ZDYbTW6fvT77HhoZogT17WFb/URyzb+X2OjXBB7EJIEEl7+mqNww7CLai9uL6gVpIT42MsJGjxBNAmnGQBkEeai1JV4hdjKWOr+FtxELTsQLoiAqWAhbxaWaLbeT28wt3lGK930rpyAxMARAcZzq6MGDMow3LVDzIfKnOwjFQ9akl446LGuzVcOJzirDOSPmsj3JDUav0l7AD7EHUlPp/NZ01mqpW95P+pO1XdhxRgg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(186009)(82310400011)(451199024)(64100799003)(40470700004)(46966006)(36840700001)(1076003)(16526019)(6666004)(336012)(7696005)(478600001)(26005)(2616005)(47076005)(36860700001)(41300700001)(83380400001)(44832011)(5660300002)(54906003)(2906002)(426003)(70206006)(8676002)(316002)(8936002)(4326008)(81166007)(110136005)(70586007)(86362001)(356005)(82740400003)(36756003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:57:46.8865
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1baa4f5f-50f0-414b-bfcf-08dbfaf06965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4222

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2f4ac415e8d8..584608b98f26 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2264,9 +2264,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2294,15 +2291,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
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

