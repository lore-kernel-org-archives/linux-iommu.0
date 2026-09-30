Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013063.outbound.protection.outlook.com [40.93.201.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40EE4746CC
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790760352; cv=fail; b=s1YwvN4f0UQKkbNGNwv0p7tUxi/4N/qrDkNPO6HDs6uOK5oz8VjJwFHQ3qcbTSBrLa6JPQtH7+JF+GpfixauUUwZxS1SOxWrr1f0NYzZheZOF/0ldj3PmRXEjtwI1YukDl36rvuXP1nW2k0i8wR8uywlvQHsWITFpuHF6J3Tg+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790760352; c=relaxed/simple;
	bh=E4Tqo+1mK4oEuennHtt2u9JDFZ0M62Q5IlZ9D1CcJfw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM17LBGOS9th7Wy7Nmj0D+jCNlOdIAyzY+oV6GGfDxDJx0Mn64G0r4xPUjDKHgEKPrP6+CZkfHdQtKYOhDvsZsaR2+LiuUy/IqrurXVeCS0nAP9auOSU0D5rn2MCIHnPdXRfbljAKJCUrQUROepyWDamo2dYZoF6bvrmabSqtbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w07ZUeZq; arc=fail smtp.client-ip=40.93.201.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w07ZUeZq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gyLPYB6z9dsowfcreKv0mZ0Bne+E/A3jT12AqdBs3TYWiTzq542CjM1DkTOa0NMULaScAw0P5C7kaRJGm/KbxJaBulEMlbxni1ojNLSNU8vMJl05XlRjc0XIz2PB3AU3OxOLVwxDjAtIHSZ71ZDZ/jfY31CIdmwNXNR8/4r8b6FAO2GCi1Av7wYM2qn3jJTR+lQQEhrJsIlOXc7ak5pM0DQCBySNMZiZcDg5FZgpDEYcRypmOe+T+EAOoBd19QnEES2UPhNrsw81CoAF/1tV/xZnj7C10xX6BtXH8nuZPtnDExCRu6iVtcQSldy32iydPbEV8e1BRNKlLwawea1CZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z8tblPWrhH9PEzcb8NRRQxL1PHiiD5cZu/9fRl+BG+M=;
 b=DSPyrQaxMgjH4EP0H+K3/rMa9h9yLQVcyxODrSYNdaC8jAKJzIZ/+POBybEGgXVScmAlb0XLimeHldWLQFdsq94chmesoxlYp7jM8jjusHjbB6PkXklGw5dk3qZK/dcLESEaf3+KErYJlsokgvEWVffsdvJbIPo4PFfYIqrNPlJe25sqh0YhIBS4n0SaqxUxDfGX8l3gXxOeaNndgFNUh4+lBhjbTPhkXW33Y590PhhUIts8oitaarf9IiSVjPrh1D9x5iMUDccrKBw/KpYFIPIRjKHyKsHbx2/5jfe8iXhtYbNBX5Hiez0YugkemnCGd1OvchrrNOjadCkKat011w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z8tblPWrhH9PEzcb8NRRQxL1PHiiD5cZu/9fRl+BG+M=;
 b=w07ZUeZqzTHaUT2vQJWeg42wUqvAzP2HfqoutWgzVAl1MEN5qeo/Kiv9O3gBST+pA+GCaukoMlqAB0o4ODEh+ACzGvdX0yQvm+xbLipNM2FRUHJkfJMBuofx2e29Rh4S5hjGiuEM2bYyN5EZWK2pVUUJgtw7SSk4PIqQ/gHX8yI=
Received: from PH7P222CA0018.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::12)
 by BY5PR12MB4321.namprd12.prod.outlook.com (2603:10b6:a03:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 09:25:45 +0000
Received: from SN1PEPF000397B0.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::a7) by PH7P222CA0018.outlook.office365.com
 (2603:10b6:510:33a::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Wed,
 30 Sep 2026 09:25:44 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B0.mail.protection.outlook.com (10.167.248.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Wed, 30 Sep 2026 09:25:44 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 30 Sep
 2026 04:25:23 -0500
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
Subject: [PATCH v6 14/24] iommu/amd: Add per-VM private IPA alloc/map helpers
Date: Wed, 30 Sep 2026 09:23:34 +0000
Message-ID: <20260930092344.5616-15-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B0:EE_|BY5PR12MB4321:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c688154-fa3a-4074-0cf2-08df1ed4ce0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|36860700016|23010399003|82310400026|11063799006|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	gpTxrHDw/+kKlNvNdQb7EFHrF4zEdtxtMLTQIMglapCs7MkgSVVAZay2FFrsfEyIoRZ6hP63YneFsJtneDV2W3dcaBP/tWv56kKbQQLKMRd/jzwiXbgswQihIEzpnMNY5tS9A2LKhIaaBUQUJgCv+gg955D5Sgky4lXumzZLhsxvOsFz1ZvPi2dHQcLQpDXndb/8z07IYEudJjH1EQtTpjQliiZz1rwMxxzcDuk5EcZutbXGm7HqPZFNv735nkcrYHhU02lgOxkXmQ0AuAf+kg8ey1iSzXrUEmyecp40aHObvHdswrDkmIsUxMntdCOlvr6WlJIc5CMLUEwBJSwaEYONr+q2KAVPKtEn06xNj7LjQQ+GU2JUyOtnyneYFOiSW1S33z6vR3VB2N9W2p4s/hD7oOJE6R2xQfQXMn3ZvEDO63/9IIML38rdXTdg3uuCSYaIlElMV8mFM2RS13aeJvKvIAdw562MJWm3Oqfu2KR5Ct/ruddxhTSfbZYcaqvQhLwri06q96BOT2eu/XHVzrWwS95cSMu1mzSBc6/cSjYkpDL71/U4lBVSBZMdCIEShDZxkPkHJJa1E8sHziKMrBB0PBDizOrpvomnt3qVKr/19tq3UGG+YlVMX/dMg1AO0nmtdpvXTad4KrDCOUNFj6Di+ENRAqm0/Ohk9blxKxk5TfOu591PHJYsLBIabwtj3VFi085TbJT8xIGkGS6spA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IFXHmUzvDE/M760Hy43Hym+Q4Ei7H2sujXD0gv0QOUMLI0oVT3ZhbTuRWoYKzRR0bMSz72Iohi1Gx/cTzEO+2cua/1iHIcM5C94Nz2gJPir6cop8CTk7M3RlMtwLP8/NtTPiTrnHyBKtFbkb5enXvtUkIY5PJzxY8Ra8S0mqPoQA6D35OcFQogzPi+PSfpxpQCJbDGQvAH+OfbMVI+iuZXfjjYdonZt/vA+ePOjs60l/03bHWHZ6WkufWK2+i4Bi4h+hEvKHI61okDNiqfRAcmtmh10wK7wD3VIOrpFFcbq2jYU8PiwXW/6yl1fXWV8kDaMGemVBiHj7Cn4gDWA7mrdFnNZ3uUXM5MyEaLkWf5lo/ShFga0oxIUsy4l8vY3GdFzWfp6qnHGQslyl/M4j6VlOfov0Snqe5LEGcYpius2yx+Kt7GThIOTPLbaUP42k
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:25:44.8528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c688154-fa3a-4074-0cf2-08df1ed4ce0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4321

Guest device ID and guest domain ID tables use dedicated slots in
the vIOMMU private address (IPA) region, indexed by guest ID (GID).

Add alloc_private_vm_region() and free_private_vm_region() to
allocate backing pages, map them through viommu_pdom, and tear down
with an unmap flush on VM destroy.

Charge GFP_KERNEL_ACCOUNT so the DevID/DomID pages count against
the caller's memcg. iommufd already charges the vIOMMU object.

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/viommu.c | 39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index e9554a3e9591..d80f545c0648 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -382,3 +382,42 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 	amd_viommu_uninit(iommu);
 	return ret;
 }
+
+static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						 u64 base, size_t size, u16 gid)
+{
+	int ret;
+	void *va = NULL;
+	u64 addr = base + (gid * size);
+
+	/* Charge the caller; boot IPA stays GFP_KERNEL. */
+	ret = viommu_priv_alloc_map(iommu, addr, size, GFP_KERNEL_ACCOUNT, &va);
+	if (ret) {
+		*entry = NULL;
+		return ret;
+	}
+
+	*entry = (u64 *)va;
+
+	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
+		 (unsigned long long)*entry, iommu_virt_to_phys(*entry), addr, size);
+
+	return 0;
+}
+
+static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						  u64 base, size_t size, u16 gid)
+{
+	u64 addr = base + (gid * size);
+
+	if (!iommu || !iommu->viommu_pdom || !*entry)
+		return;
+
+	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
+		 __func__, (unsigned long long)*entry,
+		 iommu_virt_to_phys(*entry), base, addr, size);
+
+	viommu_priv_unmap_free(iommu, addr, size, *entry);
+
+	*entry = NULL;
+}
-- 
2.34.1

