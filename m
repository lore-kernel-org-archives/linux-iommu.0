Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DE0D200DC
	for <iommu@lists.linux.dev>; Tue, 10 Oct 2023 14:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GjTr7seC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ga/OX/5LBK088N6tpZL/AckcXofzpXfT1LUwnG4EUI2CgMtDWeByAym5BOl0bhKkE6nX1w0ap/oHPLgsDqTGVzgOxPTMGhWkDwylZ6oAFBRbumIpVGUJQwhqoS6QrTO2gnEZvWTe6CehGbtiiaZEv/9a5l5oqAUV1QmeWmZRLW20IEgmk3cbXGuYg6wWWBLUE35zBAjoL+KdEGu4HnEoACdy7lHCL02MGH5HgtVXcg0v25jBxahnTdxGvWqInJySHsLWnWywF9Y2Y2Vv51nWYmTamo1Wx8DBVctfQylJIG9KjnQflQGmSJHI6CK5OkXjRuxYSfS5C3Uw5EnkhqE2GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPZkfFveif89TfRh1+4MiJYJUN26h9y0Kf1g0vPG/Kk=;
 b=OJKhpF3An8fSsP56Hu/deIqlO8NBoR4J5qDoNSdMFghxGrUXdJN8Y7c3x13KSxSGZvPFJoa7jKM+i4lQi+1J160Dmin+tJmDi5rlpkH2Oz3CxrOZAA6khYdMWJR7S4h94gPlaMu6nwU7w2p5QvOFtT5Fa40NcCBi0g6GpuxfBUG3fcC8F0hGjDw/sCHH6xVI1bQiDhagfGRhjm0ZJyl269JeloGT7Xd3ubMm+rz2//VwllKrRm8hj4edXX7KQSYMDjMiKmOZavT3n59kcfptghA9w3tPQCog6Od7GMgRuCE4c0n7x/5Y/kh7kBwS8WsJ9BcZW2l9PZsvg14LkKha0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPZkfFveif89TfRh1+4MiJYJUN26h9y0Kf1g0vPG/Kk=;
 b=GjTr7seCMr53qJ5+7ITAN/KdtYYa+vIL7V1xLBXx/YvlUFMsHv23oxASYjSVULLmMs5/KyVYr37csEGvwGha50bqYhSbX7C3zbBbMxKOo8d86sqpArNxOfL9jyKsp9P1PHreL7YO2pB0w7cVmA3z+2tqBxFru/9eZ5fShaCOy0U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 SA3PR12MB9157.namprd12.prod.outlook.com (2603:10b6:806:39a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Tue, 10 Oct
 2023 14:53:18 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::726d:296a:5a0b:1e98%4]) with mapi id 15.20.6863.032; Tue, 10 Oct 2023
 14:53:18 +0000
Message-ID: <eee6f770-248a-033d-675e-f4c875212368@amd.com>
Date: Tue, 10 Oct 2023 20:23:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 11/11] iommu/amd: Introduce logic to enable/disable
 IOPF
Content-Language: en-US
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, suravee.suthikulpanit@amd.com,
 wei.huang2@amd.com, jsnitsel@redhat.com
References: <20230911121046.1025732-1-vasant.hegde@amd.com>
 <20230911121046.1025732-12-vasant.hegde@amd.com> <ZQCSi6ROWVrIZEux@ziepe.ca>
 <57dfeefb-5a21-3e18-46f1-851de56a3037@amd.com>
 <20230918124505.GC13795@ziepe.ca>
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20230918124505.GC13795@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0161.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::17) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|SA3PR12MB9157:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b7e7d34-c5b0-42be-b317-08dbc9a0a362
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	D4xNr1JCLc7wijEth6NV1bBjUdWDrwi2AgSsPUxz6M0VtAu4nITv0+MDCal+hpcf/IFBDMYPazs3oS5mrmK65Jl/TXUci276f9RZ8ARiHyy4TnVtBcHgZ5kd+8H1Xuq+mDOt7JQxg/PNLXHJ593sn7ymDVh02VtSKR0h+veF5qz9guzlkviUwCOfk4DIN6j2Dg7wp7mMC/EmtkiudzjUjxKaN33Lz2YwndGSkiSq7/mkY+2ViAaZnnMQrApJBxUBn36fVdvfAxw4Sg1Hu9QCV6qO+1wHSzlqRgpo0n6W3/zLWQj/UKQHxVpKDra9C189pUXV6rGKLRVkrkIc5qsMdD1S7MMIrjZ5k2ZfmCr26sN8KEXf4572YT5Zq28GMgFLwT7RtmpD1kwsNWsEn5azsx37OMDP7SOH5DCpzm0sbDC/tIjw722q6DpVes9CKSK8KGIEmT4LjVpzteSPhlxY6klHRusFHBSvTg18TZ/LVhj+eZB6US2dLmaGV+XUmWnvqrRjSxuIUnc6KtMyuiOJadaVvOX6tJQkQSPlC2z6YtwFS3gXWkkIuV+ZlMww7Zy5LdOJYab7uIqXVYbs22OYlNAMvjx2AWmMyzea6sJUtrFhXm+xxdMgNiwd7P1jZwcIWcmpGs8qeVmC9S0Yw6VMtg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(366004)(376002)(346002)(136003)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(6512007)(53546011)(6506007)(478600001)(6486002)(2616005)(6666004)(26005)(83380400001)(2906002)(5660300002)(66476007)(66556008)(66946007)(44832011)(4326008)(8676002)(8936002)(6916009)(316002)(41300700001)(36756003)(38100700002)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TWR6TXF6ZlNyNk9ZSldNS0dpR2tJSnhNNmI3MHBpZkdMbzM5U01SZDl1ajUw?=
 =?utf-8?B?S1U3b3Exdy9mR3J3aWlBU1ExUFdZSnpkM0JReFFRYmo0ajB3emIxRDdFK1dK?=
 =?utf-8?B?UlRYbWNqWnMzQ21saTJCOWZuWklUK3NnWncrQW5RWUhaNFkrU3VuYko2WUNH?=
 =?utf-8?B?dDdUa1kvVjhUOU5QNHFZSHlteFpEUkt0SDdoTUNpaStjb3M0ZVZsU0ZVQzl0?=
 =?utf-8?B?MUhMS3RiRXhOenZnV3o5RFpxNmthNmJhN1ptVG13cHZzOFlPOWUxeHF0dmtu?=
 =?utf-8?B?cmEybWFSd2UwczVORFFtMjMwMDJ6OTJoTUx4Y3M5WmdaSXkrNUdHTzh4L2Iy?=
 =?utf-8?B?NlFTWlFXZE5ZN3l0TWhqMmFITkw1OTdWY0M2UnR0NmM1ZGU0K1NoQ2Ztek52?=
 =?utf-8?B?czZaODlhb1FyTWFmbjVNWjlTUlRjdzJKVnZzM3kyM3pQTDNGZ3hjNS9hZEF3?=
 =?utf-8?B?cW5zSW45aUlPZGZsT2Q3eUhKakFPamZZVU9QQnc2WmFTTE1OZFk4SFFaR0Ny?=
 =?utf-8?B?Z1laTzBUZU1YTTAzcVM5Rk9LRGtYbFg5R01GaDVFYUdtY1hraTFQQlgra1oz?=
 =?utf-8?B?L1ZIMnM3STFCeWw2Z1JIMGRjcEhKTStpeXZsb3lKYmcyM0tONHZHdzVTUkdw?=
 =?utf-8?B?WXQzNU9GN1o1czI2L2tKdjBBN00yS1lab0xxejdjekNlYXZheGVaemFtaHRG?=
 =?utf-8?B?clNmb2V1VGJERlFlVzVNU29BT1V2cVNEK1FGMWxPOVNnbi9VZW9HL24vZWxF?=
 =?utf-8?B?MUd4eTdNNUtkUmltNnlYQnFQU0g3ZHZpSER6K2luT0NINFlUUXZDdWg5bXNp?=
 =?utf-8?B?WHZTRDliSEpKV3F2N2RYSzU0dGtmbG1XNUVWWjNsVWd1U2hCU1o2SkZyWHRS?=
 =?utf-8?B?YjRnMldSUXpxbEw5RU5lS2FzOE5Jc1lXelBhTTRNNFE3Y25oT2dlUm03WDZ4?=
 =?utf-8?B?Nmp2dVM3dFZxc2gydFVVRjlxdDVRNzRMbXdRaUxpRlNENGFXUWREaEhTU3BT?=
 =?utf-8?B?ZGJib3duQ2tlZm5JRTJXWGlYajFYR1Rkc2s5KzFnUDhWL293YzRnc3Q4NWdx?=
 =?utf-8?B?UkJIa0N1a1ZxWDBkYnF1cGR4WjNCS3JxVVNKOUtxdWUyR3FPdmVUREpITTNq?=
 =?utf-8?B?VjRLVnprVEFOOUxrcWhNNTZJTVNCanZzN1pFMW1WOG8yLzRZZWZ4MGJad2xl?=
 =?utf-8?B?bVd1NllZcGFQZGR4MjZRUzVnRXdWZUpibGFkTFJ4K3l3WGQzREpVZ1prekh1?=
 =?utf-8?B?NlRDbDlSYUNXYm1XZWIwekZ0Q0ViWGVFMDlvTW15eE5nM28waWdxUXVBczNx?=
 =?utf-8?B?VGlHRDNFWFNBRVRUM3hlemw2WVBvSjYxaCtWM2ZQKzROSzJZODF1TW1BVkhG?=
 =?utf-8?B?Z0hBZTE4dzVUTXBCYndQNDBJQzNEaXpqS2R3NkQ4TVBRN3RNckpLR21ienhz?=
 =?utf-8?B?MTh2anJYTnovRXRzMWhjc2NEbzUwUGxJenNQSE53ZzdYckpOMzhLUU1ScWpB?=
 =?utf-8?B?QVU1UUJ3TXdITi9oK21NdE5WUFQwY0tRNnU0VnVjSnNZTXdKZVQ2YWgxUFRZ?=
 =?utf-8?B?ZHdTMjdZNzgyVFFHWFVYVWZ1dkthQkN1M2lYN0lOMXo3bFpyMVFySGZFNlZB?=
 =?utf-8?B?OXo0L2JJM245WVFIY05CYmlIWjVoR1R1ZktsNHcxcUduV0lZU3ArcU5VRTJ1?=
 =?utf-8?B?SzhMQ3VmSENZSGRWcjFVY1FndE96TlRKNXhvbUN0TDJmbWFYbHQwNm56QU53?=
 =?utf-8?B?YTE1ZG1MQUg3VS9ITWFPUHJSOXY0TFFsZXlORS9sTnlZM2tna1lZY1JzK1Bp?=
 =?utf-8?B?NlRkWmQ0dGRDY29ZWktmSENJTmgyVFlKQ24vWVdsVXp1REw3eG9IVFhIK3dZ?=
 =?utf-8?B?bi9HaWRsd1BQd3Y5V1E3OFdFT24xYjlVZndwdGF5N2VWQVNlQWRkNHFibjJ5?=
 =?utf-8?B?WlZud1kzeW15WGJHTWs5L0t5eThROUs0Q01Ic3RaM3N3YllkQkRpeTRnVDdW?=
 =?utf-8?B?aU1EOGM2VksxdDJKR3E0c2NRM0p2RFh4M0RDeGNESlAySkNldzExL3BNVVpY?=
 =?utf-8?B?cmtKakpjcTRoang2VkVhOXVNMmo1Wi9wVnZoMno5ejIrQUkwZy96UlJadDJ0?=
 =?utf-8?Q?6amMq9JNEyloqfyDYW/9c+yYD?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b7e7d34-c5b0-42be-b317-08dbc9a0a362
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 14:53:17.9707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E/62ofwxFaN6Z2g4Cqs95VoQVP67O1O7moSyPi9xww5wfZdY/OTAMo+teFHZJJQtBaKaKeItyLjGtp7KIE7LwQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9157

Jason,


On 9/18/2023 6:15 PM, Jason Gunthorpe wrote:
> On Fri, Sep 15, 2023 at 01:56:54PM +0530, Vasant Hegde wrote:
> 
>>>> +static int amd_iommu_iopf_update(struct device *dev, bool enable)
>>>> +{
>>>> +	unsigned long flags;
>>>> +	int ret;
>>>> +	struct pci_dev *pdev = dev_is_pci(dev) ? to_pci_dev(dev) : NULL;
>>>> +	struct amd_iommu *iommu = get_amd_iommu_from_dev(dev);
>>>> +	struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
>>>> +	struct protection_domain *pdom = amd_iommu_get_pdomain(dev);
>>>> +
>>>> +	if (!pdev || !iommu || !dev_data)
>>>> +		return -EINVAL;
>>>> +
>>>> +	spin_lock_irqsave(&pdom->lock, flags);
>>>> +
>>>> +	if (enable) {
>>>> +		ret = amd_iommu_iopf_add_device(iommu, dev);
>>>> +		if (ret)
>>>> +			goto out;
>>>> +
>>>> +		dev_data->ppr = true;
>>>> +	} else {
>>>> +		ret = amd_iommu_iopf_remove_device(iommu, dev);
>>>> +		dev_data->ppr = false;
>>>> +	}
>>>> +
>>>> +	amd_iommu_domain_update(pdom);
>>>> +
>>>> +out:
>>>> +	spin_unlock_irqrestore(&pdom->lock, flags);
>>>> +	return ret;
>>>> +}
>>>
>>> Same remarks as for the SVA, this is in the wrong place.
>>>
>>> iopf_queue_add_device() should be done when a PRI enabled domain is
>>> attached to a device, not in feature things. I also want to remove
>>> these too once ARM is fixed..
>>
>> You mean we should do this during first device/pasid bind time?
> 
> Yes, when a PRI capable domain is first attached the PRI stuff should
> be setup. SVA is a PRI capable domain type, but we will have more..
> 

I have done this for now. But can you explain why you want to control device
feature? With current code, if something is broken then device driver knows it
and it can decide what to enable/disable. With new approach IOMMU layer will
endup applying all device specific workarounds right?


>>> amd_iommu_get_pdomain() has improper locking, it needs to hold some
>>> kind of dev_data lock to access dev_data->domain. (and really this
>>> would all be clearer if it was just written dev_data->domain instead
>>> of the redundant function)
>>
>> It helps to get iommu from device structure. Its useful and we want to use it
>> other places as well.
> 
> As I said, it seems obfuscating as to how the locking needs to work as
> you must hold a lock while using dev_data->domain. In some cases that
> can be the core code's group mutex, but that doesn't always work..

I don't think driver should rely on core layer locking mechanism. I have cleaned
up this code.


-Vasant
