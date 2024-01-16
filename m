Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E4A1CABD
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705424296; cv=fail; b=WqTBF+8NxUlE9De5q6+uv/dterh85qchLUNiDKKlXXMiMo3LWnlJ5wWrMF7+zu/POUanSvDasrajv6oI02A68kmnURtpQVg914NdSgkijEo3nrljy9dxBAb5DGdGtVEy2fnrUOHTvNwco9ggaG0hsg6m6VhsZdQzsmiCTBiY32U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705424296; c=relaxed/simple;
	bh=CGwAwYd14wEO9Oj6/UlCtOYzN4nh+jtjOcCzgKmBvc8=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=CjvPL+7soW5xcHq7/X+Aa3QTC1pudpl1XmefwGzyK+tnOLe44JwKimYwtlrUVn/3PGe9i0JB8mYn/XmkKAo3fCFn8FXpLeHWzLWkpV+WDxGkSXDoytyT+WBgRXMAf0vQyfv7GlXiK+sPf1XRrs8a2nPr2x/Ib9aRfAY3rj8ZJ1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KAzjivpK
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KAzjivpK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JhOD2sAFBmZGY/dZWFTMz1+gr2WuuS7Bwt3p6/Dw7aZQe22i7NL1/ooDUERBTBHNK46nuI9tMYrioAN8xilGwEg/hw63LPfALr2rbqY6uxLCC6Px5IujZpm+Q70fAFgWWPVTXCWBB9tIylIMOtaIWNwXwgGZiZTWPa4We/ohfWX4wxHWVeQ5Hx5QBI0spJRgaik2rld/rq4vi5K7xuIKqZV80Ra95xcgATekLKIKh8NJ+VEPU67XnUcxNQ2hSAmVNc+x6cp4qW6E0f2lYv0+xbP6lV4+fvDNJMkqRwphpduo/TrTaAYTlqzPTlsJKT8Kgnz/9UIAdacIY6KFrMm2Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/oCucTOWTo/vfqp1uCFQ+gdmGJtBg23YcjYamGKLKI=;
 b=aiQo4v8OcGyGVeR81u86eE45Ye9MbjXaOOLsGW+u+I5O/w8CjKT+S2VK6RujjoJ1XH2VllT9pZcXBxazzao/FyLsj1G+e2INXOLax5B0azWPJEt8/ZsMJrnXcIEyGsJKwEy5zOCKS2YdQs1QtY1LWBJaDCx9bblG4hxS4Xdd36kJKWAVMQvm/sRxKtkUlYcQx4doYKTSuznJ3P/RLfaowjzmBziAHHaklWx6OYMKKqgTqu5EVpYy1pmP4pn7lLueFfO5gE97l+JrMbsSqDqc4/nc7Hc05zWfTHP1XfwbwOQ6eytXtmPI4blJmLn6ZLRX5rhs5EzlgN7/mrtd8/aPpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/oCucTOWTo/vfqp1uCFQ+gdmGJtBg23YcjYamGKLKI=;
 b=KAzjivpK5k0er5iTfckzhGm9i9yrpDrx20Ktid+76cPrlKaMa38rmMFT00wuAjnUbpdfX4Y8kW82rshBkZNUOuXHYeyfOFtZBtGSWHRkI1b8jSTUOitV3eouDwwtUMsMqZiF0FVC7/7yHfOIdDfWAz8P3CezD2baZczrgk34Un0=
Received: from BLAPR03CA0053.namprd03.prod.outlook.com (2603:10b6:208:32d::28)
 by DM4PR12MB6616.namprd12.prod.outlook.com (2603:10b6:8:8e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 16:58:09 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:32d:cafe::d0) by BLAPR03CA0053.outlook.office365.com
 (2603:10b6:208:32d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.26 via Frontend
 Transport; Tue, 16 Jan 2024 16:58:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:58:09 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:58:06 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 16/17] iommu/amd: Rearrange device flush code
Date: Tue, 16 Jan 2024 16:53:34 +0000
Message-ID: <20240116165335.6043-17-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|DM4PR12MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cbb5b0d-7bad-4887-046c-08dc16b45197
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ngFhZAvbvW7YKEEZkjjPgWTvdJ4Jwo8mnOh4ikb3T/ZmTbp7IpVbjeeILopuMkklaVT2CIRDLwuDbD6bHCUpzNa1IBYWpXwf6U/ByvDYNmqMgeGIf+XYT72BBvV7JL8FdYaBOFaqwCCIk0SjpdepzghGu0V3LhVw8TYgIg1FR6HNEMMFqt1Cr2Kd3ldxvnat0wMwaa0tOEdU980JKKiZnQBVdnGn0y0RCxPyPlWbKr3xKnpzAbqg/PejJSga0vnh7ta+W4dLYYhRmov+AXNkO6y3omcKV9Lbmjff7gvjOJbSnwu3UVMOk3m8S3gHfhz/PxKVvGIcakHGEPpCHCV8GhhgHU/RdzqACG6jU8mG66AkR6e+c/7aLaimWu3i6pFKUUrZd3l2lEFOsD0X06+DADjKwnZ7EmrQk78lnE3b5DwjDtRo89/FhkKTCgXWvVeySJ4OJO3yECs9H6xIicQ+Ai3IPH+8s63GgZ50AMW2YIYqUSa0mWVoGzp1vuVPoXH+hQUMZPIY0xjFKt1C5up4KnlN5xocO86wkxJKYdoQiPC+a1BlcFihaXOc9eW0c/49frJGbuT/rEWa2A09yn0au89iuuEdP2/fQ37aOQguBNNJlBy6SgmgSUx6v0tRX8+EHFwqGU13gnVWpbbiy1AOmMDJJ9dr9YBzu/mOXY5AcI6PjMuUSi1AzDKJGckv+STsw1xbLZcW9Nvd9HyNFsfwVLmA5+7Mh9PyBZfSJOJyMPvrRWiU6Uoqz2fNITYHhY5Nx0hB+ileAxyg0sZTZ/SZJw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(346002)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(40470700004)(46966006)(2616005)(26005)(336012)(16526019)(83380400001)(1076003)(426003)(41300700001)(44832011)(47076005)(40480700001)(40460700003)(36756003)(82740400003)(86362001)(5660300002)(36860700001)(2906002)(316002)(54906003)(110136005)(8936002)(8676002)(70206006)(4326008)(70586007)(356005)(6666004)(81166007)(7696005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:58:09.6982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbb5b0d-7bad-4887-046c-08dc16b45197
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6616

Consolidate all flush related code in one place so that its easy
to maintain.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 92 ++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index ac81872ce5c0..6e7436787c45 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1649,6 +1649,49 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void update_device_table(struct protection_domain *domain)
+{
+	struct iommu_dev_data *dev_data;
+
+	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		set_dte_entry(iommu, dev_data);
+		clone_aliases(iommu, dev_data->dev);
+	}
+}
+
+void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
+{
+	update_device_table(domain);
+	domain_flush_devices(domain);
+}
+
+void amd_iommu_domain_update(struct protection_domain *domain)
+{
+	/* Update device table */
+	amd_iommu_update_and_flush_device_table(domain);
+
+	/* Flush domain TLB(s) and wait for completion */
+	amd_iommu_domain_flush_all(domain);
+}
+
+int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
+			   int status, int tag)
+{
+	struct iommu_dev_data *dev_data;
+	struct amd_iommu *iommu;
+	struct iommu_cmd cmd;
+
+	dev_data = dev_iommu_priv_get(&pdev->dev);
+	iommu    = get_amd_iommu_from_dev(&pdev->dev);
+
+	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
+			   tag, dev_data->pri_tlp);
+
+	return iommu_queue_command(iommu, &cmd);
+}
+
 /****************************************************************************
  *
  * The next functions belong to the domain allocation. A domain is
@@ -2173,39 +2216,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
 	return acpihid_device_group(dev);
 }
 
-/*****************************************************************************
- *
- * The next functions belong to the dma_ops mapping/unmapping code.
- *
- *****************************************************************************/
-
-static void update_device_table(struct protection_domain *domain)
-{
-	struct iommu_dev_data *dev_data;
-
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
-
-		set_dte_entry(iommu, dev_data);
-		clone_aliases(iommu, dev_data->dev);
-	}
-}
-
-void amd_iommu_update_and_flush_device_table(struct protection_domain *domain)
-{
-	update_device_table(domain);
-	domain_flush_devices(domain);
-}
-
-void amd_iommu_domain_update(struct protection_domain *domain)
-{
-	/* Update device table */
-	amd_iommu_update_and_flush_device_table(domain);
-
-	/* Flush domain TLB(s) and wait for completion */
-	amd_iommu_domain_flush_all(domain);
-}
-
 /*****************************************************************************
  *
  * The following functions belong to the exported interface of AMD IOMMU
@@ -2804,22 +2814,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag)
-{
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
-	struct iommu_cmd cmd;
-
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = get_amd_iommu_from_dev(&pdev->dev);
-
-	build_complete_ppr(&cmd, dev_data->devid, pasid, status,
-			   tag, dev_data->pri_tlp);
-
-	return iommu_queue_command(iommu, &cmd);
-}
-
 #ifdef CONFIG_IRQ_REMAP
 
 /*****************************************************************************
-- 
2.31.1

