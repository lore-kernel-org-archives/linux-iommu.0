Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012046.outbound.protection.outlook.com [52.101.43.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A6F64C3F6
	for <iommu@lists.linux.dev>; Mon, 19 Oct 2026 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418820; cv=fail; b=REjhcbSJeXsKb3hqUoLtxmgvYo3tFG1sm9ueRG4ifi7FeJmJy7eUFkqcET5CQACgNEXdz8iIhWgiSxUsLGAxhkC6k5fMoJVPOpOcTLT7LNgKLrwjQE83eNyu2g/GFAh9tz/KyToHLz4RH9opQTh/trfiW+cg8nChnejRg258Glw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418820; c=relaxed/simple;
	bh=1V4JjxKwfRyyJREemNKLd1nc5hOESKUtnAcsm9gyey4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UdILbP0/he93+hCVCin7EYtTzeZJA6JW01fnaTIqyGpnFe1ZwrzPoVoF+hzs3ZxHanhaNIz3GInk1to519AY99NuJMQttPprldyRTKJHBJW+8RFwgHkAc8yI/qSa/+kYds5++qGrJiAOTrGZ9W5XUVu//C3ZbkZRV1Gf0kZH2+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NBJ1Nfcg; arc=fail smtp.client-ip=52.101.43.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NBJ1Nfcg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tTz/YlsXwChHIbwvRd0enxxKnWH96cl/35uZRNtp5rYVb0/8jRFYbcJNL++60BWJy63Cnxxq98lRk+ru6ylQIumFkucddRsBWdWsHcG1cJplxnDZZCf7Su168Q32bJjZEKlx5q9vpx+b0gMyURT2E/Zr9D343b64c5Kxv1bBZSvItuzfHyi5vzFQky6ywSlDYU8y7zViBDaXyc+zFo/P2DwIOVGWP5Vy+TPBZ/02pXRr95tmNXBTVYr7tHD6SQjMnW4EbXS6otnTMUBa19LxeLPRX/id5GbogI8t/1Ia6rCsksFlEuhZyjDxocmjYLLekKAwA28u3BqZF7+uY/6lcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eoDnC2atBcu4KECPbOSglscfk7+x3ie9YeAXth+GcQ=;
 b=yP8h5wz+gS/3jWKAi0n0shn3n0A8akT7O/78MU1aQxj8xtlrrIVjDo3kwRXkRRNllvb5BvcGNl+i5e2ZLPPPls71zUcilY2xTv2WmdBsi3AbRQklX+9f5IN8BuGdDRm+xY+gv/MCnJqmwd9hM2++5jW8336tnz2DirzShVeHXaJxGN5avhrPW9PgEPYVSQm3TZBSvqB8+sev3c01YyUq3YpQOIn2iEhmboy47MIqNyC4EETpb4f6frblgMryoBJ4lPDrZ2iLT1b9qGft8k/J9PBrQX5M7Ex4Tv4PeLr9wo6Hb4IoB4yHFzI6PpVz23+ZMm+vpgZV5S+GdOsX7/DNtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eoDnC2atBcu4KECPbOSglscfk7+x3ie9YeAXth+GcQ=;
 b=NBJ1NfcgOV9C4g2ZKIzKJQAbDubc44OlYgaEx+5Ew71vCXiXwgxmNEbqnAawdzlciFqtOxYdq+Nye958UYMMBEBbmv+j/7XmsLLxOZrSqhfZPeJWveau3Qz/oRQeRgpDL/ow32cIm/+OaEh9FESWyWCkK+iKpbSnOFFFaem1CdU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by SA5PPFDC35F96D4.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 19 Oct
 2026 14:06:49 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:06:49 +0000
Message-ID: <f725d1d7-2147-4155-a3cf-f8348b56dca8@amd.com>
Date: Mon, 19 Oct 2026 19:36:31 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 09/24] iommu/amd: Introduce and map vIOMMU private IPA
 region
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, Sairaj.K@amd.com,
 jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com, chrisl@kernel.org,
 wvw@google.com, wnliu@google.com, dantuluris@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com,
 guanghuifeng@linux.alibaba.com
References: <20260930092344.5616-1-suravee.suthikulpanit@amd.com>
 <20260930092344.5616-10-suravee.suthikulpanit@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260930092344.5616-10-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0118.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d0::11) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|SA5PPFDC35F96D4:EE_
X-MS-Office365-Filtering-Correlation-Id: 92fe6902-27bc-4587-4874-08df2dea377a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|366016|23010399003|261009223027099003|18002099003|22082099003|10067099003|11063799006|5023799004|56012099006|4143699003;
X-Microsoft-Antispam-Message-Info:
	+Epm+lUavSciUcpuvPgunvruwP55/WAJOLYhM4P5EUNCEW9mw5wvbeWwMGK9CQAHr0BUKuc4W7KpQVVKjAT735Za/9IFqge1TYUnYKVsnGEwSJZDXQizHxj2udWmarpf1ad02WDwD4jBYdYoB1aeco0o+DnFSOjS6trHDIAZSGuI4PejXTsHWywmmwCQGAgQDe6lfpYc5Rx9sAUI5zYPFNPfDaSgqWUlgRtj2kNmhbFiuxSOj5mqgv9y3VVORy63w1NsaOkMcAip8r7b2JdL83QBaXc75a35Si8WRt5ROMnp6TJeVXhi19z0qlrny3dGNPD/euYRAZcxY5TBrrohrTJTsDkalIty68os8AoNu3twOIQMlphDBDUy4LlUk60omQD3b1Uu5F6MaP9dCviMn/RZrWr+BSwth3VKiT4SaDeOgni7UMICxJxawdCGD07jCX9XNXGynwc45B3VYONaBfSUOX+nKy7rDr1gTcU7RkJvUNdkWH8pfgJgzChV8LDNy5x7fT7ngaVzAb0Lhk88D/JjmUtAXmPdKbZH+A9Ss9voA10q0usPPfA06RO3011lgkEg+cMM7HRN1JF+TnCilLMJ8OLyIPCSQVCPig4/yHf4f+Y2c5jS8MqblsM2TKkETIVZa0WJiWVVnrFYH0/5L/4Ak9Zd4VXni6hZHyOQZJ8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(23010399003)(261009223027099003)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(56012099006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGppQ1Bzcjc2dTBpUjVxKy9UZm05V2Y1dS9qUUIzTGp2WWd2eWh2cUxBM2Rj?=
 =?utf-8?B?UmNOcE8yL0dRLzI1OHQvMDZvY0VxNWxkZ3I3emU2WHdpeHB1WTUweDRLc2Vs?=
 =?utf-8?B?bkhLZStEdGJ4ZUh4aGxURjhhckVKQVFWS3RYdFZZM0NpNkkybWUxb1dYVDNK?=
 =?utf-8?B?dlc5UlluNnVPZGViTnQzc2pxNFNyZ3dEaUltSHhwbWN4VVpmZFZQM3M4UGQ3?=
 =?utf-8?B?ME9PWEtaSnRMZldIdTBScldFQ2RhM2FxUm91aU9vN0JrTUY4ZDJQM3pVMGhy?=
 =?utf-8?B?bHdhQ1AxQWwyMjYvbFBzUE96NUp6TjFxQlU4d1UvWnQ1MmFXeXl5RlRtbzFh?=
 =?utf-8?B?T2ZWbG9IMkdtSHN4QW9sOVFGSUpQKytwRFAyZHNINmZqcWZ6VUJtQnhyTCtW?=
 =?utf-8?B?QXc4RnVpb0hCMyt2VkFFSXZsandTZW1CemgxSXRtVFlweElCeS9tejl5dVNE?=
 =?utf-8?B?WGM5NlBOR2lNcUg1Wi8wTTZma0ZBNzhVTk5KbzZ3SmNyeThhUEpjbXgydzUr?=
 =?utf-8?B?dm1ZSW5CUnE0YWlwYVh4NS9ldzQySDNDRGdJNmlGbUxtYlE4T0hHWkFVb2Ru?=
 =?utf-8?B?MkhJemt2VFlkb1IzSERwbVY0UFlFTTIzUDE2SFpjcjB6NitXdERheGdiRkJV?=
 =?utf-8?B?UEF2K2F3VDErL1VTTHN4aEJjOWdmenhWTlVNcTVlM29hL1JoN2wwYzViTmdF?=
 =?utf-8?B?V0FUd2NPR3BSbmlINXBGL1ZPQU9VSXFDUVVjYWdxa3RDNU94Z29KdHBTYy9u?=
 =?utf-8?B?d1lMSVNtRlM2R1Nvck1DcUkvWEsyblhlWmxWdldoQ0p5citXa2NLenJuZXNq?=
 =?utf-8?B?anpTRlh5VVFrNnBYWk9RVElzTHZ2OU0wNzl6MTdCMXo3a2M4KzlBR2tURVRv?=
 =?utf-8?B?VVh1ZWtOK1FTeE5wbXlEbW5GRkthTXYxUVJ1TVFwR0dxTWF4dlFaL3YzVEhC?=
 =?utf-8?B?Rk5aVEZLcEdNaTJyQUZMUHo5QmFXRGNkVytQeUVBM0J1Vmt2aGxPRjlkekxl?=
 =?utf-8?B?cXEyaXhQdHd6VXJIMEZhWFNqOGRoL0Z3ZlA0ZExtL3VDbjlZTmY0d0pGZlhK?=
 =?utf-8?B?dXlkamZzNFVMQStSYXkwOXlndXpTMVh1OE5rcjNTOUhTT3BwNFZLTlZzaVU4?=
 =?utf-8?B?VG9sOVl2aG9NTjQyODhNbE1iS3BDczBvaUtWelpkZnlieVp0cW1aNXRqVjNJ?=
 =?utf-8?B?ZytXYXNoSHV6SUhlT3pPMWtNT1dKVnFERU5vajhXNWRwUnJxOU9BTFdwN0JI?=
 =?utf-8?B?ZmRQaFRYd2JueDdhL3pUbTRXcmhQcW9ZbGZPZkhOYy81bkExQklvQTJCemhy?=
 =?utf-8?B?YTdqWWJIbGNJOGt5T3dRb1E4TkF1c1pGeTVnYVRRbVlZQjVUUlE1VWs2SVBx?=
 =?utf-8?B?bVJSUUN1MG9VOUxTK1IxR2FRZ09MNG5aUFlJd05nejRXdk9iVUw3cjBUd0l5?=
 =?utf-8?B?Y2lZTDJ3QWdFTWZzak9RT2t6WEo5L01EZDREWXhjSFRCNDQyaUh4OUR3TnhN?=
 =?utf-8?B?aHhRQkJ4TkJNSG56NUVlV3d0THJnVkUvQ2JNUFBadjdValBNNUJ0WW13ZS9x?=
 =?utf-8?B?eEdWVDdMTGhESzhRbFdhK29Fb25JSUg3YnhNYXlSSGdtYlp2cnVjS1BWUlpi?=
 =?utf-8?B?cVNQU0IzTjgwZlZzd2o2dWpFODZ5MURqUWVBcG5naXhQNHpaQWtMaHpGYlkx?=
 =?utf-8?B?eUpCeTBMMDBjN01Qb0ozdXpwM25MNHJhaGFRK09kaXJSVlpsNTQrK05vTVRY?=
 =?utf-8?B?RmxCMWh0VmJDTmtxNGF6eXdqVzNGaDY2eWZFRG16MTNEUkVjYmlLSHVwWTdk?=
 =?utf-8?B?czhEMkhSOUZxUkE4eEdhVHZtbGlZK3ovV21DMEtBd0hBZmFkelp3b0ZVZmpm?=
 =?utf-8?B?STlKZ2RUVFV3MmRMa3lMRnE5MFA5MVNHNVk1OVlyYUkya09nSzV5aklpTzNa?=
 =?utf-8?B?L1J5ekEvbG0zSG1sWklFVmN0ZC81UVJSQ0RSL0piTUViRU9KbzFCVkRWaGsw?=
 =?utf-8?B?bkxDUU9UVk9VZ21OQ2N4K1NPY3ZNbjAxdFpPYkIva0IzT1ZoQis5dEtGRFd1?=
 =?utf-8?B?UUozcW5Yd1lFYWxZbjlITUZJSVZsS1VMMmZkb0c5S3lGVXZkT3NTc2F3eXAz?=
 =?utf-8?B?azdqZUR6TUZtY0o2T2tTTHhUU1JOYzVtTXBXZU1meHNNQlJVZGRUeFJaTWlI?=
 =?utf-8?B?RUhVeExhWXJOUmE2RHQ3d0tXUjBIUDhCdlBmdDJWVDR0M0tjYS9xeXlXQlkv?=
 =?utf-8?B?TmZpcWU5aTczZm0wNFNvVkpGK0lQWktKc1JPZk8xQ01Xa1ZUU2Y1ZWF2L3dl?=
 =?utf-8?Q?wGIHrnX7bSEkDHk1CF?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92fe6902-27bc-4587-4874-08df2dea377a
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:06:48.8134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AKk+OOAH8mQYvKQZ7zt31njENPW/GwcZ72+dxUzVEPerd2f+ZS2hYafkhyOhD7lHunkAOuGoTux2TyjotVn1rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFDC35F96D4



On 9/30/2026 2:53 PM, Suravee Suthikulpanit wrote:
> AMD vIOMMU introduces the IOMMU Private Address (IPA) region for
> guest-side IOMMU virtualization data structures.
> 
> Introduce a per-IOMMU v1 paging domain in viommu_pdom, allocate
> 8MB of backing memory as four 2MB subregions, map them into the
> domain, and add viommu_private_space_init() /
> viommu_private_space_uninit() as a matched pair.
> 
> Register the owning IOMMU in viommu_pdom->iommu_array via
> amd_iommu_pdom_bind_iommu() so unmap uses the standard
> domain_flush_pages_v1() IOTLB invalidation path. On bare metal
> iommu_map() does not flush (amd_iommu_iotlb_sync_map() returns
> early unless amd_iommu_np_cache is set).
> 
> Call viommu_private_space_uninit() from amd_viommu_uninit() so
> boot failure and free_iommu_one() release the 8MB IPA mapping.
> Failed amd_viommu_init() after VF mapping goes through uninit.
> 
> viommu_priv_alloc_map() takes a gfp for backing pages and
> iommu_map() page tables. Boot uses GFP_KERNEL.
> iommu_alloc_pages_node_sz() zeros them. On set_memory_uc()
> or iommu_map() failure, restore WB or leak rather than returning
> UC-mapped memory to the allocator. iommu_map() already unmaps
> any partial IOVA.
> 
> Skip IOTLB invalidation when CONTROL_CMDBUF_EN is clear so boot
> failure after disable_iommus() does not wait on a dead command
> buffer.
> 
> set_memory_uc() on each 2MB-aligned subregion splits the x86
> direct map to 4KB PTEs. set_memory_wb() on free does not
> re-coalesce them, so the direct map stays fragmented (8MB per
> vIOMMU-capable IOMMU) for the life of the machine.
> 
> The private IPA domain skips iommu_domain_init(), so set
> IOMMU_DOMAIN_UNMANAGED. set_dte_entry() only programs a v1 table
> when type has __IOMMU_DOMAIN_PAGING; type 0 would WARN and install
> a cleared DTE when increase_top() rewrites the self DTE.
> > For more info, see section vIOMMU Private Address Space of the
> IOMMU specification [1].
> 
> [1] https://docs.amd.com/v/u/en-US/48882_3.10_PUB
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu.h       |   5 +
>  drivers/iommu/amd/amd_iommu_types.h |  11 ++
>  drivers/iommu/amd/init.c            |   7 +-
>  drivers/iommu/amd/iommu.c           |  13 +-
>  drivers/iommu/amd/viommu.c          | 192 ++++++++++++++++++++++++++++
>  5 files changed, 225 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
> index 8c298e090889..a0d5d7e34020 100644
> --- a/drivers/iommu/amd/amd_iommu.h
> +++ b/drivers/iommu/amd/amd_iommu.h
> @@ -53,6 +53,8 @@ extern bool amd_iommu_hatdis;
>  /* Protection domain ops */
>  void amd_iommu_init_identity_domain(void);
>  struct protection_domain *protection_domain_alloc(void);
> +struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
> +						      u32 flags);
>  struct iommu_domain *amd_iommu_domain_alloc_sva(struct device *dev,
>  						struct mm_struct *mm);
>  void amd_iommu_domain_free(struct iommu_domain *dom);
> @@ -94,6 +96,9 @@ void amd_iommu_domain_flush_pages(struct protection_domain *domain,
>  void amd_iommu_dev_flush_pasid_pages(struct iommu_dev_data *dev_data,
>  				     ioasid_t pasid, u64 address, u64 last);
>  
> +int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
> +void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom);
> +
>  #ifdef CONFIG_IRQ_REMAP
>  int amd_iommu_create_irq_domain(struct amd_iommu *iommu);
>  #else
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 9eb9a0c190de..9a90b8fe0fe3 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -417,6 +417,13 @@
>  /* Guest ID bits 0-14; bit 15 is reserved for secure vIOMMU. */
>  #define VIOMMU_MAX_GID		0x7FFF
>  
> +/*
> + * Total IOMMU private region is 8MB (4 x 2MB-subregion)
> + */
> +#define VIOMMU_PRIV_REGION_BASE		(0)
> +#define VIOMMU_PRIV_SUBREGION_CNT	(4)
> +#define VIOMMU_PRIV_SUBREGION_SIZE	(0x200000)  /* 2MB */
> +
>  /* Timeout stuff */
>  #define LOOP_TIMEOUT		100000
>  #define MMIO_STATUS_TIMEOUT	2000000
> @@ -804,6 +811,10 @@ struct amd_iommu {
>  	unsigned char iopfq_name[32];
>  
>  	struct ida gid_ida;		 /* guest IDs for this IOMMU */
> +
> +	/* HW vIOMMU support */
> +	struct protection_domain *viommu_pdom;
> +	void *viommu_priv_region[VIOMMU_PRIV_SUBREGION_CNT];
>  };
>  
>  static inline struct amd_iommu *dev_to_amd_iommu(struct device *dev)
> diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
> index 5be422591bac..d34f991dee24 100644
> --- a/drivers/iommu/amd/init.c
> +++ b/drivers/iommu/amd/init.c
> @@ -1805,7 +1805,12 @@ static void __init free_sysfs(struct amd_iommu *iommu)
>  static void __init free_iommu_one(struct amd_iommu *iommu)
>  {
>  	free_sysfs(iommu);
> -	/* Tear down vIOMMU before IOMMU buffers and MMIO are released. */
> +	/*
> +	 * Tear down vIOMMU before buffers and MMIO are released.
> +	 * IOTLB invalidation runs only while CONTROL_CMDBUF_EN is
> +	 * set (amd_viommu_init() unwind). disable_iommus() clears
> +	 * that bit first on the boot-failure path.
> +	 */
>  	amd_viommu_uninit(iommu);
>  	free_iommu_buffers(iommu);
>  	amd_iommu_free_ppr_log(iommu);
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index ae44050fe86a..dfb9268f3c4e 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -2509,6 +2509,16 @@ static void pdom_detach_iommu(struct amd_iommu *iommu,
>  	spin_unlock_irqrestore(&pdom->lock, flags);
>  }
>  
> +int amd_iommu_pdom_bind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)

Why not just rename pdom_attach_iommu / pdom_detach_iommu ?

> +{
> +	return pdom_attach_iommu(iommu, pdom);
> +}
> +
> +void amd_iommu_pdom_unbind_iommu(struct amd_iommu *iommu, struct protection_domain *pdom)
> +{
> +	pdom_detach_iommu(iommu, pdom);
> +}
> +
>  /*
>   * If a device is not yet associated with a domain, this function makes the
>   * device visible in the domain
> @@ -2858,8 +2868,7 @@ static const struct iommu_dirty_ops amdv1_dirty_ops = {
>  	.set_dirty_tracking = amd_iommu_set_dirty_tracking,
>  };
>  
> -static struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev,
> -							     u32 flags)
> +struct iommu_domain *amd_iommu_domain_alloc_paging_v1(struct device *dev, u32 flags)
>  {
>  	struct pt_iommu_amdv1_cfg cfg = {};
>  	struct protection_domain *domain;
> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
> index c9207ed47fb6..89d6dc520b2c 100644
> --- a/drivers/iommu/amd/viommu.c
> +++ b/drivers/iommu/amd/viommu.c
> @@ -17,6 +17,7 @@
>  #include "amd_iommu.h"
>  #include "amd_iommu_types.h"
>  #include "amd_viommu.h"
> +#include "../iommu-pages.h"
>  
>  static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>  {
> @@ -39,9 +40,12 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>  	}
>  }
>  
> +static void viommu_private_space_uninit(struct amd_iommu *iommu);
> +
>  void __init amd_viommu_uninit(struct amd_iommu *iommu)
>  {
>  	iommu->flags &= ~AMD_IOMMU_FLAG_VIOMMU_EN;
> +	viommu_private_space_uninit(iommu);
>  	amd_viommu_vf_vfcntl_unmap(iommu);
>  }
>  
> @@ -110,6 +114,187 @@ static int __init viommu_vf_vfcntl_init(struct amd_iommu *iommu)
>  	return -ENOMEM;
>  }
>  
> +/*
> + * Restore WB and free @va. If WB restore fails, leak the pages so
> + * UC-MINUS direct-map PTEs and the PAT memtype reservation are not
> + * returned to the buddy allocator.
> + */
> +static void viommu_priv_wb_free(void *va, size_t size)

Better viommu_priv_free() so that it matches the alloc function?


> +{
> +	if (WARN_ON_ONCE(set_memory_wb((unsigned long)va,
> +				       size >> PAGE_SHIFT)))
> +		return;
> +	iommu_free_pages(va);
> +}
> +
> +/*
> + * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
> + * *@out_va is NULL on any failure. @gfp is used for the backing
> + * folio and iommu_map() page tables.
> + */
> +static int viommu_priv_alloc_map(struct amd_iommu *iommu, u64 iova, size_t size,
> +				 gfp_t gfp, void **out_va)
> +{
> +	int ret;
> +	void *va;
> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +
> +	*out_va = NULL;
> +
> +	if (!iommu || !iommu->viommu_pdom)
> +		return -EINVAL;

Redundant check as its static function and know we it gets called only if iommu
and viommu_pdom is valid.

> +
> +	va = iommu_alloc_pages_node_sz(nid, gfp, size);
> +	if (!va)
> +		return -ENOMEM;
> +
> +	/*
> +	 * IOMMU spec: backing storage must be UC. set_memory_uc()
> +	 * splits covering 2MB direct-map pages to 4K; set_memory_wb()
> +	 * does not re-coalesce them.
> +	 */
> +	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
> +	if (ret)
> +		goto err_uc;
> +
> +	ret = iommu_map(&iommu->viommu_pdom->domain, iova,
> +			iommu_virt_to_phys(va), size,
> +			IOMMU_READ | IOMMU_WRITE, gfp);
> +	if (ret)
> +		goto err_uc;
> +
> +	*out_va = va;
> +	return 0;
> +
> +err_uc:
> +	viommu_priv_wb_free(va, size);
> +	return ret;
> +}
> +
> +static bool viommu_cmdbuf_enabled(struct amd_iommu *iommu)
> +{
> +	if (!iommu->mmio_base)
> +		return false;
> +	return readq(iommu->mmio_base + MMIO_CONTROL_OFFSET) &
> +	       BIT_ULL(CONTROL_CMDBUF_EN);
> +}
> +
> +/*
> + * Unmap @iova if the command buffer is still enabled, restore WB, and
> + * free @cpu_va. Skip IOTLB invalidation after disable_iommus().
> + */
> +static void viommu_priv_unmap_free(struct amd_iommu *iommu, u64 iova, size_t size,
> +				   void *cpu_va)
> +{
> +	size_t unmapped;
> +
> +	if (!cpu_va)
> +		return;
> +	if (!iommu || !iommu->viommu_pdom)
> +		return;
> +
> +	if (viommu_cmdbuf_enabled(iommu)) {

Hmmm. Why do we need this check?  We already have AMD_IOMMU_FLAG_VIOMMU_EN to
track whether vIOMMU is enabled or not. So in amd_viommu_uninit() path, if
required we can check that flag so that we are sure command buffer was enabled.


-Vasant

