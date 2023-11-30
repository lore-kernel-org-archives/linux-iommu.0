Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27EB1872;
	Thu, 30 Nov 2023 01:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nCc8Hu+T"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WyNKAjLM/vSKVV26Xs+P1qB+d5IznyrTbhYHYLS00vO8ea4jBExouryseSO/YOmK0h6Bj4whyznyiaey3h5t/LPaMf3/7J0ahYhmeP7cURpkT5mQIhrH/YuMjwLWrE4FDo++4bGkH/s5LhnHWiLfgooUd8od5VT0FaQxscC7Kz2iZtbsslMS0m7hoMLTCmk886KcXPGuartyGbQKAwRheuTADvhvnqhNggLPyL1TDF4x8I2qt07FPySdmfsDhpfbQfzOY8dKf2hm1t7tOU7CZLef2KSA64eIxjJVO02BMmAinQktsJ7DUFPDKpZbxE+fv33mlKMFmVT0rnS07gZoIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XwJ+G8korP3D4LufwIZ/Z16nvSXw1vjgiBys05/mYhQ=;
 b=m5q2ygerkpyQ1iMDrPiHD8uV5CiryNKzdb4uz07Fzth3PthksBADJA5ToCziXSAjASMsI393CvPKDIxVj7ifBMXi/O0U66LH/hU1kVkItUchtKWh5TnlgWALhV+xZLwelTz1TCZJkNAO0ZkYmGiA31GZJKGuQG3FsZ3p47P5w8VmaEIzSfDYmDb+Uf0brRPS50jgb+bONf21CDNTmXOlI5YbtDabgorKxpmpTl99ZDLxmsy12MZGeVWO5Ysws0PZTWgzFUmvfLmx9vx2cskCDFH9XWji+1WLSjafpjghOygZsApgiIO/a2gWjNOiNqOcMq47qbaSdXO44YtWBRLMhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XwJ+G8korP3D4LufwIZ/Z16nvSXw1vjgiBys05/mYhQ=;
 b=nCc8Hu+T+61xbVRDIagKTpcvsee0EztH/IkdYYfTDd5agHmCjVEhtqwsJg6DxmQvcFl7M/4E0F6LfzIOXiL4LSztrL6pwXbGQnnPsCtm07QMaNszC2o4VV0A8bzZ56Nzds0dNRyqGZxABWXcLtNcuKYnvVLYJwFVvo1eFEGulMafm+YwF2wpmOwDGViadg4QWLVJ0JY+fz2YG0MdPEKxBk+sbZiV8QdtVgRcwVCL6sKD1AP6fqwqP1mLRuCPNCNwDRizkY4v9T5HAhZVkMgDWIYWhHnmbk5HLzOHeoy29C/VClZB4TWlCXIUhZAa2fioOMuTXesAym9xKcDHPXQsoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:39 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 26/30] iommu/arm-smmu-v3: Move to iommu_fw_alloc_per_device_ids()
Date: Wed, 29 Nov 2023 21:14:26 -0400
Message-ID: <26-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR03CA0029.namprd03.prod.outlook.com
 (2603:10b6:806:20::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d35d6ad-cae1-4967-cb73-08dbf141b63e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	5KziSofXkSD64q6hEP6/sRMoSanN4+xGbQhp1AhOUF7C+oYtCp3BoF4kpCBJgAAexYAYawsZA/j0GNP5JKJWf1ji6QgUL5oD60kaIeLK1uD7gntJhLMr4PJHW2GR3O0GuaBDC09JO4crDG8osGK25W0HnfUtOe0d4F27SH956XzW75ADecbZzdGUlFAyO/iqA3iMF5kPBOAzMmDAIgWlsdsfKEj8yDLqRhZTAvSoO7nYKHK5wlk8j7HDuA3UU5g/XMMnfe5v/hrfwFGV+baErB9y+3IzJVVapjgBhdUjzUg13WtQ9zYlO/w0fHKayAQ2OXPxYJ6wevKWNEpcIwL+0+B3t6KXQobBOBMW3UJUDwg/ASTy0M7e4hCi9Yl6ynYzD9/qA4KVHJrqjrOA794+EhCVOY/UBB66GgANQrws7sRxhWjhwt8YG2tVdGjW8dsUVdlWyiDjPGw3emitFj1UQ5gDQK0yelP+aArlI/Ctz1Nh1XTH3zvzykX5fmnXLE1KZYltF/cCMpJVqIKAzp0Cml4t6DiUizZ4dzgJ1kugcSS+nMbKTM1gQnlGCSaBnhM3q7YX9Zy7FCh1Xze+L3GJSj9U9fovFgZK07lyq/xyZd4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eqalExC/jWh09xpUw3OD6Uc9GCZhNHekF+ze6QQtE3QQk1MNT4Oj7BLqltsu?=
 =?us-ascii?Q?KcTdMRshiCkYHW0yzrf6TpJZ5vPCPDqLbU9/Ga4oYp7uQzgzZE6VyE++l44i?=
 =?us-ascii?Q?H7bdaEvSg+SchLYcnymDTn9BACGwOrBVoGbNU2upYFYXNoTtv1CRDhKuQI7f?=
 =?us-ascii?Q?IvCr5yJjqAzGgAgpa/nMcDe/FcRGheffC4v5DKAiak0XtAFP8Qw4YGfCbD3U?=
 =?us-ascii?Q?VMl0k5PV/E5kDtakRHX9iJLDq+9v+8evP8/3CZDG8s8GlHv+CcXYR3G2gC8y?=
 =?us-ascii?Q?JDxtzYzqn2PR/MMXoKinoqK0+iIjoKwqcCAV7KpTyW9z2pOuqfmG1FPANlk0?=
 =?us-ascii?Q?wCFmYoU7h5cryO4HXIVdSUvqy47PVGQ/qhycsDg8/Dr64bwwrGPDtESQtMz4?=
 =?us-ascii?Q?GEwSI1HCxnXhrZVzYMNtQpIf63M7V4kcu7R2wot1LDtqaso06Z0WYlhYvBKg?=
 =?us-ascii?Q?kOZNZXY1615HNVUkQVwiOVliljUPe9WqYtnizVC9wtJCGhUB6grsXY45syIE?=
 =?us-ascii?Q?aBZ9z22Swzchx4ev+N7DtT2+yVupXO97sOBvgrZqRNx3kCgoQdgiZN7iwSYR?=
 =?us-ascii?Q?gaXm20soz6h7GaiH8Ab45SHAyRW1nqcOgP2hU3iGbFhmEDKpBxpTxVmm30kK?=
 =?us-ascii?Q?sqYaTOyKXr12HN7zVN9wsjzgs+Kg6Wk/aDyka3M7u6V1n4SYVcw6JhqyVpSL?=
 =?us-ascii?Q?m71W/hMLGwbJDfNHAz6HfAQIESaFeIG9LEJfVCu6RnN6VMxSX1NsXDABD+yf?=
 =?us-ascii?Q?FbPoWQGb/ZsOiy0IRtbDVUOQUnqxFioM4jchLpa5hKZZ6fIA5bbgVqQ2qMd8?=
 =?us-ascii?Q?T91A+f0VhvrI0dcMtMy1a7/gugJKgrGwkBUcadPmOI58VjHpdtExysaF1n6B?=
 =?us-ascii?Q?ekStUDvzTjblU0e9iK44TKPZUq1NGqh5+u44IHt1eA3duXu2u1JphEu6P05N?=
 =?us-ascii?Q?0kGjRtPQSwdE2yKGUl7LhUfKC8JnPeM0+Zpa/NgaFqJGwkJUpZAdMkfIQeQo?=
 =?us-ascii?Q?7UNHOwHjbxsemNerJj2UNwVGKnXJqnZaM6vdWVaePbHUQ5cr2i1zZJnBViZ9?=
 =?us-ascii?Q?XG1V1tDGTFR38HiOrTBrJtXe2D7GmC7BG1OmMg7jKZJOzXoP3n7VBqA9v+L3?=
 =?us-ascii?Q?mcU8Shak4iedWHmiJCDKbBG5u01dCZb8KaEn6XuDkRduR5aNcV1i/GgCl+C4?=
 =?us-ascii?Q?Ax6dDDd6lVgLN7ahF7po2eqcLpQuXd5O8XhqpxprnZA2d0viYxvDY7joUvG8?=
 =?us-ascii?Q?3WUuv5WQuyqqlJf3j9mOl49Ua4dPSZsQpBqXwcNxYPCVWSGTkwjfHJfFyz+i?=
 =?us-ascii?Q?L7JwRMuzzsiMSkmT3zKfs5DqBbXNyDbO2zwwhbwzGujL4W0n0UTs3pjSIbri?=
 =?us-ascii?Q?AESUmEHAxHXrjOjNvJYGpJJGdaUhlMAbuIhaR7bk5UJJIfMaNtetZ85WOLNC?=
 =?us-ascii?Q?rM+5irugmPmeCDx/YtuJzNxXDDjZ6Gg2kjKfZpMgMWUq9UFYWUU9uzrgE4Yr?=
 =?us-ascii?Q?jDMIc23xzMXjyiNe/HPwpgj5u/R3rrjBoGVoc3sDeOOBcuZh1VK3iiosiZkP?=
 =?us-ascii?Q?l9ubh80tWvjfw5bBOhSzRu8dwp0XO0JSjDMR6LXL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d35d6ad-cae1-4967-cb73-08dbf141b63e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.7622
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Uli80+p2Fa3MqFBmm9GBkGJLC7qZc2Bl6dS8hf73AtZSVV30OhDswYUOYPgVCRVW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

SMMUv3 supports a single iommu instance with multiple ids.

It has a combined ACPI (via the IORT table) and OF probe path, add
iommu_iort_get_single_iommu() to respresent this.

It already has a per-instance structure, extend it with the ids[]
array and use iommu_fwb_alloc_per_device_ids() to populate it.

Convert the rest of the funcs from calling dev_iommu_fwspec_get() to using
the per-device data and remove all use of fwspec.

Directly call iort_iommu_get_resv_regions() and pass in the internal id
array instead of getting it from the fwspec.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c                   |  2 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 74 +++++++++------------
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  4 ++
 include/linux/iommu-driver.h                |  2 +-
 4 files changed, 35 insertions(+), 47 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 6b2d50cc9ac180..acd2e48590f37a 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1297,8 +1297,6 @@ static void iort_named_component_init(struct device *dev,
 	props[0] = PROPERTY_ENTRY_U32("pasid-num-bits",
 				      FIELD_GET(ACPI_IORT_NC_PASID_BITS,
 						nc->node_flags));
-	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
-		props[1] = PROPERTY_ENTRY_BOOL("dma-can-stall");
 
 	if (device_create_managed_software_node(dev, props, NULL))
 		dev_warn(dev, "Could not add device properties\n");
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1855d3892b15f8..1a43c677e2feaf 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -26,9 +26,9 @@
 #include <linux/pci.h>
 #include <linux/pci-ats.h>
 #include <linux/platform_device.h>
+#include <linux/iommu-driver.h>
 
 #include "arm-smmu-v3.h"
-#include "../../dma-iommu.h"
 #include "../../iommu-sva.h"
 
 static bool disable_bypass = true;
@@ -2255,12 +2255,11 @@ static bool arm_smmu_ats_supported(struct arm_smmu_master *master)
 {
 	struct device *dev = master->dev;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	if (!(smmu->features & ARM_SMMU_FEAT_ATS))
 		return false;
 
-	if (!(fwspec->flags & IOMMU_FWSPEC_PCI_RC_ATS))
+	if (!master->pci_rc_ats)
 		return false;
 
 	return dev_is_pci(dev) && pci_ats_supported(to_pci_dev(dev));
@@ -2382,14 +2381,10 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
 {
 	int ret = 0;
 	unsigned long flags;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_domain *smmu_domain = to_smmu_domain(domain);
 	struct arm_smmu_master *master;
 
-	if (!fwspec)
-		return -ENOENT;
-
 	master = dev_iommu_priv_get(dev);
 	smmu = master->smmu;
 
@@ -2529,15 +2524,6 @@ arm_smmu_iova_to_phys(struct iommu_domain *domain, dma_addr_t iova)
 
 static struct platform_driver arm_smmu_driver;
 
-static
-struct arm_smmu_device *arm_smmu_get_by_fwnode(struct fwnode_handle *fwnode)
-{
-	struct device *dev = driver_find_device_by_fwnode(&arm_smmu_driver.driver,
-							  fwnode);
-	put_device(dev);
-	return dev ? dev_get_drvdata(dev) : NULL;
-}
-
 static bool arm_smmu_sid_in_range(struct arm_smmu_device *smmu, u32 sid)
 {
 	unsigned long limit = smmu->strtab_cfg.num_l1_ents;
@@ -2568,17 +2554,16 @@ static int arm_smmu_insert_master(struct arm_smmu_device *smmu,
 	int ret = 0;
 	struct arm_smmu_stream *new_stream, *cur_stream;
 	struct rb_node **new_node, *parent_node = NULL;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
-	master->streams = kcalloc(fwspec->num_ids, sizeof(*master->streams),
+	master->streams = kcalloc(master->num_ids, sizeof(*master->streams),
 				  GFP_KERNEL);
 	if (!master->streams)
 		return -ENOMEM;
-	master->num_streams = fwspec->num_ids;
+	master->num_streams = master->num_ids;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++) {
-		u32 sid = fwspec->ids[i];
+	for (i = 0; i < master->num_ids; i++) {
+		u32 sid = master->ids[i];
 
 		new_stream = &master->streams[i];
 		new_stream->id = sid;
@@ -2627,13 +2612,12 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 {
 	int i;
 	struct arm_smmu_device *smmu = master->smmu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(master->dev);
 
 	if (!smmu || !master->streams)
 		return;
 
 	mutex_lock(&smmu->streams_mutex);
-	for (i = 0; i < fwspec->num_ids; i++)
+	for (i = 0; i < master->num_ids; i++)
 		rb_erase(&master->streams[i].node, &smmu->streams);
 	mutex_unlock(&smmu->streams_mutex);
 
@@ -2642,26 +2626,27 @@ static void arm_smmu_remove_master(struct arm_smmu_master *master)
 
 static struct iommu_ops arm_smmu_ops;
 
-static struct iommu_device *arm_smmu_probe_device(struct device *dev)
+static struct iommu_device *arm_smmu_probe_device(struct iommu_probe_info *pinf)
 {
 	int ret;
+	struct device *dev = pinf->dev;
 	struct arm_smmu_device *smmu;
 	struct arm_smmu_master *master;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iort_params params;
 
-	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
-		return ERR_PTR(-EBUSY);
+	smmu = iommu_iort_get_single_iommu(pinf, &arm_smmu_ops, &params,
+					   struct arm_smmu_device, iommu);
+	if (IS_ERR(smmu))
+		return ERR_CAST(smmu);
 
-	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
-	if (!smmu)
-		return ERR_PTR(-ENODEV);
-
-	master = kzalloc(sizeof(*master), GFP_KERNEL);
-	if (!master)
-		return ERR_PTR(-ENOMEM);
+	master = iommu_fw_alloc_per_device_ids(pinf, master);
+	if (IS_ERR(master))
+		return ERR_CAST(master);
 
 	master->dev = dev;
 	master->smmu = smmu;
+	master->pci_rc_ats = params.pci_rc_ats;
+	master->acpi_fwnode = iommu_fw_acpi_fwnode(pinf);
 	INIT_LIST_HEAD(&master->bonds);
 	dev_iommu_priv_set(dev, master);
 
@@ -2670,7 +2655,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 		goto err_free_master;
 
 	device_property_read_u32(dev, "pasid-num-bits", &master->ssid_bits);
-	master->ssid_bits = min(smmu->ssid_bits, master->ssid_bits);
+	master->ssid_bits = min(smmu->ssid_bits,
+				max(params.pasid_num_bits, master->ssid_bits));
 
 	/*
 	 * Note that PASID must be enabled before, and disabled after ATS:
@@ -2687,7 +2673,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 					  CTXDESC_LINEAR_CDMAX);
 
 	if ((smmu->features & ARM_SMMU_FEAT_STALLS &&
-	     device_property_read_bool(dev, "dma-can-stall")) ||
+	     (device_property_read_bool(dev, "dma-can-stall") ||
+	      params.dma_can_stall)) ||
 	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
 		master->stall_enabled = true;
 
@@ -2744,14 +2731,10 @@ static int arm_smmu_enable_nesting(struct iommu_domain *domain)
 	return ret;
 }
 
-static int arm_smmu_of_xlate(struct device *dev, struct of_phandle_args *args)
-{
-	return iommu_fwspec_add_ids(dev, args->args, 1);
-}
-
 static void arm_smmu_get_resv_regions(struct device *dev,
 				      struct list_head *head)
 {
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
 	struct iommu_resv_region *region;
 	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
 
@@ -2762,7 +2745,10 @@ static void arm_smmu_get_resv_regions(struct device *dev,
 
 	list_add_tail(&region->list, head);
 
-	iommu_dma_get_resv_regions(dev, head);
+	if (master->acpi_fwnode)
+		iort_iommu_get_resv_regions(dev, head, master->acpi_fwnode,
+					    master->ids, master->num_ids);
+	of_iommu_get_resv_regions(dev, head);
 }
 
 static int arm_smmu_dev_enable_feature(struct device *dev,
@@ -2851,10 +2837,10 @@ static void arm_smmu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
 static struct iommu_ops arm_smmu_ops = {
 	.capable		= arm_smmu_capable,
 	.domain_alloc		= arm_smmu_domain_alloc,
-	.probe_device		= arm_smmu_probe_device,
+	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= arm_smmu_of_xlate,
+	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 961205ba86d25d..ac293265b21a13 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -692,6 +692,7 @@ struct arm_smmu_stream {
 struct arm_smmu_master {
 	struct arm_smmu_device		*smmu;
 	struct device			*dev;
+	struct fwnode_handle            *acpi_fwnode;
 	struct arm_smmu_domain		*domain;
 	struct list_head		domain_head;
 	struct arm_smmu_stream		*streams;
@@ -702,8 +703,11 @@ struct arm_smmu_master {
 	bool				stall_enabled;
 	bool				sva_enabled;
 	bool				iopf_enabled;
+	bool				pci_rc_ats;
 	struct list_head		bonds;
 	unsigned int			ssid_bits;
+	unsigned int			num_ids;
+	u32				ids[] __counted_by(num_ids);
 };
 
 /* SMMU private data for an IOMMU domain */
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index c4e133cdef2c78..8f7089d3bb7135 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -252,6 +252,6 @@ __iommu_iort_get_single_iommu(struct iommu_probe_info *pinf,
 						       pinf, ops, params),    \
 					       __iommu_of_get_single_iommu(   \
 						       pinf, ops, -1)),       \
-				 drv_struct, member)                          \
+				 drv_struct, member);                         \
 	})
 #endif
-- 
2.42.0

