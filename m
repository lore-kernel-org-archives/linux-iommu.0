Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB6D1FC8
	for <iommu@lists.linux.dev>; Fri,  4 Aug 2023 06:44:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a8YIaBDNKGz0UPKhKXWmeHE9dJ9dLTBZVp8rkCUStcV7raz4JDLxiAgdwd18PfIAumceI/irItLOw2Wh1lp4Iyr09ZbGkfhixubavD8pkTzzwSh6+GBZ/32O9Y8R3M4hNiWj16Sl0Ei2Snm1oDS1vEBb/kxnG0t5WO3Ynt41nPIb6wfhpr4fI4gDhkq8gVvKU2PZXYpEPmjdbmgOqJxOFkKV2yV2nXQ3lnWG7re6xTEAAvN4Byf05tpKsyBHsA7TGE/JZVl9K5cyyPPKx9+IHO1033JGG5IV1y6BKznS2WpeG05aMWFmGJS3KCG+d+V6hMXY848P7c2LZ4bhkd1ZzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ue4rNNve17OL8t61UWTezxUTlqbKYhitz62fgqw5L2c=;
 b=ETURhCYLwQWrSj/aTJ4Qwqvchdye6Zjz7pMjEdA+f2Z7agXKfbaH9/kk9iR/7YjcMOPaAiX8ueW/HgwIrIpHmD69AUL4NpsaSiE5/Phv4K/YsICuNoZIHbHvZf2MKBoBpGSelFUhkCkbg4t4w5OAaKs2zM9EwExTjuF9yqO0iwEv1V14SwjSJTY/AgQ6jfkA4k50+F2d8T9jhbhgzwKG2I5QyOPADpgxvL/nlaySGin181OMYP2Kcz9GgqGVU9m5d9pjesk5pgSjCNFKms5wpSSjGrAs49sWfkH+1Z4+EE8EZOyDXpZn+bzSthtFfCbgB7O15e0Y15v6z0uF1MoGVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ue4rNNve17OL8t61UWTezxUTlqbKYhitz62fgqw5L2c=;
 b=F/p0QmgGqXhdQEdD4Aax4gDA4Ie9n458z2PgflBal4Q7UERBmTbB9JuqQj3YpyVaHYcoDnuJqJa6vdV9OUuwMzVtxSiFfpBhZoyfc8fn0WSx5kmTSfs/S8X0qM3x701jCQJpvV3VVgT0cB/igRTbgwrOYlzH+XaitvKH4ynRtYU=
Received: from CY5PR15CA0227.namprd15.prod.outlook.com (2603:10b6:930:88::25)
 by MW3PR12MB4443.namprd12.prod.outlook.com (2603:10b6:303:2d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.20; Fri, 4 Aug
 2023 06:44:10 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:88:cafe::7) by CY5PR15CA0227.outlook.office365.com
 (2603:10b6:930:88::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 06:44:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.141) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 06:44:10 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 01:44:04 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v3 05/16] iommu/amd/iommu_v2: Use protection_domain in struct device_state
Date: Fri, 4 Aug 2023 06:42:05 +0000
Message-ID: <20230804064216.835544-6-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|MW3PR12MB4443:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e33d94f-4a2b-48c4-99f4-08db94b6356e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IdYrvtmzMUpVT0DMc38xk2elzqGQoYTIVlw5BJ6+OVl6R3XvmvxbSYwgh0tZO9PUVVTKsWXiGDeUXeRhoERwcIz/hIRXoCMj1TsZXdVcNEA+d4LUcZ4ZA+zvIN3wLh+TYgd+phygZdE7I4XH45XDcoHjWHTtJtZuimruQqGZ5sUAx48+8LEWFvH6gKpoGv0lbdP33H98/5nygcKe6pPiv59bUvAMBf7iLc1vJghrAPDnlh8TxmUYdXLA5FsGeUjXgwlX30P+twoJmAXOxS6eSxjSFjH93Rm9RngOeCkICihT+fLhugkO/mLko0A4jbi7ufGW7Gok0sbY7HmH3RVvjs+k8ThuE3dsWlIIkAojPgI5SXqHZjR+AF255kDsBlgkwR66RwXM3W3NiTL6peybm9j5SXbFIhs80AxQaGOvwPIhQADmby+9ndezxrfku4EEsJ2uzww+drASsP9SL8tYUP4+w99esiD0udMtGjMj9XNLGf8nagYSgeBomx6OfnI8V1EbLC8OJMLGmcPoja5rGXzGs755c2CUUcQ7QCrwGIYJQngvnBAmUUTw+M6GAYXnaHE0kcrqI0B1DtjByhd53AubtN/46TL7056McbhzNPksKC1/TsSa/GkXxjlj8KPJgQySBww/eHaY+bIVZ6XIGl8XlFLQyuqfETvL+XANXjdpDrOaUOa1qD22vSX+TDxiQGqXc2PXzw9dapXgLDSp+DyKMcar+B3KsKaSkC9hpFX2VpVoRpcgMxtKOpLYmIy0X6w9WrOvzksh55E0Kh4F/w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(346002)(136003)(376002)(82310400008)(451199021)(1800799003)(186006)(36840700001)(40470700004)(46966006)(40480700001)(40460700003)(7696005)(82740400003)(70586007)(70206006)(4326008)(316002)(54906003)(478600001)(41300700001)(5660300002)(110136005)(83380400001)(36860700001)(16526019)(426003)(1076003)(336012)(2616005)(26005)(47076005)(81166007)(356005)(2906002)(36756003)(8676002)(86362001)(8936002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 06:44:10.3362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e33d94f-4a2b-48c4-99f4-08db94b6356e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4443

Replace struct iommu_domain with struct protection_domain to simplify code
since the protection_domain contains AMD IOMMU specific information.

No functional changes intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
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

