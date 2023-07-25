Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2050.outbound.protection.outlook.com [40.107.94.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9E61FB7
	for <iommu@lists.linux.dev>; Tue, 25 Jul 2023 03:31:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BES157FK0gE0NdbbnyNPDrTUaL3L3o5azhbj9VP9RNPWXxMEI708Aw/U6ZGP55PoJf8o20ONSXZ2x1jrOwMiKJ07y7YJYQ6P757MAfxiVG0jRmME04DvfMGSEl3Dq2dsQiHQLT+YN6eoSCUs5j8/mPmQ8+RTA41Z9hqCxj7g+fRJ+ZARK8sCxBkMRKhBM8VFPWtqw04rdgX1q40K7YmPhz/eE6GL7UYbGb7f0VVoSFtUkilrx6VUwCf8u0+w3xwmRA25VQO23QuNtaqvfcp4rffvBtIMkZlL2+NPMvDhEege3O20SG69b+qip9AqKnH7eJt7N1CeP2ls5LkdmRvnRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TQGyBMnBg4yT3jnTVAWLNLwd9fLHT+QAGr1yl0pZhsA=;
 b=BWfiXgHRBLwh9m3SXuDvT2HqIX+sdu67gPfavdjM16o8ZehyMXv+Kw9T3ihZkaKhy53NGRmcJYkPwMNvq+1urhduR6jqPNFsHgDdycgcRNyol+vlgKcv18RVh9e4tn8lhs8ISMrljCf5GeLjj87OD+CJsaQAMLBWIKMW5SCaAJDD34aR++3AHkOr+GxxzCbgDiuLxA6/yz6pq0SF4n2ulnHzPcPsIgWyKELMt1OTXfoShr7Zs4ROweJEvcSkoqEtOETgzAZbaOl8f2PUK0Eg2nIvJRevDN2tqbAUDLMZgZik+8rHB6Fet0CFevtPPCa/GGSIybi3f6DiaNnQHyMkSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TQGyBMnBg4yT3jnTVAWLNLwd9fLHT+QAGr1yl0pZhsA=;
 b=j1woApV+j+cAf4s3c99EkVmhpUoFvnwODeApKyUmQ1PRCXR3fqkhkyPCMHIen/BixiAKBOq1PSt12EVi0vohNjpcqsx301Brh+5xPSax0W3bdJr6OSBlAewliQajozmMaslqbG7AT5Oblg9fu/8g3LAJUaAtpAfAXvGxPTbAKWs=
Received: from BN1PR13CA0030.namprd13.prod.outlook.com (2603:10b6:408:e2::35)
 by IA0PR12MB8840.namprd12.prod.outlook.com (2603:10b6:208:490::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Tue, 25 Jul
 2023 03:31:47 +0000
Received: from BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e2:cafe::37) by BN1PR13CA0030.outlook.office365.com
 (2603:10b6:408:e2::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.25 via Frontend
 Transport; Tue, 25 Jul 2023 03:31:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT009.mail.protection.outlook.com (10.13.176.65) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.25 via Frontend Transport; Tue, 25 Jul 2023 03:31:47 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 22:31:46 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 24 Jul
 2023 20:31:46 -0700
Received: from dev-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Mon, 24 Jul 2023 22:31:39 -0500
From: Jesse Zhang <Jesse.Zhang@amd.com>
To: <iommu@lists.linux.dev>
CC: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Yifan Zhang
	<yifan1.zhang@amd.com>, Jesse Zhang <jesse.zhang@amd.com>, Jesse Zhang
	<Jesse.Zhang@amd.com>
Subject: [PATCH] [PATCH] iommu/amd: fix the flush IOTLB issue when do detach
Date: Tue, 25 Jul 2023 11:31:38 +0800
Message-ID: <20230725033138.821890-1-Jesse.Zhang@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT009:EE_|IA0PR12MB8840:EE_
X-MS-Office365-Filtering-Correlation-Id: e51f2e60-3cf5-4c2e-8cc4-08db8cbfad0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Bnr8Z4wk41F3DDVOnPKhgTzv/4zdzgRGDAUq1RFVQakg8R3RITx/RY3SosMwwkdUM4QDs6YZYpg1otwNza41uQUPIj86j7ixCzHn+CmJOgJM6UZrbPCCvME0Sisc7DjsJt7AUcehXsyZc2AuPaHRnuUbejwH3N4bdV6zfgaJOPU4O1fSPptiPyo0Sbq3pvKweOxRYALLGtV+QlgGSTmqG6vCLdXeZAkxANrp/JQOJv7Q31xcklOHbQWJ7RAIdZpC7vBO0XuyDm2JHqk03KB9rdVSkjQ4RKhNJlwcwDmBTLD/IcDhllEYlCEAEjYk49n74F7zkA2Ei1/cYzngMfLP0Aix3d3yGnlK+z+qYJmT6TqZih6YjorsajPe8z1oSPXIEEXF+f6Ouu8QcYFQkhpI519Gp58FFCR4lIhCQgWqEaMiR2s/O3TLts9xwDA1osS+zRyeCRwHUK4TUZMJww83F0xqVxl5icdGWYtpGKF34vMpI+pP3BhMN152g9bfVLnyHaWYEPu77em7gVg81zI8qUODnlpr6fiXcV4tCbL6rjOsB0/rr15SFwy4gVOduDObtk/ex1JrMbgiJkopQ1ci1oL1pPLGCQADY+vRefyNmQPbT5s295eiYFH3NSSxa6uvJxHZX23EjAdSm3XDJZxmd2x0NZrvISeSYqA7s5TYheCgwL9q2y4hLsknpj7CxOOjmOTNIg9VaXdqpjDEPXW91ie4WmuAtcvu/XIFPePMAFxyH+m8/Xn7iLbNCRwAKtFfNapZ8g7RK3NvQhC5Y6HyRw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(41300700001)(40480700001)(54906003)(8936002)(5660300002)(8676002)(4326008)(6916009)(316002)(7696005)(40460700003)(70586007)(70206006)(86362001)(83380400001)(478600001)(2906002)(36756003)(356005)(47076005)(81166007)(82740400003)(2616005)(36860700001)(426003)(1076003)(186003)(26005)(336012)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 03:31:47.2642
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e51f2e60-3cf5-4c2e-8cc4-08db8cbfad0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN8NAM11FT009.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8840

From: Jesse Zhang <jesse.zhang@amd.com>

[WHY] After invalidating a domain's page tables, then we need to flush the IOTLB of the device in the domain.
[HOW] so we need clear the IOTLB first, then delete the device list.
otherwise, that will not clear the IOTLB by the function of amd_iommu_domain_flush_tlb_pde

Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
---
 drivers/iommu/amd/iommu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index dc1ec6849775..6e4c43e25c27 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1699,12 +1699,6 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	if (!iommu)
 		return;
 
-	/* Update data structures */
-	dev_data->domain = NULL;
-	list_del(&dev_data->list);
-	clear_dte_entry(iommu, dev_data->devid);
-	clone_aliases(iommu, dev_data->dev);
-
 	/* Flush the DTE entry */
 	device_flush_dte(dev_data);
 
@@ -1714,6 +1708,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	/* Wait for the flushes to finish */
 	amd_iommu_domain_flush_complete(domain);
 
+	/* Update data structures */
+	dev_data->domain = NULL;
+	list_del(&dev_data->list);
+	clear_dte_entry(iommu, dev_data->devid);
+	clone_aliases(iommu, dev_data->dev);
+
 	/* decrease reference counters - needs to happen after the flushes */
 	domain->dev_iommu[iommu->index] -= 1;
 	domain->dev_cnt                 -= 1;
-- 
2.25.1

