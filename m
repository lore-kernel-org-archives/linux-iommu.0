Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2079.outbound.protection.outlook.com [40.107.220.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2225B1CFA9
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424309; cv=fail; b=DZrNrFVhaZYrHkQx6zQjvMKpgLbAVKjPKmLY9acBym3Cj+U/K/IOalEqZxhyrRxmumEgJTtW9fqs7cYwgKz2/GMdTLYA75pANzKgXj8FUSSwwQSV+F63ojapqj9UGL77RA8S/KdHrSZOqMd1KapVUdLqTBUjFVfLaNyBD/6IoVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424309; c=relaxed/simple;
	bh=PPUzyNx9BkxAT5pJsJCeTfFlp2AO2j+5QLqGALBXXCU=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=LHDszDSC5yCY0RvFIdciPak0SeGPKfL2cVHZwUxPZM5gACgirsus4O0xdH+I90g3HN9WjElDuyQ+icFYf83tKZX+Agd1+QKVYZ9675LT3CDk0lmYJgfUjqUEfztkizM/WoGl1DAVwIyCjLQ2R+YPzhViBy+p1hwnm9pUQqKfPLw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sddmIu9z
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sddmIu9z"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cypwDb+QwcGBBaAyyaUFjOe2S/mi24Orx5P3Kc8yqKj4j3MtIoAXBs+3TIppuCYQO4wzJ9LCvrgo0NvocCw0bTBf4A6zrl3UDbEQKPZX9hbzwlYci091KqYySflhcBwrw/4KlIrtCvxzQrHfOHTiYofu1Lpk/uVcHo7f+xHzKEj8lafVhMgoiEWCBCYTni19xH2UAvQPrmVyr323E+EYeuNXs7A22KEMULwS9J7AZelq/wi/TWK5WYDQmmG2IIvsEN3Yt9NNJrkJ9h7qou8YzXIp/opLLEOe/J5b36F8uIWNSv9M8so1Lg+Uh8xrbMIC7pFEzNTE1DXuufefC4bgnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2N7UhCisicRsVQYgUbhWj4sbGtPnjnIDwurfmBuNDDU=;
 b=ktpoVAaiN5BOLOhDnrNsMriAvt7qy+Iuze2S3jtYbO4n3buDaub434pEosJvmUzlJ2r4dfGV8addY7qh73HhXJxPZ7tiWOnFQDyK9LtuSiBm8XuC5SyJxj77mjWXywIcAgCI8NIg5OQnEibUiueERVcQKNg4V/MYRshHyBVwjo3RpPoA/e85x50lq1lVpYgSW4pxGtMug8EIawEvvAJ3S4cP/TMF+h5GkIrbF6cRa9zBW+2XBZfl4BxkVq6pkv6Mw4+nL6sIpEhsS+Ty4GiR6SWYl+kvyknwrzHm69w0oq5FQB6f7SJdyLVDa8DeefZ0fZP49snL9ATzacdur6leUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2N7UhCisicRsVQYgUbhWj4sbGtPnjnIDwurfmBuNDDU=;
 b=sddmIu9zs0iuYiu4St0M08NwjQExbeeqSJyBLlWA1eehWUrW6sm0h26uEtWVbZLNVoh/4duC5bkaEr0ygO+suK4ROE83UYXHQQ93SFmrPvmng6+1JjnU09u0lR1RwpvVBeg8gSWX7Gbg9uenQXarCgcdKTRkUCXXgFbkXvWtjGA=
Received: from MN2PR04CA0028.namprd04.prod.outlook.com (2603:10b6:208:d4::41)
 by SN7PR12MB6713.namprd12.prod.outlook.com (2603:10b6:806:273::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.23; Tue, 16 Jan
 2024 16:58:26 +0000
Received: from BL02EPF0001A0F9.namprd03.prod.outlook.com
 (2603:10b6:208:d4:cafe::e4) by MN2PR04CA0028.outlook.office365.com
 (2603:10b6:208:d4::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.23 via Frontend
 Transport; Tue, 16 Jan 2024 16:58:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0F9.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:58:25 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:58:22 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 17/17] iommu/amd: Remove unused GCR3 table parameters from struct protection_domain
Date: Tue, 16 Jan 2024 16:53:35 +0000
Message-ID: <20240116165335.6043-18-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240116165335.6043-1-vasant.hegde@amd.com>
References: <20240116165335.6043-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0F9:EE_|SN7PR12MB6713:EE_
X-MS-Office365-Filtering-Correlation-Id: 985f6815-43d1-400d-4d7e-08dc16b45af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	u7jHbyoYCmwSQBpH+TZpOyc/Y1ZPLLJtTjMM/O1jtJmeGf7L7F9lIvInfh1CoN0SERG2dPX8L41qr9WCBsMRrY9mIUI1T4QCnIk+xoGoJ1rFuGGz2aBjSM4RA+3B9inYVO36tm01wIyQRwCLnls37tiT/8ViBVkeHvNEMlAf20AaOFrDNbtu86e+nyMwH5UZzjl8quVPvwd1lhG5+bNvtbLcvuXjgnBMVILaxkbJJtWuweU///gZPTXQIClxvyut9f2gvAyaXz8Ow7WbwUlhTdXaWnd+HbcFo477mXCDbZlxWml6qL9R0S7AgxU8u1mlhI5bcvHqbBbNyk49QTZCe3euWbAGehsTjmW8dQU25S/mtcwHbcWUq1iwXmsIJ/kH2Fx4iDjfPpwQ+VdMVDyoAd912L28w4XvDVAROhD/QRdVPOQ9SnSdm3GkHm4OpBUNjyBTjQRQpsycUxP72COJnE3X0jCn/XdykgBVTdRwrzgC6K857MVHY/EXVJQ+XaJ+9WwAT07Fx9bCOwR/a35bPMSXTLjMXU8fhPRwhglHiqe2aWsx4BP2fN/3Fa45ybiomC09F4Sd/Z20EwhXduy/Bxhhgq7sXNqPGVoxwqSwVhVqTLVLHzXKY27BEI+9rd8B8JXvYJrEYtUBbPHrkba1EYQmITboRm+/5W7sTgwJ67lXCnoGI98mCFqCGCz4vPZGCuJFFqndvv6uNi8M4CurdhVT97veqkQozFmFCBUN8G8rzXd/gZkwNIz3o63TAj2uxNVsMktS6Ay8qU8wQoIsfA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(346002)(136003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(40470700004)(36840700001)(83380400001)(5660300002)(82740400003)(16526019)(1076003)(426003)(336012)(478600001)(26005)(2616005)(47076005)(8936002)(36860700001)(8676002)(44832011)(4326008)(2906002)(110136005)(7696005)(54906003)(316002)(6666004)(41300700001)(81166007)(36756003)(70206006)(86362001)(70586007)(40480700001)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:58:25.5511
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 985f6815-43d1-400d-4d7e-08dc16b45af9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0F9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6713

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
index 9e23710fd3ec..d5786c33aee6 100644
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
@@ -572,10 +563,7 @@ struct protection_domain {
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
index 6e7436787c45..256b5507272f 100644
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

