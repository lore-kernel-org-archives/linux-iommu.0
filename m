Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7735DB645
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563453; cv=fail; b=FVcqwD3Sr7uHmo4RScqHnkcmx0hIF4KZ7ahWSgXiDE0KFkVY/sBn2wSzus3HUduIziv2K6LfdzWlMm29qNwRakRFMqx1kvsouIfuNlM9gkOCxDYtn/Qjw1zw3MTJnWsbcVhy3huRoXAFqWUElMB2qntgMiOAJzEuLJtF7K4fmio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563453; c=relaxed/simple;
	bh=BaMxujgFp8ym7m5DWijqVEoqwU0ZDO8aVOJSQ0O6VPo=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=SMK4WY7pCarojA9HIiGGEVGtJUGCNJB8qLpi1591eja+sHieb6PVV2PAKynaf8bhlnx6wr0hEMEfRPIk0Lw7ong05pKZNOT1L001PfAyi/5RskFFuUmPgBsivPNs/9q3c8se8N4UkHd69yC7PGKkwK+gEdXKxlzooGkse5Ji6i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RcI3ZlmM; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RcI3ZlmM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eVZ+sdYm+1iHZxZ4GUcn2u6y2tuBQxE0nFuMsoUsx/NjQaxzo0WK/+oxIjN7UdjJ4aqJpC+1PbA4gyPSHIf1On/W2rrZ0twucWt6mtUwo/5NfZbk5ATk61Bl2/2iqDPpx/4ftufsvv4aUSNjSCQNmgb5xf/Y9dM+Kuvf5kRqj3phgWKkFm6qwQiYiG/nObLgH0cEL+aKfQPDeJusZcP4xyAcsUVbUjnVYav4SVAHlWte0wpbhz7+FkC/VpWfib5gkt3fxkq3Ae1R0NJXrpuDze+lEkl80RMFImTUtKOCls9bj0WuVOr7LsUrQj/A+x65g6lZUovMycTvgpWdqvtyIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5B0+GdZL7JlDnmRlplPJhh9jcshJuzy91QhyjNeh1Vo=;
 b=lXga7tSnPtz4Xo6u33h8ikwI9i8B6hR9Sz57WPxaBs2AITLE+OgoG41HDGekQpRppdKyi7dsAu7JDegpknZy4A3iyLx6OqGUxmDGUMlYo1NWFugSYZteQd0x8yL58wjePEbd3nf9TCyt/5E17fgAtrCAIDwtWhohSzGSZJwjOB7vdqunfSlmACwZe58trjBB2PweKLrd+suTgx1LdO3m/J0gAI0A66FuV6RBssBZPbvlWJvj6vbJOe6mh80MgKTAj8rNwxSVkEVw9mTH390dHHx7oaSM1tRS/hKPVOGBFssEsuRyNuZC2VDcrMh+lStFK/O+6ZX1jpzepiPrUVylgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5B0+GdZL7JlDnmRlplPJhh9jcshJuzy91QhyjNeh1Vo=;
 b=RcI3ZlmMOj3kARRPKFSqx+0WA7V2fD0EB8VWks7PCJteC+G0aAaYuVTrZGzar0zn+HisK+UHwsnRSvf0IX0aqvlFmlytUw+UQt9+CI5lMwdIzw7qfQZFmP+1eSemlea8HDDdFwYTBOPj2lqYVxd4pih3FyISpbwB52AOiGAEbQM=
Received: from SA9P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::13)
 by LV3PR12MB9438.namprd12.prod.outlook.com (2603:10b6:408:212::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:37:29 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:26:cafe::46) by SA9P223CA0008.outlook.office365.com
 (2603:10b6:806:26::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:37:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:37:29 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:37:09 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 07/14] iommu/amd: Add support for page response
Date: Thu, 18 Jan 2024 07:33:32 +0000
Message-ID: <20240118073339.6978-8-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|LV3PR12MB9438:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d162c3-e1c6-4b0c-c1cd-08dc17f85320
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iAWpr9rAclW80fdbqNHmwPRfsXlTReCUUYgvfWvKIwKZPBRacXN7/TOcAHi6iXlZN+OxW2tHdfro1AswGu7437cVR928Cnzp4S7yds8mLLhAgrJlsBNoWDlIFaDe8TGGw9tjQ+4Zk9k8OxbDhQMv8WuHw3h5j3Y0muZhOjog50irlhDtUiWnfptlzRMjt9RaV+XkJkhSTcpwJis+jqBJt13bYQ4vzYMAggngJdYc6P+QF0pMuGl8ToLz1X/8TELnGm3CvFO6H6cfPzb0DO0zGzVEZeW/4zs1jfzxdQ3GQ9+cVuHdcm3uZG8o9vobURLGKbFx/8Z9rWmAxi37sQG1Ad4fRAyuqiCVPlM7uPH3oUanSxNrxrM9PWgamEHVmz64EmNQluNq8UVa8WOolqCh2JiQjhGj9hbBolID0NGV1phyr0LcLpWklFjnTHOX/3HKXxJXx4p3tJjq4nVwIyvQEm/mGoQbLl5aW7GujZ9FdJOy1Wb0OoVjOIDUCw2RK/8HZ4C+nojm2ssL0zyVhCG0F77mWIQCBh30R/wf5iTzwZzQUN5vGFmNlbCZ81f/K1s8LSLZe570YElHPam59/iafs5A35AXx3R8R/W1D4mjYVsMNDzyYMeeokAQZJT/urkJ7SIT3JhXxOOM+84v3+Xt4d+8Ft0J6AYoRjkqyJxH0Zl3D9jvLghwpuinvXk3gas14f5bwxOdWcdYgRtjoXp17SsqYTnUsbL6m2Owi9nNtrIjLrIyGuDOfgSp8n0g0ScRi6r78D6+W62nBs4htJ11gg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(396003)(136003)(39860400002)(230922051799003)(64100799003)(82310400011)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40480700001)(40460700003)(83380400001)(426003)(336012)(16526019)(7696005)(86362001)(36756003)(356005)(81166007)(44832011)(5660300002)(4326008)(26005)(2616005)(1076003)(82740400003)(47076005)(36860700001)(8936002)(316002)(478600001)(8676002)(110136005)(54906003)(70586007)(70206006)(2906002)(41300700001)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:37:29.3283
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d162c3-e1c6-4b0c-c1cd-08dc17f85320
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9438

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

This generates AMD IOMMU COMPLETE_PPR_REQUEST for the specified device
with the specified PRI Response Code.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  3 +++
 drivers/iommu/amd/iommu.c     |  1 +
 drivers/iommu/amd/ppr.c       | 15 +++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f9e921cf97ca..c8deb22955d7 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -49,6 +49,9 @@ bool amd_iommu_pasid_supported(void);
 /* IOPF */
 int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp);
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 405609bd9290..d300456e8984 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2786,6 +2786,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
 		.map_pages	= amd_iommu_map_pages,
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 1eb0b737afb5..b1751eb495fd 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -148,3 +148,18 @@ void amd_iommu_iopf_uninit(struct amd_iommu *iommu)
 
 	raw_spin_unlock_irqrestore(&iommu->lock, flags);
 }
+
+int amd_iommu_page_response(struct device *dev,
+			    struct iopf_fault *evt,
+			    struct iommu_page_response *resp)
+{
+	struct pci_dev *pdev;
+
+	if (!dev || !dev_is_pci(dev))
+		return -ENODEV;
+
+	pdev = to_pci_dev(dev);
+
+	return amd_iommu_complete_ppr(pdev, resp->pasid, resp->code,
+				      resp->grpid);
+}
-- 
2.31.1

