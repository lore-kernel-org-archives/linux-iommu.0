Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2076.outbound.protection.outlook.com [40.107.94.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499B423AE
	for <iommu@lists.linux.dev>; Fri, 28 Jul 2023 05:38:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKk6nNfbRFQSoXq5HwRUU41qVoLrpAKL7CkSUOe7V8tChTX/H74/k+RCE0LqKkzo+DzzR5mIfYXOts3qE/sONI649O4tX/MDdBd+8qKtbo8R+eQugn6YxFajJYURpgjKZdAMjgZE6mdcM4dVuy04HQimjpu0Lc1fZfhxmBhIWs+bXZKmC6gatD0K8BRhXCZTKxoKCSV59rSRHv4psuAMKb6eiLwMZnwskqCi8yVoTffhKrZuSA+5ULNDtvBcHVdapPxue02CAyTS6X/mvvoSU0YQSJ7Sj+uR3i3d90DtRoHarR/jU3zrrDGHmdQuLAONCGwZKMtZEZBvcWKe4kG99w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JGQQrAO7S9b9HMAsSgnDH1V0KZv2NqsTTnCPSw92gds=;
 b=X6ZRZtXSHZeD+bkh3YP8sKEecpuL+BlOizLqnu290oYU9oYJnvU0n3CYHRpYeQ2c0Fho73XGRrzbV+VmM0bL7U/d77WYbxVLHNbZqNCWm+qjPOHRds6M/qUIX24TfAUHdDO4J6/wcK0TTPb+5yRLuuoT2nx+XYtsPdX+58QLS6A7Z0+aTokVwPSzf7Idsk/My0vEnlk+zMdjPVT4Nnxjseyjxa3LUOCa+vEcxCVSsVhg0tN+Il7YqZrxqPnScWrF+y6SiM05NlKH+2D9BLkKTpAx7IhdnBfT60Bir9qIItFEqwlE5Owx4NhgPUIxtLWfKKwaLV+XY2dlN3KVUJLP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JGQQrAO7S9b9HMAsSgnDH1V0KZv2NqsTTnCPSw92gds=;
 b=z0Tm31xPQ3EKO5YcTK4jzX2UWl/RBLwJWwj+OUqr7BxEQcWt+TTR1dq6icMJpQ38TBjQeZ3Q5+rym8umNGTmL8QkmJwTYLM5xnee5HQWTBNhK07GwBIFWCD24BHV2mYQiZ0Nimy4qFKYejZUCPgsOnFcO6EfjQp0ln/ISuKJZ2Q=
Received: from MW4PR04CA0170.namprd04.prod.outlook.com (2603:10b6:303:85::25)
 by DS7PR12MB5909.namprd12.prod.outlook.com (2603:10b6:8:7a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 05:37:59 +0000
Received: from CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::e1) by MW4PR04CA0170.outlook.office365.com
 (2603:10b6:303:85::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 05:37:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT098.mail.protection.outlook.com (10.13.174.207) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Fri, 28 Jul 2023 05:37:58 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 00:37:55 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v2 05/16] iommu/amd/iommu_v2: Use protection_domain in struct device_state
Date: Fri, 28 Jul 2023 05:35:58 +0000
Message-ID: <20230728053609.165183-6-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230728053609.165183-1-vasant.hegde@amd.com>
References: <20230728053609.165183-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT098:EE_|DS7PR12MB5909:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c4fbe32-8f99-46f0-d85d-08db8f2ccd57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	M6j14WPmJvAVDsocuYxtRZ3jCaY7v2wfs7yOe1eSJy6wxT2ubFx6jwP9PA6XTRnGpjfF87CIt+WBU+NO0rAHtCtp5gCQvHQv7obJRNpO0u3kEeRS2sFiu77kguT9IhtA6b+p1vX800QBuw/+eBLVxkxBLHzRB//Krx4vBHo03prgfhf8mAWtB9NZugF0P4CEfhICISEhgGt4LhuXHP1oAEPshBvChfrkts0nPcWbnK9L1PbRY+p7bfkk05uY+YHvZLm+9jDnGrssqIiaWlJbdCgmEoZhg/Zh5oxrtq6lCaW0hhE6uCFOuk+c8W3m31IvsRaLRk0W0k54TwkFqW7J/B5UxMhRNgaedJWggYTxlK3H1H8NIwJ/A1Pg1tO9FgVghDvzcbXxwqsonLDC+BULDzYD3e0PQ0+N1f3SXa4HdS0+UudYGKyWRyE0YYa8GM6R6I2ib858RIyIMJc8PgBiuGfdOSC5+jA/wMLoDOfOgqZAYCvyGpBNzkk2m9cgRrCkQw2Hf9O2fonu9yUX7OOaXTCxtzplJAiLzRUxclulA2Syzrk+qeWMEV0Dq9rOYH+/5Zq0XIKEoeHxpHuIAWasIAZiqOa5LLSB13yb5sTYhwdq7eH4ladkfJadfzth+v2lSLaWZA7mLHk79+cbASp6pP65tNjv2PC66TXyps5HleAJo3hdwTVljqcX+e7nwgE6ZsIfI6uDny8to0VrFUeh4hz2BQhaPwzKaEzYPnzELzkKzuChZ8f6QW5Le6w8nL1sglPulDPtQ/Uqnb09XMXwYA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(376002)(346002)(39860400002)(136003)(396003)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(83380400001)(47076005)(40460700003)(36756003)(426003)(2906002)(36860700001)(86362001)(2616005)(40480700001)(356005)(81166007)(82740400003)(41300700001)(316002)(4326008)(26005)(1076003)(8676002)(8936002)(54906003)(110136005)(7696005)(478600001)(70206006)(70586007)(44832011)(336012)(186003)(16526019)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 05:37:58.8070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c4fbe32-8f99-46f0-d85d-08db8f2ccd57
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5909

Replace struct iommu_domain with struct protection_domain to simplify code
since the protection_domain contains AMD IOMMU specific information.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu_v2.c | 38 ++++++++++++++++++++----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index c5825e0a6770..6a423928d5b5 100644
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
@@ -369,10 +368,10 @@ static void mn_invalidate_range(struct mmu_notifier *mn,
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
@@ -651,7 +650,7 @@ int amd_iommu_bind_pasid(struct pci_dev *pdev, u32 pasid,
 	if (ret)
 		goto out_unregister;
 
-	ret = amd_iommu_domain_set_gcr3(dev_state->domain, pasid,
+	ret = amd_iommu_domain_set_gcr3(&dev_state->pdom->domain, pasid,
 					__pa(pasid_state->mm->pgd));
 	if (ret)
 		goto out_clear_state;
@@ -735,6 +734,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
 
 int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 {
+	struct iommu_domain *domain;
 	struct device_state *dev_state;
 	struct iommu_group *group;
 	unsigned long flags;
@@ -779,15 +779,19 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
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
 
@@ -797,7 +801,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 		goto out_free_domain;
 	}
 
-	ret = iommu_attach_group(dev_state->domain, group);
+	ret = iommu_attach_group(domain, group);
 	if (ret != 0)
 		goto out_drop_group;
 
@@ -821,7 +825,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	iommu_group_put(group);
 
 out_free_domain:
-	iommu_domain_free(dev_state->domain);
+	iommu_domain_free(domain);
 
 out_free_states:
 	free_page((unsigned long)dev_state->states);
-- 
2.31.1

