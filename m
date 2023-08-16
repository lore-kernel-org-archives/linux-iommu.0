Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FC59174D0
	for <iommu@lists.linux.dev>; Wed, 16 Aug 2023 17:42:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O7GIEkbb8XZOflseSP4uyk4lI/lYEYQ5W2mPi0pIzc/7X6kFGNUn/dY7MKBxTrh1Ap5lMzY8XstEWAkMgKxP8OdTzxNpwByJ3gubCKZFMHb2V46kv4qQspI8nCrxdHl/UrgajeKeM9hwX6zUROQcmHTlP7M65fIYkbHI/Yx7k0me9m6FCIHMrRBJFobnm/ncP1WIgaQ4Cs7aqzYb9z1V+xki7MLI9mAzJ4aFt+NeFERLnQyr4AiI+TSmGjKaPUz/MjGLhl7Mz2UI0Gi3vQ2VTk5T3m3B5nyIvLK8B4JNKLwA9CqpuCMS/l74as/9a6bEXRxBBBKLhZoobXAYmMyDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hAvNejTXeSS4Q7lgaVrCBxSqNeivG8WrN1Pa41u0SW0=;
 b=I1b5CPKCml5NCB31T5CXfPVDMwbNxDMA+Qa2fEgAA9U9CfRa6x1qM2IeGRheirKVgBzVCDgDNjl1sUOF5E0E5ZofG8gQpnn5o9b2xXjBHPd2/B28vevCZz89PF7PedsUlU8ve+TDn6E16xGEQJWelXUzTeMR1cQKsx7FruZ+Hq4QuMvTH0S4PIzKkuYSpo16bTH5cUcjHQ3ah+2MXv38ih5prNPyNyvzY8CBTw0myrI5/Cs59LwM1OEYohYweYfmdh+hcB/a1UsUB4co9K9OutspYBdVI77CSzbJhGSezOTLoRMQWnXgTsGuEXmkw+GjUYJol3hXSAngEqMxcUVsRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hAvNejTXeSS4Q7lgaVrCBxSqNeivG8WrN1Pa41u0SW0=;
 b=0/OTYoBqS4rvn5pSksK2XTgtRnBli8BhtdxU7r1yCvfFgj2g+F6QVH79++T+laA3fSKPSxJPsH2XO1pPiZ3+bBs9pQluFLGZY4ksxshQDlc28fe7Ds6etmiKJdyqz/1jVZt4xOk871ZL1/3FrNLmn9vq+vb9DMfp5ycfCrdMFoc=
Received: from SJ0PR03CA0100.namprd03.prod.outlook.com (2603:10b6:a03:333::15)
 by MW4PR12MB7239.namprd12.prod.outlook.com (2603:10b6:303:228::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 17:42:46 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:333:cafe::95) by SJ0PR03CA0100.outlook.office365.com
 (2603:10b6:a03:333::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 17:42:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Wed, 16 Aug 2023 17:42:45 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 12:42:42 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 07/10] iommu/amd: Refactor helper function for attaching / detaching device
Date: Wed, 16 Aug 2023 17:40:28 +0000
Message-ID: <20230816174031.634453-8-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MW4PR12MB7239:EE_
X-MS-Office365-Filtering-Correlation-Id: 906fa6e2-a009-4fe8-4f80-08db9e803344
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OZmLfVRJThs+8CFNdn90+iZEDxYAz+ZU1Hgk1Q5nm901NczJggbWPFcqLT430eVuRN4h10yegHq42zdLzr9twZb2e/OxvjMhiBWzQaCqMpUcSLY5D7UKQFvXJTnrh/ZyBPywmiXy6WhTm925Sl+kYH7c+zLvkgXb9fTvQRDWxtZuy3F5KlqMYRKm5NfULH+4BngGkbYNery+EA3P8zz3OhVPakEyzN707GkUu+ADKdJr4q5iyl5ZSTZTn1XZTtRiihnKH0iIwQT54S6a4QykMpcUhWnhoWvAXlq/z3rh+1RULzANi35YcLfKnOAaC8fg3OtPC4XYPLQxXX2ryC4X69NhRunRNkiCc/+uLSk76RYGyAMzPoXuRJnpfijajRoLc4zb/8zSDukKu5HSui5iqnSH3R2KRb4nQ9aaWt4vLMJ7fa+gEUkYkJcQ5YN86BqIPtTmWjUPCraCYBxesXE+8/2fHcnQWFyPYBB0GBI1KX8vN/7INaXYzpGeinGlwAvh4F/JEh924GtdiyYBCsG0X2oGdVoa2r27jXDONWq/uFhOhWJDd/zMiETRcELoe4XFb/mJU8y2VYioK3wwht1CJCoLXIW15IQZJPIlo6NOph0KLEwgVqeUMHy+7msu8uM/gtpYQzB2UaR2o4HoXvw9O3l459waaz525TKi8gEn2wC8X4nHm85PHlKIrU1Dv/UDQYb1dT8bPxcgxJABkojXWNrvGpjXMerkywcnWPfsyTC1qRUPouV4ZN9YUZPaqdSKMqqr8Mo/QIACjGeeQlIgDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(36756003)(7696005)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(36860700001)(41300700001)(356005)(54906003)(82740400003)(316002)(81166007)(70206006)(70586007)(110136005)(8676002)(8936002)(4326008)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 17:42:45.4612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 906fa6e2-a009-4fe8-4f80-08db9e803344
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7239

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

To use the new helper function for setting up GCR3 table.

If system is booted with V2 page table then setup default GCR3 with
domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from
do_attach() function.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 51 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 47 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b54d4a0e2f4c..421f827fc24b 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1804,15 +1804,38 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+static int _init_gcr3_tbl(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	/* By default, GCR3 is set to support non-PASID devices. */
+	gcr3_info->giov = true;
+
+	/*
+	 * By default, setup GCR3 table to support MAX PASIDs
+	 * support by the IOMMU HW.
+	 */
+	return setup_gcr3_table(dev_data->domain, -1);
+}
+
+static inline void _destroy_gcr3_tbl(struct iommu_dev_data *dev_data)
+{
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+
+	gcr3_info->giov = false;
+	free_gcr3_table(dev_data->domain);
+}
+
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu;
 	bool ats;
+	int ret = 0;
 
 	iommu = get_amd_iommu_from_dev(dev_data->dev);
 	if (!iommu)
-		return;
+		return -EINVAL;
 	ats   = dev_data->ats_enabled;
 
 	/* Update data structures */
@@ -1827,12 +1850,27 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	if (domain->pd_mode == PD_MODE_V2) {
+		ret = _init_gcr3_tbl(dev_data);
+		if (ret)
+			return ret;
+
+		ret = __set_gcr3(dev_data, 0,
+				 iommu_virt_to_phys(domain->iop.pgd));
+		if (ret) {
+			_destroy_gcr3_tbl(dev_data);
+			return ret;
+		}
+	}
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
 		      ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
+
+	return ret;
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -1844,6 +1882,11 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	if (!iommu)
 		return;
 
+	if (domain->pd_mode == PD_MODE_V2) {
+		__clear_gcr3(dev_data, 0);
+		_destroy_gcr3_tbl(dev_data);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -1889,7 +1932,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 	/*
 	 * We might boot into a crash-kernel here. The crashed kernel
-- 
2.31.1

