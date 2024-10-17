Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2048.outbound.protection.outlook.com [40.107.94.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F9E71DDC34
	for <iommu@lists.linux.dev>; Thu, 17 Oct 2024 14:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729173752; cv=fail; b=Pe8rcrv+57Mx0RlCY6RPrx8353wOriNLRsa3YfS5MCsmCHNkDtnhJv1lb9NfV6kr12f0PBwVUp1Ddb7mMu6xzwQGZjlD0Ui0Uur0QcAFMRICMpkeobGiIGXs1zg91k1gcKrBZmQcqxd0wy8ob9D2N1p2xVhE7h4D4SaoBz+3ACU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729173752; c=relaxed/simple;
	bh=2bbD9tN1i8KYVA6qTyPvFPeap59+IEEXRfXwbU0dYVg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8oLFJzUQ0XgTnJf23buxbHwBBINY2bKX3BiiyRgVDkd3cUfa1QHl2zFYsMmlVM5F/Y5oYAKSYqUWuFBrDdwDzNwomzcaXdW8ry0eo1hxzmg97P8ciJoAqaR/+2yC7M9JTwP1axtA+An+Lw/UmFLWv6xyoD9xcduzqXF4qizckI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QxKNqxAl; arc=fail smtp.client-ip=40.107.94.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QxKNqxAl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqbt9M1W5i6ivVd+a/7IccVrkA78y4+jE+nc33kITVKapXq+/OEVJfsyETpKpFpMZw5EsF8fBlq8rqZYUMaiMjtR4RVfbtLTtwZp47Q0Mya6eUE5meQWtNWgRpK9tqiNIfx2jC35CxAi9F6hYK/cjUsKcUtl58fiF+4Cd7uKjsCO3Kq6P6sV5bTo/JWLDl3e5nwmAYotxqOuXMnim0CI7PHqg7SnF4Gao5/pbRZqPHGYt9fGCJLx1ybCiMJJcjPX9fu+Dt+KLKInBhDnOdupvH6TJT91ufA9io9CZU5/0Yr8Qz75mTvCKIxiVKgFFtiKMe3kZLAfrr+S+z6CQUS0Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+LKhKptDht595z4FlmAOeJ/d0cAaL02yTziknhnT/0k=;
 b=fE3fSnhJ7XNc73hTX9gCN2YowYBU1wlmsSiBthD6cfdN06tC00CBAgP8PIpK0yOpi734x0tqZGH9bowKx7HJbwZMHb1bUaxuBIiKrSoInQbilhC8s/ekR7slfsFlPuH6SElED7DPaHVNmLerQ8KsZnAGVQTnYOiWwrJgB54BtFt+46p5/D7YKZVqVCnpHdDMX+vbR5vnEsJFTDeCGMJRJ3K7UnTHk1YimYiqIN0PUwzB3gP5b1UeeG+QkYSAOVsQvZyn+cI8mGeAsCST1+ELVLNZZiDn8ZkzuOvI4riEBeycggxF5RLdy1dGy6F22M2fwTmORhOxWOkY7m24j1PbWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+LKhKptDht595z4FlmAOeJ/d0cAaL02yTziknhnT/0k=;
 b=QxKNqxAljxXOuKpu8yIPv0Pk9EVPoZ1vkKa2YKnLtI27lRSM7rVmllgn2JxSztPWSB0sWxKsC8daDxFy6tM8F7wm9r0vF+/Pb//27TgkzE+CmVIg3r420avUExTcdXMdcgc0I+WI7PuGzeksO1ztXX3aSKtVo2KhNwXrYvMqsPA=
Received: from CH0PR03CA0382.namprd03.prod.outlook.com (2603:10b6:610:119::35)
 by CY8PR12MB7338.namprd12.prod.outlook.com (2603:10b6:930:52::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18; Thu, 17 Oct
 2024 14:02:22 +0000
Received: from CH1PEPF0000A34A.namprd04.prod.outlook.com
 (2603:10b6:610:119:cafe::ec) by CH0PR03CA0382.outlook.office365.com
 (2603:10b6:610:119::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 14:02:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000A34A.mail.protection.outlook.com (10.167.244.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 14:02:22 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 09:02:18 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v3 01/12] iommu: Refactor __iommu_domain_alloc()
Date: Thu, 17 Oct 2024 14:01:26 +0000
Message-ID: <20241017140137.6028-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017140137.6028-1-vasant.hegde@amd.com>
References: <20241017140137.6028-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34A:EE_|CY8PR12MB7338:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fc1c0a4-de9d-4340-96c9-08dceeb4524c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XmeEfku/lF39AX7dyBDh5Oc8bcI0dfdZe7InVmH1Wvf2PaBvm1kuXSZm+GBc?=
 =?us-ascii?Q?mt55kxLXDT0g2t2vin2hPyPIBABTr3Do2a9hJBwjw7ymC2iJTiHPvme9XkQb?=
 =?us-ascii?Q?3D9ZciNt5ZLLup4zgYufC/Kjo4ipVsFqEbUpFrd8FrnB/QO6mqJAH07Uv+sy?=
 =?us-ascii?Q?MX2IDyvylhrMxRuhvd/tglZArTEyPm+bwLGM1oYhaC0E37mJw1X0Ygy7YB3S?=
 =?us-ascii?Q?uRQUCjLgqyeuSVuZv/GvPuLq6SsXu2vK81u39/QwYJMjZFCsKawx1UTMkmWj?=
 =?us-ascii?Q?S131qVJevW6wIdU7OovJjKmLYsMyALOFX3JcIaCv49bq/5SVbrmtWG5F9P1k?=
 =?us-ascii?Q?B0LbOExhJhWeCPynME7H22sETmM8wWnY9j3L93ZpbfymvuFpYEpIbUEPVRJX?=
 =?us-ascii?Q?lgX9Ddg4isbzrn56ihiblCKuWyVBPhdE62ZPOuST5kVpTwGpzR5KCKDtv1fh?=
 =?us-ascii?Q?uC/tvcX/xXt7zIFKo0HvZ1J8D2gbyfGQ2FmfSAhsNOJYXbLQd9R/tac2EZe8?=
 =?us-ascii?Q?SLRZY/mP5eo3NN6lxWDjw2xYSAuMoDeicLF4PsAycAIdgBgr8vV5LVRMQpuz?=
 =?us-ascii?Q?ZaSCUsTRxIc8LFjHhz0LtRm+2ouoMtuCyobJuGRDISwm1F/GjtrFLQAwOYGm?=
 =?us-ascii?Q?kKJnZSaWLfjhtcSLgGK7aLWttQapxvDMsFVa8hR64644MO74vHyGP3SgiM6v?=
 =?us-ascii?Q?umH1CB+3e73yRYwi83DSeEqDnvBGCedLWrS3RkfeWuWxAfADKghF1YysWGo6?=
 =?us-ascii?Q?i+kaBdkKHwMKtVKVRcCUH8vwb2DxJVGOJA3uv2P1qtFGqNybSQ727rrauxnd?=
 =?us-ascii?Q?ENgdyodAyoUCgNsFKZTykll1UyJD9sbD4sfeuwv6TxAXthR2PRDH/xzq8/MW?=
 =?us-ascii?Q?9eWqJ77rLiXYcEs+TWpyoyIDv+4bE8WVS0rOYLFC6RHXvxjfoZddEKNICq3h?=
 =?us-ascii?Q?KkU/MpHIK+MK0zeZFpMGH1/2safNvTCamcX8w9F2n2VoAc/3h6SVmj7P0s6z?=
 =?us-ascii?Q?rnKhtwbXGoN1E1OVSVBj2VRkHdffqwTLvXL+GExIXAucJqQ/NfvjIWNceks2?=
 =?us-ascii?Q?k2M7WR5jQgJWN1bQuhO3AgPtqyt1i5Z3si6/jOX7Dss/6imQcd6kunSEFwHd?=
 =?us-ascii?Q?ofDqVfYy1403rYZmC1Durc1orSFiUFRTcDFWut/2JPn4BTBEELAYNWh0sWep?=
 =?us-ascii?Q?0s1aFYRsPEkjm8H83DaIS26lCmWmHKiRkPynzX6GQi5YnJwyEdzsX7ushR/N?=
 =?us-ascii?Q?YYSOIEvsd1zSgZkkaivNhp+j+1Ifcp97t+n7hZEbTUpSE7nY+7F12+fDWLqi?=
 =?us-ascii?Q?sxFlMDz91u0qSjGCzaLLI0ivDmUPY6vHmz6APnAyDayZTknTLJV1pj/N8N0/?=
 =?us-ascii?Q?8oZcKYqmuUyFvEstcNk7IXTgHEL4kCQQWiOprZKWntCirMJOkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 14:02:22.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fc1c0a4-de9d-4340-96c9-08dceeb4524c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7338

From: Jason Gunthorpe <jgg@ziepe.ca>

Following patch will introduce iommu_paging_domain_alloc_flags() API.
Hence move domain init code to separate function so that it can be
resued.

Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
its required in DMA API mode only.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Split the patch and added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
---
 drivers/iommu/iommu.c | 46 +++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 21 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 83c8e617a2c5..811748bec4b0 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -1934,6 +1934,22 @@ void iommu_set_fault_handler(struct iommu_domain *domain,
 }
 EXPORT_SYMBOL_GPL(iommu_set_fault_handler);
 
+static void iommu_domain_init(struct iommu_domain *domain, unsigned int type,
+			      const struct iommu_ops *ops)
+{
+	domain->type = type;
+	domain->owner = ops;
+	if (!domain->ops)
+		domain->ops = ops->default_domain_ops;
+
+	/*
+	 * If not already set, assume all sizes by default; the driver
+	 * may override this later
+	 */
+	if (!domain->pgsize_bitmap)
+		domain->pgsize_bitmap = ops->pgsize_bitmap;
+}
+
 static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 						 struct device *dev,
 						 unsigned int type)
@@ -1962,27 +1978,7 @@ static struct iommu_domain *__iommu_domain_alloc(const struct iommu_ops *ops,
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	domain->type = type;
-	domain->owner = ops;
-	/*
-	 * If not already set, assume all sizes by default; the driver
-	 * may override this later
-	 */
-	if (!domain->pgsize_bitmap)
-		domain->pgsize_bitmap = ops->pgsize_bitmap;
-
-	if (!domain->ops)
-		domain->ops = ops->default_domain_ops;
-
-	if (iommu_is_dma_domain(domain)) {
-		int rc;
-
-		rc = iommu_get_dma_cookie(domain);
-		if (rc) {
-			iommu_domain_free(domain);
-			return ERR_PTR(rc);
-		}
-	}
+	iommu_domain_init(domain, type, ops);
 	return domain;
 }
 
@@ -2965,6 +2961,14 @@ static int iommu_setup_default_domain(struct iommu_group *group,
 	if (group->default_domain == dom)
 		return 0;
 
+	if (iommu_is_dma_domain(dom)) {
+		ret = iommu_get_dma_cookie(dom);
+		if (ret) {
+			iommu_domain_free(dom);
+			return ret;
+		}
+	}
+
 	/*
 	 * IOMMU_RESV_DIRECT and IOMMU_RESV_DIRECT_RELAXABLE regions must be
 	 * mapped before their device is attached, in order to guarantee
-- 
2.31.1

