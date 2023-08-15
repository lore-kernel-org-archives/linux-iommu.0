Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DECA81078A
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 10:23:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA1fP72j99+bQE4zmxmsTX5yEPr6T3fuS7oUEHbbxM/SEwh2cx8vVIvbSdMz3DYE1Oy6dZt238n1lGpW7Vt6oo1/3b4EF+LpfGb/4nOoT02pFYoaWVO1toYFhF9csRY4ajaTFLXpB92U9RXdpGI2CYW22iTB2m9j//nIH1vgMC1yFe/a0X6FzM+8w1/Eg1Q2NFc4/1pMH/njNemzN/s4io8mK/OwD2zfTQIvxitO4R8770+QA3Dunmr8ZACfahMq3tQLNQDpJpR0MHDfy+Xex0XDBmFeZbnPBvTDlkqxf7lXUh/cW2xTdu0DSwO4kzTKrqGRGRTQU9/nqciYCNbWxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVBxxA8GAjvlgSVSpzoSYwRUv/eiXvXO9XI6s2vEeKA=;
 b=Qggr5Jf9/1fJL2dSbADT5nBk8mEkZYjIlUYqnKoOHMK4V6/iWp+cbDoh1Revxtom+UxCqodlxk9KQoxxDWFJiSZwdSmTc4oBcR32sB6GpWiFytQqoVt4BtJ6x4F3rHgKKN+YU5z48ryBUwlW+7b4jzL+YcxnmTAhbLinqkJmmeO5NVX8OKPsjE7HsnyFztMpeQB02mjArnDbZQ0YAG2PXm9er0ww76UZZC/AJTwj3CVKtd4vDJdX+9O6RRWyoNDKNlLmsclOoqkGus8VPKpq+GtrmoySo2AII7k97LE/uy2nnx7F3kvZZnK7Mz01R37Lsjrg5HejUWrJEPr623s5Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVBxxA8GAjvlgSVSpzoSYwRUv/eiXvXO9XI6s2vEeKA=;
 b=1E5xjsHFsCrMZrJ7633b0ayRxOPG1vsoXZ6weT/XbX1QKhImnbPIlkWh3KYeEMSz8dOigiE/LuVLUqTR8IWzNdnTpQHFpFbffS1k0YDImHekut+AXKkT7AKPMowfO3PsOkJySgzYrvv7ojuKr36qcz8fcLjq+luT3DOv5T4XaMg=
Received: from MW4PR02CA0001.namprd02.prod.outlook.com (2603:10b6:303:16d::21)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 10:23:06 +0000
Received: from CO1PEPF000044FC.namprd21.prod.outlook.com
 (2603:10b6:303:16d:cafe::6a) by MW4PR02CA0001.outlook.office365.com
 (2603:10b6:303:16d::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Tue, 15 Aug 2023 10:23:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044FC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.3 via Frontend Transport; Tue, 15 Aug 2023 10:23:06 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 05:22:32 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v4 01/14] iommu/amd: Remove unused amd_io_pgtable.pt_root variable
Date: Tue, 15 Aug 2023 10:21:49 +0000
Message-ID: <20230815102202.565012-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230815102202.565012-1-vasant.hegde@amd.com>
References: <20230815102202.565012-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FC:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: e03fa8ca-aa52-417d-07ed-08db9d799d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0yJ8IVgYu0BIuTnIqHrCu1v3U0ldWHj1SVDnW2iDsogXcc0G0CbEGaru+PpDaI+w0mSz2Lk1vMVpgsp71XvzAaqZfWbERC/WetFqXnM1UGuZFto3ROYsD4X9e35Z6vQE9dd/foC1bB7OMiC3uYOpEqIWFBqghFl7QKpqZ2jP4pnDtj8czqP6VNVv/eZnR+Tq079tm+QHrBbE7nURHtrKTjC3I1ICtvZ3EFkEGNVDHKd6wttrjSw5MAQtfIx3QGUTuFKFUAlMteHMBADTTz23Sb8OzO7RP7KNDQEH0QOm3O7PFiDgjEmOwg771rF0SLDoLceZHD2OWK0ZZIsBnv1xGcbtrFtklaomap643t6sBh+Sh3abf8SePtiR1zshAt1ug9CW9T1YvNtM94Hf2TvphYsQ2Rfl6zS0wjxrILF5V6WiSocwv2ViIFm7PULsWjqbH9Lc1tfeZqc6dT3qni1kPrUGCsRTNWxG+VKzVs+jc8nnSMFE/NEYuoBOR9jex5y8a+V8O6YGd7y7ZVhAs9oDJmT7D+DJ20BlGaZO0Lw7aXwZBK52Ly5Pgqi0tKxvqhjHJYpZkQ3GVSPiOSR8Bu+NqIcHgZ1npf137tnEP5J4RvCPoTR7jmGFbVX/wmu15wXetu+s2qnHVOdTU8UDwnEdcYVtXm+Ku7bJ3fe2EQgfWU9m+NolRdsCwn/AWL6eeqT4H7ayJfizrDkOU3F/oi3vwu/sjR+K52PPN1szt+rfBn+qVlRruVf+V+3QlmHcaB12A4HHvRNiUQKK8F5eQdHC8w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(376002)(346002)(39860400002)(186006)(82310400008)(451199021)(1800799006)(46966006)(40470700004)(36840700001)(6666004)(7696005)(86362001)(40460700003)(2616005)(478600001)(81166007)(82740400003)(83380400001)(26005)(1076003)(336012)(40480700001)(426003)(36756003)(16526019)(70586007)(4326008)(70206006)(2906002)(316002)(47076005)(36860700001)(41300700001)(8676002)(8936002)(44832011)(5660300002)(356005)(54906003)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 10:23:06.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e03fa8ca-aa52-417d-07ed-08db9d799d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FC.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

It has been no longer used since the commit 6eedb59c18a3 ("iommu/amd:
Remove amd_iommu_domain_get_pgtable").

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h       | 1 -
 drivers/iommu/amd/amd_iommu_types.h | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f23ad6043f04..6bf55de9fbeb 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -108,7 +108,6 @@ static inline void *iommu_phys_to_virt(unsigned long paddr)
 static inline
 void amd_iommu_domain_set_pt_root(struct protection_domain *domain, u64 root)
 {
-	atomic64_set(&domain->iop.pt_root, root);
 	domain->iop.root = (u64 *)(root & PAGE_MASK);
 	domain->iop.mode = root & 7; /* lowest 3 bits encode pgtable mode */
 }
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7dc30c2b56b3..081d8d0f29d5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -544,7 +544,6 @@ struct amd_io_pgtable {
 	struct io_pgtable	iop;
 	int			mode;
 	u64			*root;
-	atomic64_t		pt_root;	/* pgtable root and pgtable mode */
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
-- 
2.31.1

