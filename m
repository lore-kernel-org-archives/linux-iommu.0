Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554BC56B9B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ewvp/a/p"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6eU0MBvtYxXXuAgQgS7tv9l1ycGBIWYOoAl0C3svZ0T3dSAtMFPApjAlyJ1POGFUWlzbK71PnqPe0EEZsntnoa8SgdTox6Cv6VFRcJ4v+SiqUOJESE35V1RKJoh16JtabjsRKL8Isu3pyn5cAFgaU0f3lZF8Fm89cSP/VNM8lxweOtvIRMuFk0nYRkw+iLlZQSydG4GzLa0rWhvexLWNLfTl3avu8Tz2dGVfw0FjSOSapt7qKgqkncJuebN/5jJlt79I/K2I4LXO8HQrgvJA25NyRGnAQuQC/PGWvZCuIf2CIJfmm9gUlPRlX2C6XLq3bjHvVLwLE6YstO3AYqbzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HNWlTd4Yg6/BhyCFMCndC02guYUOrBeWXa6zDBSGhpg=;
 b=b2YP1rMsmbKWzVVwp86cPHqoUIIR+sYZDT6mJ0z6oJkDo5PxC+hiM/sEyCIPOLW2+L2rb94rNebcN0DmFALl0yvY5lVZR+9p9bcqkcko+Ikkysm6vGHFDFwwGDu9124X73kwtxTlGWP+ueD+lTz/ciTE4qTJ+s+HI8AikklTsHb9XaX7hT2xbkzcgYpkEgf9EjYUH2N4Wa+a4+qoXjMAITop9LQDIWAKYsjpebttIuPTb3GHeZPAtJAp7J90kI+LKkNZHCwVhp4yljhK7GacgtHQap3X0X0pTnfYVrJ8ydo+qQQF5+nb7ABqGEdHbIiqxchPZZtcDJ5i2vxZa9D1sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HNWlTd4Yg6/BhyCFMCndC02guYUOrBeWXa6zDBSGhpg=;
 b=ewvp/a/ppKB9Z29KqiPLd3vkvjOMjK5J3Wk9RnTUBbSzNR1yiecVZ3920M73cLcsuJCvYdEKiZTo28Zya1rsWI/g+22CGDWd9TsXnzvxIBrmEbnKc6l4yt1v41DlzpgB5UsYOBaa0b2C8kjAVNgPbkhrJLBcNsJm815lAEDpGFE=
Received: from DM6PR03CA0091.namprd03.prod.outlook.com (2603:10b6:5:333::24)
 by SA1PR12MB7102.namprd12.prod.outlook.com (2603:10b6:806:29f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Tue, 12 Dec
 2023 08:59:07 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com (2603:10b6:5:333::4)
 by DM6PR03CA0091.outlook.office365.com (2603:10b6:5:333::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7068.33 via Frontend Transport; Tue, 12 Dec 2023 08:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Tue, 12 Dec 2023 08:59:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:59:03 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 16/16] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Tue, 12 Dec 2023 08:52:24 +0000
Message-ID: <20231212085224.6985-17-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fdee97b-8dd0-4935-ee82-08dbfaf098ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7YFFQwkyiP94BCGhKujPHK4tolH3DY/1zX7S1dMWNon7rj2+rwR90IeQhVJP4RlKcq1PjaHHmIfr/XjgJWYm8N17m2ywRStB+tdS3QDASlYNg3ckmTZjfcvFvkyLgWZdVDn4YL1cpfceKPpVVMqPZL0dfiscnpdXlQPtAXxpraAbEIlsr/crudtwCDWVhfym/argLO5G0ivb4H1GcuHYMgD2whH5eM4Sl0mSTLc7zZRiftqDijDBf+EpqGf5l9bjWhYSXqyo/lOCP9U1VwvyiOsLUsPvuj4+5xluMxwrvTRcdPjRZEZJx2BQHHBJZJ5dkSvWg1xxRR8XMvpGKFdQQ6pUGk2bm7ajdxdisEqg/o7kE+SzH1fAWbzo+3vPGNY3mKtQDkUZQ8O4jsp7qvsCIFEN3C39/eKDbkHZRh2kCka3jOo5mIIxDxZGPc+v3IWaGmDF7OVWVzQ5Kv0HYOWwOu/ar1OdrUeqZcoa5YG9leuS7ufDu7dQCHnC9YJMvOsPmxz/YvppBfPncCg20KaiRuQpSnTqEEy+6AQ5sS03r81HmoG3doPGLGGM6dIIxK1jHiF0fzh3gVnTbd62efML8iJ0t0jDhoPHmlsW7Rtl6VvjpoelacQDFRGnkaS0shGtfKbHR87hvqqDyEabIX6rA0nFT6Kjke4aSgCs4MDd5U6wK1xIxivcdG/P+LUHYZ2pJ2Smy3BtHhIIm3C7GpoDgAYiP+rNYn+BKhqx+wYEsBg1f8h33DewpE9F2SsYrR6NTPgxAEtOtqg4aLfi+ULn/Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(36840700001)(40470700004)(46966006)(40460700003)(336012)(2616005)(1076003)(426003)(26005)(16526019)(7696005)(6666004)(36860700001)(5660300002)(44832011)(4326008)(2906002)(41300700001)(478600001)(8676002)(8936002)(70586007)(70206006)(110136005)(316002)(83380400001)(54906003)(47076005)(82740400003)(81166007)(356005)(86362001)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:59:06.6853
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fdee97b-8dd0-4935-ee82-08dbfaf098ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

Since they are moved to struct iommu_dev_data, and the driver has been
ported to use them.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 12 ------------
 drivers/iommu/amd/iommu.c           |  2 +-
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 51daf5dd4729..3dc39bbc05fc 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -453,15 +453,6 @@
 
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
@@ -571,10 +562,7 @@ struct protection_domain {
 	struct amd_io_pgtable iop;
 	spinlock_t lock;	/* mostly used to lock the page table*/
 	u16 id;			/* the domain id written to the device table */
-	int glx;		/* Number of levels for GCR3 table */
 	int nid;		/* Node ID */
-	u64 *gcr3_tbl;		/* Guest CR3 table */
-	unsigned long flags;	/* flags to find out type of domain */
 	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f2a748904eed..4e4ff1550cf3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -90,7 +90,7 @@ static void set_dte_entry(struct amd_iommu *iommu,
 
 static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
 {
-	return (pdom && (pdom->flags & PD_IOMMUV2_MASK));
+	return (pdom && (pdom->pd_mode == PD_MODE_V2));
 }
 
 /*
-- 
2.31.1

