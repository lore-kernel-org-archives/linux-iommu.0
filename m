Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010055.outbound.protection.outlook.com [40.93.198.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0F2443C3A
	for <iommu@lists.linux.dev>; Wed, 30 Sep 2026 09:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790759177; cv=fail; b=Lwb1mNNeZK/uklJQeMrUejVmDSHzTGfL42+ZceKOWFJPucH62Y2olK7/MI3qzeOYm9Jtoo7UVkwpYXDKMHmo3biPDZA/JNuvcGmx8UUfosuodAvmxMkBOR4cRbJDEFSOXuRpSadRgZrG61d7d0zvHV5hMro9y2dGTQMLpplAyLg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790759177; c=relaxed/simple;
	bh=CV52leiF2Y2RBJq4TsInEE6F4cw5N2cpeJGmlGItNKs=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PRpwBZ1+RH3/gEt8CvpJDC4K7fkxESgWz+Pq1x2OQbVFspI5sqI6+sxRMYXGkn5fXwRQmwD7YvYsn3t+jCduvQu/wnaA9uMQaeQJ9MMqtOMBfvzilMFubjmUayTdPG6FRtPu6zJe7BoDwzbhXGGamezhRYhG+wza1pVUe5mGZk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JsvuQAFP; arc=fail smtp.client-ip=40.93.198.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JsvuQAFP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T1lAzgfGWbD3QleBGd8kpwyT9tJMUcGmZo9NAyJY5KN9r+BJ+HkblrnVd517rRvkEVRZIod27ehmAkrI1omSM/w+x9fi/pzxfC7LupLVslzf13pjTv17y1CtB5wWNxFFM2dTW54EgQIrRT4geBBE8ccHQKX3oOICSbSsQipWTMoHSnB+8GYvOzn8ovdAkyxeHDDxmnPGR6xnmVd1iZKJwjH6gKqhh5xCTbz0LvxL+ycZ9SjXl0hr7FEhd4J71ERRk3ysHQ/hUOU/hFvhuiZpcadliQLdoU4TjiKIly5e+SPXf6CsqfT0tG9Zr49OvNj/5+1rq6dWNQETmI0DJS3eAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zq8OTdVISb8VBV52RU1RqOp227u3JM5sk1o+gJ0emy8=;
 b=wkEizWP0WrvO3umK/trFyrh6QPZkv0yMjVPhSdS4QxGFoY3txdx9aXQM9dj8buUOjSOKyhb4+U1xdDBCjI3UAoPVo4exraf+EEjnjLQOZy2X9MBhndAXrb2kC4XKYc4EmzuqIEhrLNesxlQQY9JQQ/5KKyid/5LJEaMZeK/0AjHlrFjz4Gn5Rlxon63l5cmv13nijfOB60hbUUePk+oEFubUDNoM/tTKF9F3cTpRCWcVFWYn/UtSa+NnU0xTiMTmbwn8EfSCLOgw8uMDqlbbu8qwETh9tY6R4VfVvqj1ZtOFiGjMwOdXt+40Jb3grfR943FmNcQCjUFukVT2UCYtiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zq8OTdVISb8VBV52RU1RqOp227u3JM5sk1o+gJ0emy8=;
 b=JsvuQAFPZyvzF5VrjB3nYJsTkVyjw+XDTeLH78fbXg7UnvIvs9eXm1mUDO1wwS4sanKadmjL7Gfwe/1FenTveeTWeNMQVbhKMgCPk6/Ind/475vrlzNYp1UT1ru6sw+U+0kaH3zv3tu0pK7VBbbD306obhwSo8lxUhjqNusJ9NE=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999171.namprd12.prod.outlook.com (2603:10b6:8:388::22)
 by MN0PR12MB6200.namprd12.prod.outlook.com (2603:10b6:208:3c3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Wed, 30 Sep
 2026 09:06:11 +0000
Received: from DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19]) by DSVPR12MB999171.namprd12.prod.outlook.com
 ([fe80::b7ec:f444:4560:9f19%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 09:06:11 +0000
Message-ID: <5dfc3c36-af54-4624-bcb2-2386a8f34e51@amd.com>
Date: Wed, 30 Sep 2026 16:06:01 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/24] iommu/amd: Program IOMMU DTE with the private
 IPA domain
To: Guixin Liu <kanie@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, joro@8bytes.org, jgg@nvidia.com
Cc: yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
 vasant.hegde@amd.com, jon.grimm@amd.com, santosh.shukla@amd.com,
 Sairaj.K@amd.com, jay.chen@amd.com, Ming.Shu@amd.com, SooJin.Tan@amd.com,
 wvw@google.com, wnliu@google.com, dantuluris@google.com,
 chriscli@google.com, kpsingh@google.com, alejandro.j.jimenez@oracle.com,
 joao.m.martins@oracle.com, guanghuifeng@linux.alibaba.com
References: <20260914184750.222939-1-suravee.suthikulpanit@amd.com>
 <20260914184750.222939-14-suravee.suthikulpanit@amd.com>
 <a999cd33-c857-4c3a-9643-4c0add9679ae@linux.alibaba.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <a999cd33-c857-4c3a-9643-4c0add9679ae@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR06CA0007.apcprd06.prod.outlook.com
 (2603:1096:4:186::9) To DSVPR12MB999171.namprd12.prod.outlook.com
 (2603:10b6:8:388::22)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999171:EE_|MN0PR12MB6200:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a744b57-035f-4934-b2e5-08df1ed21263
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|7416014|22082099003|4143699003|56012099006|10067099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info:
	IcsZnjsG/ZBIxh/7RCpPBDsHjpyYojzPQxxsdOgdJBhUksv0ANSVqwu61b0H+Q+u7ZYJZC9xFwaW5rxJK8rx1aCYFyAd6h5xxYgOjMlEvSiH5yy6+PYqEPd81eHppLXFAeqYp2y+feX+Dp9fnqQ6hiHn3kNqAWDS7TbigMbWl48Q1QHPzB1UyZndQl+SIzek7imvuDO38AwY4NrYie7Xtjpf51Exa+hiS/PZnyOLbvBCqPXhs1EHHqE6GwFH3E/5qjwlhfVrwylTCM3H7th5l4FkZa7umt0LV/Lg7kQN7GLssOZt4mcUl/HwE5ptCWBckAC5+nR4jCdJtjYu3tZltM3PexGcwWh/jNIopp2LZax/Q1IWtyJBGXHAz4Z+8SSaOjp6kiwt7mftFqJx+3t0k44XJuhda8AZiOdS6SbbDrn1cNor8ToC/mjo/SV831/uFP/Mh2sE10mOlx2ruymScOV9/2uLX9Yal1n61PECIgje4NTMQfq9XzAPphZrGezMmkbq3anCa0qRgMa7R16FdSkIq/PmIqmEVdpT0GjIETxR9+HwI/vnuSZz4AVsMEoVmq/aftrStmpfYEMMKx8cJc6ACDyviFViQekJwLW4Nc91h3WVF6czSPwTltkeircYyHKa9/0+Q8mhtngXNrikqI54x8MOJCcxOjS9bdvQvAE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DSVPR12MB999171.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(7416014)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q1J1Kyt3dXhDK1ZyU2k0RTJXR3ZsWE9od29IdDl1NVo3Rk1Bd05DaFdqdC9M?=
 =?utf-8?B?aFhTWWR5Zzl2TFc3c0tEVUhQUWFvVFlsTU9wWWozMWtpbkdyeE9FSWRWOWpJ?=
 =?utf-8?B?cGJsR01SczZKVE9qRkwzTDE1SWlhcjFjekcyZk5Ma3hSdWFPWldyajR0RGQ5?=
 =?utf-8?B?RU84R2dLVEpNT01zNUJjbFlncnNQTnlaT1VDV2hUU3N4Y1pRNHNLV2xWQjVa?=
 =?utf-8?B?VkEza2hBZFZVaHFaZ0ttdVJPcXgvZW5jOVZSc2FYN0tUTkdERHhvZkNSQ0U3?=
 =?utf-8?B?MUMvKzB3ZGpnd3dJcEVTQkszTW5UQjJ3eVZybGlSbWxic3N5WVBCSWVSMkVw?=
 =?utf-8?B?Vmg0QjRRZHRMeGRZZ1lFdXc2aTBwVVRPUjNmVHE0dVlaTkZUdDNYa0N2QXhG?=
 =?utf-8?B?MTZPOE9MaUdLQnpialNHY3ZtSE42VUFvRlh0Y29PdXNTMjRFWHVkVjdvMXVJ?=
 =?utf-8?B?NGVGOStEaXBCQWUrRlpCMER5VFgvOGxBTlhMQjBnUVlzdU11ekR5SDBlNW54?=
 =?utf-8?B?bHAxcW50a1Z4M25yWXE4a1pjUUNLU0pLYnlQVFFnaUhEWHI3MFl4Q05XUzJJ?=
 =?utf-8?B?V2NQdk5wRTZUaDFscXlrRWZEMjg5b0VXMDFlcTE3VGJsYzVGdlp6Qm51ZGVv?=
 =?utf-8?B?TWJXTzMxVjFYSkJ3NTBQVW9YbXpGT2o3MGNqYTliZUhTVlVmWHpxZW9KZXh3?=
 =?utf-8?B?NXNVdnoyUkNvRHBFWXFoMkU1TEsrLzJFTnRuMWxqNHZoMU96eGVvS0xiZnpt?=
 =?utf-8?B?c3l0VlhGM3VpajFKdnR2WXFPY1Z5ZC9VMGtBU29zN014RHhIcG5GOGRNN25r?=
 =?utf-8?B?ektUZmx4YzNPMkQwL3dGOWtpMVlqSWNIalo1b0JaSlJOZzNCYmFHVEVxSUEx?=
 =?utf-8?B?dXFpcXVnNDd1U3YrMTNlT2dsZE9mRUpNZy9NdFAzZTJXMGlveDVSZnMvY0Zz?=
 =?utf-8?B?TmE0V3VGSnM2cWtDUEE1VkZnNUs0RkJITXpwY1UyckZRbm9TVnFvUlpRR1Ey?=
 =?utf-8?B?d053bXk5eEUxa2FqelVXN20wM3ZSbTFFODNxSmN0Q2QwNnIrUEN5WVRwS0hn?=
 =?utf-8?B?MmdYbXJUQS9KOE1wY0V5a3NtTjFzZzdIRnl1ZG1CRE90TjYrdkxpbmhkVStR?=
 =?utf-8?B?eUozNzBjN3hHLzlVZ25xbmZCdUF2N1lxRWI4TUsyajhRRVFubmQzdjZRZmph?=
 =?utf-8?B?aFMwM09sd2wvV1hZZlU5VnBnN2pqaTB6ME44dnpPY1g2QzVZbERyK2NDR0ZG?=
 =?utf-8?B?TytsZ2ZBa3pGRXlKaE5WdFlvRFJMTXNVdFEyUWRwNVFsVTQxMmZYd0hWRFkx?=
 =?utf-8?B?bE43OGpJb2EzdzNDSURoYUMrZXBadlh5cXR1K2FHa05VOUl6M3RDSVhxV0dH?=
 =?utf-8?B?Z0hYR1RzZ2ViSlUrd0VRSzZOcHJPak5zOEUrQS8xa21KWmM2ZnFIRVkxcFkz?=
 =?utf-8?B?M2lNVW9PbENCZlVpUUU5VnAzc09LTC9QcDNtSC9BYkZtRUErUjdrRCtNZkJu?=
 =?utf-8?B?TTRiallNeVdOb0Y5WnFOTUdYcGw1TXY0Znp0ZDdzb2F6Z1FScnA3OW9aNXVN?=
 =?utf-8?B?Y0lkSXE3aXY0VWVtMk1RWmhXYjRGQ0pnN0FPR0E2SlllMTdDWXBVTFRvaDlX?=
 =?utf-8?B?R2xiVmRBaVNjMlNhTy9mQkJMQ2l0S2VPRi9veC9sRllDdTdEaFhGR0o2Um4w?=
 =?utf-8?B?Wnk3cEhvMUx2dTRmZzBvamRuUThJK09GVUw2eGNaUXZtTGgzUUtweDM2TVRZ?=
 =?utf-8?B?dzF6MkNqZWpZL0UveE5uZTMwejdSTnAzQ3d2RHBnTXNQQ3djSVZwRXZGTVlC?=
 =?utf-8?B?eVY4MFRGWVoxNWZncWRLS1N4S3JZWWVPR281RDFqVVdicVVLaTNITS9mWENE?=
 =?utf-8?B?b3kvMDNOWUhjY3RlRWJaODc2andwV3o1VlFGSThFZmVFSkNGTS91Qmc0YjVP?=
 =?utf-8?B?OHgzUzc4NnB4c3NERTFDSVZ0SmxUVFVmTUNTNTBFeHRrYkFCMFdBOHBSL2V5?=
 =?utf-8?B?dHVsQjFzQmtoVXhnWWZVT3d0TDhNYzh0SDNiVU5kWCszMmVvWk0wcjNGOG5x?=
 =?utf-8?B?aDI2Ny9nclFSN09JZTZTQ0RRQ1UrT2tRWUV4UzlkbGNWcENkTlB4ZVZBbjBw?=
 =?utf-8?B?aDhoS3J5ZWVzUms0S0xHZ2dBci85SjlTY1hYdWpyUGd3eW5tUStVTlgvTEtt?=
 =?utf-8?B?cDBsNUliU2ZJajNsOHNmTnhGNzdXSWhBejBMZTNHZE5BRHVteWtqUnhjQlc5?=
 =?utf-8?B?d2ZqWFVtWWk4Rjk5NzhOV0dCSitFSEFVWmJMSS9JNXdVMHZrSm5qVVFta21Q?=
 =?utf-8?B?U3NNSWVtOU9xMnlvcGx1T3ZzSjB1SWRzMDkyYmRBTFkzSWdoZDgwUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a744b57-035f-4934-b2e5-08df1ed21263
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999171.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 09:06:11.3647
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QhnYGJMAUGIVcXQ5aaxLsifV+/f61s7gWtyLjJ3wMLxCf3TMnuuJkl9Tv5cA+mdJ9F2CxBsOBa6zM/jtjDCqyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6200



On 9/22/2026 1:57 PM, Guixin Liu wrote:
>> diff --git a/drivers/iommu/amd/viommu.c b/drivers/iommu/amd/viommu.c
>> index 89d6dc520b2c..3ec907a498c2 100644
>> --- a/drivers/iommu/amd/viommu.c
>> +++ b/drivers/iommu/amd/viommu.c
>> @@ -40,11 +40,55 @@ static void __init amd_viommu_vf_vfcntl_unmap(struct amd_iommu *iommu)
>>   	}
>>   }
>>   
>> +
>> +static void viommu_free_self_dev_data(struct amd_iommu *iommu)
>> +{
>> +	struct iommu_dev_data *dev_data = iommu->viommu_dev_data;
>> +	struct dev_table_entry new = {};
>> +
>> +	if (!dev_data)
>> +		return;
>> +
>> +	amd_iommu_make_clear_dte(iommu, dev_data->devid, &new);
>> +	amd_iommu_update_dte(iommu, dev_data, &new);
> Should check viommu_cmdbuf_enabled() first? If enabled then update dte.

Right. I'll fix this in v6.

Thanks,
Suravee
