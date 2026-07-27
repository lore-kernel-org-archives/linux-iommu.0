Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012023.outbound.protection.outlook.com [40.93.195.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9AE417BD5
	for <iommu@lists.linux.dev>; Mon, 27 Jul 2026 13:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785159116; cv=fail; b=baBqfrVhAe5GmFVZXU8dBTdbytkzurw7uTwhiK+Edn2h5tRHBNCR1IafZ2TFB/pW95d1mxcSOO/6gGVFuQG3SRH20Gc6oXuotuMq/DDfW9FTNqU+ZAbPDMI0DvnFY4C2UOOywppfSaWND5sftyMxW6fQWZw54UWecSp8Lb0mKHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785159116; c=relaxed/simple;
	bh=uaaJZuqjFUu1d2AzEsoQP5dJHkNu8xxGsNwAGd50mz8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Cya1RwLuP2C3bPUNrE4erXzSN64daWWzex82s3vA4lOTmpwvCmW18y3+9jA04/YVu9DrLz3afKWbbiToqlFzYYtfX633WVQYkFT58YPNdFAyck7mOc3lBwf7rTWTgHFayHKaFGwiltO7A/MOTZLZPKrqoytC2HaPp6hmIwbdmbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=VUEZm9S8; arc=fail smtp.client-ip=40.93.195.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="VUEZm9S8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MKeST2aJoBS7E08E7PWVVsQaipK9sfh3gctLUZg39vnO2FTEB+nn7m+UI5LpqULe3J2ByNZw+4BRV2LwjPkPntzUNKiqhfXfyLU6F1qN/55pQhidK5lSiFPh9QP8jGwHdFgeLq2ph78gsqgqFvVEJ4X2Bep7/So6ofMipoW5OUowusDffij09Z7fbSw12IFp2JxPqJfXhGx1asmTkTlaUzJ4AG/ij8mesNIdqzZf5WMnONk94ZiQsgIcuHnzM4IDj6mBBPXoC4JWOkba3Cvp9GJWhPvbRSbQCDJ464H6WtYmlVU2ZjKHNaFW58KA1ABVYNfADcJa+AfCHt7QVFsfxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pMsMsgZjazmnFL0OIkB0fKRHQQ/6T/Exczw0y4LUh58=;
 b=tOwjb3DnmOcC/PskuE/GtSm3fAx52aS3417lXXMDgL1Fo09RCrGEmiAzA6AXoHE0WiWF++YUhNFJ0UTUyuc+lZt3/aVZLf648CvwYzcYsAVGoqIE7n9IjzZUOuo3o+m6Fy8xh7VQoz8U0l/ljEWEZOiigeJ42s0j9LEfd0VQYLrghSOl/JXn5604L2NMrAaX2tjzfiOgUxN3wQkLOqC202/iGFxXmhxRcSBoXp/Y97+ywSUQGQav61fMwYXIa1rgMp5gl3550AKZH0fwODs52zmmFj4oDAo0CVy3mZ/2PrwYlnx1OjxFRcYrNfjUlol+hVZMgIv9VKwTngd9FUhs0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pMsMsgZjazmnFL0OIkB0fKRHQQ/6T/Exczw0y4LUh58=;
 b=VUEZm9S852Y5RIRJDprnOzMazLaILMFEDzJIa4bDhmuPu0V1PUSpyz+H0K5ZsuyRcj95jwbPrJSrmq4y6FfvwBeJ27mHP17HhqxQun2aH4QdtXqqk28uw78neRTQqwcsBYR6CTIl6apbaLrnwFLn7cJQtXTx0mEsn7U/bgkni30=
Received: from SA1P222CA0185.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::11)
 by DS0PR12MB6414.namprd12.prod.outlook.com (2603:10b6:8:cd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 13:31:46 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:806:3c4:cafe::7) by SA1P222CA0185.outlook.office365.com
 (2603:10b6:806:3c4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 13:31:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 13:31:46 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 08:31:32 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<Sairaj.K@amd.com>, <jay.chen@amd.com>, <wvw@google.com>, <wnliu@google.com>,
	<dantuluris@google.com>, <chriscli@google.com>, <kpsingh@google.com>,
	<alejandro.j.jimenez@oracle.com>, <joao.m.martins@oracle.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>
Subject: [PATCH 17/24] iommu/amd: Introduce helper function for updating domain ID mapping table
Date: Mon, 27 Jul 2026 13:29:06 +0000
Message-ID: <20260727132913.22475-18-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|DS0PR12MB6414:EE_
X-MS-Office365-Filtering-Correlation-Id: c3fdcc45-a81d-415d-7f94-08deebe367e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|7416014|36860700016|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	C0vTBHFs3fjt3oNFjKAPmpqnN8aX9eBhc4NK76hKlL9MfZMQDfgU2sBzRLwRAcCyqjVQ2CtxgPQLq4N4VlVZWYvbddnNLr/a7neaIwK/y8Q0+xlFpoYREDL62BhZpLd3rwh34aAPutGLdBQ1j800tFxbpyAwpL1Igf/Qr7pfzPw6U8gqcEjYVC84RUj2KzL0qU9xxVmUMJVmAehaTJKluKvDsSQir5rsbOwfz5DTZ5mrIicxyv+EpjXW019VZmuvK34tnfBJ+5aqwtCv/UnEy1S05xDBOC5Xp0U6Gs2qvSjSaoQtmbIArJZN/MQgtPNAtO4de7/qYcvMAN+tewjinGYKSNYsk79v4XM9znlwKT+dJ+IFodpFejTTyrjU6xh+BSXVG1DcjIpg18wTzdWsf7yR1BVALfa0LZn4XL79yNuPNRQ460cAUNnxBuvgqwLNuOAnOopNI8Qc712Cl601aPbv4CEzV1IVgaaMjMoai857ZDsaOZR6TkQGUGl2OkEPqBOM84pe3O7jVqdAecmoW3o+vwVDDd8W0NF+VChd6clFCm9Q4lC0w98hMkUKAOmFj5CSUzMi8rFuMW6hlO1Gg3G8xF6054l0wKBYFUDOkI3gAhcuItfwyM2g5a6nPJqxXaKmPubIs/cQKLjnAlObBGR6OhWwlt5ej+Bv5pXiSsCGTz0vzUIx6T1/sGX0fmZWPFA9N2Q+oLQzexiIUh+wFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(7416014)(36860700016)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kByG1+/FgU0mQF0sStfWh3wpFKhJ3wJdc0G48mAm58z1XphxfFfzamfxjHmzlGGJY20l+85FgmLCmQvwixpaxUtXxtNdZUwcrLOPdEdtLjdGIJEHQ1McU+aXLZ2f4kim4hk15pO7zH9MojazqGRaF5wtopNgCguZIXqOsaLBvS0UA/72eG7hHkrF/2SEr0vo4uB40F8z38Y8KH+5lhng7fi53Aa+/OlZh6y+rcY7wYWe0k5SmKNclUcqwrdT8XFzzNkw2uSVtbwVvcqUHmCi4cUhXiWCxYbnPpUraIF+Y4+3j52uekSNROt3p+UveICXYJL8cvq+RxipnMIn1UvnSvGZh8kdNEv9XguaktcRvxgfIkReKtoz7iSkvtUSladtt0YBFpGLxVmT1Um7C6TAbx/sJtvHtpwmAYdpiG1e3kwjV1U2QWSsl7alT112zvGi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 13:31:46.5526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3fdcc45-a81d-415d-7f94-08deebe367e2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6414

AMD vIOMMU hardware uses the Domain ID mapping table to map Guest Domain ID
(GDomID) to Host Domain ID when it virtualises guest IOMMU commands.
It uses GID and GDomID to index into the table to look up host domain ID.

Linux IOMMU driver programs the table entry using VFCntlMMIO Guest Domain
Map Control Register.

Introduce amd_viommu_domain_id_update(), which is used to set the entry
when attaching the nested device. Clearing the entry is done during VM
destroy.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_viommu.h |  2 ++
 drivers/iommu/amd/nested.c     |  9 ++++++-
 drivers/iommu/amd/viommu.c     | 45 ++++++++++++++++++++++++++++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_viommu.h b/drivers/iommu/amd/amd_viommu.h
index 8b57717c22a6..b6fd5ffc3b82 100644
--- a/drivers/iommu/amd/amd_viommu.h
+++ b/drivers/iommu/amd/amd_viommu.h
@@ -18,6 +18,8 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu);
 
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id);
 #else
 
 static inline int amd_viommu_init(struct amd_iommu *iommu)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 6f3ae2496160..1365c67168b6 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -254,6 +254,7 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 				struct iommu_domain *old)
 {
 	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
 	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
 	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
 	int ret = 0;
@@ -267,10 +268,16 @@ static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
 
 	mutex_lock(&dev_data->mutex);
 
-	set_dte_nested(iommu, dom, dev_data, &new);
+	ret = set_dte_nested(iommu, dom, dev_data, &new);
+	if (ret)
+		goto out_err;
 
 	amd_iommu_update_dte(iommu, dev_data, &new);
 
+	ret = amd_viommu_domain_id_update(iommu, ndom->viommu->gid,
+					  ndom->gdom_info->hdom_id, ndom->gdom_id);
+
+out_err:
 	mutex_unlock(&dev_data->mutex);
 
 	return ret;
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 91d0dd3ac912..708f2c7496a4 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -40,6 +40,8 @@
 #define VIOMMU_DOMID_MAPPING_BASE	0x2000000000ULL
 #define VIOMMU_DOMID_MAPPING_ENTRY_SIZE	(1 << 19)
 
+#define VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET	0x08
+
 LIST_HEAD(viommu_devid_map);
 
 static int viommu_init_pci_vsc(struct amd_iommu *iommu)
@@ -420,6 +422,22 @@ static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 *
 	*entry = NULL;
 }
 
+static void viommu_clear_mapping(struct amd_iommu *iommu,
+				 struct amd_iommu_viommu *aviommu)
+{
+	int i;
+	u16 gid = aviommu->gid;
+
+	/*
+	 * IOMMU hardware uses the domain ID mapping table to map gdom ID to hdom ID.
+	 * If the mapping does not exist, the hardware would generate error in the event log.
+	 * Therefore, initialize all gdom ID entries to map to parent domain ID to prevent
+	 * unknown mapping scenario.
+	 */
+	for (i = 0; i <= VIOMMU_MAX_GDOMID; i++)
+		amd_viommu_domain_id_update(iommu, gid, aviommu->parent->id, i);
+}
+
 void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *aviommu)
 {
 	pr_debug("%s: gid=%u\n", __func__, aviommu->gid);
@@ -432,6 +450,7 @@ void amd_viommu_uninit_one(struct amd_iommu *iommu, struct amd_iommu_viommu *avi
 			       VIOMMU_DOMID_MAPPING_BASE,
 			       VIOMMU_DOMID_MAPPING_ENTRY_SIZE,
 			       aviommu->gid);
+	viommu_clear_mapping(iommu, aviommu);
 }
 
 int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu)
@@ -452,8 +471,34 @@ int amd_viommu_init_one(struct amd_iommu *iommu, struct amd_iommu_viommu *viommu
 	if (ret)
 		goto err_out;
 
+	viommu_clear_mapping(iommu, viommu);
+
 	return 0;
 err_out:
 	amd_viommu_uninit_one(iommu, viommu);
 	return -ENOMEM;
 }
+
+/*
+ * Program the DomID via VFCTRL registers
+ * This function will be called during VM init via VFIO.
+ */
+
+ #define DOMID_ENTRY_GDOMID_MASK	GENMASK_ULL(61, 46)
+ #define DOMID_ENTRY_HDOMID_MASK	GENMASK_ULL(29, 14)
+ #define DOMID_ENTRY_VALID		BIT_ULL(0)
+ #define DOMID_ENTRY_WRITE		BIT_ULL(63)
+
+int amd_viommu_domain_id_update(struct amd_iommu *iommu, u16 gid,
+				u16 hdom_id, u16 gdom_id)
+{
+	u64 val;
+	u8 __iomem *vfctrl = VIOMMU_VFCTRL_MMIO_BASE(iommu, gid);
+
+	val = FIELD_PREP(DOMID_ENTRY_GDOMID_MASK, gdom_id) |
+	      FIELD_PREP(DOMID_ENTRY_HDOMID_MASK, hdom_id) |
+	      DOMID_ENTRY_WRITE | DOMID_ENTRY_VALID;
+
+	writeq(val, vfctrl + VIOMMU_VFCTRL_GUEST_DID_MAP_CONTROL1_OFFSET);
+	return 0;
+}
-- 
2.34.1

