Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2063.outbound.protection.outlook.com [40.107.101.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B0A19443
	for <iommu@lists.linux.dev>; Tue, 16 Jan 2024 10:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZRFFapmH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BZkXFCPQPvyKlGDzQOMKsjuv5fJ0X7juhCDe1iIo2bGhPpUl4i5fUf+5U2dPpCqBhiTNsRHJFQ5S42EYFOoomkmjJI2XDqqJfXGF1It8FEkr+BoT+8+YtrQSkdhB86K00c2g0S4BaXMrPeosQj3AjN1qiFb9csSWgkhQ/SA+1bgMWGeG/Q8DLt3U6Y47PEF2R/qUSZCh+3fZhW+Uvl62iEq7z/kHg2zKAun6AQgtCmPD2PWb6/lKHfUbBewEM3B/Xu3ujiTDRewW0J/WiPAwDbUGC8OgsBeOAsSOrIyURUHRfgrBYL9zBI6GY4ldb89H/XXKhaWO9Uxoxwee/++cNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5A1DOW9OMu9UiurSHyyEojw7pIC0q2PBdUe24+q97cY=;
 b=j7rno5FUpbDYl6UEjn1wLoPBWnq/yU48O9CDCf9qiALyeEB9MS+1zEvPbVszN3vQZHbIZo88pQbgmwfv3rYygoeLdLaVdC2oS+aBzODbT1b7l1bYhwRBJKvqrCSpASY8m65cY+l2e09zM7AYmQdcIVCljMJnsyZvUy+Puftvj6rNyPGz9FdXNgjezald2Ux2Vku6+9x1T2CAZCCpf4q+idIQZ+7/4JhsyWbbZyVeVYLPx9iQHz6goAF1XJgNwOz+hrXIL7Xq9tkCmg/rdQAckBZAz73JrV5URm+buuyWUdqi+qmH7IeFi/Ej/whzQMKPZhpultn9Rermog/35BKkJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5A1DOW9OMu9UiurSHyyEojw7pIC0q2PBdUe24+q97cY=;
 b=ZRFFapmHyUbmVkp2ProeeRigwNoSCVnC8cN7dDatYvCQR9YM08w0CF9PHE/n9/qjRyAnRvTXvBcqJY4tGC5YNfrQrh3+H3izkHFR3h6nOA+obOfw+CWyudet7H1CKaL9rQQFUkrWpWU1usjPUIfJuRLCvhJUn9RZegpugo3CmCk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 CH2PR12MB4924.namprd12.prod.outlook.com (2603:10b6:610:6b::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7181.26; Tue, 16 Jan 2024 10:52:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7181.029; Tue, 16 Jan 2024
 10:52:25 +0000
Message-ID: <5d0f4146-fb57-d700-1263-881e2ec3ded7@amd.com>
Date: Tue, 16 Jan 2024 16:22:16 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v4 07/16] iommu/amd: Introduce per-device domain ID to
 workaround potential TLB aliasing issue
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com, Baolu Lu <baolu.lu@linux.intel.com>
References: <20231212085224.6985-1-vasant.hegde@amd.com>
 <20231212085224.6985-8-vasant.hegde@amd.com>
 <20240105185549.GM50608@ziepe.ca>
 <d71a2bc0-ed07-53eb-faf1-bd36b6ff6ffb@amd.com>
 <20240111135952.GV50608@ziepe.ca>
 <0215990a-dff1-c6c3-bfa1-c90fa63b0c7b@amd.com>
 <20240112145934.GY50608@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240112145934.GY50608@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0022.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:97::23) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|CH2PR12MB4924:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e5460ff-4c57-401e-bb3b-08dc16813967
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	s9g7tKabYLdxBZeUEhdJI7cqLl/5uTFRbjgPS5G22UAxh/zH+KNuDNOt5XoNXyAy8T7OeywLR4Tdf8XFB2voudcBKmVx74fNmZbzECRNqm9N2v/OytEDhuCnVUI/sUpjxa35Wctt0WJL87iageVCRjqKi2QPnWhfv+Q+1EXGpP2Q7TkbgJkh+LvD0Xs3EZK0X+XiH6JygR8ZfeWcS4KaZQmHJ4+Q5sdogPUmKFAuzubKLQSH1o3iFu831+GYbsgPWK80SA/anHVrvBeoBzSOe+fwv3N2ryek3Eq9eAe6qQdosH77PLQ9ett3YdhgWrdpGHKgGIBiNxj0vOQiFFC4fnBbNw8Frn0CtzC56eik2vWv2axvpoHzmAPTKwFcihtOcqGPLJ+NFRrsouhLbprIEs97RyZtQBK7qLfZCipyYMVhMHG2/sz81ADLRBtNS4NN+z5tT/B7eSFZ/uhpLpeWgG2i0EqnXO0UV4zUf6ZErQ38w0GXrDDUp4hfZ1H6n2JavQjbgznGLorTMiFC5brsPkX+J9VYZtuPmPFbDZZi6RBadwo18i4/XMpqo0DsFhkQWrb3AtmFmv5E2RKYPfLjhVdE9HfshN8PGtrh+88HKi7MJVQAyOxybW5ZpGAi6d/gm68tSBkyo7Z2/6iKITMC8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(376002)(396003)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(26005)(2616005)(83380400001)(38100700002)(66556008)(41300700001)(8676002)(8936002)(6916009)(316002)(5660300002)(66946007)(6666004)(66476007)(2906002)(4326008)(44832011)(478600001)(6512007)(6506007)(6486002)(53546011)(36756003)(31696002)(86362001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eUl0SHFOZVdYWVd0aWFvdGRUalIxNHovRkp3eU5XRGlsUTA1dU1wbkxZYm1B?=
 =?utf-8?B?anVKSVZ1RmRrZ1VwRHVROGRDa1lXb2lOUDJOaHhXVEdhcFNGMFhqVjI4TWNp?=
 =?utf-8?B?am1DdW9DYXlOUXVtbHptbEorV3lWbWZlczV3SWYvQTY4bllBbkc2RFRiajdr?=
 =?utf-8?B?SE5uUDM4NlZXZjFodFBZNXAyWkpwNjgxajRKY0s0a215RHZsV21qMWtGUitC?=
 =?utf-8?B?Z2RHMnBNMmE3VWg4SkMrYTk3bjcxMVU0KzNLM2dXb1MrMjhYNXVWb0ZnQnQ5?=
 =?utf-8?B?ME5oZ1lKL1FlR1F6dWNTMmh6S1pITWNhNGVGMlQ2TXpLSVNObWN2OGhCbkhO?=
 =?utf-8?B?K3dvRTQvSGVKQ3pHNUV0bWxIK2dxU2U0Nk1KM1pQbVA2S0hSK3BNZk1EYi9W?=
 =?utf-8?B?MlNGZTNtTkNvd1JxNVZJa3lMbGVRNkdiQ3g4b2tOMlMxUnkyUyt2SFlUclYw?=
 =?utf-8?B?U0RiT3hKMDN5ZVQ2VkhOUEdhUzhuTklWeEpxVmFNbzhVbnN5UkJBdWU4MXRI?=
 =?utf-8?B?SWNWZERDaTd0SEJKdFoweFZPeXNHQVZ4dWdBamNyL0xWYXk2NzAvWmtuQzRY?=
 =?utf-8?B?UzhMUTAyaTlLZ2pURVJZUGdxUG92Z0VNTUZ5OFFTeXhUbkl3TzdIQSs3OEhB?=
 =?utf-8?B?KzJNSzNBUlYrM0J4UmpWeWhuWkxaTGhQdUozSVhzU1lSZTM1TG9iOFdvR3dQ?=
 =?utf-8?B?akhuUEk0dUVMSDZUWjZxd0FvaWV5WUlMSXd3Qk9KTWlMQUQ5LzE1V0pOUC9E?=
 =?utf-8?B?UWNYUitJc25kMGR0bVBkSHRNK0xFT1FJaUZrT3I4M1QwbVE3bEpFemUwK2Mv?=
 =?utf-8?B?M1VEd3NydXE1UTVvWlZQRUQvbTgyayswb0JhS3JxZW9QbmFrUVNPK2o4Lzcx?=
 =?utf-8?B?UkVvcGgwSlRVV0pJV0JwNjZVamVSUkM0dmo3L3dCMTAzakRKclNtTWdNZUp3?=
 =?utf-8?B?OWxHcTh3WDdQdWREN2cyNnovWFR3RnlGbXFlVFNGd2RKTnFVdDZQSS9vSVV0?=
 =?utf-8?B?bE9US1gwZjAxbnZqRHI3c21uV0prUUV3L2JoV2tReTVhSGFTTkNvanFhWm1h?=
 =?utf-8?B?UDBrbzNYcjNzd1pQc3JWU1F5NVd3eUZOZ1htWVV4UzFmcnN6WHJhODlQT1dl?=
 =?utf-8?B?cnVIWTZaUjhUNk5aTDZNbHFBVFplWWptZDhRbndjZGQvSm9rMUw4bVVhT0w3?=
 =?utf-8?B?a2oyTWtDMU1yTEV0QmloTW8rNWhlN1Rxb0FCUFYyUWhETkFUY1duZEJGWmlX?=
 =?utf-8?B?bEhsemZxOXhUUFJJV2txdVZMRVNOR3hleXowM1FNU3NrMmZBMWdONDVSODBY?=
 =?utf-8?B?Q1IrQ0plL05uTnZCN05YL1B1MmU4dFFESlpqYUsxWjBPNmUzV245aENVQjBU?=
 =?utf-8?B?bUY1WUM3SkgrSHExYmJmcGw4azF5ZkRUTmFSQkNIZ0ZBT3NIcjVDaVQzNU1x?=
 =?utf-8?B?YlhIUVRIL3N3RjJHVDg4YzBUOXExcklGNERsRHliZnNMSW9yOFJwU0NyclRN?=
 =?utf-8?B?ci9kWHBCU2hDajNIbUZWTWZMYkoxRG1MY3JodUlKb0FJL2tQbjg2QjB6dmY3?=
 =?utf-8?B?blpjai9YSjlMekUzc2pXblJTSmFrTnUzTVd2RGI3bjNleU8wbkZmUVRSdG01?=
 =?utf-8?B?ZTFVY0xReCtWSkdqMW0xYUFqbVpQdUJIaG11OVhQdUk2NnIrWUpuM1JNU0dn?=
 =?utf-8?B?Q1pyM1ZYVXpSVlBwOTdGUVlPelF3NldZak1JZERUT2xtOHFTeitoWTJkTkxD?=
 =?utf-8?B?RSt3N2pKRWI0d0xyS0FFRzVQZXp5Zmh5OVBoV3ViWnVEYUZScTdUaVBuWEgx?=
 =?utf-8?B?UHdrc2RmZGJuWWpQWnpwSDUraDV3NlBkL3JkZ3JoNDJiZElhU292RkZxeHFa?=
 =?utf-8?B?bkhLWVlkZ0NSU3R2c0JlMnBuY05KazZYSVZqd280L0hvQ1V4VFp0MjdUSVhy?=
 =?utf-8?B?TnJpVEF3NWxsQ05YZ005NjkwcmFBSjNGbmVZRVlHZmZrVzBnOVoxSTFDL2lC?=
 =?utf-8?B?cWZUWFp6Q1JOZFJ2K3g4K0ozdG1QMGVkdXJiNDdmM3pXVVcrNWZBNmN1d2x5?=
 =?utf-8?B?SndxbllpNElqQVljT1MxNmJ3RlczcGlNbUJEQUNwQWp4dk11bXluWWhBakd6?=
 =?utf-8?Q?jP+5q5TrxuwZvmjpIMwKeppXt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5460ff-4c57-401e-bb3b-08dc16813967
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2024 10:52:25.2889
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z9khuRREAJ68N922K3qjYyp8EDknTs2DMll3FABjQYPszEPH7cnKfqq+ik9wEIpakHjzlaJ2sWjGLsyFGwe7yA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4924

Jason,


On 1/12/2024 8:29 PM, Jason Gunthorpe wrote:
> On Fri, Jan 12, 2024 at 06:15:07PM +0530, Vasant Hegde wrote:
> 
>> Right. It makes sense when using V2 page table. But when we are in V1 page table
>> we don't have GCR3. We will revisit once we finalize some of the vIOMMU stuff.
> 
> But in v1 mode the domain_id comes from the iommu_domain struct, there
> is no case where it logically is part of the device.

currently yes, for v1 it comes from protection domain data structure. In future
we may have to do per device domain ID. Anyway for now I can put it in gcr3_info
table and if required I will move it back to dev_data structure later.

> 
>>> Invalidation is no different than any other V2 domain use case. The
>>> domain ops trigger invalidation. In AMD HW you need to record that an
>>> unmanaged domain is connected to a domain ID & PASID and push the
>>> right invalidate. The driver can't just assume the PASID is 0 for V2
>>> unmanaged domains.
>>>
>>> So the implementation is to track the attacked devices, iommus and
>>> PASIDs in a linked list and use that linked list to generate
>>> invalidations. Intel and SMMU (after my patches) both have
>>> implementations of this. I would like to unify them to a helper
>>> because they are both kind of bad.
>>>
>>> There are many use cases for PASID mappings without SVA, including
>>> SIOV-like devices and virtualization modes with non-SVA PRI.
>>
>> What kind of page table will be attached with non zero PASID? like KVM page table?
> 
> Probably at copy of the KVM page table in some for, certainly today
> starting with an UNAMANGED domain as is normal. I think people will
> want to do different things here..
> 
>>>>   - iommu_ops->iotlb_sync_map/flush_iotlb_all will flush PASID zero.
>>>>     Looking into intel driver they seems to be invalidating all PASIDs in this
>>>> path. I didn't get why it has to flush all PASIDs here.
>>>
>>> You iterate ove the list above and flush every PASID in the list. I
>>> don't know what Intel is doing, fush all PASID on domain invalidation
>>> sounds like overkill.
>>
>> IIUC with UNMANAGED domain with PASID, we will have device/pasid list with
>> different PASIDs pointing to different page tables.
>>   ex: PASID 0 with DMA-API mode , PASID1 pointing to some other page table.
> 
> The *device* has a list of PASID's that point to iommu_domains. This
> is stored in an xarray inside the iommu_group.
> 
> The *iommu_domain* has a list of *devices & PASIDs* that can use this
> domain for translation (ie that it was attached to)

IIUC domain will be having device/PASID combination something like below:

UNMANAGED_DOMAIN_A with IO Page table :
  - DevA + PASID zero (say non PASID capable device)
  - devB + PASID <M>
  - devC + PASID <N>

We will *not* have same device with different PASID in same domain like
  - DevB + PASID M
  - DevB + PASID N

Is that correct?


> 
> The RID attach is just PASID 0.
> 
>> This is where the confusion is. Current iommu ops doesn't take pasid as
>> parameter. So if we go over entire dev/pasid list and flush it becomes overkill
>> right?
> 
> If I have a v2 paging iommu domain (unmanaged) and I change the IOPTE
> to effect a certain IOVA range then I have to invalidate it at every
> place that is caching it.

Below flow is fine. We mostly have it and we should be able to refine it.

-Vasant


> 
> For ATC that means I need to issue an invalidation to every
> (iommu, RID, PASID) combination that has it in cache.
> 
> For V2 AMD IOTLB I need to issue an invalidation for every
> (iommu, device->gcr3->domain_id, PASID) that has it in the cache.
> 
> For V1 AMD IOTLB I need to invalidate every
> (iommu, domain->domain_id) combination.
> 
> It is a data structure problem to store a minimal list of those
> things off of the iommu_domain.
> 
> No new op parameters are needed.
> 
> ATC is a list of every attached struct device and PASID, populated by
> ops->attach_dev (PASID=0) or ops->set_dev_pasid.
> 
> V2 IOTLB is that same list with duplicate device->gcr3->domain_id's
> removed
> 
> IOMMU is that same list with duplicate device->amd_iommu's removed,
> which is the list V1 IOTLB needs.
> 
> So, store one linked list for ATC in the iommu_domain.
> 
> Sort it by (device->amd_iommu, device->gcr3->domain_id, device->id)
> 
> Skip consecutive runs of same domain_id or same iommu when generating
> the invalidation sequences.
> 
> Use RCU to lock the list so the invalidation fast path is
> lockless. (this is tricky)
> 
> Jason
