Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6C1346E66
	for <iommu@lists.linux.dev>; Tue,  7 Jul 2026 14:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783433262; cv=fail; b=B2gTvoKbtdKQM30LVMcNqKB2Xni9oaIoZGF9eWsC2NvelYy5gGwsB52YK5pwgllUvXaWq5sAN4Gg+Hwby7lUeAVKPytWC7YJtolcmJTEEUjTITT/arA0/yiOZWUoqX9xKygUtoLDoiUuVe/KrQVVFdQCWudby4ng4A4TqeP+b38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783433262; c=relaxed/simple;
	bh=rOgYyUPNfUoIKzMSf5RCXlsne9P6Qdog+Q7Ylf/D0pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iOKymWnZGvovTStDldSt8HXw5JHcPfKBC6LhQWBil96TXpg7YMJNcNl2owO002xOemv1necqt3foZgIJTK/cCXeGc2BeKcqdoO9G+PRRYUqxBW52kOofzg4n+JPTmN9Ea+41GoRNQ1ZYe1WOV4cc8mD5BHaoyFu8JBPcupToIYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Y/x3rsge; arc=fail smtp.client-ip=52.101.57.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Y/x3rsge"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MoBozPlL0x+l4cjm6dYDBi1D0sPIQUbUHq4oImzoO3sWsFa3DGI/MQ0JcN+YiIE/mASQCV29Ke0bZrzVOiUPeSmICVa6cAEHMP/tDAksJxkVqREi+bDbQDNVeQCqeyvsbQvck/c2bD45EGDfhaV7h6fxqlHSKxFTVIt7ie0dxrG+7u4hCgNt56Yd7cOrQAOgI1lsmPE/NZz9Gd2lhN82gJeTqLLeaFZJcfKNhjckPQVymayAgL40KAsfUhsyICoSbAzbNkvNZOWzuU/h5PtjO62iRWdvq6w4J3b8g0pg88lSxExAkrNw+f1WmLY0tfkSJS4RF4HgbTcUv58scEECoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lm4wieuGJZED8BkhaEYkXgLN7EKNza5L9Pn2FOhGkV8=;
 b=W8R0xKiEXhX/H4TYVlNBw99lxSlYv0UHEgxAhfTxAo7gJ6foRdmODbTg7D3Q/51CZ0pPAfq7Zrxs3yQPr+vY0aFWSjOO4Dk4cRzPnOFHjZMJA7YS8MSYXrIeYOnGoGFHHgA5BcbReDopgXFQ/6m34DXF2Ua7xFa8+m+zH8WDkeXjvGDuVyOfxnw194/VL4Ec1DMU2z+VYh3iTCIj9Novb4HEPC1mbpMc6uzO89vWvgsoP3scz7NFkPP+JqTXoIRQNkroRILH2OVXW5Ua8HsI476zE4gj7+EZMPXJ/jdFPvXw6J/6iAoadi2oN6POlK/GcebAFKfBPw2bed/Z4iBOlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lm4wieuGJZED8BkhaEYkXgLN7EKNza5L9Pn2FOhGkV8=;
 b=Y/x3rsgeHuZ0Rp9964zwGp830VmUIx/9LZvwOlY5M+oG4Lm5x9WBnZIppiWYUSpouijy8itHGU/Ilcwj75CH2n9WN1HBBfNBa1zEdZC+b4DXRAo5jn0SvLYoDBWbs3y1vMkT627R8jsnsz5VSYHXxZSAYadYsqo8/TlynIP9PxPL2GfnlssqrWjFMlMoLsSoxTtvWqL3xVj78HlC0mXXBnzholhThxkIivl4HE1tX3Jd3278b1nz1GYt2373gUba16uEG4+bOLqKwyjTLkWRe3Q/ItfijvRyEF+GmzUa5FJatAUU8Zvf7lSqRZgEi9n6f/oQv251k0HpY2W309gKIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4373.namprd12.prod.outlook.com (2603:10b6:208:261::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 14:07:36 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 14:07:36 +0000
Date: Tue, 7 Jul 2026 11:07:34 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
	sairaj.arunkodilkar@amd.com, jay.chen@amd.com, wvw@google.com,
	wnliu@google.com, dantuluris@google.com, chriscli@google.com,
	kpsingh@google.com
Subject: Re: [PATCH v3 09/22] iommu/amd: Introduce and map vIOMMU private IPA
 region
Message-ID: <20260707140734.GA220801@nvidia.com>
References: <20260629153535.15775-1-suravee.suthikulpanit@amd.com>
 <20260629153535.15775-10-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260629153535.15775-10-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: BL1P223CA0043.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:208:5b6::9) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4373:EE_
X-MS-Office365-Filtering-Correlation-Id: b747d724-f513-4bd1-c9b8-08dedc311897
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|7416014|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	3Ilx6PYYP8Pmn+aNpgnst5KOz40JfNUvV79XQTr8mzSygZYM82fMjx3LRO0S3ddw2GUH/0Ux19J5hhvEDAVEKJBMIMxNQmDD6rG1cOmwaAOK8s9LbZQ/cuScIYcOi6d161AvaO8sOJjNwu+6kdAwMN11ZTs90TO4wibhRd9fGM45DvOfNFHlQzJFs8rEuYR/3tNCoCQsJY/MKkXzURcondmYn6rqucpOQz6mLwcaMFgYGivK4BjFsq+K0g83XjuJX4v2SQNRS2354tiQ3iGlUEMMMLJh/5tQXMm02imMIr67lU6fabCyjmr6HW2Njxc9ZSP/9GS1hwabIT24wWvPEaFYPOe3vnzwGpa34JJEOSxl63jjo+2W6RLMFBogjvp9Vy4IP3uKfvGDvogYVLyzPccV52O36epnCdkBkYknhr94H5j85n8FETGrj/Rco2w+/BMAa8CwCJ4vlskA51elKVVENLW6tdnd3r6A6qxDO7EU3N5vMxsK5ViXEXBmRf4vIWuISJVzsv24Mx5L9d1wuUQhjp2shHr5U9x8jyqmsrbQW1+U3+FQ/oAxn74oYoaOvS/mnQxQmnXpir+fI+lG3tLh2gCgz9DcuYbv0rWz6kexzbqwK6PPAGBq2ChaYQJSwF4dcNseFhffTqMIfG543TpjYQtH1dSMNWDC2HHPEgg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(7416014)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1I+cOe+ECBL7Ph3v5MNR8BOdJSbJXRDg7exN3F+NvLDvbOkL0ENrASvN62s0?=
 =?us-ascii?Q?a1qaRIimHfy2P37lNRCGPVtCpduheuQeAIj+NGrklV7N9CIJP2RXkj9TpFgV?=
 =?us-ascii?Q?0ydplyeiXr9T3UhbTcXUxVAaT+jE7ZMzoy+bDAZ8J5PCWZ4V4GgNfodDmpoJ?=
 =?us-ascii?Q?JRnGJ4GsoYgOY0695aMzEFGOodkVyuvH9/oG52PL+5Ws/ma0yB6HtJdbXuZh?=
 =?us-ascii?Q?OrWQ6JNawe3id9lxarRWao3BQphzYmhNbduqYoKylX1L3gQWVem0zooX8otY?=
 =?us-ascii?Q?UlCMzp0fetrmBnqFqhRgy8YBrJNs4hm+QNrJhnZSseJ0XvYVbE67+xp+4vIn?=
 =?us-ascii?Q?rcZ2blUDTLUo/Y7rJXjaGK8eL7qhj5lEH3a7Qr29EjCCPjnd9ddYj15vsyH4?=
 =?us-ascii?Q?5mPhDyVKE0s435KDmpbJ7hHuJk1WVIkwvVvoiSGoljhCKaOE9dz+ptWTrYmI?=
 =?us-ascii?Q?84D6Q319tEwqSryj+Zp2M0++13S8qPRZzsIa7/Gl+iB2u7p5+n+05K7wk4nr?=
 =?us-ascii?Q?tmeujx0vcpn1lAnTgIa4/WTedJtCQnyZqm6BsnyPgv5K2TW8pTOe2BWA8vWc?=
 =?us-ascii?Q?ozI++hO2MQxbzj2k4fnVOgmJqmKqOcQylryU72IgfwMJCeq5vCbMP8xp5pZq?=
 =?us-ascii?Q?UZiiX3louXm4XtestgV8draHzQYgkY9PuOn+C7wEPZcwEafnTb/kMT01aPTl?=
 =?us-ascii?Q?rl22GHe9+00pY3u31GqKorRe+xDpIDeL5eeOejJI6uY5bv1geG/k/7j2dTh+?=
 =?us-ascii?Q?k0p/yDVMQ0WZvSlBW2C84mp+e9hDhUsnybQRZDdVzT3HVO/Q/buJmyjXOPTp?=
 =?us-ascii?Q?Kd9MC0AMfgQao6AICIMW4SgMrZIixcbuISXf0cIXeZ10jwjQt9JJXY68u6dI?=
 =?us-ascii?Q?q5qujxcAzYzvIsvvN2QDIzk3DFJVTKSEnoTkoJdWkphbIa/61V4QdLnqyE+d?=
 =?us-ascii?Q?Tnf9pVqaevi+Uqc/OqpMyODdprnFbq6jLHoJGRcQJjVKN6XqBuFvS9LcZ3Gz?=
 =?us-ascii?Q?UWDIxaiPiShkxR6ekjITNoj2K40beENoS5naKpCSjeEqUjq6PukVl2DADJ7u?=
 =?us-ascii?Q?DjIEMH1BqB7wB9B3RSYGc+LoLasoh2I+U+HGB2fTSctSahIlyFOoytkZf4Yy?=
 =?us-ascii?Q?53FPaRZFFqGMTQvaq/neCSKvcM3txl4g8WDmfJhmNg+2Dvt0HnGpPLSr9tZ/?=
 =?us-ascii?Q?Adbn+sxU0fIy4hHSuAyA0d4lydAvCKMxWiCBH/f4sVCIKErspWDbBwIxuqz5?=
 =?us-ascii?Q?ksdP2Rd7Vm09KSErfq7E7pMwv28eGO2unUCa8ndsM/RJGt41BY1v0WxHI39y?=
 =?us-ascii?Q?wOy2GAMw3PrNxlK9o/Un+F50+qTPSvn7fm1+Rmv0/JMOoKvO91Gj3mgczEN7?=
 =?us-ascii?Q?keAfP+UpFHBeHQht5/vaSUBACyRL7KEXphTzGkOHbn7y+wk7VeW7JPdJ4Y9M?=
 =?us-ascii?Q?LxLCYScgxaq6Bd/ueFuKLayAa2/YzLd0kdOmHejefQrjT1p1FhiiVSgIFvhx?=
 =?us-ascii?Q?pdZHb8vejCPU6YYOwW8Ne7tgJZVhv/51DC8FZyDhJY1SYroi7F6RC/fBr75j?=
 =?us-ascii?Q?T/sZ3vnLzevHremAgG/2r80kjaxBSwtrImVtved7v0hclh8f53A1oKh01LG2?=
 =?us-ascii?Q?e3q/NZ39RKMl74XcfI2oLQ6Yf5c49A+UVszw+tlKLTUbDSR001TEbxzpEZV7?=
 =?us-ascii?Q?5En42eZ/XQPwW4wL7TA42q5wOrg/Ldd1lnBb5IJPThnO4WqT?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b747d724-f513-4bd1-c9b8-08dedc311897
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 14:07:36.0362
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Sv2raEij467e0y+i8IW/0Zeon9rwtRyuF1I+WFNFOPbZjVoRdf+GMBlSfnJarFSe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4373

On Mon, Jun 29, 2026 at 03:35:22PM +0000, Suravee Suthikulpanit wrote:
> @@ -1808,6 +1808,22 @@ static int domain_flush_pages_v1(struct protection_domain *pdom,
>  	return ret;
>  }
>  
> +int amd_iommu_flush_private_vm_region(struct amd_iommu *iommu, struct protection_domain *pdom,
> +				      u64 address, size_t size)
> +{
> +	int ret;
> +	struct iommu_cmd cmd;

Why do we need this function?  iommu_unmap() should generate this
flush automatically, shouldn't it?

> +/*
> + * Allocate backing pages, mark UC, and map at @iova in viommu_pdom.
> + * *@out_va is NULL on any failure.
> + */
> +static int viommu_priv_alloc_map_flush(struct amd_iommu *iommu, u64 iova, size_t size,
> +				       gfp_t gfp, void **out_va)
> +{

I think the flush is a bit unnecessary in the name

> +	int ret;
> +	void *va;
> +	int nid = iommu && iommu->dev ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
> +
> +	*out_va = NULL;
> +
> +	if (!iommu || !iommu->viommu_pdom)
> +		return -EINVAL;
> +
> +	va = iommu_alloc_pages_node_sz(nid, gfp, size);
> +	if (!va)
> +		return -ENOMEM;
> +
> +	/*
> +	 * IOMMU spec mentions that the vIOMMU backing storage memory
> +	 * should be marked as UC.
> +	 */
> +	ret = set_memory_uc((unsigned long)va, size >> PAGE_SHIFT);
> +	if (ret)
> +		goto err_free_pages;
> +
> +	ret = iommu_map(&iommu->viommu_pdom->domain, iova, iommu_virt_to_phys(va), size,
> +			IOMMU_PROT_IR | IOMMU_PROT_IW, GFP_KERNEL);
                        ^^^^^^^^^^^^^^^^^^^^^^^

These are the wrong constants to pass to iommu_prot

> +/*
> + * Unmap @iova, flush the unmapped span on this IOMMU, WB, and free @cpu_va.
> + * Returns 0, or the flush error if amd_iommu_flush_private_vm_region() fails.
> + */
> +static int viommu_priv_unmap_flush_free(struct amd_iommu *iommu, u64 iova, size_t size,
> +					void *cpu_va)
> +{
> +	size_t unmapped;
> +	int ret = 0;
> +
> +	if (!cpu_va)
> +		return 0;
> +	if (!iommu || !iommu->viommu_pdom)
> +		return -EINVAL;
> +
> +	unmapped = iommu_unmap(&iommu->viommu_pdom->domain, iova, size);
> +	if (unmapped != size)
> +		pr_warn("%s: unmapped %#zx of %#lx at %#llx\n", __func__, unmapped, size, iova);
> +
> +	if (unmapped) {
> +		ret = amd_iommu_flush_private_vm_region(iommu, iommu->viommu_pdom, iova,
> +							unmapped);

unmap calls flush through the domain, why do we need another flush?

Jason
