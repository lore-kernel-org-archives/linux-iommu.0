Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2055.outbound.protection.outlook.com [40.107.93.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165C01173A
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563563; cv=fail; b=DFPZPkxkrtcDTdJVpUpIHx9M9YeM+fWzuFsGmN7gd5S4T0L6Tb9yfQsIedqVO2xZcukqcDS5Rfz2h4dgpoJIZPxWFwf09EK+fqUEgV7McWAabX0DH4M2W0FDoHTxcQEuljR4/G24fpGL4fYpPEC+lGnlbRf2kjcb88E9YAhe3Gw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563563; c=relaxed/simple;
	bh=1DHW6lh6U9Sn/Cm8If5f7aBl77HB6V8gf515qK5QRPo=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=AwyWJj2WWtKJY9WdQn7Bi0b1bySdgdnwtHUSqG1kw0mgQkZYoK6AdvRLDsfdsdb0PurYSgwhFP9qptx8jR1Vnpp5AnABWINOFl04ffUprWasG3S2k8nB+0r9uTbJO7VY0DQhN7Qaa6leQaMFbwV6eKSYtkf5f4IniyayFbMPuV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NBUDCdlQ; arc=fail smtp.client-ip=40.107.93.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NBUDCdlQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCoQ//pil7ZeheifZpsZQhHLP0X2UN7MgwBb1Vis0rYBXHrk43UBNh3LM8GEFpK3Pm+rn83BNbA61XXS/n2TCuHhDYAuL/qRXk/49epdUgCjW8BbrAHakhbAiBU04GuY6WxeebrBDE3bwNz+y0xsmNg9RB1sHnDQYfZfT8f5bN/aroZFogrca5a61KLbdTODpw/RiXiFNQEo8geyW0LYBwsacuEceYDsBL7uOccGGqMwwstEQ2wkeUteYZeWZV/oac7cqRZ7+MwWHEGAKZ98HBtX1F64HXUbPots42qYshUNWre/7KKSX3rVyQzwbHE4NoQZgFy3qBKplXJcok2a/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5DFRwRTEHRk42aso34yeWTrfDpnCknCIb3KEQZKXXw=;
 b=OVwn1+TansCNPr+d7xBW7EJfySe2uHqBEhhxui2OofHA9t3LAEgizawTZ3XPubEiSzyc+FtOoTOv4XIvRSD52BWS0pOGx740bHofDY72PQ6TpaB6+7oiZO3iqZn6eeChVCsi2DxFVoSTcwu1SOVymSMtoX8Yhf389fAOE+sTYYmda1gdpkjCKelFjY2VZtpSB9665PABjHNEtS4+D9BijRVTITy9sT68laVCVcz1A+0cdYcDwMnx/ps4cc+wA5WxAcva8W/xMsNKNUdpFQ1X0xsI2buzRF6CIaACevAXnIczqJjcM3uU1uwkE+aDz8378ewagv9TqTe9jQXEqfIb9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5DFRwRTEHRk42aso34yeWTrfDpnCknCIb3KEQZKXXw=;
 b=NBUDCdlQbH2XdXjqAgusK6y/MY8Ru7VljgyM5uf4rZL/JahclHFSOIcU4WZO5zKfQLSLwBD/EjZa+RY10ZuPrMGEt7ey7ow1Uhk0zPd4sXjxsoFTL+LS4ZlD79ElNb187uMiqe9lgXf499fqPOS5yZUPz6gSSpF/KLTWd3Ji80w=
Received: from DM6PR12CA0036.namprd12.prod.outlook.com (2603:10b6:5:1c0::49)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:39:19 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:1c0:cafe::a0) by DM6PR12CA0036.outlook.office365.com
 (2603:10b6:5:1c0::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:39:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:39:18 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:39:15 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Jason Gunthorpe <jgg@nvidia.com>,
	Vasant Hegde <vasant.hegde@amd.com>, Tina Zhang <tina.zhang@intel.com>
Subject: [PATCH v5 13/14] iommu: Add ops->domain_alloc_sva()
Date: Thu, 18 Jan 2024 07:33:38 +0000
Message-ID: <20240118073339.6978-14-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118073339.6978-1-vasant.hegde@amd.com>
References: <20240118073339.6978-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: 784c2609-7e73-463b-3d82-08dc17f8947f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ePkzFVKMMJoz/wYvbnSaN/FCHzI8E+HTGuWn9a3gBBRKIwjmqEBq8VusSQNb+CRNBHIugv1NcVaxa4uwLTCLZP4Vbi+FdV22C9OEO+i+o34Rgs15QSEgnXNn1sbX4zOVAKXDeOqaDUcJOj9Tdh3IuGxCG6+Fv0Da23AeC0beMdU6SWT/f8Sy8wl7lbljQAh9VQnE5Qgt98KZe+Y4SzBh5vClKcu2vmQBAXa37GnIioVA+uLZcOjTl5ep8QrFSKszdiOA0uMehQRbfKVJ+F+y5lrXsk1hf0cCDcyqnFFBEC8wavW/YzBDVS5NR6Gh4zvy7bqaV4HaDC+WoJO1z06g8FbUZ4vmGWZZhD+03GCFi74h/5YjPXapmzvjUlS+DqnFTTNeqV3yNZqzP2U/Qbkbxt2d3EStfTyKo03WUDoHwhzqGwMJeuDU2hbU8mnzT7EYMRtUOre+aCez0L+9PwBw49OtAhb7ATM5Xkp7ZtHX7bwHLwKYiXt4yjP6uvmjEFIGhhTPYx0WRBQvTxZTFeQS/3UL/e/S5KCmrOIVMz8HVQRGaNdHjT/c/A0m6hjV/bz97AMO/BqlCGD/ps4VW4oJeQRyq+YFa3HIA+rilFkluspXVQBsH2fnPols2Ngy7bpVgdJMur9IpAYqQZpz0/5lcaY0hBGrurWwnSKhFpq7SJmR2MVkvGDaMshJmduI+vxTHbZn1y22TfUW4EvvbvKKEXKpeqsEujLFYiLIdIYPdIrkVSz1kXb8is9cTDOa9GxdOaS9v1r4V51d5xjWhz9e1g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(1800799012)(186009)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(40480700001)(336012)(16526019)(26005)(1076003)(6666004)(83380400001)(426003)(86362001)(36756003)(7696005)(356005)(82740400003)(81166007)(8676002)(2616005)(44832011)(4326008)(47076005)(5660300002)(36860700001)(54906003)(41300700001)(70586007)(70206006)(316002)(8936002)(2906002)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:39:18.9681
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 784c2609-7e73-463b-3d82-08dc17f8947f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

From: Jason Gunthorpe <jgg@nvidia.com>

Make a new op that receives the device and the mm_struct that the SVA
domain should be created for. Unlike domain_alloc_paging() the dev
argument is never NULL here.

This allows drivers to fully initialize the SVA domain and allocate the
mmu_notifier during allocation. It allows the notifier lifetime to follow
the lifetime of the iommu_domain.

Since we have only one call site, upgrade the new op to return ERR_PTR
instead of NULL.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
[Removed smmu3 related changes - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Tina Zhang <tina.zhang@intel.com>
---
 drivers/iommu/iommu-sva.c | 16 +++++++++++-----
 include/linux/iommu.h     |  3 +++
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/iommu/iommu-sva.c b/drivers/iommu/iommu-sva.c
index b51995b4fe90..c2e3a083ea43 100644
--- a/drivers/iommu/iommu-sva.c
+++ b/drivers/iommu/iommu-sva.c
@@ -99,8 +99,8 @@ struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm
 
 	/* Allocate a new domain and set it on device pasid. */
 	domain = iommu_sva_domain_alloc(dev, mm);
-	if (!domain) {
-		ret = -ENOMEM;
+	if (IS_ERR(domain)) {
+		ret = PTR_ERR(domain);
 		goto out_free_handle;
 	}
 
@@ -266,9 +266,15 @@ struct iommu_domain *iommu_sva_domain_alloc(struct device *dev,
 	const struct iommu_ops *ops = dev_iommu_ops(dev);
 	struct iommu_domain *domain;
 
-	domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
-	if (!domain)
-		return NULL;
+	if (ops->domain_alloc_sva) {
+		domain = ops->domain_alloc_sva(dev, mm);
+		if (IS_ERR(domain))
+			return domain;
+	} else {
+		domain = ops->domain_alloc(IOMMU_DOMAIN_SVA);
+		if (!domain)
+			return ERR_PTR(-ENOMEM);
+	}
 
 	domain->type = IOMMU_DOMAIN_SVA;
 	mmgrab(mm);
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index c983b6a1ebce..8019712c3f6d 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -454,6 +454,7 @@ static inline int __iommu_copy_struct_from_user(
  *                     Upon failure, ERR_PTR must be returned.
  * @domain_alloc_paging: Allocate an iommu_domain that can be used for
  *                       UNMANAGED, DMA, and DMA_FQ domain types.
+ * @domain_alloc_sva: Allocate an iommu_domain for Shared Virtual Addressing.
  * @probe_device: Add device to iommu driver handling
  * @release_device: Remove device from iommu driver handling
  * @probe_finalize: Do final setup work after the device is added to an IOMMU
@@ -494,6 +495,8 @@ struct iommu_ops {
 		struct device *dev, u32 flags, struct iommu_domain *parent,
 		const struct iommu_user_data *user_data);
 	struct iommu_domain *(*domain_alloc_paging)(struct device *dev);
+	struct iommu_domain *(*domain_alloc_sva)(struct device *dev,
+						 struct mm_struct *mm);
 
 	struct iommu_device *(*probe_device)(struct device *dev);
 	void (*release_device)(struct device *dev);
-- 
2.31.1

