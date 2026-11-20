Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795188217;
	b=XkLu0Gc85FfO4e9Y0oq9nl9Vz0KUD3qaTAe+sRx3i6mM8nSh1JCvIUfChmWPMCLq671u
	 asMRPIACDFDPHpnFM62uw4kxa2jaWWM1bHD3+SF728gav3iUXckT8uMU0ZKKXk/gCGYPC
	 69kysgKz9MF565QpiX2Ic02u8esRSsax+Dn0HovHOkKA1sqUgP2zHP2+edFjiJUpqDfqN
	 +aLQ4FvJu6uJMVq8fwaq/zpl19SWVjeUPXYzscDAUOQlVG0KnltMeZelApQ0ct9vbQnyR
	 f9nnsmybdJPq1aQDSu3Py6TK5Iv8ryAbaGZpMxiSAbcYKvVd6QWr+GYSpWEBbYLMOjQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795188217;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=Xqd+gRTJqVqfEEGeYw8XiRxWQZPZQl1KWOnEd7eS0+U=;
	b=Vvuccbv9gZMIBK8ZZY850DqktLegXUhygGxOn6AIRmj/sVJ7FreI49Mub5nr0y7nVXrR
	 kOaW1QdiTE4O3BsiJo2TQY673PbMnk0b8G+nA9OZUr3TCgpVk3rAmiIRCpX8opwr/eWnO
	 vdUr5cByQu9g7rBVJcU/YlQxr8sG6inYM/9wN1THlNUMWDBP3OvnmVNZZblLi7b51wWEX
	 oSnj+BZB4vXivrR7UnwTbcvkXSkuhJBQMEbyIgQeGfziVy3weoxgTIzfVySAt8O7768uZ
	 pmSwJ+AqzWvpEAarhP8ra4qk9mmJM1MRmVZ+0vlNGN9FwDzGVXpVksaf6e3ICpsh2Aw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZVGNhRDW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.93.194.8
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011008.outbound.protection.outlook.com [40.93.194.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030F1606A326
	for <iommu@lists.linux.dev>; Fri, 20 Nov 2026 15:23:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 030F1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=ZVGNhRDW
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LegMYQUBgemEqspbN5f9u82fWJuJWMlC7UL/5+eSlE4xBIszlkOSPgJzWgYKTiqL0mqqUf9ESOK7sP+5UPkvJufFj505Fl9L0kzSaU9RGq0vcaCF2xdkCBg2nwP5SWYiGEJgD4plHSIHVlwEhQBTUNmN0Tbu8nMLhJzeJsFyDk9ZMGruvstbgHZNhwYX9w9fc7we+LgBbJiPbbCFc29DnQQkHE6N0tmbjeQj9tY+t5KU32H75wH4mK9at9xE9CS8GGHZRAEM+1WSGAJjq+U5LG/P5VDnH5qZssJu5WAHtSL6S/RbQs1A9TSPg99TqOr3TuTABWgAMA/9miiOn4P8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xqd+gRTJqVqfEEGeYw8XiRxWQZPZQl1KWOnEd7eS0+U=;
 b=ytGe02A5vlq+8IatHal2JaXFpdU15O0QprVdGHbQPi0fxnJFZUe2DXzfQaLfZQwAbMu1f97U17CNyEcNzjtaHlBFgbcAflqFJwDgk0BIrgbaD8VpMMdqQ5uPbiQbQ9brVCbgX98Wdhxa2tf8E+5z7fcxZB1Lvz/SW7OrPUPRjN2Fhy3hE1Uiqf0oAsCpWSDoh/OJR4qgmK+y/yS6VUQLTwh3Wpu4tPjwdAc0Z/9XALhy1FgnHDMr+dBWDKBEpTuDSSylmyOnbD3FQUehbqhMOQjpaMFjjAEYKf+6pjJAiMfQuk/ZRSgqSywnxguqYTVNh00vkBeOCn9xFOmzjXxc5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xqd+gRTJqVqfEEGeYw8XiRxWQZPZQl1KWOnEd7eS0+U=;
 b=ZVGNhRDWRvlbCUzw3rguwSkd+N6CEhfUeL4ntSh69R+VxUuTQuLbo963TDAa1a+bDxigmidpTMKm47dKZ9iRM0nx3MhWRxtxNdjlPRSEQQgBPrigPl924C0pTP4edfw7YSJS+ShssAYQ7tr4udgvYhPh2pOerwRilygI1WSY5Pw=
Received: from MW4PR03CA0123.namprd03.prod.outlook.com (2603:10b6:303:8c::8)
 by SJ2PR12MB8160.namprd12.prod.outlook.com (2603:10b6:a03:4af::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 15:23:26 +0000
Received: from MWH0EPF000D8951.namprd05.prod.outlook.com
 (2603:10b6:303:8c:cafe::5c) by MW4PR03CA0123.outlook.office365.com
 (2603:10b6:303:8c::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 15:23:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000D8951.mail.protection.outlook.com (10.167.249.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Fri, 20 Nov 2026 15:23:25 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Fri, 20 Nov
 2026 09:23:21 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, "Mario
 Limonciello" <superm1@kernel.org>, Alex Deucher <alexander.deucher@amd.com>,
	Akshata V Unkal <Akshata.VUnkal@amd.com>, Nathan Blomquist
	<nblomquist@gmail.com>
Subject: [PATCH] iommu/amd: Mark v2 page tables incoherent on Cezanne
Date: Fri, 20 Nov 2026 15:23:08 +0000
Message-ID: <20261120152308.76894-1-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000D8951:EE_|SJ2PR12MB8160:EE_
X-MS-Office365-Filtering-Correlation-Id: aa964679-f58f-4d83-9840-08df471a38bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|1800799024|376014|18002099003|261009223027099003|56012099006|11063799006|10067099003|261028144727099003|261102123227099003|261026121527099003|261026140227099003|261022075727099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	WMt0eh2mfR9HD0y9U7G9CarZDMBJw+lmGx+Ob0BgI+MWEtCOSF+IbpcWCNpNERUZ0dPwlzwPszSxbmZTyts2C657P26XcFWVKO5rVrpTAnIzzPFytVWAKxlH4gxQCTfXeJunwybrmUwAE/6U32QrFfPK8R2E2qw0SSPmp325IoF3xbbTiCuNokpYdRB6NISuMX22vdu/WWb/z7kjMhsVZBsmuJvFpH8GCWnYy7dZar321Zu6iOzFh4Z3zDj11gLqYoiUyma10+bXg8uLZnV6tT654wzG8eBUGNVOq60RwcXftydXNzqyD4/YdU9p/wAPIhzyfeyo4GYYY+F79JRC1F9uHzMLg8jtsEYQbxTTpEmQugCeu8hNr39d9tEBrBHB4vTplFIDeJZeYf0NzFT9+qBMtXgL+Mlg4KDVPsL7xWBJftILlJtLQ5w6T4Lc/FPEejgBCuUOwR59GKnk9eqNJmWMkiUGel4cFWMT419d3PXOmTrZ79lClHhET14V0e1XcZhVJBoCOKC+WbQN+jPrNq+qb8Zaig3uPVwTEXOZil8IGvNBcZGQayM+bTo+u9YSmS/fbLr8BV6yOy+6pfL97CVtc5hOX28NkOsTUzBeDS4JrR/CH35OXFFxu9ocYkUJ8r1m0XIW9ENJP2ZGGp6xbA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(1800799024)(376014)(18002099003)(261009223027099003)(56012099006)(11063799006)(10067099003)(261028144727099003)(261102123227099003)(261026121527099003)(261026140227099003)(261022075727099003)(261022105027099003)(261021121427099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ivHw+b8rngiLCIJ0icYYoJwBSnafIxXE9ttCLX63L3+0Cki5wly/wpA5KhAmOZl8g/gIbboY7ep/IRsORWKyTRXgggqcS9agJyHBCuGchCrwNk0RaSOggUQALcorzasu7pKRU08ab9Vrmpum/AFbdiMKCIVPjyb5a4lDPgwI6qetzCKf+vdZmfXetIWKaZkUT3u+GcLQpu7FazUbCMYlY7U4ECAUQavSK0+vTtjuTXsjM8wxjaDMzAmX99zGx83rmgvZHcWjwcNZhczQ22E1feyXslSeF3cndRoGCfruuF5xEM7A+VTSSdfziePujKhEeWCFPeiyG/jQLYZDaT6Zn+lx62iIflTLR83RKrSZTvEhclaE/TGhyyuE/ZSKY767xWwCp/bBSVz3k4iC0bWyQOUF54Par72tnEPbD+omjk7VVjdDHiloWfasK9vyoEP7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 15:23:25.5613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa964679-f58f-4d83-9840-08df471a38bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000D8951.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8160

DMA fails on Cezanne (family 19h, model 50h) when a device is placed in
an IOMMU v2 paging domain due to missing coherency setting in IOMMU HW.
The IOMMU walks v2 page tables without observing CPU writes still held
in the cache. v1 PTEs have a Force Coherent bit, which the driver sets
on every entry, but the v2 format has no equivalent bit, so v2 walks
are not kept coherent.

Set PT_FEAT_DMA_INCOHERENT for v2 domains on this CPU so the generic
page-table code clflushes table memory before the IOMMU reads it.

Link: https://lore.kernel.org/linux-iommu/CACOV87VBwH+R3eSBEOuz8hk7OaT63+A9m6ipPSW5wt1VhHMFPg@mail.gmail.com/
Cc: Mario Limonciello (AMD) <superm1@kernel.org>
Cc: Alex Deucher <alexander.deucher@amd.com>
Tested-by: Akshata V Unkal <Akshata.VUnkal@amd.com>
Co-developed-by: Nathan Blomquist <nblomquist@gmail.com>
Signed-off-by: Nathan Blomquist <nblomquist@gmail.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 41ee4ad1dcf8..0f04013f590d 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2792,6 +2792,15 @@ static const struct iommu_domain_ops amdv2_ops = {
 	.enforce_cache_coherency = amd_iommu_enforce_cache_coherency,
 };
 
+/*
+ * Force a clflush on Cezanne (family 19h, model 50h) when the v2
+ * page-table is enabled.
+ */
+static bool amd_iommu_force_incoherent(void)
+{
+	return boot_cpu_data.x86 == 0x19 && boot_cpu_data.x86_model == 0x50;
+}
+
 static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
 							     u32 flags)
 {
@@ -2810,6 +2819,13 @@ static struct iommu_domain *amd_iommu_domain_alloc_paging_v2(struct device *dev,
 	domain->iommu.nid = dev_to_node(dev);
 
 	cfg.common.features = BIT(PT_FEAT_X86_64_AMD_ENCRYPT_TABLES);
+
+	if (amd_iommu_force_incoherent()) {
+		cfg.common.features |= BIT(PT_FEAT_DMA_INCOHERENT);
+		/* pt_iommu_init() rejects DMA_INCOHERENT without a device */
+		domain->iommu.iommu_device = dev;
+	}
+
 	if (amd_iommu_np_cache)
 		cfg.common.features |= BIT(PT_FEAT_FLUSH_RANGE_NO_GAPS);
 	else
-- 
2.31.1

