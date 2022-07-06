Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637133C6
	for <iommu@lists.linux.dev>; Wed,  6 Jul 2022 11:50:53 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hOKq9YNdzzouc0DcGsOlhdFmDAs2cG4VXjdGt0Vp8fKNZVOxF9oZA77bZPCGe6Xxd25ED/jfQa+LeAcirBSDlCZKnssL2Y8wO2idtjZ8ihiYWVhHoutMaOkimyZr5mFJDHrhlL4ih5w1qD0ZCclIJyG9C1otY/Wn/7GfZfOXV/e2k1xgZVBios4Ukb+0/wUxvjMJoMHLw5g9B5QpPZl3hLlqrVpn6+OEV4L1nr49tWD4IAdsUEHYTrCnPABu3EzF5YzQfM4BuJgdk5zZEqYlh5Kc8lYYJyqcB1EwtQ6Op/Edk4yY/gyCNQ407PqiZO2jsHG0zgvBslQHUEmysDTX4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+UCYeVBQ9xNc9Zyg+jahl83HG54SuPRWXULBG8IUHc=;
 b=TjWDH1LEG+MvjUJvjEiwzg1SkW8Blhu45BFpu8HZLGJHjA+IPvAaUAOcoHXqE2NUJNovio0ebscrB5kT4oi9A7JE8oWeLhEgnUbjAFLhJbH+MBvFajETJgkXqyZSyA3EuzB+Eq37RVXz3Yx92SuTezdtTDPfVHemcpfbGWHuqNekaYRuM91c1knEZPqO4ktw3Wmb5hdHnwa+4DsSYQtW3Y9xi2Uu9/fsWUrvtuM//wJUNrYbm+bH3b0keGCEm/KR8eN0PsNikCIWrlhnZsTvXW86CP6h0CaqsRGYXWIr89GvbYKQhL5BbHf6t24yMEJKunop+WDGsKYe/OF3aeMmpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=8bytes.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+UCYeVBQ9xNc9Zyg+jahl83HG54SuPRWXULBG8IUHc=;
 b=PPPIKypCL7KlUuzNRFSkUpltmutp32AGULXdcUL7wkg65obSgBoJDTaGf/onQqpMuTnMv5REC0v/OSRAHFmFHwY/wsQvYfP21nd6QOZrZhaO5OPmSjxRbKMSHoJcRflnDoDzCofJAwsHD31EWm4jomyc1DDih2DUZF+M/qCN+4o=
Received: from MW4PR03CA0298.namprd03.prod.outlook.com (2603:10b6:303:b5::33)
 by BN6PR12MB1139.namprd12.prod.outlook.com (2603:10b6:404:1d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15; Wed, 6 Jul
 2022 11:50:51 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b5:cafe::f4) by MW4PR03CA0298.outlook.office365.com
 (2603:10b6:303:b5::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.15 via Frontend
 Transport; Wed, 6 Jul 2022 11:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Wed, 6 Jul 2022 11:50:51 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 6 Jul
 2022 06:50:48 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <joro@8bytes.org>, <iommu@lists.linux.dev>
CC: <iommu@lists.linux-foundation.org>, <suravee.suthikulpanit@amd.com>,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH v3 RESEND 33/35] iommu/amd: Print PCI segment ID in error log messages
Date: Wed, 6 Jul 2022 17:08:23 +0530
Message-ID: <20220706113825.25582-34-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220706113825.25582-1-vasant.hegde@amd.com>
References: <20220706113825.25582-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4042e25f-714e-47d1-ae0a-08da5f45c689
X-MS-TrafficTypeDiagnostic: BN6PR12MB1139:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	pKeMTRlqnw47cWjZRXRNbsJ2xQgedqiqS2xZH2C3zO5eze67MtDEoJhOdExmFoKUBhw3fanZzRfdABzqiXv1xlVEkK/sbG+GypdgQSFUyQuZkf95zg3mCYLdBHvvw6MQjXm0FWQngqAuwGw5rv+4WzBS1PF0l2OIGN91mzw09f+Pdenp5A3PsY2uL8+zN9iF3zjmINPEbTq64wwWFKMMnCXAoq0PGPNCVCYuynTiyAVJtjFmZp8tc1msmT4rJZvyS3sBJ5Cy9PsBt8SXcjjYU5+C5he5ibRDkDSIzlX4Z+jevNoVdybP9qVJ0mHy7LzMMNOMPk8oL9VjNwT2hbMLJ0rLw4vaQqDmnKHyfYgdpr4cRffpDRmjo7T0fISBLDUvtIDb/i8uXl7u4fKGiepUfSMFMnIfDVRp/jVbkgwWl5AXJd768SurMRfRRTArO+3G1R5BouhqtARNcdrKQPdC+w6lTgyYL3sNw3M81BnAlLVUqS+Z3B24WHGiJqCL+t0fu3e7CrHhMM0B4Pub9FhaYQn/EeR9wgSh5mxWrIcZgQH8wGlWTeEd0W2OC6KEFvFp/gy8WLvsq0PS2h0C/dlBCQShpSa0PWNJ0v8oECWQ7b4xcvSqR54eRZZ7HGdBJO8DknD29fu/GLojj8fP7OBgymn2PZ2KEcqSADsDo2NRACx/e0mQIEIhm/NXGk2PLFgi0o5c8qGW7WCTLtSClTpKJd6UCrJQaAAPCq9WdMJ/NmF1ykjrdqm7NHPCn/eJ/Z53f8rjDOamosPXLe4PQNPp/JFzILYQgENvFUXnOSna3rHjtWPtJ1Rh/UD2C1HiTxLbNIA4gr5kemrgz43v1elxKqmoSfe9TelT6rmq7IPhhd/8hFieu/UV/u2nKJ/QhPb2
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966006)(36840700001)(40470700004)(2616005)(47076005)(1076003)(426003)(336012)(70206006)(8936002)(4326008)(8676002)(70586007)(5660300002)(36756003)(41300700001)(6666004)(7696005)(86362001)(40480700001)(82310400005)(2906002)(186003)(16526019)(26005)(478600001)(82740400003)(83380400001)(81166007)(356005)(34020700004)(316002)(40460700003)(54906003)(110136005)(44832011)(36860700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2022 11:50:51.2765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4042e25f-714e-47d1-ae0a-08da5f45c689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1139
Message-ID: <20220706113823.Rc08TcTgEbc8bvCctP-GyKORg-WF5JLdAF9TFUNx4nA@z>

Print pci segment ID along with bdf. Useful for debugging.

Co-developed-by: Suravee Suthikulpaint <suravee.suthikulpanit@amd.com>
Signed-off-by: Suravee Suthikulpaint <suravee.suthikulpanit@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/init.c  | 10 +++++-----
 drivers/iommu/amd/iommu.c | 36 ++++++++++++++++++------------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 9b1026fa7283..3c82d9c5f1c0 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -1855,11 +1855,11 @@ static int __init init_iommu_all(struct acpi_table_header *table)
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
index 2dbe17e49ffc..6a1db8f9f453 100644
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
2.31.1

