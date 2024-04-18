Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2068.outbound.protection.outlook.com [40.107.92.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A48A416089A
	for <iommu@lists.linux.dev>; Thu, 18 Apr 2024 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713436593; cv=fail; b=l46inTjQLSt4yiOBe7eYHpxvaxqGVUlaNoPmfU45cp+2QB4S4JTnDHS4DI1nZ8q99IVQjyDmzen8uOBq80p4T4JeMdvpDGLnMsLyFWA02M1YlvmD3CA2/89j0nOWZcFpAinbHOgOEp+674TMuoO47Bl4m4CxZmJs5x8/ZJvpugU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713436593; c=relaxed/simple;
	bh=wEi0pcOW5JaapJwFWvs/auDhB8z9caoM8emeI7F6AQM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLbS4UOinyolUZvgTXI0ngfkHW8UDOeKsUM+/npNkjB+1fSviKHb8c8xssCs4No3XL6kmWoLSkQvmNQaPWJYNPVcKGKazoylgr1czFGpWXS0s1C0Sfgl9PmtJ81P0LVbLksX0Susofil/m7KuayHLh+x0HOJNkdqjoM8vxCu9BA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VPBVVmSz; arc=fail smtp.client-ip=40.107.92.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VPBVVmSz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ofyl7ttgcGcrCSmIBvItMtZ8a7M/Dad2pgQFUQE5DftoFxNPjqHQ+lCYqVJYfoUXkMXpVm5to6jB/fChbGD6pmGhLccPGgYEyIVh9BIaCYkPSKSjGyH9evn5oa398Trh07nGbP03xxGnns82EfBoy4XnaGiSVp62VeXxGbNya8yn2peaJQggPajB8qrRCtC8U7EC2EmhjukMAMnrtS6BOkKc9IekVjlnNSsRXMRlllCdHRNvtXqK8Ydrq1j5ueOjm70f+OOB76waWryB/HqFYvP3t7G1ae3Tq2qnMo2Q2rtatHxbDdcUIlRbL1MBV4OHoUOGPsNvRuG/jn3IqGLYeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YSlGLFefw2vgrwhmKxRT/yPjir2DTiNneia6azWqkT8=;
 b=eCaLJK0RU3yX/gn8CLax6S23Tzt+PRK0yMOK2dQkY6P008VKVuooNgtkypUrkt+VzbCZ6bWHL0s9E0Oq6ylLZv4Yi6nMN2F3Tt+4u5jABFnB9V2jN/XQdqcHKBxYGdaxHFYOhyBzDaqeUdQtcKfrg3DfVjnrywRIANkTH8TZK5RjhV4LXbW+8T4Z8OJ/rxf7neQycnnUc5ioYVKDo4bxx4pMWcPciy6cu11geKRM5doa4Z5NnEjnLDNxYEoSLwkstZ2/Tw82uMQy3wNDMyY3yGwNHaOj7SfYfHa/e4eloDTV+gLfdlyl+roL4/c4dFFU/0HAGdKCzwzmVBICeY6jJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YSlGLFefw2vgrwhmKxRT/yPjir2DTiNneia6azWqkT8=;
 b=VPBVVmSzFM9S2J6KI6houxnNUFKjmU+TarNoLBWhpIef7GXqOPzkgyIiYtgM+UZUCq5hB2of6KMUzhnOhF5YlvqPTz7Tf04xsX4DKROSyo/huxAzs5eMhNvJnhxsXOBOe5VUBzWuV+TM38c//yTWlv59gJXLj4AYAINsgf+nAm0=
Received: from CH0PR03CA0036.namprd03.prod.outlook.com (2603:10b6:610:b3::11)
 by MN6PR12MB8515.namprd12.prod.outlook.com (2603:10b6:208:470::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.41; Thu, 18 Apr
 2024 10:36:28 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:610:b3:cafe::a4) by CH0PR03CA0036.outlook.office365.com
 (2603:10b6:610:b3::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.45 via Frontend
 Transport; Thu, 18 Apr 2024 10:36:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Thu, 18 Apr 2024 10:36:28 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 05:36:25 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: [PATCH v8 08/15] iommu/amd: Enable PCI features based on attached domain capability
Date: Thu, 18 Apr 2024 10:33:53 +0000
Message-ID: <20240418103400.6229-9-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|MN6PR12MB8515:EE_
X-MS-Office365-Filtering-Correlation-Id: cdedce3d-c4c3-4240-fff6-08dc5f9367c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	DxNk55Hw3XMCjbckj3c+H6L4CuMZ1CkhxvX2xI90cUmtpRezx8RfHChrYx+fMDOez2Qz67ZdpbXYNm2QhNA3rUCKqrFaAujIQGr9Rozi18LzQTDOSexovD0f68szZfTxKdEHHXHhVCnfjLx48pF3aGoNMc+2oxKqrZJjcOVjnUt+2B9HzcigK/BKkaNGFK8sbJBoSG8O3UJkU7ofaPxxVSyKlPqKphjfZvVO2409tg1K1iuVytjDiiJj3+fMAnN42lIEWoUIk+rOHFIkDsEoVoc9337qXdATI+i8DaSQ9oOUv94kA6Ymrv7TmaAVbQfS5eaAA9FRvFfsj69hmw3Wo95DZzwr8xJbaU8PNvUBPEDDQNE2QQ41/K+cBZN9Xqytct00rrt4shIdDN00qM92XJcCkf6A1Dehw1xDnsdI905RYXYnYDJWspThAr8vUjI7tWq0AQK9wAwJA+UA0fHP7WRwesi/QDGhYGOznVIxC9gDQE+RLQp5IQdA4K8AMIJC5Bc42/PJn6sXK9t9s5cy+JodpvnK99RWVVuiM1WjVWBvi0XENFLsGXZ+nf7bJLM241LNfhRW24DOUrp38Lqsbzp/4Zc3uWg6+jZ5k/JX9LdiWsI/YkbHhUb/GE3UG27HL/cBBZjEie6t7ysQapvk5dFjadwZXFImeUlN9lr3mw1njYrMestZv2zJ4sIgLIz2t1c7HCCmB7cckeLG518eJQ/wDUqM2ZOi3mrZHZI7el/jyLud2UOgU8nnUkYCROSu
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 10:36:28.4584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cdedce3d-c4c3-4240-fff6-08dc5f9367c1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8515

Commit eda8c2860ab6 ("iommu/amd: Enable device ATS/PASID/PRI capabilities
independently") changed the way it enables device capability while
attaching devices. I missed to account the attached domain capability.
Meaning if domain is not capable of handling PASID/PRI (ex: paging
domain with v1 page table) then enabling device feature is not required.

This patch enables PASID/PRI only if domain is capable of handling SVA.
Also move pci feature enablement to do_attach() function so that we make
SVA capability in one place. Finally make PRI enable/disable functions as
static functions.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/amd/amd_iommu.h |  4 ----
 drivers/iommu/amd/iommu.c     | 22 ++++++++++++++--------
 2 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 159e9a43aa61..f8919c54d9ae 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -46,10 +46,6 @@ extern int amd_iommu_gpt_level;
 
 bool amd_iommu_pasid_supported(void);
 
-/* Device capabilities */
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
-
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
 		       ioasid_t pasid, unsigned long gcr3);
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 288cf7485306..1319f93bb473 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -399,7 +399,7 @@ static inline void pdev_disable_cap_ats(struct pci_dev *pdev)
 	}
 }
 
-int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
+static inline int pdev_enable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 	int ret = -EINVAL;
@@ -407,6 +407,9 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	if (dev_data->pri_enabled)
 		return 0;
 
+	if (!dev_data->ats_enabled)
+		return 0;
+
 	if (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP) {
 		/*
 		 * First reset the PRI state of the device.
@@ -423,7 +426,7 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev)
 	return ret;
 }
 
-void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev)
+static inline void pdev_disable_cap_pri(struct pci_dev *pdev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
 
@@ -465,15 +468,14 @@ static void pdev_enable_caps(struct pci_dev *pdev)
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
@@ -2035,6 +2037,7 @@ static int do_attach(struct iommu_dev_data *dev_data,
 		     struct protection_domain *domain)
 {
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct pci_dev *pdev;
 	int ret = 0;
 
 	/* Update data structures */
@@ -2049,10 +2052,16 @@ static int do_attach(struct iommu_dev_data *dev_data,
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
@@ -2107,9 +2116,6 @@ static int attach_device(struct device *dev,
 		goto out;
 	}
 
-	if (dev_is_pci(dev))
-		pdev_enable_caps(to_pci_dev(dev));
-
 	ret = do_attach(dev_data, domain);
 
 out:
-- 
2.31.1

