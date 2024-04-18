Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE0C15DBD8
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436654; cv=fail; b=d4mMzmgzKcc3gi6qyUQrhQ4WLsNY90CowlQgnsgeb5liy5jf2Cw1rSBHzKb72KiM4A3FnP5jKpyLCRV/KhYBh4aaSX2BawFYJ4SBeEX1kmDIKoX/grPc+UTiPyV7M0MIMa3SZcYI+bqTXW87u5WWoXsQ0Vhv4U/UBv2qUn8sgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436654; c=relaxed/simple;
	bh=kBO9LrqmbRVQBnMh52jVZR8CaEoLzcZ5EaO4aPN1eNo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QV4VpNkaTeI3CSRjNNbiBt3UR6HVsaC9k5abZtW/6Gc6nzLjR+jyzesT9a6e4Vpc07D40cNwTb/kvLzZ6Sa1SLI2rjTIaigGE0NPZK8Dehfu7I5x/DRGMI+IApDMY08eGeuPjPhgw4pIv3uYxGuvcwAKTOjajhWJjN5qPwF+wbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bdhBte6R; arc=fail smtp.client-ip=40.107.220.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bdhBte6R"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vop28CFKnbjz0hKirs8lRJA9QiNnFhE2Cu/Tl8bEdb6gOzl/TzSxicQffAJnvrlcKwwmRXfBYxWMMJVe+lwXhc4Enfoqk8GfMdU0S3ziUvkcmljJkvmneFZyNKkDcdjcPnerUGQpLAj7z2fF2v5fRlPCUsPtKO9+8xCNwsJ9PFp7Y++xgk2CeRNhNKUVLY+8VwstP3bebgWUQOcSTHjl0QFGb8kbgTHaraN5eBV3cWxuITVwF4MuWgobO4x+s0jVfdk0T+rl5Xqu2pFPFdbtXWzDcTC+n61L8a8X4roHwfEqhaWZsagF4cxquoxeN3UJyLqIjK6Ws9dle2oMVzSERw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fqR4eJfFt7YO9poSt6PqxgZmyMle1EiScXawz0xcdkM=;
 b=TuyLWX2nfOkEq7wldWTlKTtARBS2KmoJoRASVkeSHjBVxwOAj9u1PbtoGah5FycnZ7uQI+KBSUIfcp5hcy66rkYxl3k/4zGK1LY5PlfO0ba5AIX2BklK8niGWxuUsj4++giCT5NOWKJ99NZH/HtAP/x77xxlKoQS2j8sQ8AwSWW/CzvDAQvS5nVVmPyYEsoeqIG42luKqpSDWuAptCNAQSMQf5ozpmVJYrE1K/kM1Yo1wiMdZ6KbnIykrSyY3mPOapNnde2vy6ykXhsP+oGyKlhPtgSorYB1lF4QLFIer8Wt0e6tUqu8WqKF5qwVpzvSdpTXU3+7+ph6utzZjbRV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fqR4eJfFt7YO9poSt6PqxgZmyMle1EiScXawz0xcdkM=;
 b=bdhBte6RN0dGDVQslaT48/Pmeiwb7h6GqmINiXqUEQI9GdkHDJQnEnxWe6YQvPTv4dh+2dfFYB7zcLgCt+hMSWa1bCfUzSUYbAncyeYI8/5CVHgDJcQ00V9QkILpskeIK1LK1mTeVdYH3e1vWrF19c1V/gIDDhRnRQlKW0urb9s=
Received: from CH0PR03CA0049.namprd03.prod.outlook.com (2603:10b6:610:b3::24)
 by DM4PR12MB6494.namprd12.prod.outlook.com (2603:10b6:8:ba::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.37; Thu, 18 Apr
 2024 10:37:31 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::d2) by CH0PR03CA0049.outlook.office365.com
 (2603:10b6:610:b3::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46 via Frontend
 Transport; Thu, 18 Apr 2024 10:37:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:37:30 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:37:27 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 12/15] iommu/amd: Add support for enable/disable IOPF
Date: Thu, 18 Apr 2024 10:33:57 +0000
Message-ID: <20240418103400.6229-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240418103400.6229-1-vasant.hegde@amd.com>
References: <20240418103400.6229-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM4PR12MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 3014e299-6787-4442-3892-08dc5f938ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OH/udAt11d+styUOaQCZh7qHTj4sIvj8+W7Ver0pSvGeElfW8EGLNrY7LfS6swQm3WtH4ASZvkSAJhckViCQaFtvq4sM1s8w50cIq9ZMphGs3vPW3OnTZe3kzz17WMxStqRGG28zMiQ6Hf4DB8z6XUQSCov7fz9NGCiqndLtK58NU7zVOvAPVIi+c4WOTL4cwVvyzJY1/hnZE4hcp7C+eC0DDdmkgjuZlYRqaCcNqmCtuyB3Q3BHLm+4stX4TWhFucjYd0SxePXgZyJy+2AhTkCqH3d1hT3pH2IzKKDCc+vG3EXa2AApszMH8uIyJA27gRnGR/iK1juzNt6H0OHQq12Qcpi5cuSJNyEAeheyuftNxAC0twkZlVQyifOEt+tbe5auPDBWoFZjjeeF+19tA9Q591cYgGyIcU6Et3a6M2WWkw8FAnpMT6PXCsi1Eh8WTsIo2HIt3buQWI4phEgOdAVhJFhwVe2qcn3DoJ8gDEX2F3vdtMHO93ZMDVmU99aUE0zVsqkSglrp8Pr2z0ihg6Ix5J/Vav82xgVs2pgeyCJd+PDn+ZfC/qs95ixXT5Up5pQbHXdmuJj30DothlHGD/TYhTevwpeGb/E6EpdLy7HAyLTxXk3MDT1HT/QFkp+3eqpqHyIztMhI1PnuteBevRHnhY0trtv3TGZT+3IOX4Fgsgamm3krcA6RnKRY9m9mYw8JrNF8725yyyqciDgZjNkgQsigU1x4yXvt0JPR3tANJ/2sFUqdIN5xbvCoXc2d
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:37:30.8018
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3014e299-6787-4442-3892-08dc5f938ced
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6494

Return success from enable_feature(IOPF) path as this interface is going
away. Instead we will enable/disable IOPF support in attach/detach device
path.

In attach device path, if device is capable of PRI, then we will add it to
per IOMMU IOPF queue and enable PPR support in IOMMU. Also it will
attach device to domain even if it fails to enable PRI or add device to
IOPF queue as device can continue to work without PRI support.

In detach device patch it follows following sequence:
  - Flush the queue for the given device
  - Disable PPR support in DTE[devid]
  - Remove device from IOPF queue
  - Disable device PRI

Also add IOMMU_IOPF as dependency to AMD_IOMMU driver.

Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 39 ++++++++++++++++++++++++++-------
 drivers/iommu/amd/ppr.c       | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index 443b2c13c37b..d563f6d496ca 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
 	help
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index bb9a4c2e40da..dabbb85a71e9 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -51,6 +51,10 @@ int amd_iommu_iopf_init(struct amd_iommu *iommu);
 void amd_iommu_iopf_uninit(struct amd_iommu *iommu);
 void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 			     struct iommu_page_response *resp);
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
+			      struct iommu_dev_data *dev_data);
+void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
+				  struct iommu_dev_data *dev_data);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 11b50a6c744e..9d5bffa16cb6 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2057,8 +2057,17 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		if (ret)
 			return ret;
 
-		if (pdev)
+		if (pdev) {
 			pdev_enable_caps(pdev);
+
+			/*
+			 * Device can continue to function even if IOPF
+			 * enablement failed. Hence in error path just
+			 * disable device PRI support.
+			 */
+			if (amd_iommu_iopf_add_device(iommu, dev_data))
+				pdev_disable_cap_pri(pdev);
+		}
 	} else if (pdev) {
 		pdev_enable_cap_ats(pdev);
 	}
@@ -2130,12 +2139,11 @@ static int attach_device(struct device *dev,
  */
 static void detach_device(struct device *dev)
 {
-	struct protection_domain *domain;
-	struct iommu_dev_data *dev_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct protection_domain *domain = dev_data->domain;
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	unsigned long flags;
-
-	dev_data = dev_iommu_priv_get(dev);
-	domain   = dev_data->domain;
+	bool ppr = dev_data->ppr;
 
 	spin_lock_irqsave(&domain->lock, flags);
 
@@ -2150,8 +2158,19 @@ static void detach_device(struct device *dev)
 	if (WARN_ON(!dev_data->domain))
 		goto out;
 
+	if (ppr) {
+		iopf_queue_flush_dev(dev);
+
+		/* Updated here so that it gets reflected in DTE */
+		dev_data->ppr = false;
+	}
+
 	do_detach(dev_data);
 
+	/* Remove IOPF handler */
+	if (ppr)
+		amd_iommu_iopf_remove_device(iommu, dev_data);
+
 	if (dev_is_pci(dev))
 		pdev_disable_caps(to_pci_dev(dev));
 
@@ -2814,9 +2833,11 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
 static int amd_iommu_dev_enable_feature(struct device *dev,
 					enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
@@ -2827,9 +2848,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
 static int amd_iommu_dev_disable_feature(struct device *dev,
 					 enum iommu_dev_features feat)
 {
-	int ret;
+	int ret = 0;
 
 	switch (feat) {
+	case IOMMU_DEV_FEAT_IOPF:
+		break;
 	default:
 		ret = -EINVAL;
 		break;
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 9bdd1db5f60a..0463daa2d46b 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -243,3 +243,44 @@ void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
 {
 	amd_iommu_complete_ppr(dev, resp->pasid, resp->code, resp->grpid);
 }
+
+int amd_iommu_iopf_add_device(struct amd_iommu *iommu,
+			      struct iommu_dev_data *dev_data)
+{
+	unsigned long flags;
+	int ret = 0;
+
+	if (!dev_data->pri_enabled)
+		return ret;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	if (!iommu->iopf_queue) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	ret = iopf_queue_add_device(iommu->iopf_queue, dev_data->dev);
+	if (ret)
+		goto out_unlock;
+
+	dev_data->ppr = true;
+
+out_unlock:
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+	return ret;
+}
+
+/* Its assumed that caller has verified that device was added to iopf queue */
+void amd_iommu_iopf_remove_device(struct amd_iommu *iommu,
+				  struct iommu_dev_data *dev_data)
+{
+	unsigned long flags;
+
+	raw_spin_lock_irqsave(&iommu->lock, flags);
+
+	iopf_queue_remove_device(iommu->iopf_queue, dev_data->dev);
+	dev_data->ppr = false;
+
+	raw_spin_unlock_irqrestore(&iommu->lock, flags);
+}
-- 
2.31.1

