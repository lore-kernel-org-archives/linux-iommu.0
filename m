Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2065.outbound.protection.outlook.com [40.107.243.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0C66AAB
	for <iommu@lists.linux.dev>; Mon, 31 Jul 2023 07:58:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6jN9OVKhNOwHbCR/ZtSgc6QelELpBaboCLoC9/BHrHIopkbrmSuFnsdpnFcybVdy5UplB9R1DWXvyM6PS7fCLKfzYdYA/ZRojmYTcUcNzcNzvkpHaIJA/POoM3/KJyHGDLwLUm0b0BSd6ezhPOy7JOTiAufjMHWIvtCR3QslZUg3pWi7CYDHsdTuyBHjW3ZYBMBmZc5fwufvb7uo4gpiBlFIOpqeBFKoXf/scALD6KAPu2jDdk5Ypd59ph7//lhZ1kt6TQ9SeeMiSs7f6V36EmS8QaOBNcQ1Vem6iPlxsxh+32sRCmiBpq4nDK6htrxgQik7Xp8oiT4oRPHoMBlUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjARSuNeETH6X1J47xYIqB5xu52kaTbNltSCQks3ZU0=;
 b=Qe4mwU5wBSpWct9b/PJVAu3+f+eppka7XYAC2p9r+s3zac951cvAVjbChwEi40VaZX5tjkIp/mUbasDtvQyrk/JD9OEFuWg6vF9jmYfZ9wqWXQGGEFM6sh9RD0mLHsuUQaLESrAaJnTKQkXnpJtEumJsHt7lwDcy+7xNlUHfYRP1tBsvjcXkXjlwl0mHkzrv+jmPEO2G7epv3wAu9AJT2HrN5qIUgmKKC0Q+6mcBtO2zbHNJENzCS0sJT9HAtRwKU+a/jYYyQPrMsH8Ad5GOnQuWHXib9ANfW5wzio0ZVwtWlRUxYAKfzo81dvtg7ttBEDDG5QeCW/vCHG4OyBKgmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjARSuNeETH6X1J47xYIqB5xu52kaTbNltSCQks3ZU0=;
 b=qrmPosLd4PYYVQyVMrRbem66ly4hpa6CWcDUxLW0GsEkiUfNSrUbWFykYpAvAMKUFZMB5d6uNBxYaAELdU045jJMSL78+9XwZo38GwWBE+d1Om62LnsCqajLA+i00erX0m4J1Lmt5bKHlZX7ljXdRsWrT+2ftTvfej3us9FAvt8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN0PR12MB6245.namprd12.prod.outlook.com (2603:10b6:208:3c3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 07:58:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::67ec:80e:c478:df8e%7]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 07:58:03 +0000
Message-ID: <89614189-9dc5-f643-9594-6fbcdda5ace5@amd.com>
Date: Mon, 31 Jul 2023 13:27:49 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 13/16] iommu/amd: Introduce iommu_dev_data.flags to
 track device capabilities
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230728053609.165183-1-vasant.hegde@amd.com>
 <20230728053609.165183-14-vasant.hegde@amd.com> <ZMPS8IGzwSWdnNWv@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZMPS8IGzwSWdnNWv@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0198.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:e9::7) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN0PR12MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d91fa57-0a41-4e34-036f-08db919bddc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ISsTw7uu5jycsFtLI3sL1ZesYr+VVvamBgG265v3VV5fQsC5oolpsLqteJNTYBAh/+W5J5+C5tRuiLQsJpUejID9WytgPonOPgLwozXYZiLIxxcuCHCYxhsxUqnknNzjd5XwHFz6uy63u2h6TRDnmXv2K/9dqjAdYoDLfAIKP4iDsHnC+pRVDroJAQwARSGVw0h3HSl+3E8maEG0JtT72T8BypHUvI5CoMl/AX6m80URZhGy9kYS0bF7tCATvWerRbCDGHC1l4zseW0oqoq65CE0AjgtXrjmc1kaM0P+cH/DzmI4yxQKu9myR88jIEH+2AAG6U9LBoe+QH7TrePpVTa5wFelC2UERVUOUkYlXG9+39m7j5mTlce1EXRrBS1sV9ncDkwquKDLuGsb7fNBNiyCkvhK+D8/ujwex2axZsliYNPI686DcirB3ZeE/ITITmZjfusuaRX7WNhsY+/rAGim4EF6vkASPzbQ5Vz6OSEDzKLPip3AEaW//QXChFkRZqq9f3ofiXuJx0EcX5i9m7f5smJV1FmMhdijtlPT6Vm81yKs4ZeW2H6rLAfqAD8D6teZKLPUmPgJcU9ZkfY94Jr+oISQkK9RNkuZQlNWlJ66g0fCnAYgti6vFt0ZnEA64N8ZeAyYp2+sDm1hA8w7XQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(451199021)(38100700002)(31696002)(86362001)(36756003)(6512007)(478600001)(6486002)(6666004)(2616005)(53546011)(186003)(6506007)(26005)(8676002)(8936002)(44832011)(5660300002)(4326008)(6916009)(2906002)(66476007)(66556008)(66946007)(31686004)(41300700001)(316002)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YklSY3J2Z2NkTmZMK2JSbmlia1ljaVZQNVlzaDRpUHlTcE1nMXoyRTdrRS9h?=
 =?utf-8?B?UG5zU3FtaXBpKzJ1RGdlaXNwdDFKeU1IQ0dqdXpDdTJRZnk2TVQrWGxZVmlE?=
 =?utf-8?B?cmNCM0lxNndJMGx0TzF3T0YzcUZyaHRYeW1pWU5DV2pOR0djNXJ6TmhvNFph?=
 =?utf-8?B?RHJ6eEN2UlVSSy9VbUg5dFo3czNkUTJMNlZHbzA5cVkzb1lRb2gxUWZiRnVm?=
 =?utf-8?B?OFJJMFVOSyt3c3R5bHV1a0dJcis1T1RDdGc1eDhUN3p5OE1RRVptanI3SlVy?=
 =?utf-8?B?ZE1DTnZyWHgyMUFRVkFLQ2ErT1RMYkVzdGErbDZ0NGlXVFBqRzVjUlE1SUxt?=
 =?utf-8?B?SHpaajF1NmNhZk9NK3czeXZJbWVYY3padzYxTm1GUmFIWFl1OHhmdENEQ3A1?=
 =?utf-8?B?M0pNN1VWYzkrajVRQnA3K1hmWWgwOVVaVTZBcDh4eENieXRPL3orbFg3WHg4?=
 =?utf-8?B?QUgxUUFEemNDVzIzUXpjanhqRE93cHd5dXROWGJyd05zOFdPTmRmaUo0Si9Y?=
 =?utf-8?B?SUFXU2hXUzNrK2YxQVo2RFJPSVZtWmFma1Fnc0dmU3czQjNBSVR5Q2doczQx?=
 =?utf-8?B?OVpEUTFnVDFiUENRNjd4dU1sbFRwKyt6eEFWd2hSeWRwdmVFUnRBSkx6ZlNU?=
 =?utf-8?B?TDJFQkJRWGxhUEg2YTJCT0YwelNjc3FHWGdJbzJmeURDd01BLzZYSU9nOHFo?=
 =?utf-8?B?ODVvZHN0RjllcXpPLzY1cnNBV2Z0OFFDcnZLQUsvajAvaEtZZUVRaExQYlZN?=
 =?utf-8?B?YWZURHB3c0xwM1R4Mm90aVlOSFZLcitYMlpIMXByZ2J3aXBsU3ZjaDFNRURk?=
 =?utf-8?B?RVM5WjdqVVY1NjJCZFc2TzVMMWJleHhpanNRTWM4WUhvaFRaY2ZsTmt3bXhB?=
 =?utf-8?B?WHpjaVM1MHQzaDRYTndKNFRKZFBWNmVoNUZRbVNvckdQZkF6TFN6bi9Oek9X?=
 =?utf-8?B?ci9tM25BQVlVVWFZb3FPeDU5a0ZLc2Z5QUZTTmgwaG52RWdMTGdiVE8rcUpI?=
 =?utf-8?B?YStGZktUcm9tY1pYcjZ3amV3VHRhSUJnVGYxTzROYTNVN1doK3F0MUZKcFZV?=
 =?utf-8?B?djRpS28wYmdEbU1RUmttTEFDbWdySmF4V3dTTU5qL3pYL2thc01PRFdHRVdV?=
 =?utf-8?B?NlpBVG1uVU52QUhZazlXSGVxcGV1YjZJaVArQ3hIbmJPaG1DakhHUjZXVTRt?=
 =?utf-8?B?Ry95UU9CV3p2WUVZS2Q0R28zV3hXVWI0V2tNZWN2VFA4Zk5TMVZCRTJGcWlD?=
 =?utf-8?B?UVhiSjBhb00xTUE3ek5PamNPK3UwRGUxZDQvTXY3NlNlVUNqTll1SmlocnJU?=
 =?utf-8?B?Vkl6L1V2dFpCTTVJK3dkZyszQ1lEekNBb1RTME41UEJwNUQvN3dvd1BtVzBs?=
 =?utf-8?B?bTdBVjFKOGpWeUp4TzlvT0RJYWxlN25UU1BndEJXdmtGR0ZUNHZhNjhoQjQ2?=
 =?utf-8?B?TUhBWS9DTkhHWW1WSG1OekJSS05zNk10Q0ZUYUNaQ1hEMjVGZjUwSCtGOE1n?=
 =?utf-8?B?elVvV0QxTlBmWTRPNEU5QlVFMElPUHNtMGdJUnFxT081S3Mwc2ZlbnpDZmxz?=
 =?utf-8?B?U2NJK2FsSW1VbDFDK1dicjMwQXh5QWZsb3J0bks0aE0vQmh0SFVnaExheElZ?=
 =?utf-8?B?YVduSGh4YW1LSlBTUHpvMDcyUXIzcUNBU01zc0s5MGdYMHY5a0dLN1JiVW5n?=
 =?utf-8?B?eEVjaC9PVTlaWDlDd2c1eDBHRDQ5YVMrRmsrQ1QycFdaNFhMY09XRHhjbStK?=
 =?utf-8?B?Vnpiclc5M3lyZU5TeUR5dTVFa2JxdHdtNDJURVdjQmpZWWJpK0xIMWFCK3h5?=
 =?utf-8?B?TEZzdHFGay9RZVZ1dW5vdTVhRHNmdEhjUVFWR1NYQ09zVlk0L3ZtWGEyMm9S?=
 =?utf-8?B?aElNL3oxQ2xyRHVHaGZQUGgrYzVVVDBId2xBbXlnYjB3aCtrVVdJVHcrM0lu?=
 =?utf-8?B?YVB1bFVBc1pnTVBzaGpZMXVrT0ErckZnWU9KWGJYRzhGb1pkMUF6N3IxRG5L?=
 =?utf-8?B?NFlGTDZLK1dlNzNjc1hSVldqcm9qckVNN3cyekJRSDAyMXlsTmZyTHdDdkV0?=
 =?utf-8?B?a3RmZ2lYMGdKdkVWRDBVbVlhNjRlUmg1Sk5xNmxDR1dtZGhXQWlvNlRWTDJv?=
 =?utf-8?Q?c36oTqmu9NPmMlGPtlgaVYzqm?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d91fa57-0a41-4e34-036f-08db919bddc6
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 07:58:03.3809
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9ZRFpuifiCDqtrDnUNtfCmrd0S8cgZHFhBT+hLehz9PjA4B8R5kZa1tWwGY/bhAM+Z6b9BhIuR2r/DofszXgww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6245

On 7/28/2023 8:08 PM, Jason Gunthorpe wrote:
> On Fri, Jul 28, 2023 at 05:36:06AM +0000, Vasant Hegde wrote:
>> Currently we use struct iommu_dev_data.iommu_v2 to keep track of the device
>> ATS, PRI, and PASID capabilities. But these capabilities can be enabled
>> independently (except PRI requires ATS support). Hence, replace
>> the iommu_v2 variable with a flags variable, which keep track of the device
>> capabilities.
>>
>> Device PRI/PASID is shared between PF and any associated VFs (See commit
>> 9bf49e36d718 ("PCI/ATS: Handle sharing of PF PRI Capability with
>> all VFs")). Hence use pci_pri_supported() and pci_pasid_features()
>> instead of pci_find_ext_capability() to check device PRI/PASID support.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu_types.h |  2 +-
>>  drivers/iommu/amd/iommu.c           | 39 +++++++++++++++--------------
>>  2 files changed, 21 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
>> index 321d361dfb60..57c74870b17f 100644
>> --- a/drivers/iommu/amd/amd_iommu_types.h
>> +++ b/drivers/iommu/amd/amd_iommu_types.h
>> @@ -821,7 +821,7 @@ struct iommu_dev_data {
>>  	struct protection_domain *domain; /* Domain the device is bound to */
>>  	struct device *dev;
>>  	u16 devid;			  /* PCI Device ID */
>> -	bool iommu_v2;			  /* Device can make use of IOMMUv2 */
>> +	u32 flags;			  /* Holds AMD_IOMMU_DEVICE_FLAG_<*> */
>>  	int  ats_qdep;
>>  	bool ats_enabled;		  /* ATS state */
>>  	bool pri_tlp;			  /* PASID TLB required for
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index e67c6fae452c..7f67e8991949 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -314,24 +314,25 @@ static struct iommu_group *acpihid_device_group(struct device *dev)
>>  	return entry->group;
>>  }
>>  
>> -static bool pci_iommuv2_capable(struct pci_dev *pdev)
>> +static inline bool pdev_pasid_supported(struct iommu_dev_data *dev_data)
>>  {
>> -	static const int caps[] = {
>> -		PCI_EXT_CAP_ID_PRI,
>> -		PCI_EXT_CAP_ID_PASID,
>> -	};
>> -	int i, pos;
>> +	return (dev_data->flags & AMD_IOMMU_DEVICE_FLAG_PASID_SUP);
>> +}
>>  
>> -	if (!pci_ats_supported(pdev))
>> -		return false;
>> +static u32 pdev_get_caps(struct pci_dev *pdev)
>> +{
>> +	u32 flags = 0;
>>  
>> -	for (i = 0; i < 2; ++i) {
>> -		pos = pci_find_ext_capability(pdev, caps[i]);
>> -		if (pos == 0)
>> -			return false;
>> -	}
>> +	if (pci_ats_supported(pdev))
>> +		flags |= AMD_IOMMU_DEVICE_FLAG_ATS_SUP;
>>  
>> -	return true;
>> +	if (pci_pri_supported(pdev))
>> +		flags |= AMD_IOMMU_DEVICE_FLAG_PRI_SUP;
>> +
>> +	if (pci_pasid_features(pdev) >= 0)
>> +		flags |= AMD_IOMMU_DEVICE_FLAG_PASID_SUP;
>> +
>> +	return flags;
>>  }
>>  
>>  /*
>> @@ -391,8 +392,8 @@ static int iommu_init_device(struct amd_iommu *iommu, struct device *dev)
>>  	 * it'll be forced to go into translation mode.
>>  	 */
>>  	if ((iommu_default_passthrough() || !amd_iommu_force_isolation) &&
>> -	    dev_is_pci(dev) && pci_iommuv2_capable(to_pci_dev(dev))) {
>> -		dev_data->iommu_v2 = amd_iommu_gt_ppr_supported();
>> +	    dev_is_pci(dev) && amd_iommu_gt_ppr_supported()) {
>> +		dev_data->flags = pdev_get_caps(to_pci_dev(dev));
>>  	}
> 
> This is even more confusing now. Why would the flags rely on policy knobs??

This patch adds support to track supported flags explicitly. We are not changing
existing behavior. That will be cleaned up with Part3.

> 
>> @@ -1843,7 +1844,7 @@ static int attach_device(struct device *dev,
>>  			goto out;
>>  		}
>>  
>> -		if (dev_data->iommu_v2) {
>> +		if (pdev_pasid_supported(dev_data)) {
>>  			if (pdev_pri_ats_enable(pdev) != 0)
>>  				goto out;
> 
> ATS should be usuable without PASID support. ATS on a RID is perfectly
> valid and is being used in the real world.

That's correct. Current code is bit confusing. We have follow up patch that will
cleanup {attach/detach}_device() code.

>   
>> @@ -1909,7 +1910,7 @@ static void detach_device(struct device *dev)
>>  	if (!dev_is_pci(dev))
>>  		goto out;
>>  
>> -	if (domain->flags & PD_IOMMUV2_MASK && dev_data->iommu_v2)
>> +	if (domain->flags & PD_IOMMUV2_MASK && pdev_pasid_supported(dev_data))
>>  		pdev_iommuv2_disable(to_pci_dev(dev));
>>  	else if (dev_data->ats_enabled)
>>  		pci_disable_ats(to_pci_dev(dev));
>> @@ -2464,7 +2465,7 @@ static int amd_iommu_def_domain_type(struct device *dev)
>>  	 *    and require remapping.
>>  	 *  - SNP is enabled, because it prohibits DTE[Mode]=0.
>>  	 */
>> -	if (dev_data->iommu_v2 &&
>> +	if (pdev_pasid_supported(dev_data) &&
>>  	    !cc_platform_has(CC_ATTR_MEM_ENCRYPT) &&
>>  	    !amd_iommu_snp_en) {
>>  		return IOMMU_DOMAIN_IDENTITY;
> 
> This looks like a mess that needs fixing. PASID support should never
> be a trigger for an IDENTITY default domain.
> 
> If GPUs are broken then match their PCI ID's and do the workaround
> only for them.

I had to dig git history to understand why its implemented like the way it is
now. IIUC it was not for broken GPU. We cannot switch from V1 page table to SVA
(iommu_v2 module). Hence they forced device to be in passthrough mode.

Part3 of SVA series cleans up this code.

-Vasant
