Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EC084A48
	for <iommu@lists.linux.dev>; Tue,  5 Mar 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709652073; cv=fail; b=Hd3KqX6d6xWPdrPRnwP3sW2tQpTZOODDyey3ayOIGJp8Y/zeVxyydOX1l9Bn31rUScSNE1eIYqTS7BTsIWS8+Qs7x1MM7C3rSpQ2c+dBG/w0kLTgueskpgTLkC+BSFM2Cb42LJNeCeDaRg5Y2iR/1Xk+V+xmcDplGd0pRa2ISFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709652073; c=relaxed/simple;
	bh=YeR7i4TDW6zlWAMu00rakIAQJQIFrqRqiZ4XpKenfhg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=l+PbsVueyZKZcRwhtyZ04PguwLwdosW7nD3dxGMl4k3yocBRVKp1LxJ28mTGS4SaVGtwYANjJokv3y1O0eyArzBL7lsTgZgw6f/ozL5/UzzknAlv/yihHzj1XrVP3J2iAdPoeuJx3u6xOMgC/ITe7lHoRGbVFt2Hmnnj4SFHNiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=s3KOjLFt; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="s3KOjLFt"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbm9OH1lj+03pspedUygM7mbZ6HqNZN44xw9KE6ipXOvdHHVGHsrdcKl0UoTMGtlexGmQwtu054dTVWP7B6U3JEwDZdxETrPEy6hE52HfRVQfyuR8xnjMzNxyTiG+Q2ela4MD+r/aUBWhxFMdq+16czwG9R3jHVXKsdY2IV+QqLQztTWpSCR5MDFtFPf1/ynddZOK/6WVVtN4TMPGTYhcsNl4PrnvUozo6b9Blve4uU3sW/ZKFjcs94NXaWAhmK+OYu5qmkyE0IjyPagQdpDiOd16+QtlnY2BMk6Gg/985uqyY1af6vJ55WWLYZDebi1te6LwoMcczInaTqB9p5CQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9ch6055Jpur392pAlPAob5KMY0pk9eOMj7Oy5YQH/Q=;
 b=YFuzjXJj+KX36jzF70OMrX2AqTzbgSBoL9Mda+ia9GFPJaF17VNNT4Rn6Db49p3yD1UYr/KxYPoyyc6N16k05Kbo2Gjhc3D/wR0jjwlLJR816CDMQV9QpNUGWi9lV2RnG6jQiJSdq/GXDVvw6f41WLresjScSyOclpKYg8jcqQZ3SicCSzRAns+LEs89wwiHQYiUpALBF2kV0bMmJgvbycyKtXXrX6RawQPZ5+lIIniXKtgRQv4LEZI8OKCQ2uED0dJyRMniDYPCXkjbVo8CypeqMigQr2E6tc3zbi1pJc6hJKf1InNpYbgEHSICakOEnmmYaeTB7kqBG2gmCpzZaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9ch6055Jpur392pAlPAob5KMY0pk9eOMj7Oy5YQH/Q=;
 b=s3KOjLFtyqPqlmKIdty/7dpOqkm+h3TK+6jfGXpPO34GMYY/0j08zxivzI4ofrOQKXZ0VsnMiu2HLTMT5hZVDQSZybYkf35/QPPIZcOX+azfGvUhHiRbBcYZTGX+/EiMpgeUlueYR3TIKBG+ybAJRnNx1oYbVZGePXq9dTUa+Oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH0PR12MB7959.namprd12.prod.outlook.com (2603:10b6:510:282::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Tue, 5 Mar
 2024 15:21:09 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::d709:cb7d:2612:bb27%5]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 15:21:09 +0000
Message-ID: <10e35828-1ceb-f4fd-19a8-633f2029c343@amd.com>
Date: Tue, 5 Mar 2024 20:51:00 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v6 12/15] iommu/amd: Add support for enable/disable IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240209112930.63663-1-vasant.hegde@amd.com>
 <20240209112930.63663-13-vasant.hegde@amd.com>
 <20240305004254.GG9225@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240305004254.GG9225@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0180.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:26::35) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH0PR12MB7959:EE_
X-MS-Office365-Filtering-Correlation-Id: 09e03d8f-2e64-4629-0c59-08dc3d27e235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Gj+wUqi+ANIp1vLE/hCvErtDkJ6NtA7Hz/kh5WjysiObMcAcRnRJ6wmwhqd39b+P3PBdSBw/czCRiyID7gXFuFjmQglOAMGoaMOjtAmDDAriUW+sioiaL1xDxf6BiRxamcUD46fOw1STUnaMvMHMEEnReOsaQ9FP9nVc1fZsDH3VNbSoZrPPqLYsR0ereub9e6x4FYWacgzLWhx38+jcpmv5Mrg9ED1uCT/pcAyKJiGxYuuD+SRLGmP0ZE8TLc+0FR3zhP2zxpeVYdEm+9/Gv62LQO2nBQJqW1Fd41L77fXVlMWi5BTtoGFcSkndKwiN1z8TRCLgaBnCS9wNOBXEEMrzrw1Gdsk1TlHMydX1DIHARxcqxhCtO/f8j+FxoLDndTOJKQ5vagX/a7UJleW9UnxEf4XJxRjX++iVOJeKLv09Rhes09uVI+bQaPaRkK/EmF3yn7a1wMG5Nntj/vxcNPE8tNFfnpJ/HH9fSglMtAEsgWOSlmKTEDc9BLVZ4Xy1S/0oSTvV16SlmrVPKiSuBbH4ifVCC6WuZUVJ0X6a6SeOG7IUGP5Jeq7fKi12/TXcaa62aoZrvECqrkPOFVLhG3tGWh+uX8Z7m0lgkKSXXl7VX+d63uvg69/1oZkqugnnrIOvj/rHW+nKk7JRdrrzJNoyVMnkzPro+EwoFuE8pI8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVNxTFpTZ09TZXl1STI5SjZIQ0w2cmFYSFpoV3dndkpSWVFIMy82R1NLaEps?=
 =?utf-8?B?Vi92OU9aQ0ZWN05NZDRyaGhIN01PYTVocFhzQVNFb0J5Zk9jSWkvM1FtcDZX?=
 =?utf-8?B?MTdqYjFGbE9FeFVJL2tKbVZ2MkxnNXBDRlpjdEpFMEdmSThiL2F0VUdTVG1q?=
 =?utf-8?B?SWJiVEwrNlZwcVJhY3RvYTNGekp3WEFFSldpbWR4eUNKMVYrWnFpMHVEaGhw?=
 =?utf-8?B?Z2ErNEp6MFNrV2RNaWt0MmI3UThHTWdVT2V0OU4wYklUT1lZZE1HLzhTSHRX?=
 =?utf-8?B?d1VUeEp3RElKWkpyN3ZmY2RGb0tyZ0w5MjdqT0hiVTBLU05KOUFPZVBmNHhT?=
 =?utf-8?B?dXNBNjdXSFhzZjFvYlJ0djFwVEQyMWxIVDFzYmxJdExVcWc4RndUV05ZRmc3?=
 =?utf-8?B?OXBSN1JzQ21jdWFGNEdyOFJKL1RxdWZkNEhWY25VU2I0eWVFMjd1ZjEvdjdY?=
 =?utf-8?B?UW9mL1IyMUZqd0JralZqMTZYbzdXU2cwWXBmV0pCSWx6TlRXN0srYXNuVUxM?=
 =?utf-8?B?YmJXdDI1MmRTallYdGhJb1ZPc2hXRnh5ZUZLaXBLTGdSc2VRK1Z6R1lYaC9N?=
 =?utf-8?B?YVA5a1BQOTVBYytvTWRqR1FMZkRBYXc2eHhLSjZkR1c2SWZrVzN2SUxITkFD?=
 =?utf-8?B?R1J5OHpkeHFRVTVpTWZIaklYS1NLdUJHK0hnZWFQSlNyMFhhTmF5MHExT2Mr?=
 =?utf-8?B?ZGM5bWRmVFFZcE52dDF2MFRUN25XWWpEem0xZVRLVEIxVkFoSnpJV2xzMnJR?=
 =?utf-8?B?TUdVRXByTFhXakNvelB2ckRwVVBHU2Z1NHZaUHR1MnprNTJ5VzhWUlBmOUZz?=
 =?utf-8?B?ZWUzd3dyYW0wQXAwOWR4ZGFLRnk3RzZpVEJ1dVZLaXh1bVFaU1VtTG9Zam5z?=
 =?utf-8?B?VFR4NElQUlZBaTZlcDNKY0M4SXFJN3F4SHZwaHpoNzdrQWVoZ0J3RnJDcVVz?=
 =?utf-8?B?MGpKdEt6SkZ0K1NSOWRuK0lIVDU4SFJycUZ1ZW5wTlh4SlRPZERETEhxbk9x?=
 =?utf-8?B?dnhSMmVXUmtHeVMvd3NIR2hjWllBY3lYd0I5ZnVOM0xJWFh5THdocUFDUlhG?=
 =?utf-8?B?STU1L0xRUmhHZjZFTWlCWThSUGVvQUlHSFpFaHA2d0lMbEd4VDZ2T3VXSVJO?=
 =?utf-8?B?OXp2SkdYd2pSc3hyMFZGVTNBOTl3TVNIc2F5L01aNjJxRm1DUUZjeEMzZVE5?=
 =?utf-8?B?ZTdQTWZ1TjQ3TmI2ZEhoSXNXbzVxRkJSalpGaFpNSzRwTUwwVktFMzZNbkpl?=
 =?utf-8?B?YXlGVVdkNmJWNXA3SFNuMVY3ODcvZmFtS05vT05kWU1FekFqRFVmUjdmRVZk?=
 =?utf-8?B?alExUTdxbmhVL0dqczdMd0xteFA3cjZ6ZzJGdlpaRzcySldwellNb2FlYXU0?=
 =?utf-8?B?UkpVK3k1Q2dWYkkzdUVOWlFGRXdMUVJxbUgrSzJvSGh6NzFRaWMzSzlqNGc2?=
 =?utf-8?B?b1gvNzFHYUdCWUMrT0ZDWHloNlZ0RmUxZExNY1I3UGVpbEVOS3JFYmcrdFh3?=
 =?utf-8?B?MkJ5SE15WkM2UTRsNitMN3lPUkVTb3ZRZFROaXlsbVNLdFZJTUw3YWtGbGM2?=
 =?utf-8?B?dUk4Q2o5d3RYUkwzWVVaNVNMbVFLdHhTYW9pM1k4Y25EQ0tGeUlndy9xNUZC?=
 =?utf-8?B?Wm1IaDZreWhuaEtiQTAwUkJkTm5WL1E4YVBCVy9lSytDbkhFd2k3WkZGRnRY?=
 =?utf-8?B?YkZadTdrUzdYMTFiNjZFMFJRM2VHUHpyeEg3V0ZQb0NMODduNzhxTE9ycHJY?=
 =?utf-8?B?UDZSeFdqTWYwaTI3c2FrT3N4c29uREZDVTM1bkZLOGVmSTFobDlVTTlIdG5x?=
 =?utf-8?B?RG1YUVYzUWZJcVBrWC9lRTNxbFl5QnNjTXVBRm5GMlhibjN2ODJNTlNaTGph?=
 =?utf-8?B?TGwvOXR0RmcvL2U1Q0I4RzAvOXRHRUxWZXJpdkZndzlEOW5IbGdwUkJEQ0tU?=
 =?utf-8?B?QnhscG1jMmJmMHdGRzM5SnRZaCtqaXBXeDhaVVR1OEJ6SlV3SkhLTS9yQ3py?=
 =?utf-8?B?anoyRlgyY0ZmdVhJdzRpcjg4R1ZEbUxvTzlXQVV2aUpOSUhPWHRHTUV3aWpQ?=
 =?utf-8?B?UXdWUEVlNW1zeXA3c25CSFBuMmpsRjc5U3RnMElMTldOVVlBRnJCNFhGWFdq?=
 =?utf-8?Q?FSbKIaR6wTJN3/vsSD3unHxLx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09e03d8f-2e64-4629-0c59-08dc3d27e235
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 15:21:09.2196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hezqCg0DG158rtb6vNg5SfFeRlLx3lz1y34PJx7JeWBdulBCRROxC6kWCeGfkCx4lMEj624y+kYvrzwrJt3QIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7959

Jason,


On 3/5/2024 6:12 AM, Jason Gunthorpe wrote:
> On Fri, Feb 09, 2024 at 11:29:27AM +0000, Vasant Hegde wrote:
>> diff --git a/drivers/iommu/amd/Kconfig b/drivers/iommu/amd/Kconfig
>> index 443b2c13c37b..d563f6d496ca 100644
>> --- a/drivers/iommu/amd/Kconfig
>> +++ b/drivers/iommu/amd/Kconfig
>> @@ -10,6 +10,7 @@ config AMD_IOMMU
>>  	select IOMMU_API
>>  	select IOMMU_IOVA
>>  	select IOMMU_IO_PGTABLE
>> +	select IOMMU_IOPF
> 
> Makes me wonder if the previous patches actually compile fully?

It compiles as IOPF related functions are defined in iommu.h. But as expected
IOPF features does not work fine.

> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 0fa172e0583d..21cc6654410f 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2058,12 +2058,22 @@ static int do_attach(struct iommu_dev_data *dev_data,
>>  		if (ret)
>>  			return ret;
>>  
>> -		if (pdev)
>> +		if (pdev) {
>>  			pdev_enable_caps(pdev);
>> +
>> +			/*
>> +			 * Device can continue to function even if IOPF
>> +			 * enablement failed. Hence in error path just
>> +			 * disable device PRI support.
>> +			 */
>> +			if (amd_iommu_iopf_add_device(iommu, dev_data))
>> +				pdev_disable_cap_pri(pdev);
>> +		}
>>  	} else if (pdev) {
>>  		pdev_enable_cap_ats(pdev);
>>  	}
>>  
>> +
>>  	/* Update device table */
> 
> Extra whitespace

Fixed.

-Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> I already remarked about enabling PRI in the wrong spot..
> 
> Jason
