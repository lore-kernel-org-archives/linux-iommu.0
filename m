Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011023.outbound.protection.outlook.com [40.93.194.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49BC2EA72A
	for <iommu@lists.linux.dev>; Wed, 26 Nov 2025 00:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764118629; cv=fail; b=l2o6z0QAteZP0ID9pJtK03ZoZYHrF4hten2hC0x5tE1ImhKZBezdtXyeeRA/+8O1xAXwvpswqm/IoedKzmoRNNSpdfRIMMsX8WS/D0pV7eXbg8x3ncJIamhJWNIbUTxk4Y/dPdCy4L9BgW40uFdqYtM6xY1FZdILvefbKsw2tlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764118629; c=relaxed/simple;
	bh=TgV+eWdkHKdHGnPqleUNklxorHLGO8+E6Nb8P0+ryxQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiudptipIFMhqMB/uQ5DI/apBH2yoeNsAH4ifaGdyNCQrjkGjQVTmYDkMNBFnbR2iqeGWerjgTh46YUTjZ67etl+Z+w/cZd9CT2Ik1vG31CgoXI9HAdrQkcNtk9PdWIckVnC5pWPplFV1gjRibHjTGVh28xH3DM2OWE8RfNf6bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YUSr1vQw; arc=fail smtp.client-ip=40.93.194.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YUSr1vQw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ndyOZ2b+lR25NNDi3p19JLcDqzGAfavUXFuXSBqvAKt0CeFwiROrPyxlWtJaOkEWAvqZwIODmIpleofXoCeVa5pA5rAkJfHfDRehNxtzCIUROASEw5uxRsPTOB8brZG/WaYuJsxg64q2VLNO93DeipktW1fMpmEOr5qeQK22fTmDIJhNiZTtgGS4htHQG6jBymUZh739V/m0To1iUrOR1rEcd+xkEAe69k43Ra9xi+hJjGoJl21eugWh1BLESHfzWL5jj6yI12W7yTR9hJj6YPvzHgu9Z31/frl/rtdFiHxeYxLPTNEC4lh6NOVX2cyaJeFss1i0RH36bv/dkR4k/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=unHHh0NLbpnnPNI7bBp35AJ1/bCWYR9F7f3PwCfNM7M=;
 b=uEAiIfzUdWCoCwmwl8dF/W3SQPtT/a87QD0eeffsFbw3R7M1QYEB8bNjDOpxJz4bLDgdax4AWJ2LgC0M4dk+AyKwkHojEn1ZY5lcLGXQ4UL7PwlCXNUjKeEx7N9viK+M2SJvkWH4X0akvF2/koBl+FRMd32BXrJbVJJ4SIciAKAGmxni/s1/wVH8xd73jCPk+FutInBd3LHXpxLlzudxdCymGLLiQ83KzfH6+FOhd8DqUO8iNHNjKtG2xsoZ6MkzA5XC2hv1JpwYj/ROb2uhwVhzVIuLTmPuCy5K8j4jDK17fDp0+V/olDhnbX1VVhvWaTx8Pvoj0Gwrm47ZiDii7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=unHHh0NLbpnnPNI7bBp35AJ1/bCWYR9F7f3PwCfNM7M=;
 b=YUSr1vQwMnUpg8ZV2RO757MJBWE1b+fQ84GwApVmxgRbr+x4FVDv4nwIv/MQ+ItYLK9LXWzPgl3xRRlytUviLHOz22CiPX96Hn4ZRivHikEZy+Erfq8ax3qGp9DFN9jZa2+Vjj2yEwTbNS45NVCi7TdvZ1XtdAUhXfEE1wZREb8H1F8EjWZcm/qsXZrdQjTVlnb0LjP53l4QQdN4tEOSI5yxIpbvt+GsMCz/VhdaiXszZSFr0LJG4AQAzDlx1Bjx5qVqLrv1QZm3BJJdmGSxxo5Y7u/Yo3A39z+cc/bYwL2gQpMm7fsnO4dwv/FyhX+h1a8LWsvHdEiMQM208nnA1g==
Received: from MN2PR05CA0055.namprd05.prod.outlook.com (2603:10b6:208:236::24)
 by DS0PR12MB8042.namprd12.prod.outlook.com (2603:10b6:8:141::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 00:56:59 +0000
Received: from MN1PEPF0000ECD9.namprd02.prod.outlook.com
 (2603:10b6:208:236:cafe::ad) by MN2PR05CA0055.outlook.office365.com
 (2603:10b6:208:236::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 00:56:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD9.mail.protection.outlook.com (10.167.242.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 00:56:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 16:56:45 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 16:56:44 -0800
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 25 Nov 2025 16:56:43 -0800
Date: Tue, 25 Nov 2025 16:56:42 -0800
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: Will Deacon <will@kernel.org>, <jean-philippe@linaro.org>,
	<robin.murphy@arm.com>, <joro@8bytes.org>, <balbirs@nvidia.com>,
	<miko.lenczewski@arm.com>, <peterz@infradead.org>, <kevin.tian@intel.com>,
	<praan@google.com>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <aSZQSsP9t0nyfNkx@Asurada-Nvidia>
References: <cover.1762588839.git.nicolinc@nvidia.com>
 <ebf35fa1b2025be736475950503f0dc0612371f4.1762588839.git.nicolinc@nvidia.com>
 <aSTRdltJpMeFLDN8@willie-the-truck>
 <20251124231341.GO153257@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251124231341.GO153257@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD9:EE_|DS0PR12MB8042:EE_
X-MS-Office365-Filtering-Correlation-Id: f3883b56-68f9-44c8-0d9d-08de2c86b466
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Y8+XLWgFKX1qWHn7VroElFXpgdu05RvHBoKoFU5ZN7fy6793YZXnFa4UgwOj?=
 =?us-ascii?Q?AYiWV6aqhhfO6l3KnnNjg59G5bODbYzKIG4moEbSexjtpxODexZAE5SPfcs9?=
 =?us-ascii?Q?yDWLWB3QLz3nQwbZteCtcm0r0Rw1cqXzUK6ru5E0eJvHdXjG3JoG0kRIdWVI?=
 =?us-ascii?Q?tRy0VhmMCbr6zDAD41SBha6hSbHBJIroEsxMKVa1wQGh46CgNO6bVpEGrk8n?=
 =?us-ascii?Q?GfFG+qjRCXMVKWAXjo7Wv+Lu/S4LXEXYjOpyY91Zr9TnwKev4qzZRNOBseSf?=
 =?us-ascii?Q?K8sZl/1do3RtfzGaV08XDddjtjIKWQvMyBVNlEZvKNClEvSnZfH53HWVabzs?=
 =?us-ascii?Q?pQPziPVwRoJuCLrFl5NtPifKWcO7DGLWVwip/pTg3SkRDQ9LKNvT4dprKvcv?=
 =?us-ascii?Q?RQy82C9L/QZ2iwTKlXkFtBoSN5061OWJIsCA8Mdw9FJE+Ynm7CHyDF9kzscN?=
 =?us-ascii?Q?T2unCSv9LcUYLZwS+XZ/dKWr+vLfhAzRmzdBAkPGYFANzvYiz6gx++kUEoYK?=
 =?us-ascii?Q?7tEQJungR3tGtciYSsD/fOaduT/GQ3JezCzok8mit6JGbO7eNTsrbrb8Vivh?=
 =?us-ascii?Q?5QAIZNFUlQPXwIX1egk0eKpdVdQh+TqtpMUQTAsmpLak+o6Mu30LJ9siJTdG?=
 =?us-ascii?Q?MMup2J+EV61ADSqDJ6v1n4wzq1Bc7LakyYxcbLb2PCPaqLdPKrny77+IGoiG?=
 =?us-ascii?Q?iaZM4l/U4vfX3137sWWlE3Slv4uLr0K4pU5H2Bn/h6py0IqK+g6Tk8z5TsMY?=
 =?us-ascii?Q?US7hhHZA+9Kk8j002GLBsdEZ2KUDJYLR4q6DBRe/65IUqQUy/cSBjEAzptfc?=
 =?us-ascii?Q?VGB3xCa6Askbet+JNPacgn/tAjtw4N1uBcwzxTba7B/+0YET8UWy3wvOYtk1?=
 =?us-ascii?Q?BHoQvM0ewy3KFpkkHSIGF2tVP7y2pPScPqcB4oL2b1SdcGbkc+kkyi5lDmHB?=
 =?us-ascii?Q?3ZIQgJOfl6Org4DMqTtjmakqdbL1cxi84fNI5RXWNcdviDZRPebsMTdPPCXx?=
 =?us-ascii?Q?EcSisZ3Skjcx2AkluUVex/W5Qzq5mzsFfw1t3g7doa5sXC9ys373NYsqSE0K?=
 =?us-ascii?Q?+OQ+ixeePzP2K5YivW/It+1NMqztBs56bOrdpU6rH3Y8+oQpLNDQw6SULecZ?=
 =?us-ascii?Q?YM9Sy19S79QgWEmfdNQUPLIsOiiO/2hwnM1I+3acrlqXPRz4DG+zTjhB6RY7?=
 =?us-ascii?Q?Z45iDmIMYR2oKyLlJf4doXEdTM6n+uDqdUVDkHBGJnaH44gcGQGqZAhSYRvC?=
 =?us-ascii?Q?b4nMrF+L/ccX7bvRRH8/PhfkOBiAvcfd+qMX4HjAVe3P0LiBTnCTdgtAxBg3?=
 =?us-ascii?Q?rWvfi0gnt8+ORFm5vSP2eEYqUPswyiOFrj2mqWfq8QoVpyHl69pcoBnPX5Cy?=
 =?us-ascii?Q?o/p17R1ZKs4qOBscvohUUv590Bk9g+v2+ml8rNqvOetFkeaTMzDnv8oM4S5J?=
 =?us-ascii?Q?t6E8vnHS/0ytOdxdkommonojGhXmEgf2VW/id13kB3DyDQIFZ+kSPMH8K+78?=
 =?us-ascii?Q?X9FL7zQb3fOY2prQ/hJg2h5m0PMKoMuQtOxd6aE1PIz7hFcVv9D0MTzY2cRm?=
 =?us-ascii?Q?U/uKHbhs8hvvrHtQmRM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 00:56:59.5170
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3883b56-68f9-44c8-0d9d-08de2c86b466
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8042

On Mon, Nov 24, 2025 at 07:13:41PM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 24, 2025 at 09:43:18PM +0000, Will Deacon wrote:
> > > +	switch (smmu_domain->stage) {
> > > +	case ARM_SMMU_DOMAIN_SVA:
> > > +	case ARM_SMMU_DOMAIN_S1:
> > > +		*cur = (struct arm_smmu_inv){
> > > +			.smmu = master->smmu,
> > > +			.type = INV_TYPE_S1_ASID,
> > > +			.id = smmu_domain->cd.asid,
> > > +			.size_opcode = e2h ? CMDQ_OP_TLBI_EL2_VA :
> > > +					     CMDQ_OP_TLBI_NH_VA,
> > > +			.nsize_opcode = e2h ? CMDQ_OP_TLBI_EL2_ASID :
> > > +					      CMDQ_OP_TLBI_NH_ASID
> > > +		};
> > > +		break;
> > > +	case ARM_SMMU_DOMAIN_S2:
> > > +		*cur = (struct arm_smmu_inv){
> > > +			.smmu = master->smmu,
> > > +			.type = INV_TYPE_S2_VMID,
> > > +			.id = smmu_domain->s2_cfg.vmid,
> > > +			.size_opcode = CMDQ_OP_TLBI_S2_IPA,
> > > +			.nsize_opcode = CMDQ_OP_TLBI_S12_VMALL,
> > > +		};
> > > +		break;
> > 
> > Having a helper to add an invalidation command would make this a little
> > more compact and you could also check against the size of the array.
> 
> Yeah but it makes all the parameters positional instead of nicely
> named..

Will's remarks did raise an issue that __counted_by() requires a
max_invs v.s. num_invs that can be smaller due to the removal of
tailing trash entries.

Then, it's probably nicer to add a check against the max_invs.

I did the following, which doesn't look too bad to me:

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index b04936e76cfd..28765febf99f 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -3066,6 +3066,51 @@ static void arm_smmu_disable_iopf(struct arm_smmu_master *master,
 		iopf_queue_remove_device(master->smmu->evtq.iopf, master->dev);
 }
 
+static struct arm_smmu_inv *
+arm_smmu_master_build_inv(struct arm_smmu_master *master,
+			  enum arm_smmu_inv_type type, u32 id, ioasid_t ssid,
+			  size_t pgsize)
+{
+	struct arm_smmu_invs *build_invs = master->build_invs;
+	struct arm_smmu_inv *cur, inv = {
+		.smmu = master->smmu,
+		.type = type,
+		.id = id,
+		.pgsize = pgsize,
+	};
+
+	if (WARN_ON(build_invs->num_invs >= build_invs->max_invs))
+		return NULL;
+	cur = &build_invs->inv[build_invs->num_invs];
+	build_invs->num_invs++;
+
+	*cur = inv;
+	switch (type) {
+	case INV_TYPE_S1_ASID:
+		if (master->smmu->features & ARM_SMMU_FEAT_E2H) {
+			cur->size_opcode = CMDQ_OP_TLBI_EL2_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_EL2_ASID;
+		} else {
+			cur->size_opcode = CMDQ_OP_TLBI_NH_VA;
+			cur->nsize_opcode = CMDQ_OP_TLBI_NH_ASID;
+		}
+		break;
+	case INV_TYPE_S2_VMID:
+		cur->size_opcode = CMDQ_OP_TLBI_S2_IPA;
+		cur->nsize_opcode = CMDQ_OP_TLBI_S12_VMALL;
+		break;
+	case INV_TYPE_S2_VMID_S1_CLEAR:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_TLBI_NH_ALL;
+		break;
+	case INV_TYPE_ATS:
+	case INV_TYPE_ATS_FULL:
+		cur->size_opcode = cur->nsize_opcode = CMDQ_OP_ATC_INV;
+		break;
+	}
+
+	return cur;
+}
+
 /*
  * Use the preallocated scratch array at master->build_invs, to build a to_merge
  * or to_unref array, to pass into a following arm_smmu_invs_merge/unref() call.
@@ -3077,84 +3122,58 @@ static struct arm_smmu_invs *
 arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
 			   ioasid_t ssid, struct arm_smmu_domain *smmu_domain)
 {
-	const bool e2h = master->smmu->features & ARM_SMMU_FEAT_E2H;
-	struct arm_smmu_invs *build_invs = master->build_invs;
 	const bool nesting = smmu_domain->nest_parent;
-	struct arm_smmu_inv *cur;
+	size_t pgsize = 0, i;
 
 	iommu_group_mutex_assert(master->dev);
 
-	cur = build_invs->inv;
+	master->build_invs->num_invs = 0;
+
+	/* Range-based invalidation requires the leaf pgsize for calculation */
+	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
+		pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
 
 	switch (smmu_domain->stage) {
 	case ARM_SMMU_DOMAIN_SVA:
 	case ARM_SMMU_DOMAIN_S1:
-		*cur = (struct arm_smmu_inv){
-			.smmu = master->smmu,
-			.type = INV_TYPE_S1_ASID,
-			.id = smmu_domain->cd.asid,
-			.size_opcode = e2h ? CMDQ_OP_TLBI_EL2_VA :
-					     CMDQ_OP_TLBI_NH_VA,
-			.nsize_opcode = e2h ? CMDQ_OP_TLBI_EL2_ASID :
-					      CMDQ_OP_TLBI_NH_ASID
-		};
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S1_ASID,
+					       smmu_domain->cd.asid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
 		break;
 	case ARM_SMMU_DOMAIN_S2:
-		*cur = (struct arm_smmu_inv){
-			.smmu = master->smmu,
-			.type = INV_TYPE_S2_VMID,
-			.id = smmu_domain->s2_cfg.vmid,
-			.size_opcode = CMDQ_OP_TLBI_S2_IPA,
-			.nsize_opcode = CMDQ_OP_TLBI_S12_VMALL,
-		};
+		if (!arm_smmu_master_build_inv(master, INV_TYPE_S2_VMID,
+					       smmu_domain->s2_cfg.vmid,
+					       IOMMU_NO_PASID, pgsize))
+			return NULL;
 		break;
 	default:
 		WARN_ON(true);
 		return NULL;
 	}
 
-	/* Range-based invalidation requires the leaf pgsize for calculation */
-	if (master->smmu->features & ARM_SMMU_FEAT_RANGE_INV)
-		cur->pgsize = __ffs(smmu_domain->domain.pgsize_bitmap);
-	cur++;
-
 	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
 	if (nesting) {
-		*cur = (struct arm_smmu_inv){
-			.smmu = master->smmu,
-			.type = INV_TYPE_S2_VMID_S1_CLEAR,
-			.id = smmu_domain->s2_cfg.vmid,
-			.size_opcode = CMDQ_OP_TLBI_NH_ALL,
-			.nsize_opcode = CMDQ_OP_TLBI_NH_ALL,
-		};
-		cur++;
+		if (!arm_smmu_master_build_inv(
+			    master, INV_TYPE_S2_VMID_S1_CLEAR,
+			    smmu_domain->s2_cfg.vmid, IOMMU_NO_PASID, 0))
+			return NULL;
 	}
 
-	if (ats_enabled) {
-		size_t i;
-
-		for (i = 0; i < master->num_streams; i++) {
-			/*
-			 * If an S2 used as a nesting parent is changed we have
-			 * no option but to completely flush the ATC.
-			 */
-			*cur = (struct arm_smmu_inv){
-				.smmu = master->smmu,
-				.type = nesting ? INV_TYPE_ATS_FULL :
-						  INV_TYPE_ATS,
-				.id = master->streams[i].id,
-				.ssid = ssid,
-				.size_opcode = CMDQ_OP_ATC_INV,
-				.nsize_opcode = CMDQ_OP_ATC_INV,
-			};
-			cur++;
-		}
+	for (i = 0; ats_enabled && i < master->num_streams; i++) {
+		/*
+		 * If an S2 used as a nesting parent is changed we have no
+		 * option but to completely flush the ATC.
+		 */
+		if (!arm_smmu_master_build_inv(
+			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
+			    master->streams[i].id, ssid, 0))
+			return NULL;
 	}
 
 	/* Note this build_invs must have been sorted */
 
-	build_invs->num_invs = cur - build_invs->inv;
-	return build_invs;
+	return master->build_invs;
 }
 
 static void arm_smmu_remove_master_domain(struct arm_smmu_master *master,

Thanks
Nicolin
