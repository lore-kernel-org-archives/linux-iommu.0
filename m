Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2072.outbound.protection.outlook.com [40.107.223.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E2DDDBF
	for <iommu@lists.linux.dev>; Tue,  8 Aug 2023 10:08:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMhmIvVkG3kAvLR16d11d9M163G5JfbRrIw/Oa4F1wDKe5BCJyo4ebn7vHj2hC7vHWqx00OUzIUQ7WwkOl4SqU3GzNuxtuK5/AHFoRq5Rj9r+8fYivttQcc3GLHsdliJAMVHtBeXawSe/aVQAbkvGDXekxz6ZDQL7upg4qZbUBtGr0iYmbgiTuKm41u30RiZDpv1aW8aTMjJNWG6boxu1cPCd/QIFIh/rwYP8McFnqJ0++io3ghLP6X/i3cx9Ts+YGEdsrg7tsAsjDRL/CCm/4DFBrRG24H7kwtU+tU1t8lWx+57yDUr/qHrdlM/wHdJqvIq+YGYVyjxnvkASOioag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y4pl1tKVgJMaZNNXvzGmg/RpfptL+Wdo0Tbmf7hKBc4=;
 b=YfXjjQEPzsCQ78iKGXSH6bKdCtQT3Q6rWiT4l8Hz0Hjy1FLCMSrEJJnESIIu+JtibyPMHGgru/QovEQhWT79VyNANfkf+VpCfuDbXk+bx34Eb5l7X/mSNXh6EI3DjsQ8+YO+BIqdqCtZdBO5NR4PZglChzJjsT7v21QocsCmE+gzQpsNwSIJLZtYhEg1KlhIkN3seg3EPPS8++teHmDXO9x0+7T05D19GopUNG3BCYUpgzKCwM97QKcalhynPswEPxADOliyWCNbftG97MJxhuviAxNkeWBfwho16w4RcO2H4/Q4F6UzeHw/OnhkDVJ5hygV1BK8iOHZCE03CED0ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y4pl1tKVgJMaZNNXvzGmg/RpfptL+Wdo0Tbmf7hKBc4=;
 b=mr+uhyOf070CNM1yT912SUcXRcbnYaBmn6xxIO8BaBKKPmL99lfcXq4CiPG7dqnp27BaaroY8oC57HYsaTyommeapm1ZeG9qB1gdDtbA4i0LxgLD+w3qoSknvlIADHwf9MrhiILrR/BAhD0h7Kgi6ti3k3OHhqKbjZEpq6Fm6jo=
Received: from SA9P221CA0018.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::23)
 by CH3PR12MB8935.namprd12.prod.outlook.com (2603:10b6:610:169::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 10:08:39 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::3e) by SA9P221CA0018.outlook.office365.com
 (2603:10b6:806:25::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27 via Frontend
 Transport; Tue, 8 Aug 2023 10:08:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Tue, 8 Aug 2023 10:08:42 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 8 Aug
 2023 05:08:39 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 10/11] iommu/amd/iommu_v2: Add support to switch default domain to SVA mode
Date: Tue, 8 Aug 2023 10:02:31 +0000
Message-ID: <20230808100232.5977-11-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230808100232.5977-1-vasant.hegde@amd.com>
References: <20230808100232.5977-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|CH3PR12MB8935:EE_
X-MS-Office365-Filtering-Correlation-Id: 5023e84d-1d7f-4b01-2cc0-08db97f771a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pGHbJAH1ysGZKfK0v1VN6t7AyQ75OJJK8VtmzkFIrg+CafFEAWt0tipyprLK5qQ7/ypboAlSB7VePBdhay/EOoYddtL6D4C+9k+jHCwzqcwnRlcmx1bkB8PupTRk0ulRlZ1BCbLiW2hOEkol6Ek+VG4NnmXMUTtKf/nKldgdtR58gdHmnutSNyMF5FHrkBKMvXUaWI39UOHlKOAI5K2AZfC4RXGfB96Wuzht5MVDbUXh1tdn8hzbyYA19YAdkmvnlf5yUY0MsQoL2QBuuR43O48ao/9XM6vMsE/zLNVu/XstogmkFRdte6+L6bQ+gw/79d78iUQfBRdgwxX2pcbDnCZ+KPq3oFxecTz6vPzBtteCpMn/lheWbFp8/j6BIBbT4Hwbv7jtDtTxrVxbEJB2vZLBtGUBkBSsHe4j5l0xxnYxlYZfZTtTPaLUyMLoK5E4CNJ47jmiJo6hcjacuMV8O57n+ELGPGQDqS32yyno8ITrK53x+XsGIn4qkqYIU7vCq5ZAo96MKgUQ2NgRRstT2x6XUgjAL78bFFS8vtMGkpBYMfXvKGPeGxC7QnbxOph7yFep/brRH6LGgkphhtOZ+EY3BWVXD5qaaqnB/QFiNNwI5X17PXs0kvN+2W76uIHoT8XaLkwJOS9YxSwV5eZeHxnIUK7NQiVzGbt3837oB7rC5YN+awGqg9XE3WCGrdcmsquRLc0UcNw8vyU320w1FUHXgP4KflSjSJJj2xfPHGxeTwhgflrU7WExb7TGLxKeBeZ45ewnSvVda7iy+ojVuA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(39860400002)(376002)(346002)(451199021)(186006)(1800799003)(82310400008)(40470700004)(36840700001)(46966006)(356005)(336012)(16526019)(478600001)(81166007)(86362001)(54906003)(110136005)(70586007)(4326008)(70206006)(316002)(7696005)(2616005)(82740400003)(6666004)(1076003)(26005)(40460700003)(426003)(41300700001)(2906002)(83380400001)(40480700001)(47076005)(36860700001)(36756003)(44832011)(5660300002)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 10:08:42.1536
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5023e84d-1d7f-4b01-2cc0-08db97f771a1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8935

Current iommu_v2 module allocates a secondary domain every time a
device driver calls amd_iommu_init_device(). Then it detaches all
devices in the group from the default domain, and reattaches to the
new domain. Finally it configures V2API mode.

Previous patch added support to switch same domain to SVA mode. Use
these new interfaces to enable SVA mode.

Note that even with this change, PASID is managed by device driver. This
imposes restriction where there can be only one SVA enabled device per
IOMMU group (same as current behaviour).

Finally remove unused functions.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 --
 drivers/iommu/amd/iommu.c     | 37 ----------------------
 drivers/iommu/amd/iommu_v2.c  | 59 +++++++----------------------------
 3 files changed, 12 insertions(+), 86 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index f5a9697488f8..2ec335ac0b1c 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -72,8 +72,6 @@ int amd_iommu_v2api_gcr3_uninit(struct pci_dev *pdev);
 
 int amd_iommu_register_ppr_notifier(struct notifier_block *nb);
 int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb);
-void amd_iommu_domain_direct_map(struct iommu_domain *dom);
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids);
 int amd_iommu_flush_page(struct protection_domain *domain, u32 pasid, u64 address);
 void amd_iommu_update_and_flush_device_table(struct protection_domain *domain);
 void amd_iommu_domain_update(struct protection_domain *domain);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b56d1e624cf6..77b87511e085 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2725,43 +2725,6 @@ int amd_iommu_unregister_ppr_notifier(struct notifier_block *nb)
 }
 EXPORT_SYMBOL(amd_iommu_unregister_ppr_notifier);
 
-void amd_iommu_domain_direct_map(struct iommu_domain *dom)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-
-	spin_lock_irqsave(&domain->lock, flags);
-
-	if (domain->iop.pgtbl_cfg.tlb)
-		free_io_pgtable_ops(&domain->iop.iop.ops);
-
-	spin_unlock_irqrestore(&domain->lock, flags);
-}
-EXPORT_SYMBOL(amd_iommu_domain_direct_map);
-
-int amd_iommu_domain_enable_v2(struct iommu_domain *dom, int pasids)
-{
-	struct protection_domain *pdom = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&pdom->lock, flags);
-
-	/*
-	 * Save us all sanity checks whether devices already in the
-	 * domain support IOMMUv2. Just force that the domain has no
-	 * devices attached when it is switched into IOMMUv2 mode.
-	 */
-	ret = -EBUSY;
-	if (pdom->dev_cnt > 0 || pdom->flags & PD_IOMMUV2_MASK)
-		goto out;
-
-out:
-	spin_unlock_irqrestore(&pdom->lock, flags);
-	return ret;
-}
-EXPORT_SYMBOL(amd_iommu_domain_enable_v2);
-
 static int __flush_pasid(struct protection_domain *domain, u32 pasid,
 			 u64 address, bool size)
 {
diff --git a/drivers/iommu/amd/iommu_v2.c b/drivers/iommu/amd/iommu_v2.c
index 8453b2d9d27b..f05bd9156c8d 100644
--- a/drivers/iommu/amd/iommu_v2.c
+++ b/drivers/iommu/amd/iommu_v2.c
@@ -111,9 +111,6 @@ static struct device_state *get_device_state(u32 sbdf)
 
 static void free_device_state(struct device_state *dev_state)
 {
-	struct iommu_group *group;
-	struct iommu_domain *domain = &dev_state->pdom->domain;
-
 	/* Get rid of any remaining pasid states */
 	free_pasid_states(dev_state);
 
@@ -123,20 +120,8 @@ static void free_device_state(struct device_state *dev_state)
 	 */
 	wait_event(dev_state->wq, !atomic_read(&dev_state->count));
 
-	/*
-	 * First detach device from domain - No more PRI requests will arrive
-	 * from that device after it is unbound from the IOMMUv2 domain.
-	 */
-	group = iommu_group_get(&dev_state->pdev->dev);
-	if (WARN_ON(!group))
-		return;
-
-	iommu_detach_group(domain, group);
-
-	iommu_group_put(group);
-
-	/* Everything is down now, free the IOMMUv2 domain */
-	iommu_domain_free(domain);
+	amd_iommu_v2api_gcr3_uninit(dev_state->pdev);
+	amd_iommu_v2api_domain_uninit(dev_state->pdom);
 
 	/* Finally get rid of the device-state */
 	kfree(dev_state);
@@ -735,9 +720,7 @@ EXPORT_SYMBOL(amd_iommu_unbind_pasid);
 
 int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 {
-	struct iommu_domain *domain;
 	struct device_state *dev_state;
-	struct iommu_group *group;
 	unsigned long flags;
 	int ret, tmp;
 	u32 sbdf;
@@ -774,6 +757,7 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	init_waitqueue_head(&dev_state->wq);
 	dev_state->pdev  = pdev;
 	dev_state->sbdf = sbdf;
+	dev_state->pdom = dev_data->domain;
 
 	tmp = pasids;
 	for (dev_state->pasid_levels = 0; (tmp - 1) & ~0x1ff; tmp >>= 9)
@@ -787,39 +771,20 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 	if (dev_state->states == NULL)
 		goto out_free_dev_state;
 
-	domain = iommu_domain_alloc(&pci_bus_type);
-	if (domain == NULL)
+	ret = amd_iommu_v2api_domain_init(dev_data->domain);
+	if (ret)
 		goto out_free_states;
 
-	/* Retrieve new protection_domain that has just been allocated */
-	dev_state->pdom = to_pdomain(domain);
-
-	/* See iommu_is_default_domain() */
-	domain->type = IOMMU_DOMAIN_IDENTITY;
-	amd_iommu_domain_direct_map(&dev_state->pdom->domain);
-
-	ret = amd_iommu_domain_enable_v2(domain, pasids);
+	ret = amd_iommu_v2api_gcr3_init(pdev, pasids);
 	if (ret)
-		goto out_free_domain;
-
-	group = iommu_group_get(&pdev->dev);
-	if (!group) {
-		ret = -EINVAL;
-		goto out_free_domain;
-	}
-
-	ret = iommu_attach_group(domain, group);
-	if (ret != 0)
-		goto out_drop_group;
-
-	iommu_group_put(group);
+		goto out_uninit_domain;
 
 	spin_lock_irqsave(&state_lock, flags);
 
 	if (__get_device_state(sbdf) != NULL) {
 		spin_unlock_irqrestore(&state_lock, flags);
 		ret = -EBUSY;
-		goto out_free_domain;
+		goto out_uninit_gcr3;
 	}
 
 	list_add_tail(&dev_state->list, &state_list);
@@ -828,11 +793,11 @@ int amd_iommu_init_device(struct pci_dev *pdev, int pasids)
 
 	return 0;
 
-out_drop_group:
-	iommu_group_put(group);
+out_uninit_gcr3:
+	amd_iommu_v2api_gcr3_uninit(dev_state->pdev);
 
-out_free_domain:
-	iommu_domain_free(domain);
+out_uninit_domain:
+	amd_iommu_v2api_domain_uninit(dev_state->pdom);
 
 out_free_states:
 	free_page((unsigned long)dev_state->states);
-- 
2.31.1

