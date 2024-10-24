Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2067.outbound.protection.outlook.com [40.107.243.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E0B14F12F
	for <iommu@lists.linux.dev>; Thu, 24 Oct 2024 14:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729780270; cv=fail; b=A+saqv9KZ1x8aSFKZdYx1/wHzkKzsVG3wyz4wOc/FOyLQRHgnyFWPFfOOO1H9068ZgI6Z/FV/sxZj5XYKUrkIMrsoZ2j2hKQ+08yYL2YaWud7zjQQ3TmSHeJKLpwoVT3Ck0OAccgneN0kejJ/3uTbZPfNx/foxbGBtlOetvUI/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729780270; c=relaxed/simple;
	bh=DL9av6XhCe4XnV4815eM61XgdpPMZDBIsUvUr32FCEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=V0H0ZRe3AtX5cy45XgSEFX5QU67Vt3iPlaL/9I5x3ZTpzEzX5t+N2b3Y2mdOZI38f+z5VpCDPK4CNMnrxXq5mAragF5b8XpG7dmZ+TCOFA3foYJinkTNvCIVUQ88Vjn4TJ7XozpMcTuyJugXAb/Tn27dKXvpIgSzor/yhYkG95E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eZb7v6KQ; arc=fail smtp.client-ip=40.107.243.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eZb7v6KQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YkZngUFqLR16L9FV9l8ODMRIMlpWtsMcrbTkoYxbe5p3XvL0qI+ql0w4yz9nwgEzdsiGPvqX1w2gzdRc1lx0pBRt6jeuzyfU3HPsWMZrcGXWdenM9ilzNp1SiItnxz2mvAk8H9SySre71UjZ8N214bWxjqm8+ZkoM3yPwdGkC9rrieXe4pE+cojy4pIGp7ri8KBpvetQ4/Q8QPw9TvjoETbVBVMNYVrSu1i8rkfaqbxiM4/bsNl7KEBdXnqetQThLb31G9MPCfiH5BMNZ94dj2XllnO70icXUIaiUHQrVOdvZBUVBf0JwpeEzKuM60KwZfAPKy21+fcq7WKb+oAaaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMxu1PaiVN46c/+1IchAqe4P59gJXoxyXIxXgMyqhKQ=;
 b=fvHwbiq6kMLTahuZMo1ozpa0y5Ad/IWh6JBZpPNm8gNq4byYzV0LT9j/ug264uqniJXhyV3GlS1TLkLbkcs45sgMY1h1vt97FtSgjnobSIormMwUv/eXr6scWCxrGve334a4cCttWVwGN1ehy+7M2U3D8kkQnX17l/KT8FZEacMVhAGsfrF21PlD9VS8zErjN3ESBO6tc0WR08D6VrunAYkIEr78pbqM9hFJz1tNNHmCn3q7ss1FnGfbbY4gtwaiZ+gsIaxLwIgXMz6PgnyZRvaqx22IV5uXmzjjNqOcS0xcE1BS0e9CIFEZ4IzwyWU7/JFgugT1XYYOVUOrHHfwpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMxu1PaiVN46c/+1IchAqe4P59gJXoxyXIxXgMyqhKQ=;
 b=eZb7v6KQ6jKyQ1RHzvIAYOIJoMI+vFmR7l93HgT6Rn3EEPNFuw71p5IUxW/sITEHW868Bj4Una0rzeWxgqBR1v1/heVaGO4LJEf0WO1EEsWGY816C6J1BhvPsc+T0m9ZW9Iuzm/JTmnYxcl6USKnNrHS+CHJo5FeuTU+TG5xUaE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS7PR12MB6048.namprd12.prod.outlook.com (2603:10b6:8:9f::5) by
 DS0PR12MB6440.namprd12.prod.outlook.com (2603:10b6:8:c8::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8093.18; Thu, 24 Oct 2024 14:31:03 +0000
Received: from DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5]) by DS7PR12MB6048.namprd12.prod.outlook.com
 ([fe80::6318:26e5:357a:74a5%4]) with mapi id 15.20.8069.027; Thu, 24 Oct 2024
 14:31:03 +0000
Message-ID: <2a3916f4-3162-4ea0-95eb-25e79325c4a9@amd.com>
Date: Thu, 24 Oct 2024 20:00:21 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/10] iommu/amd: Improve amd_iommu_release_device()
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: iommu@lists.linux.dev, joro@8bytes.org, will@kernel.org,
 robin.murphy@arm.com, suravee.suthikulpanit@amd.com,
 Joerg Roedel <jroedel@suse.de>
References: <20241016053501.97497-1-vasant.hegde@amd.com>
 <20241016053501.97497-11-vasant.hegde@amd.com>
 <20241017133918.GT4020792@ziepe.ca>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20241017133918.GT4020792@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0059.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::13) To DS7PR12MB6048.namprd12.prod.outlook.com
 (2603:10b6:8:9f::5)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB6048:EE_|DS0PR12MB6440:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d45b251-929d-44bd-af8a-08dcf4387ced
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?blVTVldCdnVoQWhIZGowZDhVeHJnRXhtQkRUeWNtRUk0WnE3MWU0OUJqQ3F2?=
 =?utf-8?B?ekhUWmp3SFBrUWdma3I1bFZCZWNOSkRaRm5sc0g1dG0wcGkwTlN2Y0RUenZh?=
 =?utf-8?B?S0hrdG9jMW9ERE5OcFlJSnJEblFHbVRaakhSMUhoS2lyM0hjT1JBS1Q2ZFF3?=
 =?utf-8?B?YTQzUCtIR1VhRXRxZnlsRy9yamRORGdrQ3VGeVMvU1NlZktVSGRlRTB3UlNs?=
 =?utf-8?B?R2ZxUzB2QW1LSnZlb1gyQnlYOXpTUXYzcUs3L29RNXVZOUZ3Wm9OZ3V4cWxP?=
 =?utf-8?B?ZTNENXVSMGNpblRiS3ViTUZWSCtUZVlwd0tvN0h6c01ydkc2dmdxVW9wWHRW?=
 =?utf-8?B?WjBRbmZmanUxRWdxa0hWWG12QVJPVEZicnIya3RsY2czWEw1Y3ZLaFNCMUd1?=
 =?utf-8?B?enZ1RHh4VnRVSTJNand4cnA0bk1SVHFoMEVUS2Foak9WY1pGWEhYL2FNOGdp?=
 =?utf-8?B?L0VrZjNEb001VGxxQ29SY1RNeUw2NENSdm9XajJqb3U4alRYbTZPQjlrUUI2?=
 =?utf-8?B?c1ZyT21XNHk4SHcrbmwycWhRQW5GbjZHb0dyd0ZPMkZ5VHVQdDhxbjZYZGFr?=
 =?utf-8?B?S2tlMGVDQXhrbFVGVk54M1I4dGJGdU5iM04xZ2FCMU45UGdjZ3U3Wm8yNTBs?=
 =?utf-8?B?Rit1aThPSWJoYWpYR2luWUp3SXRKUDRvanFPQm9qNjM4STlDRHhMV1pxZE4x?=
 =?utf-8?B?ZzllczZQMEhQY21oa0JMV2RmSUVrMzlNTUs0NkdFVEUyZklmSi9jRnNmNlVh?=
 =?utf-8?B?dTcwLzZZL3BENHZqN1dQdExGVllpYWFsTENxMnhkMVNDNmY5VzUwdkRWcXUw?=
 =?utf-8?B?MkxyZkN4aTlJT28va3FQRjlCb0U5UzFndzd4TnNMcHJCSHF5VE14d2dPL3Fn?=
 =?utf-8?B?YThOc2VpZEhseE95bXg0WXBUbGVNTjdjVG5KUVNLbDhTYS9FZG9jN2J2R2ww?=
 =?utf-8?B?Y3h1VkxtR3NhZG9xYzhBRTRvVEpJYU0wM2ZnaHZhTGZFSEtNdk12ZitVWGZT?=
 =?utf-8?B?cXo3RjBmdVRFN3BNSGRRSllqYndFcEFTbVJqVDVkUks5YTFyMTVaa2lDN2tU?=
 =?utf-8?B?SGtQdHpsR3pxc3EvZGpnQ2RHTkswQ3A1QVFrY3krQU1Kd3BWM1BRZjZZU1po?=
 =?utf-8?B?NE55dFVLaVB4RlBxQkxHZ0twR3FKN0cyMDgxYUlNckc0VW1Mc1pwMmJJckgz?=
 =?utf-8?B?emhqUFZlZE5McVE1RlFXRTFHQThsZE1yRW1jTVR5OFo0MXFIT1VrVnVxWURw?=
 =?utf-8?B?LzNPbG9YcUFlNWtpK2pUaUhxUG9yb2tXZmtMUkMxd09PcXVSelNuRWVwZlZ2?=
 =?utf-8?B?OUZQRVhRK1NTSHdhamJXOWJYSnVPWHVJRm9ueWhGd3JOMG5rUE5Fa3R2MjNK?=
 =?utf-8?B?RzY3cXdBalpVait6N1FibHo2eWJGelRzczdCZ25oS0s1L0w2ejlHOU1OQ1Vz?=
 =?utf-8?B?ZFNrV09RTVhicEs3dVlQKzVOaEdMeHJzZXE5Y0t0Ui9aY21RZC82d1FHczMw?=
 =?utf-8?B?YUJvcDZYdG11UUxFeG13UjVlVnBRNDR3b2xTNWlHcXJETkxmRWxmdXRicTN5?=
 =?utf-8?B?aENoSnZqVXJ6cHAxUy9PZFdYbzY2VWp4VnhCUDYxcWtGN1pWU2tMY3dxTjhQ?=
 =?utf-8?B?K2RHTVBETG9sOEE1OTFlbjR2T21ZNG03QWkzMnF1eXdZYXdFRlVwRWV4YmNM?=
 =?utf-8?B?WXcvdFQrZHczdW0xNUo2eEI5Z1pQYkpDMGNmeUlwOStGQW8yZFFHbTJsOEtF?=
 =?utf-8?Q?nzLwxvqGu4mI33/N8AOyjlYR2lB2CpvEfZ+zPqF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB6048.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TzI3SExOZCtmU05ReWs2VnNwT0d3ZW5DbjhqUXhjNDdwbmdXamdveVN1Ris1?=
 =?utf-8?B?UzkzbjFYVm9ab1FGM1lsVGc0Q0FjWjZ1aE9vREc0V2FTK0ZrdDBVeTFPS1Ax?=
 =?utf-8?B?b2RqTW5hbmxDU0RMVk1qMjlpRU10YWFwN0NQTE93SXpZWGl4WVE4NTArV25O?=
 =?utf-8?B?dlhqR2gyS25neE1yN25IcWo2ZkVpNmtqQVFIcFh0Z201WEJtTG55S2hFWWtL?=
 =?utf-8?B?SkwzdDRVSjFKWXZpUHpacHo5OVRBZDcxbTdidUZBeGprUFRDSG96V0Q5VVAx?=
 =?utf-8?B?SWxXU0tJZ3I1T3M2VFRYRzJyRkVXNGRIczhKUTRUYU5raDBFS05meGNObldT?=
 =?utf-8?B?S29iV1pBQklKWDVuNmduRHBkdlpqMDZvOUY2TTJkMVZWU2FLLzdpcVFDOXZC?=
 =?utf-8?B?am9QRjJucWk3UjhURVFQZ0RtU0JsM1k0bjlOL1ZaRXNBOERXQjliZTZlSGxX?=
 =?utf-8?B?STdocXV6NU83MXNkQ2d4M3BFRTZFVWJEa01kbTliOEloN1ZPMExZd0VkVHZi?=
 =?utf-8?B?R01GRTIvZy9tc3Y4Smt4d3ZwdGt2c1lLSDZLNmpSMzRkQmE3K25aYWxnVE1i?=
 =?utf-8?B?SGhTRzRqc1NNSklRYmx1Ky8rL1FJeGVXMHBUTGlBRC9hb3FyM2JtUzRaalhz?=
 =?utf-8?B?cVViN0JLRXhpUzBvaWp1VVZ6RkhYTXgyVjREYVBPRjdZNUkzdHZjT3ROY25r?=
 =?utf-8?B?QSt5V0dGTjdhQ1NvWmR2MXliRzM1VXhOWlVadVFBZlZjQUlmSXkxQ1FFaFM4?=
 =?utf-8?B?alNvbDFMTDdJWWxiM21UOXZhNDdlZHNaWUtUY2czNk1CTTNoQko0R1ExYlBO?=
 =?utf-8?B?Mnh4UzlGWHFOVHFmOHI2c2UyQWg4cmc2OXlDTGVrRncvUGtLbUNqSHZFR21w?=
 =?utf-8?B?YXEyMHk1MUdIdDVWVGg2RVhzQ2tTMFBscDNTWkI0L0ozYm9kRzFtYkwydmll?=
 =?utf-8?B?OGFvZStvQ2xtbXJuUlZGNXZqeXJPMzNBWkJWVytqa1dvOTlodnBmUU90Z1pU?=
 =?utf-8?B?MDFZRG9oMU1iaU9RcWtYeGsrVlptL21nWEhPeGxQdWYvcUowbkNTUDFIbWJP?=
 =?utf-8?B?MTE5RUhhc2VNRTdDRGJNZU8zR1NDZ0hJQlRRSmdBZ2ZnU2Vtd0ZXSjhxV1Rl?=
 =?utf-8?B?TmpMZ2d5VkhFVlVnWmZhc2ZtTzhJYmhkaGk3ZER5OXhadHpFY2FZYkI2MnBw?=
 =?utf-8?B?NnlLaVZrNEJKMjduK2F6ZEhHTG4zaVU3MTNMYkNFN2lkb3FWWlcvaFBlSWNt?=
 =?utf-8?B?S2xQaU1pN0ppdjZaRzNBY2w0b09PdE9hQmE4RFlpRW0yKzVHeEpwWW5TUUZx?=
 =?utf-8?B?U2tYR2lINWxWeVZiMnlpUXgxSFJSYUwzeHpYaW01cnJqK2FSMUVTTURVenpk?=
 =?utf-8?B?SE1JU1JkRzhLcGFEWS8wTW1OWVJHZmdMb0FleFpHZXBhZFIreU5jN0puYnlo?=
 =?utf-8?B?VkFUTkFmQVFXamVmb0xlRGhnNnQvdHN6QnhOdW80dDdGVkZUL0JNVFdPYVF6?=
 =?utf-8?B?Rm51alp5VzQvZ0xXQ2hIRDR1a0FiVTh4M3Bpb2dNdi9FaXIxZVUwMXVuQnR0?=
 =?utf-8?B?SlFJWXBoWkQ5aDlNZTlMa1UxUUpvR0M5MlNCVjcrckdvQktwWnlZejlvSFEy?=
 =?utf-8?B?VjRpRUFoakM3azlCdllGeGcrVFJpNldIQ2RRTnpyNVNMc1FwaEpLMXJtZUxM?=
 =?utf-8?B?WXJMb3Q2TkhUQjR0aDhHSjdzODBuYS9iejVPbTJocEExeTdOSnA1bnEvZTcx?=
 =?utf-8?B?QWhvRTRzaVVubUVKajJydkVKWUdEVUUyM3ZZYll4ZnNTa3FqY0RJQ0dlUmFq?=
 =?utf-8?B?ai9Oam5KMjl2d3VBeUdKZFd6YnV4L3pURkJJdkNSajlqVlFlbTkrOThmOTZs?=
 =?utf-8?B?MlJOMXQ2MktXUXlRYi9wUkNrZTRLZUNCKzV5WTdMQm44UDFNRStkaGdKZlRW?=
 =?utf-8?B?MkY5dHg2b3BBYmZWOVVXVkpIbzZENDZXY3R5eGFTeUVmTmNYcmgvRHArZlcr?=
 =?utf-8?B?Y21wVk5nOFE4eWdpU21jT0xjMHNub0NYRXpSczRWSjFxR3ZGblF2cy9weC9w?=
 =?utf-8?B?Y1lzQmxDQk5hdGlCQkluT2NVL2lDc1ZSZTc0amlXQ3R6Zy9qazF0TmRmQ0pj?=
 =?utf-8?Q?rlHKBK9fMU6gwHOc0ZKjHGlNR?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d45b251-929d-44bd-af8a-08dcf4387ced
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB6048.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:31:03.4646
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 12prnz4X2l5/oK5U5v8Ce6Cg7E/tWhE3VDpyTV8KuHVrgPYk2VgUpihnAAISvRMCf+sdpIWS0tWjgH1sjw/rUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6440

Jason,

On 10/17/2024 7:09 PM, Jason Gunthorpe wrote:
> On Wed, Oct 16, 2024 at 05:35:01AM +0000, Vasant Hegde wrote:
> 
>> @@ -2251,7 +2234,18 @@ static void amd_iommu_release_device(struct device *dev)
>>  	if (!iommu)
>>  		return;
>>  
>> -	amd_iommu_uninit_device(dev);
>> +	dev_data = dev_iommu_priv_get(dev);
>> +	if (!dev_data)
>> +		return;
> 
> This can never happen, the core code never calls an op unless
> probe_device succeeded.

Correct. Let me remove this check.

> 
>> +	if (dev_data->domain)
>> +		detach_device(dev);
> 
> This is also can't happen. The driver sets release_domain then the
> core code never calls this with anything other than release_domain
> attached.

I wanted to implement ops->release_domain  after this series. May be I can put
it as part of this series itself. We already have all the support. Should be
easy to add.


> 
> Suggest just 
> 
>  struct iommu_dev_data *dev_data = dev_iommu_priv_get(dev);
> 
>  WARN_ON(dev->data->domain);
> 
>> +	/*
>> +	 * We keep dev_data around for unplugged devices and reuse it when the
>> +	 * device is re-plugged - not doing so would introduce a ton of races.
>> +	 */
>> +
> 
> Yikes.. Sounds sketchy. Why doesn't any other driver have these races?

I don't know. Suravee/Joerg may know have historical details. I just moved this
from amd_iommu_uninit_device() to here.

-Vasant
