Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011049.outbound.protection.outlook.com [40.93.194.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AA246D544
	for <iommu@lists.linux.dev>; Mon, 24 Aug 2026 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787592320; cv=fail; b=QyAGuEyKvicmeACCthVxTnNqCuwjIY4b/9b6yAaIKQNmn6P3GbvZqbRroCxtZK1jze5lghkpNqlESojNRyA/Kr8qwQcPA/AodrRvrutmdUDklQ2GVXrGbstdZVuXioS+9n1uvfayKDgAehyVJdb2Hu6FWdxH2BvF313LsYzmus0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787592320; c=relaxed/simple;
	bh=/mzLEgirZFnQ5ZjkTXqnRyvO99C4GKbj23pCoJ4y4zg=;
	h=Content-Type:Subject:From:To:Cc:In-Reply-To:References:Date:
	 Message-Id:MIME-Version; b=tjFV9is04ceJVuvojahP7H3mk4tY2skaSpQ+xlmS9K2+lWwYavRfYZTfGXQ1YuCOYJaxy65wF+lm2szkf9CqKd9gXATHqBhsJWLLJnH5cMKyw9GCF5qCz84sQt/nWW6YcUTX4wrnrGXNSMNYl5tkSG1vY03buw1G80eC1S++W84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m/fsQi3v; arc=fail smtp.client-ip=40.93.194.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m/fsQi3v"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HUlQP33nBLFv0jywqBD7DhfZjJnsTPx9tdQ5YrGkwfwc7ZpC14zuPZn8G1xQX9w/yh7uGibRJ3CnCiIG4GcZiGfugcBXsFPW0tOXG3GrWuKjmhAT/sTP95TnU8BH1dI24e0VKLV6txtcOjOIFJQeCy9sEQBTuhV4/bpp98bj7K1+5jmee0WuStS1/3IQSNVrlxiW9xbMYXqlAivnTnkHDSaNE6knX6sklc31lFoZccfUfbrspbKundEGXtaD9pRUEAv0KtgXbT44QDtVUNWmtDGDDrxoGvYEtqnSXPVHOREeU04+WmStAnyTKt06HrXqy3/4CmbggIE/uaHtOJo0Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ION+crKBDBh1XQr+pqqSrfih7WLvy23VD8J6+BC1Ieo=;
 b=jnKLH0gv1uBX5lDj9uDeV9VNm9z9vVAdS75xJ1pssSqgWT5s4HNkuSuMJdFrJwRnGs+nso6j8OntoagwiRZ8PhkXeDuUYDxh/9J4BnCMPVMQt0LCph3dQXqR0LS1Sa7ZWfCrNLT/m+RzMhAdilsf5qWE2RqCs0InCHq08Y1N1yyevQxW0JfIRGhMLIuH3n/1iwEUNGdX7r6rzvluLBfGX/hEcYF0xFXtXQgONXW/b1F76/4Gqca352VCf/aPnfblFjuVxBQZEMX7DPdK8dFe1nLg9BspIpe+19uOlkoH9bp4eEz5aMHF0ZcXCRLkfTwhN6F4fzgxZqapA1llecNw0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ION+crKBDBh1XQr+pqqSrfih7WLvy23VD8J6+BC1Ieo=;
 b=m/fsQi3vOxF0nY/crAqIc/Mc/ZdacOMZrDYOrPFILrGj3HCdXTxWumHDYl9SA3WW41I31GPSSX1BHUP4q7ru6oZ5RLCse8HnuSc+GnOxW4bUL0WnzLjrcKKrs2iW29vKyJf1NM7hd0puj5zgl0K4TswApDThgnjwWtsADsUtOAXTd0mRbvPfPb4Ne2GXtrr1ykqoQsXCWKoqTR4JzSMWzJHCenmxI96xLQWlcDsm7UP4suHNDKQCLxgNa363SPV6xIvYF9DrItJyXA0qXvXQoF+Chf6hPkixciNAoN0ImDYE47PKDu049Zq1MbN8Lh8EbatsuSQv9JJBVfkCrIXr8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV8PR12MB9620.namprd12.prod.outlook.com (2603:10b6:408:2a1::19)
 by MN2PR12MB4302.namprd12.prod.outlook.com (2603:10b6:208:1de::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:25:07 +0000
Received: from LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528]) by LV8PR12MB9620.namprd12.prod.outlook.com
 ([fe80::299d:f5e0:3550:1528%4]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:25:07 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU
 instances
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org, 
 jgg@nvidia.com, yi.l.liu@intel.com, kevin.tian@intel.com, 
 nicolinc@nvidia.com, vasant.hegde@amd.com, jon.grimm@amd.com, 
 santosh.shukla@amd.com, Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, 
 wnliu@google.com, dantuluris@google.com, chriscli@google.com, 
 kpsingh@google.com, alejandro.j.jimenez@oracle.com, 
 joao.m.martins@oracle.com
In-Reply-To: <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
Date: Mon, 24 Aug 2026 14:24:56 -0300
Message-Id: <178759229632.3131778.15484398917177708696.b4-review@b4>
X-Mailer: b4 0.17-dev
X-ClientProxiedBy: BL1PR13CA0423.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::8) To LV8PR12MB9620.namprd12.prod.outlook.com
 (2603:10b6:408:2a1::19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR12MB9620:EE_|MN2PR12MB4302:EE_
X-MS-Office365-Filtering-Correlation-Id: d404407b-ab07-484a-e9b9-08df0204a35e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|7416014|23010399003|11063799006|4143699003|56012099006|5023799004|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	/R7V3zmeSs1XfZvwxsP5S7W0y4UZBeAt8p72W0eUleYOFcWsc53SZUtn63yRrrHikOYDKSDx3E0OL7rI0dWc5qhBc/AuF0DXAtmBJ69KvXmgz0Cn2nBlR88yMuLU0HdHtJFksY3cPN208lF1YMGNDfCxF+NmDHIwutbr9x+0TzQkPMlDCDcVWsnE2VGRarApnneGGNgc8hSjuijU7RovNEV06pGXLHohdusy7xoR62Ai+CAyKbTJ5wjRGfgYj+hd4eslEfVt6VfN3mv0qa2h3+Ho27hB4/Qvel3yLwOSmq4UL0DUD6egoE51HCFuunmXj0+ASrLZUXrPilD4SjFhMZsKBPoNqL0Fvrmf23fSp1kqRr5sv8LmCzRGFH4FQe64BsY3cg9mhy49UMAX8fpf4XbncKvmrw5U1dMDOaGC5wX57lhXzfPi8Q+qyhQ/L7HwN9V/7+nc3mR6A/GWCsvGFHdSVbr7JVFz0bGSDn95cwp6vftMPUwdzpnwVAy1hntPE/JjgOdZK0/yLdxk6+QIrZOiqwSeaWkDIBEq4XGn5KESwKV2eUhtDlxcsYBUbOQ/xHefv/khSQulNtZsON9/Y+n0kbZ4gX32zEpB7mAfuDlQY9COECIFm2JPHVv/3lfRR9wydVD9Tg9ojVpkOxxHBR1zk5rkYyMo0AE3tUFI94U=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR12MB9620.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(7416014)(23010399003)(11063799006)(4143699003)(56012099006)(5023799004)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZmtXb3BoV1BkSGxkeTUyeU82TTR3SUVkOXB5MGE5VFBJeE5OZ3JrSFRzRjY5?=
 =?utf-8?B?VFliWW96cm4zZklPZFJyUWhKdHJEa2h6anFtL25abmNJNXNvWDkwNFpNcXFt?=
 =?utf-8?B?NDV1cTNibmhlTkI5K3lNRHhFUXlUZFVoa0JBOEIvTTVMZk8xRmFOcnd6UGRH?=
 =?utf-8?B?Kzc1OU54YmlCWUo0YjBNMzdNTE96RXdNdmlTWkEvb1VKRWxtZVRUN3VCeEdn?=
 =?utf-8?B?cC92aGxqczE1ZytXODh5c29TdzdmdC9NcDlSSk5Bc3dZMWkyV1RxTEt6RStn?=
 =?utf-8?B?eCsrVGJHdHVzeW43Mmh6OFc2VVkyZ3JjeHJBZktxQUdTbEUxTHMyTGYzK2tP?=
 =?utf-8?B?aEpPejJCbHpieUZlRWZYRjFwVTdXWEFwNkI5T0VPV1FaRnJVTjFPNW8reWhm?=
 =?utf-8?B?NmMrWHdST3hMUGlUWUoxYytMS3p3QmF1QVZGZ1dSZXgrWDRkUkZvNGNUSUhi?=
 =?utf-8?B?UkIrS0FHNEVvZHVFc0JFOHNuVTdtd1RLektTWTdSWmpCc0pXUktsZ2xjbmov?=
 =?utf-8?B?SkZTbHFoL2orK2U2RTFqV2kxQ2Y2NnAzaXZUOTM0V09OWEZBZThvOEV4VVVz?=
 =?utf-8?B?RUN4RW80OUtsSlhRRmt0ZEVsT2Vod3FMS0w4ZTJYVjdXL25xM0M4M3Q0Z0lr?=
 =?utf-8?B?Yk5iV1NJZTJSeUJVMHRSaTJOUlhQY2JyT1Uzdnd6UGoxd2pobGFDb0ZLc2Rl?=
 =?utf-8?B?SHJpa1NPYldzL01nYWpDSlV6VVVlSXhOMExZT3p1UDYyOFBwRWFlSkEwZGpt?=
 =?utf-8?B?QmYyazdtMTNsaCtlSkZYeDFvRHBxQ1Z0NnZzQmZKRm4vMVNBLzNEblZjRDdJ?=
 =?utf-8?B?WVBzcnJxZEJwZDE4a1B0dnFrclZ3bTM2RS9vWVFVRE9yUVNUUFJzaUR6cFc4?=
 =?utf-8?B?N0hpYldEVHZVbTNhNmszN3k3Q1Bmay96VktKc0hjRnY1VTN2UVlBZVJWMDhj?=
 =?utf-8?B?MzQ0VlBtNXcyT3c3L214aVlSZ3VBVEh5ekZXNWtXM3dmb1J0eDFvTnZiZDlx?=
 =?utf-8?B?cTZqWVF2ZjdXamJXSjgydlRMRVBSZUN2RGtpV1RIcUJNTlF3SVNmd3BJZkFO?=
 =?utf-8?B?MXo2NHpuSmFRNzFmQm1NTU51UVhROXgzU3J3Mlp5S2N4YnMyTUlzcUQ1cVd5?=
 =?utf-8?B?MlorNWpBVGh6REx4a01mR2MvOHV6U1RGdUt1T1dEYXB5V1l3eWgrZEtXYzBM?=
 =?utf-8?B?QnhjS05id0JpRUVHelRpREttRk15MDBNa1JVQ3puL0RtZVFVTXdzYUxuZXB4?=
 =?utf-8?B?V0FVU0tveFpzR3AyRGEyajlVdTRwK0VlUGViZmF5dVFZTHdTSWgvWE9CWHNa?=
 =?utf-8?B?dGMyejNMdWk2RytQd2pNQmx0YnVvVEpNTWJOTk1uZldOejlXTnkyV3AzVVla?=
 =?utf-8?B?S1BlcDcxWVl3dzY3Q1RneFJvdmh0QmVNcWVkaTlxcVBjTWlScjVLeE5sTTlP?=
 =?utf-8?B?eWc2TzZydVE0OGhBdVd2WUV0QnVjMzNLazJhTHJjOTQxMGp3ZzQvaUdtQ09F?=
 =?utf-8?B?MS8wT2c3U09aK3JzdjhzWjl1RjlCK0g5ZEdOYjlZdFpqV1EyR1JqUFJwdEta?=
 =?utf-8?B?NHg5Vm43cUpZTlR3RlVQSGxXM1dPWUV6a3pXWnVXUVZSN2JQdzg0cFdHSGZo?=
 =?utf-8?B?dXNZdXVMNG40UlRtdzVITk1Iek5OWUxpZmhNQkYwMFRLMGdQT1FYRDR3RVhG?=
 =?utf-8?B?WG56bWRJVmxvT3NiL3RwNmhoTnNCRnh0TmxRYW1NSXdOQk9GckpCaEVPM3Np?=
 =?utf-8?B?SlNIM2dOQjkyY1UvZkltdXVZWjI5Y3VvYWhjY2RkeGhPbFhEOU1EdFZXUUxo?=
 =?utf-8?B?cFpjdERtVC9hVzBaMU1qQ1pTaDdnQlhDc3FhN3FkMEtIQkNRcldJWEkrYzdB?=
 =?utf-8?B?b2ROb1I5dVVUOEhDcE1BdzcyMzQrdFRiNnNxU0hlUk9hUEtLV003cW4wQUw2?=
 =?utf-8?B?WDRHOUJteVFmM2pjaDQwSHB0bStkVk5zdGdFMGpVd0l6QURxajRuK1hQSXJx?=
 =?utf-8?B?TFV0SUJ4MVVlc2ZIMUwrTVBxYko4YmwzVHVoN2hoV2dUaUZGeXk3eXkvd0tZ?=
 =?utf-8?B?bTNjWGh4cG5pdDZjV1AyNXpvMzdoYnlMdFpUWWpRNW45U25INVh5aFVjMUZz?=
 =?utf-8?B?SlJQQkNYSDJGV3A0bWtJRHpwUDJDTXZTTG1hYjRsTDBLYUM2aEduaEo3cXJH?=
 =?utf-8?B?M1l1U2FaTys0d2tDa0c1b05tbnpKZXVPbXc2aG40QUhVZ0pXNXliVDNTZTVj?=
 =?utf-8?B?T3F4eXpDVGIzVHBRZFU2RG90N1ZFa0xwbzVaN0FSaEFHdW5yeEV0TXg5K2lL?=
 =?utf-8?Q?oEvXapYXC8RquOiA1P?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d404407b-ab07-484a-e9b9-08df0204a35e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR12MB9620.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:25:05.7920
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 06ixMsHlwm6ElJ3ibZdVxeLdD53FHxTOL315xE5cP4cYT6yPDfkX5nCbFIQaRWa2
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4302

> [ ... 73 lines skipped ... ]
> +int amd_iommu_gid_alloc(struct amd_iommu *iommu)
> +{
> +	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
> +
> +	if (ret < 0)
> +		pr_err("%s: Failed to allocate guest ID (devid=%#x)\n",
> +		       __func__, iommu->devid);

Don't print on user triggerable failure paths

> [ ... 19 lines skipped ... ]
> @@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>  int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>  			    const struct iommu_user_data *user_data)
>  {
> +	int ret;
>  	unsigned long flags;
> +	struct iommu_viommu_amd data = {};
>  	struct protection_domain *pdom = to_pdomain(parent);
>  	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>  
>  	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>  	aviommu->parent = pdom;
>  
> +	if (!user_data)
> +		return -EINVAL;
> +
> +	ret = iommu_copy_struct_from_user(&data, user_data,
> +					  IOMMU_VIOMMU_TYPE_AMD,
> +					  out_vfmmio_mmap_offset);
> +	if (ret)
> +		return ret;
> +
> +	ret = amd_iommu_gid_alloc(iommu);
> +	if (ret < 0)
> +		goto err_gid;
> +	aviommu->gid = ret;
> +	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
> +
> +	ret = iommu_copy_struct_to_user(user_data, &data,
> +					IOMMU_VIOMMU_TYPE_AMD,
> +					out_vfmmio_mmap_offset);
> +	if (ret)
> +		goto err_init;

These hunks doing the copy struct are probably in the wrong patch since
nothing touches out_vfmmio_mmap_offset.

Otherwise looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

-- 
Jason
