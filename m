Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2058.outbound.protection.outlook.com [40.107.244.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBDF1CD23
	for <iommu@lists.linux.dev>; Sat,  1 Jun 2024 21:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717276117; cv=fail; b=Q0KK5zdygiIFogHWbd0BMe7Cf99a/MNGfNHWz8v67BFf0zOtyHf/GioePRRx9hKhpPzrMOFQCG5Bugg+hpBwScDBtUjut/4RhcntCWLBsXysY+pfksmqZ+tKbB4pxxGeCzYYIR95x+KjaaRvR98vyGJt47SMpNu72QpsN9KZBxk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717276117; c=relaxed/simple;
	bh=ySfQBokosHpYCgZtLPqlMAb/4gL4PcvFhLozgWuSoxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=a2ArzOG1lBmGA97kZ7L5StFzBJvMbQu37EmKPBKu12FVyyc4QP7BTt2Jpx0cTBYBc5bKvB+D6aLBjprt2FPuRia9YgR8101GDXEqklN+KnuKk/hoU9YoOLXMfkIYS3fs3gy35CZrf6MJDGu0P9Xyhax0piYSl2puevRJXJRXKI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rOao6wBz; arc=fail smtp.client-ip=40.107.244.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rOao6wBz"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HB1u0VCSlszHUAIPhdWa6IFl9Q0cboI8COV+I+qtbt0Xk7ZAnUfY0jQUzixrefjKJuHiL/JqLshlFdp2WwvfNwtFllsFtVTftpKFRkYuqA1rTisLOQyGQXPnFL52dYnxK5HOTH8vtTRcPMiAmr7nuzATGGa+rG2yhi6MFnDqTWY1sBRXasNwKCnSzi5P6ZI3LiKU9cfSXHN+gj3BSRnryPRDYRCIUV2e6omC83qC7RG05UUvpL6RK0n66f9mZE6XlU1hUhKbdatJvGupm6F28VfbGtxNu6+AZGn/FYtbp96VjRN7maj9DGdXu7coCy9FN/8FIblu6/SGupedVcerhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WwPy34Yk0pZ7crKnHqi1NpNhFEdXrCRKM2rg/UMYJU4=;
 b=Yrfc11NvOVhXGTSYOgDRtRYnFkw3mtK8mw0JOA8JlLMXQH6DMmYsYP/fy9F/U9jMCYu2zDBn/hTFRh5wNJz4ZQv03POLuAlIgzERY5i5uTI1vsUDadBEMcr7Z1lkejO5FEsdUbA5fu/ermUpDjLxFCVLTfaPtxF+GYR6vTygbuB/HfbKprvJED17/VXH6pl+GZWWLqcYxZpEJ/NMrtoCKP6qq/RAP91z/K4mQjFYw3r2FUTXrghCnADQSiVcIyWf+0JEBIA+li+mfhFR6qckffMbId+KZEpIEQ3IDzwbcmBVDJgNANBl81tr6UOgmCraGS82rpdIm3HT+YmzMedUNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WwPy34Yk0pZ7crKnHqi1NpNhFEdXrCRKM2rg/UMYJU4=;
 b=rOao6wBzk6CmpcQQi5bWetjN2wGxpj9mp7n1SN8W45nG7iGscWtrrX1gX4bj8nj9NQNVpYDX+MKMhz/XNDEvGvF4IoUftTaaT2lHGH1oykhMF6v2xpEPgzHVdl6k55M6UZembsh/EC446kgzlXv6Iz8QL1/XmDQRHP7MNEqe2U1j12keD7885DcOHVwelLCa2htlSSF67yE+V5U4yoe46S6iG8wFmMN6Vredw/P0lcGbuNzfUdXGJBZRuW9zBuAOfFMWXXIJqMKrv2XFjNN0yAmlW0Mj8s0WL64jxBq0VS8/bH/IaeQIK5MaUzb2rqSCPf8lxLtNkLJG/GX32c8YBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DS0PR12MB7804.namprd12.prod.outlook.com (2603:10b6:8:142::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.17; Sat, 1 Jun
 2024 21:08:32 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7633.021; Sat, 1 Jun 2024
 21:08:32 +0000
Date: Sat, 1 Jun 2024 18:08:25 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	robin.murphy@arm.com, will@kernel.org, joro@8bytes.org,
	ryan.roberts@arm.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	mshavit@google.com, eric.auger@redhat.com,
	joao.m.martins@oracle.com, jiangkunkun@huawei.com,
	zhukeqian1@huawei.com, linuxarm@huawei.com
Subject: Re: [PATCH v4 3/7] iommu/arm-smmu-v3: Add support for
 domain_alloc_user fn
Message-ID: <ZluNyUDmTzNIWjPw@nvidia.com>
References: <20240528071831.17560-1-shameerali.kolothum.thodi@huawei.com>
 <20240528071831.17560-4-shameerali.kolothum.thodi@huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240528071831.17560-4-shameerali.kolothum.thodi@huawei.com>
X-ClientProxiedBy: SJ0PR13CA0053.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::28) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DS0PR12MB7804:EE_
X-MS-Office365-Filtering-Correlation-Id: 9972fc7e-9e8d-4659-87e2-08dc827efe3b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|7416005|376005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7f0xleJjTYR2gczPhSQKpX2ScLryOx2NgVxxBIWyGpj/vJ8RLRPMPbehwGQF?=
 =?us-ascii?Q?SQMLYn3JxDot8UoB83SD51CfvMcmikZYvtdDayx29zahXahYdnHZVsSDJM+L?=
 =?us-ascii?Q?1li4wCtfs73CZl84+7ApDOq/+6vXfWkV6dE2hcap9L8zqXbkJugEmdci8pic?=
 =?us-ascii?Q?QIQ3moCX72vCRFjevHgPuU6H8Yu+YzENVOoAw0TE39wczyOffnZ1q0LdqkCi?=
 =?us-ascii?Q?2cJl3PopLShqFShiDDW37dghsQuRy/XiCz+CE2fEGh3ahlzLd8CYjeJZyPPV?=
 =?us-ascii?Q?AFc7bQg9tQ3PX8BKAP1L33UqDqyax2zAkr9nBpy142HfRc205/4UlX0MyOvc?=
 =?us-ascii?Q?/xsIpsmebRGPaOJC/RKJp6DWzxPm9h6wIdurVQ9tfaZPuI1bH+zgFATKSv3u?=
 =?us-ascii?Q?lzT4L5NPJaOZ2cdJek3c2aQ4pNUiSG/laB5J53ieQFRZq8BHeryQoBOJwa0H?=
 =?us-ascii?Q?w9SGyTQuzAGbzlGbUkMD2fDAFjx+bRKWbsVgdClnlIXQwvzPbSQm7Fr+yuyk?=
 =?us-ascii?Q?OS5WHOSx32pbd1Tpcnux7Hkz8rGolsl6Skep7qbz8I7AlS0ocj4ZVKaXQ3Hu?=
 =?us-ascii?Q?OZZvO6sMyTL9BcqpfTsXP9seVIQUq3ObF/It7WAlt59mLKzohOuwGT73WwZI?=
 =?us-ascii?Q?jtqx0RBhOOCh48WnK+j5up+22BJy8D9KDCBeTw8CcK9vKT7euL7kq4lVADiV?=
 =?us-ascii?Q?DDzogUWNZr2+3ZrxcPAPCuLI74o58YleEkkHTRi6cErghtZm/OAl0/WnWdNx?=
 =?us-ascii?Q?PWX8Oe5qhSzdak+Tk9nFrxrtKzU00r29YpuPrXhrYA3xoC8FEFQ5wSXZ88C5?=
 =?us-ascii?Q?19uv5e5Ubu4z3UUu613/z3tT0/CJhmiehNlxSguMNMyZU0gniV8kZ9KHwqgt?=
 =?us-ascii?Q?sc6AmQYHwIewZUDcm+0cd0fpKorOzshvCLFcRc6gE3oc5cFjENtlj/+DSVOM?=
 =?us-ascii?Q?I/bvK3d1u4RsjqF70A4UrdSUV1QIaZLO+MOf1D1JIV7J5NvkQqO0xO78CEbE?=
 =?us-ascii?Q?qnvkQ3ZwvzbHYoy2A0P9lS030hv1wJ4bLuuqaC1MyTkSVPoF8TZvNj8bPw62?=
 =?us-ascii?Q?Ukn66hMlo+e3tdbd7w/zasWu9LbIC89mo5eeUh9VmdRHoxK9T8gMeGyowyhX?=
 =?us-ascii?Q?oWJEdfcDoxD9hJ5diYvQlSRob1JaW97d0K3xftXV1mnCz6D6FkSSLyKLQx0G?=
 =?us-ascii?Q?h+qcKKAPPKlWP2HWW2dD+CRAVcnVJIYQNe6b1duOj3aTt9SViMae0Q885g3g?=
 =?us-ascii?Q?lVElwxw8fjQHifjBcxpk4z9UbSjR18ddyVTrWS87tQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QKqS3/9MTfBRd1efpPQl2SFXhrB8+R52/fy0Asj+u7P+10ErQmoB2Ray2mOt?=
 =?us-ascii?Q?hRhqzfykMcjwn6Tlhp7oM6haQexwX7Ja2gV7YGHgMOafKSeKcplf3RWN+jMB?=
 =?us-ascii?Q?n7UpraKcjBxTqZD+1sZ7aVTwoDf5SOfTxdPCNHFWXxjYerydkh3WnKVg1Jj7?=
 =?us-ascii?Q?OoGHU8s1RKB0P2ZRVUQbbJn4T+4SaqW5bzQQG6GmhlZaegq2rJPC/6+Ecydx?=
 =?us-ascii?Q?WXtYOgeI8hSJQs2QcvSEcrkCZp0h8oNgrtYK/wkHrzEFzGMER/5hj2FRyKAl?=
 =?us-ascii?Q?dHlwXpG9d7tETeS2wxhJmFH3N0jCGE2nFPSDWmythGqJJTazOzWNuxy4xFie?=
 =?us-ascii?Q?c1gIwoHvjK4UA3z7oYnw0sk9HoTD0N7eVqmuGRjaoNt6Cnyq6AOhFJjg7uhs?=
 =?us-ascii?Q?whyUQi8rlrZ5mgsxtYZTUazFbbOVAQbQt02bxr+MwJTkr7E/RXbyd+GK6ZCs?=
 =?us-ascii?Q?y1bubLFh4RT/RC8ON3AiKdZ2opsxbEt+rR2LrHjNHZuTZf1xel5jUypdpIW6?=
 =?us-ascii?Q?HTp4LW9JCLi14go9ypI40Ecn6NJqnpGCJTkftiiicPGktDTkbuyU3TxgO/SU?=
 =?us-ascii?Q?iKXMAnwcrFYJrL+ahaBVnQtlDP5Vkv75cqDkBAzP+bDu0NGbsO/JcSS8Ud32?=
 =?us-ascii?Q?Z9fUBCkHBLbl3SMzQmRNYsewBh7hXcWF19ZcuvwDnLeB+4ULSuavD9IWR0U0?=
 =?us-ascii?Q?ksYNYfCB3YDxFkuH1JhzFVm1rXGMxtWrOzOkiuWHJVDlYADNNOdhNh7qWhz7?=
 =?us-ascii?Q?83CaVo6QOXKNhgkr7pH+Eoz/SkX5JdGF3U33c86tfQ3730cjhtGkIpm7/d50?=
 =?us-ascii?Q?oNFsCnqG08fgYusDEPOM2YDUVYiRx4eESWXkXfebGt+5u1KrJoq61YTmQgWZ?=
 =?us-ascii?Q?jCiwoJle9Hmhjhp/SVKAsAZcuf8+b2EwhwvMJst3cMXK4YOd+cWbFna2Osb+?=
 =?us-ascii?Q?ugP5lMQE9TeV76ieb7W9kJZ/QJF0uY/3H5Q5Y/C9FRHDkSUUCmgQ3uuP4oct?=
 =?us-ascii?Q?HHc7gXNeqyf6JRWXK9qPET+MUNJTt6472EoTib2+nJf2WBUtAq/zZzuggsPw?=
 =?us-ascii?Q?61oWVof/t67bE9bdGKoa27EnFFEiU9H6gcLadPugNpSAgk6gVL7SsPu8SGTG?=
 =?us-ascii?Q?Kz3aonAoYhO4/HtFPQXwswXIHjZVC+trABski3OmItYO4OmSya1Ca+RV0jP+?=
 =?us-ascii?Q?uLMkYb2VIGBZfvC39PFoAEUXA443DEYyuUO6KB6Wxjp5mLmezpTriTrzwYCv?=
 =?us-ascii?Q?kLSAUHc/gtbAOK0zUrf48IIpAwn9MoLEnRoWLoX34PPN5gkmekBDRSAw6Qxy?=
 =?us-ascii?Q?+b0BlFGap6ddI3CY676LcKe8r3tXkYf9seEcV/QVc3mDCf6NmyIcI/RjlUE+?=
 =?us-ascii?Q?YzFwtkUZRxzBgDWykTUj82CowLLeK+Dw3dxdpiNRRenh7x2pz83ewCsDRJHt?=
 =?us-ascii?Q?q16Rj51SObY80CKGB3FCe7Vnlo3b13Q1w21ZFqpe9IDs7s8wvd5wq4ncgGov?=
 =?us-ascii?Q?LkH841WLW6ebISQFcGdIuwPOHdfGUh04bc7yQugL8iZ05d5LQXlvoRP0v2pD?=
 =?us-ascii?Q?/Lm2IHofYmUA33vtTS/DYtn6PTBuUdVEUA/4iJA/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9972fc7e-9e8d-4659-87e2-08dc827efe3b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2024 21:08:32.3731
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d+5R8k0c4DAec9oum+O2844nmFr8gKubn7M3NK2gVDUd3XRsllu5slr4egJfAU2q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7804

On Tue, May 28, 2024 at 08:18:27AM +0100, Shameer Kolothum wrote:
> @@ -2715,6 +2717,34 @@ static struct iommu_domain arm_smmu_blocked_domain = {
>  	.ops = &arm_smmu_blocked_ops,
>  };
>  
> +static struct iommu_domain *
> +arm_smmu_domain_alloc_user(struct device *dev, u32 flags,
> +			   struct iommu_domain *parent,
> +			   const struct iommu_user_data *user_data)
> +{
> +	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
> +	struct arm_smmu_domain *smmu_domain;
> +	int ret;
> +
> +	if (flags || parent || user_data)
> +		return ERR_PTR(-EINVAL);

This should be EOPNOTSUPP, and same in the following patch that
touches this.

Otherwise looks good

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
