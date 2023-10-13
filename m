Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A825B17740
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qbQM4nJR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GYIxV/XhyBTGaVES5Cq/3WiHBIeJI8KyoYjy8QqbJs09Bevy1R5Okk2rjcd0abftXiDiX+LpF/Q4XVJ2Oi+BSLdQ0CufmAyHMhsXGv3vBpqMvosxHVhMqefdD+oaFxXGUSnxXg6GQ1fLm61GD2ra6FXR5rNdUBRngqqKMrquid2VjMRDBy5KRQjgf2rp/+9YJb2bEJrReCSl0RM2POScRgf/ynMysnoBFwV6bl5Ke8RWYVIGIarm+JV/3wLcCZO3GCcrdc1yvdyFtxmiaP/fuwp6sx/RYHQRZbTPetVYpIEsMMhLlNgXzzMEicrHmEXSvxpsFT3+NFyliaSSdtxuCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZNCd2ae/0qd0GwGn/YzmhxK5Xz3RaKfCS8yXK1wdYhk=;
 b=ACUCFgUZmiZE9NyWQ8QXz+aXpWg9MKgrEgiPjg7E+154RCZGLgZFHoCP8h4ABcBm0X6o4nJjsYOQxXG8u+DEoIyQNcpn7QdXZmvpRrXdOnKp8diqxPGeImS2oLuw8nhuH9KobveOGnOv6ax5VAnS8P9achbCd34J4vC7L/ahlgKl/N9PyjTRPsGxDRLtrJ/F2V74xGJGoQikN4HiVbjYRs1yXWjUHbYHokvJgqx7hMrA9H5rvKeymFRY7kNZffueKF5e0TrW8HJbmvkWJlmOOTgFTfdUfWhn/nBJAKn/J82RUQbyj0JI1gThphWuM9LE/OEX/DFCxGPCGFwcX1LaBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZNCd2ae/0qd0GwGn/YzmhxK5Xz3RaKfCS8yXK1wdYhk=;
 b=qbQM4nJRpna4vESlX1SbEg+7S5ETXnkfisoufR95ympH6Ajp7moKYXDu13kg7l4AlG+V1reDzHv0EDJSzvsXI92i359eQ9Ibuo4DvmB/I1xKNGdM4D2Lj2CbY5jkrJxTtl9EP6HIfyyH63q1IYdnuzXdSCaG6G1KXrKLhI3d1ME=
Received: from SA9PR13CA0040.namprd13.prod.outlook.com (2603:10b6:806:22::15)
 by PH7PR12MB5855.namprd12.prod.outlook.com (2603:10b6:510:1d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 15:21:48 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:22:cafe::91) by SA9PR13CA0040.outlook.office365.com
 (2603:10b6:806:22::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.30 via Frontend
 Transport; Fri, 13 Oct 2023 15:21:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:21:48 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:21:45 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 13/13] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Fri, 13 Oct 2023 15:16:52 +0000
Message-ID: <20231013151652.6008-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231013151652.6008-1-vasant.hegde@amd.com>
References: <20231013151652.6008-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB5855:EE_
X-MS-Office365-Filtering-Correlation-Id: b06a5758-00e8-47f5-287d-08dbcc001e4a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2AAE9GrmEXCG5aBFehLRLfTJx+v0oEJQPHy4eJUayVhlAi+h5WwRqhzM/cGVfNoFr2Xake6zk8Jn8FvWLqf8Y0VV9QY7OnSBB2fMs3UEuhZ1i+O5B88Yz/QZtFmIeYAyeHkaDf/oijSED/QKaX/VvGzbVExiMyYNXGmbz4x6p5SBejI+V2WUT9EXlJC5RUkVCroiUFqMhlF//epWgA5TokRHg/808pCcXysciAP7Fg9hdHeu+52A9+wjTn1m1XLnHNaKdGRABl9oIr/Eo7De63i01OqZ6BExrt6ftwE/qHbUNQ2U5exMFzbUvp1DR9fLWn0ycIAQyrl1OYYXLDmLWLBv60+6Ey+f/xYeeV7ZtINVo/pU0/bCPTQgi4W8b5gNiImI/tfoJTj3Qv3tqnoFclgBwABBj4yQqDavCdyaR9t9HhbHrXgtDUmWkTwBgo9UFc7ALn7zdYfCXmVIfGVYtDcLn44WsGST/jIXXoZHgNlGlPagFwWbVsJnhOAJz8DIsgTulMjcYXoq/NflEeg/AynPLdgx/y4yqXx6GfYu2rlighvmQEUPEW6KAL5zwb9nXajhuGBDHgjAHRdVZgZ2hKzAg2JxFuFomJ+joQmAsnalMIvpdUl42Eewp3iTtueptgCLK+DZMPCySWqitfhL9vW73tWpRnyktw/emMndbFBYLLlOINOsMUzlH36uxIyS/Mb6H1XdqTg783hkUIKgUw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(230922051799003)(451199024)(82310400011)(1800799009)(186009)(46966006)(36840700001)(16526019)(426003)(26005)(336012)(81166007)(2616005)(1076003)(356005)(508600001)(86362001)(5660300002)(8936002)(44832011)(4326008)(8676002)(110136005)(2906002)(70586007)(70206006)(54906003)(36756003)(316002)(6666004)(7696005)(47076005)(36860700001)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:21:48.2674
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b06a5758-00e8-47f5-287d-08dbcc001e4a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5855

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Also remove V2 page table check in __flush_pasid() as this gets called
only when we have PASIDs enabled.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e836438a9318..da94dca1eb92 100644
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
index 988341ec499d..d6e9f1ebd1ea 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -92,7 +92,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
  */
 static inline ioasid_t pdom_get_default_pasid(struct protection_domain *pdom)
 {
-	return (pdom && (pdom->flags & PD_IOMMUV2_MASK)) ?
+	return (pdom && (pdom->pd_mode == PD_MODE_V2)) ?
 		IOMMU_NO_PASID : IOMMU_PASID_INVALID;
 }
 
-- 
2.31.1

