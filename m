Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2060.outbound.protection.outlook.com [40.107.100.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9DE381DA
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 15:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715528061; cv=fail; b=U5xTfOnWNSmv39ICNDwq7pgqFrVmp5tpj6ljY4k42MJSfO40FqIPyvubkEfdJHrMms8Q5R2Ni7YBAdSNEHI7zdq1x5EWV3tLWHIXPlCGsp2Db0R0MOtKLKiZYNYjNg0i5fLCY2xtJyJa7Ul7aU/eHjAteGlNcigWpjImqDu7R5E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715528061; c=relaxed/simple;
	bh=aFP0XSPoaTQZvcT4tYNq9CTfwMvD6hdV1z1E7Pu7Elo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MtzECo/jK8l34rY7B1vwDyq2oTAUIpyuW8Nw8WffWUxiWZcdicsMOvxiQknVSx8dlgAZgYxI4ZAZtKMGV9UgydAxn+Md+zxdXoOIeNKbJYL5WyW43SF0klLEyHN51+G5I2AcV8z4/EeSj7LNN+JNti7Vt9sbn9/pHMCv/VbITO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lFkgcxnf; arc=fail smtp.client-ip=40.107.100.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lFkgcxnf"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UGhujWGvsw7vXj+WIiHNzyedKyZM4poATnyEqCGUf5YL7PzjCxuDnJaN8rEohRZOVfNIUdwd/tXou9dtKx6bgnKP110vixz3h8t7mMZtK3NPZV0JuUPNg0j7NJD+vfuVkynT/kioSV2mFRE2daI5sAq1lBv1e0Z74sJV5pdqfbxTG0LgHpsfK9+UQ4VXtMWXxxHvLD7yenM7Fsa2Z82jUo4AVe11bnq7SN3uWkn5JFRg/2EuEGX2hgn4YmQfQgQoC/h/k7vBBkUpHcX7zZ6TZF7y7gHaDp8Bcz8YAVnXDPH1BLwyejr9fyDiGWHHtOIAdvyB4bE/oRXm7CiPcUkMJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hVlv6XiTWBTsSQssNpGBQsT0e0u6n+iy9DfHs4rpfb0=;
 b=eDVSB4UCPwbfE2qMGL752HVFmNfIyAKc5lLOK6oQUbiihFTFvRR8woPWAAD9wyLn+bR54EuJ8TvTd1XRemWdyV7cql9fWybFO5K+FDuLsJlZePNy+OwYv4DEVUL2ZvioDf/zcCB2BlqG85b8/Tx6BNcfEYp2OJWar76oMmZKxhwJUN0SVuHhFarBILWMqEL1HPiJ2yzLYxal2Syon/+hmj79WzV4iLh8gD619xV6WD5UtyKygccAbvFg2vnMlXcAyPdRmpBRw8s5mk0b+c90FtsdeFWvbS0Hi1eN7iGOeLEnPikc0jirH0IkmjwnBTTOUAWr/K491jCEfddWdL426w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hVlv6XiTWBTsSQssNpGBQsT0e0u6n+iy9DfHs4rpfb0=;
 b=lFkgcxnfAvw3EmFhjY+jDAl6Q2md4oHx5Hw3DW4uODuYoIUM5hX/0TF2+ll+wqSfha40BG/nhRKMxocoRshx9qXQgrrJYGucWaxGj7v/OsEI0rHUmvq+kwOuPDnFvnY3lJwKyS8D94+n38jHU7wQ9bfCcXqIh4914/Z8Ls36VLJtNFQbVsHu3zmZGsLFezXEtNAJN4CCSwz261a5vTpEsgeE3vmHZqXGE8QCyOZrlU+tbNwJnEGITN7eKaTkQz1O4crBpsx1yeuN6Gq3gCx6dOCH+fKJCWSBfBHfWbDBVK7FJuFAeSiRovV/6qqrDL1zsypeYpjwECD8CAyW/iMP1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by SA0PR12MB4397.namprd12.prod.outlook.com (2603:10b6:806:93::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 15:34:14 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:34:14 +0000
Date: Sun, 12 May 2024 12:34:07 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
	thierry.reding@gmail.com, vdumpa@nvidia.com, jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v7 2/6] iommu/arm-smmu-v3: Issue a batch of commands to
 the same cmdq
Message-ID: <ZkDhb5ZmymmT2+64@nvidia.com>
References: <cover.1715147377.git.nicolinc@nvidia.com>
 <a282dd487b8ea18dbb6d37907c1fb8eafda77d73.1715147377.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a282dd487b8ea18dbb6d37907c1fb8eafda77d73.1715147377.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BY5PR16CA0002.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::15) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|SA0PR12MB4397:EE_
X-MS-Office365-Filtering-Correlation-Id: d271be8a-35ac-4049-5965-08dc7298fa67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1kZbPVs7KBl1nWQt741Qx1E71NZxvvmqsobG08rALN2EYvqbzB4gCvJC4ith?=
 =?us-ascii?Q?f/6v/nKL0IdZI2iad/qF29qd2FwO3TY9zMIAJBhGu4OR54Oh2iXhYkgIBPcH?=
 =?us-ascii?Q?iCvjx8jByk67sKqiLQTLzt3r/vmafaBfAs0TEyM6EW4CqRC7gkfLt4Z7jeq4?=
 =?us-ascii?Q?qWG1EMW6ZRQXA1NBnaXkJ1mu8GFefBESoKUEjpMkA3D7/9uD8NRSBhj4cbug?=
 =?us-ascii?Q?yaCRpbOttOi1nwMVqmQTgz1S4fk1HzcqgF1A9nFNBFC6oF7XtoESi7v5uAZ2?=
 =?us-ascii?Q?zbLYDY3sg/PAcOiL49SocvFNemoObBw6OD/yzsB0JVVtFtrONoPnQ4M2g20m?=
 =?us-ascii?Q?4LUKQkfEqPhJPMXIvBLJxt6bmItQkZnPprd4//NMPCQc9YUFk3CIdWKauozq?=
 =?us-ascii?Q?UqLX5DVSs14oocv2szNQkFG3yBIxT2aAdbtzvj6PAdl/NwsYapez7H/8wOCF?=
 =?us-ascii?Q?mqteC4ITGpU81Be+w8LAxBcAZ3G5V2yhUfJRQVkxYhrHk/Qt+igkJyWr5cJy?=
 =?us-ascii?Q?4hFaNvwb3wdMWBgWtCTUWZRW/r8CfSPid90lMVI5hHmV/YHJ1muaAnqIuAsI?=
 =?us-ascii?Q?4+h27gxbor5jv9WkS6y8sgoLIdwsyMKHHOEXZux7ZFicXZkEu4GBMHVAC1R3?=
 =?us-ascii?Q?VesMPUH+cZM3wrrc8XdhOW5M2UvouuiYznJ09ql1PsZBeX4OLVT9aS2EY113?=
 =?us-ascii?Q?+AzgLqR5gvt+xJqUS04ogJI6pkXtNM93lDVfLmf2BufSmp3V/9qQ8IBagpFu?=
 =?us-ascii?Q?3EhKwS9WGy1Pi2N9HDcj9ujEL5wgMeLBRW/yNWXFaL0eFVA5j9QiXtjljHMZ?=
 =?us-ascii?Q?oZC4BbK1ukMsi9KUZ7B3Vq1as3NYEF7XDF6xGlXi/tJ5Aj+yu9nLIbX/hwTs?=
 =?us-ascii?Q?rgLSijhAJOiLjEekrXYY6b1O1PaCTlwdhsMaVzk4UOtBikbiFZv8Ki2IVQu5?=
 =?us-ascii?Q?qup9FOICSX3l2v3A3woxw6kNOFI2KDScCwsTWlxMnEW+y0mgYenBFnbZkNQt?=
 =?us-ascii?Q?TEOBn6a/0zNDzAOM+KAY6y4ufw7A11cDb9g+HMqE/CnOX4FVs3IFWovTBg5C?=
 =?us-ascii?Q?5ggUP/XeLKs7shmCvDD+yiyu8pGcW2yA2rtN172K4IoZLwQWpBUh5IJUATB5?=
 =?us-ascii?Q?wNd4wkFzRIMpizPOC85qrFw/lLDrxOdayvyElGBi/YiiWC3f2oErmvp34Blj?=
 =?us-ascii?Q?1USBGebQtXPB2B4tW9u5xE1CHC9kyF6yp1B6Vfttd0Jy35Ul1RRViKbjyWAt?=
 =?us-ascii?Q?helNR2/eaiVka/jqs05JfTctThe2fdVQaq1ymQokNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uhgn7va1ARL9ZPyKBiDwiEUCD/nAdqt0tRPgqn/1frgmPKpjF7ioTTfj/Pqh?=
 =?us-ascii?Q?TSEINv1ee/sV31uXkYTJVlDDxiqjKLz6JirF7WLr/KF5Ep5FnTXXHkayz0kT?=
 =?us-ascii?Q?Ln/f6qPzkThhiQ6BRnzRerdFLBDXfrbUtUBBsL2wwVnyCtgBj6jrUvLs82ph?=
 =?us-ascii?Q?7Mlcg9Jlw/LnKNL09t3FmOxXLMQp0iXExwj+q3ac3HmYk7sQ3PAs6M0JVgXr?=
 =?us-ascii?Q?MdWPx6F0UDFdjgsuW5MOU4650QURtCOeqv56XRsXCOC41AgGsfeDtBUvY9qE?=
 =?us-ascii?Q?rKiwKreZ2NK7cBO4E/QbtjcF1G1jtMrygNXUHnD7NldJXfR4qKwzuJMGCHaZ?=
 =?us-ascii?Q?qWcPcMFV6StQoOKYEw/IUpFM1sGITkkA6k3oAAE56QAqK/K5nez7Nih94LVr?=
 =?us-ascii?Q?S3w8L2gmSjPdPKO0J3tpJhrkp1SzUqhB7Gm3sIifm9rZ1+P4Sp31s31BpUd7?=
 =?us-ascii?Q?GEZog9nYFSy5pecFAMyhyUN2rAs8D1t4bsg41Vebao+MDnQBuJrIILEdSyb0?=
 =?us-ascii?Q?TOgbE1sRCI71iXHUNla9coI2jCzwM6fSFkPGDmcb/BFKLCQ+dHmt/7Fwt+1S?=
 =?us-ascii?Q?ti16p7hxrHT/HPFjPb1heCQgnvIDv1fcQDRaRAOeRg+qch8VHLMUUVVBMrtS?=
 =?us-ascii?Q?r16b0Mnic8jDlM/zsX1Qe/WFdz/WDtH4KapKppFp3P9xG0ItH6jju9Bhfb4K?=
 =?us-ascii?Q?7VSgfECkLrarrExPZx6Q4/ZbdF6R697qmAu7LVQ9aU4bQj2JSwFp+XURCisZ?=
 =?us-ascii?Q?bYCRwp/KXFiuMRfWi7heBGxeQP44GT2wkFe58yNIyL3BIzknw1SJHikpvyF1?=
 =?us-ascii?Q?tI0IwmgmA3m4EX8scowHVj3xA3m2R6EbTvi8sec9HHWsaLKcr1UbekiS94Nc?=
 =?us-ascii?Q?c7MgIijsFhzvtfBj7VYqpXVqr//oSnfvgR+acgN2AaF7m9S9W2R31tP3FEaM?=
 =?us-ascii?Q?XFPmvy9C0jHDBR8M9hP/VcmIs/Tvi8HQJplpFdmScTSJ0d7L4vc1LxnQx73a?=
 =?us-ascii?Q?kvqT87UiQ6NQVFQsQEvTMrENP6Vwmc0BszskveSmm14Bg3esdo/RkLOPR47x?=
 =?us-ascii?Q?s0QH1gRbM3lt4IL1/pqyBaSwmL3NplnQbPAog87cSSip09ln5TuGVwFNnDGk?=
 =?us-ascii?Q?Q1hV40EnlSzgNoqOYRZ0c3CX0to6/3Z+iT13CKvPku1AEfzuG/+8jFtlOmCA?=
 =?us-ascii?Q?MpHzzy8duSHeJtPWfAsIwsmq/dFjjNByVWPA6yqQIyo3DGf6B92bAy1mZONw?=
 =?us-ascii?Q?JD/ZkeWh82LVRjFQB+1wb2pVbvLzeqZm0RRB0kgUakw/AZIVm3r7DdyEzyvn?=
 =?us-ascii?Q?JpMW5W76v/c+a7eaaqEfndAdb/ON+DgUY4IKqpyvbJzT+RAKQoG1gGgnZpOY?=
 =?us-ascii?Q?e0+Q0oHzawb+HquExfNaWZpDgUKY0oiZvXQO3VxnO9zOkbIzDEH4GGGTlSnN?=
 =?us-ascii?Q?4Q5P5F88q/gePHdpJtROkNe31pC8IiYkeFYLD4Xn6sJl9acPcyto5a1jDreq?=
 =?us-ascii?Q?7E0RICoFW1G0uDtA/f/snQ+mG6ViZ1eZObHUXY2VRC+ETAjdeXXRbg0XhDJ7?=
 =?us-ascii?Q?munGvLN5bw+sfBb0WGgljdZSoXLa4ZDPFLPy7EQh?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d271be8a-35ac-4049-5965-08dc7298fa67
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:34:14.2693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rZSaky9tQzK4n6NeFAYrPgE6AsVy2ZWsw2+MZW+CcXBDE3ue/Cm0t2rKrlJzBLq1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4397

On Tue, May 07, 2024 at 10:56:50PM -0700, Nicolin Chen wrote:
> The driver calls in different places the arm_smmu_get_cmdq() helper, and
> it's fine to do so since the helper always returns the single SMMU CMDQ.
> However, with NVIDIA CMDQV extension or SMMU ECMDQ, there can be multiple
> cmdqs in the system to select one from. And either case requires a batch
> of commands to be issued to the same cmdq. Thus, a cmdq has to be decided
> in the higher-level callers.
> 
> Add a cmdq pointer in arm_smmu_cmdq_batch structure, and decide the cmdq
> when initializing the batch. Pass it down to the bottom function. Update
> __arm_smmu_cmdq_issue_cmd() accordingly for single command issuers.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 44 +++++++++++++--------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  1 +
>  2 files changed, 29 insertions(+), 16 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
