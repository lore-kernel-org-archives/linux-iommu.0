Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011039.outbound.protection.outlook.com [40.93.194.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E14B3D47AB
	for <iommu@lists.linux.dev>; Wed,  8 Jul 2026 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783539897; cv=fail; b=Lm9VuDGzO2zXLyvGetdH0CJiKVKnhaGF9hi0B94H4aMCw92imP8Hz9F0hlGI9jcbnis7BnCv+wgF4yo8zqH9sqy6U7iP5/O8637dS+OxV2VQfiiuW8bT7v0BSa3rIJxBS1RY2F49Axdlijfi/B+1kkmiDeZfNzNef69KAa2b1fE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783539897; c=relaxed/simple;
	bh=ZEqiHXdMPxSMGJ/QLrN0bsAPuxKkleAIOpNAvJcvRX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZGbWQRE3BpoHsw6NT0/J6Hkt3L6gWy3HCX3t09QInIQObPjLh1/AqAxBbX7PNj6ip4HlvT8D0sV/NAxKf8JtwuouGtQKUBMHigh8YCx3lvS4Mjs9m+CM927PGhAe8sX9hFY/SfDPVmY5V9YyQ/m+FSId/Yqv3SVOKIKvy+YaM30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LVbHbJRx; arc=fail smtp.client-ip=40.93.194.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LVbHbJRx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jIAGMV5yEN46ytH/BLz/KPdEmLeQ0ICUe1jVAHd+1Mt78IEVOd/86JRiVPkImYgm8aNFby4zyFRwWBTDHBmJ2pCCGRA09gU67R6fLW3uduPTzLEy10VgB4WVW9EKIBZRo34qOXsX4jGMjOFU+JsM0vy+1Vm1DBh87Ra0gz6H7PBRZRTjsrSvkFJjth6APKnN2qOMeKSvrOgbY1LHo/RYL2VGNnjhL17JC1jbdsTNJ0BX+iDtlfpE+v5M3sM6u/rHVpdm8RjOo4KXzZ7z5ezUMDRHOm8G5MmGbDwXexB4oOere9XnGui4ZA/YlhdJyN7cFuwpXyb+YdOzplgNaqs53Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xLKpclR6TzU06Q17+5WVq9H2iJLIm9bYLUOwqelsQHs=;
 b=DVLy2Ez+XhCoOMdahE6BsRjqaZfN5GQjdrEtPXAXa+P1rDnOxPDRpgKXrWH0z6LVuQxMAczRvilk+OEJIyMvKaAQbz5juVDIV0PdTwuRcJ2/JBdG4zYSqjuouBOeHWusSTLvoUD29IQxwlt7fJn4SlYEN1ShMdFmE8Xx5BdBpDDf2SH0f0A/rweLsELkBqAIHuwApgLF9PWa9cxn4+dOy0yVc/0HeKTtUAy9kiJZqOGrVHM32qxTR8NsQe1dpzom5tF08rCQflMtCmxf3fWq6tbAJdAFQswQQjZ3ABNzLGANrADUFY3eSop0g2Aix57A3l/XQv7DZM2Y/nKL4kIcsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xLKpclR6TzU06Q17+5WVq9H2iJLIm9bYLUOwqelsQHs=;
 b=LVbHbJRxhqny3hsXTuGS1C8xysVMte/SCBKMVbl1OWHw8nDaVzZExiPVhl857kCSdNsh+mgdyyCgDh63O6A5dYhDHbVQP4pyKXsCQYta3diIJuSW/fT/zoGPCwGJP7ciS4XBgmS0AZcGLJuErID9rUFVQZ+Vt+/S6tNpPgggGXm2b+HNng8DSuXc9OZTQ3pa8K838yRzZ2qap3/l6vxvo9vVRrxnOCZH62V0dEz1m1xAP+pcwodmzEz0jQnM+0RTQNIt6S4AnpOhb55YRonWtoaf3g/RN/jzbQMwRIiCYvudOgOoOn71Tk/O4NE8HOVX4P5i55XOMqUZAdj+3LsBog==
Received: from SJ2PR07CA0005.namprd07.prod.outlook.com (2603:10b6:a03:505::29)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 19:44:48 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:505:cafe::86) by SJ2PR07CA0005.outlook.office365.com
 (2603:10b6:a03:505::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.10 via Frontend Transport; Wed, 8
 Jul 2026 19:44:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 19:44:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Wed, 8 Jul
 2026 12:44:39 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 8 Jul 2026 12:44:39 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 8 Jul 2026 12:44:38 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 2/5] iommufd: Iterate the cache invalidation array in the core
Date: Wed, 8 Jul 2026 12:44:17 -0700
Message-ID: <c19b7508428e9f14d6997ff9f5a41d9d5ba6cde5.1783539724.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1783539724.git.nicolinc@nvidia.com>
References: <cover.1783539724.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 700ca7b1-7930-4ea6-700a-08dedd295e5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|23010399003|22082099003|18002099003|3023799007|6133799003|56012099006|5023799004|11063799006;
X-Microsoft-Antispam-Message-Info:
	ELPohnPGlTeM41qYZTvkM1001iQYSzl3opyjk0obU/T8BfFEguaGb04iEdt/5rnx0CHOSHlvHlUtOHZkh7J5SYG3GIsZIBEKQJ9l2JSF4Jfjb3Zs9v6HFUyeaTLQy6CrD9JWGKtZprcT7+P7s/Dg/nag3U51+hlduvHcs8x64FQj8CK9NL7rpAW+D+TA4CYkqGGgLl2g23/fFldfApkVklsI6kpplQW4X/RnDDdEuAOjPthQv2ddPzN8VmHfv1dq8g+fkxK7zw4Ll273i6gnYkMQXfFcdbHD5b9gsEjnD18beOqbr0130w8lalIIPk3BrHCNkmQaUJTFiJBm85/ENku92vK+bZM+HqZMruSyYGwLxjcvQv+o3mavGhAH/w7mpG/ns0HhjxNFh/U+h5MKm8rbtPwupZfrEvb8mtrxY0vNaIs+W/SspDPptjqimNT3rrc7DhS++qkmWc30GdWx5ER8b0cWZ5VePW/iP4P+eVPiM3ohyn6s/KwqMuikEw10TNSXUrraRRL74qXIfp1oorVPk+16Jzs8lZjwdPNkGbA15yNATnwKjoEWgjMY3xNH0+JNvEuGvaCcElw3Tg2X0q6ORI5Htt5P/paEIsSZhwy5ipaLJkruk9naRqO6ukyb85mYYkYdlCILAdcQtR6IbMytXa88WP3eUJXosEfzcW7GPt+rMW+9yifeMFAs95QnH3F1Hv944a0usnQmCEsEow==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(22082099003)(18002099003)(3023799007)(6133799003)(56012099006)(5023799004)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ktwTgmvlugiBPFxlC4mubXini0Z5L5kIuMZJO6kRt+iAyyDy1myIjnYpdMBepsiMu24hshCygHtbnPJLHv/doSOnfgzWoE7r/Xf63PlAHrteQsmxfP+QTYZRK4CYcH1wpAHuTc4N8WKHtVkRswgiv9Hz9NRhKx4gH0s6uj3MGNlC+Lf+TRRJFeg999RXSpHa/AIMaiocaq3nkejdeXb6FYcJgn/z830liMWA9SyFcvXjpNEVIRLDdsUc22dueXfmoRWz9M2CXwT1HrE4A/sqBuI7RDF1Fd2Fbo4oL9m/HF89+3KdmfUd/jqQqeya38InMdKu1t9RhKBxCGzfdUuE6KlTunsuq8vbMjoHfQpmapf0YkLZZFr2YIPaoCtQWduiSLs2Hg0KaWkfqh8DOnwUvZUYIME5YhHQb0yem/Gq21i+MamcbPX+1ZwDudifZew/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 19:44:47.9585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 700ca7b1-7930-4ea6-700a-08dedd295e5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946

The cache invalidation ops, cache_invalidate_user() for a nested HWPT and
the cache_invalidate() for a vIOMMU, are each handed the full user request
array and report how many of the array entries they handled by setting the
array->entry_num. Every driver therefore implements its own loop over the
array, and a driver wanting to process that array in fixed-size chunks
(e.g. to issue commands out of a fixed-size on-stack buffer) has to carry
the loop and its sub-array bookkeeping all on its own.

Move the iteration into the iommufd core instead. Invoke the op with a
sub-array that starts at the first not-yet-handled entry, let it handle a
prefix of that sub-array and report the count via array->entry_num, then
advance the base pointer and re-invoke the op until the entire array has
been consumed or until the op returns an error along the way.

A driver that handles the entire window in one single call, as all of the
current drivers happen to do, finishes the loop in just one pass, so this
does not change any of the existing behavior. It instead lets each of the
drivers convert to bounded chunk processing on its own, done by each of the
subsequent changes.

Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 include/linux/iommu.h                |  6 ++++--
 include/linux/iommufd.h              |  2 ++
 drivers/iommu/iommufd/hw_pagetable.c | 25 +++++++++++++++----------
 3 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/include/linux/iommu.h b/include/linux/iommu.h
index d20aa6f6863ab..969758f87e445 100644
--- a/include/linux/iommu.h
+++ b/include/linux/iommu.h
@@ -773,8 +773,10 @@ struct iommu_ops {
  *                         passes in the cache invalidation requests, in form
  *                         of a driver data structure. The driver must update
  *                         array->entry_num to report the number of handled
- *                         invalidation requests. The driver data structure
- *                         must be defined in include/uapi/linux/iommufd.h
+ *                         invalidation requests. A driver may handle fewer than
+ *                         the requested, in which case the core re-invokes the
+ *                         op for the remainder. The driver data structure must
+ *                         be defined in include/uapi/linux/iommufd.h
  * @iova_to_phys: translate iova to physical address
  * @enforce_cache_coherency: Prevent any kind of DMA from bypassing IOMMU_CACHE,
  *                           including no-snoop TLPs on PCIe or other platform
diff --git a/include/linux/iommufd.h b/include/linux/iommufd.h
index 6e7efe83bc5d8..3087f5b2def84 100644
--- a/include/linux/iommufd.h
+++ b/include/linux/iommufd.h
@@ -154,6 +154,8 @@ struct iommufd_hw_queue {
  *                    The @array passes in the cache invalidation requests, in
  *                    form of a driver data structure. A driver must update the
  *                    array->entry_num to report the number of handled requests.
+ *                    A driver may handle fewer than the requested entry_num, in
+ *                    which case the core re-invokes the op for the remainder.
  *                    The data structure of the array entry must be defined in
  *                    include/uapi/linux/iommufd.h
  * @vdevice_size: Size of the driver-defined vDEVICE structure per this vIOMMU
diff --git a/drivers/iommu/iommufd/hw_pagetable.c b/drivers/iommu/iommufd/hw_pagetable.c
index 623cc608ca0cd..644daf18849f4 100644
--- a/drivers/iommu/iommufd/hw_pagetable.c
+++ b/drivers/iommu/iommufd/hw_pagetable.c
@@ -501,6 +501,8 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		.entry_len = cmd->entry_len,
 		.entry_num = cmd->entry_num,
 	};
+	struct iommufd_hw_pagetable *hwpt = NULL;
+	struct iommufd_viommu *viommu = NULL;
 	struct iommufd_object *pt_obj;
 	u32 done_num = 0;
 	int rc;
@@ -527,31 +529,34 @@ int iommufd_hwpt_invalidate(struct iommufd_ucmd *ucmd)
 		goto out;
 	}
 	if (pt_obj->type == IOMMUFD_OBJ_HWPT_NESTED) {
-		struct iommufd_hw_pagetable *hwpt =
-			container_of(pt_obj, struct iommufd_hw_pagetable, obj);
-
+		hwpt = container_of(pt_obj, struct iommufd_hw_pagetable, obj);
 		if (!hwpt->domain->ops ||
 		    !hwpt->domain->ops->cache_invalidate_user) {
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = hwpt->domain->ops->cache_invalidate_user(hwpt->domain,
-							      &data_array);
 	} else if (pt_obj->type == IOMMUFD_OBJ_VIOMMU) {
-		struct iommufd_viommu *viommu =
-			container_of(pt_obj, struct iommufd_viommu, obj);
-
+		viommu = container_of(pt_obj, struct iommufd_viommu, obj);
 		if (!viommu->ops || !viommu->ops->cache_invalidate) {
 			rc = -EOPNOTSUPP;
 			goto out_put_pt;
 		}
-		rc = viommu->ops->cache_invalidate(viommu, &data_array);
 	} else {
 		rc = -EINVAL;
 		goto out_put_pt;
 	}
 
-	done_num = data_array.entry_num;
+	do {
+		if (viommu)
+			rc = viommu->ops->cache_invalidate(viommu, &data_array);
+		else
+			rc = hwpt->domain->ops->cache_invalidate_user(
+				hwpt->domain, &data_array);
+
+		done_num += data_array.entry_num;
+		data_array.uptr += data_array.entry_num * data_array.entry_len;
+		data_array.entry_num = cmd->entry_num - done_num;
+	} while (!rc && done_num != cmd->entry_num);
 
 out_put_pt:
 	iommufd_put_object(ucmd->ictx, pt_obj);
-- 
2.43.0

