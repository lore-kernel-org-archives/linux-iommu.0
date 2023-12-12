Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2061.outbound.protection.outlook.com [40.107.92.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA2C48CE2
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ehBg03oB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d8a+nb45HZ9Is2iYHClVIN8M8FsxQB5QFn0701KlNVsEbIHw4QzVYrOSBY5HYFImovGguYBFFQhpR4auTCG1tKgpDBOoo7sksGxS5v8XDtwMWEz3AoBXrcOPRKnDAp0tXp5Eariij9vhTTp7LsKKcuwQeBnA6Mc1aRLYlI/hMc2Pt9VDvdGzbKtn10FQhA4r27hbDzej48Z8jUId6LYo7i2Q7pA9tyxRy3UJaro01JOROB06VzOKVgmnY1iRNc72df9m/gcr+e0ROJ1XyD7o/LhsUlBRQn2xBg3ThnXsvwlN2duwej0rC/cxOsN91+mN5jb1zm/Do3uzASsb8BN9UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0a+stk0q+FnU28eyNiJ99eV1mkkVZbSW0zgPqyZmRw=;
 b=PWrT0QwRxrP4hA9dRRbKfmILOxwpBGt36C0bdI6gcN5rLRUIwHVtpSG2ee8jfGHyohJVmeJ+THSEsfAanHnxY3D/qdLVb4BUbA9QlwDjRjlVK0Mu56YaEYo75xl98k56ZjVNqoQndayrZZ68nJQF5vYrQ6BZLtqV1fRWCQZlqOdySF+pckMnfOA+hLYUp5dgxK9ZNBzh6UNigPZV93vW1wHFw/VvDxZStn0sWblEZlKnOvpx5Za9nxfo7yDiKbVlYdbZNROOD97pauRmPdKL7rTa2g2Kp5FsYCGVS4RGO3I3OalKcVph7d9OhhgnuPChEel1+XWSJypLVLBDp+LTrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0a+stk0q+FnU28eyNiJ99eV1mkkVZbSW0zgPqyZmRw=;
 b=ehBg03oBQPzEE5OUVyGHx8szPElxI/QIC8rmGb/AvjgUmR1ubtVAKZ3ZfbUmV+IcvY44UnfQleXsFqsgxC22WdPo7ajpX0vcTkgT7M2mTF2YxC0H1vaBmwNOAAkVHmPpPOy9oYvLvrV2cjuO++hNZG2nzsCvh/UuAgS9kI55hsA=
Received: from BYAPR01CA0021.prod.exchangelabs.com (2603:10b6:a02:80::34) by
 BL1PR12MB5078.namprd12.prod.outlook.com (2603:10b6:208:313::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33; Tue, 12 Dec
 2023 08:53:39 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a02:80:cafe::e8) by BYAPR01CA0021.outlook.office365.com
 (2603:10b6:a02:80::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.33 via Frontend
 Transport; Tue, 12 Dec 2023 08:53:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:53:39 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:53:14 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 01/16] iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
Date: Tue, 12 Dec 2023 08:52:09 +0000
Message-ID: <20231212085224.6985-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|BL1PR12MB5078:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d3bf989-2f18-491c-f701-08dbfaefd5a4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	BKUZgRqx3bcQnv2uFf5bFVRXUKtcctLp7yCRvVojtW6BleyVitS/21ssgipEuSlykxdU/yuzX92NlH1Qq8ataJZcmTPNsGwA8tpWZ+r07oQrEvK09bc284RkNYkKZ10hnZWPmZZtdZ/T2XmDFaWMHhkJiYlh/VkecABoO2XMGbtoYrY/qvaH2gT0TIaKDsDRQsYwUb/3vr4UpHglEGuAfhAJcFz52NCazpCWQ8CbLYmih+TUpfEm30o8L9vAK9zGes/PGNXrEXssMGNHefKvwYOdzGt2mhm7SWbhd1DlP7gVOQ4TBsV5BzUpi5qVjzMA4AEcLCeULcLUo9DtMKz8BrCXPXuFdj2d1ofVNTuaIEgqFJ5cJNFvhmhPIwuT+sVX+cud60WU4l2G0sbx6YNLzL9efxTYG/HG1XTifnGvnX7GmrTNlxb4QDev5Jv9MunQLnpoGvLz2blK816vHB/wG/LOdMtYdNeAucuWNjL9bxRZ5z4uw/ehNEj0r25WoRhRPeopwa51rC7KgEIpLea2Kx9sMJAut6IJ4M7Qai0UTMrtF5cg+gXAkGMs/CNWVmfydXb9jhoaHXS47eotk51ghFA0rrgqOVKiR5+Ts5GWhAsPqzf3wPpCyD+OZpLW47N0JV88fLvkP30+PSDaSQLjvdxc4korBo2aBWJ6h8DAeRi5MV/BPLwI2UAO1gXyBz8G7l241XHamz9+Qzbt8uwF/rrZj9aDFmO9YM4zMir7oeze6wslDPqXiEKKO8VPavXx/xNzc2kcwineteqJfvzsuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(136003)(346002)(396003)(230922051799003)(451199024)(1800799012)(82310400011)(186009)(64100799003)(46966006)(40470700004)(36840700001)(41300700001)(5660300002)(2906002)(36860700001)(1076003)(2616005)(47076005)(7696005)(36756003)(478600001)(6666004)(336012)(81166007)(82740400003)(426003)(83380400001)(26005)(16526019)(40480700001)(8936002)(86362001)(4326008)(40460700003)(54906003)(70206006)(356005)(316002)(110136005)(8676002)(70586007)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:53:39.0136
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d3bf989-2f18-491c-f701-08dbfaefd5a4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5078

Pass iommu_dev_data structure instead of passing indivisual variables.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 255ea754c0cd..474c073a422c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1706,12 +1706,14 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	u16 devid = dev_data->devid;
+	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
@@ -1731,10 +1733,10 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	flags = dev_table[devid].data[1];
 
-	if (ats)
+	if (dev_data->ats_enabled)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr)
+	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->dirty_tracking)
@@ -1810,12 +1812,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	bool ats;
 
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1830,8 +1830,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2015,8 +2014,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
-- 
2.31.1

