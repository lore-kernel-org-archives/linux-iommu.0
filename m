Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 171F027E056
	for <iommu@lists.linux.dev>; Mon,  6 Apr 2026 09:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775466243; cv=fail; b=JStNgmvq7mEZu4yqtbg+e6Fh8Q3z+ojrZW/YyFxc7vXbhOanob2E5bQEXnQ2ZIKL4UqMxZrS5EbGKhN/khsh2lmLQZ8GoSmysYj+LFNl6pj21iNLHMU5HYoB5y/L3ZDJE3Ds9Z7nes7sRXTr+SpO+AbYRg+t9al69wNVj1vVW+k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775466243; c=relaxed/simple;
	bh=WQIwzg4qXeC2s5N+Zz8F6PS5lbAAGSFxEhnY7PRw1L4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MmmN5C0jw+nRzyUnS5Thb3BACUNSjny3uHkgCZVc5nO3L9yIV7Dqw3ia8TLOxnkuuKUEBtksnW0O8TgaXs6CiNmXj9HxLzDCv1HigLjmh4gP9V/1CJqUztcoHgqUnlQu+jRoO6BIvbxzdhUdMnoeingZaqwDalOM6Enwi+qep8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eP2Z6wLu; arc=fail smtp.client-ip=52.101.53.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eP2Z6wLu"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yAm8nBmqjzLooFZUuygUI+cnBMEELT2BhPywy64Zhppt3qjTgm916XnYyZpNKA8zKuOVMljfhYghOLin/4fZmYyusjxmzgEWgJLB2+r8LziOKutRn5DBd7GAOyLv+Dlp1U6elyRD2Youg8ApZXZKTX43XwOFHVaIEDk1oUNKsTv7O0nu/yfYOHRTEee5YCu7/SwVZ3O3we2h6XrrNqgOrE+ZW6j4vrZFLrk4iuNHiXBLCsRVXP/0ZK3DdFgiHcovu6FFuWQ5NSemmmscwHKLRW19IS8giNUXxcdg2DO0C8cc9sxj25G2ZzJkk0a/fV5CYfC22CoA57dikQu5VWDFRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aMGlQmhei/+5h5J75Ib8B3D5XVxImc7AQ0ExGvlnCgs=;
 b=ydZo0PbmIZboAfgZkau6qU1/CzQCsRKcogOlftgr8eOhd4NNDz+bQ6kgX9vWiLs6ZYUP6kHY2FbTccmcUPBoWOng1ycRZ5vCmdctE9Q9rNqAaquhdnEcQbXLLYF7eXemSOzZWbbyeC6TjZp3TyvRRkgxS4sQquEp2oc05lkg6lNm6sgmzhcn+ZggetzfXfPBOgkPu2IY0fpN3MckNKdEn9fXgpPfwqVCwKHBXI0qNh/zNAULO+v74t8DOIhePC2gc4151iTYHxDffRrXxPuPbT6GGyI+XOSduSP/tc992do/vW7H8yiKggyRcQN4B2VHR90Bo2rjDPE4MXYrW/fy7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aMGlQmhei/+5h5J75Ib8B3D5XVxImc7AQ0ExGvlnCgs=;
 b=eP2Z6wLu4hvcS9JdQUMSfqdmfghyQgpIiQJZ9wxny2f/nHnMaiQJImMzPiE7FlYZDjn0w7HSUDX8xXTegjc+1QnwDxoEQFylymM3wU/m0rVebBe7BM27asBPuj6zoXugfIj/eNN3f/iceGttbxSk3V6xFcRfzjzA0AzuzBnVMfc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DM4PR12MB8452.namprd12.prod.outlook.com (2603:10b6:8:184::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.18; Mon, 6 Apr 2026 09:03:59 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::b5e5:12ea:9815:b7d4%7]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 09:03:59 +0000
Message-ID: <009bad64-e49d-403d-8dd0-0296bceaee23@amd.com>
Date: Mon, 6 Apr 2026 16:03:48 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/22] iommu/amd: Add support for AMD vIOMMU VF MMIO
 region
To: Weinan Liu <wnliu@google.com>
Cc: chriscli@google.com, dantuluris@google.com, iommu@lists.linux.dev,
 jay.chen@amd.com, jgg@nvidia.com, jon.grimm@amd.com, joro@8bytes.org,
 kevin.tian@intel.com, kpsingh@google.com, linux-kernel@vger.kernel.org,
 nicolinc@nvidia.com, sairaj.arunkodilkar@amd.com, santosh.shukla@amd.com,
 vasant.hegde@amd.com, wvw@google.com, yi.l.liu@intel.com
References: <20260330084206.9251-8-suravee.suthikulpanit@amd.com>
 <20260331055539.4026383-1-wnliu@google.com>
Content-Language: en-US
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20260331055539.4026383-1-wnliu@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0020.apcprd02.prod.outlook.com
 (2603:1096:4:195::7) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DM4PR12MB8452:EE_
X-MS-Office365-Filtering-Correlation-Id: d05aae55-8258-4b3b-ea07-08de93bb7068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|7416014|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	tnM1SBOJhMcRzmS/75eG6PpZ3mCWp/wQTNgN1HHpk3yQG6QljczDBgc0S47Je8TP4akp3Qz0IbRagjkGkBsDpZU10tdKyowBDu08IJuQYmRI+0flZ0HvU52UjGQDN7xu0fMZ1KSi1vu3DGBmnBzlg1LwL+Z5rbbCKXduAeguXP2xqtTzf0GDRNKTDDOq/voVmvJ979ukg9mS4JsbpwvhITjU0ifKMsbG7XDhIGI51U1eHC5dQEaWlz3lx9NEQVfIVHTSHbsEGuxs3JoGBoiLgQ93cG9LSvjzeDjkyyVmbUng4wuctkMUfK2Vi9FJNud4UE/aGkzUR85pyoZBLDKL9WRQH3f9AbpXVw1s+KiVYL1Xw+8yt2Ly6XLlZ49ChrU4t58bi7OUQdECT4x1uZ28zi9veSBJ71qV6dAYHPz7hLAJOG43c+szF3AaNevJDGnjPYHaOul1qMOM1KOBbZYwXWzagjTZid753g4vaTUBBiBH97p7M2qkbpx7ZaQIbABcfIvJ4iv8iLH1c/IzSk2lsStVUXejCy5kJCudWOCrsFyEBYs9Th3Wu4gydD7l4RNzPV1gTTNcutDdXzK90jAntT5yvYYwZrtkKimGDn9BdlLRov0z5O3B5dme/MftA4qw+UNUckrdkunm0642iwi45CI3n03Q6s3QYvhBlvewdFJG44KQKTUePeFjS0ikzVZlFt34xDYM/e3vXUqYP4nS8pbc8mJfp1YggXl8JsX2nt4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dFlCZHBjVTZucnFSYW5WQVh4UnhwM3VMVm1vcjRBWG1lYU5VV0xJUzZPblRN?=
 =?utf-8?B?RXEraEs5NFpKQlJmL01xWTN6NGY4WWRrdkN2V0IvYlJ2TWc3MGU4VjJpQ0o1?=
 =?utf-8?B?VXlqWXNIazY0L3RwNE9wdU5Mdm54bTQ5YWkwSTM1eVNWTFJmaEVZMXQ0SEIx?=
 =?utf-8?B?TVVveUtaRkZLV2djVXVmM3R2NnB6MXRpa2tRRDhLblhmRXp2WGpSZjJEODI2?=
 =?utf-8?B?bjZqQVhwYXNiNldJeVZNWVVlT1JERlpjdFU2MVZoUUNrYUpnbnlsbVR3VU1n?=
 =?utf-8?B?ek5VWWxrdHVwRk1oWkNMa3FjVVFrM1pKVE8rYmxzYVF3VDcvZEMwUWljY2Jn?=
 =?utf-8?B?cS9KRmRkSWVibUlIMFJxNDkzb2xrd2VVWTUzd3BNdmFMb3BHZyszK0Q1VXJh?=
 =?utf-8?B?N1M1K25QRGhZYkZuMzRmODVlbVdUQm9hNTd5V3E4Nzd1YmpIdzBOTVMrOUp5?=
 =?utf-8?B?bEZjNVFGTC9DVFYrQnp5cjBXYkpBbThHOGthY0E1VUNCMWZGUGFhZTdYYWFI?=
 =?utf-8?B?WUtHeUJVQm90c0NNSjhaNXkyRG8xTVg1cHpMcHY3bHFyakxGcTZpMHFsYnFT?=
 =?utf-8?B?dmh6TlVzQVV3aW9JUktlSmpyanV2c1NZOEhBc3ZPTm8yWkpSeEJiUk95TGVu?=
 =?utf-8?B?RkJFekFlQ0VzMEozTk1mU0JrVHNDaENSQk11UTA0c1lDWkxDVFB0L3ZJc2ty?=
 =?utf-8?B?UDdHQ0l6NWZmcDJWQnNRQVZPbFc2SGNFaXpCRXFSbUR5SGZ1dGZrZ0FtdFNz?=
 =?utf-8?B?ZXZacnRvcHJvR215Q21DbVgrQnpmYW9vWWZrZE9TSmowTjNNR2E2VitpM1Ax?=
 =?utf-8?B?a2ZRYUNjMjFvWEl6L3l6eUozVTlidzVVdENFNHQ4VWM0QVJLSnJhRUxKRXJj?=
 =?utf-8?B?UXBKMDM2bmNvTWkwT1MvZGZqc2RGOWFSY0Q5OHd1eis0b0JMZzZtRnp3VERW?=
 =?utf-8?B?UmN4WUI5aGNVKzM5VTBDbkRqb1lkQnRrWWk2TGc4OGlqbWd1SENhK00rTmxs?=
 =?utf-8?B?TC85V3l3Wkc1TGt2UmIzQXdqT3FpRkwvTXdWck5zdENIWGFuczFiV01ZNFh3?=
 =?utf-8?B?UDhqSmIrWUVPc1pWRUFtVHZkUWVWRUg3WTV5RWwzcUJFMjR1dUwzNDNlcmRE?=
 =?utf-8?B?em5iZytKSjVtL1RiTmZHU2dTUGR5SHlKcDFBanBZU3VkYnNORHcwZkpYdHNk?=
 =?utf-8?B?MGIyMU15Mnhxb2UyVnhBMVJtNXhHWWZJeVh5VTNkU3h0aUYweThackZORVh6?=
 =?utf-8?B?UE1OdHh2cWZUQkpsRE9kWXZIVzI3WDFnK3gvdTBHd05VWTJGU2JCcHZGZmE2?=
 =?utf-8?B?TWIrTVQzRDhDYWhVWWVMdGxoZzNWMmJNU3lBYUhXdjQvcTYvZ0NzM3ViY0sx?=
 =?utf-8?B?cTVzc2pJRmJhTm9HRHJSSUorZnlCa2pRM1MvSG1aaDlXZmZBRDhWenYrQlBY?=
 =?utf-8?B?emlkRytyRGRJSVpaUTZKVzZvSkhrc3dDd2w2MjhjUjl4OU0zQk9BQzczcXlr?=
 =?utf-8?B?ZGtEUE9yNi9YVnhZdDczd0wxajZWWjNnems4OXZGRGtUTWI1eDM1MUJBVSs5?=
 =?utf-8?B?VlRpSkpaL21QVzBrRWZVeVlOQnBiME1md24vNUtvZXJDb0lXSGxraU5lZGU3?=
 =?utf-8?B?UkJkczhxd0theHIzTW9VTS9lU1Awb2pxOFJIK2Z1VlhrOXpxVHpZSnZjVE9z?=
 =?utf-8?B?cjIvVlNUWFpLTkpXc04ydlRLUTV6NzJoMXF3Yzh4UlQ1R3lmSnF0Z0ttZlRK?=
 =?utf-8?B?OU45U2dHdXFWQWVvbGhCSlY3THZVMEI4NEQ4UWtXV0ZlVk1WVDdZc002THM4?=
 =?utf-8?B?TkdJdDNGVlFUUldUdTVmMlpNb21YTzRBZDRxWjg5VDdXazRaZWJSUE9SdmxT?=
 =?utf-8?B?Z2tTcEdIVmcwKzQybU5pNU1kQk1HbjRneCtxWXErWkszQ2N0NG9pNEdvaHhr?=
 =?utf-8?B?THB5emNpZG9GM1VrS2tDSkN6eitmck0ydmd0L1djL0FTRHpKRTlvOENJUlZr?=
 =?utf-8?B?QStEWFFqS0FTZG4zcVNwM09JTlNsRFlPRzhqU0RPQ1ZULzgvRnJwcnY2SGkz?=
 =?utf-8?B?WGUwTEVxUmtERzNlcG5IajlCRFc4N0FxOUpmVEZiZ3V1QklTVS9mQzNKRWND?=
 =?utf-8?B?djVTQTBvNUNaRTNZd3Q1ZEdTekQzSit2ZWN2QVJXaURSTnNHU3diMmNZZHhH?=
 =?utf-8?B?K3dOUTM1bUlnM2NyRTYyY2lGRTJTYjRESzdrMzRiS3JvU3YrZ0xqRmZoQ3NH?=
 =?utf-8?B?UjZKYXlBYWI4MFZhbDJXUXZYOHEreks2WmhPRkhpS3dSZ2Y1SDZESzRWeFMv?=
 =?utf-8?B?U2tQWThUelBUR0FCdjI1UW02aVhDN3pHTkVUUFhyQTJZeFRsV3Y0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05aae55-8258-4b3b-ea07-08de93bb7068
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 09:03:59.1460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q22ZlXbN3ChYBKGS6HCkZQwr2opdA1435ZAjfH/66vXfGRQIH5JdEcVMK8mTwwpnjeRifI5LM5/A8B8EVl0sfQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8452



On 3/31/2026 12:55 PM, Weinan Liu wrote:
> 
> On Mon, Mar 30, 2026 at 1:43 AM Suravee Suthikulpanit <suravee.suthikulpanit@amd.com> wrote:
>>
>> diff --git a/drivers/iommu/amd/iommufd.c b/drivers/iommu/amd/iommufd.c
>> index 6fba5d9b1310..5dcd3fc3ba99 100644
>> --- a/drivers/iommu/amd/iommufd.c
>> +++ b/drivers/iommu/amd/iommufd.c
>> @@ -66,11 +69,21 @@ int amd_iommufd_viommu_init(struct iommufd_viommu *viommu, struct iommu_domain *
>>                  return aviommu->gid;
>>          pr_debug("%s: gid=%#x", __func__, aviommu->gid);
>>
>> +       page_base = amd_viommu_get_vfmmio_addr(iommu, aviommu->gid);
> According to the below implementation and prototype, amd_viommu_get_vfmmio_addr() won't return negative value.

Good point. I will remove the check below.

>> +       if (page_base <= 0)
>> +               return -ENODEV;
> goto err_out here as well  to avoid leaking the gid allocated above.

This should no longer be needed.

Thanks,
Suravee
