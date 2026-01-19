Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010056.outbound.protection.outlook.com [52.101.46.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C9F4322B63
	for <iommu@lists.linux.dev>; Mon, 19 Jan 2026 17:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768842940; cv=fail; b=fa1xY1dZ9vxr/Duj1qoRw1NEdf8AebkuNEKVKsGaq+CnKuGCgTbuFYZ4KemgEITpqvbT+nX3qvzyL32Rvw7MFe1fBoqBRpOVz/CIElSqG+rFLAB4swlVqB7aTUyopiecjhCsLb5BklqeoScQXQrsGI7el4IXnlXIhnzrVOvxCpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768842940; c=relaxed/simple;
	bh=dQKO2eJmt/kO/d9nP6aElfXQGmVx4VJlYvCnQu2Lf0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kcbd6rSuYATha0GJWqiV11sA8GUxABH9nBHZoh8/uxmy/LykD7BinF9fJX17Xry1aVzBY4MiIPiIiZO60DAtwvr5ajqERoSgHGrUL21JAAMzNLsrXsXE9jMfv/N/bYe3uVU4e7QqgbLhOb+N9y/hBIpIsJcQGJHbvfsu5sBsBpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nPb4MdY6; arc=fail smtp.client-ip=52.101.46.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nPb4MdY6"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dqij9vVlTlgHVbbKEMTX05EEIZf97SPa6oVuRk77xzNYI++ZtmcgebCA+q6/XEFRsZMfxWq7f9tyzf8p07U5P9qHtAnn6w1MZuJ/5BpkEVDubtn0MD0EZfIOBFjDt5EJq94Rgl2UfZvDG5xWhowW2jxFzVN3QFn+/Ll+FInUEOKZf/K9otyzr308v2mm4J3E2yE5zM6t/sjZ5bAjvgNmVnGpOYnR0wkV5yqBuGDLU0ErZe87XW153r9DHYi02iUCNsYbWPQBlAk+qTN/hhbLITW0ey7UnHDSDHyRSN6PC/CgUAHOBZgNqEDO0TUHKEbp7rY9mork+V7ExEW+7emDxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XED4OJZtHvSEFWJ9h2kq7YodGLU57kCGxwsB1p+4YwI=;
 b=CuQv6U/XW0aJpfIOofg9lWRDx19l2d+HDE2YV/xofuBk2if5hL8UEjh/sP/wohGZfJYTxdbmKjdX3nasNJ/Rj69gm86AbLvh4G8TE+ZpoAjqf8IPm25Kg+89SkgFWmKdeCCJpY8gBUGa0ZljdD/v6jDvK+HT7dHsQ+uNoKM2PUKHoI7va/0tZJNj1uDA9P2jaQe2eEhP3LpU0khPUNFuHuARdG9V3RTvL3WJlYS1b7pK4i2Uj405gdysqyn2iUwm2FunjHwPPPtRY6nDc0Ss0cely37Ss/PY75unC/efJTRkBZwOmo4bo+TseX4q0L1owO+KUKtitpFoX5K5754dMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XED4OJZtHvSEFWJ9h2kq7YodGLU57kCGxwsB1p+4YwI=;
 b=nPb4MdY6VElydmn1D/bJBk0empsBpi8aUpzI1hbRzyewoN9ka7Y9tHn22xL+a8hvS+2q4FDdP6MO0bwAQ3qx5kZvTQqxe6OXmnERdLLJoc7fC1QgBqejcsR8uC3nN5/b779qkXmr4KhYkoZAOE5qk2PsZYjtAx88/Rt90XUfr0qykdxCmco4Jw7/D2vPUNpn4knX7zwF7wbEzHuXgUCElSi3Rra79D1EsnSaDyL7Esda69SZvr4bcxkSs4H16S9pRzKLhEwGF8Amd4k3pIimLQix2H0dZPvKEDmkZylTVWFvMXP2rrF2hwzbM5KcklRMLI+P5Kq8i4OmOqQt3cZ9fw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Mon, 19 Jan
 2026 17:15:35 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::1b59:c8a2:4c00:8a2c%3]) with mapi id 15.20.9520.011; Mon, 19 Jan 2026
 17:15:35 +0000
Date: Mon, 19 Jan 2026 13:15:34 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: nicolinc@nvidia.com, linux-kernel@vger.kernel.org, robin.murphy@arm.com,
	will@kernel.org, joro@8bytes.org, kevin.tian@intel.com,
	jsnitsel@redhat.com, vasant.hegde@amd.com, iommu@lists.linux.dev,
	santosh.shukla@amd.com, sairaj.arunkodilkar@amd.com,
	jon.grimm@amd.com, prashanthpra@google.com, wvw@google.com,
	wnliu@google.com, gptran@google.com, kpsingh@google.com,
	joao.m.martins@oracle.com, alejandro.j.jimenez@oracle.com
Subject: Re: [PATCH v6 13/13] iommu/amd: Add support for nested domain
 attach/detach
Message-ID: <20260119171534.GK1134360@nvidia.com>
References: <20260115060814.10692-1-suravee.suthikulpanit@amd.com>
 <20260115060814.10692-14-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260115060814.10692-14-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: MN2PR08CA0013.namprd08.prod.outlook.com
 (2603:10b6:208:239::18) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: b628b5d3-b801-4fe7-6bd3-08de577e5be0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wq8SeJbrqFHssUVOESLSRobwleUwA739V0sSvnf2O4OVCAb73TCCkewZAFt6?=
 =?us-ascii?Q?Z414XaQ67eb2G+Zcn3Q8rBDFCpykaeE3qRFZyLtGbZROSi2DS96vkOXERjlw?=
 =?us-ascii?Q?z/2Jly3RkYJwI7FZlUG4D4SYPyHhY2gcyGoogrUsZcXPA28VlCVSalNcjq8u?=
 =?us-ascii?Q?gH4nAo0h+J4nQPrNoaxrM3E/4JGg7A19RFjQ/jFfGyaRkBxEGhNoPtBBGJTD?=
 =?us-ascii?Q?tzGwxfUWpXJw6enlsN3uH42BO0N05PCEXYtiW3VRLPgbcAcGoA1CdZZiNBof?=
 =?us-ascii?Q?w9k8oMF8N53EAHJMkLIXTXdX1GBPPk+xoN3Iv4dXYKjHFOKacykhjxo+sHVn?=
 =?us-ascii?Q?bjce/fDg4gZrlacgzN4T4bCdBSdcy1SDJAghCEHkiqADT2p+dPDvOlBYLfmL?=
 =?us-ascii?Q?tDmu+s05d2g5k455JxcvXtm+FdDRZGHZslXhFGSSh4hPmqKplchrQiSFovz3?=
 =?us-ascii?Q?o/NwBPJOiQSqBdZDr/AWQopNIg/zqEuZnD//T0AYQ1DPX+fPmvizDJ8uYDPz?=
 =?us-ascii?Q?PwlQMzJ1NzRUc3gazIlPhVgAYs+2kmdm98pWCoqJmWP3ObbRYDL9BVvpQtCp?=
 =?us-ascii?Q?TQTvvshOl8NJ8fCc7VC00hoDa0j76lSWRV/6fHb/vxLTJfuhsJ3lvIPSB35h?=
 =?us-ascii?Q?IuzeFukOrKL8JhP7EnDQIJx43lDd8um+AXfE/5Yoju9ts3nk+w95jyjW25kh?=
 =?us-ascii?Q?5DOszm7xsj7irwK2Fq4bjsTsNBSiWsbmn2KvqiQSICmSDv37+YEbARTwaJHO?=
 =?us-ascii?Q?+5oAXfz1bE9QmCMThLF+Sz3sIVI4LwJHfD44fwn59Za/8CHSzRp4SF+Dfj88?=
 =?us-ascii?Q?Wnz27rsKx5CKP0m9aVem21x9YNwJ/M3YohuoNfhiHCkINUqmSLQTH5rfJg67?=
 =?us-ascii?Q?wfpX4+qxXMhI5htlWIQz++0krdm6LLuhukzFlKBCg84vJRhiDhjz+bVsKOTv?=
 =?us-ascii?Q?SRm9lxCp9EjMwxg/VKJ9oGyfgf7copXJ6pWKMwa7eF1/fWIKV18gf9zJdUn4?=
 =?us-ascii?Q?zPgsrL/MQOyXxzDA+VQPq8NLbB5irzEgCDOn3y164QwpU/JpD68iKabIqGS6?=
 =?us-ascii?Q?yAKJ1H1ieLGNvVcjhhMKdCrigOPcUBQWWqwQDXizr5hBdCR7//WdGayeTwpm?=
 =?us-ascii?Q?bGZwLCke+yYiwfdhrYE1VzpioxsWPlK1pzVNDw2FaD1Y6kmmB4Tg/EiKkPlb?=
 =?us-ascii?Q?Jvbh2b6AisrBzAQ99RkmMWTxiIFeokcjtpMdzqZ78MeqU0BB1NUK4CDj23xK?=
 =?us-ascii?Q?PJ+8xKj5M7bV03CptWN+6chdPJlSuU91MVO9yf2RlenW0zXwvGZUsVKhyioA?=
 =?us-ascii?Q?A2yMQ2ScniAMfXV20QNM/867bV8RT3oEy0YN8N7Lb9ufe9fSTJoqXwKOzxdH?=
 =?us-ascii?Q?700uhNkuXlZQZTV8zJTQWWxndJouHxEIY2ciuwhTE/fYyz5MAeUa7nu5UGze?=
 =?us-ascii?Q?GOXofZ7uiSYBMPBxerdBf8K/X63qWf/d4DOkHFrdTQ/iqez/zrmYmnHkq2nb?=
 =?us-ascii?Q?hFlEtJgHRmV3EwLAa0I01T+RhVTdXBhwuV+3SZVmevnaRVEHXv3CMFba/fHE?=
 =?us-ascii?Q?wh6x27SOoC0Rq/rKlMY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vMSpz407Q66P8KXPxS5/Jnsc8ERtW6BPTmImTf0EdtIHXY9oo8jXuO7os8ZR?=
 =?us-ascii?Q?lE1Nz0rsNub4wvaFM8xTstACgISh7kMcy8bikiUpYeTPesZAG3tSdZiPeiFD?=
 =?us-ascii?Q?/vUCszlN8BHeNmRv9/1ZNsjo+F+ew83K5ugfHK5zKpYp1JlOjLfnvJtQqSn3?=
 =?us-ascii?Q?HbCsN9JZ7CSqG9vUF+zbjKi9ia7d+4Snciy/oHY5aj1LSuQqceicHn82A12s?=
 =?us-ascii?Q?TIRU6nkv3845upRiDRKzAboItaVgGwlE5uB/Y210wb2Kw3lwCdWtG3OY4eIW?=
 =?us-ascii?Q?IDiTOXDUHJYYFkjAxT4EDoN3MiaWpFQcFxom2Q07ThD/c15ICLPtLHyFTEmW?=
 =?us-ascii?Q?rZ8Jmz7dCZYN3bOtnjFocVDFMQ0/7LpTB1S0rUKI763x0cUF+t09rIuiJjg7?=
 =?us-ascii?Q?Tb0x5IDxLCRPxhDE38rvsvLC7N6NtgBNATKaxw9BRGm9YzGoi4v4xKHbIO/Y?=
 =?us-ascii?Q?snsVd9fLNKGH0jy97hcCjZJdas41/MZ9iCgY2t8hydQr/2eYs4nMCdDe3MYQ?=
 =?us-ascii?Q?4a9q7GB6Zw5AU6OqnVp1CjN3j1BewZeCqQAMeeFIsL/djfkr48Q0J5vsO4sU?=
 =?us-ascii?Q?I1FXH5ln3Q/Vo4q2IHt32JXEEhmyz9QTL8Wwlp4nrXkoxC1ERMa/bOANjEU+?=
 =?us-ascii?Q?z/PR6GY/TWgDeax3NpJptSQp5D3n+TJRZjc8/xB3/WiEVmX5x/djVlkpEF5L?=
 =?us-ascii?Q?LgWpCFBGmkogl1l8mDV9JFNyY+6mHbe72BDvSZ5cMWdKwp1Q3Qgf7ACbNmYy?=
 =?us-ascii?Q?+zC5rSaEWGjHox7b6WNK0R/cIJCD3hsW2mTRwPFKYTi/9hFvHLzsoqwsZ0X3?=
 =?us-ascii?Q?93rtk85GMbz4DWs9VkeDOMKc+T/Zpd7OAIdJbDQRhq27SfE/dtIoJiE2Jr8s?=
 =?us-ascii?Q?hw6Zi/8XWz6J5BQbSWM07j9CamH9pBTqKE7PM91/M5Nk7I2GP+auj0ipcnOJ?=
 =?us-ascii?Q?KXrYfkq/DzQSJpsg1LTIFrw0BrRjqdI9Eh+Uq+eW37msjhCtrBYH+UhoVcnq?=
 =?us-ascii?Q?MDVaK6KBDvaXb2yAotpF9EtvXuMU6HQ+T+cUfibZimSRl+VEn0OoQlkO9pp8?=
 =?us-ascii?Q?GrOJCRpIEkt/H1Xzsz/8VsDI4+b0+iPurZkmd8RBQ9cRd0lxZx9wjzgJdyva?=
 =?us-ascii?Q?71+78P4Nwl+C8HbDt/2CVAvO4IcnIhxRE083XdihhtX8rVLFtjz0SUzPplDi?=
 =?us-ascii?Q?aMBfgoa6QovlFAWROAmFw8DzASPLjrpgU/xEYoNb72YcKjlTFPQvPjYMsT3p?=
 =?us-ascii?Q?ED0CnmOzOGNRR7EFNI2JOa1TG75CD0S0KN+8EdHX6uP+JLX8Iaz6yTVbjCMK?=
 =?us-ascii?Q?pLJyVMzHoFxiVF57rOWZEWM9D7hyotjUsWWfaWzAdcInpSiehMOK8LbElhgp?=
 =?us-ascii?Q?n1irVKGB1ko7MVYmtaM6u5r0YrZGnncriyRfhnT1YyXHF5aYDD4EHwB4uJdX?=
 =?us-ascii?Q?0jflJrrYcbM4TqCLXXv6sGCiE0xFiaFoLxvWZmyRvWBXm7jsbq6SeUXsO+dB?=
 =?us-ascii?Q?T1g4AoZRoXEXbIeCRLhrzORke1XE/IELGgFsoPSGxtoF28DY27EG+D70IA7F?=
 =?us-ascii?Q?qfgY+UUWYOx0Na73+lcSQ7qtRyoTlGRnaAUGeKEZporD8fXSyTCCuUuWPXY/?=
 =?us-ascii?Q?f6K+tvcbQnWHysGbVZRvF2GgiNgT/OnuRgD2ym+h4UgThDlAejezwHsyBxEp?=
 =?us-ascii?Q?iQGPYSSIZ65oTNhl3/fgdSfKDPclph3/j7Dq1L+2z0MOmTFn?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b628b5d3-b801-4fe7-6bd3-08de577e5be0
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jan 2026 17:15:35.4421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGKKwh9HdeCl2Sf5AkiyOO4dJykGyIXKEIpCtWaJQV2jIySCMA82mM8uZy0i3pRr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357

On Thu, Jan 15, 2026 at 06:08:14AM +0000, Suravee Suthikulpanit wrote:
> +static int nested_attach_device(struct iommu_domain *dom, struct device *dev,
> +				struct iommu_domain *old)
> +{
> +	struct dev_table_entry new = {0};
> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> +	struct amd_iommu *iommu = get_amd_iommu_from_dev_data(dev_data);
> +	int ret = 0;
> +
> +	/*
> +	 * Needs to make sure PASID is not enabled
> +	 * for this attach path.
> +	 */
> +	if (WARN_ON(dev_data->pasid_enabled))
> +		return -EINVAL;

Well, that's one way, but a rather big hammer as we do want to support
assigning PASID capable functions to VMs.

You have it on your list to fix it up properly?

Jason
