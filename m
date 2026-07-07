Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011031.outbound.protection.outlook.com [40.93.194.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4242110E
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783434804; cv=fail; b=RB8Q4nEUY/QKdTEFo2T0CUgCmDGZpuZr3l1MqOJ6HNA7v7ZCy0obX4hUOScqWm+y7l0X0sZO1CHb2fG/hiLfCaip4cxoF6z5jb0sHSllJXIaqJezXxF4uK/V7sOMixOBCAdS0f/CZ/QXaswx6Y7o3Eih7ggqOw1eC5dptOzu9Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783434804; c=relaxed/simple;
	bh=VMOd3nSsAcyGtjbWfswFkYndpLN7WOAY0LBgycdrNSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=V4AR80vp+2djgq6nMUZwnHzGjtvqwCUtwDgF0jF4QdAOzqw9Tu8a47cZwJ0PaPUyTeMF3KP0/s+ntD4GKR5SLPMOPoSXjP5nrX6pHQjK7pJJYlNSjnlWZNQTAN9Lsl8iz85QPYVg0zpiJFRE52faYKVPr/f2X1CuhRcuO4PsyRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aPsTxk+s; arc=fail smtp.client-ip=40.93.194.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aPsTxk+s"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AqqxbGscRu7vfraJuctdfbZ22TNWACNvexm5Bn5JaRj88had9lJzjKvLyXzXL6337xZ5zSoFxoGdft0tDOqiaZMFxlqCZMd6dC5rGm+/QflQ6DZzjMB8YN09WckuG9dQoLDJTvZcZ4TVCIskhtY+9zUU7LSJgteqZJnmn0OFQPah9n8cahN/EMYg4J6RvqXXzbFQ50YOXcVpSTGlHd68C7mNPnza9ECrQlUwtE3tR4hy24isg0qViajsl2A9Jn68vikD2GvJJyRcsmieVPv0PCS6EtZ3TR/4T+3lJyevMxTxfawf80RsNfHlvkwdvnSBq9qGsuseSywPKSg6DD8j2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnNRTEZIeV3QsOow+fKVQHZa9muvnK8WMv+Xv8mi7mQ=;
 b=r4AsPHg7M7o+aG+dpUwzCC7bETu91CWFeQOq5fqRmu/S2bk5M9jOTxP01qhdW8BhFangQcvQpxLk3rsurBc8o6QVgjSTODArCXTBl7isCsBm7mkerpAh2frQveLwNcKoX4SCGT94k18jxzYRsTFyIjIezWCn4ByMU/2LZu5z7t7120ZJuoug7aM7O5QW5XBP4vm7cyxIx5Zmmw1kKvWMi4OBTwjUrI513NP/KbCynGrRWjLoIalr9DBeBnsr02mfT6QRd+1yfrB5UB/N0u6h4IgnAx4d/JIccJhkYevd074rtZGQ+KdgoaqMS2ZMN/sYVGXVNjwI7faUSTiX6mAVNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HnNRTEZIeV3QsOow+fKVQHZa9muvnK8WMv+Xv8mi7mQ=;
 b=aPsTxk+sFtE17nat2DtxGFrPId8gWhMigFxwz/VguxWeV0dnDdzDZZin0+LxmCmEuISeLooF6vbbIqCvoTp9KXX5i3SFbcxHcdIAuz3IzRC9SBEZNT/OVJGTEuRxXTuMB0Gx5XTCQ63SwtdTtdqtXiXr/LmiSSve6LHiGEH0vySt2CqpX43SMyDUoFgLBU3zaTlYnwV7UQcZ/dTUriFooWHGOWgTyQFyl3jTPkuc5yA+L3TzcRxPxZtSQtPvJQGzgLJukAodHAHIUf7jwJl7z2LvLc+idtlD7LCw/kCOXaCvEo41HpnQtW+tvuzeK9kfL/Sos3N4AoZOOfTnGQ9trA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by LV9PR12MB9806.namprd12.prod.outlook.com (2603:10b6:408:2ea::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Tue, 7 Jul
 2026 14:33:18 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:33:18 +0000
Date: Tue, 7 Jul 2026 11:33:17 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
Message-ID: <20260707143317.GF220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-8-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-8-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: YT3PR01CA0048.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::32) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|LV9PR12MB9806:EE_
X-MS-Office365-Filtering-Correlation-Id: 9963a549-28d2-46c1-09d8-08dedc34b00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|23010399003|22082099003|18002099003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kwIiDAWu0KQZ4xJgnBkvcQ/ry3dXAj/j+vC7VhMJvpz+IikkGUhWhSMDXHTLx6iVfeDEo/nRW6QIlNCQlU1IIuigB1/vxk9TS3JUEE2Y8Y6AWobPjrijZghJccriEkfFmiWnOpGM32GWwmf4cFf70Fcki2GV6SxFdgAVvdifLTgLC4MYrDNFYSxtKDwm4cACn8VAzTsE76l4KLCvbr/VC7pcvmNsCZnPQyy0crT7hDwVEY4765TPA3tFG/0jyqO+h2ND2iPHqcogNMtnD8xizr33/fO1ScqmYbZRsm3F3hLRs1c45VPKfzW/6Hi8wgmXMWHhaLc4BjdYhXrdniAxEsUnrymugoKu94Cg/luUZGpDKJoBKGgr1WQK/mNkwuvVZrPxOsD0Lud51hwY6uEN7fXYZIZ3Cbwz+bW5rMjraapyS8NFHVu5bCXpo2c/E4RJOmXOB7yIUIke/1z/8eEh60Z7pqlIgPTV57Mp4HCQJgW9uJhsWCkbl788yQxAfnhf3EzHFHAYFKyjc4KRWUCJFqAEHgIziCd29E4VkWvOJKBEdEG0+O3iXGZRu8LFWgmSpQje1RhyJYRn5zGSLqgzUWtpWaNzs55209keP3boGbsMpsIyn2XGIHv4prIqqRyZktuLz12voKrRH8li2k927xhvU71hNpIjeY+nQu9DlhA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(23010399003)(22082099003)(18002099003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jsxGSgHtOLLWD7JdQ9AqRUdh11hjWnfBZojVJUmSb1Q4LVTGk+G/CwlmkCJ0?=
 =?us-ascii?Q?foTa5heEv7RMuWq9ppAFJn4bvItGfCGfj2ZZlCCL+Gx6+bUJHgLnojaomo52?=
 =?us-ascii?Q?K59W8qLOHAk+LKoNKIjIVdKWINmnkb0JedoZof7NdPUHC/p7+qibzlD4F4dN?=
 =?us-ascii?Q?vy/+JpekZ/f2i5XtG/d1qKL1qqJIgqc6mBHfxZtIcS16npnypWnZGmRzT5YK?=
 =?us-ascii?Q?bJUWSsxXWGYTq2VEmfUnLb43wYlEWygw+j1patHfQsRMIjMGnAUvahE+9jjX?=
 =?us-ascii?Q?UgCcXCjlbNDv0xZUrotD1IbzoLgzFcMmtWnsbRIuX/Uyis2PC0D+7WGKfFiW?=
 =?us-ascii?Q?/1l9UgxAPPvpxc+5LZ5T700b7x8zaBCU3w2UZ3Gfuhv0VBeOCfy7tKKG9mn0?=
 =?us-ascii?Q?WXAM2G/XqZ7ZEe4/mdcryvee5VSj2lHI0l7jAPDHBeDJEG9sAE32tMW4HSGC?=
 =?us-ascii?Q?qY1TaFqwL/aptywD93408HCFGfjAnDcAX+sYObFdL1U6HxuUZ65Nsk7EzpIZ?=
 =?us-ascii?Q?r2UN/dH8xP7iG7NO1RSe3mY/UGTARo9Dd2eJjX+vA6/MStnHExuFhQAc9ZCm?=
 =?us-ascii?Q?OUDtxUPV6t/R5YAzoJTZLf11Tb+HV6MXTUDp2NjB9Q+jorOx+RJ/sk2YV/sX?=
 =?us-ascii?Q?Vb1hnyTCfrKkfSR3ZwUmx7c3KTynOrO/clyRle9JxwjKpn9oyY4MdOW1guaT?=
 =?us-ascii?Q?1iTC24Bd23p5aga8brjzCYEXV1tnBSAKPf1NcrXzFGvP9F3T9ZTbVho/NjnZ?=
 =?us-ascii?Q?+jDX0FBFdCVbg49Znr0t9wdJHJfhrxm1PhJS5XSkbHHqWI60e7TbQ/WaQHKr?=
 =?us-ascii?Q?I0zvkPWpdQfdD2X0fIEASp+4jML0Uszy+DE5qL+2wMwpurYznXXRi5PhX/h+?=
 =?us-ascii?Q?jYuRRTE4D85G4osIuWxETuKwLRZMOKKwiPJYg7/mvkcM24zsfZYDAIPOHM2S?=
 =?us-ascii?Q?IhV/V5H7s76nHgV4sDdLSO2OEdeQ4ylrAE3Q3eGh81A9eY5chUnBO+MCdRHQ?=
 =?us-ascii?Q?40u3kO21G6qmQ0f0F8KyMLDN9fVsbFVFvyJg8DynbHpf/OFvnysr7iBUJP7v?=
 =?us-ascii?Q?C9NwMS8GQPnoqtzddv5WhPUKii48uzVr5kf4VbZnpHob8PpBSQ2nIq2QhsAp?=
 =?us-ascii?Q?NGd2HJuqO5vDjA+u4zR7ChKchOFA1jHZmLq/aDHNTG7dkAFgWpjYYP8tcxD+?=
 =?us-ascii?Q?wfzjp17diGRkpHAFZmqEfjlPS1PSraxR9wt/zhr2fYFjnTeamg21q0t6Qpcw?=
 =?us-ascii?Q?5RoROYS0gEQ11mJ73PRGRN8idWInEKV3MJY5ZfhrazzLFgm/o4AA2KjQeKqN?=
 =?us-ascii?Q?pdF7KghXM+vl90XY4hD9f90l4oYf6F12k/P59LBCcemXcSNeDwpQDrw6x6la?=
 =?us-ascii?Q?pr0a1fME7+bsM6Ev81EI+kJp4D8SycRU5iq9h8vdE7bbBrX5WoBGe/W88inZ?=
 =?us-ascii?Q?anFA4295Q5Yc43II6Pk/pP2XaC532slq43ja8jz9OhokgZf7v5V10jmwqrZp?=
 =?us-ascii?Q?5fu8NXgMSH+wqC1m0t+c7JWona9lzMdY02f7Hm/m3+jBm6tZ6cRtEmtGc7Fa?=
 =?us-ascii?Q?uMVZ/IMN3FbhRU+CaA5Onrvumgud78VU0WirBDLn189bEMyCgKUJitSYgFiS?=
 =?us-ascii?Q?wZPyzMfORVePXgk1ojYvauuNCRlWyYJvEGc7zQ6glgmHS3IAvIkT1Z4AWPXS?=
 =?us-ascii?Q?D8GWGZB2mlonufxGLMe5QCM+1271NvZt5bMaG3rDFWo0A8mj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9963a549-28d2-46c1-09d8-08dedc34b00c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:33:18.5238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e6MgHq4UI0AId1NB7TQXgg+FHV6fP7d3LjZRpDmdw8685CcoPykFdR6NOiJsOYIT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9806

On Mon, Jun 29, 2026 at 03:35:20PM +0000, Suravee Suthikulpanit wrote:
>  
> +/*
> + * Returns VF MMIO BAR offset for the give guest ID which will be
> + * mapped to guest vIOMMU 3rd 4K MMIO address
> + */
> +u64 amd_viommu_get_vfmmio_addr(struct amd_iommu *iommu, u16 gid)
> +{
> +	/* TODO: Add check for sVIOMMU and set gid[bit 15] */
> +	return iommu->vf_base_phys + gid * VIOMMU_VF_MMIO_ENTRY_SIZE;
> +}
> +EXPORT_SYMBOL(amd_viommu_get_vfmmio_addr);

Why is this exported?

Jason
