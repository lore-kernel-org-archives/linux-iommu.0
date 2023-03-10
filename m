Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2058.outbound.protection.outlook.com [40.107.223.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFBB23AF
	for <iommu@lists.linux.dev>; Fri, 10 Mar 2023 09:32:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eNk+24ESHhFWrc33382uk2BP5zlQYRsYSocCqWpwZFc7o8QE19cVpCHiDZBQW666Rlx3qvXrFKCDL3nF6xC0CGZcnVyqgCxZ8ve6mlqfCD85GZ9fznv7+UY1qFQFj3G7P/aWb7FkimIwFmv6YsHsxVvrOZCb94zQ+vZMygzG9li5aBZHmGOTfFMJPWfJbeRzQy58IVIPbDmh7DW3pA/T7IIXEzZ+RZpJQxfKdda9ignCoDgRTLHkdge2dNMDSWVON/EAgDVg4zOUIHNXkBxze8SDm62H95JVz4A3p7J+S/XtxbDRDv1hWlWN6NIw1SLfSVoVxkGqwIw6dFd6cPYBrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eJoypkHB7yhq4sa03AZFRFQQDheaI7tv2iVyzJV/m34=;
 b=SURVQC2n8UZwGcOEJijQzQWUpudBms6xBPCH2MkpQjBD9VDRbQKdiSHyVjbESm4dDQgNalj1+BlSZAtWWQV6jZ808Rqv49S2dd4IYm6zpApNQSA4QE4MFyLhPzIlIwQQ6yZ4dO7GGIYJKJ31nIunGDsni5YPiIKigsPvM0STaUWog4QVpg8X+ZZrWgAqip2Q8OLc2h583UnQ8a73VESGwWpuLj8RhWx1Az5TvNGbw1+lXYeaVFG+8Fi7d5tgowzgptAiTKq2jygtZwLOMWNsV3qfGjbkFBNZdtJZlQIcdSYO4vij1bFspHxxqJ/ICLnJtSI8827DLPr91Urjk69mQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eJoypkHB7yhq4sa03AZFRFQQDheaI7tv2iVyzJV/m34=;
 b=GkLunvO9fWHiV6UosBmkTk5zSVSwy9Vq0ueWR9PySZ8DahKhXDuJYNW2cHk5oFXED6du81Bd5PR/XaAwYAM0qUt5uNkc00rXVHJ80/DMIC3acZHu4twd6KKkyScnQnQO5zXPd3TnxrTy2ZwRMm+QUCa4HwdLZtP7IzMrCk4OpXw=
Received: from CYZPR14CA0013.namprd14.prod.outlook.com (2603:10b6:930:8f::17)
 by MW4PR12MB7016.namprd12.prod.outlook.com (2603:10b6:303:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6156.28; Fri, 10 Mar
 2023 09:32:10 +0000
Received: from CY4PEPF0000C97C.namprd02.prod.outlook.com
 (2603:10b6:930:8f:cafe::c7) by CYZPR14CA0013.outlook.office365.com
 (2603:10b6:930:8f::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.20 via Frontend
 Transport; Fri, 10 Mar 2023 09:32:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000C97C.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6178.13 via Frontend Transport; Fri, 10 Mar 2023 09:32:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 10 Mar
 2023 03:32:07 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 1/3] iommu/amd: Add node ID to domain
Date: Fri, 10 Mar 2023 09:31:28 +0000
Message-ID: <20230310093130.6064-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230310093130.6064-1-vasant.hegde@amd.com>
References: <20230310093130.6064-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000C97C:EE_|MW4PR12MB7016:EE_
X-MS-Office365-Filtering-Correlation-Id: e4723deb-5eec-47d6-103c-08db214a527d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DBVsdCxOFOS3fjQsQC9mj9SftGSJG6VvrhKQKrxmOyy/mB4EJoUMnOhuQzBCOUrJbf8glYIqBCB1rkaLz6CdTTtAgKth2dhBZrc8aRIKvihrMdN9e78/9ilTI0asEes5LGJEFDw7e3EkDblR70ihmic7+Keve2eTMVGfQ1SJj5cYL2npocnFJqhk+XKGhem3MSoSxHCXy0fqcegXKvhAkYurPmW9Ev9buf3MPQXZsSUmSWEQIGqb5VH7wUZhlnwDPBK+t5XgeSCjoVfR1uTN/UpmUP0wNu3dlv9TbmGnYHxGkF8PZZzfmeTimgZNFZmyXCW0SAxsSecTGRWCyLmKDRzTtKXbsvzSzfdDlGGoOn6WkFVTORo6FEYYYUmOFF7EquSHXOUiLz4PkYR9NRKa4zP2S2QWIAbXMrX3q6aG+zEFPqXkVgDn159Z+C7sj65NgACy/cSQp7QV1GDKwsyLZtWuR9W4IgvQtFn3zpaoZLX163m2FsHOUV3sJ5mf+VB7js+8N7qJIyPTz5zrgtGLSHtKyH0DimOaNhzoFCPhQiV8tSztTUQUOFiQdzv7WuikcGlNffMCc/xP6DRY9fb0EMjGlSwMiac04VozqJpA+bbGEeAiunrhIlakNF+9yH3BDBKxVGerYtCvwogznhbqPiUy9+QLATeQAOwRa0koYsJKddzMcjIBiL5oGvVUVgRdwVCBssDs+VGpHBiLCyyNnjEafUz6SsLvlH1uGBlxqVg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(136003)(451199018)(46966006)(40470700004)(36840700001)(336012)(316002)(54906003)(478600001)(47076005)(83380400001)(110136005)(81166007)(36756003)(82740400003)(36860700001)(4326008)(426003)(8676002)(82310400005)(40480700001)(70206006)(70586007)(8936002)(6666004)(7696005)(16526019)(2616005)(26005)(1076003)(186003)(44832011)(356005)(40460700003)(86362001)(2906002)(5660300002)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2023 09:32:09.7187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4723deb-5eec-47d6-103c-08db214a527d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000C97C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7016

Add node id to 'struct protection_domain'. It will be used while
allocating page table.

Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 1 +
 drivers/iommu/amd/iommu.c           | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 3d684190b4d5..e5cfdeaaad48 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,7 @@ struct protection_domain {
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
 	int glx;		/* Number of levels for GCR3 table */
+	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5a505ba5467e..5452d0dd6569 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1662,6 +1662,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	dev_data->domain = domain;
 	list_add(&dev_data->list, &domain->dev_list);
 
+	/* Update NUMA Node ID */
+	if (domain->nid == NUMA_NO_NODE)
+		domain->nid = dev_to_node(dev_data->dev);
+
 	/* Do reference counting */
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
@@ -2097,6 +2101,8 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (type == IOMMU_DOMAIN_IDENTITY)
 		return domain;
 
+	domain->nid = NUMA_NO_NODE;
+
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops) {
 		domain_id_free(domain->id);
-- 
2.31.1

