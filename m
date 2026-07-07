Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010021.outbound.protection.outlook.com [52.101.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F0D42B304
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433929; cv=fail; b=k2uK/nNomOysMkCihy7O5SSVcWuOBdmNTp2aPFMp6+Kv82SuSNXuI3tShVL/6EwAKCVpTaYriIh7ERKtCJ+V8HhvhDbopX9s12t3e1ZENjR5AgjWMwRvsTZ9pFOd3XG/OPsH8kgkXm0fHXKNBzeHW5xpOR2CJX9rvCEUNIIWJMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433929; c=relaxed/simple;
	bh=fhPzg+9gi4/ppimNUv9Dg/a7Cuu6PQigAECF6FQ3Au4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KbRLyE0LNYvVIfOAWyGmnsATdLNhgFzZPceU4JT2vnRbuwjsuCP5M/s3bdxKmmpQIjmab4t+bM2eh7dC3aP9KBSOKfy/HKboZuu9MVdF5rLdTEaR4lfG2RXvkJNgzaFdDg4synhF7efb8cqUf980OR6K8NfPDcTjVnORyQvMcos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=maTxS7dF; arc=fail smtp.client-ip=52.101.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="maTxS7dF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iz820ZGgU6Xym+3OsP5fG6jpstJPsCbHgRME+h+/eS4vSoHyd4UX1dyldbERMXDxiBsXZEePscplTTkU0geaOiexWYOc+1HIII93Pn4fG8Ju5L0Fz30QMWwQcbFEVnvrvCODlkSaUzDxuUhL2yBfgqY0inDceSvtKLGGUcX/qQVT6gpxkw9+k6YjZALYCi3+4pqwP0ZdhfDJAlCCS0gaKdfOhqwmSBeTgkqVmkHq2RA9H8wUdtg4gffCVZRfbgQxLbsX23OW8t0w5HQnlJsowidgKpwKGww+OtBVtqkwKq//x5vDFdnsjSPm7RMyFNYc2/sSB3ayuNv94p0DIiP/cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAVWKzuglWRINoiER5bOG2xeL1FFXXvW+b/mAswaKSA=;
 b=fG3bJrnn7pP8GJ1BaDJ8C3qODtic8HCzcEYutgW7ikXaDWFEq6uNRuqOIb9zEIoeevbWo5FZAZ6hmu31nnpcgsAU9fJ+E76uu7mlR1J3RgSeDveUaqN3/6zYYm8gazmZljq0jH1PX462RDpUJCsbDZCZpiOvVXnhRFJlxJryL/29QR/VCtDZPNU1fqAvIOx/MbCVC3EwjUdijoC5JfxhbsGrUdxsd4pAdrg1PVKwsOQ3CKXSD9Wzw6xeJFL0oU+qShtkuNInk3Iz4BPnFdBWThMzTHsd6O1QFkiyrIgwk2DoPldUOIvGsABFvW05cEvXry2WB4tKnSlDm/Rs8r1M2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAVWKzuglWRINoiER5bOG2xeL1FFXXvW+b/mAswaKSA=;
 b=maTxS7dFGgUt87VBfBerd1x30IGIYDkCGaFTkC/lQWRrBuC17op+iJCZWbw+S0ltZzLKzbUiKoBlLGXDdNGeB3EgX0+ExIbCIuVnr0W03iB44TPjOa7DVsT8R/OHLSnvZB0fTeE2N1fk052a3RxqBa/2O3mwi5QulEQBR9GALbHvYTjDzx2hZWabNAALB1fY9dj4oC2yIGd2a+9wzy/BGCMQAqfkC+NJqcLX7llOkjQsIy78Tc5X0KAwWYUoWLlHpZ3XMXvocpddczHzI/vDbBNeQ2Eg26O1zAwlSf1BGUZswxEVD/oOrgLS7u9qAItfT8WAo4hm/1js0jyHy019TQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by PH8PR12MB7184.namprd12.prod.outlook.com (2603:10b6:510:227::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:18:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:18:35 +0000
Date: Tue, 7 Jul 2026 11:18:33 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 10/22] iommu/amd: Pass iommu to device_flush_dte()
Message-ID: <20260707141833.GB220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-11-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-11-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT4P288CA0068.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::26) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|PH8PR12MB7184:EE_
X-MS-Office365-Filtering-Correlation-Id: a71adcdb-391f-4200-08b5-08dedc32a176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|366016|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	kg8CjMz2fqYBzPCWrJKjNYwrK+vgNX2gV/J3amnFJy1zJhDCy93Dals0cNxKJuPDAfmWLrpowI6Nl+4Dp4qOar0lbvXk4yQ++yEma8Mtsn4iOoqC4DkJQ0SuBj99NnjHCKKzXQ12MLm9EFG21BOukGveON3t+knOt72BllG5cnoWl0ot8iXxNQxO1a4ONna7FiIk+BVMXB8H2ouhnzFopYXTBURA1jPd9YF8NdUabC1jicjAA0zHEazW41LIagmwVOn8bIJQKxUQK/OlZi+FmlyJ6lpJTvELoX+yQT24pLslLyCW2EqrJpVCwMeyjupksX2+SWQiW11vcj1hF5pbESbHKz5yYUMkus9jaLtzt19unZsD7mCCfaFrZaNLDGYIHAvEayyDsiZsT2pg8rfX5bavSd1S1pt80JfzdgPJiZc8Z5/i/OjfOC1fC8asFjyHAHrfBrAp3wcQMbbA7Jda0P5DePuVo4NGaIeOZ6xzpjJL+0lR+lfDpEaB6/zJqjzI6wsNsgKlO6/gRLjWr0RuYnlkD4uFoECSY/bVwbQXAU/LhfWNzRwFuikyewWxhfEQdB2R0z0hmg7/4r0DT7kthpF4MpoUobEcl+fWVbO8EZkPf/diMt0S8esBh3A0bEcoYFCTAhexhZszKlwCmhfBi7IRkRCZjvfP2H+BXjSttX8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(366016)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D2djqN58jCk6MYV1x4jY+hG7EsWk+DChq2Ub05//xdMRSMz5K857MJZFzr3L?=
 =?us-ascii?Q?2Lg0D/dSPcCBXTWtwRCqvMSDtapnvHtQZVn4SYh4PtS8rL57dqBheXdZHtjX?=
 =?us-ascii?Q?9HCOqkvORiZbpjct3WTOy8Vf4OqT2vzgG7SLTTlsdjGnuwiZLX5KZ5IGtHpi?=
 =?us-ascii?Q?UIQsJGknsBeNnUngS8q/DT7jRa9tnWs0w1gEJSWmptj23h/WzsOByKDckaJ3?=
 =?us-ascii?Q?NMo49ltJSKoa28C4SweRCvs1a15q/Mbya6zCEntbAVraTYFtpPXXve58OzMA?=
 =?us-ascii?Q?KUd58tvQyZw0ebZu0tHNHBccAF9w0UIu8IBi2zEUcPd/VX34ItfAh5dH/CiU?=
 =?us-ascii?Q?JJmw5fQVykn3ekLrX9GGyHh6aFHHG2NEtWrYMKtUH95sghTHIS/e1FH5ZaD1?=
 =?us-ascii?Q?qpFfG7TMnyb6bI9Ny4YUFRgPWS3HPqZnS8cNYIw5Hx9EBE+LFZg8UAkhuDKh?=
 =?us-ascii?Q?02eFwKvEX3zY9M5h+OygqwvR63V5ea3xd7im8sks7LCNn5GzLrkDIfGi7qMo?=
 =?us-ascii?Q?B9S296CVO34xFYLVyECs0P70kzUII4LtyZKrpjjBaLqU0tipSUtvdYjCE06N?=
 =?us-ascii?Q?ZaS32Sm+GUc6NSydRR5VKS26U+eEu1P1fwvNVqiqk8m+VrdVoukLPpGmhAXe?=
 =?us-ascii?Q?WSDl5bpIAcb2ha8s5ZzGwmjBpqrgPIySgMy2/ZIOJWnkM2BQ0OISBNYGCCES?=
 =?us-ascii?Q?2sTMxYtZ1cCk5bze7aJgvjn/Os6Op+l+03WLekaCDKfwcS7A98tiTtkEhgi/?=
 =?us-ascii?Q?q1QoqhVWhssYBZ50xKXNbJxkwDqqjfw86JEOtKtemSTDYhNOlfQM4BYh22nM?=
 =?us-ascii?Q?GrGsqAhhSx0PppStpmLp5sHKvhzQfwxYWfqCz/RGukHVkZ0aQySmRDEY/SEx?=
 =?us-ascii?Q?X7lCuTC9adV16AK+NITx20fpCoe2vY67Uet0ZI/gHZZ3VY0BPVQej0UJROAX?=
 =?us-ascii?Q?8ReTa9K1Fb5+4SjNh7lKkWKGOKp3vGpumHrfGGHUery7zHaae/4N6ttw45y8?=
 =?us-ascii?Q?wNfNtvoekzmzpc3Crcy2XxQbb8tRxcfwuUYBBAVGI4L1si3KyHFX5HA5PdMU?=
 =?us-ascii?Q?l+5xJ+hJbJGz1jJQtMMJ5DiCEYGCKzrsqlFIBs8UB5qPkA3Vwuw6QMPXej8A?=
 =?us-ascii?Q?2LfpTYE45VqkKCHi8ZvSH7PUEgKYpaIKId7JGFCyjBxJjS5w3SMPr8BPTLIt?=
 =?us-ascii?Q?7oYa387QnSiRAgMeqCqEdoHFwP2p8BVHZs84v3frlUYnqF6MIKmwt/7o0U7W?=
 =?us-ascii?Q?M9hhWZTIzyxWkq9L3/+RHAwTE6b9x8OAgwuQUgLyd9zn3SrYsfctdREit4JJ?=
 =?us-ascii?Q?PbKDkZbpe1GPw/rRriHvSjNeuLW0iU506OjQaX28MRT7LjS6Z7R31Q6hB5fF?=
 =?us-ascii?Q?jW4702eU+ONbnibu9QsFz5iVy8Eg3MoMEl8aPGrfkvgZEA5TUtlqr7coH4tJ?=
 =?us-ascii?Q?CEhvEEFzIG2iKQjHD10NlxHCmrT6Cbj8dFkEhP1rlSK13WBToBaK2DiPXbIi?=
 =?us-ascii?Q?I7BdhrdM2Jn/uT1xRmYfLjaVupGkxUjI1/UBCT+PRMOL5QbxAzZT2Mfx91z2?=
 =?us-ascii?Q?Bs1fl9n4mHZ7rPtcOuf41SSP9DG12QqdpJ0LjONoDPNashVeX3EeT/FbugT4?=
 =?us-ascii?Q?tGtzLBeBqf1hIC2cBLSpEwT74EbqzDUFbxh/EAQSycID9nhUdA6F3b/vprdy?=
 =?us-ascii?Q?lu35lQL2fgi9KppNwbhGn/Hu83JkLgSI4dKjxSMhTybdJL15?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71adcdb-391f-4200-08b5-08dedc32a176
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:18:35.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VsjVvgSNuKwFSQ8UEaM8WqauCp1qw45ozQ6OaC3p0ZLn/iNbKRPusXrgBIBhAMT1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7184

On Mon, Jun 29, 2026 at 03:35:23PM +0000, Suravee Suthikulpanit wrote:
> Take struct amd_iommu explicitly so DTE invalidation is issued on the
> same IOMMU instance used to program the DTE. Also, flush each device in
> amd_iommu_change_top() immediately after updating its DTE.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/iommu.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
