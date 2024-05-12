Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2062.outbound.protection.outlook.com [40.107.92.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2702940F
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 17:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715535774; cv=fail; b=NT6fRWiqhR93eXnc1jQYP3NLCLhb+SGrUqBZFC2t9tHlPooSDvVol3iSymshSPYoKEOlIh8PQXEmyIWK1dQ+P2H1V93USvYnS7kwjZNyWAtwcZpJ4Kbs8xZzBOUZ7n7RLJVab1VTtVHoKzDm3WFJmzQQwao+PypRA/V0lk4MEnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715535774; c=relaxed/simple;
	bh=cTZ+ka1hUaaW6yPKA9PzOq53HNp7kR4+ObMQVx2pMjs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TcKmt/PWtTK0ASjRu6DLEjgelBs8fY/P8Va33sbqAX1VPqaIer0/h7C3lVLvmmQsu4YzZr8Ua2T23QvdqJvyClPjwfs3LbZ1vFAHqTzDwhC6TGpMVNc43p6Pg22S5Y0PHoVJN2DhIzWgnga7WZ/3k1yjyPCCF/tUV9pVthzbVOo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pBnKecjH; arc=fail smtp.client-ip=40.107.92.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pBnKecjH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b3wHyNlyEik2X7u1MirbY2so0FymT4ZzX3ftsqeZqzJ64iBI8yKZMgSxOxXRJI5lWnDVsNtXSfBncF4lQ+wBvAu82ofWap45MqgejxBYcotAGJ1eN2qwhkzgJW7Qd9fvkoa0Qv77w76onUaoTi5aK6gb+DBxqqIMFbtbrUjfyN63AtPaEBzgyLQubXAIGU+WV8riJRIQ/n07SnHaI/oQ9WHbKKEvxFPbWC/LPBK+PI3/j8VNjF1MDkrngfwKRBPeRGWnaxfuZUrT2t5sfwxHo0+HYsIhytwXYYAVTp0+zgXvyznr45sFMJ1WF9wdAK6yKhCVRWTH/5XMlU4i7oLNaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8BiJfOnYjO5wqie071ipWPsNAAHf8rni0f/u90ISxcw=;
 b=m7jg5vWTMYzFwdyVbEIhTXX5qE8Rrk6h3/6B2+Gr7xM1CYcaNIRluYmzmmV9G2SmlyZDNsTgu+9g6WjrhutO7AQXgHyO5+Ji8XneKFLRjmu4yCikEXbp5HxpKRd2PPg4HlWVIcBE1BZdK0Acv9gZCkiCmgCxTYeBlE2rsOXnqcJRH4OvIEfiBKXYfHhqj2cH2ZtQFzbamUXbCcNyoJ6JnpNgBZhjehBdarpNapcqrcnL9NNP3AMZKt0XvvVC9f8nETmH5zF11WLlqDghTd+lAFgnigntUfD//V4olJIjujPfMDyVmF6WYHvtOlQHbdLLS/jYM8B8o0l+l2QAYzCvsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8BiJfOnYjO5wqie071ipWPsNAAHf8rni0f/u90ISxcw=;
 b=pBnKecjHRbLu2DDkCrx64l11A/rI46AqfSsP6ds/ssaFucKFIWpvL1Kl0Bzcg5a1TCJ36LKQAJ54dJWcVGuZclq2N5iAuDMKD9qArIFKyVEbrqqBoeCCeT9vWdChAAvVxqUHHYCjeTziWLC68Q1894Ne/52kS6Ap2PmX37Ks/u3OvOBceK8Ht08hkh/O9ohwne/3CngvCvh/pTTTyAMcI1CRzwJ12P+c1VBZYnMnHYIOyrM/VYu8YOHpv9Em3iuyk4/1oA12F+2XjxVSRs1YqGQvh9CPu8DfFFQj/BUFVbfIr86L55oEyuceGTVcLSjQmbaJUp/XYxwcfBkKO9PkKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by MW4PR12MB6874.namprd12.prod.outlook.com (2603:10b6:303:20b::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 17:42:48 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 17:42:48 +0000
Date: Sun, 12 May 2024 13:06:13 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 6/6] iommu/tegra241-cmdqv: Limit CMDs for guest owned
 VINTF
Message-ID: <ZkDo9US02pD6vysO@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <062cf0a1e2b8ec6f068262cc68498b8d72b04bcc.1715147377.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MW4P223CA0006.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::11) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|MW4PR12MB6874:EE_
X-MS-Office365-Filtering-Correlation-Id: 7294f779-cded-48db-4a06-08dc72aaf02e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CZyLvBFKVj/kvD8M/wD1yMlI0gBGSyUssn3wDsJwpSOEb2juUNIkmlbDvfU6?=
 =?us-ascii?Q?gPS1ZQcEPNGN9/z3oQfD4UqzBvmowo/B60c2c+hVS+yEUy2vxvr6rFTozfVs?=
 =?us-ascii?Q?dv50CSVTNkimlCiiVmPcJH5lyiMWBeqZ0Oml81VTdGKBuU4Fyr8ywNhK8iJN?=
 =?us-ascii?Q?EH6iHr41CK+9+1KpFi0gbhw5T40gVmp40Tn+8AYS95dTw9ofPb65Tj1mPyYd?=
 =?us-ascii?Q?wp7pMkqrwm1nq/4B45AliMmp+qJlq4sTKC3P1+8dOEok4RDFw3Zptt3mFNr/?=
 =?us-ascii?Q?xghqBHfnv+1El0AwzHNK7n0hnUTE4VDpz94FU8xH+CQSG/5qRiiNvJiiZdR4?=
 =?us-ascii?Q?cP4wIg4+u/0fULtb2KkYffY9MuFhguLbozd2y2ObHbJNbbYdcJ/rSysix5lD?=
 =?us-ascii?Q?KtoRYZBh502W8HS+WnWfXLUtbaI/j20+OZkuSslL7FaPJH83HuZdGbmzT2VX?=
 =?us-ascii?Q?dUDDgOu2+IeJX1Y0fGdSAs4MoqZdDD8/BbSNqGj6Xmdl5YU/dBG/j2Fdjwyi?=
 =?us-ascii?Q?so1UDR2M0694krtUtTfB6rWzabqmdxktY3jn/gVSPVlRbA3kX7XHe5c+wQ6a?=
 =?us-ascii?Q?MVn6Z9tiH5fm9DF0cmBKS+1ZZGD//2yU/Xf/CB9HzDI3FVAatHHnBVRMypN0?=
 =?us-ascii?Q?xEmUdNJL+d0P3HSTCKw7TJ9hSB0qonZpezTT1WrRc2PXLxqecIzXpDReEHgd?=
 =?us-ascii?Q?mjNT+sQMWtSIEgw06hwvRmP5r9in7wU9EYFj3gABzQ3b9hUg/h+PVTNr4VNI?=
 =?us-ascii?Q?lszW6Zxxbe4h2E8GhvgNY7p3yJp3+TrutxQQ5gBDxcfAD4l43Q920Ke22NND?=
 =?us-ascii?Q?tuVL3/584Eac1PjNFaVWzh4VMs/016aPsWZjd9JbTrbUlVrxsv2yYY9D6ZZm?=
 =?us-ascii?Q?cM51ZSG89ZDMY6wzF0DvyltwCtTqbdF7QO6g1YEfOxd40MMC0ZIVB83F44ou?=
 =?us-ascii?Q?6QGggyJtrev6aFF18K5rSD1Aq2rHlM2x9mzi0XenU7HQjg+1KgsR9rYAjEyu?=
 =?us-ascii?Q?Och3eYDOHUEZT+k99WCjgVxYenXMqD7zHbyZZcv52IegciY22OH9oP9hetj6?=
 =?us-ascii?Q?0lRa3UX57XEnylHBJuD4ZCAcOC0MoB/Km1APNIOcW2JSO5Iu8OmNBLHC29gW?=
 =?us-ascii?Q?8Zu7ijfsRka1mIhwlPKinb425Y5lLHg/YutsH1H9dJ8vda+XMuPbC4WyYG3U?=
 =?us-ascii?Q?et2b6XOoCRMkG7dcke0iRvPGyIAY257X/4B6risBDqNnjc6pYtIRdi27jhK1?=
 =?us-ascii?Q?2YY9efJlDPYQjSKhc9z+Ydod2tjr50x9n85K8A+d5Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?4vkUSyqbLDeDWK3+/+KdAhTJPIGpok7N1k472PuZ40eTgn7pKmkkUpUA86O7?=
 =?us-ascii?Q?AcHCnDYoo/HGdKSf97f/BK97F/RKvpfDqC8+BPygmX8f97XjObiJpBv1saUK?=
 =?us-ascii?Q?SeeYC9zhVYq2WSzqElKMfPNTNM/hQ7y8OjIQuperoYmxWKoFJR3ILcrwcMsQ?=
 =?us-ascii?Q?UzWrRxDooz27D2YoawMKrVF7b4qAJf1/PZ+W8xgmHfo40UGF3wRdyJyQ6Cv/?=
 =?us-ascii?Q?MJNtGIfgPq35vqOzHVIw3IR2q4Z8spg8VcEum8tFOsbTQuZcHHlHl/xt9Oiw?=
 =?us-ascii?Q?MlaDPOHDGk7Tx0nMdDdw81wLsDznZ8SrmkZcNNsrEZjQHxy/r1qxfcXDOvpC?=
 =?us-ascii?Q?/+umH/QuqM4UsU+GtPDC7W3zPZvtZQTyi9P/hWff/PUmTQsfYSz4R0zVlwU1?=
 =?us-ascii?Q?VFjCqbgVuTfVxaB7xq8YSZ+xX+6+bbEZzTsa7MqUAIzsqEdH/bEYcDr+YWeV?=
 =?us-ascii?Q?hel7vA12NmXSWBYAaqk8vLU95d+S18wbfpyUURqfMyfTU+N5neoOIt8/EpY8?=
 =?us-ascii?Q?X4Si6Q+j6JHn6+Xfo6UyGyowlF3o5l82Tj4pYyopHsD40z3gvquYdxS634Uv?=
 =?us-ascii?Q?0PaQKQhYc6kZq6HB1Fp7dr01W1pbFt8mpDWOTS4+b5YHXLNvTxDsGYC9Ba5C?=
 =?us-ascii?Q?sScMqDR5Str5sRyKLLDZqY6ZrPhYhnCcWlmu6Ag+CrlUkg8eNgqdKbl9axya?=
 =?us-ascii?Q?H4bEjsgG6lIhQKTTTkMZRtnnp/x8dEmDNJ81oVYoOA2HAKAYw9E44oqQYBHB?=
 =?us-ascii?Q?3hQJlZVZ/dYj8I/hIZ9zDDYQTLdmog/LxRpEOEpAOZCdp82xwqBbBofvPLEQ?=
 =?us-ascii?Q?99t5OGisuAkFnQ5A/B2cPMXhuFcWdHYj+SnF4gNHr3Y8w0w+VIHa66r98DOW?=
 =?us-ascii?Q?q48IVaxO6TxQzMXau7C9fXcsbtuQ8d+hYTVFmACK2NpNigvdULqrAlN61/0j?=
 =?us-ascii?Q?vgPJC5iTtG+8ttMadyqty4arv9UCbN5mVmQhGh7r0GFP4UtvJf3RFhHrQNFR?=
 =?us-ascii?Q?+LpNsGsOKaXqJYUv+5DxGKn4712YnRgb8FEQlKEtD5X4mm8gG84ypG1tNXcG?=
 =?us-ascii?Q?PAo075T1PxT2DQF000uJ51bzeHe1PQaCotF60dxaK8yAZgf7mQn2JGaRYEna?=
 =?us-ascii?Q?ODupkaUUd3rGmrx1ZeylFkqWvkwbC0hZt/YdYblCzg/aa6YQINP35eAWNR6j?=
 =?us-ascii?Q?gBKaV2KoaoXEQ15BoyAQWyDKNmEW+j/s83S77v2rg2E3PFKLnEax9x2SwMMI?=
 =?us-ascii?Q?K9CUaqJkrU4hv82hnoTQ4RPCVJeysnzktdv80tIU11L0kWLw9NPRy/2T2B7Y?=
 =?us-ascii?Q?cb6S8yYg7QthEcqauzszWKt5UN4He2bZxxfyWUoYyEfnMZemDoOmKyAwtMnv?=
 =?us-ascii?Q?RF4QyBNk4/GoOmdn9sZAVn4O0bQ6vaf7ha4olEkdJ5oDPcr031yMJNrCBQ+k?=
 =?us-ascii?Q?slWATgRjpbbCKprSwSd3kFbomF09/daZyUIbJOjQBgpShNAIYRxyIMFngPEb?=
 =?us-ascii?Q?o/cBIxi/Xb24uHl8JlYnwSUqoZgOIljxLGSrysUlgmGtsQ1gZZtoNPID0CM9?=
 =?us-ascii?Q?HmKN0X0PV48ORN5GhQMOA73g0+d5/7Oe1Mk4Mpal?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7294f779-cded-48db-4a06-08dc72aaf02e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 17:42:48.1254
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bb7yuHzxf/kjLK+GHxSzo/NnmmtuZxhTd5lbwdCmunrO8Zv5nS5+JFkM/qv3r7p9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6874

On Tue, May 07, 2024 at 10:56:54PM -0700, Nicolin Chen wrote:
> When VCMDQs are assigned to a VINTF owned by a guest (HYP_OWN bit unset),
> only TLB and ATC invalidation commands are supported by the VCMDQ HW. So,
> add a new helper to scan the input cmd to make sure it is supported when
> selecting a queue.
> 
> Note that the guest VM shouldn't have HYP_OWN bit being set regardless of
> guest kernel driver writing it or not, i.e. the hypervisor running in the
> host OS should wire this bit to zero when trapping a write access to this
> VINTF_CONFIG register from a guest kernel.
> 
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 20 ++++++-----
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   |  5 +--
>  .../iommu/arm/arm-smmu-v3/tegra241-cmdqv.c    | 36 ++++++++++++++++++-
>  3 files changed, 49 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index d1098991d64e..baf20e9976d3 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -332,10 +332,11 @@ static int arm_smmu_cmdq_build_cmd(u64 *cmd, struct arm_smmu_cmdq_ent *ent)
>  	return 0;
>  }
>  
> -static struct arm_smmu_cmdq *arm_smmu_get_cmdq(struct arm_smmu_device *smmu)
> +static struct arm_smmu_cmdq *
> +arm_smmu_get_cmdq(struct arm_smmu_device *smmu, u8 opcode)
>  {
>  	if (arm_smmu_has_tegra241_cmdqv(smmu))
> -		return tegra241_cmdqv_get_cmdq(smmu);
> +		return tegra241_cmdqv_get_cmdq(smmu, opcode);

It is worth a comment descrbing opcode here, I think.. At least the
nesting invalidation will send mixed batches.

opcode is sort of a handle for a group of related commands. But what
is the group? Minimally it is opcode + SYNC, right?

 The caller must only send opcode + SYNC commands to this queue.
 The opcodes XX,YY,ZZ are interchangable and can be sent together.

?

> -struct arm_smmu_cmdq *tegra241_cmdqv_get_cmdq(struct arm_smmu_device *smmu)
> +static bool tegra241_vintf_support_cmd(struct tegra241_vintf *vintf, u8 opcode)
> +{
> +       /* Hypervisor-owned VINTF can execute any command in its VCMDQs */
> +	if (READ_ONCE(vintf->hyp_own))
> +		return true;
> +
> +	/* Guest-owned VINTF must Check against the list of supported CMDs */
> +	switch (opcode) {
> +	case CMDQ_OP_TLBI_NH_ASID:
> +	case CMDQ_OP_TLBI_NH_VA:
> +	case CMDQ_OP_ATC_INV:
> +		return true;
> +	default:
> +		return false;
> +	}

When I look at the nesting patch it also includes SYNC, NH_VAA, and
NH_ALL. Are they supported here? VAA is not supported in the HW at all
right? What about NH_ALL?

It looks fine otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
