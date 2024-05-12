Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4A1208DA
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715515740; cv=fail; b=gQvKaKd9iCTIP9iHcnsjMd/nAzc2PEu0SWZMNZDGw5ZqvmaAmTftO7yGQuEN3+y/1DV760bmCPZh7t4tI2Bc4OQnq4YhiysjEPArfQqre1ybK5OwfSig/OQd3YJOY6X9F3k8+LdcbyT4MTWRAtC1oxh+B0WxY05lnnlmA+Y5dBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715515740; c=relaxed/simple;
	bh=Su+fn5jectNIzliW1u7yfqPWCu7f7yXobbzwpyhNl58=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WIgYKM1dcko1sHSlGtX+Sy6/oXIgQKZKEdzZ8cixppmV8V3Xy4l/1beyMNdVd0YKJiB4x4sJNE7Iufq3MpI/daBPMJ1+qXj2rlkjA6uKXfip9O24/2fiv9MueyuC7GM/oHHgA01LrMSBO9NR1RjqGeZOO5epnF5fjEUJDIGyBWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oXx/vw2G; arc=fail smtp.client-ip=40.107.243.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oXx/vw2G"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPswfPWoQovGRKNd5GFGYxMvrVJt+pTFFWns+r556ym9cUl3D0Zftp25ntfafb3Se98UyZAgqc7RZKGBTdNR34oNLYl/13pr0uoGxIn+haxWqU44MPZ76LbscfKEUw8JY5mU8qR93nTMUVG0MUslY2zf/m8AlKKun4utKO9aI0uK2nwBDRDkuaR56BlXb8+oV/Z6zXnmPvjjXamXoC6LBolmkazY2m2RQdNATrigWMpzkiTzdCFkBBCi78gV5TmuQvu2DOHLX9TLxADSSTtX6l1DlKKP4b8VQFfnFXLRWfvWTuoMb+OdXaHin1V5fDJbuxs/H1CG2ZmSonWPr66gXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xV9Okrb5PQfNQymNtI8i1QnaKnEb/W8FRBVgNhqQIRY=;
 b=aZAoOEZHhWK06Ucl6MQYA7ecagBTghJAh6INx/tWMAV4Qs1df9n5b8+a4AECwwf2HFj3zHZYHiHzzYSEazJMwF70BOtesw9Qq/IpqzXt0ZAd3O1HKPod0Dlnw6Bm/qI1XJt4bOFDtYfszZPmVs+kSGmsJNzmfI7r8ngfQcV8TTqhrpdan/bApTBxcxt11K7FsgFN1iy1GPCC40a4xsivan5BoYgPouofSEZfJai3WsQ3e4a1Q8zSWN4vA8+XO3ZPe6K0L8VbejV36DoLJQZlP1pcynhKvUIhlJSZFGZv3zjXyYLjuD24JlgRZHLX9u19jV0tq5lL61SXfifoscWIYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xV9Okrb5PQfNQymNtI8i1QnaKnEb/W8FRBVgNhqQIRY=;
 b=oXx/vw2GOjiB9agPqYwl3fGaslF19LpB8U/ISrizge31fqATVDKm3RJKM8vM9KtWLWt6cxJNfBYDM9XHuDfkgSTq02Q/JG0mZP9HYtGdCNrhMPGoWnPTweISnwpVXO8i6CVQ0c7DmZ8qavh3h7RtnT/AL4W9wIodFc1D5puYalUJU8X9v8JB87JT1bIB7BOUtaaX65PFrW0TRNnH7xhZa8lkfgz7QJ3gzl59dFm+KAu2oaYgFOmCU04STvIlHi7kbj3OLs+yExOLpTkrkc6yNuZG7hrrIGSM90w9F14HeDfR1ptMszJBOuRm4zJOp+snzSFllFnw2Qfgst1yOh8Shw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 12:08:55 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 12:08:55 +0000
Date: Sun, 12 May 2024 09:08:45 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v3 4/4] iommu/arm-smmu-v3: Enable HTTU for stage1 with
 io-pgtable mapping
Message-ID: <ZkCxTWbkK0Domuwr@nvidia.com>
References: <20240430134308.1604-1-shameerali.kolothum.thodi@huawei.com>
 <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430134308.1604-5-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: ca07e380-8531-43b3-8c2f-08dc727c4bef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|7416005|1800799015|366007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?58EC4iHjCXsEBqLT/beMVI2xj3+bS14V3OPLuk8xFDoGYOMls2AERjwCe8Cb?=
 =?us-ascii?Q?DKTsBkrSxrLJgrBP4GHrwHxo815hYui35BuXz/fBd3cJAFAfDIrxHDVjqfIb?=
 =?us-ascii?Q?Cb56krVd24dwQRLqTpnNc9uJ9YCZ6vorBoxtG3RW9H2IGD480DPI3jmkOq/r?=
 =?us-ascii?Q?Nk4wcv69yzxzQn0jEI2Mt//6dnlrEvfKxATYR27SsaxuH/jjqZmARXe8D7VD?=
 =?us-ascii?Q?95sJOJJahSVTmIjTG1e2Fwglda85Xe8PJqOLS5UzlIE27yLcDN4VigC+axL8?=
 =?us-ascii?Q?bf2S5iwqjLbHwse7mpfaHhtzaAaXuJ+QV8XoLh6skQnUofKCfYizVyPnrnhS?=
 =?us-ascii?Q?Ft5j1RTpYn6Wcu5tU++IsWOc+cqCl3je6yH6xvsUJP9GkbXM6EgnGYFtoa8Y?=
 =?us-ascii?Q?qbCyItuXJoDgvthP0DCWRg/GuQpPafxLUzRjcqT25dMvlBvLr394vdE6yUhp?=
 =?us-ascii?Q?HyY6GW9T/zrpEUZ/CAekfGm3F5FIU1DLbntH2pWQh+QP5IAwRMCwR6jgirWL?=
 =?us-ascii?Q?GMzAubV4UyEdpNsO+LvpdK+SLr0Q/G2fmS7ak6VEjfy3zuDeomALS6hUz2gB?=
 =?us-ascii?Q?DFf2Go3j0Amz0ia7kuEsIwUZRlnQrYr8Q+0ZbrxkZjJ5WgpIeaK71vrpePRc?=
 =?us-ascii?Q?iZI3eeG1SgnZo4Ig7K7RMaxYSkQnosgqeey/uzs2OMGXUgeLUp19HfGxCt4u?=
 =?us-ascii?Q?Lu3ApH+dWUdmax8tyw7Qii/xvSuZdF4kqyei+07FdI2eqigTVSMwig4ZbRT2?=
 =?us-ascii?Q?4/I/cS/Zfs+g8jGZPDTzvOs5RCMMV5u21uMSmLPy5QXtwHR/Z6TbLB4+HEn8?=
 =?us-ascii?Q?am0/YbL/PZQs5/jqN25BzE1/CcZRVbWLd9cs4mp9Afc2pcki7TMYgeL53zCM?=
 =?us-ascii?Q?EXuTX60JO8jQnSFJXWn6NEVHAGLhQ+adqulV0Tk46Fqm1OM5CQINwk9XoBvi?=
 =?us-ascii?Q?aqYrlOj/uyOHBG+M2a96cf6Il5OxxNw7bLUDrcqSofRnhkEjkpas6FtM8hUV?=
 =?us-ascii?Q?3AnocaAXYKWlWgnfBq/kWvhUqlOel9Zn91uC/9dI4bh2R9sTNOHjTkiYO9ai?=
 =?us-ascii?Q?kTjd4LYpl5vNZwq4/G9WpsK0iR0Y3xxaWgVSR297z/YgY3QoQv0+PkxYKng3?=
 =?us-ascii?Q?GGjdCNkVyvue6rsFjljEXlW3i6BEZzCK5TjZOgVoh1TBsG41NKP1be4BUA8z?=
 =?us-ascii?Q?QzoCg0t15TOMGLwrwr/rjxs+NUlGRVlldSMXXvLB+YVuhjd1pSj3LNOGbtvN?=
 =?us-ascii?Q?dnISuDCJLRCu/czdqJJav4sAPoqj5J4aiWZQHorblg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/Z6xTAEY4suCE+62I37rJog4nxBe9YnLy09dCJ3VjMVVV3pjWQFxIROz64Ej?=
 =?us-ascii?Q?zRpZb/DH/0owzu1xv9EYxxAF/ROjyuxgMHYk6IMJ1O61q+z+Zl3yD+Aqh+mu?=
 =?us-ascii?Q?pKQG7LBZ5SnWZKyRNtku1r0aZvyCXxBKPcaJYIlioCOFKAmhXDW49ZVhhS0l?=
 =?us-ascii?Q?A32GIYTlinyO27yhStnMXHdeNomvFTaIo9dq2gogB1oTUY9Ovn/Vk0QTtIOO?=
 =?us-ascii?Q?8Zy08FwJiQe5Pr6c5SLUn5fUIDkmxJxq1ulScNjhvl4fqS2+lVUX1+np7a5T?=
 =?us-ascii?Q?Sbruk3jL+DW4HPmMe6ueaGqR7WXcBu0igAIQ21FAagZNgBJZInc4PIA2Oist?=
 =?us-ascii?Q?jK3mH0EF8y9kMfPeP2dywdW8qLher1N3bgjApjhwWgjqE/3Vm4AVy3WJX4Zv?=
 =?us-ascii?Q?pJkBIcSRgE1M0bDHXCTjx5n3ZWmeB0W/QtFTM0Ohb/sONUGSqrwj34xUJhji?=
 =?us-ascii?Q?CHGtxVmpBzo7/Tyw/czBXen5LOrrTyW+uxCJikzutKVNRonwspwGaFxW/oK2?=
 =?us-ascii?Q?JJG4qsrw9wprDX3hIkbZhT4vApYt2W3hKQiYVlihSCpvpBmR/6r6vbP2q6tt?=
 =?us-ascii?Q?c0Wlm5IzXPB3dHobMpkqWqNFso3M52+R3BqUFqvgFutGpEImn5DG9XNVqPVw?=
 =?us-ascii?Q?SqX0bdi9SMQ4LYWxzGvrQ5i/RqgJ19cK3LZff+A0KIHIt38NZV+2gsfi0nfv?=
 =?us-ascii?Q?E+YW+cyX6lGfbI7wEDRlBCHbD7/63s0Kf5KhuYFOp8qKNgF7HN8cv8iuN63N?=
 =?us-ascii?Q?cKyIDnpUO9N9EY0s1UrH+sdYUS/UnwhCiIiKSRnZeyexVIsNcgGjXl4dwgtC?=
 =?us-ascii?Q?x8JkT7kBoUNzZMOVhmTGVWI5/3BsFegNnYtJxDU2naggMJTRsP5tqQAh4hEa?=
 =?us-ascii?Q?ScJGLz+lV/PYjwIhRJ/84Fqvk9j4JXifj/8QlUcqwMTcKBExCk1u6lmnfclc?=
 =?us-ascii?Q?DCs/rqGnlaz/I4yFgcOpS1lqbZIGsnfrHnW95FdRXwqhwyQQn0bS2xA4XK1a?=
 =?us-ascii?Q?c6ONOl2z7jvAYZTPm9zhKm0ei+hDhQcSVr4fWw8JUigZ64+boWQdKZxtQcil?=
 =?us-ascii?Q?3snPRrbx0M4I8ynFJ/iVbVOAdXQTUWruXxl3haoE3vRTz1Iq5Z6nT4PWCXlj?=
 =?us-ascii?Q?VsiIpbRF/FZzI/Jr9C4WUaV8clNyv3UeCR5b8ruyxBIhDqRRJPCGIhoK5zsC?=
 =?us-ascii?Q?F2fGWSRs7ijw6gtY2l5IZtcVzK8//jktwzdJzb6+9uAR5blQPPqZa/b1I8H4?=
 =?us-ascii?Q?h1U847HbYsydld7khwtKBf0pSblEGLZyqX1porEpS1LFVfT0RMBpEaX2iGG2?=
 =?us-ascii?Q?eElcF9+fiS/s0w4QYfb0uqRauK7KpBQoyLtGbomF4eG57fSLhYAdsICnlPsy?=
 =?us-ascii?Q?gNrhQZczGpcGbuN0ZK7anPapUmOzQlO0bb2Q36N9UlyF6lqehjpNzZh5pLj0?=
 =?us-ascii?Q?xio/IqyW717oFlMqJDXTHg0YZBIIQggcLhWk/PMRF88fGlu/raSSEBCfEwjd?=
 =?us-ascii?Q?9e3Q3Kg0rv5MGiOjgIS9Yt3GvExwG55bWfHmehqGsVnNuUIpCgZkMMyTgjlW?=
 =?us-ascii?Q?OKcU1ZeCx11V8Ikt9Y8l84qAxrAdviyJPYvVU7XK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ca07e380-8531-43b3-8c2f-08dc727c4bef
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 12:08:55.6617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8aHEO1ACtT8h0xXGsgEGfAvPItyHNXT3InsYoU/qFINnNmMj+gM610aVxojayZy/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

On Tue, Apr 30, 2024 at 02:43:08PM +0100, Shameer Kolothum wrote:

> diff --git a/drivers/iommu/io-pgtable-arm.c b/drivers/iommu/io-pgtable-arm.c
> index da6cc52859ba..20ac0e833c7b 100644
> --- a/drivers/iommu/io-pgtable-arm.c
> +++ b/drivers/iommu/io-pgtable-arm.c
> @@ -433,6 +433,8 @@ static arm_lpae_iopte arm_lpae_prot_to_pte(struct arm_lpae_io_pgtable *data,
>  		pte = ARM_LPAE_PTE_nG;
>  		if (!(prot & IOMMU_WRITE) && (prot & IOMMU_READ))
>  			pte |= ARM_LPAE_PTE_AP_RDONLY;
> +		else if (data->iop.cfg.quirks & IO_PGTABLE_QUIRK_ARM_HD)
> +			pte |= ARM_LPAE_PTE_AP_WRITABLE_CLEAN;

This seems a bit suboptimal, it means the HTTU will be generating
dirty's before the tracking is turned on. As I understand it if the
SMMU wants to write a dirty bit it has to do an atomic RMW to memory,
so this would be a drag on baseline performance?

Should this start out as dirty and let the enable flow clean it to
turn it on?

Looks fine otherwise:

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
