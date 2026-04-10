Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A226F28D
	for <iommu@lists.linux.dev>; Fri, 10 Apr 2026 00:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775780861; cv=fail; b=msOyXggWV23fTaq+o/oRMRo9qaQcY4aaWU2+8dOwM2SMDZf7bcosZCuy4vHb0RVo40E4mWYmMFABMJganmVprqZrXSb/9FSFS9yAK13eg86JTYRvRcCv+1OgazWxakjvFXixiFrzlID9rRy3d25oLIVVsB7W0VC96eF8HCBwEZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775780861; c=relaxed/simple;
	bh=mZReaE7jMhZFXslQMQfm69M/WqBo5bJQgQoaIZSh+ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sNRITS87OnA5XnQBvsanCTf84AypeYYICgV5J60s2mLs+Hmk8skF8/rUE1DMFrQwm3IuNZb/jPnDXnKdCJukUZ8k7P64JtUjkNJUp4g2t0HgbY/EXIUj0J1JLvKukXtMonSX7z6uv4FBBlQWgjBiHjNKemw9uV27sA8Rg9Otuoo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fccEhxPY; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fccEhxPY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dz1cUsh9d62oh7ABFMA8blj2bkKzyM0rOMvnU6mePWf3eGe/MY+sY571JdZlrKwfNq6jlIFNXz0aC41Y6+1wqMxr1joXZFYLH1Q5nnn1jL3Xc29J6Sx/gG/egdlL80i0aGDBR/hNmxpHnod4s/PjBvFCtbCGGiAKTviU9fkuv8mMPd80deRfZFl0B62STwo2JN5UpObBSLrIm80krbSBMTe+RxH1FLuWrTCI1auy/CC9bmZMd2riuFDGg7nma8ix079p3C6S1/bNiMf2S0VWYTHMhxeSGDPuNEdMnnwg9h4qNjiM2S4ZxIw0uprI6EqS/wMKs23dT7QUSolE0JTilA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3aK6f0HHSPILZM00a5sFkmou3G9U81jMbnqniX870Bg=;
 b=Azkx+2fYywdH5tzZcfqMYaI75+9W2QGPbrVrbj+NG7ItkEA+dZWaoo7L6eHGM/Arl6xKSUeyI9vdmnBggMAOuANVFJIQJ2h97Z4S52Vz5UvOmplTXWLkQL8NdancHEN/BQj8XaHwNG8ahAR5ZHwWyeiCbpcjB9oUYY2no6b12CUjPoPh3Wm9sGiuK/VA+z7DSFV0eaG+Ya+CU8xE+webD8/0e58GQv29myRE1Lsu90czOpj6PLEdLnR5WG7gQH+cyZbgYiUZzqzrVVvx7sYkZBCRNs+n3Ukce6KgA70dXre4SJZGevmu7vrUGxS9LfZXF1Omv8uHF3izLXCEmqfUDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3aK6f0HHSPILZM00a5sFkmou3G9U81jMbnqniX870Bg=;
 b=fccEhxPY6UJCE8wJpVjxyMqAXkUY/qSOEqJNmM+mXa7SjvJ2YHe6PdYULm546oTQzDe2o0fuB7aed3vSisovzZbKHumnnLQQVTJWCxLEbTBKzaiSf5XwdSpBJoZePVd1uy4h+/h67YA2jHrF0tOXeypAH+4I7a1PnoXO3VUz/GO51BJTX/Ygv/oy9T2TASi5QRkua3KPBWN/rWukSZc8xU+HAuUPjIMm5VyvOPE5Gr9z7whyHnyWRtCUKXWXjesuKY4etZrBPbo9BKrH3qNU+dnoBtrK62EdHP39n4lKZh9ZJmO6CTRv6d7Z4Ti897bGxnaOSHIaVipw8BZsgnzzYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by BN7PPF9C6E5285F.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6db) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.42; Fri, 10 Apr
 2026 00:27:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%5]) with mapi id 15.20.9791.032; Fri, 10 Apr 2026
 00:27:35 +0000
Date: Thu, 9 Apr 2026 21:27:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, jpb@kernel.org,
	praan@google.com, smostafa@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
	jonathan.cameron@huawei.com
Subject: Re: [PATCH v4 09/10] iommu/arm-smmu-v3: Remove ASID/VMID from
 arm_smmu_domain
Message-ID: <20260410002734.GC3357077@nvidia.com>
References: <cover.1773949042.git.nicolinc@nvidia.com>
 <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6d87a722635d29e896b277cb60f0208859073d6.1773949042.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|BN7PPF9C6E5285F:EE_
X-MS-Office365-Filtering-Correlation-Id: e80be337-bf22-4b86-9049-08de9697f671
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Fz8H70aHwzgD5V5NAp+dHu0l/ycD2OJ2/mPmWzf7dVrSGn+OMajJYov1AAultSAcaNPF1rMutxLz6Qewgu4XDfB+B9Y3NRsjM1u9PlmXN9QyT6R/HSFJuYmjt3/1Mt6DCjqNtXHaHsZF1SGle2V+Q7z4JryE6cGhr2ptqLyaM6llKDPI4KOoddnD4eQ5i+0fMzeaeFihZDQGl84ss8qkgF7OWtY6lBIeiVqWKwmmyGw6zs7PXC+BWCRgkS6bHf8MHyaXAO9ydElpYvajWtpaVb8AF7qa2TBMkNMewu6doRyPR/1Md45hDwy2O+eFbdIVUtcG4Bm9NPYqsV/MwNXh+qVLBym4TMdAyar2YsR11dunqGMkiFUkuBF7F4WNKlYHTOLV1k2r5eSAezFzqs3l13xwxD0do0JzsQKapeZCx2c28zu3P+HJckY55QsFyRSsZyOfeKF0dM6kKpsomN0Y3qSnktFzXeO1bHcn6lop6fUQEHg8CZJevcvQ5u2gKqO593CsVdwCORpQVmDj347y1NMjCujREkJpxFhqoLS+7Fvrouy8bEaJC7qBWKLl7R0AM+7SpaQchXRJqWuLNiKJk62quAC3DJLo0s2yKeuafrgLEIL9MYz0tvGujHucC3V9BmymBp/tBKzhZlNnPBdmigssbT6ELtXxz6hd/8J75OjBR0fNhd7u+CuVAotAiBfDmra1hqBrokEitC2GM2AeukNXJKAH5BwXNbz6zrlN3Ko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HcPzKabPT10M3sEwLIxtXjpPfK/4ZAJxKj+4hqRmEqZuZzpy903GHM4ftMms?=
 =?us-ascii?Q?YY2OrAFORbSWyBH7A0PVuYF/DtrpIzWa99hH2fvGgmJgkscB6xgtC47JLNWx?=
 =?us-ascii?Q?OR3D7ZogpU3ys7sgQ+/jogA943yKt+LDtV0ZJVV+DBRnB4Mf0fiWNFeEurXP?=
 =?us-ascii?Q?ZpAmq8DAjGUyAGz9O0z6vyHK1e+xXP1xYDfrVTyN8xIZBmTaApDvxwnx8v//?=
 =?us-ascii?Q?uAThauwfbZ/sBCkLjIdIF0lk+J3CsSDpqdYtPBSXhQWckMpT0WZ8NvipWq+j?=
 =?us-ascii?Q?jvrScN0NatkjP14xvsjag0Z+q2BGhy5phUEph7cU1NSl96vdNB76IjuCGGZn?=
 =?us-ascii?Q?RQIi6oj7rV4Y8/S193+dcM3pCGKbquitNOoSW+QHpWw55pDH1KWFjJhIFcb/?=
 =?us-ascii?Q?Xe6FSh7o+3ynB3DxDuGDmPV92ImvotAdPG2y1g9gS5q951Gtw8qSLqS+Sqp2?=
 =?us-ascii?Q?eK1fSeEGF9MqhlRtD0VvnjvwU5MEvmZ3z7MjMvtSdXnTvQ1/IPS3Gq7WmaLs?=
 =?us-ascii?Q?D+rzll34aO+FPwZ4W4ZjUWPT4YTQx4sAbEIcs+fd5ohKLJN0QbI8Pvv7Vpk/?=
 =?us-ascii?Q?njj8oh2O31HRMgbbum4JP1iOsacoE0sqtc4RjDpdNIUJf1IgRB55F0lbaEgc?=
 =?us-ascii?Q?nuJthjEuys+smX0eDHgg7mXMdkKGr+hnCeh8ziRT/libKNSZtpvAvJ0heVLl?=
 =?us-ascii?Q?UYkNqcqnGDJ6+3zuWcps4vEeukoVo0M4xDVP7Fu8ttja0Tds8od3kpNR2XH0?=
 =?us-ascii?Q?ya0AFyuYzBjcByPYR1hi8yQP3SOZeoHkfwZQvHPXok1ccaryikqHNNlIVUc/?=
 =?us-ascii?Q?DKKJ+gDVIAwTxZtDgT8ogBU3zWNuxqQznrj9hau6ac1gYKf/M1mgVeT01P5y?=
 =?us-ascii?Q?Pm6JCxDL4DlpAq8XxpdhL2NhPrX7TebuYstZsiC2l8FdcTRuapxqtnRS1skU?=
 =?us-ascii?Q?xKzN3eMb58sHANQGQB0qCkBm/kqGsgaiuKSp1yXzcpm3zYpOdVTOD3lCa46g?=
 =?us-ascii?Q?KIZheg8CkOD4zRZVzVbrMf42D9zKFxgCBIgdLjZ6+rxjxau/PERpMKIYqnvS?=
 =?us-ascii?Q?D8pSHaAqUf3e5GqpdFzgAP0BUuv9vHzagjyjpkSyTbNEIjh29FwmXEmmThOo?=
 =?us-ascii?Q?dRVN/rdxvbCHpAxQ7NgC5tavYydZuymYRmVfNsN+KEaMEPAO5ZNg+aYYHDyA?=
 =?us-ascii?Q?vlhmn01fVIcrsallHXANU8vAqOrTplsdedqZ/cDpif/PVd/S4w2Q0FxvUgCV?=
 =?us-ascii?Q?xprXcVASwaBrZyqn2OqXl+9O+p4ZVEgvj5ADRS8W+8UkVutGh+cRUT/6xHvg?=
 =?us-ascii?Q?l0sqc33t1aAURZcoDEvk0hxpJM+NeaKTYKHt7IXoPcwB7VwPNNrWBJ4FzWfj?=
 =?us-ascii?Q?zpOm0TlIoD8eR4zSyYFymguELjjKec2SWl53QfMCngU9cvPaoLManxZbT15z?=
 =?us-ascii?Q?gDyYE3nsReXl6ZnfTOGdACYQVLYQSScweoB9JrdzJAInHN1uePWddNiUi8ku?=
 =?us-ascii?Q?q0fpQQwSGzeVcYXmoOdsPCU7RHS9vvaDWvZXiE8aFd9z+7YuFHfx3a2oJprq?=
 =?us-ascii?Q?/it5c6W/OgFZmttYIeMrUVfXO3l/lmnD2Wc/R1Eg2ilfw092loy4z5pl8OeH?=
 =?us-ascii?Q?mT+ewLipo4+lCKVUe1RCK6NMFCvMRAwFsUNzxx2iG9wCR8LFtDVKDxHBBHAf?=
 =?us-ascii?Q?FQQhIgVdT53amF1Nz52Rs/nDFWA3kufLspFqkXnIGdmjY6sU?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e80be337-bf22-4b86-9049-08de9697f671
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 00:27:35.4513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ehTrLhC25aPKxTkxofgdHLmjjsKSWu/2WdA/fh08A4hALRw91FeNh/7WhhtpqTOV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF9C6E5285F

On Thu, Mar 19, 2026 at 12:51:55PM -0700, Nicolin Chen wrote:
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> index 846a278fa5469..0e48264ccd01b 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -300,14 +300,6 @@ static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>  	 */
>  	arm_smmu_domain_inv(smmu_domain);
>  
> -	/*
> -	 * Notice that the arm_smmu_mm_arch_invalidate_secondary_tlbs op can
> -	 * still be called/running at this point. We allow the ASID to be
> -	 * reused, and if there is a race then it just suffers harmless
> -	 * unnecessary invalidation.
> -	 */
> -	xa_erase(&arm_smmu_asid_xa, smmu_domain->cd.asid);
> -

I don't think this artifact has disappeared so the comment should
probably remain too. It has become slightly different because it is
now running under RCU protections so it will clear alot faster.

Otherwise

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
