Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2087.outbound.protection.outlook.com [40.107.92.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A04AA38
	for <iommu@lists.linux.dev>; Thu,  5 Jan 2023 09:17:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YgbNmFiI4o7zndBiQU9ogNo1ZKNldIaXXoKFNon11FHuj2d0hEpjqTS3knmwToSq+jI27ufhI66KhtNbWahNdqpar7x2743yogE0kzXnBivFM4O5PbVvvYOGE8rHL2BwgjBDq4NzwRr/vhUWGXNHeGZz8/tVzYH8ETXfqE8xmiL5+Jo3l7ujzzbyzwoYvHwP8EPTnjKJoyvwxUMET5ZNmd86NyKH1O15S51LWZuoai1jG4K37smKPDQ+ANwpuLSTh0Xm0zoXKJrU+EhYugCvCTOU+9omvIDTiJWOnL8uQ2HZKPXMQ8psF8jN8TopUidzvpK7kONYG5efCcogHsK2ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=85aPFonQ/YV04u5CXphqtNjN/hdarEwyrU/4qcULw1A=;
 b=EuKckWVtk1SD7Gpbk6H/I1qHhyvm7oQaVqAgYQL5yLARt3Z39X/DnfK7391ZSlOgWis1ZXx+qwrrjFtoPLrWXBUYLpiKz/uTXQb0S34GADSqyFvz9W4L1S1BR/GS7LlaQpoUqStahT56WoiTimx3vIUyXtpzgCgxrKngJM21CyVgyGrwpkvkzomPZkHAhwrLXRbbxXEQHMIUQrkgj9g4h2XzbxWwsd/wizPhnu47sUNj2Jc1dF++URh7kBQAKwKyBLuKDQ2F1E90dghqttDXHilW8Cz6mVWk8KpyH7+XGm1wmC7MxiMM3HksTB5vp15BdttMz/4qMfAP47JznMoXkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=85aPFonQ/YV04u5CXphqtNjN/hdarEwyrU/4qcULw1A=;
 b=h9Wn0wk1D7IRCXXF6o/3ae0LJSITRacYxdFTRB7ZqT09ru5cqXaHBkJfMDUdcqtxBiSLDzSSS14pntXMqxn645N62ess8lQAvh2dKxw2uyQNEmIHG97LOfDRUy21onTZXoZMkRuFEb8XrgYS0K0ERVnVlScfnd74X/c9ZGGpVh0=
Received: from DS7PR05CA0039.namprd05.prod.outlook.com (2603:10b6:8:2f::16) by
 IA1PR12MB6089.namprd12.prod.outlook.com (2603:10b6:208:3ef::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5944.19; Thu, 5 Jan 2023 09:17:46 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:2f:cafe::35) by DS7PR05CA0039.outlook.office365.com
 (2603:10b6:8:2f::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.6 via Frontend
 Transport; Thu, 5 Jan 2023 09:17:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5986.14 via Frontend Transport; Thu, 5 Jan 2023 09:17:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 03:17:43 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH trivial] iommu/amd: Do not allocate io_pgtable_ops for passthrough domain
Date: Thu, 5 Jan 2023 09:17:28 +0000
Message-ID: <20230105091728.42469-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|IA1PR12MB6089:EE_
X-MS-Office365-Filtering-Correlation-Id: 88719cb5-e3bc-4ecf-66ca-08daeefdb4f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nqrlblLSNgbAQOKhrpT2uZDzG2xQ0goRvihgFB1uiTVqvPSIvef+Ufpq3u8XAnWZaXcO1okIjfmjVQxvQNdrimD6Moi9KxpF+x0uN8Mhvvkn8S1mK9Jy3+ItMea1hggjSq1QU9XcjWgznhKDV7bKkFgjguQ5ujo0Uh8FJBGkSk+KPUwAHnOQYg4iOE6OCjP5TfpufJfnZ/fGI12E4Y+M96AV7iVYst9VUIlB2gaRwxxx9RY12SkFittwx3AsVzt/CvosqmdBdrgFaqY2hYAQ8uF44Gdat/1o9busDYxivvvs7rNR+TI+S0qLT9KP5wQEfr97zCPwihmYohhLm9ikLeHN5IFZ5fGwGEIqCkubgnEuxUTEbcQIf2teVjYPfVMQJyA1gIzT//feaxVf3g/0kLxlbzbmcZpwbUoftBiAJfFtHY3AClLPMw0RMRgd+uBGDbuUeYJISVDvPoGM9M8/trzcfS47K0ZPjvflxnXzTz6kljPvf1FBqj8vkC+m0zSsDQOqEC06uXV4bnrx3Xrme/iNtT6dRmbYUOz3McXqGBvOkGIhwaThxcrxfLJegjnnEUF3VI8/LWFhSk7pSu4NNUnDu4xR7FHFAEW/fbLPFkl5ap098nwF+tfpKENTd/0QKzFsp2zbWS0guv+cffj9AQNB2lD0XBeTKQGsRpXpsh6xkEl1FGfouqLvJlAtGSncGmIzcI3IQUrpXvvyk2+T2ttoqnXmQd3NqbI3OIGdlJc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(376002)(346002)(451199015)(36840700001)(46966006)(40470700004)(36860700001)(356005)(82740400003)(47076005)(426003)(86362001)(2906002)(8936002)(44832011)(4744005)(5660300002)(41300700001)(40480700001)(82310400005)(336012)(7696005)(6666004)(478600001)(186003)(8676002)(2616005)(16526019)(4326008)(1076003)(26005)(316002)(70206006)(110136005)(54906003)(81166007)(40460700003)(70586007)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2023 09:17:45.5683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88719cb5-e3bc-4ecf-66ca-08daeefdb4f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6089

In passthrough mode we do not use IOMMU page table. Hence we don't need
to allocate io_pgtable_ops.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/iommu.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index acc5e5e4f9e2..5aa54249387e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2079,6 +2079,10 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 	if (ret)
 		goto out_err;
 
+	/* No need to allocate io pgtable ops in passthrough mode */
+	if (type == IOMMU_DOMAIN_IDENTITY)
+		return domain;
+
 	pgtbl_ops = alloc_io_pgtable_ops(pgtable, &domain->iop.pgtbl_cfg, domain);
 	if (!pgtbl_ops) {
 		domain_id_free(domain->id);
-- 
2.31.1

