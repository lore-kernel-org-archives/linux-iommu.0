Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8319AC433F5
	for <iommu@archiver.kernel.org>; Wed, 11 May 2022 07:30:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 51EDD40B53;
	Wed, 11 May 2022 07:30:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6oHIRQODRWxD; Wed, 11 May 2022 07:30:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 686A540B4D;
	Wed, 11 May 2022 07:30:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 53536C0039;
	Wed, 11 May 2022 07:30:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BB081C002D
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A932441886
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8TFb4O9ZmRG0 for <iommu@lists.linux-foundation.org>;
 Wed, 11 May 2022 07:30:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam08on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e8d::609])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5DD7041883
 for <iommu@lists.linux-foundation.org>; Wed, 11 May 2022 07:30:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FYftBPy76DNPieomTPLcS9hXUKj1tAytp4N8AsqwkZDW0LQP738HfLcJGgiOREmIpUWzwODoM3Uy0kj/gf6Ng+zdowQeAIDCU/kCv52KMlZmR4LkZng7+Y+wkkTr4oS/IRKyf/PEI+2oYbawCf55fAGsKq7EtqbTjhgRRR2nU9xXF7ctoku6c31QT2FfyzbwSyiOTDQGhyLWGByz8MfOjpc7dcibz1AxSShJOT6Y8PwLb42aTM5I1WVFNsUoi/ycBLm1wnZz+yLAmCjLpvCm/XjF2+oBOxk3YMwKlW7BlOj2rFVscLTvEmTlnXBBa6z/uukamBXD8Lo5ARXhUedHNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0EcQ8/Bg+IJAlREBULQPlcLJaRNEd2ixyqOXiYGQigo=;
 b=lHui+qwS3egI3TF/DTmOGZ7C91UKQn5azbNWbtZMnuQICnPUKw364ctXWDxSx3+asqVXMvKpKk69IJ/5AC9+wu1VJGdMVj0aGqf9y+lv85CvlEPZ8fo1Gpmyoj5Ehno4qLlKnRphzIr1/MLZakZyofhWQJbuHHRIDlamf7gnKdIB7q9x5ifsC4b94XjCqpL4L0SNkDLOfWxfekqNUmvVnrEj/w0L0eCCvbZvddalQZi/G/Z192j1v+ATo/qzDKuuu4D83LVt277VE+MrQRnhlPfLKlGJZro5TCc8T+pi40MywGw+vBOpLfZVRUfUb0XZYgIV8OJDAOv/Hn2XmioA+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0EcQ8/Bg+IJAlREBULQPlcLJaRNEd2ixyqOXiYGQigo=;
 b=RBkTc1OlKeRV1lMJr6stzGTNfzc0kG9Gxk7+dV1n4BAw3DMLs51zn3z9OaGOWq4CcPR47n/keDF68dmkPvS6nHLs+UbhKKaPLx49+zxogv1LE6W4NbQt9CmXGAFyx2lSDNJ9pXXsUuVHXeMy06t9c7kGqd+7n723p51aeKiaojI=
Received: from DS7PR03CA0293.namprd03.prod.outlook.com (2603:10b6:5:3ad::28)
 by CY5PR12MB6297.namprd12.prod.outlook.com (2603:10b6:930:22::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.18; Wed, 11 May
 2022 07:30:34 +0000
Received: from DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ad:cafe::be) by DS7PR03CA0293.outlook.office365.com
 (2603:10b6:5:3ad::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27 via Frontend
 Transport; Wed, 11 May 2022 07:30:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT047.mail.protection.outlook.com (10.13.172.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5250.13 via Frontend Transport; Wed, 11 May 2022 07:30:34 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 11 May
 2022 02:30:32 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v3 33/35] iommu/amd: Print PCI segment ID in error log messages
Date: Wed, 11 May 2022 12:51:39 +0530
Message-ID: <20220511072141.15485-34-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220511072141.15485-1-vasant.hegde@amd.com>
References: <20220511072141.15485-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9563b8db-b21b-4a68-8ca9-08da332022fe
X-MS-TrafficTypeDiagnostic: CY5PR12MB6297:EE_
X-Microsoft-Antispam-PRVS: <CY5PR12MB62972879032547BE7C842C9987C89@CY5PR12MB6297.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRcwSbQOOW3ZxP97Su1XPb18JW4+QA0dbY6eAPKVD6h2k3RIyHz2EhheJV95Nh9k7mEV09x+PJiZ4Qyf6PzM7XvVd7FVgDxOaFshHqchI2P1ET7k2zbZ7dc0ldELrFvRuawdCoF46CJyZRAPNH/bsP1I2C2W+L3rv65xtUFjzUJP2uYn1150waW0Fl86EgHG0wJQAA5lRIJ0lB40wteHpq7lcmOW4sZS0ajjpSJwLF/96Bv3zz1uUBaekTZ2llSs3skx+omTg+9aHt6Hkyzi83ECIqR+PXDOt28hdr4jNxvW2++OxtAiv+nWHj+K+PGR9O3QviUAeofpiDPIVw30CynQc3Fbz25nhgbpYZTgFoZEpjgG2WuKe9MAVuE/6437r+GQehWDgy2MlQrTxYi+IOCSv4Cm6DwA2fAaO/+Vsn6SFlIoa3GnsJiTEI5jeQfGBa36WaTxgiLtmNf9IVzKKOedK+9ju0JffIgbN2p7v6E3iitxiWiLANex7knQu4MXSukrapsOq5ht4e2anUx9lHyjProXTTjf0NXTEn6uhvB6/LHv970gR6nQmZhDXi1x5ajG5V4NAlyBQwle1hoXsO+zr7RKrHRUCTZnGfzi45m/HhpCQnPSTYnWfZ3+4cEPihwabxPHVy1+QS+OBSlGF9LaONeGaes7Eoha2wG3y0Uxmn6bbNUW0ta6SPiezGg2/2HfNQb6ii53tpj72z00vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4326008)(7696005)(2906002)(82310400005)(36756003)(8676002)(86362001)(5660300002)(47076005)(40460700003)(26005)(81166007)(44832011)(2616005)(70586007)(70206006)(8936002)(508600001)(1076003)(356005)(54906003)(336012)(426003)(186003)(316002)(16526019)(36860700001)(83380400001)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2022 07:30:34.4330 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9563b8db-b21b-4a68-8ca9-08da332022fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6297
Cc: Vasant Hegde <vasant.hegde@amd.com>
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
From: Vasant Hegde via iommu <iommu@lists.linux-foundation.org>
Reply-To: Vasant Hegde <vasant.hegde@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

Print pci segment ID along with bdf. Useful for debugging.

Co-developed-by: Suravee Suthikulpaint <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpaint <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c  | 10 +++++-----
 drivers/iommu/amd/iommu.c | 36 ++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 969b496f7e74..8483d98a1775 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1853,11 +1853,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
 		h = (struct ivhd_header *)p;
 		if (*p == amd_iommu_target_ivhd_type) {
 
-			DUMP_printk("device: %02x:%02x.%01x cap: %04x "
-				    "seg: %d flags: %01x info %04x\n",
-				    PCI_BUS_NUM(h->devid), PCI_SLOT(h->devid),
-				    PCI_FUNC(h->devid), h->cap_ptr,
-				    h->pci_seg, h->flags, h->info);
+			DUMP_printk("device: %04x:%02x:%02x.%01x cap: %04x "
+				    "flags: %01x info %04x\n",
+				    h->pci_seg, PCI_BUS_NUM(h->devid),
+				    PCI_SLOT(h->devid), PCI_FUNC(h->devid),
+				    h->cap_ptr, h->flags, h->info);
 			DUMP_printk("       mmio-addr: %016llx\n",
 				    h->mmio_phys);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 536dbc1d26ad..6320f2f97d88 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -496,8 +496,8 @@ static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32
 				vmg_tag, spa, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			vmg_tag, spa, flags);
 	}
 
@@ -529,8 +529,8 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 				vmg_tag, gpa, flags_rmp, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			vmg_tag, gpa, flags_rmp, flags);
 	}
 
@@ -576,8 +576,8 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 				domain_id, address, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
 	}
 
@@ -620,20 +620,20 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%02x:%02x.%x "
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
 			"address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address, flags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
@@ -645,13 +645,13 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 			address, flags);
 		break;
 	case EVENT_TYPE_IOTLB_INV_TO:
-		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%02x:%02x.%x address=0x%llx]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [IOTLB_INV_TIMEOUT device=%04x:%02x:%02x.%x address=0x%llx]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			address);
 		break;
 	case EVENT_TYPE_INV_DEV_REQ:
-		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [INVALID_DEVICE_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags);
 		break;
 	case EVENT_TYPE_RMP_FAULT:
@@ -663,8 +663,8 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		pasid = PPR_PASID(*((u64 *)__evt));
 		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			pasid, address, flags, tag);
 		break;
 	default:
-- 
2.27.0

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
