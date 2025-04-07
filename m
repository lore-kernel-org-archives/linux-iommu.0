Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BE0218AC7
	for <iommu@lists.linux.dev>; Mon,  7 Apr 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744047854; cv=fail; b=jn7noZvG4ccgOdy8dwuBKH5P7BLCIczYeGN+jZdaj5Dgj1bCiZzUf67JwZCvM9w9beeQXoNee2qPkmmXQdfh6QYn/I6EWSGGGZEudfjmml/Z7IsBn6vJmkF5gtphMfsMbEgAkXOl5r7ufspC38Vgt34qsmNBvmw5eRQX4cfEyv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744047854; c=relaxed/simple;
	bh=t5Dao8mwrKqFxDJRi0cGmCKHC0gMlp5JMzOAkM5Lslg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MhhSyQTa0wmdWD6vQKn3FUNBoPxHW7Xkxjtp0bQ5uJdXLAUc5e0ZeyII3jG48x+E809cOo9ld6VZASr23Wlxi+X+PTZZKO9mfI5Len/tvTjbzt179La1LraIZXis7KtZWv8zficCLBo2ZKesK621nKz+f94dE3snDp1JwbmgWdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=euTPXPjA; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="euTPXPjA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYlpwm0R+tL5qpgK6FU6J6X/1U9uMOc+Uua9wpWYIUCn+B5ohtUXhsKiP9W9naEK7pdww/veMp9O/ZrJRxPXUW/+vPHohy62cTDyHnlKvzYP2QsTSt5VhriGD3UdobbTIxBvwHBI7XyrAjpaUPYaC8mlLEZv+u5bJti0i8/rgeBlYneaZLC3TelVaEAJkeDt2VPXOi/UOYTvGlpdJmjet2bhUA/qLS956+y4Dvqwi1vaAwUtp5lWJmVkhXOxdNThv68AK10sENJJqDsRVhTtCybljq+UH1OEgWHomx0bF5MeJn+Ay1ttbQ08hj2Kuql3CKAlBhEEmf6c87C7MM0v8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T/P+DNyUqlYiOpkfEzwFvnt1sxLUEnr5tsyDuM9CEvg=;
 b=Iyd1jTVhyKnmGlKx+gdYAQVy+BmPZqgKbddTj1Xhj8mYhzwklNevAgOOH2TvTnbh/uvu6Z01mLJ6e5jMZCfbD/OQ7ScObw5GHDpsZ47oYda8zvUM9ko57ZfAFiXt+y9GhJUlsuLnZwCjyiiw4RY1CM9ZucAoz5mA5ifS/Z9FgFQmkxe/IoZ1VUOY0k+qFZ7AOYtZf07eO5reMvFy0KGMJpqhStLwAqaoLGaeo+BxJKFy0dztsY+kdyQua4hShad6shqFwYIH90VfdzDVOV+nkqDDDQRWIoF5oCFrQhVnZKzXIg2yHTnR+FfnRiNHRxjiyaDxjX6s9Mzqt5Dr237pJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T/P+DNyUqlYiOpkfEzwFvnt1sxLUEnr5tsyDuM9CEvg=;
 b=euTPXPjAj4piiXVVLI1YGKXGovqlMxMTeATTCt+Eb0nuC034/uqafyZSKW4+Eyv0KTBDLEJUjBzcfOIfkTEoxJPr4+rWKZUYm5iIDPmGG435SoWk93s/nFaH1H69r1jrosTyTUj0ONd3bltXc4ZKmjPZNvJq+nmEJXvIS+s7q2qaAENWk4yhTin4JvS4lI1gf8WyHDGGt0bo2YMD3wqZLgTW7v6kNuUZcq/Zns65nRSKxIqONCu6iq7bfD0PLWvq5rwPLBga1LzNq0pmaCFxyFcfvHF+7x1ULP+C5vQN9t/l5WG0sbiVibad9bJomzlDV/7oDae5SJK1ENcFvw5usg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by DS0PR12MB8453.namprd12.prod.outlook.com (2603:10b6:8:157::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Mon, 7 Apr
 2025 17:44:10 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8606.028; Mon, 7 Apr 2025
 17:44:09 +0000
Date: Mon, 7 Apr 2025 14:44:08 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, thierry.reding@gmail.com, vdumpa@nvidia.com,
	robin.murphy@arm.com, joro@8bytes.org, jonathanh@nvidia.com,
	linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc 1/2] iommu/tegra241-cmdqv: Fix warnings due to
 dmam_free_coherent()
Message-ID: <20250407174408.GB1722458@nvidia.com>
References: <cover.1744014481.git.nicolinc@nvidia.com>
 <a92f259bc18f8a5acdc067770b485ea71767100e.1744014481.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a92f259bc18f8a5acdc067770b485ea71767100e.1744014481.git.nicolinc@nvidia.com>
X-ClientProxiedBy: BN9PR03CA0317.namprd03.prod.outlook.com
 (2603:10b6:408:112::22) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|DS0PR12MB8453:EE_
X-MS-Office365-Filtering-Correlation-Id: 364e28bd-2b7e-4610-50a3-08dd75fbcd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e5c6jjvG53aO2RUmIzmySb2NSZ6IPls/mJ/S+bIDZTjCUOBhoMNNjbqYqaZM?=
 =?us-ascii?Q?Pj0Z5QAEulux6ZyiJycFHmzj4FFtyvlaA1P/bJfNjcgu7WdnxN/GInpqf+Ir?=
 =?us-ascii?Q?65dgkp3AGFgC7tH6yaaqjPMLsfG4m+38keNOCGO6eUaDBvQtYOyLeWCuEc8/?=
 =?us-ascii?Q?9QSB3J7Z7KmGBfq0K+7NXohoKluKvjfLJ60w1y8lMoS3uPanHFrB3xTBHBeB?=
 =?us-ascii?Q?lxN89Zs+OohareZn14dhuHrOwiTEqJb/CVdEMJi431gXma8Nbn6yw4D7Kz9N?=
 =?us-ascii?Q?PKDSlSCBCvgp2VtEj0N/+OTQXN+GreBN31WifNUV5MtKX45FTKUXbSAxyudO?=
 =?us-ascii?Q?SV5KMutsEPmUiFpZppKfsyEiwoGC/UbqR4tczG492Ku225ytUW/NfBXAhG+6?=
 =?us-ascii?Q?yEAcdFX53Q+ncMi9kbViPCqrdVSeRfXxmnxs7eyHT4JVLETK4+aOgUn+OUlV?=
 =?us-ascii?Q?97iXK5poBN+ZHY84igUwP6INHXN4Wfz/QG4Bcm3Fs4NxIDbsgANlH5LFILFg?=
 =?us-ascii?Q?ziImtz/DuOJSwvY44k19HLP+fELSKzO67WoYMFgnqmqCZWd2ouryp+fRjTPQ?=
 =?us-ascii?Q?3d4CiZuhmYv+O8XIkmK3DFJ5+d0pCjzFbkjtEFvZFgo4025CN0t7N2fBIH8v?=
 =?us-ascii?Q?lmAjbWrSRCfVHRLbZtw/nvbDvdC6Nn2vqrCSUsK17mh8nV78lpRY6CnQ09pY?=
 =?us-ascii?Q?zklplRGmYMe7Tg0lp0lvBdeavm+9ot/KioYsPYFlAY3oJApRp9TXZrnj4oMQ?=
 =?us-ascii?Q?09Y0Q57p5O/lAo4nYWG1eP/F0MMnt2oQO1TbtizkJiM1odcIlYiCJra+Bvwy?=
 =?us-ascii?Q?hx2UUUWawwbq2nh/r1ZiDK/xP6Fi05ThLft2EjL3C8AnSAb6wQPHeqX4SMtM?=
 =?us-ascii?Q?QO06jFaBU1wOSocf2ZYxBx0UFZxzqDEpDFYeaxkvg1q5R7LLAuKtQtSJLaSb?=
 =?us-ascii?Q?TIWm0EtobHII5GJynouW7uTMTZO7nAEp4xp1J3/vlLsvcrK346+cNNshe/En?=
 =?us-ascii?Q?edinpTnjQffKbagivJB+igkJWIyelC1NxkBZ0j42d4IPy6DpgtLX9OVCT2r7?=
 =?us-ascii?Q?c3KngBOcAqpjN2PKlfJVbr6+eglNUk8poUW/4mYpSkvC23a75n6tLcQ8kvyt?=
 =?us-ascii?Q?m0lXddYKJUnbAavlbIShXmlYnj0u6JiD0wMxcCWUHy+gKNbwsdiEtciyk7Ik?=
 =?us-ascii?Q?zmPSSmYYOg+o8ygZfg945eHHf5slQTEqBcHdf1s57NLGx17xBTOz3WFuxOTq?=
 =?us-ascii?Q?Qg5Gsf5iGs1hvOWp3d7hjHmaNCUrw7GuGeAOcPZPuR+vNjDM+mFxQgbSY3Vo?=
 =?us-ascii?Q?m+ouZ0BSwgRvpXO+e1t8pIUSFIExM2wqTaJEiG8R5wIwYP8ZvqFJL1WKgpaO?=
 =?us-ascii?Q?dcOMFpQjLx3ecstTeI+rG3htQDt4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RZTCK3UhErQlLUmtePYUXAJug+Ebe84iaLPwHbs7V9CmEWgwzETP0s4nLMgT?=
 =?us-ascii?Q?Ih9OvZdgCVF92BO7Mzzuh0C4pPZpjFMBdUEsMIlVAgVn3PQLxmrAcdqRxKr1?=
 =?us-ascii?Q?ET+Uo0BmQbF7xbPnNE3yBRMJ5yL9uSLTdzzSJAR+AdhNcPWlATUvXsaP0U2A?=
 =?us-ascii?Q?dJJDCaGODl/cCB2lDstN1ZIFgtEmmHP577VqHTulLI/YJiT3tHoFDspHrE9m?=
 =?us-ascii?Q?1ttYRvnqsgxUcvNe0Fj+zQJGUdwOP/Jz+leTxp78L3jLVPBjXaVF+uZ9RncS?=
 =?us-ascii?Q?or89GhkYEW4XyA3wNm//0BESRUbxoXKaSF7oEK1N9WdUcyPgyUfWgCr+v2gp?=
 =?us-ascii?Q?of64n+s28TIaWD+FOjw61kpRXGnSOT7TllGOxSpYwyO88o+zTFd4m6NqCmlZ?=
 =?us-ascii?Q?6uRev2SOu5WGOwiB3sReDM07CgfmxQyscGSBcTn5vExjVyI4A5wkJgPRPQdO?=
 =?us-ascii?Q?DQ5X64i0CbfeDfRoo9JkabxZnu9iDI67EBD6rXlEKikNe1bYDbEJN4XCvMdB?=
 =?us-ascii?Q?8xq8g6l8usJr4Yl/lWDeY4EC2vmunGJ9sGJNrQxN4JgG7uKTzhiRmDnw3xFK?=
 =?us-ascii?Q?IhCkR7StljvapFdQU87EIqp3TeBhAKbhdjtZtS3fZcQS3TfNy+wiqypyvRMV?=
 =?us-ascii?Q?SEAdX0GVR/agdi05MwcxFjm3Jl+nkYccg9UzNuYOp0N4UD6IkQtA/bqrVQjq?=
 =?us-ascii?Q?ovdtuuK4vrbnVG6fXjwcolDQlA0LTZXgWfOXctFfcuwESPAZjOyq92uMvTgD?=
 =?us-ascii?Q?Pjn8hivyAb4yPXbD/Xem1F+lD18uNsd41/BncivTBn3WA82CWzdCb+NiVrl/?=
 =?us-ascii?Q?XYbwArP5rPrCNOkOkwJOm/T6LmgmtujhwkksBDLzE4W/e7Gngrl6ROMl2ngO?=
 =?us-ascii?Q?Km0vBvB6eR0JLdtPmNQl02FiJSztcu/ud/iphq/vhE2Fgpx3CWwHu6I9CsWa?=
 =?us-ascii?Q?m6tOz1pvpulBMErEy5EKRYabZnRb8jetGgAkC04GsUEcv4C62vCI6KfTZrQ+?=
 =?us-ascii?Q?HAOKQhks3H+qz0VnpjJlHc92YRD0psxp4Hd/HYQV67C7ffO5Yi1llocKqQPg?=
 =?us-ascii?Q?sDmrhfOYE9Ds27LqQ3WnhJS8bWM+wGoiYKuWlYEfxVS+GV7W+pJGVcavytcY?=
 =?us-ascii?Q?n/Wp3fIpmxaw9CU3sVC2mxgl0SwA2/1iXziNz7mqkPWGEhNIU/apqrRMgkiy?=
 =?us-ascii?Q?PXBDVNVxx+bXQBRci6c4uFJGq7bZggfeWi7Lloqml21Ql2WdA1SoIVQyoBIZ?=
 =?us-ascii?Q?p1VnKHpyDsTUPzTkP3qJdk9gzFlOBik/DiIfupieP+19BewIWp/4oNglL/Rm?=
 =?us-ascii?Q?GaQ/4wFLqvaxUo/GQhItUlaziFHfGvzpxRjFkxudP9wbF4LtW5yL5Q37QsaX?=
 =?us-ascii?Q?1SJrDDJ099twPySsvLUI5tk/ubHaYmXsOrRg1P12anLjNhQ+ddpX/hX/eFx6?=
 =?us-ascii?Q?+eTuGOpM/BCUpFJBg3/kIoFtTDeXT9KJjKpY7XY+36hcP9cwI8QTuy+bHi4e?=
 =?us-ascii?Q?lfE89GbbuoI4Qr4SD9jiEASern12wufs+sWfAW45uMN0POT53yY4lrNExx51?=
 =?us-ascii?Q?m7SdXIs9ORsn+bOgFiqMY9j/uuRTo3nWrItVBwM2?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 364e28bd-2b7e-4610-50a3-08dd75fbcd35
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 17:44:09.8216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XJUjmfovRyV+9QqrZb2tNsWikjXJljook88Oz22EJukkUvCCYUfGah4G0WK6ZX1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8453

On Mon, Apr 07, 2025 at 01:34:59AM -0700, Nicolin Chen wrote:
> Two WARNINGs are observed when SMMU driver rolls back upon failure:
>  arm-smmu-v3.9.auto: Failed to register iommu
>  arm-smmu-v3.9.auto: probe with driver arm-smmu-v3 failed with error -22
>  ------------[ cut here ]------------
>  WARNING: CPU: 5 PID: 1 at kernel/dma/mapping.c:74 dmam_free_coherent+0xc0/0xd8
>  Call trace:
>   dmam_free_coherent+0xc0/0xd8 (P)
>   tegra241_vintf_free_lvcmdq+0x74/0x188
>   tegra241_cmdqv_remove_vintf+0x60/0x148
>   tegra241_cmdqv_remove+0x48/0xc8
>   arm_smmu_impl_remove+0x28/0x60
>   devm_action_release+0x1c/0x40
>  ------------[ cut here ]------------
>  128 pages are still in use!
>  WARNING: CPU: 16 PID: 1 at mm/page_alloc.c:6902 free_contig_range+0x18c/0x1c8
>  Call trace:
>   free_contig_range+0x18c/0x1c8 (P)
>   cma_release+0x154/0x2f0
>   dma_free_contiguous+0x38/0xa0
>   dma_direct_free+0x10c/0x248
>   dma_free_attrs+0x100/0x290
>   dmam_free_coherent+0x78/0xd8
>   tegra241_vintf_free_lvcmdq+0x74/0x160
>   tegra241_cmdqv_remove+0x98/0x198
>   arm_smmu_impl_remove+0x28/0x60
>   devm_action_release+0x1c/0x40
> 
> For the first warning: when the main SMMU driver cleans up its resources,
> any routine in arm_smmu_impl_remove() should not use any devres function.

Bleck. This is situations where you should not be using devres at all.

It is not that arm_smmu_impl_remove() should not use devres, the
problem is that arm_smmu_impl_probe() has mis-ordered the devres
callbacks if ops->device_remove() is going to be manually freeing
things that probe allocated.

IMHO you should just put the goto unwind back into arm_smmu_device()
probe and not use devm for ops->device_remove(). That will put things
in their proper order and no problem.

Because changing arm_smmu_init_one_queue to avoid devm looks worse..

> -static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx)
> +static void tegra241_vintf_free_lvcmdq(struct tegra241_vintf *vintf, u16 lidx,
> +				       bool removing_smmu)
>  {

And this is kind of ugly

Jason
