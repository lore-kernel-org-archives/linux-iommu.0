Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5AFBA2B
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 07:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705563547; cv=fail; b=WP45HZ/nTcgEhdBfj6TyLqhf2NTzGkDeSeFfJwI4AmMXFDhxXhmxFboWjeJrofv3mUeswqVSppWnchp6rNfK6tKqtIwB/JSIy8QBOjK2tGqBtlGl3hwyYNCu9ixuu7nFM7mEOfVbS9jkWjrXDHjvxKRuqkiw0EfW9Il8PScnbNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705563547; c=relaxed/simple;
	bh=8lcG7YAR/1THZW8UAxuxILssGRxPFwENqgggRusWPvY=;
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
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=LDHs51toC12LxrEDJ1A98LEji3FOiyTEWSz6X6O+k/OwjWWpqfbZZL1GNQcDmZimIqsHkjOK1n2aQEF03uzS0wLJnxMbiLik4wJF8ykLngZyAuF097+feGJiUNIANWj+pZNcZ9AEH8e5416oGSeaFHR5gt3mfavhnT9STY88AXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YGpaCfMP; arc=fail smtp.client-ip=40.107.244.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YGpaCfMP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU/2AEWYkET75QFhsRQ7K4BNS/vcBhpkPRcX/kqE2VP9eVhYrqQIQVEDln4x2f7hiB7LpzNb8625Wfa8Bh+7dmf42zdq7+a7MTlIMAIGM/RQdL1otFv4U01QPF84igeIAQwvQ0jaLrn30RvZG1U+ODhefWO2KGoGadv3o0YwCkMdoHcbgHokgM29VZqLpF4HKtQb37+psLQk0aWBD5jhw69NprtIfMFYe/j/RFW/uQfRJuG/mnhkf04UCz5USMg6Ej4AT3Pb2kBgLNbojFH4RFR4bssG6oWXLz72YIAw93KPUESgpc1Wj4/YqtejhvW0uS170QL/S3d66Wiy6F7Iwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kq7NOo2ETPb40qJU1+L15MLPHVlUnGBzsF4b1Dr5vsg=;
 b=akLOeXUNomj88rLAC/H9gyjmsgNs/SdAGx9eF/87Ozam2G7kQfvg17itEUdSFS121fyvtp+M/hD7D92cNNPsjcO9h7859Sr34lYFuR2xuqDW8AXXF7P+x9MQcZnIlBW8rtSCMxpnlE9qm/EOitF3vm+edazoF0emV/fAMKxPY2t/zDQCAYMQgPgaZwyKQ9W7/J7nQT/Tr4KV4JFn+eRKi8V553RwHHUcJ4Cl1C/ctZhNOAUUq6maCm6ssID8Y0jPbrnZBxPpIFqth54vHiZFwomAPQOxo4Qlc0odrbDYQhMQIlUVZ/VhW6j6SnOnXab6nTQ5fmiFLj2I8QJHLyBiMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kq7NOo2ETPb40qJU1+L15MLPHVlUnGBzsF4b1Dr5vsg=;
 b=YGpaCfMPu0r9zO+cMrEpJXIQClMYd2TCQw6mJfN8PBRFUP4OxuVNccIsAsHismVX3EmyyUrJcoWy2zHUH7LCvHXr6DU0qkvy9sP9gjExxV13WaKV/Qq3wXiHa2TnGjwQY96lt5wZ7QzjisUANoEjygQFny30UEXZHjnl/mFZOxM=
Received: from CH2PR14CA0013.namprd14.prod.outlook.com (2603:10b6:610:60::23)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 07:39:03 +0000
Received: from DS3PEPF000099D7.namprd04.prod.outlook.com
 (2603:10b6:610:60:cafe::19) by CH2PR14CA0013.outlook.office365.com
 (2603:10b6:610:60::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 07:39:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099D7.mail.protection.outlook.com (10.167.17.8) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 07:39:03 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 01:39:00 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, <wei.huang2@amd.com>,
	<jsnitsel@redhat.com>, <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Date: Thu, 18 Jan 2024 07:33:37 +0000
Message-ID: <20240118073339.6978-13-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099D7:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ad5ea37-c2f0-4a11-6194-08dc17f88b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q+y3stLIoJjV52eT1YPzllwI2GNyk12fmvuQR6zgQMlxCoxIiTtJJCemhpmxAUm8Ffnwq7IXwnWgrBj3Mi3e1XDH+cEbWrRbTsSamO0FMdtKnK0Y5oMdA3Zk7KqOC9gk13NRb78taOTBClmAPS/htqtWH1pMhgZ854rshCZ03KIxC7TTFV/mQk0+iZPEV5sFXHg86o41z0I/E2jeEYTfAdO+Tplgx/w3+4GnsvJ2/x/4HVY5O3Ybwn8ozUcaB9xxOf+CO+zAsg7xzzP4OAv1v3nxCkyIfCch4CGdSECfABgZ8nErMZbF9nNyJe9S+Iw0hKkl7OJ0zPMe0J++3l3AIUIcm0sauXZz88JJFSjHrHNv/V7aK51bRnFbwqsIOl5ZvBYwUbh8EBBF/52o+80aSoUrDv0qwGcOp6gqCB0MMRGuT4wNKKn04SxwBV3O6o0FN7IZ/e3uVdraIBoIadv7m7+UdUeHkwPpJFHt/GeGH9cBnRzUTPspalZb26Eft5SM5K9out3nWeBDjpFjPKwXvOkIDuVGa/g2Qit90KfFrsVtQYNk+bp1Bei3jAiUnlNbXTRcBqoAGIoE/nxXPArQcomZl09nptIPsyy+NfYKHv2nR22Wbtk19ExkBqkDsR0gbbDzVpVYCWAxrJgLPAqkGJXlxQjfUszdmHRj2MaD6XQfDjJws810hj4iCR4kjB1YL+DeFQFDnCdZm8ymPLWMDxHJyDlCYyxlq8vjX2Q6q16xsiHQ/ZCCwLw2HiwO0zSRVb8vi9hSZCc/Al+aOcwIjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(376002)(396003)(136003)(230922051799003)(64100799003)(82310400011)(451199024)(186009)(1800799012)(40470700004)(36840700001)(46966006)(110136005)(70586007)(70206006)(478600001)(40480700001)(40460700003)(44832011)(54906003)(316002)(8936002)(7696005)(8676002)(6666004)(2906002)(30864003)(336012)(426003)(83380400001)(81166007)(47076005)(36860700001)(86362001)(356005)(41300700001)(16526019)(26005)(82740400003)(4326008)(2616005)(36756003)(1076003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 07:39:03.3387
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ad5ea37-c2f0-4a11-6194-08dc17f88b2e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099D7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312

This includes :
  - Add data structure to track per protection domain dev/pasid binding details
    protection_domain->dev_data_list will track attached list of
    dev_data/PASIDs.

  - Add support to check PASID is supported or not. Also setup gcr3
    table and if PRI is supported then enable IOPF.

  - Move 'to_pdomain()' to header file

  - Add iommu_sva_set_dev_pasid(). It will check whether PASID is supported
    or not. Also adds PASID to SVA protection domain list as well as to
    device GCR3 table.

  - Add iommu_ops.remove_dev_pasid support. It will unbind PASID from
    device. Also remove pasid data from protection domain.

  - Add IOMMU_SVA as dependency to AMD_IOMMU driver

For a given PASID, iommu_set_dev_pasid() will bind all devices to same
SVA protection domain (1 PASID : 1 SVA protection domain : N devices).
This protection domain is different from device protection domain (one
that's mapped in attach_device() path). IOMMU uses domain ID for caching,
invalidation, etc. In SVA mode it will use per-device-domain-ID. Hence in
invalidation path we retrieve domain ID from gcr3_info_table structure and
use that for invalidation.

Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Co-developed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/Kconfig           |   1 +
 drivers/iommu/amd/Makefile          |   2 +-
 drivers/iommu/amd/amd_iommu.h       |  11 ++
 drivers/iommu/amd/amd_iommu_types.h |  19 +++
 drivers/iommu/amd/iommu.c           |  14 +-
 drivers/iommu/amd/pasid.c           | 191 ++++++++++++++++++++++++++++
 6 files changed, 232 insertions(+), 6 deletions(-)
 create mode 100644 drivers/iommu/amd/pasid.c

diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
index d563f6d496ca..68d8fc107cb9 100644
--- a/drivers/iommu/amd/Kconfig
+++ b/drivers/iommu/amd/Kconfig
@@ -10,6 +10,7 @@ config AMD_IOMMU
 	select IOMMU_API
 	select IOMMU_IOVA
 	select IOMMU_IO_PGTABLE
+	select IOMMU_SVA
 	select IOMMU_IOPF
 	select IOMMUFD_DRIVER if IOMMUFD
 	depends on X86_64 && PCI && ACPI && HAVE_CMPXCHG_DOUBLE
diff --git a/drivers/iommu/amd/Makefile b/drivers/iommu/amd/Makefile
index 93b11b6d764f..9de33b2d42f5 100644
--- a/drivers/iommu/amd/Makefile
+++ b/drivers/iommu/amd/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
-obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o
+obj-$(CONFIG_AMD_IOMMU) += iommu.o init.o quirks.o io_pgtable.o io_pgtable_v2.o ppr.o pasid.o
 obj-$(CONFIG_AMD_IOMMU_DEBUGFS) += debugfs.o
diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 2d099c54b941..1344b48caa46 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -44,6 +44,11 @@ extern int amd_iommu_guest_ir;
 extern enum io_pgtable_fmt amd_iommu_pgtable;
 extern int amd_iommu_gpt_level;
 
+/* Protection domain ops */
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid);
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid);
+
 /* SVA/PASID */
 bool amd_iommu_pasid_supported(void);
 int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, ioasid_t pasids);
@@ -72,6 +77,7 @@ int amd_iommu_pc_set_reg(struct amd_iommu *iommu, u8 bank, u8 cntr,
 /* Device capabilities */
 int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
 void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
+bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev);
 
 /* GCR3 setup */
 int amd_iommu_set_gcr3(struct iommu_dev_data *dev_data,
@@ -196,6 +202,11 @@ static inline struct amd_iommu *get_amd_iommu_from_dev_data(struct iommu_dev_dat
 	return iommu_get_iommu_dev(dev_data->dev, struct amd_iommu, iommu);
 }
 
+static inline struct protection_domain *to_pdomain(struct iommu_domain *dom)
+{
+	return container_of(dom, struct protection_domain, domain);
+}
+
 bool translation_pre_enabled(struct amd_iommu *iommu);
 bool amd_iommu_is_attach_deferred(struct device *dev);
 int __init add_special_device(u8 type, u8 id, u32 *devid, bool cmd_line);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index feafa868bcbd..7609fc1c5aee 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -8,7 +8,9 @@
 #ifndef _ASM_X86_AMD_IOMMU_TYPES_H
 #define _ASM_X86_AMD_IOMMU_TYPES_H
 
+#include <linux/iommu.h>
 #include <linux/types.h>
+#include <linux/mmu_notifier.h>
 #include <linux/mutex.h>
 #include <linux/msi.h>
 #include <linux/list.h>
@@ -511,6 +513,11 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 	list_for_each_entry((iommu), &amd_iommu_list, list)
 #define for_each_iommu_safe(iommu, next) \
 	list_for_each_entry_safe((iommu), (next), &amd_iommu_list, list)
+/* Making iterating over protection_domain->dev_data_list easier */
+#define for_each_pdom_dev_data(pdom_dev_data, pdom) \
+	list_for_each_entry(pdom_dev_data, &pdom->dev_data_list, list)
+#define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
+	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
 #define APERTURE_RANGE_SHIFT	27	/* 128 MB */
 #define APERTURE_RANGE_SIZE	(1ULL << APERTURE_RANGE_SHIFT)
@@ -560,6 +567,16 @@ enum protection_domain_mode {
 	PD_MODE_V2,
 };
 
+/* Track dev_data/PASID list for the protection domain */
+struct pdom_dev_data {
+	/* Points to attached device data */
+	struct iommu_dev_data *dev_data;
+	/* PASID attached to the protection domain */
+	ioasid_t pasid;
+	/* For protection_domain->dev_data_list */
+	struct list_head list;
+};
+
 /*
  * This structure contains generic data for  IOMMU protection domains
  * independent of their use.
@@ -576,6 +593,8 @@ struct protection_domain {
 	bool dirty_tracking;	/* dirty tracking is enabled in the domain */
 	unsigned dev_cnt;	/* devices assigned to this domain */
 	unsigned dev_iommu[MAX_IOMMUS]; /* per-IOMMU reference count */
+
+	struct list_head dev_data_list; /* List of pdom_dev_data */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 6f5900333946..703f2c081ed0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -196,11 +196,6 @@ static struct amd_iommu *rlookup_amd_iommu(struct device *dev)
 	return __rlookup_amd_iommu(seg, PCI_SBDF_TO_DEVID(devid));
 }
 
-static struct protection_domain *to_pdomain(struct iommu_domain *dom)
-{
-	return container_of(dom, struct protection_domain, domain);
-}
-
 static struct iommu_dev_data *alloc_dev_data(struct amd_iommu *iommu, u16 devid)
 {
 	struct iommu_dev_data *dev_data;
@@ -346,6 +341,13 @@ static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
 	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
 }
 
+inline bool amd_iommu_pdev_pri_supported(struct pci_dev *pdev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(&pdev->dev);
+
+	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PRI_SUP);
+}
+
 static u32 pdev_get_caps(struct pci_dev *pdev)
 {
 	int features;
@@ -2309,6 +2311,7 @@ static struct protection_domain *protection_domain_alloc(unsigned int type)
 
 	spin_lock_init(&domain->lock);
 	INIT_LIST_HEAD(&domain->dev_list);
+	INIT_LIST_HEAD(&domain->dev_data_list);
 	domain->nid = NUMA_NO_NODE;
 
 	switch (type) {
@@ -2838,6 +2841,7 @@ const struct iommu_ops amd_iommu_ops = {
 	.def_domain_type = amd_iommu_def_domain_type,
 	.dev_enable_feat = amd_iommu_dev_enable_feature,
 	.dev_disable_feat = amd_iommu_dev_disable_feature,
+	.remove_dev_pasid = amd_iommu_remove_dev_pasid,
 	.page_response = amd_iommu_page_response,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= amd_iommu_attach_device,
diff --git a/drivers/iommu/amd/pasid.c b/drivers/iommu/amd/pasid.c
new file mode 100644
index 000000000000..6b9d1917aa4c
--- /dev/null
+++ b/drivers/iommu/amd/pasid.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2024 Advanced Micro Devices, Inc.
+ */
+
+#define pr_fmt(fmt)     "AMD-Vi: " fmt
+#define dev_fmt(fmt)    pr_fmt(fmt)
+
+#include <linux/iommu.h>
+#include <linux/mm_types.h>
+
+#include "amd_iommu.h"
+
+static inline bool is_gcr3_table_empty(struct iommu_dev_data *dev_data)
+{
+	return (dev_data->gcr3_info.pasid_cnt == 0);
+}
+
+static inline bool is_pasid_enabled(struct iommu_dev_data *dev_data)
+{
+	if (dev_data->gcr3_info.gcr3_tbl != NULL &&
+	    !is_gcr3_table_empty(dev_data)) {
+		return true;
+	}
+
+	return false;
+}
+
+static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
+{
+	struct device *dev = dev_data->dev;
+	int ret = 0;
+
+	spin_lock(&dev_data->lock);
+
+	if (is_pasid_enabled(dev_data))
+		goto out;
+
+	if (!amd_iommu_pasid_supported()) {
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* attach_device path enables device PASID feature */
+	if (!dev_data->pasid_enabled) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	ret = amd_iommu_gcr3_init(dev_data, dev->iommu->max_pasids);
+
+out:
+	spin_unlock(&dev_data->lock);
+	return ret;
+}
+
+static void iommu_pasid_disable(struct iommu_dev_data *dev_data)
+{
+	spin_lock(&dev_data->lock);
+
+	if (!is_gcr3_table_empty(dev_data))
+		goto out;
+
+	if (dev_data->gcr3_info.gcr3_tbl == NULL)
+		goto out;
+
+	amd_iommu_gcr3_uninit(dev_data);
+
+out:
+	spin_unlock(&dev_data->lock);
+}
+
+static int iommu_setup_pasid_pri(struct iommu_dev_data *dev_data)
+{
+	struct pci_dev *pdev;
+	int ret;
+
+	if (is_pasid_enabled(dev_data))
+		return 0;
+
+	ret = iommu_pasid_enable(dev_data);
+	if (ret)
+		return ret;
+
+	pdev = dev_is_pci(dev_data->dev) ? to_pci_dev(dev_data->dev) : NULL;
+	if (!pdev || !amd_iommu_pdev_pri_supported(pdev))
+		return 0;
+
+	if (!dev_data->pri_enabled)
+		return -EINVAL;
+
+	ret = amd_iommu_iopf_enable_device(dev_data->dev);
+
+	return ret;
+}
+
+static void remove_dev_pasid(struct pdom_dev_data *pdom_dev_data)
+{
+	/* Update GCR3 table and flush IOTLB */
+	amd_iommu_clear_gcr3(pdom_dev_data->dev_data, pdom_dev_data->pasid);
+
+	list_del(&pdom_dev_data->list);
+	kfree(pdom_dev_data);
+}
+
+/* Clear PASID from device GCR3 table and remove pdom_dev_data from list */
+static void remove_pdom_dev_pasid(struct protection_domain *pdom,
+				  struct device *dev, ioasid_t pasid)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+
+	lockdep_assert_held(&pdom->lock);
+
+	for_each_pdom_dev_data(pdom_dev_data, pdom) {
+		if (pdom_dev_data->dev_data == dev_data &&
+		    pdom_dev_data->pasid == pasid) {
+			remove_dev_pasid(pdom_dev_data);
+			break;
+		}
+	}
+}
+
+int iommu_sva_set_dev_pasid(struct iommu_domain *domain,
+			    struct device *dev, ioasid_t pasid)
+{
+	struct pdom_dev_data *pdom_dev_data;
+	struct protection_domain *sva_pdom = to_pdomain(domain);
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	unsigned long flags;
+	int ret = -EINVAL;
+
+	/* PASID zero is used for requests from the I/O device without PASID */
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return ret;
+
+	/* Make sure PASID/PRI is enabled */
+	ret = iommu_setup_pasid_pri(dev_data);
+	if (ret)
+		return ret;
+
+	/* Add PASID to protection domain pasid list */
+	pdom_dev_data = kzalloc(sizeof(*pdom_dev_data), GFP_KERNEL);
+	if (pdom_dev_data == NULL)
+		return ret;
+
+	pdom_dev_data->pasid = pasid;
+	pdom_dev_data->dev_data = dev_data;
+
+	/* Setup GCR3 table */
+	ret = amd_iommu_set_gcr3(dev_data, pasid,
+				 iommu_virt_to_phys(domain->mm->pgd));
+	if (ret) {
+		kfree(pdom_dev_data);
+		return ret;
+	}
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+	list_add(&pdom_dev_data->list, &sva_pdom->dev_data_list);
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+
+	return ret;
+}
+
+void amd_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
+{
+	struct protection_domain *sva_pdom;
+	struct iommu_domain *domain;
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	unsigned long flags;
+
+	if (pasid == 0 || pasid >= dev->iommu->max_pasids)
+		return;
+
+	/* Get protection domain */
+	domain = iommu_get_domain_for_dev_pasid(dev, pasid, IOMMU_DOMAIN_SVA);
+	if (!domain)
+		return;
+	sva_pdom = to_pdomain(domain);
+
+	spin_lock_irqsave(&sva_pdom->lock, flags);
+
+	/* Remove PASID from dev_data_list */
+	remove_pdom_dev_pasid(sva_pdom, dev, pasid);
+
+	/* Remove GCR3 table */
+	if (is_gcr3_table_empty(dev_data))
+		iommu_pasid_disable(dev_data);
+
+	spin_unlock_irqrestore(&sva_pdom->lock, flags);
+}
-- 
2.31.1

