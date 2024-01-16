Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5541A1C6A1
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 16:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="N5huA4+B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9GhG9/MTMr8ycFLATh4XUxJ5ucFLzbaRv4oEBm/ntgVjGX+O4VacbRtDRAM6/YeTDjre7bH72V0CymF1GqJe1nil9vz4JVqlMLLjKyoxWKk//uU2sbcVnKkzmUc3r8n/reSPgW7Gjcu+AotmP5VnnXVj8MengF6uzQm7UkHznxPrIAFB7jkwOUUDZmVrb9nv3tpkhfgiUS4jLAlFvINe02mHRF6M2eJELuozs5ZuzM9w7lr7h1lSxOvWmZCfS2JcU1JZbW70wv9vUlh9f2Qd9PExUAgvi4NgdJgw1z1g2Qtb8seTQmkIBpGdklEVfaBfdfZnr5zrcCMSWjwz4OYNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b3/Pb7DQiy9yfs5RJq2yHvP7FL1H9/Tv4BRRV5MrExs=;
 b=A1oZgcLPEaDbISGRjp1sLCUcfFTJginGDuEuTO+5oOdMzkJAaRGteKRusmIIxWUwb0fJo/tnCns0qKtvz6JkKJz9ivKGCEfLfinyEC0zAq61Tjk5pRvZVSx0sMUJkLE5eEndLki7tATiYGxiekYEztcFlxLcc3c9SaIz5aMAGKhoKLneUxC76u3s9G2unZSBZj+ctNk4jiZ+JoVBL0FmdDAP3A0z2EuOya+JNVoL3SUhspSuKL+LhdN/LjLGlR0KFs1QIcOjNOIXFlk15mlo95DEhLl3erDHeVkfNyD8r1c+czIxa7oFp0WFQwOeIhzjx190FrQkd/um9Q385rEV7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b3/Pb7DQiy9yfs5RJq2yHvP7FL1H9/Tv4BRRV5MrExs=;
 b=N5huA4+BVMYu/4VV33uJBb3NnA2RVvtOfwnHrXY53ZTcbBxKvaKWRoOXU9IMn9Jx1t2EQpagXuktoAgPgeikvd1YprqrFlGDYjtvM6xuq4VcCS07MXqTNsbrp4BBgVxpSRmUbUaD4umb4f6lE0rzTJWeOwKE22a2xk+q7V6+YGs=
Received: from BL1PR13CA0419.namprd13.prod.outlook.com (2603:10b6:208:2c2::34)
 by DS0PR12MB7533.namprd12.prod.outlook.com (2603:10b6:8:132::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 16:57:53 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:2c2:cafe::af) by BL1PR13CA0419.outlook.office365.com
 (2603:10b6:208:2c2::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.22 via Frontend
 Transport; Tue, 16 Jan 2024 16:57:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Tue, 16 Jan 2024 16:57:53 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 16 Jan
 2024 10:57:51 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v5 15/17] iommu/amd: Remove unused flush pasid functions
Date: Tue, 16 Jan 2024 16:53:33 +0000
Message-ID: <20240116165335.6043-16-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|DS0PR12MB7533:EE_
X-MS-Office365-Filtering-Correlation-Id: 5be3ace5-e9a2-40d0-2694-08dc16b4480e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tY1XT71RalgY8h8zkif2qQ6N8kakOvw2u9gCWPyCDRroQhO3467fGjWWUhtDhk37rzSJlUr1W45wddcLQ7q6+0Chrdyfwi9v4C2BCOJosP5NOBjdQhlaVDup9djTbqOSG5Fg4NngxRzL8sIYMSs6vLsJyn9jV6hutJCdmBrA40Bfs22/yKOavFhcDj/52BOpiZBqF0IZzoakCwZ/zAb9Yzm9Bntz+md9M3AeH3d/2u6pW0gjRnuTYlwoTM8sd0mszaUKoxp1LAk5BaPtCVYrctFhlktUKgCjhZHKr+vf2rJWWA8j8NPb73Ae0YAIHKZueZAGWd5NPg5YtiWWeIVLHmJt5F6bhm53TlJMUgpHxc1wN9ZQi4ZfMUd45IvL47/ejDemPP0iEwH9VCtKBMGfx395y+C7qcI4cSAY53pSka8m6kscsHCytmpHyZbnEq/B0Gc0/zRc0MLxwxIOMhsbT0nF7leFxfVjv0P79Ot8RqcJ+X6i/Azy0GE4RdmMTPrVTMibIzVicdmUMzGyShwc6Vvuw/SMkRWJVTDkYMn3z6m8KegTZ7i6tb8fBXjN7br9tdkUHicYE2DY0wrfm6rtclKmBbxiRyfnL29N0AnO5YDD43WiUXfxqQ+ZCqU2Z7o4sgLGR4DM5Jv759ArV4oh8p6ipKrfJeprVyj/49OdInX4wG4BwSvYboa7S7BqempltVmzktMN0ZJo/cyEStZOW/id/KO7ku/cq4+pcDNVbrweZq7hnzEcr3oEy37DorTF5wzTbosZbTtAI82BFQjySw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(82310400011)(186009)(46966006)(40470700004)(36840700001)(40460700003)(40480700001)(26005)(426003)(336012)(2616005)(82740400003)(81166007)(1076003)(356005)(86362001)(36756003)(2906002)(83380400001)(5660300002)(8676002)(478600001)(47076005)(16526019)(6666004)(7696005)(8936002)(44832011)(316002)(36860700001)(41300700001)(70586007)(54906003)(70206006)(4326008)(110136005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 16:57:53.8110
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5be3ace5-e9a2-40d0-2694-08dc16b4480e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7533

We have removed iommu_v2 module and converted v2 page table to use
common flush functions. Also we have moved GCR3 table to per device.
PASID related functions are not used. Hence remove these unused
functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |   3 -
 drivers/iommu/amd/iommu.c     | 100 ----------------------------------
 2 files changed, 103 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 3a9b32ad1411..b61293f2aef6 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -57,7 +57,6 @@ int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
 int amd_iommu_clear_gcr3(struct iommu_dev_data *dev_data, ioasid_t pasid);
 
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid, u64 address);
 /*
  * This function flushes all internal caches of
  * the IOMMU used by this driver.
@@ -73,8 +72,6 @@ void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 void amd_iommu_dev_flush_pasid_all(struct iommu_dev_data *dev_data,
 				   ioasid_t pasid);
 
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid);
-
 #ifdef CONFIG_IRQ_REMAP
 int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
 #else
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4f7e0dc3a2f4..ac81872ce5c0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2804,106 +2804,6 @@ const struct iommu_ops amd_iommu_ops = {
 	}
 };
 
-static int __flush_pasid(struct protection_domain *domain, u32 pasid,
-			 u64 address, size_t size)
-{
-	struct iommu_dev_data *dev_data;
-	struct iommu_cmd cmd;
-	int i, ret;
-
-	if (!(domain->flags & PD_IOMMUV2_MASK))
-		return -EINVAL;
-
-	build_inv_iommu_pages(&cmd, address, size, domain->id, pasid, true);
-
-	/*
-	 * IOMMU TLB needs to be flushed before Device TLB to
-	 * prevent device TLB refill from IOMMU TLB
-	 */
-	for (i = 0; i < amd_iommu_get_num_iommus(); ++i) {
-		if (domain->dev_iommu[i] == 0)
-			continue;
-
-		ret = iommu_queue_command(amd_iommus[i], &cmd);
-		if (ret != 0)
-			goto out;
-	}
-
-	/* Wait until IOMMU TLB flushes are complete */
-	amd_iommu_domain_flush_complete(domain);
-
-	/* Now flush device TLBs */
-	list_for_each_entry(dev_data, &domain->dev_list, list) {
-		struct amd_iommu *iommu;
-		int qdep;
-
-		/*
-		   There might be non-IOMMUv2 capable devices in an IOMMUv2
-		 * domain.
-		 */
-		if (!dev_data->ats_enabled)
-			continue;
-
-		qdep  = dev_data->ats_qdep;
-		iommu = rlookup_amd_iommu(dev_data->dev);
-		if (!iommu)
-			continue;
-		build_inv_iotlb_pages(&cmd, dev_data->devid, qdep,
-				      address, size, pasid, true);
-
-		ret = iommu_queue_command(iommu, &cmd);
-		if (ret != 0)
-			goto out;
-	}
-
-	/* Wait until all device TLBs are flushed */
-	amd_iommu_domain_flush_complete(domain);
-
-	ret = 0;
-
-out:
-
-	return ret;
-}
-
-static int __amd_iommu_flush_page(struct protection_domain *domain, u32 pasid,
-				  u64 address)
-{
-	return __flush_pasid(domain, pasid, address, PAGE_SIZE);
-}
-
-int amd_iommu_flush_page(struct iommu_domain *dom, u32 pasid,
-			 u64 address)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __amd_iommu_flush_page(domain, pasid, address);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
-static int __amd_iommu_flush_tlb(struct protection_domain *domain, u32 pasid)
-{
-	return __flush_pasid(domain, pasid, 0, CMD_INV_IOMMU_ALL_PAGES_ADDRESS);
-}
-
-int amd_iommu_flush_tlb(struct iommu_domain *dom, u32 pasid)
-{
-	struct protection_domain *domain = to_pdomain(dom);
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&domain->lock, flags);
-	ret = __amd_iommu_flush_tlb(domain, pasid);
-	spin_unlock_irqrestore(&domain->lock, flags);
-
-	return ret;
-}
-
 int amd_iommu_complete_ppr(struct pci_dev *pdev, u32 pasid,
 			   int status, int tag)
 {
-- 
2.31.1

