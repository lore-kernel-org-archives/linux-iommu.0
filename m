Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E3E7F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:33:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nSJvwYM8v6C9CRnmXf5UyO2mvvQd4FFK+EHvZ2nS1a09sBGMiWLO8UzP15tQbR0nvOibOxC2WpaGX6aCIYNqYXeaQm5AAJEh0orGIGDfZeSexYIhv8rcqEZ6RQdsyCvWCh2T0CARRrVXWnC4AiMQPbgb7yOY54T1IPZByaFnB38+PCTFp1r7EblWGi/kwWpF7T9saXvSgF+x/827+ffi741PM9wIHbKnc4WH8xPonMvrL5PgGfDsAdX65L4jPHtBaA8EwsLEqnLcADoPs+P3SFNSZKqmycS0OuEwCeoP89DN6oGw0zyow3bsJyXZJQVcBMh7CtlUyz2+uvA6u1axqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJfGy/7dC3SbGJ87nS6mgUQsrr99Was4Zx/FaHPtTgc=;
 b=TBavQzE1GU/5LLWsyS79b2u4djQn2G4tnU0dIyesF50x8iI8m47Zebipbz7VqHvuUXqSnjwURogkawgl1G+h226gTeX1xrvvkmmSNBVMe5/ApCDvY24Oqik8lGyDJ+/XUjU1ylqrSTLckcHKduZBPSWb0dGFzb7B3+aHhTvRk8sLSZmL+GsLVX7WJoyPSz9JA8T/qnuj6sQB74q0Nno27T4eNRWVlRP8xNuKkpC0UM+8KQ2RZuQh6dMqoJfMggUIjHeHxAIJarDiShMqpFs3+74prTW0h16aje2WvitfW3kR0FlL5EPCr4JoTUd+BCNPKm+YarUACKVK6wz6VyGpTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJfGy/7dC3SbGJ87nS6mgUQsrr99Was4Zx/FaHPtTgc=;
 b=wVk5Tfk3b/lKsVmuidBjPbGRATo4EnYCOfKhcjPz9S76/9UWhaIVXNj8oA4ug6nXRumVx5rxHsbYe3ejf8gbNWu318AVdYD6HkBo0QR6bj5UE7BKV3UiTMxXnSP/pvBcnM9GcDgVf9lAmiZ19gBCZF+rVOfZUEW/S8uJ5Lzhp94=
Received: from MW4PR04CA0208.namprd04.prod.outlook.com (2603:10b6:303:86::33)
 by BY5PR12MB4997.namprd12.prod.outlook.com (2603:10b6:a03:1d6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.22; Mon, 12 Sep
 2022 06:33:42 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:86:cafe::c8) by MW4PR04CA0208.outlook.office365.com
 (2603:10b6:303:86::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.20 via Frontend
 Transport; Mon, 12 Sep 2022 06:33:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:33:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:33:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 2/5] iommu/amd: Protect domain update with domain_lock
Date: Mon, 12 Sep 2022 06:32:45 +0000
Message-ID: <20220912063248.7909-3-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220912063248.7909-1-vasant.hegde@amd.com>
References: <20220912063248.7909-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|BY5PR12MB4997:EE_
X-MS-Office365-Filtering-Correlation-Id: e4a4bfd1-32a1-4f71-a8e1-08da9488bc14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2JbmYSg45Xni2E7orir9JwwSQBl8C/KDSaAeJF2XYJPHYzy97VnwJe/PHwvjTFwnG4bi1HwsbQnTOmLAZpqTvOnDm2EJ+Wed7Q7/gDEbEjNrlrCjRvCzO4i976F7Zl7HbhWmN2l5s8Of6LjFIqJbWWqcdXPod4xRT++ApoBfTiLNj0R+ADCgp9hACXSG8OPkGPEgCTgT2qS7F9BXTgF4PNZTSyjaaM6S6PKUJpja2K9klKDvrZqAasgrBmZ/p61oc8H8mewWQ6Bv8dRQb9z+FyXGO5yLWEoFmLNn6bT1r8joxSJdaru3mh7jXppSagulGZu1iIa8Yhh3rv91yleKTWE3/zgTvCXBOVdctbK1DDvpcUrMLfL4OcnMJs9NiAD/YQMswrFroRkdTxLAF9+rakj1A2E7F79L8A+pPtNL9ZWyBo8VB0GKvliVXVCdT4AWVWlIad2NFtSXN412nxzZDFnyq11Kr/NFY/oCY/ck/i4o39QG5Pe800Njxjpcy4Api2073OUy441Akzq0uvgpkFMBqaEn/iwlnMIIhNJFrbq2ctR6dAy7FVRUBBrZ3lbV/zGn8DKfE695NAURqIwJCwXlh5GFj0wQ6dWnba081xCA6iByPNRKxLK9+vIYrxqq8y1TL2+E03z2v+vkvh0bsSUL493ZTwlzuWWliUAJDI9t14UhQMfjaxwzeDrN1yNhm4wsi2ZQteH4V93WcNuh+S8Ze/IyRyf/mB/z/HVKcZMlgWB+SZQqrJVcP/vvQehtW/9veW6ZwdyyBs60V2NURf5wn+sX0ydIdLEi0I5Fq1jHxF89qbW8qbY79+kPqUHH
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(376002)(396003)(346002)(39860400002)(136003)(40470700004)(46966006)(36840700001)(82740400003)(356005)(81166007)(110136005)(82310400005)(54906003)(15650500001)(36756003)(316002)(40480700001)(36860700001)(478600001)(70586007)(70206006)(4744005)(7696005)(26005)(2906002)(8676002)(4326008)(44832011)(47076005)(426003)(6666004)(5660300002)(40460700003)(8936002)(41300700001)(86362001)(16526019)(2616005)(336012)(186003)(1076003)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:33:41.5936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4a4bfd1-32a1-4f71-a8e1-08da9488bc14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4997

In protection_domain_free() path it calls amd_iommu_domain_update() to
update IOMMU.
  protection_domain_free -> free_io_pgtable_ops ->
    v1_free_pgtable -> amd_iommu_domain_update

Make sure its protected using domain->lock.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c55f4a129b1e..f49980956220 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2001,15 +2001,21 @@ static void cleanup_domain(struct protection_domain *domain)
 
 static void protection_domain_free(struct protection_domain *domain)
 {
+	unsigned long flags;
+
 	if (!domain)
 		return;
 
 	if (domain->id)
 		domain_id_free(domain->id);
 
+	spin_lock_irqsave(&domain->lock, flags);
+
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
+	spin_unlock_irqrestore(&domain->lock, flags);
+
 	kfree(domain);
 }
 
-- 
2.31.1

