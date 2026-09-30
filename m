Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010024.outbound.protection.outlook.com [52.101.193.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609A948032F
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760402; cv=fail; b=C/N+mvZqM2HDKYio+3KE0nd/OroquCSZMNP77lx7381sTB1jVfL/fsx0pPLyGmsgoyDPuzRmPeU9QRFMijXpgJO+V5dGrRhRD9biD83lN3oYS1Hp6ybLc08B90AlmoXDNxIqMhPTBsji/0XUK6zJ4uZKrAK3ZXukjaSgRaiLlg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760402; c=relaxed/simple;
	bh=AThx7zBKZ7gI1xTJxu7w3010njRM3k3N7wKRrfeTONI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWyALGEK3YWIO9mwSPSIU8k1dWFlGsp+cBO9czdQJbyqT43TBWb7uDDRYcETN8WeJtKXjIV7f7MTK5Uo/fATcETaRRhNBhG/QK9H4bdZQ8lrs+sglJecpJyjw4xMCiXZQhjvlMMF0gkHPA5AXATK5BSqwJhveAi7IH/yOP3AH6g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kLvm0k2a; arc=fail smtp.client-ip=52.101.193.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kLvm0k2a"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pk8SymqJbpfyW5Edj8xABgH3GQkNPmXPb8s4AF3kcVucRodDNK8L2g56hM1r868Bpkee77UImoz85mM/kHWg6HQJrqE0XQ8Wh+0wAP3YFbaHVzhN5PEIlTOeSAck8Aj1zgXLoMpJJWZgj+Odm0KZ9pHU1nuTQ5HjGqXotOq9zzZn7jK268g82mGc64lkQ3wOtP/nfKpMBFVYT7UbTl0QE/qRersU6/x0i+ldki0BvnUlGk6f29kC9zxiyovnAfAarjBdyfIhyPlicNFhcthwS6GgNMc5m1RzNpFLvx/Q8ZC8yZfCBB4/IMOZMDplp3/muxmEWCuAgu//knnmx8X3NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OxgioBZBbXlMCDlc9MPiDu9hX/JreWrnVBgoBtuuN1A=;
 b=sJhg9jZvZFjNK7dQWt7QHLg9Qv4tII/ObBDwh9Tm06ArBnd3o1YjVIyBfGrRG8yJAhLquN3OF3tRm/o+/TAureefGQZe8Q/kKp62n6F6HUpXOMxIrcO+lwV7HxmxP6oRdJiMWqPw0tWnFMSkM86ICPdcugT7R3hJ2F5+u3/mCfz4/qq8rvA10lrgLMc+eSlHeCBOe5P7lEZECrSMX5npPX4OF2TpwH/1y1A7eLij+cEeGGhzDD3hlzlzVqjfM3vERTgft0Ovd76xhLHiuEMdQoRpu5THagn9guzwZ3yZgg2Jk+RGyWD7CqtvJv7H1yFkMb6ZKllUUc2IFpIHkWtjYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OxgioBZBbXlMCDlc9MPiDu9hX/JreWrnVBgoBtuuN1A=;
 b=kLvm0k2a8ZMp/M+mUXhcpXe7IEiWZOH3FX+bDqjgdDbm41WMrBGFK1PuLHafNAEkjYjPYcPOBcRyOWR1jtRKFU+vOdwTSQhIoFQjg6dSaEFjthbdvTMBHz/G1ZdQrqsjWqvLrO9lQaprpM83CbIQ5Z9+s0XVDSdB9zMg2pm315Y=
Received: from CY5PR15CA0177.namprd15.prod.outlook.com (2603:10b6:930:81::23)
 by PH7PR12MB9222.namprd12.prod.outlook.com (2603:10b6:510:2ef::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 30 Sep
 2026 09:26:30 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:930:81:cafe::a8) by CY5PR15CA0177.outlook.office365.com
 (2603:10b6:930:81::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:26:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:26:29 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:26:17 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <Ming.Shu@amd.com>,
	<SooJin.Tan@amd.com>, <chrisl@kernel.org>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>,
	<guanghuifeng@linux.alibaba.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v6 23/24] iommu/amd: Assign per-vIOMMU translate device ID
Date: Wed, 30 Sep 2026 09:23:43 +0000
Message-ID: <20260930092344.5616-24-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|PH7PR12MB9222:EE_
X-MS-Office365-Filtering-Correlation-Id: 13484e30-2273-4192-fcd4-08df1ed4e8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|23010399003|7416014|376014|36860700016|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	orCdLhDAbXd5EDW8C3tUbE/KRPx3VIhw6M3Dk2k52eJQWY6fZPERkJZl8kGlDWNeHVgj18amHDSbmoFDGxkRvXEQetO64rON0ov3v/6B/xvIo6fEDVMZhN82zhUDthZXpzdn+al+8DUyZEOlA5BlV+roh01HkNxb4iQzsEv/K+X5QXqsn5dIiH6vQ7SeUqiRDpffbWTiGj1yJN3V3R+jDwzwK0tk1DZiNkMZVKannfMZeKFNVYN9/tJCL+6w8OB8Hv3B74lYpDgoyowjroblBinrW0luUukz9kFor9hl7nFHzT5c6DiXE7Nfn8CgHH4ojAXDr5SXquSwaRknfer4hRvwSG7Ab4u332odeUC3ERLeVxfisf7HfzwtaUTsexCHtGVdZV6bkJhmghKP7zWAL1YCHLaHhQ4JFlYY5UczWAS2cOTd3FVcu1awrbDAWIfVXkKMX/j1/2jaiHAessUz0wGa772HQpxhI9ATE5OF6R3Uqi1TNqmRbN/bKkir3roFmANWiia4V73pcy0fJnHENk5u/v0XZYnd/PVI+RbXeq0S0+oOp2kYbm9KnX29PfWBWd4E62kwhxWbF2rjPLN7aFpdFGZ3kU/Ct1i+hOTCSXEJX+rhZxxl4+Pdi/PgaJNVgcThGAbZQGDlpi6NYUbDnI5z6gKYnM3iR7+2ifJPe0wkmKLyZq5+cw5fJ+pnLaGnlGVT3RgdHjRQwVosU0RGYQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(23010399003)(7416014)(376014)(36860700016)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	M8th19S22xMSyO0h9Bw/etfiFxsFd68z2MOO9BS4nUiRQS1YsEN36YWMZKPmjitiuFAFcklYL//1TmWYlFnujJ3LSNH8OnDn8F9nbsTpT0FVG/EBEJjbEsPzx5b/FiWbpet97y4qLQEWgeF2YV/uc8qLpP98PF0hSYs1ohvO78/P7kjVaBIqd23MkwvO/ytnIwlRlkdk2wkZW6uxMVrXKE7FRK9nUqfA7ATUmb74EvRlWB5x3FdLEeL/Z17fvH9xLhWuBW5IGrCL908J+vaXcYM8BHaoppeIJOkQAmj7zeaV6ypTmQSQBKTaB9VUPrsYZOXmXP4kYoeuPDrXs9RpWlS4gpQFEN2i548ecq80l+Jz062wZv+uJDBjM8461t/kpxUmYu3gdh29bsuuAjP3DgXiD2EYa6/oh2gpUMMGgAv749ZOGA1BUVcye8xwU1b4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:26:29.7982
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 13484e30-2273-4192-fcd4-08df1ed4e8d8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9222

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

Destroy trans_devid_lock on init error and on vIOMMU destroy, after
the last unlock, the same way as vfctrl_lock.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h | 10 +++++
 drivers/iommu/amd/iommufd.c         | 68 +++++++++++++++++++++++++----
 2 files changed, 69 insertions(+), 9 deletions(-)

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
index 5760b183ce62..1f7485131e63 100644
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
 
@@ -93,35 +98,68 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
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
 err_gid:
+	mutex_destroy(&aviommu->trans_devid_lock);
 	mutex_destroy(&aviommu->vfctrl_lock);
 	return ret;
 }
@@ -140,8 +178,20 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
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
+	mutex_destroy(&aviommu->trans_devid_lock);
 	mutex_destroy(&aviommu->vfctrl_lock);
 }
 
-- 
2.34.1

