Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 186F34595C
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185151; cv=fail; b=XS3s2jvSILv7Hra8jJO58Rh+9zUILPj1tqM2Vni4Ut6c8lUL0TZG4hXQfNHiP32BQJj2menlZc70KEkgytMjXIOBP1V/M+PmZfd9S3/ntPhT/mQ3qzQGpC3WYVMZ09YFJaRV8F/rgYOudD584vYyEDUIrniXnVMEOYKqpbXQAOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185151; c=relaxed/simple;
	bh=x5Lz89hcAuOBp0OrITEHVGMQGqyUMSl3W0eMOOjIJkk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p6/7oT0hZipHlFNbOkLCGajD22/igk5szYX1LG3J26bFu93bqzyCnnjVwokJ/cxU8gyb3AEEx/2HykNohM/FqHzUFAKiFc17ZoQJHa8Yoc6F9H7MB8EhoAYOM5lfc1nb0AXPC+/c06E6Kva1G5u8yL72iXS5KDkW65dGxZKSJiA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uy91m2jh; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uy91m2jh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dGZfsmtNKxQjtzA4yqp2v/9JGaZLhSvdahsA5E01fF4E2yjoMYuKI2fyRuaBX9j6HAh1kTVEXdDHKI9WofDTO/r7/Lr2H5aYI0u5qwE8JxyBHimco6Z9YTC7Fh/ksdkQwbbKRC/+0htb3YjpHR73RA5gsVNmuFnzbkrUHAPPst4E3/2H8Zzwgnnqo1jOy15hoI28+nNJc252r2KNIMc3dg+SiaW0q2sgF02MvvYmig/n912mFwhDsRxl+8P1SvlisN+rrZfCugwuqcFUv/YYDrYshQIY/rVTLEhjWeyaaExPZQlwXHRyYiYyP+TROem4N7CgNDrTrBuKkD5b0KGQ3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9NMLXmatbh8l4uLjcCk60TCEoLZhoXW+iPmucFtKELE=;
 b=mGNKr3ZD6cDd7xLusA7ozYvoYa+ZQG4MfWqvhiikEMNmk351aSsgq95K0yYVr1+8q7VcOQezbQCxV0IPS5yjOv4wY9rjo10/TihW+odKF/xOeaouPvqMnmK+50UblbyPB6sYh2oTyO/+DO/irIY4g4ieu+F96mqPMQGQb6QNgUa1AJQGSNzyjlhW94nq7uGSKVP7n7qVD8UOEScrRN1SGUHkUvM/jwcxac5TJIEmWTa9/8re7y4V+7r3VYIhqS0R6RmXR3nAzsteyB8yBjST00/metrpVK3QqLK+JAALQCeq3fSJCjb556EGG3/ZAOKMzJjpn3prTNdGdTgCIlgOLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9NMLXmatbh8l4uLjcCk60TCEoLZhoXW+iPmucFtKELE=;
 b=uy91m2jhawMMjFz3yiHdf06PWlMAru5srzYLKP5DSWvsNkuR6phGfeV5hdh8il+dLfuF5zP9b8UcnM5P4ajYR8GdmuESiO5nO/MEscBsE4ZqWhQ/7LTsin9f3G751CiVQxEzQ++9h6smtiQ+EHHOa+sySDzXuCJk5HHrtZ4XmDU=
Received: from CH5P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:610:1ee::21)
 by CY8PR12MB8068.namprd12.prod.outlook.com (2603:10b6:930:75::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.39; Thu, 25 Jan
 2024 12:18:49 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1ee:cafe::fd) by CH5P222CA0017.outlook.office365.com
 (2603:10b6:610:1ee::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:18:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:18:45 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 15/17] iommu/amd: Rearrange device flush code
Date: Thu, 25 Jan 2024 12:11:33 +0000
Message-ID: <20240125121135.8217-16-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CY8PR12MB8068:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c9f559f-ae1f-4612-d48f-08dc1d9fc956
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AkbHvgloq+97Nkcp3baFNLoYm8MXDkUpSl+tNwJjuVDsYi7AGAVsmfAXFzTo2j6tKpezxkata0cl8ovlyOC7ueqxzyzfCT2wDBdnUU9y7A1XDC4gWUcaZJPeKs2fnGXSsbiIA11i2u3xLyhVqa/LCOv98TJFzk3o/Ps8nOHrW9GjheI8pq9qyZCSWTparIwT9wPJJhKvkk9Somwt9yTXZRKqUVKQ01DdUFrCDPvFFNN1p7shQwxUIRKSp6jQmwxEffHE2tDSKMRkTfkDKOTGss4OJ7tQuvzCTUuoKptauGyKuJ6Gb55B74Ugy/quWawSnAVGPSNB4Q4+M2rxKDd8TdQW0OoXyfgf3/G14FsXUtJMpXDoy/1fCqMhMrbzI9jTP8K2pFrvuMv7Py+Q7bfFDJEb9E+GdQoz8E6xAv0i6NmBeDjn2ktLifFtd0MBW7Vb5mmAi4c5f0OdjpgQLtrR29+iB6M+rZcTljzj7nLa8dN9EArfIjzD3vHZCwdGXDp3+mehR+22tE2l2RNwN43xWJNbZr66DNN524Lkouq7tzaazl4xDCJuxpjWiGPXxjkGUX77+Fmf4p5MkR5490RWciuDBaM86bwTO2PjTq1xmd2xzdF34O0wAM2XPqhHeBp7DK4fYbZaG9cs4XWoTYlLK6bDMI99O9YRLowytTK3AK0TNX6L9qr/lStWO+t8v6PDXMkLQx8WSZI9qORKEqtUYlz8A839LTDCn7DaisoqkTreq1e/K7Ho1KCTIX4lX1t+8Fp4h5qmIpLL9tCUgbYTGg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(64100799003)(186009)(451199024)(82310400011)(1800799012)(46966006)(36840700001)(40470700004)(40480700001)(40460700003)(41300700001)(83380400001)(478600001)(86362001)(356005)(36756003)(36860700001)(82740400003)(81166007)(47076005)(1076003)(26005)(426003)(2616005)(16526019)(336012)(70586007)(7696005)(70206006)(2906002)(6666004)(54906003)(110136005)(316002)(4326008)(8936002)(44832011)(8676002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:18:49.3746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c9f559f-ae1f-4612-d48f-08dc1d9fc956
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8068

Consolidate all flush related code in one place so that its easy
to maintain.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 92 ++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index f8d8ad29c3f9..3195cfaa1a7e 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1609,6 +1609,49 @@ static void domain_flush_devices(struct protection_domain *domain)
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
@@ -2119,39 +2162,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
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
@@ -2750,22 +2760,6 @@ const struct iommu_ops amd_iommu_ops = {
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

