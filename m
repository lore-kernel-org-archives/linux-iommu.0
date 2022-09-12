Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2070.outbound.protection.outlook.com [40.107.93.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4D67F
	for <iommu@lists.linux.dev>; Mon, 12 Sep 2022 06:33:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bXglnVeR1RmO8TzvrxpXrfgMRarnckfxQYqxzgrwQ7wTroB/crtVSLSpe1Hob7KEgsqKefKyr0IfHnYUwoHKfdWzJ/1+e5ilavXV8KDhFRjRsvJfZq/4mFw7lKR8VlIoeU128OeZyKbFYiwueE0wOnlOaGoensbWODm5pjkGoKr4derdBpg+n60J9+eQYk7K7dNbrCgMQk+1U1/gkYM10OR9RT5ErRE8ERSYWCxRMzDIU+JlIPyTOh5DMhDkBBZfgoQSwaYBPjKTqHt7ZZHDlCHbvAVLMjtYujp0u/QC1Th5UV36xhqbvTx0wfHZV0YRkWxMlcRmnVZuFgZsv7gDug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DIEx9lam2GfBTpzCkg15NVnFZxXgiJrKRYVVUTzA+o0=;
 b=IjxnP2RosC/kJYyXRk1uD8j1/4iOMJjllz/anh5OQ8AYY0Y/QmzIuKu5lginKy3TnGQ8A61ATvwsl0EUaNMyLWtnNKpAYmFBAENakmAkWDOYJ+5CF1MdntVwH1HBr3INNLScPvmPWAtaCjpg5IFV2jnFbzlxeFXethY1KnYlimgovbo8E93XiYMTRmoN4WI0REqdkAE4xlDid6ZRQqdTzBwxSum1cKl06X9VUnnT7g/svcMhHW8Rls3hJpHjkvcViTLXJiZfqrPwjK1lRu2SCnDgeW0IUA1ZKTEWW3fyxPyHPQchYXbwW8MpH/rkRyjYdg2q8kJ2YQOil+Y5z+/rQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DIEx9lam2GfBTpzCkg15NVnFZxXgiJrKRYVVUTzA+o0=;
 b=DEAbo/h9ZC+ZFINQbpyEPpU0ebeq03oGzR/zewfkRiVZQDEZ7KsmiJbkYebB3koqzq7Ny4q42CbOTD9L7yGn1uk6yjIPaEqDYmC/LFaV/5WBAyIf2iEQJhd7rHhXIOyIC95quF5Q1ge1pRw5JbfyWc554o/AQlZsZA0Tz4/PZSg=
Received: from MW4PR04CA0071.namprd04.prod.outlook.com (2603:10b6:303:6b::16)
 by MN2PR12MB4320.namprd12.prod.outlook.com (2603:10b6:208:15f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.16; Mon, 12 Sep
 2022 06:33:27 +0000
Received: from CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:6b:cafe::5f) by MW4PR04CA0071.outlook.office365.com
 (2603:10b6:303:6b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.18 via Frontend
 Transport; Mon, 12 Sep 2022 06:33:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT104.mail.protection.outlook.com (10.13.174.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5612.13 via Frontend Transport; Mon, 12 Sep 2022 06:33:26 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 12 Sep
 2022 01:33:23 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <robin.murphy@arm.com>, <suravee.suthikulpanit@amd.com>, Vasant Hegde
	<vasant.hegde@amd.com>
Subject: [PATCH 1/5] iommu/amd: Free domain id in error path
Date: Mon, 12 Sep 2022 06:32:44 +0000
Message-ID: <20220912063248.7909-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT104:EE_|MN2PR12MB4320:EE_
X-MS-Office365-Filtering-Correlation-Id: 466fb1e8-83d6-4ccf-51bf-08da9488b2f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1Q6ZPlH1xdhvnjlrQdd6OkyfEijU9RSpqHLbiaVarnTDy8gTLNv4ZhZPCxxSa/C6pziaEKRpe5RKZ9+AHst+9zGut8VDYGvxwn9GSFVgB7TigJsiYPmvhwCRoauW7leLu02oTdMh/HRaQt10RRr6Nra5hg2rW4U/MUUzREEpUgEL8HL/8cwBFGm+Bgf4DWgw3pjxpZzgo4MQ3AYUNItkyPiTnORcJ3hcKpVjFZ7Lven2LFingGbpHTV5MKCv+0CBw2CDDdToN5yXIcyBZOSmH+WHPDZXTOsQ3474frPCT5D11NWLA7X3sw5tKgegZrqEjcmenz0j82VIP6cJs4VrP5gM2TkSgiM3kIIPH79Jy5kyTzUdGhSP53+IvWM+z4XlGmPm8hAkXInnIz28ajJZWp4dxyDmxz7XjG+Pfu7/ubYzG3JdhJgqT2T4OimCoBToLKLElpMpjnsQsi4wXpxLrVVydD11jvVTdYbDWSaxtH9dpVhVpohTmceqc9bn5msFZ1JRF6QjGSEOiPbnUyoECJ8UvxuS+wfKdWY5fU3GAi6kSP7yLrEv6KFH306fMEPlEempxBC7v0s1N99EXydTiASTKVbjDW+mN/ge34Pz3AIC+buUjb5kHu31yY8vSvWsajygVOpwooqv4a0kEa0DU1fsfLQ7jp33NceQF0KRP3hWRG/zX1mrrORxD6m3bUsjr+DeirxRliahRW4ZKNCsc5pGh7UuGJyLm7pHk74DCFGygUSTYnG3MEzaDFWruYK/1Aps789EudQC0vOINHcqZxbPn+5p+vFjaOPnFxpUfbGMVJKqAFCeq7eVqOuWXiAX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(396003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(2906002)(82310400005)(8676002)(70206006)(36860700001)(4326008)(4744005)(44832011)(8936002)(356005)(81166007)(82740400003)(5660300002)(7696005)(6666004)(54906003)(26005)(40480700001)(478600001)(41300700001)(40460700003)(426003)(47076005)(70586007)(2616005)(316002)(1076003)(336012)(186003)(83380400001)(16526019)(110136005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2022 06:33:26.3356
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 466fb1e8-83d6-4ccf-51bf-08da9488b2f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT104.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4320

Call domain_id_free() in error path.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6bfcac8de1f4..c55f4a129b1e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2027,8 +2027,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 
 	if (mode != PAGE_MODE_NONE) {
 		pt_root = (void *)get_zeroed_page(GFP_KERNEL);
-		if (!pt_root)
+		if (!pt_root) {
+			domain_id_free(domain->id);
 			return -ENOMEM;
+		}
 	}
 
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
@@ -2092,8 +2094,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 		goto out_err;
 
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
-	if (!pgtbl_ops)
+	if (!pgtbl_ops) {
+		domain_id_free(domain->id);
 		goto out_err;
+	}
 
 	return domain;
 out_err:
-- 
2.31.1

