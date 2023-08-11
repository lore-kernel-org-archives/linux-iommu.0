Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B667EAF9
	for <iommu@lists.linux.dev>; Fri, 11 Aug 2023 17:02:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UBhe2pfxN9zqXkPfgad56v/upDg+RV0raLF0jAglEL1dOpKrmS2WfSsPKG4X1n9gWn2/6YxUoGlRt1DXUpVtkTQeeMT0o4x/NVvNIKflMUnklYFEo7jWc3T7QafviiChEVGdO/MJS0T0tAA2h0q04I+AngmuOQcNR+S7ocXjH1sGkGnKnclCf07JRElHd9vfb/9y4dpCW0YzuFVjAlKANioKLDveyBliK8c64YeAARUgF/ccQs822avyOlLtakQMrdEIocdIXaFYm2ZiQvpAkPsYSFDBNn1VIOFHd+VYcAdm77/E78MhQBe5z3/EKYDKKycYelMjbg12ZgdBJSPCiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JCIlkaEUjN2Zw/rqXnTWdTiLBNnc35P4+JPigPMZiE4=;
 b=H5uHuqC+qpLlHHs9/9w4OSffgZktmiqQ5VAwEVEnJ2iaSgJBg98bqoFUBZY1jHWkfsvY9PPyyCYy4X7KybGv7knUCAEQa9y27mjwyA8zJpoyKJpT6320dXgGHL1mlB/lvn2rl9av6+rVddWHp+q6ZuNpXaFUC06LbmeFBdUb3hQ29jl12wHZK4E5KBMYd7R75SnVBQOTr/asmyFNH8smnLSANhlwbW0aDhYC+RdvOLI6jzyHVCUSY/Kt/FO1L5pFoWIYgXiqQ1D2T1O4MxXOOsX2BDZbGmGrfdUL37mjeuU3tJJUFKnnEBdzqZR7XHGVEA2cPMO6JEgGGByFNCG7HA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JCIlkaEUjN2Zw/rqXnTWdTiLBNnc35P4+JPigPMZiE4=;
 b=sMWj3J0YpcYnT3MyAn4xp8WFmKl1VfdX1BOS7uPvd2OOgeiLr9YoUYteLE2A3WUI3CsAohnRZ7dpBB7NqjsQdAp4Geu2dNmMZhanVYptH6zUiJxSg/WrGQ57oGvUgom4l06K/dol2lCnhIEQ9BaeBl+E0TKVRsWxIXpWyYsC75M=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 IA1PR12MB8357.namprd12.prod.outlook.com (2603:10b6:208:3ff::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 17:02:52 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::12ec:a62b:b286:d309%7]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 17:02:52 +0000
Message-ID: <ea948f80-d0b0-5987-f891-d8f10154901c@amd.com>
Date: Fri, 11 Aug 2023 10:02:49 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH v3 10/16] iommu/amd: Modify logic for checking GT and PPR
 features
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vasant Hegde <vasant.hegde@amd.com>, iommu@lists.linux.dev,
 joro@8bytes.org, wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230804064216.835544-1-vasant.hegde@amd.com>
 <20230804064216.835544-11-vasant.hegde@amd.com> <ZMz66cV24yQV9Byn@ziepe.ca>
 <14ad5515-e320-198f-8e94-1a83678a51b1@amd.com> <ZNJJTzuCyKXQojfe@ziepe.ca>
 <b11dcd0d-f24c-c940-ce10-a5eba650b27c@amd.com> <ZNY0imlDnwRkPb+7@ziepe.ca>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <ZNY0imlDnwRkPb+7@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH0P220CA0024.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::29) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|IA1PR12MB8357:EE_
X-MS-Office365-Filtering-Correlation-Id: 6d6bdfb4-1c27-4c63-1203-08db9a8ccc5a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Lk9MKdGu8yznYXQYSoO4oLwYFF0B+dnRS7p42X2hFZzVx9wjvO6LBHjMkpN3ioBko5vK41UErYgsUrG5zfalcETvMbPTwFL0hSTP8ITDMXLHvhHVB2cZi3tk1+hK3iRJxCiYSco4SuBRsFUvg5zmQGWvqefoU+9ZS5SlhZ8nsokSZCzWHaZIEYrISWRq5XhMSLQpiGsYc36SfyN3V6jIK/5T5eGWUCr8B1RUxeaUwmXOdIH04lZOQ5Kswr6SGGA1Xo0oI0wyKtBDlDDM/eVNYpgKiAYFKtDI8ZWM7dWvMfeWyAIo87sp0zfFO4APQtRzT9ajn3Ng82WUlZ88FMR0hdwcaLBMLBxugwKKcWZV2QGlnaFGikscT5zwGjIKGosXPbHyM2NW9IjlZJLSZ4Tie2D9P8CnZhWmjB3MKIdBUDdSlAN0jDguNC1euK/kRcm9RWJeQ7TrHi7yXM5UENsoS4NJqzizbDiLaoUOBhDdZu5RhbW3WVTBGPAW6f7ucdIj20pTViF7CsK4mYs+RSTds4D4lNr7nn1XNE3wzuGi/z8bDe/dOmuyfCIgohnrhksY9VaO5ShGjT5QBdNKu6J6xWYY1mKc/6D5ZD63xI//JsWjoRt1YkHoHBu8Y/Lxoxl7GoVFChLib6mI0pqz/9dQrQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(366004)(376002)(451199021)(1800799006)(186006)(5660300002)(26005)(6506007)(8936002)(53546011)(8676002)(41300700001)(36756003)(2906002)(83380400001)(38100700002)(2616005)(31696002)(86362001)(4326008)(6486002)(6666004)(66556008)(66476007)(66946007)(6916009)(6512007)(966005)(478600001)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?R0F0WjFJYWY1MmtudmdQakQyaGx0VnlWQ0J5bmVRN1FSZ1hXbm9HUlZnZStO?=
 =?utf-8?B?TVdLOVJ0TjBhZ1paMGRMU20xclhyM0JVY1NDMGxJakdlL05ESWRBZkpZdWFP?=
 =?utf-8?B?ZHUxbGU5cHZGNS9OM2doQzY2VTBuTXJMdWFhSnZIWDNrQVZDZmMyTVlvM2tV?=
 =?utf-8?B?RkM5L2VuZjlnS2RvdlVxMjV3MHRCMGRsMTgraEF5cmU5cytKQTNDcGg3ZThm?=
 =?utf-8?B?a1ZqUGd1L1VDekR0K3lDYzhjOE5QZ213NlFSQzNtb1VGK1JMdHNRVEdGamdh?=
 =?utf-8?B?czB0T29mZ2tVamg5M0tJL21BOHBjRTRpVjdzVVM2SXlVWktXUU1zNndxK2Vl?=
 =?utf-8?B?a1BQc2JGWVkrMlhxcVZ5dEFYYXBsd01UUDRZWXJCQk1VNEJTR3ZOeVdqcXhK?=
 =?utf-8?B?YlhBZ3FhS0JYemkzdlZialdXT3BQeE5vR3NmNTdrOGJJNjhoSkN5OVd0RWlD?=
 =?utf-8?B?MkREcHdycW5TUUhkUDZpV2ZoR1BRVFQ4alZBc3YrWnZEWnZ5UHJhaWhZSXFN?=
 =?utf-8?B?YXVIbzZNa1hxTlFHRTRweHpRZXRGTThOaDNnalV1c1ZEbDN3MmhpYm9iMjFU?=
 =?utf-8?B?cC81VVp0eVQ3cHNJSytvdEdRbmZtbzk3c1pxekNMdTlROC9yMHErV1VsYllB?=
 =?utf-8?B?aVhxNnpNbGJJZzBUUTh1NUU3bE1PSklxbkR4VVhJSTJmYkRleDRidExiSG1h?=
 =?utf-8?B?REg2bXJ5UGllbEsvNkV0WUhOUDdJNHBFS0VJeWtOS0c4cmZiR0x2Ry80SmFZ?=
 =?utf-8?B?bFFWYVVUaC9jbDhvYlQ1bndBdVlBeG5CbHMzd2pobzVXZmoxUjZpYVZwR25E?=
 =?utf-8?B?MTM0SHNMdGVpd0NNNnRBc21HY1ZhVWFQY2ZQY1RKWXdyeXFMVTUzaU5TSkpM?=
 =?utf-8?B?bGFOMTNCVlVWZ0YwU2RoYmQ4Z2pVNjNMZThOWFNrWllBMHc0UjdrNTdyL2R1?=
 =?utf-8?B?RVNMT3o3Vk9hYWkzZHNNT1JWTk81SW02M3FjVFJadHNTQ3BIMS9ORVpsRS84?=
 =?utf-8?B?SDRXVTMrM08rQzQrb0xuNHE4TDFlOTJ3d2RseVdEeURoejNCc2J5dFQvQ29Q?=
 =?utf-8?B?Rms1enBiaklDOUlWU1JWMXB1OUlLRGN4aG40Tm5Ndk56VDBJQnRmeE9MOWtF?=
 =?utf-8?B?WmdVNG53Q1dLQ3ozMzQ4cGM4R2ZXaEpRejV3N2V2K0NJZ2xFWFJpQi8zTTVl?=
 =?utf-8?B?dHhMTDVlZjBldWFsM3JCenpPMklEWm1nM24xc2xCdlIwT0duZ3ViRzZScEgx?=
 =?utf-8?B?c2pVeXRFNFE3VUtMMXU2akxoN3BDcE85VmVSSk5NVGJvTDdTZStGL2FMYUx4?=
 =?utf-8?B?TTJlUy95alBvdzMzSjd1NUdrMnpRQ0o1VnhSMnZlalZaa0JpTjVqb2g1MXUx?=
 =?utf-8?B?WE9xaHZ5NUN4UnZGMHpXeVJSeUlmUGx3SEhpTS9JcHlEWVVtODNzaEFSdEJB?=
 =?utf-8?B?MTQ2K09STmwvN2RHelU3TmRPVkU4a0V1MnJjY0lLQjVPV3VVaFJwc1dmSmFu?=
 =?utf-8?B?Z1EyYklsWDZqYkU0dkl0dFR3OG5ubGlOa29acVdaV2F4dU16WkUyTzQvSE9G?=
 =?utf-8?B?cjM5dDVrR3JlWitxRStuVlZ0NWRyNExQNWRCUnl0SDJnUUJOcDVKcjE4enRo?=
 =?utf-8?B?QWJWMXlwZHdzWTUxTFJIYVNJYUlwNDYwNTRtcjBtMkJpWndPN1d1TzhaSm1Z?=
 =?utf-8?B?MktVbVIxUWtlU1AwK0NlUHVPc3VGS3FjdEcvVXZDZ1U1STZaS0VPRjNSbjMy?=
 =?utf-8?B?U2lQUjQzWTNOWm9iWmpTY2psU1NrVEtQN0QxOFhtNGYwZXpqOEJmdWJqalJl?=
 =?utf-8?B?T0RJbnpHbldramo3MEZYZTM1MklMMEtYT3dKWDhHekpCNm9UME5jcnlWMEZk?=
 =?utf-8?B?RC80TklXR1ovZHVnaE1PSnZHdW5ybEVHYzExVml2VWc3emRZL0w1a2dkVXlC?=
 =?utf-8?B?eWxNNE5PL3ZCcjRndUdEbk1zVFQ1VkFMbStPd2ltMmJsaFpOWUVldDRVQVAy?=
 =?utf-8?B?akd0cWQ4N1BGZURjSEUrK0xKTGdLNXBKZ1RtMTVob2oxZHgySko2aktWZFRF?=
 =?utf-8?B?c1NaM2EvUDJnajFiNE9jYmRHenRCQ2hSNDBIcStNVWRnVHRWb0VoK2lLYjdN?=
 =?utf-8?Q?CiXJ5yeBnnoz8GXyUEv9otdUh?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d6bdfb4-1c27-4c63-1203-08db9a8ccc5a
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 17:02:51.9401
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aTs0akR+stgC4kse0ZyNcVVErOmNkIa+r3ckD2+sLCChr3L2FAJcVTDBmjmKnENUcAG3kKPlata42whv4Uq8bw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8357



On 8/11/2023 6:15 AM, Jason Gunthorpe wrote:
> On Thu, Aug 10, 2023 at 01:31:41PM -0700, Suthikulpanit, Suravee wrote:
>> Actually, it is not just for the SNP.
>>
>> Please let me further clarify the existence of the global amd_iommu_efr and
>> amd_iommu_efr2 variables.
>>
>> EFR and EFR2 are provided in two places:
>>   1. The IVHD block in the ACPI IVRS table.
>>   2. The register offset 0030h (EFR) and 01A0h (EFR2).
>> where information in the IVHD block supersedes the MMIO registers.
>>
>> The EFR/EFR2 information is needed early in the initialization process prior
>> to amd_iomu_init_pci() (where we can start accessing the MMIO registers).
>> So, current code ignore information in the MMIO registers (only check and
>> warn in case of the IVHD and MMIO are mismatch).
>>
>> Currently, IOMMU driver assumes capabilities on all IOMMU instances to be
>> homogeneous. Therefore, during early_amd_iommu_init(), the driver probes all
>> IVHD blocks and do sanity check to make sure that only features common among
>> all IOMMU instances are supported. This is tracked in the global
>> amd_iommu_efr / amd_iommu_efr2.
> Assuming homogeneous is sort of the point - things should be localized
> to their instances so you don't need to make this assumption, that
> means minimizing the places that touch the global version
> 
>> Therefore, the helper function check_feature_on_all_iommus() uses the
>> effective amd_iommu_efr/amd_iommu_efr2 instead of iommu->features. In facts,
>> we should remove the code which directly uses the iommu->features,
>> iommu->features2, and the iommu_feature() helper function to simply and make
>> the code less confusing.
> But if you do this I would not object - I just don't think it is good
> driver design*for the iommu*
> 
> However..
> 
> Looking at it I only see two places that need the global 'all iommus'
> check - one is amd_iommu_snp_enable() which is never called (seriously
> stop adding dead code to support your out of tree patch sets!!!)

FYI: The SNP host kernel support is a WIP, and has been going on for 
quite sometime.

https://lore.kernel.org/linux-mm/72939733-c736-98ec-ed09-e835d8f988b2@amd.com/T/

We upstreamed the amd_iommu_snp_enable() separately to IOMMU mailing 
list to help prepare for the on-going SNP work, which is a large patch 
series. This helps reduce the amount of patches to be managed and 
reviewed in that series.

In addition, this the IOMMU support for SNP is part of IOMMU subsystem, 
which is reviewed and pulled separately from the SNP stuff. It just 
happened to be accepted first.

Thanks,
Suravee

