Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A3163A1B6
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706184821; cv=fail; b=qBK78PRBdL9JlC/1XhqalkybX4HXE3dvbkeef3rNXwIIWVCKHVI6Zg1QLeCStRn1RUF+P95+SGLYKRyHHnXThp/X0qPIOYUPn0dunMlIDDAowD5JHb/QNTh30sqlc8KBE5i+PLDMe8ANQYrc85XKb2XgQpG74HSSpxMD6CLRAo4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706184821; c=relaxed/simple;
	bh=GVpmif5k3rIvtTluVYMH9E92U2R0JaIdfDZipS1s8wA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWdOjOASGK9D3d+Whfy9w34GJ5pRsXJw/V7hrGpP3kMV96Bnwq+8Kg9voqu4IAk5qMsIMBfl9RU+Gh/QwjvSnH3q/11MP6aahC2PuHZ5r8jHmMkpPPUuRugixPfNffoU9tHQ7AqBMtVBVq/2AqXRgULuia2zcX0CLylfNe28aq8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3BXiC9jp; arc=fail smtp.client-ip=40.107.93.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3BXiC9jp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnimJ5bD5qkX4kr6vbljozQ8RlL1pANTsiNfek3ut0YPY3c9QCGPZW79+JTjHPHCwJRNpGh+PhmpeMn+7rE03BvFiJ3KYmovB+TJ3fY87KF13VY3ELZgWGSSCGDz2T1qFvErSZLU8F55TkKL+xtNPWzETVN9KrkImLoPPTNhCO478jbvYV3e/7CRr9Ybu+9Sut1K3wKi5UgTSEDb0vcY3jJigKMcOtUNyrqzaXM1mo4Ep1Uyv0wmSsRZA/l91HE3p9AET+FrSP1b0nF6doC2+xIDvJvy+Y0kr5NAF0XPZxknd9l/bbv+ZID/xlENQmOOjEbRbR9FzMz849HfdxftZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ta0MEkjlAMw5ON4Yxn1y4nXuJHRQBn7PNqY7NMZm9+U=;
 b=BfwBJsecb+wSfcPPq5t1H6rip3OnGGTfs28G5L5nLMvRGlCpruk/ZlGfL/Hw2RoGr8JePpOVL8MEUbSRqD3fcL2xoCxrPSa1HvoT+yc0JQlv/Nkl9dCNMsMGvkhlByVGcbUrRnfd1bd0cBm9wXsXSNUYM0ywNV9g17HJ64N0ZwnE1WT2hL1zRnT9KF8a2rSSR37iCzfKpwj0/PWMwQNRcf0QpwzL8O8O4KGhekaGGcVTFRNvDd9hjQuHRyolmRLl2ZD6zh9N2JyfedXRD28uYJJPRU5aOPAyw3jxjb9MeEDfXLmTFXDDnAIED1ryyB8+yr6KYvIVUeb/y36XSnRrWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ta0MEkjlAMw5ON4Yxn1y4nXuJHRQBn7PNqY7NMZm9+U=;
 b=3BXiC9jpQP/ZrPLOOMKBojpaqU0ys1afdNWBA/LbY7mXGilr+QkuV1ij8iGf2qkfdhP0D2aLK9q3Z/0DKcPrl/54v/apVAYgm2FK+A4Y9KoMYCcSb0nHvLjzwTLIJxcv16LiL9L/iqJ3oHLnGUxTU+KiorxzbVx+R82yFyumol4=
Received: from BL0PR02CA0132.namprd02.prod.outlook.com (2603:10b6:208:35::37)
 by CH2PR12MB4908.namprd12.prod.outlook.com (2603:10b6:610:6b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.24; Thu, 25 Jan
 2024 12:13:37 +0000
Received: from BL6PEPF0001AB72.namprd02.prod.outlook.com
 (2603:10b6:208:35:cafe::cd) by BL0PR02CA0132.outlook.office365.com
 (2603:10b6:208:35::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22 via Frontend
 Transport; Thu, 25 Jan 2024 12:13:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB72.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 25 Jan 2024 12:13:37 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:13:34 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 04/17] iommu/amd: Introduce struct protection_domain.pd_mode
Date: Thu, 25 Jan 2024 12:11:22 +0000
Message-ID: <20240125121135.8217-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB72:EE_|CH2PR12MB4908:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a259bf4-238d-49f1-ca45-08dc1d9f0f86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	747SAeVJq7VxCrVJhI7QILC6YllbCm00x2hMKyoOA7KCbEf7T2t1Ny+/guqnIWUQk+8pvnE8dJlDFIw7AjPOzZgnktRNSbLXAbkXjkUenhcB/UzjFwdkvznAxH+rU1V5czVCbZzETTGecPpFDRAX/WqPgMwBZA0V5/0JnhcbkqMwi6nuy5RtkrfmaYGcNk/S/dd8E+5H1YNVlBXDewh5ivSICHK4lZgcC95f/8AtxYiw1KbOiGmEOkXCj2kSVSMhDN0lgMFqku39fN5tkwptNj8DM0TTT/tr1daTrbkiJsgZ59o9Tp1UEmZcWdJ0c7HVpK9bYFI6r+N/6LUE1gATuw2Au2p2AY13YLlgZ+ABQuHS1/y/VJXslcfxJBRU08nSSWLo1kNyqEhZU1x47O0qVIKiISr/va+TbMK3JnA50b4n3cP41UoWyQk71kpJXZgyhdq4G/HpBVl1biIOtUWeGeTWSdl2mCA0u7YuCtL4rg1YHglkCYrYmx25ZHISBRDEYBCAzOBPBhYY1Sr+EtC7Q9pk/iA+Q9Pj5sIvJnlohgDAtxEIA2hEyh24j+44MPm37vHJHIlL1B4occsSxS/1cLYPDrKrfS3EVXQcybCGH/6D7yqCOT473a6/8HHwRULEO12t8ncRkCIziX9hoj+fKKUNmJz3QGEWXMOvgt8Xnb0ZY/lQRA8CeWWIPNA3MGmX8/FiCCRruVB8dqNLH74TUd8jcEvaeH58z10w2fD4ZC28QQwNsQXgiIypeBRp7kWGIkA7GRVGvaW20G9343tyDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(47076005)(41300700001)(86362001)(356005)(81166007)(36756003)(82740400003)(1076003)(2616005)(4326008)(26005)(36860700001)(16526019)(426003)(336012)(110136005)(70206006)(2906002)(7696005)(70586007)(316002)(44832011)(478600001)(6666004)(54906003)(5660300002)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:13:37.6015
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a259bf4-238d-49f1-ca45-08dc1d9f0f86
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB72.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4908

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

