Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2077.outbound.protection.outlook.com [40.107.93.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0524ADDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:09:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oQJ019y/M+wf+yMpTRIIJLQvODoYdFgs6FYXptSOxDkWh0ACMIL3ertuUooTJfmZWfgpWFQ/hgQxfG3tM0vxrah+lLwU/sDX51sWLz302xNne/eCMPjElIg24j0c290pEmrWnEmfmN0YE2Q5zYiPy3oPj1mk0Gl+Nk7L8nNv+LOl1DpAoP3i1A2gn9UeMNej4n2OF5Jj/0Iinn1dH7Pe79a/LSoJUaocWKvEV+yvY8mAlJ1pOWq2JVjvsu8ie1I2oaLmP2XMJg8T4nhCCP/PXqySvpWAi7YPxPpN/RDyNjWkiX8SdCoDpXE7/47yi0V5cW/57pthHtvBzjTq3KKFAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1L9A8CqxMHORjU3UCcFKzE/TShZ9dVFsY88W9jrbKus=;
 b=mq0gQbImSmtErtRlS0Qf4Ap9zNNdmYyt9JtiHPq0BwcV7az0kKduUuysonwTNgMN8MjL2u5GI+qV+2Nq/EZc3i+NpxZARtCD15uABCDQsq9zqdWINhvdi7mxzgLoD0pEqeiW7KB+tah0On7ErrYIOn7tmxNERG/687qNuiy8QRkfQprzuEFYVWvlwkJChLF9nJxUOv6PeGWjglDvt2DdNkk0Tc0BcAZxe7c+Ge/trmVrFM7hXl+lzvki0Tgo3oNaR/hNe+/03XjrqpfD4eyXqZXX97Gz93dq6D8pAc8G/N8Ok8LarKRKDEz6etxldAdxsg7LYbfSJ+I5xzbsLSfhRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1L9A8CqxMHORjU3UCcFKzE/TShZ9dVFsY88W9jrbKus=;
 b=GZ8J1eljA7gzmf3ulhtEuLL5BOBYVR6t3/IVnWQ6GA1QHmIptB2pE8nTsweWz2Xc1j+muIA0a3dFBR1oHaH7WOjF+HE2RmaTGDkDuzJO77w7a5QKO0baSZcvVSoI46x1LuuFGT8Iivx5ikEVZPLP44WQIVLA617P4gJ5zJAga0Q=
Received: from SA0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:806:130::22)
 by CY8PR12MB8300.namprd12.prod.outlook.com (2603:10b6:930:7d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:08:58 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::e5) by SA0PR13CA0017.outlook.office365.com
 (2603:10b6:806:130::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.16 via Frontend
 Transport; Tue, 8 Aug 2023 10:08:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Tue, 8 Aug 2023 10:08:57 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:08:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 11/11] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Tue, 8 Aug 2023 10:02:32 +0000
Message-ID: <20230808100232.5977-12-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CY8PR12MB8300:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c2819fb-1a3f-418e-fe1c-08db97f77b0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rd/cf7n9k6yidAEhYnv9EWnwMCli45JmdLnx0yfw8oZf71srxi/f2D8odfl5YdNB3hATCWEhz7Uyv4ltd61Nce6QiNK4fz32q++QkMP8ZsXyF+vyXsmFvoOmbcsOWGwZthwFcPaLVWqua4N8MTb4UT1VKOUq93IDN6y/JvFenzGDCtUrswMDjhcyHLJxYxvBZ0cxv6oDp9h2EKX68vgW2o/5KbFu/S7/KsVlhDF8f5KWHUhAPgHXCqWmpCdhFghUu1yJZlhSkd9cXPPoBrZoEb75RiAqhflq/J9p8gnJNqxctHdJ7nuJqVJLj80g27akmta4tnlPFkAPMQ1+0NNSz9P8N0af72QqtHduVlD2QL8ylTVuOK++he+PidynNu6IJ2ueEquNh/pokMYwrgv13gNxRGmb43R8dOFWXCSDawBoYdEaTOy4Wj/VWDzkZCM6j0diDaH+CEv9j1L2veNOJu1/gmfwJpOyLfi+55MZrQo2mJ8RQGzC8TpMZE1g7mogMH4bjpJaIhA7lyLRdk4GgBaCT+kyhk4q1MPk+KT8xpYGTUZTU+ExOwN/tdY4ncbCJCc+UPWLv5XEXYd0Bx+ATwsBDi8Y9wDFv5FuMUVhK1ejuXuRZBJ6MwgvWXxl4Mt3vgyIpLIdl0Z33NUlZITqb4gvWbjdJzWeJGyVuP1gJYg9rd7r+IGVN35st9UZV+V2cPimV0AWwj0qDk+BowPtgnomHqXwpX7HG20O8qmuDV6MRTYaji+nCm28Hdp0wPeLo5OoKCkC2jikz82cD1NXKw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(39860400002)(346002)(396003)(136003)(186006)(1800799003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(426003)(478600001)(81166007)(336012)(16526019)(7696005)(1076003)(26005)(82740400003)(110136005)(54906003)(356005)(6666004)(2616005)(36860700001)(70586007)(70206006)(83380400001)(47076005)(4326008)(5660300002)(8936002)(8676002)(40460700003)(2906002)(41300700001)(316002)(44832011)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:08:57.9884
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c2819fb-1a3f-418e-fe1c-08db97f77b0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8300

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a275a4bbf8d0..cbc36a81c9cc 100644
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
@@ -579,10 +570,7 @@ struct protection_domain {
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
index 77b87511e085..8434cbeff085 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2732,7 +2732,7 @@ static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 	struct iommu_cmd cmd;
 	int i, ret;
 
-	if (!(domain->flags & PD_IOMMUV2_MASK))
+	if (!(domain->pd_mode & PD_MODE_V2))
 		return -EINVAL;
 
 	build_inv_iommu_pasid(&cmd, domain->id, pasid, address, size);
-- 
2.31.1

