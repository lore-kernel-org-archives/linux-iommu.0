Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013068.outbound.protection.outlook.com [40.93.196.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 106C941F35C
	for <iommu@lists.linux.dev>; Tue, 29 Sep 2026 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790718765; cv=fail; b=gx+4pNOjY/tldx7Li49WOeQice9tSPCmuFUO9o8GI1kOkHufTiG5npge3oyqsMVCmHzqgQtDQb+ZoQHxsNLHYazkF/FYu5XOP/2oAxRTDSDCRJZx8axPQlScw7P+BdyaZX1BQGGubWrguTBm6lxONmEaIMCfdJS3FBbDS/XXFaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790718765; c=relaxed/simple;
	bh=ctRPfb+1sRO2+YSaBfbijjOIl5zixX1csL/nYqixvG4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pAb2M6UpTZnhdtngogzEqlUhzQOGcNcYhwJdbYOTPmvv/RAriv6npQMAk2kMAJ7SPENHIRjEKgBIgcuHFDbIF2Fv7f7vAJzIMzlIMVEpQmhbxSnQbyKUeZ/sEtDtHL6b+tQNMpficFMx6tIkoit5hv+G936yrM7UYvinLFZyY/E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dyxdD0Dv; arc=fail smtp.client-ip=40.93.196.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dyxdD0Dv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ObAqiZTHG+LPJVwv34iuq6eFaa5HHbzczcDqdOXZ0HGirKG+OX4KpglkfkzuYoPjddqY6tAhGm06WNA+hINktsYsG4mpH+i+nikn9427HeuKsE/FtnaeR6tvYmEjndA34INH6kmvxjxU+TJg1oG2VNjxvONlYrke+tdzQX6plofUnBwT/XwS6M3w1sVo5VrPt9bXNqOVT67BjnyeduZQGdJjAQHN+jRaPI/uUmAk1/CinGHTrWOwpoeiDdTpn3vxFK08ATlU/buAj/XLhHORu1BbEWw79Z2UqEJXUvuUlNgV12dtqiR4+lQnwDWcX29cUeONnmkUFSmV9XMmyvVdvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rpc97EN+cbj5RMnVDFH5aRzU60rOnbu5nH/IYmAqNRc=;
 b=Er9fEuu6DGQ9YaiuLAvdfa3sVsfylvQ5rqryK/b/mZUlI8XHBN1h9GhUTv1bpzLhc3RJSJtOqltgiv2n0BWDpNrid8rkl0reaVR/uL/QjILSoCM/qD45zoW0hS1EmUwgLCf9IHppkFbOPaC9ndh9tPXOFBMypAz9Tess+pxn/AKqNLCyrpTTUfGV/s+pYaA5SZAcwPXZx7S9IaqKY3K6EGnBUxMnlmx53d8NNx/dHe+vCbJ/pkHJAK+sgkHMmPkfwx3Ox3nmLekcEPwj5OxYpIWePkSGheuqoSejL/pf6Qmjl6aJNiOvmSFgGMnQsG0/GMZLhoUL5mOYs6zfy9a/zw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=8bytes.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rpc97EN+cbj5RMnVDFH5aRzU60rOnbu5nH/IYmAqNRc=;
 b=dyxdD0DvC/5c0O7YNb2uRSe7XR8oC8TrC/KkriVBIttZD6WqfXxS88Sv94OiteY6GFKFHat6LDYw7Cv1viqR/rv6GUH2Qh2NERu9i82Es8XV8TfQyPP7TVX/oqBJgzjUnVjHCvS+XVaG0K7s8w5q37aOOz0iSgpvPTjYrHc4uPGgGu405sgfXhZrVoBZ2ydRHksKAlFtRdi+8jhpTFLhuVftL0YrycTZEwO+RkMmR4Xx0eWSD63nNsaidxjLuk25/LJMOKQcBHSk4qz20XG+Mj/tKbAXFIjVLT9UjqkNNoqswi7afOgH+f7t+M7tEfVSWAldLRt9CO1j36Ata5w8dQ==
Received: from PH8PR07CA0002.namprd07.prod.outlook.com (2603:10b6:510:2cd::9)
 by SJ1PR12MB6265.namprd12.prod.outlook.com (2603:10b6:a03:458::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 21:52:33 +0000
Received: from SA2PEPF00003AE5.namprd02.prod.outlook.com
 (2603:10b6:510:2cd:cafe::7f) by PH8PR07CA0002.outlook.office365.com
 (2603:10b6:510:2cd::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 21:52:33 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE5.mail.protection.outlook.com (10.167.248.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 21:52:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 14:52:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 29 Sep 2026 14:52:15 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.14) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 29 Sep 2026 14:52:15 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <joro@8bytes.org>, Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe
	<jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Jean-Philippe Brucker <jpb@kernel.org>, Yi Liu
	<yi.l.liu@intel.com>, <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 1/4] iommu: Unpublish the attach handle before the group detach callback
Date: Tue, 29 Sep 2026 14:51:51 -0700
Message-ID: <03392b21011e9285b342488f0df233b92acc3405.1790718296.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1790718296.git.nicolinc@nvidia.com>
References: <cover.1790718296.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE5:EE_|SJ1PR12MB6265:EE_
X-MS-Office365-Filtering-Correlation-Id: 9996c174-07c3-4d69-0d7e-08df1e73f759
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	L7baTU/sWdeZ5Rw4/CxDiDKkEcAk68UaHgL7s/vO/DxilgsBHBdySX8A+1oGTltA7/tGXVJGEUkuw3gv2x6YS8IKRyFyGQzv7BKh2i33GwCP62+5gC8GhQ3Nj9g35ytdL/i3GYPtgPuGBOx8tFjDeI4VnI7H/6jyCg+m6rRv8Pti5NARJNL4ICnNAZ1UI7VyxMr8MjgeZl7ghL0zO3v77H+oHo9Soytlth04ZMeDwYQ+d/AG0xP5VEo6xkd9APHaapx6VIp2mKf3XdXr7jA36CR682gip5drPqwakogvVOQAbvyfvn8yN9JU6wuwlqR5IHtY6LsImtlRJGL3itnzaLjFLcvk04O6C/Si0WzG4QzdauMa6YMEhYGRWKlvKjJ907JtQOG/+7LjwsR4y9Mcb8f/mBvkI40NPW8wVL4IhGJzFuwlN2UAIqr4Szv5QR2o/ZXs1u42pYjkIayOMDYYwqIiLi4hdkcz9/g0lAHmxZczfpt1a0A3FX5BPc/P5rH5zEB5Lwn6Ts7Y6R57n+pk9+4PkBZ+WHHRQxnSDQNK4xyqcC9GKn2ht+RO/DrqQz5PvKkNRmFcwhP+O5njBGx1TC4ZuESDe4DViEclw2kFZjxQs6MZIwANjEfRxZCfVc3YhesPFXsJ1kkZ+sxK1lwEBfJzkyYspiDGkeLfdlHY/CUcbWx4ex86gi+S3F84sk97hLOU6L8fdU1DrmHSvHtjlQ==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hQcSV/Ce+Q+Pljne58nG3tUCBPUqkdloAcKD+kZdVrd9UGNkPd/u9jKzDa+ktagMCN4Zs1+uYNYZgLL2PCpjdHmr+zOiDWVAMsexakValre+BcC6nmFjKkxkM9BAOmZS30JRq2/38HOgRGE9Yv8ZB0Occvn5FOZfGppfGJbIgN7Pg1xzvl1RRL31GICoJHGQ+Fl4An/uvickFPjYQ6c1qzxKDHrubJ5nJWIa5/+X+Oc6dMQtP9ApoEnWHi3w8uvAgcksvzv9Ad7jZq75T7GK1ekV6u5kUW673BCVYA1zcphT5lF8df4LvcuXqBguLnzEyLqMwrwvYKKkG0HxJ5Uq6gg/yXabk4MX1XnlPZ0r8djAVRLdzSSKyRP25T3b08JksHJL7rFTPeJaO4J0vx7x+xq3vOM2ECA1zddfv67m2Z3mdqO9r2t0EQntnqgtMHOR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 21:52:32.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9996c174-07c3-4d69-0d7e-08df1e73f759
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6265

The group->pasid_array entry is erased only after the detach callback has
returned, so the outgoing attach handle stays published for the whole of
that call. iommu_attach_handle_get() reads it under the xa_lock alone, not
under the group mutex, so a fault raised in the meantime still finds that
handle and the domain being detached, both of which the caller frees the
moment that detach returns.

Commit 5e9f822c9c68 ("iommu: Swap the order of setting group->pasid_array
and calling attach op of iommu drivers") has fixed the attach path, while
the detach path never got the symmetric change.

Erase the entry ahead of the callback instead. A missing entry reads back
as NULL from xa_load(), so that iommu_attach_handle_get() returns -ENOENT
and the fault gets rejected rather than delivered against a domain that is
on its way out.

Fixes: 8519e689834a ("iommu: Extend domain attach group with handle support")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/iommu.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index cd1bca7ede9af..a062a84686c29 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -3951,8 +3951,12 @@ void iommu_detach_group_handle(struct iommu_domain *domain,
 			       struct iommu_group *group)
 {
 	mutex_lock(&group->mutex);
-	__iommu_group_set_core_domain(group);
+	/*
+	 * Unpublish the handle first, so it would not resolve to the detaching
+	 * domain once the driver is detaching it.
+	 */
 	xa_erase(&group->pasid_array, IOMMU_NO_PASID);
+	__iommu_group_set_core_domain(group);
 	mutex_unlock(&group->mutex);
 }
 EXPORT_SYMBOL_NS_GPL(iommu_detach_group_handle, "IOMMUFD_INTERNAL");
-- 
2.43.0

