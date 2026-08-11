Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F462EC0A7
	for <iommu@lists.linux.dev>; Tue, 11 Aug 2026 04:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786421419; cv=fail; b=NH0zJ+vCCXQuCp8ypkZOmoNd4NmCTcstpMpH81JfEp5UIhz8UkrlXihICXXiVZaEcGFB1XbHDTWUrH+VRe691kXvU+1ciOShkJuLF8Qpy59DdscXP8dKsvFG440iGYvTw5FJ2idv3H17faeZL5rBu1WJZk/bDSLCwTLhxYPVYII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786421419; c=relaxed/simple;
	bh=APrgRWYPxn76jfIySglnQBi0Qrn8WpHynWLGKTRp0xE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KfqpJkG3J70IcB7ABqTOEYsJ6kSmJXHgBwWlt0XTptqDKS4IBEI6yQUz35GwHd4wqcpoHM+vdOEt8vrXEcopTLyARL5slYwahKf3HjecEKF7FBkz3t17i4PaqlUlHO0tZRY6SpKynnY2iptFZOlCInkP/8APF4SsygLmnd6copk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iN6jIzPP; arc=fail smtp.client-ip=52.101.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iN6jIzPP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f10dFtOvAiiTWswPOXJh9UGpXWxposTVYlPkFAHTYrr34WPZpbwpCS9pSkZTz0f5MYwh4zDJyr3KPtAZNU+8lrVsBj/CLl9Ja2IaigtbsPG9qq1YJoV7hXOyFqknZiUcHhNpHlCibR5PpmFBpJZnNb05ycVT2WrATwxXp8Av0emSzYKvpkxukKfcC2y5MhizKNrtB3FfnFsXWUFA1LzbJFEgYTvMbDVDWER/gCRPV5OeXCwn0WkK9e9NgQcLXPRVhdFDXfgYsCtHesqzKxVS11NdGoRkTbF4Ay01w0rPJumgAmhlU5vnrrn/OR0++VUtYefVGJyZ8M5KyZjel/ybcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YcuZ028OaUbHH4P7oZ0BKUrdTxcXdtGkYYT+SxE7cQI=;
 b=Li11CeRuPKo3/+ow0wQlHZ2RqFSlDSTdBgzjiBL2U3CTMmd7hjTVvY/AzXXQqfR0LfqfzQRF/KBLZBv7JVzpschP8N1j3oJfjMpWFYNLvF3xhZy67QMvRpzoKEocL2dDa7XkkoYBg2ZaTjbRagXC3EK3gHXJBTEutKNGvALE6dMLjxXjlXQft/1Ll5UAz1gdiQ+igggCfykw8uE7q8do2ThZ3ogD79wPREgx/GD0tuKC1csEDiafYpdsTa3GKTaAgOSpNLl6spN+A6M8Y/KPsml6NjbFTblT+/i0qSqToiiVU/Azs38Pe3I5vr6H65/qkNr26dEpeFuNDVKDbG95HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YcuZ028OaUbHH4P7oZ0BKUrdTxcXdtGkYYT+SxE7cQI=;
 b=iN6jIzPPSHuci0pjxOT2o2K1Oe+52TRjDGcoAgrA0FYsNFPy21aWJd0q8EZzPzZvNrv9rcOmAf/llS3Lu1lQetHcZ0U9biOn8wiS6QfaWZGwd+rzBBRS+NBZWwU9vaet/vij4EP0X4wE7vCbmb6RKpcOSWoumpBlY11n3FzFDxQ=
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by DSWPR12MB999153.namprd12.prod.outlook.com (2603:10b6:8:36e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 04:10:12 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:39c:cafe::37) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Tue,
 11 Aug 2026 04:10:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Tue, 11 Aug 2026 04:10:11 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Mon, 10 Aug
 2026 23:10:08 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>,
	Gaultier Delbarre <Gaultier.Delbarre@amd.com>, Wei Huang
	<wei.huang2@amd.com>, Ankit Soni <Ankit.Soni@amd.com>
Subject: [PATCH v2 3/5] iommu/amd: Fix missing CMD_COMPLETE_PPR response for invalid PPR requests
Date: Tue, 11 Aug 2026 04:08:58 +0000
Message-ID: <20260811040900.8572-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811040900.8572-1-vasant.hegde@amd.com>
References: <20260811040900.8572-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DSWPR12MB999153:EE_
X-MS-Office365-Filtering-Correlation-Id: fc0b2ff1-417f-4031-059e-08def75e7085
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|23010399003|22082099003|18002099003|11063799006|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	sNPwZjt7Sjx4Ye1/MswWxuut+LO7JnJsJ0ufWfajk8PT80dTP503qkwnQ6tI63lPykezYdPa+98jwWPf5GZ67hr/iTLnWxQVNKP4HKm3GtZaC2AoB63Na1GUL5cH9glDtOlgALELRSXUpiNe9uVshEgxuGULEsOcIyaYjlK0/2T/mlDtGxQfJt/qzdNhRW9Ub33dUAZZQNqZXBWzYKFE4seOtf7PQsPBwKMQM+ARwCOG7TGe0KsSdTmDQQluWXjBcg2I+Nsj3PltKEOxvyc1B3iKobMx/zvhe9n/6wMBenAOQNHCGoG71dgwE0oJnqDFFBpBOwsqUGSzOxnrIABe1j0w1pEODtq4IeYiIkfmmf5A0SEAtBHm+x3UlmqTlh09tESRIT4a9iPP+7k4yH33Q+vvArSyOIn8zKI1Mm9hGgvclPThzAu/Og0uIaU3F+Y2meFuhDEjD1PGcvLdaJDqVTGlJKsFqH4vtOx4PB60pD4lp3UcDoybuZ6EMpTAncyq3t3QtgFrYk3dYRCd2hHiOKPyNljTznxxv32QTIEdmB8vuufWDOiQeLfIu4fGH5/sdpRUTL8IDN/LUpJMFJHk1qhQabVnjziaUHXf2kEWNXAsQVuRj1clv4IL4bzC9Mbw4MZwrCW1bh2vzeZcccYSjm8DjClTAyjtieDzcejg9VLQKwe/utnTYZWAlfpu2S9E
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oFe9/+TPvJv7ZtmMhwmMZphEVR8FyhkiXKTHxk/N7xu5P9ELShqXZbzmiA28BT8L8T/U2dgdhLDv7zm0pOKGc0JTcMkDmMSxIlbmk/+Kyppju2VwHS8MSe7U7RKrZ1nBCrI5K+WLZZTJ4sN529c6PRwk1/KiN3rSTs45dt7Vh9b9LJ2It2GbNM5vZvZLgAxBKBQAoHLxmXPY8pfyZ+bMGitd+L81WnDCJey7SWv5aKY4oJ2blksy4vgl/UDjti/Mo/bCBWBDGnVV6K6+AjwOXhq0teHrMJ9UWB0J31RmFO3HlWQR5E+KW0jiCVTN1Fxf8AWFT71fCR/1h7WSm1iV+0RD5dJ6XAazYkPLNIET04Hys7FlFOR5CU+oKETSyR6z7feBP2euW2TzwHi/4/cRmOAlb1h3Jt44C6OHZxPFRacd2ugXuvxZaEPOHDTmFlp4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 04:10:11.9132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc0b2ff1-417f-4031-059e-08def75e7085
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999153

The AMD IOMMU spec, requires the host to respond with a CMD_COMPLETE_PPR
command when an EVENT_TYPE_INV_PPR_REQ event is received with the RX bit
cleared. This response was missing in the current implementation, leaving
invalid PPR requests unacknowledged.

Introduce amd_iommu_report_ppr_err() to handle EVENT_TYPE_INV_PPR_REQ
events. The new function logs the invalid PPR request and when the RX
bit is cleared, sends CMD_COMPLETE_PPR response.

Reported-by: Gaultier Delbarre <Gaultier.Delbarre@amd.com>
Co-developed-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Wei Huang <wei.huang2@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/iommu.c           | 38 ++++++++++++++++++++++++-----
 2 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index a7aa9411b2e9..500952e752b4 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -159,6 +159,7 @@
 #define EVENT_FLAGS_SHIFT	0x10
 #define EVENT_FLAG_RW		0x020
 #define EVENT_FLAG_I		0x008
+#define EVENT_FLAG_PPR_RX	0x001
 
 /* feature control bits */
 #define CONTROL_IOMMU_EN	0
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 563f9c2672d5..4372d3908e67 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -905,10 +905,40 @@ static void amd_iommu_report_page_fault(struct amd_iommu *iommu,
 		pci_dev_put(pdev);
 }
 
+static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *event,
+				     u16 devid, u64 address, int flags)
+{
+	struct pci_dev *pdev;
+	struct device *dev = iommu->iommu.dev;
+	u32 pasid = PPR_PASID(*((u64 *)event));
+	int tag = event[1] & 0x03FF;
+
+	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
+		pasid, address, flags, tag);
+
+	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
+	if (flags & EVENT_FLAG_PPR_RX)
+		return;
+
+	pdev = pci_get_domain_bus_and_slot(iommu->pci_seg->id, PCI_BUS_NUM(devid),
+					   devid & 0xff);
+	if (!pdev)
+		return;
+
+	if (!dev_iommu_priv_get(&pdev->dev)) {
+		pci_dev_put(pdev);
+		return;
+	}
+
+	amd_iommu_complete_ppr(&pdev->dev, pasid, IOMMU_PAGE_RESP_FAILURE, tag);
+	pci_dev_put(pdev);
+}
+
 static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 {
 	struct device *dev = iommu->iommu.dev;
-	int type, devid, flags, tag;
+	int type, devid, flags;
 	volatile u32 *event = __evt;
 	int count = 0;
 	u64 address, ctrl;
@@ -982,11 +1012,7 @@ static void iommu_print_event(struct amd_iommu *iommu, void *__evt)
 		amd_iommu_report_rmp_hw_error(iommu, event);
 		break;
 	case EVENT_TYPE_INV_PPR_REQ:
-		pasid = PPR_PASID(*((u64 *)__evt));
-		tag = event[1] & 0x03FF;
-		dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-			iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-			pasid, address, flags, tag);
+		amd_iommu_report_ppr_err(iommu, event, devid, address, flags);
 		break;
 	default:
 		dev_err(dev, "Event logged [UNKNOWN event[0]=0x%08x event[1]=0x%08x event[2]=0x%08x event[3]=0x%08x\n",
-- 
2.31.1

