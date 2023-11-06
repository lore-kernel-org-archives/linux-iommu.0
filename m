Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4286E2CA9
	for <iommu@lists.linux.dev>; Mon,  6 Nov 2023 11:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DrVforX0"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhX7QJmmU/SyNQ5jd7scSj/GAzr3Ei2k0sH+TL00ZrIGtYYmi6pdfoB4nOfXyVo51DPsvoZViox8qktwQ20refEMrYRnT/JbJrErBSFSxqFjtl/Z8wc05tSOrcP545KVtSucEcMFkpAYpFmxJqXEkNxH2OaLS8XBBuc6hbJId7fPIL+TidUedjNBWHiRB+OLu5YKsov/TMbYaNMFYpnqhj9hknQOiaOmzH8aWknHohwiE1k2rOcZA9ex/EBMFnyINkSp1irc+xe/H0QGrVdC54Lzk0mATdmaNHDgs2M+xzPposEZciCoS5+yfHvBNxtxBnK5E8h00l7s1YAt+bwvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9wECKN9Bf0k6eN6n3fTnvNxJaKDrZOa9M+pzq7rg5c=;
 b=h7uQc6KsMiNpqmN51pCGfqnILJfVrBnMe+kvjH3ywY2w2wZ22JiMb+q98uFMyFxqENgiHyUAGoxxuZ3AbhPHJH2nKGHtmhzxh26+tOHsAXw8a3iLcOT9Mn+0bCRTGaW++QLr2Jb81ZI5y5pNLWzBanVWGo050Ds/KBxYW3BGEZWS9mJA9L7cpB3+QdVaa3UBYF5qaRCrxrui3aBpmYvEdaNPpjIrdSUuRjJvsrkKs/ffJDCid3H2VKB/kOIw7gXWYwk3JsST+k8z5zirw79iw8waRrXG6lBARm52oGKOqkdQFqu24opQzSCkLaXThgaDUxDTISFDt3R1ryriDlfzhg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9wECKN9Bf0k6eN6n3fTnvNxJaKDrZOa9M+pzq7rg5c=;
 b=DrVforX0mEpl6FjOlOL91rquVqlDAZBqBL4djW5kYaoR3qNYIe87C9P2rF/5s0Um3I3WserUIrKokasjr8/TIGrUxuN3Ie6yx/eqCUcprsl4NakuBOUiN5fXcLXO9pLe/7jwf8ueN325kMmrnBo+1JXxbr970UH8l7Jx77a3r0I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 PH7PR12MB7356.namprd12.prod.outlook.com (2603:10b6:510:20f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.27; Mon, 6 Nov
 2023 11:19:25 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::befc:daea:28e6:32af%3]) with mapi id 15.20.6954.027; Mon, 6 Nov 2023
 11:19:25 +0000
Message-ID: <04d60b2d-0eef-90ed-7a36-0b0ffd8a9b7b@amd.com>
Date: Mon, 6 Nov 2023 16:49:17 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v1 12/13] iommu/amd: Remove unused flush pasid functions
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com
References: <20231006101624.5912-1-vasant.hegde@amd.com>
 <20231006101624.5912-13-vasant.hegde@amd.com>
 <20231105175809.GL223197@nvidia.com>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20231105175809.GL223197@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0127.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|PH7PR12MB7356:EE_
X-MS-Office365-Filtering-Correlation-Id: 558749e5-d8c6-4137-0bba-08dbdeba3b98
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Q03xIhlaA7kgDbwlO098FOlquvbS//Ff0R1EsIt6L6NlnQtziovE10PvkrmMDvS8LtHaq0GZy2Q3mWNjFqB0ME/8X2RDrKJUN7RHkJKcPtkk61fZWHGALB2BSyect+3h04ajLE0Ptjg/EAz4htNS1o75DHITqXW+k551Sfs/G48U806rl47Ygtcxr2Ny9Q9ux/wGnUdCbOfspvjY0WLnfMdy8U6YUEQHnADr7gfUN6TjP5z8Skihrhwm4RImKjNQPRVyLoGqXX27jKMmyXjEdIeCmiFuhx6rAD0L9vQdewl5YeoAQ1gIebCdc3p5T/UiLcDXcn1tzcMrkDbjb9g+pQmkPqht+5xBgS74lURrhZE1rd5ZBsum1MYtLf10Ib+IYbmq9dzJyeotEE3ohVZS8xRugSCP8DJMsjExrxXMLPcFYB7JULVZh6562agFxUMARnfm/76uBuTksNRO6fknw0VAhcq3UaMoQuZMYo7MuV1KCIdlxuIkr6AOc6MbdgoegHvZZSd+Cx+MtYScY4IfxolbaWK7ScRUS1GcA2/0TiWmypXuWYd8XjOjiphcTX3Nl3Aan9i+sKED30eFzK77mgQIY2OwFBLX1nRenHfDEFhPyufJxErfCt/t2dOiQv1KKejCQL8zM5wkx1IiqM/3slwQ6IORltYxvsce9qWenzf1rSsKhARv2xz1/M/vDTnWl2UzU0jQezhWn0s6FOX1Ng==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(346002)(396003)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(2616005)(5660300002)(31686004)(26005)(316002)(6486002)(6916009)(66556008)(66476007)(6506007)(478600001)(6512007)(6666004)(66946007)(53546011)(8936002)(83380400001)(8676002)(4326008)(41300700001)(36756003)(2906002)(31696002)(86362001)(38100700002)(44832011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3NDaDRueUc4S1VlMTUxUmY3ZVNoYlA2Q0hmeWVzTVIwekZ5L1BBL3BUWlFu?=
 =?utf-8?B?dGE0WHBsY2piZ3pyM3pKOHk3U1ltVytRSzd2S215M1dSd21BMjllNWM1Mzlk?=
 =?utf-8?B?aXRNVVNheDk3NHNzbGt0TllCbDZFcitxYTVWMU00c3M0SHRGVmdQNkt2UmMw?=
 =?utf-8?B?MWdqVFRXMUlPWmJQY2IvSW9DMnBBczcxSEFHK3NleGNSdHNTeFRmVGV2SVMy?=
 =?utf-8?B?am5HcnVIWDg3MysxdjRIenVVNFdMZG53RmU0R0xHSFJOMlJQTSs4amxiOWZ2?=
 =?utf-8?B?WjFqeUV3RmExUEdidGM0Vm5oZjBCWnFvTEpIQzArOW1yUm9vZGNqcUFZZGsx?=
 =?utf-8?B?cEhnMWNQQ0MxcVJpclNQOU5TeW83VVN5SkpseG9xditaRCt4Yi9peDZucElp?=
 =?utf-8?B?MVZFZjlGZzZmNm1LTHdxMXpXcU53UTUyZVlBWEF4WEVJbUk2UlNMUHozZW5I?=
 =?utf-8?B?ZnBSa3FLL09hNFpxeGFmZ1VPSTcwUXZRc0FDTXhjZHM5bUMyMEViMGxOVThw?=
 =?utf-8?B?MWx6SVN1OC9LR1VBdkptSWVVMTdSd1dSbzNNeHhqcmUvcGJDdDJNcVFmaGI0?=
 =?utf-8?B?elFDZ1JDQTFkN0Rob2pxSndyb0VtaWNuZUF2Wlh6eHVDN3F2RXhiSjR4RGlL?=
 =?utf-8?B?Zkt0c293dWMvWmpVVDc4QXVmUGJISDFRUHRuMjYxYVUwai9oNVRkSy9WbG11?=
 =?utf-8?B?bWw2R00wcTdSOUhZMWVJQmVpTkNBdUVWNUc3NFc3V2t4bkpxT05ScXZxaGlI?=
 =?utf-8?B?bk1Ma2hoaEh6cFQ3YkQwRnBjMzZrWlRRQmovQ1NCdlBDM3BUZ2E5UjJwYXlq?=
 =?utf-8?B?czlDeldpbUE5cTkrbWNhdXRTY2xEdWF3cUFNaXB0a2dLSTVwMTdKeWNickxp?=
 =?utf-8?B?aXRBYkdjQjZBeHRxdldVYkdoRVFsUndxeUU3S2ZxYjVJMmhSdWpXbHlCTnpT?=
 =?utf-8?B?MlczSFZqZ1d0QkczMXFRWXFqc0VUWGZqYWI0YVJva3dZbFdPY0xkS2RjWS9T?=
 =?utf-8?B?K2Z1K1U3dzRCRVdLdU82bmxkRWllbm0ybmhGMWZhd0VmWmhuNnFqLzJWOTRY?=
 =?utf-8?B?ZVgzVnRYUHkxWTM1TnFJbkNSN2VVMEZVWjFzSkRwbzZoeEpwVTFKYzUxaGt3?=
 =?utf-8?B?VmpSMXRUV3RJTW0rQXArcFE4bk5IeHNiQjkxSzdKVDZyK2h0YWdpQnR0S1ZR?=
 =?utf-8?B?VXVtaXVSVCtwSFFObnhnSmlTaUdzQ0FSSlNxNkpPcStnSzdmQUkzejh3OURx?=
 =?utf-8?B?VkFkWFRtRUdwM05iK2hhRlM5Z1cxY2VMYVJlb05oRDA5dnI3SG1sN3ZSRmJC?=
 =?utf-8?B?aTJDK0JFMzFQQlpPV1RiNC9DR0NsQm1IY3VzN1NiU1g3Z3pDK1hGRXlEMHlx?=
 =?utf-8?B?MWJ0dXFrSWtxckErWGo5NmxuditCSzUvd1libWNFSVV3Q3dXSm5uUjltTXBx?=
 =?utf-8?B?RVg5RUlWQWxrbDVRcHdYb09HQTA0b0k0NTdWS2RCalM5SllpcTBteEE0N285?=
 =?utf-8?B?WkFLcGwvZERDLys3QlJxTGxsTmRVRWxsK0pKdWlvdUlEOXQ0RFdjengrYWh4?=
 =?utf-8?B?dGNKejJCaUJ5TzljTXg1dlZqUlRwS1N1M1MxQjlGUmVwTmhtMm5uSDZobDc3?=
 =?utf-8?B?STU5NHlKcGFiZ0hld0ZwblZuOEkzU2d6eUp5Q2pkUlNoQ2xaMUZCRC8zbmRm?=
 =?utf-8?B?SmU3aUpJRXREVkpXZXFUL3d0VldtQjJnbEVNZFBkSjY3ZW9nTmNXSFVHNTBR?=
 =?utf-8?B?eklOMGpQaVdvS2paNlcxOUQrUjRjellJMXdBZ05STWRrUEVPTUJ6MW52L2tw?=
 =?utf-8?B?cWdBQjVxQlp6Mno4aE90M3dLdUVtNTMrODU3Y0tBVG5kU0N3YS9Fa3JzMmN4?=
 =?utf-8?B?OU5mQ0E2QnZNTDBDMk5BQVhmaDhvcENFcWhGbUJnVDZmRm1Lc3cwbDlFNHJY?=
 =?utf-8?B?VFExQm9sNU1rdVBZajdUOXAzVnNCbEtIYURYUEtLSWk4OXgxbG1NVTRIamo4?=
 =?utf-8?B?Rmd3bngzTjAvd1VxaXZoaFJ4SEluY0VGQ3NsMjV2QmV2UmFGc1R6SmN3VE9Z?=
 =?utf-8?B?dUdHT3ZrUnpVcXh3QWpVTHV0N0xhWTBUc3FCbi9ST2owQlY2eHZCUGVUbTRa?=
 =?utf-8?Q?xm30RxdEfe6h/qjs1bRnMiWjb?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 558749e5-d8c6-4137-0bba-08dbdeba3b98
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2023 11:19:25.1569
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: asdsOU7DV7jkM3CAsbHJTlsuHjVeIC62pJ7xQ19w1W4dBwPSeddxFh5BmrHQlLzMfXPDxS8xQN8rkJUHByJCjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7356



On 11/5/2023 11:28 PM, Jason Gunthorpe wrote:
> On Fri, Oct 06, 2023 at 10:16:23AM +0000, Vasant Hegde wrote:
>> We have removed iommu_v2 module and converted v2 page table to use
>> common flush functions. PASID related functions are not used.
>>
>> Also when we add SVA support we will be moving to per device GCR3 table.
>> We cannot use current flush pasid functions as is. Hence remove these
>> unused functions.
>>
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
>> ---
>>  drivers/iommu/amd/amd_iommu.h |   3 +-
>>  drivers/iommu/amd/iommu.c     | 100 ----------------------------------
>>  2 files changed, 1 insertion(+), 102 deletions(-)
>>
>> diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
>> index 088890f9618a..38b3f4562f3b 100644
>> --- a/drivers/iommu/amd/amd_iommu.h
>> +++ b/drivers/iommu/amd/amd_iommu.h
>> @@ -53,7 +53,6 @@ int amd_iommu_pdev_enable_cap_pri(struct pci_dev *pdev);
>>  void amd_iommu_pdev_disable_cap_pri(struct pci_dev *pdev);
> 
> Maybe this addresses my earlier remark about _pages?

Yes.

-Vasant

> 
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> 
> Jason
