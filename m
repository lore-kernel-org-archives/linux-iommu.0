Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2078.outbound.protection.outlook.com [40.107.94.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C9945030
	for <iommu@lists.linux.dev>; Thu, 25 Jan 2024 12:18:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706185123; cv=fail; b=H9LdY0GAYRbJD0mp64VpdZvbn+hBJZNX+sWPu8WLztcY4mToiH2Cowf+FakRh/l4venDCHGp1cchozWX1LhFoI/CluJVuIuk359fYJVJVd2vY5AatDiE93OQ2LSWYaUnhEAg8CywWkiszCUQptil9RHl8kuoLlS02MhMQbIasjY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706185123; c=relaxed/simple;
	bh=It07T1AsAjUDaiJa5Udbv1/+39cSm5VulajPzh/3SIg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LSm4xK2p2tmlFrV2uFreLRvzrCZEhHr1h3Wwur7/n02gD6U67t+rZTTsyn8H4f6iEwd1BUANseqt+wOLgsWDq4Ur9TSkyivrw0K4vtreAi1YzEvr01JJo8l6vdvIcIlxLoCgMbMzts2TyZMYIoufoTIRe6ta04CuLneSfmic4h8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zpPICOLz; arc=fail smtp.client-ip=40.107.94.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zpPICOLz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hY2PwvajoUNulbdCpMECfiTkdz8IyV4s7itCEEw67h968I1/dFdQFSn4mBsJmkp9aeb1d/cJ0eVb+UwEcNVFk7R+em/b+uncefD9rIsJpd86DCav72Fqs+OT+bew63Gl2q6H0aVaNeLNND0LmXtSaizTWzqy4z5miWB6h+EVKd53e5T/FlIkpJ0UQLADf4h9wAC8jhArVdNF/h1jRfy2wv0DdLEE+zI/eSomN5LFVwUYkt/Saf88eIk4MXI+rd6FZDfqLLmoQyzdwhtnCuWJX3wDm5G1heoKT7EiI+H+4vpuBt/PhFm1QN+sxcHnniYyZlc2HFtc7CBov5B5VPRD6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QMNvEIzL6hfYF6gIbHmjcMDIWpjmvueo1xmdFI8YA0Q=;
 b=BwXaXQvJiGHaW0mnDTWRfIDPUCweyA4sTryRZEaIoBEQL0PawS1IG9sSaHQ1miqd9NHuCkatYLZYkiQjFMnykIw1mNTew3LNQpcb8+4Z+yeCLkT5f/ZkRqpLbsuvddkYm8Ml2qN48I1sddx5QZWjJZPZgWIipvroEfukgbO+VAXwKA07TyM+SSBNSRD+JqGdLap4cNjNfQh7pUw1AAv5jPM33Al3mlD+yrdkJ+79QmMqLjUKDWPln3RhDPpi7Hfzhkav+KN2d4gyL/eI+vj+xZC1y8jTl5hzlY9TKqNSJGn5qEL8hz5MUbBS/GYtqbRV1uBgvLhxqOOlmxDmnNGO2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QMNvEIzL6hfYF6gIbHmjcMDIWpjmvueo1xmdFI8YA0Q=;
 b=zpPICOLz3LfWw1JoW5ypkmMpovfllk+wEsrpnMU9yAGH3MQtwSd2OZTf1jIjV+7w9aCC5G291I25RR69P2Oby+T5mxiCYKZzFZ3z4n7+qrr1EV9bb8gHxFvp8LpPXXVD9zGMJF46AQEw0aa9OTIAokWVjYSCJ+cyvf5gV7cgb6I=
Received: from SJ0P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::25)
 by CH3PR12MB8880.namprd12.prod.outlook.com (2603:10b6:610:17b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Thu, 25 Jan
 2024 12:18:36 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:41b::4) by SJ0P220CA0009.outlook.office365.com
 (2603:10b6:a03:41b::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26 via Frontend
 Transport; Thu, 25 Jan 2024 12:18:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7228.16 via Frontend Transport; Thu, 25 Jan 2024 12:18:36 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 25 Jan
 2024 06:18:29 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v6 14/17] iommu/amd: Remove unused flush pasid functions
Date: Thu, 25 Jan 2024 12:11:32 +0000
Message-ID: <20240125121135.8217-15-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240125121135.8217-1-vasant.hegde@amd.com>
References: <20240125121135.8217-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|CH3PR12MB8880:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdb22dd-4886-4341-62a1-08dc1d9fc1af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tVdJ0ScyfLriW5rEcYEz6ucGQLIDsPnnrFtTwN4TdXjW1EoupFv3gwNYckFRoP0nO2/1zv1wESSEvRl6xIC5PkMagn6LV+WvFP6/9ENbhD1G8sQdv17r65gw7TMKguTI8S3Mic5ckG2AUYokKC1z0bEB9GFBeUm4sE6lei5uPr8OdPrJ6/oWXExNKXAUkZpMyiM1bjdRMHnKu2l4Oqi0TVVlwVe3+SrzLa968aHGc48fKQ3lxTTEv4I/IhJOLVeKE1aswH8uNKj5w4wOsguDdD9pmdJ6W6nqaH2uY6ip31DRROOXw5QJhL/GbvC3EYt+agOghUPWR3/MTjMjDUlgHFRYBbIlpCdO96M8JfLLBRzYHnCBq6LaRpsIE7KnvhM+76VS2hVGZx0VvP9AmKMcEc3oRGEJb+/rAHPc3yUyIOIiamr8QP0Nhw2IOg3JIr71rJBbfkh2j67vcJbsm0zNYTw0wLCCINxusXYLvUFGMGOpsR8HJUMS+AQok9p3G75nOJDLUQcqG/4uY1vU9K7hCIybX9Sqnp8bQlhoXT+y8h1zFsEnqc+7yf3FqhXXmrit7ZVjv7jU7uR4JVHVOYDkymCHPwcmB4mipngH2MkPOgGichnXMchd0THwhFmCjGDdWTfgAlM6eXddS4PAatHQLOFDS3ow4uDqmjgYK4mGPRra2ZyX9NWqMq0kEvR5Ca9abBW7HIIxA+A/vrNbUcGbN9JUpqzuIDItiDT0NRQGiPP9F1sNYsBTYPit8vP4Y+E7aZVD9wdsNsal3Eulb7aZTA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(376002)(39860400002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(82310400011)(40470700004)(46966006)(36840700001)(40460700003)(40480700001)(1076003)(54906003)(70586007)(5660300002)(316002)(36860700001)(426003)(70206006)(8676002)(6666004)(26005)(4326008)(8936002)(16526019)(336012)(2616005)(110136005)(83380400001)(2906002)(44832011)(47076005)(81166007)(356005)(478600001)(36756003)(41300700001)(86362001)(82740400003)(7696005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 12:18:36.3926
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdb22dd-4886-4341-62a1-08dc1d9fc1af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8880

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
index dd86a681099c..f8d8ad29c3f9 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2750,106 +2750,6 @@ const struct iommu_ops amd_iommu_ops = {
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

