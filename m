Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED93E148316
	for <iommu@lists.linux.dev>; Fri,  4 Oct 2024 11:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042934; cv=fail; b=l/diOW7uC/mPhjMm2EwnvjPuBPmWGaMDecOXFZ1lJ75lib4gIuKbLoYu9ea5tPUsBwaujjdG77t18p9tORCGpjfXZmFAyXM5yWxp9TEF1oxs2s+fWRvD2O+N98hTnmz8tt+L6PeGdQ+HIc6AIbw23+liWjD6OrCh6og/RwC/UYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042934; c=relaxed/simple;
	bh=sDprpgEFB5NgEJF9QqgQWtWEq3MbV5/yYq7FVkGWZPU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pBq7qVIUyaGiZoNmDIw9VkmUoSuXxQk5ofCjn8OhueUgJuHhHJLpHpBKNB+lsyxWIlqCrFcNgAmPsFiIl625fJ4AUUQqgKgXFHcseZ/YLgHIiZ+upFKYlUS5LVPKAvI8xFKS8+LV94QfBLlMrkrwVt4zKfg62Ksu5dTnZBRrt2w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=iZCyfVz/; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="iZCyfVz/"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSefc27ftwGXK7l9Jr05VYXbZcwZAbJ6HhYQvSnmtGrwY3Xq8hOPWiOIA6/G/0WqDu+D/AB74dsCjQdj1W2J2qmvYhhIabduT+aEIiKjxyt9Su7CYr1RG+z67sDl2Ra7eLkoKFAsuhqkljZTMrJSQKEYFhYqdbZYWipjUgS9S7LbvEj2b+pB5ZNxLiJCphwC8zI8Ai65o36zXNLmzLcngv7rVO0CWWUc8I+Ka4cEIkCJ0GVgoQjuoZ4XMHej7ewIEbqCKUYaV9RxwQx6r3gjXuREpD5fimoScyA7W9JDirsaCwQMHHDLg9DXUULkx88nuJheWEoNi/6o/IliiV/F6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6C7Ukv43Vvg90v9HDTohflb14fkgi1/b5K3mVlqKl7g=;
 b=FcjUkT9pdPqaso9PzLN+sdYK8pSfHqYalkg6vAv6wqiO2bI5fPSpXOiygqSJyLWfx4DcHUHuCMudaz3ozPK4AeRXqy4HkKhC3Yzui9hsgaqucz74NpsVuVU9A5nlspAm6CYg832e+cVMrpNVNCZOZE5YcnOsnNzWACdmoN0xu714Qpau9viMTDOtjsL/zJ+q5gvzgXsHwMT052fV5uZPUygAUsFRnHf8Wq3kEYPNMeg2eXj4zwHRm74wZQtBCgfGz2a3tcjrny6+vODycPbvLKQXpTbNkfLyGIIJIRPlwwHRtQS7h+w0W6cOdZqXwCi8LHmZou8Ry+MHTIUArbjKjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6C7Ukv43Vvg90v9HDTohflb14fkgi1/b5K3mVlqKl7g=;
 b=iZCyfVz/Ja+cpRl8m0wNUWVzcunjh+XGd8gtQ+pjjUmAiRwa+Zaok3EYXXNdppzzQ6HnPm8VvaTPCmZ7geEQUv2tH23IxGJmyLb+IAXYVSNbSPc0v2WFUtmefyGzyKr3P27WPEVXIGHMmag7Q9Vlj9LWCHfA2X9nY3yC5hwk7jY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS7PR12MB5936.namprd12.prod.outlook.com (2603:10b6:8:7f::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.18; Fri, 4 Oct 2024 11:55:28 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 11:55:28 +0000
Message-ID: <1f6110a2-a21d-45e9-bfcb-7d3650ff889d@amd.com>
Date: Fri, 4 Oct 2024 17:25:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] iommu/amd: Add iommu_ops->domain_alloc_paging
 support
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20240911101911.6269-1-vasant.hegde@amd.com>
 <20240911101911.6269-8-vasant.hegde@amd.com>
 <20241002193345.GR1369530@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241002193345.GR1369530@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0062.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::11) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS7PR12MB5936:EE_
X-MS-Office365-Filtering-Correlation-Id: d71cd4a3-bc0c-4554-147b-08dce46b707b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bWEvalBQazVUWm1ZekdZaVIzcHZFLzdFUDAyeFdONFYxaFZzLzJDM2lzM3Fk?=
 =?utf-8?B?eUxyclZmS00wd1k3cEp1RS9ERnY0dDZTMXpBMHQzbTY1QmR6OCtEVzN4bk45?=
 =?utf-8?B?OVYzdDhRRTJmUkdSVElUM2VydDJnalpoeUxMWURFVFBqUUh3UkJhK3ZiSkk5?=
 =?utf-8?B?V2ZWZXgvMXF5aXFFNHZpNWhLTTV1Y3pWVmxwOTh6am11RUJHZklxc3R0OXAv?=
 =?utf-8?B?YTNoem8rWmFNU3lhaS9lbzA3d0F6VDlaakxzZ3dHVXVYQ2ptb0lHdXFUbTVi?=
 =?utf-8?B?dGF6RXlPUGdGcU9VQU9ZNkRJQVhLWTUrM1o2NDNuWVE1YktqdUk1THoxNm9h?=
 =?utf-8?B?K3NvR1VFS25hYTlHS3dqSDlVemJ0c1RNK0paSjh6aFFlREVsalg1R25kdFcv?=
 =?utf-8?B?ZUhiM01CalIwc05CNUlaMVFGYlpWSjM5RTBOYlZIWlh5RCtadC9PNUo5aGpn?=
 =?utf-8?B?MnNxRWxDbk1FUGVzTVdCSnB1cUhNN1FuRWY3NWhidDZRMVlNMEU0Umtxd3Ra?=
 =?utf-8?B?V20yQ2hsd09SMmEzVlFBc2Z6VWVRUy9sbWl6aGF1MFZWSW1zNGlidUVTMXlZ?=
 =?utf-8?B?bGFxcWNNNUxVRFc2NTQ1T3BiWDBsN2lNcEtYcVRsNWlxS1JYOURXOFN0bjNJ?=
 =?utf-8?B?R0lxeW5DK3NleWU2dFBsRGdaMDQ1MWloREk4KzBYZ1hnMEtsbytIbndEY2xK?=
 =?utf-8?B?ckZTMXBSdGdDUlNnZXRRUVM1bno4WFZGN0xxTFZ0WHlFaTZhNkczd2hvM1Ba?=
 =?utf-8?B?S2QvWWNmRll0VTU5U3JNMVBQaWYwRWVoOElnQUVxRUI4bUI5RkJDMmJEMmJJ?=
 =?utf-8?B?dElVY0F5OVlkQmt2Y2pHc1NjMHNjbzMxTUZ4VVJjVDdSQzVMNEE5M0p3M2tS?=
 =?utf-8?B?enUrN3VOdGZOVG5XVTdRSTZmUHBHUTV6cEtuelBwbFpKZkdMZUZjc1c3SW9C?=
 =?utf-8?B?V2JYV3F5MUUxNnlwa0s2OGhxSFdDTjZSS0EwaTh3NlhVV1NVTVRuM2JwdUhX?=
 =?utf-8?B?NFo3Z3Yzd0Y0cnJ6M0h3ejZrZy9VWXRkQnBkeERaT1c3NnBGWmc4TXZhNEQy?=
 =?utf-8?B?YkoxQVRqZmFQZFoxTm12SFdnL09NWG9xUXZqV3NLekx0T0p3N1kzUllJYjV2?=
 =?utf-8?B?U2ZWVHM0c0x0WVFkU2haV0NmbmJjeVh2VnhLcG96K2JBdEhiMGNpSEVwQWh1?=
 =?utf-8?B?UDY0d1psSTJ6bW1HWngrY3YwcFNnQis4d0VWYlBjQVBKNVRqR3pscEkvNWtk?=
 =?utf-8?B?TW5nSDQvQ1M5djczc3dLTjJoSEdUOU1xNUN3UXppUUxDeHdiUVdWbC9TazZr?=
 =?utf-8?B?TG4rYjJndDFNY1BLdlhpa2crOFhydWI3U3V4OHN2cm9WSmFTbHZRSmhVVkRX?=
 =?utf-8?B?ZStObUdLTDA2UHpYN0tvNW1EM0Z3YUYvNmFBUWxtWTJVSGNBaVdGbzQzUnNX?=
 =?utf-8?B?SVpMcDhDN1hVenBGQW5VUlNDZ0lkUThieXBSc3VjMUg2RWVxUEFVeWMvcjdE?=
 =?utf-8?B?RitBTUtjNUdjUzhUK3JmWW0xK1hoYzVEQk03L25QN3BQOUd6L1VsRTB2Mjlx?=
 =?utf-8?B?SlBWREhWbkluTDRKZ09TdWxpUk4rOHdzc1lxU2hFTnVkV3h5NnBHUzNlbUNJ?=
 =?utf-8?B?aFNlSmxCUDk2ZGFzQWRZTyt5cmdWbm5rY2hhTnJrV2FvSlZWZDBHWkdXZDZO?=
 =?utf-8?B?MFJReDBOQmZOdHdGdlNQbHdYbTBOejhVWVp6d3FmWmNJVENTQnJTd3JRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2Z4OXJOR2RjZ012RTc5V2NtOUEvc0ZOUkswbkROdjhuY1JMRkVBdFh5Tml6?=
 =?utf-8?B?eGlvcTRSSDBhNFZLRHlhNVhMNTZoQ2VKdUp5U3pMZDF2c3VxU0twTVRFZUdO?=
 =?utf-8?B?aE9DNjZldS9DalFVd0tQeDdzT3NZaUQzWnNRaE1tclhDa3pXaWVXbzI5cEhT?=
 =?utf-8?B?RUxKTjZkVzVyNFVrQkVvU0NSVDBqSEpkYVVWV2JkblhETGZSSjVzQTBuNkVq?=
 =?utf-8?B?MzdlcjhOYndlWjg3eVZmOStCbjA3QjY5QU1NQTZWNG84enFlL3RYWnpRdzg3?=
 =?utf-8?B?TzdGNVNSVHJVNkdHbFN3TTdqYmUyYlBGd2lsMm1OWC9CdXYyaDQrNzZYL3VF?=
 =?utf-8?B?di9yc0xHWG15K1BYYVpscXBMdzI0Wm9RbmJlVjI5cFNyeGp6blJ2WU5DUTF4?=
 =?utf-8?B?aUlUMTB2Sld6azY5SU1EeXRmNnRrRmIxREFJNjVORkdKcHIzV3RGVExQVjQ0?=
 =?utf-8?B?TTRFdmgyQklmaWV4SWpjajlPQUVaWThwYW5XRkxCQzFkWmc1Vm81cHpzaGFT?=
 =?utf-8?B?NHZGUnNDZ0I5Z25KY1NhVUJ1QXdjM0xWYmxxSDdKandpUGVkQ2VCZS9FOWor?=
 =?utf-8?B?K1VrTjdORDlRRzZIN29tYmgreUxvdFJrcFdPS1lmbWdnTllkeTE0VklKS0Z4?=
 =?utf-8?B?MGZvUG9XT2JjdWFoTUMrc1VCdVNycHVuNzkvaXRUbWxoYXhwV2txMG11ZkJv?=
 =?utf-8?B?OUN4bnpQYklNUXF5ZGVMRityT1hwV2s1aisrMFpZZ2ZrbFJvS1RlS3IxcjFZ?=
 =?utf-8?B?bW1nNW9yVjlFNFlCclJGdGxpajRBUnJBdnRibEE1SFkyWDdqMmRmMVB5SmEv?=
 =?utf-8?B?clRveVZ0UDRBRW5OVWhySnY4dC9MYnNocUxBcFdBS3VhajhoNDFnMnhzdG95?=
 =?utf-8?B?K0dheUNLdWkrUitiSEJxbVNqY3NIMHBWNDR4TW9Ud1JDTHV3WFdxNlRBT0wz?=
 =?utf-8?B?a1RGb1hjRUh5dXJwRi9LeGxkejF2SjgxNVNUR1NaaGxSSjJ0aVNxamFWOW1W?=
 =?utf-8?B?WXFwSUFjWHFpVndyYjAwdWdTY3JUNUZ1WHpvL214TXdzSTNIc2FLcm1ZOVFr?=
 =?utf-8?B?c05wYTdidmptTTF4cVBaNTFBbklnbHNXYnBnU0hWTHlMV3VhWFR2ZWk5b3d1?=
 =?utf-8?B?YTBTU3hvYXVGQ1FXS1lzVVY2Y2o2cXc4aTFrRWZhbmtTRkcxOU1ZWU5MLzNW?=
 =?utf-8?B?UUdRbEcvWmVqKzNEVEZPbDcyamw4cHArbzZuUkdwNVRaaE9Ea2paa1J3UStW?=
 =?utf-8?B?UXNQZDZudUpScVpjWXFsUnJEWDAwWnJEZTRZR3pPSzhuOCtkNHhqVVJCMlFT?=
 =?utf-8?B?dFNveW9JVFRmV2kvM1YzeWtCcjBGZHgrYzAwQzM4MFVJM2lHMGFBRWNxTmhu?=
 =?utf-8?B?RFQvaFFGa1ZxUEEzZUdsWnBZalRPa3N2KytESnF1blhheGhvNGNJanRHZkda?=
 =?utf-8?B?ZDFCeWJ2a1ZwMFd3TGE1b3hEa2MzMEdhUmFVWGwzZk5HbktLZ01oK1lVSjlH?=
 =?utf-8?B?NHlsbUV0QWc0ZVBqZXNJeVpGRFltaTZidVNWMk9jQW5Vajl4dm4waG1VTjhq?=
 =?utf-8?B?bThCek5XdGJMSGxHaDBPQlFyL0VvKzNGbVFSdi9yS0tFd2dva3Fhc3lTMWVw?=
 =?utf-8?B?RUtTV1g0aXBIaU9zUHVjdmp1MnBnQkFwU0xjSElEMC95UEhXQ0M2RVdJbmFV?=
 =?utf-8?B?SXMrRWUyeUYxWlZVUmIvNlZER1N5VStQS0Z0ay8wZjYyTFB0TUUzRzhYbEl3?=
 =?utf-8?B?MUZKMkM5eHF0Y2VGRUduNWRsZ2RubmpGWVJFM2RqTGR5NTdoSU96aGlPSVRX?=
 =?utf-8?B?MzlpZjcrR0VITlN2cG1jUlZyUzlEUUMzYVB1TFRtSmlsYWVFb3N3K2NuNXM0?=
 =?utf-8?B?aC9zSUQxQWV2MzNXY0Z2OUZzRE4yQTJsS1N6V1BzN01QZjdJc2FsNDQyMmJW?=
 =?utf-8?B?eG1hUUJwZHhaZkt0RnAwNGdRRjhwN2lDMkZSaE1iRWxNbklvUDdsM205Tnda?=
 =?utf-8?B?bVJTQWVQZnFZVkhDVURsV0FxNm8zL1R0RFhPdWN5YkhDNmdxdG9qUWFDWXFG?=
 =?utf-8?B?RFdZcE5ZeFFlOVo4dGIvUmJGeUFpM0xXUFM4S0owc1NvajVjblpldm1FYmQ4?=
 =?utf-8?Q?6sLQ7rEYnuP4jECgJPOx2nJlp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d71cd4a3-bc0c-4554-147b-08dce46b707b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 11:55:28.2728
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEryFfTlTs76BA+GTgGkQ3kT5olmFcLoFxSk6+4NwcPAI/1+bXVMqGiMYmEWgsbflTUY9q5YVnYqNVc6xpaFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5936

Jason,

On 10/3/2024 1:03 AM, Jason Gunthorpe wrote:
> On Wed, Sep 11, 2024 at 10:19:10AM +0000, Vasant Hegde wrote:
>> Add support to allocate paging domain. Note that core will call
>> domain_alloc_user() to allocate PASID capable domain. Hence its not
>> checking device capability and allocates page table based on
>> amd_iommu_pgtable.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/iommu.c | 11 +++++++++++
>>  1 file changed, 11 insertions(+)
>>
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 1c9e539f15a7..e6b4460c485d 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2395,6 +2395,16 @@ static struct iommu_domain *amd_iommu_domain_alloc(unsigned int type)
>>  	return domain;
>>  }
>>  
>> +/*
>> + * Allocate domain with default (amd_iommu_pgtable) page table type. Core will
>> + * call domain_alloc_user() interface to allocate PASID capable domain.
>> + */
>> +static struct iommu_domain *amd_iommu_domain_alloc_paging(struct device *dev)
>> +{
>> +	return do_iommu_domain_alloc(IOMMU_DOMAIN_DMA,
>> +				     dev, 0, amd_iommu_pgtable);
>> +}
> 
> I think you should avoid this. The _user one (aka extended) should
> handle everthing. It doesn't really make sense anyhow, as the legacy
> VFIO path is going to take this branch as it will have 0 flags.

I should have been bit more clear in cover letter.

I thought eventually we want to remove ops->domain_alloc() interface. Hence I
introduced domain_alloc_paging(). I didn't remove amd_iommu_domain_alloc() in
this series. I was planning to do it in later.

If we are fine to keep ops->domain_alloc() then I can just drop this patch.

> 
> Can we just get rid of amd_iommu_pgtable ? The logic to do feature
> negotiation with HW support needs to be embedded inside
> amd_iommu_domain_alloc_user() anyhow
> 
> And the two kernel command line options seem totally useless now that
> we select the page table format correctly automatically. As you've
> explained the v1 format is always better.
> 
> Maybe the kernel command line options should be revised to force ONLY
> v2 format and ONLY v1 format, but that still wouldn't need this
> function. But also maybe they should just be removed.

Yeah. Some enforcement and cleanup is needed in that path. Its in my list.

Before that I need to fix few more things like amd_iommu_def_domain_type(). I
have few patches internally. Will post it after this series.

-Vasant
