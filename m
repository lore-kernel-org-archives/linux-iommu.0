Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010050.outbound.protection.outlook.com [52.101.61.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54177330666
	for <iommu@lists.linux.dev>; Fri, 29 May 2026 21:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780089073; cv=fail; b=f6ZiSqk1m6Lr4CK4MjlbhKoRPPnQVlRg0Ef+xGeWaOFPwlYqrhD7ZWqD93UDVXb3CimBbgAsZzgfkurmxchBKseGexbV2wfx3z5z7WFe4f3IUb3RRbstAPGax+IXK0kgi315n3F5VZz/83ln8/lhkaZhTYR305uo9MMNarxKqW0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780089073; c=relaxed/simple;
	bh=zRlNEpiGfq+MmxsGS7L0ewg/Dvctpias1bQUeSCZoR0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwNFmaWbOQW9en+COmdO8jvcKyMcnj5poKi/uNpf00TzArW447iyirytBxM4tmI+lDuvGZM/hSdQNcZsqGEYiWcORp7SWGaJsQ5hPCCN51hsnvQxdjcW34iMSbfNsNZ0Hqz4CxQSaEbOY/I9osSwJ25E+bnK7yG7FvVvemBBbLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GGYcawiP; arc=fail smtp.client-ip=52.101.61.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GGYcawiP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eoSiQ2wF12gosteNlqB7Cp9FUf47uMWtFVV6tEEfZESrdj4NeYqnGbsIpyjshGoNMFnwdAV5drjQgmBrUQGEZw7295YZe2qM6N8Hl0Xaws8ruEhxZASgk2AdhnGusSDp8Th0Se9MikqCt10qehwLfHPVjTLjJ+OK7vzoymIw6jY5WmuHMlH4nxH9CkFPYr1mHF2LZuadwnFhzCbNG8W2+Bw60ts51FPB9z2z/HyTP0QDHYG8/W3i1fyO9Q9iM703tI6cwAeNRHPfcJ+wQfPAlpwNsUZJLAMtJb97y4mOSiQP/Qt4Z4/slRTGfr6Gb1xDsVhXJX6w5kKWrtyEzJguaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H7bfiRTjHnALuT3Qb/L7OBCBWrFmUa8leJ/JP4StLeY=;
 b=jbPtlkom5SzDZKkRptSKEzuREssEMckFQiGeaT09FLrbFoPUukEUFP/OPF3ri5g4YxVVsYIZem27Mbj4ve9Bcifi8KsDtGmDKSWqKQ3AvyfGdvz6tMqIJjkdpZ4UqFMI9uFUuzRyGveUJvSPRORHIpSmpkqTvAa1AO42RahMwM+vhbTLUKkX529qA+illiqeCKvnY+EaApxbwmRXmZmS0I/1DmJTy9SzkDwWhhEPazt5+Nuh5eg/Lka65KKsKiIK3HHOLR5PcQJK3xaKprwpQeM3BEM4U7o+qH8UWD1fSBy4iC5l397Y5nj2phXpk+Xpj7HqNsTlMZ0f+ZHV3UCd3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H7bfiRTjHnALuT3Qb/L7OBCBWrFmUa8leJ/JP4StLeY=;
 b=GGYcawiP4Em5zKMzWbKDCBS6n4TL/4x5B8Zpg3mW+xPI54zPUkmkJ3F+pIO+y2CCRxxQIwsuxiLUAXiePhGv8c7l9gV+WhgAx2QsCjHx3FBtnr55mUKtThWcFKKPENbr8Pg7f7fREXfxIZcSRZ4o7d+ugm/g7KXR51hmMKLnpaebOVig/3i0MJ/X08LvwcstD8cZqFH5UFCZw+zUDksBUuk8N9fxRUPsT773POi/vKIMBO0PHl/b72nySSFngJOypOSr5qUEigx0ocVuFboQIJA8uPl5JThVoFL7YtWEnTY3fAyHkHZdojhj2/WLSMtc31g2/wLfA616gA6MXNMfQg==
Received: from CH0PR13CA0017.namprd13.prod.outlook.com (2603:10b6:610:b1::22)
 by MN2PR12MB4221.namprd12.prod.outlook.com (2603:10b6:208:1d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Fri, 29 May
 2026 21:11:06 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::1c) by CH0PR13CA0017.outlook.office365.com
 (2603:10b6:610:b1::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.5 via Frontend Transport; Fri, 29
 May 2026 21:11:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 21:11:05 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:10:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 14:10:46 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Fri, 29 May 2026 14:10:45 -0700
Date: Fri, 29 May 2026 14:10:43 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Ashish Mhetre <amhetre@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@ziepe.ca>, <linux-arm-kernel@lists.infradead.org>,
	<iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
	<linux-tegra@vger.kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v2 2/2] iommu/arm-smmu-v3: Issue CFGI/TLBI twice on
 Tegra264
Message-ID: <ahoA05k2zBumGqi/@Asurada-Nvidia>
References: <20260529140830.629738-1-amhetre@nvidia.com>
 <20260529140830.629738-3-amhetre@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260529140830.629738-3-amhetre@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|MN2PR12MB4221:EE_
X-MS-Office365-Filtering-Correlation-Id: a7cd45da-0e8a-4765-cc3e-08debdc6cc3a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|11063799006|4143699003|56012099006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	16SvXPB37CrC2v1c7jceWLDsKPeZN6Kv4e10jH4VdvRcwgmi2xju5NOkqjfLGa3+X5IcB1TheMduIrP2m1o376c7eG63tnY5XUTt9b/fWHy9I4E4g0fWh915FEK6E42nEV+Dez4HKjKW3h4d52x09uiMr7G9ClmZOBSrWAhxobos2k7H5+BDm9FIT3YSdUPS6tdBGlSOMTgrrQGNXLYKH+PjvC3JTuTu8OSNGEkUtS+D5+T0snLV/FQLIn64buViYr5WciKS3fwt12N85cpzvqiWl08MHwyJzWaW0ohhPXt4/y45qFavokWcpslWiLqLnH8F/uU284PEclWbZY6V5rEWkQymiIEqmXjitmYZx48Q2Cqwe5N+WNp9QoBwevV8Wlmk5bhX8V9NMBBE3VjO3tD1Su20NWRn4Y0UfTy4urtLCY4/FlgLwBGPdi6C2MMrZD+3nu+YdruIiq9Avxhg92ISOhPO/M0FHn2b4atmlYuxm9leihNVCb5UfvnA0TLHRwKxYvpc6XPMx/jtD8VxNoIVArB9RrZm3F2MlYDLThBJBJ8bFVnb5y8KVAUpvMNcPVJ2CmWQYiJyLQ+As6GAVcZUL03b2DXJ++4i5KyUrnWbQAwpQKK9fNhJGIGYZfkR8zVPms4idJqodByRHDp7cjrmE1C1lHs0OEFnPGXTuqI2jmREGhdLwt55IoJ6dGL7DpZN6DyM93MSMdpeI1mLzSWYFx5AJ1LTRYOGRJa6who=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(11063799006)(4143699003)(56012099006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	S1SV+PY1UCrYBklEM6BGg2KhEoFcBXA8IiwoygGeyAU48YPgY0xZD9WladmXZEXbdoswZCdsT1rxpOH4KwkeFufBRrTtRVpEWp8po9H1hMIQAna8gXUFzklhw8Odktb2+ZNckzAt+LifTauotylZCHap2Om24wjVq1PUoNS7DoheiKAdHjVfOy30cgjOlqbaJ+ChiyFLcfQcU1pzksoJG8MEQSuJ6rmLWEB2+1xsjgIqFzamYJQYs7627o3kFnx9HMFPYZCIkDjpIroaKzormr+ouvccE9CVLZ9VYMd3JzpT9FHuaH4bnmqviQf1fsY1OpUWDBiWidSxKIhEsDPBrfW04mE9SmCg//PV6fa1wgFP8YJ28iyETxws4Efto3UmpPhcyXVHkQ1S2LPz/uJHXuLWc1/NXc55tAPT+4dxbCiVqAkrP4DheCwcU/Bea/Fo
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 21:11:05.9199
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7cd45da-0e8a-4765-cc3e-08debdc6cc3a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4221

On Fri, May 29, 2026 at 02:08:30PM +0000, Ashish Mhetre wrote:
> +int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
> +				struct arm_smmu_cmdq *cmdq,
> +				struct arm_smmu_cmd *cmds, int n,
> +				bool sync)
> +{
> +	int ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
> +
> +	/*
> +	 * The driver's batch invariants keep a single submission's
> +	 * opcode class uniform, so checking the first command is enough.
> +	 */
> +	if (!ret && sync && (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
> +	    arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
> +						    cmds[0].data[0])))
> +		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);

https://sashiko.dev/#/patchset/20260529140830.629738-1-amhetre%40nvidia.com
Sashiko pointed out that the iommufd path might mix commands when
calling arm_smmu_cmdq_issue_cmdlist(), which is valid I think.

>  static int arm_smmu_cmdq_issue_cmd_p(struct arm_smmu_device *smmu,
>  				     struct arm_smmu_cmd *cmd, bool sync)
>  {
> @@ -863,8 +909,18 @@ static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
>  	}
>  
>  	if (cmds->num == CMDQ_BATCH_ENTRIES) {
> +		/*
> +		 * Force a SYNC only when the batch carries commands that
> +		 * have to be doubled (see ARM_SMMU_OPT_TLBI_TWICE).
> +		 * The batch holds a uniform opcode class, so checking
> +		 * the first command is sufficient.
> +		 */
> +		bool need_sync = (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
> +				 arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
> +									 cmds->cmds[0].data[0]));
> +

Also, given that this does "force a sync", I think it might be nicer
to go to the force_sync path. One of my ongoing series also needs to
add another force_sync condition, so I think it would be cleaner to
have a helper function.

Maybe try the following diff. That arm_smmu_cmdq_batch_force_sync()
might be added with a preparatory patch, but it's up to you.

--------------------------------------------------------------------
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
index 1e9f7d2de3441..4c9ce974d31a8 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c
@@ -350,6 +350,18 @@ static int arm_vsmmu_convert_user_cmd(struct arm_vsmmu *vsmmu,
 	return 0;
 }
 
+static bool arm_vsmmu_can_batch_cmd(struct arm_smmu_device *smmu,
+				    struct arm_vsmmu_invalidation_cmd *last,
+				    struct arm_vsmmu_invalidation_cmd *next)
+{
+	struct arm_smmu_cmd next_cmd = {
+		.data[0] = le64_to_cpu(next->ucmd.cmd[0]),
+	};
+
+	return arm_smmu_cmd_needs_tlbi_twice(smmu, &last->cmd) ==
+	       arm_smmu_cmd_needs_tlbi_twice(smmu, &next_cmd);
+}
+
 int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 			       struct iommu_user_data_array *array)
 {
@@ -382,7 +394,8 @@ int arm_vsmmu_cache_invalidate(struct iommufd_viommu *viommu,
 
 		/* FIXME work in blocks of CMDQ_BATCH_ENTRIES and copy each block? */
 		cur++;
-		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1)
+		if (cur != end && (cur - last) != CMDQ_BATCH_ENTRIES - 1 &&
+		    arm_vsmmu_can_batch_cmd(smmu, last, cur))
 			continue;
 
 		/* FIXME always uses the main cmdq rather than trying to group by type */
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index a63155e9e7f28..9b150e3145034 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -820,33 +820,6 @@ static int __arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	return ret;
 }
 
-/*
- * Returns true if @opcode is a CFGI_* or TLBI_* command, i.e. one of the
- * invalidations covered by Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE).
- */
-static bool arm_smmu_cmd_needs_tlbi_twice(u8 opcode)
-{
-	switch (opcode) {
-	case CMDQ_OP_CFGI_STE:
-	case CMDQ_OP_CFGI_ALL:
-	case CMDQ_OP_CFGI_CD:
-	case CMDQ_OP_CFGI_CD_ALL:
-	case CMDQ_OP_TLBI_NH_ALL:
-	case CMDQ_OP_TLBI_NH_ASID:
-	case CMDQ_OP_TLBI_NH_VA:
-	case CMDQ_OP_TLBI_NH_VAA:
-	case CMDQ_OP_TLBI_EL2_ALL:
-	case CMDQ_OP_TLBI_EL2_ASID:
-	case CMDQ_OP_TLBI_EL2_VA:
-	case CMDQ_OP_TLBI_S12_VMALL:
-	case CMDQ_OP_TLBI_S2_IPA:
-	case CMDQ_OP_TLBI_NSNH_ALL:
-		return true;
-	default:
-		return false;
-	}
-}
-
 int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmdq *cmdq,
 				struct arm_smmu_cmd *cmds, int n,
@@ -858,9 +831,7 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 	 * The driver's batch invariants keep a single submission's
 	 * opcode class uniform, so checking the first command is enough.
 	 */
-	if (!ret && sync && (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
-	    arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
-						    cmds[0].data[0])))
+	if (!ret && sync && arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds[0]))
 		ret = __arm_smmu_cmdq_issue_cmdlist(smmu, cmdq, cmds, n, sync);
 
 	return ret;
@@ -893,34 +864,48 @@ static void arm_smmu_cmdq_batch_init_cmd(struct arm_smmu_device *smmu,
 	cmds->cmdq = arm_smmu_get_cmdq(smmu, cmd);
 }
 
+static bool arm_smmu_cmdq_batch_force_sync(struct arm_smmu_device *smmu,
+					   struct arm_smmu_cmdq_batch *cmds,
+					   struct arm_smmu_cmd *cmd)
+{
+	if (!cmds->num)
+		return false;
+
+	/* The batch's pre-assigned cmdq doesn't support the new command */
+	if (!arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd))
+		return true;
+
+	/* Arm erratum 2812531 */
+	if (cmds->num == CMDQ_BATCH_ENTRIES - 1 &&
+	    (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC))
+		return true;
+
+	/*
+	 * Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE). The batch holds a
+	 * uniform opcode class, so checking the first command is enough.
+	 */
+	if ((cmds->num == CMDQ_BATCH_ENTRIES) &&
+	    arm_smmu_cmd_needs_tlbi_twice(smmu, &cmds->cmds[0]))
+		return true;
+
+	return false;
+}
+
 static void arm_smmu_cmdq_batch_add_cmd_p(struct arm_smmu_device *smmu,
 					  struct arm_smmu_cmdq_batch *cmds,
 					  struct arm_smmu_cmd *cmd)
 {
-	bool force_sync = (cmds->num == CMDQ_BATCH_ENTRIES - 1) &&
-			  (smmu->options & ARM_SMMU_OPT_CMDQ_FORCE_SYNC);
-	bool unsupported_cmd;
+	bool force_sync = arm_smmu_cmdq_batch_force_sync(smmu, cmds, cmd);
 
-	unsupported_cmd = !arm_smmu_cmdq_supports_cmd(cmds->cmdq, cmd);
-	if (force_sync || unsupported_cmd) {
+	if (force_sync) {
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
 					    cmds->num, true);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
 	if (cmds->num == CMDQ_BATCH_ENTRIES) {
-		/*
-		 * Force a SYNC only when the batch carries commands that
-		 * have to be doubled (see ARM_SMMU_OPT_TLBI_TWICE).
-		 * The batch holds a uniform opcode class, so checking
-		 * the first command is sufficient.
-		 */
-		bool need_sync = (smmu->options & ARM_SMMU_OPT_TLBI_TWICE) &&
-				 arm_smmu_cmd_needs_tlbi_twice(FIELD_GET(CMDQ_0_OP,
-									 cmds->cmds[0].data[0]));
-
 		arm_smmu_cmdq_issue_cmdlist(smmu, cmds->cmdq, cmds->cmds,
-					    cmds->num, need_sync);
+					    cmds->num, false);
 		arm_smmu_cmdq_batch_init_cmd(smmu, cmds, cmd);
 	}
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index 08d1abaf31ae2..e6afc832c0078 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -1219,6 +1219,37 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
 				struct arm_smmu_cmd *cmds, int n,
 				bool sync);
 
+/*
+ * Returns true if @cmd opcode is a CFGI_* or TLBI_* command, i.e. one of the
+ * invalidations covered by Tegra264 erratum (see ARM_SMMU_OPT_TLBI_TWICE).
+ */
+static inline bool arm_smmu_cmd_needs_tlbi_twice(struct arm_smmu_device *smmu,
+						 struct arm_smmu_cmd *cmd)
+{
+	if (!(smmu->options & ARM_SMMU_OPT_TLBI_TWICE))
+		return false;
+
+	switch (FIELD_GET(CMDQ_0_OP, cmd->data[0])) {
+	case CMDQ_OP_CFGI_STE:
+	case CMDQ_OP_CFGI_ALL:
+	case CMDQ_OP_CFGI_CD:
+	case CMDQ_OP_CFGI_CD_ALL:
+	case CMDQ_OP_TLBI_NH_ALL:
+	case CMDQ_OP_TLBI_NH_ASID:
+	case CMDQ_OP_TLBI_NH_VA:
+	case CMDQ_OP_TLBI_NH_VAA:
+	case CMDQ_OP_TLBI_EL2_ALL:
+	case CMDQ_OP_TLBI_EL2_ASID:
+	case CMDQ_OP_TLBI_EL2_VA:
+	case CMDQ_OP_TLBI_S12_VMALL:
+	case CMDQ_OP_TLBI_S2_IPA:
+	case CMDQ_OP_TLBI_NSNH_ALL:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #ifdef CONFIG_ARM_SMMU_V3_SVA
 bool arm_smmu_sva_supported(struct arm_smmu_device *smmu);
 void arm_smmu_sva_notifier_synchronize(void);
--------------------------------------------------------------------

Nicolinc
