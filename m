Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2052.outbound.protection.outlook.com [40.107.95.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382F61B81D
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d3zmSaz1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOu1vhUK6VriaOHbfhkc9RTVQYU+q28ddJXJXAOOzkdXtoJL6rdra+JAbtxyTN5SOwpZHI44+mOGabC1U3A6uQEd5G0mrmkx0o1yDY7jfcUZ44JqniCQT4Tm5a76yCkgpqE4/Lr7MwD+8gNaMuTah96EGe7IIO+R0ykvTaNlZfij8Gr17SqKvDubwxzrNy88o1Q2rykgQFDAWAx66beWw9eO5n5JE9eICNYqejK9yoW9ZFSsvRx/fiRoxmbAdafMz3YSnbLrsaL1xfwxJjHoflsmfueMI8iE0iTKJFXXtQwUwr4RNHh2RW5LohvwM+MpT74RnJhDROLgS5gg5eqQeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta0MEkjlAMw5ON4Yxn1y4nXuJHRQBn7PNqY7NMZm9+U=;
 b=UJAiN6rf0J+G5Y+RuwH8SzDsd4IKr19M3ZwaUbu/o3eZIFjqOffpobRjT96FXtRahTNmN62fuaq5adIGj+QYebf7hJ7HwotXboloKundKxY1JcnwSX8BbbRVSVSz5mqbdRj7uNU3P1sdWWr1ItQlNsnzFIiWbytqOKuHgSFikg/fHYB4mSObKKlDKXK9L0aRhkvoKmT6PpU/wHoeVPM3WFzQRRNB/8Q8/RJPX2oBaWyOIt7XjOLCGL9UedZMAAy6fNuFz6BHYGPOOn8KC7LkEE5f2GkKwC1dpQlcPwX0y1PNwYoBC1CB/5ogHAEUktPtF38+ZsMOxsFaDxD8CwmY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta0MEkjlAMw5ON4Yxn1y4nXuJHRQBn7PNqY7NMZm9+U=;
 b=d3zmSaz14B8DTfqZV4sAEQFVuXQQpFRyxwbwYVIlKCm2k/POpiNdG1aDWllREphnBIO2NTKV8tL2jKqbh0Rq+mVqlVUCclE9sTK+FHZmcryd+cESmVqVGk0hAM6Xzn2kLzZAOghUTAI8RX5ZYL5BDsUgj18wsGTLs1+78Cg1ILY=
Received: from SJ0PR13CA0056.namprd13.prod.outlook.com (2603:10b6:a03:2c2::31)
 by PH7PR12MB9102.namprd12.prod.outlook.com (2603:10b6:510:2f8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.24; Tue, 16 Jan
 2024 16:55:01 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::81) by SJ0PR13CA0056.outlook.office365.com
 (2603:10b6:a03:2c2::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 16:55:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:55:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:54:58 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 04/17] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Tue, 16 Jan 2024 16:53:22 +0000
Message-ID: <20240116165335.6043-5-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|PH7PR12MB9102:EE_
X-MS-Office365-Filtering-Correlation-Id: d4fd3e97-f07e-4496-35c1-08dc16b3e13b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yWFZjK3ok0DT63qeQUMAGiCSCUvP5RS3IgV2QMUYNUkv6n98o4ZADPZi4a2p+rdgdf6ah7j3bFYS0WI+90wZj4zLFik/x7u/P/gqTeR/X9fFzwFqTBXzDYpBAMC9ClqgyKO83/+g4kqxjA8GHWcuHhlXx4VNZjvoF1yrHGiWXmBoR0d+LQQT95BBbzbtYIs9C8bxuN+r/ivUgFb3dkZZUCzc0ze/Jr/kUNJxl75FQPEga1lN7dau/e+kPZ/lC4FL1L31QpvYnr94d0LBkZs07JXjLbIMSNS3JIyaQwxHrYbNbXlcKrPEcGqQEf5HPSyb4vPhPYTpEl0IkSHOaEE1Bj+JQYwHvM+V2BzpdyEQCKazwGQLg8JV2k574kPfqPRZ+1ffvQbPemP1smMY/t9zJkR+ssyJyiyGQ70mR6mkzCthaBA+7w/GbRtgQ0SckBk2k/3LiwSgv1zEQN7ulgkroZ8whrdXyk8GwBEGFfe1GiiIlKFErkxxWxdvyEMmQ2A7VTk0zAlGQHWrBSgu1kx//WomzAvHzHkY4kWyKOZmRvMljYEltZSVniJuM4r4s2xsebhBM7VYtWVMTxySX8q89OBFyHgH+hj+tjSvJdrmKJx6wnD3bdQ+kVNInQ4eG6EIiEYxV9jmUv3iOqgLk7g2I1QIAEgYJkbg+1iN2yG+eZ2I12tbFwV7Is9bm9VO/+nAou7NlFfJwbFDAiIpYT0MXAXAzcZ3vsQf3TwjjC9r1LLNDcfYwOek/pL1yiO/3ExeQzmbPeuh7xXAeSApddvtTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(186009)(82310400011)(64100799003)(451199024)(1800799012)(36840700001)(46966006)(40470700004)(2906002)(5660300002)(2616005)(478600001)(336012)(70206006)(6666004)(1076003)(86362001)(7696005)(70586007)(44832011)(26005)(316002)(54906003)(8936002)(110136005)(36860700001)(426003)(8676002)(47076005)(82740400003)(81166007)(4326008)(16526019)(356005)(41300700001)(36756003)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:55:01.2072
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4fd3e97-f07e-4496-35c1-08dc16b3e13b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9102

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This enum variable is used to track the type of page table used by the
protection domain. It will replace the protection_domain.flags in
subsequent series.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
 drivers/iommu/amd/iommu.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 809d74faa1a5..934a63f64839 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -549,6 +549,11 @@ struct amd_io_pgtable {
 	u64			*pgd;		/* v2 pgtable pgd pointer */
 };
 
+enum protection_domain_mode {
+	PD_MODE_V1 = 1,
+	PD_MODE_V2,
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -564,6 +569,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
+	enum protection_domain_mode pd_mode; /* Track page table type */
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eefd399c5086..88a536dafa7a 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2073,6 +2073,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2081,6 +2082,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-- 
2.31.1

