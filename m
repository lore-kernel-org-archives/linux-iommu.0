Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451B43D8C
	for <iommu@lists.linux.dev>; Tue, 15 Aug 2023 05:33:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IlJoPr8ZvtOXkbzlBbAn5vLldVTzUflUxWCxkf+28Uk9Jr9VMEhlel9qcjSYM8XkIAMy2Q0d2jQRm4P7bwHTJxQ0I6H260pVDo1rFllCpmz78MKgeQUGuD/2IH+txvyKO7uU9tMdcYok7vBhA3QwkjAd4XB6erYcbyYEhF75SyN1hO2AgpXB8L/chiRCXLiLWJkhxo2hJI637wRKKbyxt8ClAKgxrFO7Gu6ALjHYUqdd9Qw/n6cMGT/ZM+MMve5aF9nO+0HDvFyY8fM39tebBwISTNQW2APiDFJAtpgWRwCr/ycP/Fs3hRDK4VONyXBsi59AOPGDv2WJI9Ot7t9amQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FiMnFJMQ0U5pebbp5+CcMayRgDaQcRebrG2DZ7tc8X4=;
 b=hQXDkSwkDF1ZD2Pnc6ANr+ORQUOYcxGtr3Yex0eWfBO/Ca9ZI4Cwlq3mpBRp/WEe47ULMchXDkwHDJeyroGKn6bGQKoJN3XXefknYPxHWrokCLPch3WccUXyTubLyi35Y+hsGAzvBm7vll3vJZd2E7U0/LzEZemQt0+zrp/WnczT3mN55aMyThfZB+RPh2icEYsO+qIUPL9DDwLTuMHYyN7Q+tyr7oIUc1JpLvX3LYJcRnzFOsqTbkoOP/+NAJtzwVqK2HV8E3/9KqQkDzZy4gOK1/AQoUlQKERqzYl5ab0KL18eycUf4ySyq9GUAodfOdkcqirzpmjk/ifjhENXig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiMnFJMQ0U5pebbp5+CcMayRgDaQcRebrG2DZ7tc8X4=;
 b=4+W/DU2AWNnD6n+/sN/foYFNW/rgvsvoKw0Pixre6QwzK5tD1SLiQp7qIBgkROZ1G/xpoG6vQyTffbyaP6f6lwtoQF/SaO+7jDRTb5DYEgzkpZyQcum+WIIWLpjKHZTLDvQjBFvIBKh7ERcQ1HjpW2SONiYGxsmjl3QRqTIfZWU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 CH0PR12MB8485.namprd12.prod.outlook.com (2603:10b6:610:193::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 05:33:11 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 05:33:11 +0000
Message-ID: <57810db9-9a85-ca4e-0fc8-24dcaeb77fa3@amd.com>
Date: Mon, 14 Aug 2023 22:33:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH 06/11] iommu/amd: Refactor helper function for attaching /
 detaching device
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>, Vasant Hegde <vasant.hegde@amd.com>
Cc: iommu@lists.linux.dev, joro@8bytes.org, wei.huang2@amd.com,
 jsnitsel@redhat.com
References: <20230808100232.5977-1-vasant.hegde@amd.com>
 <20230808100232.5977-7-vasant.hegde@amd.com> <ZNJhw8RRvJZ+R61y@ziepe.ca>
 <f08fc678-0bff-1e3a-302d-f673c952462d@amd.com> <ZNY1ligeAdFmILoT@ziepe.ca>
 <36a5f7ad-7d67-a818-2b0d-366722592887@amd.com> <ZNbJTiolSya/3/Nu@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNbJTiolSya/3/Nu@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0179.namprd03.prod.outlook.com
 (2603:10b6:a03:338::34) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|CH0PR12MB8485:EE_
X-MS-Office365-Filtering-Correlation-Id: bcac09d0-3ed6-4489-f908-08db9d511cff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0OyPyZ4lit5HGowLAwuZYej4fcGzoCk2YrsK9iC5hsqV2tU4z9aztoFs9lXrpYto7w2dQBE4t47a3uMmlsIwtp+YeGwKLbHxV11bCQ8IIUPXO4mlj2iga/v5etvEFm0aVW2hNO7JRiUgs3lUnxLmL4S+kI3SEWKewut0YsO1/TL4vKmZ63mEBm//42iXt2AYZ2biQ1KDj87LNh+0sb14c/y4f1zKVN3uZlB5PdRoi1vApiCVyLq57UFm0g+nnzoezG+tfCRASI5C8E8LtF+aaMlFQJRTOv+luODxOGu5lFOSOIclbvNOYn+X9F8Aj88+45unHkPdEI0vmXISuOFasvFeoZIEDx+w/5LUHfZt3+8etLx3QHbh+F+X3hvaSOOp4psOfGvOH8pI/e313Z35M/z4c79SYbGcoNIO6VLCmatcgGkUJdPyH0Z4iGjVbl04N6TWIBFbw+3AO05hoZ82ebwAEBJWWUyvedGGjFvx/HEe/bzZgi/H/WgWDfPJJp6E26/IjmoLqPkb/bmp7hmD1Qzhgfb9esAL/xdz7aJb/mbNxAkyBM+kJXsu+3PHcZpsYZCqeP7c7Bwlez8Ax5ZbRH8gbD+7DjuGjhfv0Lo/rBSyqbbuJ2+TFhVEIUUAqldgnZJMQxJQ6/jB8TW829oWFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(186006)(1800799006)(478600001)(110136005)(86362001)(31696002)(41300700001)(6486002)(6666004)(6512007)(966005)(5660300002)(66946007)(66476007)(66556008)(38100700002)(316002)(4326008)(6636002)(2906002)(8676002)(8936002)(26005)(6506007)(53546011)(36756003)(83380400001)(31686004)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkhIQU1WK25YSHd5STN1aHB2UXNMaTRBUlp1YmhUaGJZWVZlSytYNjBNZjdq?=
 =?utf-8?B?RUM0WDErUTVrMm50ZWtBdVkzNDF2Q1hDZnB5d1hWMVd1d1ptQTUvQUtOU0pn?=
 =?utf-8?B?SVdvYzBadmpGeUlHdWhOendQWlBBbGdPZHJydUFaM1c5ZzlkcTZJZVVQWmhZ?=
 =?utf-8?B?ZkhnTVZoVFkzaXdleXhkU29kQjFRNHVrdlkvMTRsTFo2V2JHK2Rva1J1bmVl?=
 =?utf-8?B?NmliM2Y2VStyb3lLNnF2OVZyVUs4OXVSeTkydk54U2xGME5TaHZnUUJFTU80?=
 =?utf-8?B?UklIbmdQeW4wZDYxMkFwL0hZTExTWlVFeHNoTndST0NFUW5McXR3Nmc2eVhx?=
 =?utf-8?B?UXByWFF3MmlRRWFaRXNFdDlEV0p2SEZ2bXB1akNlaFZmRklSYnJyUEdSWmZy?=
 =?utf-8?B?OFRlYkorYnNqc3NVeWd5c1hSRC9xVlZRWlRpckZVa0NVcFExdlFNUkRPbkxL?=
 =?utf-8?B?K2dzWG8rN0xXdmpoVXhEYm1JVmJGSko2MHZHbGlhYVlhUGVjZE1oSmliUS9S?=
 =?utf-8?B?aDJvMUcxQ241T1hVa1RicmR3SUwyWmV0cFFNUXNPSlVGeTZBZjFEdXhLWFdO?=
 =?utf-8?B?bTJZb2dJSnFZK1VOeDhyaElUTkZGUEpYZlFUSTdSc1F2RHNaOWZNWGtvOHZx?=
 =?utf-8?B?aUw0WDd5clRpV1lEd2FrRFJxL1FCUkRhVEdRSkZHTmhsaXVNZUg3MGV3R0lx?=
 =?utf-8?B?UHBNSGJyY0t2TDIzejdCU1JUM2NyUVA0OWpDcEJUV3pEZDhneFBybzhsaEgx?=
 =?utf-8?B?cy9FTjBWWDAxTGVIR0M0dGIyMjVnajdNM000dkUyK2o2MnJDUTFET2VyaDU0?=
 =?utf-8?B?NGlteTJTdW8xeVdKb3JuNWVVMk8zRU4xRkNvSHJHM0Q2T216VnY2YUp4VEZm?=
 =?utf-8?B?Wm5LVkdiNmFId2YvaWl4K2dYTUtIMnI3N0xWWjlKK1BNQ3RBYkwrWHVleGM2?=
 =?utf-8?B?cFVzSHMzb3JPY2oyYnpNZGdzakV5bklqVCtzWDN2ZXNITktmQTgwT052SkEz?=
 =?utf-8?B?eXozSFN2VVQrUmNzMUcyUkNQbkJYT0lHZS9Xa3ltKzlBL3p4V25kRU5XWTlX?=
 =?utf-8?B?RTN5bnBoZ29VTlh2MHJhTDZpKzVFWHAzR002aUhWTUM2dWJsdG01bzhlV0V5?=
 =?utf-8?B?U2dvNVRJaGxMTnR0TGhpUDVZc0RDUFE3TVF2dUJ4U1k5SlNEVE1EU1VyQkVi?=
 =?utf-8?B?SzU1a1gySVFpTTQ5cks4WGlWQ3BjZHI4NkhzVFpSRy9NMzdXb0hoMGhUbHJr?=
 =?utf-8?B?YUs2TUF4ZlIxT3Q1Y2VzYU4vOFdlQUpTNXRlcjVhczJHMGFlWFV2V0lLOVlt?=
 =?utf-8?B?ZDN4eHhDMG0xaStnc0hRRjdkVkptUHRGTkRrL1NwUWludHVYeUs1YzI4YUw0?=
 =?utf-8?B?a0dTWlJSOUhndlVINTNYYlFPY2hQdnFwNWEyeDNXYnZtaGYvcTE3RTNFVkQ3?=
 =?utf-8?B?WUE0c25RWUFzcllHaWczalZNZmlzdzUxRVlaYVRFZHg5endlemZOVStmejY5?=
 =?utf-8?B?ek00TjdDTzBqK09XblJCSHNFWW5GOTlSbFVEaTN4Qy9zMmREZHFNYk45a1Ix?=
 =?utf-8?B?UzV0eTNxT1JNSmloZG5lYXpTays4c0VYaHF3Z2dhWlVibVR5ZVZvU0NTNnd6?=
 =?utf-8?B?a3V1M1ZVdE5kaXloZWdMdkxTUVJpN3ZvV0ZRT2V1YnZaanp2WkVQT3MzOVFi?=
 =?utf-8?B?SEpiS0Q4bFNJbXlFeU4wWGViWElEdWFjUHhGc2tsUVZXQktwck51dEJENkN1?=
 =?utf-8?B?WkhVUFBCTW9OQzZkWUw3TXNMQmpOcGVkYXNHUFA1VU0rckNRdkwwWjNBK1ZX?=
 =?utf-8?B?eXhDRHdaRW9VSUpKazRJSDluWEJySDcyRzVXUU1oRjZHZVpSQzU3OFZXQnZT?=
 =?utf-8?B?MEZ1ZmtDYU02bFg2MXNpVjZ6dUFHVHNkb1M1UVluajRpd1E2bnVkY2h6cm92?=
 =?utf-8?B?TjR2dlU4NFlhN3Z3VGdQN1lNbTYrYUtRVE5CdFZJQSthb1BoSmpibU9UdDRG?=
 =?utf-8?B?VldvNWJRKzJqVFZHNElOVmdJVmZLTGNTNEUrVFkxQ3pzRDhyOEVzOXVKVkdy?=
 =?utf-8?B?ZkdZT3hqOEF6eEUyaUk4RXUzbmpxWk92a04wVDJRamV4aW44UFU0dHNpMjNC?=
 =?utf-8?Q?AWC/UTid58xjWotYHO2tA8Mo2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcac09d0-3ed6-4489-f908-08db9d511cff
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 05:33:10.9285
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RkQnoSsqqEvp8vogDwMdadO36x04MvHlQz/0JOjsPB/MbG7eRGTY5zP4tv3DRU93QxCzkA8ks5WvqvUrZ8Sglw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8485

Jason,

On 8/11/2023 4:50 PM, Jason Gunthorpe wrote:
> On Fri, Aug 11, 2023 at 10:20:56PM +0530, Vasant Hegde wrote:
> 
>> Our hardware is capable to boot with either V1 or V2 page table. By default
>> driver decides what is the best mode.
>> But if user wants he has a flexibility to choose V1 vs V2 page table. In that
>> mode we will adhere to user provided option and all devices will be put in that
>> mode.
> 
> There is no valid reason for the user to override the kernel. If we do
> this for AMD we have to do it for every single driver that supports
> two formats. It makes no sense
> 
> Jason

The amd_iommu=pgtbl_v2 was first introduced to enable nested IOMMU 
translation w/ HW-vIOMMU support. This option is necessary for the guest 
kernel since we need guest kernel to use IOMMU v2 page table for DMA-API 
but the IOMMU driver is currently default to use pgtbl_v1 for DMA-API. 
Currently, there is no good way to auto detect this use case.

In bare-metal environment, both pgtbl_v1 and pgtbl_v2 are supported. In 
the future, we might consider migrate to use pgtbl_v2 by default. 
However, there are certain concerns and restrictions w/ the use of pgtbl_v2:

* pgtbl_v2 is not supported with SNP-enabled system. SNP-enablement can 
be detected with amd_iommu_snp_en, which is initialized early when the 
amd_iommu_snp_enable() is called. So, IOMMU driver should be able to 
automatically switch to use pgtbl_v1.

* There is an upcoming feature (e.g. TMPM : 
https://www.amd.com/system/files/TechDocs/58151_0.51-PUB.pdf), which 
requires devices to be setup w/ pgtbl_v1. However, the TMPM driver is 
loaded after devices are probed. Therefore, this would require Linux to 
boot with option amd_iommu=pgtbl_v1.

* IOMMU pgtbl_v1 and pgtbl_v2 are different from HW perspective, which 
could yield different performance depending on the workload and 
end-point devices. Therefore, the kernel option 
amd_iommu=pgtbl_v1|pgtbl_v2 adds flexibility and give users additional 
control if needed.

For SVA, we need to ensure that the iommu group is using pgtbl_v2 or in 
pass-through mode (no page table setup) prior to enabling SVA for the 
device. Currently, this would require the pgtbl_v2 option. However, we 
could consider default to using v2 table for an IOMMU group if it 
contains an PASID-capable device.

Thanks,
Suravee

