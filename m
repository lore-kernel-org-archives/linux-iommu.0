Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D911CD23
	for <iommu@lists.linux.dev>; Sat,  1 Jun 2024 21:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717276026; cv=fail; b=IwKEIKMGeKn8y0RFt4y0GxJxmULHUhsDp3KegY5bMAD3D5C+EkDmVrEqzHuOdKmacW/k3kH7+wuJ0+LTvE2YVE19ybEPx52CUmA6zI/sNYwMv4sNgXRHyhftuVxk5FqUX5KDftBvXjNJ3JtYxTL9iy8XMtCxZaJBj6okqeOljlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717276026; c=relaxed/simple;
	bh=0nuqVNwx/GTcLZ814dhWIIgHM7jWap1n0+XHE8GhIrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TtJ+vhezcun461LLKK2QKGpqqpPv3lCTXcVzM/c11V/oXeMihL3fpD5GqjADcNS1TTfbDqxZMpAd0WEatXoHQBKhbu5BlfdfX43pRH4zKJuYFHXey+OR+XIU2lIP4cEWNu7c2EAzie0NPhZFnvmcwae1aKVhYzuBrbqCD35egi0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qsTTSCyD; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qsTTSCyD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOnrKHS00BFle0CPtNSUlEoePy1ND3OXrwJcbppIlH13hL12yqref2DZgrtzNjzcpjmPmLX7Vf9KDmTmcnk84tzYYEZaeZoUMutYyW2Id/m4pWK/j1m6J8UP9m8Fc+KWNGFM/XdwC/EkuNjDxhCvLJ5cpCZn4m6kYVEnLm+V3lJr7+C2XJ/QOHnqXwu0SH8ufp69q/XSf+AElwQgrH10j71LynyRXdnNc0u1htq/8adPvtptHEu+uLB2MmyUpe7qE3iVn/sCiriDsDIUy++eT8QwKOWZxnO8oFeRzP88al2JCh7RFiYv0HVTzZVCEPwTqVaW2ty95ZJT5C5ERzNQ2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WHD2IvTjJ/QbEv/AFAZRKFFVrRN7chPqnVfHDbGIQKY=;
 b=iFSnvU9oZPISyiCiKT8MrDvuP9J8tcXPAS1JsdMiwkhrEQ4psfXr9DvwStumPfd/tN0H3h7myQ/pRmlS5aFHADX/cB/OYytgASW0lfD21qle3pxbCDjig1YLv8XGgOIdxvKP78sZFghotzGyYi8u35IXAlo4YhM3d0msAmVCUlhptR2OTiitIr+VabgWM2NOhmGkZNNf8mkDhrpbClnEqgKVI+oiDsBJEiNxl2wUrSm7NfaEyriqJ8S2TrESZ5wtACJ6zZn6myZ+1qqVCfvn9T8WIqdm3i0jHCGiAQ+wrL78TEhXSX3xmZPACL0laF0F4De7OP+fYUzj1/zIpH6HEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WHD2IvTjJ/QbEv/AFAZRKFFVrRN7chPqnVfHDbGIQKY=;
 b=qsTTSCyDGfzDFnqTqR5/aTN04lKvkOqbUNGxAU5H37vvtbbU0y9mNAth/1j9zTTuLJ+yCQnf2KhN52SHIYAjklMZv3LdrPPb2Y/BUSNEI0vH5R9YldI2WnjKG8PEVa7QIN8ohOBd1Lki7plA4vfhrnoX2+R8avE4SQFcR9vEgSDYTWyOoB/oL+jWfqHJpgG1DD7JM6OFWF/ZUnzHo0GaICD+FvYbV8DwtuN4CAld2Kw4RLXq8z8bPH4tAPBFkwYdjHKp0vgD3HeP4UgleBSuDwHQfUQLq1zJVCQs6MvzODkupsCVTsBrexFxcCFIKQJ9w5tfnN2dXG9+13Aq03At0A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Sat, 1 Jun
 2024 21:07:01 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 21:07:01 +0000
Date: Sat, 1 Jun 2024 18:06:55 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v4 2/7] iommu/arm-smmu-v3: Factor out a common
 arm_smmu_domain_alloc()
Message-ID: <ZluNbvTNlABEz0QT@nvidia.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
 <20240528071831.17560-3-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528071831.17560-3-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: BYAPR01CA0035.prod.exchangelabs.com (2603:10b6:a02:80::48)
 To DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: da801949-fdc6-4c0c-4696-08dc827ec83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F7IjMR/gmiBb3d5facradFS/VoPMNHvegNL4dn+2CmW7P34yn7KRpk3iN5/8?=
 =?us-ascii?Q?BX8CAKz3ICTcrfW0XfHnhsnvT/1okf8DL5+WSwHVjbvO+IdqF+1TNlCmnI2+?=
 =?us-ascii?Q?OMIDH9tdjpG7rC74XRdIojjDzWgZL+lnceKnmV6IeosDYe5MZ2lZd52w/OEM?=
 =?us-ascii?Q?HDlsbjvhPO8/4EPZJnXp5b+xB3RR0Ek282WplItnql5qzG/HDZSXQ7n3XLey?=
 =?us-ascii?Q?5RxC+7NnGPuaLGLeRhrwfUNmxg8A6dWma9TTBQzQ1cQLRawdWsfj9Rk/sMsT?=
 =?us-ascii?Q?G9LGSw8pF8HG0NR7mxSEHhhPLxwYSSsndI8ZukItldKl0vRTxtzzGAEhQgJ5?=
 =?us-ascii?Q?XQ1DReU+wlmw/CcNFXYktvtxM5TXLcehmDu7D3u6vvmyop18CyF9A/ze3ZV9?=
 =?us-ascii?Q?Y/n7+OGZILuodKCPalk1J5smMkLVAUgZZF0o0k+jPpuUVO4Cq9Rn4S17cgZM?=
 =?us-ascii?Q?qJDo2aA23g8PsTceGqga7EfH9ltiP1HemqV1J6lkzb/hRlOZd903r09IPDOM?=
 =?us-ascii?Q?vRVrZh3o8ODFtEaQR0aFLZ+RsaXJxTO42BH3xmS73W8T/MNzI2GQUmjbYY7D?=
 =?us-ascii?Q?vwOgy/AgdQ1X8VegfNKDVOKjBef7BNu2CY7logXjGiK9Lu+m6DKcCcHwP8fi?=
 =?us-ascii?Q?bqA+kiLbUmDwCBgK7tgwVm0VMYW0LoYNwgDGXqeMFJk2qm6gUV2M2xwkIJsk?=
 =?us-ascii?Q?JiYSmuEjkQTXBhdUyPv2sbVKrOMprt5E8ppPDHmxYHInd4noDaS6bS6qkKSO?=
 =?us-ascii?Q?sxe7Z97Iah1RmgTN2fV15Hd2+vhYTlBDRJCgfk9hzyDL3bo6wl0+/Cdpa6KL?=
 =?us-ascii?Q?W4oNfMkcPs7Yz1d0cpX7isWJHjP9UQK6qQjkvGxsauCtRxIQCaKglbe64FId?=
 =?us-ascii?Q?3FqJKGL0dX3FjtWYIsn4wJfxSctryxczhCFGzRrnqioYEM4tlyXk40Q2FK5z?=
 =?us-ascii?Q?YTP6qaWBQIuuDE5R9uxrxGVe1yFCDvJ6Oq2n1gop7+Y/nOblbI6d9kZUhMXw?=
 =?us-ascii?Q?eHYtJMQqqVk9SPSCesTRZcdhhdW0NeLJB8CVkDDacV+zbVvC3T7T/X4l+HPf?=
 =?us-ascii?Q?IHgAXD15kLa7wd4eBzVmqK4FGHScnO+m3EuySLLZ+xaA/rFsirM3BOopKIjB?=
 =?us-ascii?Q?qaIoc4Iwu1vE3lnh0kBUaT7P3uXqIk4DmY51xGSK7RJA/covnaOTD+ezMfxy?=
 =?us-ascii?Q?tPGfq0HgsVamI2BteQu9qU1vfJcU+EycCmpvDQPbi9SqsShU3r7td9zgi7Xv?=
 =?us-ascii?Q?41P97fB6X+OERwlgLny02gDd5w2Lb6P0cbs7t0haEw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1zrKfwY1vPY02U13mTd3ln1eJHBpngK8Ei1L4rgiilcbxRF0gNLmuSbXazfo?=
 =?us-ascii?Q?G8Yh6T9CUnsUUehFbz+EyFsd3E901n4603uSDsiQBN5l5TiulVtKIJ9KKUN8?=
 =?us-ascii?Q?xmxBtDt37QHf6maREKYiBrSxKxlVMv5bv02NN3/SJEyWvU3m6G/REfxWHw+G?=
 =?us-ascii?Q?71HRL+f8x4zZi1EXEtz9v9q5rJfCc2zmzMmEAlgDPosZ8oWq4uyK35DRRd2B?=
 =?us-ascii?Q?QbeVwsT/cuD9k7vFJFxswPfSsgsMq2WZuyCznPNd2NjIVp9mwMqcKBPk9t1o?=
 =?us-ascii?Q?jctsTbJCMQp3DOKI0qUTRTHi+ObzUHjJg8sgp/KCB//8poUYHabM1t7Zt0tF?=
 =?us-ascii?Q?eLITr0VVS0k88RpJ15DpHVYIq75FdHrn88sQUA4CE1+zHwCTZ0A8ZLi2mTIQ?=
 =?us-ascii?Q?noushzSQyHhsjq5rFiHw9ioNeQAillq+TTXVMEwI8SFpuuHsOXJICtL9UGVK?=
 =?us-ascii?Q?XxUf1cuqxSNve21vUwCta2WEnZF47r+9wAu41rmQWOxuWGTK+buZ/IgPC6pm?=
 =?us-ascii?Q?1B++8T/ESiPDAPVvRmdt3SLiCiMk8fQYVX+PxVLU5KO5z7FdyO25xdN6fTwq?=
 =?us-ascii?Q?8votiKB7datlDP3gqwtL1c3Fr+YFNNGy3OA3C2BNr36sgTkNk519GN6uj5SG?=
 =?us-ascii?Q?NaM5qpwaLT9jkdt8TlRo/0cPU04g+7cc7lYQtNEGhdH3oyQ3jAqP4vnZl+Bt?=
 =?us-ascii?Q?WDPNbJ9V0Dj+roBVrhdZ4utHBz6r75WeffVLZ4sxqmbdQZm+td+7DgENr35f?=
 =?us-ascii?Q?MY/RhmM0gorHwICebcl5oqgwCtVPiU1QxfER3v9lM2uYEqHG/UH7P8Kgev3q?=
 =?us-ascii?Q?cWze13BgRA0xKG2pYvAD3sbqKFPKIIBWj3qf9BcffHVwysrgXOqMaI03piFl?=
 =?us-ascii?Q?oihC8KWNZBdOGFE0ReQ6ebMf1LtFRtx8rGqpFZW1gIehfwKU/IU9YiLdfLXZ?=
 =?us-ascii?Q?FnJ2l3aMglZm5uDcntXFZWzL3T8WGGT2CuIcnMo/akF6BIWSU4IufcNKJeUI?=
 =?us-ascii?Q?YXkUdPEBtb5ofLSd0HGVsc0jBL9YCgvan1i5u5bs3Jpn6WvXTGMAGZyf9f0u?=
 =?us-ascii?Q?O8iSY8OJRVANfP7HlyMWBLB9d9ainJAOt+pobirqKtISfPJp4b+AcXtm1/If?=
 =?us-ascii?Q?JUSGEHUIsebE1F8SUNdEYvj1NqiRA3PLPVr/MUNPdyg4dN9KxufCDymTzfxO?=
 =?us-ascii?Q?sHX8O4BQUj1qQr+rLkMvUwtBH9i934U70OdsnkFeE3OOTtNuwgfPR3KWuXkm?=
 =?us-ascii?Q?lRMkFGb7gaLs11Psmcw/NfeH+FnBdTz2wIggPit3QcNw3q6uMoNotH8PKt+O?=
 =?us-ascii?Q?e83LqYmhRrNQoq0s7W2+GbWYf+gop5PJA9h35wSJJLGV15A+WyHunxHpZLPi?=
 =?us-ascii?Q?4REtBYZYcSvGJNWcl3BUmXduSV8fV1+YSrk+sejVAf11jjTx44i6qpcXrmQz?=
 =?us-ascii?Q?TDzUkuxmF9juaX8DGjHaNVbcvy9yGXncgzzRySHJMebqVavhuyqEbBuhy7X6?=
 =?us-ascii?Q?0pVhvUA9C/oJ9ffkianvxZVb3CNn422PkQ5qoT4x4ch031kAeENfpxSt68bT?=
 =?us-ascii?Q?n3uLDrbHLunjRn7fkh8l+4INwW60IXUsfngtxoJm?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da801949-fdc6-4c0c-4696-08dc827ec83c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 21:07:01.8046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r6uzU7QRcFDrhcFqBv3JvLLpJ2H+9fl7qnWl4XfDwr6Nf4OiapijtIRV72qxFO2p
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804

On Tue, May 28, 2024 at 08:18:26AM +0100, Shameer Kolothum wrote:

> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c
> @@ -648,7 +648,7 @@ static int arm_smmu_sva_set_dev_pasid(struct iommu_domain *domain,
>  
>  static void arm_smmu_sva_domain_free(struct iommu_domain *domain)
>  {
> -	kfree(domain);
> +	kfree(to_smmu_domain(domain));
>  }

  
> @@ -659,13 +659,16 @@ static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
>  struct iommu_domain *arm_smmu_sva_domain_alloc(struct device *dev,
>  					       struct mm_struct *mm)
>  {
> -	struct iommu_domain *domain;
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_device *smmu = master->smmu;
> +	struct arm_smmu_domain *smmu_domain;
>  
> -	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
> -	if (!domain)
> -		return ERR_PTR(-ENOMEM);
> -	domain->type = IOMMU_DOMAIN_SVA;
> -	domain->ops = &arm_smmu_sva_domain_ops;
> +	smmu_domain = arm_smmu_domain_alloc();
> +	if (IS_ERR(smmu_domain))
> +		return ERR_CAST(smmu_domain);
> +	smmu_domain->domain.type = IOMMU_DOMAIN_SVA;
> +	smmu_domain->domain.ops = &arm_smmu_sva_domain_ops;
> +	smmu_domain->smmu = smmu;
>  
> -	return domain;
> +	return &smmu_domain->domain;
>  }

If you drop these two hunks you can drop the first patch as well. There
is no need to touch SVA in this series

Jason
