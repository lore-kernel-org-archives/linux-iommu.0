Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3439CD1F
	for <iommu@lists.linux.dev>; Tue, 14 Jul 2026 18:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784054994; cv=fail; b=GTTAYaC1jR6OJMh0P/cDon4P0OsaZAzg6vPckAKjiImUsga1ZdW+vBq4bB7jmsUJlWHvCWcafg2SpZZACtC8rWiBD5tgvNWUUH+rMVbiPcezuP34QZiM0wTBg3Jz5wefFUbaXMuvPlOKKliu8NKiXcxZPO33ET6RCzI2ncF7dZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784054994; c=relaxed/simple;
	bh=fA4GBagE0Hgl3PTpEi4GCJ5CIH6TC8NPcWTOuGm827U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOEDwlj1tcXk5TPkhknQDTHu2MYdWiyIdnsOoaIyzbq4dC1diKKqThV4VZ9M3BMy1zUJuHlqjlXqTwySqUxlKrjW9BmzpFM+ixXeUuABbUbnhYu/xpeB+38vxP4BkXyPrr+kArrT/VIuuyfOzL+V4/VcuGbwgJ8mZ+frhy/f74k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=igtyEauS; arc=fail smtp.client-ip=40.107.209.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="igtyEauS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I8xRAlSupCNElN0e9DomvqLQNydq77UsWVDZIQdKwC85oh0feVGq/05Z47yE53kLX1y1e7WcWHX3zRFeOZEip0vCwY0VGhjYLs8WEBQLfTgz/9C7/HCt7KsP4uNsNUJvopeIkEpIMJlEO6XqtL5JVZA6bnCS8KkHgjXs7Nsd443iurNzzccnQf0L94wa39AUJ+gVDu5tmPmluVdU1aFNz13GKWL0a4R7iC/OInNJN9/WAOBOUQsQkq7GxH5KCAAcLoAU/3TC3T9MXmP0EXIbmfrVeIVP3iZ9PdMqXVUFvS4uuZXnT7MoYaoGuUg1o5oXF7UhJYgGvRgRFui9zFoVEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gqFpwz9zKyNZPGIeIRh6+wXm14o1BuoGQbs/Iw0QgiU=;
 b=feST5TIHr7upHFUTEB9cgKsvbHBnIDq9GavnMlbafqmGEoqP5szYMKbbMDwtjgv2n5GhEh6b4bUeM20G4xxcImQAbk5znYGpWS8fwdBdDzBbcsjPsyYUqAWkcrWHmsR/gwE9uxSVjlmTdZM/GEsgaNE23VWdmJFAKrwczKZ6U+Jx6eXuwpQ8iijzgCSutAOFdu+MDShqAwUV95YqxXWWUfnxp96RQTUfMCUmqFfBvVWeJOOZw+30a31MEmu2P7V9X3IBs2C/QWZT/9QCGhJSJepilhVRIfyZ8kYd5YCFtnkZxous9K6Xmv2qHLJQfFTtiOeSGLW3Hto153ocTfJwHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gqFpwz9zKyNZPGIeIRh6+wXm14o1BuoGQbs/Iw0QgiU=;
 b=igtyEauS0wZYPavrj9NrFFY0atgbZvcUosVHnVJTo+IA34COCEgydCk16Ac/KjBLcgAOwqoMsUVWuCWy5FvxNmN6RIsukm3dxv9mWDfcNPeCd6dwb9HCsFpj4DDEXu57keY+W8UvWin2ktF+QGbx32DHos2dQj5iLdXaYb8aD9rQwCClmiOTLQ/nJ82Pfwm9rnmPn9PjgsdGAzm4q13F1OCH8BSUo6Gij44/3VzyzEJezCIuu/x1NcyLq7Lq6WJ7kKrqvlAheKUF+TzHTHwGaWRFlgXYiHe1imNfb8807x82NArMkgD2pHXjdhVrW0e/QMI2yphwV6dZU3N3lxM26Q==
Received: from CH2PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:4e::27)
 by SJ1PR12MB6028.namprd12.prod.outlook.com (2603:10b6:a03:489::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Tue, 14 Jul
 2026 18:49:45 +0000
Received: from BN3PEPF0000B36D.namprd21.prod.outlook.com
 (2603:10b6:610:4e:cafe::9b) by CH2PR02CA0017.outlook.office365.com
 (2603:10b6:610:4e::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.9 via Frontend Transport; Tue, 14
 Jul 2026 18:49:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B36D.mail.protection.outlook.com (10.167.243.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.3 via Frontend Transport; Tue, 14 Jul 2026 18:49:44 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:18 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 14 Jul
 2026 11:49:18 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 14 Jul 2026 11:49:17 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Will Deacon <will@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>, "Kevin
 Tian" <kevin.tian@intel.com>
CC: Robin Murphy <robin.murphy@arm.com>, <joro@8bytes.org>, David Woodhouse
	<dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Pranjal Shrivastava <praan@google.com>
Subject: [PATCH v4 3/6] iommufd: Iterate the cache invalidation array in the core
Date: Tue, 14 Jul 2026 11:48:49 -0700
Message-ID: <10d92026fce6d6f3e74e1d41edbd03da8bec7e3f.1784054606.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1784054606.git.nicolinc@nvidia.com>
References: <cover.1784054606.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36D:EE_|SJ1PR12MB6028:EE_
X-MS-Office365-Filtering-Correlation-Id: 771dde1b-018e-4cdb-0772-08dee1d8ac19
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|36860700016|82310400026|23010399003|18002099003|22082099003|6133799003|3023799007|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	Nn9JkyvI2e+lutPatp0OEcxIGePDQ+AUFvmHXk6cbeIYZ2UQM/T8UEFfpRupqoKJDacSA2CHw7E8n0aMpaevYyRfUjCDK8+mzxLKWPQHuifTZdWiHCMTENlW/jFwOkg+lD0BEqbahatsXlwz61qNjuaCXonTvquFN92385+5qNz3KOkMXRU0MaDLbBrPTQVoHJMcNAVmBAMNM6Ztw2BLBkLwfInllqAsph2k7loErNn5y2WhuvavZFK75G0rlEzpt9vgeBLFSUS/pkcwygZbok7NJkH30LizTjlJYKttqI3JTiQCm1vq4cU4tWQZqBSEERXvP5iNbuUVuM7EQMs/P2UZMxLJs3bwmaOKbFeNQslzQbKr8skDuPH80YB5e+OAEpZJ0EDF3HPG8n4dnPj2fSBr/QNKGrMrYFhboURgNYv+Hpif7vwE8CPaQYXJ3hmUmCxc3xK0qROlpyjofKej647awoFLrYIewrK2k0IqtSVMhKRESIG86fgh4xu8mpTsZhS2ovJ3EBPebbdB5TBQlCFIpEQ916mgvC628y3IMcjor9bZgzsulM8jcPEsJ26S8uOsMmUXj0Cdmoa+szUPUkJzVPcXvazWg8mGnlRgg4k99D4SjM6oOufej26lsN7jfufd1R8tatx+tLaCNxzLpQHg1VS2e4a2W3pE/mAfxZsrtZ9bfhFfQvbCSoi8TmTOYW0AsdQp09kSSJylCrV3rA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(36860700016)(82310400026)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OE2MK0MQf5UuVxSOrf3R0bP7oirZsWAvbdlo3OqcUObkLQJB+RTqkSMtrtBhg4m3UYnOqpDVAofonmSCSC8tTVSM8txgIgPKJUbiiO12y+SzyjDGSfDwjmWUY/xcJ4gE9nllPPXSpTkfzDxlRg5dhKCNZmEnizL7s3vSZxM3gwRIUH5dXx7/X0Hwk6+vHeORpaB6pE/YFdOhO+XoeVUb6Ef4Xw0oA9fTVYdtklIMRVqTgF9p2P0DtlA1oEjL4QK1SCq3VU7GFZQmlc+hq0eUzNE8nOeeJzP252IUL6XELft/AHdBxi8wmGGW0ZmGHXNoqTZOfMUmDjb6m6+zKiZQQSREVpcv6UCb+uGCfmC63rYqV+ibrnQic5gtN1cqfiEZ4k1dwjgXGFFQr1yvjReQS5W+ASseMAymo4ENqeLtU/tK6kFnTQW/PdxKXHt/+vQX
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 18:49:44.7875
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 771dde1b-018e-4cdb-0772-08dee1d8ac19
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36D.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6028

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
Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
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

