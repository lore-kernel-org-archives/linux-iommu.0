Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E71211CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kgUdIfdP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NDU1Qb62dkAP7fMoQNnoepvY9vPovfnZY2xZrvikqvv3FJWv4LnOqjauV7lExi6hF4LsCPIHAvCoZNPg0/zGVjeSaJwGE1QgdDa8GTnwIo8nw0cFB88ZOBkon41SrSLqAkswesJ/n1Sk1+8VLy0NGBGk/VHCON+eIr/8UDbLWtbQ71W3vRuIK1ZT/531CL78eeUFfSs3VFQw92DLz2D6qwNr7FHE192TY3DSh62zn3+GgznhzKpY6O+OtFIgpKTsrTjYj5aejgryCB+hRRye9zYrXjWhEHQFKbQTQ6+i3R7on6ahLgff7r+6UiuieXnusdgNVIca5FDXVZzU5ASfvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kVjwxcataPHLJHqvTBRzZAwAoM0YSdqFb+82VFvcDpQ=;
 b=VqBr9WqeEPodSlZ7kW5YiqtZqyztQ4g5DmTFtUUEroBnmoootwUaOgRliZvMyLLlYwGpLImMwfK1J81L5kjaBSkHI7tp4bErRtuXetbczgcFZnf+BB7SuXpeIH6rrnRCv2+Bdo8e2nadE9eTOxERXzTkdAyojeUtXYONzvfFuO3eSXiAwdrzxTGZmF1u7JGenK7Xk2i6ky/rPb89STJ8geeCb7rvmiT7Jq4o4mGQzIzHPfRvd1wzzGjg8vigoF4DJiMXlFklTtNUqNy+soQUwCONS6aNrUOStR2AhJOrBDCGhenLcBbZWGNiOWdG3l9REau3rl6jO6ezuf1Xog2A7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kVjwxcataPHLJHqvTBRzZAwAoM0YSdqFb+82VFvcDpQ=;
 b=kgUdIfdP/MmPDnlTjuvAuAGT5MWW6nPSEF7wAtYfx+gWwcK2+BG1sVU9912S6rN28S3Vr3nsgOLqulNV58z9kOA/W4dcOIsHJzP9LUjSctXtUb3GKVClxvrBJ03JEppJsTiDwuyHsQoE4bVVdV97JzDIaXdPMPlsaVxyiMB06QA=
Received: from BL0PR01CA0018.prod.exchangelabs.com (2603:10b6:208:71::31) by
 DS0PR12MB8365.namprd12.prod.outlook.com (2603:10b6:8:f8::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.45; Fri, 13 Oct 2023 15:18:29 +0000
Received: from BL02EPF0001A0FA.namprd03.prod.outlook.com
 (2603:10b6:208:71:cafe::2e) by BL0PR01CA0018.outlook.office365.com
 (2603:10b6:208:71::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.46 via Frontend
 Transport; Fri, 13 Oct 2023 15:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FA.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:18:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:18:25 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 03/13] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Fri, 13 Oct 2023 15:16:42 +0000
Message-ID: <20231013151652.6008-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FA:EE_|DS0PR12MB8365:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d7b22e-7943-460f-7aeb-08dbcbffa7cb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HwljjI6l1I+3RcVnCvFeUuYpicUTlhA+xCV3S4NQPlfEBGAZZDfYAg1JH6+nVTU09bUyreZMIsO9DLRnWnnvAgYT7NQ94CsaYq5el5JDenObQAqeoH4BBQmsL1WmWo2UwNyaST+v5OlpdxpfCOkbIadxuAqN/72KB3zVzePYazsJcse761quBl7bcbK/wQQCcvoBx3SaKi7pMHyUG5YpAy8s3Ze68tjp+SOM+bK1X3dgcJ3j90I5GezYgdhk9am39VJ3q2bzVwpk/03OTdhgBo0HCmJmSunJVRQhWC3dXBKGzCwHA/HTzWIiUfYagJ3pKolCW+5uPoovyH1WIoP976ACWTnnPvab+RdeqqxAxnNpI3cG/8CKx1oNj7GmHQmhGr11+5ysjhHGwpLM+6Uv9LEBG79G0uM5JegUvhbu57ztWJppFgwfmXq/30gRJ6Flk1DE5TBo3JtGM+TGqTwXEGlqrekZTzNmnWly6hNHfNK2REV2SI3ByaEMmZ0rr2c9UjqzR73AF9Y8hke0ssEJd48C6SkPLu4MaYpAnE8o21UjAthktDoIWrEsVie+YY2YrMYRWygnho4jn70VyrEZf3MsWnYc2AV5ExtTtXwzUOYnqg5OKkjCh6xEdyrcojBLeD2/TPs8GTWhk7+xvpa4Tn+zGHtr6lx3l8sI0TGSqX0pTfRBVZkeixUPWsYjiHN0iEV3v1HFE2jRX3TI9li5OLrZrRtVl4mfdhact35QKrJmWhAIvVKOl7ER5oJdAYYnJhzzRGA+leIbL+Jj5bUoog==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(39860400002)(376002)(136003)(346002)(230922051799003)(64100799003)(186009)(82310400011)(1800799009)(451199024)(40470700004)(46966006)(36840700001)(40460700003)(1076003)(2616005)(26005)(478600001)(6666004)(7696005)(16526019)(336012)(426003)(47076005)(2906002)(44832011)(8676002)(70206006)(110136005)(70586007)(5660300002)(41300700001)(4326008)(8936002)(316002)(54906003)(356005)(81166007)(82740400003)(36860700001)(36756003)(86362001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:18:29.4817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d7b22e-7943-460f-7aeb-08dbcbffa7cb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8365

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
index ba40e5066300..5785bd51540f 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -538,6 +538,11 @@ struct amd_io_pgtable {
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
@@ -553,6 +558,7 @@ struct protection_domain {
 	int nid;		/* Node ID */
 	u64 *gcr3_tbl;		/* Guest CR3 table */
 	unsigned long flags;	/* flags to find out type of domain */
+	enum protection_domain_mode pd_mode; /* Track page table type */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
 };
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index eedfa341085c..ff52beb83b74 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2148,6 +2148,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2156,6 +2157,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-- 
2.31.1

