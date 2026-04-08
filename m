Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010017.outbound.protection.outlook.com [40.93.198.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75FC43D88E1
	for <iommu@lists.linux.dev>; Wed,  8 Apr 2026 17:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775669353; cv=fail; b=eKL852Rx499EPBVaXSbcu4ycCe/+sZGg2Sti3kdNMAfZqk7tY50yPcH0oeb2bMmRwAuT+LYCyFFtWCG3764Ng1e+9zPawgWDJhtqCkxwlbcX34/njCOL6ohGt2GJropKI7u+DCBIxEEfk7bqbRgASPcXPzJA7B60mBerGFqGc7I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775669353; c=relaxed/simple;
	bh=qwdH1z+YA9qEvtjZZ8E/JO+O8iKNTDiA2kPlLy+Wap8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MJwOWtL8i1UdpA0xsZkRMqzKaP4uWwxOzsCHKwB1ey1zeFWeUx1ai9uKDsiIMxMydJxOddlyWYafh+wM46e4BgG6S1ht+Bj8/TNUO0py0Kr61UW7pwTJYCYdWvBHKrIXKuSsJ/WnFZKpeYghEbRANktLRjqtppR4klSHgaF0Y3U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lzwVLtkb; arc=fail smtp.client-ip=40.93.198.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lzwVLtkb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pEbth76Cp3cNGHkXd5z9T2g223iw1yPfKSZpVNvNObdBQfEDi8z4u3IoJi9OyoDJnjiSttIf7mSxZxRq5bekGoThNb4p0xFg7Vk+JK3upPCvlzsxDMPrvMaIaCMeoXc39F42VmV4XSyfL5/AfE4tGHWQl5rjxeP0weyXDZd6zw+DG/HejkZkGZFSXvr3DQlvJWCzA2rxXc0Pyxq3cLZkzA16Ld0kf7zS40dYCUv+unxBQg+x3FEOYa+zhdCg+aXWZaEWnybBdZoH1syKRxNT4AbxXEGXFctWvrglZUhhXLWpjV0Z06AJt4tetRglY4DsE8uiG6ag4Gl+06pjKWGgig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aUNIhwEkhzskfcORIZb/HtYjPQhW31BZ638N801Swj0=;
 b=otc9Uq2ckZntP3CZ5Hwb5DOpdchRRCbwsp2W3BBI9PDfgXzViUYhuc5NPKU6mmpZ6ZXTYIUGtRy6jT+LQb+mpMMXjjcmg8LQE3I3ol9OTWENSQc6buhI+tdF/hsAGOoT42ar7p8I3mdNDjndfR9Q0nWoQOjnUjfOY1mGl1Z6rmKimpBXHM4V7mjwnsunRajXRqzn0dSYvaKDJl87oN60ropMvMK9Ef3Rb71v7/MkSsNOgFIzYBHAKThOtZ3PUqzbzl+JIWHxrCDTnPCxUzuBWb1WJxxM+u0U+Myces4wpijFx7DkiZotBwySRMkiCt0Ya2LpUlBg1egk1R6ECAR1aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aUNIhwEkhzskfcORIZb/HtYjPQhW31BZ638N801Swj0=;
 b=lzwVLtkbyCP6SZipD75LImAKFoh2P2MwjbCPl41Oui1FMO1jGs8rP84Ra/nxFqfPhYE1zS+RHcmP7sG7t57VufQLe09Xwfiw+vuDv8bMy11doWDd2WS1YX5WDBZHdWDLbgnBXcmCNug5h7EyFzcr0uaLEYpJ48qvN6iJnZLhmjSqQXimGr41rhWM/xCDOMctgn4iyfmc0wyCnaBBxzG6pgsUee10ciguMUiC/HveTJU1ZS9q5mjczkPNbP8+KjsidfbEwr5Dl7WdK3OXYFGojou1S7+xNH4TUpwVQePMgiTKnNSs20R6zi/hU993uFvBzqZizhx4pMhGIoaLIUXIBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by DS7PR12MB6286.namprd12.prod.outlook.com (2603:10b6:8:95::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Wed, 8 Apr
 2026 17:29:01 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 17:28:59 +0000
Message-ID: <bdad8adc-5c20-4fb5-90b0-b7ca4199a7a8@nvidia.com>
Date: Wed, 8 Apr 2026 18:28:55 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu: Ensure .iotlb_sync is called correctly
To: Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org
Cc: jgg@nvidia.com, linux@armlinux.org.uk, iommu@lists.linux.dev,
 linux-tegra@vger.kernel.org
References: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <8982e3412563cf91e106d59228dfb6115024c75e.1775659257.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0393.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::20) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|DS7PR12MB6286:EE_
X-MS-Office365-Filtering-Correlation-Id: 08afbbd1-2a39-45e3-106c-08de959451cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	j8GpT6dsYMV9ZM+tzhxQ48D0pS5FHobsMiKKp8dwM8GU2n4Kuw1b3bjoHmzewhkaHhSCNKJ1xNPBWnzZBOTmN2l5Qh5su3orJ1/lOkAS+n8OODhBRuXSfmPF5mxNeMVs5i0lq2A5BCagmomjnR/lbHapFzkD7LBaZr8Tpk6l93Fd+Oai1vn2TcFEPs35D97vbB6TUDfb5nF9qyZtcld+2B13jTD/FKQblm4aOymRPFXttOksBbWNpS5ljcTI4bjTgtXUskgl7DfWWCed09xq3haZKKnf8QYEwlDPDIJUpIH78wQNqC3K7/HnfUuDFDtLCAhXU0wTjgtk3TgyLIfgDsE5NHdLP7xxwV/arHtBHVRY7YSGLFnc3meUXSbe3Gm4Rxr8Oums1qnLIqrYZcIGUFYjhIWsKZEeQ19p7+EUdv9dIgmtqazx7nsM2WSNb2kmdlumGuPCp5++cmV5cGKGH/jf9KoO54lpC5tkQIylxobaZWM8NixYiOXgmMCWroOcERdjLZBTjpwyzPyrZKnkX5yg51kWDG4yt/36olIeXweJi+B4DYyEpVkfG+ODhS1eQ/3tJkjReNtL62fw+AR/d5mtWXxEKE9txY6Ufl7VXP1lp5KUWggScOV0FjLykzc95/igJhOuskIj9Fds/IHHbpo/d0C/wagkHDtoNtOMDnVDS5Tm59AVO6qj9BgEtqYDnUAGZwjENBcovXpA+0bH9igRNe+pnXNIlnfuj3yRoDQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NE5oR2g5ZkFiL0E1ZldSMGs1czJ0UEpGTDZSVXdxWnZHQTk1bnJYWmZEVlht?=
 =?utf-8?B?K0t4VEhMckE4MnNkbitYMkE0M3NTL0tmRmNZcU13MFZ4ekFpK2lRb21CNmd2?=
 =?utf-8?B?cUx4NXFxTDczMUc3dTlSMUlSdUhnN1JZbWpuTFk5NjVvd2ZmengyWjJGd2Zk?=
 =?utf-8?B?ZUI4VFJSNlQveU9QRkorazNHWkN1U0ZSaURHNGFDNW1lLzZCcSt4ZXFlYnhD?=
 =?utf-8?B?Ty8zZUtUNG15d09oZ0FuTHpNQlJ1YkVXMGtSZnNzRHB4ZUFUcGF5THp5ZmJS?=
 =?utf-8?B?WVd6Nzk3K1JuU1NtOU9DUk1kZzUrTnZIVDQ1eFpCMzY2cmdxZU9FL3l0SkNx?=
 =?utf-8?B?Y3MxTUpyQ3BUZTkyMHZLa1Z5K3dQWllHTXpkajJRSmEvVDJpcERDT2ZqbDZV?=
 =?utf-8?B?TUx3SGZsd0JHaVNwa252QXpoandUdjNzeE5BRm1XUk1McjhZSFZPTVJFbmxh?=
 =?utf-8?B?TWpmd2lvZEhIY2RPOHVJcFpnSUpvcWR2ekVQZFZRSC80ekJpZDlyQ2NOVTNi?=
 =?utf-8?B?WDFVNS9RM1NvbXJmajBYQVBKYjFCc2ROUHhRZXJtSG5IbGNnNVNZbVlKaHVy?=
 =?utf-8?B?NndiL3grVlJWUDNJUmpOcWV5MGFYVDVvbCt3Wi9tbnZMVGFOa0ZHQ1hYaElS?=
 =?utf-8?B?a3B0ODVZMDFVWUt2dVkza0g4bGJCNDRUV2Zvcjl5S05ueER5S1c4aUc1eW16?=
 =?utf-8?B?OVI5T09Ndk1sK1c4anlUNVVKRnpMUHYzYms3cTNXZG5oYU5QbWN4MzhKeGk0?=
 =?utf-8?B?TGtFcDZkYW9GUC9hUWdCbkFIRlprYWkyZmZEZEN2SFYzU0RUaHBCKzhvdytY?=
 =?utf-8?B?QXRSTU1pZG1TYWlmazI4ZzlHMmVnaXZkY1RwZ3g5bzVVMXdiSGJxNHVqNW5o?=
 =?utf-8?B?cXBweTRrN3hCaSt2b1h5aURSUkl3TkU3aXFjaWdFanN6MEcxRE9URFlNSm5p?=
 =?utf-8?B?Y2c4a25SZjdVMGFuOG5tQTdqeGdQTldzVUJ1V0hPTGlHRjJoa3JyRzZQZjFS?=
 =?utf-8?B?OVQ2b28zZmVvOVlYM0h4RHl6Y05NSWxueDZiTHRubTBrUjRFbEcwdHV2WWdR?=
 =?utf-8?B?R0pkOEhEdnNTdmpVZmtCbjNKeno2OWpSTzBjQ3Uwd24rRlJ2VzVmNmZqM2dq?=
 =?utf-8?B?RE5IdVhBY3BBRjVPeXlFaTZsSExMV1RuSlA0NzgyS0lYZkVTbDNpY2FKZTBQ?=
 =?utf-8?B?WEVhd0NTNlpiUGpKR3VOYnRlTys4S1BaZmM5NlFhdVFMcVF1SGJLei83cXVN?=
 =?utf-8?B?TVRPTXpHNU1JTlpQWVVURVhXVEFCT1lqa0JtRC9PR0daUjJYVWZKNmZJUXQv?=
 =?utf-8?B?MG10UzFwaTNVVnJuajlqdDVPQWZoYzhoT3NaeThvRWtBL3BxYWpkTUptSzJw?=
 =?utf-8?B?QVBQQm1XWkhML3JnWC9MUlhXMXVEOENsMWQvNlVIK1drYXR1OHMzcUJZTTNT?=
 =?utf-8?B?M0tSdGxaSEFSUjhHWmh4Ti8rMC9iUk9aNW02VnRlRHRqNUNVNjhWTElJSVFt?=
 =?utf-8?B?clBwU1BzdUJybDdyOFpPZkdVWHY5OTFrc3dOekFIbzcrUDVjaVhTSGhMTFd0?=
 =?utf-8?B?d3pTd0ZUWEg2VkgxQWkxd3dFemZRNktWQ3d4QmFyWFJQcVhyemhCYnJtUG5E?=
 =?utf-8?B?Y1Y4ZHIzUGVKMlo3bFQwR0RBNmthRm1WWU5GTEYrOUp3dVVPVnplN3pHWkFI?=
 =?utf-8?B?NUJoTk9TNFpYU0cxVWR4cjNWaGM1akh6ellJTy9Ebm5mMW1vQzYwQlBKZGJK?=
 =?utf-8?B?OWVtY1FFOXQ5cVpRaGJTSEgvZ3RibmxaMnNTZ0VnbXI3ZitCYTFNVlBZRUxI?=
 =?utf-8?B?SUV6bkNrKzNjdTE2YzJLeDZ4WTBIK001azNUNzFqKzZ6TkJjZEh3VmlzeGhw?=
 =?utf-8?B?R2NsQ2tCTkt3amdwYUVqWGtkSkZRcHJTSE9OVWxQdlhxMEdqaVB5UnJJTmJm?=
 =?utf-8?B?WFVJK09VUjUwMmgwK3VJdkVETWVHVkg3d0krSUpBbTQwMWhPQ1NvKzloWWVJ?=
 =?utf-8?B?NDV6akgvbFgvRDJGMHhxN2p1NWpyTXRjSnF5aEhRYWRienVRbnc2T0pDdjNG?=
 =?utf-8?B?SUUrTTlkTHNKUlFpNW85dlNDWVV6TEFoYk56ejl3NEgwSWNlU2tibUdNcThQ?=
 =?utf-8?B?N1lnSGlta2ZlTmRvek5OU09ndmJBMnRYOWlwYjYxekw3ZVk3QzMrNTg4bDZk?=
 =?utf-8?B?dUFzMHRyZWNlWlhwQjlRSDZiQXlEUGw1WWs1dTRkY3diVkE5eSs3K25rSEdi?=
 =?utf-8?B?b1pRSk9TS0Y5OEQySS83VlRKREhkK1laZnFQK3pPTUxXdm8rNk9tcGJPejg3?=
 =?utf-8?B?QUo1c3RTelVyZUxJMGowZE8rS3JwMGxFNWN4UjVrbVRXUE5jRktUVU5FVWhI?=
 =?utf-8?Q?ONjuPT+FX6Y9X+ux1N8rSHEHbLHBJv5RAH/cJCzpjm2gp?=
X-MS-Exchange-AntiSpam-MessageData-1: 7+y4o2RYAfEmPQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08afbbd1-2a39-45e3-106c-08de959451cd
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 17:28:59.5308
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ATMmZ9svIqwj1scbsuQzM5KSkR+nlHG8ChPpfS9CR7JZRUhPYDd9g7haSBhxsFEMvG437k72VE4j85l7Utp2Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6286


On 08/04/2026 15:40, Robin Murphy wrote:
> Many drivers have no reason to use the iotlb_gather mechanism, but do
> still depend on .iotlb_sync being called to properly complete an unmap.
> Since the core code is now relying on the gather to detect when there
> is legitimately something to sync, it should also take care of encoding
> a successful unmap when the driver does not touch the gather itself.
> 
> Fixes: 90c5def10bea ("iommu: Do not call drivers for empty gathers")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Closes: https://lore.kernel.org/r/8800a38b-8515-4bbe-af15-0dae81274bf7@nvidia.com
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>   drivers/iommu/iommu.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 50718ab810a4..ee83850c7060 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2717,6 +2717,12 @@ static size_t __iommu_unmap(struct iommu_domain *domain,
>   
>   		pr_debug("unmapped: iova 0x%lx size 0x%zx\n",
>   			 iova, unmapped_page);
> +		/*
> +		 * If the driver itself isn't using the gather, make sure
> +		 * it looks non-empty so iotlb_sync will still be called.
> +		 */
> +		if (iotlb_gather->start >= iotlb_gather->end)
> +			iommu_iotlb_gather_add_range(iotlb_gather, iova, size);
>   
>   		iova += unmapped_page;
>   		unmapped += unmapped_page;


Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic

