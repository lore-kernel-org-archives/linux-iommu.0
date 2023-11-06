Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1AFBFE
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 12:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2FXIbiV+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dgW4c3lUuMQpmi6U/1rqs8XRI6O4uZEQjSqjjBcl2HHVd6XjLG0nMAVP8boM/ivHT0Kuficydxoy0cE9ghz3wMVJqqys8YzTuOhT6z6JZ1Z9PUeVm1pNbXFcwMMZdNCCkKSQnC75XtltPUj45Zz+DACzcRACemVWXJTeyl3pXQeGkTm94FNt32LHki9hvqdJAbQHy77LR3fqyB/dPxfMlG7T0257fvODBLVWQ1ltvKI4TYFrwufamL2/LD8mTslvaul/dqRTEoyluEgttp5UPFitutFE5tWO2VmnbteBTnP1Rx3pxxUKmpyU+Ypv32HH8SLdMVsd6ON5+iCTXtCiTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xtyNcI+W9pYhVjqJq7FDHGtnbX9rDTO5KCNBWx6moMU=;
 b=lCCZkUQBNS01t8t7CVjcjTmhb1J3ybc+7oegLelhE0ZKrYROO+j7GaoZfD3Qeez/BJx8VGgYPAqa5RteSB5tXG/8CH0lhkArijoRuQZ27zjC97m1gO22WYEROtfpelH2W6xUHpDHmLvscPK75pZa/TJnfdiH19B+OGDPGzNRv/8J0/yS0bit+MvD4JmAY1W286is0HqjiVL7BSQ+hILyA4yRzrc1lC0+qVRmF/nk8bbgPaAhZYZwjk8AvtTbsPOXCAxIqT2vH6XFvKmNph4/I42AjEax4I/N0/locuzOyU4wLYMntZKaewDNc/BdGU2kXPBSwaJo6vpxeBDfJqE3+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xtyNcI+W9pYhVjqJq7FDHGtnbX9rDTO5KCNBWx6moMU=;
 b=2FXIbiV+O8aVqCoTiTgufVowcrAaeV31ZOU1rGe0AWPB83ouo0ssObkVKnDyM4dvph7fxVZ1eNTDikyiq0luQPof3E3ZgJzMMlAdcKAiTibS+4QuxEJTH0DiXePsk4B/gXaw0Vt0PB4e8ns8qxW+4Cuta+kJ4Y/jCxA7rkoLozI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB6921.namprd12.prod.outlook.com (2603:10b6:303:208::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.28; Mon, 6 Nov 2023 12:39:55 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 12:39:55 +0000
Message-ID: <a4855a3e-02f5-2ebe-f8c7-92137421418e@amd.com>
Date: Mon, 6 Nov 2023 18:09:47 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v3 06/13] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20231013151652.6008-1-vasant.hegde@amd.com>
 <20231013151652.6008-7-vasant.hegde@amd.com> <20231105181604.GH4634@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105181604.GH4634@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN2PR01CA0225.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:ea::20) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB6921:EE_
X-MS-Office365-Filtering-Correlation-Id: aa44ba01-34e7-4349-9aef-08dbdec57a85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	E7lNkA19cWKOGkUVJIUPpdpRhJLXK9Ibby3GQeeucbagwotNnvp8kn5veVK/2nLWnMzcV8IWdKu9keqJWte0KVsJz+S5EtW1vXp9gyolzx8wk7Nqn28w9i+YpAl2PY/sl3Y5aHpFkcvVp6wANzt/GiThW0MZm6CYt4Fm2/3lYvSd271qLYJgK733YWWbwFa47O6WwOWdfBNFa366Z5j2iIi57g3EddfDZ5/UXYLv6GYCYM+2c3Lp5Fdem9frjffY9uGmLKK6+1KdOy9KXO0Er+bRKzYQtVLpcmVZg2vyH4ZZClxlCh/u3Pv0upggKNeO8fQidMLsJpFp6+fqYtrk6yocrb3f+nAxInLzk/Qdo6CAFy2wOF/IuPIAKyD2n3A0IcPMIYZmLmG+sW0SUV3It3F15tJluhbfyAtUi0h/fRJeU1XkLtnRYagid5/481B3gf2gBHNfimH1+/50bA0n/f7YlB8+s+GNOvw46UOEXLgSw+TA7yu0F7llrGYJipVy8KOijOMrUHhLyKOcysyPdQu/WV9DUYLrT8xYHbImMbGkJDJ+pJvPWYDzFLozWd3v1/UGdy3GGD13QFoySAw+0pIXNoKh/454vvEs4jHnhjWHqPEmhfbIx3+bp2wGtuT/ueSBhgvlbqyjY+hW4x7hPQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(83380400001)(53546011)(6512007)(26005)(2616005)(6666004)(6506007)(66946007)(316002)(478600001)(6916009)(66556008)(66476007)(4326008)(8676002)(8936002)(36756003)(38100700002)(2906002)(41300700001)(44832011)(86362001)(5660300002)(31696002)(31686004)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?N2xLTnRtNlpzSUNpU1hyM244RHI5QTZ2WDlvNDhnYm1VTUUybmNPVzV1Tmlr?=
 =?utf-8?B?R1ZQV3VpZXdacmlocE96Z283RlZLM0pTSjBjWG82ZU1wWDRTQjQ1NldSNTVE?=
 =?utf-8?B?WlNJTlFMamVVOG54UVcvVFN1OUtlY0lIa093V0FacE9IZnpWY3R1c1NnNjA5?=
 =?utf-8?B?bFZPZkRPcW0wM2ZoSnAyUStVQlBORDgycXllMWlLWmY1Q0RmZCtTSVFvRXhs?=
 =?utf-8?B?UXBJTnMvblR4bWhDc1ZhS1pveUNQeXhmNUNGNXVpQmJXRk03WmU2ZEZteTNJ?=
 =?utf-8?B?M2NsYjFWazJwN1VnNXhRM1RQclFrWnllcVp0MXo4SVN2YnlHa1oxSEl4ZU81?=
 =?utf-8?B?V0w1OHg1eG9aN3VkYnp4Wko0QzNnRGZXcWJzZmZMbWlKU1FLVjZ1NXRCVUR2?=
 =?utf-8?B?eG4xc3VpRzUrRnVmd043ZVp5VjJNTlpKQUpMV2EwRnVYbFowVUY4UXVjRXQ3?=
 =?utf-8?B?SlhWMTZrTVpGdkF2YURaR3JOSlBlUWczUlNrUjREczI0VUpVeTN4YUt6M0wz?=
 =?utf-8?B?NDFiRmIrcXZUUDdzWkExbFc3Z1Fib29QWi9nMXVKdTZrWGtXQmtiZGN5b29C?=
 =?utf-8?B?SUthQ0twdXpUeDRkb1pMajVmMzBpVHUwYnBad2RJeDBiR0tnV0RVQzJYWTBy?=
 =?utf-8?B?Q0RpelRHUzlGV0tRNU5JdE4xek1RTlBOK1RsMnBGZzVXMlg1SVBQcW01RjBh?=
 =?utf-8?B?dkZvQ1BkNFVsVFR3S091Q1R1eFR5UFZGYUFlcUhIUGhYc2pPRFpjdG9xTFIx?=
 =?utf-8?B?cWlqNTRTSFo1TjhyRzd0bmJPYVVyaWJJaDBBVEpUdGYwa3huZWViaWpUQVov?=
 =?utf-8?B?NWpTY2hUMGlaYUtwc1ZjV2tCRk9qUW1vb0dEeU04WWdWbGRyaTBISjBxKzJI?=
 =?utf-8?B?NS9YdWhKWUN3ay9NWnRZendXWkdtMWlPeFo2ZUxjNjhLdkwwbVA5WjlvRmJQ?=
 =?utf-8?B?aUpjc2t3bGJremRvUll4MlBybnpjbm94Q1drejVFZXl1eDFSazZJN2N2U3Qz?=
 =?utf-8?B?RFlFZXRBQ2lTNG01ZDVWa25rVURIRHVOWVk5Z2pIRkgzZDAva0ZKeTFQZWY0?=
 =?utf-8?B?dXFlMjdoeGtNeExEY2VtSEhBa095cEh6OElwKytCbkhVSE5WR1VNcktxelU1?=
 =?utf-8?B?NEYvRGFMNjdETmEwM0F2MEtvTlljbzNCVCs5aW5yRWhDZU9zQW9MT1R6U2dv?=
 =?utf-8?B?SFVKKzZBT0JCUnZtSVcrckRCOXJKYzY1aVVyc3BHTU1GU1FBUG4yVE1FMHRH?=
 =?utf-8?B?bG5oMy9kR1RJT2RrRUVnTUk4aVJyL09NYUFFOGc5SzU2eTlnWDdYV1ZxNjJU?=
 =?utf-8?B?REQrMmF1ZWtGQ21UMXF6UzlERDdORDhBUVh2dkZlTFBhTVRQM3Y5NWN0blhk?=
 =?utf-8?B?WVlXSzZGMXJCN1ZRb0VxTTduNTVYOUE2SUl0SHB4c2k0Q0xXWWZjWEUyRVg5?=
 =?utf-8?B?aU81NStKMUF3V2pSOHBmYXVaZlBVellUY0JzZXIyOGtyYzVkQnFBNitZM2dw?=
 =?utf-8?B?K051WEtKR2FxUVp5NU02cG5KRmx1dVBWaldMcEkwWEFtenh4U0YxMXV3OFNS?=
 =?utf-8?B?U1hGYWhnZlQ4a0dmeGc1TmVHaEdJaGpNZytkVEZjTFNRbStkaCtVYTVLTWY0?=
 =?utf-8?B?eDlFSkxRQVJwNm90SEFwRUY3bUxmUnJQMC80VTNFQW1MOUN0aThDMkw4bkRq?=
 =?utf-8?B?Rm1YTVVsRWVzQkNPU2xROHhCeTNEcEJ4OXAyY0I3cGthenBqVXltZnNSUmpk?=
 =?utf-8?B?TGc0K2dwTERFM3oybXY3WEl0UkkyQVJoZjA4VWV2blFoNmhERUJoZUhQZHRH?=
 =?utf-8?B?TjdqVldYbElQMDhhQ2tjUGhDM1VpbUphd2ZZQmlxY1ZFYkp1QThpZ3hKWUYw?=
 =?utf-8?B?TTdZanJRajliZ1VOdDB2eGtRNENXQ1FaQjArU01YZGR0RkRRTXJTUDVGdkdy?=
 =?utf-8?B?dFlaVUw0WHR6ZDY4VW5aY205UkhpbklNT2JGMm10YXpmTkxWRWFWYVBHakhp?=
 =?utf-8?B?ZUJLY0tYNERjVVczZjdCWEhuSFFJaFoxWmJFNG5UclVjTC9ER01Hci8vd3hE?=
 =?utf-8?B?cHJDZk1QbVlHVVgvb3RnNE5QVFFmYmM0ZGo1Y2pmaGdRRmE4bDlJV2ZLWDFu?=
 =?utf-8?Q?/evmNI835QsLfT71+2/w5p7EZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa44ba01-34e7-4349-9aef-08dbdec57a85
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 12:39:55.1802
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i8UdFNgYnfeaQk5YB0SsztfkfptImSGiuqm9iJVpIsV2xczIfsUDrvjFtLW+1M3lP93wDzEMp7zYRxGIcmmIZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6921



On 11/5/2023 11:46 PM, Jason Gunthorpe wrote:
> On Fri, Oct 13, 2023 at 03:16:45PM +0000, Vasant Hegde wrote:
>> With v1 page table (stage-2), the AMD IOMMU spec states that the hardware
>> must use the domain ID to tag its internal translation caches. I/O devices
>> with different v1 page tables must be given different domain IDs. I/O
>> devices that share the same v1 page table __may__ be given the same domain
>> ID. This domain ID management policy is currently implemented by the AMD
>> IOMMU driver. In this case, only the domain ID is needed when issuing the
>> INVALIDATE_IOMMU_PAGES command to invalidate the IOMMU translation cache
>> (TLB).
>>
>> With v2 page table (stage-1), the hardware uses domain ID and PASID as
>> parameters to tag and issue the INVALIDATE_IOMMU_PAGES command. Since the
>> GCR3 table is setup per-device, and there is no guarantee for PASID to be
>> unique across multiple devices, the same PASID for different devices could
>> have different v2 page tables. In such case, if multiple devices share the
>> same domain ID, IOMMU translation cache for these devices would be polluted
>> due to TLB aliasing.
>>
>> Hence, avoid the TLB aliasing issue by allocating unique domain ID for each
>> device even when multiple devices are sharing the same v1 page table.
>> Please note that this workaround would result in multiple
>> INVALIDATE_IOMMU_PAGES commands (one per domain id) when unmapping a
>> translation on the shared v1 page table.
> 
> It is worth pointing out that this is a shortcut to implementing a
> more complete solution where the domain ID can be shared right up until a
> PASID is used.

Let me see if I can rewrite the description bit.


> 
> 
>> @@ -1418,6 +1426,19 @@ static int device_flush_iotlb_range(struct iommu_dev_data *dev_data,
>>  	return iommu_queue_command(iommu, &cmd);
>>  }
>>  
>> +/* Flush IOMMU TLB for the given device */
>> +static int device_flush_tlb_range(struct iommu_dev_data *dev_data,
>> +				  ioasid_t pasid, u64 address, size_t size)
>> +{
>> +	struct iommu_cmd cmd;
>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev_data->dev);
>> +	bool gn = is_pasid_valid(pasid);
> 
> Again it seems obfuscating to ecode the table type in the
> pasid.


It depends on how invalidation series goes.

> 
>> @@ -1523,11 +1544,25 @@ static int domain_flush_tlb_range(struct protection_domain *pdom,
>>  static void __domain_flush_pages(struct protection_domain *pdom,
>>  				 ioasid_t pasid, u64 address, size_t size)
>>  {
>> -	int ret;
>> +	struct iommu_dev_data *dev_data;
>> +	int ret = 0;
>>  
>> -	ret = domain_flush_tlb_range(pdom, pasid, address, size);
>> +	if (domain_id_is_per_dev(pdom)) {
>> +		list_for_each_entry(dev_data, &pdom->dev_list, list) {
>> +			ret |= device_flush_tlb_range(dev_data,
>> +						      pasid, address, size);
>>  
>> -	ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
>> +			if (!dev_data->ats_enabled)
>> +				continue;
>> +
>> +			ret |= device_flush_iotlb_range(dev_data,
>> +							pasid, address, size);
>> +		}
>> +	} else {
>> +		ret = domain_flush_tlb_range(pdom, pasid, address, size);
>> +
>> +		ret |= domain_flush_dev_iotlb_range(pdom, pasid, address, size);
>> +	}
>>  
>>  	WARN_ON(ret);
>>  }
> 
> I feel like this has become pretty complicated.


I don't think its so complicated. All we do is extra check to get the domain ID
and its necessary as domain ID allocation depends on page table type.

Also we have centralized check in domain_id_is_per_dev() so that its easy to
tweak it later.

> 
> I think this driver really suffers from not having the right
> data structures to handle everything cleanly.
> 
> In smmuv3 I added a 'master_domain' structure that linked the PCI
> device to the iommu_domain. ie when attach is done you'd create a new
> master_domain that essentially stores the parameters required to do
> invalidation.
> 
> For what is going on here I would say to do that an then put the
> "domain id" inside the "master_domain". Decide when the domain is
> attached if the domain id should by taken from the iommu_domain
> (device does not support PASID) or from the device (device does
> support PASID)

We still have single domain concept (at least until we introduce vIOMMU). All we
are changing is how we allocate domain ID.

Having another domain for each device just to keep invalidation info is
complicates things. Also IMO its unnecessary.

-Vasant



> 
> Then you don't need all this logic to try to figure out what the cache
> tag is later on. And you can get build up to removing the
> protection_domain->iommu madness and more properly integrate the pci
> alias stuff too.
> 
> Doing this datastructure change was a big step that made all the rest
> of the PASID/SVA/etc stuff I did in smmuv3 flow nicely and logically
> 
> Jason
