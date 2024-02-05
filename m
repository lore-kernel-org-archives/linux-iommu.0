Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2074.outbound.protection.outlook.com [40.107.220.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F5B1B802
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134621; cv=fail; b=rTTzzxCNi3FmrEtkQb1igtpChLBDbTNwvarDZ86g4K6YNFyofMYwTDADE4hHTe3YTJTtjhxczj0wkFXo2K24EGzMxLK58/fVLJFue3mYz3vcprb0KwwhSYgJARKPxQ9Y6g/x5LYKp9CS88hceyk/fxoyF+XXN8QhGoGafDKZHbw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134621; c=relaxed/simple;
	bh=GOKmrXzlGTqysvoKq98ohcc4kSya+OkWbz1axVdAKfQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uYmIpce0Rx44cRFKVkmSfKGluZUCSG4q4ODyZhoXrNolaMAGAHw2iTCodFcjJoQpfORaUAw1j8CVV3Sid/NWJzyDvitsSUixKjkiq+rNH+omDWLuYpOfJZZV1Ce93l5wCXE3V4q2Sp7mP78/JvV5D7yTQADAee24jkG/i1rdgYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RFaKQFfh; arc=fail smtp.client-ip=40.107.220.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RFaKQFfh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN7jPyUKDIMdzBWLOIJT1mCzQlDvonu3AmzX3iir1PreYBfXnM0Yfs7P+inL+OzPTjXNdjZO/ShgHAWzIbEUICFy79+1XunO6F4+K3erPUYufMnGwwBlbGcA1uzuSTK8plk1RlnN392jYNbkxqD89MYljh5WSvBlOrCK2snGt7/t6hsg1yU1BDBw/fNeqbTq16NFmL9teeCOwVnD0+wAdpPmPXO1EtAriN8QXBWAyWZ+/HX+jdp8WYmx68Szmzy1amV19WDhnFGeE1c7y6kBFGJ/eKKjlbHHnhizhNclEFw4rsyXyvPPvQ8AQPyQrA6SeN6WhZZmtVfcBvTbLM907w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhqcAOcw+QN4Q49yy2Kt9WqUR88TZr7fomHw7FylaXM=;
 b=H2dXGmyeN8Y1b2sx1jXCWO4WlwFI1fI5V9Fl+RSG7aOsjWrlPJWqU+5Mav2iX+mQLsoluVaFIXy7K9OiyfckAhlU2NL1dBL/k2i6VShM4Z+sIRMikI+JceiZ2ArtgdVlbLBjFWQTSn1itmES/2UBzDr/V4Z703XY0cqH4p8nNIA4M/q/meKp8bkrFDv36+8Qh0RYGi4ltp+TOXtLICs9Pk/jx+FcDBG7umC823CyXJpM+tUHfPt3w/cuIUwQvkTyCz4nz/Zvn7fmZHTQ00S4WYJfIINkr4Orp0nx/68NWSRVKwylbK/sFOWtp7MSy9BkOk4zfa0BkAKcLY5lOnJZCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhqcAOcw+QN4Q49yy2Kt9WqUR88TZr7fomHw7FylaXM=;
 b=RFaKQFfhk1r9jxVvV1iRzxBadUHTyEF4Qst/6jk6Jvk3Fg3EmVdB+9LSFJQ0ysx1qwHyYLTy2f54X1es/UIFeQSOzXIo4B41HZmDbS5b4NViUMBvD+bDv+h+5KaqKCJICKkWX7Yle5HRwZKauaXt0Rwa8SwQ4o+qSQeYJM1FbJE=
Received: from BN8PR07CA0003.namprd07.prod.outlook.com (2603:10b6:408:ac::16)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Mon, 5 Feb
 2024 12:03:37 +0000
Received: from BN2PEPF000044A4.namprd02.prod.outlook.com
 (2603:10b6:408:ac:cafe::a) by BN8PR07CA0003.outlook.office365.com
 (2603:10b6:408:ac::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.34 via Frontend
 Transport; Mon, 5 Feb 2024 12:03:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A4.mail.protection.outlook.com (10.167.243.155) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:03:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:03:34 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 15/17] iommu/amd: Rearrange device flush code
Date: Mon, 5 Feb 2024 11:56:13 +0000
Message-ID: <20240205115615.6053-16-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A4:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: c974d36d-cf4d-468f-21d1-08dc26427c04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XAQnuZ9pY/eKoejFETQx8WuUozH1RiywlMe+Gv9pKNh84mSgQYrpKAJoBDQwkj6btAZMbu9nMf9DJCTEfIqUbzEySEvYVvFZRjR6yEnyPUMKnf2pB9/sbyYCLE05PLAv5J456EyXo9lGFQhfHJtYCfs6+zLqYiLV2pjiqnx6P71/oB/EdUKezRCLp4Vy3J8sHcOoW0aCk6NJcGEJOtXgZtQmLzh7RXrH3r7mWFqUUR2HD/9PFfJaGOXPpmyb9bG1qh6wCKxWHV/IvdQFW/ndDTURMlbvsPIuivT0RT+Ef4SeNubXb5A40ebUpSGKE8eUpa6drhaT2ptaAqbfSp/uedQf6Go3iRAC2E0S1gDb8hlA6gEThtlmJBqqzJTWEjm7z4CMGKbh8UFHgmZ3faiplgGhDB5cwgVokjPvc8Z2TC87YnAqEEfVTH5A76F9QBDFebbgdq3GwCMogfiX01/UYCyo6pzYXlpSkCQQOdGTu82+GvCp4jM+fah/HR5xc98ikyTd3iPHtoXao5gNK9b/pDVALPymiP7/he/Qwy0xZvWc6BA6P6Oh20sPs2LXSAXzMmufXYW4MLByaOwCUU4iNrYcnrI/iompK+Vq2DR8I3aKHEUr3qfx8LSNlw9IJhmv3VRmhYnvRCKLZpHozM8t7LkXINPCK0iUzmBtWXGunNLbl6rTA/0yvyZXEt93mOcuTDgHZyEs/m9yujOu7ptt7oHsLSAf0GvIFXg67P9bO3axTXMKrP85iLt1xUWjdzsacYfNLBfRoaBrrFZ5hdKy1A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(346002)(376002)(39860400002)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(336012)(426003)(2616005)(26005)(1076003)(16526019)(40460700003)(40480700001)(41300700001)(316002)(36860700001)(47076005)(70586007)(36756003)(54906003)(70206006)(6666004)(478600001)(7696005)(83380400001)(81166007)(82740400003)(356005)(5660300002)(44832011)(8676002)(2906002)(110136005)(8936002)(86362001)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:03:36.9329
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c974d36d-cf4d-468f-21d1-08dc26427c04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910

Consolidate all flush related code in one place so that its easy
to maintain.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/iommu.c | 92 ++++++++++++++++++---------------------
 1 file changed, 43 insertions(+), 49 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9c29540ab3a3..ae42b677480b 100644
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
@@ -2121,39 +2164,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
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
@@ -2752,22 +2762,6 @@ const struct iommu_ops amd_iommu_ops = {
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

