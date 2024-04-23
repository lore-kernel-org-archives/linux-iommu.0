Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D960877
	for <iommu@lists.linux.dev>; Tue, 23 Apr 2024 10:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713867110; cv=fail; b=B48263m7FZWSO/xFziXOuFu1zGWL353igF2t2Joj17hUsUAz/5YjTVx9jZgcBtbgheT7zG/9KcYZ8I0cvqcA16igsw1t9Z4+5zlU42k2r53iQbW49WVFzyXBm+L5z532pMzIeSSpIqXiQsWAQ2tt2cI8tgHe7FWPdTGULZiNZog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713867110; c=relaxed/simple;
	bh=3U7FE62Q9v5Qg0juHPuuk+imb37YsARE5Dux1KLwoRE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dBbcNUosR5LvFp1dacKzrjyqrZqs7FHcmjZTzm6X+1Ce5Hz3KlJFgg5CUZNl3ki3ZCNx05LzfuBMwK3/F6FWf6gmAqJegV7udUq/dmqTsNWWRLnj22R6NmdEMaaGBc8Q4oUqFlSym+4AaTB0hlAAxsC+hzxjaE+fw2qrcyqy8Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GxH9Cgmv; arc=fail smtp.client-ip=40.107.243.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GxH9Cgmv"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCtICQKIRsvcgaOhg9vhBX5ARQEGpwusEJ9LwOg5ACtErGQfBCIeo24Y/l3owGR+QiGBgwxH6y+vpz1jIs1jY4zD2kD5a3v7M10r1gGkHHjP0q/ELgri7ApdsCW+4sKvnlfOHcVVReWkNs7QzHkW/h9vuzTHYXotBXh1hTRCgNgIsJquSCFHiCQPoxhVvIdejcXy+/u9cy9lO1u5gAMvtkx8r9UhLcyuH71H2o7BQfSzfOXPFn1LC5tyL3Vj9YevRwFLDscNg3paee6/bjCfD6PUze2z9eudNzlIRmEWjL0iMXrcAYu42TZhQB1WwxT3ZXQDMeC69qI13yhdRV4nNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jyVKN0zKFt6h/MhA38kaQ1W+Uz6UKmz9ME1oG8rF7o=;
 b=TYT7YFZeT93+/DqgxXktytKU0XqyQqtb6krOICX55xN766nXWkc6sr1teAXD7vkmYqiZjFfYUZlEwaP5GOahNyFXfZvuubWnWblrdjoJINfLdTEm+sPqbIcZrY70i3+3XGBLvcJYBijASSy31k+BMxZ9JZmQQx6uTDcuLy/DWqGZxt4GkGp+lZkVXmFEat4+EbQqM/0RZEYBezPgR0b1Fsp5NqFhSy5idE3lFDgJHizPdY4UQCItratPqufn6OeZh0GAmkjEHcYmt56YE0YVAuX4tYb4qSfhiFxgMC7G8F3QcRHmBaDFNNcXq4xtBZYgxvd4wh9ovRGeb8otm2JHdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jyVKN0zKFt6h/MhA38kaQ1W+Uz6UKmz9ME1oG8rF7o=;
 b=GxH9Cgmvh188E6QrnV/O3de0n124OSJJ+sbRoQ/EU8CFhomlpdPs0ToHv63CV8ik55Lr3Ho1Gf9rX+qYdz5YVbBkIsWycCHf9M7CAY2g0+CAo3R93OjEzdeo/Lvqa2IkMQsZrpIyxymdmfL56Hl2LiaEYxjXYFFmwGn3coFDLTM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 IA0PR12MB7627.namprd12.prod.outlook.com (2603:10b6:208:437::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 10:11:46 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::af7d:5f4f:2139:ebd1%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 10:11:45 +0000
Message-ID: <52c162ae-a66a-4e73-a953-22da43c30390@amd.com>
Date: Tue, 23 Apr 2024 15:41:35 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: Enhance def_domain_type to handle untrusted
 device
To: "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Hegde, Vasant" <Vasant.Hegde@amd.com>,
 "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
 "joro@8bytes.org" <joro@8bytes.org>
Cc: "Suthikulpanit, Suravee" <Suravee.Suthikulpanit@amd.com>,
 Eric Wagner <ewagner12@gmail.com>, Robin Murphy <robin.murphy@arm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, "stable@kernel.org" <stable@kernel.org>
References: <20240419114715.6028-1-vasant.hegde@amd.com>
 <BL1PR12MB514484CC63FA4A5193A6C580F70D2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Language: en-US
From: Vasant Hegde <vashegde@amd.com>
In-Reply-To: <BL1PR12MB514484CC63FA4A5193A6C580F70D2@BL1PR12MB5144.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0190.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::19) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|IA0PR12MB7627:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b68e3ce-c7aa-4338-0cbb-08dc637dc7ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T1dmUVJwZGZmc3NzZmpSNy92cmVBZElEaFlEOVFkV2REWi9NcEk2eWNuanpD?=
 =?utf-8?B?TllmbEtPdmRhT25Ubi9lODlQMnZqZW9vUmQ4d3l5TExmT29XZlh2WlJDOXYv?=
 =?utf-8?B?THFZUVNNZG8wdFpoWEt6VkpGSk00U0drNTJvTmV5N0xzbGpxemZEMmcyMzZw?=
 =?utf-8?B?SHBzQWd1TXFiVGRJRFNMOTJUTzQvUVp1TTNyWWMyOEZMbjBqZmpnaFVuOWIy?=
 =?utf-8?B?WHM5WVpYMEx0VEhxRmE0YzNDaTF5eVp0RnRmYnJIZ3E4STV0ampESngvOGZw?=
 =?utf-8?B?WFRrM3FBVWNXaUREUGtwRHNOTmY0Uy9mSDVCNGFyUmliWXNlY2lqUlBMQ0Er?=
 =?utf-8?B?bGJTYWd2RUFXK0lYY0xoQXZ4WnlhMVBoRlc2b0c1SU9hNm8yelZ4R3RuODBi?=
 =?utf-8?B?WS9TR1YrT3YvcmdBckZLcHZwZTUxaE9STjZmUU5SQWwxdzlWMEJldzhDUUxR?=
 =?utf-8?B?dW9LdjhMdGw4dk1uRllGUWFrSEl2YnNVeVdFVWRjOTZEV0VPTjV1a0F4SXJQ?=
 =?utf-8?B?d2VFUTB5K1ZldkpDWjRtcGxyMGV6TG5ySm5ZSzZHSFNaUTFWcTFhbzk3c282?=
 =?utf-8?B?Q2NOYXhNOTJ4eUZTQVNDdmtaVVhnTFQxelg5N3k5L0hQRzhUckhlSEF1YVF1?=
 =?utf-8?B?dkZmWGF2T01UVktuaExvT3lIWTdaN3UxZ0d6RDljRzF2M3ErbVRqR09kNlBV?=
 =?utf-8?B?L3o2V3kyeERmTDFwRitRc05sVktwTjV3cVI4enBDMklQTnFGOE9hSUN1Vm9Z?=
 =?utf-8?B?QVRTMHJsaVFkcXJXVkFaU3JBV1hzSlFublh1Z2I2K1RQWDJkU1R1SGpxTUdY?=
 =?utf-8?B?TkFvMjNUYUJxS0xYWDJxM1prQnorSTl0R0ZnMWtaRGVFMnAvOTAwRjF5LzhK?=
 =?utf-8?B?VzRoK0dXaWNmV3NsZGdhNjc5SnVVOUJDQ1VJbytMRk9ldTRvYWdjWVZpY0c3?=
 =?utf-8?B?N3d1SDlEYW51N2RPK2JoVUJ6dU5HQXNvUElpdU91L2R3RDlHWjBHREhNdlha?=
 =?utf-8?B?Vzd6QVJSK1p0ZW5yUk9TckhSTVhNOVE0R2hCU3htN1VCdU1MVWFIK0JWZWJh?=
 =?utf-8?B?ODlpQmorcFlrdnM2OGNaMjNNR2gwbHE3OUYwcTB5NGlBS2NMSXBrMDhaNzJO?=
 =?utf-8?B?ekhoRFEwS3R6Skczcjc5SlpuQW92SXR1NGF4NEZobTAzTThlL2pKbkc0SEw3?=
 =?utf-8?B?MTBuNGtTT1JTcCtnRitUOU5xWUdqSnlTc3AzVGFjYyt4L2xnM0Ixc1ZZSHR1?=
 =?utf-8?B?cmxYQU92RlNmVzlQTHpTbFZFUFFUdGEyOUwvZ3hmdEViVXJmUGE1T3lPUUNG?=
 =?utf-8?B?UEVlNHlvSlo0RGVyVVl0N09VYUxHYlR1WkJFQU5pdWRTVklrK3pseUVGS21C?=
 =?utf-8?B?bzBtV04za2Z4ekdzNE5ZN3dkcURVRGNhNXRKL1l5cFRUQ1JwUjNHT0d6OHVV?=
 =?utf-8?B?SUc5eFIxRXhZQUhOVC9FZVlaUmlpeTM0M016V0t2cEVFZ1gwZ2ZDQnlyVkNF?=
 =?utf-8?B?NkN5aXFGNURqOE1HbDd2Z0tlSEY5c2J5Z3NuV2owUnF4Smw2Ym5QTnpqN2RM?=
 =?utf-8?B?dlRCQjBiOHFxZFJ6KzhXQUlPL0YvUjZjV295cXB2VWw3dDcxR1FOWjV5QlB6?=
 =?utf-8?Q?8IoGAiKvRWpyf7aC1/IOexcUj2jkbt76JSUp+g/BsNHQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T3lwcWhuSDhPdytvQXRpc0lWbkJkWnhva2F6WXB0eVczc2YvZ201TGtJR2NT?=
 =?utf-8?B?eG5uWGpMMmFmbmFRanFUMVQwUkZ3YVQzQk5EUXRSZ3BJUW54RHhLdUljUWdL?=
 =?utf-8?B?Uk5Wa2Z3ZTcyTDhuUTl3WjZDcHNZbGR5ZHJLeHpqQ1E5ZndQcUovUjdDM3hY?=
 =?utf-8?B?VHJIeWs0MDRwQWhPaUhjanRORWlFSldFaTNkZ21HMEp2Sm9xM3dGWkFyZFJm?=
 =?utf-8?B?VVBPamNTL3lyL0hGdUllSDlaY0N6RUJtK0JoNVZUTEtVekh1aGd5RnZZeXJW?=
 =?utf-8?B?ZU1QTmMrcCt2V1NmYVB3ZEUyb3FFRTU1bVNQaURvK3RNNFpNTjFmVEdRV053?=
 =?utf-8?B?NmkwMTVSUnl0WlZmcmFFeHRVa3MwK3dNakloY3FaU1Y1VFc0THFXbzhiWGtm?=
 =?utf-8?B?MmxScGR0eE1mOGR3Wm93UG9weUVCUEJmMkRxZFl0N1UzSXNnc3BkdGVMRFFi?=
 =?utf-8?B?clUwK3JrZTZNQ0gzcTRONUZuamh1OFRRbUlic3FLb2Fub1Q1MXovMjVTMFlq?=
 =?utf-8?B?dUpHcUlLWEZBSjBISEl5TVNGRWdLbTc4T1AyS09sMGNNdHhMZTVKL3lIcGhR?=
 =?utf-8?B?enpnZ1lSV0FxRnpsNm9CNHhNZXpjdVNqTG0yUEZkMEU3S2VrSDk1MDFtQk93?=
 =?utf-8?B?NXl5YVkwejVvNHUvYWpWQVdMclc5NnNPcFdtU0xabGFNUFlqK0VodWdvVXZY?=
 =?utf-8?B?YkRERzJLUFl0OFRvcXNYdHZYZ1VrZnRPSTRPRVVCME1QclArN3ZGTnB0NktE?=
 =?utf-8?B?cFFxaWJiK0M0UXVRaGZDLzBnalMrbExDSVdNYWRyaStienR3cFcyK0ZvRGV4?=
 =?utf-8?B?amVmYXd4clJ1dnhleGFmZVhRZEh4UjRScnRwUXJBcWNRbEtPTWI0N0RlK292?=
 =?utf-8?B?cnNFUms0QmNDZjlrd3BnZkNxVHJvS3pidXV0QUJFbFFNTzluMnVzUHIwMTdM?=
 =?utf-8?B?Nkw3R0ErdjE3U3RBOWZKWURtdWVHUERLWVZkeDNyZkxDUnNGTmtMb25XU2tL?=
 =?utf-8?B?WUpZcDMxZDUxd2tXanJWMTNSaDRqelpiRCtYU3l6RzhzTERRRi85bTd5aUdv?=
 =?utf-8?B?NTVOVGJMdnk3c0tiRXBiOFlsSE9yU2dkUXhBdWo3dGp2UHdESHNQR2ErM245?=
 =?utf-8?B?L2drb1RSbXR6azJzYVBXNEFSaldNOTZ6OTNHK2QrQXc4S25sazJGbXVGeEpI?=
 =?utf-8?B?blJZUTMzZ0ZMNk5pVGhJeC9paFo2eTNVK2kzb0I2b3FXdnNXaTFpdjF0RXdX?=
 =?utf-8?B?WFdudnc2WDhzT2NOQU41YkcybUZuRE1mMm04QU04NEI5eGNmZTBhMXFTMGZi?=
 =?utf-8?B?L05oMUFOd0NnblppR29nekZjYVlvMnNvejA1b1hESjQzNHh4VXViaXlOVSt3?=
 =?utf-8?B?djdTNVZnTnVVNkM2WlhXVmNTWnBtYk9IODJNYXdDbzYva21pYkhydkYvOUs0?=
 =?utf-8?B?bUNFc0V1UEZ4djRRamw0eE5INm1NbzVueEY2RzdwbGlEdHJCRU1RWDRlL2Nl?=
 =?utf-8?B?Z0ZtT1JBR3RqZFRmU1hFZkN3Y2FtM3prZ010UWE2T3pDRTlyejJIVkh0REJv?=
 =?utf-8?B?QitCODloZFJoRmtObUdwWnhwK2lQK1RHb2dmNjQ4cGs4MGdUa0NvRHhOK1oy?=
 =?utf-8?B?M0VVb1JTalliUmtGa2YyTVQxTTNJaWF1b2ZmeDA3VDA3V3J5d0tzMFdjUFBV?=
 =?utf-8?B?Zy9ya0k4dzA0Q2Ntb0wyQmVxZUhReG1Ea2dacGlQWmZjYndKQ2RNTytGZXlO?=
 =?utf-8?B?MXY0QzBVYzMrR2l1MmJHTlc4TzZDOFh3QTNEaDJWYXh6WVhFRjc4NVpKTWZF?=
 =?utf-8?B?cFpnSGszWW5IN2RXYXVoV0tlME5zYkFtOTcvK29lWHFxK0xOTnBaSHpsckVH?=
 =?utf-8?B?NnZCbVhxWVVMOGRiN1Q0bVA1U0hvS2YyODdsaGdnWHRWS0NUSU1icVo2S3Jw?=
 =?utf-8?B?VEl6TkVPNVNjSE8zY1d2RFJ5WFVlcXppbm1yZmNieWllNmFBV3ZGVVFrenla?=
 =?utf-8?B?NFpkU0JoK3Z0S1JYMnY0WGdtcldBTUx5ZVR5ank5WmdrK20yZUhQY0gvYUVv?=
 =?utf-8?B?cFQ5WGpmdGZod1Q2blNsOWUyRkg4a2gvODRtbW9KOWdDbHFoSlFSdlJvS1A5?=
 =?utf-8?Q?ZiF6zGOg1+YXrEi7eWPQvTjH8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b68e3ce-c7aa-4338-0cbb-08dc637dc7ab
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 10:11:45.5015
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0/w3h91cyFjXbOZEisWlCdOhyIlKTe4JzHUSelqlfYdV0oPoLwBN4q3zsAkLODBotV/xbSJcymwiL7vdUmPntg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7627

Alex,


On 4/19/2024 8:54 PM, Deucher, Alexander wrote:
> [Public]
> 
>> -----Original Message-----
>> From: Hegde, Vasant <Vasant.Hegde@amd.com>
>> Sent: Friday, April 19, 2024 7:47 AM
>> To: iommu@lists.linux.dev; joro@8bytes.org
>> Cc: Suthikulpanit, Suravee <Suravee.Suthikulpanit@amd.com>; Deucher,
>> Alexander <Alexander.Deucher@amd.com>; Hegde, Vasant
>> <Vasant.Hegde@amd.com>; Eric Wagner <ewagner12@gmail.com>; Robin
>> Murphy <robin.murphy@arm.com>; Jason Gunthorpe <jgg@ziepe.ca>;
>> stable@kernel.org
>> Subject: [PATCH] iommu/amd: Enhance def_domain_type to handle
>> untrusted device
>>
>> Previously, IOMMU core layer was forcing IOMMU_DOMAIN_DMA domain
>> for untrusted device. This always took precedence over driver's
>> def_domain_type(). Commit 59ddce4418da ("iommu: Reorganize
>> iommu_get_default_domain_type() to respect def_domain_type()") changed
>> the behaviour. Current code calls def_domain_type() but if it doesn't return
>> IOMMU_DOMAIN_DMA for untrusted device it throws error. This results in
>> IOMMU group (and potentially IOMMU itself) in undetermined sstate.
>>
>> This patch adds untrusted check in AMD IOMMU driver code. So that it lets
>> eGPUs behind Thunderbolt work again.
>>
>> Fine tuning amd_iommu_def_domain_type() will be done later.
>>
>> Reported-by: Eric Wagner <ewagner12@gmail.com>
>> Link: https://lore.kernel.org/linux-iommu/CAHudX3zLH6CsRmLE-yb+gRjhh-
>> v4bU5_1jW_xCcxOo_oUUZKYg@mail.gmail.com
>> Fixes: 59ddce4418da ("iommu: Reorganize
>> iommu_get_default_domain_type() to respect def_domain_type()")
>> Cc: Robin Murphy <robin.murphy@arm.com>
>> Cc: Jason Gunthorpe <jgg@ziepe.ca>
>> Cc: stable@kernel.org # v6.7+
>> Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
> 
> Assuming it fixes the issue, please add:
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3182

Sure. Will add it in v2.

-Vasant

