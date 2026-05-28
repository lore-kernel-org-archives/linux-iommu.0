Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010054.outbound.protection.outlook.com [52.101.56.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B856831A81C
	for <iommu@lists.linux.dev>; Thu, 28 May 2026 05:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779945549; cv=fail; b=JZsOyH5tgOqhIhDLyKyzo1r8o4twfWBA/kK2M3KpdgjMZxDtdnipOrpI0AehbjZEcQYZEUXinUmWtOaHHKtTeZHA7tkL8FwZni50+0g9hfOlIulybclQDudn9zR6vDrJzoT5LHTGg9ahd6TrBVyAiFuGR7ZgIy8nUYBKGUh0Mv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779945549; c=relaxed/simple;
	bh=WDvAmfDnJxVobOAnNbX+1xWUmqI/DmbyTr3NKvFzAbU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iblZWgKssEfeckVUohBFY/X3tw77F/shHxy4u9GebgmNcajGogDX59JQRCli8DOc1I2PumKwYJhkcmgwmvRgkgHRoBK3Fd9KaM2/V53Toyx30UegrqqZzrq7Z3HV9FwN1GijOqtQBw5Jq8160gOeV6jpP69Psl0Jai1tvWV/GTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QZ9sssmK; arc=fail smtp.client-ip=52.101.56.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QZ9sssmK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SqP9bo+SwXpY8bc6/pGt1XbXaGfKi7cqrx1ZkjwI171OT6jPJo5jNHr3+6GcVggek26EK0yt3hIHWWsXZvGPbydJhgml70V7b7xcXFpmhxgwbGuKHRC6ucIiOxFicitKCmDtwdo62+ml4EKCL9O3cPPDt1BenCRJmf3OPLOg5eQe22U2Q2onIh8ymPrlyvcszLB9Ix+f/DF8WA7RS/CItw45F6lpwfWhaa2PJWvAVDXzE6GaJxvph/WRIwGuBZPff5Xe+PWehky+jmCqct9nmd2Ef/jnzCVUuajhd42r+kD8HmaXMuUf3MWvJHP995yG1CWY3VJ/6z6WRasa65T6dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8yo0JtAdv8/uFI/iVLG0iSq3jQ3GB4celNpGqod1Xc=;
 b=JWtXqo55A5P7PpKmkJ8djx6D0LzjFWZ+j+4/ZHfURBbwxbnklXcFX1LatNbwqsi/QwA3iG86oOQlTBtXJGxuBOZ0hqjXgporSZ2q2+f2ckXPPPXofl/EHd3KnFPIe5RO37fmzyaeSx5MH7MsKFdZ/bPnUxUsFOl7pNfEawUTUsy1vEjo/uU+wMEUMkaC79M0yWV0IVQVa3ZBfM9ksNc/vdonDrMEdpo6jVIDeXKMaIpXzwfh86hrPtNpKNH3DPb0k03Jubc9qNb+0rE+HGjdELSpNf7+D8LrNR8Ex6B9c7zVR/pu9fsDFwc2H+gLA9MYgzG5QcYisyz6V0bPP4Tj2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B8yo0JtAdv8/uFI/iVLG0iSq3jQ3GB4celNpGqod1Xc=;
 b=QZ9sssmKQ2TMjPzwV1c/IZl0k5MV/XFF8VUC0koEhfvUBcrLxAI8BpOXhoNgxaJ/HAFCk+GEzyrWWyRMFadJV4QfdMjTK83OU+YyL+aNKNHJM8s0dkx4glk+pc6uiow1IImaU9w+WSUhdIaJ/mGNz9f39A2tM+RH4cEmn5fnci4=
Received: from SN1PR12CA0102.namprd12.prod.outlook.com (2603:10b6:802:21::37)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Thu, 28 May
 2026 05:19:01 +0000
Received: from SN1PEPF00036F40.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::1a) by SN1PR12CA0102.outlook.office365.com
 (2603:10b6:802:21::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Thu, 28
 May 2026 05:19:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF00036F40.mail.protection.outlook.com (10.167.248.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 28 May 2026 05:19:01 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 28 May
 2026 00:18:55 -0500
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<joro@8bytes.org>, <jgg@nvidia.com>
CC: <yi.l.liu@intel.com>, <kevin.tian@intel.com>, <nicolinc@nvidia.com>,
	<vasant.hegde@amd.com>, <jon.grimm@amd.com>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jay.chen@amd.com>, <wvw@google.com>,
	<wnliu@google.com>, <dantuluris@google.com>, <chriscli@google.com>,
	<kpsingh@google.com>, Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Subject: [PATCH v2 12/26] iommu/amd: Add per-VM private IPA alloc/map helpers
Date: Thu, 28 May 2026 05:17:24 +0000
Message-ID: <20260528051738.596013-13-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
References: <20260528051738.596013-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F40:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d1df9bf-4df4-4447-60bb-08debc78a0d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|1800799024|376014|82310400026|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8MAgQ+239AiqoP8BgmT5fsNuTTn/9Mh8yDFPuaiLjh9CJ1KBIgHVwXPAThsGBGNxelVFaGVxt0bKEoqjaaGzI6puAVIFye6NsDfl76mJ2+IYgZWUJ6tT2FOAllFJwskI7AAWnOWholwiidqkCGcjZRBTSAYOwgQgQ7biL6DqZxt9Y8jquCcT2cs5eyaBX0QBlp738dUrkH4fI5dq7WEquxEl1iyBl6Rb/h+aU0EKeE9EVJIK28WCt4qv4Gp1M1+l1jggK6vnOA9S9oQXy134HIwoOeE39iDAGc+2CgtoOLp5eFB0Pu7V00nYMInO9p+jalag5Jxy9CLqUdlrUu0KYBCMVuTDr/SyA3sJ+zrMkQUuV4YeylKWXg9JjLDNJV1zK2JEGlLCpWkfMimamFrLZb4rh7opnfXfNjbULexdjzY78bLQYSVcz/GvTPcFDXVMqNvsp8WKmc3b6/A2GLqgeIn8p87EYu709CLkjrRwyLeEzNlG0c3DpeioIorS73fFgK5bVf+GUIr7MtxTohZ8VPq+WiJito40u097DhZ/T3ZihzaM1dXsxDvNxCiAmv0+jvWCVDkkLASH2CYZw/+TAEnfrgvwbkpZd2q7kyka6BHobOyCtsQr+EHWWywTRkFw/My+Zk2s8HTIAmcleP840vkuY3Vbws4x8JD7CWMOvGAvGNCBvEqB3nmzWAimfISAvHBmw+dg8Sly8YzXRSOZTDSIUHxi2c4t/7oz7HYU0es=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(1800799024)(376014)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	oQywkFmqoUj4xql6boH36DjnBmJd3NTnWJYMsmKt1GoBZaDMY6SOaOhUOhaZF6rDIvbNDu2HTp06Lh8IMMPYnDZo/4DRZ4z1fClqovKe4LBydKJz6Yd8muw244kc+w4NotM4vfVsV29f+v+WO9dpFE1RkQPFMnqLOvcNAxgLAEz4sUZlkcHMih8x/N/a9GA+IzMtO4dO71QtHXWyGRJtdk/4Ve4JGkW9j9KHLvplmt/jguYeh1t8tyA0ujjmfN0pDlkf+YlwTRno08mNdn/pdeGaTk0gnf7oSSqEyU5KZH92XqczpEqGUVeb+6bhcBfl24Nr2ckY484rQS0kokIcPQiTCkA4TlveTFx5gdvJvFa05J//QPH4vuWc46sYisXt9giVX8Jh02oh8OVNXDqSHk8HX5C7VSME8frrh+X/J0Gt8WqGQFzIsxKnueANKG0R
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 05:19:01.2746
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1df9bf-4df4-4447-60bb-08debc78a0d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F40.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

Guest device ID and guest domain ID tables use dedicated slots in
the vIOMMU private address (IPA) region, indexed by guest ID (GID).

Add alloc_private_vm_region() and free_private_vm_region() to
allocate backing pages, map them through viommu_pdom, flush the
private VM mapping, and tear down on VM destroy.

Export amd_iommu_iotlb_sync() and use it for nested domain
iotlb_sync so nested attach paths can flush gathered IOTLB state.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>

---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  4 +--
 drivers/iommu/amd/nested.c    |  1 +
 drivers/iommu/amd/viommu.c    | 59 +++++++++++++++++++++++++++++++++++
 4 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 7c725e032d20..304cb9093249 100644
---
 drivers/iommu/amd/amd_iommu.h |  2 ++
 drivers/iommu/amd/iommu.c     |  4 +--
 drivers/iommu/amd/nested.c    |  1 +
 drivers/iommu/amd/viommu.c    | 55 +++++++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 279f458becda..1d8727c16840 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -105,6 +105,8 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
 void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
 				     ioasid_t pasid, u64 address, size_t size);
 
+void amd_iommu_iotlb_sync(struct iommu_domain *domain,
+			  struct iommu_iotlb_gather *gather);
 int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
 				      u64 address, size_t size);
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 8b441f68bc47..e0433e65cfa5 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -2729,8 +2729,8 @@ static void amd_iommu_flush_iotlb_all(struct iommu_domain *domain)
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
index 5b902598e68a..15dc57cf7c5f 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -291,4 +291,5 @@ static void nested_domain_free(struct iommu_domain *dom)
 static const struct iommu_domain_ops nested_domain_ops = {
 	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
+	.iotlb_sync = amd_iommu_iotlb_sync,
 };
diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
index 90ed2eb92aeb..6dcb02b12a28 100644
--- a/drivers/iommu/amd/viommu.c
+++ b/drivers/iommu/amd/viommu.c
@@ -297,3 +297,58 @@ int __init amd_viommu_init(struct amd_iommu *iommu)
 
 	return 0;
 }
+
+static int __maybe_unused alloc_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						 u64 base, size_t size, u16 gid)
+{
+	int ret;
+	u64 addr = base + (gid * size);
+	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
+
+	*entry = (void *)iommu_alloc_pages_node_sz(nid, GFP_KERNEL | __GFP_ZERO, size);
+	if (!*entry)
+		return -ENOMEM;
+
+	ret = set_memory_uc((unsigned long)*entry, size >> PAGE_SHIFT);
+	if (ret)
+		goto err_out;
+
+	pr_debug("%s: entry=%#llx(%#llx), addr=%#llx, size=%#lx\n", __func__,
+		 (unsigned long  long)*entry, iommu_virt_to_phys(*entry), addr, size);
+
+	ret = iommu_map(&iommu->viommu_pdom->domain, addr,
+			iommu_virt_to_phys(*entry), size,
+			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
+	if (ret)
+		goto cleanup_mem_attr;
+
+	return amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, addr, size);
+cleanup_mem_attr:
+	set_memory_wb((unsigned long)*entry, size >> PAGE_SHIFT);
+err_out:
+	iommu_free_pages(*entry);
+	*entry = NULL;
+	return ret;
+}
+
+static void __maybe_unused free_private_vm_region(struct amd_iommu *iommu, u64 **entry,
+						  u64 base, size_t size, u16 gid)
+{
+	size_t unmapped;
+	u64 addr = base + (gid * size);
+
+	pr_debug("%s: entry=%#llx(%#llx), base=%#llx, addr=%#llx, size=%#lx\n",
+		 __func__, (unsigned long  long)*entry,
+		 iommu_virt_to_phys(*entry), base, addr, size);
+
+	if (!iommu || !iommu->viommu_pdom)
+		return;
+
+	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, addr, size);
+	if (unmapped != size)
+		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, addr);
+
+	set_memory_wb((unsigned long)*entry, size >> PAGE_SHIFT);
+	iommu_free_pages(*entry);
+	*entry = NULL;
+}
-- 
2.34.1

