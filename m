Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2074.outbound.protection.outlook.com [40.107.243.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866F28DD0
	for <iommu@lists.linux.dev>; Sun, 12 May 2024 15:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715526157; cv=fail; b=aTv0IvyKAeG//mUJoKMt2ArBYOzgIhRUIyPlf8r4VWUfZmYvxYpDyUe4G5injEIaEleNzYBoCRezsjwoWCraO0N2GvsNbk0bPmsT4ZqkfLgeYDMTEqZBv/ArYzkxxJL9RxmlRz3zFmTC/65mUgoNvRGsPQJDDcAUuQxEXuDTaLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715526157; c=relaxed/simple;
	bh=W2rhQ4yRgofM/lJx2Nc6Z3L/xRS7nmByP91vG6G5128=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jM/RnxbO/2r4NCx3WnSwR1ffW+iu4Awo+89RApPy8xKIEZMP+OurFpZxSonRxFgQczu0a6FIkiO+0srUIwp6tXbXqpA5nvEMTx0BycmvEGSk2yD2Ezy/oRNSRdamBqHMy7IpvNsetptAxxa4UDznGk6479svn6fECiLJUDRU1mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gy5O2tWX; arc=fail smtp.client-ip=40.107.243.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gy5O2tWX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YcFgqxouspc5ikXJZfSjLtV2V6iCbW/IAge+D1O6Jp90dGXWrhMEstWLxZydk6mcQ1YpSLFPtIplBCg/44Gsz0ik8/SVh7+BjM1/nC89j56wNEYVq9qD2ORjLE8k+5G5GkbSk/zIir0q1U9EP1tTyF7VY3F4awZ9HyOl+NllSGy/ISkU0SvBGjPkB5rPiXP9RmiUlE9IG71EqFSUvbuUnqKmQ9ZIWzWXYDZhnmxc4CwcQ5gGPvOXnpERQguzgw3pDzlD+fQutqe5d4aOWm8AoGMhCWjV/MGwLF8zljgB+QCHgbIjvyJtNutQHL88oNBaGLxcivht2df6ggEY36s5EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgAjyHgkRl+IKDoqoxey4ePLznWX5zWEiMYXwJ5W2uk=;
 b=oWCTTcebyll9EMBGnsTSIyhp+MWXXC/J2yJNsvqxD3pWrqKc+vg4UpbgRhD5vQLmQCUqln6kb+94fNE7mM4fWq+mKwEE82kcX/a3uo3DbIk9Isf5wa9bu5aTQFp4Aw6cC4FheQ4Ql5l6amdh2wpnzvnBc4B5P5A/xY6Sc9WPK7hiY5B9AIR16mXIH94IghA6cr8IZ+cO2DNRVkNzEoZV0IbrZIF9IAqKRmkQ44P4J0RUGX1iqOyeZIYga7pXKGwW1J1y6Ve00bKDldx63ZGZVH3AeLAiTXd5LRaMYw+V/LfqJ7W0YCi1iXZMtYrqYlznWbRM/2zc48gvuFvsdePJlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgAjyHgkRl+IKDoqoxey4ePLznWX5zWEiMYXwJ5W2uk=;
 b=Gy5O2tWXWwsrXyDRXyjqxcbLZAMsBvL9uuFWV1978fdU6EAj5fue+fnJrEpjBsiMuAy50wttO/IrdTWuyryVdRBwg4gSoGdBQqzQUv3G0CEPjMu1MxKmDtDInq7d6YN+x2dPXQ9gdNYzZ8MdIxDvL3D/CBNkWnjs+l8icEG3gQMafXa1Z/GFzjNzyPiVFDbh1wP+wwczgqKXyW+M8RvV3R51jkFaGw3boz4mca+xT6+6kgkd0w1ASs7z9PwjsxOLD1FPOOTgiepZF1KG94rw8uX/jr4cS8+tfCKvvD6fLkR9DEk8fCmPpuQ43LmaK8AYrSDgYn1DsXBmFYwCD7/Xow==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by CH3PR12MB7643.namprd12.prod.outlook.com (2603:10b6:610:152::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Sun, 12 May
 2024 15:02:30 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::c296:774b:a5fc:965e%4]) with mapi id 15.20.7544.052; Sun, 12 May 2024
 15:02:30 +0000
Date: Sun, 12 May 2024 12:02:21 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, kevin.tian@intel.com,
	suravee.suthikulpanit@amd.com, joro@8bytes.org,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
	yi.l.liu@intel.com, eric.auger@redhat.com, vasant.hegde@amd.com,
	jon.grimm@amd.com, santosh.shukla@amd.com, Dhaval.Giani@amd.com,
	shameerali.kolothum.thodi@huawei.com
Subject: Re: [PATCH RFCv1 12/14] iommufd: Add IOMMUFD_OBJ_VQUEUE and
 IOMMUFD_CMD_VQUEUE_ALLOC
Message-ID: <ZkDZ/YO0jqZOlRtA@nvidia.com>
References: <cover.1712978212.git.nicolinc@nvidia.com>
 <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0ee53af3f59602834e67ddf86c748ca304da175.1712978213.git.nicolinc@nvidia.com>
X-ClientProxiedBy: SJ0PR03CA0069.namprd03.prod.outlook.com
 (2603:10b6:a03:331::14) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|CH3PR12MB7643:EE_
X-MS-Office365-Filtering-Correlation-Id: 79599a86-8677-4f3c-e38d-08dc72948b54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|7416005|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qm1e8O6fTN7B0YQTsSTEicXhvq0tTM1z+zrF7lJamPsIg2xdaR8DpRvPDfIV?=
 =?us-ascii?Q?LlSLu+iT1TC0m97Gk/X4ZMPo+0OFfIdRof1crEPZgdQZ7MbgUCar6Fpa9XQN?=
 =?us-ascii?Q?eIoy+cO3g6Y+6VzP+NhI3Ekugk1GIbgwwUDtIEqjlzyKR404pv2M3+gjd2Tb?=
 =?us-ascii?Q?qdKDv9Jo1G1XCbdzpelHe/zayeWi1HMg8C46YF4TBwKVqecg8GjHUHTYbABq?=
 =?us-ascii?Q?498VYmIdaKX/iddBebtoMdyxUPsOjTHZlPdcVS4KoQeuAp+xiE+MbsRysrmA?=
 =?us-ascii?Q?WAiHW48aYYYJ9FR1I/k90I9EGLiRJaAz29AIrUDlI6VQ0ePOVpUkoUDBXvON?=
 =?us-ascii?Q?hJ6ycVeSObfTczyOp2N6nEhipLt8RmTnUK1KB8LqoqBVN2CuNE2+XtSeVe6G?=
 =?us-ascii?Q?/NodcqM0blD995l+K3nkGGjI5Gvoci1EMW25dlhB90F4HW/9H76lcv53OT/A?=
 =?us-ascii?Q?MwUUc2qVvbDO5Psgt5HpOelORxqNhhN4ZTdeW2qUsSKh2vjQXCKNGBUSlJmC?=
 =?us-ascii?Q?M6aZoUGe0cUHm9DlyEO3D9nFqJ7HQozLgOUJrjHUeRUTRXE3M7uNPcQv/1mn?=
 =?us-ascii?Q?smYogb1FjQTuo2XzImApwVxgFZIyhhUnPQIeOdF5iZkmAEzVUU73cPBRthlx?=
 =?us-ascii?Q?IjAUeO3Kzh3rIVKeVdjGAR8p/l5/q6Gj6uNPCC0RGFLeGGy4EPeGbpF1q4iN?=
 =?us-ascii?Q?oa+C3+DQASE7h4a5UnEq1yOdZK/9UKJAL3r7Emlbu+WQG+wDIog6LuD+tddO?=
 =?us-ascii?Q?Lc1FAJhTBmXNnSUOQDnIgoagMPjpTu+XRoor20UrhNx4U/TyEcXBey67H5o9?=
 =?us-ascii?Q?o0f6hykzUIw1RK0rc1SZOHYGYRm3bwwOZfeNbaBOfmiEvmfhZWX2eylHveFS?=
 =?us-ascii?Q?WO3Aw5xMaUGJ5LXKnErTZWiKA6PG7ExFmh+pZIP1yWnRL20XckFyzykLN33y?=
 =?us-ascii?Q?USu3p3k29K7Phzsoy9NOoiOFQrhVEro4RrDAToduirGF2i613Cpfvw22qLd5?=
 =?us-ascii?Q?OpEMWbEVeiQFjPt2wrZJaJvzTA8Fzv5YxVR71+kuWP40m1xqqAoJFOUYuaDY?=
 =?us-ascii?Q?s1aHeWuXM32U6srxyn8X4ECjzLAEZkiRm5JEYp82KWSdkdbnbIImLZEcoSwm?=
 =?us-ascii?Q?qLSdGJk4nS3GL/7RllQjYi1t5KkF0qSBHpjJTv7K3rGm6tWvtM+Ik0pE67FV?=
 =?us-ascii?Q?Y0+wzGLUdQ79L0vuCOe4ZDDr1SUqqCBKMZGOZxZsXUA3FDwwlyU1NI4qbGKI?=
 =?us-ascii?Q?MnyHEIMD5urVf+ppQgCUrNkCTIoO4kBvcv8TZOCPkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Imi0O1olVrMI26HWuQJEBrFVK2ulXwkgLTki8AvFjd10KWQu5c8pfmS04hcy?=
 =?us-ascii?Q?uHpOYXwjz3JNDbth9Ibe10wi8mkQ4CH4IYGce20Yp6IHBJ+ZcaN0XsNNZXQe?=
 =?us-ascii?Q?juoB4dIGNOGJSLOXlWCHFLVMzCg8iG8QL5+nWb+QEptFN045vtBR/C4T/N5D?=
 =?us-ascii?Q?4TofcPI4CygZixttASdr5Ku52RWKj2zyA6pmhciAPEZhNCVtQEIunGtH1ALH?=
 =?us-ascii?Q?osytr6Dd9y5B75nikWMskrJGHDYry+ywlXNCB1l2izgSoGITWmVeC6LyOLi2?=
 =?us-ascii?Q?sYy6tYVnyyZUAJgEl+v3u6mkfONDPG1UF50ePW5z18OPuvoCQr2g1qX7XTb3?=
 =?us-ascii?Q?m7gFos/MakkeIItYO2eICHwXsYRp2FN0NZliXcIjz/1m9bX+K8MIheq24s+x?=
 =?us-ascii?Q?qpUiATphWDyWl+YUjQJc3UFo9iWQZLwHyU9oS9CI9gNVsTzwU/7E8oLWpFkl?=
 =?us-ascii?Q?UlW79+FI2vD1XCVr6Ceq1lVV7hIzrCMsffeFMFhcnbOPNeKOsRd/WcHTdBEW?=
 =?us-ascii?Q?u8bzEhNk9DwFwhHvZCJJlmVD4FxNEbUTr1l5ojI2lvoY/OQyO9Yh8WRleWg5?=
 =?us-ascii?Q?XjzqJHSjK2b4yB5VSo/+3atrqKXBxZuTHWrHkjuY2FRwmUYmxIPrePTVS37J?=
 =?us-ascii?Q?CBBNmrWmiwYJDmOEb7hrZjqy/hxVaP2++dmCGciQeQ9PragbbblduqriHxGH?=
 =?us-ascii?Q?TVGqlp7OQXGDJMrWb63ELkCN8wvqGDC9mcbOHxb+uEufhlstEGX8I5/HVbCF?=
 =?us-ascii?Q?9ziy/A+ZqNNvglMaBQvktFa1pLgcd9dckIQ3r2jvg5agg1Sgb4I5iWG4IM6h?=
 =?us-ascii?Q?yd/aYzJrherXeT+VaOPuHqyJVCM/uroom32ii7pfvkSvx+4q10gC3bZX0zKP?=
 =?us-ascii?Q?+TJWXp3g6wuRXVFrUpYfjX+qoajzUTzWex26jsvY18jAlRnqDiO+hx6I+8AY?=
 =?us-ascii?Q?U5PJEurvidwpflY024AdXVbbNI7eFxh7YOJ9mOkEHkqSDX60ct1947bh8Q1G?=
 =?us-ascii?Q?VPPBLmhWKrwjFFJ5QXzdk0AtqBMZiapYSOjVnndyIgeOQ1T1iHQ9ZxdRyoY7?=
 =?us-ascii?Q?jISBPMzeJustQoHvxYEzaimMzXbSBewYhWB8biodr15RZMsLb9EhN7yYZbfL?=
 =?us-ascii?Q?3/SnxQPR3LKP1gz6S3cyhKU9b9r6sobsyWqgVX+Px/QdJIzz/hwMmeYDytTk?=
 =?us-ascii?Q?x3C0mV/TXQI9zcNkUfMJ/EnkLkc+n1+Gb2dVR4TFkLIYXcFL55qYiXCAClSs?=
 =?us-ascii?Q?OYp/CYOjArg7mxlSRt/PXuUSbq2kqlRryE/xl8idkcAtjGCf4pQYMnV94ahc?=
 =?us-ascii?Q?donFfnud/+MwgPC0Hw8GgykWFZa35uwnWqWYr5iRMDJv8fXH1jVEvCy6G2hw?=
 =?us-ascii?Q?Zo6gakh4PzHqX3xsYs2Qc6onHXEwE00HoO4go7TnFUvjOqgBmmhplokS0PC6?=
 =?us-ascii?Q?3JqxWe4Uo1SoWcDVk6dePWeFQVbOI6VGvPBvxICyJ7CbbpYh2c/bQ1hICSzr?=
 =?us-ascii?Q?cRJfW2O3t9msivfFgV7KojrXARfPf7KNDPa6A/PxC8wb679pPoIiVa+Zy97v?=
 =?us-ascii?Q?ZUqz0p4FytuaokZKDXvZb2/yk6+M04Q3S133dbyK?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79599a86-8677-4f3c-e38d-08dc72948b54
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2024 15:02:29.9240
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HztEr6sBrF7GQWGj4uSMRVp44x/lcdu2zsBJ1gFgF9jnJVcJr/NUZHOZAa4iE5yX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7643

On Fri, Apr 12, 2024 at 08:47:09PM -0700, Nicolin Chen wrote:

> +/**
> + * struct iommu_vqueue_alloc - ioctl(IOMMU_VQUEUE_ALLOC)
> + * @size: sizeof(struct iommu_vqueue_alloc)
> + * @flags: Must be 0
> + * @viommu_id: viommu ID to associate the virtual queue with
> + * @out_vqueue_id: The ID of the new virtual queue
> + * @data_type: One of enum iommu_vqueue_data_type
> + * @data_len: Length of the type specific data
> + * @data_uptr: User pointer to the type specific data
> + *
> + * Allocate an virtual queue object for driver-specific HW-accelerated queue
> + */
> +
> +struct iommu_vqueue_alloc {
> +	__u32 size;
> +	__u32 flags;
> +	__u32 viommu_id;
> +	__u32 out_vqueue_id;
> +	__u32 data_type;
> +	__u32 data_len;
> +	__aligned_u64 data_uptr;

Some of the iommus will want an IPA here not a user pointer. I think
it is fine API wise, we'd just add a flag to indicate data_uptr is an
IPA.

Jason
