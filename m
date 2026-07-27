Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47FE2D6409
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159139; cv=fail; b=I7AKp3wNd++1qcqQgKA3cacRvxxuTJnjI9zpD/iHwzWxpsWodo24MRQbt2BD+6DGAF0qs7ibNa9562htgv5++/N/Wfki+ZuVLI38B2qlGAB2v4JtdXDUVKLS2Nrcp/EgfrGeWJVLyAr7NI8hHOaoWWI61h7WZ+EMNVI5/vi9ASo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159139; c=relaxed/simple;
	bh=HVcO5FF04EBTBUuWJS1o3xIzfm+DoMfNks6r8G2KUzo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=InJHS0wuobK8bQ6XK9ExyOfQGV4U+3vabhY8gG0q29/gaK6qAFe3YbtcZ4vml3gcG4hjKKqo/uQWmoLSDMgP50gLmYELZfCsW6r6PZKQ65sZSFZr/ViNjNl2cDZYzwm7+L/zdP8h86HUMSeT9C1IbgmEKfG+3jNcJ27VRwztb+0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f02MietS; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f02MietS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B6ywq1ZUo3tECPZANPNYS18HuJiJjl4M4dBdjM987BilHtOs5kMe6bmHBBAF42RMFel7DzaQaG0OCM+2jxKzuyu8pxzK2kDwGsjazUxryRG2D1HoRz2SWuDorIKCqBR8lobd9W5lTFQTxIqDoZfqTODbB87qNK44wo/QiIxWCQl6EyjdGWWPC9LbGpk9dk1HilBxKhLGI0POxEnPCkH4rilNDy2FDc9Kg9JKps8M1PLNeDBVZZtI3ekIRHrbMNlHS/q+UopwkEEO6+rG43Ms98IDwJmvrBxJDas/PqhDqmDkpD1WSHnLqmeJEV/w05yaeGz/bnI1FT5m0rEcEKkg6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SS5wVyZAxbQloyvHs1vB9b33Y5DT/uIiz7B/kZF5ns8=;
 b=EagcpbFmgyzswRz1vw84Q8jSeXzHYgDUDH5EjkjuoF3AX0maKWj6OoOzCF7cv40dV/tIOMmEWmzrFAvRtmJ3OuulkbWsC/IwnyJ6qAiqTZ0bqnjeHMn0n+c6ImdfHsZXjadmF9tqwJ+ofzVyv7DLZf/8DKdVu9Auo48gofSIsN5pMh3bQvqFgu4zWzToFbGRH5cDM6gCQjKaNZc3d5XBCohPna+F77vy+VvhjSUe92l92WUt43UkYggLrhrmlh8VDtUnlS3z4CtRY70IuO28GWqAmbSwl17YbT3IcSriJbwA7ZAec3PwEv4mUmdnaVLYnkVv0ZiZU+W3VZSKTfqBTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SS5wVyZAxbQloyvHs1vB9b33Y5DT/uIiz7B/kZF5ns8=;
 b=f02MietSHZLhe5sXv0grVPU0gtUbhF1qa8N9po/PCIyaA3+qpT1YuPWBwJ9fpoeELb34Hc/7x0c0ng9QPC9HDyrLTSaEN6MiHekhKp3jtdEXCTto/DD5XEjUTfU0BlEKqVCdMODxtH+EomtazV5e/CplMm+glBDeB0sAHSu4ggs=
Received: from PH8PR02CA0036.namprd02.prod.outlook.com (2603:10b6:510:2da::28)
 by DS0PR12MB9321.namprd12.prod.outlook.com (2603:10b6:8:1b8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:32:14 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:510:2da:cafe::9) by PH8PR02CA0036.outlook.office365.com
 (2603:10b6:510:2da::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:32:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:32:13 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:32:04 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 23/24] iommu/amd: Assign per-vIOMMU translate device ID
Date: Mon, 27 Jul 2026 13:29:12 +0000
Message-ID: <20260727132913.22475-24-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS0PR12MB9321:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c65b83d-3dba-4b5e-1096-08deebe377b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|7416014|36860700016|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	IpvC5lBdM5sGOmcAjdGc5CSq2KbfK7vl6sZJT1RTUYqdOeXyHmf9ctZFSBnkrSfcVKrKBKd4xv85A6gE18DgQVnAyHzYDq7jVsA0vc6ogGle64nQG14ef8ujCuVG2TbqmBBwkaDeIKQl7sjYFGAPgucNoi034x/mUBOX0G+c/1qCnbMOmkHuJyGwOOKWv0UoG2W/QOMWO9xNEpil1g+TyhCNVa0FpEPCJx+5pqsU7orvJ7KEQh/pGEOYY5lDtiQvADhRQo+9n0C7R4hA0NO1S5Prb+mzp+b2S09r6TAiivrE+qcq3xudAU78fmZgm1wS7qzGEp70CzFp9sHettg4P8DuaSG3HwhDNJ5iSGH82IhBm/ERXQl581aZnTjbYSw+0yLgFaixP2RDfGiFsysaof24ud7qvKru5AGK0+ab/Qw4p/8NFVqQQrk3tK9y8Ez6NoCFglocOyvRJ8iQxEvNtIVh4m7QXCfgFxzSfLi6D6qFGzDqx0etPMXDnkdeWSZAZ/mP50CXN7wwrKhm1eItUL32hg4KGTPpYvj3W2hP6nnP9IZWgnweesgNWeLrhGoi1Wx69rwqTd0LRMVH8mjX9RcGYdDch96rzhF0FuwWOKsmsg+pN1rwyV5V6t/NMpcfkPve5PHXbHTqwsUXQ71l6+nJD9vw2RdUOIZYDWzJF/JwnOzegizdN9G04DG6xdHUD155fZuAEgtm76Jza02KcQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(36860700016)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b6WwRvJIqogFrqvZf+KtLKDu1K2ibEmchINtavce0lI2XT8MrH8AVAT+9VBhnwwQaj4FEAN2ZVtKWX3KrmfzvQV1021HhxsQG0qoR36N8LLhvbeDyYV0CEHRbHAsK+OlOxv7qPaqZwurH7458q86FFvj7lTc5kcknea3qDD/eJeHuWr+Xusab93QpjUAgvtyaV28ON5F/co+icY3v2q4dtBZu6SjBjnaRwAbft+i81QTG6/YJSTkzEu/ECYdnJotMrVkwQCjM5ujNndeImfXTvJlX0NATHjqcIMDG7/ja7IrF3VQRkHWVXh46PH+Kztd+tGgoMJ4LZAsMwk/iWlVeJqYYJxVt1tr7MrKt7YeegritcJJa9aUPFcl9a6zPjktqoYVJs/J+QwsLuhe/jQIx0TJofRsinQfhYG+pYKsQtiEmhLKhiYmlEGQCtrhdYp5
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:32:13.1129
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c65b83d-3dba-4b5e-1096-08deebe377b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9321

Allocate one translate-device-id per IOMMUFD vIOMMU instance from the
per-segment pool on init.  Program translation DTE and VFctrl TransDevID
after MMIO reset; clear both on init error and destroy.

Add per-vIOMMU trans_devid_lock to serialize DTE and VFctrl updates
during teardown.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  7 ++++++
 drivers/iommu/amd/iommufd.c         | 35 +++++++++++++++++++++++++++++
 drivers/iommu/amd/viommu.c          |  2 ++
 3 files changed, 44 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index f288a7b384d0..39cf2c588106 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -559,6 +559,13 @@ struct amd_iommu_viommu {
 	u64 *domid_table;
 	u16 trans_devid;
 
+	/*
+	 * Serializes translate-device-id hardware changes (DTE, VFctrl) and
+	 * coordinates with pool relocation during PCI attach.  Lock ordering:
+	 * pci_seg->trans_devid_mutex, then trans_devid_lock.
+	 */
+	struct mutex trans_devid_lock;
+
 	/* Offset for mmap() of guest VF MMIO; set after iommufd_viommu_alloc_mmap(). */
 	unsigned long vfmmio_mmap_offset;
 };
diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
index 7e070f72f02e..43575af59bba 100644
--- a/drivers/iommu/amd/iommufd.c
+++ b/drivers/iommu/amd/iommufd.c
@@ -48,11 +48,15 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 	int ret;
 	phys_addr_t page_base;
 	unsigned long flags;
+	u16 trans_devid;
+	bool trans_devid_allocated = false;
+	bool trans_dte_set = false;
 	struct iommu_viommu_amd data = {};
 	struct protection_domain *pdom = to_pdomain(parent);
 	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
+	mutex_init(&aviommu->trans_devid_lock);
 	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
 	aviommu->parent = pdom;
 
@@ -81,9 +85,22 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	data.out_vfmmio_mmap_offset = aviommu->vfmmio_mmap_offset;
 
+	ret = amd_iommu_trans_devid_alloc(iommu->pci_seg, aviommu);
+	if (ret < 0)
+		goto err_trans_devid;
+	trans_devid = ret;
+	trans_devid_allocated = true;
+	aviommu->trans_devid = trans_devid;
+
 	/* Reset vIOMMU MMIOs to initialize the vIOMMU */
 	iommu_reset_vmmio(iommu, aviommu->gid);
 
+	ret = amd_iommu_set_translate_dte(viommu);
+	if (ret)
+		goto err_init;
+	trans_dte_set = true;
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, trans_devid);
+
 	ret = amd_viommu_init_one(iommu, aviommu);
 	if (ret)
 		goto err_init;
@@ -102,6 +119,18 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
 
 	return 0;
 err_init:
+	if (trans_dte_set) {
+		mutex_lock(&aviommu->trans_devid_lock);
+		amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+		amd_iommu_clear_translate_dte(iommu, trans_devid);
+		mutex_unlock(&aviommu->trans_devid_lock);
+	}
+	if (trans_devid_allocated) {
+		mutex_lock(&aviommu->trans_devid_lock);
+		amd_iommu_trans_devid_free(iommu->pci_seg, trans_devid, aviommu);
+		mutex_unlock(&aviommu->trans_devid_lock);
+	}
+err_trans_devid:
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 err_mmap:
 	amd_iommu_gid_free(iommu, aviommu->gid);
@@ -124,6 +153,12 @@ static void amd_iommufd_viommu_destroy(struct iommufd_viommu *viommu)
 	xa_destroy(&aviommu->gdomid_array);
 	iommufd_viommu_destroy_mmap(&aviommu->core, aviommu->vfmmio_mmap_offset);
 	amd_viommu_uninit_one(iommu, aviommu);
+
+	mutex_lock(&aviommu->trans_devid_lock);
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
+	amd_iommu_clear_translate_dte(iommu, aviommu->trans_devid);
+	amd_iommu_trans_devid_free(iommu->pci_seg, aviommu->trans_devid, aviommu);
+	mutex_unlock(&aviommu->trans_devid_lock);
 	amd_iommu_gid_free(iommu, aviommu->gid);
 }
 
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index eb3f5217d856..ae4a6a2cae39 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -501,6 +501,8 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, 0);
 	viommu_clear_mapping(iommu, aviommu);
 }
 
-- 
2.34.1

