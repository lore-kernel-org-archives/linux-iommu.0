Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1C8442C;
	Thu, 30 Nov 2023 01:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YGYkQoB2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a6Brgh6m0YohMAMLroOhdKqMFPWh+oSLpBDZPASYFyfD1M0aWoi1MA6kAVY7hIgYyLMfLbsNI2qnPZQ7Vh1rhZoGSPkDTmXN29F3llY2osA+bLBjRRJnPYUq3YgbtS/kh++XN1s1Kb4aFbRJmr4jWAqtVJJCdvSeZxNYid+O2d2aUzG4iFfFWnOH1uZrFv6cN2vYM/0q7o29Q3jkW8SUayLNxKcmQBJzLIN/NWYWD4+xT7FBoq6lEN+5T0KSrd6p1QtXPYrh4Fprq9Lqitg88QhG3Enu8C6gmLka3scZNhzgWNG1qbeO+5pWAJYn7LFUTy+VERL3KeHreIn+P32G0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1otHA+LIL3W1WZMWhBTV+rqHH68xzfh1OFbgeJsyAew=;
 b=J0yua5FW9XDWTKIhPgO3nFv5jJsQT3+BVRxbkIJ7ch9iqVU3CqsbRNruXi/UJyrgABe7rxvtn+7SntkrAAmChPeik6wHVQdhNYBaJNzlnkoJjCD7Fc5FiHMY2YE1mNed3F9U+MnjRjHSP0+tEAfz8iMOn8L9jpP9j6tUmwZ7VI9w2r9gM5RmFw8iw0jhBcMS+ijTFYKQD+iJckPuIFS0rZ7EMXLGkAM9CDUcafC0HYP297KiwqVHM1QYx4n+nnz8qd0kDY0YGO5MyBi8nApgeA6DZrQrtOU3HQeJwyGk/jd/VG+VQT2xTw2vwHFH4qgirzHu9tRRjQ9/fWl1o+0dOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1otHA+LIL3W1WZMWhBTV+rqHH68xzfh1OFbgeJsyAew=;
 b=YGYkQoB28VK3VF8fLRCMTQ/L1O1Bbvu70BMPz46+DY8vNl0DOvqYTT31NovFP/jeOwxu87WlGTsGv+nWpoQmHYg1i9l+vXS+IH8gtsn1QVDqwTLHe7yVf+9JDXv7aEwYiYcobtRgVELse2uedMC0uipAoGFp1exqLJVjTm2cyBTTamVkoE2ZVLdGUMgC4+iLO3Afv4DRTX3oD04K3D0QfhOlzaAF2qMh5Cus0UIeVQIbfDaJkuodskFzY64YlKR+aLneQHv8YUk6NfQrKjPLrSQzW1AGM5O8wzs9gopS+Tib13489l0PY/gCIcFfBB/RlbRjFZeO/v2mtt/yW+NWmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM6PR12MB4484.namprd12.prod.outlook.com (2603:10b6:5:28f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.23; Thu, 30 Nov
 2023 01:14:37 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Thu, 30 Nov 2023
 01:14:37 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To:
Cc: acpica-devel@lists.linux.dev,
	=?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
	iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Hector Martin <marcan@marcan.st>,
	Robin Murphy <robin.murphy@arm.com>
Subject: [PATCH v2 02/30] ACPI: VIOT: Make a viot_iommu_for_each_id()
Date: Wed, 29 Nov 2023 21:14:02 -0400
Message-ID: <2-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
In-Reply-To: <0-v2-f82a05539a64+5109-iommu_fwspec_p2_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SN6PR16CA0065.namprd16.prod.outlook.com
 (2603:10b6:805:ca::42) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM6PR12MB4484:EE_
X-MS-Office365-Filtering-Correlation-Id: ceca9c7e-df93-4f52-3325-08dbf141b61d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	A5v8Q7bz7d5qUn9FAHRMiwA74FgBU2JEQTP1NZVVm3T7syU3gIOxrmVmYB8XZiqR8Cy+93+Dz7QRFm7hRMWsw01ccCUSZHbwfcUccpR9Hg33TEWfEzMJWr+MzFHn4aXMm7Z7TUf9o7+0uE6cSSw+fxxhZIXlf8nZ/Ppw8pFcs3tykuOST4U+/5/O0VFMRb/a8EqRiQZcqKUNQ01Txx2YBRhsOdUq1hty4BXjxcd+TfB2w+nTJiDljngCboaGo86cbfO7DqMuLKfGL/4pRHXLdTL6GhNhymtMpUrCQn7EV6iNT/2/MzJUFzucjpQu3uK5jmOOmVLU86G50ng6CbEF2ZxQcoJxcxEBnPhm1eR62OBDEVik46jkZDOCo+FcG5MMTYuUxCBQYVV8mNFzWj77EZs42H2wQUAbexEUsdoTYdK69t6Po/EqLKzBSMvQ6Q6EE53N28EZEMj1scnTRLYCSgpTfDFmHFHRQXjW0a+cWrzKMxYKNxUMB0qwyLMkvpEqAALjcpG9aZHCq7ed+u0iWFWXGnwAy2A5Tkr3r+7nXzutNjyFdOp4jKeXu8k3PdJ3blHD1kTXCD7zL9E+yM35I5vf6kWh9/hcgyLzX7RYLkIZT9o0/R2TedEJ+GnOBl9Z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(396003)(136003)(346002)(39860400002)(230922051799003)(109986022)(1800799012)(451199024)(186009)(64100799003)(83380400001)(2616005)(26005)(66476007)(66946007)(54906003)(66556008)(2906002)(8676002)(4326008)(8936002)(86362001)(5660300002)(41300700001)(6506007)(6666004)(6512007)(36756003)(316002)(478600001)(6486002)(38100700002)(4216001)(266003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kxGRsA1JEimyMU0zsokGkwpTWXnozAa76sZe0axastNdQtRFHFoAbhHYgHVt?=
 =?us-ascii?Q?2U4fCEa9NxCj9psPSzi6JW+aRJbOVXAuE0ar0tOUjQX/aZAPHACPo3GfcBYy?=
 =?us-ascii?Q?JRjrZ+SUrt5Xa5wbELbeslZiLjRhO5nyp9JjcRtF7D5rSUYBdL8o7jHsDeca?=
 =?us-ascii?Q?IeYqMmXWnsJeEpxRPsEgfokn95LYsZ5jxTiXa8CvyN8b16Jb547+zPrieIZy?=
 =?us-ascii?Q?R1BsOK0BUsdsw5SzKnj5JALivZra5fTRnYjA2nlgPiSGBaGcDLP/bKSMYAo9?=
 =?us-ascii?Q?PGLD3HAOGkud7qXD9jdyUfIebaHheSptuPL/AqhahG1/KTF9ks+acC2uBNV8?=
 =?us-ascii?Q?3Gxp/833vuKKHXb35ceq+5EIpn8Q33hUBHrZAol2XFhc+HISQqBL/O8w14CK?=
 =?us-ascii?Q?63Gq5CwUl6ATnoGYsK4LHr6VsIIhdOu6bMNHqKUJmeJBZtHFQ1tYEJ5Bt+LX?=
 =?us-ascii?Q?d34nkYD96SEqOqjB20WhbhJtvqpShW1EROyR7NPUw4SxzuHGqNFSPnFcFbzU?=
 =?us-ascii?Q?qqPiKTW8WcXy/7dubSTevTQlfwW4t/bIInFpaspm2vS734CvwiizMhlBBPMm?=
 =?us-ascii?Q?CmBBO7kT9OAo0juzHae/D5jEDDGQqQhQrvHXOYXhxcZEx4QqvVAPQGY1UrUi?=
 =?us-ascii?Q?hg6uv+61H0zRaB08Lh2B4PuNSqMiPD1z9dWW1E2/i+sOBVrFQiVIzB935Yjj?=
 =?us-ascii?Q?nP31vuWmxNMw6rfhlWNpQ718hxXvJ/OoHFKVWRIQ6iOB+LZX3jBV++J6JonU?=
 =?us-ascii?Q?iS0PBjFDwbXsFrhvSOBxNvdXj1M91/sghq7Cc4DGvnCxq9VNd7d/7PCetVDE?=
 =?us-ascii?Q?xzTfqbGlX/a8uV9/xt+93cDXMqiLuonykqzaEW/Humlv/eILk8oZrvleWOsD?=
 =?us-ascii?Q?wyE2dY0Ez4qHoID+ciOYdpJvPRWVas7xjZ5J1jnB+h7NGJqEBdtWcXG5H79+?=
 =?us-ascii?Q?BAa8IkZ5ZNV0nEW0iQsTzyrmeo400qCEJrlC/AM0CTIPSmMEi36nI9kUbO11?=
 =?us-ascii?Q?Uuu5Wrd3NZWhXKc/NLp/1CDTe8iQNLZMnePIgu3N8z/bZAaWjbwM0ZwknAtB?=
 =?us-ascii?Q?RKzbw4hxrrFqsUgmV6L1D2KuJWZSmneYfXYKFISXYHVsYoGcDW1F4iBZxgo4?=
 =?us-ascii?Q?E6cV6T4tv+SO1h4EgSJVWOWheeuJ5/fuczjIdj3AiLlAMPJN0b+mnXsMl74o?=
 =?us-ascii?Q?B6N+stRHjImjukbHfQZu0H0SeH82SWIGN4EQHtmVdQD8levQ9AzxTSHFBmgD?=
 =?us-ascii?Q?PwE7x5u0qI+gZ9Xql3rft32Oj/w+TFXPP4pCaZWlCvMD8l1mZyhqiHWzBhP+?=
 =?us-ascii?Q?D4sK22s5LVTDjvKPBbM0DbyLZoLRxebSWZ/AzKy4OcSHjfN+kLgFm3w5nuZC?=
 =?us-ascii?Q?5LCkFmaVmwCjkhGtjohAoFBquweVuWd4Q9FldQlcUDufUvrkLkVexTc07Jr2?=
 =?us-ascii?Q?oYRHq0B+shEeZFmQNNVOpKvV3aMjwqnPnloydJjJYQq5hp3Koyx5BwBRcslB?=
 =?us-ascii?Q?KZXuVyNQPuFi4qn4IIYywaXeXJVoZbRqVsTDUWcFyldN5axEuBZKcH+WiAXO?=
 =?us-ascii?Q?zRfkrUx8m2qAzqZ37AIdbxdjx1qMZO5tPa4eTit2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ceca9c7e-df93-4f52-3325-08dbf141b61d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2023 01:14:33.4642
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +cDVAQwNoh/Mr3O8hEDX40wX6d5J6T5FnxNhKQEd+kT6CCh95+4zPyaLBOQM6ayh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4484

Similar to of_iommu_for_each_id() this parses the VIOT ACPI description
and invokes a function over each entry in the table.

Have viot_iommu_configure() use the new function to call
viot_dev_iommu_init().

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/acpi/viot.c       | 54 +++++++++++++++++++++++----------------
 include/linux/acpi_viot.h | 11 ++++++++
 2 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/drivers/acpi/viot.c b/drivers/acpi/viot.c
index c8025921c129b2..7ab35ef05c84e0 100644
--- a/drivers/acpi/viot.c
+++ b/drivers/acpi/viot.c
@@ -25,13 +25,6 @@
 #include <linux/pci.h>
 #include <linux/platform_device.h>
 
-struct viot_iommu {
-	/* Node offset within the table */
-	unsigned int			offset;
-	struct fwnode_handle		*fwnode;
-	struct list_head		list;
-};
-
 struct viot_endpoint {
 	union {
 		/* PCI range */
@@ -304,10 +297,10 @@ void __init acpi_viot_init(void)
 	acpi_put_table(hdr);
 }
 
-static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
-			       u32 epid)
+static int viot_dev_iommu_init(struct viot_iommu *viommu, u32 epid, void *info)
 {
 	const struct iommu_ops *ops;
+	struct device *dev = info;
 
 	if (!viommu)
 		return -ENODEV;
@@ -324,11 +317,17 @@ static int viot_dev_iommu_init(struct device *dev, struct viot_iommu *viommu,
 	return acpi_iommu_fwspec_init(dev, epid, viommu->fwnode, ops);
 }
 
-static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
+struct viot_pci_iommu_alias_info {
+	struct device *dev;
+	viot_for_each_fn fn;
+	void *info;
+};
+
+static int __for_each_pci_alias(struct pci_dev *pdev, u16 dev_id, void *data)
 {
 	u32 epid;
 	struct viot_endpoint *ep;
-	struct device *aliased_dev = data;
+	struct viot_pci_iommu_alias_info *info = data;
 	u32 domain_nr = pci_domain_nr(pdev->bus);
 
 	list_for_each_entry(ep, &viot_pci_ranges, list) {
@@ -339,14 +338,14 @@ static int viot_pci_dev_iommu_init(struct pci_dev *pdev, u16 dev_id, void *data)
 			epid = ((domain_nr - ep->segment_start) << 16) +
 				dev_id - ep->bdf_start + ep->endpoint_id;
 
-			return viot_dev_iommu_init(aliased_dev, ep->viommu,
-						   epid);
+			return info->fn(ep->viommu, epid, info->info);
 		}
 	}
 	return -ENODEV;
 }
 
-static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
+static int __for_each_platform(struct platform_device *pdev,
+			       viot_for_each_fn fn, void *info)
 {
 	struct resource *mem;
 	struct viot_endpoint *ep;
@@ -357,12 +356,28 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
 
 	list_for_each_entry(ep, &viot_mmio_endpoints, list) {
 		if (ep->address == mem->start)
-			return viot_dev_iommu_init(&pdev->dev, ep->viommu,
-						   ep->endpoint_id);
+			return fn(ep->viommu, ep->endpoint_id, info);
 	}
 	return -ENODEV;
 }
 
+int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info)
+{
+	if (dev_is_pci(dev)) {
+		struct viot_pci_iommu_alias_info pci_info = {
+			.dev = dev,
+			.fn = fn,
+			.info = info,
+		};
+		return pci_for_each_dma_alias(to_pci_dev(dev),
+					      __for_each_pci_alias, &pci_info);
+	}
+
+	if (dev_is_platform(dev))
+		return __for_each_platform(to_platform_device(dev), fn, info);
+	return -ENODEV;
+}
+
 /**
  * viot_iommu_configure - Setup IOMMU ops for an endpoint described by VIOT
  * @dev: the endpoint
@@ -371,10 +386,5 @@ static int viot_mmio_dev_iommu_init(struct platform_device *pdev)
  */
 int viot_iommu_configure(struct device *dev)
 {
-	if (dev_is_pci(dev))
-		return pci_for_each_dma_alias(to_pci_dev(dev),
-					      viot_pci_dev_iommu_init, dev);
-	else if (dev_is_platform(dev))
-		return viot_mmio_dev_iommu_init(to_platform_device(dev));
-	return -ENODEV;
+	return viot_iommu_for_each_id(dev, viot_dev_iommu_init, dev);
 }
diff --git a/include/linux/acpi_viot.h b/include/linux/acpi_viot.h
index a5a12243156377..fce4eefcae4aad 100644
--- a/include/linux/acpi_viot.h
+++ b/include/linux/acpi_viot.h
@@ -5,6 +5,17 @@
 
 #include <linux/acpi.h>
 
+struct viot_iommu {
+	/* Node offset within the table */
+	unsigned int			offset;
+	struct fwnode_handle		*fwnode;
+	struct list_head		list;
+};
+
+typedef int (*viot_for_each_fn)(struct viot_iommu *viommu, u32 epid,
+				void *info);
+int viot_iommu_for_each_id(struct device *dev, viot_for_each_fn fn, void *info);
+
 #ifdef CONFIG_ACPI_VIOT
 void __init acpi_viot_early_init(void);
 void __init acpi_viot_init(void);
-- 
2.42.0

