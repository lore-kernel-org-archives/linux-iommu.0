Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2060.outbound.protection.outlook.com [40.107.102.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F132174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:43:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TEvbuNKXOI0eoxazW47FFxIwHzu26gJwLMEK0cYhEyw3pI+fwxrZh8g18bUid2np/2ahM58arItSKBEERq0XquMt+CpFb18U67QH/DyhZsVXo3nJMk6Incy393RV91ydi+Er9peKslfoJ0PoSkFB3RNsvm46YXPCmVnFcMwR0BbQcHm0iwZUIDQhWLGy6297t2FhCDcE2eF4746hqaxQioInCyeniYGijEtuFvncXmj/OAn19z4ht3OJ5ZCd6gUxKIycpjP4UlDNPQme5pqnymIJcoJ0m86NgBU0fnWd/GphxKzesFyxLp7tQMgiltXjEgZAAY22c7QZrmwZrxHsjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nc3owv2faDpOXgToJviKCRRiWaWjkwGvjuMDyq5ANZk=;
 b=SEILkrFV0YaqUgli+0+M3ogcP0xstlhWC014YFv0j3IR3M+NfZmHIWxfgyOEM2R8GhWSX+MUtxKSzmXbiWp8O3r4a0i3VVNwhib5kHKoe6dRj7Gnvzd01SYkDQJpqLogPBCPEdl7EPnCHw6Yrnh4lqk7tzyY8Do63NYdUdXjaM8m6+OiE8HCXj1WZEB/bWEFGEFaFy1mEWIcLx/ic+ijicwer68Ph7EWqfy8hQm+EL1We+JwMj+x20xqoXcBSLYkB+d0QICGmEsiN5ydvbpgGFeOGgnpOcjTCJH/uTdn2+Ey6YJuOCjWVsEcwiXHpcfbBYacVoFTMYYrbbU9Qt4cKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nc3owv2faDpOXgToJviKCRRiWaWjkwGvjuMDyq5ANZk=;
 b=M0VsfwixRkb7gMz18nIvJkSXe/qkM5+hJ8x1FWdT9V1XjBl+y02lFHK9TOe264GU212Oox7VXL1/nP/0XapZN+Cg6aJ9rxHV0C6Y3Yos0RZPUJ6wGOhVV1kK3igqo96hPLvPVyVE9jdcCZfoR4+Boupck1bzftYldpcnLifocKQ=
Received: from MW2PR16CA0039.namprd16.prod.outlook.com (2603:10b6:907:1::16)
 by PH8PR12MB6820.namprd12.prod.outlook.com (2603:10b6:510:1cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:43:33 +0000
Received: from MWH0EPF000989E7.namprd02.prod.outlook.com
 (2603:10b6:907:1:cafe::5e) by MW2PR16CA0039.outlook.office365.com
 (2603:10b6:907:1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 17:43:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989E7.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 16 Aug 2023 17:43:33 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:43:30 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 10/10] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Wed, 16 Aug 2023 17:40:31 +0000
Message-ID: <20230816174031.634453-11-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E7:EE_|PH8PR12MB6820:EE_
X-MS-Office365-Filtering-Correlation-Id: 5072a03e-591d-41a9-af72-08db9e804fd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rAhS9YwR3JNMck77CKMSvY5vbwYHoIIsad6bNYAItyGDeHwzatLxXA+U5QFExpsQPM85zUzdNmxkj6yNNeDi5Ya8dSQ5h5uOY1QH05TUB7mW5EPISUNh6Fa8b4eszeLKZskahkR5NONxvEhm136/5ra+cctPT8VEhLw2gqG68ZsWv3azlHbKZCj+6o2DcgHu5+MYEO4xO+11RX4Fk9YvaSc8sqrgtIvFzQOKrmjoeMOURXfK5DesIpXNgOTDx7sXIp7V28812lGMXguUgDdk4vf4fCxi7cZYbTwguunu3pV0zmDS959FsdVDzL45tjoXJmEz6+iO9PiASJPlPCqhaYwwd34iwM3FWkOx1X4lq6JwR0uJpPXEZJWPRvaypvPIoSb92As1gulSRgkhgQCa2BNjlASujnitNLrIfH7AOafLJhGTGYhBiPXdZg6mEoRXaQvhgPKsqbystilpbqz3jP+PTFOw19byKy7VgZjtbR9D1hc1KHG8vowgyhk8wUgAPX3JJRLXFQ7sfe9EYrhThqAeCXiQgjbP2HRz8uz2Wx6YirDXoHlKJJDkfjAvNwH0sNeVuHcxFxgF5XqndiDCw43JwKmgVwnZ5V2bEdt08BhqWY1ptROhz6Nn/HbOWpefgWlThLm6QgxHjOyZF6CfsaRPLaBzrLAhEoaIRPyv77H8Q07GxQNVJZgPWFKjOzqCPVp/MbRCmBq8qCz1NuXev9fKNsgBeBd9B34FCqbUVwF5RycKoOKotPKQu4ER0Wr8ydA2J9f17Tay/YxY66nAjg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:43:33.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5072a03e-591d-41a9-af72-08db9e804fd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6820

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Also remove V2 page table check in __flush_pasid() as this gets called
only when we have PASIDs enabled.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  3 ---
 2 files changed, 15 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 1c4672ed90f4..b1a54d8c7506 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -442,15 +442,6 @@
 
 #define MAX_DOMAIN_ID 65536
 
-/* Protection domain flags */
-#define PD_DMA_OPS_MASK		BIT(0) /* domain used for dma_ops */
-#define PD_DEFAULT_MASK		BIT(1) /* domain is a default dma_ops
-					      domain for an IOMMU */
-#define PD_PASSTHROUGH_MASK	BIT(2) /* domain has no page
-					      translation */
-#define PD_IOMMUV2_MASK		BIT(3) /* domain has gcr3 table */
-#define PD_GIOV_MASK		BIT(4) /* domain enable GIOV support */
-
 /* Timeout stuff */
 #define LOOP_TIMEOUT		100000
 #define MMIO_STATUS_TIMEOUT	2000000
@@ -561,10 +552,7 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	int glx;		/* Number of levels for GCR3 table */
 	int nid;		/* Node ID */
-	u64 *gcr3_tbl;		/* Guest CR3 table */
-	unsigned long flags;	/* flags to find out type of domain */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8d3d520a525a..15fce04ac59b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2594,9 +2594,6 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	struct iommu_cmd cmd;
 	int i, ret;
 
-	if (!(domain->flags & PD_IOMMUV2_MASK))
-		return -EINVAL;
-
 	build_inv_iommu_pasid(&cmd, domain->id, pasid, address, size);
 
 	/*
-- 
2.31.1

