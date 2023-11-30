Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844181C39;
	Thu, 30 Nov 2023 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="d1Vb+2wc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DgCrtPVkWmnRHAiiNjldInWiJvuinV96ZDD0l0szCpjy/iuty8jptWzzBllDKfrruSGwVrZku9aZEE2rLibEfC6r3Vi43nme60Zb5yR6IlsR4kKJYT6NEmUvLw3O4WIPPRBVcyYG+Eh//aMzBAzeENCXz6IqHn1qjyDohnNqbgXfUx9cvMp5hVnyXJiAZ6OQ8RCxyfK+Kdl9Pzx91l+6hYxK5Hhm/wwMHCiO0nioiN6eUmPO5m9YGOnyNWM+MZwhyeKdlwf9Pq6gBgEOjbOt8HxiotySNNJr5C2bEo/PHavRLA5Vw9PWca/3Ym1CRWa8qeRMrWLyrKVAIR4aEnCmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=472sQygPvvhZhJ8WiOO2/mkS7+2EbUYdhDQB/DwfKZ8=;
 b=dzTYFpI/gxhEle75n4T2ZGOqaeli+03q1x/yk+3oCqMmOUnDAwdbZaHvGXFBh7JFvK6qpgx5iVMVJNrucCjSDY/I8K5MipJiiOvV8dVXkEy0okUY3a4H7fm2vBfMzOaw5FxlChe/WEZ5jt7PHRKzql9N74shkWw0kjywlX5T7DxpmNVi1ICuheA9BdIdguViffvqTkJTfJShscYq31F1lwboNNzAuLRPupPzJXOxggwLa8CItZXMETBJ7p7l/s1xIF0zTvBHLLuvlx+d9bPVwSszH6m0YrXd+JfzCw8ZsoI0A9grsOQc4040h/ZtZwncWGtKGUWqrIw1AxiW6lPV3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=472sQygPvvhZhJ8WiOO2/mkS7+2EbUYdhDQB/DwfKZ8=;
 b=d1Vb+2wcn59iiDfGPF17wzNLkS3A5pHoC7CvJc3oykA0DwvP1fErXHZaYJFGuLYaeieDiHd7T1rA2L8zfq7ItOjyeBRDYLEdmgtAfK9H+0nfogDyNZGEZDCdGU3WHj2MpBuHDTYfAuD7SIV6atawEVNY8RxZHvzNOSkadKeiVY8QjtlcfXWIHZSdBQgLuIQfF5+CFEcOz0MWtLF6SS0h16HbvwSmv44ckC+1si5AI7qkmmJwos8Ij8L7MYnqh4P0+oe7VMM4JVgdeZHF5SXWdAmd2EXqnG1up1PS13Oaq+lSxYXTsDZ25eSez3LFNvK55uWQWp76nkdanS20gj5DCw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:40 +0000
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
Subject: [PATCH v2 06/30] iommu: Make iommu_ops_from_fwnode() return the iommu_device
Date: Wed, 29 Nov 2023 21:14:06 -0400
Message-ID: <6-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0105.namprd13.prod.outlook.com
 (2603:10b6:806:24::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 46ef5bdf-3aa5-4777-9c14-08dbf141b650
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	y60t36f9HYC2fRXe7ZctsrmYbnIN5AnDgdD1U3b2NmSbb2dZbzkz2kN0qql2xv+VfaqFG3RPcOIoo6drepB2ylgC+5OSN4P+NmcERFWkxH7ToKUzfbufPn9vpkWBXSNo9xdcagbT6Xk2mSCg+h7R2QPApCkSlmy/t9E7C0CTVzuhaL3B2QdvVl0ww/v4r/Oc7VWihntnVPHxNqORhHRlIlPMdhBns2O2QIHdePiLyZRJiwca30GO/HEkH3DqpDcLZYeREh1IKxvGHU8XrP0nnao0EVDyRnDgbSkzU9W1Eq3nByGwJKjNJ59tC4yQ2krDVkOKZgRr9Ael77PRlbG96hOMzxzVCgUV0g5Hkx4PKIkRhMD+6ZcxYiMmQWxShBA3ECJ1RwQrhiMv/evVxnp+2munEaKoprAOdm0gLTF9DcBKAqIgveROSGDI38PqXj7w7EuQWbphskbyuCxXhJG0p9E0sk8cIGSQiO8Eyi5lGPJLmLZJ7bkOhkz2/GqQ+V6xlBMSOVMxiSSmAbGR0j9SSsTZdiq17bL5xfKbG/QwFjOZYZaugxzGYqRa7VRJmpAGf00V2o9eAW+oUgrSZQ5sKqMLnsK5evHl75MAZyALzVUpDQC7RtaIAk6rD0cMbaLe
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZkmPTfBggaSsLYTFFJZSzVzhMyPJUsm6xB5QDDLh10LgmVukkDdaR53MmeAq?=
 =?us-ascii?Q?2NiBH61ErMWPuP4ZeaJGj3o+AmttDLUaOeJDJyGcFBOI+8a6oHf+7VAcGOWw?=
 =?us-ascii?Q?KJiKgkBu3HvmqPg0mBeoA/+kpvza/r9YmophWNwFW1e+pNdZHi533dPyKKP6?=
 =?us-ascii?Q?2A6Qrm6lRNdrJSeUiivN4xoxbdZpCrxZlWg0FdDtAvnoy5o4HFs/nu95PYq1?=
 =?us-ascii?Q?PB2U/2/jfoEvyJcmZ8hxj3FZkevNqfvi37PVP94VCUcX9VEiLuOzvLWzx51f?=
 =?us-ascii?Q?cqDlQ083ZCtJOVWWnV8lR4L3/yU4rfsMDzq7b69vfiMjdjXwc1VIQYPSysMv?=
 =?us-ascii?Q?hcDZLBU51hIjrhVk9h7vsoxoebIRZ8Es0R/Cj3pKHD99V6P0Bll5VnVS56A7?=
 =?us-ascii?Q?FZegEYkYRMkln88nUCq52++5fO031wS4gCHcTCgQpKUG9eAGY7g9PWh1LWIn?=
 =?us-ascii?Q?iqKIO8Z0+vvOYjFahIGJVUW5Cg4jkBpjtkZr54VODmAPyxmt+1KwLr33CTZm?=
 =?us-ascii?Q?tdjAb/1Oe6wSYeDKz8GlXmNYz1R5IEE2brn3/qTG9QsTcFfGZ4ygPbRAapS3?=
 =?us-ascii?Q?k2F7qboxINYr50By+zsdbHnVMQGDmoYMT2fpUZAToT+pgjhGZDju7dwdo11b?=
 =?us-ascii?Q?JhzXBqmTCTTT51npYSgbxonbdm/J/mD8XbeLdiMyCEASkIzx+imtNkPL+Mt2?=
 =?us-ascii?Q?wCEtmFb7SNZHBhljhISM8MXT3SL50omrsLQ+UMDXlC6CQW8EiFEpB+MfDRXf?=
 =?us-ascii?Q?3IEXvvuTLiQa2jRPw+sL5xXWtg6pLsP2nOQfXmSXkCxlwbvrwyoHNpd8v07g?=
 =?us-ascii?Q?x7sGntMG/siWjdXGRa57t3IpvvP9vhjVTb5Zvp16DCgi/iltwwDyekN5bHfP?=
 =?us-ascii?Q?geMlQqJ5hF87hjudVcnWnV9zI6/D2yxybjIqSM1EmcRW0N5R4eb4RKKt1RJq?=
 =?us-ascii?Q?LxBVJQ+fWpX01ea5ptGDg55Ufam8P5vTgVXi6/kNi+RJTHQUtlsEus56LS82?=
 =?us-ascii?Q?lHkrkELtrr2VLxPn/YVJo8JqHR+Liw37ywFMUCSyxjBPew3/qNnCctW6sAu6?=
 =?us-ascii?Q?e02B5RdeEboGWYLzsOcvk6Z1WJEvbaApBOb4exPuQ38T+QJKmobvgAjy3ff5?=
 =?us-ascii?Q?pxVeL1ow2dU0c8RRF7y9NCOcMkpA2sXg0N1xDMOZBiM2pYkh5MC8KB6I9MIt?=
 =?us-ascii?Q?D7BzcTbmoUIqogMnwLhqqb7f3s6cyjibm6cyydEXcJvWNetNcE0MJXlZ1yJb?=
 =?us-ascii?Q?zdKJ+ZyYm4+LlaJ8of41a46BllbveoUICL4KNDv6SsHb6OTpPPs+0vui0dpm?=
 =?us-ascii?Q?uJfxdi7eBWDMHNLBmRl/8TxPuOCgBhet21z3Wddxz2iloP0hOn3CkTKYBQU7?=
 =?us-ascii?Q?ygr2F6HXqcwYZMN2CdV1CoHyCqiI52a49b6IfScbJQAa1tghRFDooIezUavE?=
 =?us-ascii?Q?BbK0VBbmoSqB8WkUqntTBIF/irgWhMgzD+ZuEmGpZOs0eUbS04ivWnmhUniI?=
 =?us-ascii?Q?mtgu/y4866xYiSPf5YSViQrJcRsvlTka5jgJfP9Oi9KbaT53l6KAA73WL7fD?=
 =?us-ascii?Q?39WIXbz/MRx1U3vF1U4XvRkSa9ZbtTE7aFQZW7Rv?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 46ef5bdf-3aa5-4777-9c14-08dbf141b650
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.8834
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HqIGW3H/VOVYFxFJX9FPu4M3ak8jqtHFTKh1M44DPQ3jxyXVjHY4LcduxgJB+WfL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Return the entire struct iommu_device instead of just the ops. Name
the changed function iommu_device_from_fwnode().

The iommu_device pointer is kept valid because this is always called
under the iommu_probe_device_lock.

If iommu_device is valid then ops is valid too, the module refcounting
is pointless. Remove it.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c    | 12 +++++++-----
 drivers/acpi/viot.c          |  9 +++++----
 drivers/iommu/iommu.c        | 20 +++++++++++++-------
 drivers/iommu/of_iommu.c     | 16 ++++++----------
 include/linux/iommu-driver.h |  3 +++
 include/linux/iommu.h        |  7 -------
 6 files changed, 34 insertions(+), 33 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 93e30f2f5004f0..798c0b344f4be8 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -797,6 +797,8 @@ void acpi_configure_pmsi_domain(struct device *dev)
 }
 
 #ifdef CONFIG_IOMMU_API
+#include <linux/iommu-driver.h>
+
 static void iort_rmr_free(struct device *dev,
 			  struct iommu_resv_region *region)
 {
@@ -1242,7 +1244,7 @@ static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
 			    void *info)
 {
 	struct device *dev = info;
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct fwnode_handle *iort_fwnode;
 
 	if (!node)
@@ -1253,19 +1255,19 @@ static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
 		return -ENODEV;
 
 	/*
-	 * If the ops look-up fails, this means that either
+	 * If the iommu look-up fails, this means that either
 	 * the SMMU drivers have not been probed yet or that
 	 * the SMMU drivers are not built in the kernel;
 	 * Depending on whether the SMMU drivers are built-in
 	 * in the kernel or not, defer the IOMMU configuration
 	 * or just abort it.
 	 */
-	ops = iommu_ops_from_fwnode(iort_fwnode);
-	if (!ops)
+	iommu = iommu_device_from_fwnode(iort_fwnode);
+	if (!iommu)
 		return iort_iommu_driver_enabled(node->type) ?
 		       -EPROBE_DEFER : -ENODEV;
 
-	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, streamid, iort_fwnode, iommu->ops);
 }
 
 struct iort_pci_alias_info {
diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index 7ab35ef05c84e0..9780b1d477503e 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -21,6 +21,7 @@
 #include <linux/acpi_viot.h>
 #include <linux/fwnode.h>
 #include <linux/iommu.h>
+#include <linux/iommu-driver.h>
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
@@ -299,7 +300,7 @@ void __init acpi_viot_init(void)
 
 static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 {
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct device *dev = info;
 
 	if (!viommu)
@@ -309,12 +310,12 @@ static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 	if (device_match_fwnode(dev, viommu->fwnode))
 		return -EINVAL;
 
-	ops = iommu_ops_from_fwnode(viommu->fwnode);
-	if (!ops)
+	iommu = iommu_device_from_fwnode(viommu->fwnode);
+	if (!iommu)
 		return IS_ENABLED(CONFIG_VIRTIO_IOMMU) ?
 			-EPROBE_DEFER : -ENODEV;
 
-	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
+	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, iommu->ops);
 }
 
 struct viot_pci_iommu_alias_info {
diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 76b245973cfafc..45e6543748fd46 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -520,13 +520,19 @@ static int __iommu_probe_device(struct iommu_probe_info *pinf)
 	 * ops for probing, and thus cheekily co-opt the same mechanism.
 	 */
 	fwspec = dev_iommu_fwspec_get(dev);
-	if (fwspec && fwspec->ops)
+	if (fwspec && fwspec->ops) {
 		ops = fwspec->ops;
-	else
-		ops = iommu_ops_from_fwnode(NULL);
+		if (!ops)
+			return -ENODEV;
+	} else {
+		struct iommu_device *iommu;
+
+		iommu = iommu_device_from_fwnode(NULL);
+		if (!iommu)
+			return -ENODEV;
+		ops = iommu->ops;
+	}
 
-	if (!ops)
-		return -ENODEV;
 	/*
 	 * Serialise to avoid races between IOMMU drivers registering in
 	 * parallel and/or the "replay" calls from ACPI/OF code via client
@@ -2997,7 +3003,7 @@ bool iommu_default_passthrough(void)
 }
 EXPORT_SYMBOL_GPL(iommu_default_passthrough);
 
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
+struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode)
 {
 	struct iommu_device *iommu;
 
@@ -3005,7 +3011,7 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
 
 	list_for_each_entry(iommu, &iommu_device_list, list)
 		if (iommu->fwnode == fwnode)
-			return iommu->ops;
+			return iommu;
 	return NULL;
 }
 
diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
index fb743ddd239e0b..cf68cdebc9f318 100644
--- a/drivers/iommu/of_iommu.c
+++ b/drivers/iommu/of_iommu.c
@@ -21,16 +21,16 @@
 static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 {
 	struct device *dev = info;
-	const struct iommu_ops *ops;
+	struct iommu_device *iommu;
 	struct fwnode_handle *fwnode = &iommu_spec->np->fwnode;
 	int ret;
 
-	ops = iommu_ops_from_fwnode(fwnode);
-	if ((ops && !ops->of_xlate) ||
+	iommu = iommu_device_from_fwnode(fwnode);
+	if ((iommu && !iommu->ops->of_xlate) ||
 	    !of_device_is_available(iommu_spec->np))
 		return -ENODEV;
 
-	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, ops);
+	ret = iommu_fwspec_init(dev, &iommu_spec->np->fwnode, iommu->ops);
 	if (ret)
 		return ret;
 	/*
@@ -38,14 +38,10 @@ static int of_iommu_xlate(struct of_phandle_args *iommu_spec, void *info)
 	 * IOMMU device we're waiting for, which will be useful if we ever get
 	 * a proper probe-ordering dependency mechanism in future.
 	 */
-	if (!ops)
+	if (!iommu)
 		return driver_deferred_probe_check_state(dev);
 
-	if (!try_module_get(ops->owner))
-		return -ENODEV;
-
-	ret = ops->of_xlate(dev, iommu_spec);
-	module_put(ops->owner);
+	ret = iommu->ops->of_xlate(dev, iommu_spec);
 	return ret;
 }
 
diff --git a/include/linux/iommu-driver.h b/include/linux/iommu-driver.h
index b85c9f15cf478b..636b5b5f18f76f 100644
--- a/include/linux/iommu-driver.h
+++ b/include/linux/iommu-driver.h
@@ -14,6 +14,8 @@
 
 #include <linux/types.h>
 
+struct fwnode_handle;
+
 struct iommu_probe_info {
 	struct device *dev;
 	struct list_head *deferred_group_list;
@@ -21,5 +23,6 @@ struct iommu_probe_info {
 };
 
 int iommu_probe_device_pinf(struct iommu_probe_info *pinf);
+struct iommu_device *iommu_device_from_fwnode(struct fwnode_handle *fwnode);
 
 #endif
diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index cf578b8e0b59a4..f0aaf55db3c09b 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -819,7 +819,6 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
 		      const struct iommu_ops *ops);
 void iommu_fwspec_free(struct device *dev);
 int iommu_fwspec_add_ids(struct device *dev, u32 *ids, int num_ids);
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
 
 static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
 {
@@ -1168,12 +1167,6 @@ static inline int iommu_fwspec_add_ids(struct device *dev, u32 *ids,
 	return -ENODEV;
 }
 
-static inline
-const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
 static inline int
 iommu_dev_enable_feature(struct device *dev, enum iommu_dev_features feat)
 {
-- 
2.42.0

