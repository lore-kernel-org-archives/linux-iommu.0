Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010008.outbound.protection.outlook.com [52.101.61.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBD873BC66A
	for <iommu@lists.linux.dev>; Wed,  1 Apr 2026 10:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775040380; cv=fail; b=NjW/RJ9h7907aBZGnnJsX1pUkbDbIyQqE0jS3uIbbR4UxAXMMBXkOaDSL40l9rSWTmcRbqtXFXpJ5473mzwhBlCxyXCRYU9O28AzYD297x/jmJ1g7nUX9JeZgbRnoPsn/PRJS14hTE5PaEPGYwBQ8I/BRB7OboqMG7CZOrtc/to=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775040380; c=relaxed/simple;
	bh=NQ6YbyOuOZ2u0+qLjQJOzAD7WGCiACSpey7Mf2+sTjI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m4l1Tw8VYC1nrt/crTwp6vVirLAYioIryUewUGUmxxK0mPJZhqax8yfM+HQHtJDjhIgugxms7AvVr2cJ1BzQglUwbDmgDXk2RNvMuDk+3J5VDZXMUsIf4vmnZQHyGQGSc2NPWUg5H8ec0r70fHQ30oPK4ADzJA5G3no8d1WCRGg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MeoNxfwc; arc=fail smtp.client-ip=52.101.61.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MeoNxfwc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yPlLLafKReLm7skbz4su2zI2x0EBkEdBbD6ct2raUPvUYQHpZZosTm7Et2hIu1t/cCTXr/NysGPiEW/orWDM3jEjWNZEl4n/tOcX4mvKc+fRxc2aTF4vp1z0Pf0aUZ9j5uTUJDG0HFB5V6SikWTVs2MyPX9Os1eDS9DzHvO8JjxikWUNhwx9F+oh12rXi3fCtWQcIEwKwno41TkUkA/gCj0QdK4EpNUxSM0UVzYUwDCOStqxtYMnILuthWnwUQqVkgQ1JJe96GJmbx2y3V2+Se/U49I9Id5bkA5JqRCqEG1OMbg8ZCaojAWdj1GfbvfH6x8C/TUgnLzOW3Km6cGtcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vyr5eVr+qeWc9/pOyoBBX1mcXaVFAh2KVprjhBxp7b4=;
 b=m326pZRvFTw0u5fcOeUOHTYmhtl2+UQzzVq4PhT88iJCuH7S0L5n/jf3uyG/+QplyQPmsKBroMgeIiUIrN1GbkKvmlkAYsf8A1ywIj5Sdr0Jltw7mb5+nFeJz1es5bgZsLauRlSwAqSgye0uc10yasH/WSgB+5EGYMtYka62HEcrY/X7lA04MJ0exdAJiO2ElkvDt+nEXCT8ttq0eDiW6YXIkeLjIEsuy4+vbrlwWOKtzuP3MiumEc19ixbjXwB4+OoeRA67Nsoscea79UE7ozQkAbAhgVQVZDVfSAGKCy8LAgMHFM93agIPpcfMXaK70PSaMlWCl4Y0vWag4JXdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vyr5eVr+qeWc9/pOyoBBX1mcXaVFAh2KVprjhBxp7b4=;
 b=MeoNxfwczAIDlDAyJmVlI5YY+OKuh+1U9xXsGP3yJn0s/YboH6k+dHgZBgzUAjPvdItkyC7entYDyYSSpn2POHrYXrwpSapMQZ8WRcItLP1yR/GQUkq9vtasaQ1qwzOe8PlxnJJALQllC1EXYIKPqE8ZgR8ORG9MEs6ROQETIIY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7SPRMB0143.namprd12.prod.outlook.com (2603:10b6:510:201::21)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Wed, 1 Apr
 2026 10:46:15 +0000
Received: from PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f]) by PH7SPRMB0143.namprd12.prod.outlook.com
 ([fe80::a6b4:32ff:a323:b46f%3]) with mapi id 15.20.9769.014; Wed, 1 Apr 2026
 10:46:15 +0000
Message-ID: <ea4cfd4d-9ad2-4451-a896-9f0435e72a06@amd.com>
Date: Wed, 1 Apr 2026 16:16:08 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] iommu/amd: Invalidate IRT cache for DMA aliases
To: Magnus Kalland <magnus@dolphinics.com>
Cc: DheerajKumar.Srivastava@amd.com, dhsrivas@amd.com, iommu@lists.linux.dev,
 jonas@dolphinics.com, joro@8bytes.org, larsk@dolphinics.com,
 linux-kernel@vger.kernel.org, suravee.suthikulpanit@amd.com, torel@simula.no
References: <122231f6-3aa4-4f7e-a663-a182460c9436@amd.com>
 <20260401103559.63865-1-magnus@dolphinics.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260401103559.63865-1-magnus@dolphinics.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::12) To PH7SPRMB0143.namprd12.prod.outlook.com
 (2603:10b6:510:201::21)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7SPRMB0143:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: 51f4b356-7565-4b99-cfcd-08de8fdbe5df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	w2U/n407wwfGQiu6mHSsEgvlzBWfks0Hbm9AU4fq/+CbKxMpIBi4dpBSwcwTua2Uc+DeCOE9NmJJCeaU3V4TfQ4iHil3YDP76LJRnkhPVtdT4vpibndzaLRpgbhE+nWcbYwUyu6IiY+6TtS2OVrfBMYJgeBjo82kYfJHPxSqA0RvQhIib61bkYHtGj3OlaQkruw5XdAJr5yzAI4uM1hTAuugpqBttHcQd6SHwdjN6XXxAJncDSxDHvMyW17waU3PVtV3FXQklbsdza8x5gC1ZrAonDkTym2wf2jLziOGtiOcKit7BPY9xBoL+dCLtdAGGOL1WSoSlQIrvXHxfW5JNVhflnAzQ7k4iWQUcG4PG1ujavEphxSCAjOlThJM0jCat3G8AeRbgBQui7TfTbUFKbIW22Kg3INvJ/mWCtUHu/DOfZBImrd8XrLu+TVmsiG9P3m9ZssHqsrB9/w9RFkSgJDnmo1MeEBUW2Z0vAHeXZViFlHCoZpMIkqzLR03nyaisZZKuyG03crAISlIDaIMcXoAeSrIyTJABzSu1BC4VcGcBOKJBNrPJzr2Sr0bLc8bEp180U4nK1wHR1VytsQrbE20crHDlyal4Qzg/NotrY4naXUTWOMOSkabL4IcW0wCXDUCRhSpABsUqBmqn61RIAa1I5UCtgPdOI9rdwX3vQK9NjPkpRBI6oIfyb4LDmV/
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7SPRMB0143.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1ZjRlpNbHN0Q3Z4THpWVWRoQ0NmUmFSamhKcnJsUnk1OW9qaWhnclUzYlE5?=
 =?utf-8?B?Q0JmWnpPUE1uSG1QQzhtTDBva3duOHRVV1dEYmVqcUd0QldYSzRMWkFQOWN4?=
 =?utf-8?B?NG4rNkNTY2phSVhCRTNoMmZkNHRVeHMrbkM4WUVKSUp4Q3p6bndTVXBKZU54?=
 =?utf-8?B?K21NOTg5bDV3UE4yV29JeTNpZk9kSURlYjE2QjIzanIvLzNWM0pmSVdnQkZs?=
 =?utf-8?B?R28zbElOcFk0aUNKenF6RmhDQjdpeFUvU3Zrd0JoM1hVVXF6NDk5MEZxYmg4?=
 =?utf-8?B?Yk5vdkkzQW0xRjM1UzhKcUxqVnUvejI2d1hLYjI3MmpXV0puNzRTV05UUnNQ?=
 =?utf-8?B?Z285RW5qby9TWUFibkNqa005NFpSNUFLa2dFUWc3MTBNcHdkVWxEMzQxNG5l?=
 =?utf-8?B?bXJGdzJEb3hlY2FVMFVnaDUzM0FFdzNXVHBWTW5pT0hVWE1yMHpObHZaWWZ3?=
 =?utf-8?B?MTF0RGx3bUIvd2tUeE95QW44NlhSdm5VcWJ2ejZjT2FjajN4OTUvZGVFZjBu?=
 =?utf-8?B?UCs0bXhvbDlnWDIvRGNRMFlPK2wydHEyeXg5NkYrL0o3TzRkQlJaQ3owb0Fk?=
 =?utf-8?B?VFVSMjFVQVFXVWM2dGExSXhuZEUwNDFldDZ1YVpTekNuaDFvaVZDaE1Bc3dR?=
 =?utf-8?B?VzFVQnhONGdPU3VpcytYWkExL09vRHRqSFk1b1Bjd2hsUjE3YmV5NHhPbDdL?=
 =?utf-8?B?WHp0QTAxTlBRM1VZajJyd1RvdHdqaEU3Y3YwWUllN2ZQWks1bnFZQmtoMk1u?=
 =?utf-8?B?QnFkajlLcDdzNDYvY2lyTnhDK0JyN0JZNG02SVNSd0JFamVCeSsrU0pKaVl3?=
 =?utf-8?B?SXdtWktJRDg1OFRGcTZrSWtkTVpQc3RsV0dGUkYwT21IUTUrM0lZYTRWUnl0?=
 =?utf-8?B?RFF4TWNxK3dCWG1rSFpmV0FKOXkwT2RvVjE1dHJMaFR0QjNtYVBrYlRVYVVM?=
 =?utf-8?B?M21vUmtVQmt3Q0tHeFNXZ0RlZEttNklCRnFrV25aK00wNVYrUmZZQkhZVzFJ?=
 =?utf-8?B?NWwxRFFxcmZvd0tDeXE4YVZPOXoxWUJXUnFtdDBlOWd3S2JIZWlqR3FjaU50?=
 =?utf-8?B?RDZkMDB2eldIbG1MRkoyb0RCcXJaUW91Zm04TkVKQzVsZU95WmpUcGdpbVdx?=
 =?utf-8?B?K2hPNWk5Yk5JdEtLbXZ6bWZHQTdiZkZ2NXZYS0pFVnZRenNGSVdhb0xNeTl6?=
 =?utf-8?B?bFdCaWIrQlRXZlhWWTYyREkveUFRU1lRNHorTDFyaGNGMmg3N2ZKejlsRnJr?=
 =?utf-8?B?Sk1hOUlsbDkvcXFEb3BxUXdrSzVyL0xLb0RMK3ZyV3lRT3ZFZVowMVM0OWxm?=
 =?utf-8?B?NTRORS8yNEZhdHlVMjRpSDNvY2pHNUpIL1lPVzNtMWNZQVNzbkZXUmZiSHo5?=
 =?utf-8?B?dnpKT1NFZW1QaHlHV1gxM2wycE1jb3R4elZPUUVtd3U2b0tFdmZ4aVk0Z2pJ?=
 =?utf-8?B?dHpud0tnWGJwM3hmbThqdXkrdWttRHRzV3ZnT0plTi91aGRUMlRNbFZSRWIy?=
 =?utf-8?B?QTMvN0NTUGV4NndrcGJRYXZxbFhZTlB6ZUozM0tjd3RzQi9pd3hUTlRxNzFQ?=
 =?utf-8?B?eHZud0dQZ3BLZE96eU14b1JoQ3NzdHZJVDFIeFJBODRXYVdWamZPNGs3dDd5?=
 =?utf-8?B?OG9EVHNyN2NITjJMNFJvWlpzTWNCRTE5WlFFNlJGLzk0TEVQRGZFOStZN2ZI?=
 =?utf-8?B?bUFkc3hsTTVzSzFhU2QvbXIzcWVhZGZWenN3Q29lWmhTeDBYb05jalUwUHpy?=
 =?utf-8?B?SGJoZzA4UEF1eWdPbVpOWTFCSGlPNUNla0JpQS84dGEyZUxJVEdTbjVvWkl0?=
 =?utf-8?B?aG1BWHRLTlVPbVN5TmtiSGRMdmVzZlY4Slp2SGkyTHlHRk5sVEhpNEt3bWg0?=
 =?utf-8?B?M1lvSDVYOFNpNkVVY3BJcG1jTENDQ0h4V1RDMnJwZkRBY3dsK1MrVDNkekFL?=
 =?utf-8?B?MXcySmsraFVEaGVpaGFNaEx4UE1FUU1EcWF3MW1SbXBnTkxRcVVxQ0p6VGZq?=
 =?utf-8?B?VFNrWDZtNTRHSGNNNzlua1dtdzRCK1JDWWo1VXRweGs3cFJyK3VYWUg4bTBP?=
 =?utf-8?B?S0xkY2xlcTdBUnZydEFBaWJuS3o5bzFoV0p2bGNyclRjeVlRQjdLNThUYStC?=
 =?utf-8?B?NVRia1FVMFA3eWJNd3BGNjAwOWhhenhqMjZXWjBUQmRJZWRnQ3RyaU0zaUlh?=
 =?utf-8?B?aWdUelVaL0hTNU5VclNUY0NsNW9uMHRkb2RlbEU4K2FnTU4xaWxBcTlqME9Q?=
 =?utf-8?B?VVgySXhabWFHVWN4dlU1M0w0dXZPcUFZemlNTko3OXRTaW9Id0RNbEtXSVpI?=
 =?utf-8?B?RnczUjVFWFdoQnJGZWd4Ri81ZkN6aWphYVVScC95eFR2T1dhUXQ2dz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51f4b356-7565-4b99-cfcd-08de8fdbe5df
X-MS-Exchange-CrossTenant-AuthSource: PH7SPRMB0143.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 10:46:15.4398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7sILr1VOkvyTb5iKsQqHmKhydku7ILNB3AI0/RVj11O81zeS6Oxs0+r+UZWyNSymVoV774dq0xALsZWPYUcjKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

Hi Magnus,


On 4/1/2026 4:04 PM, Magnus Kalland wrote:
> Hi Vasant,
> 
>> I went back to those reports and reviewed it again. It looks like
>> pci_get_domain_bus_and_slot() takes spinlock which is causing the lockdep issue.
> 
>> I think V2 is good w/ some changes to get the pdev.
>> Instead of pci_get_domain_bus_and_slot(), we should use dev_data (like we do in
>> other places).
> 

.../...

> 
> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 050178cf388f..eb23b9e7bf03 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -3118,12 +3118,10 @@ static void iommu_flush_irt_and_complete(struct
>> amd_iommu *iommu, u16 devid)
>> {
>> 	int ret;
>> 	u64 data;
>> -	int domain = iommu->pci_seg->id;
>> -	unsigned int bus = PCI_BUS_NUM(devid);
>> -	unsigned int devfn = devid & 0xff;
>> 	unsigned long flags;
>> 	struct iommu_cmd cmd;
>> 	struct pci_dev *pdev = NULL;
>> +	struct iommu_dev_data *dev_data = search_dev_data(iommu, devid);
>>
>> 	if (iommu->irtcachedis_enabled)
>> 		return;
>> @@ -3131,11 +3129,12 @@ static void iommu_flush_irt_and_complete(struct
>> amd_iommu *iommu, u16 devid)
>> 	data = atomic64_inc_return(&iommu->cmd_sem_val);
>> 	build_completion_wait(&cmd, iommu, data);
>>
>> -	pdev = pci_get_domain_bus_and_slot(domain, bus, devfn);
>> +	if (dev_data && dev_data->dev && dev_is_pci(dev_data->dev))
>> +		pdev = to_pci_dev(dev_data->dev);
>> +
>> 	raw_spin_lock_irqsave(&iommu->lock, flags);
>> 	if (pdev) {
>> 		ret = pci_for_each_dma_alias(pdev, iommu_flush_dev_irt, iommu);
>> -		pci_dev_put(pdev);
>> 	} else {
>> 		ret = iommu_flush_dev_irt(NULL, devid, iommu);
>> 	}
> 
> Thanks for the fix. I've tested it and it looks good on our end.

Nice! Please send v4.

Also I have sent one more fix. Can you please test that patch in your setup?

https://lore.kernel.org/linux-iommu/20260401080017.117549-1-vasant.hegde@amd.com/T/#u

-Vasant

