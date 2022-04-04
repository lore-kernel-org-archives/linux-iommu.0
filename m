Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6483C433F5
	for <iommu@archiver.kernel.org>; Mon,  4 Apr 2022 10:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id A79C160C34;
	Mon,  4 Apr 2022 10:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z4g-t4wVyjOp; Mon,  4 Apr 2022 10:09:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 39A5E607F7;
	Mon,  4 Apr 2022 10:09:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBEF8C002C;
	Mon,  4 Apr 2022 10:09:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6A1A0C0012
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 58CE682A2E
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=amd.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wVadWRJfPKQo for <iommu@lists.linux-foundation.org>;
 Mon,  4 Apr 2022 10:09:39 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on20622.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7e89::622])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 679C582A2D
 for <iommu@lists.linux-foundation.org>; Mon,  4 Apr 2022 10:09:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZ2qn6yEjrBT3t6gTKNVkeKE2gIZVx+GbFShE2ElrV6dO7lXaGpkM2HKCdqHNQfcKiuo43NxqloVymPHtIJr0ENllEqh5vYxYx6xrvrFOJv9ay9rubEuiVly0PQUVdRH6knTRVKc3KQa6vtPmTMM/fvn02MZJ50eGr1CQtaRkVcgk7r5aNK7FKl8u7KAShpg/i/kn3Q2NRbI6a0zIN3l86mSa+LB1RKGridTFE8beR0FIjHILb6I/+BDEKGzW/YpzBVRcxMTx8hsfnGvaEBs4msy2DBd/ihA2a6lfKHglqusOcjbPcQTN/1tHKbpltiiLh+ykWhTjJGsvdSizg5Gvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4m+8ksnBsDrLG0POQy46pC7bPKX5oQXuv7jUkwxFgXk=;
 b=aBAYTu3YU8H0Oza4E/4dBt6+7VsxfcENRBLGYAtsDAlHOzXSQXxcs+3cwMYrUdoLT8NYR8ErbxXCjXVDgebIaO797+Jv9VzrarEHVLNJzRu5a6JRjtPcB9GbGfPFO4jGkKLxl07npVwkSdJLDnrEV1tS/DM4sf1eP2OEbnnzKGUu6wvh4rTBOv+xzGEhQCN+2Ju5HBnlBFRzuvXzAuI2lz8o6WZ2yL5TZWzS9oqinnYc++WqfWenlpJA3ufuQm0kZpumTbfDRclAer9Ssh6aR0g3iJDFLxCi6ZhsrDKNEfq1RGvON/iZrwwTR6NxZI/Rw7ANnFxv3tE+HUaOOjoI2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux-foundation.org
 smtp.mailfrom=amd.com; dmarc=pass (p=quarantine sp=quarantine pct=100)
 action=none header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4m+8ksnBsDrLG0POQy46pC7bPKX5oQXuv7jUkwxFgXk=;
 b=soDiYE02WGr2kCJms+7SkPl6MG/LPlyzTUvMlpQ+KBtGfZhTtuM7TwtBBcCniLnDuOdTnba2aRlr7gHp5C9RvcA5hc+V15eNrmUNKrH4iQBAtBe+Znh1rm8gxTzXqRBfvNQNGlq4rT6Aa+ReV24AcV/VUP5g5oUkuxMh8AO5xqc=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by BL0PR12MB5554.namprd12.prod.outlook.com (2603:10b6:208:1cd::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Mon, 4 Apr
 2022 10:09:35 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::c9) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31 via Frontend
 Transport; Mon, 4 Apr 2022 10:09:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Mon, 4 Apr 2022 10:09:34 +0000
Received: from kali.amdval.net (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 4 Apr
 2022 05:09:32 -0500
To: <iommu@lists.linux-foundation.org>, <joro@8bytes.org>
Subject: [RESEND PATCH v1 35/37] iommu/amd: Print PCI segment ID in error log
 messages
Date: Mon, 4 Apr 2022 15:30:21 +0530
Message-ID: <20220404100023.324645-36-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220404100023.324645-1-vasant.hegde@amd.com>
References: <20220404100023.324645-1-vasant.hegde@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f30aa695-ced4-499b-6186-08da1623385e
X-MS-TrafficTypeDiagnostic: BL0PR12MB5554:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB55542E632A2A79B89ED3DA1187E59@BL0PR12MB5554.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9LSw3rfXn+gW6oarJ/oqEKlerGmEVGJ+CBu4/37yCHD2jUxtAhTRVpIX/Cfuk91i+/3/G+cn9hVf5BjwWcLWGF9bK/f9fks/fXcrmCRpnef3sMm2SOPPAZmIglMhVIf1K8ZNvef5EuJZnZb4+XLmCQMbyRbLqGO4OBO8WPsfB00ABzi2GdPha+KEiy+nZ0QoM6g8Wp3ewx8V3BRP8YlSf+gB98nTz8UnTPfm/ZUPQgRE2f6qaWZ4E+tdA0UKkXxbhOguOI4L/mn+69BpVZgkHNvJ/nN1zMzlTt7K7edQ/PAJ+wYHXYgo7biO/AwBNnMZyqU0u871Gnm2+UY4ZEvj4Pp0zXrRML2gz9GEYeuXBC7vVq9EYia2eUNS5mO17tU+IA1CKx1rOsMVytZid0yImEgXZH9KtWjmlZLFC+QIkqo8z+R1ua9AcpF1NRG5b+2R1CoGKMZHaYU/1M+qd+yHdPA0F+ICGjAVH48wQ+P0QfXvmRhW9L3NI0IPxcIKjaCdlg5r2z16VmMZsmoA5wHctoc2zaRThuRkRZYkSOlnDPkXNCd8i5O+MNrE78R5HNudss0xhTqpgnEEJD2uv3C0BuhyF4XLB1huIJIIS795cyzH9PLSSJ971g0moQPPVZPq2yTZkPThbIrbPKgqSIwP+KSG5eIL5UQvSnlUHeW0LG9UyQe37wtbByXpbM6VbTk9KWo0BebUdjqiiXe5BNxN9A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(81166007)(82310400004)(8936002)(356005)(26005)(6666004)(40460700003)(2906002)(5660300002)(83380400001)(47076005)(44832011)(86362001)(316002)(1076003)(426003)(186003)(8676002)(54906003)(336012)(70206006)(36860700001)(70586007)(110136005)(2616005)(16526019)(4326008)(36756003)(508600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2022 10:09:34.9847 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f30aa695-ced4-499b-6186-08da1623385e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5554
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
index 4dd9d4201ffd..c64a2382b4a0 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -495,8 +495,8 @@ static void amd_iommu_report_rmp_hw_error(struct amd_iommu *iommu, volatile u32
 				vmg_tag, spa, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [RMP_HW_ERROR device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, spa=0x%llx, flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			vmg_tag, spa, flags);
 	}
 
@@ -528,8 +528,8 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 				vmg_tag, gpa, flags_rmp, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [RMP_PAGE_FAULT device=%04x:%02x:%02x.%x, vmg_tag=0x%04x, gpa=0x%llx, flags_rmp=0x%04x, flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			vmg_tag, gpa, flags_rmp, flags);
 	}
 
@@ -575,8 +575,8 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 				domain_id, address, flags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
-			PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
 			domain_id, address, flags);
 	}
 
@@ -619,20 +619,20 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 
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
@@ -644,13 +644,13 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
@@ -662,8 +662,8 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
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
