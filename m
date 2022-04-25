Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C476C433F5
	for <iommu@archiver.kernel.org>; Mon, 25 Apr 2022 11:43:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2670160BF1;
	Mon, 25 Apr 2022 11:43:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vM291mf6_4lG; Mon, 25 Apr 2022 11:43:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B77CE60B2C;
	Mon, 25 Apr 2022 11:43:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 929B2C0039;
	Mon, 25 Apr 2022 11:43:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CB06BC002D
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B9EA681B26
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jbBo_c4zTVm1 for <iommu@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 11:43:45 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20609.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::609])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C5CBE81AF6
 for <iommu@lists.linux-foundation.org>; Mon, 25 Apr 2022 11:43:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A4elEj+InKPbP/hbQOGSuYrRVU9qkXV7uqOCdhMPj0I4rolMQDDalDzEqa9ABkLd+0NXHDx/52WiAy2NpNxITI/lVdjq5wJ1mf7wA9BoGN4A/pF7FXDx8829G7M+qzksvhzFEE620kKDMmp6x7Fi/+aRr4H8ojYsrcH7Lguk26OZTilSwf8DyEnIXSCpI5e7czNp+N+wvzd1Bmi+3KKRzbMfR8qkoGDq+KQcIbMO2dEUodHKXPmpXaOZN/jlNxsJAZPb0cSqVaV7NqIv56qZxUIHvT/7kH2BqZeh3nlMv+O5gSSEQqG9HFHa5cw0zrbFmb+GrgKZFriMVJEMZla3hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbbJUulrAAEPWXASZFkg43LaZXFmDU3CNJxTAWiNjGM=;
 b=FUwebdWVkB+lwwVP8SAG2d3onj0tk7yMYMpSJK8LaJSk3W1DOTDV5FeuotH7HE4+LFEp/AuRFpHi/V5uMVU0Eot+GPuTIH2GCuGdjaFeOlkPSu+zSczSy3jqZKRbLhgQNkonCHYWYbzmR0gW8YUdss+mAL8zjd+9KpP/dTXh4/3U6Jol9/tczh+QrOcw+O3yPtlbuVqLYyEWzLut0RuVKjHedmFjRF9ygaz1RLOi3QdFqrkKU///SS9plki6zIVf+XCceLX20Y5ch1ex2R2BnR3Cv16tbWTkfpBNIs6JaJql4+oNOODYugbDdViYFj0UtEdwr6YUZkKCqQQBuiWueQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NbbJUulrAAEPWXASZFkg43LaZXFmDU3CNJxTAWiNjGM=;
 b=vdOYF6v9U9ZYSUYhjGtoO7hxyFUbAXJVQwtnoxWJIMqKsRLZtdb0HsapEeFZwCi4Xdm44byDVV7ehMJh7b6SJgiPrR/dr/gpLBPay+x2E+pcToqTDg4RnPQCV1CwNtqWHAz2MBWJ71o3QLpl67Cyz6g+UEEikF1N4cX0c5y/Q4E=
Received: from BN0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:408:e6::9)
 by DM4PR12MB6255.namprd12.prod.outlook.com (2603:10b6:8:a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15; Mon, 25 Apr
 2022 11:43:43 +0000
Received: from BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::90) by BN0PR03CA0004.outlook.office365.com
 (2603:10b6:408:e6::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13 via Frontend
 Transport; Mon, 25 Apr 2022 11:43:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT050.mail.protection.outlook.com (10.13.177.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5186.14 via Frontend Transport; Mon, 25 Apr 2022 11:43:42 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 25 Apr
 2022 06:43:41 -0500
To: <iommu@lists.linux-foundation.org>
Subject: [PATCH v2 35/37] iommu/amd: Print PCI segment ID in error log messages
Date: Mon, 25 Apr 2022 17:04:13 +0530
Message-ID: <20220425113415.24087-36-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220425113415.24087-1-vasant.hegde@amd.com>
References: <20220425113415.24087-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 453b1c8f-0ab6-4534-5177-08da26b0d95b
X-MS-TrafficTypeDiagnostic: DM4PR12MB6255:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB6255340281A74EAA23B815F087F89@DM4PR12MB6255.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kUpUzhksM49nmaNeubkbSMCYx6yx4O3BaP1aV3rmU4PazgDLbxnuuEP6DHt2WmWwHNuA7ucLly2fYEQ5lYQ3QRQVWpom3Et92USKDDRmYnbdqhBO4r4ZGD0qG01bfPB93hvZIXm8EBZ953p/9oaRwLUUMn/kNMi8VsTv39A30/zg/Fzt/cPk/l/Ug7sbCuOC3wJYsE4f3xM29rRbNcVHAWz+3DYLnNH7KOlOBd2duq9ttkXLdedVz9/zFski4+FWwGP0mW/6UAVgIrHH3HKYzFjYKKagC1EsdEZPD6KHSnVgRW1/R3AFDEtHLSnSx+vCbppk1YF+Wv+kbr6XNzZ7W0P6gW2lWYDO6oAmJreabT8f1a1xc0lGdOZpksO1AD19/d/OOupUq0ZfckqSRGgz3vSomJ4kE1SXB+t3V76Rp6vxBSqX6Cnk3rUgeici/QCRba7hPli2k4F1qenOVc72UevjU8BydbRMCBr8fjQwgzf0M0zjBZgheS3UqTrw+w2SaXOVwR2JipORAkZwjORyGxA9eWIb1uEqLrLpjC1eaMNeYJIyMdBhbvp1QcthT1hfI4vgKD1iF0lw05863k0dikQnpejigoIeVpLDMANTdxcuwfbTYfpfHq6ESJHMTRC0ZSe5zlmCfOF4z3YSRHQuyGmkbxu/KK0OJVzatmWcepspx2p4r+0KGBh4Cu6dQ6HnSufcb3/7o6+sld0zQDHqVQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(336012)(2906002)(6666004)(426003)(5660300002)(16526019)(2616005)(8936002)(186003)(36860700001)(1076003)(36756003)(26005)(82310400005)(83380400001)(44832011)(508600001)(47076005)(4326008)(316002)(54906003)(6916009)(70206006)(356005)(70586007)(40460700003)(8676002)(81166007)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:43:42.8305 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 453b1c8f-0ab6-4534-5177-08da26b0d95b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT050.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6255
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
index ba0ef8192a2f..24814ec3dca8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1850,11 +1850,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
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
index 46236fb05a1f..47946894aff3 100644
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
