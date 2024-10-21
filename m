Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D426B1CF291
	for <iommu@lists.linux.dev>; Mon, 21 Oct 2024 06:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729492760; cv=fail; b=ZutrnyMDkgZsct5sqfYt4gh6CsGtRP1ZoQE1dUm17iqWdT7J4iRkjs/0MC7YoZ843NR3UpVFw03SWpvTaPRBm6YVb4mPkY7ZCRTBeCzXVJEInnkJv4y908GZHUw1R+5RZgG1xZvUY3Ln4XTNBADKekK5kH5uvEw9WIOB5k3tZe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729492760; c=relaxed/simple;
	bh=6LOVBZK5FvC6BgE3OfqPQe06iT9PZS+q+tGRKI7FPE4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NmPuxroHTTwT+qmYvuM5mWzNiBmGNoJ8wVscR0YtThkC6ZtcRXRJzrbrO1lfHJRl1CGU7W1GMcOSrKh4MWV44ouu0EIVoIJMG886zNh/jpgXnM28y/1O8NoDDrS3MHubgiylegwdIw1H8AU++7Pggrqq6injN79YBoSH9xVvAO8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Tk8NS1kj; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Tk8NS1kj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEs5uglTOoxgBphnWYAKlkmVK50a0UlBpC7OQfbiPh8SoqNwSm4E00Vj8XH0AEQFe4eGvidL3gEi5lBA0+0If8DhaZFnXcdZ1xiM3VrPbq+xSPHtPTdOvXCNFHtUbZLWfOquAqRo/2gfVS16rcgD3B1RirlQLX/c0hqnvaggsYCtXjlKLI8eLPDGASC0O4T1TX76lz1Zqty5RWIVAr0iitWZIojDb8CuqPU3LVIRkmtrrsBSzu/BOugWvcYUFap3XL6TAFe19VId08dPGrJFgIKZnTd8Zoa/z1uPdzq9sIrGYaGJ5EOXnyiecrDVTDmZqSnFnLn86Xpal+qNz0nsGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKfhrH1v+05Wzlb/L7TVpeoCng32IsV0ezSN9ye8kas=;
 b=wI9mPGsl8WWD+z9PIw0/KQVGi4e6uD6nyybrYjl8l5NHgK4LSOCNNuu1iGk339CUn7y/h8WuT+0lKHUzCzwOl7ZqOYsmF6ermQsFz6zb98GS8zbRMVMoiEFThi8spK0gGPG7cRH5LS8KUczy+8+DJuTIPimQCHl1Udp4s2b0j6Zz2shgRPd7hOsLij0lteSwC/7X1BfBhdHc0/RXCVzX6jewddepRQuSl7N+D74bsEa5yIxyo8o04DxOGrrsS1K69we3rMB3HZ7VV2EpVU09njEfm+qOWqCUPBjM9dh9qPnE1IIolDbZRqHn5b+gU7trxtZSckLBRVCb2V+9q6ZZeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKfhrH1v+05Wzlb/L7TVpeoCng32IsV0ezSN9ye8kas=;
 b=Tk8NS1kjmVstALnlZjiLlQ2//OIP4VTD4X1/rRqWLLWAegvTsUpBKPOhUbk+9tdYDRSr1UO1323e41jIMo0mhKMKvC6jthsPC6W2UMALHzP/wtCKgv7UzcVAQGQIXcTLpCDdS69V/aFlO7BJUPgST7/6bflG9VYU8iqWe/oPuac=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4040.namprd12.prod.outlook.com (2603:10b6:610:ac::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8069.28; Mon, 21 Oct 2024 06:39:15 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Mon, 21 Oct 2024
 06:39:13 +0000
Message-ID: <7f6f0492-c345-4aec-9cf5-73a4dd1d71b7@amd.com>
Date: Mon, 21 Oct 2024 12:08:23 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/12] iommu: Create __iommu_alloc_identity_domain()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com, yi.l.liu@intel.com,
 baolu.lu@linux.intel.com, kevin.tian@intel.com, jacob.pan@linux.microsoft.com
References: <20241017140137.6028-1-vasant.hegde@amd.com>
 <20241017140137.6028-13-vasant.hegde@amd.com>
 <20241018143233.GM948948@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241018143233.GM948948@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0177.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:de::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4040:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f8e702f-9ac7-44a3-976d-08dcf19b136f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bE1JVTNKb01QdGl4Z0QzM0tlL2c5MVFzNEd4RnJDVG5pOFJXMThreWpodFVh?=
 =?utf-8?B?RzBpSHNjSzNFU1l3bVdNSXlqR2ZQbmVwWmJiS3YvUUt6bDNlSDVrbUpHK3kv?=
 =?utf-8?B?cUVoYkpMNlBhRGRKb3VramhNa0x3TGpPNENVWEl6WUg3Mm03OU5WUVhEOUVl?=
 =?utf-8?B?ZnZzclFrWExrTmp2eTUvZ2FDTHMyTjB3Z2p2QlN4L1lORnp6aEh5WnZiMnJK?=
 =?utf-8?B?WXR4eGt2RXBpWHlxOEhKanhwaGJ3bDJkcng2Lzh6cC9qellEVW5lZVJobVM1?=
 =?utf-8?B?bUtvcnFreVFremNzczJTc2FRM0c0UXJyMnRvNTY2T0FiOWZsWFh5MWcxZ1Fu?=
 =?utf-8?B?bk9wS0VFNGpzTXZQU3NPUURPdnFBMU9qWi9sRnNZUUlCeS9BK0J5M0dMbml0?=
 =?utf-8?B?VzdCcURVWVBLOVdyUnM1WFF5MXZ6dGlTeFlseG9mVzIzOGQ1UWtDaGdRWXV6?=
 =?utf-8?B?TThvN2xDek1MdG5OMklwdDhUeFpFTnB5U1AyUmlUbmtVUHluYzUreG95bUhX?=
 =?utf-8?B?R2QwZEtCQUxTTE5rekRVeE9Wa2VaOGVyd04yV3dmTmlsNnI0aHN5WUpBZTgv?=
 =?utf-8?B?d1BQdHIySFl1RzRkZ0dRNFBuc1cxditleFV2bEZaeTdnV2IwOWV6NUVvWTNM?=
 =?utf-8?B?czJrcDZRZVU0NHJBSDVtOHBneGJXTmQwMEtla3lSeDFiMVl1RUgxdk5uS2Qv?=
 =?utf-8?B?MjFsd1UzdUFVa05hSzRWZGtmSXR1RTBVZW9KR0N6S3kyb0tLZDRNekdxNUtU?=
 =?utf-8?B?cDRtbmV1dWdnY3RLUThJMFE3OGdlbjZPNVo5a0ZVdm14clBhNmVVZFRYWEU3?=
 =?utf-8?B?cVBhbkV1ZThvMGhBRGhoM3FRKzRiNTJNWSs4ajd0T1NDN041cXZVZlZKa2d3?=
 =?utf-8?B?MUdLajIwckJURS9acitYV0srNldoNjhZM0RCVGJYSDZNU0Q5bE5LN0M0VndV?=
 =?utf-8?B?YUhKZ3p1djk3anBtQnBmUW5FbEpMTm1wQUxRUkJ2QXFDUUpNTXBYbXFpTkJr?=
 =?utf-8?B?dFVWMFJhcWE5SnJZOWJmM0RPaTVjanJweEt3dzBkaU4wTFVxbnM0ZytDWXVU?=
 =?utf-8?B?WHFTRzM3Q0krMzFMM3J5bDA1L29vbnQ5VWl0WlFCSDhneVNpQThCU0t6U2My?=
 =?utf-8?B?NXRSS1hYcEd5eTBLKy8vT2ZEZHlSa2NQMFJWaWplNDdtM0NDY2x1aTdoM00y?=
 =?utf-8?B?Y3NSY3RxUENiU1EyaklycmZkK1Yxa2hqMUx1RStkQlpWQU5hZ1lleWFVUGNE?=
 =?utf-8?B?b0JPWkoxZXhWMm1tRTZqbGJxRkVITXp1T0RkVGFLUGY1Zm9LTTdpVHgrZ2ho?=
 =?utf-8?B?Y0t3WlV6SU1RU2ZEcEROeGNGQjBCTm1SZFBHVktTNjlEUEFvQzNCSkQvbjNG?=
 =?utf-8?B?MnI3VUlFVkxXaEEyamVmUktDbnpZRnVKRFYrYVF4aU9OU0k0QUlJUXRXMnVS?=
 =?utf-8?B?bzNWVFVXN1IvclBpQVRiRnRwR1pNc0hkTDFwSjRmU2l4b3NZL2VlVUVmS1Fl?=
 =?utf-8?B?WWIvNENONytBSFBqazdCeFd6TGIyK2ZwUUpGbm5kc29PZ25KN2RwSkl0WWE2?=
 =?utf-8?B?S2pPelhUeUNPZXFHSTR4T1JuSmxEL3dCbGtxcUhsaWF4TUV3M3dmK25PenN3?=
 =?utf-8?B?aTIzZEh4blVBMVEvRVlGQjBJNHdOSithajJia0NSSndQbERVbDc1QkZDWGIv?=
 =?utf-8?B?OVNqUDdYVm52SzdoTjdnUFpzUTgwUXNlUEJZTTZKUXRTVDJXMW1VamN1VkN4?=
 =?utf-8?Q?dqlhtFb01+ZbOBYWBZ7K2GE6qVzih2rXQCExo2v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bnJwQ2FLbkE3Q0wzUXl5RlZmVTlpUWFVNFlIRjMyQlEva3dJZWJ3UlRKeGJK?=
 =?utf-8?B?ZDlVNlFpMGRFdVJxdTMyQmx3RFNCNmRpMzdQUzUxMjE0aStUTU9VeDkwc3BC?=
 =?utf-8?B?bk92cVB2anRuRjZ5U3EwQVgrSTJ6SWZ2QSsyZklnSDBvZFBobHJsdm93NnYx?=
 =?utf-8?B?eS9LeFlPdGJJTzNQRVhnOTNaYUxhaXNQVFkxTFV3eUREM3BRTmRRTWZid3Y5?=
 =?utf-8?B?UitEaXRMbkFxSENxWEFwM1JoSE92ZWpoZkNWOHlLdHd3dElZbUNnSmt1RGJC?=
 =?utf-8?B?d1pzc2hsOURMcWduWVNRY3pJS0pMaHorbVhaTG5jcjFiVm1SSWF3V0tML21D?=
 =?utf-8?B?aDB0UU5QTlQ5K3pKODFzTWVVUUx5MUtNa3l2R1U5b1JCdi9GYWtSdERzbGli?=
 =?utf-8?B?bElVRzJZYjFhd2xMTnZVaFprVWI2dHE3ajFsRHQxck1WazFFNm9iR0F0VVlV?=
 =?utf-8?B?UVdsOVAyb3A1czdEcVFRWUlGeW5JRnNnbWltTU5zck8xUHJUU2FxREpRVXdV?=
 =?utf-8?B?dThnTTZPcktzbTJaeVJvZDRUOVRjUnpabHpYR08zeExqZHhhc2lQREt6TVEr?=
 =?utf-8?B?U2hYc0EvK09DTVRvQTVTT2M4S3RQd3BheUpTWTYyd3paK3pJazM5b3VOSUNq?=
 =?utf-8?B?eG5LYWhDVjN5QjNJemVTcXlrMnJXRjA1U1d0MHhxQnJxMlNvbmR1emY2VGhk?=
 =?utf-8?B?ajV2ZFlnM2JoOFZmOG16VmVNNVZqQ2dQQm9neDAvUWY3d3pjWkdLR3gwbkNw?=
 =?utf-8?B?N1c0dmdNUzB2cDRzbTFKRGpsaDc5QkN2YXdpdDFzS2tpaE5VWjYrMHFKSDlE?=
 =?utf-8?B?THA1V040Vm14OGhhU3B6VVU1UjhyVTdRQW5ERXliUkhLcU5JUEJGelJuMHhF?=
 =?utf-8?B?RGhGRE53WHhYdllwQVVLaUxUdXU1UUNDalUvWHNkZGRDNGtWNUxFd01hRmJp?=
 =?utf-8?B?MVZUbnlaRk9oRTFEUnJqd3ZBN2dvc0FEMFBkWXE0bUo2MStVREQvblpaUmRT?=
 =?utf-8?B?RnBhRkRBd01XcHNSLzFyakFkYndKVDJhYmRBNHJiV3JhSHVaSEtTbWhIQ3dr?=
 =?utf-8?B?TVgyWDJwQnJMYUlvUjk2S2VFRzRWVnA3bHJJdWFxT2VDZ1BTUDRQR2hQZ0NY?=
 =?utf-8?B?Umpic3ZKM2R3TTFNVkVOWVpIREl0OG1HeXl2UVN3T2ltaW5IYVdjMXI5UUJH?=
 =?utf-8?B?d2VaRU56QTNhM2oxcTF6N0hoL28waUV3VjVhL2JNQW00d201RG42aU1Sak9R?=
 =?utf-8?B?Wko1cVArd0xuRzU5QTFSZnFoa1E2UE05ZjEzbU82T1l2S293WTduODBDWE13?=
 =?utf-8?B?QnJ0YWwzZm5HdVRVNmY5NFBCZm9kWTdGR3JZWUl5V21FeVN6ZTNzUjNQRzhw?=
 =?utf-8?B?SzlST2tDT0ZQRXFab3J2QVYvV0RUcWNnMG13dTNqQU00MWtFamk2LzE1bGIy?=
 =?utf-8?B?SHBnL0dHQzlvcDdLVVZPWWpxMzE1NStQY0lxaWlOY1NpdUdnekRpdjdJMldS?=
 =?utf-8?B?L0FLRlB4a2RlNU9XSDFuL3VzNHBCeW5vdkRpNkpqWmxXczhvMytIMU82NGVa?=
 =?utf-8?B?blZtcVhKcUlYa1pSMFZTcjZjUFVFWWZIdG9jdlM5K0dNcGlCSjdRa2MwNG5m?=
 =?utf-8?B?cm5EeEQwL3VwYjlZckVQUXljQlR2UXlYZ1QzUW1nZzRVV3J0Vmg5UXJLaXk5?=
 =?utf-8?B?OWt0L1RJRVY5STArczUxbkJYRTZ6Z2syVnBZZE9oQzhZUGdSS1A1YTJpT1g0?=
 =?utf-8?B?bTVqM0d0WU9wY2s5R2xNWUhGV0RzaUdPdC9DVWF5VCtZenZmbW9TTmdsaUhR?=
 =?utf-8?B?c3dIcjMwVk5QWnltWEhKMkJ3WmVWWUtjdlRha0ZhVGtFbHNuVDFFdkQ4eG9L?=
 =?utf-8?B?c2VzTEZSdERyZVl2WXgreGFodUFBeE5IMFBmNWhUUWlURHBjeGV3UmVCOExY?=
 =?utf-8?B?MVZ1b3h1cVdxZTVnQzZtN2hEclpmOFkzVnpCcW1uREVkQ25MQ29BaUVYSlQx?=
 =?utf-8?B?U1ZZT3pYRHJpSzlyNnRJcUsydFNZcThBejNqYmJRU1lpclJrMDluVnZaY2l1?=
 =?utf-8?B?VzVHMGJxcjZmaS9mTnJ2aXR2WnpJZnFISE5yODhLVHdwWW5ZNEhFdlYwSWs5?=
 =?utf-8?Q?P/jAWOGQbHqiWyHOMHhw8VABD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f8e702f-9ac7-44a3-976d-08dcf19b136f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 06:39:13.1735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7PavpqzFcDiRXe6H2hxv8jHmFdXmM3YyVKgropJpUbtt2ira9s9pae/fYlYcsVyMe5C2eSG93UWmxNe0hT3iIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4040



On 10/18/2024 8:02 PM, Jason Gunthorpe wrote:
> On Thu, Oct 17, 2024 at 02:01:37PM +0000, Vasant Hegde wrote:
>> From: Jason Gunthorpe <jgg@nvidia.com>
>>
>> Consolidate all the code to create an IDENTITY domain into one
>> function. This the legacy __iommu_domain_alloc() path from all core code
>> paths, and preps it for final removal.
> 
> Ah some grammar:
> 
> Consolidate all the code to create an IDENTITY domain into one
> function. This removes the legacy __iommu_domain_alloc() path from all
> core code paths, and preps it for final removal.

Ack. Fixed.

> 
>> +static struct iommu_domain *__iommu_alloc_identity_domain(struct device *dev)
>> +{
>> +	const struct iommu_ops *ops = dev_iommu_ops(dev);
>> +	struct iommu_domain *domain;
>> +
>> +	if (ops->identity_domain)
>> +		return ops->identity_domain;
>> +
>> +	/* Older drivers create the identity domain via */
> 
> via ops->domain_alloc()

Fixed.

-Vasant
