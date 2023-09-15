Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2058.outbound.protection.outlook.com [40.107.243.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763E63C05
	for <iommu@lists.linux.dev>; Fri, 15 Sep 2023 08:58:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FtCcg+gXFtVbx7M2EIJVleZNJ3+//F0E3npCUUzzyP1JZm5jYhYbu76/7hYFCNbSoXe4OoeQRkP2LdfxaTsfA2T9bQ4QVZ8ofXFl433n+sggTJtcOaxadIXn9wD+8vLTOik1ZH+EhPjSHWX4I1kpVpIrH3jAQUD2WV8XT6d/RXBdiJVxZ+Fqby/Xt4qusUf5u8pHCn3VOUox/XChNFhUi8LYdVcGDNBWTQm1eePsyjZDbwcuNlhPDYv09Jbf3MBRiRp9RYMyw9lFwNo65RYpe2SPTa8OcePL59cLcokEFrgP02D2qdbQ4p5bN4r7J/3JRgOrYIhxiZ64DfzH1Pqwhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7V2k6NUiB38MuGbcoWub02E+IGX9pd1u2s5kyMqM9ZY=;
 b=FGKVI3eKFRW+7squMP8tj/enEFSCGbG/wY8Raba2yDYmxPbwU1Ie67TvhlOzZI5xhz6Wy257lzB6+15q/7tqT3F5xkHfAMTMQ4vhchsMgwr92aixyPZcjevwgX+R1rmvLsTpWHGySV/myX9g3XMtz4VwORCFNFkpj5l+xhHtapCdojZAa0CgcquRZ4QNSYVkDslZ7ixlsl7lEQrGn0VsMbaRKIECDBQjD8/X2DHm9McevJjML27mRv9VOF48jMNAHEXC7O6/XQ1G7iCZdU92XB/oYJjeV4hSqHLAmgte+8VyAxl5+2uJXjNSK2vBP2+234trU/35pGWUSUq5KDfK6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7V2k6NUiB38MuGbcoWub02E+IGX9pd1u2s5kyMqM9ZY=;
 b=yU3a+oqOFD/d3UyUe/hyAp8Y6tQDCjQ11Eb0gy+dL2B/CsHTdrKmiHVOvMyF2KdktJlfvixW5M9uJNmVkckzBiFFGkmbMq5RFfG/bNKBYOAWouz4h0DgqBgtDaRYHsCSI9EceS3Bk9nY9wEBXCGv/2O8g/eN9sgmDzesrD2S24g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7578.namprd12.prod.outlook.com (2603:10b6:208:43d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Fri, 15 Sep
 2023 08:58:04 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::cb74:f20e:dd21:d763%6]) with mapi id 15.20.6768.029; Fri, 15 Sep 2023
 08:58:03 +0000
Message-ID: <9b134256-b093-e16b-3e46-2e9bc42de53d@amd.com>
Date: Fri, 15 Sep 2023 14:27:51 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 05/11] iommu/amd: Add support to enable/disable PASID
 feature
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-6-vasant.hegde@amd.com> <ZQCYhVD+rudRtnFl@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <ZQCYhVD+rudRtnFl@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BM1PR01CA0160.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:68::30) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7578:EE_
X-MS-Office365-Filtering-Correlation-Id: 7435ee82-18b2-48af-b6f2-08dbb5c9dee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	c7RkXdaEnwUc9Hx2gr04Yh8Qh7S5NRi4BP/V5bq3DNr2ntBG84EO6kNpoR0oIh10obuPBizs88rdLY+CnqF08+qnKApvFPWZQmwlLRvdT0GpKLgyUc/aOVf9DumGvhyVEeMzgjzPB3iPnyJpX6wyYXub7zoanD2R+ZawdoJK79jUIgtsWEOJTVtdVbJKTJw55dt03GdS6y9CQEDoHiZJnlwq+OOqLzGOu44dafiey6f3RrPQQXfkhr9ZQi4fuHBVnDkqCoI6zffNeTu0fcXUTXSy140GPPNfpQjQ3xcFt3uQlRQd4I/WyuVa1TnNABwPM2al17Vm740NcfRRKVam8F9VQVkPC4WsWRO302ytFclhXllg8b0qGHjdAg3ktrWaT/EthToxrMI8sXDUlAOC9ap950VefW0xi/XiqW4EI064jji4fuF3bMgtgQiZFlUIKgUpk4J0RqkMgwFoXDlOkz6tw2RRnjpkI0gv3jBd/JLh5wJD0D4KM/kurjrWiLPU3rx/IglCXHLpDYujqTuR0IXbXAWL7k7rFYrhDTSwrLq9cc7MM8GzU6qchWVXOYqJ4pTtIxbgSS5yBMpU2SAvsMXNeBCIYC00QVZ42IuefDujIywd2q01ATb3eOXiZIHGfyO0IlljBCqNcvf6jtIl8g==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(44832011)(8936002)(5660300002)(8676002)(4326008)(66476007)(41300700001)(6486002)(6916009)(66946007)(66556008)(6512007)(53546011)(2906002)(6666004)(31686004)(6506007)(316002)(2616005)(26005)(83380400001)(478600001)(38100700002)(31696002)(36756003)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RkZ2VnZnUjFWNUlpb1dqRG0rbi95NGJ6TWhmT2ZMUzhQSHM2RUtLcTZjOTlW?=
 =?utf-8?B?R044eGlVWkVXK3pGVVNmQWtqclpsZytFRTBhSnB5c3ROblY2TXFYeHc0T1dI?=
 =?utf-8?B?eWNMMVJFODB2dnRkcENIbTBkNmJ1TWxFY3p3dVQyWkE1S3ExMUlFMExuUHZm?=
 =?utf-8?B?VmZNRy9pZGRGSFI3OFhhVUltS3pnaW4rb1pXQTA1bkgwLzUvVUdpV1k2N1Ju?=
 =?utf-8?B?dytKcnpHS2ZPd1BmTCtlVDJZZndXa0Jkc29ORDRzdEF4TW5OdFhZT2FNSDdk?=
 =?utf-8?B?RXZqeWI4NnRtc3ErdU1NVmdGYzVPSngyMER2VWlKMGROYnh6V1l6Y2xra3NS?=
 =?utf-8?B?NklhY096c0YrdUd6eUEvTElmL2tuWThRUFFOVWx3dEtNSDgvVE90aDZIMXBN?=
 =?utf-8?B?UW5TV1d2RzBrL0ROVlNwQlpHU0oreldXWGR1cXRwb21zeHJRcXBPSTFndkdJ?=
 =?utf-8?B?YkRIaUpoS2pzRnJJVlNDUHVPQVp6QUFoWVBxYzIzb2M1WHRUVTllSnoybldn?=
 =?utf-8?B?ak12ajVUWDB1YlFLbnhUZnlYNTNhQ3FQWmNzazJSUG4yeWYwa1JDZGZhZGY2?=
 =?utf-8?B?QW1odkN2NG1VcHpWZ2xlckJ3NDVtN1YyRGRHcXU3MGQ3WGRWdWlzeGZMQXJr?=
 =?utf-8?B?SHlQSTFpTnhxT3hrL0wwTkZPVWNpWFJ2a20wQ1lJUkVWVjF3bnRJNlN5aWFI?=
 =?utf-8?B?L254diszSzZxVEtlNzY0aTA5VVNwZHhmMnhQc2N6T29pa1dXMW9hUzFnZ3Zp?=
 =?utf-8?B?MC94ZXBpYzQ5YkY4S0R0enczbDg2NkJXSHdIeUNOM0VhTXlpMzdINVNyNUxi?=
 =?utf-8?B?T2J2NDl5ZlA4VUpZbjFkdUk2SFV1YlVHK2RJYm90TVB1cm83K2phaWFmRDQr?=
 =?utf-8?B?M1BGeWRWSjdCZktmSmptRjBPRG9Cb3Q0NlUwVGtsdmQ3cWJ6R24zRlpUdGZs?=
 =?utf-8?B?S0VITk42QXU2NTlRM2p0REVTYWtRM3o2dzNMdjNJRm5nTVd2dnFuREQ3TVpW?=
 =?utf-8?B?WjJIUGs1VVZTSmRtNWhUVWpGcDRnWmtQenM0N0RrRXVFMUx4TWxHNnBMUkdw?=
 =?utf-8?B?MlVuMDNybm9KUnJEZmZ5S0xmTnBLekhNc0tTTGk4THVETENlaG5VRjdLdUFZ?=
 =?utf-8?B?TVJFVEpueDFndmJsaXZaaGdPV09peGZsdFdvYkdVbEUrRExxN2d4eXE2NnYw?=
 =?utf-8?B?bVJ1ekdLV2RQYVlLWmpUdnNVdzNYM3hnVkJxSlUwSlVPdmFJcFJvT2VuQ1J5?=
 =?utf-8?B?VUtyNnN4MjBBU09RZHo4TGZhOVp2b3k1NzhHaEVLMjVoSHN0UFFCbHE2aDdh?=
 =?utf-8?B?VUwwb0UvMmFhamY2cGJyQkhROE1HcitvdkZuU1VkSHVjcGtXQUxSbUFYVDhu?=
 =?utf-8?B?YlpWd0gyb0dYNmJ1RmltREhBR0VaVGI2Yjd2RFBiQmxXdGtoN1ZWM0F6cURH?=
 =?utf-8?B?ZFA0WjJHRVAza0N2YnJoK0lpUlZiTmVGRE95RVh5Z3BpclAxUWpRemZ2dkFl?=
 =?utf-8?B?eHd5OHpOYzBpcVp4TTZqVk1YMHMvOTU5MGRhMU50WkZ2Z2hXZmpZVGwzWWNN?=
 =?utf-8?B?cUdRb2xteng0b1pWQUMwYUh3Nmk4WHNPL0J6QlZCMHF0QnBpYVF3U3V2Qm9Q?=
 =?utf-8?B?UGlTVitHMlBSdWV5TkR5ZFlTYUExa1QzREpvK0dNMXpKbkhZUWlDTjQ2eE9s?=
 =?utf-8?B?ejk2WGppcXlwaDBvMitTMzM5c2tZdTFxR2czKzNEbTRKNDFVLzlaTkMzdU40?=
 =?utf-8?B?eE5TVW5yZEtMM3JybDJHenA0bjNwZ3p1WEJOZDhicUNHdEN6Z3g3RG5rcG1D?=
 =?utf-8?B?WkkwRWNXSDhNaGdEVVV6V1lHblF5TFFDbG91RW0xMXRNRlcwRmtNTWdHNFpD?=
 =?utf-8?B?L0hwOGx2RWUrNEZIUWRxSDR1azFFY2NWcjRxM2k3VG11SHhERmlyOFVhNUVQ?=
 =?utf-8?B?RnhLZXJNRnV5QzlINlc2UUpOQnJBdHprM1BIM3luaGdxTDBERDN0dVRHMits?=
 =?utf-8?B?NFBSWmFIVGNQNVZEVnp3eE5JZXZzWVFMM21NQlFSMGk3V0YvWDl4MnBJOW5Y?=
 =?utf-8?B?cEM0dmdLYmRpVjhpc3F4bzhMa1J4cXFrOHdOc0hYQ3phR1c5TDYzZmlBdzQv?=
 =?utf-8?Q?J/Ryqw6LwKFaeEG0Lw7ypVTX/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7435ee82-18b2-48af-b6f2-08dbb5c9dee1
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 08:58:03.8820
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qsj+Tr/a1t3ak9PxFEUEL1PU5C8qi5+szryE16TfQZ97DDRfzuudH3mHLiMZex1bJwqw9byT1NxPJ6liI8RDyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7578

Jason,


On 9/12/2023 10:27 PM, Jason Gunthorpe wrote:
> On Mon, Sep 11, 2023 at 12:10:40PM +0000, Vasant Hegde wrote:
>> From: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
>>
>> It seems iommu_dev_enable_feature(SVA) will be deprecated soon. Hence in
>> this path we just return success.
>>
>> Instead we add necessary check during pasid bind to device. IN this path
>> it checks whether device GCR3 table is setup or not. If not it will try
>> to setup the GCR3.
> 
> Yes, though be mindful that switching from IDENTITY v1 to IDENTITY v2
> on the RID (eg switching the DTE to/from GCR3 mode) should be atomic.

Right. Its atomic. It should work fine. I have to be careful when I add support
for PASID table expansion. But its doable.

> 
>> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
>> index 94eec3dac8f6..5a9749cfe14e 100644
>> --- a/drivers/iommu/amd/iommu.c
>> +++ b/drivers/iommu/amd/iommu.c
>> @@ -2162,6 +2162,50 @@ static void protection_domain_free(struct protection_domain *domain)
>>  	kfree(domain);
>>  }
>>  
>> +/*******************************
>> + * PASID setup related helper functions
>> + */
>> +static inline bool pdom_is_pt_mode(struct protection_domain *pdom)
>> +{
>> +	return (pdom->domain.type == IOMMU_DOMAIN_IDENTITY);
>> +}
>> +
>> +static inline bool pdom_is_v2_pgtbl_mode(struct protection_domain *pdom)
>> +{
>> +	return (pdom->iop.pgd != NULL);
>> +}
>> +
>> +int amd_iommu_gcr3_init(struct iommu_dev_data *dev_data, int pasids)
>> +{
>> +	struct protection_domain *pdom = dev_data->domain;
>> +	int ret = 0;
>> +
>> +	lockdep_assert_held(&dev_data->lock);
>> +
>> +	/*
>> +	 * We cannot support PASID w/ existing v1 page table in the same domain
>> +	 * since it will be nested. However, existing domain w/ v2 page table
>> +	 * can be used for PASID.
>> +	 */
>> +	if (pdom->pd_mode == PD_MODE_V1)
>> +		return -EOPNOTSUPP;
>> +
>> +	/* Allocate GCR3 table */
>> +	if (pdom_is_pt_mode(dev_data->domain))
> 
> It seems obfuscating to put this test for IOMMU_DOMAIN_IDENTITY in a
> function..

It needs to know how domain is configured. Hence I have this check.

> 
>> +		ret = setup_gcr3_table(dev_data, pasids);
> 
> This is the DTE change that should be atomic

It gets called with dev_data lock. And it doesn't break ongoing translations. So
it should be fine.

-Vasant
