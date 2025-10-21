Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011013.outbound.protection.outlook.com [40.93.194.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A15212F89
	for <iommu@lists.linux.dev>; Tue, 21 Oct 2025 01:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761011126; cv=fail; b=XKqKzLFvO1pQLE4XlNKbw6uYdHXzXvrysRfI4ZBkoHgYHZekG6qzzZRhLlEol5wKFjMwRr0qM+cACHtvudUPY/R6jM+Hg+cCq7gs9Wcv87kMcHsR1dVdh/+Zi+cwyDQMfvqkB4tshuP1l+zy/+RGNOcfTjDjgVY9Wx+lyvye/Xw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761011126; c=relaxed/simple;
	bh=3x/c4wvGidACaIAFgzVDTBT9Ir4DBIXFai8aPxapfyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hE9zOhyu1RqrBma+lSoIjrHqqRbL7FyKGsnN6L7qAE9STCJ58RpXC4cSkXcpc8f4/cqkEjAP6XoQkyWwOwp2Esgo5N8n44tSsINu0Cud1B7ZpPanVJHieV7sSvK0WQvDH70GuvytHreZeqmMPTNfmKzuRi0xr+45ukIvX/yXUmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i8EZ+hZd; arc=fail smtp.client-ip=40.93.194.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i8EZ+hZd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwFAGVsIpNngCKApz1S/0n9ETnFgS921IlPcK5Tdp/DUXPnvNqPdDmLOVC9nh1PpYTWILOYql3ann2maVTCwZho/KHPCM3JtPuiDo8HopaucRBh7FjiRspJBxTGtC4AxJ/PS6J/fAMpUhxiZG0XfX615I2Z+zjeBRRRCKZ6f8bLgFS0S0B4qPlvZejjWFjkgJOQN4yViDE0Q1jupWvJyxTRNLAH9r5kSYgn3YZOkyzArHpIIt8HjoiwMAhJf/Pnqm3RjoRa1ETU45E8nEJ1fIIrDxOauPB4urwwIO2Co2ZzfJaA2tyhs41zumRanTAOc9uhDYS6tyQnaMYtJIbUqrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CqNMIItAz4XRME2Tt9TMupC8z37c6oKF7PZj0RNDLUA=;
 b=LEXkaikvtjpMe8Fw2fQIkEXqXxYLMQL0QXKWP+3Ak/18L0/Cljoy3uc59BNhCxfu6fU/YC9GKWvqBH0Pc35DC2Cshxr+JkoU5xYAJ306NJPkL3j3eqYS502SNWyJH7yafjBGD0doDfRoxAIn7C0e+sPDHc8V972Joo7Vo7JuHO1aWyP3aFDQr0LFTJYi4ULD4JWEnCMDOWsC9IS+l3h+GcYWtvwMap27zw2WYpUw387IiXB+LsMOBKbzzyXHM7JuAlsuVWdBKqtGdXPGH4kYiMqghXHUGo0U4+1MwdyfyxjM56QtzQPp21YKNtdD2v/jNIOgaXufJza+GDyGhevvtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nvidia.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CqNMIItAz4XRME2Tt9TMupC8z37c6oKF7PZj0RNDLUA=;
 b=i8EZ+hZdDhIlhCfmv/bx6JDePFoQkBuWDBAv7rXQRFibcF/qY1TY9KSAsKPZGHomJx0lseGSmwsCp6KJjyhpgSLdtkaD7AoHczaqp7pkaHTu4Cc/mw3M8lpLB2Jpq7W7AzJrTddRtfZjwhuWa/SWgjEVqn0hHqpmNllinS0UEsw=
Received: from BL1PR13CA0431.namprd13.prod.outlook.com (2603:10b6:208:2c3::16)
 by BL1PR12MB5873.namprd12.prod.outlook.com (2603:10b6:208:395::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.16; Tue, 21 Oct
 2025 01:45:16 +0000
Received: from BN3PEPF0000B074.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::1f) by BL1PR13CA0431.outlook.office365.com
 (2603:10b6:208:2c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.9 via Frontend Transport; Tue,
 21 Oct 2025 01:45:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B074.mail.protection.outlook.com (10.167.243.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Tue, 21 Oct 2025 01:45:16 +0000
Received: from purico-ed03host.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 20 Oct
 2025 18:44:57 -0700
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
Subject: [PATCH v4 13/16] iommu/amd: Track host Domain ID mapping for each guest Domain ID
Date: Tue, 21 Oct 2025 01:43:21 +0000
Message-ID: <20251021014324.5837-14-suravee.suthikulpanit@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B074:EE_|BL1PR12MB5873:EE_
X-MS-Office365-Filtering-Correlation-Id: 42a46ad5-95d1-4063-8f26-08de10437c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H09EhKuuM4wr8PEtyY048Rh45Ik1drNjPZDvzkaDBt2IYtCuW7KPkttbjpHZ?=
 =?us-ascii?Q?NqPp+fu1NSjNd3MxRhmMIHMBe8W1cj1+cdgIk6MJLPg3XmiiOxZza7G+SHz0?=
 =?us-ascii?Q?GIdjuNN0VtG6Va+gVtew2Fj7hShaUEyzJ3SF3kM7eAh8eZlRU+w+X+IrArh4?=
 =?us-ascii?Q?CVwz1r2N9229d93booXRnUVbsKdC7W42bJhN8y8as3AIiBj+LoBPO0AaC0Z/?=
 =?us-ascii?Q?xO2PJiJuX6qZNggIri5oZvXTrwiKnmwCYzJikB4twv0aJi5HmBrHGfXP3XFu?=
 =?us-ascii?Q?g0esWFyjLLH/4HBN9vHjvmHWeUOn6bVrInS4jZ5OzCELX5TLT46InmoZpQxB?=
 =?us-ascii?Q?cEnAtqDlkdW5FKGuDy/NmIg9fJP1hr0V5/Jh1+vHtMG7qHHDHO6glZjG6laa?=
 =?us-ascii?Q?S+WVftHedfQUG2Qa0Y2+a0OTfbHDxyTso7yvpP+4hgfJ2EaV9BGVCiRweVox?=
 =?us-ascii?Q?JL/WhD9j/rX0WYTpAA4TzkH2vgd3WLZHcMucO2Z32zCCsODVjqaQS+artEMn?=
 =?us-ascii?Q?hHwBFCQnNnTbjDBf7LvSlhyBXnOi43J8mFOXMC74O7lyNZhNS9CZWocBSj7K?=
 =?us-ascii?Q?7L0bsMTE0P7iV2V3MkAnop2pxn5fJnVeQ8wLFECAy8hArDDDaVyffXo+T50m?=
 =?us-ascii?Q?TBBDJZFS54FNG2nB3qO8jV0rwnsuqeZw+eUynKY/mEAo9p2JPXbIShCdu02Z?=
 =?us-ascii?Q?/ZalojAu5ArmvCC6ZG28JHnzLgf4w34lT9jJv3DDCMd67sGuJpBVaHq3ajjl?=
 =?us-ascii?Q?tRwbrjS80JTS1YjXxlBGriONCtO0V1kKTfTBEHBx5Ma9AOfSOnMKMf0dHBuz?=
 =?us-ascii?Q?2ASfUycxlziUSFAdoUiDQHXoUnDgBwsUvaVKZmn7QbR5Hvi9jFyVTE99vNPi?=
 =?us-ascii?Q?w7VJgv6wcUypsyHaJpkjF9wUcsH5DPquAi/VSLeAMBb+Gox2jwZmTDhSv9rS?=
 =?us-ascii?Q?9RovbUAd876N87V+Zv+wfQ8Gi/daJUfmyawXAHiqvgAH4iLjQ0CEWaexCTzQ?=
 =?us-ascii?Q?nUc9cEiqoWxmnpC994W2TR1eIY2sKwPzEIcE4AdBU8F5om+aJ0g3YAaLyKrg?=
 =?us-ascii?Q?O8FsFKB8Mv7fZaC24+W+PMHIhe8TyGULMgxNNrfMCB+Nlj40KsXUjFnnBI+E?=
 =?us-ascii?Q?jTUeBe4o+t6hU8QWYRcy1N35xK3hrXC0NBhjtW9/H9C+3ArASKA5up+Af9Hu?=
 =?us-ascii?Q?sn9AzLh5xE4T59uehQh/LSVd0RnlZq0Z9tMDfe7Dwtm4nyTzb2IVGjE+QUSQ?=
 =?us-ascii?Q?V2SiOE6i5HLLFK8VMXylJG1SEc2EGd/nDYx7iV/ho4DJ6b6DYhfxb0xmb6hB?=
 =?us-ascii?Q?fu+dMbYxYkryPpvZzLYCmmwdIIAFvKwo3wobbUmB2Ei98FAh/fHC7CytjKbi?=
 =?us-ascii?Q?h54MigkCv0BHMtLtQEi7KWo8KMfyBOgS/wkbD6I42nuS548GCPx3Xsw1XTLz?=
 =?us-ascii?Q?uKi5IGK+ndeYr5SbtLVAmIhDRwKhu3CaeTWstz8ppc1eTfFmIIzSaN93MIdq?=
 =?us-ascii?Q?nOH1MZYki+uekVfwsST5NJTkLdmMDfEtUZSyLWOhVcHb4UU4wq3CmfvBl2ZL?=
 =?us-ascii?Q?FqzmqTZ0NEUaMhqyHhA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2025 01:45:16.6288
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42a46ad5-95d1-4063-8f26-08de10437c41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5873

Each nested domain is assigned guest domain ID (gDomID), which guest OS
programs into guest Device Table Entry (gDTE). For each gDomID, the driver
assigns a corresponding host domain ID (hDomID), which will be programmed
into the host Device Table Entry (hDTE).

The gDTE to hDTE 1:1 mapping is stored in the nest parent domain using
an xarray (struct protection_domain.gdomid_array). When invalidate the
nest parent domain, the INVALIDATE_IOMMU_PAGES must be issued for each
hDomID in the gdomid_array.

Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
---
 drivers/iommu/amd/amd_iommu_types.h |  3 ++
 drivers/iommu/amd/iommu.c           | 30 ++++++++++++++++
 drivers/iommu/amd/nested.c          | 53 ++++++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index e0f0cd3d34f2..09952b7a256d 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -602,6 +602,7 @@ struct amd_iommu_viommu {
 struct nested_domain {
 	struct iommu_domain domain; /* generic domain handle used by iommu core code */
 	u16 gdom_id;                /* domain ID from gDTE */
+	u16 hdom_id;	            /* domain ID written to the device table */
 	struct iommu_hwpt_amd_guest gdte; /* Guest vIOMMU DTE */
 	struct amd_iommu_viommu *viommu;  /* AMD hw-viommu this nested domain belong to */
 };
@@ -623,6 +624,8 @@ struct protection_domain {
 
 	struct mmu_notifier mn;	/* mmu notifier for the SVA domain */
 	struct list_head dev_data_list; /* List of pdom_dev_data */
+
+	struct xarray gdomid_array; /* gDomID mapping to this nest parent domain */
 };
 
 /*
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index c4ff18adcf03..e4db6f304599 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1493,6 +1493,23 @@ static void amd_iommu_flush_tlb_domid(struct amd_iommu *iommu, u32 dom_id)
 	amd_iommu_completion_wait(iommu);
 }
 
+static int iommu_flush_hdom_ids(struct amd_iommu *iommu,
+				u64 address, size_t size,
+				struct protection_domain *parent)
+{
+	int ret = 0;
+	unsigned long i;
+	struct iommu_cmd cmd;
+	struct nested_domain *ndom;
+
+	xa_for_each(&parent->gdomid_array, i, ndom) {
+		build_inv_iommu_pages(&cmd, address, size, ndom->hdom_id,
+				      IOMMU_NO_PASID, false);
+		ret |= iommu_queue_command(iommu, &cmd);
+	}
+	return ret;
+}
+
 static void amd_iommu_flush_all(struct amd_iommu *iommu)
 {
 	struct iommu_cmd cmd;
@@ -1639,6 +1656,18 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
 		 * We need a TLB flush
 		 */
 		ret |= iommu_queue_command(pdom_iommu_info->iommu, &cmd);
+
+		/*
+		 * A domain w/ v1 table can be a nest parent, which can have
+		 * multiple nested domains. Each nested domain has 1:1 mapping
+		 * between gDomID and hDomID, which is stored in the gdomid_array.
+		 * Therefore, we also need to flush every hDomID associated to this
+		 * nest parent domain.
+		 *
+		 * See drivers/iommu/amd/nested.c: amd_iommu_alloc_domain_nested()
+		 */
+		ret |= iommu_flush_hdom_ids(pdom_iommu_info->iommu, address,
+					    size, pdom);
 	}
 
 	return ret;
@@ -2470,6 +2499,7 @@ static void protection_domain_init(struct protection_domain *domain)
 	INIT_LIST_HEAD(&domain->dev_list);
 	INIT_LIST_HEAD(&domain->dev_data_list);
 	xa_init(&domain->iommu_array);
+	xa_init(&domain->gdomid_array);
 }
 
 struct protection_domain *protection_domain_alloc(void)
diff --git a/drivers/iommu/amd/nested.c b/drivers/iommu/amd/nested.c
index e7b6f69a9d0c..383a3c7b4a91 100644
--- a/drivers/iommu/amd/nested.c
+++ b/drivers/iommu/amd/nested.c
@@ -67,7 +67,7 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 			      const struct iommu_user_data *user_data)
 {
 	int ret;
-	struct nested_domain *ndom;
+	struct nested_domain *ndom, *curr;
 	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
 
 	if (user_data->type != IOMMU_HWPT_DATA_AMD_GUEST)
@@ -92,6 +92,49 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 	ndom->domain.type = IOMMU_DOMAIN_NESTED;
 	ndom->viommu = aviommu;
 
+	/*
+	 * Normally, when a guest has multiple pass-through devices,
+	 * the IOMMU driver setup DTEs with the same stage-2 table and
+	 * use the same host domain ID (hDomId). In case of nested translation,
+	 * if the guest setup different stage-1 tables with same PASID,
+	 * IOMMU would use the same TLB tag. This will results in TLB
+	 * aliasing issue.
+	 *
+	 * The guest is assigning gDomIDs based on its own algorithm for managing
+	 * cache tags of (DomID, PASID). Within a single viommu, the nest parent domain
+	 * (w/ S2 table) is used by all DTEs. But we need to consistently map the gDomID
+	 * to a single hDomID. This is done using an xarray in the nest parent domain to
+	 * keep track of the gDomID mapping. When the S2 is changed, the INVALIDATE_IOMMU_PAGES
+	 * command must be issued for each hDomID in the xarray.
+	 *
+	 * Since there is no invalidation support and no viommu yet, just always use a
+	 * unique hDomID for now.
+	 */
+	curr = xa_cmpxchg(&aviommu->parent->gdomid_array,
+			  ndom->gdom_id, NULL, ndom, GFP_ATOMIC);
+	if (curr) {
+		if (xa_err(curr)) {
+			ret = -EINVAL;
+		} else {
+			/* The gDomID already exist */
+			pr_debug("%s: Found gdom_id=%#x, hdom_id=%#x\n",
+				 __func__, ndom->gdom_id, ndom->hdom_id);
+			ret = -EBUSY;
+		}
+		goto out_err;
+	}
+
+	ndom->hdom_id = amd_iommu_pdom_id_alloc();
+	if (ndom->hdom_id <= 0) {
+		xa_cmpxchg(&aviommu->parent->gdomid_array,
+			   ndom->gdom_id, ndom, NULL, GFP_ATOMIC);
+		ret = -ENOSPC;
+		goto out_err;
+	}
+
+	pr_debug("%s: Allocate gdom_id=%#x, hdom_id=%#x\n",
+		 __func__, ndom->gdom_id, ndom->hdom_id);
+
 	return &ndom->domain;
 out_err:
 	kfree(ndom);
@@ -101,7 +144,15 @@ amd_iommu_alloc_domain_nested(struct iommufd_viommu *viommu, u32 flags,
 static void nested_domain_free(struct iommu_domain *dom)
 {
 	struct nested_domain *ndom = to_ndomain(dom);
+	struct amd_iommu_viommu *aviommu = ndom->viommu;
+
+	pr_debug("%s: Free gdom_id=%#x, hdom_id=%#x\n",
+		__func__, ndom->gdom_id, ndom->hdom_id);
+
+	xa_cmpxchg(&aviommu->parent->gdomid_array,
+		   ndom->gdom_id, ndom, NULL, GFP_ATOMIC);
 
+	amd_iommu_pdom_id_free(ndom->hdom_id);
 	kfree(ndom);
 }
 
-- 
2.34.1

