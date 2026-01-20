Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010013.outbound.protection.outlook.com [52.101.85.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFE67261A
	for <iommu@lists.linux.dev>; Tue, 20 Jan 2026 00:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768868540; cv=fail; b=iwuxRy+0KAT+mbq2swDEVDF8ShStvBIg4VhcVh4bd2f+DtoUNxLr6JVn+dhUp+L7N7lY2rA9JwM0Sk8gyWPb4ms88RI1Ojub6zU0wF3vUzM70UQDlWNAmuBiBfwGkgLgTxLMjDssnuktUG34kRx1scDNXvz03pVDK/X0Iw9wpjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768868540; c=relaxed/simple;
	bh=jKnJEXSYXwOzebtPQKvu9T4K8Z8jyO0596LqdlikJYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZbiadcH4zfgHRaCeYX68Nt9X7DPgfUUCFN53RAH90zquM2MSHX9Ho/pbll+BP4MrQyIQ/Wvvu4r2H+UW9+Jw7fTRH/QkhxFsEg+c+EOIrn0FQARax22m4yWeBGXPbBT9wXCMWUqMUlOGCVcpWhF8CvtONO3U5vcfbxp7hEITpFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nNnEq5z7; arc=fail smtp.client-ip=52.101.85.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nNnEq5z7"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qX/8oePeWtD6BHN4vGpv7xwIvrY+cgeexIuUX8D1aKr8dg8AFIMwwvdOLuuZZolI1Bdb/xBi9p66OSO6b7JD11zL3GeQLG7moYOzaL5NEHLeMn8WkGNqvV0VEujRUlJA8Xig6Sjw759M3RaZF8tu5ANvoxXucvIGNYyTcLYl3eT4Hd/5unAM5kr3PJxRx7iBaqpZ5/ZakHOc7oM8XyIDn3xOEXvC3thSDUCVHBHimnIb1z17oCJ+q5fJU8V/+7jgQXlvf5z2MyXGMtu64o/nThcU6DYZQE365aGLenzBU0keINplJBj0R6VmqZcMumGf8+Nvm3LVnDO964h8xk3cPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2mjKlTe71LKxOJb9n/mBgap8RbLIerfr32L117tE1eA=;
 b=A3z3Re65y7ZyitkbAm1J1eWDlt21hiZTUyngtXcpX3ktvUitFKCuqYw1R3goxGCE4j/K5PgVoK/wc6ySickZhMzQQ6GX/ukOowlzBq7/eD4TT/SBn0JJPEX1Yfl89QT5hCuRL5lXoMq056tGuZZxNuj0iFlhE55i6SmxYxB8kuEFIc3Ih/LRqTB8ZoBldvQGqUhn+7H3VcCwNUFarxaNoypNSPu0tcLWND/0rExA1h21j7Wnx9NTOluVK2hBMJg+I9m+K3XRS2SNVom7BwzhhLhTeXSiC8OhjEGRmp7syawXlBdMYyl6jlUBD3GW2qFi33eBLBZHbCdo2YqVRiKCow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2mjKlTe71LKxOJb9n/mBgap8RbLIerfr32L117tE1eA=;
 b=nNnEq5z7eRXJ4g3AJc6u1EoAoqsd3hiypYw4gmYqSVZ3vl0UnVjPvpBUIxRy4crK/zS8jAknaVzF/Rux1ckhKMLLb6q75T+SUyup5AcbMlFqk7wIVF0eK+1Iy4ZHlLCPl4bgdtGPBVwGTmEQLaagaAaswo+kzakWqw0c8YgD+OiyTrvQS8z5QxUyPPIlAvG6FWoTY+7J/aumQYkIROOPPB2+PGKsF4XomcFsZ2PzH65LIU0JTekthAZQ5VowKoy2bcNA/BFnKd8sqaoCwUXLGJyJMR01HOutlYPuYpHneB3O52/YGgX7iblX4fv4W/Ic+ACQKvgZT6fm0pMitUc9FQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by DM6PR12MB4315.namprd12.prod.outlook.com (2603:10b6:5:223::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.11; Tue, 20 Jan
 2026 00:22:14 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 00:22:14 +0000
Date: Mon, 19 Jan 2026 20:22:13 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	praan@google.com, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc] iommu/arm-smmu-v3: Do not set disable_ats unless vSTE
 is Translate
Message-ID: <20260120002213.GY1134360@nvidia.com>
References: <20260115011243.1302402-1-nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115011243.1302402-1-nicolinc@nvidia.com>
X-ClientProxiedBy: BLAPR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:208:32d::27) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|DM6PR12MB4315:EE_
X-MS-Office365-Filtering-Correlation-Id: bb0fd749-ad78-40d2-3b93-08de57b9f613
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?FarTSnPxB+swRK2H5eXqsiqbZjAfM7SY/jBi7Fq7MzE21bhhMT0KtARXoYtc?=
 =?us-ascii?Q?3lUmdQhhqHzZjTuUpssweWt0tv1WGFV0jpDrLFOkO4WUcv/MNPl8qk06M206?=
 =?us-ascii?Q?RwQGySUGZKQfNoP85lJg71JlqMHX5stw8mWv7C4gU/Lp8yubFN6mzj1GDIae?=
 =?us-ascii?Q?tffC0YWoblg5DarHeHLZvN7cuhVR4YFJp4pEw3W7L1yqYluvqGYUV9x+kYiR?=
 =?us-ascii?Q?n6KNUU0yDJO2EPFHPnPLjH/9X2r2l9sanBmuGuDsqdgIHFWKGJ/XAPM+DC17?=
 =?us-ascii?Q?oMPLgME+QjsLOA2QBqPZmkg6RA2AImrx1ay7NNrc6GoolX81LHaOfSHHPyBr?=
 =?us-ascii?Q?WHnA8Nv7UpKtXkR9mEEaEJNjBWC35jmRTt8VyLWuwQLhCBkrbmthYa7oCCSb?=
 =?us-ascii?Q?Gt4iFl7pOPZW4RUAFive04NQd38+dto0sOCwv9vdXuf/XjdGsNbIRXos2j/T?=
 =?us-ascii?Q?tIiPNKlcPG6fTvSpWD+vFTK9MVgI3g3tChF4esZNk8YTC/5NGr+ZwvKFKYF/?=
 =?us-ascii?Q?sM4xwdl+jmGYQKSh/m0R/5FNRkKMqKI6umwpCo8O3HbhXEWERyMy1qtne3XE?=
 =?us-ascii?Q?FqlAgCf2G/Wks6fP07Divac17H6UXcMd3IqPKZo6Iy0HUyxBkAbiKc21QBxH?=
 =?us-ascii?Q?zfT2oQatOi2f+MjtucqjCEufMGQRbSCdvZsTXrDzDzUGZA82jEBdvi9wXQot?=
 =?us-ascii?Q?THuBqv88Jh+R41blU8p8ijTMb3bpk2ZnrbGVsFUJPW4+pTXi94/yla4WCrGC?=
 =?us-ascii?Q?7370ukAcCXi2iGJX1awxpvt0MrI6sH833aZ/cDCuHCGcQc/79imYnc0bGmr2?=
 =?us-ascii?Q?okxwxDcxwPi0klHuMSNZzTDxLi3cI8lpT6Ivv1QVbO12SKaCFJVI02z38a7X?=
 =?us-ascii?Q?PEX2GTwefXzzyaTIaiQax7Q752/zxFrZRUPFRj1HA61IBlTnvs6tC0AZm3dM?=
 =?us-ascii?Q?+f8IB2fr9pVaRS2gsPCkYR6CvOSOfeRyjGBZjTEhToaMd+aOkJu6BraSAxhM?=
 =?us-ascii?Q?8+DeFFxyPORXA64KbfAOdtIOCA3Z1fg0Nd5sDnj7QsMghPboaS+8ku240WBP?=
 =?us-ascii?Q?yJPmJRus6cfvCYLou+OczJvr6gv1hlSjSfD8HTGj9ihOKPH2uo4iv1U0xuEX?=
 =?us-ascii?Q?rWNCvFTQmEQ4GKXw/2Ob0CPfmRWewuZTnHoB7Kl8DOHsqTizWmR1bB146QT9?=
 =?us-ascii?Q?ZdGwpY3QnCgfaVLzoPH4NPSG7KA6mUnoqDcvnhfwCrGDMi+1BRjR+eXJ0l9q?=
 =?us-ascii?Q?QNq62K9rsuwnLVL7Zno+ubZw71jmuCAd8f17yS4igEbV/dLXgRMUNgIafrr2?=
 =?us-ascii?Q?pbHUwtC4abXRHxogoTDjq7dCDWv0MrQupu7Kakfcm4ZOsD/uxgeikZmxu0Ha?=
 =?us-ascii?Q?ZHxU5agmp3xMmANEQWclQ5Vzn7Bp6CgZ1fVet0pw9gESiT6cCau+cwfOISZD?=
 =?us-ascii?Q?DqG/Qo8nKrjjsAYYBxcKxar5KwI0dn9XedPc3XAnlPirPoxcNpuBamnl/AmP?=
 =?us-ascii?Q?nP2Kjod7MXkoV1dv/GAVhys3M9bR1FaW00S7TijY6VK1Hh2wWZ/GyenlB3Ka?=
 =?us-ascii?Q?Jh1zjYk5J+AycVLMi70=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?IOUHlnXG0Om4Ac1Er3Suqlvpud0m2e6nFbpu1I131/D8iyl5gPGIW/q3Vfil?=
 =?us-ascii?Q?MJPX9OlswjHHIO4LEp/ImH03YxhOm3HbPXPRR+L9m9Pf7Hz5f0+QNhFNvm0o?=
 =?us-ascii?Q?SZ1ZiFj9xnCOVrM/A+p8qvRyTJicnxoPtjpW/qGsYuCMLwC5eERfDlt3D3OJ?=
 =?us-ascii?Q?oe1oLQWpOTemEcNdKl2QbmXZywRf84dp+nj96GOD3rSNF5Nt6vnEPfKjB0Ts?=
 =?us-ascii?Q?xbMaxyUtfZYu2QHQ1Ke8NrB5x/QjLCAUonYYVyRtGYQ52cTNZizFmp6M67qO?=
 =?us-ascii?Q?FEXfa93coMr00nNFNL0Xkyu50uKV/dlyk6jS9yIP+8FeMvzKLbVNYTGdHDfv?=
 =?us-ascii?Q?BbglbWmcm5W0JY5naaZ+OM59M4XDI7N2Rtivr75cbaxTPcrFP7e+Zy+dooJd?=
 =?us-ascii?Q?V3xDCx16N3lJu1Vh+p9E1Dwv8Ovg14DOSyRjHX4JlRkKeb3sKcGOF9YARWAr?=
 =?us-ascii?Q?o+7WM6xHDM45DqJkdIzgZ5RB5zufMPIC46moiM2Jv/xo9AbJ4zb8aJikp7px?=
 =?us-ascii?Q?Z1xq7STtGpGvLF96uvNchD6v0HU3TkR1QFt9dZaL7iDGT25/bvTP3Zg2i5mE?=
 =?us-ascii?Q?vlG5rRfZDJZ9ebVloZtYGlADOWSM6ATZekIaP8NcdLbIkORzeI/5j2C/MMWR?=
 =?us-ascii?Q?OHtLBB/B0WBoDJcSO73RQVtFaD5kTz7r8hRmRuhRjokffJYB0WqaNVPt8OTa?=
 =?us-ascii?Q?mdesSbB7NPuUeFvwsQnL42qC5QjhP6GI2RsMy7uLh9dSs1tiRrYue4X5DbKG?=
 =?us-ascii?Q?5hDr6TdDBfpeuGt/z0914duY2w6u1cJytyLnQcEnSW1A66CZBgrS43NH/6mb?=
 =?us-ascii?Q?WGJOqh6uRyTbaOhlbBnyyOifWvP71Zav89j+YuDI2PZ2l6yuDHyAoisqbc1N?=
 =?us-ascii?Q?YgjA17d3ewejkUoAa2fozzlT4ASlYEA0/vb6Ty/bo0OGXPVQMzqp82GQQ2MR?=
 =?us-ascii?Q?/z6yg1OVgYutTTX1C+JMskrqxBLyJRLnqKe4/blqmSUhgJ+Ojj+8YFYxC/Fz?=
 =?us-ascii?Q?p0sMwNgfWXTtsv3ONHU37rbdOw/o9Fjp/00R33TF9BW64Np5PM+jcKaOcC0a?=
 =?us-ascii?Q?gNaZOkGT0NF02kIbzF4jrRrux6JIQOAqkh3FnDSE9ZWBlk7llYD3DLkJ8Vlj?=
 =?us-ascii?Q?rydbI7CfMEo0J5RRuKlVE8c0PxdcPLbrctzbYNtT+msLo4tbZiNo/JF728bg?=
 =?us-ascii?Q?VH7C5EgIvCfloyHB1+GFqTUWD9Bd/FxuxrEy8TJ1uo0vFfCvgKocf2bFvMCG?=
 =?us-ascii?Q?Sf6T0Wf3/RV9E9sWKzt3WPF3EJddisttsrgBAdqv187j1/3ygyPCstJoRY6i?=
 =?us-ascii?Q?bItPvgXNGm/A+2dKtt5YxEEPn+pLISrVH/8ytD/2LfqsGvMmmoE4w7+KejxS?=
 =?us-ascii?Q?MeafwcN6mzuYKNcZXFs0MuGLCl/9DwOKMiI0LgKxbuhJ1/LU1RH5GCGZTCAb?=
 =?us-ascii?Q?VpZH4rCTQWKGeuLuswyEXTUME1tOUbhlnetEqMjlXDOK08dA2DjEnlLHiMtj?=
 =?us-ascii?Q?zkC+7qNnRUVeXrPPeKmsvV5V29Xy6+VfExkMJOBYR1Cy4cVykADFrXYS7x4f?=
 =?us-ascii?Q?4ZH3HbT/8l9d+PY1SUWt6qjr+yDS0Xq/zIG3YNtUB9Xxiv72XP/meh7lZYfC?=
 =?us-ascii?Q?ckAO+c6fFPyvJqVe2fK5D9n4W9/EN/nyxDl2ijgvHmK2Ca/3IfJKZwiMDVZf?=
 =?us-ascii?Q?Wp3UFkgiVWDgMYb1gwU0JEDWcEOvgBIL4Tdtl/H2aIMXCJMAc45eUI6PghYF?=
 =?us-ascii?Q?7a4bwkKGqQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb0fd749-ad78-40d2-3b93-08de57b9f613
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 00:22:14.3908
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pWfYpx2Td18qAN8xqnEf4Mo37MIQu8YlQ39lsKQXtW+Sx3F4Vi/f0jeim73po6MF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4315

On Wed, Jan 14, 2026 at 05:12:43PM -0800, Nicolin Chen wrote:
> A vSTE may have three configuration types: Abort, Bypass, and Translate.
> 
> An Abort vSTE wouldn't enable ATS, but the other two might.
> 
> It makes sense for a Transalte vSTE to rely on the guest vSTE.EATS field.
> 
> For a Bypass vSTE, it would end up with an S2-only physical STE, similar
> to an attachment to a regular S2 domain. However, the nested case always
> disables ATS following the Bypass vSTE, while the regular S2 case always
> enables ATS so long as arm_smmu_ats_supported(master) == true.
> 
> Note that ATS is needed for certain VM centric workloads and historically
> non-vSMMU cases have relied on this automatic enablement. So, having the
> nested case behave differently causes problems.
> 
> To fix that, add a condition to disable_ats, so that it might enable ATS
> for a Bypass vSTE, aligning with the regular S2 case.
> 
> Fixes: f27298a82ba0 ("iommu/arm-smmu-v3: Allow ATS for IOMMU_DOMAIN_NESTED")
> Cc: stable@vger.kernel.org
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-iommufd.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
