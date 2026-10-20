Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792517796;
	b=tTiJmFc4nJDkHowEdaYP3qRyvWsM7uF/+y3QWqc+XfKCoHI092MuZhyCWXHHE6+cChm0
	 HoxLfLeI9NLJXraFSgqL8ZVcHBFeCorBon7jPqSgpaRNE4Jdib8C5D6C9CbOWtje2NKI/
	 Q8Gu1ZwvdZ3TT3p6Bj/BEWmsRwvIwOHGR/xBeGIaknCKIaJRrLANVRzBivk9FAZk2scSR
	 yzU03A3Xg+xw3VAPEJPYDw8dPud+PjBQHgb5YdEYK0hemjHsrTndI80V0DJGY/lqppMVZ
	 6vZPItT/nAxDrcvtWFNrLaO0TWLLx8Gv9OTDX5ky6NZRpOid8Hd1/d0NVJ9L4Q4vpBg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792517796;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:Date:From:To:CC:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-NV-OnPremToCloud:X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=q9YLzauE97mN/5zqnD9jU8gAi/Zk5uH01SdB9tn2mAs=;
	b=Dk4WFCM9p76DL8Kg1iSsDFQyw/Nu9MNTSzIsRYKfdMNcbIbXYIu/gpUcbCMBuoOnciCa
	 oVY6MZmldkjG3+hMB/fVhudgjGWpQRHCVj9EDKgQ0ptBtvgpHBbFBb9CSUXvvmUjI9Csp
	 C68xhQ871IPMbji0ziA/ICW6n+NhJsBSiWoCrjgmYa8tl/ApFrQ5Ne5YXJVq+50GIPfH2
	 IOhD7/iWbIMmzdGZGS5DucQk0YSLKTLQXztixKKj0m2sLAuHn5bglGR0U9GPG27Y9tZwB
	 49TFChoCpxVoi0gbXbj0KS0PPjiwzWmCuq0PZ+WssEts8wcjryusXzVpS1Z9O5qomtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="q/98Noll";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.54
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011054.outbound.protection.outlook.com [40.107.208.54])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9C4606A323
	for <iommu@lists.linux.dev>; Tue, 20 Oct 2026 17:36:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A9C4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=q/98Noll
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OCkc4rmlZOy7i01jwrtTbpVy2y9QpoVBaAzUdJxXSI0TRLPVrd40SqeRacRyUauvd54GIYsjl8B611sYed5N+7B1PCpes0GEQzmZsO+qqHuaC6di/sDh7ubzgzroJWKJjVivuJhAPbpo0xDBAv2mS5qO6qvgwLjLxi3YCCIr27O6S7zFudNcgAByMBF9BYoDMSZMYJZbRAq9stV1sqfprOjDmK7XzFMvbGdgJlQgEAlMr+UXu7S1zjRslAG1P1tw/OgeO6oWmobrmm4dYLZUTm9uQOoLEHh2M88uXRFI+b3ofZZ9FNs1vVTsw+aBiZlsJtwqMfecyfZfoT4sWEQTdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q9YLzauE97mN/5zqnD9jU8gAi/Zk5uH01SdB9tn2mAs=;
 b=YcW0K4MZqKnlwX7PROL4B9KNOF5m1gkuxxb8B1srMfCQYS/xGcVw0fjM/bB8P1cC44eG25FT/KVPPTn63oefCHqRFx3D3os4zEpVOCN5ZdnYG4iemPAOK6u1PAD1mauVgQYNxd0fBzUyPm2dz7vJm1aYyFSSA/pkPMRQOu//l364WIUr/R5kk9BXPVNKYeT8ofpieds9jiYREn5Lk8x5qBsRlMPTYZP/gOMHdFgOpJ1YDirl4DzOBjygnd904mlEA+A3yE9eRG0g08aauztjHjHwSyJ+Hjf1x4InXFesOI0w1zR629jWrMnjixByZP8LZT0voXfyDRL8b4BvqLZu+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9YLzauE97mN/5zqnD9jU8gAi/Zk5uH01SdB9tn2mAs=;
 b=q/98NollNc5d2EBnmM9lVV4B1oN/daG9UxdscLUyLEbLQ0sW640tv1uTOFliQUubobVbQrbvTkkXJvNp6FmRN7aWVD7JUZdX3TjfkaWYExK5gk5lW6Ec6gSq/6+D6qe3/+Bkvf8ydNSH4jDUDqik8xGhNNZGmwwQFY8biwFDi2sgfY5i/SBthwvUn0R+uBUwN6nEIzdbDeLk8efriki5kGxHq1DvNujnnwvQ52z1qlT+GX65C+uX+Qa80prbfxr9Oxu9zeXiBdBMeeVgGuk5JrOuExSeMnXkhFase16GFgABr/+V/8MU1c0gbco73hMWRz4nuSzq9leRwcLpVHAMWw==
Received: from MW4PR04CA0284.namprd04.prod.outlook.com (2603:10b6:303:89::19)
 by IA1PR12MB7758.namprd12.prod.outlook.com (2603:10b6:208:421::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 17:36:30 +0000
Received: from CO1PEPF00012E62.namprd05.prod.outlook.com
 (2603:10b6:303:89:cafe::11) by MW4PR04CA0284.outlook.office365.com
 (2603:10b6:303:89::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Tue,
 20 Oct 2026 17:36:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF00012E62.mail.protection.outlook.com (10.167.249.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Tue, 20 Oct 2026 17:36:29 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 20 Oct
 2026 10:36:05 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 20 Oct
 2026 10:36:04 -0700
Received: from nvidia.com (10.127.8.13) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49 via Frontend
 Transport; Tue, 20 Oct 2026 10:36:03 -0700
Date: Tue, 20 Oct 2026 10:36:01 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Mostafa Saleh <smostafa@google.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<jgg@nvidia.com>, <praan@google.com>, <kevin.tian@intel.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <jamien@nvidia.com>, <kas@kernel.org>,
	Cristian Prundeanu <cpru@amazon.com>, Breno Leitao <leitao@kernel.org>
Subject: Re: [PATCH v11 06/11] iommu/arm-smmu-v3: Add
 ARM_SMMU_OPT_KDUMP_ADOPT for kdump kernel
Message-ID: <atemgT/67JPpdk57@nvidia.com>
References: <cover.1791226953.git.nicolinc@nvidia.com>
 <ee4257b62324aa75d7140f1f4a49aa0f78586fff.1791226953.git.nicolinc@nvidia.com>
 <atdSrRwrphdI9ZQA@google.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <atdSrRwrphdI9ZQA@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E62:EE_|IA1PR12MB7758:EE_
X-MS-Office365-Filtering-Correlation-Id: da8f7411-0292-485f-ae8d-08df2ed0aceb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|82310400026|376014|1800799024|23010399003|6133799003|22082099003|18002099003|10067099003|5023799004|11063799006|4143699003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	p1nVJek8Rr7RiItFESY9LiOZ5fSaQAUu5jY8nYUv2RpVykj1WMuDlcT2TW5iU2hA/QDWaZcxfkxyg9Jo8Z6VbMZetVUhevGhbxVaJm+SgsVqTzCiXc5Uop9VQ28wl5bRn/xS9prxzSMVHKTu2vgDCJUd9NGM4bU60F0TJs+AnpjYpz1f6GZytU3WmwhcWrcjjUhFpmnupnOe85AlcXgqE0pE5o3DnRm5yPmp6NWkMqD14DE+lZwfvscY2SoPt8PU9dHxzi9vZhnEqAAkkDmapYNJ5MMwPqGIaRcwUjMY+ij2OULQXkPn+etPYSdTHtvldBg3kuqM4z2tPJ0/svPiql0VXk8tKwuGZQRfXou+7+esvlXzFwKloroQev9PGH9y6RNFfKIE045Wf9m8rut4jxY8TWPbxV62kdt09+gylefXp4OBdEJHOgStREbzHGPQ806etg0ixSk2pKjMlAcq2xai8I6aWcjchWz9qJndOpMsphayvFTlQ1TK4Bze5VqR9SntAnMm5l2pIxnkv2dRZWbB3JeGEnLygcEaWmdBsHXXz+Xzd7kBgsBcHGvzLeqzlmS7fzmRs1oLjumSLSzDtmpIEs6sGdSW59juL0gfXb1KZv34VSz6IebeKMbfj+S/RzyXZU3xa2KF66sHHcCpJp8nfCH1kzCCNHjszovG6BN8lOPCrfoWJCD6ktQ53mK/5a9OxLjIr1lcRLUxVsPX8w==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(22082099003)(18002099003)(10067099003)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	TpSV9znDAloiw4EYAM05FWLJyuMpmcr5Arbiobv38DOrhvj0AF5WonTHTvJUjB8cyoFdOX8/yhgVFHRyOgPGFMNsDgfcJ8PMvzFDxELRj0w83X7aQvkuEXt5vUmk9Bdf3wV52+heqvtGj12iVBzepAA+Jcye2gZK3IaEMeuCfzAIQZ4LgmpJSe3rq4DAlQUfwbyQyw1GqYbRUn6SZRGrm3dyw5KFoO01Ws+aSkeVEamkLk0quDxcNAjIbNH8MATF/Adnx1oow/6PZKh4fa6RqdMxlh+jxlyfPucvx6+OCPO4i90+7ZUQPV5+9iLebW20/Kjhs4DI0oiZGxRIQFkmmAZYXtU77uDdCsmglFClpCbCug3fPEX2omJQe2uoaS70IyzriEdEl218GMSEWP+iIfK9dMMV7aYZowGoYROfuQ3rYI3NVAUaJDGsS9XK7V3p
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 17:36:29.8039
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da8f7411-0292-485f-ae8d-08df2ed0aceb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF00012E62.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7758

On Tue, Oct 20, 2026 at 11:38:21AM +0000, Mostafa Saleh wrote:
> On Mon, Oct 05, 2026 at 12:30:49PM -0700, Nicolin Chen wrote:
> > +	/*
> > +	 * According to spec (6.3.24), HW aligns the base down to the table size
> > +	 * and ignores the low bits, so an unaligned base would make this kernel
> > +	 * read a different table.
> > +	 */
> > +	if (!IS_ALIGNED(base, size)) {
> > +		dev_err(smmu->dev, "unaligned stream table base %pa\n", &base);
> 
> I understand these are best effort, but what happens if the address
> corrupted and happens to be aligned?

This is a basic sanity so HW wouldn't immediately fail. A corrupted
address would be trickier to test out; also we don't have a perfect
way to do that. Earlier versions had some address range check. I've
dropped it, following Jason's comments.

This is also in the kdocs of the whole smmu kdump functions:

 *  - Only a coherent SMMU (ARM_SMMU_FEAT_COHERENCY) is supported, as the stream
 *    table adoption is done by memremap with MEMREMAP_WB, which is verified on
 *    the real hardware. Callers of these functions are responsible for gating
 *    ARM_SMMU_FEAT_COHERENCY once during the probe.
 */

> > +int arm_smmu_kdump_adopt_deferred_l2_strtab(struct arm_smmu_device *smmu,
> > +					    u32 sid, phys_addr_t base, u32 span,
> > +					    struct arm_smmu_strtab_l2 **l2table)
> > +{
> > +	struct arm_smmu_strtab_l2 *table;
> > +	size_t size;
> > +
> > +	/*
> > +	 * Retest the span in case the L1 descriptor has been overwritten since
> > +	 * the adopt. Reject this master's insert; panic or SMMU-disable would
> > +	 * either lose the vmcore or cascade aborts. Do not try to fix it, as it
> > +	 * would break all other SIDs in the same bus (PCI case). The corruption
> > +	 * blast radius is already bounded to that bus range.
> > +	 */
> > +	if (span != STRTAB_SPLIT + 1) {
> > +		dev_err(smmu->dev,
> > +			"L1[%u] span %u changed since adopt (was %u)\n",
> > +			arm_smmu_strtab_l1_idx(sid), span, STRTAB_SPLIT + 1);
> > +		return -EINVAL;
> > +	}
> > +
> > +	size = (1UL << (span - 1)) * sizeof(struct arm_smmu_ste);
> > +
> > +	/* Same live-corruption check as the span; reject an overwritten base */
> > +	if (!base || !IS_ALIGNED(base, size)) {
> > +		dev_err(smmu->dev, "L1[%u] bad l2 table base %pa\n",
> > +			arm_smmu_strtab_l1_idx(sid), &base);
> > +		return -EINVAL;
> > +	}
> > +
> 
> Those are a bit similar to arm_smmu_kexec_parse_strtab_2lvl() is it
> possible to have some helpers instead?

Sure. I can do that.

> > +int arm_smmu_kdump_adopt_strtab(struct arm_smmu_device *smmu)
> > +{
> > +	u32 cfg_reg = readl_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE_CFG);
> > +	u64 base_reg = readq_relaxed(smmu->base + ARM_SMMU_STRTAB_BASE);
> > +	bool was_2lvl = smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB;
> > +	phys_addr_t base = base_reg & STRTAB_BASE_ADDR_MASK;
> > +	u32 fmt = FIELD_GET(STRTAB_BASE_CFG_FMT, cfg_reg);
> > +	int ret;
> > +
> > +	dev_dbg(smmu->dev, "adopting crashed kernel's stream table\n");
> > +
> > +	if (fmt == STRTAB_BASE_CFG_FMT_2LVL) {
> > +		/*
> > +		 * Both kernels run on the same hardware, so it's impossible for
> > +		 * kdump kernel to see the support for linear stream table only.
> > +		 */
> 
> STRTAB_SPLIT which influences ARM_SMMU_FEAT_2_LVL_STRTAB is a SW choice, so it is

I missed that.

> possible to get such mismatch if STRTAB_SPLIT of the newer kernel is larger than the
> older kernel.
> However, I agree that in that case it's better to refuse the adoption.
>
> > +		if (WARN_ON(!(smmu->features & ARM_SMMU_FEAT_2_LVL_STRTAB)))
> > +			ret = -EINVAL;

I can replace the FEAT guard here with

	if (WARN_ON(FIELD_GET(IDR0_ST_LVL, idr0) != IDR0_ST_LVL_2LVL))
		ret = -EINVAL;

> > +		else
> > +			ret = arm_smmu_kdump_adopt_strtab_2lvl(smmu, cfg_reg,
> > +							       base);
> > +	} else if (fmt == STRTAB_BASE_CFG_FMT_LINEAR) {
> > +		/*
> > +		 * The kdump kernel need not match the crashed kernel. An older
> > +		 * crashed kernel that predates two-level stream table support
> > +		 * may have used a linear table on 2-level-capable hardware, so
> > +		 * enforce the same format here to match the adopted table.
> > +		 */
> > +		ret = arm_smmu_kdump_adopt_strtab_linear(smmu, cfg_reg, base);
> > +		if (!ret)
> > +			smmu->features &= ~ARM_SMMU_FEAT_2_LVL_STRTAB;
> 
> For simplicity, it is better to enforce the same table formats between
> kernels as the rest of the file, for example,
> arm_smmu_kexec_parse_strtab_2lvl() refuses different STRTAB_SPLIT.
> Some checks can be removed and the was_2lvl error path. It's
> very unlikely to hit such case anyway.

Sashiko pointed out a corner case that a modified kernel kdumps
into a vanilla kernel. It is not really a big effort to support
it. So, I would rather keep this.

> > +	} else {
> > +		dev_err(smmu->dev, "invalid STRTAB format %u\n", fmt);
> > +		ret = -EINVAL;
> > +	}
> > +
> > +	if (ret) {
> > +		arm_smmu_kdump_adopt_cleanup(smmu);
> 
> Probably easier to inline the error handling after each call and remove this?

I don't quite follow this. The clean function is used by three
sites. How can we remove it?

Thanks
Nicolin
