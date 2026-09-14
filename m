Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012015.outbound.protection.outlook.com [52.101.53.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA74738E8B1
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411750; cv=fail; b=ZmSODTiiglX07PMNLn9mD7GfConT+eDOBn8aPgMwg7p4ywgRfJn/ohivf3Mr5vbL2NF0iKy2iZnqK5PqOY6HzN9YFAMDvxQ3lIHBNk61WucQXm+pv7VedvlIuucmPsgj+nlX1S9bRTs2cNjcNN5ZL93Iz3+2zyj4Kmf5fnupmBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411750; c=relaxed/simple;
	bh=N+i0zLYYDNQtrz7JB9yYzCOp+nUlxxehdaKL5iOadxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GT/OlOwWh3W0PJtQhUx+jXJfvy9E131wILyj3nEHlP/UnoRG3kC8uLIrgsR+wMNNslg1NxguXbJkHPRJK//3XpPmN7BRZRpyoglBQTgbQvVoYRM3d/yf8BHGXKU74a/f/1ZLid2Gs35azs9gywPgfsoJhCVHMcM1oXWoP0qB0Nk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WNRxbM76; arc=fail smtp.client-ip=52.101.53.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WNRxbM76"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nE/zqg3zp9TWeME0qCElxWrcNq7WqhE44zrIv4x7p5CITPV77DzDQVNxhv27UOvViP8XyZQrkXoEMZpNe8dP9s1zHfgWzvqwI3dyaN4+se8fW7sw7VjxxicDliFrmU61FyP7gKkzrTSdrG6p5rglbuds4giU4OstCawMdcw9TWpfKHCSxUjVDhkIlGbxLg2b1LfiwdsABgN13s4rnm4OZLGm/ADMGNp9d6y70iDn784t+G9GRJD/95O00mfQpOiTpSsYXK6xCjWYIufCETq/Tp+YGfi7Ki4nPo/D6jtvJuG3gDOGF6AsOlMWneiZquTmeYmDFpMcLAb3ibW9HIe0ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tESWOykCYz+cJPGfENWWIo6x48UBaI74NZ9GWATTCpg=;
 b=nxw5Xxu+m0rL64JpH3cgOcYkd/LMS9j+D1NCz9dzeW/BGJn43Y/Viy4LR1n/iVJZnmxjMahilVrVh6s7pJ9uS4shChg1cNBkFgvoojodoPSRnl0sLxCZaisDCyNrhxepX7GsPKld+YocPH0naGVgoIyC0e1Q2qHZxumEMqpP5/PFeNfbZQnlWcXqZ3w3umT+piE8w2psWDQWdIUi06gyYhhEUQPmjRZvXhLDeeTPHK3hexVIsaOSWhQg4SqXk33QubbvlPRjzIexWZDQbKs00dnB04O73MpmXFnM9EMuhGptzBJFWkYlf0Fus6yPcBuryzHhmkgpHTiJGuNy6XHb5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tESWOykCYz+cJPGfENWWIo6x48UBaI74NZ9GWATTCpg=;
 b=WNRxbM76OwPCKC1VZyeOcAQH22Jqov4xfD93/xAbSbPclVYQCxHXt4oKnI3tykpJ+6ck47xN6CNHFxYJ0LHVlhPCnJQo1z4bRmewYT6BO3mUDJNkUKUMHNcOHCGadz+7B5BMaF4CmBTtOZ01pXWWQYF/1zO4ju4QZJnrDQZbL34=
Received: from CH0PR03CA0450.namprd03.prod.outlook.com (2603:10b6:610:10e::28)
 by PH6PR12MB354726.namprd12.prod.outlook.com (2603:10b6:510:3f7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:48:59 +0000
Received: from BL02EPF00021F6C.namprd02.prod.outlook.com
 (2603:10b6:610:10e:cafe::81) by CH0PR03CA0450.outlook.office365.com
 (2603:10b6:610:10e::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6C.mail.protection.outlook.com (10.167.249.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:48:59 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:48:52 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Vasant Hegde <Vasant.Hegde@amd.com>
Subject: [PATCH v5 07/24] iommu/amd: Add support for AMD vIOMMU VF MMIO region
Date: Mon, 14 Sep 2026 18:47:33 +0000
Message-ID: <20260914184750.222939-8-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6C:EE_|PH6PR12MB354726:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cde5812-e459-4269-ac13-08df1290d669
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|23010399003|36860700016|18002099003|22082099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	JJ+TQSbggjo1L7RdKMj6atNSJAZa/xgAc8ZL7BYrVIlFXWEG5LIBaqVpfMBjwTyF7YFMH/P0ycbiuv7mhbgSyfKok8C6oS1VdsGvttHeZKRiJChC4Ndy9xFrl9ZiVEtRVhSjDJ+DOMyCcF8BTaTjtdFPajjVqpoHndQU2HAlUabPPoIpoiHuejASY/rM/kOvKVv+IMgYTSIh10lv9Y5iwg0wSzJSfBiHcnC4yVF1b8IIpf3YQ14W1DjdyQ0y5WWFPao8AK1swy3sb85rCxQRmHBM/RgjfNdIUGtihzfwkGkVtjwjLq6S6uXRtMTBfp8UAY0KkG9ZGRrXSK4d5Zgc/jJWqg7Jq6ogcU+5HJFrVB5HBH/ERv6ZvXha8VtC2IwiI5q93J98Iazxt6S6wkx+dCeBtJFwypbajULrHVPqUIxgbnPUlsH9Oo26b4NbjSftJKBLwbYkjQ7i7aqaBO1iJ2vuML3FbN8BUrowQtOrqd5U141g1wPwGv6qX44FrmAGcIv5St0s8rJFjTMDSQHYEoqVPr6M2oL/u89MYOJA07c0k9zaMR2ym5p2AhUo+UIfJ51dx//GL18eiSbnJGRKQlLxM4ORG9ynuPp6UaFBylWds9qekWt3Wh3SOyzAbbIBqmyb4B0JVLk/+kcTzY9DkSU6NjZMoR1g+lZavrFmguoNbzPcCSsBns3JMvoP7rbwQsy1LFBgxcjKdgqUXJFwcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	twCJDdOfTkHVJZue9HPXHHNu6ywfTzKGTNn+DHRmQBiCxFQ4Po9qBkRHmwV4oQ1EpH+LesMKGNIkoTx18Kr+8CwuN2c/RTtFuPhlSgbwiG8huN3fedQjUgAQPCxjEfAq/IMtv5hnL9ACSRltS5xG8FhC0K2hxmN/iDBwkFAgLBxJHgSGwpC3w1EKsfUQU/v3xXzh5dthzcWMw6AOA+tmS2btqEc7YxtJs+s2yu8ArH104jH/EV4Bj07JqihWe12lab+uFFvGecm4HA4k/nUw2oRWN01kSfA/eZKVIWXVDCXSqLphUrgytSgqITR7fdZ94KrozTAy361e7+Xdm7soVphWtQ6k2brUqh0R2o+r0G4AfvTR8m991QyasqHN8OgrFC8uI+KIif2SobqeJhsfZ8c7iGoMQQFJo7AX7KWrEP/tbcSJRha0IqCULTccqabM
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:48:59.1282
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cde5812-e459-4269-ac13-08df1290d669
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH6PR12MB354726

The AMD vIOMMU virtualizes guest MMIO registers at the 3rd 4K region.
This is achieved using the iommufd_viommu_alloc_mmap().

Copy struct iommu_viommu_amd from and to userspace so the VF-MMIO
mmap offset is validated and returned on vIOMMU alloc.

Return -EINVAL if the VF-MMIO page_base is zero so mmap is not
registered at physical address 0.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Co-developed-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Vasant Hegde <Vasant.Hegde@amd.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 +++
 drivers/iommu/amd/amd_viommu.h      |  7 +++++
 drivers/iommu/amd/iommufd.c         | 41 ++++++++++++++++++++++++++++-
 drivers/iommu/amd/viommu.c          | 12 +++++++++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index c2257d48e222..3aaaf69a1e7d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -532,6 +532,9 @@ struct amd_iommu_viommu {
 	 * Indexed by guest domain ID.
 	 */
 	struct xarray gdomid_array;
+
+	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
+	unsigned long vfmmio_mmap_offset;
 };
 
 /*
diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index e5fbea666e01..276f2126290f 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -14,6 +14,8 @@ int amd_viommu_init(struct amd_iommu *iommu);
 
 void __init amd_viommu_uninit(struct amd_iommu *iommu);
 
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid);
+
 #else
 
 /*
@@ -30,6 +32,11 @@ static inline void amd_viommu_uninit(struct amd_iommu *iommu)
 {
 }
 
+static inline u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	return 0;
+}
+
 #endif /* CONFIG_AMD_IOMMU_IOMMUFD */
 
 #endif /* AMD_VIOMMU_H */
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 69a0e61bf83d..7f358e57efde 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -7,6 +7,7 @@
 
 #include "iommufd.h"
 #include "amd_iommu.h"
+#include "amd_viommu.h"
 #include "amd_iommu_types.h"
 
 static const struct iommufd_viommu_ops amd_viommu_ops;
@@ -51,6 +52,8 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 {
 	int ret;
 	unsigned long flags;
+	phys_addr_t page_base;
+	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
@@ -58,14 +61,43 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (!amd_iommu_viommu_enabled(iommu))
 		return -EOPNOTSUPP;
 
+	if (!user_data)
+		return -EINVAL;
+
+	ret = iommu_copy_struct_from_user(&data, user_data,
+					  IOMMU_VIOMMU_TYPE_AMD,
+					  out_vfmmio_mmap_offset);
+	if (ret)
+		return ret;
+
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
 	ret = amd_iommu_gid_alloc(iommu);
 	if (ret < 0)
-		return ret;
+		goto err_gid;
 	aviommu->gid = ret;
 
+	page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
+	if (!page_base) {
+		ret = -EINVAL;
+		goto err_mmap;
+	}
+
+	ret = iommufd_viommu_alloc_mmap(&aviommu->core,
+					page_base, SZ_4K,
+					&aviommu->vfmmio_mmap_offset);
+	if (ret)
+		goto err_mmap;
+
+	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
+
+	ret = iommu_copy_struct_to_user(user_data, &data,
+					IOMMU_VIOMMU_TYPE_AMD,
+					out_vfmmio_mmap_offset);
+	if (ret)
+		goto err_init;
+
 	viommu->ops = &amd_viommu_ops;
 
 	spin_lock_irqsave(&pdom->lock, flags);
@@ -73,6 +105,12 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	spin_unlock_irqrestore(&pdom->lock, flags);
 
 	return 0;
+err_init:
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+err_mmap:
+	amd_iommu_gid_free(iommu, aviommu->gid);
+err_gid:
+	return ret;
 }
 
 static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
@@ -88,6 +126,7 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	list_del(&aviommu->pdom_list);
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
+	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 7e6c4412ff20..c9207ed47fb6 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -110,6 +110,18 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
 	return -ENOMEM;
 }
 
+/*
+ * Returns VF MMIO BAR offset for the given guest ID which will be
+ * mapped to guest vIOMMU 3rd 4K MMIO address
+ */
+u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
+{
+	if (WARN_ON(!iommu->vf_base_phys || gid > VIOMMU_MAX_GID))
+		return 0;
+
+	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
+}
+
 int __init amd_viommu_init(struct amd_iommu *iommu)
 {
 	int ret;
-- 
2.34.1

