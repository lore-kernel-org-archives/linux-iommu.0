Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010063.outbound.protection.outlook.com [52.101.56.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9C7380FFD
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 05:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785130842; cv=fail; b=rnFMgrz0ilK7el/mOw7iRTxhbsl0of14MkS7JaVkUO095S0GKqpPaOayWfAO0+hjfoqbsrg63zEqw17pJz2vLxlwdW6baWTpD/4KAyUpsQRnMtuzQEzoFFf4Y+ca93Da2W88MIgtF0vOBQ0w7vaJzW8pvGK+yl+Jc1lPDhxNXt4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785130842; c=relaxed/simple;
	bh=fGLkpX+o0j6pUBGYD8NRwfV5m/axPQIvo3usjhonKCw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDqiurKllC6FidxzvXpQOqJVbHsOufGMxhGyuTvrZKPyJOMWtVCQwX46o4MTq2wwqHsih0CKWMI9ddfHeXDJxRh8jVJXDc6308lSLoAwI8Y+jfH1Q/N2NUhY5WwjGzwGmdQJ3+h7nZcd7JkZ9LDT0qFWucDlF3P8XVBKbrZtwGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=U//gJTHE; arc=fail smtp.client-ip=52.101.56.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="U//gJTHE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwVWtrYQGV6ksP6RTWVPnO6o6HwBD7bVpgkDnQX24WM2gfnYSytZ9rIcTxDEntpJXaGxWGsEkCpvMSCGeql4kC5UtST6Omr5Zo0E0y3liHhOY3GFekRHukHouMtdSRF2H79PyHuQ/JiR3pvmjhF8NjcSLPD0F8LT++4kUp3xBvA5tMhEXOvOJy761lxRbn+vhYe7wO4CbkkWmIYrmvZ2MwFhDBYleolsrxmX5ifj9PmCdjGkgMPQMXN9R97x4hh7BoAULP6VBquINThra0IU535oSjSCE1ZQr4759Ye664eKOBsmUXlDzt4bEHeLlT2aclO8BJUP8meQgCLeo1s96A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMZRP1PW4dXdC4szgvEFEqJiQVMQXVSlV8LAybyWQx4=;
 b=vD7kTh8gkUvT5wDCxvNQag50XEMCRhPa77/2ND6KQHUrPqIS07i9u84IN6brKfgshUr2Im0L6snnZcqVz6O7SIcthHlbjmDLPMPsdPQqjc8WxC7jCEAdumP2ktHjDxXmV+zikKepSbUxKwf4FmobyH13mfPA7N7fwN4RhGCSq9H5uU91+yEyU9iGMp/+yjpybOCCiLCXT/r/rsmFhzYF6+pLDono0Q9q1eVs1+7D0hpBg8dfsjbyCKdSm7LEf7dyvZYNHYlirQqp3a8taX6SLe2XFwjHFBb/FozMPcme9Jhqf9kDAOC3R4ZJP9xpqmb5b2zokbl7+12GmpjTo6mfXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMZRP1PW4dXdC4szgvEFEqJiQVMQXVSlV8LAybyWQx4=;
 b=U//gJTHEAhm9OMavqpv1+yj7TcRRWV3qcdPhyks7DfzPv1i0xc0xUVCZbFe5TLeh+asYObcK82uGBTKj/KmR9R96/80QKikSA4pYHEbfqAxJyuwgAYJCFguG5oNM+m+u4AJwID8vblaOqAPB+6WWf9Z5JVQ9B9bXqkhH1hyD+18=
Received: from CH0PR03CA0369.namprd03.prod.outlook.com (2603:10b6:610:119::22)
 by IA1PR12MB8358.namprd12.prod.outlook.com (2603:10b6:208:3fa::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 05:40:36 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::8c) by CH0PR03CA0369.outlook.office365.com
 (2603:10b6:610:119::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend
 Transport; Mon, 27 Jul 2026 05:40:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 05:40:36 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 00:40:34 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 4/5] iommu/amd: Rate limit INVALID_PPR_REQUEST error logging
Date: Mon, 27 Jul 2026 05:39:06 +0000
Message-ID: <20260727053907.7622-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727053907.7622-1-vasant.hegde@amd.com>
References: <20260727053907.7622-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|IA1PR12MB8358:EE_
X-MS-Office365-Filtering-Correlation-Id: 32e1a729-029d-4a9f-89bc-08deeba19580
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	NyXwdKIOKIJBC06djJkHEgpoUY3UmwT31K7EsZ24lqm0qnYzAPIFfHaVHv9npOvjm4IHIiFDOTUi3iTmLlKNerZFhbgTTU3vp0WUtSBqCQL911EbDoA6oSvZxv1C3GOCNuD7y/2Sc9L/RAOP7q4uW5mmCCkLf8h9QDdoQZLsGZxhm7SQ4IxPvP8cnY3ez3wjA4YB8xCCUhMzRzRxKrL9ECsk1i9R2xgx/1jJ3tzPffSxFRMpvR8tKzJv6Mok4V5CoX2fYi3guFlYSd/DEjZinpDcsf0nQpbg0NXEwq10aIEU3ecs39+93T2sLP/j8sJeJzz6H3g/stQpzo0gU7lfmXctItWdTQ9I2K7EPszkmVJm5xKPb/gTOg89RVoE+vfoBYj4GRmADgGHb2SIbNL5MmkfN2jyolHBGNb4bz+n1Tn0dh3bObUEol1LlHVK4+nYPz7nU1eBlyM2QReyvjj2d1FZujvhadjzb57TE2x+P5pj4Qq6KYAcA4wBOF5NiJED/Bwu/T73b/QeBegFACDdxJBx+q38hFdImuqQaBvkykYLZr8EWSG1wlI3EFlniHXWJ39NaEBpztq1R2OFCXqfOuAaoKg+TggL8T/zrm2V0DCObo+6W6v6cx2OlGnKqw46AAtoebnEPZkW2j+GQEsfH5ZOEXzrVr7hlibQ383G3Hk15JeC9dFbC81yzfxuSTELTeApdfTbfdh0yjI6Rcbeaw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HpwiaYZEAMDp0UWiXZpLBoLfs276g2LAZlB0agjV+onirkTRJhF8vIeQlm4T5xuyMYcA1HyIuNU8CmIdvBNuw5MjbxNTT5N2aAaSS9gPdvSoHqmXlBuSdjX7Q5Xwu9mF2+N71Rk81cXNbBzkqktGJ4L4Nv/41zatahpqqPtW1p5/AC/6Fnc/U4XcU66Awdlonu8XYA5X1+etqbxl9A+yc6jy3jTLtxqTAR8ajfDo32X3XvD4TxPMnagK4v/5YgMPitDfb2ahjgagx/k1b1QEL3xDt7xL0+kNm7DghX+1MjcVXj5vnfi2idw94Tm/N6nlkvgSTNSiwqeHqZDUcCUwk/6ukjH0opSc8VZkJaX0EgRMar3MMmls/5Iu9gvRyFDK9mRY/z5cPSL/x96f8Cy6PeuKMiehLwwKOUWoHfhAhqvtJNOG4qfU2BdeTathLhjT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 05:40:36.3350
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32e1a729-029d-4a9f-89bc-08deeba19580
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8358

The amd_iommu_report_ppr_err() function logs an error message for every
INVALID_PPR_REQUEST event. Under certain fault conditions, a misbehaving
or malicious device can flood the IOMMU event log with PPR faults, causing
the kernel log to be overwhelmed with repeated error messages.

Switch from dev_err() to dev_err_ratelimited() to suppress duplicate
messages when INVALID_PPR_REQUEST events occur at a high rate.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 4372d3908e67..17df9b28ebaf 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -913,9 +913,10 @@ static void amd_iommu_report_ppr_err(struct amd_iommu *iommu, volatile u32 *even
 	u32 pasid = PPR_PASID(*((u64 *)event));
 	int tag = event[1] & 0x03FF;
 
-	dev_err(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
-		iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid), PCI_FUNC(devid),
-		pasid, address, flags, tag);
+	dev_err_ratelimited(dev, "Event logged [INVALID_PPR_REQUEST device=%04x:%02x:%02x.%x "
+			    "pasid=0x%05x address=0x%llx flags=0x%04x tag=0x%03x]\n",
+			    iommu->pci_seg->id, PCI_BUS_NUM(devid), PCI_SLOT(devid),
+			    PCI_FUNC(devid), pasid, address, flags, tag);
 
 	/* Skip COMPLETE_PPR_REQUEST response if RX=1 */
 	if (flags & EVENT_FLAG_PPR_RX)
-- 
2.31.1

