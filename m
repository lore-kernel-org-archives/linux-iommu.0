Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2076.outbound.protection.outlook.com [40.107.220.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB6412E852
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478451; cv=fail; b=Jq2z+uUrbh6/rGLTIqUzYe1WZah/u7VxhWUDp4txwf8wcxnKkswzh+IQd7CUDIVE0aYxqIvoWlQF30r4An52t6YjtqJAgDTHYbAjUGcIoQYTbtOJcM51/lXVQsi6jLN1ZAwyGV5eR33IOE1Z0HwgskmEDonR1qP0PNWQAr6x8Ws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478451; c=relaxed/simple;
	bh=jWIaJ1jmdi8z7iPdV1AjKXkKKFc2BznKBRF1PvXZIX0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IxWyAjS1lNMnr4zGpXjV5nieZnmmfISU397B2/i4N9lRjyONwfsi+668qyfT3hy4DY8vx2cUZbAbTxjcqgEyT+2LnEdkrHP17yQWqacz4xPo0caQl4Fzzf76/TjB0q662+w2pHqrWn1kwGOiwTwz6ilOua3cLblnyCovIFhoM+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2+kNnqqG; arc=fail smtp.client-ip=40.107.220.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2+kNnqqG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cOsW6i4/rmXlOY5NYhtQVui7Lo4ece0oH4zdHcFanpo7YdhQOOCQt87Pp7skmlUPMFaYaMhpgRXLfQne9quDhorlJd1k11J50HxCMu8yqNJTPeUYdYyhxWTQa7chevaoglSiHKDI/GfnU86tq4eO/QtLlwe1KlhHeUk6AnmyxdfuOkPunFjozfruM71rzTL/3GSfJErkCGvRKnziL+i+RnJygwWVShmN4YWqJ10qdEUNCAq/4+LIvHNXN3/9/2AVJr8g2zt4FVy5Mc/E/7bTfsy8Q584nmTBAvX4A8xzQKiGtXZ/7AIqM2s7YV51/Tuo9FJNGcgHVatUv3zwMQq/Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VvyoKt4v/ZZbKsQGErZ4v1Kz3lxmmgZCEawOZCxxCE=;
 b=IUUFUW8REDNzQ5cd7fWxx8HoQSt72+pU1tiL0tV+9XfhmX14YcMEtwAE0GV/zpLjrAfnZcivDZ6wqCgR3NopJesFiHucUS+5VcNyzPcoqISaN2roh1TKpy/WAkZZKmChHYOO+YAgK2DlP3WTaEkEqxKR9PGfZzoH304NPNniC/aByQQOtzTpstrtlUceP36ejQf5w7NjeWoLEEwXW4zZgAssPbi0EvuEJ6iECo2r8r4kM7gkNYbgAhpjqg3Ox66atxYfOj7pVH+RgrLQfW0jWxtYOBSuyljG+K0UWKSPWnJ5YzA3ACQq8QWmjHLg70EV5GmItcwq+Jj2p77hbzMedQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VvyoKt4v/ZZbKsQGErZ4v1Kz3lxmmgZCEawOZCxxCE=;
 b=2+kNnqqGdhsKAKBSt2z+U84pphT/V9y5t4JUunBQgDjiS7p/FpV01dxF4q9pUtGwOMRQTokqgdDqYy6ndPXYstJ7E0PM8ZHQxt4VCC/c4SRruBf17beMp+V9hEwOHOqwCrOVrCvwqcEEbf0Yf3OIkzQZXS8v2mdDc34lQLssBWE=
Received: from CH3P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::8)
 by MW4PR12MB7030.namprd12.prod.outlook.com (2603:10b6:303:20a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 11:34:02 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::ec) by CH3P221CA0016.outlook.office365.com
 (2603:10b6:610:1e7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 11:34:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:34:01 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:33:59 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 12/15] iommu/amd: Add support for enable/disable IOPF
Date: Fri, 9 Feb 2024 11:29:27 +0000
Message-ID: <20240209112930.63663-13-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240209112930.63663-1-vasant.hegde@amd.com>
References: <20240209112930.63663-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|MW4PR12MB7030:EE_
X-MS-Office365-Filtering-Correlation-Id: 399e4b05-993f-4ceb-1b4a-08dc2963039f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HrhT3sPHI0uHvImued4L0i3nTKBxwQzNep+avUKUW53Lvd1dS6lHB7Kvj6BCZlgyUTAX85pLQPJ/Cc9xBFvF+4wokNZjx7N1hVVUIhVrXaC0FRSNJ+RB0U43vbvqWqBD2L011jTJSifIqtvnEh/QEhh3HjnAXKqqfK5CMLR9a53Me6XF06x75WEpNTmmFI8Zr9ygyxJrTIcp+rQxaNTChEh+yS/J46YW9hHGr5HaMMstz+okBm47jrHCoxDyBId6Nt0/pdDW720c83htrpFOFubZcLuDRIowV5vikyn9kU2uwXhomz9V8ZKsktkQMjBW5VQYMk4Udi/IND3YmiWeHV5+dP1eSVYaPfPMCbZxjEGNEURkcSmITDVQPemDoxVS1zIADvjpaHUaSumkHfWeBK4ktEoxppjv1GjHs7W1JuQ8f7SYZzGe9cnLjfjlP5/OlE656vLvSM4tQoTQ9swE3q8mmIWLJcTeN9q8e71+VSosM3RpyWZwLQJGlKKQuhpAjjpb/OPpAGIxlpTDujVSw6CVEiLJAw16v45B+5cyKDgHfjVCvj6XfXqWMXHvQFBIldNPFhDFSgiA64fjCgIBUKMx3bfREOKtw7gA/sz7ieI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(136003)(396003)(346002)(376002)(230922051799003)(1800799012)(451199024)(82310400011)(64100799003)(186009)(36840700001)(46966006)(40470700004)(1076003)(336012)(16526019)(426003)(83380400001)(26005)(41300700001)(6666004)(8936002)(54906003)(70206006)(86362001)(7696005)(44832011)(356005)(110136005)(81166007)(478600001)(2616005)(4326008)(70586007)(82740400003)(316002)(2906002)(5660300002)(36756003)(8676002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:34:01.8402
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 399e4b05-993f-4ceb-1b4a-08dc2963039f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7030

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
---
 drivers/iommu/amd/Kconfig     |  1 +
 drivers/iommu/amd/amd_iommu.h |  4 ++++
 drivers/iommu/amd/iommu.c     | 40 +++++++++++++++++++++++++++-------
 drivers/iommu/amd/ppr.c       | 41 +++++++++++++++++++++++++++++++++++
 4 files changed, 78 insertions(+), 8 deletions(-)

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
index 030a04451599..384298206a2d 100644
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
 
 struct amd_iommu *get_amd_iommu(unsigned int idx);
 u8 amd_iommu_pc_get_max_banks(unsigned int idx);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 0fa172e0583d..21cc6654410f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2058,12 +2058,22 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
 
+
 	/* Update device table */
 	amd_iommu_dev_update_dte(dev_data, true);
 
@@ -2131,12 +2141,11 @@ static int attach_device(struct device *dev,
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
 
@@ -2151,8 +2160,19 @@ static void detach_device(struct device *dev)
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
 
@@ -2816,9 +2836,11 @@ static const struct iommu_dirty_ops amd_dirty_ops = {
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
@@ -2829,9 +2851,11 @@ static int amd_iommu_dev_enable_feature(struct device *dev,
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
index 46d0ad13ac08..dca4bf7f704e 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -241,3 +241,44 @@ void amd_iommu_page_response(struct device *dev, struct iopf_fault *evt,
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

