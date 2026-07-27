Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419D4417BC4
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159136; cv=fail; b=p8j9uQpw0NMp5RDLqVXzF6sfXUKesy0wCPXV5CHwJnvC3YYvi6Wn6ZJWKA+6RW8YMJG+bpF5PMKZ8UKR+vs13eFYej3JNg4HkaNp3b/kHnnYgG+Mcq0dHuzbbgEl82ljiAKi0Jtsvorlt093ZG8rj3nE0+R9J68zFC0kkgY2nh4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159136; c=relaxed/simple;
	bh=joDRSoFcFHIVyQ0GW1gad25fUf+r16cIw74tr653MdQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hYhHHIFbczKgpmo0AYDZSx995gQsdtHfmWyHI3iu3HEHw+2Lt6s8hD6yza8IBiZPKUT23D7+S7VrKwgBz/VhrKb9GdDgc2QRZ6460mfCV/6cirg67MWtcdU+L9g3niFoq8jXiXcUmVPYIUjJu+RTaWfAgOF7qcR0PkN3whbCNbg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SuIrGdjE; arc=fail smtp.client-ip=40.93.194.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SuIrGdjE"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HXFa2Z3GczVsh45e0EEjGnUdUEIy9XGsm3Rf8nzYSQUqj/xTJ0UrkqOYwVgKvQntUjL+SeOLfsbdwccivbA93B95cEw/bc1njZT46JbSSNamD0fL13z9dWZwTNTONNy9/zmQMaZoMaeBefGtOPa5xOYWp3miOqrPsrYmvOxWEppQCf/VYjhF2DsJrjiU3UCbqwvfT8Ln01OxypXBtRY/c1CN4mD1EEMtalNwAD8og058YBm67/2HZPjm6rKXDnQDKKRqU5sjFqbroanUvUe3iC6DkUxC5ukstZVqn/drVqDzo0c1omTYb8Ok8KV8JhVWbiART3r2ksuIGdgXr8pOCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1J6ygHqUhdrAXivW3O0e6cjtmJ5nnWB8UvLEvvnXo6o=;
 b=Y2N6+lHgDEYwXuX5hKZjHIIOm7wTu7X3rMWQ0pUEAVxU3iWcdZhDjc+EpyqjRkJtLgvOFP5mrFIDqrO9MLLTbEyBYRMtFmVewBzDzd9vEfG32qLAKQos2olLvFnDlxtoZN+NQ3FFf9gLI54Q76zvwCLEDiJuQCp+iVKbQc0wpuSKxLnf7wls+Q1JNs8AGj4QDH8BSF1oteD/tiZ8nVkw+Kbe5o0qgjrM40snkEErMiwRFhonE0/J+G61VuDTW+ATwXrZ+U5PfihWS7X0w80jFZskGrSZtvkc+FJBrw0XVCFG1GYSJqil5ceVOalNnc5dvnY1cKzM2G21As2HEPlwYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1J6ygHqUhdrAXivW3O0e6cjtmJ5nnWB8UvLEvvnXo6o=;
 b=SuIrGdjEVFKVod1BmQ9bNf0YIdx5tWbjbVFVfwSg0fBMxEJte20ujSgvdYg2mkcgmw3Ity0vxOKWFLyHsSGufo2DiTJqFZVZ7DzBKXirjwWa0/BcTZFoZKXNsqv8/ZLMXKVxyYrI0Tt5ldl3BtWBT4XomM+mxO7ra7dA3le0OR4=
Received: from PH7P221CA0082.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:328::21)
 by SJ2PR12MB9243.namprd12.prod.outlook.com (2603:10b6:a03:578::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:32:06 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:328:cafe::9d) by PH7P221CA0082.outlook.office365.com
 (2603:10b6:510:328::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:32:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:32:06 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:59 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 22/24] iommu/amd: Add translate-device-id alloc/free with vIOMMU owner
Date: Mon, 27 Jul 2026 13:29:11 +0000
Message-ID: <20260727132913.22475-23-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|SJ2PR12MB9243:EE_
X-MS-Office365-Filtering-Correlation-Id: dc622363-5aa5-4896-603c-08deebe3739c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|7416014|56012099006|11063799006|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	yzpCqWg4gpRqYMdqVsR/cTj70qQQ72BMDdSQchVLdySAMehgEUAlhctjCQdjMcNgyc+aKmhBOFCYn+lcowvmK0VHusIrfk5lLtgFK8dkbCVMyxmFjP8Ovega6+TvIl1IHCR6TioWStpnvuYzFguCGYXbzd8Ij9xU95XxfpdvmqfUq9+AOVV7HQQIQke4YSOpHGbMjxBcBRGNwZ0GmPhtFD26mUFEhTOb5kF3zniAbngrblRuKvWM9Cmn9gm1/YGF8oVUSIzal71zny7PfThU3jN+6JT33WhA2gTMCVm1CzZoqhnnvcPg5ZB3SyFamkWPpCziCgPFY0Wq+5OZ+dVVAXTV9V+QCAyOP0Fzz9jjSzarMfHzpAqUKxHs4AhLc9X8mxfQ25HCpghIOj2cI0/iD3W4sHwIeJxlDOonR80dhnkwb53l/T6/AHfdwqyQ5z9mhQ2xZDD/nYbBi8FOs3HTCd2XAY5ez/eD1A9fHNPXTfgVDQtUMitWeUo9d/triobz9hmqPchIrn4gpUfZVznQ9Q2ub4rFP/X5EAIwY7GZch8UdgSF92ypTTj9Y+ofiyJWmwCI/bBlcdPZWlGgVY83TxRTlRT8L5YEUio+LBW4+Wt4xjdrU02aA7cfbr0otkLyMKB1joknf0ANofIlufBr1LxgXJzy+1iD9JeCUP0KLh5pAB//Cp9lPCn837/FMXHQp73CcwQ1aNmd5mnLk+pcpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(7416014)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8w21qk+62bppAh9eqY8eEsPJBXfZ9EJ80UV4+pzd2tNAX5YF0dJ5y7SQZKtrzSwdpGS/MxU1JKTmZdzd1I/dMHJ5yL5CONRHB3YVgVWwEQDe2mdW2UJ1qGMGExhIA4b6uCoUmof0De9bDthDk1SHE7n0zq2LOKuJoQlNKmANHLq1tSlJNIqNAJiUwe++knt8YzNTLkyFmGpQ2dSBXnmp9953jSKZo7f9uaRu9qKo+NcpnXarXG1sbvidQe4OlFw9Cu/hKKj4nBa7IgaxRk9HQRBTPMEj4SbUjT7XsH08DhH27WCtvHFIi1Yes71wGRl0Q1X1++sZC0SdgybA2FpMWtTNfDYTJ0L6DAMEUA2eA20O2tUEqJxIPFPVECa8iNMiCYMOiFPzijwqAoDzAp4JRImhSmXhKVIoS/Y4ISeWjzH2yKrmaopTxiAXdOhVxZAL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:32:06.2257
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc622363-5aa5-4896-603c-08deebe3739c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9243

Extend the per-segment translate-device-id pool to record the owning
struct amd_iommu_viommu in the xarray.  Add amd_iommu_trans_devid_alloc()
and amd_iommu_trans_devid_free() to hand out ids from the high end of
the range and return them on teardown.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h   |   4 ++
 drivers/iommu/amd/trans_devid.c | 100 ++++++++++++++++++++++++++++++--
 2 files changed, 100 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 200640ed0ef6..94ad1902ce14 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -225,6 +225,10 @@ void amd_iommu_pci_seg_trans_devid_fini(struct amd_iommu_pci_seg *pci_seg);
 int amd_iommu_trans_devid_reserve(struct amd_iommu_pci_seg *pci_seg, u16 id);
 int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 					      struct device *dev);
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu);
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu);
 #else
 static inline void
 amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg) { }
diff --git a/drivers/iommu/amd/trans_devid.c b/drivers/iommu/amd/trans_devid.c
index a40686a576ec..9d7d93c5dcdb 100644
--- a/drivers/iommu/amd/trans_devid.c
+++ b/drivers/iommu/amd/trans_devid.c
@@ -22,24 +22,55 @@ static inline bool trans_devid_xa_is_reserved(void *entry)
 	       xa_to_value(entry) == TRANS_DEVID_RESERVED;
 }
 
+static inline struct amd_iommu_viommu *trans_devid_xa_owner(void *entry)
+{
+	if (!entry || xa_is_value(entry))
+		return NULL;
+	return entry;
+}
+
 static inline void *trans_devid_xa_mk_reserved(void)
 {
 	return xa_mk_value(TRANS_DEVID_RESERVED);
 }
 
-static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
-						  u16 id)
+static int trans_devid_find_free_locked(struct amd_iommu_pci_seg *pci_seg)
+{
+	int id;
+
+	for (id = U16_MAX; id >= 0; id--) {
+		if (!xa_load(&pci_seg->trans_devid_xa, id))
+			return id;
+	}
+	return -ENOSPC;
+}
+
+static int trans_devid_xa_install_locked(struct amd_iommu_pci_seg *pci_seg,
+					 u16 id, void *entry)
 {
 	void *old;
 
-	old = xa_store(&pci_seg->trans_devid_xa, id,
-		       trans_devid_xa_mk_reserved(), GFP_KERNEL);
+	old = xa_store(&pci_seg->trans_devid_xa, id, entry, GFP_KERNEL);
 	if (xa_is_err(old))
 		return xa_err(old);
 	WARN_ON_ONCE(old);
 	return 0;
 }
 
+static int trans_devid_xa_install_allocated_locked(struct amd_iommu_pci_seg *pci_seg,
+						   u16 id,
+						   struct amd_iommu_viommu *aviommu)
+{
+	return trans_devid_xa_install_locked(pci_seg, id, aviommu);
+}
+
+static int trans_devid_xa_install_reserved_locked(struct amd_iommu_pci_seg *pci_seg,
+						u16 id)
+{
+	return trans_devid_xa_install_locked(pci_seg, id,
+					      trans_devid_xa_mk_reserved());
+}
+
 void amd_iommu_pci_seg_trans_devid_init(struct amd_iommu_pci_seg *pci_seg)
 {
 	mutex_init(&pci_seg->trans_devid_mutex);
@@ -121,3 +152,64 @@ int amd_iommu_trans_devid_reserve_pci_aliases(struct amd_iommu *iommu,
 	return pci_for_each_dma_alias(pdev, reserve_trans_devid_each_dma_alias,
 				      pci_seg);
 }
+
+/**
+ * amd_iommu_trans_devid_alloc - allocate a translate-device-id for @pci_seg
+ *
+ * The trans_devid is allocated from the highest id to the lowest id.
+ * Generally, the PCI devices enumerated from the beginning of the bus range.
+ * Therefore, ids in the high range are likely to not be used.
+ *
+ * Each vIOMMU receives its own translate-device-id from the per-segment pool.
+ * @aviommu is stored in the xarray as the slot owner.
+ *
+ * Return: allocated id on success, negative errno on failure.
+ */
+int amd_iommu_trans_devid_alloc(struct amd_iommu_pci_seg *pci_seg,
+				struct amd_iommu_viommu *aviommu)
+{
+	int id, ret;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	id = trans_devid_find_free_locked(pci_seg);
+	if (id < 0) {
+		ret = id;
+		goto unlock;
+	}
+
+	ret = trans_devid_xa_install_allocated_locked(pci_seg, id, aviommu);
+	if (ret)
+		goto unlock;
+
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	pr_debug("%s: Allocated trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+	return id;
+
+unlock:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+	if (ret == -ENOSPC)
+		pr_err("%s: No free trans_devid found (seg %#x)\n", __func__,
+		       pci_seg->id);
+	return ret;
+}
+
+/**
+ * amd_iommu_trans_devid_free - return @id to the per-segment pool
+ *
+ * Caller must hold @aviommu->trans_devid_lock if racing with relocation.
+ */
+void amd_iommu_trans_devid_free(struct amd_iommu_pci_seg *pci_seg, u16 id,
+				struct amd_iommu_viommu *aviommu)
+{
+	void *entry;
+
+	mutex_lock(&pci_seg->trans_devid_mutex);
+	entry = xa_erase(&pci_seg->trans_devid_xa, id);
+	if (WARN_ON_ONCE(!entry || trans_devid_xa_owner(entry) != aviommu))
+		goto out;
+	pr_debug("%s: Freed trans_devid %#x (seg %#x)\n", __func__, id,
+		 pci_seg->id);
+out:
+	mutex_unlock(&pci_seg->trans_devid_mutex);
+}
-- 
2.34.1

