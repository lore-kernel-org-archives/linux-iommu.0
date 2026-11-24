Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795497839;
	b=BDXi/UmhvtcBVs7oDc+C5RGqUobW7Srne1I9+qwTeKgx97Z5CTbxbCIg/MW0KBLK/MME
	 ZrDPbfGjf7eTEEcnDzHscm9AF4eU1O0vORsea127DkfpIxYrNqhHYV+R7F2tSyBvnBy43
	 HWIxy0fL1PHwiFft4q2X+ZiyosvhFWhoP2ARdxUhvbRYgInW/IT5RdflbDvcE+jkkYdnO
	 PMal2uXhrYR1FSG/+MPiVojaVY4HSpgpJYjU6UFQl6QDgRgBViC/XXcNOo/mimvKWttlH
	 aqmKx+0VuVftr82WBa3fqtJUt/4pzusMYwyMUiBdPaoBAl4MS8SrzxkZvRUDMM4PCAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795497839;
	h=DMARC-Filter:DKIM-Signature:Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:Content-Type:Content-Disposition:
	 In-Reply-To:X-ClientProxiedBy:MIME-Version:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-CrossTenant-Id:X-MS-Exchange-CrossTenant-MailboxType:
	 X-MS-Exchange-CrossTenant-UserPrincipalName:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=2w73sxHct45ALL0fvmrD2lcttabAAcsXl3NwU0yYwUo=;
	b=zDWcjckp2IILw9B9FpX0fvqd27doiUZlzkSXlxAw8apZZgauMCwcdq1jT0xTx6PIcT/p
	 7tu9Tvwk8FwZ0v10KK+RzIKpYD3Q737Jrl3JGszxSVQ3vBE4DK1Jqqerk8YrRNBDWAr0E
	 9zacRiCmrInWbu1MKJxx85pKYVIwwkwYZ8VZyZlGdcy5Iv3nQlOL3HSGMlJOq/2p1w906
	 3TdEX4NrpI6bbiZ9UwTkJDnpgk9ndz03o6+5RKapwPz+/jJxZocsqSNknNbMfcTez+HXg
	 P3uz/HpAqVcnd/5aUwf6gHVo/JoA+3owld+46GpK6x7JoCjFr34WVVdA7/oGnoAdt5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=umOLT7+l;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.61.35
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010035.outbound.protection.outlook.com [52.101.61.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3BB606A31E
	for <iommu@lists.linux.dev>; Tue, 24 Nov 2026 05:23:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E3BB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=umOLT7+l
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d59hVkTw+Gl5KgnuU+r8SwtpRXZSKcikp4FDHNAZApfKBIiZWgtfmfMaq78sx6ruyqRNYHnWEV1jkYoigj/mgOK0axa6I8HaYNwZWNM8NBV4pnfCY5zQxFLH/cBKcYH+HcLRUNQAY/4VfyckJnXiUotgeY0+KirYl2d6jQ8rOx0URl6JN09hTmwto3/8KkJYYnKFeTLu3WyX0R28NrDd1H27c3Qszyrfo3ILgIr1MTkMndGE0UM7K9L5vEZmROKcAs/XmApKc2Pc8e5AmIFjCf3K58eLkQ3Fytb1t3f9qdfc+kkUOefp8gjXKMp+01sfQ48ZvCFvTAjAJ4w+ZxXNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2w73sxHct45ALL0fvmrD2lcttabAAcsXl3NwU0yYwUo=;
 b=j3bQK9//rSma98W6xuZQwYETs8V195qE+8xlb2OaDrNjQLc+crG/TXMpg0PEEwTklztii04PASLfS2qgPw++O4myjyn2FSGoY9KsnOnw/CoAt0nMpIMg9oMXlsJ2nO65mW0Y6SclzbtYZA+B4q8I1Pfxdj5aoKWL3AQI+1wmBTu6+fm9d0NuQkJmO7zAc5GiUdcc4Up+To5fYCYtaQutfX2B79F9Aa0MrBR2vGAoDwBWMjRxn+trAdVPvbExc1I2cE0S7HiSPlIrFLh/fbJNKS58Gv+P3qoGdO/nEk75UizSEP1u6aGrS/GYys8L6mSdsguFlLUbebzO8ekpd83c6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2w73sxHct45ALL0fvmrD2lcttabAAcsXl3NwU0yYwUo=;
 b=umOLT7+lAaqGL9Jas3sSLapqTfIRtLF75O0hPRVCHtSe0pJfB2vXiuk1LtGoER7Tww5mDalWPQ09PZk3ipd8JL1cYSLrhklbZ3BC0SFB/iDKRPlYQ1GC2SamV8nfj+fxXQ36FU7CUZU9U/pEA7SlWAZKPlsJ3rE12N9G6bTq0n8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB6837.namprd12.prod.outlook.com (2603:10b6:806:267::10)
 by LV1PR12MB365848.namprd12.prod.outlook.com (2603:10b6:408:50d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Tue, 24 Nov
 2026 05:23:32 +0000
Received: from SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0]) by SN7PR12MB6837.namprd12.prod.outlook.com
 ([fe80::42e1:d1c1:d50d:b2d0%6]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 05:23:32 +0000
Date: Tue, 24 Nov 2026 05:23:18 +0000
From: Ankit Soni <Ankit.Soni@amd.com>
To: Samiullah Khawaja <skhawaja@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	David Woodhouse <dwmw2@infradead.org>, Pranjal Shrivastava <praan@google.com>, 
	Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, 
	Alex Williamson <alex@shazbot.org>, Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Pratyush Yadav <pratyush@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, David Matlack <dmatlack@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Vipin Sharma <vipinsh@google.com>, 
	Nicolin Chen <nicolinc@nvidia.com>, John Starks <dev@jstarks.net>
Subject: Re: [PATCH v8 05/18] iommu: Implement IOMMU domain preservation
Message-ID: <ngjof224lsvn3aamehaaowcsk6lyrypjw7uidwwbxxpzot53t6@462wqwsp65bw>
References: <20261123044949.3610702-1-skhawaja@google.com>
 <20261123044949.3610702-6-skhawaja@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261123044949.3610702-6-skhawaja@google.com>
X-ClientProxiedBy: MA5P287CA0163.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1ba::11) To SN7PR12MB6837.namprd12.prod.outlook.com
 (2603:10b6:806:267::10)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB6837:EE_|LV1PR12MB365848:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9cc767-38c0-42c7-6ab1-08df49eb1479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|376014|366016|261102123227099003|261026121527099003|261026140227099003|261026130827099003|261022113327099003|261022115727099003|261022075727099003|261022105027099003|261028144727099003|261021121427099003|261021130227099003|261021135927099003|261021123027099003|261102130727099003|4143699003|11063799006|5023799004|56012099006|10067099003|261009221227099003|261009223327099003|261009223027099003|261009220027099003|261009221727099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	EFblSmy1Stxnp4e/Jb7PRc6hf9a+Rsjb0j9CQ6eX+y93FJBzaJWKhpJmWMTg9RaLGoueOqmxuL/DbQdx9OwLlT0tqP6DOP9AeawOZ8HqJbA4sT48rhHmdQh3Zx8yyUKO9/hfPn1z+AyEUl3arAf6DVi7+Ls5SJURiNoaeDHiNZajTudckn/yC0AsII6BlMcr5ZYYFwM8XAvZVItgYN99AMeV3SgrKwvnSWzkINty443Nj8DRmINLBVwI9+ehDOgh2cwqzdjLQ09vziAy3Ivjcp/XSjizbX6CmWlTUHlWN/7wNMBl1rggrFDRpJTGgHXd9GdeGNjp9F3l5SeEHy53GxXrh9kwm5g42zMA12QL3QKnD6VhvOrhKTRx/eE6A1yjA8gsArhyQu4SLk9MLkTxYGevkyn6hskDhLCeKWa+gG7obzAtYCFxJZ4ur/pchG1iySPFkese7VuIp3nnPYaWJbdMpVtSmAmZxwEEhzyvHF4u48hVaplnZlSwK4l+hwLUwR21MESEiFWYEDgpHhCIeug+9tXAT0FtQmAIQS2+UvI4PPVlzra89YNsOYi9NkrdDbIrAfQJq7GaLUeSmYRl8/vl6K0xk87omDpXvgo9vdaAgBO6IuqecVNKeAOA3sCLFRU3Br2ka+JrsDJCd1udste22VBPdoOXSHXCuWkj/mA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB6837.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(376014)(366016)(261102123227099003)(261026121527099003)(261026140227099003)(261026130827099003)(261022113327099003)(261022115727099003)(261022075727099003)(261022105027099003)(261028144727099003)(261021121427099003)(261021130227099003)(261021135927099003)(261021123027099003)(261102130727099003)(4143699003)(11063799006)(5023799004)(56012099006)(10067099003)(261009221227099003)(261009223327099003)(261009223027099003)(261009220027099003)(261009221727099003)(18002099003)(22082099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2wR6FTPGaEyPZO3HZ+GLJOr25goc731QrJ+wDaZs2zFbi1T9CBeSiqvjVtqL?=
 =?us-ascii?Q?FdfcATWlBA12nB+1aelncVZgXC2INO2V1cSbjcrdT1e5Vm/kTXL9z5CB7jQP?=
 =?us-ascii?Q?DTcAS5jfGUFDmNQxUnBv2+gaCpfltQDr+whv62aJ25+CWuxAMNKbZRUFOMMu?=
 =?us-ascii?Q?IfzEAc18+/S9DCM1DvWvY6xw0sS8RSGTBwXMmGOlihuJe+YqixJpQv/SroGj?=
 =?us-ascii?Q?kIw9zc4iYfF0hYvJc7cvctE5RZ0DulCSdeVtYmK/LbCf0Rj9a2hyUMXt8y40?=
 =?us-ascii?Q?C44h55A/gn4W7YH0dc7eDS5Y1eZDfRvwCw3vjVZ3fqEKZsww1pi06jVZgvd9?=
 =?us-ascii?Q?Gryzu37j2V2e3y/wigfT6Vxi0qWZqAVYkWepCeWCryMzZtdjpnBxxP0vRp0t?=
 =?us-ascii?Q?9ngjAYM2+pByCfRxO1S3IXgkFyOC3WclmHPDZu6LL4n18Nwf0HJdfq/pqt3W?=
 =?us-ascii?Q?4dxm6beU1TQ1/AsBOj3EEZ87f1kYxsFxOoztNHvHwb+NvWpH8ddJhwhDe+pF?=
 =?us-ascii?Q?IAFZ3Xicjj3O7MXBpsRedrxCzomXLph5ZvE9rlg7Whe5oxe+FbxaWlL0iYzz?=
 =?us-ascii?Q?BuIaD9MZN5v8IaWp6BJTY7BLLq72i2RsOCK3QRGAdcpmLlknlyfncWV9nY6Q?=
 =?us-ascii?Q?HlDcqjj8rUzA3XdCJFDqXF+wFuC9P2BTTc8NQyoYZ4kf8z8sga5WOfpmMBVo?=
 =?us-ascii?Q?0lui//fjpgeSpReEYVrP0HDS4Ob6M8WiaZXgVxUcg240E3Z/rSA6crM1r6YB?=
 =?us-ascii?Q?bA3JqkpA8ytsP9pW2pa8JhmorLRQKNB3mGkj9jdQ8ZGFIcMKS9i15dTamF0t?=
 =?us-ascii?Q?a7Dbgvoq5yklgAPary6lomHRQUu3xJmKL9qbe+UP5iAWvQQeeIakdxhiEaJt?=
 =?us-ascii?Q?4ZrIMqkEId9KUgBd2gvvoKTXt2XXujsa5mXUIiRzvsYO0or62NCjO0UbPmcl?=
 =?us-ascii?Q?RPIMMxIx07fMpDTV4DIO0zfgShFae2L+++kj3LosRHp8vO6Qxsxrclz6RvZY?=
 =?us-ascii?Q?DrFIqHuoxrCn2bFRl1JUS3NlHiQS5owe309VBBAOritVMhkCiNPTls0DN1Cn?=
 =?us-ascii?Q?2jkV9kGS5U2r1byatmqD+QSDDzwxiNu2jZ1ccYXNHj8BKX0dgB7Tir5lwlYb?=
 =?us-ascii?Q?KXrjbgcb2JeSHxHr0zRW++HuD100EPriX11ZaDaXZhd4jHDPWf5j8o4rZmuD?=
 =?us-ascii?Q?zPxqTUwsBvPQ0V8tt1Qw80ILFusjC6uEghZe8kHT99GxTQ3WR99X4re/8O0R?=
 =?us-ascii?Q?ukjXJsu7KbGa8Ysxra4LosBVgLsuwXAvayTLUW7jWJrVUs4pnLqML3KMGVaj?=
 =?us-ascii?Q?gzFshDFBlxwLmFddrn66WA2dYBrXY657RJnvoMxlsJ/qdirYFj1M2vrvQgo2?=
 =?us-ascii?Q?8OT86tWI3P8TrxPHtCDafh3dKgKrzRhFXKO6RhQBwZGoODymMFQ/udgMBZyA?=
 =?us-ascii?Q?kvgvzgJFABgpRno8q9iv5EX2VPcF8/c1g1a8SXuggIbBO+1PMgeH70H8M+lB?=
 =?us-ascii?Q?qcG2tuLoq5dImGSYfX1roK2zTRB8fMdPOpJ5hnYRtW+4GjN44DQ42LM00h0g?=
 =?us-ascii?Q?/Ryp+BGd0/CrZbibyNDqzysVWffv0GGN6OKkYgCqGFof+cy9C/HfXQCSh4Y0?=
 =?us-ascii?Q?sMODKbDyqGir7ApEGMSHUXTlQKuBwzZKwGVLVEKWP99hlB9cr9YXO1seywRY?=
 =?us-ascii?Q?Ny6lyvlvb+v1tzUUZyLqkmksMfLrxKs1sT7FCXOWCrBccDejipsrvgu5bNFS?=
 =?us-ascii?Q?Ttqy4eRskg=3D=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9cc767-38c0-42c7-6ab1-08df49eb1479
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB6837.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 05:23:32.0661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PtuISSgUbwNHrfvyZtm6JU8Z8r1ufBkEIr25vY7FMW7lb5sreBq64IriwCMmj6hEqesYf5Z9cXUMQo81pjVnyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV1PR12MB365848

On Mon, Nov 23, 2026 at 04:49:36AM +0000, Samiullah Khawaja wrote:
> Add IOMMU domain preserve and unpreserve APIs that can be used to
> preserve an IOMMU domain across liveupdate. These APIs use the iommupt
> preserve and unpreserve ops of the domain to perform the respective live
> update operations.
> 
> Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
> Reviewed-by: Pranjal Shrivastava <praan@google.com>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

Reviewed-by: Ankit Soni <Ankit.Soni@amd.com>

> ---
>  drivers/iommu/liveupdate.c       | 119 +++++++++++++++++++++++++++++++
>  include/linux/iommu-liveupdate.h |  11 +++
>  include/linux/iommu.h            |   5 ++
>  3 files changed, 135 insertions(+)
> 
> diff --git a/drivers/iommu/liveupdate.c b/drivers/iommu/liveupdate.c
> index a1f40e242d93..a98f16d11727 100644
> --- a/drivers/iommu/liveupdate.c
> +++ b/drivers/iommu/liveupdate.c
> @@ -37,6 +37,7 @@
>  #define pr_fmt(fmt)    "iommu: liveupdate: " fmt
>  
>  #include <linux/errno.h>
> +#include <linux/generic_pt/iommu.h>
>  #include <linux/iommu-liveupdate.h>
>  #include <linux/iommu.h>
>  #include <linux/kexec_handover.h>
> @@ -67,6 +68,35 @@ struct iommu_flb_obj {
>  	struct iommu_ser_set device_set;
>  };
>  
> +/*
> + * Reserve a new serialized object at the end of the set. The deleted objects
> + * are not reused, so the objects never move and can be referenced by their
> + * physical address.
> + */
> +static void *iommu_ser_set_alloc(struct iommu_ser_set *set)
> +{
> +	struct iommu_hdr_ser *hdr;
> +	int ret;
> +
> +	ret = kho_block_set_grow(&set->bs, set->count + 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	if (!set->count)
> +		kho_block_set_it_init(&set->it, &set->bs);
> +
> +	hdr = kho_block_set_it_reserve_entry(&set->it);
> +	if (WARN_ON_ONCE(!hdr))
> +		return ERR_PTR(-ENOSPC);
> +
> +	set->count++;
> +	*set->head_pa = kho_block_set_head_pa(&set->bs);
> +
> +	hdr->ref_count = 1;
> +	hdr->size = set->bs.entry_size;
> +	return hdr;
> +}
> +
>  /*
>   * Restore a set of serialized objects from the previous kernel. The objects
>   * are read using the size recorded by the previous kernel in their header.
> @@ -239,3 +269,92 @@ void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  	liveupdate_unregister_flb(handler, &iommu_flb);
>  }
>  EXPORT_SYMBOL_GPL(iommu_liveupdate_unregister_flb);
> +
> +/**
> + * iommu_preserve_domain() - Preserve an IOMMU domain across live update
> + * @domain: Domain to preserve
> + * @ser: Pointer to receive the virtual serialized domain state handle
> + *
> + * Return: 0 on success, or negative error code.
> + */
> +int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
> +{
> +	struct pt_iommu *pt = iommupt_from_domain(domain);
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret;
> +
> +	if (!pt || !pt->ops->preserve || !pt->ops->unpreserve)
> +		return -EOPNOTSUPP;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (ret)
> +		return ret;
> +
> +	mutex_lock(&flb_obj->lock);
> +	if (domain->domain_ser) {
> +		ret = -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	domain_ser = iommu_ser_set_alloc(&flb_obj->domain_set);
> +	if (IS_ERR(domain_ser)) {
> +		ret = PTR_ERR(domain_ser);
> +		goto out_unlock;
> +	}
> +
> +	ret = pt->ops->preserve(pt, domain_ser);
> +	if (ret) {
> +		domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +		goto out_unlock;
> +	}
> +
> +	domain->domain_ser = domain_ser;
> +	*ser = domain_ser;
> +	ret = 0;
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(iommu_preserve_domain);
> +
> +/**
> + * iommu_unpreserve_domain() - Unpreserve a preserved IOMMU domain
> + * @domain: Domain to unpreserve
> + */
> +void iommu_unpreserve_domain(struct iommu_domain *domain)
> +{
> +	struct pt_iommu *pt = iommupt_from_domain(domain);
> +	struct iommu_domain_ser *domain_ser;
> +	struct iommu_flb_obj *flb_obj;
> +	int ret;
> +
> +	if (WARN_ON(!pt || !pt->ops->unpreserve))
> +		return;
> +
> +	ret = liveupdate_flb_get_outgoing(&iommu_flb, (void **)&flb_obj);
> +	if (WARN_ON(ret))
> +		return;
> +
> +	mutex_lock(&flb_obj->lock);
> +	if (!domain->domain_ser)
> +		goto out_unlock;
> +
> +	/*
> +	 * There is no check for attached devices here. The correctness relies
> +	 * on the Live Update Orchestrator's session lifecycle. All resources
> +	 * (iommufd, vfio devices) are preserved within a single session. If the
> +	 * session is torn down, the .unpreserve callbacks for all files will be
> +	 * invoked, ensuring a consistent cleanup without needing explicit
> +	 * refcounting for the serialized objects here.
> +	 */
> +	domain_ser = domain->domain_ser;
> +	pt->ops->unpreserve(pt, domain_ser);
> +	domain_ser->hdr.flags |= IOMMU_SER_FLAG_DELETED;
> +	domain->domain_ser = NULL;
> +out_unlock:
> +	mutex_unlock(&flb_obj->lock);
> +	liveupdate_flb_put_outgoing(&iommu_flb);
> +}
> +EXPORT_SYMBOL_GPL(iommu_unpreserve_domain);
> diff --git a/include/linux/iommu-liveupdate.h b/include/linux/iommu-liveupdate.h
> index 4755ab3cd67a..caa9778eee2d 100644
> --- a/include/linux/iommu-liveupdate.h
> +++ b/include/linux/iommu-liveupdate.h
> @@ -15,6 +15,8 @@
>  #ifdef CONFIG_IOMMU_LIVEUPDATE
>  int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler);
>  void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler);
> +int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser);
> +void iommu_unpreserve_domain(struct iommu_domain *domain);
>  #else
>  static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *handler)
>  {
> @@ -24,5 +26,14 @@ static inline int iommu_liveupdate_register_flb(struct liveupdate_file_handler *
>  static inline void iommu_liveupdate_unregister_flb(struct liveupdate_file_handler *handler)
>  {
>  }
> +
> +static inline int iommu_preserve_domain(struct iommu_domain *domain, struct iommu_domain_ser **ser)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +static inline void iommu_unpreserve_domain(struct iommu_domain *domain)
> +{
> +}
>  #endif
>  #endif /* _LINUX_IOMMU_LIVEUPDATE_H */
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index ef5043752a36..77f78c88c627 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -14,6 +14,7 @@
>  #include <linux/err.h>
>  #include <linux/of.h>
>  #include <linux/iova_bitmap.h>
> +#include <linux/kho/abi/iommu.h>
>  #include <uapi/linux/iommufd.h>
>  
>  #define IOMMU_READ	(1 << 0)
> @@ -249,6 +250,10 @@ struct iommu_domain {
>  			struct list_head next;
>  		};
>  	};
> +
> +#ifdef CONFIG_IOMMU_LIVEUPDATE
> +	struct iommu_domain_ser *domain_ser;
> +#endif
>  };
>  
>  static inline bool iommu_is_dma_domain(struct iommu_domain *domain)
> -- 
> 2.56.1.809.ga0b61035b5-goog
> 
