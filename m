Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012019.outbound.protection.outlook.com [52.101.43.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F12307AFC
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762544978; cv=fail; b=uBJvMntQvlsIK9kqq/bmFfN6sV5OuEkZohiPcxYgO/ynTiQdMRpgSUTiZFubazz1rSLpZGEi8lGfNkGAb4SeN0DPKg2xnprVUIsg6Al2XDjO0TSBLe80qvdKZsEQeMqh9bm+/qK2svhvM7nZwV0Udszl1YKJZ6AGYRcdGgjQoGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762544978; c=relaxed/simple;
	bh=i/uuD7MiIc/kQVSy7nJoJtHSKkwduAdtTxh1uE+ERDU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CdoZ79ILTTgCw8hQUCt7nKko5tSSoQ+8OmBnnMHOwGPeNsqmPkBmBzI0FGpWzkuN1m/NzLj4mP0eGpEjqC/sqtI9pxjnqMafF/TUiALckY3o4AvtTKst8q5qoW08YdBgAQ2b8COsLYUU59OuRlA6oa9bDLbqMDwcJIhe1FLpvSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jKamn/k2; arc=fail smtp.client-ip=52.101.43.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jKamn/k2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NE2UvVIgB821yPVAQObxkIMh4+SWeeVfFfQ9vYzQSjr3yB/f9SqLXjJoxQ5fW5n++jdQgIKcyz6bsQqvggWVk2RpSYp3660lAagCE35exdKLTyJuRb76E5/rOKpzRquUjphE5qz2+R5OJYdAmAFU5jKLR/xcDB7M67xjI2LAo1VfEgODHfCLakVMEB+wHPCKvCShVoPQIp54f/F2sS6p6jMeViRSaesv1cGvCHPokQl03fYEId+y37RFHZoFbD1fyLkbVSJA+BQW0OwHO2J2FEfh/ttHhaJuY7iWvYCqOmtZrxjA6GU2ryZhJigzLiN+1cySDiJqgtj0qdmDuJi5/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROrFZrUV6oYdiDoys3AcUhj93Vwqs5/t7wMG0XjCJCI=;
 b=PgHx9D7HlhdqClq4q0sbwUnRPZ2PwUOlQoG4uX88VDYtYlyvW0jpy7t2M0FHF5q8o3ZSyvlUclmzVwEMifKC9Kvs2z1FjRgiCW1fH69IdD/FkNNtyqZ3vbGGEMwS/9bwRBkFpUFKadKdGFpX2OAli6J/6yiIDKgs60Id6v2UATQeIY8pudKicoZRuG7V955m3eyizySBcgePRC5L4daxnR1h+B4fJka2XWlNwgMZZ7OtBmTiQiFrRHscaAbMdMa7s5bf4K3Ip01w9xlsKGDP5wWomzKdHzkikq6vVSU+p+ENCxvjliwQlKtrlHzaY/AWQV5vDaRGJF/pcCkELpZP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ROrFZrUV6oYdiDoys3AcUhj93Vwqs5/t7wMG0XjCJCI=;
 b=jKamn/k2HaWhz8vIkpa4H7q6qiQTdnfO+fctAOL7NL9IV8RNoNh4qfXrQE8FTsbX0j0ZhUgfPQr3Nb6VO0DYMI8QzYnvomvBZSMdSO89Yw56kiCQ/WtGOWZOszSscdwqKaAMwnrEcamIT6UShynDKsZhDgsuFrcbLYBlrE8Rc9Ojh+TXWY0p+qq4Uz8hBiMq5gAX9X97NXo9RMrMAi3zk5VAM5gpeoT0MBfafnyJyr+KiNtgkB7nDXQ9lqG78tDOx+NyG6WSeX8SbyYd43o6GsO0eSg4si+UrsFWki82sBAbgjjGl2Qstdy/j/8TqU2QfWjkkWTDr3IAiFr1UsmxBg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3613.namprd12.prod.outlook.com (2603:10b6:208:c1::17)
 by SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.13; Fri, 7 Nov
 2025 19:49:33 +0000
Received: from MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b]) by MN2PR12MB3613.namprd12.prod.outlook.com
 ([fe80::1b3b:64f5:9211:608b%4]) with mapi id 15.20.9298.006; Fri, 7 Nov 2025
 19:49:33 +0000
Date: Fri, 7 Nov 2025 15:49:32 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, jean-philippe@linaro.org, robin.murphy@arm.com,
	joro@8bytes.org, balbirs@nvidia.com, miko.lenczewski@arm.com,
	peterz@infradead.org, kevin.tian@intel.com, praan@google.com,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 5/7] iommu/arm-smmu-v3: Populate smmu_domain->invs
 when attaching masters
Message-ID: <20251107194932.GC1932966@nvidia.com>
References: <cover.1761590851.git.nicolinc@nvidia.com>
 <82f22b35e9d020efadcbac86564b609b08619f82.1761590851.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82f22b35e9d020efadcbac86564b609b08619f82.1761590851.git.nicolinc@nvidia.com>
X-ClientProxiedBy: MN0P221CA0016.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::19) To MN2PR12MB3613.namprd12.prod.outlook.com
 (2603:10b6:208:c1::17)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3613:EE_|SA3PR12MB7975:EE_
X-MS-Office365-Filtering-Correlation-Id: 073b41ec-ae0f-4da2-cfa0-08de1e36c5dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?v/MoGJR59mn+ToqlRCiGjABdYXuJ+TbCJsUYeyDnUk8waFkR4n4aI2jrTjsb?=
 =?us-ascii?Q?ltOryvwxf/MKyNTgGIXi3Ax1aEDKXbStrrmSQ6TJ/4rfZPTu3fZrhHm1dhDY?=
 =?us-ascii?Q?YvOoL7WmPXrIbeUWqi2A20hqIHIgJLOmm4WBzkB1lPUHKRg3vfsXCuAcgEUA?=
 =?us-ascii?Q?ikHAMm7Dyrj07LNV00az9NnOBg5XELpSnpppAQ3FH6RixI1jtnLIY+jDQN6m?=
 =?us-ascii?Q?jJaBf4ktsfloryrHFLBslbB4rJ7192lFrELhxCkMFJjjNyIDkJIdwzhYnfsx?=
 =?us-ascii?Q?U7bTj6Tq9nXZRs8iQ/VeZa2ZbOgF9tF4+JKhroUf2dAECbXS4nDmZEI1OVTj?=
 =?us-ascii?Q?8+f5+vnDkru/u2GdC6ydyYAuVgFRmqYHj/FN7HNHc1qfHJvvnDZEfotyBWOg?=
 =?us-ascii?Q?hBSH8QZMCSzd/r+xjI3B+qVLK1T/NXGjL1vyBH+jO91VGa2yraTYOP1MgoRJ?=
 =?us-ascii?Q?/hnWlcj5JVkQ0zyjp1OR1gAauFYVVRF9E24awPeZcODh+42YmR+XbDAdoELU?=
 =?us-ascii?Q?S6W4g0D0o9d0xZNke04bKwyAPBRW4cN4c4t30S1q9pfO0Uj84EylZy57zsIv?=
 =?us-ascii?Q?fNd76ZUvA8gw5dTmCx/KnAO79R4IPE0ShMZ+P8LnBnaeBXVbQEUZ/LYDNOSy?=
 =?us-ascii?Q?tfypCVN2AeuzWgBzbdAoDZOpnrZNfJr1VhmHm4uwe+Fbom06LojAX1RjorTs?=
 =?us-ascii?Q?trA34mlw80uyj5RDBWmMp5Bivd49W/d6dqXtDtZqqhMzBvUKoL+dvSW9FfPK?=
 =?us-ascii?Q?3LTRmbQKcToYlAtRJgqf1vqJcknxAT2U7JOKupARHnq7tG0qIlTrgq6h0aBR?=
 =?us-ascii?Q?kc4PXrU1G3apk9/dO86qkm2njK/qRqC5QFQg+sH/qhqdl1ipdsTklkkVuMHq?=
 =?us-ascii?Q?4Km3Hu75M9zu2lb0xLnHKYcpXyCC7i4GswG3HRMQExGggaldc6Oh6fKy5v7f?=
 =?us-ascii?Q?PNTXJmbfMu9/RpTBLj4e4vloknbpEFX0+iHl6RwgVy1VaEjXC8hXoUhX1CF1?=
 =?us-ascii?Q?x0DSBTWHtd5Q5kWgWBa9QU+gnEWbP+PLrTOv6cA89LWLq8AmNFILWDabTC4O?=
 =?us-ascii?Q?neXQAlkMyD0m23hudZ2KiHrYDGyg00SxEvBygLjvu9FBk7aGv5kPIeS9bqTS?=
 =?us-ascii?Q?zDx5K4upfJCMzb8aaINZiaJGXQSNY8wb8hEppJizp88/yzLz6v86QYgL4eVy?=
 =?us-ascii?Q?Nanle50nGEeo49H1oqrSEY2fw8mhCMFSAJYGV64qtmyPtfDOvinRh8NRlCIR?=
 =?us-ascii?Q?ToGyAf1CXBhQTfajAPl9DswF4cXVMmZvKb3wwb913JQX2eVBlUc9jBlAOyHO?=
 =?us-ascii?Q?H6BoLCZNipp5YUujNirKXasySD42k3rQ3Dd6xSBkxBJlryms3DN1o1oxJMNA?=
 =?us-ascii?Q?kH/GCqRTCV6K6luqYfkclQOXSYUBs2b1hzFN8Z8Q3j0tj9V8HGMX7a0SSUsF?=
 =?us-ascii?Q?kCKhDKAKLboXnImRkyMCugDMNu+OXAHx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3613.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qv1Qn/dRT9LGOGJ3lIlGhrc7778Lgj8AzfhC2bTmL2TOdQe5dacSMeqZ7vTX?=
 =?us-ascii?Q?MNr7tzlACsu3ftSmwEwvq1Q8G5ZopHZDz/M8zdOJ7KUkUBCkhklvLHcSNMJq?=
 =?us-ascii?Q?Jj23ErancR7VokEJbWzxOggGBp1Ok9OL6afgVFJR0iHaUlRLh6ieSyuMgB+i?=
 =?us-ascii?Q?YAUk6Lbmh+uYuwHlNe0S3F7hzCjpREt61qUr0FvRX/wtCGa2JG23U2oqgemm?=
 =?us-ascii?Q?KMfizkV7V8oyUiIrYDKQKr2qpZGLqZIgMEg5IHiYfeZzgpzECtRZ54lnBH1c?=
 =?us-ascii?Q?XzW/sNXzp3l02SKH0mk1qzjxAe/lOXHpqkgc6YvCc96dBR9c3Hb52H+BYzcE?=
 =?us-ascii?Q?zW+Z1zOyJUP+25byb8ybpFMQ/jHo54jNPUV81CQhXC/Y4Lnb4axb0Aj/5eWf?=
 =?us-ascii?Q?NNODtjOA/XbVBYBZ3OJ3cjI1QC7fa07jZLANqPYzTXGG+mok80sLpb/dNikY?=
 =?us-ascii?Q?Ov77YcEb0x7+f0BoFzDOpIseG4z31m4aoKkph1MllWx8rB55nuq9fIIStjDw?=
 =?us-ascii?Q?/0C1vWMgXoz/2YGCQyOQtFNG1nkphKT+3MTTCCLsUgtwp4m038fV9ZGuDR04?=
 =?us-ascii?Q?oozwVmdzzss3gkOMwCb4/vW+//3slUdmB3dPLRtVHWFEnACEUHAOF2MQ7XSC?=
 =?us-ascii?Q?GjwG7bdwO6wN4hLp7QML+VRyFj9iu0BiYp1pi0P6/MxY25+Y7aSmKpZburIz?=
 =?us-ascii?Q?TwAWCg+M3ste8hRxQwFFeJHr5ftOY3m9QwvDM6Y2LPEXU+RsxSNauTMnsn5I?=
 =?us-ascii?Q?w87AyNJIhUJjn6FV+nhs6jxjDYUTEdpkIEoYRa0KXAEH3Q8rCrV/sjNHOEZd?=
 =?us-ascii?Q?9t5sB3ybZw7BiBEVdjBUNyvN4ztFSw9AKNX2EGyx3lCh7PB2TyZ/ptRdB8eE?=
 =?us-ascii?Q?96kkPkXfxvAdRp06pbM0fIcG0bZLdPByCnzD+EHMgkyCPomPQMR1nI8jxJe4?=
 =?us-ascii?Q?XH84xBeQSPz/MqVA8E32SpiHmVI+NMSdVA0VW0zerQbhWhCnhi96RgsKX3L3?=
 =?us-ascii?Q?bacFpiBQGpK0UC4i/dPH+HJMXRQsikP33QeFRDHxAlkN2wwuBbNYFSKpbPrD?=
 =?us-ascii?Q?HdorouxaJvzyB9HWVJsIjyy2R0cPnwMLe7qet56rSYOgnj41kTKTeDTKdnxr?=
 =?us-ascii?Q?G2HeO3Fsuc0/YCeP6zEpCd5iwDheUbohs6zvOZuafJ+Wnc3LcHaNdDg5FIBq?=
 =?us-ascii?Q?UWUIIXSC2qSBcOmcRzwgxaUmGN3yhkgHzMnneIMtFzXj/pe5vQmkLqRQdP4K?=
 =?us-ascii?Q?JBgFD5lu9rLt/I/vaHTjhESXCmvrqLfIuJyCaPK7XYorMUg1BOs2nimEPTCe?=
 =?us-ascii?Q?7eC5uXOJB+pGfrmgQDBWX2C50VRtTcJQAwlY3RZGp7Zgm59oFwST4auaWsIj?=
 =?us-ascii?Q?OcEVqww1og9MVqP3H/VxA9SVYcD2wKPMKUgRovjeLipdVwbo3FW+lRCaeH41?=
 =?us-ascii?Q?p3GV1Bwhi+l6M7Ir4cyPQV0lp75mtly2Y/9oqY6UDz9X3VYwougtu9n8S+OR?=
 =?us-ascii?Q?HdQwSeHbqVKwbKaozx5I8192MQsQF/FbYc8SbleZroIDJ3OJretlRHUiLjPY?=
 =?us-ascii?Q?XM/I2AUH9xPC5phWnJI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 073b41ec-ae0f-4da2-cfa0-08de1e36c5dd
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3613.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 19:49:33.1107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nKFjveHmm/ilBHRcE57kMdN0mZq3FUgUVn4SkeYzjM9vt9Jz44TY/Jn2WIXTHujJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7975

On Mon, Oct 27, 2025 at 11:54:19AM -0700, Nicolin Chen wrote:
> Update the invs array with the invalidations required by each domain type
> during attachment operations.
> 
> Only an SVA domain or a paging domain will have an invs array:
>  a. SVA domain will add an INV_TYPE_S1_ASID per SMMU and an INV_TYPE_ATS
>     per SID
> 
>  b. Non-nesting-parent paging domain with no ATS-enabled master will add
>     a single INV_TYPE_S1_ASID or INV_TYPE_S2_VMID per SMMU
> 
>  c. Non-nesting-parent paging domain with ATS-enabled master(s) will do
>     (b) and add an INV_TYPE_ATS per SID
> 
>  d. Nesting-parent paging domain will add an INV_TYPE_S2_VMID followed by
>     an INV_TYPE_S2_VMID_S1_CLEAR per vSMMU. For an ATS-enabled master, it
>     will add an INV_TYPE_ATS_FULL per SID
> 
>  Note that case #d prepares for a future implementation of VMID allocation
>  which requires a followup series for S2 domain sharing. So when a nesting
>  parent domain is attached through a vSMMU instance using a nested domain.
>  VMID will be allocated per vSMMU instance v.s. currectly per S2 domain.
> 
> The per-domain invalidation is not needed until the domain is attached to
> a master (when it starts to possibly use TLB). This will make it possible
> to attach the domain to multiple SMMUs and avoid unnecessary invalidation
> overhead during teardown if no STEs/CDs refer to the domain. It also means
> that when the last device is detached, the old domain must flush its ASID
> or VMID, since any new iommu_unmap() call would not trigger invalidations
> given an empty domain->invs array.
> 
> Introduce some arm_smmu_invs helper functions for building scratch arrays,
> preparing and installing old/new domain's invalidation arrays.
> 
> Co-developed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  17 ++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 242 +++++++++++++++++++-
>  2 files changed, 258 insertions(+), 1 deletion(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
