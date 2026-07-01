Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95B1A3B4423
	for <iommu@lists.linux.dev>; Wed,  1 Jul 2026 09:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897658; cv=fail; b=OVNUhFQNuPbTkzHVXAqb0fjZSwSuu4whjRXJVmGtET8zRJtm7fURRdcNNXnF8ZWbwpYtdFGOv6S5JigNtwuh2jimF63mfUkaNL9Pq1czAZRTRg5lwFmCktH88DLw+rGaLO5S1+WTPEibB15Lo3Nvu2OtA5WDCHXeUhcK+AxdWu4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897658; c=relaxed/simple;
	bh=afUX0v2Lp1EdXh4boJ2sAReg0iK9TzNdaL1nQ/tr9s8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lLcAx/6/Eodb4YHZJyCmCn4fDlh8K1l1Hkna4jrNLRNKFr73yvoSumUqjHu2Y5gDOe4iVmSbdIEizv0GfXkobzgGhrrfUPlhR8DtO0IgJOgJDNziVcOwzqlDnFt8QEv1yjvWIwg53yS90dx0Hui2GsAnXwe33TO7kvgz87zTFug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GP4x+zlW; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GP4x+zlW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPgkqWIJsnBDp/0JMB15FAVouE2nYdySteADYv9Tl3sECt1ZvdtWn3s5tUK0a2jvGI5yb3j6FXaCThO85LeT3uBpT5JR0TgsrTJmdfWrfBDy0dkZgnctNUfL/495KIpZvkX7ah0F4yI548AAVHeQiPeyyErXhNOsjP2LlVwQ7dcY3eSlG/yXsho2wv8qrzTkKeieQ1/obpxlFr9TL3wo3/UKPtrM/BuXrhkpYQkWTkLtXDkrPjBpnCP8c68sEEu0+lDt6VQKEGjCY8R7MWSYS6FM4omI2O8seHaqNzzmfQwh2Ol6r1nd30eeMyFjMLw5wASKuqtHdH00RrOnk5J7Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kAxv0Wic6UQtemaZWspcaRa8pWebyKfhbxsLo09z7i8=;
 b=sbV2EyVvhLStMPdfXFtPRFPCq0lKjNJSXQelfIJvqLWL99aX+xi2dtuzHDx01YlcTuz+X/tmUtznZMkt6w0FUVg+WgtoSIGbxbtrRpeW2mIFDVeMc2BiIYMixF2R78MSIxBvZG1wQdtXlKp3eFPO0hB6IbxzI4Q8MjBGjl4AQyT/MCW4VmfaSwLczYWuLcy8LNfB+rN/JoLOfgyUrf1E8TYFhmON1hRB+yz5bP2fM/W+FnAqJa56b9TLdCoFn+FkPHToZ9zTTMjxE73bT8FbquifIJLe6Fqc2g2GOaRWRbca71qln5iy+6q94d5u1uFXHdE6D001r5//pYr63renUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kAxv0Wic6UQtemaZWspcaRa8pWebyKfhbxsLo09z7i8=;
 b=GP4x+zlW2EzeDN70agUwOuCLWFX8Pn+CmpZEAVj8S6U+COOWn3uYt07/m7ZBAsSr1erwv/qJrkzZQsuTpLDb0/Daj9OQLDRHBnVe3OCB9trgyhDKii3iQySo891dr8TQrSJNelwZktd1LemKveY2Ai4d+QnJdTETJYSAWxkS7Z8=
Received: from SA9PR13CA0061.namprd13.prod.outlook.com (2603:10b6:806:23::6)
 by BY5PR12MB4178.namprd12.prod.outlook.com (2603:10b6:a03:20e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Wed, 1 Jul
 2026 09:20:48 +0000
Received: from SA2PEPF00003AEA.namprd02.prod.outlook.com
 (2603:10b6:806:23:cafe::ae) by SA9PR13CA0061.outlook.office365.com
 (2603:10b6:806:23::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 09:20:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00003AEA.mail.protection.outlook.com (10.167.248.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:20:48 +0000
Received: from honglei-remote.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:20:45 -0500
From: Honglei Huang <honghuan@amd.com>
To: <robin.murphy@arm.com>, <joro@8bytes.org>, <will@kernel.org>,
	<leonro@nvidia.com>, <m.szyprowski@samsung.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<Ray.Huang@amd.com>, <honghuan@amd.com>
Subject: [PATCH] iommu/dma: free the entire IOVA reservation in dma_iova_destroy()
Date: Wed, 1 Jul 2026 17:20:33 +0800
Message-ID: <20260701092033.422867-1-honghuan@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEA:EE_|BY5PR12MB4178:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f98625-10af-433e-573d-08ded75209cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|82310400026|1800799024|18002099003|11063799006|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info:
	vyLLONTwaQjM6a1sHFJy7yJHbU8pfyoNORHz1BAscoTCdOvQ8rBTd0DonuowFc2+zEa74Di08O4WsVrgfC4qZaoX34GbBTwntWTFWjIBlTQTIWNC21J2mvIjJtiB/1FYWrMdzPEeQlUC0Dyfc/q/poyNdPAWmxKH2rhqMpFqForf+1kAWpSWYR415pztgogy7V88swXXVR/rhxMlYD8ne4M+vW4UCFqSv45Z0OfytjK5Tmmldsej9pU2C2V+wxQutkeFzycKZn13WYYWl3Xhg1gjJwLopwSbZyZHd+19X45rV+ywmcf3eL5i0qJQIuJ+07Dagz80vvLffusUsi8dM2InpFqor/RVDS1+nCFdLbuy4KLP9G6lonzxbnq3LAVXMrPkFn8xSpkCznNg6GAf88KYS5e691DkdQKgtiesOUMT+hIiDbdAYgGPcRRTEx9mr0dkTuz1NfqKf1lHFZPj8+dwErshuCOCfUKW4zM3S+7bQVb6zm/rvYJrf0asGCbC5RN/89tNxOQmBulkPFJ6mIJMniDY86wbzkYfWY0rUg/ejQL2vm2iEm309HtNMsC6zmwpHivyDcZ+Kbc1DeW4cT3Kqdk5+pzpY3TWt161Z/0qRGBSgJcYmfzIhxnQslecXV2TPV1ZwM4fSFUureowOt7tEhqkJ3EEVbJcz5Me8C6/4+AsEB7yn+UQBq+qnqkM24XTl6EZt99PGR7Dr2d2tA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(82310400026)(1800799024)(18002099003)(11063799006)(3023799007)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ng4uMhCnTHY00O9jNmHsMeayJRAsIkdKn2R4BK/oOlkgGVGlDiHgS71C2pA+7uA02rEaoOpujZ1krYONyR17hItrpirIuUvTYG7jvio7qbBg1wiKBaSbm1Go2UnZ871XD2Dwg0P1qBxoQuIWVgM1iTokLBtZT/BsQnBoN2Oikoa1waIzSkOfczei3dMl851XWu7HjcL2jJ5IHGK3dg6rd6TJ/vqEA4XYytqFPhIcbf+EudS7bqeiDOW7/itrFy3FIELnDQRArEIRDanpge8RaMBj/DQvK5xoJ55hO4PfVPKMd9RRR1RZkoMtSjCYm+y4QQElQZ/5l2Yww5TGe30B1tZZyfkplM04qINDy3tnO3kkpOc5o1NGV5W3jYZRj4D62hH6+PkhtvAQzQxlPKX7YYDkt4mOmPu1lfmz1SEY/b9rOsPR48hb9JzP9cQmhEG/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:20:48.4328
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f98625-10af-433e-573d-08ded75209cd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4178

dma_iova_try_alloc() reserves IOVA for the whole requested size and
records it in state->__size, but callers may subsequently link only a
part of that reservation, for example the drm_gpusvm mixed range case,
where a device page range is linked incrementally.

The doc for dma_iova_destroy() is:

  "Unlink the IOVA range up to @mapped_len and free the entire IOVA
   space."

However __iommu_dma_iova_unlink() computed the amount of IOVA to free
from @mapped_len rather than from the full reservation. When the
reservation is larger than the linked length, the tail
[mapped_len, reserved size] is never returned to the allocator and
is leaked, contrary to the documented contract.

Free the whole reservation using dma_iova_size(), mirroring
dma_iova_free(). The unmap step still operates on @mapped_len only, and
the same iotlb_gather is reused so a single IOTLB flush is performed.

Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
Cc: stable@vger.kernel.org
Signed-off-by: Honglei Huang <honghuan@amd.com>
---
 drivers/iommu/dma-iommu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 9abaec0703e..bb29c82d1c8 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -2096,8 +2096,11 @@ static void __iommu_dma_iova_unlink(struct device *dev,
 
 	if (!iotlb_gather.queued)
 		iommu_iotlb_sync(domain, &iotlb_gather);
-	if (free_iova)
+	if (free_iova) {
+		/* Free the whole reservation, not just the linked @size. */
+		size = iova_align(iovad, dma_iova_size(state) + iova_start_pad);
 		iommu_dma_free_iova(domain, addr, size, &iotlb_gather);
+	}
 }
 
 /**

base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
-- 
2.34.1

