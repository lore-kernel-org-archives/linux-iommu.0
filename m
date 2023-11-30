Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D4805C98;
	Thu, 30 Nov 2023 01:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="M0kgaMc6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JV8tR0AhZEpNrFHRUr6aW5vfbaLybm9cVq7Nn408IzkxCrAbpnQLGVzf395EZ8h5qEW/vOG1y79bYOMHRnt3QBaun99or312w7AGU/iASvgYOPOjvfstY7R6uoj3Y+ShZWoAMPAfDNU2aW+8VK+Sl3frv9wYdsCCc8dM864j6cwxPOoi6oFwZ0dPazhqw7Q5Rstv08DHwbce3KUPA9XKhbGMFva4ofiFtfVLyc2lzQkvZC7KxfGjKjjukgGa3Ik94Bb01yvWPe+jku90OlzaADDNgciju1+Dk62SzXag2ElkYfB5hk59kuilRJLAfuUx9PLyao5l4cKnm7jgVueP9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29OOCCTk8mlu6NkZfaPP6EDcpKq/iCHGfu7Wm1bl1pw=;
 b=XhxdFK82Y9WHBtt2BiSP0puOV1tszgsMvzWNgi22SvV7h7ACfH0nl4I6nF+Ibo/VSxIPa8oX2HIMQj26ZtOqTpztvgxpeYS1IcPGyw8fA+Mw4NWUkHVeaSqEZZFB+gdRcWN+AEYN1MYO90ije3GWOpzgOBkFBc6nN5Mlj5L4MChI/Ly9+ji82X/QiHOGRzM8pzsb2o/KyN6s71eUit32KDNpTW+fG2r2/u+9YUOmr3VyL7ehTqfIMXDnT3ee2TmSccx8p83wHzr+30gpdCJ5/uO9BHuZm8gkxcmEN1TFdgIunwmlFYaNEPkhmO5oaYdYiCi2dXth3nQfobIjfPrX+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29OOCCTk8mlu6NkZfaPP6EDcpKq/iCHGfu7Wm1bl1pw=;
 b=M0kgaMc6Wpzjkt/P0PaX/eeV/4bUdDI1poqaJk6nJta1lxwaxEKHtLpyFuLFr/WnDSEHU2WIQS18uoyeqZkZvRgnBIBaXoVrM6Qbvavn4kShiQR9BATYSjjc76OiS5xfztuQGR7YawG07AkQ2crZ0Cqn+eMzwZn9jUUU7KFoQ272x7LrmRiv7nRlStDDeZcOHBgEo8+fddIiuEjwzmduhlIpAKH2U75I5wbr2OtDMhQAXc+SgH5pHQuMUd73kCtWJ1ql6pHgcvjyYW8q0roIfAsL+8GMBKqhMk5rR0c2JWxkWz+rnutgOfT+WKcOS5qXEOMFRogsWE/x3rrso2M+/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:43 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:43 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 30/30] iommu: Remove fwspec and related
Date: Wed, 29 Nov 2023 21:14:30 -0400
Message-ID: <30-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0054.namprd16.prod.outlook.com
 (2603:10b6:805:ca::31) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1088852f-e9b3-4c23-fd08-08dbf141b75b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	MqgneFahdAyYFY37BT1Hb9RPZOIKhHCMCT6Nn26PbNHhPtfX9sMc8CEJTPFe/Qs1d2fZt5CmBpwsT9ly4Nx3CcBHzg0pWXKLH+2ZpSIpY2CKNhHX5Q9vi3gyhf9MTzSmJarjdlmN3maZAeDVCMdlVdWhCocLDvQHVdMFvFie/JyC6K1FTQUl3zveM7hE/zDvcenIEOn2sLdhcpUvVjewUgba9F98cOB/pwmVFdv9zkaPl5/JoOkq6fHjvUcnm9GX19QE65mFRruo6VFKIdeBTlSpMGH3XqFznovSxYYGm2bh/CQxbv6f5mloGhA7aOcgi5dxW0RTjvvRqSIAKkaQ8fzpEj8jWLydKzu814EtkHUKAKWGVq9ta+vlGVs7/216iUNidrIkqZiX6ryZ1hI8mHHh1Rx20EhlEU7ijingaiock10ZkbY15yKpmjb72Mhu1HpyjWFd8iPUH/Evb1IU8JVyeSa9R5ST175nzmDvdw+81rYmOff4GI87iWrLXISPvykHM5QbVZACSdDlmf3/Pqp9OQFRWyOkjEMUSS7gVcspPk6O21PXKbqPbL9igMLRxpD7X2W1zNRYofSAnu55hXURhvdqU5k0vxx7eXukq6A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(30864003)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jBWW31eqRd8ysvlaXV1EcvsnkVw34BVpj78/ykhjbkhrYI4wLJid1tPLt1lI?=
 =?us-ascii?Q?NCVnD8WRqm/xbPXpkmjHljak0a6RTAJ6n82r1PnvEPei7Sf2rzE7f+0uF7tC?=
 =?us-ascii?Q?YRBIWqu2jORHaCqvkvcSmNLcfCZ/nQjPzXQqsSCqo5LMl+cIyRnBXXvHV8EU?=
 =?us-ascii?Q?xsd6HHkCNE+yeg7bJL0XEXvi9KNnwohQP7IPCnn0J+F5c3aw6TlV1pcZ+Dc2?=
 =?us-ascii?Q?nbcpvy6aOAXfNstUI7tg2vDVLx1nMunqreWIyzjB3jrUyw2QIrr1lliyyF83?=
 =?us-ascii?Q?m7UhimG2ZleCUH+YQBXbaYsaX8ilfUShTnwUGHnRYXFAtLfyXynPZ+41+ZSe?=
 =?us-ascii?Q?BjFGxUkDuRHqsYFlxOKuZsqOm3nwsl1OFalcthiSoTkxhCf9EA4y6vkD88T4?=
 =?us-ascii?Q?oImzWJwNPAhZVbCkUswt0pFzHLeZ+9RsvmYB1Ok50GaTNUJ5R6Y2T7noS3Fc?=
 =?us-ascii?Q?WR0qG4Zs11uUNKqbpCIW4lYe/ZBGB/HUrngFm69AfuPyZXCC1nPrdidhMcre?=
 =?us-ascii?Q?aBLb/ig2+4DMhvGnGCqgX7J79IEofkmkNqSD1uChfnYNlEsmR1VRQYJvxrPS?=
 =?us-ascii?Q?FPub5TQiX4UxOKObsqbH0W5s25a4xGxXPaFOaJ/3/lpGEFpZ/q8xhNW6D5vB?=
 =?us-ascii?Q?wFPkM/8+X4F5QAkj4PWO/ZAXpV/8WgDWDE5leMlTgFhq6SLkTcuNMDD5Jh27?=
 =?us-ascii?Q?N/F8tlB+3nb2XF7zLxQ4R8wdrZpUf/krkcsN8VonWT4RMxkmdR1/wLKCj9KZ?=
 =?us-ascii?Q?qblrbw/3N/1UG/uRRO7YVLvtAwP0awTk3ul8rfi7t6MVTMY1DdKULC7tSpVr?=
 =?us-ascii?Q?sKirA4p2nxwPm5EffVSMkXQyFsyHwK6W+0c3jAxtg/g+kXGX7Hadradtu4t0?=
 =?us-ascii?Q?t/fdVTjAFhohnBzAHq34JTSBfJDdUTmh6VF27OEbaKuUnV1uGCUrDqA33nRE?=
 =?us-ascii?Q?2kY+6C2iCvfCG9E3qcX2lxa1JGSXXHyb45uLKaCif9nhzqarSFP5mpJKsJyI?=
 =?us-ascii?Q?yQdZb1e5wHn976uly0ThiRIA7sAfGU7SXaO6d+6e0Lc9EVQ+vqVYY/Gzh/hk?=
 =?us-ascii?Q?0osZJ2m4adgaaqnIji3kc3pL02NZ0a9BpT2qqMkl13Uhyi+czFqbP470z/Sn?=
 =?us-ascii?Q?+0wXlGKTBJG9ts6wkgOkBsYsvTkputS5dFKBZp+Ec1o1cadOHX7/KYxFmQ1D?=
 =?us-ascii?Q?deoPs7M5SU/S1nukHRcVXxiJCmhTuyOaGpkVOGpUyx/GbLQWK0pn9UO7Rvzi?=
 =?us-ascii?Q?esqEBidTyteYKuqjAMN6k/zAynWLPGErWjU8n65NWo6+d7r05l4uQvCpi0yD?=
 =?us-ascii?Q?WU96ZdjRpSVYVYRpnfxU+ok3i6uejmtaxSTr7DvwnasY5sgx704MVu4wWGP5?=
 =?us-ascii?Q?JnALAaA9JgYNZkf7oAbraps1eO6MIWdoWJfO1qr9sZdGUaNBEJ7I/Lns+6i9?=
 =?us-ascii?Q?lWEakXA5RGWcbE4h2MCdKXaumpPzJsORtzcD3ZwpkOyAp2ffut65nTeYBjV1?=
 =?us-ascii?Q?jcOslMH8X+CfdGbHGVDS2vgs2HDRkiZ9M4kbRkoYDLGWibQdJ4TKLLMCrFhn?=
 =?us-ascii?Q?woIEoDJU87dD/gma+K1bkytN+sqHCiFA1YY7SqRa?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1088852f-e9b3-4c23-fd08-08dbf141b75b
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.6759
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GHI7L30jKf3Ea2zFum7PhS/5JxGuiTSzoQ+htj0KhoipxGa+DCw/tBKBhsQEstK7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Delete all the now unused code connected to fwspec.

Remove all IOMMU related FW parsing from the *_dma_configure() functions.

Remove no longer needed includes of iommu-driver.h in the ACPI code.

Return the iommu_probe_device_lock back to being a static inside iommu.c

Make __iommu_probe_device() rely on iommu_find_init_device() for
everything.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c                   | 76 ----------------
 drivers/acpi/scan.c                         | 52 +----------
 drivers/acpi/viot.c                         | 32 -------
 drivers/iommu/apple-dart.c                  |  1 -
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  1 -
 drivers/iommu/arm/arm-smmu/arm-smmu.c       |  1 -
 drivers/iommu/arm/arm-smmu/qcom_iommu.c     |  1 -
 drivers/iommu/dma-iommu.c                   | 24 -----
 drivers/iommu/dma-iommu.h                   |  6 --
 drivers/iommu/exynos-iommu.c                |  1 -
 drivers/iommu/iommu.c                       | 97 +--------------------
 drivers/iommu/ipmmu-vmsa.c                  |  1 -
 drivers/iommu/msm_iommu.c                   |  1 -
 drivers/iommu/mtk_iommu.c                   |  1 -
 drivers/iommu/of_iommu.c                    | 47 ----------
 drivers/iommu/rockchip-iommu.c              |  1 -
 drivers/iommu/sprd-iommu.c                  |  1 -
 drivers/iommu/sun50i-iommu.c                |  1 -
 drivers/iommu/tegra-smmu.c                  |  1 -
 drivers/iommu/virtio-iommu.c                |  1 -
 include/acpi/acpi_bus.h                     |  3 -
 include/linux/acpi_iort.h                   |  3 -
 include/linux/acpi_viot.h                   |  5 --
 include/linux/iommu-driver.h                | 10 ---
 include/linux/iommu.h                       | 70 ---------------
 25 files changed, 8 insertions(+), 430 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index acd2e48590f37a..8457874c789456 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -796,8 +796,6 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
-#include <linux/iommu-driver.h>
-
 static void iort_rmr_free(struct device *dev,
 			  struct iommu_resv_region *region)
 {
@@ -1218,19 +1216,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 }
 EXPORT_SYMBOL_GPL(iort_put_rmr_sids);
 
-static inline bool iort_iommu_driver_enabled(u8 type)
-{
-	switch (type) {
-	case ACPI_IORT_NODE_SMMU_V3:
-		return IS_ENABLED(CONFIG_ARM_SMMU_V3);
-	case ACPI_IORT_NODE_SMMU:
-		return IS_ENABLED(CONFIG_ARM_SMMU);
-	default:
-		pr_warn("IORT node type %u does not describe an SMMU\n", type);
-		return false;
-	}
-}
-
 static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 {
 	struct acpi_iort_root_complex *pci_rc;
@@ -1239,36 +1224,6 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
-static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
-			    void *info)
-{
-	struct device *dev = info;
-	struct iommu_device *iommu;
-	struct fwnode_handle *iort_fwnode;
-
-	if (!node)
-		return -ENODEV;
-
-	iort_fwnode = iort_get_fwnode(node);
-	if (!iort_fwnode)
-		return -ENODEV;
-
-	/*
-	 * If the iommu look-up fails, this means that either
-	 * the SMMU drivers have not been probed yet or that
-	 * the SMMU drivers are not built in the kernel;
-	 * Depending on whether the SMMU drivers are built-in
-	 * in the kernel or not, defer the IOMMU configuration
-	 * or just abort it.
-	 */
-	iommu = iommu_device_from_fwnode(iort_fwnode);
-	if (!iommu)
-		return iort_iommu_driver_enabled(node->type) ?
-		       -EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, iommu->ops);
-}
-
 struct iort_pci_alias_info {
 	struct device *dev;
 	struct acpi_iort_node *node;
@@ -1380,40 +1335,9 @@ int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
 	iort_named_component_init(dev, node);
 	return 0;
 }
-
-/**
- * iort_iommu_configure_id - Set-up IOMMU configuration for a device.
- *
- * @dev: device to configure
- * @id_in: optional input id const value pointer
- *
- * Returns: 0 on success, <0 on failure
- */
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
-{
-	struct iort_params params;
-	int err;
-
-	err = iort_iommu_for_each_id(dev, id_in, &params, &iort_iommu_xlate,
-				     dev);
-	if (err)
-		return err;
-
-	if (params.pci_rc_ats) {
-		struct iommu_fwspec *fwspec;
-
-		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec)
-			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
-	}
-	return 0;
-}
-
 #else
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 { }
-int iort_iommu_configure_id(struct device *dev, const u32 *input_id)
-{ return -ENODEV; }
 #endif
 
 static int nc_dma_get_range(struct device *dev, u64 *size)
diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index eb7406cdc9a464..c86ac07a7a6420 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1545,29 +1545,9 @@ int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map)
 #ifdef CONFIG_IOMMU_API
 #include <linux/iommu-driver.h>
 
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
-{
-	int ret = iommu_fwspec_init(dev, fwnode, ops);
-
-	if (!ret)
-		ret = iommu_fwspec_add_ids(dev, &id, 1);
-
-	return ret;
-}
-
-static inline const struct iommu_ops *acpi_iommu_fwspec_ops(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	return fwspec ? fwspec->ops : NULL;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	int err;
-	const struct iommu_ops *ops;
 	struct iommu_probe_info pinf = {
 		.dev = dev,
 		.is_dma_configure = true,
@@ -1575,29 +1555,14 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		.is_acpi = true,
 	};
 
-	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
-	/*
-	 * If we already translated the fwspec there is nothing left to do,
-	 * return the iommu_ops.
-	 */
-	ops = acpi_iommu_fwspec_ops(dev);
-	if (ops) {
-		mutex_unlock(&iommu_probe_device_lock);
-		return 0;
-	}
-
-	err = iort_iommu_configure_id(dev, id_in);
-	if (err && err != -EPROBE_DEFER)
-		err = viot_iommu_configure(dev);
-	mutex_unlock(&iommu_probe_device_lock);
-
 	/*
 	 * If we have reason to believe the IOMMU driver missed the initial
 	 * iommu_probe_device() call for dev, replay it to get things in order.
 	 */
-	if (!err && dev->bus)
-		err = iommu_probe_device_pinf(&pinf);
+	if (!dev->bus)
+		return 0;
+
+	err = iommu_probe_device_pinf(&pinf);
 
 	/* Ignore all other errors apart from EPROBE_DEFER */
 	if (err == -EPROBE_DEFER) {
@@ -1606,20 +1571,11 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 		dev_dbg(dev, "Adding to IOMMU failed: %d\n", err);
 		return -ENODEV;
 	}
-	if (!acpi_iommu_fwspec_ops(dev))
-		return -ENODEV;
 	return 0;
 }
 
 #else /* !CONFIG_IOMMU_API */
 
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops)
-{
-	return -ENODEV;
-}
-
 static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
 	return -ENODEV;
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 9780b1d477503e..67b7c4e21eeeb3 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -21,7 +21,6 @@
 #include <linux/acpi_viot.h>
 #include <linux/fwnode.h>
 #include <linux/iommu.h>
-#include <linux/iommu-driver.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -298,26 +297,6 @@ void __init acpi_viot_init(void)
 	acpi_put_table(hdr);
 }
 
-static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
-{
-	struct iommu_device *iommu;
-	struct device *dev = info;
-
-	if (!viommu)
-		return -ENODEV;
-
-	/* We're not translating ourself */
-	if (device_match_fwnode(dev, viommu->fwnode))
-		return -EINVAL;
-
-	iommu = iommu_device_from_fwnode(viommu->fwnode);
-	if (!iommu)
-		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
-			-EPROBE_DEFER : -ENODEV;
-
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, iommu->ops);
-}
-
 struct viot_pci_iommu_alias_info {
 	struct device *dev;
 	viot_for_each_fn fn;
@@ -378,14 +357,3 @@ int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info)
 		return __for_each_platform(to_platform_device(dev), fn, info);
 	return -ENODEV;
 }
-
-/**
- * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
- * @dev: the endpoint
- *
- * Return: 0 on success, <0 on failure
- */
-int viot_iommu_configure(struct device *dev)
-{
-	return viot_iommu_for_each_id(dev, viot_dev_iommu_init, dev);
-}
diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
index b796c68ae45ad8..81b129ed81cc03 100644
--- a/drivers/iommu/apple-dart.c
+++ b/drivers/iommu/apple-dart.c
@@ -987,7 +987,6 @@ static const struct iommu_ops apple_dart_iommu_ops = {
 	.probe_device_pinf = apple_dart_probe_device,
 	.release_device = apple_dart_release_device,
 	.device_group = apple_dart_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.def_domain_type = apple_dart_def_domain_type,
 	.get_resv_regions = apple_dart_get_resv_regions,
 	.pgsize_bitmap = -1UL, /* Restricted during dart probe */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 1a43c677e2feaf..71c47d3a5cdde9 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -2840,7 +2840,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.probe_device_pinf	= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.remove_dev_pasid	= arm_smmu_remove_dev_pasid,
 	.dev_enable_feat	= arm_smmu_dev_enable_feature,
diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
index f18d40532af433..537b47cb0da2b6 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
@@ -1577,7 +1577,6 @@ static struct iommu_ops arm_smmu_ops = {
 	.release_device		= arm_smmu_release_device,
 	.probe_finalize		= arm_smmu_probe_finalize,
 	.device_group		= arm_smmu_device_group,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.get_resv_regions	= arm_smmu_get_resv_regions,
 	.def_domain_type	= arm_smmu_def_domain_type,
 	.tegra_dev_iommu_get_stream_id = arm_smmu_get_stream_id,
diff --git a/drivers/iommu/arm/arm-smmu/qcom_iommu.c b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
index 4baca45df99971..308b439b955be6 100644
--- a/drivers/iommu/arm/arm-smmu/qcom_iommu.c
+++ b/drivers/iommu/arm/arm-smmu/qcom_iommu.c
@@ -597,7 +597,6 @@ static const struct iommu_ops qcom_iommu_ops = {
 	.probe_device_pinf = qcom_iommu_probe_device,
 	.release_device = qcom_iommu_release_device,
 	.device_group	= generic_device_group,
-	.of_xlate	= iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= qcom_iommu_attach_dev,
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 5a828c92cd38b2..e66aacc12b5ee1 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -23,7 +23,6 @@
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/mutex.h>
-#include <linux/iommu-driver.h>
 #include <linux/pci.h>
 #include <linux/scatterlist.h>
 #include <linux/spinlock.h>
@@ -456,29 +455,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
 	domain->iova_cookie = NULL;
 }
 
-/**
- * iommu_dma_get_resv_regions - Reserved region driver helper
- * @dev: Device from iommu_get_resv_regions()
- * @list: Reserved region list from iommu_get_resv_regions()
- *
- * IOMMU drivers can use this to implement their .get_resv_regions callback
- * for general non-IOMMU-specific reservations. Currently, this covers GICv3
- * ITS region reservation on ACPI based ARM platforms that may require HW MSI
- * reservation.
- */
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (!is_of_node(fwspec->iommu_fwnode)) {
-		iort_iommu_get_resv_regions(dev, list, fwspec->iommu_fwnode,
-					    fwspec->ids, fwspec->num_ids);
-	}
-
-	of_iommu_get_resv_regions(dev, list);
-}
-EXPORT_SYMBOL(iommu_dma_get_resv_regions);
-
 static int cookie_init_hw_msi_region(struct iommu_dma_cookie *cookie,
 		phys_addr_t start, phys_addr_t end)
 {
diff --git a/drivers/iommu/dma-iommu.h b/drivers/iommu/dma-iommu.h
index c829f1f82a991c..69196f421b9b10 100644
--- a/drivers/iommu/dma-iommu.h
+++ b/drivers/iommu/dma-iommu.h
@@ -14,8 +14,6 @@ void iommu_put_dma_cookie(struct iommu_domain *domain);
 
 int iommu_dma_init_fq(struct iommu_domain *domain);
 
-void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list);
-
 extern bool iommu_dma_forcedac;
 static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
 {
@@ -38,10 +36,6 @@ static inline void iommu_put_dma_cookie(struct iommu_domain *domain)
 {
 }
 
-static inline void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
-{
-}
-
 static inline void iommu_dma_set_pci_32bit_workaround(struct device *dev)
 {
 }
diff --git a/drivers/iommu/exynos-iommu.c b/drivers/iommu/exynos-iommu.c
index c301aa87fe0ff0..80cca10e8dfdcb 100644
--- a/drivers/iommu/exynos-iommu.c
+++ b/drivers/iommu/exynos-iommu.c
@@ -1473,7 +1473,6 @@ static const struct iommu_ops exynos_iommu_ops = {
 	.probe_device_pinf = exynos_iommu_probe_device,
 	.release_device = exynos_iommu_release_device,
 	.pgsize_bitmap = SECT_SIZE | LPAGE_SIZE | SPAGE_SIZE,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= exynos_iommu_attach_device,
 		.map_pages	= exynos_iommu_map,
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index c76edc9061f123..ba0c0c7f251ace 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -42,6 +42,7 @@
 static struct kset *iommu_group_kset;
 static DEFINE_IDA(iommu_group_ida);
 static DEFINE_IDA(iommu_global_pasid_ida);
+static DEFINE_MUTEX(iommu_probe_device_lock);
 
 static unsigned int iommu_def_domain_type __read_mostly;
 static bool iommu_dma_strict __read_mostly = IS_ENABLED(CONFIG_IOMMU_DEFAULT_DMA_STRICT);
@@ -371,10 +372,6 @@ static void dev_iommu_free(struct device *dev)
 	struct dev_iommu *param = dev->iommu;
 
 	dev->iommu = NULL;
-	if (param->fwspec) {
-		fwnode_handle_put(param->fwspec->iommu_fwnode);
-		kfree(param->fwspec);
-	}
 	kfree(param);
 }
 
@@ -560,8 +557,6 @@ static int iommu_fw_check_deferred(struct iommu_probe_info *pinf)
 	return -ENODEV;
 }
 
-DEFINE_MUTEX(iommu_probe_device_lock);
-
 static int iommu_find_init_device(struct iommu_probe_info *pinf)
 {
 	const struct iommu_ops *ops = NULL;
@@ -588,27 +583,10 @@ static int iommu_find_init_device(struct iommu_probe_info *pinf)
 static int __iommu_probe_device(struct iommu_probe_info *pinf)
 {
 	struct device *dev = pinf->dev;
-	const struct iommu_ops *ops;
-	struct iommu_fwspec *fwspec;
 	struct iommu_group *group;
 	struct group_device *gdev;
 	int ret;
 
-	/*
-	 * For FDT-based systems and ACPI IORT/VIOT, drivers register IOMMU
-	 * instances with non-NULL fwnodes, and client devices should have been
-	 * identified with a fwspec by this point. Otherwise, we can currently
-	 * assume that only one of Intel, AMD, s390, PAMU or legacy SMMUv2 can
-	 * be present, and that any of their registered instances has suitable
-	 * ops for probing, and thus cheekily co-opt the same mechanism.
-	 */
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops) {
-		ops = fwspec->ops;
-		if (!ops)
-			return -ENODEV;
-	}
-
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -622,13 +600,7 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	if (dev->iommu_group)
 		return 0;
 
-	if (ops) {
-		ret = iommu_init_device(pinf, ops);
-		if (ret == -ENODEV)
-			return iommu_fw_check_deferred(pinf);
-	} else {
-		ret = iommu_find_init_device(pinf);
-	}
+	ret = iommu_find_init_device(pinf);
 	if (ret)
 		return ret;
 
@@ -3085,7 +3057,8 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
+static struct iommu_device *
+iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 {
 	struct iommu_device *iommu;
 
@@ -3173,68 +3146,6 @@ int iommu_fw_get_u32_ids(struct iommu_probe_info *pinf, u32 *ids)
 }
 EXPORT_SYMBOL_GPL(iommu_fw_get_u32_ids);
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec)
-		return ops == fwspec->ops ? 0 : -EINVAL;
-
-	if (!dev_iommu_get(dev))
-		return -ENOMEM;
-
-	/* Preallocate for the overwhelmingly common case of 1 ID */
-	fwspec = kzalloc(struct_size(fwspec, ids, 1), GFP_KERNEL);
-	if (!fwspec)
-		return -ENOMEM;
-
-	of_node_get(to_of_node(iommu_fwnode));
-	fwspec->iommu_fwnode = iommu_fwnode;
-	fwspec->ops = ops;
-	dev_iommu_fwspec_set(dev, fwspec);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_init);
-
-void iommu_fwspec_free(struct device *dev)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-
-	if (fwspec) {
-		fwnode_handle_put(fwspec->iommu_fwnode);
-		kfree(fwspec);
-		dev_iommu_fwspec_set(dev, NULL);
-	}
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_free);
-
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids)
-{
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
-	int i, new_num;
-
-	if (!fwspec)
-		return -EINVAL;
-
-	new_num = fwspec->num_ids + num_ids;
-	if (new_num > 1) {
-		fwspec = krealloc(fwspec, struct_size(fwspec, ids, new_num),
-				  GFP_KERNEL);
-		if (!fwspec)
-			return -ENOMEM;
-
-		dev_iommu_fwspec_set(dev, fwspec);
-	}
-
-	for (i = 0; i < num_ids; i++)
-		fwspec->ids[fwspec->num_ids + i] = ids[i];
-
-	fwspec->num_ids = new_num;
-	return 0;
-}
-EXPORT_SYMBOL_GPL(iommu_fwspec_add_ids);
-
 /*
  * Per device IOMMU features.
  */
diff --git a/drivers/iommu/ipmmu-vmsa.c b/drivers/iommu/ipmmu-vmsa.c
index ba984017065f98..96a6a13538ed77 100644
--- a/drivers/iommu/ipmmu-vmsa.c
+++ b/drivers/iommu/ipmmu-vmsa.c
@@ -872,7 +872,6 @@ static const struct iommu_ops ipmmu_ops = {
 	.device_group = IS_ENABLED(CONFIG_ARM) && !IS_ENABLED(CONFIG_IOMMU_DMA)
 			? generic_device_group : generic_single_device_group,
 	.pgsize_bitmap = SZ_1G | SZ_2M | SZ_4K,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= ipmmu_attach_device,
 		.map_pages	= ipmmu_map,
diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
index 6f21eec857c7d7..acb4858032f22e 100644
--- a/drivers/iommu/msm_iommu.c
+++ b/drivers/iommu/msm_iommu.c
@@ -674,7 +674,6 @@ static struct iommu_ops msm_iommu_ops = {
 	.probe_device_pinf = msm_iommu_probe_device,
 	.device_group = generic_device_group,
 	.pgsize_bitmap = MSM_IOMMU_PGSIZES,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= msm_iommu_attach_dev,
 		.map_pages	= msm_iommu_map,
diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
index 477171e83eaa6e..53099af3908ea3 100644
--- a/drivers/iommu/mtk_iommu.c
+++ b/drivers/iommu/mtk_iommu.c
@@ -1023,7 +1023,6 @@ static const struct iommu_ops mtk_iommu_ops = {
 	.probe_device_pinf = mtk_iommu_probe_device,
 	.release_device	= mtk_iommu_release_device,
 	.device_group	= mtk_iommu_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.get_resv_regions = mtk_iommu_get_resv_regions,
 	.pgsize_bitmap	= SZ_4K | SZ_64K | SZ_1M | SZ_16M,
 	.owner		= THIS_MODULE,
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 463d17ab5057d6..1daf16323fdbc3 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -19,33 +19,6 @@
 #include <linux/slab.h>
 #include <linux/fsl/mc.h>
 
-static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
-{
-	struct device *dev = info;
-	struct iommu_device *iommu;
-	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
-	int ret;
-
-	iommu = iommu_device_from_fwnode(fwnode);
-	if ((iommu && !iommu->ops->of_xlate) ||
-	    !of_device_is_available(iommu_spec->np))
-		return -ENODEV;
-
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, iommu->ops);
-	if (ret)
-		return ret;
-	/*
-	 * The otherwise-empty fwspec handily serves to indicate the specific
-	 * IOMMU device we're waiting for, which will be useful if we ever get
-	 * a proper probe-ordering dependency mechanism in future.
-	 */
-	if (!iommu)
-		return driver_deferred_probe_check_state(dev);
-
-	ret = iommu->ops->of_xlate(dev, iommu_spec);
-	return ret;
-}
-
 typedef int (*of_for_each_fn)(struct of_phandle_args *args, void *info);
 
 static int __for_each_map_id(struct device_node *master_np, u32 id,
@@ -143,34 +116,14 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 		.of_map_id = id,
 		.is_dma_configure = true,
 	};
-	struct iommu_fwspec *fwspec;
 	int err;
 
 	if (!master_np)
 		return -ENODEV;
 
-	/* Serialise to make dev->iommu stable under our potential fwspec */
-	mutex_lock(&iommu_probe_device_lock);
-	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec) {
-		if (fwspec->ops) {
-			mutex_unlock(&iommu_probe_device_lock);
-			return 0;
-		}
-		/* In the deferred case, start again from scratch */
-		iommu_fwspec_free(dev);
-	}
-
 	if (dev_is_pci(dev))
 		pci_request_acs();
 
-	err = of_iommu_for_each_id(dev, master_np, id, of_iommu_xlate, dev);
-	mutex_unlock(&iommu_probe_device_lock);
-	if (err == -ENODEV || err == -EPROBE_DEFER)
-		return err;
-	if (err)
-		goto err_log;
-
 	err = iommu_probe_device_pinf(&pinf);
 	if (err)
 		goto err_log;
diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
index 4cff06a2a24f74..72ee43d3230f5c 100644
--- a/drivers/iommu/rockchip-iommu.c
+++ b/drivers/iommu/rockchip-iommu.c
@@ -1141,7 +1141,6 @@ static const struct iommu_ops rk_iommu_ops = {
 	.release_device = rk_iommu_release_device,
 	.device_group = generic_single_device_group,
 	.pgsize_bitmap = RK_IOMMU_PGSIZE_BITMAP,
-	.of_xlate = iommu_dummy_of_xlate,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev	= rk_iommu_attach_device,
 		.map_pages	= rk_iommu_map,
diff --git a/drivers/iommu/sprd-iommu.c b/drivers/iommu/sprd-iommu.c
index f1b87f8661e199..6e7634872bfcb7 100644
--- a/drivers/iommu/sprd-iommu.c
+++ b/drivers/iommu/sprd-iommu.c
@@ -404,7 +404,6 @@ static const struct iommu_ops sprd_iommu_ops = {
 	.domain_alloc_paging = sprd_iommu_domain_alloc_paging,
 	.probe_device_pinf = sprd_iommu_probe_device,
 	.device_group	= generic_single_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.pgsize_bitmap	= SPRD_IOMMU_PAGE_SIZE,
 	.owner		= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/sun50i-iommu.c b/drivers/iommu/sun50i-iommu.c
index 84038705cf657d..e91aacdb7104b6 100644
--- a/drivers/iommu/sun50i-iommu.c
+++ b/drivers/iommu/sun50i-iommu.c
@@ -845,7 +845,6 @@ static const struct iommu_ops sun50i_iommu_ops = {
 	.pgsize_bitmap	= SZ_4K,
 	.device_group	= generic_single_device_group,
 	.domain_alloc_paging = sun50i_iommu_domain_alloc_paging,
-	.of_xlate = iommu_dummy_of_xlate,
 	.probe_device_pinf	= sun50i_iommu_probe_device,
 	.release_device = sun50i_iommu_release_device,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/tegra-smmu.c b/drivers/iommu/tegra-smmu.c
index 1daa92f524452b..1c14f8b5ed847d 100644
--- a/drivers/iommu/tegra-smmu.c
+++ b/drivers/iommu/tegra-smmu.c
@@ -945,7 +945,6 @@ static const struct iommu_ops tegra_smmu_ops = {
 	.probe_device_pinf = tegra_smmu_probe_device,
 	.release_device = tegra_smmu_release_device,
 	.device_group = tegra_smmu_device_group,
-	.of_xlate = iommu_dummy_of_xlate,
 	.tegra_dev_iommu_get_stream_id = tegra_smmu_get_stream_id,
 	.pgsize_bitmap = SZ_4K,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 767919bf848999..f6b8e796a792e7 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -1054,7 +1054,6 @@ static struct iommu_ops viommu_ops = {
 	.release_device		= viommu_release_device,
 	.device_group		= viommu_device_group,
 	.get_resv_regions	= viommu_get_resv_regions,
-	.of_xlate		= iommu_dummy_of_xlate,
 	.owner			= THIS_MODULE,
 	.default_domain_ops = &(const struct iommu_domain_ops) {
 		.attach_dev		= viommu_attach_dev,
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 89079787905d40..79dea7bea7a6f0 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -631,9 +631,6 @@ struct iommu_ops;
 
 bool acpi_dma_supported(const struct acpi_device *adev);
 enum dev_dma_attr acpi_get_dma_attr(struct acpi_device *adev);
-int acpi_iommu_fwspec_init(struct device *dev, u32 id,
-			   struct fwnode_handle *fwnode,
-			   const struct iommu_ops *ops);
 int acpi_dma_get_range(struct device *dev, const struct bus_dma_region **map);
 int acpi_dma_configure_id(struct device *dev, enum dev_dma_attr attr,
 			   const u32 *input_id);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index bacba2a76c3acb..9e64a18676a4c7 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -53,7 +53,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
-int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
 				 struct fwnode_handle *iommu_fwnode,
 				 const u32 *fw_ids, unsigned int fw_num_ids);
@@ -72,8 +71,6 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head *hea
 /* IOMMU interface */
 static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 { return -ENODEV; }
-static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
-{ return -ENODEV; }
 static inline
 void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
 				 struct fwnode_handle *iommu_fwnode,
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index fce4eefcae4aad..0bc01d456bcb6b 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -19,14 +19,9 @@ int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info);
 #ifdef CONFIG_ACPI_VIOT
 void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
-int viot_iommu_configure(struct device *dev);
 #else
 static inline void acpi_viot_early_init(void) {}
 static inline void acpi_viot_init(void) {}
-static inline int viot_iommu_configure(struct device *dev)
-{
-	return -ENODEV;
-}
 #endif
 
 #endif /* __ACPI_VIOT_H__ */
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index aa4cbf0cb91907..7ddd0b94e13c0d 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -62,7 +62,6 @@ static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
 }
 
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
-struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 struct iommu_device *
 iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
 			      const struct iommu_ops *ops,
@@ -201,15 +200,6 @@ __iommu_fw_alloc_per_device_ids(struct iommu_probe_info *pinf, void *mem,
 			pinf, drv, num_ids, &drv->num_ids, drv->ids);      \
 	})
 
-/*
- * Used temporarily to indicate drivers that have moved to the new probe method.
- */
-static inline int iommu_dummy_of_xlate(struct device *dev,
-				       struct of_phandle_args *args)
-{
-	return 0;
-}
-
 #define __iommu_first(a, b)                              \
 	({                                               \
 		struct iommu_device *a_dev = a;          \
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index 0ba12e0e450705..456b9b16599ce0 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -354,7 +354,6 @@ static inline int __iommu_copy_struct_from_user(
  *                  group and attached to the groups domain
  * @device_group: find iommu group for a particular device
  * @get_resv_regions: Request list of reserved regions for a device
- * @of_xlate: add OF master IDs to iommu grouping
  * @is_attach_deferred: Check if domain attach should be deferred from iommu
  *                      driver init to device driver init (default no)
  * @dev_enable/disable_feat: per device entries to enable/disable
@@ -398,7 +397,6 @@ struct iommu_ops {
 	/* Request/Free a list of reserved regions for a device */
 	void (*get_resv_regions)(struct device *dev, struct list_head *list);
 
-	int (*of_xlate)(struct device *dev, struct of_phandle_args *args);
 	bool (*is_attach_deferred)(struct device *dev);
 
 	/* Per device IOMMU features */
@@ -534,7 +532,6 @@ struct iommu_fault_param {
  *
  * @fault_param: IOMMU detected device fault reporting data
  * @iopf_param:	 I/O Page Fault queue and data
- * @fwspec:	 IOMMU fwspec data
  * @iommu_dev:	 IOMMU device this device is linked to
  * @priv:	 IOMMU Driver private data
  * @max_pasids:  number of PASIDs this device can consume
@@ -550,7 +547,6 @@ struct dev_iommu {
 	struct mutex lock;
 	struct iommu_fault_param	*fault_param;
 	struct iopf_device_param	*iopf_param;
-	struct iommu_fwspec		*fwspec;
 	struct iommu_device		*iommu_dev;
 	void				*priv;
 	u32				max_pasids;
@@ -787,29 +783,6 @@ extern struct iommu_group *generic_device_group(struct device *dev);
 struct iommu_group *fsl_mc_device_group(struct device *dev);
 extern struct iommu_group *generic_single_device_group(struct device *dev);
 
-/**
- * struct iommu_fwspec - per-device IOMMU instance data
- * @ops: ops for this device's IOMMU
- * @iommu_fwnode: firmware handle for this device's IOMMU
- * @flags: IOMMU_FWSPEC_* flags
- * @num_ids: number of associated device IDs
- * @ids: IDs which this device may present to the IOMMU
- *
- * Note that the IDs (and any other information, really) stored in this structure should be
- * considered private to the IOMMU device driver and are not to be used directly by IOMMU
- * consumers.
- */
-struct iommu_fwspec {
-	const struct iommu_ops	*ops;
-	struct fwnode_handle	*iommu_fwnode;
-	u32			flags;
-	unsigned int		num_ids;
-	u32			ids[];
-};
-
-/* ATS is supported */
-#define IOMMU_FWSPEC_PCI_RC_ATS			(1 << 0)
-
 /**
  * struct iommu_sva - handle to a device-mm bond
  */
@@ -818,25 +791,6 @@ struct iommu_sva {
 	struct iommu_domain		*domain;
 };
 
-int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
-		      const struct iommu_ops *ops);
-void iommu_fwspec_free(struct device *dev);
-int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-
-static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
-{
-	if (dev->iommu)
-		return dev->iommu->fwspec;
-	else
-		return NULL;
-}
-
-static inline void dev_iommu_fwspec_set(struct device *dev,
-					struct iommu_fwspec *fwspec)
-{
-	dev->iommu->fwspec = fwspec;
-}
-
 static inline void *dev_iommu_priv_get(struct device *dev)
 {
 	if (dev->iommu)
@@ -847,7 +801,6 @@ static inline void *dev_iommu_priv_get(struct device *dev)
 
 void dev_iommu_priv_set(struct device *dev, void *priv);
 
-extern struct mutex iommu_probe_device_lock;
 int iommu_probe_device(struct device *dev);
 
 int iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features f);
@@ -878,7 +831,6 @@ void iommu_free_global_pasid(ioasid_t pasid);
 
 struct iommu_ops {};
 struct iommu_group {};
-struct iommu_fwspec {};
 struct iommu_device {};
 struct iommu_fault_param {};
 struct iommu_iotlb_gather {};
@@ -1153,23 +1105,6 @@ static inline void iommu_device_unlink(struct device *dev, struct device *link)
 {
 }
 
-static inline int iommu_fwspec_init(struct device *dev,
-				    struct fwnode_handle *iommu_fwnode,
-				    const struct iommu_ops *ops)
-{
-	return -ENODEV;
-}
-
-static inline void iommu_fwspec_free(struct device *dev)
-{
-}
-
-static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
-				       int num_ids)
-{
-	return -ENODEV;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
@@ -1182,11 +1117,6 @@ iommu_dev_disable_feature(struct device *dev, enum iommu_dev_features feat)
 	return -ENODEV;
 }
 
-static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
-{
-	return NULL;
-}
-
 static inline int iommu_device_use_default_domain(struct device *dev)
 {
 	return 0;
-- 
2.42.0

