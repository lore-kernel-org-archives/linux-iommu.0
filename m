Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C5C187D;
	Thu, 30 Nov 2023 01:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y2KAbUCh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CIBr6s7IlUxzEbgx0SmRb8lAk8cxjekU3dut2Bq+KlfrM5RG5BdGol7w5xDmE0vjJtDw+Occ1ApQLM9peDeb2oRxn2rb3sg6U0b0MtHT3FS3M/K6hQD24g/yltAAXdvYv7kGnmFUfm4AAvaPbd7G5ab2+UJ2Tc+M6oGQsyvKmCEb1frrvX3XF/7qtdv7hZNNOkFxqf//wD9sZwtnP/sD26PdWmdYkqfyCjiTMW7xjH88uesOz9T1JF4kOsO9eTYuUIg3PrinvVFkkqvr0/wylAjNlNBkmGHVrsISZTGVbKzlmxKhCtm/Kib8Fj8ctSAFzRXardURiQkdwM1QwYfFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fwf/8BLazV78Ujjm7q8f4RCgFTKfbzZbel/RjT7b+os=;
 b=ZUH4CIFxhDYXxYPgpUcTuPMEcfrfvdmwiIWh50DhEzMCGfWyXLaM7x7rA1MwKWjeMnhUPJQ2XnerW1htAi6vrUGnDRTALj7CQMFSe84n18amf2aGSSIKLb5Z8lzyPe58p3jgSj72hn+a4Tu9IMCZp0rUQjEGG6tuFPKYx5g9CxhegvDso8+5by6nLYVVl/nozE+R5G21M7cXoHNDAoXgj1WOmKcb1A1E/lwUm5QyDE0UY2f3wuF5NFHwUy0JanTUNp3Y7aSOyfang/rgwM9kD87T8BXlEy6uqbnVwFm+c/rIH/Z/NqOchui7/UsLc8gJqN8+aj0lrptZc1SKYYY4Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fwf/8BLazV78Ujjm7q8f4RCgFTKfbzZbel/RjT7b+os=;
 b=Y2KAbUChVbTggcY5pakuxzWtiUu07/1YfBbfUsPmjY2hNQQ0U2MQpwY4pbjtqkChEfsXv8ZVQD0ocnmVQrYk7CiDfB1PQVX+Nu4847UwbPhKbelFnnBD9J/z/NMqvSpSCMVgIR45Iu6oBcuTjnSKxW0hKpMRjctaSeOpUVhrtdc9/YstcrC76oQNrkbK5220mBXrEf5yJ0foVcQ2O16s1qHH3Iqdb8My0Z+M/8RNIK55VayqU8oQFCOPDeMCjDc1b8uXeQ3qFpdjmIoX3CAMv0MS0q90KTsYvt7s+bEK58UVKwhUzK1Hzl0Stm2FE5V3W5sva5VSsj8Ef6j2HjelXw==
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
Subject: [PATCH v2 08/30] iommu/of: Add iommu_of_get_single_iommu()
Date: Wed, 29 Nov 2023 21:14:08 -0400
Message-ID: <8-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0057.namprd16.prod.outlook.com
 (2603:10b6:805:ca::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: fe799dc3-ea7c-43ac-3e46-08dbf141b647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bidHljiJgv90sfO/r869tRZ8uCHTK7R/ZGQNWfybmp/ceBj3koq8ebEPsn9ypXPA+zIjU6Dbz53EpUFVoUSt65VaKIsIjOJGswLn1Ji2xzTx7xx/rP7ahiWQWQHVZSGAzQkzAFvzIQsZZJMVPCDFr0uDPQWbHsyCZuUC+Vf+gVium18jmq3yCFsi5spRoQwAs8Dmp6rs6cFdvfgOS0aGvC7LN4yPx0Nb9cp1ggR4ay4wc/r9dsU4zmFZ7IwpfJB9QXdUUCYMCSZr7A0lh/brxQoUoSyG+QHJwKC+iCXAJch7imH9qiqpyOpIMTBkjeREJ+yPYj7fnnMkRcTib8jUlLO7+FL/1ezUTJCEBoEzwPUJpVgNqmSsFqqJ3UuJNkBe0Gsdzg7gFLhzBT5woqDTAc4Cdt58RsGMZ1Rcv47VFrRb1TcNJ2oPNYU99StbdPS9x+q2MAWUxKJEzjsiMCsCO4QWlPnBPwK/3fiLfotR7uym+dDZFFrB8IB682bsT3nKJq8SQJA9D28h7I7tubR8xmL0bprbBNHj3tgV5D5rmS0bsEILtKP1z/RI+aYZ/wiJ3Md1KLSh+vzzkwYjRtygXtJA2yYqKy2MNJe/KMbuJVYwDvixp2R2fY19ijARF9fS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OMekdgaiXf9NIoAzD1ehw31u8p5L49WG7BptfqFLGHU3ixIp9z6a+ByKzuRe?=
 =?us-ascii?Q?iGYvUuXvd5AN5Sa65AmOb5Xx8glrqwDDF1+jF9SIRy3OWeXuC7XRqDlnQeYD?=
 =?us-ascii?Q?4HJ8YcgkvSR7Hd1gakzyeOfK2bt/QdntnbIYAvRSx/6km4EzIiP0i8jHgss9?=
 =?us-ascii?Q?T80glWpsXGRiWR5KJUxbbTfa23a4DwuI5y7W4grLf62n9hsBBlYgPAhuwo0q?=
 =?us-ascii?Q?wdG5fMDbHzbX8a3xVhiFdpdz9hRaNgjY6R+LrxF+lVF1GftdrbVobNrDpQtv?=
 =?us-ascii?Q?LI8roIPXruBqm7lqX/OlJV0an0htI+mFVCKgkl3QCrKDi9tw03NXoWlsZuES?=
 =?us-ascii?Q?yzcmADxwQwwzI/3ENtRBR5GpvjalrG7LZ2DcAMnWvp5EVrGZ7Xr4fnPhcS5I?=
 =?us-ascii?Q?HfemQU7e0ELc+mpUTq0kiDmXXd6ZVMmakBxVvyWmpUxtxhzzmctKtLxvC4sc?=
 =?us-ascii?Q?pQ8I+QB7/twjmFVYiFE3GLw4b1WE4Q/l7AJ+KyHGMaiuOeLWUUbYJo2NawlI?=
 =?us-ascii?Q?W+/UhPaG/6P4o0+ahERqx2cbPonb9zyWpCsWtbS0v3Gw6okslrBu0a9Asl6v?=
 =?us-ascii?Q?h8PRvA1nhPm0JX6C7rqyCgMPMXlYl/vLLlyWdA60S9oZEXhe1MHTGvYyQlEx?=
 =?us-ascii?Q?TT5aYqrUgZuwerwuLv/FlAnwQW4miqLeqcUE4dCerpOU/ModRQpWFPRyjO08?=
 =?us-ascii?Q?KWbm39kd+Y23e0qK3xX0VNYOBUUby+02XO+qxfLPDNuhWmasK39TnTV0Vx9F?=
 =?us-ascii?Q?mCJHxU2Qj3g3feHTLM/Mvs16jtRr35JFa0bfxfuM9vDJE/4gLSQSZ9VWEL5i?=
 =?us-ascii?Q?1T0ZHIXliBU7TqCb18EEZwDoi/tkWPpsC/VGkDB5mMdIfWno60D5IDXXMhgB?=
 =?us-ascii?Q?d0Y4ZEwjoMPicd3l0rb17zN6mxaBcKjyMGdHfudeP8vJLzwpWYx2l9ZgafL+?=
 =?us-ascii?Q?OPv9sovFOH5GVfPRPF2kVOuNyTwtIAK+4gB7x5O/Rsmq6/5CkSq+NB/dw+cU?=
 =?us-ascii?Q?u1aTgHqG7EtIcAFWnrNlo8ZuMzffc/jwdQySlKBRuFQCjooZPhxxEH/aapGd?=
 =?us-ascii?Q?iilysYa/NmJfNt9H3RhtIKn65n1BbRLwFtqnbRRroX+tx80nsdeB05RWbOrM?=
 =?us-ascii?Q?RbKUMedlbEaIr9Mc1Wu0DW/x7ICcZL8zaA5qZK8s7EExcOLWCw05CSClv7lJ?=
 =?us-ascii?Q?/RyED/Mdjb02snyTJUL/wvW6O4snKGkWHNCg+87jAG3bl+7e1/OwiPJ9hsG4?=
 =?us-ascii?Q?Nkm3QD4tN8d8D/uFdkjjpery6HU5V+wLIvYj5Nixw7lhkk0YGbF5Fj8eIWhi?=
 =?us-ascii?Q?rfKR1CwHzlR5d19p7+N6GqvBOwgSsHkzTjUl5YcbiXrstdz/TVL2xZgKn38p?=
 =?us-ascii?Q?AYIRh0uta9VjWJTIH2V17GiWoI5Ka3jMT15FN3rgy4j2BAFEAykHNYWhfTWa?=
 =?us-ascii?Q?tJSscNPpBV4cNKVuN5O/C5Fv5isxctC1ngYAb4QPsidhY2H2JpbdLzcwp6Uj?=
 =?us-ascii?Q?RTJrJBNKcC86rBN54g3WGTTyxgodpzL1C7MyWdm6Fyn+d5rc77jJSrhzldRw?=
 =?us-ascii?Q?oDZTlgpZSnpqJ8uf315NaXSdsiY6TzqUBXiPlzc2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe799dc3-ea7c-43ac-3e46-08dbf141b647
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.8107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2yCDh1WKx1ItRRSAj+FyNRXPpHshPMVqkO1gx3V2NxxB2+9XogNcxM2+CMIc4OL3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

This function can be called by drivers in their probe function to return a
single iommu_device instance associated with the current probe.

All drivers need a way to get the iommu_device instance the FW says the
device should be using. Wrap the function with a macro that does the
container_of().

The driver indicates what instances it accepts by passing in its ops.

num_cells is provided to validate that the args are correctly sized.

This function is all that is required by drivers that only support a
single IOMMU instance and no IDs data. Driver's should follow a typical
pattern in their probe_device:

	iommu = iommu_of_get_single_iommu(pinf, &rk_iommu_ops, -1,
					  struct rk_iommu, iommu);
	if (IS_ERR(iommu)) return ERR_CAST(iommu);

	data = kzalloc(sizeof(*data), GFP_KERNEL);
	if (!data) return ERR_PTR(-ENOMEM);
	[..]
	dev_iommu_priv_set(dev, data);
        return &iommu->iommu;

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/scan.c          |  1 +
 drivers/iommu/iommu.c        | 52 ++++++++++++++++++++++
 drivers/iommu/of_iommu.c     | 59 +++++++++++++++++++++++++
 include/linux/iommu-driver.h | 85 ++++++++++++++++++++++++++++++++++++
 4 files changed, 197 insertions(+)

diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
index 9c13df632aa5e0..de36299c3b75bf 100644
--- a/drivers/acpi/scan.c
+++ b/drivers/acpi/scan.c
@@ -1570,6 +1570,7 @@ static int acpi_iommu_configure_id(struct device *dev, const u32 *id_in)
 	const struct iommu_ops *ops;
 	struct iommu_probe_info pinf = {
 		.dev = dev,
+		.is_dma_configure = true,
 	};
 
 	/* Serialise to make dev->iommu stable under our potential fwspec */
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 45e6543748fd46..ca411ad14c1182 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3015,6 +3015,58 @@ struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 	return NULL;
 }
 
+/*
+ * Helper for FW interfaces to parse the fwnode into an iommu_driver. This
+ * caches past search results to avoid re-searching the linked list and computes
+ * if the FW is describing a single or multi-instance ID list.
+ */
+struct iommu_device *
+iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct fwnode_handle *fwnode)
+{
+	struct iommu_device *iommu = pinf->cached_iommu;
+
+	if (!pinf->num_ids)
+		pinf->cached_single_iommu = true;
+
+	if (!iommu || iommu->fwnode != fwnode) {
+		iommu = iommu_device_from_fwnode(fwnode);
+		if (!iommu)
+			return ERR_PTR(
+				driver_deferred_probe_check_state(pinf->dev));
+		pinf->cached_iommu = iommu;
+		if (pinf->num_ids)
+			pinf->cached_single_iommu = false;
+	}
+
+	/* NULL ops is used for the -EPROBE_DEFER check, match everything */
+	if (ops && iommu->ops != ops) {
+		if (!pinf->num_ids)
+			return ERR_PTR(-ENODEV);
+		dev_err(pinf->dev,
+			FW_BUG
+			"One device in the FW has iommu's with different Linux drivers, expecting %ps FW wants %ps.",
+			ops, iommu->ops);
+		return ERR_PTR(-EINVAL);
+	}
+	return iommu;
+}
+
+struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf)
+{
+	if (WARN_ON(!pinf->num_ids || !pinf->cached_iommu))
+		return ERR_PTR(-EINVAL);
+	if (!pinf->cached_single_iommu) {
+		dev_err(pinf->dev,
+			FW_BUG
+			"The iommu driver %ps expects only one iommu instance, the FW has more.\n",
+			pinf->cached_iommu->ops);
+		return ERR_PTR(-EINVAL);
+	}
+	return pinf->cached_iommu;
+}
+
 int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops)
 {
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index 20266a8edd5c71..37af32a6bc84e5 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -138,6 +138,9 @@ int of_iommu_configure(struct device *dev, struct device_node *master_np,
 {
 	struct iommu_probe_info pinf = {
 		.dev = dev,
+		.of_master_np = master_np,
+		.of_map_id = id,
+		.is_dma_configure = true,
 	};
 	struct iommu_fwspec *fwspec;
 	int err;
@@ -277,3 +280,59 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
 #endif
 }
 EXPORT_SYMBOL(of_iommu_get_resv_regions);
+
+struct parse_info {
+	struct iommu_probe_info *pinf;
+	const struct iommu_ops *ops;
+	int num_cells;
+};
+
+static struct iommu_device *parse_iommu(struct parse_info *info,
+					struct of_phandle_args *iommu_spec)
+{
+	if (!of_device_is_available(iommu_spec->np))
+		return ERR_PTR(-ENODEV);
+
+	if (info->num_cells != -1 && iommu_spec->args_count != info->num_cells) {
+		dev_err(info->pinf->dev,
+			FW_BUG
+			"Driver %ps expects number of cells %u but DT has %u\n",
+			info->ops, info->num_cells, iommu_spec->args_count);
+		return ERR_PTR(-EINVAL);
+	}
+	return iommu_device_from_fwnode_pinf(info->pinf, info->ops,
+					     &iommu_spec->np->fwnode);
+}
+
+static int parse_single_iommu(struct of_phandle_args *iommu_spec, void *_info)
+{
+	struct parse_info *info = _info;
+	struct iommu_device *iommu;
+
+	iommu = parse_iommu(info, iommu_spec);
+	if (IS_ERR(iommu))
+		return PTR_ERR(iommu);
+	info->pinf->num_ids++;
+	return 0;
+}
+
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells)
+{
+	struct parse_info info = { .pinf = pinf,
+				   .ops = ops,
+				   .num_cells = num_cells };
+	int err;
+
+	if (!pinf->is_dma_configure || !pinf->of_master_np)
+		return ERR_PTR(-ENODEV);
+
+	iommu_fw_clear_cache(pinf);
+	err = of_iommu_for_each_id(pinf->dev, pinf->of_master_np,
+				   pinf->of_map_id, parse_single_iommu, &info);
+	if (err)
+		return ERR_PTR(err);
+	return iommu_fw_finish_get_single(pinf);
+}
+EXPORT_SYMBOL_GPL(__iommu_of_get_single_iommu);
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index c572620d3069b4..597998a62b0dd6 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -13,25 +13,110 @@
 #endif
 
 #include <linux/types.h>
+#include <linux/err.h>
+#include <linux/slab.h>
 
+struct of_phandle_args;
 struct fwnode_handle;
+struct iommu_device;
+struct iommu_ops;
+
+/*
+ * FIXME this is sort of like container_of_safe() that was removed, do we want
+ * to put it in the common header?
+ */
+#define container_of_err(ptr, type, member)                       \
+	({                                                        \
+		void *__mptr = (void *)(ptr);                     \
+								  \
+		(offsetof(type, member) != 0 && IS_ERR(__mptr)) ? \
+			(type *)ERR_CAST(__mptr) :                \
+			container_of(ptr, type, member);          \
+	})
 
 struct iommu_probe_info {
 	struct device *dev;
 	struct list_head *deferred_group_list;
+	struct iommu_device *cached_iommu;
+	struct device_node *of_master_np;
+	const u32 *of_map_id;
+	unsigned int num_ids;
 	bool defer_setup : 1;
+	bool is_dma_configure : 1;
+	bool cached_single_iommu : 1;
 };
 
+static inline void iommu_fw_clear_cache(struct iommu_probe_info *pinf)
+{
+	pinf->num_ids = 0;
+	pinf->cached_single_iommu = true;
+}
+
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
 struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
+struct iommu_device *
+iommu_device_from_fwnode_pinf(struct iommu_probe_info *pinf,
+			      const struct iommu_ops *ops,
+			      struct fwnode_handle *fwnode);
+struct iommu_device *iommu_fw_finish_get_single(struct iommu_probe_info *pinf);
 
 #if IS_ENABLED(CONFIG_OF_IOMMU)
 void of_iommu_get_resv_regions(struct device *dev, struct list_head *list);
+
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells);
 #else
 static inline void of_iommu_get_resv_regions(struct device *dev,
 					     struct list_head *list)
 {
 }
+static inline
+struct iommu_device *__iommu_of_get_single_iommu(struct iommu_probe_info *pinf,
+						 const struct iommu_ops *ops,
+						 int num_cells)
+{
+	return ERR_PTR(-ENODEV);
+}
 #endif
 
+/**
+ * iommu_of_get_single_iommu - Return the driver's iommu instance
+ * @pinf: The iommu_probe_info
+ * @ops: The ops the iommu instance must have
+ * @num_cells: #iommu-cells value to enforce, -1 is no check
+ * @drv_struct: The driver struct containing the struct iommu_device
+ * @member: The name of the iommu_device member
+ *
+ * Parse the OF table describing the iommus and return a pointer to the driver's
+ * iommu_device struct that the OF table points to. Check that the OF table is
+ * well formed with a single iommu for all the entries and that the table refers
+ * to this iommu driver. Integrates a container_of() to simplify all users.
+ */
+#define iommu_of_get_single_iommu(pinf, ops, num_cells, drv_struct, member)  \
+	container_of_err(__iommu_of_get_single_iommu(pinf, ops, num_cells), \
+			  drv_struct, member)
+
+/**
+ * iommu_of_num_ids - Return the number of iommu associations the FW has
+ * @pinf: The iommu_probe_info
+ *
+ * For drivers using iommu_of_get_single_iommu() this will return the number
+ * of ids associated with the iommu instance. For other cases this will return
+ * the sum of all ids across all instances. Returns >= 1.
+ */
+static inline unsigned int iommu_of_num_ids(struct iommu_probe_info *pinf)
+{
+	return pinf->num_ids;
+}
+
+/*
+ * Used temporarily to indicate drivers that have moved to the new probe method.
+ */
+static inline int iommu_dummy_of_xlate(struct device *dev,
+				       struct of_phandle_args *args)
+{
+	return 0;
+}
+
 #endif
-- 
2.42.0

