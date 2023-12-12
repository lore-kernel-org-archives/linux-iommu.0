Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040956B9B
	for <iommu@lists.linux.dev>; Tue, 12 Dec 2023 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MfYCWnpO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Guqs7wGOnWLLq/KrC0uTU8TLeTCLdnAJRTLJER+byTNBeeRdEerYNT4UEZmIeOxNj0USmubV6bXwyTdfCSYGEn9yQusgan6hfgC2/25PydYfJrMYmy7HtVKX2U/gkKEgM9474FJDOJjIk2Kn6BmY1NEGQ/mNMS8QEOGRQazhLOtcdzzsrNxetNLBY/5UVDJC9zFCOLxfvAD/R8LvipON3AuuoPT7QMTW89qefXqASAvvTHZow2zIAUk+XTN7R82HBbjCzDsBstw024LsvJy0bc5i9ndoqf/WaF7C351+90p85Nsoi4sEPJYCR/QUnZrmzdgV81OpOMGaCjKy1e9mFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CBHLu4xmdFG3lcCrrDnjgFkVhL0zCfyhqGfxL8TlqRk=;
 b=RC/uWqx4oaxy25nOpPFY/N4mIyTHT+imvmiWZ9HV01IegW2+zbZAYZF0Bg5FnHsvQWMii5ri5yIfDkn99HqmLRbDKaLmwsBlERtySGjzQtFnpbRGaIJdG8tKlmLPvQqn8Fv1l3fYQD/HWhSq2KJr3pCZxbBd8qs6YCyJI1PDMV6JUWf1TgbKGoXOPLnKGy1FaCJcDHzz0S9U/g5hAKBM9CYA2fSZqaOJEqDUgYlV3YjIgT71kvqth5qQ2ALjif0DwWdXnHX7tbuxPcbtGZVgWsHhlNUmkKTjTZ33jOR8qLLNvFXqxD/32Gcd9yGylXLngDiqglQGtPjLB1kRjdhG1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CBHLu4xmdFG3lcCrrDnjgFkVhL0zCfyhqGfxL8TlqRk=;
 b=MfYCWnpOmr+Po77pZoVOLKMeUa8L7xY5P+2CmF9jKv82/2eWLTEjZB5bNuvDRcDkzHJhhjYJfZBwnlNSlBdjaPzHKnLW6S9NHl4mqtwWp6L3FM/gGIUL/ZAeOxlbPVVIiTUSenhTjViz6ycCdbNwqfx/9Yo07qsWSegJLecKUSo=
Received: from CY5PR22CA0057.namprd22.prod.outlook.com (2603:10b6:930:1d::31)
 by CO6PR12MB5427.namprd12.prod.outlook.com (2603:10b6:5:358::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26; Tue, 12 Dec
 2023 08:58:49 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::f0) by CY5PR22CA0057.outlook.office365.com
 (2603:10b6:930:1d::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Tue, 12 Dec 2023 08:58:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.19 via Frontend Transport; Tue, 12 Dec 2023 08:58:49 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 12 Dec
 2023 02:58:24 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v4 14/16] iommu/amd: Remove unused flush pasid functions
Date: Tue, 12 Dec 2023 08:52:22 +0000
Message-ID: <20231212085224.6985-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212085224.6985-1-vasant.hegde@amd.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|CO6PR12MB5427:EE_
X-MS-Office365-Filtering-Correlation-Id: 400c7c93-7e67-4a69-a691-08dbfaf08e98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	4LN8RosAHbQYw/qLu2bowIFTt+x6TRI0xobHgTnfvXGSaYmHR1+DOCEFCMEKS5WINdtHeJKr3+apcWaARIfrZzsd6s9KOmtCqVdD3bPOSngLjy71+ArEwhoMFVXE41eAErMY/WQYh2PV0pMHOSaukaK9vS1EeK9dRG3B59lylXzuNa+mug94+zdGWmsmEWt/7DUyfhaWreLu92SXSwHRmwM1FpoVo0fZnS1MQOyVQPqUT95CYBFVmZ3LWiGXco1sLmmcJOnRF2gSH8MD56cL2sxEJ9se0ETSIxCfXvCnqpXO0vxny4jqXZrjcndnN75J8Df5/Q39jKDyE6eUtD+oCSfPezzPxaBXbl+M+BYDdziTHMicN7g8k97lK0RpXN3c8iUX6Z5U3bMm9e52Sk6yeDxo5Hz5NDi6OHJYRNmy8xw9zsbF7pwk+X33+zvziUuX+w3tlcL9AZGYDBD3QWN/YXW9Ojy4GOroepxIPNkMjPcnHN3M+X5JCGuzA0nz0CvGk7CNBYe47vOVieIHA90LLLtSyG4jO5aekC3Tz95eyW/ocp+PVyTyFRmOn9Pv1y/OC1qPCQP/vlyFp2Fk/aRVpA95OXI2AWeKBF4crYj0uD4uecHnU0O47pG2YCDAG+vd6jXj+vhP6+kFRy6IdWlvOyAmlMsiIIbfZeTeMeuXGTv475PN8cnumzEkR683tgn4ZVkjwHf6gUWmesorEw/G9j/qpTqXhfeF9l0N/guErF1+xQE4NXO42NSHnVj8UBigTA5XuBEy2EDxc3rO9CGbXg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(136003)(39860400002)(376002)(396003)(230922051799003)(82310400011)(451199024)(186009)(64100799003)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(82740400003)(356005)(81166007)(316002)(36756003)(86362001)(54906003)(70206006)(110136005)(70586007)(16526019)(1076003)(426003)(336012)(26005)(2616005)(36860700001)(47076005)(83380400001)(7696005)(41300700001)(4326008)(8676002)(8936002)(44832011)(40480700001)(5660300002)(2906002)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2023 08:58:49.3583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 400c7c93-7e67-4a69-a691-08dbfaf08e98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR12MB5427

We have removed iommu_v2 module and converted v2 page table to use
common flush functions. Also we have moved GCR3 table to per device.
PASID related functions are not used. Hence remove these unused
functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |   3 -
 drivers/iommu/amd/iommu.c     | 100 ----------------------------------
 2 files changed, 103 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index c712cd086286..bbed268e8abc 100644
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
index 7e5f32817931..13cfea126800 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2837,106 +2837,6 @@ const struct iommu_ops amd_iommu_ops = {
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

