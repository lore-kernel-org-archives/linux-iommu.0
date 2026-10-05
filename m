Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011021.outbound.protection.outlook.com [40.93.194.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE9A368941
	for <iommu@lists.linux.dev>; Mon,  5 Oct 2026 06:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791182612; cv=fail; b=HcOSLfrG0T5FxCj+/GJMSI9g5dbsRI9Z629RqT3OUVswCh+3Hnttm1zo2knqOQgKGt4ZlPyuCr+Gvd10Ih2zGcgux0owih2s36kDJqXfw47W7OuTNeX6wKl5N9TADOE966x9Nff74TEwhcNZxcdTh5NxkuMYxLTh7yIwGeQ5Dto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791182612; c=relaxed/simple;
	bh=QT/JYcpBnipQw7Haa9kjBNBka0GIBurBlxxKNojCnmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh5waWCis1taVPRmiQzu/ADxXHC2vHjctoxD1gBJ4zQoD7S2je3Zy95OXLNhag9003ArWjGIqzCQU0vwiMm7G8urJd0AI8tuyi8AUkgbB3kiFUAMs9D3/wXGWwmi5IfPzOjhlA1joFnElpdIFwE07vLOOy6MnCjJIraWTybdxm4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2abHuEtT; arc=fail smtp.client-ip=40.93.194.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2abHuEtT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CZ1iK16j+mfZLf1MFxO0P58a7w7VyOiU6BfFJT9lvVltfQR7H6NbHF1NW4We1/Knqw+htdqNxiVkPCdG1wz/QmN1g5Z2dog7PD0wD+L50DjqsqIvOX5+7JMul2pJqipSa161pcA525A1bTYA+UVV3X9ageTrAx4Yx0fXuZ/8KXdnqzFIPsxQI93JAT/CMJ4QbAT5g0N/rHTmTjiowri6sKC/5N8mYoOz9fl+CFPl0kGaA4r5OnxqVsNLmAp7O7tDdlF55ht8Wmkf5Gzyu7fs+rX2GRDh9UH29abCxGvIiCL6NTGMOmPIPSgXiOtC0f2b23TbigR/A1T3cyFryoScfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gONSiPLIv9WnBszH2dJs3hcGCMSj+vzxXKhevRZAPyE=;
 b=lAd9fE/RM1tyCd2xaatxmPnb5dFxkDH9+t+OJih+6ftst8aygC/ogXNFndYpSRYtl7RGDc4WvS0O3t9iuvEl4PazKoJxi8sywuPJ7fg7isadSyanFHY4nHU24SxGGIBflINESL8fDPfkDGH4+fUVGNVv7SWcGiUoyqEBMTd4IR03SqYWZeImMIEuIU8UE0qk6TSZTzzflXvU/+KU4uKqbPxjjtGP1p76Y5IASJF/HchEQgNPavEGqt8APttEhPjPuPuJttkJVWs8cWP+o+f6ysG99+n8odU5nkAqthVDQ4PGJwqyXrbGcidW1b6MPUnCa41J8NTjXu7lvRI0gJkoaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gONSiPLIv9WnBszH2dJs3hcGCMSj+vzxXKhevRZAPyE=;
 b=2abHuEtTMyzlSNg+of6n3eKEyViVj596Zh3etJM1j77QjCAABsRIsr72LO0BO5CMYF1RUnbSg2KT5StzV8X0LJbeVuMbK04KhBv0aoQV6dpGjpBr8PR3/5pGpkZDpAcRMdFVGdGidvmGCk0Bjri7oWRyAPmKNhQGYEUB/XXH6Yo=
Received: from MW4PR04CA0260.namprd04.prod.outlook.com (2603:10b6:303:88::25)
 by SAWPR12MB999267.namprd12.prod.outlook.com (2603:10b6:806:55f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 06:43:23 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:303:88:cafe::30) by MW4PR04CA0260.outlook.office365.com
 (2603:10b6:303:88::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 06:43:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 5 Oct 2026 06:43:23 +0000
Received: from BLRANKISONI.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 5 Oct
 2026 01:43:14 -0500
From: Ankit Soni <Ankit.Soni@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>, <will@kernel.org>,
	<jgg@nvidia.com>
CC: <suravee.suthikulpanit@amd.com>, <vasant.hegde@amd.com>,
	<robin.murphy@arm.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, <pasha.tatashin@soleen.com>,
	<rppt@kernel.org>, <pratyush@kernel.org>, <skhawaja@google.com>,
	<praan@google.com>, <baolu.lu@linux.intel.com>, <dwmw2@infradead.org>,
	<kevin.tian@intel.com>, <dmatlack@google.com>, <vipinsh@google.com>,
	<kexec@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 7/7] iommu/amd: reattach preserved devices to their restored domains
Date: Mon, 5 Oct 2026 06:40:17 +0000
Message-ID: <20261005064018.1558-8-Ankit.Soni@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261005064018.1558-1-Ankit.Soni@amd.com>
References: <20261005064018.1558-1-Ankit.Soni@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SAWPR12MB999267:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e222e2f-8799-48a7-b7ba-08df22abf3ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|82310400026|376014|23010399003|11063799006|5023799004|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	f1vQkcc+SqPHrqNciPcfJPhvnqiIkHLitiuRVlaOX/cX1GNiTIu1cWSsWa92e2SWHIS/iYJsJrMvoNfZe5jIjNr1Gk+AfhcLEe7FU2saWQezhp+darVp5W7be9o7aWS+QVMHC6zRQojW7YxL8mUUx8TlCK1epTgrElpQGJGHtgCWekwgFhG7/SVdVdPbVN/89Oce62jFfpfj5+uicW9FcHash2EOstfnNA56P6w2Ha40XblMnjlsCLn6IVfIslDCprBYOXk4YuDAZry1S1JjcfreSxGmB7SZzGc5RVMlZOkaoGYQfTXb1XD4O85Z5627y0Xs8DeERfwWlYTDU4UGQ39mUZ0YvHW1G6Zm05Cd3N93zZsBKZe28U4Z7HPYJAwvUF6atNk9SvTeMgITC+n00M8HCCvEYpMRbvO8e/TzMoY5H8lXN9wz8UxwZwLqOxAl0hQBQbg1JkHjsFxlCHXgt2dtifvvs9d4qP4mlLiHKpALqykwExFzKHz2rSvhPt+70E7KQ8UgZgeVnU4zB5Qs/bIpJatIvghUH0Sh/bMNZ27c470u0vyEH4e0QsCo+GWV/BRCTq/StCiVu1WqtgQqg/BUcnADDJ5gfIMsNF4RhuTnQVSyZd0b/v9eF87hTY3lb9KptKQ1vu76W3P1grwEaEJOqvyS85TJv6YcPBN8mCYmrITgEz0nwpKvPLTSOkuBqQaekqpfFhY6MtZA48E3yQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(82310400026)(376014)(23010399003)(11063799006)(5023799004)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	JELXZM2zxlWsejmmXWhIyn54UbOAmxk2LU/dH9P1xBYz+trZPunbJWHZYz83sDTJbmpQAqe80pG7XX5NmkIAIz23ViQDSVPPt9nqMh1oiZV+2UlTfSMJ/WwxY2Zqk3L30jXpdToyEX33IKTiIKQhDTpNSkUQfiX5J6Y9OF1pCbZnfLuYPqYqWbp1mR9s7Aqy5FMGp0DIqhOgDMdinTDhz8uzfO8ULyDaTKp3PQ0japchwb2WsKWHDPQbCWclhv5cZTb4FAMmpW479fVsuUwx88CLes8kKQNqkrR6VktS5w5j2AA3UWgRUcEmeDHiSMSdHTtGPWKu+nhHwTTN7WOoVcIGP/nZZkv+ua0icQdUKdZZ/E/HSGzMAjEhl9SiQeJ0QyO3L8M80wIN9FliTtPEHGt0YlLeZh6q2SbtMHEJv0Z+OgjEaYSndxSf4wPQuv/n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 06:43:23.1560
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e222e2f-8799-48a7-b7ba-08df22abf3ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999267

A device that rode across the kexec is already translating through the
DTE this kernel adopted, so adopt its domain ID and GCR3 table instead
of programming the DTE again, and verify the adopted state against the
live DTE. A mismatch means the kernel and the hardware disagree about
how the device's translations are cached, so fail the attach and leave
the DTE alone.

Refuse every other attach for such a device, in all four attach ops,
because the blocking, identity, nested and freshly built paging domains
would each rewrite that DTE under a device that is still doing DMA. The
paging path compares the target against the domain recorded for this
device, so a second restored domain cannot be swapped in either, and
clone_alias() is skipped for the same reason.

On device removal the core skips the release domain for a preserved
device, so detach_device() never runs and dev_data->domain stays set.
Drop the software state and leave the DTE alone; the restored domain
outlives the device.

Signed-off-by: Ankit Soni <Ankit.Soni@amd.com>
---
 drivers/iommu/amd/amd_iommu.h  |  10 +++
 drivers/iommu/amd/iommu.c      | 130 ++++++++++++++++++++++++++++-
 drivers/iommu/amd/liveupdate.c | 146 +++++++++++++++++++++++++++++++++
 drivers/iommu/amd/nested.c     |   8 ++
 4 files changed, 292 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index ac6d7a17eb40..93fe65b28d53 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -239,6 +239,9 @@ void amd_iommu_unpreserve_device(struct device *dev,
 void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu);
 void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
 				 struct iommu_hw_ser *ser);
+int amd_iommu_reattach_device(struct device *dev,
+			      struct protection_domain *domain,
+			      struct iommu_device_ser *device_ser);
 #else
 static inline void amd_iommu_clear_unpreserved_dtes(struct amd_iommu *iommu)
 {
@@ -248,5 +251,12 @@ static inline void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
 					       struct iommu_hw_ser *ser)
 {
 }
+
+static inline int amd_iommu_reattach_device(struct device *dev,
+					    struct protection_domain *domain,
+					    struct iommu_device_ser *device_ser)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_IOMMU_LIVEUPDATE */
 #endif /* AMD_IOMMU_H */
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 72df97b99589..0bdd93016814 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -444,6 +444,13 @@ static int clone_alias(struct pci_dev *pdev_origin, u16 alias, void *data)
 		ret = -EINVAL;
 		goto out;
 	}
+	/*
+	 * A preserved device is still translating through the DTE this kernel
+	 * adopted, so never clone another device's DTE over it.
+	 */
+	if (alias_data->dev && dev_iommu_restored_state(alias_data->dev))
+		goto out;
+
 	update_dte256(iommu, alias_data, &new);
 
 	amd_iommu_set_rlookup_table(iommu, alias);
@@ -2376,6 +2383,55 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
 	spin_unlock_irqrestore(&pdom->lock, flags);
 }
 
+/*
+ * True when @dom is the one domain this kernel restored for @dev. Attaching a
+ * preserved device to anything else has to be refused, including a different
+ * restored domain.
+ */
+static bool dev_restored_domain_matches(struct device *dev,
+					struct iommu_domain *dom)
+{
+	struct iommu_device_ser *device_ser = dev_iommu_restored_state(dev);
+	struct iommu_domain_ser *domain_ser;
+
+	if (!device_ser || !device_ser->domain_iommu_ser.domain_phys)
+		return false;
+
+	domain_ser = phys_to_virt(device_ser->domain_iommu_ser.domain_phys);
+
+	return domain_ser->restored_domain == dom;
+}
+
+static int reattach_verify_dte(struct amd_iommu *iommu,
+			       struct iommu_dev_data *dev_data, u16 domid)
+{
+	struct dev_table_entry dte;
+
+	get_dte256(iommu, dev_data, &dte);
+
+	if (!(dte.data[0] & DTE_FLAG_V) ||
+	    FIELD_GET(DTE_DOMID_MASK, dte.data[1]) != domid) {
+		dev_err(dev_data->dev,
+			"preserved DTE does not describe the adopted domain ID %u (DTE 0x%llx/0x%llx)\n",
+			domid, dte.data[0], dte.data[1]);
+		return -EINVAL;
+	}
+
+	/*
+	 * If these two disagree, either the device caches translations
+	 * nobody invalidates or the IOMMU waits for completions from a
+	 * device that will not send them.
+	 */
+	if (!!(dte.data[1] & DTE_FLAG_IOTLB) != !!dev_data->ats_enabled) {
+		dev_err(dev_data->dev,
+			"preserved DTE and restored ATS state disagree (DTE 0x%llx/0x%llx, ats_enabled %u)\n",
+			dte.data[0], dte.data[1], dev_data->ats_enabled);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * If a device is not yet associated with a domain, this function makes the
  * device visible in the domain
@@ -2385,6 +2441,7 @@ static int attach_device(struct device *dev,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct iommu_device_ser *device_ser = NULL;
 	struct pci_dev *pdev;
 	unsigned long flags;
 	int ret = 0;
@@ -2401,8 +2458,17 @@ static int attach_device(struct device *dev,
 	if (ret)
 		goto out;
 
+	if (iommu_domain_restored_state(&domain->domain))
+		device_ser = dev_iommu_restored_state(dev);
+
 	/* Setup GCR3 table */
-	if (pdom_is_sva_capable(domain)) {
+	if (device_ser) {
+		ret = amd_iommu_reattach_device(dev, domain, device_ser);
+		if (ret) {
+			pdom_detach_iommu(iommu, domain);
+			goto out;
+		}
+	} else if (pdom_is_sva_capable(domain)) {
 		ret = init_gcr3_table(dev_data, domain);
 		if (ret) {
 			pdom_detach_iommu(iommu, domain);
@@ -2432,12 +2498,33 @@ static int attach_device(struct device *dev,
 	spin_unlock_irqrestore(&domain->lock, flags);
 
 	/* Update device table */
-	dev_update_dte(dev_data, true);
+	if (device_ser) {
+		ret = reattach_verify_dte(iommu, dev_data,
+					  device_ser->domain_iommu_ser.attachment_id);
+		if (ret)
+			goto err_reattach;
+	} else {
+		dev_update_dte(dev_data, true);
+	}
 
 out:
 	mutex_unlock(&dev_data->mutex);
 
 	return ret;
+
+	/*
+	 * The DTE is the previous kernel's and the hardware is still walking
+	 * it, so unwind the software state only and leave it alone.
+	 */
+err_reattach:
+	spin_lock_irqsave(&domain->lock, flags);
+	list_del(&dev_data->list);
+	spin_unlock_irqrestore(&domain->lock, flags);
+	dev_data->domain = NULL;
+	pdom_detach_iommu(iommu, domain);
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
 }
 
 /*
@@ -2493,6 +2580,30 @@ static void detach_device(struct device *dev)
 	mutex_unlock(&dev_data->mutex);
 }
 
+/*
+ * The core skips the release domain for a preserved device, so its DTE is still
+ * live here. Drop the software state only. The restored domain outlives the
+ * device and the hardware keeps walking the page tables we adopted.
+ */
+static void detach_restored_device(struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	struct protection_domain *domain = dev_data->domain;
+	unsigned long flags;
+
+	mutex_lock(&dev_data->mutex);
+
+	spin_lock_irqsave(&domain->lock, flags);
+	list_del(&dev_data->list);
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	dev_data->domain = NULL;
+	pdom_detach_iommu(iommu, domain);
+
+	mutex_unlock(&dev_data->mutex);
+}
+
 static struct iommu_device *amd_iommu_probe_device(struct device *dev)
 {
 	struct iommu_device *iommu_dev;
@@ -2561,6 +2672,9 @@ static void amd_iommu_release_device(struct device *dev)
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
+	if (dev_iommu_restored_state(dev) && dev_data->domain)
+		detach_restored_device(dev);
+
 	WARN_ON(dev_data->domain);
 
 	/*
@@ -2935,6 +3049,9 @@ static int blocked_domain_attach_device(struct iommu_domain *domain,
 {
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 
+	if (dev_iommu_restored_state(dev))
+		return -EBUSY;
+
 	if (dev_data->domain)
 		detach_device(dev);
 
@@ -3018,6 +3135,15 @@ static int amd_iommu_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (dom->dirty_ops && !amd_iommu_hd_support(iommu))
 		return -EINVAL;
 
+	/*
+	 * A preserved device is still translating through the DTE this kernel
+	 * adopted, so only the one domain restored for it may be attached.
+	 * Refuse before the detach below, which would tear that DTE down.
+	 */
+	if (dev_iommu_restored_state(dev) &&
+	    !dev_restored_domain_matches(dev, dom))
+		return -EBUSY;
+
 	if (dev_data->domain)
 		detach_device(dev);
 
diff --git a/drivers/iommu/amd/liveupdate.c b/drivers/iommu/amd/liveupdate.c
index 2e9a1de6b1ff..3d09054be438 100644
--- a/drivers/iommu/amd/liveupdate.c
+++ b/drivers/iommu/amd/liveupdate.c
@@ -395,3 +395,149 @@ void amd_iommu_restore_dev_table(struct amd_iommu *iommu,
 
 	pci_seg->old_dev_tbl_cpy = __va(ser->amd.dev_table_phys);
 }
+
+/* Inverse of pd_mode_to_ser(), for a value coming off the wire. */
+static enum protection_domain_mode ser_to_pd_mode(u32 mode)
+{
+	switch (mode) {
+	case IOMMU_AMD_SER_PD_MODE_V1:
+		return PD_MODE_V1;
+	case IOMMU_AMD_SER_PD_MODE_V2:
+		return PD_MODE_V2;
+	default:
+		return PD_MODE_NONE;
+	}
+}
+
+static void restore_gcr3_level(u64 *tbl, int level)
+{
+	int i;
+
+	iommu_restore_pages(__pa(tbl));
+
+	if (level == 0)
+		return;
+
+	for (i = 0; i < GCR3_ENTRIES_PER_LEVEL; i++) {
+		if (!(tbl[i] & GCR3_VALID))
+			continue;
+
+		restore_gcr3_level(iommu_phys_to_virt(tbl[i] & PAGE_MASK),
+				   level - 1);
+	}
+}
+
+static u64 *gcr3_pasid0_entry(u64 *tbl, int level)
+{
+	while (level--) {
+		if (!(tbl[0] & GCR3_VALID))
+			return NULL;
+
+		tbl = iommu_phys_to_virt(tbl[0] & PAGE_MASK);
+	}
+
+	return &tbl[0];
+}
+
+/*
+ * Every preserved domain ID is reserved before the first fresh allocation (see
+ * reserve_dev_table_domain_ids()), so @attachment_id already matching means an
+ * earlier device of this domain swapped it rather than a collision.
+ */
+static int reattach_domain_id(struct device *dev,
+			      struct protection_domain *domain,
+			      u16 attachment_id)
+{
+	bool disagree = false;
+	unsigned long flags;
+	int fresh_id = -1;
+
+	spin_lock_irqsave(&domain->lock, flags);
+	if (domain->id != attachment_id) {
+		if (list_empty(&domain->dev_list)) {
+			fresh_id = domain->id;
+			domain->id = attachment_id;
+		} else {
+			disagree = true;
+		}
+	}
+	spin_unlock_irqrestore(&domain->lock, flags);
+
+	if (disagree) {
+		dev_err(dev, "preserved domain ID %u conflicts with %u already adopted for its domain\n",
+			attachment_id, domain->id);
+		return -EINVAL;
+	}
+
+	if (fresh_id >= 0)
+		amd_iommu_pdom_id_free(fresh_id);
+
+	return 0;
+}
+
+static int reattach_gcr3_table(struct device *dev,
+			       struct protection_domain *domain,
+			       struct iommu_device_ser *device_ser)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct gcr3_tbl_info *gcr3_info = &dev_data->gcr3_info;
+	struct pt_iommu_x86_64_hw_info pt_info;
+	u32 glx = device_ser->amd.gcr3_glx;
+	u64 *gcr3_tbl, *pte;
+
+	if (amd_iommu_max_glx_val < 0 || glx > (u32)amd_iommu_max_glx_val) {
+		dev_err(dev, "cannot adopt a %u-level preserved GCR3 tree, hardware supports %d\n",
+			glx, amd_iommu_max_glx_val);
+		return -EINVAL;
+	}
+
+	gcr3_tbl = phys_to_virt(device_ser->amd.gcr3_tbl_phys);
+	restore_gcr3_level(gcr3_tbl, glx);
+
+	gcr3_info->gcr3_tbl = gcr3_tbl;
+	gcr3_info->glx = glx;
+	gcr3_info->domid = device_ser->domain_iommu_ser.attachment_id;
+
+	if (domain->pd_mode != PD_MODE_V2)
+		return 0;
+
+	/* Double-check the hardware is walking the page tables we restored. */
+	pt_iommu_x86_64_hw_info(&domain->amdv2, &pt_info);
+	pte = gcr3_pasid0_entry(gcr3_tbl, gcr3_info->glx);
+	if (!pte || (__sme_clr(*pte) & PAGE_MASK) != (pt_info.gcr3_pt & PAGE_MASK)) {
+		dev_err(dev, "preserved GCR3[0] 0x%llx does not match restored v2 page-table root 0x%llx\n",
+			pte ? *pte : 0, pt_info.gcr3_pt);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * amd_iommu_reattach_device - Adopt a device's preserved DTE state on LU boot
+ * @dev: Device being attached
+ * @domain: Domain this kernel rebuilt from the same preserved state
+ * @device_ser: Preserved per-device record handed over by the previous kernel
+ *
+ * Return: 0 on success, or a negative error code if the preserved state does
+ * not describe the domain this kernel restored.
+ */
+int amd_iommu_reattach_device(struct device *dev,
+			      struct protection_domain *domain,
+			      struct iommu_device_ser *device_ser)
+{
+	enum protection_domain_mode pd_mode;
+
+	pd_mode = ser_to_pd_mode(device_ser->amd.pd_mode);
+	if (pd_mode != domain->pd_mode) {
+		dev_err(dev, "preserved page-table mode %d does not match restored domain mode %d\n",
+			pd_mode, domain->pd_mode);
+		return -EINVAL;
+	}
+
+	if (!device_ser->amd.gcr3_tbl_phys)
+		return reattach_domain_id(dev, domain,
+					  device_ser->domain_iommu_ser.attachment_id);
+
+	return reattach_gcr3_table(dev, domain, device_ser);
+}
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 63b53b29e029..4b84b7b4b829 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -6,6 +6,7 @@
 #define dev_fmt(fmt)	"AMD-Vi: " fmt
 
 #include <linux/iommu.h>
+#include <linux/iommu-liveupdate.h>
 #include <linux/refcount.h>
 #include <uapi/linux/iommufd.h>
 
@@ -248,6 +249,13 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 	if (WARN_ON(dev_data->pasid_enabled))
 		return -EINVAL;
 
+	/*
+	 * A preserved device is still translating through the DTE this kernel
+	 * adopted, and a nested domain is never the domain restored for it.
+	 */
+	if (dev_iommu_restored_state(dev))
+		return -EBUSY;
+
 	mutex_lock(&dev_data->mutex);
 
 	set_dte_nested(iommu, dom, dev_data, &new);
-- 
2.43.0

