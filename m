Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C20C100AE
	for <iommu@lists.linux.dev>; Wed, 12 Jul 2023 14:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQbptR86rX4/rKx65VtdXCWrMe5QW0ZlYvr/miXejqf6j91Duiy7MFhM9zDcBVx6vKJdL6h+45inBIuKWFC4QtIO2yeRCALtjgNphy6z98gaaNcoTRCj1QOs0LsOiEIC/yeaVOWYM9flrWWM/Bhu+KE6RjwTMHIcly5XzudsIq7L86QPUvIjCix4sOKb/rdL+Dz+CiwxF+0ZXC/APTNOauHnu+iFUX6LDb1fEFLD89E19IVH8Ni05Q7G5NHGl1Sr7W+cpQBpEk2+/Mvgb3+RT1LuSVqzziCWydcp3VPOsp4Hlx57OTTk5kZEzkro7r5Pl+OptDjM8rGdiz7tt/6e2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZBe6OHvf2MRWwcTCh+s1WHBV46iN3vXKEI+pi5IJ2pg=;
 b=iKGj2gN6/e3fuWzAprAlXxIZHmuDBXfBSR7Q/I04Lh6udHqRd3zYSQoYO3EyBKR4j3BNWHysE6DjRJXVKvR/dX4ygor5cafPjJOwU0wztoM5kji6l7k4z6P+oOX88mpKA0w7+MlRZjYBQzVV6e1o5+OiJuowQKhISf1GnOOJ/1Bfxhtzo2+02V9L3NQbn2mQlYhHC+Le1s1Pu/tiIhcxdwzU3hzr9CnuEBJ2Bic9zZ1n1r8WXNLmJwINzO844zuvfOusy8wM7IvpUnXzDuQmYtNLHiR2TX4LgHU7z2cY9BJORKGJuQtDUD6N99eDQAPWmVKiu7/YGO5W8nhYA5Kg2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZBe6OHvf2MRWwcTCh+s1WHBV46iN3vXKEI+pi5IJ2pg=;
 b=bJHVmLYlGklWRWEfBzWH2noRrgYWspCv8tje23pO7m5owNbRzrZ4DqcbJ+ZnQHZvSHhZhOiFveON8Ux+weN9tvUFqmY7vMOb6bAsZYUJ9jD8Qp8YyAkvsh/4ExZEXmwJ54KdPW8udHPMC/zI3Ekw3V2H7a++QEXJHQP/Gj0BiXU=
Received: from DM6PR03CA0033.namprd03.prod.outlook.com (2603:10b6:5:40::46) by
 CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.22; Wed, 12 Jul
 2023 14:17:10 +0000
Received: from DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::1c) by DM6PR03CA0033.outlook.office365.com
 (2603:10b6:5:40::46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.20 via Frontend
 Transport; Wed, 12 Jul 2023 14:17:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT006.mail.protection.outlook.com (10.13.173.104) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.20 via Frontend Transport; Wed, 12 Jul 2023 14:17:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 12 Jul
 2023 09:17:06 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 05/21] iommu/amd/iommu_v2: Use protection_domain in struct device_state
Date: Wed, 12 Jul 2023 14:15:00 +0000
Message-ID: <20230712141516.154144-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712141516.154144-1-vasant.hegde@amd.com>
References: <20230712141516.154144-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT006:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 13b52c9e-51ee-459a-05cd-08db82e2ae8a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Z56FOUcTcWJZ45YoCOth6x5OSZ9MbIPobIAXFshnuKVzZmgf18faIWTl7y4z9cpI40gGOHd8ITUSDvWPqAr0XvMkSepR/E5Yb+uLlJVnS2vMxaIqiYHp8R6jidBOy5zhzToE1CXJYJ9dYeRHLTrs7vsONprYTp11zt3CRMd8k7+fxVohlKWXMwz2M7Qkr/yD4etBr7DDzA3d9qwb5fiPrejyDFyWZwIjC7tXrYOZZGGaWvMAXhXZmoVGMNJCreGGvjJssR1LsISJ2HSyUC5ntn6SOt/R0y7OlHhazEDOv/AcWNA1vwm2DbtfOZP8Js4IYcJvWmIZetCPyFVipMERe/eEa5hj/BnLHbemd4wDn8MY4A6teRW96PIb0yD2BTHomuEAF79Hn3iIm/fhaxxpCC5ALisAMbxdnHn+SZKP9dvQV/LqJT1P04eyvwW+WTgoCuT7PnWO6Rwb1GggcJOCuqs0mjVsBFWELqaoiKcbWI58embcZ/t9cg88PynfoXm/F7/0lEHYZN43dRNo2Q1cLEJ/2QRlKjfO/LF2DsIMHsuD1lLxr8VJCw9tPlRs4R61uufQER6dMouaL5LVtLqy53+Nm385G0okkaiFuCUYIs7vm3Y7mlmOromiOPlIH9LAbQF2fNyD2c6RSx+zCxk6W9pgphDLquDQFoF++6Uy8kyOSyDQ7VdvQvXHVSmJzgo5guMHiTpe+pB8mqD/amLLAut8dNe4vziO4Pd8a5l8QYcR6tLkHwTH+Z3KKo/oBwysjUSWZLwlU+XPwdein3zj2w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(346002)(376002)(39860400002)(136003)(451199021)(36840700001)(40470700004)(46966006)(478600001)(6666004)(54906003)(110136005)(7696005)(4326008)(70206006)(70586007)(316002)(40460700003)(41300700001)(82740400003)(356005)(40480700001)(81166007)(336012)(186003)(2616005)(16526019)(2906002)(44832011)(8676002)(8936002)(1076003)(26005)(36756003)(5660300002)(86362001)(83380400001)(36860700001)(47076005)(426003)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 14:17:10.4620
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13b52c9e-51ee-459a-05cd-08db82e2ae8a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM6NAM11FT006.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

Replace struct iommu_domain with struct protection_domain to simplify code
since the protection_domain contains AMD IOMMU specific information.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 38 ++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 261352a23271..e4507a211d6b 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -55,7 +55,7 @@ struct device_state {
 	atomic_t count;
 	struct pci_dev *pdev;
 	struct pasid_state **states;
-	struct iommu_domain *domain;
+	struct protection_domain *pdom;
 	int pasid_levels;
 	int max_pasids;
 	amd_iommu_invalid_ppr_cb inv_ppr_cb;
@@ -112,6 +112,7 @@ static struct device_state *get_device_state(u32 sbdf)
 static void free_device_state(struct device_state *dev_state)
 {
 	struct iommu_group *group;
+	struct iommu_domain *domain = &dev_state->pdom->domain;
 
 	/* Get rid of any remaining pasid states */
 	free_pasid_states(dev_state);
@@ -130,12 +131,12 @@ static void free_device_state(struct device_state *dev_state)
 	if (WARN_ON(!group))
 		return;
 
-	iommu_detach_group(dev_state->domain, group);
+	iommu_detach_group(domain, group);
 
 	iommu_group_put(group);
 
 	/* Everything is down now, free the IOMMUv2 domain */
-	iommu_domain_free(dev_state->domain);
+	iommu_domain_free(domain);
 
 	/* Finally get rid of the device-state */
 	kfree(dev_state);
@@ -269,9 +270,7 @@ static void put_pasid_state_wait(struct pasid_state *pasid_state)
 
 static void unbind_pasid(struct pasid_state *pasid_state)
 {
-	struct iommu_domain *domain;
-
-	domain = pasid_state->device_state->domain;
+	struct device_state *dev_state = pasid_state->device_state;
 
 	/*
 	 * Mark pasid_state as invalid, no more faults will we added to the
@@ -283,7 +282,7 @@ static void unbind_pasid(struct pasid_state *pasid_state)
 	smp_wmb();
 
 	/* After this the device/pasid can't access the mm anymore */
-	amd_iommu_domain_clear_gcr3(domain, pasid_state->pasid);
+	amd_iommu_domain_clear_gcr3(&dev_state->pdom->domain, pasid_state->pasid);
 
 	/* Make sure no more pending faults are in the queue */
 	flush_workqueue(iommu_wq);
@@ -366,10 +365,10 @@ static void mn_invalidate_range(struct mmu_notifier *mn,
 	dev_state   = pasid_state->device_state;
 
 	if ((start ^ (end - 1)) < PAGE_SIZE)
-		amd_iommu_flush_page(dev_state->domain, pasid_state->pasid,
+		amd_iommu_flush_page(&dev_state->pdom->domain, pasid_state->pasid,
 				     start);
 	else
-		amd_iommu_flush_tlb(dev_state->domain, pasid_state->pasid);
+		amd_iommu_flush_tlb(&dev_state->pdom->domain, pasid_state->pasid);
 }
 
 static void mn_release(struct mmu_notifier *mn, struct mm_struct *mm)
@@ -648,7 +647,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
-	ret = amd_iommu_domain_set_gcr3(dev_state->domain, pasid,
+	ret = amd_iommu_domain_set_gcr3(&dev_state->pdom->domain, pasid,
 					__pa(pasid_state->mm->pgd));
 	if (ret)
 		goto out_clear_state;
@@ -732,6 +731,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
 
 int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 {
+	struct iommu_domain *domain;
 	struct device_state *dev_state;
 	struct iommu_group *group;
 	unsigned long flags;
@@ -776,15 +776,19 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state->states == NULL)
 		goto out_free_dev_state;
 
-	dev_state->domain = iommu_domain_alloc(&pci_bus_type);
-	if (dev_state->domain == NULL)
+	domain = iommu_domain_alloc(&pci_bus_type);
+	if (domain == NULL)
 		goto out_free_states;
 
+	/* Retrieve new protection_domain that has just been allocated */
+	dev_state->pdom = container_of(domain,
+				       struct protection_domain, domain);
+
 	/* See iommu_is_default_domain() */
-	dev_state->domain->type = IOMMU_DOMAIN_IDENTITY;
-	amd_iommu_domain_direct_map(dev_state->domain);
+	domain->type = IOMMU_DOMAIN_IDENTITY;
+	amd_iommu_domain_direct_map(&dev_state->pdom->domain);
 
-	ret = amd_iommu_domain_enable_v2(dev_state->domain, pasids);
+	ret = amd_iommu_domain_enable_v2(domain, pasids);
 	if (ret)
 		goto out_free_domain;
 
@@ -794,7 +798,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 		goto out_free_domain;
 	}
 
-	ret = iommu_attach_group(dev_state->domain, group);
+	ret = iommu_attach_group(domain, group);
 	if (ret != 0)
 		goto out_drop_group;
 
@@ -818,7 +822,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	iommu_group_put(group);
 
 out_free_domain:
-	iommu_domain_free(dev_state->domain);
+	iommu_domain_free(domain);
 
 out_free_states:
 	free_page((unsigned long)dev_state->states);
-- 
2.31.1

