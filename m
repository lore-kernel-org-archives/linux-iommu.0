Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9C91D55E
	for <iommu@lists.linux.dev>; Thu, 18 Jan 2024 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705568597; cv=fail; b=dqkqK3pcCE8z/gAhXWbmYootF+dW+e3bKxwaxID9lduguGfbxNk0zBgSiIcr1xSjVaDSylg8yEWhQqyKlICWDHoDnfqYJpr9nZiFl+2tP0Nmh75LVNNnZtSQK71pG883CeRFHtEUL0+ebytHUhiLg8QDVVbEPJ7/T6kVjiVUy1I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705568597; c=relaxed/simple;
	bh=X2r5n9S3OSUHzC0E+yRb5udSRiD0C4rFLOb7oFzzZTE=;
	h=ARC-Message-Signature:ARC-Authentication-Results:DKIM-Signature:
	 Received:Received:X-MS-Exchange-Authentication-Results:
	 Received-SPF:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:
	 X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped; b=iG1Cj+qtXqq9UcXrNVMBYJJQ1S52LubE8NEBmVe4tqwu62ssgotQE7u9nfrREAHTo5F32fGqOhLfscfftOWZyJd4/XNAQqbTfCs6fh8KXAFbg87QNLXbk76EyDANUVbvfPT1UIymHWvL5QLvdQ/5t7ulnvLCs5mTuerNlZ/tkeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iLlioIPt; arc=fail smtp.client-ip=40.107.92.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iLlioIPt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKC4HA1bR0022siWcIu3GbLpZ2qLiFbXaN/lmj7FGCjn02o7CLTgHQt89jSkqHfcV9LLlM45lv7vgSTJIcO020II43JmiOcBOK8Xvg+BZ8XMQpILfKq7jzhEGTXzZn1Q/XwWYyg8EoKjGJ/mIqL7ZCBVl86ADOpodDsmr9YZDXDW8Yc7roUa42FLPtgAIm+t0YAsPvXdyF2NSsz3x76JlReQleIBR6p6SsMx+8z2iOPlvNWzn+bATVrpLYwCus5RW/gZWBnlR+kSPINL35gPzoo1/JHc9vcUzgj6668btoobeiONxZJ96k1ldkFrwVcO4+q5bBpJI0XhvuuT3UmmWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=73b8Gir25C4yXskl5wcy0vCDvueA1J+5g2M9RfDTZsI=;
 b=mP9zHdaIyiWCT1xBl3Z4lce/DGG9miyEExAt6JS83GXsGjPtMXviyLq+XKIfxjAEI7/osgi9oYRYfFk0xWIqRBSo/u72wfcaQumcB2DsgFeoeIBH7mHFFJ+NXfrH6Nx8aqsA0HN+9pa7qdPl8oKnFmxM3gYSQOG3SetY3U8yHTuk+taG9LnOHXebwjQBPXbfVYLVGzXn9htLoigdZ6cifoEvtl5xChot5g+DXrvS/TZdWwn/AchQ/JgGtHKY+PXL0qB2PzdiNzAHjsG2hgd1IukbMRdnZd6f8SMdvHlwrITRUFkdWOHoQujCe3IeWZe49g71qsXLG+E0txFbjKeoow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=73b8Gir25C4yXskl5wcy0vCDvueA1J+5g2M9RfDTZsI=;
 b=iLlioIPtiauH+tjhtklMpou8aSbf0DFlxnBXy4x+MkbBVIfJJwbDQaRVme+JiCNrh9/DSgnxtSzjhCZkJgvMgIngU+C4Mfh3fSE8juUUuA1IYe3PK7LG/ac9IAsG/bHiVInIu+KyBWnIJubwWHcc6+9Xd1vVLZH0cnybEqLYgVM=
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by SJ1PR12MB6123.namprd12.prod.outlook.com (2603:10b6:a03:45a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 09:03:13 +0000
Received: from DS3PEPF000099DA.namprd04.prod.outlook.com
 (2603:10b6:5:3b3:cafe::54) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24 via Frontend
 Transport; Thu, 18 Jan 2024 09:03:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DA.mail.protection.outlook.com (10.167.17.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 09:03:12 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 03:03:10 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>
Subject: [PATCH 3/6] iommu/amd: Remove unused APERTURE_* macros
Date: Thu, 18 Jan 2024 09:01:02 +0000
Message-ID: <20240118090105.5864-4-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240118090105.5864-1-vasant.hegde@amd.com>
References: <20240118090105.5864-1-vasant.hegde@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DA:EE_|SJ1PR12MB6123:EE_
X-MS-Office365-Filtering-Correlation-Id: c22273bd-d841-40d8-a7fe-08dc18044cf8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jFiRlhrYambnwuCxApYF3VD4b/sc5+as+Ql4A9Xt1wD90vmkqs7zkwYOASg7Wd+7YtNlhTkMrdQD7d/NxirZitLmGVcBOGLeWnv03rcOGcz07OD1bKY6Ob+VfmQT+3OOJ4cUJbBXQ60w/fzZrdctWnNBT8iZT6HMlX8BsUDtA/i3pA1n2p29rHppZpgGwylytZZHlKYBInrYc6XB6nVPNWIQFepWY6qUUBT/J3cRveHDUlVAiTlsnGx1NF/CtkffBSYTZaESP9MP0UeOK4PP25QfdbMqwCSSSMfl8F9RXbZYd08qgg3BeEDIFmPIICRv4I8Ie7GU/RDYl/ZO03/N+YSgf9J3Q5s5pqEIuOZiSprus64eeFISJYvdZ4db5vXJf9qEcgkdOw2QfqDiE4mvhfFOZuZnEPB6OaMYQ2BfTnX6/YHscyexmHHZ1g/DTgiLOiqC6pOU+X9vANq2YwMLDK3Oa0XW0r9L5ZN4huP4IJkm8HztnuSwUbHv73ip54OScNZ+WWesGKiXzOl8sbFM85b6xxEsWp2lR+i2CimFUNGu0U7sYqeFys2QsVBouuuIkJHnuiVtGsLlkGHD2PM6bPY4hAqehS+5Wkis5CCi9JcA1wvRQypaX93C8pTwkoFO09nJIOVXYGrQgtX6MCyVXhWPx9fGRW5BYB5VH/nmM+LBI1PN9IGYuc0/PmBfcQlkgkAsqR1AaIISMUUfImO0GGDzFRlnxEfQY5vBS7SIwZilZ25Ks0qUwL7t8peLpPjkOePyzDDNut4omciLcxfpBw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(39860400002)(346002)(396003)(136003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(16526019)(336012)(26005)(426003)(83380400001)(7696005)(2616005)(1076003)(36860700001)(47076005)(5660300002)(44832011)(4326008)(8936002)(8676002)(2906002)(6666004)(478600001)(316002)(54906003)(70206006)(70586007)(110136005)(36756003)(86362001)(82740400003)(81166007)(356005)(41300700001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 09:03:12.9286
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c22273bd-d841-40d8-a7fe-08dc18044cf8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DA.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6123

These macros are not used after commit 518d9b450387 ("iommu/amd: Remove
special mapping code for dma_ops path").

No functional change intended.

Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 722120f95647..9bef7aa54992 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -519,13 +519,6 @@ extern struct kmem_cache *amd_iommu_irq_cache;
 #define for_each_pdom_dev_data_safe(pdom_dev_data, next, pdom) \
 	list_for_each_entry_safe((pdom_dev_data), (next), &pdom->dev_data_list, list)
 
-#define APERTURE_RANGE_SHIFT	27	/* 128 MB */
-#define APERTURE_RANGE_SIZE	(1ULL << APERTURE_RANGE_SHIFT)
-#define APERTURE_RANGE_PAGES	(APERTURE_RANGE_SIZE >> PAGE_SHIFT)
-#define APERTURE_MAX_RANGES	32	/* allows 4GB of DMA address space */
-#define APERTURE_RANGE_INDEX(a)	((a) >> APERTURE_RANGE_SHIFT)
-#define APERTURE_PAGE_INDEX(a)	(((a) >> 21) & 0x3fULL)
-
 
 struct amd_iommu;
 struct iommu_domain;
-- 
2.31.1

