Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011019.outbound.protection.outlook.com [52.101.52.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B8741A545
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159146; cv=fail; b=H8V/sTM7tr04mEJbM1wxrkfLrd9P2Z4jX3jFu4JRx/JpG1S4tiwWJoy2pIXoLvDDb3z1RP1uwK99e+7JTTZHtmJLNS/2YKQnkoVDFG880i3eA+tMC8VluerBCiu3d6CuNlIA/o5MGSgaH9vf+n1JBTAWPMBMxf90vM1vsj2ZYMQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159146; c=relaxed/simple;
	bh=5L9OebVLjA0eoRNkxlTE44ZaFoduR0RahNEvV39zatc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H1E9lS/Nf+tFSLbjdp9xBDyufiujiU6uszNVP2HxQV2QTA3Ebxdf3LUwxLUC4DGN2E7GNYKniQf5CcKQhS/eQ/n5jROE20CoO+Pvfe9EdqPNszG2+wSe0XqmitC3Lgs9VHU1jiCRjqHFfQIaQlgiu9VrBToFoJeJNG0RhdNYEDs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=gIyWzA83; arc=fail smtp.client-ip=52.101.52.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="gIyWzA83"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ur9meqC6hra1J1uIfpSIqnucBRK9ydZgJSR5vwRTFykR2STqT/tyPCQXBE0DDYgy9j6sNi+Fso/2wnbzU0cSJayaymVQ+gBVwvk9oXqEL+K5S4zz90L99nc+gqhwp5pQ9GQ0fWY9gxG9ReTIv//POmYYi5Iev8jRY+YA/L+fy76mAskMggFxvcTEqNG0/bAbVC3ZLRVCE3sFmsiWJAxOjYCm3mu353LYNU0+r3W2vMdHwKCYAUXK/j7zwSn1EdTWRgVLES716OKVMEZj45km5Nbmp5stuKEkI+1r+SOB8vi6r3v8gNM1g6iHkGeJpNI1CeTWcSlu/+nWpnPUzp+xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P+c4sOqgxWO2kPvoRWharVX+lmUaCOi/yVIGDTPj1Lw=;
 b=W+aU+cxybzh1WqL7WjXScY3ph5m2C6E2VlMk8ZTXABHbe0t3QzoaGgAgciKgnqg8O5TXwdE825g9NeyYUYNFLhSQrJYh0dF3ILSb7OgmxMLS66mL9tbnLVuxkVSzXKnPwtYiDo+gESRXgGVue0zraYicyObOJDvC4c8qQpQj9/FDsqvI9c9WK5v76X/eXPp8pJhSC6QSja5/Ao640y45RfQyqnI53VALieBAxPVVdHpiGZ8jZKdiDLhJ1FAJaTPK7Dzj9GVyYpgFr1B1dpWGpvLUDEJ1qTJDnnhMqKA5iC67A9IQ56VWEvoPe0mVXDBtGq69562I6ExloRzwcLyGWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P+c4sOqgxWO2kPvoRWharVX+lmUaCOi/yVIGDTPj1Lw=;
 b=gIyWzA83eohtpCZEKukCcrw4G3KPGUHxZZ9cPj2521ejnHKXolxIr9uny6zJO6SjXeiwc6El/f9jmiPGdsu8fdeSMTUe4mMRLJI6fpkgQt7fgTx66vpdFsNCnPnHnHO/3yxlMc7Nag4KxkA0SmYZMpeyLZVMn2vhbJf91ku3Hqk=
Received: from SA1P222CA0176.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::12)
 by CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:32:18 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::90) by SA1P222CA0176.outlook.office365.com
 (2603:10b6:806:3c4::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:32:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:32:17 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:32:10 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 24/24] iommu/amd: Relocate vIOMMU translate-device-id on PCI reserve
Date: Mon, 27 Jul 2026 13:29:13 +0000
Message-ID: <20260727132913.22475-25-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ae5c88f-0fea-42df-5919-08deebe37a98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|7416014|1800799024|36860700016|10067099003|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	IbBHizV65erOgTGFrarDYntyXdIHeZy+guhwMFIL2yPh1sw5hr26t0c+Lp+dJlMWi4K3zv8ngujQjCj8BkPMr4Z7SV0AAHPsJHnqY2LVgdTWQr437nNEYBzTVnwrqVN/06KYUXBaH1N2e0wZm0sMfrQhEVHbam71nJYpuoqXIJ5HZ9WnN7uVK+1pEACO+XbyAfreMSC2o/hrYDKnbpNIqwoLcGfrJQLgyGapay4voTa3wtb3pE+jGXfNLgtD2rxZ1Sjef3BuIxvYcY2t3VlVmPn4jGcc2rHw47IUOGcHbR8NLgkqG6jucnouz355Ndgq95UdnuRkMpemAuY54UfWPUWHccO+m3Za0RiUDeHlEExh8stDclxWJSdFJdn86v0Mdz8ZirzSnncG0ryfKmoRtyfUqSvDiNuIFlLSeUz/KOBD0yIYleGxPeYuLYwmsrGIaxICaOiHT+xRylJM27F7/ghEUxmrGzRRS+Gy6/zd5HVT/a3Bg+nAO18ZYIjdVkK/6Jt/koDCY57PFkhn9M8qZ2HngxIF2fjbFU5/PinsawFPRzeOEZTYWxr0cUIqcNS/Jf8ojZxhCDFnDm9I/vquhXPB7Twfxz0UXzmg5wSFI96i6TZ5pHfWgBPlppJskqs/JPRUpZwTxpcfQIyDoGxOBe+UcqMTV1vnMJGuR9turXXhxsYTcaOYidaj7AbIgbjHj6FHd9cM9cUC8G6PMinNMg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(7416014)(1800799024)(36860700016)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mq7mB/SM1T5SP4hCJDpS0Usa4W+OCG5ohr//T4ivVgods5HhiCx4nqt8mnK+CZ0vdKIhb65eril8GCEJmtovbYCBN9moQMMVYYmEMfn/3PqQKk8i9yQqDicWJXhrrtsrABTsG95EWS9blWgquyH6eGAuA9BXXaRukgQz2PInX4GgFZnr3PASy7vVvO9lXysE+Vw6OTfQV7WlSUw5+zIJ4r4YmEThbNhQU4aA8+Vj4zJgGQCl95ffW/XlSwh4KE7lsoeu+3ee6ylAbetlYLroJU1l62b7+AZQvrA2f2+7QMSgimHMqu+zVzgeewMnLo9+y9cCvyzxTFpcPJaOww00iO+wdZSl1dn4G2EPQ35x6RXD32i0fPSFZRM+AbWWfOU56A406W2mR5tFWUmpmTmO4HvuhDobBpQznfBo8F9Fm9QqVXbefuD62WE+3i0vVZWo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:32:17.9359
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae5c88f-0fea-42df-5919-08deebe37a98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

When PCI attach reserves a BDF already allocated to a vIOMMU, relocate
that vIOMMU to a newly allocated translate-device-id before marking the
BDF reserved for the device.  Reprogram translation DTE and VFctrl under
trans_devid_lock; roll back the pool on failure.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/trans_devid.c | 116 +++++++++++++++++++++++++++++++-
 1 file changed, 115 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index 9d7d93c5dcdb..6fb1ba3c9444 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -82,16 +82,120 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg)
 	xa_destroy(&pci_seg->trans_devid_xa);
 }
 
+/**
+ * trans_devid_do_relocate - move vIOMMU translation DTE from @old_id to @new_id
+ *
+ * Caller holds @aviommu->trans_devid_lock.  Pool xarray already records @new_id
+ * as allocated to @aviommu and @old_id as reserved.
+ */
+static int trans_devid_do_relocate(struct amd_iommu_viommu *aviommu,
+				   u16 old_id, u16 new_id)
+{
+	struct iommufd_viommu *viommu = &aviommu->core;
+	struct amd_iommu *iommu =
+		container_of(viommu->iommu_dev, struct amd_iommu, iommu);
+	int ret;
+
+	aviommu->trans_devid = new_id;
+
+	ret = amd_iommu_set_translate_dte(viommu);
+	if (ret)
+		goto err_restore_id;
+
+	amd_iommu_update_vfctrl_mmio_translate_devid(iommu, aviommu->gid, new_id);
+
+	if (search_dev_data(iommu, old_id))
+		amd_iommu_clear_translate_dte(iommu, old_id);
+
+	return 0;
+
+err_restore_id:
+	aviommu->trans_devid = old_id;
+	return ret;
+}
+
+/**
+ * trans_devid_relocate - move an allocated id to a new slot and reserve @from_id
+ *
+ * Called when PCI attach needs a BDF that a vIOMMU already owns.  Updates the
+ * per-segment pool, then reprograms DTE and VFctrl on the owning vIOMMU.
+ *
+ * Locking: takes @aviommu->trans_devid_lock, then pci_seg->trans_devid_mutex
+ * (same order as destroy).  Hardware steps run with the viommu lock held and
+ * the segment mutex dropped.
+ */
+static int trans_devid_relocate(struct amd_iommu_pci_seg *pci_seg, u16 from_id,
+				struct amd_iommu_viommu *aviommu)
+{
+	u16 new_id;
+	int ret;
+
+	mutex_lock(&aviommu->trans_devid_lock);
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	if (trans_devid_xa_owner(xa_load(&pci_seg->trans_devid_xa, from_id)) !=
+	    aviommu) {
+		ret = -ENOENT;
+		goto unlock_seg;
+	}
+
+	if (aviommu->trans_devid != from_id) {
+		ret = -EINVAL;
+		goto unlock_seg;
+	}
+
+	new_id = trans_devid_find_free_locked(pci_seg);
+	if (new_id < 0) {
+		ret = new_id;
+		goto unlock_seg;
+	}
+
+	ret = trans_devid_xa_install_allocated_locked(pci_seg, new_id, aviommu);
+	if (ret)
+		goto unlock_seg;
+
+	ret = trans_devid_xa_install_reserved_locked(pci_seg, from_id);
+	if (ret) {
+		xa_erase(&pci_seg->trans_devid_xa, new_id);
+		goto unlock_seg;
+	}
+
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+
+	ret = trans_devid_do_relocate(aviommu, from_id, new_id);
+	if (ret) {
+		mutex_lock(&pci_seg->trans_devid_mutex);
+		xa_erase(&pci_seg->trans_devid_xa, new_id);
+		trans_devid_xa_install_allocated_locked(pci_seg, from_id,
+							aviommu);
+		mutex_unlock(&pci_seg->trans_devid_mutex);
+	}
+
+	mutex_unlock(&aviommu->trans_devid_lock);
+	return ret;
+
+unlock_seg:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	mutex_unlock(&aviommu->trans_devid_lock);
+	return ret;
+}
+
 /**
  * amd_iommu_trans_devid_reserve - occupy @id so it is never returned by alloc
  *
  * Reservation is done when attaching device to a domain (see amd_iommu_attach_device()).
  *
- * Return: 0 on success.  A second reserve of an already-reserved @id succeeds.
+ * When @id is allocated to a vIOMMU (e.g. after PCI hot-plug), the driver relocates
+ * that vIOMMU to a newly allocated translate-device-id and reserves @id for the PCI
+ * function.
+ *
+ * Return: 0 on success, %-ENOSPC if relocation cannot find a free id, or another
+ * errno from relocation.  A second reserve of an already-reserved @id succeeds.
  */
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
 {
 	void *entry;
+	struct amd_iommu_viommu *aviommu;
 	int ret = 0;
 
 	mutex_lock(&pci_seg->trans_devid_mutex);
@@ -99,6 +203,16 @@ int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id)
 	if (trans_devid_xa_is_reserved(entry))
 		goto unlock;
 
+	aviommu = trans_devid_xa_owner(entry);
+	if (aviommu) {
+		mutex_unlock(&pci_seg->trans_devid_mutex);
+		ret = trans_devid_relocate(pci_seg, id, aviommu);
+		if (!ret)
+			pr_debug("%s: Reserved trans_devid %#x after relocation (seg %#x)\n",
+				 __func__, id, pci_seg->id);
+		return ret;
+	}
+
 	ret = trans_devid_xa_install_reserved_locked(pci_seg, id);
 unlock:
 	mutex_unlock(&pci_seg->trans_devid_mutex);
-- 
2.34.1

