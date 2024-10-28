Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2061.outbound.protection.outlook.com [40.107.102.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B761925A3
	for <iommu@lists.linux.dev>; Mon, 28 Oct 2024 09:38:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730108339; cv=fail; b=n6lvgYpHvZjfCpgjOoYpfI9vdp3EaM1eKEmZC6YKAVhwHtnWK9BIFFxlgpE8hpgedymzkbWmjnHyrDNiD6jA1LCLt4VzLKiR5cjp8+7+zXDLU3MSfJPyBxjaWrUQBwBZslehh5Pj01H/JZ/3ufvWtXK5yPjNBU189y4Fl1y67KA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730108339; c=relaxed/simple;
	bh=X/APcutF9a/bXlYf6WtUSmnIOcjwL7rV2/80IdOXUe8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qyZGA+bZVHwdfKdOObovYLN2XaKxTgOR2ICmX8igi8ZNdTuots8qM/Za5eo3wnq74BVwdMYJhEJKFrS/LTWfDpi7MIjgHRiSHNdYNDPw1a0Hoi8j++L0S2NAqhvvypnsBXV1lXNvSQR4VE2qRmauZsFgMDZ00K/f3t0dQ1zk9/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mK6+svtE; arc=fail smtp.client-ip=40.107.102.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mK6+svtE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H5WvaQ2WVUfSD/YfxnZtcbP+u9wbmYXNXrQenigj/O6cnV+t1zsSR0RWF2FiNuhJeGt13+l6wrzYFOVQQCgYKtkb4ELJLtZPpvFA/v/am0cKM2VrtX/N/2e9wFRQBttOJD/ewKp2dCRGM056ofN679wgVEacjHa4OUIOyvaPjc+Fod4zGiMI4+uC285hE563hPEYSb9Nci6yISLEUaTdXAZ1cVPxNuVUFVsiF/TzmM+7lvoVXRtErp9JnE9McwgFpiMBSOy3wbvk8XgVcFcUeZhg1iXeuLd2Fdw8Yp7l6K+fzH8P3zNRTCAV/zjfpe69nYISR1vmvHOoYsGnpv2Fxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHDUevirY/a3ux1qh23oq5+yEOHQjFsJP3lyxzCjIaI=;
 b=NnRmzV2AtAlPTAwt/UxqOSlf8wflweC2uESvGeJsunG0bThWAs6kgNwG6t0BV/FAZkLrrFQpRqjJyTdVFmCUt8iYof3gjl+uL9w9m4alaIv+iExtjNV2vV8IxWNcTr22bbNtCkNFOpITtGhrivhugutMbMWw0jAFdyPtlSFxGKbkVt/CuMqFyp2743OIO72yYgiAs6ODT/lMKs+J/YHlQFm+SEji1dWd0UmGEteVLnHZMTvfnvoaZIb07tV1EpHcxhVc+lZaLSTj2U6cOGNxzjvFbhBvxo5qXQxLnjs7hRrZkst1JKVlGW3xg7dIbaqAgPjPI2KJq1iGGQhp/jKWZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHDUevirY/a3ux1qh23oq5+yEOHQjFsJP3lyxzCjIaI=;
 b=mK6+svtEb+YxoAzHUyhTIi2WJuWDIxZGcxPXX5/r9TvfUqzuDbDk6qtNzGyWVatF/kg0m0rT2aSYzHKnNhXR/vlhyWFDGunVB4O2qcCR80NUjvyO/nQGSD3rpOUgfkzTTsCOeAufFJS2VPjA8mlonxCAj8GxAmGe2EavXXtZQxU=
Received: from BY5PR17CA0008.namprd17.prod.outlook.com (2603:10b6:a03:1b8::21)
 by SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.25; Mon, 28 Oct
 2024 09:38:54 +0000
Received: from SJ1PEPF0000231C.namprd03.prod.outlook.com
 (2603:10b6:a03:1b8:cafe::f8) by BY5PR17CA0008.outlook.office365.com
 (2603:10b6:a03:1b8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.23 via Frontend
 Transport; Mon, 28 Oct 2024 09:38:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF0000231C.mail.protection.outlook.com (10.167.242.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8114.16 via Frontend Transport; Mon, 28 Oct 2024 09:38:54 +0000
Received: from kali.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Oct
 2024 04:38:50 -0500
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@ziepe.ca>, <yi.l.liu@intel.com>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<jacob.pan@linux.microsoft.com>, Vasant Hegde <vasant.hegde@amd.com>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: [PATCH v5 01/12] iommu: Refactor __iommu_domain_alloc()
Date: Mon, 28 Oct 2024 09:37:59 +0000
Message-ID: <20241028093810.5901-2-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241028093810.5901-1-vasant.hegde@amd.com>
References: <20241028093810.5901-1-vasant.hegde@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231C:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: b7ee52d8-be6b-4581-2a7f-08dcf73456b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EcoI9ufpTKEIGa8P5DbxjQidH+FBQBAAhNpoGAUFiDDdn6YQEAptbgwk13rn?=
 =?us-ascii?Q?DfKoFv6htLl82PDWQfE2F13CuMlkHSc3Xx3naMATOkgRalWzHkzknVM/cUI7?=
 =?us-ascii?Q?6dqvrx+bH1dlNgWtTVIojlsBcTa2GOyPnZAv/RRF5xw+GCWT9GsR0OSu7qwq?=
 =?us-ascii?Q?BrWgLnK7dJkjXMVjqvHQY3HOC3QDUCEzjIEXwk6TCgF59EwblL3MLSX9NgOl?=
 =?us-ascii?Q?mxYDONtl6Tp3VhQJP7GcBKYDeblQ1rSaVNCkohDcnld1Hm1E2yFFA9zV/AyT?=
 =?us-ascii?Q?k0KRD/GqPVbHc5KclapkOEMvRKKMhiIG6X9yLGjd+e1Siu/ke1+gbbliB4jW?=
 =?us-ascii?Q?EUEZ1ovwhKak7HbLgu8Sxf40eIvnU62cAjH75MZ3IDheLjA54AHDHAwFtxht?=
 =?us-ascii?Q?KEURLyPNTeinrMTSz0uWHhGcc7Qv1ZdizefpqWLYV/7G3MRHYQLWrGagUJwi?=
 =?us-ascii?Q?pzFEJbjFUnAgnKyuUkWxwZLQuH8ck3tfMxGj8EehCcORFwsD6Htk3wVrVeiX?=
 =?us-ascii?Q?sYXAonsik6e6RnUzmKkKMHwrUVIqRCfbxSnxBDf/XoNR3Y1iimSXHib6MPor?=
 =?us-ascii?Q?qTmSD+pLLMDkbmaSuZ/SSN0geGpeaAvp3CCAy4rw2hDoIJ5e4O4R5VfhMEGP?=
 =?us-ascii?Q?1Q1flurrobL6RRbVNRUxAFTHMSNaunh28zOgOUhhsTYfNViz6BxUeG8Gk+Aw?=
 =?us-ascii?Q?sTuNLXxsRkpK7c6k4J6zZH2ESOdFAFbA7zjFylRkv5QQjbcJ7nwEoduks+rL?=
 =?us-ascii?Q?uOWbQj+kfJNNggbkH8+FkMHergkqDJsEMKXviaB7RzfsYKCmhiOs/jIoGglF?=
 =?us-ascii?Q?8rQGzExyBaZMzQn4FU55nSWLFD/omGfmleoi5mxtYUFOIptCJdaedojI2GZv?=
 =?us-ascii?Q?Plx2DhPFSZz65HQOhurRGsXCwjr9/hNCJnpkMjn+Lnm2Wr+MgtypfnTRRhdP?=
 =?us-ascii?Q?AGvh6tzm2yKlWVX5jrzhMMKMPoAMjWDQsAHaATJ1K4wxDOEX8ahEFd6dx7JB?=
 =?us-ascii?Q?IQnBg7qjxeoypc8KrqMsW/Zp8r82wk8ETAa3CfyVQhSwkAFspUw1KPlYKAlj?=
 =?us-ascii?Q?A03q4HwMao8fE7U1ji9yDmoo9qQlEpkuKcydfhqshR37h60dASwQ2i/r/PLK?=
 =?us-ascii?Q?YHBIutLKGrE3obVjkYQigvCFpVsKXMYF1aTlxdvEgF4Ms51/1+geMD1lOZ+Y?=
 =?us-ascii?Q?0ofEk5QIzKVgaNVUwsta6Ai3Ou2+zjtzuNq9xerkw7x3WaxEP6aOzKaQlnQx?=
 =?us-ascii?Q?p3l2CwY5tBMcH5DHd82A8CeOF/cqfzpSgQpHE/MWAu6/T1MTncoqKkZEJBKK?=
 =?us-ascii?Q?IyMVhfR3KBE1YBgzYEfjnWyevRcdoknpWYQCNA7G18DWdH0wkonRfE5YSpbd?=
 =?us-ascii?Q?KHofpha4XyXSlMVjnwRiu7SerLJ50F8sxi5XFuNSB4hqlmoNKg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2024 09:38:54.3188
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ee52d8-be6b-4581-2a7f-08dcf73456b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231C.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159

From: Jason Gunthorpe <jgg@ziepe.ca>

Following patch will introduce iommu_paging_domain_alloc_flags() API.
Hence move domain init code to separate function so that it can be
reused.

Also move iommu_get_dma_cookie() setup iommu_setup_default_domain() as
it is required in DMA API mode only.

Signed-off-by: Jason Gunthorpe <jgg@ziepe.ca>
[Split the patch and added description - Vasant]
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Yi Liu <yi.l.liu@intel.com>
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

