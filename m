Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4842E3FB
	for <iommu@lists.linux.dev>; Thu,  8 Feb 2024 18:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707416650; cv=fail; b=h8JJb8PHw4qG+G7UDXv23RLyuDe2zZx6n10mkuXYLOmMPaBdlF2R5oaJrCW34O5sLIHnRISe4dKHZeZ2suQbFhtlOXVQF8giUvIbXIWTdcoxdQ8iHlPv3kWhVwUPaF8GESdSWFKCfl8vpZJdDWxJxxxVbh30eIkZA3oF1UcxTrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707416650; c=relaxed/simple;
	bh=oUFmLxHYg8loQYhwfKD7lljiY9GSbgCbr3F1K3YYDGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E9f7LZogupttYNdDWpY2oruYo1XZPYG77qLceYqSDFPI1K86k9ocgYIoFa99tNrDXSz97JMF5tAeLnO+r3TZftmHICkyVf9GvgupxtzCiF3kQ1YtN6LfUPGY1yjOATSEAFlMRMEzY7bU9llTsKO+/zOeDK71dVAcAbnAO3ItkSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aVim1f5S; arc=fail smtp.client-ip=40.107.93.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aVim1f5S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gATZPAJM2IhhqpESsNHiP77fi9bb6DtFTO3HB551AazTomqE7/6EVLHWuplPdV/kR5B36rLS78qoR/pfcdocpWBjR7r7dEnViNNkmOrhzmJstz2hqSdK33jB6xJSuUs3IVGpcRksPOx0lImXgYMq0lP1kjBberAzC74Y3fvmYv0i7iQW/N0wgbgAN6RKTBZfFJnLBvaUwP6ruqcBnwQO5dOZo/IRDI0Ew7pWAZguizX4EsMOjM2lOk3rQoyUBgIXVJY7Vjlpit0YIAUtQR8uNmrQ4QQBBwCg49YdOlexIaXmOQYE2K32eDtvkmP+oGj9MCk38H7CRrMXtnVZ5MWM+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+uri2DpFhEmDK2WX3+0prVOYv8jTvVck3hqN2l6OoYs=;
 b=dWsnX/5tLE5XwtaWNj6WItUNPMgbySgSWf7xAnVNhlDPkOLthw2tqBpVwq8Ps9GIAScQ1xixrNhi2jNEm1vNFmWE6421DKf9/LvoqRuDKdtZqyS6E2uVFflC5Np4uHX6tHnauDNDrgotlt2+Ox5tk8qGPWEqruuhTeYrtM0sxPMbX+cth649E7a8nsJBSsl8oyTTl8e/OYRjIDeaHfNGJHcPVtzSlIcYUdF3YIlM7ans8TBz3oTMYGFZgNLRH05cjTA874OsiEi2LvpLLuU3Lc53brgtAADhx8xR9CBN64/vMypyygBM3BwNgdU/xLUdyWW5dlhMrBT1DCCLITm3hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+uri2DpFhEmDK2WX3+0prVOYv8jTvVck3hqN2l6OoYs=;
 b=aVim1f5SkcDewLDvjiey4bwZbys3KtgapuFE3IiZOP4Y/z5bVzwFYutJ6CVUYe3SZRK+xHcjJcyK1vJldPFZrEzhQjH0QKwPLelhHoTMvXuUojSQ2+rv6ANcsis/SdMuotwKQkoJZfDguCrwWNMs70Jr8l1kGTVfxSi2xICtq3k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.11; Thu, 8 Feb
 2024 18:24:06 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::481d:7627:c485:9cb%2]) with mapi id 15.20.7270.012; Thu, 8 Feb 2024
 18:24:06 +0000
Message-ID: <5ce55e42-d158-1675-f906-58b545e2b2b6@amd.com>
Date: Thu, 8 Feb 2024 23:53:58 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v5 12/14] iommu/amd: Initial SVA support for AMD IOMMU
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20240118073339.6978-1-vasant.hegde@amd.com>
 <20240118073339.6978-13-vasant.hegde@amd.com>
 <20240202152524.GA2606743@ziepe.ca>
 <f36ea0af-23db-7653-32e0-0a7b3941f801@amd.com>
 <20240206173457.GH31743@ziepe.ca>
 <0af9b44f-c78a-7e79-5c10-fe8d6e92f5bc@amd.com>
 <20240208174159.GW31743@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20240208174159.GW31743@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0184.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: 57be1cfd-7fcb-408c-9dc2-08dc28d3226f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KXVGNRHDuIOcC0QvAhuQW+EpcSwBhCqjRgqzy0wvRrTWyT9UR/ET3QZRACTtOXV24x7lzFCIJ/3Zpr5L8hR79fLE8pTmJAqD2yfNc4MJkrE0jj4H87+KIR31qAwUI8YEM/2xjQXmbNboszTDvf0kRKt6CjPO2021et9haRS2N3ki8dDD7SXt9VaivLU0YRyHQoGcvTWE7NX6sOcGPf75pCXNzH8aq7/1zrQA7Xl1o9qXBHFOqA8NLXZS2k340OGJKxhmV4jsQCfql0EK+iE0d/RJRcgpUbgoNS84JFBcc8/62tJxRu9jwWaYqeypKJ/6B8jPZ5lpM1qXLkoMC+HqjJMI7QQGGRmPNIpphazBtjXN53lE0CtOvF3UXmH6Meib2zg77mptTbvaO6Idqf7GGFAO6reRpo74QMqkY/iDuEBex3weiV51gh8P6smGAfBN84nmJ9nNmNYUJGIQp3SaJwvboP8zhkf9zFU7PpaNoFb0VqtZ+bcJCKZpGBhozWeYWhG093O6iKKZjma65OWGqmtRgE+vYAZcrY7aEpBeVjsipV98ZgfWEb9huZ/GWfei
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(36756003)(31686004)(316002)(6666004)(66946007)(66476007)(44832011)(2906002)(66556008)(4326008)(6512007)(478600001)(53546011)(6486002)(5660300002)(38100700002)(31696002)(86362001)(6506007)(2616005)(26005)(8676002)(6916009)(8936002)(41300700001)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?alFvUDhPN3BoN1FHT0dSNjJBUlF2c2xlUWcwV2V2V3JnM3d3VlFDQUlTWFhF?=
 =?utf-8?B?a2hYTml5dTVDcUNPb2czQzhDUnE3YVNTK0NnRlFCNFkxRXBKNnZrcTM0b3ov?=
 =?utf-8?B?UVVWaWE1dEVKeUlpQlFlN1hnYytMZ28xNDdBcTViRk1mTThjVlFEcXVFWm82?=
 =?utf-8?B?eXhaZWhQdFFSYU1FaXFmdTN4TVRrMFRYRHJpWkRiTnNEM2k1ckYxdlpIM3dB?=
 =?utf-8?B?RTRQdGdWK2pJRWptMnVXN3hLM1ZOZUpYVXZQYWxobzV6bHZWTEdTQ0ZkWWtQ?=
 =?utf-8?B?TFlwN0dXZHFaMGxXdzF5SE1WS3B3a3h0cGxxYklTeXVCV1I3Y1dzSUQxKzZO?=
 =?utf-8?B?QXVYZUNJaVBZOHZCbmxDOXdLa21vK2U3WnpQM1ZENStCTGZmNmdsVlBvaS85?=
 =?utf-8?B?RDVja0UzTDBNOGlwU2RTNkNZOXRkVjRGN1FFQjJYTWN3LzZhWmlVZGlWYUw5?=
 =?utf-8?B?dGNKNDRHU29qSHgvVy9ocVVRZGcxRUtxOGd3Rk13SDdjOUxBVTVJMWh0QzJO?=
 =?utf-8?B?MFFtWTJVS2tKNERMYzZERU1HMkw5Q2pvYjQyQzVrZ1BpajdlaGRJdGY5OHlQ?=
 =?utf-8?B?WUJ4bUIwMkg5VFBLc3ZKRFR4LytzNzFZQlYrc3NKa0J5NlUycDBaZnBHbjdO?=
 =?utf-8?B?WUZFRVZiRTBHNHl6R2cvRlNXOTNmcXUvZHZsL3pZN1lYdTFkdmFSZ2sxZ0Zx?=
 =?utf-8?B?OTdrWXc0em13dk1rZGtJd1R3NDBmNC9WeGNyU1hSNWRWSjF1ZzlhTE9NcmVq?=
 =?utf-8?B?QnpSRGJWT1A1WXJ3b1RYU0xuVnRxRUZJSFJ6OXpPMlBPUG5HZytxNTV2U3R2?=
 =?utf-8?B?cDVkZ1ptamJJbmZ0eEhlLzFGclBDS0p0U2tUWTkyM1BYUjRqYk1WQm1qK0h6?=
 =?utf-8?B?TTh2MXZPUHVDWmI5K2kydTVtV09oa0l4U0FEOUQrblRxTDhReng4WUpSQ3oz?=
 =?utf-8?B?STdRN2JEL1c5NGx3bzdVNXdTZWl6eG1vZW03TlIrWE1ORFVWZGNtc016aW9j?=
 =?utf-8?B?Mjg3Q2xyTFdZalR3Y3BLS3VNcXlvaFZkdExPai9BbXArSnJGb0Y1RW1TVW9X?=
 =?utf-8?B?WUlEL25mbTlJUVJ0d0VVTmwwbngzelRIU08zZnlCbUc3ZGQ1ZGUrWGwzQS9x?=
 =?utf-8?B?VHphcDVaSllBaEltR0hFT1o4MWpSS2dZdjRwQTNPUEt0RFhya1ZTZzlQbGEw?=
 =?utf-8?B?KzVlSEErcjcrWUFldHROMlN0TklLNSt5RE5Jd2c0VUM2WWIvWFNNdnkycmFo?=
 =?utf-8?B?ZWZaTEVOU2Z5REU4UE9oWmFQTXF0elNQYUg3cEYweXFBVGdDUTVYeEYwOHh5?=
 =?utf-8?B?VEZaUE5MU1RaSDFHeVFabXltRUtQem1MeEpIQ0RScFNRYzJvbzk0VzQybnhu?=
 =?utf-8?B?UEFDeXdtUUdNTUFhalRRNng1ZjE1N3kveWhZZEl6YjZYK0ZQQ0dmajJBVXdO?=
 =?utf-8?B?VDNPTGo3KzlwaU4zZ21qOHJlbmo3c1lkZktkWUthUDBMMmtSNE1taVF5M1VL?=
 =?utf-8?B?SDVJc3crY0k4VWpreUFQRWYvYmxkOE5rYTdlYXczSE9FV3p6eVhFQ0pzenYv?=
 =?utf-8?B?djhtQUdhYzBJbDdONU5BVTg5RFFHa2F3dHF2SUlLK0h4S1RSK2Zhb1VudkIw?=
 =?utf-8?B?QXNqWDJlZjF4Z1JObitIVHpvL1hiK1Bjd2ZaSjY2ZHBTcTg5S254dkhVVWlP?=
 =?utf-8?B?aCthakJDdXdPd3JUbU10OS9GREFzVnZTcGNKNU5nMlJnSlJDbEIrQWZNVTBO?=
 =?utf-8?B?OVd4T0ozY21LRENZTVFWeUxibEw3R1JyKzkwZVNrUHFXQnk0T0dXVjh1aFJV?=
 =?utf-8?B?djBGTHBBVm5UVnByaFlCR0YrQWJuTVNqUmdxbHJyd3M2WHd2WDJtaDd4bEFn?=
 =?utf-8?B?S3QzZlp2WVJUSVY2YTBES1NaZDNhZmI4dkw5aUo0OE94eDhzbXB2OHdrV1Vv?=
 =?utf-8?B?SUYvMGJTYTNpcTlIMDdlaVdKeU1aVmFjeHE0Nll3ZnRqbE8vWFJQWmN4QytS?=
 =?utf-8?B?NHFxUzZDRzlKYlU1WE1hV052QnVQYUJpK2xqVEVrUkFVUk8xVitLN0huejM4?=
 =?utf-8?B?eG16MVNaZGppVHBiYjZxditiamFPM1dzV0ZsZWNyUURpTmhrd1lObFo2dDYx?=
 =?utf-8?Q?/LWZWc6/E18fdxPm1b7dTFrYv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57be1cfd-7fcb-408c-9dc2-08dc28d3226f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 18:24:06.2135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i7V9U0Ht/Gt2J6bY4oYz5nESXJWBpRo7FwFGP/JN1EOpedNel3px+xegCsPTygI6r8zbziEkKfyy9wTIt5YluA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110



On 2/8/2024 11:11 PM, Jason Gunthorpe wrote:
> On Wed, Feb 07, 2024 at 03:01:22PM +0530, Vasant Hegde wrote:
>> Jason,
>>
>>
>> On 2/6/2024 11:04 PM, Jason Gunthorpe wrote:
>>> On Tue, Feb 06, 2024 at 10:46:58PM +0530, Vasant Hegde wrote:
>>>> Jason,
>>>>
>>>>
>>>> On 2/2/2024 8:55 PM, Jason Gunthorpe wrote:
>>>>> On Thu, Jan 18, 2024 at 07:33:37AM +0000, Vasant Hegde wrote:
>>>>>
>>>>>> +static int iommu_pasid_enable(struct iommu_dev_data *dev_data)
>>>>>> +{
>>>>>> +	struct device *dev = dev_data->dev;
>>>>>> +	int ret = 0;
>>>>>> +
>>>>>> +	spin_lock(&dev_data->lock);
>>>>>> +
>>>>>> +	if (is_pasid_enabled(dev_data))
>>>>>> +		goto out;
>>>>>> +
>>>>>> +	if (!amd_iommu_pasid_supported()) {
>>>>>> +		ret = -ENODEV;
>>>>>> +		goto out;
>>>>>> +	}
>>>>>> +
>>>>>> +	/* attach_device path enables device PASID feature */
>>>>>> +	if (!dev_data->pasid_enabled) {
>>>>>
>>>>> How many times are we testing for this? Just check if the gcr3 table
>>>>> is installed once
>>>>
>>>> One time for IOMMU capability (amd_iommu_pasid_supported()) and one time for
>>>> device capability.
>>>
>>> Again I think this whole thing is out of sequence. The main focus
>>> should be on the gcr3 table. You should dirctly know if it has been
>>> installed or not via some direct means. Test all this stuff when you
>>> go to install it the first time.
>>
>> We are doing 1 SVA domain : 1 PASID : N devices model. That means we need to
>> check all these things while attaching *first* PASID to device. (That's what we
>> had discussed sometime back when I had all these things in feature_enable(SVA)
>> path).
> 
> I thought I said you 1 PASID is not technically correct, but you could
> get away it it for a short term. You should be planning to support N
> PASIDs because that is what the API defines.

I am describing API in SVA context only. In that flow once we allocate a SVA
domain for a PASID, then all devices for that PASID is attached to same domain.

> 
>> Ex: If device is in domain with V1 page table tries to attach PASID it should fail
>>    If device is in domain of PT mode, then we should setup gcr3.
> 
> Yes
>  
>> So I don't see how we can infer these things unless we have something like
>> enable_feature(PASID).. which would have taken care of setting up things.
> 
> You just trivially check these conditions at the top of set_dev_pasid, look at
> what I did for ARM:
> 
> 	if (smmu_domain->smmu != master->smmu || pasid == IOMMU_NO_PASID)
> 		return -EINVAL;
> 
> 	if (!master->cd_table.in_ste &&
> 	    sid_domain->type != IOMMU_DOMAIN_IDENTITY &&
> 	    sid_domain->type != IOMMU_DOMAIN_BLOCKED)
> 		return -EINVAL;
> 
> For AMD "cd_table in_ste" means that the DTE points to a GCR3 table
> already. This is trivially tracked in the DTE programming in set_dte
> because you know if the dte is being configured with a GCR3 or not.
> 
> The other cases represent the situations where we know how to upgrade a DTE
> for those domains to one with a GCR3. Everything else is blocked.

I got something similar. I have reworked set/remove pasid path completely.
I will try to post it soon.

> 
>>>> is_pasid_enabled() is checked twice (once without lock, so that we can avoid
>>>> lock in most cases and one inside lock to be sure no one else entered and
>>>> enabled gcr3).
>>>
>>> That never works, don't do that.
>>
>> It does work as second one is lock protected. And the intention was to avoid
>> locking for attaching second PASID onwards. Only for first time attaching PASID
>> to device we will have check for two times.
> 
> You can get racy false negatives, that are hard to reason about.
> 
>  CPU0                               CPU 1
>                                     lock()
>                                     change state to !a
> if (!a)
>   forget it
>                                     a = false
>                                     unlock()
> lock()
> if (!a)
>    forget it
> change state to a
> a = true
> unlock()

I don't hit above like scenario as its enable once/check awlays until all PASID
binding is removed.  Anyway I have reworked this part completely and removed
most of these checks.


-Vasant
