Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA9E174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:41:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N+mFaZ6iLSbslZKRF/cDbBfJWOYCL2wCkfz/+kg5OyFIL69/SdRoyY5KXpTS9od3ARHdAb0MIrbXRTWkBzso/MlPPnwoIopz4LU0gEMJ2fOgFvTgmebBzk8KZXKMZYb5UcyrTc1G7v6f8cqxZEmsGBk8TA32+slb7clZstlm5jQAHzB0SS/y+UkRMEPCpcLR/AYcLOxljQeCpKe119XXVPeTa8b0unz+bN89r+g5TBzJNuaiA63o6WLS4pmehTYUfCIfNKe07WfuXoYrBISrh985nj5yAIj8SBGIP5PyjYxh1ECauv3iOmxHAGwwDt3DD4yQ2NaDK9V41pc3SPmKZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AO76hqXtJ5Zvg/0wCbyeXZVEt1RqfLaQxhje17gbp9A=;
 b=nD5+xbe05FF8VVgwTnWyqqzJKRIa3MgpK/DhzqivX1R9/MjcgVZ36sOcjheO5XV/bhgUq0rKuoDN3aVyBf3yMbobGU5Agflj8oII7NY4foyREu3OpHperiwz4xx7PnO6uV04OQTBvkf8KoxDoraId6rVMawkBI69RiQSpQbAQsRiLS0HFStS1A/b/xhqZjvRxYlSIx70y6OYR8pjDC3Zdwrl2ycFNgknJwEwn4BpabXXsrYnar0CS2jM8I8ly0pvTl3obCBpk9ggZtpZZHqp7NW+tr/QD/jm+iuo83epoZPUgzKCDIa3zMy/T0b8YkXtOxglAwMkjE98m+sgs8wZxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AO76hqXtJ5Zvg/0wCbyeXZVEt1RqfLaQxhje17gbp9A=;
 b=GHv5+jnOMHVJZ+foZUBlj9DHid/TWryaQ8sc/ScWLrbrifIDesLcR8/vQURMFWUPknRr2Qrxvmv+RDb2/tH9oGD435gXPmEN8Co246OWmBr+hCSc5U6bgHxOZFRW8dG35OX8d8cRnWdMZ8J2QO9CDTnAHJIOIdr4BufeNSmlK2g=
Received: from SN4PR0501CA0115.namprd05.prod.outlook.com
 (2603:10b6:803:42::32) by PH8PR12MB7374.namprd12.prod.outlook.com
 (2603:10b6:510:216::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:41:41 +0000
Received: from SA2PEPF0000150B.namprd04.prod.outlook.com
 (2603:10b6:803:42:cafe::54) by SN4PR0501CA0115.outlook.office365.com
 (2603:10b6:803:42::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.14 via Frontend
 Transport; Wed, 16 Aug 2023 17:41:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF0000150B.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:41:41 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:41:38 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 03/10] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Wed, 16 Aug 2023 17:40:24 +0000
Message-ID: <20230816174031.634453-4-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF0000150B:EE_|PH8PR12MB7374:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e6f2aa0-4dc5-4b00-b289-08db9e800ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HAXUhoF1nkrOIgY6iCds6zkeExMhac7ukWLtHe90NvOGm53DPS+y/xDhMBUw561Rkc7cAOf8M/9r5Nuh63mFnCG8264Etykm7LOkfs9gM0TpK8tIpB7rQn2kJVFbWNPTajaRr3DNY2eSB8XwPacZ3wGKQhdpuci3X+4V3SpusGLKxUm938j57D21q4XgqQJAVwIQXeR6HFl0eKMjwMWYDObeA0g2J8GTMTywyK/LZZ+S2w6/2O4vULiaM/cgA9QNFAzqrc2/E1aysuSALVrQvbJRe3qQ9FRpHluQme75A7aW/AzUo6uUq2loGDd9OSILB6BsxQS7mQaqhjuaVSIkhOu0graVYKbwSlHOYzNUsq7WVd2fXsKpZO4VjrfJuUTGesMGv3OLDnKe+5f3NTAZsCZwI3bGlUubu4S0oe1B6I9ghMBt73BcqERP+O8akw8W8LqRYV3c9N71nc2iEAJSF/9DEV4RCu+fmpKfQesjgTPCrFBWbRxDGJj82aEmnGvhIamXzWmRrkHPf2uIxFq+xJuNStXi/oIFhMHzcBjTWlCSB3X/zb5LCbw9XUYBWzos4llWSbtZpdVcfcoBtYLERQf8pdr5NvxKoMT0+miec0Y2AXcjVEClxnF0/oPnHPKgX5P2GskNrRoEJY7S7Q8giwuOyK+14vAfym0ZlgHdal+Pj3euVAawMOoGgKVPOYu+5MG/iau9hDgnvUiin+TG50dhNVkp9lYA2+XGUm+R3NMQD7AyfpQKWgUx2w1tDerlpjjEMz52vwkC4Y4sGdK4PQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:41:41.2338
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e6f2aa0-4dc5-4b00-b289-08db9e800ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF0000150B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7374

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This enum variable is used to track the type of page table used by the
protection domain. It will replace the protection_domain.flags in
subsequent series.

Suggested-by: Jason Gunthorpe <jgg@ziepe.ca>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 6 ++++++
 drivers/iommu/amd/iommu.c           | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e742006f2885..eb32df5371c4 100644
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
index 002b29048813..bfacad9ddc14 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2102,6 +2102,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 			return -ENOMEM;
 	}
 
+	domain->pd_mode = PD_MODE_V1;
 	amd_iommu_domain_set_pgtable(domain, pt_root, mode);
 
 	return 0;
@@ -2110,6 +2111,7 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 static int protection_domain_init_v2(struct protection_domain *domain)
 {
 	domain->flags |= PD_GIOV_MASK;
+	domain->pd_mode = PD_MODE_V2;
 
 	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
-- 
2.31.1

