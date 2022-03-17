Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73904C433EF
	for <iommu@archiver.kernel.org>; Thu, 17 Mar 2022 16:13:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 15B5E40B5A;
	Thu, 17 Mar 2022 16:13:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H44EHZFsq3VD; Thu, 17 Mar 2022 16:13:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 738FA40B4D;
	Thu, 17 Mar 2022 16:13:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4EC77C0012;
	Thu, 17 Mar 2022 16:13:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8463FC0012
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A5AD8600D1
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=microsoft.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5vrU7YaxbmHZ for <iommu@lists.linux-foundation.org>;
 Thu, 17 Mar 2022 16:13:27 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from na01-obe.outbound.protection.outlook.com
 (mail-eus2azlp170100001.outbound.protection.outlook.com
 [IPv6:2a01:111:f403:c110::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 09A9E60A90
 for <iommu@lists.linux-foundation.org>; Thu, 17 Mar 2022 16:13:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0XUdOPuwLZ8xC6HhysLCejSgCpB0BaxKTNaSKDH9u8gphuCjGm9PPDg7XaG5QRLIkRCxVSfz9JB6Rl7GRxExOmeYmswiHyuBbtUUxVCr/rOghb0lNetWg3XxPqpSUlkmibsM2iFULQx6Wf9ZLDMfDiTso7W5+yHpsFO93QxFalS1hzDlbWHF5tVjP7YpL4qZuqClQLG8ADpF4SU8MbQ7x8ZHXVpTdrkHlqf8W4dMDsVKCxKakuI/wvcf05u1/C2HiVn622g95dN26GbwY4nT1xq/qw5XKOf7BUGMAnkklV5e4LRjAQj4vaYJKYKs4D6oBEfnwyuwlrV5qwqE0JaRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TMBkvB8XqJXPIW9KcFtQrPV7sFII7sr9r1YK92fPbUg=;
 b=VBxbGBjt/2YkPUB7PrjK2SU0vVyRFAmBZMjwNzu0Joa3bqVg9GtBP50LImtJjI4gLwlLb5UPfTabFsO+YZ5uNbWZ8h1TXyIAljt4vSTFuV8jM/fyIwnk1rCjV/qbMckU2g2AkVO/aDG4UHEoGQPvWfFF/gzF1WPVKkhSTxOzMqCC6EQ8/kqrKYJy3f0EGTeJGXmq4rUmoy3b0lR9UxMYP/IjcVwjE739ZLpTtZko9ssTUONNXsEhuk3XgDra2CRdwxAoDPLT5GomiQKsfK8Q/YtrI+r4OukFBC81E12LH5S1huuUyue8uI0+QaBynTAQHYqkK0ML0p2dHvDsnx1YxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TMBkvB8XqJXPIW9KcFtQrPV7sFII7sr9r1YK92fPbUg=;
 b=dkDavD1FvmusPuQ6fUI/IYFBt8jEmGBHKTm+RrvAMycyf35y5UlBKJF5fEFXmTOGbu0VNIPJzuKwylizlWgTERLPToyMOmSs4kGe8LPpbX160flUUkTDlOEXq2SWUBOfE6NpRjqHF5ENx0tWu4stK8f2UbCRRFBq+yag9UxKsgw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
Received: from DM6PR21MB1514.namprd21.prod.outlook.com (2603:10b6:5:22d::11)
 by BL0PR2101MB0995.namprd21.prod.outlook.com (2603:10b6:207:36::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Thu, 17 Mar
 2022 16:13:24 +0000
Received: from DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357]) by DM6PR21MB1514.namprd21.prod.outlook.com
 ([fe80::8c81:f644:fc1c:1357%4]) with mapi id 15.20.5102.007; Thu, 17 Mar 2022
 16:13:24 +0000
To: sthemmin@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
 wei.liu@kernel.org, decui@microsoft.com, rafael@kernel.org,
 lenb@kernel.org, lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
 bhelgass@google.com, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: [PATCH 4/4] PCI: hv: Propagate coherence from VMbus device to PCI
 device
Date: Thu, 17 Mar 2022 09:12:43 -0700
Message-Id: <1647533563-2170-5-git-send-email-mikelley@microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
References: <1647533563-2170-1-git-send-email-mikelley@microsoft.com>
X-ClientProxiedBy: MW3PR06CA0007.namprd06.prod.outlook.com
 (2603:10b6:303:2a::12) To DM6PR21MB1514.namprd21.prod.outlook.com
 (2603:10b6:5:22d::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d4cff443-a6ff-451c-1ab7-08da08310fc9
X-MS-TrafficTypeDiagnostic: BL0PR2101MB0995:EE_
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BL0PR2101MB09957DF22A2DDDBD87313E81D7129@BL0PR2101MB0995.namprd21.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OMR6hD5Bk6K3zmqTVppztAr2rn0i7snSxUA1q7rvhxiFiuQBKdKbD+5ytAlCq13HIatV+kSW74Nn8OMet8ii8M89Cs2kwUbrUT3/gz/67OPGum6dj/TwuvOgljr2vKqPhQHUHVMy+P7htbOZqN3EfWXpk1x7uofKugs2s6/2/otn7gR7IC284WW5tpN+7xtDv/LYnH5wepErD6LpRK5l1D+G7A4+gplWWpN05LaadCnF5LmRE0y3Cy4Ly4GqjvPoR2KJw3jTwhczKr+ibPoM5tVCjotqWro3lt2F0EDjeu7JRc0USGiZPvXHYEQlFHSA+3x7t62sjEhahOgsYb1aBo7cquqt50kAb9c1bnoGCRamwa+UGfmfubU7QT8huJwUAJ0KOXme+GhlbTuOh5UM1cdrDrs5NM4Qf5CYyViC43njdPbPzeohqyjC5iw5QGsrSSa9O3ID6DsXky+Gn5syRfjhygbJSQJcVPUGO4IWEEccCSyZDq/RUcX1+IRBw5PCK8smRs+3Ft+W749Rv4HTMJMoyRE7DnADyV6OUDmy2qUjq5ta9lMB1Owne9FxV04U8xhVvwAYui+njx9x84IPGl347UcJVQPhqRs9oPU9YNmMfRd2NfgPLhBQio+YIHEwPIiM7OxYBbF9GdY6/SUMZ14pVRAnbIg2fklzoNsOpFmKBS0IAAju7zBDYMGhwDOZQppmhlk7n9fOw2wASdmJ82I9mjCKahaIGPhHtHk+ibmB+H5spNoObMHaBPx14NuJBEFf0vWBKr8Rm8bs5wWlHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR21MB1514.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230001)(4636009)(366004)(451199009)(83380400001)(186003)(26005)(4326008)(8676002)(2616005)(8936002)(66946007)(66476007)(66556008)(107886003)(38100700002)(38350700002)(316002)(36756003)(10290500003)(6486002)(86362001)(5660300002)(921005)(6512007)(82960400001)(7416002)(82950400001)(6506007)(2906002)(508600001)(6666004)(52116002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wpa7za5s+S79bphKolbPoSax4gOtIK9fIyPAJIfMpadwHMiv0Qggvg/4aJLQ?=
 =?us-ascii?Q?WuYuRJ+ouTQ3JJ1dWC5ZpiAJt4AtnKKFwWzvqrdr2Z8RnokxbTE7YcSSKpP0?=
 =?us-ascii?Q?DeLfsDi5y2AJfN/7C9UGY1mWaV7bqpQEF03iMUE+NdgrLHQmMZyuIQpJLCZc?=
 =?us-ascii?Q?M5RHWzXBQRAbe0ZCRIFuL99kwPVzImWWb0/Ccnn2EifrQ+WVet/6Mc+qH3rA?=
 =?us-ascii?Q?CLxAD4sQ2LuPk4L7YNNLLm/l7FdW3jJ61/UAB46+XJK6dArPmmEBJfVjcPg0?=
 =?us-ascii?Q?swFMWPTd0Fs96SYp1Vt2QGjlpC5LUz6nj+To7VrMndaDWrbqDzW1lqcHfpJA?=
 =?us-ascii?Q?g1qec4PT9z/nMb+DL6o/KqmGZlKuDsDUq6y4sVp3mqrMVWW6m684rNSF+Enn?=
 =?us-ascii?Q?P+dCtQ20zDBMtq1ELNqFTvZU+Y32xMhemt28x7yh2tw+5pmQn62BYp7oU0O6?=
 =?us-ascii?Q?OwixHT8KTTUVL2qjGSlk/3Dhs/BIG6HXDf1wcyWI5/SVr1yf9q+vRfRL8wkH?=
 =?us-ascii?Q?ywwshmPJrPCTbZfkCrWS4VQyXmq1TcRaDEcHQGwYPAaJRsyLN8U+64cO4TeC?=
 =?us-ascii?Q?7FvUSPXRq4eGaG70FDs6lAyWMTNMcPRCj8EIjKHjZdJXnjqqhaF/ebSVEEHn?=
 =?us-ascii?Q?CJdUPOcCjNm5zIVcQwmYGFEmrFJDHNQKuFtRRf+Juz7clBUrdUqrAWeK2uAp?=
 =?us-ascii?Q?SdFFOX+OeLGIYNyDa1hpPFLmwuY4DrdXgA8L/WC8JbZN3JAnHdw9tUeAq2av?=
 =?us-ascii?Q?zjNq9Eg8C1FEL5aN2vrFLkJOq014JNwQYPrtXaorMzxeOb2D4XT5FbYhw916?=
 =?us-ascii?Q?+ReYKuPo8lxk2DCbJNun+9QmOYpTBjRD01VK2EEmRSmuN35KISo/2wTlXThg?=
 =?us-ascii?Q?n8Pmxp7fz46jpOdFwK3yDjUO9vsZztL43W0zNivTW+mezsLWVeV57VUkJlpi?=
 =?us-ascii?Q?6xjMd2kBZv2ayVqqQ7KxE6a8LDBD86168+7vLFnlpkofD5C+5yUOLwwxM91m?=
 =?us-ascii?Q?dv1iT7B1M8syLq7BjiMthy8TVRW4iRkGdNWid76Yhf1ZLDca6uC4LuSQN2gw?=
 =?us-ascii?Q?0BBhhFvCCcFmvzZ3RCbFH4jrPK1Pss80jb+f3Tb4M/UL5Nohj5NYXJr25ZoW?=
 =?us-ascii?Q?A/H5nigs5seymNNrOEusXtYezut+ouEYLu6VYMNALtq8l4FVCp35okmHqjUC?=
 =?us-ascii?Q?x9lLQb+q6SzIIfaHc5NXI4rLkRgGs0l6717c7LjaCD87gc4cLpHi4fUb0lpZ?=
 =?us-ascii?Q?jmwRsh+oFiEZ8gUc4J2E0AKFbXVNaLv9K3Xk0fJN3EbAUgfZWv1IaShut3k/?=
 =?us-ascii?Q?k8Dmw+JccrZVZGkQiqTih3fScVl3EBmBOfvq8lDYSwysRcTc6MYC8fK8jZey?=
 =?us-ascii?Q?PsHyOWTehpDB4e3yKtKBXO4DTh94NE5qFpFC3Vr5bJoHmevSOqKWUN8UOQhm?=
 =?us-ascii?Q?GYq6l+T7BlvadEQAZ8kKGFjr1/d4uIH/0v4BS0gHu1pEeC3kceX/pw=3D=3D?=
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4cff443-a6ff-451c-1ab7-08da08310fc9
X-MS-Exchange-CrossTenant-AuthSource: DM6PR21MB1514.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 16:13:23.8587 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7hTbIRfFZ8ioxq3ygHo1svUQtGR4o2oQK6kuWh0plS6lQfsFeL7XGAj+35Jc5FU9sCVsnzCCUMk8HSLrSpzhPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR2101MB0995
Cc: mikelley@microsoft.com
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
From: Michael Kelley via iommu <iommu@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

PCI pass-thru devices in a Hyper-V VM are represented as a VMBus
device and as a PCI device.  The coherence of the VMbus device is
set based on the VMbus node in ACPI, but the PCI device has no
ACPI node and defaults to not hardware coherent.  This results
in extra software coherence management overhead on ARM64 when
devices are hardware coherent.

Fix this by propagating the coherence of the VMbus device to the
PCI device.  There's no effect on x86/x64 where devices are
always hardware coherent.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/pci/controller/pci-hyperv.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
index ae0bc2f..14276f5 100644
--- a/drivers/pci/controller/pci-hyperv.c
+++ b/drivers/pci/controller/pci-hyperv.c
@@ -49,6 +49,7 @@
 #include <linux/refcount.h>
 #include <linux/irqdomain.h>
 #include <linux/acpi.h>
+#include <linux/dma-map-ops.h>
 #include <asm/mshyperv.h>
 
 /*
@@ -2142,9 +2143,9 @@ static void hv_pci_remove_slots(struct hv_pcibus_device *hbus)
 }
 
 /*
- * Set NUMA node for the devices on the bus
+ * Set NUMA node and DMA coherence for the devices on the bus
  */
-static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
+static void hv_pci_assign_properties(struct hv_pcibus_device *hbus)
 {
 	struct pci_dev *dev;
 	struct pci_bus *bus = hbus->bridge->bus;
@@ -2167,6 +2168,14 @@ static void hv_pci_assign_numa_node(struct hv_pcibus_device *hbus)
 				     numa_map_to_online_node(
 					     hv_dev->desc.virtual_numa_node));
 
+		/*
+		 * On ARM64, propagate the DMA coherence from the VMbus device
+		 * to the corresponding PCI device. On x86/x64, these calls
+		 * have no effect because DMA is always hardware coherent.
+		 */
+		dev_set_dma_coherent(&dev->dev,
+			dev_is_dma_coherent(&hbus->hdev->device));
+
 		put_pcichild(hv_dev);
 	}
 }
@@ -2191,7 +2200,7 @@ static int create_root_hv_pci_bus(struct hv_pcibus_device *hbus)
 		return error;
 
 	pci_lock_rescan_remove();
-	hv_pci_assign_numa_node(hbus);
+	hv_pci_assign_properties(hbus);
 	pci_bus_assign_resources(bridge->bus);
 	hv_pci_assign_slots(hbus);
 	pci_bus_add_devices(bridge->bus);
@@ -2458,7 +2467,7 @@ static void pci_devices_present_work(struct work_struct *work)
 		 */
 		pci_lock_rescan_remove();
 		pci_scan_child_bus(hbus->bridge->bus);
-		hv_pci_assign_numa_node(hbus);
+		hv_pci_assign_properties(hbus);
 		hv_pci_assign_slots(hbus);
 		pci_unlock_rescan_remove();
 		break;
-- 
1.8.3.1

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
