Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2054.outbound.protection.outlook.com [40.107.243.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24EAF2C1B8
	for <iommu@lists.linux.dev>; Fri,  9 Feb 2024 11:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707478338; cv=fail; b=mBn5BBZbgcB+zhL3LSnJwdadO+aS/VnMTeXkSkX0rroJLqOVzvEQ40zTkzxlZRwvHCf07f9SsOJDHRQIIlDIK9gLCyGjrnZAKID02uK+Z78yzbjPkO3b7TNRNdLYa33YACvC6rXOfkxzXxxXzrFPBIj0XzuVPvsVsmPp+pdrdQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707478338; c=relaxed/simple;
	bh=UfvIZ/7qLCiRyk6h2SjdoKXi51+JksyPNkRd8pR7G4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MDZHo7qAIJESkZm+9ZXs8HAg/pycPZkGAIvmk0I8VDq+PG5P58L7Nq7hNZJmn2YbfG2DA4L+fI426kWLr6PqAQPJJzRvOgwyCMFxEsejVjYhZpRN0jhflOWmtrlEA9E6OVEUAyndWyqS8WbP9fi0Vef9MdYRJcJrDG5AJzdghcQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c0vUHfUA; arc=fail smtp.client-ip=40.107.243.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c0vUHfUA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HHNOX3qk3/+PfG3C/OA5iLZH14d2lr/80DoS8qmszRaTaoFKxwbxavDWPULkTL4d0lTdAv4aGcFN/Aak/Xz63MLzMtsNDdGNWBF3TiYsZJIbqh0zA7LsznN02iw0ENXtd/cWOOu7Vy/viCWUDdO5CkSI2XGPyfk2Z5eSw4biARd9Qwz4U5VZ1coWjaNfICx2yfZHddowvp4AhXAemWGCn63C52bDc8TopFrYs3pzms4cODMNL/0GuLSclztptIz6gcSSfhM/rkJJ77jSam64FhtE0077mhBh5ilTpruwV4w93bISo5hvVOEplf68z3aULgi3l0c48tFl0ag39k670Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z4rvTlPTP6S1QA4BArksajiSfPWUfAGGGqPRnRJV3yk=;
 b=I0GFmAEFH8+RYMY4ghiUQRLNkYgLWZd3a4nPFnyhD7LlCzArmJGd63Gyzd+T2mcoKvS0n7B0qv+10wOzkSutU2Aw2j+L4Ewqy6awekmh+76kovvTokQchR2OafWq4XYakKHCuTgtHEOQuKam+1Kv6ixMbjPz1tj6o4WZmeOyKyXFj8te7ScM5b3clq//1anLVRrlu8qJvpRxA3AtChlPQOufjjvl5fOZ/aZMd73E/ED9M1ybWCXFZ9ZTNCt49yvO/8AOspkD8TfbF5XmupTsYRdg4iU0Rlv394/830105YYUJEVzQSBS/MrmJfbmGZXyEL4mfNOr52E+k3yHYaYrfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z4rvTlPTP6S1QA4BArksajiSfPWUfAGGGqPRnRJV3yk=;
 b=c0vUHfUAoXxEexEAAIEUWVjZ6nQ+1icas8OaPB1b2N3hB+r63FPxpF1vKXcXhHmV6H/4hOkAS6cg9MTow0IwcVDZdip6Vgtsf/cpY7p+cPq50sD3rDiO+HRXvupJoLLP66kyg/AbBNJjnaU9YNY377LCKZtsyHTMM/Zn4vzAlgU=
Received: from CH0PR04CA0058.namprd04.prod.outlook.com (2603:10b6:610:77::33)
 by DS7PR12MB5743.namprd12.prod.outlook.com (2603:10b6:8:72::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Fri, 9 Feb
 2024 11:32:13 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:77:cafe::bf) by CH0PR04CA0058.outlook.office365.com
 (2603:10b6:610:77::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.38 via Frontend
 Transport; Fri, 9 Feb 2024 11:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Fri, 9 Feb 2024 11:32:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 9 Feb
 2024 05:31:57 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v6 08/15] iommu/amd: Enable PCI features based on attached domain capability
Date: Fri, 9 Feb 2024 11:29:23 +0000
Message-ID: <20240209112930.63663-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|DS7PR12MB5743:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a19b23f-4408-45ac-4a3d-08dc2962c2bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1EPJYljVkLly9B/NrqH7SkVJXqyh4emS+6bRg6n0EaFl9z8jCiigSCF7wM+Kr2MOFoUEApq+TONMcQ+FR+3RH02ofyAEw65C731hRKKwkQc22dTYQkK9rKG3gj0ExuMgC5gK3KdQDuabsFwPDfoxJEsungIhiY9VjVA3gnlnKzPSrt2ekwmj3ZsUzSp0fTJVC2sTxEfgQ9RzhahbIIzXoME3Gkk77lwD9OnbGMMzEmpuA/HiqQhtBuQSvZnnhA/0HH/Y1UEwRi7Tm5+ghkmfOrnVgXCjyktzqgMook1nfhpS5AJMHPYezsoP0ytA0hAJVdMTB27IPjeUR9vNSGCQvIyTmMpHywURcLXYqeEGLSkfA4rjYvmnB4XU4Tt4eLKiDhLzH0t28f+qWUhlTrxvHl5CDl+ob/F5iGYqd3LYqe+RBfKHPqISO+ggyXU/te5iN1MfrQtaB28NUWME9Um/074DUoSTJe2dZyhISLATgm6gELErfPU7OUztC3JUgzHXH86a0UXdp73ocIEBUHBoqA8/LrWtYoXW8sFXL7+wzCM+IOLvpdvAUHW9LJHLjQiKapyqy3pSBmJS+NhtLKkORFdXvcDeL3JXTg6Eayc99+s=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(346002)(376002)(136003)(396003)(230922051799003)(82310400011)(1800799012)(451199024)(64100799003)(186009)(36840700001)(46966006)(40470700004)(5660300002)(82740400003)(81166007)(356005)(110136005)(70206006)(478600001)(8676002)(4326008)(336012)(54906003)(426003)(83380400001)(316002)(70586007)(8936002)(16526019)(2906002)(1076003)(44832011)(26005)(2616005)(7696005)(36756003)(6666004)(41300700001)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 11:32:12.9992
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a19b23f-4408-45ac-4a3d-08dc2962c2bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5743

Commit eda8c2860ab ("iommu/amd: Enable device ATS/PASID/PRI capabilities
independently") changed the way it enables device capability while
attaching devices. I missed to account the attached domain capability.
Meaning if domain is not capable of handling PASID/PRI (ex: paging
domain with v1 page table) then enabling device feature is not required.

This patch enables PASID/PRI only if domain is capable of handling SVA.
Also move pci feature enablement to do_attach() function so that we make
SVA capability in one place. Finally make PRI enable/disable functions as
static functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ----
 drivers/iommu/amd/iommu.c     | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 353d59111cb2..54ec9affb1f4 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -54,10 +54,6 @@ int amd_iommu_pc_get_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 			 u8 fxn, u64 *value);
 
-/* Device capabilities */
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
-
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 693b9ba9cef0..1c3a4914cd35 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -403,7 +403,7 @@ static inline void pdev_disable_cap_ats(struct pci_dev *pdev)
 	}
 }
 
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
+static inline int pdev_enable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 	int ret = -EINVAL;
@@ -411,6 +411,9 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	if (dev_data->pri_enabled)
 		return 0;
 
+	if (!dev_data->ats_enabled)
+		return 0;
+
 	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
 		/*
 		 * First reset the PRI state of the device.
@@ -427,7 +430,7 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	return ret;
 }
 
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev)
+static inline void pdev_disable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
@@ -469,15 +472,14 @@ static void pdev_enable_caps(struct pci_dev *pdev)
 {
 	pdev_enable_cap_ats(pdev);
 	pdev_enable_cap_pasid(pdev);
-	amd_iommu_pdev_enable_cap_pri(pdev);
-
+	pdev_enable_cap_pri(pdev);
 }
 
 static void pdev_disable_caps(struct pci_dev *pdev)
 {
 	pdev_disable_cap_ats(pdev);
 	pdev_disable_cap_pasid(pdev);
-	amd_iommu_pdev_disable_cap_pri(pdev);
+	pdev_disable_cap_pri(pdev);
 }
 
 /*
@@ -2036,6 +2038,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	/* Update data structures */
@@ -2050,10 +2053,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
 	domain->dev_iommu[iommu->index] += 1;
 	domain->dev_cnt                 += 1;
 
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
 	if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret)
 			return ret;
+
+		if (pdev)
+			pdev_enable_caps(pdev);
+	} else if (pdev) {
+		pdev_enable_cap_ats(pdev);
 	}
 
 	/* Update device table */
@@ -2108,9 +2117,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	if (dev_is_pci(dev))
-		pdev_enable_caps(to_pci_dev(dev));
-
 	ret = do_attach(dev_data, domain);
 
 out:
-- 
2.31.1

