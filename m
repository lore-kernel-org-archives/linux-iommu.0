Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2057.outbound.protection.outlook.com [40.107.223.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3096217EC
	for <iommu@lists.linux.dev>; Tue, 16 May 2023 00:27:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JHXUk1xyO8tDfPmflneELmucD8jlzfOGygqdhiXvVMVILxg/6rBT6xGaXrWDukNZxQGXEzcF8Qr0FU1VxWDBpTUteKKY9ndzqGLTXdzCrwaN5WPIISGbrHZXk41lDeQrIaPeJKkihRz8uV2VKT4x9JFAcEYbSJRkdT7ANG6mL7NCv1Sdy4Ukdm5wJSV5xEjSLGBhnXGZJGZHWR+HmpOCesXfL++U9zTxWjfmO1uGtew9h5DtMlYGsiK9SD61bmIcckFLalokeCruELE92PJE5NP/qfTxItbFUEroUmadUdfch8m7sPuMp4cK0OM2qxo1i8YcEmIwhnBU8W9hvLGPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rG25Bnf6zt4Mw7yBHnQXW3mqrCbWcS8lGC7dWXx77oQ=;
 b=g/gtm5MxY+bzvM/hKDDDTKhsKUtW0pE9aIXeOoZ2NMe+MdaOGwz+806nCraE+0ul0+DmFEEkN3vavXnJrwe8V8UayMmRa9AodRWAQZ9+bhOdH/pQgVyWc6/YlZpQSBGkHmQZTgtNxHiKoljl8J7Ba/XJGLifJ8ECEA1HrGqohD+EUIjSmo7Ec9Tolp3kwEaHEWWBW0hfGfcz56csf5UKofXsS2e+YkgbdQhHCJha/edmeSPIfGvIQU4vcMIVif5IV+o4RG+YImZUE5IBOCst8OLMCkR7IkBpRXJ0OlI88HDvw+iAbhwUI9z0O4Z3uJ3RHGbWWWND5d6sDGLttILHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rG25Bnf6zt4Mw7yBHnQXW3mqrCbWcS8lGC7dWXx77oQ=;
 b=ns9wddooFPH2FxdYVheYTHVpkFYj3bzi8QQtMaeThFdanYXuaV+YTGPpLMbcECE8+0gEzi8flg63JaYrvG4sJOwB6tV4Zp1Ej3JN9RVCkYBcHXW/j5UXGt0ESS0BesM8cHvLoU3lvPQZJyeHYSnrPim3L7bYmcvMbZSg26u3ycLNwPxQTrSQlf9eYNDxkoEKO4/3z5f/+vKPkvwYNRQRuubl8HjKWLp8xEd8Omt9o9h7CiOfygiz90cTT9GxnRimWWAm8VF1Ji88y8mR0DpPHJqx7kdSZhSiTcyDD+24a1aG8R17lBXE56JoEAQ9otmaLUgtcOHMwjYfLqyUn1KHLw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SJ0PR12MB6783.namprd12.prod.outlook.com (2603:10b6:a03:44e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.30; Tue, 16 May
 2023 00:27:11 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 00:27:11 +0000
From: Jason Gunthorpe <jgg@nvidia.com>
To: iommu@lists.linux.dev,
	Joerg Roedel <joro@8bytes.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>
Subject: [PATCH 1/2] iommu/fsl: Do not use iommu_group_remove_device() under ops->device_group()
Date: Mon, 15 May 2023 21:27:08 -0300
Message-Id: <1-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
In-Reply-To: <0-v1-8fb05192ea02+e5-fsl_rm_groups_jgg@nvidia.com>
References:
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BLAPR03CA0033.namprd03.prod.outlook.com
 (2603:10b6:208:32d::8) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SJ0PR12MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: 30ebc8d0-53e5-4b97-032e-08db55a449c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NVNm/j1AAfAM/0nus983BK4QiaPN2lellRtQYKV2lEohyOurHI85WgNZKrCOgQrKhlGVUNJ9U/A4sa/dzIhimNj/9YQV76NOLUENh84dbMQYAbHlRvB4zqRHK7KALyRQspqr/qj0x8PO7VAHIDIcTH+0PTT8qcgaZ0fR7k7K7nJNm4Zb6aM/Mf7+XS2B89vw5rbN/BoND12PnLOECdPtmWtk3x9PDuAi4kNBV8uO7gFNMh2QOGOWIvAaEN8/xoeRY3rNpLd6GPDitulGEr/fQ9zbAHaBR1G381ZN6/ghLGFT5b6d1w1LNt5n0NuQVHVgwgByHatM7iUGZvZlPQtK9ziB3tSSk65hOnQCSAJIUAU5PxJS7FzhUQjkjPlCV44cS7fcg4whJZynYSYmZWZRLlPf47VPPdrl5y0LbFA05TyiWvGB20jLxBz9wHA31RhIDTpOYJm4jJXxZjzH2wsR3Qre+axgPczj4hy8izmVnfPw4jWcXlt9ANVazb118QiPvsUvoNun6p3UnaQIAx1vACrXYf3nRmNTWvJGRD3oSkaLAFVAGeJN//mvFI99AeBIvP315NSPDEmXLM7X+LpCeX5v8bZxcm3oIvydhG5bpXs=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(136003)(396003)(346002)(376002)(451199021)(66946007)(66476007)(66556008)(41300700001)(6666004)(6512007)(6506007)(6486002)(26005)(38100700002)(316002)(2616005)(5660300002)(83380400001)(8936002)(8676002)(2906002)(478600001)(86362001)(110136005)(186003)(36756003)(4216001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?E7PZHkBs6OdEYgwfX58aS/y8xfZ1FYdz1sNkHI9mGPSgk2Y8t1dMr+HQ/7Xg?=
 =?us-ascii?Q?3zqoOBnzwjQVBBnBTiL88B6lM3wpMJOVHQpfCPThe9FbS7FKRqmaqBbvRWZM?=
 =?us-ascii?Q?TTyeO/fPhx/wOoKerBnawdnQuibSERmc2Wts3qXlkpCIZZCF5CjGB3EW4Oz1?=
 =?us-ascii?Q?q7dO9Dm+zHubXeS5Fg/SguNhAFNaJCgGfDLPEsjErmRldKZjYqoEZWfu13sx?=
 =?us-ascii?Q?JsBVGx7+OOmqzyZqSp8CdSWQXlQPLLPgiEiR+zGkMWvU+jq2nYJG73Mbo/xk?=
 =?us-ascii?Q?srN2THX0mHNk8Ghh5B6PQF6R0tQJ1SaSK5GBfj2g2qJ24FtlHc7TiNE8zoge?=
 =?us-ascii?Q?czyqfyyVmLAMbjIdFOYYTuCAzG3IThplbQEvJuZIpxG86y4tNFNSXePm2v4I?=
 =?us-ascii?Q?UyTsslHhcyta9T9cWV4wu7N7gnlFzqwpCF5N75PX8G5LxC80FxzEDKDLuzo3?=
 =?us-ascii?Q?fXZo6JuieRz/7js7nraRj4sDluBrbFgO0YOQp0UW5AM1ExDceG0QnusEtVAW?=
 =?us-ascii?Q?R7sCHQ3krALTMKL5frVYY18yqPvBpLiztd2rqVQbu7w5SZF52IPU5Ugr4k9q?=
 =?us-ascii?Q?Y4w4fVPhvRyVTW2Z1c/WIG53981mm2xEsAFYVChhWSBcsgYwWDE0IvM+52/a?=
 =?us-ascii?Q?nFd/p6T8QCi33PK4LsLSD2XwHwgXo4sC15eqiL3HZBgagS1frhHRBeMISMCI?=
 =?us-ascii?Q?x4NsMvkBHsLzHZZtqYHVfQPFIhasa4Nem8uDIEVvwHXERBqCE0CYzRfJsDHT?=
 =?us-ascii?Q?W97lmKwhciNiL/i9hB2r/yvUnqncGeTrDAzpWiHSxefRcaDBQG6NaIGKSw3H?=
 =?us-ascii?Q?ddZd9v45qBBlKph9jDi2c5fxWKRBMWlFse0u3NH5XO2G/LzZe7ZNGoouL7Mc?=
 =?us-ascii?Q?mYmMqjeM8EqHDdaiDBsMmZwDTzcVTN3hsaxlfcZX7X1WAOPyJ7Ch5LNkRmTB?=
 =?us-ascii?Q?DSDAu9cyP5dCjVhA76PnwYqdjIfSLCteGpD84RIELwcAcMhahkQgz/QYDumz?=
 =?us-ascii?Q?To+xTW428z6ePWpL5hIo60OdmweqtRHXdG8KSZpNG7YktIHuHj86HSsWySJE?=
 =?us-ascii?Q?nJq4nw0Q1Lk/BP8MFS73Tpq7LQc8g7lEhJFCp079NWihERqt2uy3y2BXtft3?=
 =?us-ascii?Q?iUIGBnfqsl3AR/sZb/k+u+Wl3FwprmeVczqsCXaLtHnsTnRrSX+3Q+QoKH23?=
 =?us-ascii?Q?HV9E5HBSL4qwngVekYgAPW4wJ7OxqmZmARKMGzuXnc1tfLcuysTtCAWaoV0s?=
 =?us-ascii?Q?6r8kAi/T0hnrMUFC6lQtEoxUAMg0wQ+hHT9FqigE2Q4+ck07Svg2hXq3IfAP?=
 =?us-ascii?Q?8VDXVTW/LqvsQaQ86vpm0N/cToSXzTDpYNocHDBn1tNyyqW2tb/QOrLL/Zge?=
 =?us-ascii?Q?AnBszQfhjThL1Pqa+9hMjNsDZOZZmlGs12lANxOTRVn8rCAEA6qTGfPIJSd7?=
 =?us-ascii?Q?TejrQBBjtix127iHYa7Y3MVatfo5pxf4zwvQ4pA2XSCPoGlpE8U8BfYP94a1?=
 =?us-ascii?Q?+Z+5VI99qV6kxjANWa1m8xQ3sRI8/J9kkS3XKaTrf02WEPfK6MEDKFRFD2rh?=
 =?us-ascii?Q?63grYBt+nZM4NDbfpfER+5TVB6jTmWWLvAqEKgnY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30ebc8d0-53e5-4b97-032e-08db55a449c8
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2023 00:27:10.5594
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XHnfhefZ2gXMja7BKRTuWdQYjPsgr681xDVsPuzlVTSUuodVl1K4qm6Kt/3jYj8d
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6783

This API is expected to be used only by POWER and VFIO no-iommu that
manually manage the group lifecycle. It should not be called under
ops->device_group().

This is already buggy as is since the core code does not expect a probed
driver to loose it's iommu_group without also releasing the device.

FSL seems to be trying to block the platform_device that represents the
pci_controller, eg the thing passed to fsl_add_bridge(), from having an
iommu_group.

Instead of creating an iommu_group that we don't want and then later
removing it, just don't create it at all in the first place.

For the 'pci_endpt_partitioning' case every PCI device already gets its
own iommu_group through the standard code, so it is unclear why having a
dedicated group for the controller could be problematic.

For the other case, the controller group was being used to bizarrely
de-duplicate the group in it's hose. Instead just directly create a group
for the hose the first time we encounter it. The code already searches the
entire hose to find any iommu_group. Again, it is unclear why having the
pci_controller inside the same iommu_group as the PCI devices would be
harmful.

In any case, this is a cleaner way to not enable iommu support for the
platform_device.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/iommu/fsl_pamu_domain.c | 42 ++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 22 deletions(-)

diff --git a/drivers/iommu/fsl_pamu_domain.c b/drivers/iommu/fsl_pamu_domain.c
index bce37229709965..bf045f58cd50ae 100644
--- a/drivers/iommu/fsl_pamu_domain.c
+++ b/drivers/iommu/fsl_pamu_domain.c
@@ -11,6 +11,7 @@
 
 #include <linux/platform_device.h>
 #include <sysdev/fsl_pci.h>
+#include <linux/pci.h>
 
 /*
  * Global spinlock that needs to be held while
@@ -379,7 +380,21 @@ static struct iommu_group *get_shared_pci_device_group(struct pci_dev *pdev)
 		bus = bus->parent;
 	}
 
-	return NULL;
+	return iommu_group_alloc();
+}
+
+static int __is_pci_controller_parent(struct device *dev, void *data)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_controller *pci_ctl = pci_bus_to_host(pdev->bus);
+
+	return dev == pci_ctl->parent;
+}
+
+static bool is_pci_controller_parent(struct device *dev)
+{
+	return bus_for_each_dev(&pci_bus_type, NULL, NULL,
+				__is_pci_controller_parent);
 }
 
 static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
@@ -393,30 +408,12 @@ static struct iommu_group *get_pci_device_group(struct pci_dev *pdev)
 	/* We can partition PCIe devices so assign device group to the device */
 	if (pci_endpt_partitioning) {
 		group = pci_device_group(&pdev->dev);
-
-		/*
-		 * PCIe controller is not a paritionable entity
-		 * free the controller device iommu_group.
-		 */
-		if (pci_ctl->parent->iommu_group)
-			iommu_group_remove_device(pci_ctl->parent);
 	} else {
 		/*
 		 * All devices connected to the controller will share the
-		 * PCI controllers device group. If this is the first
-		 * device to be probed for the pci controller, copy the
-		 * device group information from the PCI controller device
-		 * node and remove the PCI controller iommu group.
-		 * For subsequent devices, the iommu group information can
-		 * be obtained from sibling devices (i.e. from the bus_devices
-		 * link list).
+		 * same device group.
 		 */
-		if (pci_ctl->parent->iommu_group) {
-			group = get_device_iommu_group(pci_ctl->parent);
-			iommu_group_remove_device(pci_ctl->parent);
-		} else {
-			group = get_shared_pci_device_group(pdev);
-		}
+		group = get_shared_pci_device_group(pdev);
 	}
 
 	if (!group)
@@ -436,7 +433,8 @@ static struct iommu_group *fsl_pamu_device_group(struct device *dev)
 	 */
 	if (dev_is_pci(dev))
 		group = get_pci_device_group(to_pci_dev(dev));
-	else if (of_get_property(dev->of_node, "fsl,liodn", &len))
+	else if (of_get_property(dev->of_node, "fsl,liodn", &len) &&
+		 !is_pci_controller_parent(dev))
 		group = get_device_iommu_group(dev);
 
 	return group;
-- 
2.40.1

