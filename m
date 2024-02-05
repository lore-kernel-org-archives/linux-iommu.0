Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2071.outbound.protection.outlook.com [40.107.212.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B46B61AAB9
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134504; cv=fail; b=tShGIqxbUdRZPB9Xe0KNCjJcG6/UyhvGnSp9T0zmMABpoIkAFXP/+tjOK7B2B6nFHI1h42YtCHqduSeM+uQV97uiHXNVIBeFWQhsbvZsM52dG+wikc9Is0Ez6/eC8+jorlnBovREiZk9oBxizLGLI+n6SXq4bwIsEMlXu8wReIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134504; c=relaxed/simple;
	bh=9kyLgvswRwD2mRCHDXlmludHx8k7QCc3kaE1rtCJA50=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eJW4FMFbHs15IVyFcuGkoRhlWBw7LQ4KHUA/IYVeUNJe1ZRBwIYHj6ChZ/CCqbmJZQX5s1YI0B/FjwSr/P6mD36wX/PAXLCeA6lqmBIVrk8jEmSCVyVuJubDcCfoOAatAkO3On+Yfx2lYaNc0fhFeGUvRPqqlg5jgNvXGMIuWdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yilHlbS5; arc=fail smtp.client-ip=40.107.212.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yilHlbS5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I7Jo8rIAHidwkGiAn7VhilVqO9nGHTRsnigl2nrKUHEDSB+S3JRpS/L+lxCbgcHG556F1DzGGAjHSrcJON9rAwwZoZhS9j2JlipFbvV1GidHHnG3yFystgkPblNcmXkq1m4dCmIJzsCP7fk6IB6v5MLPce6Gl6wIWdwDfQGjNVnSKnwfLpKmeKEToSumBcFWIMREUxKUZN9RyMpxQ1aFdACuy1a3XIAv+Qx3pBnaV9fHFWOoO6vJc0oOwmCHRpz1fkVNGDOn+0Bz/n8DYGQt1H0dqnEbBXtVtZUIQkfxk5TaTK/rfNnQhahBKpcm8yZY8OWMwnsuM1j1dYRD3bLk9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s6pviJ3VMj8jnoTPAZ0eyXIs6jb/650wRRsA0H1dsNk=;
 b=POb2Y2HpNJctzCk0jBugO8NdZs6o5lXTyZj2RIglPNd36ZsTGt+cosV6QgSEx/Rlz+zq1xzdEDlKeyCNkvC5XhF1Ytx3DLYwgRaZbfcORgXeQAemI+IZZlAMIY00cOr76r/uUHzH+RD2Y9A2uJZLB6S8GWo9EicjjWB8gZVNNP6BdlAmLXUehX0dv0x/JM2To2JqV3hhyRPo4DxgzGhkXcr55jm8noeqGmzmlNORQgNVtZL6BFhGSeAkTuBFrn++oCf9F16sIF+VnL0yRMMmLHGGNnztOG4yEh1Zu7ICcslf082igiDnYFM/DG3q4czs1KK/07uKQjOCJwIVETKuUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s6pviJ3VMj8jnoTPAZ0eyXIs6jb/650wRRsA0H1dsNk=;
 b=yilHlbS5x8T0DntvW8selDgY52E0dx4x+k0sml3BQhLAn62zrSR6H6ojQE3Un/UgWq+WiYQH+5UhI2PIdUHBf1qSdwHUYuYMAnVGWpLcJG3t0dPeh4vyVmDfzJ/2ZC2CTk83eTU2LuyGlbojg0t/pm78ZvNvtw883bkGYL4f2E4=
Received: from BN0PR03CA0059.namprd03.prod.outlook.com (2603:10b6:408:e7::34)
 by DS0PR12MB7702.namprd12.prod.outlook.com (2603:10b6:8:130::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.15; Mon, 5 Feb
 2024 12:01:31 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:e7:cafe::e1) by BN0PR03CA0059.outlook.office365.com
 (2603:10b6:408:e7::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 12:01:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:01:31 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:01:28 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 11/17] iommu/amd: Refactor attaching / detaching device functions
Date: Mon, 5 Feb 2024 11:56:09 +0000
Message-ID: <20240205115615.6053-12-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|DS0PR12MB7702:EE_
X-MS-Office365-Filtering-Correlation-Id: db6d8ad6-59a8-4617-9e86-08dc26423115
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	kvCqE99li83qbERYaDotXw9V0lYvYns22KjXRk9fXQj0t9pMpgVNXn/OntDSkK6NTfev7vUlfLCtB/uRavDD2ZXFUq1RilGRQuly3+EsDsMAfBzDd/3BANwvCwBK5K+znV01XTWcpsaZi8MKejP4M0KDrk/dRg6c4b4FxWeyzrZq5zTWq89aMFlfoMJgKCoX4ph5BWvBjbroRivC7ffnYynq2aV8UobncFU602rB4F9D3k86GQ17nK95q/cLuzcEFBORZHOnIu0r6v+qtrSKBwzrm6/eMnm37jWNHmcWxKlF7MBSx67e8Jq6shTbnPiE4BZNCMxUqdvvr4r6nDtwDKBgFdWlIDPdYReYczqN9RxN1nvdLVshwd8/NZ4e+PWZpJ3F81NylVezp8Ouqg8JDhA7q5AHDQAXHjc9ZNgaveqauq0djVoWRiVnfn8bw7xMNu+BzwRHvhBK+NbEOw9NVdHk8cZ78YLFeLWxOMH8v5Qd3Qq8SsgbupCT7Q5aHNeE+AxkvkYUO3xjAlHJrDfv8DNePH+Y08bgyfKez4VZBrLaEx+8x8ra0f3wmc0XtTRCJxXHomcxkZxHix2O6fpEiZTKn54gTc5PKZPReYiIMGekwozD/OudcWsYNt4bKB9O3BzcTEwnak97dZEuKn4Oo7BDyYdHBPbbp/FecyXPAPk9EFa9wduiai/8RqDIHrdTNphwgE4fIGmvfkszAa6kgHtQ4M+dI68EeTxj61B68NXrKrVX9g7IyrurO5Po2kJhWti3hXlRYAVNUbnEdzQesw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(1800799012)(451199024)(82310400011)(186009)(64100799003)(36840700001)(46966006)(40470700004)(47076005)(2616005)(26005)(16526019)(83380400001)(1076003)(426003)(81166007)(82740400003)(336012)(356005)(8676002)(36860700001)(70586007)(7696005)(8936002)(316002)(110136005)(4326008)(70206006)(5660300002)(2906002)(44832011)(54906003)(6666004)(478600001)(36756003)(86362001)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:01:31.2496
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db6d8ad6-59a8-4617-9e86-08dc26423115
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7702

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

If domain is configured with V2 page table then setup default GCR3
with domain GCR3 pointer. So that all devices in the domain uses same page
table for translation. Also return page table setup status from do_attach()
function.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 2261a6914bb5..adeacf5a968c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1905,10 +1905,11 @@ static void clear_dte_entry(struct amd_iommu *iommu, u16 devid)
 	amd_iommu_apply_erratum_63(iommu, devid);
 }
 
-static void do_attach(struct iommu_dev_data *dev_data,
-		      struct protection_domain *domain)
+static int do_attach(struct iommu_dev_data *dev_data,
+		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
 
 	/* Update data structures */
 	dev_data->domain = domain;
@@ -1922,11 +1923,28 @@ static void do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	/* Init GCR3 table and update device table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		/* By default, setup GCR3 table to support single PASID */
+		ret = setup_gcr3_table(dev_data->domain, 1);
+		if (ret)
+			return ret;
+
+		ret = update_gcr3(dev_data, 0,
+				  iommu_virt_to_phys(domain->iop.pgd), true);
+		if (ret) {
+			free_gcr3_table(dev_data->domain);
+			return ret;
+		}
+	}
+
 	/* Update device table */
 	set_dte_entry(iommu, dev_data);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
+
+	return ret;
 }
 
 static void do_detach(struct iommu_dev_data *dev_data)
@@ -1934,6 +1952,12 @@ static void do_detach(struct iommu_dev_data *dev_data)
 	struct protection_domain *domain = dev_data->domain;
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 
+	/* Clear GCR3 table */
+	if (domain->pd_mode == PD_MODE_V2) {
+		update_gcr3(dev_data, 0, 0, false);
+		free_gcr3_table(dev_data->domain);
+	}
+
 	/* Update data structures */
 	dev_data->domain = NULL;
 	list_del(&dev_data->list);
@@ -1976,7 +2000,7 @@ static int attach_device(struct device *dev,
 	if (dev_is_pci(dev))
 		pdev_enable_caps(to_pci_dev(dev));
 
-	do_attach(dev_data, domain);
+	ret = do_attach(dev_data, domain);
 
 out:
 	spin_unlock(&dev_data->lock);
-- 
2.31.1

