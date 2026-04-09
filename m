Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012061.outbound.protection.outlook.com [52.101.43.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5D93A4539
	for <iommu@lists.linux.dev>; Thu,  9 Apr 2026 23:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775779161; cv=fail; b=AgK5b2DgeQmS2Jv3+hPIji4QqQo6D3rVLeDe5yfwYpItU6YjAwaCgjkd0y9Awmolpvz4uO9gEU19cYkuDS/a6xiY/byo+KxrktlJ7Ep/FFU6MoSAThCrJcRGJI+Wa5QujMitBwo1BX8UKuwegiAEfwHfsNa7H0AUMuiVy2xYpYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775779161; c=relaxed/simple;
	bh=dxJCafiHIY8lVek1/OTKOERnBxCKKS9wJrP+K9fPkyY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GOIc/OB1mNScAEsVZQyp6rFUvKcPdavElSA67e8FLgFPCPXPgR4J42Wt5aJJsegndUkwtvews/kOVepJqFbIBtsGKpy/VsHNiMIgQ8EcpO93jCkhhwU5zaF7jpAcVdqdOBhXlzrPgmJD/WndHCZynuCbiWarxcek8fPxsAlI78w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NX6RfOGv; arc=fail smtp.client-ip=52.101.43.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NX6RfOGv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X7bW1WkTQMCo4R6FG32Cni8ttIgdTMHc/qMtQrgvVvezSBLKKWaiNkiXUDpsMwMeAAwVYyRO4xBtlsdnC3YtssnT/GDXUN3tt1KS/6xkwmU+PqPCx2V+J+NM7SXnPnJyDuLlwYWKyHK8pl5OvY+Qndz9prRqHliD2EdxALpmozyDGkeW6e33ndzXe0mED6qcDQtytyGO0nfVGn9FLDjijj0xXuyHh//D5n/E7AoE49P5pNfj85syokX0d0VFH2YfaJJERNPbr45vQ82/J8lhKBniwoQcCUS709yMbTgs5i570pb0OSqBWwRClzIkT8JalS7iKXq5K+MESungnuGl2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WoGYQMd96/FbUV618DsBi8uVW1NdRn2rAIzSTS5u9sc=;
 b=LQI/s/ePkasHw2VNsFTYjKS1xaBZEmwrb926mv/MNNUM4ytfal4smZVRxtEExEC38V2LoYuOGG172jv8dLHBMcHCzjJ++UYknFqkodyDgRJl2yKRhAa5zt9MHEPbdXhMPEv0FfmLuMrYbedfn5tXCfFHpV5eN8VlJaMT0R/Beu39cWkWZoZU4Cn6CZU7rZw9BU6ipgoBPlHpj0b/GOFQsDgTjF5ELQR9VcZFWq8MpVeLrvYpVyhhP6AgjbQGCoyBfEJlv6JqXGUFmtG7DFd0R5PuU4L6uwDXe8QwF18q8DmguxLdb2JJNNN2FzJPEsnhHTxquevUBxd4RFnAkwusig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoGYQMd96/FbUV618DsBi8uVW1NdRn2rAIzSTS5u9sc=;
 b=NX6RfOGviSFEnppYfJ3CGNq94HAijm5CUsb4zemEiBa3vPsl5rsIrKvgf3DwGW5HjmEqvoSEgoMEjd1GzVzWb9eSMA3WxtzxsKHa3rRCHxKoU2E0uuNeauUtfyAF0j1wIU4j1fP0358PpAo6Vl1yLvIIWxvmw4bwSmOo2wQF0N+kphgCHewrxpmZkGm0v/98NySMe74yDCTwwc7+h6tk444RUb1uVMSG5L3yOoxNIPxNzt3PIZj3QfaSqYcBagzSW4YJSuWpS7N7HxofF33KSZt8Uk0PKqNivtX81twbXhJE2gw8nChQIc43lNjzB4WiWE1vOvgdWAsxVtsPws9Eag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by CH2PR12MB4328.namprd12.prod.outlook.com (2603:10b6:610:a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 9 Apr
 2026 23:59:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Thu, 9 Apr 2026
 23:59:14 +0000
Date: Thu, 9 Apr 2026 20:59:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 06/10] iommu/arm-smmu-v3: Introduce
 INV_TYPE_S2_VMID_VSMMU
Message-ID: <20260409235913.GZ3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <c514aa533257ce67bf28645863abf5eaab437996.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c514aa533257ce67bf28645863abf5eaab437996.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: YT3PR01CA0097.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::15) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|CH2PR12MB4328:EE_
X-MS-Office365-Filtering-Correlation-Id: 35f09a00-0de2-4ccb-479d-08de9694008a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|18002099003|22082099003|56012099003|3613699012;
X-Microsoft-Antispam-Message-Info:
	L9VhOAyOyadaNyQnhFiQ/Zed8HZDTsRGpLQkhDP4XTsieTlA/zntEGKupJEDfgUW7wkOkmxGpJ82nLsmbuTYo+QqFC5o2PxRMX0aXif3UBoiloIKmRPNiPeff/XsXZpDZuvbD6lOSG4n4EL2at8PwMiB2c4MEA4kg2g9qccmknAWhBlamUZPnwdJGe2Z2P6vxVVsittbQcf5ZTAihWrfZ5ppaDyTE3Dojh1AEEHs22mUWRaSxMhqAVJnFGxrorEGFhBtBNY4DKJssFFh31d3fM1bP/jURrAkFzt32A6tp987ny0jMqpmygA8OAL0upKIpsESGaeN9gHvXexvHt+Alc6jNNDL+K6NNhggqfKB68nfNGWjOqDFeVAyPWfc2UETRtlKAiDppaVirZawAfQz4J001Wz5JIhPZqT5QPpaabEyKe1LFYp++wNIqi5iE5hwGvNiI1MblSJJvP+G8ddqgkdJnw7oNYs9W1eVJxlLsttGK9weoi7BbQnbkEA5s9koD/wD55z/RsAJf/C9bsUm6X5YOtET8cKhcZcpG+X6oUfvbq2I4NUPwLJT9+tTSUWqzgCuBK7xccfkqWRc9pRT72s97aO3trpe9A9sIZY33V4xpuq0Gh4uni6Lwe14aCWao8zrHQe++El2bGwYCfnkHQsmIQJSs0/qhT+Cls23cc8Yba75xfLoxA2uLokqYJ51wC5x/xUZFKDfRqv/TLIZx348qRonuh1fLb1NiwfBLPPCLYbA/YfjEUQHMkC2PcH/JYYIFhWAlxbeFceDfPw5orRjisanzXYu7RcaoE7h6/A=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(18002099003)(22082099003)(56012099003)(3613699012);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1cQrASzgesMZQeu8JE0KCL0aAbV/1H+wfbobZZsaRVogYFKf05jGw4fw9W92?=
 =?us-ascii?Q?41ctQ8oIV/ooxld3OgOyf6A2xH3CJ/Iqyj9gPuwrUAkJcdAXfcR4FljfkUZg?=
 =?us-ascii?Q?R5YZC9MksArVaVZt+db7WNFFBPRumyWY3mvxDcWKgkv/Z+TI+Z3IJWYql20G?=
 =?us-ascii?Q?dJh7QjNEDDGiAbjGG292FKb8OrZT8XXAhsqgKS6uBx9h0Mm0Y77dCgCx9ZMi?=
 =?us-ascii?Q?cKHWdZcfke4lwTuSp2gyu4ZYcRWvHR/ZONDy6AQlAU6g1sb/xYAF6yw0nBOn?=
 =?us-ascii?Q?DXY0AAuPAjpKZYcY0zOv2ZWn6j1oP58z9ElnS5IPA0xBdAHevw3FUNC9CY9C?=
 =?us-ascii?Q?Z0NF6FY/OEao//u6c1hd4D1NNl4kKiN2xgWSEkdv7qwfsXkS1ZPdteo4CZ1i?=
 =?us-ascii?Q?bI79gSchgEgBQjF437YKOLZ2ICOx/DIe7sWy80VJLMBvJRUTbnHWRfEFZNVX?=
 =?us-ascii?Q?cDj63vobrePkbbVRm6ldTzXdhsKFjYxVxVuA07EiBw1irOEmdHVwBa2qy+Dh?=
 =?us-ascii?Q?HwOKJp+xoIQGa45Vg9da7u+a9+RsYVtxOvFr+5sEmPiVtag6xuVBS9x7V2wH?=
 =?us-ascii?Q?JXNllZb73HLbV0i84rKn9yHLFdIzNDOQDSXBfqAa27cfzWqqCQJAHR2YjDiq?=
 =?us-ascii?Q?WaYP9Cg4K01m3R0muKpqm1+E8J932XizDh/Y/SaYj3tHmXVJu89U1Kc6xiK4?=
 =?us-ascii?Q?ZDORDXZGhD7hAcRyc4REILmtTei5Q2lGzwq7bQQkBnYfbjP+V0UZjyaW7IeW?=
 =?us-ascii?Q?mJiMutWY3AqDxR77ON65b68HhhXVTJyTMXPenQkimPDPX6SkV8zyd5BvMn7U?=
 =?us-ascii?Q?rJDH+yZbT1foOSYl4pMNW9oZy2uWB/kU31TeHoVs7FmLs9WQNhyNk6glksL9?=
 =?us-ascii?Q?LOsqkzEaKC84Oc761jyCvRACQVqfOaDuixli2DuhSwjDQsMx745opm4pGCPB?=
 =?us-ascii?Q?zD+Ausop9JVpec1Iqvh7QZNAHBFKvvf6112Ld7D74aUvI7yFa2zfHN0f7VU8?=
 =?us-ascii?Q?uHV+37icxDaF9o7frFMHk9bxS2vkZABy5OuY1MWwZwgJvgnmtLJrrqpcE0/w?=
 =?us-ascii?Q?4JKhppAkkFC7Wb6NbYD5cCgfJEAR/JTT6Sooo3FQdxodDvcS1OP4nScq7IP+?=
 =?us-ascii?Q?wpJuqjX2qT30AUD+y4nSgG2P1pynxTXA2rQLGgtg5/Km53Jn+wfXqkCnCDAW?=
 =?us-ascii?Q?nPqluy4D6KHRKaLBYHvTudNyZ9rTXBuP8rn4L0S6scUPECvnqyJ1etFR/dti?=
 =?us-ascii?Q?F+L2MyA5DJ4L9Nh3fuja10upS+ObyTnfr3HmLLpcUzhIppBCILL5GYq5cd5a?=
 =?us-ascii?Q?rc1Lpiam/YEh1gfGZklE9wQITXabDMO/BniUl450TdlxKPf1aHjZx2ypLFvW?=
 =?us-ascii?Q?3wyaHBqbiDCFR0UfEBnEpSa+3as3Ey/UJHrnugDZOW6gqgi4yCJJB7S1tUQV?=
 =?us-ascii?Q?A7Y32oADoriRPXxYLpQRjzcGaRLCJuE6bQ/sAIdrfZViwUGfXp3R9/YZ7k83?=
 =?us-ascii?Q?k3jWXbiS28j2NUqmNN+GbLIY1b807HMGm3OW6hqXOvxXXtsJuM/ouWmEe8l8?=
 =?us-ascii?Q?iOMCE7VxpsEIZ7hxnMecLyEnnOUFdZ2Wu2GjhWu1oYq9fF+Ogvlt3cwFyFsZ?=
 =?us-ascii?Q?bt/Wi867Q1+zGCzkKhZVd3zj9MLpNmIUAvE2his7bvwD3UUIsGvuDB5cRoPm?=
 =?us-ascii?Q?PI4KBL+NmKSTxVJnk/VdPYfLVAlRcourndApPpvgKR/eUl8y?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35f09a00-0de2-4ccb-479d-08de9694008a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 23:59:14.4118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9CFPZbezipnyn3ku4+SIw6o4yPqNrIGq67zlbSuXqDeIYvYmSaD9LhcsqDUrGXk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4328

On Thu, Mar 19, 2026 at 12:51:52PM -0700, Nicolin Chen wrote:
> @@ -655,6 +655,7 @@ struct arm_smmu_cmdq_batch {
>  enum arm_smmu_inv_type {
>  	INV_TYPE_S1_ASID,
>  	INV_TYPE_S2_VMID,
> +	INV_TYPE_S2_VMID_VSMMU,
>  	INV_TYPE_S2_VMID_S1_CLEAR,
>  	INV_TYPE_ATS,
>  	INV_TYPE_ATS_FULL,

> @@ -3246,7 +3248,10 @@ int arm_smmu_find_iotlb_tag(struct iommu_domain *domain,
>  		tag->type = INV_TYPE_S1_ASID;
>  		break;
>  	case ARM_SMMU_DOMAIN_S2:
> -		tag->type = INV_TYPE_S2_VMID;
> +		if (to_vsmmu(domain))
> +			tag->type = INV_TYPE_S2_VMID_VSMMU;
> +		else
> +			tag->type = INV_TYPE_S2_VMID;
>  		break;

This shouldn't search, the vmid always comes from the vsmmu struct.

arm_smmu_alloc_iotlb_tag() fixes it after, but the call in
arm_smmu_attach_prepare_invs() should also only be using the
vsmmu->vmid so this is a bug.

Just set tag->id here and return. Move the tag->smmu up so that is
safe.

> @@ -3357,7 +3369,7 @@ arm_smmu_master_build_invs(struct arm_smmu_master *master, bool ats_enabled,
>  		return NULL;
>  
>  	/* All the nested S1 ASIDs have to be flushed when S2 parent changes */
> -	if (nesting) {
> +	if (tag->type == INV_TYPE_S2_VMID_VSMMU) {
>  		if (!arm_smmu_master_build_inv(master,
>  					       INV_TYPE_S2_VMID_S1_CLEAR,
>  					       tag->id, IOMMU_NO_PASID, 0))

I think this function should not mix nesting and type at the same
time..

If INV_TYPE_S2_VMID_VSMMU means the tag is used as a nesting child
then that should also drive the atc decision:

	if (!arm_smmu_master_build_inv(
			    master, nesting ? INV_TYPE_ATS_FULL : INV_TYPE_ATS,
			    master->streams[i].id, ssid, 0))

Because it is exactly the same reasoning for the IOTLB full
invalidation.

This is the only place reading domain->nest_parent so we can get rid
of it too, instead it effectively becomes driven by tag which derives
the S2_VMID from domain->type == IOMMU_DOMAIN_NESTED

Jason
