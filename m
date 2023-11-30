Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101B51FCE;
	Thu, 30 Nov 2023 01:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ITAfbvOg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cTKJ3YPPVrAQmeoQHoazu1PN6AwuSNJCz5CN3L3yh2WHmrs1XfB7xfyDd0cMrMSDpT2JLdkP1Ab//TkNRqLlVhyw5hTEQya0q6FqgrEbR/Xuz7TLrdRLcOA1r7KmzNr2xPccms+MeZW0dfrDNWL8OYkvpnbb2jz8VhXaDvL2EA96dCm8M0mN0z2Pa/Yngd0BjfisA1a2VWaohZabFW6cjcX/IYyA5g8DlNIKpXSX+2ruXIjzjbXlM6oym6i32/BQ3qO4b5nuKeEOSWCEDxcAfb/dzAKh+axusF1rTZ2gyUbe21YaXUDYNJZ+sYhOd0OlTNJT7BbvbgHyLUU8AW290w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1/2RwZb1BvcKrWpjq41xk6R0wcBobygbj+9IidcnE8=;
 b=imTfgN9qsgXNeYo+/w513hx3ifIWEbadc9SFq4tMNoJlZt7viVTPHu4CYQaeCuUdG0HUJNa/t/6+Gbyzgw9Cean0+CDbbV6X7mTXw3r+QdE2oi54vd9VgxHH4OAEJL+zn3QUdTLP+fZB0uRVRZnHmXQJVpaoeN0ioeNCQEECJ5LC+3RZDYHpeyGaPTUocP/IWL/Y8P5J7PQwTGl6MpqAMbmqG2T+NajuBhD4LCuo8Lfw0HC/eq4nc8De3/2/5B//vavgDGp33c7fUgbKO3zUD0WR0uTJrcl4ekxcaz7am7GqM1o/Qe5n5dHqdoxCGwx99/cfttMg3iwE/eWr12F0Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1/2RwZb1BvcKrWpjq41xk6R0wcBobygbj+9IidcnE8=;
 b=ITAfbvOgF/5InXDTxQ9r9MxRaU5HvNqqkbYoIg0GhTWLe+ZGicjAKFhujQb6qqoTubNB21+OJXmPy1MaEdrBzbq4wpAsBmX0GtwqHeEE39PXIjAoGeUcsamUqp4ntim+D4eMVF6WzKcSETieysnt0aLdT4GuLXoFwyW2U47bHFms2/K0+TymP7Fgjnw5fbEQksPAT5F2L33GIbjxo1oVzTNniuIvT13K8LywCCRYguecwbaTIdazFS0JO/CqG4rISnn2gmHSJu4ysatkg5iP53FY+lNrdil0XipdUZxOG23vT+z1V7pXtvc0rLGDg1gc/bdMGi4PLCX+ImBsJqaEvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MN0PR12MB5836.namprd12.prod.outlook.com (2603:10b6:208:37b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22; Thu, 30 Nov
 2023 01:14:41 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:41 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 04/30] ACPI: IORT: Remove fwspec from the reserved region code
Date: Wed, 29 Nov 2023 21:14:04 -0400
Message-ID: <4-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0107.namprd13.prod.outlook.com
 (2603:10b6:806:24::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0ba5ed-b9cd-41a3-c867-08dbf141b668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	bqi0gU3HklEgKOfHZVtkOoP58lgNukcsc40TBbs16fk9X6M4Xvr+bPN5odU09E2tZksTbuHpGTTU65xllZONfogdt2zu5p5WeuRSIwPgpwn4aag2WcyI8dPXM2eOgt0oNDh5E5/TLQrocdKQG7WtUnWlMmx+mu14XqAmqLIS1yulmQ+/VVHRqTZNA//ZEX/Aj/4Je34MQJSDzHPnVhcShREbrCm6eFXVbq489oetpo1P1GsiI4DLLUO4Qq/G2cKEW6OczoKyUod04voy/I1sdqw3sgR9NkTI5NaiE8y46mkG++/eaxj8Bjrjf0ONu/VDlpP18ifC4uJUjwZHSbEVZJAyWDYUjNBOVXLcCURGjxANelYuXzHfJvdVJ4aS5YEaGuhfAYViHg3oq+z/nVusawkozxjA41J3Pl3EuUMG08j7lq9WdizeUQq+auGe2wrdl6AnDTuYHIsnyENU2qwGz1G5D1ggmgO3EXYfa+88g2+IlqMtQuIPhLayLzwBXdGWWmKL91W6xQYdAJUlID4r+HTJZD4JFoZQedvfwrVtdBDwfLWdn3KAq2HUjXQJs9IQF6LmIQD8XM0+oHZG7ORuMhyGlL8Dpx1vKtLt9Qo9MoKqZpDvZzqCHECnDfmmFes+
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LsoC7U5noPe5CterWpp1LpFeEEOgVKVRTSyaLBrQ7AVRYrLYwq7czzTJG740?=
 =?us-ascii?Q?8PWlGfcUPeflT54P9izAkcBHmxiGSwPgvEp6PW4i1huo0wUbwzGZ1bOTTTSm?=
 =?us-ascii?Q?CGU6LmTAxm9fYIm456dYm4Kt8YoXBcaKggLIOmcuktumm8YxJMXKEBfURidT?=
 =?us-ascii?Q?aZs7o97ADgJr86g3UpeSkPV7ne4Du6wx2oKOnq5fx5XjyoTyJhn6sVVygpX8?=
 =?us-ascii?Q?iwo3u1GbtPcJNx/cPx5+qq8dj7IeElmd2PlxzSo9CHpeouInFyUAv8q5H9Bd?=
 =?us-ascii?Q?ZSnSrYqFzKiMLbyq11dCKrXE8voDcwPpus6e3FBRMR5edgWt5KgcWPIUOm/A?=
 =?us-ascii?Q?8pGhQOXTJZh6LGLlgYwP8waJgBPh4ywe/VX9l9jiMC04L0ZHe33T6SzeoMgw?=
 =?us-ascii?Q?6Utjc7OzVoND0/rlnG03wHdBfSG8A1JUKQNt66zrYKcBKwJNx9AAG0G5UvIL?=
 =?us-ascii?Q?CcdFAav84mMy06geeYIWZZIrLjH3vnTQVE7txwZbx1OalDW00Vq6/4TSmzIm?=
 =?us-ascii?Q?QblMZ+/1sSEAPXKmr5J6rJLX6k1ODttZhLU3QNu2RetlptEwG0siykxA4s9G?=
 =?us-ascii?Q?R+PfWyx5nZPMgxOIZvex3WssxYFOZPLwIzuMoYSbv+fjWkee5CaJ0ZY3HjFE?=
 =?us-ascii?Q?pC6jdtS8VzQ3v2Pd7Bk1D0RYsXm/HHz17ygPnnK9V1H2Vkn6aign2dLvkYjI?=
 =?us-ascii?Q?bOxXUP8gNO4yElD+DcwdCinMvByMPUrrVRBMZpS1ynrBqOkF6MQzlUbcfK3M?=
 =?us-ascii?Q?C3UODOQZV4JpfhDLVBNMFKHHu0fpNCiMKWy3Q3f56/3B8glirZFt0+9DkmHg?=
 =?us-ascii?Q?Q8ajwLbaOFoHXdid2Dn0WsT9HsCs/i8C8O74j1q+JZVQU0yuN2dDAnNAvaKC?=
 =?us-ascii?Q?V8vQyWZ0bEBwmZcN1+lVMm9SIDNQsh82c6snoiZWAk0nkWDzptHg0speYyWJ?=
 =?us-ascii?Q?ETMPZq58SAxDiSNJc9L2aTT8/vFqSqEcgJSP36fuW+p3Aa/4wRedGH5s/m4N?=
 =?us-ascii?Q?dgRNuts9cZt5fIdG8l2QuC5Su+SuY31vimUXtQG1AdX6Q7gP/j3dmS9tLodA?=
 =?us-ascii?Q?+xt9WxUMCmAPEsNauOkmShU01uWba+twhWG11mhmRNHEVBwpUbHaSnWIAxyD?=
 =?us-ascii?Q?+PaX4981kkpncbTmVBG56QyPIiRzYyw48X8SgXQcoXR7HGrMOiP2YZhJgNrM?=
 =?us-ascii?Q?cDBCJdf5Jt55nrVupTnvaxrMHv4JlWf9GHiMyd/M/IiIhcXoqa2k+8z0W1bA?=
 =?us-ascii?Q?eirOGGRNZRjp61mGM7jNYnh853miq/Gn1o1e7Yxkb4al0ytrjXhyn8dI5haL?=
 =?us-ascii?Q?blAJx9erP6PPGOwWHVRzZzStB7Y/Wp/eiep2APcoTazToIfT3liJn5k8w5P5?=
 =?us-ascii?Q?rPbCKFAlO35WPdWvkugtQLtXCmbUri0tyzKJfEeMgYyurEX+qWPKsx9M5bff?=
 =?us-ascii?Q?awak5jian4wGcnSLiPLigRNrBMh8eQ3KkfspWNIVAKpOE3NBpDNIQTzkZkA/?=
 =?us-ascii?Q?IqKWyCBEDxtocCtdWL7KRMYpb4IwjNOk6uEi7k2mgYicZ9xUGsia0czwKygA?=
 =?us-ascii?Q?m9wGDxWoebQ0FqBmkMADZoIfhJyVWX8z04wCaw3B?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0ba5ed-b9cd-41a3-c867-08dbf141b668
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:34.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4RVSyW8uQsyGP7DzxYPvneu0AyNd0qeb/qVELWCtDRVntIlLONTiR/V8+W1LOWcu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

iort_iommu_get_resv_regions() needs access to the parsed id array that is
currently stored in the iommu_fwspec.

Instead of getting this from the fwspec inside the iort code have the
caller pass it in.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 88 ++++++++++++++++++++++++---------------
 drivers/iommu/dma-iommu.c |  7 +++-
 include/linux/acpi_iort.h |  8 +++-
 3 files changed, 65 insertions(+), 38 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 5c9b4c23f96a87..93e30f2f5004f0 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -946,11 +946,19 @@ static u32 *iort_rmr_alloc_sids(u32 *sids, u32 count, u32 id_start,
 	return new_sids;
 }
 
-static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
+struct iort_resv_args {
+	struct device *dev;
+	struct list_head *head;
+	struct fwnode_handle *iommu_fwnode;
+	const u32 *fw_ids;
+	unsigned int fw_num_ids;
+};
+
+static bool iort_rmr_has_dev(struct iort_resv_args *args, u32 id_start,
 			     u32 id_count)
 {
+	struct device *dev = args->dev;
 	int i;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
 	/*
 	 * Make sure the kernel has preserved the boot firmware PCIe
@@ -965,18 +973,18 @@ static bool iort_rmr_has_dev(struct device *dev, u32 id_start,
 			return false;
 	}
 
-	for (i = 0; i < fwspec->num_ids; i++) {
-		if (fwspec->ids[i] >= id_start &&
-		    fwspec->ids[i] <= id_start + id_count)
+	for (i = 0; i < args->fw_num_ids; i++) {
+		if (args->fw_ids[i] >= id_start &&
+		    args->fw_ids[i] <= id_start + id_count)
 			return true;
 	}
 
 	return false;
 }
 
-static void iort_node_get_rmr_info(struct acpi_iort_node *node,
-				   struct acpi_iort_node *iommu,
-				   struct device *dev, struct list_head *head)
+static void iort_node_get_rmr_info(struct iort_resv_args *args,
+				   struct acpi_iort_node *node,
+				   struct acpi_iort_node *iommu)
 {
 	struct acpi_iort_node *smmu = NULL;
 	struct acpi_iort_rmr *rmr;
@@ -1013,8 +1021,8 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 			continue;
 
 		/* If dev is valid, check RMR node corresponds to the dev SID */
-		if (dev && !iort_rmr_has_dev(dev, map->output_base,
-					     map->id_count))
+		if (args->dev &&
+		    !iort_rmr_has_dev(args, map->output_base, map->id_count))
 			continue;
 
 		/* Retrieve SIDs associated with the Node. */
@@ -1029,12 +1037,12 @@ static void iort_node_get_rmr_info(struct acpi_iort_node *node,
 	if (!sids)
 		return;
 
-	iort_get_rmrs(node, smmu, sids, num_sids, head);
+	iort_get_rmrs(node, smmu, sids, num_sids, args->head);
 	kfree(sids);
 }
 
-static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
-			   struct list_head *head)
+static void iort_find_rmrs(struct iort_resv_args *args,
+			   struct acpi_iort_node *iommu)
 {
 	struct acpi_table_iort *iort;
 	struct acpi_iort_node *iort_node, *iort_end;
@@ -1057,7 +1065,7 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
 			return;
 
 		if (iort_node->type == ACPI_IORT_NODE_RMR)
-			iort_node_get_rmr_info(iort_node, iommu, dev, head);
+			iort_node_get_rmr_info(args, iort_node, iommu);
 
 		iort_node = ACPI_ADD_PTR(struct acpi_iort_node, iort_node,
 					 iort_node->length);
@@ -1069,25 +1077,23 @@ static void iort_find_rmrs(struct acpi_iort_node *iommu, struct device *dev,
  * If dev is NULL, the function populates all the RMRs associated with the
  * given IOMMU.
  */
-static void iort_iommu_rmr_get_resv_regions(struct fwnode_handle *iommu_fwnode,
-					    struct device *dev,
-					    struct list_head *head)
+static void iort_iommu_rmr_get_resv_regions(struct iort_resv_args *args)
 {
 	struct acpi_iort_node *iommu;
 
-	iommu = iort_get_iort_node(iommu_fwnode);
+	iommu = iort_get_iort_node(args->iommu_fwnode);
 	if (!iommu)
 		return;
 
-	iort_find_rmrs(iommu, dev, head);
+	iort_find_rmrs(args, iommu);
 }
 
-static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
+static struct acpi_iort_node *
+iort_get_msi_resv_iommu(struct iort_resv_args *args)
 {
 	struct acpi_iort_node *iommu;
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	iommu = iort_get_iort_node(fwspec->iommu_fwnode);
+	iommu = iort_get_iort_node(args->iommu_fwnode);
 
 	if (iommu && (iommu->type == ACPI_IORT_NODE_SMMU_V3)) {
 		struct acpi_iort_smmu_v3 *smmu;
@@ -1105,15 +1111,13 @@ static struct acpi_iort_node *iort_get_msi_resv_iommu(struct device *dev)
  * The ITS interrupt translation spaces (ITS_base + SZ_64K, SZ_64K)
  * associated with the device are the HW MSI reserved regions.
  */
-static void iort_iommu_msi_get_resv_regions(struct device *dev,
-					    struct list_head *head)
+static void iort_iommu_msi_get_resv_regions(struct iort_resv_args *args)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *iommu_node, *its_node = NULL;
 	int i;
 
-	iommu_node = iort_get_msi_resv_iommu(dev);
+	iommu_node = iort_get_msi_resv_iommu(args);
 	if (!iommu_node)
 		return;
 
@@ -1126,9 +1130,9 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 	 * a given PCI or named component may map IDs to.
 	 */
 
-	for (i = 0; i < fwspec->num_ids; i++) {
+	for (i = 0; i < args->fw_num_ids; i++) {
 		its_node = iort_node_map_id(iommu_node,
-					fwspec->ids[i],
+					args->fw_ids[i],
 					NULL, IORT_MSI_TYPE);
 		if (its_node)
 			break;
@@ -1151,7 +1155,7 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
 							 prot, IOMMU_RESV_MSI,
 							 GFP_KERNEL);
 			if (region)
-				list_add_tail(&region->list, head);
+				list_add_tail(&region->list, args->head);
 		}
 	}
 }
@@ -1160,13 +1164,24 @@ static void iort_iommu_msi_get_resv_regions(struct device *dev,
  * iort_iommu_get_resv_regions - Generic helper to retrieve reserved regions.
  * @dev: Device from iommu_get_resv_regions()
  * @head: Reserved region list from iommu_get_resv_regions()
+ * @iommu_fwnode: fwnode that describes the iommu connection for the device
+ * @fw_ids: Parsed IDs
+ * @fw_num_ids: Length of fw_ids
  */
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids)
 {
-	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
+	struct iort_resv_args args = {
+		.dev = dev,
+		.head = head,
+		.iommu_fwnode = iommu_fwnode,
+		.fw_ids = fw_ids,
+		.fw_num_ids = fw_num_ids,
+	};
 
-	iort_iommu_msi_get_resv_regions(dev, head);
-	iort_iommu_rmr_get_resv_regions(fwspec->iommu_fwnode, dev, head);
+	iort_iommu_msi_get_resv_regions(&args);
+	iort_iommu_rmr_get_resv_regions(&args);
 }
 
 /**
@@ -1178,7 +1193,12 @@ void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head)
 {
-	iort_iommu_rmr_get_resv_regions(iommu_fwnode, NULL, head);
+	struct iort_resv_args args = {
+		.head = head,
+		.iommu_fwnode = iommu_fwnode,
+	};
+
+	iort_iommu_rmr_get_resv_regions(&args);
 }
 EXPORT_SYMBOL_GPL(iort_get_rmr_sids);
 
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 85163a83df2f68..d644b0502ef48e 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -468,9 +468,12 @@ void iommu_put_dma_cookie(struct iommu_domain *domain)
  */
 void iommu_dma_get_resv_regions(struct device *dev, struct list_head *list)
 {
+	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
 
-	if (!is_of_node(dev_iommu_fwspec_get(dev)->iommu_fwnode))
-		iort_iommu_get_resv_regions(dev, list);
+	if (!is_of_node(fwspec->iommu_fwnode)) {
+		iort_iommu_get_resv_regions(dev, list, fwspec->iommu_fwnode,
+					    fwspec->ids, fwspec->num_ids);
+	}
 
 	if (dev->of_node)
 		of_iommu_get_resv_regions(dev, list);
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 5423abff9b6b09..13f0cefb930693 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -53,7 +53,9 @@ void iort_put_rmr_sids(struct fwnode_handle *iommu_fwnode,
 /* IOMMU interface */
 int iort_dma_get_ranges(struct device *dev, u64 *size);
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in);
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head);
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids);
 phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
@@ -72,7 +74,9 @@ static inline int iort_dma_get_ranges(struct device *dev, u64 *size)
 static inline int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 { return -ENODEV; }
 static inline
-void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head)
+void iort_iommu_get_resv_regions(struct device *dev, struct list_head *head,
+				 struct fwnode_handle *iommu_fwnode,
+				 const u32 *fw_ids, unsigned int fw_num_ids)
 { }
 
 static inline phys_addr_t acpi_iort_dma_get_max_cpu_address(void)
-- 
2.42.0

