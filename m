Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013022.outbound.protection.outlook.com [40.107.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23923939B1
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411851; cv=fail; b=J1qhxxPxeVCwzWrdVC1N+mCq5MQrb9jfpXVnvVFkDZktIWBYKTgqqGBmt38uNCgVXBLwgN2Y2pd+hE3qYi76V+LDNdwF5TqJ0oLG64KzcWImgpm9I2YIgid7F1L3nwJBNICLMDRL6p8ABwP5woH18pJOVRIGVl1f0u87d1F5TzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411851; c=relaxed/simple;
	bh=8jvnwGKNV/p61VH/lHZgouWmrbjCSF4zNn84dnkqthA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mPYksTW9kaWZuRXSHx849YKZDUsQbrbotyQ5Jibg0MSo8w/GPeZ7vmlgoZkaqo64YAg64pgyVui9T0UFYP/TdBYnJOFep7M2HjNNNCrICewhvnyMlBEOUkKLBd3xhu7M/27KniANlTJjsaI1Zb9GwnQe8EnON2XERKl/LlfUxLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=EZOzAy9J; arc=fail smtp.client-ip=40.107.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="EZOzAy9J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dKQHr5VxcqHw8QMFDEwTE9+7YGKCBAbhBvbU9AP4JRd9nDKBpnraasi0noS3VDmWwxCZYDb8Hi49+oygLRqPtplp/SYWu4GyUaG2v9niXCoGpUsf8pvnCi/adtbXd0s7b5oQ4kGMmEwFojFhYyjgience94UCeycBxrAcpq6Z7g89iplxvl6cKA3Ql7/+LGZ38fSLTwRolPd/k5e4TKABLSOP5HakzFZXfvFVvj6wE4vDTYrDxjGmzUS4O/nom2nWFHuaHnTfKCjuBPR32EcHpZ+nIWkqRo/aNTBl+kfm4aZ3wQMszRbgNz4rQkhqdVmk33rJ2FW8AxjcdU2tiub4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pT7W8fmC5m+hdfdp26XkogyNVJdAqy1HdRuoB0WIrhI=;
 b=wK1TvjqzV7903pUtdOtuzyzlZOpFJYFWzYjZ7Hr2DNlWt3egpVda+3JYKSJTE5pfYicQ8Ci4iRvxq/X8eZmb5EAKibmY9CSlpNeGtOjODkPbHnHjcinRXb0Pbu3RnaBDKQ7j70QPUryxDeEauJcqENhKCPaeelIQUO6PDN0FWj7YHOUcocY+mv6CFlXJIvv5fVB0kagzkHVFuUs01RJlxZHX7BshanGk0fw9ydMTv/yt4sF/rStTEShPy1fB70DuEmDJtVP8j1dvzoFBDxdoAMIM2JOP15dZD+49mwt9ZfLsOnqfOOJi1xDZfyaN/oK8mVQqNxvRFiHirZu167FOkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pT7W8fmC5m+hdfdp26XkogyNVJdAqy1HdRuoB0WIrhI=;
 b=EZOzAy9JI+1LRgbRB5vsoe4rstE8hhlcq2GmzPy+ETsdSUCl/2PxBmwONYzwxLYiX02Z/26s608EcyqRJ596c04IXIYY+/byHEkpZ1bDzkK0/+8IPGKkTX+V8uU+Yq0221MNyvgPdSVIFSORGRkBZV7U4aEd+0gp2HYuKdNptfY=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:50:36 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:408:130:cafe::9b) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:50:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:50:36 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:50:29 -0500
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
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v5 23/24] iommu/amd: Assign per-vIOMMU translate device ID
Date: Mon, 14 Sep 2026 18:47:49 +0000
Message-ID: <20260914184750.222939-24-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: e29994ac-114c-4df1-5115-08df12911030
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|82310400026|376014|36860700016|22082099003|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	gCf0AJl9oxw++FrkNO+J+EtQF6UFtE6+PwrjoHNNX0jLwXhK4g8VbPUG9Pwkq1LfkpMLcC8HK2ch9xUhWZgn44CQFNfriwxu3PdiwI450NdJ1s7jL3ZK9nqDFhdSTwmsibiXRsAq1l5QYjSwh5p90442wqVSdpS+sdlMcQDeLhMvFV7hqo39nDYiQcJN+WKyPE9zpCKKYF6ZEhHZhdkJCfLEVm4EBlBLLml9d7EPVBGiqQUbRti8Jtj/LtQDtLRcgbNNwDHYD8BPaFk0s5VjolMVA7Fl2VX5oqA0fagnZo10EIYK3by5JSREIV32Ay/hChZ5m48wAP8QWTjwyVlgtP3UkWoh/mQ8a5gHwJw4CZaEoh50Nvma4B7ia52y/+GNpS61In0EmFIze4rNTVfW2m0l8ukCZce2tgf7vBws8EGFDroblcljkrzX53NnbLIqEetDrJwUlJYyiw0VLIsnTlkRxsdet2x78D3/XpKLoaJZgmWksPByw2SQuPIlfNcmey/xrAjn6pe1wy59DQCfMFJGahx3qottUkYHmGzDNyQPgjkT2d89HyqcQ+6coHrb7vHexkXH/59YwUA5SQed4XIFuOknu//ZFPwD2P5hYBMa3nY+33gOc47wa6lgGsRdwD1S0pWj3YnY8eE0fVrmSVAzqjlyOunCYVxLnWUpcf89o1NIsY9aRK8JUJT1bH/7/3bofEKaHLi/0PLRlaCOyg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OCWJcd/F0d4h9wYiDQ/O+G65uQzEboobR1MxPul55fH7dMh6K4Sp764L/py12qYsXXjQVKvJ0bsaakkcNfhFArlmUjekdrZwfcI/uyqdWWvDxdqO8/bT02NHuNXMh7IMZV/8PkuQBHFxd/ecsU/C2P5gpYexZPg7IIO3OzHCxvPhcnTZHmPhrhllNI0Fmke3voVDVi+lIZuWXvfvY7IzduUrRkxjyin6b7z7Sn4FcU4n23d/z2SFoRbyOsrxE4i0n/3b83jwtkmxWoakwS5ml5SKezmk7/YTccN9j6LovTgosGGFrifbwpjuoyBusVcXrd8vAZYESFoBxvwcu/hxAnd0RYSQ/t7cuV5gN4EgA8BS2B6UTLP67SMVn1VPspLWW21WDkUxfSB3gu4eaRmapvjnKny9duGLO8ArKULGKFOwGv7FpLm4tWI4nfQEYNJi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:50:36.0635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e29994ac-114c-4df1-5115-08df12911030
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

Allocate one translate-device-id per IOMMUFD vIOMMU instance from the
per-segment pool on init.  Reset MMIO first, then program translation
DTE and VFctrl TransDevID under trans_devid_lock so PCI-probe relocate
cannot interleave.  Clear both on init error and destroy, and drop the
id before amd_viommu_uninit_one().

Initialize pdom_list before set_translate_dte() so list_empty() is
valid. Drop the late list_add; set_translate_dte() already publishes
the vIOMMU on viommu_list under pdom->lock. list_del_init() on init
error if that add ran.

Free the synthetic translate-device-id DTE object on init error and
destroy; it is not stored in the per-segment xarray.

Add per-vIOMMU trans_devid_lock to serialize DTE and VFctrl TransDevID
updates on init and teardown.  VFctrl TransDevID is not written from
amd_viommu_uninit_one().

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 10 +++++
 drivers/iommu/amd/iommufd.c         | 66 +++++++++++++++++++++++++----
 2 files changed, 67 insertions(+), 9 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 5f84f25e3f37..c748bab27509 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -556,6 +556,16 @@ struct amd_iommu_viommu {
 	/* Synthetic DTE; not stored in pci_seg->dev_data_xa */
 	struct iommu_dev_data *trans_dev_data;
 
+	/*
+	 * Serializes this vIOMMU's translation DTE and VFctrl TransDevID
+	 * updates on init and teardown. VFctrl TransDevID is not written
+	 * from amd_viommu_uninit_one().
+	 *
+	 * Nested lock order: trans_devid_lock, then
+	 * pci_seg->trans_devid_mutex.
+	 */
+	struct mutex trans_devid_lock;
+
 	/*
 	 * Serializes VFCTRL Guest DID map CONTROL0/CONTROL1 doorbells
 	 * (DevID and DomID table updates) for this gid. Those registers
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 5760b183ce62..1c29d846beed 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -53,6 +53,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	int ret;
 	unsigned long flags;
 	phys_addr_t page_base;
+	bool trans_devid_allocated = false;
+	bool trans_dte_set = false;
+	bool uninit_on_err = false;
 	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
@@ -70,7 +73,9 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	if (ret)
 		return ret;
 
+	mutex_init(&aviommu->trans_devid_lock);
 	mutex_init(&aviommu->vfctrl_lock);
+	INIT_LIST_HEAD(&aviommu->pdom_list);
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
@@ -93,31 +98,63 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
 
-	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
+	/* Reset vIOMMU MMIOs before the trans_devid is visible in the pool. */
 	ret = amd_iommu_reset_vmmio(iommu, aviommu->gid);
 	if (ret)
-		goto err_init;
+		goto err_trans_devid;
+
+	mutex_lock(&aviommu->trans_devid_lock);
+	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg, aviommu);
+	if (ret < 0) {
+		mutex_unlock(&aviommu->trans_devid_lock);
+		goto err_trans_devid;
+	}
+	trans_devid_allocated = true;
+	aviommu->trans_devid = ret;
+
+	ret = amd_iommu_set_translate_dte(viommu);
+	if (ret)
+		goto err_init_unlock;
+	trans_dte_set = true;
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid,
+						     aviommu->trans_devid);
+	mutex_unlock(&aviommu->trans_devid_lock);
 
 	ret = amd_viommu_init_one(iommu, aviommu);
 	if (ret)
 		goto err_init;
+	uninit_on_err = true;
 
 	ret = iommu_copy_struct_to_user(user_data, &data,
 					IOMMU_VIOMMU_TYPE_AMD,
 					out_vfmmio_mmap_offset);
 	if (ret)
-		goto err_init_one;
+		goto err_init;
 
 	viommu->ops = &amd_viommu_ops;
 
-	spin_lock_irqsave(&pdom->lock, flags);
-	list_add(&aviommu->pdom_list, &pdom->viommu_list);
-	spin_unlock_irqrestore(&pdom->lock, flags);
-
 	return 0;
-err_init_one:
-	amd_viommu_uninit_one(iommu, aviommu);
 err_init:
+	mutex_lock(&aviommu->trans_devid_lock);
+err_init_unlock:
+	if (trans_dte_set) {
+		spin_lock_irqsave(&pdom->lock, flags);
+		if (!list_empty(&aviommu->pdom_list))
+			list_del_init(&aviommu->pdom_list);
+		spin_unlock_irqrestore(&pdom->lock, flags);
+		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+		amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
+					      aviommu->trans_devid);
+		amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
+		aviommu->trans_dev_data = NULL;
+	}
+	if (trans_devid_allocated)
+		amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
+					   aviommu);
+	mutex_unlock(&aviommu->trans_devid_lock);
+	if (uninit_on_err)
+		amd_viommu_uninit_one(iommu, aviommu);
+err_trans_devid:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
@@ -140,6 +177,17 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	spin_unlock_irqrestore(&pdom->lock, flags);
 	xa_destroy(&aviommu->gdomid_array);
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
+
+	mutex_lock(&aviommu->trans_devid_lock);
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+	amd_iommu_clear_translate_dte(iommu, aviommu->trans_dev_data,
+				      aviommu->trans_devid);
+	amd_iommu_free_dev_data(iommu, aviommu->trans_dev_data);
+	aviommu->trans_dev_data = NULL;
+	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid,
+				   aviommu);
+	mutex_unlock(&aviommu->trans_devid_lock);
+
 	amd_viommu_uninit_one(iommu, aviommu);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 	mutex_destroy(&aviommu->vfctrl_lock);
-- 
2.34.1

