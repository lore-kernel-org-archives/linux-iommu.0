Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646561FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:46:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cZiGvKhAnptEDU2gyZC/PJi9EuqsLFuhuyyaDUSaFk3dYdbHFDkHkj+EAMgRHY9MrY0FKBr/oOBWwEbcVt8J3MBXXanJBvLMVfTq/5IhukwmJ/MtXlnmp0QStv7y+B2n1YNgIELw8UveFsKwrg2KE6T5iT0bJGeVVyUiq5rQnghl69VkM6jhBX3lhsvsbp6GAYERMqugF75vStg7SE4pXZEsgbQhBNubTvjZ2lOOSIYbdWUh+BVoOr4qEmnzvU4xr5Zvw5xz/VWjfKXCgx3FbQh3sF4Y222JZl7fNJiCseaLEKAGkxFFalPJMDq40pZ4CvIrdGESVT0G7YGAIH5uyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEJ+epYMJ3VrpnuIrbGV4/FoEBGr51uHdhwY06Wngj0=;
 b=biD4k0COXCSjKrGwi3/pEStPXfhFcV8LB+ineQxsSOoXFF6q946IH+rHZv3vtI4O3LMAoMh309wtO8TBBFOLdYkjCqVhfXcRG1ApW3RZTgeITZPUlAkmeQcr+I15fqZCZJclOxewuskxwxUw+dEHEd0qH+gyeIFFSN0q4z76nQ9ZHstXjPMtuTkPLplz3Ur+itoOZuBKPaqdYvp9GrvMwlhPiYfRqev/VsLWWjNWDiCD5NnBoOTNfMt06Nlh3/0pLFmq67ZWbVGpwhaZvr4TBAiWNbepaWKcSBPvXVG1IS8Yjq93MqHH+phlsJZIUxCQI7ZupmVm9/DOGsFvG6kBDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEJ+epYMJ3VrpnuIrbGV4/FoEBGr51uHdhwY06Wngj0=;
 b=XdeR5Uzi0A8Iko+CsfKyrXUle3xgp4/AQsvEojmvQN3NnWKhWHGz9L17r8YR2YxkEu7zlQ3BmnyA20Svty3kggPFzIP/0CU7bLV1Xp9nBkJCk9WAzR4gZXu3H2NW3ds+q/wd8NAqAI5z8v0HrZw1OUZloMYDzPUJDav6ucQPjM8=
Received: from CY5PR20CA0026.namprd20.prod.outlook.com (2603:10b6:930:3::23)
 by DM4PR12MB6039.namprd12.prod.outlook.com (2603:10b6:8:aa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21; Fri, 4 Aug
 2023 06:46:28 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:930:3:cafe::4b) by CY5PR20CA0026.outlook.office365.com
 (2603:10b6:930:3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19 via Frontend
 Transport; Fri, 4 Aug 2023 06:46:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.143) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:46:27 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:46:17 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 12/16] iommu/amd: Add support for different types of PPR handler
Date: Fri, 4 Aug 2023 06:42:12 +0000
Message-ID: <20230804064216.835544-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230804064216.835544-1-vasant.hegde@amd.com>
References: <20230804064216.835544-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|DM4PR12MB6039:EE_
X-MS-Office365-Filtering-Correlation-Id: d2f80a51-84cb-409a-85b6-08db94b6875d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	J8gukHQB1in0PctV+o68Gnbhw6+ibEMZ+cisgy/mhI3vXqieZ/8pzzyxKE6i80bluqE5O7CU2kq3KPKb8slM3131tM50rnHxeKikj4ZwcmByXPO6G8DwcSqbFzUGlZWvjgOT9d+cFeM1YtpygFcIAw3QIfRJjplHAxWxIUlr0xn176bskndim73IDuveiLLd48YkxN4UjhfX7B64tZw+OC7fU5EvfWhIWBzhmjTq76xLlh9PGHsqwa0v0om+0Ht2Muurhx7PDsqBkeso4EP6+mw3Z1/neirrwg2UW/EGG7x22lz3WjOi7LCQ979WUYdgZhpwmlzSlCgZeNu625VjT7wp+WXj8EyG6f/Ol6QPny2VYS/oPZRLcgPCyoITbYNsa8FnXKEBGTzG9wVgqx0isFLSIqSUW17JdEQSHNzNuQrAEmNmhf9C/kdn0UoVhuWODUfVU2q9R6I8GMgdBtXWxSZ/LygESS6l8IwaCQIGLUgMUqoaMV318pMa7ahyGmjw2ZSCSqfstektF5Bi+R36t1u+fE/1M1htZVbm8QoIrhwKHWi5Xo2U85GXEQwHB8PSXPmyh+D2E/u+FaKK94Xk84KzfUrHIGNUfu6WAifjA5yiDY9UF0Uey9Jl0X1dAZZrJxRBMaxjg20V9ypusFBKSVwiV+S3EIiNLN4Z6cDmZhXJhZ3ERkCWZ3CqWia/jCm947eOK+9U27afGTbxVPuURDcFnWxJLt2zQeLvnZp9fMZVFh40QI8taubI6wui4D7yI5wVFEkeD4Rn1879S18Hmg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(346002)(396003)(376002)(82310400008)(451199021)(1800799003)(186006)(46966006)(40470700004)(36840700001)(81166007)(1076003)(26005)(356005)(82740400003)(336012)(16526019)(426003)(2616005)(36860700001)(47076005)(83380400001)(36756003)(2906002)(5660300002)(8936002)(8676002)(44832011)(110136005)(40460700003)(478600001)(86362001)(6666004)(54906003)(7696005)(40480700001)(316002)(41300700001)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:46:27.7975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2f80a51-84cb-409a-85b6-08db94b6875d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6039

From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

For AMD IOMMU, the PPR feature is needed to support IO page fault (IOPF).
PPR is enabled per PCI end-point device, and is configured by the PPR bit
in the IOMMU device table entry (i.e DTE[PPR]).

Currently, PPR is enabled for a device when it is initialized for AMD
IOMMU v2API. To support paging for IOPF, the DTE[PPR] bit needs to be
updated when enable/disable IOPF feature.

Introducing struct iommu_dev_data.ppr and enum ppr_handlers to track PPR
setting for each device.

Finally iommu_dev_data.ppr is set only when IOMMU supports PPR. Hence
remove redundant feature support check in set_dte_entry().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Co-developed-by: Vasant Hegde <vasant.hegde@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  6 ++++++
 drivers/iommu/amd/iommu.c           | 10 ++++------
 drivers/iommu/amd/iommu_v2.c        | 14 +++++++++++++-
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index b79c6e10684d..443b13b56235 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -803,6 +803,11 @@ struct devid_map {
 	bool cmd_line;
 };
 
+enum ppr_handlers {
+	PPR_HANDLER_NONE,	/* No handler specified */
+	PPR_HANDLER_V2API,	/* IOMMU v2 API ppr handler */
+};
+
 /*
  * This struct contains device specific data for the IOMMU
  */
@@ -820,6 +825,7 @@ struct iommu_dev_data {
 	u8 ats_enabled  :1;		  /* ATS state */
 	u8 pri_tlp      :1;		  /* PASID TLB required for
 					     PPR completions */
+	enum ppr_handlers ppr;
 	bool use_vapic;			  /* Enable device to use vapic mode */
 	bool defer_attach;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 5968eb8d265c..888bce5abe56 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1634,10 +1634,8 @@ static void set_dte_entry(struct amd_iommu *iommu, u16 devid,
 	if (ats)
 		flags |= DTE_FLAG_IOTLB;
 
-	if (ppr) {
-		if (iommu_feature(iommu, FEATURE_EPHSUP))
-			pte_root |= 1ULL << DEV_ENTRY_PPR;
-	}
+	if (ppr)
+		pte_root |= 1ULL << DEV_ENTRY_PPR;
 
 	if (domain->flags & PD_IOMMUV2_MASK) {
 		u64 gcr3 = iommu_virt_to_phys(domain->gcr3_tbl);
@@ -1730,7 +1728,7 @@ static void do_attach(struct iommu_dev_data *dev_data,
 
 	/* Update device table */
 	set_dte_entry(iommu, dev_data->devid, domain,
-		      ats, dev_data->iommu_v2);
+		      ats, dev_data->ppr);
 	clone_aliases(iommu, dev_data->dev);
 
 	device_flush_dte(dev_data);
@@ -2009,7 +2007,7 @@ static void update_device_table(struct protection_domain *domain)
 		if (!iommu)
 			continue;
 		set_dte_entry(iommu, dev_data->devid, domain,
-			      dev_data->ats_enabled, dev_data->iommu_v2);
+			      dev_data->ats_enabled, dev_data->ppr);
 		clone_aliases(iommu, dev_data->dev);
 	}
 }
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 9bf114382c00..4148cbf069dc 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -740,6 +740,10 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	unsigned long flags;
 	int ret, tmp;
 	u32 sbdf;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	if (!dev_data)
+		return -ENODEV;
 
 	might_sleep();
 
@@ -762,6 +766,9 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state == NULL)
 		return -ENOMEM;
 
+	/* Enable device for PPR support */
+	dev_data->ppr = PPR_HANDLER_V2API;
+
 	spin_lock_init(&dev_state->lock);
 	init_waitqueue_head(&dev_state->wq);
 	dev_state->pdev  = pdev;
@@ -832,6 +839,8 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 out_free_dev_state:
 	kfree(dev_state);
 
+	dev_data->ppr = PPR_HANDLER_NONE;
+
 	return ret;
 }
 EXPORT_SYMBOL(amd_iommu_init_device);
@@ -841,8 +850,9 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 	struct device_state *dev_state;
 	unsigned long flags;
 	u32 sbdf;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
-	if (!amd_iommu_v2_supported())
+	if (!dev_data || !amd_iommu_v2_supported())
 		return;
 
 	sbdf = get_pci_sbdf_id(pdev);
@@ -859,6 +869,8 @@ void amd_iommu_free_device(struct pci_dev *pdev)
 
 	spin_unlock_irqrestore(&state_lock, flags);
 
+	dev_data->ppr = PPR_HANDLER_NONE;
+
 	put_device_state(dev_state);
 	free_device_state(dev_state);
 }
-- 
2.31.1

