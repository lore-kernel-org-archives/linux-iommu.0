Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012012.outbound.protection.outlook.com [40.107.209.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4434544C4FE
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760259; cv=fail; b=asTExPZY0yMf2OtmbZK8TMW+TQ5XmdMfYVz1kdrH5KttLiK+oXprYZboFJZKiomAM4Q4CThHkilVvQc3zw7a9m9jeAy+WcBk9vSiLbtnAxjvy/SwQWlIPgd9HPuJ02xYW3h5rDLqtmQDqy9PRujncR5iuOvOkWVjNLrvmRBUurU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760259; c=relaxed/simple;
	bh=/Y2PQl0vJnjW2tmf54ugY+um95UjPb9FnJ6D/9kW22w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=osP1nYNEZKl1e1bbGtwnKLFfFJGGExflVExQ/zz4yDY96BQE8RbLTGDO1PlIxcem7QypMmbowGK+AT7Vl1AFEaYAPu7BXS5LFqP/bmh6wJt8om/Fm+mdLQ6riIZmMIaNVsNBOplQ+7+qo6PHlZLhW5yQbvYWzmdt1C4nDd4l4jQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dDnZ2AQ0; arc=fail smtp.client-ip=40.107.209.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dDnZ2AQ0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iR6co7FFC48HFFmVPQhPLc9VO0Im/pXCvEXHGh5mxNG4FfcC9zhsP/mf9wV73qY/uccH/lnbSWWDNmQ9fLd/0NL4L26/8OICkZrZf0f3diEKATHn/zYWMCfBGMGVRZkdcPdMXZb/dSEEUacRodhipYTYpd1ZMGhrE1XKMGTMiWprF+fRIp4OrUTRYCpLvOQHauUnY/dKmHmX0h5C1vYMOCT+nKD/fwme7lDfAfJKdEgKAvAR0xE9EaG0xYbUy4w5PuV/ZXEWVkuaFit62hddWYeYQ0S6YQn5r81C0S8/ZaTgDDg6LDETJiDgkJLcYhK6WjIV1inAbT/tLoaT0Zh70Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wx89cAN1XzONKzeV3Cn94rs4Y+inKDiYKDwx9ZYCjHI=;
 b=atQQhvAmXxrHd+yE8NRSX5QGtE/Q5PQDhHYyPP9rQElIXcUV6dTYf6hynjiqe1hl9ZM9vXoS4kb72S14Szs3ZX9pe0oCn5JirChFFGwUavGYwxvQdjQ6pACKXy/VwGVBXzyaLgwfDlnl7snGlyJ1wgRAyzVMv3Zn5l3xzE/F9UegxUXiDU0vMUjqDxNoTi143ZlWtEdJ9eu3T9ZGvoZTjuuEe85AQX3P4svx39RJAS6R0UczUDWD91lXb1G0oW6xIBlwSxnA5tHTtKQmbX9zd9y808AW5cxXoHEKs7VkJchSBUFmmpjHnMQL5/jNIqioq0tighNfHKrWAmeBW4rWQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wx89cAN1XzONKzeV3Cn94rs4Y+inKDiYKDwx9ZYCjHI=;
 b=dDnZ2AQ0hEgVoy0bj9lIieW3RNueKbmtGTk7G6G9fJmf4ndYF1KtuBfL4zZkarhR3Uh+79v+JQLnIFLA44rZhJddJXna5SG8ekOntdlYChf995ogC5Lfcm5FIyQgYZPX7oq2i3AtolKSUy0SJy5KNHFffOCSSg8B/tw8ikvwg58=
Received: from PH8PR20CA0021.namprd20.prod.outlook.com (2603:10b6:510:23c::26)
 by PH7PR12MB5950.namprd12.prod.outlook.com (2603:10b6:510:1d9::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 09:24:11 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:23c:cafe::22) by PH8PR20CA0021.outlook.office365.com
 (2603:10b6:510:23c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:24:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:24:11 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:24:05 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 01/24] iommu/amd: Introduce vIOMMU-specific events and event
Date: Wed, 30 Sep 2026 09:23:21 +0000
Message-ID: <20260930092344.5616-2-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|PH7PR12MB5950:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c3a05a0-b396-46b7-4d32-08df1ed49668
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|7416014|82310400026|23010399003|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	8SdG4NH8/SCWrkPT7USdSsNFLvD0x7X6LiJ0dH1ArSFQo6bDCqHAmJbvOOK/v+VwFUYTcaB7bfluK1K1vBBn45cDKbhKTTy764+BaDlesf+Cl2WPwuAwlpIBxGFi/P3DImBf4MJh3uTKRWVkd1xjhM7E/JOCj+lUSLaaj+hOqfcUl6P+MUbBI0MCHl6lHHYwSVcC1wgOYSvA8Aalg8QpajFVh4ieCmMTeOc7fY8rlZ/Y0ycwXy6Tme7fl4pqvZizJZvResmJOrGadcuIgMeS3JKYlbW6FllqeJ+sEpXj7biSjWJME5uveeneX5dVV+VgYDSk5P377wd+9ZUwu61D5hGfZXoZHtkZZE7L0eD1l8Qyp7FUHA1lgh6dQyzGvkow1emnjHvgWcy1XpE1OIXlQoz0mvpx8kDEQqTUUWr7l7W7lJ6Wi3kKKPLo/M73A8Fl8pN3j3zHQujrwGC/zb9YMfKR3S4OE81YvrTTh3fS33Irn/UPWZY57YINtWlxdiZjkzWD1FeS9jGRlSy6TSicNsJTMZ4UbhOY7qdl7zRRv/f/HPW47W4Qb266mk7h5AzHC9t6daBIH7JKP/37ahQhvJ7WKG7VIPX8PNrBXJBdPTK19b/9kTfKHy/kb0W3XnN0uegpkgLOcpIaDthIiZHkW/3WgJ4LKQyxrj4Mk1TJBe+gicTCS3wzGl61mye+vBJ/ApRCbz5pXiC3pLROXbYbTQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(7416014)(82310400026)(23010399003)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xkIrq4ENezCCRDe6cF7LFTGPJmwgwflTCAjxPHOSSnPQBqfBwb36fX0XnhseEkJzLotCPH6TJBS4XnTIvpcmk1T6NFlRrvTU4kWGvmHdPwtzUnr3Yupho+CHLZRAwnvaKrW2hHvY6lrp8AZRf5jSobJCHZx6Q7FcE8NgH8tx2vcXH1nsgC6tec3bMYxL99/j1GyC+In9LWWYvMcjGPzifx7a4+WOwfTWsty9ZST4cGLly13k0zwa3vrYevKsDzx+9hk0d7uylMPsXlDo6JDlS4Rr4fRKp83Rb41xNoDgoar7ccbsgFgM/UYOVsT/6M4HQ/PwM+LPZtjL3GTyA59wfoD1DbAGD8Hzy1tQ1zeERYZokAM3wBsap29fUTz5aQDxPruL6cyNRwPnEDIM54NFKKVHkZf97vvybUhdfUN74bgzaK61SUVhKhh7V0byzV6T
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:24:11.4504
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3a05a0-b396-46b7-4d32-08df1ed49668
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5950

Adding support for new vIOMMU events:
  * vIOMMU Hardware Error event

Also, adding support for the additional vIOMMU related flags
in existing events.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  5 ++++
 drivers/iommu/amd/iommu.c           | 37 +++++++++++++++++++----------
 2 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 8241ef922519..f26a9059a356 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -138,6 +138,8 @@
 #define EVENT_TYPE_IOTLB_INV_TO	0x7
 #define EVENT_TYPE_INV_DEV_REQ	0x8
 #define EVENT_TYPE_INV_PPR_REQ	0x9
+#define EVENT_TYPE_VIOMMU_HW_ERR	0xc
+
 #define EVENT_TYPE_RMP_FAULT	0xd
 #define EVENT_TYPE_RMP_HW_ERR	0xe
 #define EVENT_DEVID_MASK	0xffff
@@ -251,6 +253,9 @@
 #define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
 #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
+/* Constants for vIOMMU event fields */
+#define EVENT_VFLAGS_MASK		GENMASK_ULL(31, 27)
+
 /* Constants for PPR Log handling */
 #define PPRLOG_ENTRY_SIZE	0x10
 #define PPRLOG_SIZE_SHIFT	56
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 56262f6b1f70..43a5690721af 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -859,7 +859,7 @@ static void amd_iommu_report_rmp_fault(struct amd_iommu *iommu, volatile u32 *ev
 
 static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 					u16 devid, u16 domain_id,
-					u64 address, int flags)
+					u64 address, int flags, u8 vflags)
 {
 	struct iommu_dev_data *dev_data = NULL;
 	struct pci_dev *pdev;
@@ -894,13 +894,13 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		}
 
 		if (__ratelimit(&dev_data->rs)) {
-			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=0x%llx flags=0x%04x]\n",
-				domain_id, address, flags);
+			pci_err(pdev, "Event logged [IO_PAGE_FAULT domain=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
+				domain_id, address, flags, vflags);
 		}
 	} else {
-		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=0x%llx flags=0x%04x]\n",
+		pr_err_ratelimited("Event logged [IO_PAGE_FAULT device=%04x:%02x:%02x.%x domain=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			domain_id, address, flags);
+			domain_id, address, flags, vflags);
 	}
 
 out:
@@ -950,6 +950,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	int count = 0;
 	u64 address, ctrl;
 	u32 pasid;
+	u8 vflags;
 
 retry:
 	type    = (event[1] >> EVENT_TYPE_SHIFT)  & EVENT_TYPE_MASK;
@@ -970,29 +971,30 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		goto retry;
 	}
 
+	vflags = FIELD_GET(EVENT_VFLAGS_MASK, event[0]);
+
 	if (type == EVENT_TYPE_IO_FAULT) {
-		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags);
+		amd_iommu_report_page_fault(iommu, devid, pasid, address, flags, vflags);
 		return;
 	}
 
 	switch (type) {
 	case EVENT_TYPE_ILL_DEV:
-		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [ILLEGAL_DEV_TABLE_ENTRY device=%04x:%02x:%02x.%x pasid=0x%05x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		dev_err(dev, "Control Reg : 0x%llx\n", ctrl);
 		dump_dte_entry(iommu, devid);
 		break;
 	case EVENT_TYPE_DEV_TAB_ERR:
-		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x "
-			"address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [DEV_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			address, flags);
+			address, flags, vflags);
 		break;
 	case EVENT_TYPE_PAGE_TAB_ERR:
-		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=0x%llx flags=0x%04x]\n",
+		dev_err(dev, "Event logged [PAGE_TAB_HARDWARE_ERROR device=%04x:%02x:%02x.%x pasid=0x%04x address=%#llx flags=0x%04x vflags=%#x]\n",
 			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags);
+			pasid, address, flags, vflags);
 		break;
 	case EVENT_TYPE_ILL_CMD:
 		dev_err(dev, "Event logged [ILLEGAL_COMMAND_ERROR address=0x%llx]\n", address);
@@ -1021,6 +1023,15 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 	case EVENT_TYPE_INV_PPR_REQ:
 		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
+	case EVENT_TYPE_VIOMMU_HW_ERR:
+	{
+		u16 gid = event[0] & 0xFFFF;
+		u8 src = (event[0] >> 16) & 0x3;
+
+		dev_err(dev, "Event logged [VIOMMU_HW_ERR gid=%#x address=%#llx src=%#x flags=0x%04x vflags=%#x]\n",
+			gid, address, src, flags, vflags);
+		break;
+	}
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
 			event[0], event[1], event[2], event[3]);
-- 
2.34.1

