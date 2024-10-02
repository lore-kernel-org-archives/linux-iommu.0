Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2051.outbound.protection.outlook.com [40.107.237.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A286211185
	for <iommu@lists.linux.dev>; Wed,  2 Oct 2024 04:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727841933; cv=fail; b=bwF0NlfypURN0ahEhdPac5W/0d1eo/RIa+aX49DJea5V2Z0pghYaI6rIvfIdyYV3bNQCJZfYkpf1NKs/CSQl/Ym3Q4kkV4dZvuiL2ip+KOlRByCvOsttG2KbgrnBSheftW0TtAXDiPSEK7gwJ0ReF5qid//WLgHwt/9UZzFntvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727841933; c=relaxed/simple;
	bh=V7AKCJqpTOeIUpVYIhfMmVtdBjtX70Qyqw5kHsDXXiU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX978rU80n5bKPdkTjCMwYXEwT98cf1Xikns9ZZPfD1KUeYrLaL2N/C80NUEHx2QgiRTI5VQXVW7URCJvdfqPnJUY8jVN2F6eZfvOh3mgTqNiyXPin9tzam53TrX4Qxe1kv6hS6FkiEMMZl0KjOcDMElg13NS/Yg59saIYrih2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=udkcahiD; arc=fail smtp.client-ip=40.107.237.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="udkcahiD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETMD2ZssUeQ1IJWNV6L27lltSBj+Qd2p2t6nMI/sT+IXje7+lpLRZWnaBDjfl+R36DjKerdlb6m9d4PvD60XCe7tE7RfLntc0x0sGeswfqLLZCwWxF8oCgr9UhwaOJFM1akLlYMzpb8BNSu7Rwl8OBG/pKicvAy28R+5NALtI6FT7nezqKviyN/sudWIyVENpbSGXUJVZ9OFquklntNzlKqgkMFp4xz7szM/iYpypmMBvZvha7gC5/Dx1NEsdH9zbJoYeU4aOe9cBoDON09R5Ufu7YNtbZkG37g7b9j9Vmp2NunmtLwIaQyg8Paa90xrJGW7wtJ1IFnMYarm7U5vMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QuEIoMnG2wXy594rbuQgqmTI5a369+QVObNCBa8fSJQ=;
 b=oEfUceNQzhOg9zgFRDRohSl0w7Buglsp7VOymfDRzhijorVRq/apDDz4QaXPuGql7UbHGfKtqfxfkQo8f9usGYIbLyB+5PkKsHoxOUEIIxHun5ys1U+PmwZduuJqpKDNFnbr4hf1o4Pl3X3UkSV40ytpVRV2RkkXOpUdVgn7deJ5JGE8i/I1hhF4uFKrIjYVPTxgHe9Xbl39GtJCZaYPKf7fb1EBopChZh5jwKwsoguAm7EPBP6BFRaS7bvD3PI9Yiw2wB+ss/dCgMeow3qZZ1dwZiqCztEQ7nUe+h5yyLsy3FCncOzDCE1fcgwztdo/LGLxpliDAa2o2rHpqZnG1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QuEIoMnG2wXy594rbuQgqmTI5a369+QVObNCBa8fSJQ=;
 b=udkcahiDn5wn5cIuwIQc19b90ZQ8ETeLRuAA0bN51G7VCUf6isHGXvUgYnuEUkZVXeHWCauhmJpnEqYwgyWQgcrTicCNtNlATKPiJ7Xt1+w9H+YE5rBX/6Bi6uh61U2fjOOgbclz6zPPOQ1FTBNbRfJG6xCx14HP/7VlOvD49dIoo/9REUVoFE4oAyyE+vpto/ZAilGHlqu5sZWGqCvfZWT0HEjQXffpapdHS5OzL8hjjHYikkmBLPru1K8QZLQqs4X+GJJJ1wZ87z2cuyPrF4WpFnEKUNCRQXRcm8k8RDRNCpUSLX8HnfH6QVqWSqFD2fmAbBFj0d9z1x6OekfGug==
Received: from BY1P220CA0007.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::13)
 by SA1PR12MB7410.namprd12.prod.outlook.com (2603:10b6:806:2b4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 04:05:25 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:59d:cafe::16) by BY1P220CA0007.outlook.office365.com
 (2603:10b6:a03:59d::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16 via Frontend
 Transport; Wed, 2 Oct 2024 04:05:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Wed, 2 Oct 2024 04:05:25 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 21:05:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 21:05:25 -0700
Received: from Asurada-Nvidia (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 21:05:24 -0700
Date: Tue, 1 Oct 2024 21:05:23 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Daniel Mentz <danielmentz@google.com>
CC: <iommu@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Ryan Huang <tzukui@google.com>, Will Deacon
	<will@kernel.org>, Mostafa Saleh <smostafa@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Fix last_sid_idx calculation for
 sid_bits==32
Message-ID: <ZvzGg0P5Bj2sgNZm@Asurada-Nvidia>
References: <20241002015357.1766934-1-danielmentz@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241002015357.1766934-1-danielmentz@google.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|SA1PR12MB7410:EE_
X-MS-Office365-Filtering-Correlation-Id: cf438fed-02ac-4ad4-3caa-08dce29771e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QQeZApBILE2MbTfMVRgoRYuofZ3OOdctD/KTj7+L/M+XDRk3Ktq4rpNJwnu6?=
 =?us-ascii?Q?NhB+Ef3JIaSrJYvgl4fJCPRMg56iAQQoEhtaE/xDMXrEN3fB5eLepOLn9jNF?=
 =?us-ascii?Q?57WjqVOtd3T4fqNSSKsFCOVrYTl3ag7rmQj/J5mS8mL+bCY0xMZqTIsS4UGw?=
 =?us-ascii?Q?dQh/AZLnySH/iY1x5Cn+qiCjPNn26z7mp8dRvGnelfdlaflbR6gFRiKK8adI?=
 =?us-ascii?Q?aIprZjc3xLUxZD+82Tkj2QIV4e8beG7E5bpi50SEkZliAUu1r87wMmbU5fB7?=
 =?us-ascii?Q?6Iqlc+a/+UX1svntyHY8x/Dj2ycHSj0SxoEz7YJAC9YPAZ2wZ9M2GydU5rmE?=
 =?us-ascii?Q?gFVZaRV4UVxmPkBygJD9GKBU+ohQg9t6rIrIfG/31qQUf3ZKUKO6uXQm/sVg?=
 =?us-ascii?Q?h6qvh4VdpHHmLrSg0dBp0RUgBZQP7K0hD31uhzUKYHm9Bxu7LzXS9jeuB7tC?=
 =?us-ascii?Q?TNTz8gn1I5VfdJfLJCMGMxOkAON3T4CvJdSdqMCBm9i1arv5ssuVlgJhM5fQ?=
 =?us-ascii?Q?f/WzCBF3L8uyADzVT6qiZ0mwIvsRXdJMaonXbwJcAL43Jd6a5hRMhsU8cpLB?=
 =?us-ascii?Q?VA8TRCHZTG4yN7VF1pWvoc2LysfntW3cYxAScXo8g43phacQkVl/V9J1KhUE?=
 =?us-ascii?Q?WsElvCOqqr2rS4LGG99RLMFwVPBy8ej/TIIh0HDEx/vp4GoHgqCQAcWTDmgv?=
 =?us-ascii?Q?njZ0wfVQtNnLAUxW25klT4R1EVqr8M+00VAcruVkLm5lBafUgRWwj2nalJrJ?=
 =?us-ascii?Q?3XFGELy4G9eNmZNDgdFAAtkLJjVomN9hw/W8+SUlv6dZJztPVRZbQb9D4ftX?=
 =?us-ascii?Q?u3V7SXhtoBXBHJ4bonAe+jjltK0WbXF4yTfZyYgyvw4t7iFxU8KvhCzmytQp?=
 =?us-ascii?Q?sKIQV6ruTpuPR3fd+xLU+ZaXCMiPVUTHN/1DLXmcUxoigWyFExbCUGrf0gbW?=
 =?us-ascii?Q?oXcjHF6zBXQDlu/mjgWtw91uqpWD7nURVWuMTsSUwRMovSuif3+JfAzWd8Y7?=
 =?us-ascii?Q?BbO+MuDFaxD28D46QdnLb4hVGpjqt8U9uZYLCrE80QPHakYsbKeSsFIYGAHf?=
 =?us-ascii?Q?oCevI30SNe2e5fLGQAzjVbdT7tTNKw2bjVZfkVor7i9w60VqKvY5LXDnqBXC?=
 =?us-ascii?Q?qYgDKGjvcwhmpzKUOR9a1ZyfN4sHL+RVgGvhpMa/uUzn2OGgn5n8Bii7aRIm?=
 =?us-ascii?Q?eopnCf+d4unsaofZZI2U1tTYal+OIlSh7AV2UFwNUIgvDfTHgemd1DQV0Chd?=
 =?us-ascii?Q?mSRX4NkF3AAd3AgdKmGapm98W7Jrhyei7V1FZX+McZgj3JE//WVqGWNn0+Dx?=
 =?us-ascii?Q?udJ3r6igILzVMIE8hzEpq30Fcw2igoQjnL5Rqq0fM689pfVx7Mvxb0YL8osK?=
 =?us-ascii?Q?bs9IV6V0UVqtNbF5g1vZkFkQbe9EkwF4/aF9AlUzGaTM/LqAjcLOwB29vK6m?=
 =?us-ascii?Q?3XLboF0iXP6pQScT1i0PTZ8QUdIuCRf2?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 04:05:25.8046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf438fed-02ac-4ad4-3caa-08dce29771e2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7410

On Tue, Oct 01, 2024 at 06:53:57PM -0700, Daniel Mentz wrote:
> 
> The function arm_smmu_init_strtab_2lvl uses the expression
> 
> ((1 << smmu->sid_bits) - 1)
> 
> to calculate the largest StreamID value. However, this fails for the
> maximum allowed value of SMMU_IDR1.SIDSIZE which is 32. The C standard
> states:
> 
> "If the value of the right operand is negative or is greater than or
> equal to the width of the promoted left operand, the behavior is
> undefined."
> 
> With smmu->sid_bits being 32, the prerequisites for undefined behavior
> are met.  We observed that the value of (1 << 32) is 1 and not 0 as we
> initially expected.
> 
> Similar bit shift operations in arm_smmu_init_strtab_linear seem to not
> be affected, because it appears to be unlikely for an SMMU to have
> SMMU_IDR1.SIDSIZE set to 32 but then not support 2-level Stream tables
> 
> This issue was found by Ryan Huang <tzukui@google.com> on our team.

There is a patch that's sent a few hours earlier :)
https://lore.kernel.org/linux-arm-kernel/20241001180346.1485194-1-yang@os.amperecomputing.com/

Thanks
Nicolin

> Fixes: ce410410f1a7 ("iommu/arm-smmu-v3: Add arm_smmu_strtab_l1/2_idx()")
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 737c5b882355..b55327d6058e 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -3625,7 +3625,7 @@ static int arm_smmu_init_strtab_2lvl(struct arm_smmu_device *smmu)
>         u32 l1size;
>         struct arm_smmu_strtab_cfg *cfg = &smmu->strtab_cfg;
>         unsigned int last_sid_idx =
> -               arm_smmu_strtab_l1_idx((1 << smmu->sid_bits) - 1);
> +               arm_smmu_strtab_l1_idx((1ULL << smmu->sid_bits) - 1);
> 
>         /* Calculate the L1 size, capped to the SIDSIZE. */
>         cfg->l2.num_l1_ents = min(last_sid_idx + 1, STRTAB_MAX_L1_ENTRIES);
> --
> 2.46.1.824.gd892dcdcdd-goog
> 
