Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2046.outbound.protection.outlook.com [40.107.223.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1332716E886
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 08:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730364842; cv=fail; b=WhEcBcb+toDhcONvo4q6784rVQ9Wru8T4fkAUeNEk36tDLRtaPubJ6yp7KLDDWPO9dSZSCI6P9mqLx7PYnzJ0qLskYfRal39qbN/SSK4Xzjxz500t9/SjFbWi7CnopDQgc2YZkw9Nsc6YQ4tPbe2J7gkZ1jbuClwHphAYEIHulM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730364842; c=relaxed/simple;
	bh=HChkzl0dIpicfAU2weB/hpoWwQ96fGH9d4VTEacxuJY=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=e8FVW9fTbtt+l6t4ASab5t21ImDddlaW9UYI1df6mxqcF2UBjmpr+qr8FWfoD9mfZ8qfFy+r2mqyfC50PC49W2h1EhiBgIPWWo7sAY/cSjP9KRJfytJ6aT46Uu8PZznnrkUYK7Nvcr9p7FbQlkHTtcOPGsots7kG+RJsHNrQANk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AOk2W+tl; arc=fail smtp.client-ip=40.107.223.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AOk2W+tl"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhiISM7wDhMsL2RFq7qzVl54k5z5jwHR2IyA3E+gufYcTSfdNpGD2Eh/VPn5DiOa291YR2X19jKPpZWYWtNLWR+fR0B4GHg0EvEipJxoafYgFzt404ie8hq2//LW60yDL5OIygvP//U+b2JvJLmXymh1+1hdJ2sLNe72FQrDCGB2XaA6lhDt9AuZuNP0qvfpte6gsCz3r7rcYBvkzAdYqhQ+G+aRpLxshtLCGZJgSFM9IELYayzQ28rdhZzoea/+q/7qJ4Lf5XZtuQBzZZxGOLg5UDlNkz2+spgk0QwexwhF0RsG6U0n9E1p7Jk3PUshu3KttHxwW7vgeAD9o3NZoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=34MMBPhqPrT6Iu+iMoksuHK3Gnll8aCgZtefPxtEcCM=;
 b=l0AN1gmPRasQnbv6FidUWdFQPcTnVT49MuqL7iDih6U1DnO8+dXIuYaIaufWJ9lbz3rvfJ5pL8Z3rblzuHFgkhukrABSckYV31rkfc3s4AUO6cFEx58H0dOMehBISa82NQGZsXE++NEDkdU7YSir7Nsi8OFo5xciZwUre0WhWaQ3hPa7mxXwCSvSE7DZj7H+N7bv6fz5JEw79O1+OIOyLYvRu9WYJldsCabQPtZelgyhrRwGnkDauZEtlMNPyRmrhB/zkDjQ+ZOwcb2A1yAsxubHGgYWYg2UiKNzLyfqPd0ndomRhb4dbny1bItmFGwNedo/CfNs6ENA2BM2e3TzHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=34MMBPhqPrT6Iu+iMoksuHK3Gnll8aCgZtefPxtEcCM=;
 b=AOk2W+tlynkB+rwqBnnwETyv/JDIi0toIgDGG/hqZ+7PuCiYp/oKZM7yd/pIU2mVav9bHIPwuv7wj7ydHblMSGSFipRbr7zH5YATVSx1TlXDApQyoIwPo4X91d/i4CHcfYweqUyuR2LjTV0zOXB3GLQgWr+vx+g0fGSH8yYyyI8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 SA3PR12MB8024.namprd12.prod.outlook.com (2603:10b6:806:312::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Thu, 31 Oct
 2024 08:53:55 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 08:53:54 +0000
Message-ID: <473c387d-39a1-47a7-a259-b43287f82931@amd.com>
Date: Thu, 31 Oct 2024 15:53:22 +0700
User-Agent: Mozilla Thunderbird
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
Subject: Re: [PATCH v6 7/9] iommu/amd: Move erratum 63 logic to
 write_dte_lower128()
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241016051756.4317-1-suravee.suthikulpanit@amd.com>
 <20241016051756.4317-8-suravee.suthikulpanit@amd.com>
 <20241016133043.GL3559746@nvidia.com>
Content-Language: en-US
In-Reply-To: <20241016133043.GL3559746@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR01CA0022.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::14) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|SA3PR12MB8024:EE_
X-MS-Office365-Filtering-Correlation-Id: f05fa52a-13b4-42d8-23c2-08dcf9898c54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YjJUaWdPakR4QzhWaGx6TWNHbnhFajRuWTc1NCtPVVVtWWpwV0VpTTZzTUhB?=
 =?utf-8?B?ZDNYWVlXc1VCWVYva2FWUnZobndUbUd0bHBEWHhyOHMzY2s5empLb1pxaTdK?=
 =?utf-8?B?aklxRmc5MVM4dkdvUHFWaFEzU2VMSStFQ1c5UHFoUmxITkNWeWRwTXFyczFF?=
 =?utf-8?B?cEhXL3FrWHhZdFVDNkdMRFhTUjlJc1FlUmF6L1p6OU5FT0YxaE1LU1M3dXpt?=
 =?utf-8?B?bStOeHIyM0J0ZUhQZ0xoOTJPY2VuNlQ1aVJHVmw0NWQ5NHIxTmQ5cjBCeDA3?=
 =?utf-8?B?NFBMdU5NdGlEdSt6aWYwTHpzNnFLVGR3Y0VlUXZ1M1lpVTd5UTlzN3N3cUdW?=
 =?utf-8?B?ZXB5b3ViN3BpOFlwQkxnNVcybzZENGhGTEZxME5IRkEvNUVLejgwR2IxaXY4?=
 =?utf-8?B?bmhOK1VrVCtTWnlKVXovSEFpNzJnNkUwVDNvTXU2Q013eXJQOTJ4NkFPTS9m?=
 =?utf-8?B?cEJxNFBBKzhJK2ljNFRoRDhTakJsRlE1THZic3NEbmN6Vk13dHFUemxkQ0xn?=
 =?utf-8?B?K2VmSU1jWVhEVUEwOWJJVndzS1o1NVd1WHpPcG9ON0VVRzQwdm5zc0pYN2hP?=
 =?utf-8?B?aUdhV0E0MXJ4WlhKNzdMUms4UmJkWTU2WnlPQTJDT0NVS1VLdGdWY1FMMDBy?=
 =?utf-8?B?a21wblhoVjROMDZpeVJiMEVjSVJmU1RjenZaZDN5UjRvV3RCQjZYekczRTla?=
 =?utf-8?B?MWxWMzNUMjVYR1F3ZHQyaWdSTTdrcmF2SHBRN1lqSTZXaEJXOXB2Nk9UTTl6?=
 =?utf-8?B?eTZod21yVkxUMUFWclBPZjBjSjNweENwSFhtOHJjTE1qYUppYmJrekhEU3Jj?=
 =?utf-8?B?QzFZTVQ5d25aSW1NblpXQkpsMk9HTi9ySHJZT1R6TDFkUnFpa3RJMkszb1hJ?=
 =?utf-8?B?WVFGYkpOOWFCNldUL2VLRzE2b1Mwb0RJT1N4eUZGNGNtMndwVDFFRmp2UEVt?=
 =?utf-8?B?Nk1iSVZpNlFzNWdkTnJpRFBNK3VvWG56aEdVVGUwbFA4SXlqSlJReWtmbmJB?=
 =?utf-8?B?b1Z5ZVBMdTQvSVdtN0pJTEVsa0JGTlplZ3h0TlYweUdiNXcwTDlaMENkbUJ3?=
 =?utf-8?B?MldjemJBTGljSjYwdHQzWlR2dGEyNTkvNEw1aHdlSlNxL21uTWl6WWUrbyt5?=
 =?utf-8?B?d29qZlUvQ1ZRdmFWKzVnNVdvVmE1djY4U1djNzZVenZabWFncExZMHJjZDQy?=
 =?utf-8?B?b2svTFhQL0JZdUFCbTlHWCtjMGZadUI0YzA3UDhERXM4Q2tYVkJuSGlCL1V5?=
 =?utf-8?B?ZFhFeWJ1MlJsbGNCYUJ6bW1XenhXbjZYZU1ic25IWU5GZUtOdkRZd0NQdjRv?=
 =?utf-8?B?NjhvMHlSdkdReGR4akhPbGVpQU5SWjYydDlaZXZrQ1MyU0FpSmhMOGppVW1T?=
 =?utf-8?B?YXBvdHZDWXR6aUl3cEV1VXBuTEZRN3B2dTBRSDFsY2h3dmZzQ0dmL1hvcGtt?=
 =?utf-8?B?ZncwSmpVL3hDM2RmcXNXbEptbnFwcmNnMzBqNlUxRy9ubW9tcC9pT2RUbjdS?=
 =?utf-8?B?am9NRmhXeW90REgwN2x0VnNIOUxSSElnN3NleXdFcXErVXZMTzdxMmtJOVFE?=
 =?utf-8?B?U09IK0c5MlNMemhua2xIcFVIVmZ6Sitzc01nZER5QU50SXdIYTlxQUZKcCtL?=
 =?utf-8?B?ZWFWOHFoNjNJT1p2VGVJemRXb3BoMmZiUEQrZWRrVmo3RDFsaGYyOElPeExD?=
 =?utf-8?B?V05nL2N0TEpDeFdlZVR3VHZBNVo4N3lJMDhEb3VWYkI3RHR1YkxJUjJweEYr?=
 =?utf-8?Q?8uN2jOaumd83S25D+XnivED2ta0LibbdeIAVRLM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ek9QeVh6Yjl2T2hHdEdyT1oralVVRHE0Q0dLNCtuVFdkbnVPZEt5RHRmS2ZB?=
 =?utf-8?B?SURxdXA4Zk5ObzJadnd3TlNySFAvakZTMlFzLzBPSHNLRk9JR0FTVUxCWHd3?=
 =?utf-8?B?djBKei9WelZOUjdYZzRKTTUrL1hsK1MyQmt0RW02K2lGUXZVTzRqdGZ5MG05?=
 =?utf-8?B?eDRZZlZwY1gwVE5mYXI0RzNXU1kwNFBNei83VjFldWRrSnJCOEg2RjJqczVp?=
 =?utf-8?B?WXpwbTl4eDYxRkF2Rnc1RUo0YUhjRFdBQk1Mc3FWWDlxWWhrc0J3aVpKbWdH?=
 =?utf-8?B?VnlXOW9WS05ER3FyQkJWM0Zta281ck8xMDZscStJUWpTbVZIQ0hURGIzVnp3?=
 =?utf-8?B?OHVaK0tPTG5Kb2RkaXFnUGVoZUU0dFBGeWdmZU13UjFwUEdYdEhOL2MzSStI?=
 =?utf-8?B?NjVLTHdvUVI3NDhVNWJ5Ky8wREpsRXkwTHppdE5XN1JhY2FpQVg3WXQzY0ps?=
 =?utf-8?B?N1F5Z2RuMHVmdjlodU1nc3BWcW5HWTJPdGVoV20zMGQ2ajFucjYxd1Q5MDNX?=
 =?utf-8?B?VVRIWjNWZ2loR2tHUDhKQjl5SEo2c0FTM293c2xkdm53bmNoNWNVcEpzQWMz?=
 =?utf-8?B?d3pULzY0LzlNOHZkVG1LWTNYMnVWSkw4SjVHaC9WdTA5cW43dUZpUTYxcFNN?=
 =?utf-8?B?dGZ5ajRzMU5Jdzh4NDNMNysvejlUeE5jcG5Pc2YzY25CbVR6aUNoaWYwMlFv?=
 =?utf-8?B?MnFZZXVsK0VPbklCeWhCUkd6cElWZEl3VXdoOW1FeG1JUWpQTmptS3JwTEpY?=
 =?utf-8?B?N3BhNEcyRVEyN0NhOXd5QU4vR0F4NFlLZTBTcnhHNXpkVjg4N1k2RXg5UFdZ?=
 =?utf-8?B?QlhneVdId0Zac1ZOMi8vcjV1RWI5d0ZHUGlvK1U1V3pzQVpiTDVOUXR2NUhT?=
 =?utf-8?B?QnV3N29BNXYya0ZOaFBoQ3piZE5UUG9BVEhTOVBzOWY2Wkc5cWJKOFNITjZQ?=
 =?utf-8?B?SHFpZGo0RDRPckg3ZWpKY2ozcXJucjZsVkFpZElKVG5ha3lBUks1a0FoQytJ?=
 =?utf-8?B?SmRJNlBuRVlSdFloTEJoa1NSM1d1YTNFZEpiM25oOSt5Z09aM1FuUVJmZHBi?=
 =?utf-8?B?T0p1azNpVmFaRjY4WXlOK0hFcUNIcGY2QmFpamJYSWxVRWRRVGN3dlN4YVEw?=
 =?utf-8?B?eGtzbU96bFVEeDQ0Mml1dTl3azkxWjZyQjMrMGx4a1BpZnNHWDdIZnk2SUNr?=
 =?utf-8?B?ZGd5SnQ0dUxSa0RtbW9DTE9wbkxiTmt1b1ZFVnEvb2syZ0xnODRMR1ptVHRk?=
 =?utf-8?B?WCtTZ09FUTNjbDB3aG1MWGQ4YkdDWm0zZWU4dVlIK0JlVytzSGVGZjNjZGgw?=
 =?utf-8?B?MzQwcVRpaGhkSU9mRkptZ1NXc2g5NFl3d0dtWmlxb2ptNTFmK3JpS0ZGNnNE?=
 =?utf-8?B?Q09sMVcyQkQwc2J3czFPSG1HTE9ZM3pDWUR6L0kwanRIc1pZUnhZSzAwR1Mz?=
 =?utf-8?B?YTRxWGdRbUNxNE02Tk9HdlJwRW45a0NtTHptM05YRmJjeEltQnBpdkJEWHRk?=
 =?utf-8?B?SFliTG9KTnBwM2o0RndxNnphQzZjYUNFMHdOUlpIWlhpV3RiMEdvT2lDeExX?=
 =?utf-8?B?RnpFQzdMYmdXVFF3a1V4QlBlVmRWWnJMN29qZjBFUVE2WU92OXora3M2S1pr?=
 =?utf-8?B?WVAxYnRiZW5yazRQdWZndWtnWGJWL0hkeFBoLzFjalovTit0MjhiclV2Q2ts?=
 =?utf-8?B?dnZOYXVIc3Zna3ZBYWZyenFIbGljczB0d1hWTE5zTVlZSnpyV3ZIZ2loaGNt?=
 =?utf-8?B?OW41UTArbTVvVHpBVFBwRldxS2xpWENpV3lxcXNxQVA0NUNEckxWSHl4bkJq?=
 =?utf-8?B?dG0yZG5UNkRSbEhGT0hYRy82aE84Y2hFNVVkOUx6SWZTVWtPbklJdHVRR1pp?=
 =?utf-8?B?UGVmUmtyUExhT1ZIQjRLYXAxckhjWmhvbkF5YUgrV3cyMExzZ3dURE5lV2ph?=
 =?utf-8?B?dDd0YzRVMGlkMGVrNHNMSlNEQlNmMVhZSHZSRWRrY1RFREhGM21NVWlnZzBF?=
 =?utf-8?B?ZU9qSTVESDA0d0psMHFjTU5hZ2Z6UnZkeDVnaFB2MmRTaTBJVnZpTnYyNE0v?=
 =?utf-8?B?bDhxR0lDakVzWlJpU25JcDhrYk40S2hGSjFaeU5abGFRdk5TblFPNUsvWDN6?=
 =?utf-8?Q?vkj8tEUOTdY34uVOqAYYTvJlX?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f05fa52a-13b4-42d8-23c2-08dcf9898c54
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 08:53:54.8824
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BRbU52IUXgJ/omcDiJsS1woZWDfRR/GqkyT3NNOv4jVJ9GUYx+jFEVmvfpx/Ny4F7k8Y6DgoDei6hQs4ylsOTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8024



On 10/16/2024 8:30 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:17:54AM +0000, Suravee Suthikulpanit wrote:
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index c03e2d9d2990..a8c0a57003a8 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -105,6 +105,10 @@ static void write_dte_lower128(struct dev_table_entry *ptr, struct dev_table_ent
>>   
>>   	old.data128[0] = READ_ONCE(ptr->data128[0]);
>>   	do {
>> +		/* Apply erratum 63 */
>> +		if (FIELD_GET(DTE_DATA1_SYSMGT_MASK, new->data[1]) == 0x1)
>> +			new->data[0] |= DTE_FLAG_IW;
>> +
> 
> Why not put it in set_dte_entry() ?

Ok. Good point.

Suravee
