Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2072.outbound.protection.outlook.com [40.107.100.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA5E11CBC
	for <iommu@lists.linux.dev>; Fri, 13 Oct 2023 15:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zzmPL2P1"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LmmTJ+9Ve/HOjw8hsK6NZlNY6FlTZJNI8OxMTth1dKGkNHMxMg/HAngULXmQ4MgcSxAMAt+tLXYA4JNJUm5WwHSrpq340uErXXJuJZ/sgDwuWbGhwNGvVTfhSbx6DcEVwH9nKkDMq3Rc60Gb2BDUxPdTlK92zZEHHxjBO0pygV7rXWyfv4ZmFhykT/gCtcl2ayTpD+nwQHvxGzecF3jYKR4adyePzq4mofpe38alSFGLkYIfJA16qJW/i7cKlQfj856q2tJznLJsQKEiEgCvjEqwfvXdqhmym3XHOYshBby5RgmcCr6ea8613Qk0JwCXrEBbrdDnu6Aoq1I0uyfDNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0xX2C3BJX4ACsdfNeJ/iCaHU8OMt0iQvv5pIN727BB0=;
 b=UOKTJN96UjBGX0LvcETEq0Zeo8tuEbRGRwaWKpGYBArMekYo3vN556chTCoQ1rdTdgEE+1EToRYxszMF+5aU5nmdpB8ebdIlxCrv34dfyaKUj/MTIt2WU8HMewYZvn3OdpZXJicWkdiUkzAiYBRoBuwRWC9ACmfrL4Z8rH0pS9foSRaPJRVXefX4ra+RvSdrREkp6WXFVQ5gBGNapVSgU6XDAQypp6I7N219XaAU7INTWTqWAuJIfPDfopgPwRGh431Ik+dEhKCLYRPGYqDnkoc6EQcjEyLADWr2P4Wj39Yt6PXhmR41m7zc18pc77vdPtgXWhvR+XDXX9WlJMuuFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0xX2C3BJX4ACsdfNeJ/iCaHU8OMt0iQvv5pIN727BB0=;
 b=zzmPL2P1NYGRc59o3jQEyRAUjs/gX8E+VTVjpsKW57QLig8AZSR/M5aasMhnHXh0dkzrNtuvv1Fa8HwVPV4Ydofj6+Gw/LTVleab3knuQYUZ4QiuUHZRuvxvgjoY1UBVHZOfwNYk1oe3I0sQitFbJ33kui8tqPxH24/1x+B+FWk=
Received: from BL1PR13CA0265.namprd13.prod.outlook.com (2603:10b6:208:2ba::30)
 by PH7PR12MB8105.namprd12.prod.outlook.com (2603:10b6:510:2b7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Fri, 13 Oct
 2023 15:17:56 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2ba:cafe::7b) by BL1PR13CA0265.outlook.office365.com
 (2603:10b6:208:2ba::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Fri, 13 Oct 2023 15:17:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 13 Oct 2023 15:17:56 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 13 Oct
 2023 10:17:51 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 01/13] iommu/amd: Pass struct iommu_dev_data to set_dte_entry()
Date: Fri, 13 Oct 2023 15:16:40 +0000
Message-ID: <20231013151652.6008-2-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB8105:EE_
X-MS-Office365-Filtering-Correlation-Id: d287ebdf-c684-460c-b22d-08dbcbff940a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WrKKxuV+FCAyMfnTEopb0xf6T0C151o9VlrD2z3nIj9L4IWrKPVSXIFfNp26HufwY5574/gGO0F0Ux0k0hjfR/zXJCAV2yPsyyiMVvOqNQtain8V5R/m7nIuhaPM2uXLmB+KOfIXFjeSw1izrvcEYH+8II1S6dQIvtsSWpXQK+yisAv1WH3EI0XCBMPF2lkenLAAT6wSvxzKgcQvERIwhV+lr/eNRBKaChpJsysc7wA0I4ytBZuEYVwotqlYOeaTjcknwfkoBY2ssFY9cLiDdROEMKoMor9fYNv28OFiRc1vkjeKMtUaawnOgIkb0y+4WkGDF62ROiGPgQjhetu8cvL09+J091ZfNpPQ9V9rdLApDKJNbE/FVLR5Xekxxbt8YOjm6Fyue12WiIgJCUN0zU8gEdDK0kTLdivPHsBd+/sdXc7uTu338dw24U8bgKI/3eCaxQzpFkWOQbOpU26zxF7aZOFT0FT/3holtEacFZwrPhH0XDh6h9eWMsxNletw8eGQK/jej1WHo7yJHK8ICluctyx7pMNjk4KdJ0MP0bunq/3aSHi37NrGmOc4u5Yly9OcIfjXViUwSsHJ5Q8Iccy2seNt++AqRz57VjkNNhdawCp1fCPFwDr+s2kq2hfYHIEuPxBzfLRiIClQNJXbZ2dgPE3vC4CIlOjgSGwfDAh9l/cOSFXw8x1STtQy9m3bB4D4K4C+JTSdXhAj5z44mSrSJcdxHo7tf6Gp6TEwHDdirzmriEIGUb05qHF4mcWMIwiDfUUNVov9nSLqhfsX5A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(39860400002)(376002)(230922051799003)(82310400011)(451199024)(1800799009)(186009)(64100799003)(40470700004)(36840700001)(46966006)(40480700001)(82740400003)(7696005)(478600001)(86362001)(47076005)(36756003)(36860700001)(8936002)(8676002)(44832011)(4326008)(81166007)(70206006)(5660300002)(54906003)(110136005)(316002)(356005)(70586007)(41300700001)(6666004)(2906002)(40460700003)(1076003)(336012)(426003)(26005)(16526019)(2616005)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 15:17:56.3416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d287ebdf-c684-460c-b22d-08dbcbff940a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8105

Pass iommu_dev_data structure instead of passing indivisual variables.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2e90f7807168..4f1b356adb8f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,8 +77,8 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr);
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data);
 
 /****************************************************************************
  *
@@ -1648,8 +1648,7 @@ static void update_device_table(struct protection_domain *domain)
 
 		if (!iommu)
 			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
+		set_dte_entry(iommu, dev_data);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
@@ -1799,12 +1798,14 @@ static int setup_gcr3_table(struct protection_domain *domain, int pasids)
 	return 0;
 }
 
-static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
-			  struct protection_domain *domain, bool ats, bool ppr)
+static void set_dte_entry(struct amd_iommu *iommu,
+			  struct iommu_dev_data *dev_data)
 {
 	u64 pte_root = 0;
 	u64 flags = 0;
 	u32 old_domid;
+	u16 devid = dev_data->devid;
+	struct protection_domain *domain = dev_data->domain;
 	struct dev_table_entry *dev_table = get_dev_table(iommu);
 
 	if (domain->iop.mode != PAGE_MODE_NONE)
@@ -1824,10 +1825,10 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 
 	flags = dev_table[devid].data[1];
 
-	if (ats)
+	if (dev_data->ats_enabled)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr)
+	if (dev_data->ppr)
 		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
@@ -1900,12 +1901,10 @@ static void do_attach(struct iommu_dev_data *dev_data,
 		      struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
-	bool ats;
 
 	iommu = rlookup_amd_iommu(dev_data->dev);
 	if (!iommu)
 		return;
-	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1920,8 +1919,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_cnt                 += 1;
 
 	/* Update device table */
-	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->ppr);
+	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
-- 
2.31.1

