Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC141FBF;
	Thu, 30 Nov 2023 01:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BlPWnpkn"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e7e0E+yiJgdZGpEY54OebXJK6SZNcLnay7i+4LzAQe7yjS37oss/JRQV6YkWFn5gNuRYALiaH+IB+fdZtLQPhkiTIK2uO93jutPAM1f0c+bRZIv43s7hvoAdEbhizsycYx7gSldahl7sOXQDZZvVvVrUUGSonhAw7r+aHeqZGpPIdksTfFaRp1nv2AhSXybu0MRImNNTP8wnOnJGiUNU1uZNqMTlySM/t+reXbnNMFn44eczF4lTDdXK9fZZTIF06yPScvT+hfnmIvD6QUPrso3h/XWeZiqmMnGsHJJsImhfmOubjzy2QjcVUaB7cywzBl347qbRRj2+1RUcU66S8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TeNlyomNkLn0vDrMhnXRZEG4tXI6kjRAm58pilBJJWY=;
 b=RRHBQmgjvLQAKdVF8L7ctw2QRzdS6B6fm9Vra3SE6sMhgrCFgvJZSCJX/lfu09/DA53vGBBbYoZpkEKjGxe2E3gQfDOxRrxvcRMip8vqOKl74tzy2vCWYgvqpUXqG2Uaa3DtMUqXwNTNwZZXjsAkfl8axVaahXeQzdTzBRTWEisRAKTOnYJdt5dw0PyYByuPxlJRNDMbYIFnlR9oNVwJF+qIV6l9sU5zZvr1Z9aEhAtRjIdohg7FGmR1PWe5JDjyflKAAiu5nrkw7DbCsFItuzMPqtPsPk8rKd/6Zk2zWxHQEILGF3K0zRVgOdv4U7CX6vOveqmABODy74aFVNN/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TeNlyomNkLn0vDrMhnXRZEG4tXI6kjRAm58pilBJJWY=;
 b=BlPWnpknRRF0XZu80XLmDu9PH8WQwAo29kWMLEAjJqN2FNRjSHz4C4KetCzYYK7A02mLrsZ24yOc+7aBG996zpiEwaZ8iWF/BQR4flL1kdiASLL5UMCxBjsI63S53JX9GeGNdV0PGiRz0RrbLfgHVpj71t+CyV6HocstBO7q+Hx98P0xi5eNL/GsHXAElMeq8lxXoSExfANKJ/cExHql2k6O1alsDYEtAanAfNE98haNhb+CpRU/yUjxd7pQ7iYJ2GvENdRlzFmAMMOO8k+8Orsjh31IUnf6JUfLMv+7JPY8tAJsLAVAp6NzUBHDzhJ8pfAvjS2ui6n1V3taHjOybw==
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
Subject: [PATCH v2 03/30] ACPI: IORT: Make a iort_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:14:03 -0400
Message-ID: <3-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA9PR13CA0093.namprd13.prod.outlook.com
 (2603:10b6:806:24::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MN0PR12MB5836:EE_
X-MS-Office365-Filtering-Correlation-Id: 1940cfa0-d666-4f19-db9c-08dbf141b70e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VXRWT63Zp0apyPOtIiVl/UEPRI1opmfjZJaXpj+M9wNIeipUZjco4AJPXS2TgWUIsS8e80sX6pGhYnRDGmjPadkN+I4Y7K4kiEgjIvehpMtF5P8pnjzqDrkPukrjpmWnPn+XxtjrwpuNe74AI0/V5SY+mIOq2YVpoAc2Zx41p84zrBPMdE65QLN3Wp4SVjIbV+gUoApakhqLLPuc1m7I9uxiMObpLk/07vEdkS9FcRSrRy28z/mh8U917pBulL7CneKFGFFBMRt+2yi6c9ZPnD+PmpZSsR53/mmmldThFdx8P1DWb77qGWq+HeIgHQvrWamis41yHXPY8DL1TWzHpPocDQ3qdHOFeIBkD9wSCzQErIW9D+i6s7XLhWcH24JxyZ7V2AerLivh5Uxy5ywM7eH+ZSPkBw8rkbOXIukj6igFo75sZrUE1tIl8w4qEA8+AYuFobTY8uwUCxNmTp+eJXejrBSuqGzGtJdkxuvk5Z7GNQrZsIjYGmNCQovyb4nkRK8mHu0J2BDOWjq9DOYNMftBq90gqzayPT2lVFCxf5Xjya5toW1rxiHYMbmRfq0UH7mEx+tZ6gcNlUtWSu8ZD9Fb1FJsuhThOMKz/tm8vGYcB4k6wB7JpkKHZHCe6rTk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(136003)(396003)(39860400002)(376002)(230922051799003)(1800799012)(186009)(64100799003)(109986022)(451199024)(6486002)(4326008)(478600001)(8676002)(86362001)(5660300002)(8936002)(54906003)(66476007)(66556008)(66946007)(6506007)(2906002)(316002)(6666004)(6512007)(36756003)(26005)(2616005)(83380400001)(41300700001)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?i6OUCgopAXJ34Czwksk9ggAH+UpsqpHdG53buvlalcDcDG2WhWCwsJ2pwiUF?=
 =?us-ascii?Q?tng8DzQYpiAUKSHjJbEl1ZflO9RQAY0kJTE299qHQPwY73CMUP7h1eCXxUdV?=
 =?us-ascii?Q?xAl9glN4imxE0GYfo8z2CQNvD+0C/0ZNlf68JWimtcNLNgPM5WUYaaLVcH2d?=
 =?us-ascii?Q?A16qU8hpap2mgSuGzV9lqt+BqaZQW/wAc8nRfM/WUmA66MQcc9e7gdiq+0bb?=
 =?us-ascii?Q?PP8zK3eG9nbPk4PJu2WKOL8ev5KqH1tWoFBrTHZVtozFIXGORXoTyThfh9/o?=
 =?us-ascii?Q?O09+IpyemUqyl8P9SF5tCmih1FbvBgRy7m/SzjPkp3zpeCSLIr/lfcV/sdEl?=
 =?us-ascii?Q?jrJ98VwX6D/url6s9unbvkT3cb8QYzGIMrvgPF2R/5sXrvJ6LkeB7CuQZk03?=
 =?us-ascii?Q?pvNOHQk2vXb7h4xERSEv3Y8/F5YzO7dCb4MnuJaPMieJnrx75j97Vfu/La65?=
 =?us-ascii?Q?9497fzHUKe63ZRIPmP5cKncIOLKEG8tQxzSreN+FbPtBdOLVC4D/vmOpjCk1?=
 =?us-ascii?Q?JSK12NbGO2o+k8QVS/lbHLwVqSDQIPeKDhzwBlSogNtm1EPifu+PW/jHO7N/?=
 =?us-ascii?Q?oiyComF1A36T1oYge3chEdOZLHYpLp32sNwW+3MMRep3bFvopg+mqnJuzObR?=
 =?us-ascii?Q?F3s4JIndZnn+qiHuqKxB7T0gGxmMqoXNFx+CdSTMnZyNVVB2XWAOxPaVZ4cM?=
 =?us-ascii?Q?G4+mTntrYspgc/YM0rdbyQZju/bivLzjcUn6qd9BmXHr9RHtIBQBVLy/SCUC?=
 =?us-ascii?Q?wnJPKNJShWJ0bNhI79KhaFxr8hENoGkHAfiwiaqZg/y5oGT68Zx1iRKMTU+M?=
 =?us-ascii?Q?1Dz3XRg3LjlzLslwzRDfLKG3w1oJwFByPRYzETJdQNemP5ywwradG26bIsAh?=
 =?us-ascii?Q?UJzLs4G6J6oAbJW1V7/3r79TZEOz/kxe0hb3bLTsgl9i/u2r/FpQQSPBnAAu?=
 =?us-ascii?Q?MFk6iDqjOssml4VxL4sAjFZn+WzVFCLNHVxLXvgaM6gT1gk/tLm6OtPhshpS?=
 =?us-ascii?Q?NN8PQSPAeduGkH0tKZIKjECDZnG8bAYIL7NsSblexwshADKweoX49bmwaJuR?=
 =?us-ascii?Q?UwOyz2HZequrXa2FSSwrJmEMab2cl935bv0WnFXhwK6Mz/ZA8j1ojHl+AQ3a?=
 =?us-ascii?Q?is+2er7xjrU0LkXmYguHuOVStqyh5ZogjqyizoxO43OSFcKSGIEPNDZnH+2s?=
 =?us-ascii?Q?exFuOaBZiDss0gy4yULh0IY8tbpebbzeHE96WSepMQLRtA1IlKmWFfrCZzqZ?=
 =?us-ascii?Q?3U6hpXzdEK9+kDlccvET11plTNaLj3G3m7S6ngT+wA/mye9MTOKbO2R0IpCt?=
 =?us-ascii?Q?sBT9BA8Ea+D0olTdN639++p/rCLwycxdSEpGdQqgL9x+zgMmUx2TqbpedoJl?=
 =?us-ascii?Q?ivtb851C+dYdUNRH4UqtrAj0UyxwNQBdQQ8Wj7pAW3YtL3jiApZlzuH9No5P?=
 =?us-ascii?Q?IzHCqwaHrFGh9DDRf6mABjHQeU9PrxHvMzM/dYLL1wLdZqQqrLX7RaN9AfXi?=
 =?us-ascii?Q?PqBxwPwXT4iCHwfWR+MYFbiHIVHFcgPH2Dbb1f0cxf3xxUesitkxhT4M68Wk?=
 =?us-ascii?Q?teFebr+XlmsDVguBp490FRrAm51wSimLlI5mJP2A?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1940cfa0-d666-4f19-db9c-08dbf141b70e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:35.0058
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LDA80T2Bq262cpucgnm4IZLoMPFtGFL/y7eAd0VguxavARHo+BLbX9k7dpL3HLSK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5836

Similar to of_iommu_for_each_id() this parses the IORT ACPI description
and invokes a function over each entry in the table.

Have iort_iommu_configure_id() use the new function to call
iort_iommu_xlate().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/arm64/iort.c | 118 ++++++++++++++++++++++++--------------
 include/linux/acpi_iort.h |  12 ++++
 2 files changed, 86 insertions(+), 44 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index bdaf9256870d92..5c9b4c23f96a87 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1218,9 +1218,10 @@ static bool iort_pci_rc_supports_ats(struct acpi_iort_node *node)
 	return pci_rc->ats_attribute & ACPI_IORT_ATS_SUPPORTED;
 }
 
-static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
-			    u32 streamid)
+static int iort_iommu_xlate(struct acpi_iort_node *node, u32 streamid,
+			    void *info)
 {
+	struct device *dev = info;
 	const struct iommu_ops *ops;
 	struct fwnode_handle *iort_fwnode;
 
@@ -1250,9 +1251,11 @@ static int iort_iommu_xlate(struct device *dev, struct acpi_iort_node *node,
 struct iort_pci_alias_info {
 	struct device *dev;
 	struct acpi_iort_node *node;
+	iort_for_each_fn fn;
+	void *info;
 };
 
-static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
+static int __for_each_pci_alias(struct pci_dev *pdev, u16 alias, void *data)
 {
 	struct iort_pci_alias_info *info = data;
 	struct acpi_iort_node *parent;
@@ -1260,7 +1263,7 @@ static int iort_pci_iommu_init(struct pci_dev *pdev, u16 alias, void *data)
 
 	parent = iort_node_map_id(info->node, alias, &streamid,
 				  IORT_IOMMU_TYPE);
-	return iort_iommu_xlate(info->dev, parent, streamid);
+	return info->fn(parent, streamid, info->info);
 }
 
 static void iort_named_component_init(struct device *dev,
@@ -1280,7 +1283,8 @@ static void iort_named_component_init(struct device *dev,
 		dev_warn(dev, "Could not add device properties\n");
 }
 
-static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
+static int __for_each_platform(struct acpi_iort_node *node, iort_for_each_fn fn,
+			       void *info)
 {
 	struct acpi_iort_node *parent;
 	int err = -ENODEV, i = 0;
@@ -1293,27 +1297,71 @@ static int iort_nc_iommu_map(struct device *dev, struct acpi_iort_node *node)
 						   i++);
 
 		if (parent)
-			err = iort_iommu_xlate(dev, parent, streamid);
+			err = fn(parent, streamid, info);
 	} while (parent && !err);
 
 	return err;
 }
 
-static int iort_nc_iommu_map_id(struct device *dev,
-				struct acpi_iort_node *node,
-				const u32 *in_id)
+int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
+			   struct iort_params *params, iort_for_each_fn fn,
+			   void *info)
 {
-	struct acpi_iort_node *parent;
-	u32 streamid;
+	struct acpi_iort_named_component *nc;
+	struct acpi_iort_node *node;
+	int err = -ENODEV;
 
-	parent = iort_node_map_id(node, *in_id, &streamid, IORT_IOMMU_TYPE);
-	if (parent)
-		return iort_iommu_xlate(dev, parent, streamid);
+	memset(params, 0, sizeof(*params));
+	if (dev_is_pci(dev)) {
+		struct pci_bus *bus = to_pci_dev(dev)->bus;
+		struct iort_pci_alias_info pci_info = { .dev = dev,
+							.fn = fn,
+							.info = info };
 
-	return -ENODEV;
+		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
+				      iort_match_node_callback, &bus->dev);
+		if (!node)
+			return -ENODEV;
+
+		pci_info.node = node;
+		err = pci_for_each_dma_alias(to_pci_dev(dev),
+					     __for_each_pci_alias, &pci_info);
+
+		if (iort_pci_rc_supports_ats(node))
+			params->pci_rc_ats = true;
+		return 0;
+	}
+
+	node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+			      iort_match_node_callback, dev);
+	if (!node)
+		return -ENODEV;
+
+	if (id_in) {
+		struct acpi_iort_node *parent;
+		u32 streamid;
+
+		parent = iort_node_map_id(node, *id_in, &streamid,
+					  IORT_IOMMU_TYPE);
+		if (!parent)
+			return -ENODEV;
+		err = fn(parent, streamid, info);
+	} else {
+		err = __for_each_platform(node, fn, info);
+	}
+	if (err)
+		return err;
+
+	nc = (struct acpi_iort_named_component *)node->node_data;
+	params->pasid_num_bits = FIELD_GET(ACPI_IORT_NC_PASID_BITS,
+						nc->node_flags);
+	if (nc->node_flags & ACPI_IORT_NC_STALL_SUPPORTED)
+		params->dma_can_stall = true;
+
+	iort_named_component_init(dev, node);
+	return 0;
 }
 
-
 /**
  * iort_iommu_configure_id - Set-up IOMMU configuration for a device.
  *
@@ -1324,40 +1372,22 @@ static int iort_nc_iommu_map_id(struct device *dev,
  */
 int iort_iommu_configure_id(struct device *dev, const u32 *id_in)
 {
-	struct acpi_iort_node *node;
-	int err = -ENODEV;
+	struct iort_params params;
+	int err;
 
-	if (dev_is_pci(dev)) {
+	err = iort_iommu_for_each_id(dev, id_in, &params, &iort_iommu_xlate,
+				     dev);
+	if (err)
+		return err;
+
+	if (params.pci_rc_ats) {
 		struct iommu_fwspec *fwspec;
-		struct pci_bus *bus = to_pci_dev(dev)->bus;
-		struct iort_pci_alias_info info = { .dev = dev };
-
-		node = iort_scan_node(ACPI_IORT_NODE_PCI_ROOT_COMPLEX,
-				      iort_match_node_callback, &bus->dev);
-		if (!node)
-			return -ENODEV;
-
-		info.node = node;
-		err = pci_for_each_dma_alias(to_pci_dev(dev),
-					     iort_pci_iommu_init, &info);
 
 		fwspec = dev_iommu_fwspec_get(dev);
-		if (fwspec && iort_pci_rc_supports_ats(node))
+		if (fwspec)
 			fwspec->flags |= IOMMU_FWSPEC_PCI_RC_ATS;
-	} else {
-		node = iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
-				      iort_match_node_callback, dev);
-		if (!node)
-			return -ENODEV;
-
-		err = id_in ? iort_nc_iommu_map_id(dev, node, id_in) :
-			      iort_nc_iommu_map(dev, node);
-
-		if (!err)
-			iort_named_component_init(dev, node);
 	}
-
-	return err;
+	return 0;
 }
 
 #else
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 1cb65592c95dd3..5423abff9b6b09 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -29,6 +29,18 @@ void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
 int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
 
+struct iort_params {
+	unsigned int pasid_num_bits;
+	bool dma_can_stall : 1;
+	bool pci_rc_ats : 1;
+};
+
+typedef int (*iort_for_each_fn)(struct acpi_iort_node *iommu, u32 streamid,
+				void *info);
+int iort_iommu_for_each_id(struct device *dev, const u32 *id_in,
+			   struct iort_params *params, iort_for_each_fn fn,
+			   void *info);
+
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
-- 
2.42.0

