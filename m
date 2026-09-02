Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010001.outbound.protection.outlook.com [40.93.198.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C59826D4C3
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788335442; cv=fail; b=DGUD4T1TZdMnxZiix9675gF9kYojufGyc1WER121RPQRTu40siXQRokvRiy5kGjJH6zPGz1KCCTN8juE0Oe4Dswiu5whrxsrTXfVqJ675ZWnr1syjq0pTdbpUNkVhJMsCvU/zes7ExjEEoPJ3bjPkY+G8OwcfBYa1ImKHQtHF/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788335442; c=relaxed/simple;
	bh=kmjx8Y3yMTZAn8o9U+Exs9ri1lzzRtyKOwGjyea2UJM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PA3iEvIOt3HsdWDNt+emSYU0W/sTb3hNSPP+lfdZ7F5Kb7t4ZAFLwKx0HuWnJuecC774KKZGDRhcrtJBvk7Gw3jgTskAhnxyAzl08WD/w2GIn40s9hG6VuuHetNhWvMd3QNy2ETyYimeQI1LuRtYlpwrFmyJTiIKEnFNbYcGpvw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=B9JOnblR; arc=fail smtp.client-ip=40.93.198.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="B9JOnblR"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdUqCd2XeFb37aB4KmWxIb4uqaYvOmW9Zhq/DAzAupud/l/uMFBRaQ5bE5c9Okj3a4xW0lvuD3LGZm7RBettCD2z1BeJr1eRNrrFsjy5t4URscWpFCGaC1in5q/kJo6EfGCv7GglMPgriheJZZk1P6Wd0vYAMRtRdszIifPxeX+1xxWN2QCFgQy+YhPRI0jZ3IzA6YhRI71u72RVkpn4KWg6GVTvavOoHwTkTr7E1f4GPwwWz1tGYp1U2WIZTb0pPFY5drduQTyxpooYCY1YETbpbwT+7mMkfi5+6X8rx20ABp5QVz2X75daW493Aov2ObBQUCNqY1RNoXajDUBJtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Lr/4tq2yVTdFZHYpq3xCA4a3yn/EotZV6xMt5Fp2Q0I=;
 b=G4LEnvPPchOpgaeiMTJb+/fFMql89Cqfg+kNACszf9YZ2CqQ/ZXQg2/Zx/gSoOauH8vvDq4B9yn+WBQulM1rvymVTGfBWELm3S6WVyWUSZx/wAeXM1EYvDH+EnupgKNIpCOZMj7did9olDZWC+rGRY7aYBOj14Ca4PXz9OQQAv3JVqmw2nrPCfUOMjs1k0lW35lqm8SlO/VdUt7RJuE77DhaHUof+eILJ8aH6IdBXQHOC82Yb+AdcuJtZukfy8qMqJfoc2+iFsdoAYaEpZKSpK4vOyJ0E47MjGRpxIN1bMsq75dTW6CKMAuQscs37a2Gry6m7mBnhS1V7pbO448B5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Lr/4tq2yVTdFZHYpq3xCA4a3yn/EotZV6xMt5Fp2Q0I=;
 b=B9JOnblRVoTjvMs7i4KHd2+4F/XiVd/ihbSjsDHrn4SpZRNcE7dxaSjGFRMLV0Zwptv2WsZPlZzJXp/KNk0GudQ25djpfKdYgeOOqUgWEy6hQsltR+UIFpUUvk1cGAQmodaxuVXPRh5TsV/1PVZiZfpHr8ugSh42rBH+jhji2rE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by DS0PR12MB7629.namprd12.prod.outlook.com (2603:10b6:8:13e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 07:50:36 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0382.007; Wed, 2 Sep 2026
 07:50:36 +0000
Message-ID: <9afe0dd4-478c-48d3-a18e-98eb3cdc0cc1@amd.com>
Date: Wed, 2 Sep 2026 14:50:27 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/24] iommu/amd: Allocate Guest IDs for IOMMUFD vIOMMU
 instances
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, wvw@google.com, wnliu@google.com,
 dantuluris@google.com, chriscli@google.com, kpsingh@google.com,
 alejandro.j.jimenez@oracle.com, joao.m.martins@oracle.com
References: <20260727132913.22475-1-suravee.suthikulpanit@amd.com>
 <20260727132913.22475-6-suravee.suthikulpanit@amd.com>
 <178759229632.3131778.15484398917177708696.b4-review@b4>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <178759229632.3131778.15484398917177708696.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: KU2P306CA0029.MYSP306.PROD.OUTLOOK.COM
 (2603:1096:d10:3b::11) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|DS0PR12MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: 375da8a1-4a03-46e9-3368-08df08c6dfe5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|23010399003|10067099003|11063799006|5023799004|56012099006|6133799003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	Ng81namCuKiiHnezY5QWaPtw1RtBpSEYfy+Tl4k8YKuS/kO9GqnaNCALNnTSlVpZ9N6P5GBG/mHSr4vHnzvrBZbt9Qrkvqh5QBl0sB+hi6UI8oawuOf6AqRDyK4YBEwQN1G/pBbgBsoy1GlV2cNHedOz2CRaLpnmaY22/UMieywZWagG/q+1CB/S4Gq80m1934++9sReFUf2kyY5fgyURaC3PplSytNMOEsInuzOisCi2D09ESO+xxhbpECExKSgb7CKpRXdN5qWwLN0+JiJ3ZWD7rbQAYauqw9lZMdI34lrbhRoxxQGf7WmJMBAQV9+Pu/1IBVr2GBLOGzziOG/EMVaUTMb9BgPCQblOoLo480d6diqavJC4E5ue9Qj0+aK/taz6a4e2lPEdV9rBh9QyjgotULjNyALl8b1wAIUOzuOyjZwxvNiFsIJrtyakWewEC6xfRLbrGChB8VPxrwBmxwUsjnQXMA9nP1UlRchVqaiW83e2ifFvspMhhFhqyDnVFgeY8+9jb9KjaoqO8xqHxzuD13cHoQqVBTBEm+vwOug4NStvuZdNj4O6SbRPXXIAq1hAQm+1/QfJzvAALp9WM/G5lXWqgRUW5Jlk8e04ePWtwlvzYTNr0WRsZrUiBykqA7qQUgIQ2vuub6g97xQSTFkogozTETsNbGwY/vJvDA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(10067099003)(11063799006)(5023799004)(56012099006)(6133799003)(4143699003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bGtxa3diZ1hvdUtRTFc1N2g4aGVoN2RmcWZuUGZWSFVWb2MwNkJQVEp3Qm1C?=
 =?utf-8?B?MFZrMlRjVThVbmtzRlVTZWpVQ21NNSt2UHRvalB0dUkvQlY3KzYzM0lmWDFI?=
 =?utf-8?B?QXlqaGpvREd3d1RRaUY3VUgza3ZwS0lMZFVGSTJpZ3JHWjZxMDdwaExwa3dr?=
 =?utf-8?B?QmhJSDRsWU1XY2hMclYrOUljMklMc0M3Rm5tVnVPVnQwNFUxc01BbmNRanl2?=
 =?utf-8?B?cExzQmY5ZFpPVXFtZVlBTE1rSlRYa2oyMlR4Vk80Y3hzSUZtQ0JwSEN2aUZn?=
 =?utf-8?B?eTJtWTkzY0ppYkt1YmQrSjRlcmZUN0lvblhHTHZYV21aSlBTeVZzZlY0MDkx?=
 =?utf-8?B?Uk4vcjRRcjZLaHE4bTBmd3d0VEVYalNzMDBJRDF4RHhWUWFoTCtSTkQ0L0d2?=
 =?utf-8?B?TEp5aGdvWVJEblB5M1k5bmhIajBDdVdPb0JydVVUbmU1RUZXNFI2b1M5OHpz?=
 =?utf-8?B?dmExNWY0Ynlqc2V5MTc5QzZ5Nm5zMFVTUnBVQkc4bUY2YmVxRVVBQXZ6eTQ3?=
 =?utf-8?B?MWdHM2xaeHJEVG1XcHI1MGtmb2hDZ2RjSkxER2pENFZGOGdPT0tKZFd0UDhC?=
 =?utf-8?B?bmpwVXBEaFZsR3NhaWdSRVZVQlpyNjd1NDZ4VlRsZEk0WEpGYzFKeS81ak53?=
 =?utf-8?B?d0Npck14WkZhVmYvME9hdlhoU1Y2YTFqcG5VT2NpdzJMUjRIR3Z1WGRhVkpK?=
 =?utf-8?B?anFuUEhFU2NVTmE5WkJXY21TbXFBVDhic3NmRUg3eHBnOXYyT2pPMXB2R0hk?=
 =?utf-8?B?amtnRDBYbkd2YldiT21WNENmY25HTllhZ1JNb2xLUnlaRWdnb00ybHlqS1ky?=
 =?utf-8?B?UDJ4UU1CcEd6cHhMbmV1eTh4R2JlRG5kWS9mQXFqKzBkeEl6SW9RUzkrT0tu?=
 =?utf-8?B?TGNYOTNPZWJDWTNteEt0L0VOL3ZUWjd4ZWNPaG5nT2oxWnZuYTBZdG05eFlE?=
 =?utf-8?B?aHVwRTd2NHNFN3E5NWZhQVQzWm03bHhNMmV2YUpGZzZRdkpORUVzM00xU0J0?=
 =?utf-8?B?a2UzNGwwSG1FYVNYa0pjeC93eGVlWFF4cW1FazNyRzNtUklMenRxL0k1eGZS?=
 =?utf-8?B?ZXQ0RzVqQVJyNnBmUjFFc2trNWwvc09HL0RrMXE3NFBKQWR2SFlBSjcxR2hL?=
 =?utf-8?B?K3dKNkUyam4wdXVhNVk3N2s2TjgzRmkwT1ZkeS95YkUzbmJ4dzhEYjFPaDE4?=
 =?utf-8?B?dFN6UWpGSGRlQ3BUZFRHVGlzNlNYQjNYaVFUM0NtdXNMeHA0MTY3RzAzUXp3?=
 =?utf-8?B?OEtUMndHUHVDckhmejlPQzVNK3hFcFAxTy9jWWVuUUt0dE92NUs1bm1VS1Y0?=
 =?utf-8?B?dUxTTGc4cGp6UUdaRVlrWXdqaGhHNTllNXoxcTcxckJGYVR5WkM0ZnB6eFE3?=
 =?utf-8?B?YUxFQlU1eDY3MFkyOURGUHdaVVZpaHF3eXUycHdJbi9EclNVZUlIRnNxZkxs?=
 =?utf-8?B?VmgxTUMxUVRkNjhLZlphTHo4UXkzYU8vN1NEekxPNTVZTDR4QURDazhmS2Q1?=
 =?utf-8?B?QzljZCt6Tk1Ec1NMTWZkNjRrSzZ0VUlaSjhmM21FQ2c5R2d2WkJSTHRuSTFx?=
 =?utf-8?B?OEJRQjBtQk9mUWVXaUxSQWpTWE1qMnVRU2ZLeXpyQXFPWE1VTkV0aU0zQ3FT?=
 =?utf-8?B?eElDYkdEUE1OOUwvOXU4dE5vT0k2enhNcjBrNGo4SlptRm1tbVVYeldlc3V2?=
 =?utf-8?B?QVE1a2tIaElKSVNXVmZ4bjZtbisxN1RoU1BTRmZFd0VCdWxOVzdueGM1MjE2?=
 =?utf-8?B?b1BNKzlHRFJzbUMvNXpUSWNrTnlsazZnY0FIMGs0SHpMazdhZ1c3andNd0FR?=
 =?utf-8?B?K3ZFNTJMUDRpZUJNSzFpMEQ0V3lXT2pzSUZTUjVUajlzZGcyTGU5U3hJZVRh?=
 =?utf-8?B?dm94b2FXYW1qYmxpcmlTeGtXWWJSOTI3MXFEQkdyYlIyeU00djc5NHdPdmNW?=
 =?utf-8?B?SG5EOFFGL1F3S3p3RmRVYmtlTTRobmp3NVVOOXNGNm9qdXB1dnMzTjR6SU1h?=
 =?utf-8?B?Q1k2Wnd0S3pURjc5Y2JHMDlzTTdvS3pFbEM1Y3d5NFpyZzE2MWxrc1dmOUMv?=
 =?utf-8?B?bzZQTmhjeXJVTDJUNGFOczgxRHEvUVhlZVFTNE5DZTlQeHpyYmljaTQwM1oy?=
 =?utf-8?B?Vnk5dHhQK0FIcUpHZk10Z0FEcUlBWEhnb29PQ0N5YmdxM2UzaDVqblRQRDd3?=
 =?utf-8?B?OC9QTmhablBNS003aFdGYnRnclE1aHE4NEF4MDByNmNxdFVNRERBOFU3SHFC?=
 =?utf-8?B?S2dsNUMxcnIzZ2VPL3NSa2VOUUJXUDFhRWRyK2c3djc5N081SzhjdzMyNEZK?=
 =?utf-8?B?MnlzMVBaVlNRTUJzSkNVdkYzOWszc0FUek1aa1lVaUcwRlFCaW9IQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 375da8a1-4a03-46e9-3368-08df08c6dfe5
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 07:50:36.5939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gptEzlJ2o0eSbVGQssqSgLlbTvJeGz+eIYrMdWw2VZFLx/MAqmjfCq+7sU/39BsOagjvfR6Z6NzKg3ARAfT/dA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7629



On 8/25/2026 12:24 AM, Jason Gunthorpe wrote:
>> [ ... 73 lines skipped ... ]
>> +int amd_iommu_gid_alloc(struct amd_iommu *iommu)
>> +{
>> +	int ret = ida_alloc_range(&iommu->gid_ida, 1, VIOMMU_MAX_GID, GFP_KERNEL);
>> +
>> +	if (ret < 0)
>> +		pr_err("%s: Failed to allocate guest ID (devid=%#x)\n",
>> +		       __func__, iommu->devid);
> 
> Don't print on user triggerable failure paths

Ok.
> 
>> [ ... 19 lines skipped ... ]
>> @@ -43,13 +43,37 @@ size_t amd_iommufd_get_viommu_size(struct device *dev, enum iommu_viommu_type vi
>>   int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *parent,
>>   			    const struct iommu_user_data *user_data)
>>   {
>> +	int ret;
>>   	unsigned long flags;
>> +	struct iommu_viommu_amd data = {};
>>   	struct protection_domain *pdom = to_pdomain(parent);
>>   	struct amd_iommu_viommu *aviommu = container_of(viommu, struct amd_iommu_viommu, core);
>> +	struct amd_iommu *iommu = container_of(viommu->iommu_dev, struct amd_iommu, iommu);
>>   
>>   	xa_init_flags(&aviommu->gdomid_array, XA_FLAGS_ALLOC1);
>>   	aviommu->parent = pdom;
>>   
>> +	if (!user_data)
>> +		return -EINVAL;
>> +
>> +	ret = iommu_copy_struct_from_user(&data, user_data,
>> +					  IOMMU_VIOMMU_TYPE_AMD,
>> +					  out_vfmmio_mmap_offset);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = amd_iommu_gid_alloc(iommu);
>> +	if (ret < 0)
>> +		goto err_gid;
>> +	aviommu->gid = ret;
>> +	pr_debug("%s: gid=%#x", __func__, aviommu->gid);
>> +
>> +	ret = iommu_copy_struct_to_user(user_data, &data,
>> +					IOMMU_VIOMMU_TYPE_AMD,
>> +					out_vfmmio_mmap_offset);
>> +	if (ret)
>> +		goto err_init;
> 
> These hunks doing the copy struct are probably in the wrong patch since
> nothing touches out_vfmmio_mmap_offset.

I'll move this to later patch where the out_vfmmio_mmap_offset being 
changed.

> Otherwise looks OK
> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 

Thanks,
Suravee
