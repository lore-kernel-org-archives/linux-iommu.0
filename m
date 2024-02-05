Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 454BA1AAD2
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134545; cv=fail; b=pabINQiwbQeMdLtD1fy2D5N36l4lm44tfJMPUDbO9okKAIeGJxgBMpzfCL15E9McBXS5uQhUkzxjZ56U2oWBCUe3x5ka+WeFOkV5kv0QmMvUX/FQUFhCnIu9n9lEw6xK6NjOZqiLJTFUlxj8BXhaw6BwIBF5F949s8sINwRHWbk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134545; c=relaxed/simple;
	bh=88SYU0OQw/78nyLMAxHWoljoQ2UDkFH7+33XkahRQH0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK/QvO7lBI683zQGESwXdFRr+GEdLEvVzkcivQ0b8BTryxqM0OACYjyZp3kgO2+O4c8HeFA+/0HGK+879UREsCq7fabifFNBI7mGhO9U24DNVlTiOjRzPqi+OxpiDQBYnJy8JwOraBJg20w0NhhWixBotkpUjwHXEl6JIDWIhD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZWIkPd4F; arc=fail smtp.client-ip=40.107.237.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZWIkPd4F"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fzVwqCJVI993cxDu08bjz3hc4jW902zFVfJFD7vmlS60bAuuLB3vgBRdrrOwjOPd/LmR50/3YDjMdvpIEvtWnYJo2M2771Xy5UADB4W4f8NMqWkHioYNDPtExoKYrX3Ts2GtZqUAT1NDgddxd9LSSTfpbhr+iA518S/mTh28NBuuntwf1MIOJN4PGNRA1a0E93ZjhqA2qboWBPSyT4J0i/RbCSEEB7XqaAalp92UQxp+W+ut/VsfWy+uOLwfLoyeMpNC4zmbkrGcT+/JwAdsB/9PkvN4ICdREby7wUDmU8+ViX8MJviQEZwvJbe56Uke3y7aKdWb1m+d3osI4QvOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Cn1c17/1YMpw1y0g7SLNQ3kEs6Fv4iKoWdEgXtbonJE=;
 b=fxwkLtZNa6LuReoOqyI6MPaViSPYioprGK9d0NNcea9r0q5Qy2rSGoTR6tbe8XDZ8EqFjaDHfwVziI3QXt18PJZHAYHoxyklr6s3cO/ngeaFZf0gywwmEiIVUVTtfVPxC2wkVndsVqRqs/RhwyIAFvOXZMk7G2DDh4P6/ZEzIMsq0XVoYZUqf/t2AgQKX2zzNjEXye/kg6GOrHxM4zNODesUkR8bqCjR6DTgrkUI0HPczcXdxaZgXrN1UxuPOYFU0/ifdcmxgwxZHjlKO2enYZiyQXN9NASQ+brJEAT31VZ4N4V4yJjkgQU1JgxSp400OZ9jJoscLhZKYxW6Qg27hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Cn1c17/1YMpw1y0g7SLNQ3kEs6Fv4iKoWdEgXtbonJE=;
 b=ZWIkPd4F0E5y+KmKxw1r2Sr6KZTWM2AxHzXnAciXfL82oKWUn2GNfGEyzBcr0SEeuPTXKsV0O7oQzKZnMb/Jp5RGXJ6wWVGLSqeDIc3CbV8crSJzUJE2rtgbiCAylb6FglEJQ4nF9W1Hv5/qJp/14N3bgiXIuFcb/8ehwTUe1ho=
Received: from BN0PR07CA0004.namprd07.prod.outlook.com (2603:10b6:408:141::22)
 by MN2PR12MB4341.namprd12.prod.outlook.com (2603:10b6:208:262::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 12:02:19 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:141:cafe::82) by BN0PR07CA0004.outlook.office365.com
 (2603:10b6:408:141::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 12:02:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:02:19 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:02:13 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 12/17] iommu/amd: Refactor protection_domain helper functions
Date: Mon, 5 Feb 2024 11:56:10 +0000
Message-ID: <20240205115615.6053-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240205115615.6053-1-vasant.hegde@amd.com>
References: <20240205115615.6053-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|MN2PR12MB4341:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfeb6bf-c278-435f-63dd-08dc26424dc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aWvgYWGbaNU8l9ihFvQ4HX1WHVprtwNqlJO4/d3Bo1IpMMnkgcPzeP518shfmZLwiYNCu8KmSK7OlATiJpPotIsr4F2g4U8r5jyybbfqfaSomt4hXvdvrBZUuQ9Os4/ezr2nWNbzE7Xo4P+AYCAfMI2YQoeDnz8+o4qOb787wWh65qx5YroRnmLin+CwJzxGxnrowh6s52R15GKBsDcOu+63DplVHXaNp8CDBZq+WFNTP05XyiTZqt9XPvx7BBR8WgTvkonlkvM8ARAyMKA5NOMULwPwmOqId4zR032Pm1N+/ofTFmR0/xx2Zi1bWdoi68mHb6SLYXW9Bt5GkMpSCn8fpJxL+tCLfKG+DQq7s3MYuEKDOrPe9uMIWDUKqxWNb5MyfKD8747fIwAFoUaleruxL4RjykZn8Jx6LBWiuSHAho09wcBjt0CXsSdce6+XRfSWCg4w01jX2cs+TK45qGPObmZElMc1lHc7aZZj8tXVNF+aKfrvx8OsIe4E1yIFPu6GMPd7HziybNN8JrqT+vY3DK0av6pEtHa5tRKqxsWlUBgJF+Xobov1AxqUMeGoSLBQ57UFzw0ypNVhljo6HHdAraifslg81ggluE79d/iSYKcmSBSW7Kb/xBykRfnOzOO5I2CdRgnueRxsXSavWHCrE/fWHN/6DzV1pKWhYHD9w48RzX2ZLTWL+seadH4tjuaCh1W4sMU2FpN+PJQPD+ytGo1qEovbHm0BfiT8fRf5DJwR8VzC7khd7PbMX7E+0P0ZcPR6Kvi8WPrAV8Z+Gw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(36840700001)(40470700004)(41300700001)(40460700003)(40480700001)(478600001)(36756003)(86362001)(426003)(81166007)(316002)(356005)(82740400003)(336012)(1076003)(47076005)(54906003)(16526019)(26005)(2616005)(83380400001)(70206006)(8676002)(5660300002)(44832011)(110136005)(36860700001)(8936002)(70586007)(4326008)(7696005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:02:19.3621
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfeb6bf-c278-435f-63dd-08dc26424dc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4341

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To removes the code to setup GCR3 table, and only handle domain
create / destroy, since GCR3 is no longer part of a domain.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index adeacf5a968c..f56f09d83bea 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2181,9 +2181,6 @@ static void protection_domain_free(struct protection_domain *domain)
 	if (domain->iop.pgtbl_cfg.tlb)
 		free_io_pgtable_ops(&domain->iop.iop.ops);
 
-	if (domain->flags & PD_IOMMUV2_MASK)
-		free_gcr3_table(domain);
-
 	if (domain->iop.root)
 		free_page((unsigned long)domain->iop.root);
 
@@ -2211,15 +2208,10 @@ static int protection_domain_init_v1(struct protection_domain *domain, int mode)
 	return 0;
 }
 
-static int protection_domain_init_v2(struct protection_domain *domain)
+static int protection_domain_init_v2(struct protection_domain *pdom)
 {
-	domain->flags |= PD_GIOV_MASK;
-	domain->pd_mode = PD_MODE_V2;
-
-	domain->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
-
-	if (setup_gcr3_table(domain, 1))
-		return -ENOMEM;
+	pdom->pd_mode = PD_MODE_V2;
+	pdom->domain.pgsize_bitmap = AMD_IOMMU_PGSIZES_V2;
 
 	return 0;
 }
-- 
2.31.1

