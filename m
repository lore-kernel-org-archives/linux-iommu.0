Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2064.outbound.protection.outlook.com [40.107.96.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402CF15C2
	for <iommu@lists.linux.dev>; Fri,  6 Oct 2023 10:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WeklPIF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f05LWzT6d+Q/Q4TzEyurCyH7npZhfx2hyXarVbwZeghtZhzW3Qm6Od1GW55ZBPz68cqRQgoQoJBj8i8WiEIZpE5fpT7HbqnFiKG76/vS6jYrvhHz0zNSgHSAM9mkVt09JmOFErfB7oOkhILned8/RZJARwE7USjjjNxq+7k71KGdzQHw8+QEMbhx41ADrdHIWddOnxaSi1fZOervaMiA9CfSBEeBQ/dA9zmdZ0ByFLLGGdx+F9jTr2312eyfCvhiZqZx3YEUKMkz+7YJteqCgwWFFKlERXQsUv9/c6HYq5E/rdahDWyHQgnXFuzBCWVWeTv9qa1+50eoxeSt8jJ41w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSpj17lzfvmxnYYq2iyRoH98noKo5oZOztyy9zM1l0=;
 b=KgKeUNNHhCbLj3lWM1QqlwsKuTElI4b9pnwco78WFjpu3L1UIyt3g4K1GzFxq8y+3xCOr+/HUH3tP8bYSXXd3EobPRPJZTrwcdqoZFp4u4FJ6aUxDADF2PORO13WJlQIol0XsWtSPY3HAnlVAQekLlVSkT8o2beBn3GjOyDRROfIQaUGXgb5oTssPPKvclEwOzNsI8rQnz2oPIlBR8VA8VVhkXRoy9B8JuffB9E5vT+CJ+d5N6cViFQ6v431N7ouAdc3jMp0kC//t8ZFjCyEmR2/jQw/n1b6LQVCIOoESLFmSFitrQDgtD7j1mxllI3UQ8WwFcS+QQGnK7OBav1fkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSpj17lzfvmxnYYq2iyRoH98noKo5oZOztyy9zM1l0=;
 b=WeklPIF3qdSM5tAsQHE0ybTyfXzqeKkCaVeUHCpvJAmlwL0MlIJY3tbagXA/6z2R56clNN92ksnFvDy8v1WSjqKnsIouVoc7cD4IgNRXc+OmDmaZJHspLuY9iXpN9cfcJ+eJVZZvGE2bhbKULboNDhMs9Hn1kQJg3xxYFouaFAI=
Received: from MW4P222CA0006.NAMP222.PROD.OUTLOOK.COM (2603:10b6:303:114::11)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.22; Fri, 6 Oct
 2023 10:20:22 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:303:114:cafe::4d) by MW4P222CA0006.outlook.office365.com
 (2603:10b6:303:114::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.33 via Frontend
 Transport; Fri, 6 Oct 2023 10:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Fri, 6 Oct 2023 10:20:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 6 Oct
 2023 05:20:19 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v1 13/13] iommu/amd: Rearrange device flush code
Date: Fri, 6 Oct 2023 10:16:24 +0000
Message-ID: <20231006101624.5912-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231006101624.5912-1-vasant.hegde@amd.com>
References: <20231006101624.5912-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ae285b-2bff-43d7-fadd-08dbc655d92c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jHDognxgBGdLD7BZJj6EQtF9ZIMCm/+wLtyIabpL+YZJ7UkttuzHOonPvlpFuFATDEMZPAeE+5Q5+Bs2KisvFFEgoVn5D63mN44ruqKH8YgzHIfWOnhASKUxwNIkC66xWrHQLVoPcyKNBGfffPxjyfAh3TJb4cutcKcsBdGfnqe6EFOwqe3MGi8w39Xw9snoW71UHylvB0EnF/12e0jnYPYz+C/aCQS9Or9j/QVfQctbxqINyEyq0gL8VgqAoZXxCO34zTbl117wBXwjbrNzlBMveiSemhtg5d/qAgQGnmi6kTHOeVho4xb77QBIfOTdRSchdKqU6/aPj9GWyyaki/S7IzUCVTDJn4O6ygVr+tIvN4H8mB94ZQqXRyGFOZUw3JQtrZ3HBHt/SYhdOsJ7WJ3mhR2p1kN3YYSsD1l/VUa0onxaGkGNHwedn7yarile2QnKU9fbz412KenXKwY5Ova/tLO3r7064/+Nor4a60RQD6Wfiq5hkjacohMhIsdF6Fpz6D4Synaq3Al4a7iIS2gd/t0FMDkQBx6vF3dyuPI5Kiyza5cah0lEinR76ulT/Z6XMoo4ZHDjsXBOm4mPViW+JRDZUvYYaVW0sSG+wHt5bna1W6/tZHKhJZomFwYU1bk4W0441STWicyq3+gNsSdkzxN/Ot+f1gQ+EQl9kJoaqd1gfjlSJ3eMIz6sBHfyq+JxhAMAM2bSFIMjQ7D6gGxARr77rBhprBBJZrqH++W0vRms997dOTfiTmOnuxyVJpSeCylwa5sNhEilL8qipw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(376002)(39860400002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(82310400011)(46966006)(36840700001)(40470700004)(356005)(426003)(336012)(40480700001)(1076003)(6666004)(40460700003)(16526019)(54906003)(2906002)(70586007)(8676002)(44832011)(316002)(83380400001)(110136005)(41300700001)(4326008)(82740400003)(8936002)(70206006)(478600001)(81166007)(26005)(5660300002)(36860700001)(47076005)(7696005)(2616005)(36756003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2023 10:20:21.9618
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ae285b-2bff-43d7-fadd-08dbc655d92c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

Consolidate all flush related code in one place so that its easy
to mantain.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 105 ++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 54 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index fca1f969845d..2e90f7807168 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -77,6 +77,9 @@ struct kmem_cache *amd_iommu_irq_cache;
 
 static void detach_device(struct device *dev);
 
+static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
+			  struct protection_domain *domain, bool ats, bool ppr);
+
 /****************************************************************************
  *
  * Helper functions
@@ -1636,6 +1639,54 @@ static void domain_flush_devices(struct protection_domain *domain)
 		device_flush_dte(dev_data);
 }
 
+static void update_device_table(struct protection_domain *domain)
+{
+	struct iommu_dev_data *dev_data;
+
+	list_for_each_entry(dev_data, &domain->dev_list, list) {
+		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
+
+		if (!iommu)
+			continue;
+		set_dte_entry(iommu, dev_data->devid, domain,
+			      dev_data->ats_enabled, dev_data->ppr);
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
+	iommu    = rlookup_amd_iommu(&pdev->dev);
+	if (!iommu)
+		return -ENODEV;
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
@@ -2039,42 +2090,6 @@ static struct iommu_group *amd_iommu_device_group(struct device *dev)
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
-		struct amd_iommu *iommu = rlookup_amd_iommu(dev_data->dev);
-
-		if (!iommu)
-			continue;
-		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->ppr);
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
@@ -2646,24 +2661,6 @@ int amd_iommu_domain_clear_gcr3(struct iommu_domain *dom, u32 pasid)
 	return ret;
 }
 
-int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
-			   int status, int tag)
-{
-	struct iommu_dev_data *dev_data;
-	struct amd_iommu *iommu;
-	struct iommu_cmd cmd;
-
-	dev_data = dev_iommu_priv_get(&pdev->dev);
-	iommu    = rlookup_amd_iommu(&pdev->dev);
-	if (!iommu)
-		return -ENODEV;
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

