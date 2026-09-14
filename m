Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010030.outbound.protection.outlook.com [40.93.198.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF539EF0B
	for <iommu@lists.linux.dev>; Mon, 14 Sep 2026 18:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789411788; cv=fail; b=DzoATATNpJMNMzxIKeQl9V57T5B4fcJDYjTi2ml3Z4Ph534qtv9GA6jLTKyrcLw+5rpt4adaR7wxP59ONf/9iVqRbRRd7K8Z9Wg9++0Gk2AIgRblx9fQ+FHkC2g3uN8gve4rP+ecl+ojGSMuS2P2sNP9b0T85jCBcMf/F69JOoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789411788; c=relaxed/simple;
	bh=B9Nc3TyWoBbNX2aoMwxyfOuAk1N0YyXhollmPZE849I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RDQ+unztEw7OGygAQegVAC9yik/E4Vo3psFBY6wkNtNrOtIasVsTDWA+Im0UzlpUX/vaDhS466/42Bmlte8UJCHEkrLiqxpjdjv6CaRsedRlecwivnL19vepvtl/Fnr/JABDCWxlo+/8n63MygxZXgF+9FEoMEZn/5gpvLJSOqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lKhwlnME; arc=fail smtp.client-ip=40.93.198.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lKhwlnME"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KdiPayfZLAEQrz4jZXh7acl4PduYYmz6DCgqqjaQbeXYqr99PcW2KXAxaS/o1fprNOH13lpSy2B0C4djjFE1O9RCjvfTTzLOmKau1AauGhJM1fQox8p+dGk7TqmgFO5ZGCVfYqirJ8Ta6gglSZhvC3jIzWDN/kIdFMbRErIIUHteMVi3IUx/DyMvg1zNH2RSKvwGmWuKPjVLmuog4EzdSCgbAhzUAZvGktHyf1Z0UVBGRKzEGmlxHQK49ILgIRUgFMnfIA4csacrAFglxxI4xp3gfwPRLvpANIlSE0PQp2sRI7I5ErrJ5+knQoKaZA89Z0vknOtK2GAASnixo6si+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yj6wb8CaUbARH7V4pjgJ0IH/JYUi0tTvWgDPWqG5f08=;
 b=U9NtZ8ZNbTsT8/l1Hi9t9PSpa2crzpxheta3xpGGkptJHi3VUvjmqUeyK4bS+UPyz5MltSU7hpYk1BK3HsJA5Izib+PCO1oLOGr/JgWBvB/Ec8KnH7ir+t3Gq1tPzbuiNbkIvp+8qqjPOSCxtOrRwI7/YuEHaWrQuOkqMkQayQawBZwBOn7D94M7hfkRgm0pLVZOMYUbN749TGhoxl+Z4EsSmsyuit6GjnsJpZo3D43/RbSJ5Uk71ogcss5aqIDaLGTwCovwcQizpz03l5AdCQwYXBDOLIRbHtmQaj9vKYNkA867Du8Jt6k8Anenu3u/R1UMgsu2gvuxGF0W/UbK0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yj6wb8CaUbARH7V4pjgJ0IH/JYUi0tTvWgDPWqG5f08=;
 b=lKhwlnMExzZEHfrbKA6tR8L4ifXve4YfHFTyrHCQKHla+RtAN/ZBVVGmEZFlJ3vD71uuwkXLx7mFD/3kmTRIbl/FN49xbNkC0DOR+MqEn8PftFrt4HHz1XS9nt5HR1JHfUGJGmMKUV0t07wpQ3w47ae2UPQHM05hEs7iDmvCb6g=
Received: from BN9PR03CA0207.namprd03.prod.outlook.com (2603:10b6:408:f9::32)
 by PH7PR12MB8778.namprd12.prod.outlook.com (2603:10b6:510:26b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 18:49:42 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::8) by BN9PR03CA0207.outlook.office365.com
 (2603:10b6:408:f9::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.12 via Frontend Transport; Mon,
 14 Sep 2026 18:49:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Mon, 14 Sep 2026 18:49:41 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 14 Sep
 2026 13:49:35 -0500
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
Subject: [PATCH v5 14/24] iommu/amd: Add per-VM private IPA alloc/map helpers
Date: Mon, 14 Sep 2026 18:47:40 +0000
Message-ID: <20260914184750.222939-15-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH7PR12MB8778:EE_
X-MS-Office365-Filtering-Correlation-Id: f6511491-1a50-4106-e63b-08df1290efc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|82310400026|1800799024|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fM6gC6m7AB7CMfFSCIHLWmoD37oWlZD5VaMBiH/ackZfgQwB54TlGrn01a1ISbguuFLxlDTKGxHl5Ah8y6xaIQWr5lZHyJKtoF5c+fRWqn/zQdE9r0Z+XdusnpL227AWFcyG4PZqTTy8by7eCe9d8qrJruqttxlD30ILX5una9GIRDiCO6tykELj+NgIaR0fide4blBe1tYZyYRlIjFbzkGIWCwytNv4rONbiIk3l/B6jSzWNBhbk/1t69stE+iZUe+vaIwp+kezfTyUR1LqWYQ1u+OLHiswOXkdS83Sm76CTTOpOd4/unN5Jq6ezuycA/gm+4Sju7NuNWjngn0+XKcIgJSSQHKcss7PyOEypLh7P9vtam7uGBJojj6P3izDggQWvm8ZcKEVmsCdGCOOFMeJSzemfvIqlJFhH3PnDDiFxIG4xJNeS80hxbMpGVJDTVyrxuWFgykbjlq6W2zUZsShOZt6v7LEFaTN9H/43Ao1+OuiY3zfky1hHesDNdIBPObKnxkl579WfN3lcZIwk80oeYxGv8RxskMidiv8k/p3CYfRWDUhuKzlK60cVoiqF2v5Lda0dccL9n9alChN0fR2GF1MGCWfU45BibyA6Qq2hCIOwrgvrx9meVmC8lX8gboGC/ZyG76mKQfbaM/vzNbkzr6QlMNLzhrMtDJeZW6LTjrDsl/hL57zuyImZhFRW61q7qh9bYSKD9GrCsQK/A==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(82310400026)(1800799024)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	RokPEriA7Yv0+SYGZg1ToW8Mt3zN10qELbUUUvrG8O/f+P/EfMuDMox9s8hCUDepd0PMRnIcas/q987Y3O/MLvzaMmtNOnoHlEZDRTVIRd4wvtogBGT0q+xA9gmgsilBhWCmix+Zqd1/pGN5tMvzj4nYQF6I/r6evQGPY8a4OlsVWheKnqUetMQwielX3iRzCYH9WNJrKjF6+UhmJoiJICuE1qfWgls07Gv4DBTfU1UDQpTI1N2iciipKRCY7lA4gHScTCbLCYTHPKkE+wBCqQA0EVJ82LWYAjjjutM06u4xhbr9ZTS9JiDIFE76faByHaV57bavZyQAYIugh87emHV7LdzvqC/TcigJ+4axaWb8U1FocBinp7MfjEl1wRe71pbRuZTziNcuXSrsTTOXSWlEY7HgsTK3SHxDQL2xTdCMPKR1ZxuI9z+zf9ZRFSeF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 18:49:41.6443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6511491-1a50-4106-e63b-08df1290efc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8778

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
index 3ec907a498c2..ad5f754f25a4 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -373,3 +373,42 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
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

