Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8749C1DFDD
	for <iommu@lists.linux.dev>; Thu,  9 Nov 2023 13:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nOmlCyxU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V+HcE4Im/BLnE8IgVBF7IP3QDoc6+BiepxpcEwdHuUBPMswUHv3xtqeL6Q/H/siEmWbEQatoLyzVu49pFkw7H0a7xnGSVtfZx0Q/m1dMVpWDZtr7vGvohYQYl44uWuyqd2WVqevWcg4CYQyqD4EUoFkNQb12Zsxgxj/0EsUcDtxYQCrT9rMzr8hXXSyky5fMR1CmI13p8PKNjsw+tj/s7HTSGxIAlgDcYuaYZ1ywiOOdytc+OZm3N40dyCuvSDffVX7ft4TaSqg18emC38peJHVFcqxb3a4hjZ2BdzINayUsE45G2Wz7AzxfDfJZppouGedS0x23xjSAYhI4Ku/7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpDN/kwbxQXpKL8mR43p3ZcVx9G2QiHCNSnnbqk/IyU=;
 b=ArdlcwvO3lgFfJH6PfpOA7WhhYGTK1Oebs9CpN8DIpS4bqJHBK2K4/Te3byBooA/DnKmyY7sraznYg7sJ55CgXokt5OkAXhj6WoNTMiFAKKQ6rVFvYNtYBquUOUT5Z3jZdfnenfKdhZQNbgEVbFAQu7DC4l7bjX9QNcLHLoqay8bIU378SJQKDMgguu2uTkhi4Q5IMg0Vp8WKW8w3YP/Dy1NKqkVTAf2Pv8ff4CZOEVPcXS20+uPfeQawYVVA93uibPdaSQRtpow0nLkLnHscgt0XsEcj3PbQB70Q0kgcP6IaMUv+o6yDsJwNR5jamLwyCkxDShND5FlCyB4xcU94w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FpDN/kwbxQXpKL8mR43p3ZcVx9G2QiHCNSnnbqk/IyU=;
 b=nOmlCyxUko+0a3ppmh/qf7b0X4bkmXvwQH/VV4o5OBk4zDyf7rWyCUS1nJYXS1EQR0RlheVPno17Ua+1227vA7m7v5iWUKnpDRIq3NBwz3zGopDpwoj0q2qTUT8ZVT17RA63f6pazcayDSbivPbkDFb4l4g9NxYGR1YhVmzuzCY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 13:52:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 13:52:18 +0000
Message-ID: <875d1c5e-05ae-7248-3823-38a5e1e2fecb@amd.com>
Date: Thu, 9 Nov 2023 19:22:09 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 10/13] iommu/amd: Consolidate domain flush logic
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-11-vasant.hegde@amd.com>
 <20231105175559.GJ223197@nvidia.com>
 <5e95d78b-4c42-6596-c1b0-057e044197fc@amd.com>
 <20231106131303.GG4488@nvidia.com>
 <4267e033-6cf8-565b-9a89-492746c6c257@amd.com>
 <20231107130917.GL4488@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231107130917.GL4488@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1P287CA0021.INDP287.PROD.OUTLOOK.COM
 (2603:1096:b00:40::24) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: eff63882-5da1-4bcd-bbfc-08dbe12b16aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	QPCzlzoRldbXcz/gqDZz0uuxmY/9w/0lJNLzmYbT1XqgSq2VPSy49bPCNIoXWCbKgdvq9mgI2Cbq22MHGAAiCzQSBjhWAvFIaRfBcR1dulr9xya9KAngl5rS8DeIAEXHol28tqlRXMNESRxyfvV6IXiiqIbe9tc+nqj121gJSQf74CLwwoS0A5C2K4ZoVfzEQxK2QSZulxbHw3D3m9j5IudHvx/0039OZlZ+HWF2ti4zyQWOhi5anG9yXnZtaVX3OAzxzu+mwf494AXwAfJZGo3LdLGgAtZn4bCMfOTETxQ5vyxQVphJL7hUNuwKFPj5tNsK3I37PiAe/JsefDl+Irzn4ALBUhTEoCsyQTMv1kjDjxSwihzpDufni4TrcrpQVCeO6R94G1hnqTareeOS00WncXW50qBfsp6QZkek6AZ+/XAlKxvgtlQT6/y7MUTpfp++4GCxEFCKW5sSN6bZ+PUNUHj/hi5ZF/p7GPm1nxT2sBKMDteObfrAp9hV/8DPOSeybLN3w2LarBz7Hneh+P1uLoofRUBgAZlOpJLekg93UDPKft2y+MKZMY8Zhw9apZ8FR2W6odezvWtTeSK+0VDsvwD5RTf4/QkUsBEDFmxYwttbc9DQuN2dSfDmIxF2/dgFtSIXoO/OvXOFZG8SAQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(346002)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(2906002)(26005)(41300700001)(83380400001)(5660300002)(31686004)(2616005)(966005)(6512007)(6506007)(6486002)(44832011)(53546011)(36756003)(6666004)(66946007)(8936002)(478600001)(31696002)(86362001)(8676002)(4326008)(316002)(66476007)(38100700002)(6916009)(66556008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEJBUXRVVVVzcC9SZEhVQjdKSS9MVzQ4eUJCRjBncGRPYUh2eGQwWXNTWVY3?=
 =?utf-8?B?M3BDZm4yYmVQVG8wcCtrM3NGRW1LRnA1b3hSVEpDbVFadk9tTmhYWkU3Vk0z?=
 =?utf-8?B?dElyMk4wcFh2SXhWN0pCNERSWFFPU0NZWUpMTUdHbUNlWmttaEtaV2RFMmV4?=
 =?utf-8?B?bDNZdk9PTjNwYlZ6WG85ckpjUE50cG4xTTNjc1VoTkxVMDNaZUFDYmwrS0xP?=
 =?utf-8?B?SXFkT0NWTlpDOHVHam00cENWV3BTcWJra2dVSDNGUFlHNGhLYzJqaEFOdEtH?=
 =?utf-8?B?SmR5ay9wTkR0aHlpRjk0SHVMTXJCK1Vvc0xndHVGNHlXbzNJeDR1TTVJMzNx?=
 =?utf-8?B?Y1ozWmFPZDZNZmJjRXdRcTZjZ01mUVBtazBiTmdXQ2pQVmhoSm05dDJUcm1l?=
 =?utf-8?B?MkpzekFZNlBpWlU2UUJTVm9VRHZuVW9RakJwMHRGK1RUa2lMUzFucHJUL0c1?=
 =?utf-8?B?Mkdsalg2YVZBa1ZDVmgrQjdXS2p3NjU2VFRjOUdXdUpjN2UvdDNsc0I5MWdE?=
 =?utf-8?B?UXdSZjVMOHg5RnFjVnd2NWlLbU5VU0lYY3Z0ZGlCOXVUaWR3UW9LN3h0OFNm?=
 =?utf-8?B?T3dBeHphK0UrY2dGVnFOaTI0Q1QyYThlL1Y4eXpOQklxdnBRdzhtMTBZT244?=
 =?utf-8?B?U0l0RVNYV3FBN05MZFRpMVZwRGNvemRNVXFZSU1wSFByckZEODVzby9DZ1pJ?=
 =?utf-8?B?YWxNZHVqaEVQYVNHVnVDdFZDeHpkRE9jYi9mK0pqaWxNSDROMW1sQXZLc000?=
 =?utf-8?B?dUJ3WmFKVkpDblJkdEhrSjFFejlweXlnR096NmYzNmowNm9OblQ2dkplZjZM?=
 =?utf-8?B?Q1BUMnZxb2t2ZVZidnUzTERVYXV6NWJLOXVkYjU1WnAwaVRObW9LZDBlejRW?=
 =?utf-8?B?N21sQm9BTjVzbjA0enJ2MC9oRlZROFNVOVpvK2I3S0ErK3dXUzV5SEs0a3dl?=
 =?utf-8?B?LzEzK25Pb0hqY04zOGE4bnNQblkyZkRuNHdwMjBvWmpqTjN1SDlTUUQ5ZTIz?=
 =?utf-8?B?MTF4NkRzZXFUSW1RajNJNmNrS3E2aE5mZUxTTWFhemRYbS9YRllOUHEzMWVC?=
 =?utf-8?B?aHFQRjBwaU9YMmpySG5tOG42ZEVCcjVZVTQxdTdUdnJoYW9mT1RyWDd6VUJK?=
 =?utf-8?B?Q1RFQjlFVmV3dEpYZzRkZVNDMkRNK1RIK0Y1ZGNyb1piK3VJSEM0M244Rm1C?=
 =?utf-8?B?djZGMVVpN2JiQUdic055Yk5aYmhPZG9qdHZMV2x6ZE9MU0RQVTZtWG9NNEJU?=
 =?utf-8?B?VGRrNDBkSE15WENtTk1lUTlDRzAyT0cxeDNsY3EzOG92Z3VRTllkb3BIc0pV?=
 =?utf-8?B?NEsrMGROZkVmRTQ3SWhveWlkZStBWGNLTlRHczM4S2V3UnZjeHZCYURvRXVL?=
 =?utf-8?B?M3daMDJsT3BCK3hta3I2RTN0amNFbHAwUzJVSysyTGtFMmx6dWJBVThRamxa?=
 =?utf-8?B?Q09IeW90c0RSRG9pSlVjWTRVYVorc1dqRVFxOThNZWVzclI2NXFXTHhleDIy?=
 =?utf-8?B?aWRXbFowVlF2Nkc5UVlGL2E3RFpvZWVpR1lOSEtBSDc3bWkrVmRNSkZab2kv?=
 =?utf-8?B?ck1SNFhkVWViMkJ0NDN0S1dUZVdpeXpQQjVQdDZKMzVDMzBXaHlxZ3BGWmFW?=
 =?utf-8?B?RG85QXMxMFYvbkRHYWxOd1VVUk03NjR3S2NiaWYySk43c1pXQXVIbWlxRnBS?=
 =?utf-8?B?QzdQRWxwS0RXdW9NbnRoaDEweUV4NGRlSUdqd3pjZ25meHo2SGNNTUJXaFlW?=
 =?utf-8?B?N2dMVlpOODNGOFhuZmVmcHdSS1B5SVZzd0ZQSGM5dEtEcEhYZ1RCSXpnZ0lv?=
 =?utf-8?B?aEJQUDJMU0gxMUZnTGVOaXZXdjZKZUQ1VGd1ZkVta3dzWTNoT0VJNnlOL09w?=
 =?utf-8?B?NG8vWHVHenRyOWZBK24xMnUyNjI4SW5OdjEvbUtlWlI3eXZKckQzVzF6Qzlh?=
 =?utf-8?B?Vm5ZQ3YwNVZ1RFNrM2huK1RaWVZsdWMvYm1xUi9oQlhmL09HL3N3S2MwTGx2?=
 =?utf-8?B?MnVmWXE4VTZlR29wNlIrYlBURkNSU1krMUM1SUV3VUlnMFRvazdNWU4wMXly?=
 =?utf-8?B?d1JqMkY4TVUyZHgxVk9BMXRsclZBN2R4dVJtQzFLdUlCU3Y4TGFWT2FpRzFk?=
 =?utf-8?Q?cfRHazi42cg6NMQa4GlmNBFkB?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eff63882-5da1-4bcd-bbfc-08dbe12b16aa
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2023 13:52:18.6376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C56QyHmz2mMGdSgItwx/XIX1YIhAN+t5jy0G97GfWXY1RsyOozJo3Fw9UthPakvJ65DIzf94rzagiWwX2v6rVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144



On 11/7/2023 6:39 PM, Jason Gunthorpe wrote:
> On Tue, Nov 07, 2023 at 10:14:17AM +0530, Vasant Hegde wrote:
> 
>>> I can say that in SMMUv3 structuring it so that the attach op at the
>>> top of the call chain knows what to do, and called a bunch of specific
>>> helpers was reasonable. We know at the op level if we are going to do
>>> a V1 or V2 invalidation because the OP itself already knows if it is
>>> working on a V1/V2 iommu domain due to how it has to load the domain
>>> into the DTE/GCR3.
>>
>> AMD IOMMU invalidation is based on domain and we have single command which takes
>> PASID as well. Current code does have separate functions but that made code
>> duplicate. So I try to consolidate all low level functions.
> 
> It is really not different from SMMU, invalidation commands for S1 or
> S2 tables are constructed differently.

I don't understand ARM completely. So I don't think I understood the entire code.

Looking into https://github.com/jgunthorpe/linux/commits/smmuv3_newapi tree,

As I understand you have S1/S2. I guess that's something similar to V1 and V2
page table. arm_smmu_tlb_inv_range_domain() function basically checks for S1 or S2.

I will replace pdom_get_default_pasid(pdom) with pdom_is_v2_pgtbl_mode(). So
code will be something like

domain_flush_pages_v1()
{
	for (i = 0; i < amd_iommu_get_num_iommus(); ++i)
		iommu_queue_command()
}

domain_flush_pages_v2()
{
	list_for_each_entry(dev_data, &domain->dev_list, list)
		iommu_queue_command()
}

/* Invalidation based on domain */
amd_iommu_domain_flush_pages(pdom, addr, size)
{
	pasid = INVALID;
	gn = false;

	if (pdom_is_v2_pgtbl_mode(pdom)) {
		pasid = 0; gn = true
		domain_flush_pages_v2()
	} else
		domain_flush_pages_v1()

	list_for_each_entry(dev_data, &domain->dev_list, list)
		__device_flush_iotlb(dev_data, addr, size, pasid, gn)
		
}

/* Invalidation based on device */

amd_iommu_dev_flush_pasid_pages()
{
	iommu_flush_tlb_range(iommu, domid, pasid, addr, size)

	device_flush_iotlb_pasid(dev_data, pasid, addr, size)
}


> 
> I would say the driver should have a way to issue the commands and a
> way to construct the commands. Pass the actual command in instead of
> passing in a mess of arguments to try to guess what command the caller
> wanted.

We have helper functions (build_inv_*) functions which builds the actual command.

-Vasant

