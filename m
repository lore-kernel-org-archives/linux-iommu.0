Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161A81C2AF
	for <iommu@lists.linux.dev>; Mon,  5 Feb 2024 12:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707134605; cv=fail; b=mPdZOHKAwWdRFjhfshR/sevTHhT2aMaY93r3eoOE/oQ31QxnT16GpOCqZnu9/rJOxgJbSY1mNU3CSKWjc90h4cz/kSYCr2Uw0A6NTQi12PrK/MiwAmrGpYA7UJlE+f6KXWKZ2dcKIbC2shUbs71JAGDmPbtrvNxHdoWUDM4BEH0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707134605; c=relaxed/simple;
	bh=XemCFk0AIF4LLB2wtXv6zlH1l1bECCOrjyprU75Ecj8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TwoE++h9mK/DXfYJIzZNWzQJ62QA7g+Yz75wWpEIvFDeQ54LOD7PvA2eMHRrj8dHQhsQ3qIW6/JsKuapp0Ut4vxwHgc9CpRGjELcdOep7FlgBOpW1PIuGp4ng6vopQQ+D2hDi2qTA3MgD5SDAbnVVkYIwyLeuoZM8p88+Jz6hVc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=PMnNG3vk; arc=fail smtp.client-ip=40.107.94.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PMnNG3vk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bCer42YyiVgmPi5OPHUhNV8yHdkh25ssnuIQ9h39z+jBnpIX3GfEntUL3hLgzcump0XNIdnB8HVLHNeROgPwYlTbA4USUiXFp551mSA75sHzZPMq9jyfEhW0t3dk/stsTry1HNb0blPyQRyMFMV/kmzLQI8BvX9GAIHa601LZULKRnZlig4JxeBT2V1KWhw/EWv4kxAoP7lcTLX+EjlhMP4UcWaXZN067XzkggzHJlzQOmib9ipVopvjhUtmnWHFITqK84Ylt2v2CDo8pJ0bFzjYNiTBklut7pexz9+aeIDE8OGk9T8vlCKYizOvEO1Flo44OzMXXky3YdOPkjqdZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3dS3jtqjprV5JWUjUEI4rIsts/ax+/aI9i9lQRznOQA=;
 b=NZY0vNAw1Bu1ENQRYQTBYM/MNZKlFqrc61Bu9HmOYcYaF4FNUF5cqvPMuNWPgY/eYrcsTJ62kjSKgr5H4yMrMpBorY+J6Bm0XcAQwO5OQHgzBQzN8razOgXJg+zW2uGp+VvZZAvjOkVnaT/t1MirAIvSPhC0GE2oRC13UwaWC+7mnLlDdsvzIWkyz4RMlAc0ro2u8O8tKtZ6M1rae9Hnv2XUOUsoCUA9Gcy3NH85ez+ECk/QH9GfJlN5O/KDcejW8kOCYMmumljrqELxYn920rsHgdWntI7+ynwg8I6Y+XVpJyNvq/2vo69Ikfv0Ulv0KFWYK6/BQtT1NAe7Hy+XdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3dS3jtqjprV5JWUjUEI4rIsts/ax+/aI9i9lQRznOQA=;
 b=PMnNG3vkscSCFqq43AKEJSebNeGasrCCgX+6UQmHHzIUUw9H/LpTp3+2RzzN4fHjk4ziiSqL4Yw19EUlWtrIhfVrBlGdm3mrQW8EoQHUYPUJxdGh7PmAfeL3bbIJKrhNl9Ll6zQ41rW1DIBcDKl1WWxk4UQU+5biH8bfc208Eeg=
Received: from BN9PR03CA0847.namprd03.prod.outlook.com (2603:10b6:408:13d::12)
 by PH0PR12MB5418.namprd12.prod.outlook.com (2603:10b6:510:e5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Mon, 5 Feb
 2024 12:03:21 +0000
Received: from BN2PEPF000044A2.namprd02.prod.outlook.com
 (2603:10b6:408:13d:cafe::c3) by BN9PR03CA0847.outlook.office365.com
 (2603:10b6:408:13d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 12:03:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A2.mail.protection.outlook.com (10.167.243.153) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 12:03:21 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 06:03:18 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v7 14/17] iommu/amd: Remove unused flush pasid functions
Date: Mon, 5 Feb 2024 11:56:12 +0000
Message-ID: <20240205115615.6053-15-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A2:EE_|PH0PR12MB5418:EE_
X-MS-Office365-Filtering-Correlation-Id: 85253ff2-2c0e-4f7b-80da-08dc264272ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uDr/vqPDbe+GtgGB5rLFttTul3+khbnWR2r+Y+vX1jmzZJFmqKGzjqZHcD4iAlHUNb04xxW2FijH4WBcqwMnBXbkuNf8c7UrFhpOKSb0jkZiGvwqOU8aUvpY4qSVayTbjMmPChPJotJ2Y8dJn5tX0vPMsm0eq1l6d32JyqUyV1XHsFhCQnc6OdjyXaXd7i9Xm2aPvEVwnhUz5MyFg0pyiimGZ86h6oQesJZVLEHU7SGHd6ZgBV/xfrvYUkbprfO3lOt4Z2YIaqJlQDjK7Cd9DgZJH72iQ26Pe4kNdWauCPv1oBUkZEYbeRstc459THPX+SKZwVu4tf22+B2M5vJ0Ikp2RvO80biouNUyacatJ4g3M7ntOKD2wK+ZT7+nnOwI6/YHysJ8j1ZX7kVBuRW6vUXO6qeo/mOkjAsg0ByrIzlgXhsEEuhC61t9xkI500Tlt1G2QLR0NH7+aF0HD6ynqJ38VHxK5F3RfvKDLtcn0nO2onWXkCZvx5c5gGqsnOCGnhU3DFo9rxwVk+HtzorJrh/LNvmbOeu3ZpZ5/OYzsPJ6HrPLJrgiY1wsuUFgHHCSFME+kELqdL2XcP1EsTqOQFW3WWcdlENwq1YlUz9BRA27OEEbBUb1IqLZBj7IdWL5qF0Mv/Jf6ZkXWJVM/6jpG+3JzQAinsZPOXqOrgJtRWZi6ue6gJjKSoFUvS9fYiZnULw9olb870UD9Y6AoBboQT459DRxSmjN3b3aMpYOqi5up5Y75NdtxJBhLYjE0Zmh2s50L/dwGuE2wax34uPQXA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(36860700001)(336012)(47076005)(83380400001)(1076003)(2616005)(426003)(16526019)(26005)(40460700003)(86362001)(7696005)(40480700001)(478600001)(70586007)(8676002)(4326008)(8936002)(54906003)(316002)(110136005)(70206006)(81166007)(356005)(6666004)(82740400003)(44832011)(36756003)(41300700001)(2906002)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 12:03:21.5848
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85253ff2-2c0e-4f7b-80da-08dc264272ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A2.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5418

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
index 4ef4351ed96f..9c29540ab3a3 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2752,106 +2752,6 @@ const struct iommu_ops amd_iommu_ops = {
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

