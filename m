Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011008.outbound.protection.outlook.com [40.107.208.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424961A08BC
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011221; cv=fail; b=rD34GfALHaDaaY+l/wNE/oTGfajwBadKybvjGnfg4Pquy3LgifQgzzmvHZcsZCtzYH3yyzH2+UEaxPl6o1meynRzpdFTq3vhjpDIJ4LQ4iowrMSwjkzs1QjQmJJFbW2dNuADrxTb1hHIUb4ah4oRo5Id8GpUz/JkEFt17rFgtT8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011221; c=relaxed/simple;
	bh=rRTSqjuUd/UHbwIAVdG21Xy7oKYbL6lrghFgjgjmzns=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tyMFCB+YLp4uCHK3nb0VuLMvwQ3skF2D8cTs2IBvRnVog5m4K+9GDvcXmjAjvSALsymeW0vMPPCFzi7n9MoNPpn1vPCGh9Vk/8eRLYp2tzTRwH2WNXYzKLlrNu9iS7PEUyRxR33fdCT2Sj9o83PMcTjxfPirJLI2HHL0eSAcau0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZNFREQEN; arc=fail smtp.client-ip=40.107.208.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZNFREQEN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IAm6OGFuISQcsZcF4C1k83rEzthcnjJGnwYxC4Y3ps3Fqs0HOP2tFBvqRw1mvKfOC+7wMOJoW6kgj+wWyER9njQX2nN3tCCgZe1hFg8DCyr6EfhrPD53O3YIxrSqZaj9s7iw1HA9oJl3w9rHlYpuq8Yh6t72vn3yBE9ufqlcCVZmbMkll8PhaLv44U4YzdBeUot2pHpiMmPM9yAhbojZZtdGvg5studg68k1fVPxVKIITWmcLDScTPpbbRQ2+e6HkzunR+7/iOsLzALCs8lpySZ1i7sdFklQwJ7JSuXeX7/k3A0AoMZqV8QjlRkhqd1gxsWMdzUwB3be+op43R8mYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVQuOXhh8h+xvdbWpe4RLTcqcyGmvpKhTwwIsT0E8DE=;
 b=AnCFZn/eH8WWGH6z8GDj+FKYpdYsMa8DBQlwOxaDjg53AWQbWS9SZ9q/pCZboFkJbiFRtcayWMw/DSpBeAlbv9jfRxByIr8CvY4rxUqwdydDD5BYsaJ3IuQllDtcG1uVf21KNF2p1ciasis5SW9YrchZS08FSk/3VX6tGjLc6eD2zR5LiVwmDuQ9vdiJIjreoOJyMVnBV9dXz7sQXvDdbygTr85NwGOQpI3VUYr0vidYps7UkSnvBA9brY71FWiHGR7oAznuBA2eApTxdy2txfeM3DCvXidcBoeeaJ1jq7qCTSM0anWbsmHKpseZCeeu+SfsmoEXbEW7ikqyGP9B9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVQuOXhh8h+xvdbWpe4RLTcqcyGmvpKhTwwIsT0E8DE=;
 b=ZNFREQEN1TEEWy9P/O9Xzu2tee0zI/FLhbJwc3iLt0QsqeD2wSSuU6AilVvppv4jFbJ+tW1o88rB+6w4rQdW6yuoBbHzejo8PCqQ/ZN5p1PSdUCh3X8r5t7eiSwWf34zHu/+/pVGnprSKRJyjznpMMkIa8ck3bRbEAMn+WHDp38=
Received: from BN9PR03CA0878.namprd03.prod.outlook.com (2603:10b6:408:13c::13)
 by DM6PR12MB4388.namprd12.prod.outlook.com (2603:10b6:5:2a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:45:33 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:13c:cafe::55) by BN9PR03CA0878.outlook.office365.com
 (2603:10b6:408:13c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Tue,
 21 Oct 2025 01:45:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:45:33 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:45:14 -0700
From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
To: <jgg@nvidia.com>, <nicolinc@nvidia.com>
CC: <linux-kernel@vger.kernel.org>, <robin.murphy@arm.com>, <will@kernel.org>,
	<joro@8bytes.org>, <kevin.tian@intel.com>, <jsnitsel@redhat.com>,
	<vasant.hegde@amd.com>, <iommu@lists.linux.dev>, <santosh.shukla@amd.com>,
	<sairaj.arunkodilkar@amd.com>, <jon.grimm@amd.com>,
	<prashanthpra@google.com>, <wvw@google.com>, <wnliu@google.com>,
	<gptran@google.com>, <kpsingh@google.com>, <joao.m.martins@oracle.com>,
	<alejandro.j.jimenez@oracle.com>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>
Subject: [PATCH v4 16/16] iommu/amd: Add support for nested domain attach/detach
Date: Tue, 21 Oct 2025 01:43:24 +0000
Message-ID: <20251021014324.5837-17-suravee.suthikulpanit@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
References: <20251021014324.5837-1-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DM6PR12MB4388:EE_
X-MS-Office365-Filtering-Correlation-Id: e0eca188-1080-4345-5dd3-08de1043867e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?d90w2BABBbDnAXC5wffRokb/3uHNv5gn25d5gQr/A5Xi3iqMCZhvyYejFJW3?=
 =?us-ascii?Q?8tXefy59Ia6/88PA9u+3RTzBC7toLa4GXFwlaiR6WaS2X4qowwa4JrIXwS8b?=
 =?us-ascii?Q?O0sVPF0wdY5eI65WDrG2B1DemKGdhdkCv23BOIgq5LEfgbwWSZWE9j8uol5F?=
 =?us-ascii?Q?ZVPo3JQmhJ27+t6hKTds21ikIL21ccxAQANFL9xpaovhDasgChFNczO0RVHL?=
 =?us-ascii?Q?e15aOsUYwDw51Yd715I453x7H3ZRiekN3ggizEBrks+IK6jSB+Bzu+rx+JXn?=
 =?us-ascii?Q?MW1UrRnb87usWBk4OhrR0/qdeA2eQaQGnrbycgZZ/TEXwjrLMhH5G7ckrk/j?=
 =?us-ascii?Q?BWyFNw9eXKWYsXoZhtPDqOScOyc9g3VMN6u1Flgi/V/I4PQjezxgq+Laq4DU?=
 =?us-ascii?Q?oagyGUM9w/i48TjggMdrFekpawurr5KMSGQBYKUFSULZ1DxvvWFk2U/CgRBz?=
 =?us-ascii?Q?ieCwlyXPkhUwmi6scM51ZS8q+AtAlGxNa4Yrisukg3fnebBHDnHRfR3GQrJ1?=
 =?us-ascii?Q?JCuNeFtzygy8WB3u2SronbVcpQMLvouO0MW8+kC6mhEtBuDoEFdbwGazKFcN?=
 =?us-ascii?Q?fnQjNYe0440084OidLGnv0PgRi48zl1gyTqzs88zQyIh8DYTBydcSIS+ier/?=
 =?us-ascii?Q?Ie6W629A6nUGND+Y00hk+uV/soadrDglSFuV78k/FRMHrfnjmnS9ow+sQwFJ?=
 =?us-ascii?Q?5bnaVkyZlXhvrh1/0nTeA1YNBQKHCmGhQ6gB8c+NQF4OmljC+SJnb8wSsOv3?=
 =?us-ascii?Q?oFrEUc1YdX5ypv+51lEdFh1eEHs1E1ZMy3JPJ+qoE0V/3XqcQIbvOTEjDB49?=
 =?us-ascii?Q?z0nuAlYt4TV2aKA/UK0E3xV3p0X/+Gem/nJIICKesZyqEoaoyzHCGTQermd1?=
 =?us-ascii?Q?BZdmTnBfGPUgCNgBtY50ZWSlpw4CC36Eu9oWtO/lKDpoiJuGPNiOWTBCNNpD?=
 =?us-ascii?Q?9lzMGodUTBuXERU4sWnihHFdsGrkc1dLfsS8bF5ZvuYthKpNYb88KlI7dzj0?=
 =?us-ascii?Q?U0/sDLUYwS54p/cVo0MJPz1nMD1UgCYmaf/PUVmaQxOeShBtrtEr7QuNYFmu?=
 =?us-ascii?Q?Ce3911TpMSyJsIBTKEzJIV8h03t4TWP+tq/N0ZpmSmSt/58fvuAq1FaU+sh1?=
 =?us-ascii?Q?qftJeb+iKXNqjVMm+lILQo2JVD/8fX9/t28gFGwErSUUf9acf19OA5+TkKwN?=
 =?us-ascii?Q?ddEdT4jhANAnD/qkxrIHK7xg4cg42zyAeOdAl6+JOMfJC3io+tLlgAoVYaU8?=
 =?us-ascii?Q?1NEL3QxalRMii7YpjtvQwd258puF6liTV6pXp1OG9/UgJzLeL68Fpcq0qXxb?=
 =?us-ascii?Q?f5Ahx1WiNo3c38hRNcSDKFr8ndmdY2NIM+TxXH3DlOHJ3X1CD8ll9TzILz4b?=
 =?us-ascii?Q?Nx8FOQEA8NvSlfYSUk54jXdIh2cDXIIMnzIdOws5T+NsfkESvat4jy5B/Wh4?=
 =?us-ascii?Q?xoEDXNi+MB9rrH9KuRU1imbLDPiRSydjAWHGPCwrbPzjTUUju+mkF3wwC55m?=
 =?us-ascii?Q?uUVPcWM57jLQm2CqPJGFei5iXau3uK1rl+NTSqbqM5JGlMRcNzARb3S8GLgP?=
 =?us-ascii?Q?BiK2v+iGN6Ya3LdunpM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:45:33.8035
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e0eca188-1080-4345-5dd3-08de1043867e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4388

Introduce set_dte_nested() to program guest translation settings in
the host DTE when attaches the nested domain to a device.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  1 +
 drivers/iommu/amd/nested.c          | 71 +++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 09952b7a256d..243dc1dfd394 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -421,6 +421,7 @@
 #define DTE_FLAG_HAD	(3ULL << 7)
 #define DTE_MODE_MASK	GENMASK_ULL(11, 9)
 #define DTE_HOST_TRP	GENMASK_ULL(51, 12)
+#define DTE_FLAG_PPR	BIT_ULL(52)
 #define DTE_FLAG_GIOV	BIT_ULL(54)
 #define DTE_FLAG_GV	BIT_ULL(55)
 #define DTE_GLX		GENMASK_ULL(57, 56)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index 383a3c7b4a91..911ab331be6c 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -141,6 +141,76 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	return ERR_PTR(ret);
 }
 
+static void set_dte_nested(struct amd_iommu *iommu,
+			   struct iommu_domain *dom,
+			   struct iommu_dev_data *dev_data)
+{
+	struct protection_domain *parent;
+	struct dev_table_entry new = {0};
+	struct nested_domain *ndom = to_ndomain(dom);
+	struct iommu_hwpt_amd_guest *gdte = &ndom->gdte;
+
+	/*
+	 * The nest parent domain is attached during the call to the
+	 * struct iommu_ops.viommu_init(), which will be stored as part
+	 * of the struct amd_iommu_viommu.parent.
+	 */
+	if (WARN_ON(!ndom->viommu || !ndom->viommu->parent))
+		return;
+
+	parent = ndom->viommu->parent;
+	amd_iommu_make_clear_dte(dev_data, &new);
+
+	/* Note: The IR, IW, TV, DOMID are needed for both v1 and gcr3 table */
+	new.data[0] |= DTE_FLAG_IR | DTE_FLAG_IW | DTE_FLAG_TV;
+	new.data[1] |= FIELD_PREP(DTE_DOMID_MASK, ndom->hdom_id);
+
+	if (dev_data->ats_enabled)
+		new.data[1] |= DTE_FLAG_IOTLB;
+
+	/*
+	 * Use nested domain ID to program DTE.
+	 * See amd_iommu_alloc_domain_nested().
+	 */
+	amd_iommu_set_dte_v1(dev_data, parent, &new);
+
+	/* Guest PPR */
+	new.data[0] |= gdte->dte[0] & DTE_FLAG_PPR;
+
+	/* Guest translation stuff */
+	new.data[0] |= gdte->dte[0] & (DTE_GLX | DTE_FLAG_GV | DTE_FLAG_GIOV);
+
+	/* GCR3 table */
+	new.data[0] |= gdte->dte[0] & DTE_GCR3_14_12;
+	new.data[1] |= gdte->dte[1] & (DTE_GCR3_30_15 | DTE_GCR3_51_31);
+
+	/* Guest paging mode */
+	new.data[2] |= gdte->dte[2] & DTE_GPT_LEVEL_MASK;
+
+	amd_iommu_update_dte256(iommu, dev_data, &new);
+}
+
+static int nested_attach_device(struct iommu_domain *dom, struct device *dev)
+{
+	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
+	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
+	int ret = 0;
+
+	if (WARN_ON(dom->type != IOMMU_DOMAIN_NESTED))
+		return -EINVAL;
+
+	mutex_lock(&dev_data->mutex);
+
+	/* Update device table entry */
+	set_dte_nested(iommu, dom, dev_data);
+	amd_iommu_device_flush_dte(dev_data);
+	amd_iommu_completion_wait(iommu);
+
+	mutex_unlock(&dev_data->mutex);
+
+	return ret;
+}
+
 static void nested_domain_free(struct iommu_domain *dom)
 {
 	struct nested_domain *ndom = to_ndomain(dom);
@@ -157,6 +227,7 @@ static void nested_domain_free(struct iommu_domain *dom)
 }
 
 static const struct iommu_domain_ops nested_domain_ops = {
+	.attach_dev = nested_attach_device,
 	.free = nested_domain_free,
 };
 
-- 
2.34.1

