Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010017.outbound.protection.outlook.com [52.101.61.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3863A3B19D6
	for <iommu@lists.linux.dev>; Mon, 30 Mar 2026 08:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774860226; cv=fail; b=kZbUdP0g7XHJ4TmKoO0OMUtEfwC1QIGZb13BrXOt+N5omoCEfeSD+Tg6chmBCIjR7/DiwHYdcl6Nr4JnUXKAehAMyvPQ2O+xGGy0zb6JNXTU9RWPsbXih0alX8fa5lpiPxw3A6xRdQyP8Lj8k7gggShblDGqUKtP1lPno2vRk68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774860226; c=relaxed/simple;
	bh=EFzwQNZeNe+l8Uxi590qDy1MYkuRDqbkt7HksQ9w/HQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iQXmoz0u9VPwL9xbsCPgkYlHP2deKqeVc2qVelXYyNV7tvVvaEzLQWZtpoaPdTvroMdX6XB186T759GiHYQr/QVV0QxuMrhglXqzjAO0pxtRuy7VXpybeERoNmSXUD2wRVM4Tdr5D/Skpm75W8aKxB7TCZJS7m8Ha3t1HHLRt8w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dRNEejou; arc=fail smtp.client-ip=52.101.61.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dRNEejou"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a8PWoWXz13xeTnoddVDcTJ0H1yyTkxFAl7R7BwUUOthxrSPBj9tr7tkvKSU8nu5akx1YB/eQ3nGRkCyhsv9L0//xfpAyCfPnNpAeYUcOtXCqItM9+TXV2KsFK3+xuIaEk/x8GR15duN0QOtblDqsje/XzUisFpgZBaATfucTFmHgrrYUPpKbvKjXAOGlHgJHvngjoLjgVCXMW8IegTMHoJfQYTb0gUaFaXgHpGMAMUN9b4rGKKWyX3QieK4ASoUUT4B0rG7+mzfiQADzizreTjY5/p5BndK+PV/Ff/Tkhn0qB3mQ/oU8PN7p85lHYR9PgJzIkRM1MtWh4vz/QkG9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v08czBM5k+3jCbdjSty2HEjnT0pnPtwoVCARNMptc04=;
 b=pZw+I3TocX2kvWDfsCsMzvtBGA0vDMXLAx1PXwMKV7GVQMho+o890E6kTbIKNnjtucNMdpTiBxEXEuWJH4RNqmnipLraVtcMjxeJ2fwYJcDDheHBYnMBf6g26P+2JCab8xE8vpSRvBPgRSLpvuFU69hFDr0aIqtf0c0kojeAT+XmZlGKMaCY43yDRCV4oXSBZ/AzIY9FouAjGerAiyi5YHJCYZSE41CB8P4CKN3ZqJJLPOHZgeuUoozLvZpwpDx1lnL93rjlxkU2YG/fPJ2zoRhFHjw+PYI6NF19UA63Si/l9Zv/GXn/phgdnWMS3XCTUlhFjnJBpfavC3Pzg4RSCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v08czBM5k+3jCbdjSty2HEjnT0pnPtwoVCARNMptc04=;
 b=dRNEejoubOeDkxdXk/AaeCd4UMgUKLJ4bG1GIrGDZ1ItSbrz44hHf4QOteKL0M4NCatM6ugM+vWCNzgP78zsUoFHGA+iJrRf0NCbK1dmMfBjBeLOQ0frHMC7JzmC+T54rZSeum7GENZBu7CQ5iaghxgMpU4eDhcI2qMyzLpgMxs=
Received: from PH7PR13CA0010.namprd13.prod.outlook.com (2603:10b6:510:174::20)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 08:43:41 +0000
Received: from CY4PEPF0000E9D0.namprd03.prod.outlook.com
 (2603:10b6:510:174:cafe::8b) by PH7PR13CA0010.outlook.office365.com
 (2603:10b6:510:174::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 08:43:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000E9D0.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 08:43:40 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 03:43:33 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH 12/22] iommu/amd: Add helper functions to manage private address region for each VM
Date: Mon, 30 Mar 2026 08:41:56 +0000
Message-ID: <20260330084206.9251-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
References: <20260330084206.9251-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D0:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: c42c5af3-17cd-4dc9-53a8-08de8e3871bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|1800799024|376014|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	OGeiH8fKN2yaWkXFR9ekXwYAB9CQZUaLlbjcxY/dtc6lWBzPWUzmWAyyagMh+QobSMHY81+yVlIxJK70x8sn03TqGHbJbowIEUUpvAyoh4pWwMUSjkuIYShttwY5Uq5/HPQWh9VsUPNqWP2ZRByHfpoJq33u0CqFF6+vU4q1xb5pb94OrbWPiO54O8NjIv8tlMJnlcxkdcIYrOAb/VFAAD+PEINio9hIM5N1eMZnPhEMPcrurH/nUQwsUCmz8taDlk29W1G0S9Vhkzmk346tVUSfkv/SspmqbJZjsF/X5+RHgIqH4D0AzquElrhtAPU+Eu4iPr44sO8Xwm4PxiQTKd5TxDI2aBTv0rQIHXuhGnebbFbfpB/KDBDa4gyXYpzSo/8kzZiNXy/o3dBgHvAtyxpinB+rybJz2dtjogz0N88MW6cA5x5SUBA03ZD56eLc546nwMVpsICxnYzMOt71roYKYN1bKisv/SuMoByFZtFjSzxfxAli3j2Atld1/+DLIhZDG+iwmg1mTVh4Y3E+islL2KH4C2nuQaneymfZ026NwZU/Xsp7hkpUWNiCsmFjxTeShfkhjYhHYRLXsEtoxuIExRrBAS44eGqT7+8xDDJ1EIOsfV44mBOmpQNRdBtOXvDcWco4v+LSZm18ceGUZxO/WAVMlDxQvcpqIzWqk/2Ui2Ry6ng7RG08u2RwQZNdSx0NtMucsjsWdOlhRdH1TSUZ0I7KmPPvJkdZ50x3c91946vYVRIDgNCcKGVwSGu60C0vPHeMUfife+QfYzhy7g==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(1800799024)(376014)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LIYcZ6cYfZ1vBd5Z4vb4GYin3XFcwFf5axUN7pR/8N2IyTILqXWa4soMeWa6ywVBScJXnXoNc5v8H53iJT7gqwQ6N6cUxrcCUvyRKXdlrdsui3dLmgtkxKlAPJqVnw9QEsCbFKwRgq9VoJxTeYGf7OR3hQbNbuLtbC2scfGx3oj5x3vyrhrUEL8OaOAT3RDiUUuEZ4YCV8DWFhFtML1YPzFVeWQxYLsL+TmdXU8hNjYYIwU59XXM3yu1KQYPXo8HeF6mJVD+OF/UuY8i+mYkLK2/id7Zxe3mmY02xqtX+dz9C+cB6+D7m933PFZ4t20OmuQXB4L9X1d33zpTjcLP6+hmpq+YV/aV+UwS+NzHbVCVfUiFVuJpVEr2CA92UgTL9l6lVdVn+r8XxmYil85kU0dlzjJhd86J0Fru+XFoTaE4ZSUm7QOdrMJCElNuMwPF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 08:43:40.9990
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c42c5af3-17cd-4dc9-53a8-08de8e3871bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311

Some parts of vIOMMU Private Address (IPA) region (i.e. Guest Device ID
mappng and Guest Domain ID mapping) are managed per-VM during VM create
and destroy.

Introduce helper functions to allocate and map, free and upmap per-VM IPA
region.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  4 +--
 drivers/iommu/amd/nested.c    |  1 +
 drivers/iommu/amd/viommu.c    | 52 +++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 9bf07887b044..b5a54617a9a1 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -100,6 +100,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+			  struct iommu_iotlb_gather *gather);
 int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
 				      u64 address, size_t size);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8143cf03dcc1..4be3589b9393 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2723,8 +2723,8 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
 	spin_unlock_irqrestore(&dom->lock, flags);
 }
 
-static void amd_iommu_iotlb_sync(struct iommu_domain *domain,
-				 struct iommu_iotlb_gather *gather)
+void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+			  struct iommu_iotlb_gather *gather)
 {
 	struct protection_domain *dom = to_pdomain(domain);
 	unsigned long flags;
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 66cc36133c8b..c210b8003fd5 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -291,4 +291,5 @@ static void nested_domain_free(struct iommu_domain *dom)
 static const struct iommu_domain_ops nested_domain_ops = {
 	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
+	.iotlb_sync = amd_iommu_iotlb_sync,
 };
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 27179d5087bc..fbc6b37b2517 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -283,3 +283,55 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	return 0;
 }
+
+static int alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+				   u64 base, size_t size, u16 gid)
+{
+	int ret;
+	size_t mapped;
+	u64 addr = base + (gid * size);
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	*entry = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
+	if (!*entry)
+		return -ENOMEM;
+
+	ret = set_memory_uc((unsigned long)*entry, size >> PAGE_SHIFT);
+	if (ret)
+		return ret;
+
+	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
+		 (unsigned long  long)*entry, iommu_virt_to_phys(*entry), addr, size);
+
+	ret = pt_iommu_amdv1_map_pages(&iommu->viommu_pdom->domain, addr,
+				       iommu_virt_to_phys(*entry), PAGE_SIZE, (size / PAGE_SIZE),
+				       IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL, &mapped);
+	if (ret)
+		return ret;
+
+	return amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, addr, size);
+}
+
+static void free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+					u64 base, size_t size, u16 gid)
+{
+	size_t ret;
+	struct iommu_iotlb_gather gather;
+	u64 addr = base + (gid * size);
+
+	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
+		 __func__, (unsigned long  long)*entry,
+		 iommu_virt_to_phys(*entry), base, addr, size);
+
+	if (!iommu || !iommu->viommu_pdom)
+		return;
+
+	iommu_iotlb_gather_init(&gather);
+	ret = pt_iommu_amdv1_unmap_pages(&iommu->viommu_pdom->domain,
+					 addr, PAGE_SIZE, (size / PAGE_SIZE), &gather);
+	if (ret)
+		amd_iommu_iotlb_sync(&iommu->viommu_pdom->domain, &gather);
+
+	iommu_free_pages(*entry);
+	*entry = NULL;
+}
-- 
2.34.1

