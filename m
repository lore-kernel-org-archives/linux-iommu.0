Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D611B0105
	for <iommu@lists.linux.dev>; Thu, 31 Oct 2024 16:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730391550; cv=fail; b=FAW5Psztv7i8hdCJwrv1upL1Yg5ietPCvXfE4nZKASdqwwWsUUVgyluEr9EjWeis9R/154cxSllpgGvqV4plBnF70XeRVgqUm+JRxWCYYQ/cbe2BceInVzBuwq8+1kTwIMhpLQwXlLAh36/T4gKcDC7VM38+wRw99iWwU4fV0d8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730391550; c=relaxed/simple;
	bh=9y8qTXcmUzvphbGniSmafheHLVWQRvb4POmGl1oHTK8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=h1FT8CcnEkHW5yhmUzixB8/jrBG+ZPxZZWfEDycnsGZ/P6Tu675jzwJEu4aYzbYhg9m4pCZWRktvxBU6B2N4BbQ1k/7lF4M1H6yD2JcHF98qMmsBmJxrJ9Msq02aYh+lcUIz/RKDxXyJvSebgYNP92824s7+Nl2xFaItXzvztv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=BIWfTZAh; arc=fail smtp.client-ip=40.107.220.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="BIWfTZAh"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gkBQwRnlL3nCCN0ntM89wog2fBSXhuib1xuAnweh2TGNsVxkwYd9s1LthrjMk5W1UiojRqAq+ygJKcBPnYZdoY0MaOgPq56KN/+E6i5Klz67y2iChZPUyUTU26eJLOHchPWwKDIhPGdFDNE7V53SQbJe33mxzAF8bv2NZG9BF+g57cMiYECxEA6hBLj53nqMjLZmZw2CwE7efKG1LHACAhOyzzDcl9UI6u+WazN9whHS44hAvB06X5MrLmAmjikS52pazMBVC7wQxTRA25/CAicMUn82fJthbRTl0MqUqVuawzi74u22ymieZT2SfPnmjxg+FhUXx+E4Q8B6eXGvpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8nGOUW/V8kFpZ9juw+FVAZ59pt8k3J07uM8gBksgbY4=;
 b=zWrl2wRu3x240lkfN6X3JBpmGtYCy+IdBHAZGOwDWDRUMDec3lXas/FdfTqHyaQ+09MoNYw/uvmicJ8QPPc42KslQ1Z9f0bBIiZx5c6bsaxwkvSVYNdBNrX7GI5RgGuSrODlxB2v1P9B6rI1JdtzohnYs8TPpIMZYvTAZlMbkOpCmYbK7QFJTL/eSiyRiJLyrk1lsdnAXxLXM68lkwc9cpsWU3JpFK8tbBoFvTJEvUqTdGVdVqWQ9Ja3PT+6aNH1C52l7kW3Zj3/FmQgZSz0k9llcYwHUylOtY0lZRL1BlWAxpJPgjIT5yYerv5MzDXTml2RSCL6mlTMB+DiRnEyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8nGOUW/V8kFpZ9juw+FVAZ59pt8k3J07uM8gBksgbY4=;
 b=BIWfTZAh6QxRRwxEJRpdaq5pwXH71LdQaGHVYwyfFFBlkdKypaU9T0cc5I3jLNMVsZwMPJ7Srt6wLqD73XNfqnSXU04kULKFlMXqY5JoD73M2DDaHNWvZrZFLqCK5EgcAlyGZGWps+N7qD0Ga229GUkJMxxVss8y3F44H4nJkiE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM8PR12MB5445.namprd12.prod.outlook.com (2603:10b6:8:24::7) by
 DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8114.20; Thu, 31 Oct 2024 16:19:03 +0000
Received: from DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6]) by DM8PR12MB5445.namprd12.prod.outlook.com
 ([fe80::a544:caf8:b505:5db6%4]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 16:19:03 +0000
Message-ID: <afe4a171-784c-4ca8-9bbe-d113f9e27313@amd.com>
Date: Thu, 31 Oct 2024 23:18:55 +0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 06/10] iommu/amd: Modify set_dte_entry() to use 256-bit
 DTE helpers
Content-Language: en-US
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
 robin.murphy@arm.com, vasant.hegde@amd.com, kevin.tian@intel.com,
 jon.grimm@amd.com, santosh.shukla@amd.com, pandoh@google.com,
 kumaranand@google.com
References: <20241031091624.4895-1-suravee.suthikulpanit@amd.com>
 <20241031091624.4895-7-suravee.suthikulpanit@amd.com>
 <20241031125306.GF10193@nvidia.com>
From: "Suthikulpanit, Suravee" <suravee.suthikulpanit@amd.com>
In-Reply-To: <20241031125306.GF10193@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To DM8PR12MB5445.namprd12.prod.outlook.com
 (2603:10b6:8:24::7)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5445:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b692bca-9915-4eb3-009f-08dcf9c7bc07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cENRazhHUVl0M2xBMmFyM3AwZU9ZM0ljRlN4SnpIOEx6Q2xadjFzMWR0MUZD?=
 =?utf-8?B?dlNnTUU4VUNyaU9KRXgzMXZ0cWhHM0E4MlpGWXhHVDFkVnhZZmxHcWVhTHZP?=
 =?utf-8?B?d3RpNlhuMTdwdENnSWVqUldmdU5TTzJXR1ZxVUlLRE5uNm8zRm9tM24xN3h6?=
 =?utf-8?B?SXQ5Z1lWaTB2eWhUUTZPLzczWksxSEdrZllBNE5xWlRUenFSS0MyMXhOU2Zi?=
 =?utf-8?B?QnJIdnFFVi9VZFpnNXk2VjlVZDQ2OFZ6d1cyeEF0MEt0MEo4ZEVmK3RyZE9x?=
 =?utf-8?B?VE5hb0pmWE5IOGlpaE4yK1VpUURnc1UveHp0N2hmVkViMm95OHplS1ZSb3JB?=
 =?utf-8?B?M1NTcXZadGNFVkdVSnhNb3hMcUxtcVR4eXk1WE9OUFEvSjdzck04YVZOU2dY?=
 =?utf-8?B?M1RaOTVHMGZNV2wvVGhKSnZKalBpTTI1ZFpRY3VIQjR0TTNTMzFFcjd1M09m?=
 =?utf-8?B?QnUrbEZsWUMwMU1CWFBBcTJNNFo0eWtlcEtyVEVVZVVpUnIybTVBaVRUVVly?=
 =?utf-8?B?SW4rVUdLZEdheHFCRUNDQ3Z0WHZyTzlIR2pIMncxNE9OSE52TWhKSHgwWWQw?=
 =?utf-8?B?cXZESkFlcm90RTQ4VkJmYm1rMkx3cm9ORW9FeUEwWW9lRXhtM2pMNThIYUFR?=
 =?utf-8?B?SkJCejdHdEZWUUxNRi8vUDc1RmtIZW1SaTExL0x1RTZwcWZpNXhOOTZoKzNJ?=
 =?utf-8?B?UkxYSmZmSEppUmNKYXNXNTIyaEJXNGpmdkJkdzBMaTIwdmwxOEtteWVQR2dw?=
 =?utf-8?B?ZnBqWDZmUXR3KzFadHMxTGo3eHgwc3ltSzhQemRQRU9oa2NsZSt0U2FwWG1q?=
 =?utf-8?B?K25CamNCVHRlY3FZMlFnS0pNbEp1VjdTS1hzVE5GRGk3dXNxTkpoTlhRYnAy?=
 =?utf-8?B?UThLSnlYVXBFTHBxT1UvUHRwaVA1QmZPRlpPTDZSa2FOQ2dWajF2Sm5XMEZD?=
 =?utf-8?B?Z2xPV3RVREFPVDI4eTVUUWlJQXNTRXNQczhjZC9ncVJNdGx4azZ0VHVjdGMy?=
 =?utf-8?B?ZTlFa1hJTlh6S01NL2R6M0xwYW9HME1IVnpXKzE4aTg5bUJFcGlOSnNZbkhz?=
 =?utf-8?B?ODFIeDNSeldydFRnODB5ak05MnJXV2FzVytFZ3VwcmJGVWV2Ymo0bld2cU01?=
 =?utf-8?B?UktzY0xqT0MvbERDUUdlOFNmZkRsSWpTMFRWcWlBbUViU1FtR0tTaWlyN3Rm?=
 =?utf-8?B?YUJ5TEp5a3BxRE9RRis3ZjYwMXdTcUFyRjlDUTFVbFFVREZadnNTVm1xemIw?=
 =?utf-8?B?azVSbThmUU5pdzJ4azNtcW5jUzlPWS9jY2UzUStMRnlNRVBIckRLaW8wNmlH?=
 =?utf-8?B?RllDNTQwSjcvQjY3eXo1UTBjZS9HN05NT3ZDUEVZdkJQZTlkZEpBRyt0MUht?=
 =?utf-8?B?Wld5eGNLV0dyaHRwNHc1SiswaE1BQjlMUlhhNmNPNFZzTDIxVjdCT2JJc0dV?=
 =?utf-8?B?RUdvSjk4U0xYY1E3dGdmczAvMVA1dkV6SUxQdlVuRVZ1bGxXeS9pSi9YMGxD?=
 =?utf-8?B?OVVtcjdUYzZLTlV4Y2pZeFNSWVFTekNmRGRoV3QvUzVnV3hwOUQvcURmOVF2?=
 =?utf-8?B?TTI3N09LYjgydHZXZDZ5Q3hITFd5Mi9ZT2FhTWFKMDErZG1WRS82MVZBYm9D?=
 =?utf-8?B?N1UvTklmSExzNXdRTk10NzNwZHoxZnU5U2tqOTlPeHVCN3FmR085Q3NrUlU4?=
 =?utf-8?B?VFhnWDVucWtzQ0RlRzlsVjFiZ1hCVW1OVW9PT2R4L2ZrWTl2TDRabUZMaTgw?=
 =?utf-8?Q?a9hFr9M00cKXGEoQT8W7bKyxWhnypo19HFNcJj6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5445.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q0drSWZEWGxqNDNZWjhHRDNkRUl0citvM1FYbDQrMmRVRnRtRVVzOTdycmtF?=
 =?utf-8?B?cGh1cG91TzFEaDVXNUliVk5heHBRRFpINVcvWVVFUEk4MmdabU1iVnFWY0Nz?=
 =?utf-8?B?TG5VQnBNTDcyM0IvVEVPZk1ZUjNxS1hFZGJMcHY2bjFTNm9sQVRZTjFnTCtD?=
 =?utf-8?B?OVBYeTlXWHBjVS9xWmxzSklYV05KL0h0VFNBV2tNYVhiT2dYUE1xdmNGY25k?=
 =?utf-8?B?SnRtc2E2dGo1bmMwTi9DWUk0bXhXTDhIREtwRm0yRXdWU1UwZWxCb3hmdXJl?=
 =?utf-8?B?Y1BUanRWQndDb0pRZmRUdk9ac1NZblIvZWlQOWlLUDVNWUpLQkRxMEF6RGx4?=
 =?utf-8?B?ZE04amQ2ekJjOGRiQ1dWbHFRd0gvTDRWUWZqRnh2bUdYVVFObFljREhWbGs1?=
 =?utf-8?B?Ukh1bExvZTBCNTBJSGEyM2htbDBpQzlpalkrcCsyS01GeUF4Z2orUXRweFR6?=
 =?utf-8?B?b2xZTCt5Z3ZSRDlabjdPMkgxT1VROGovWmVodG1lZW5yVk9ROUxwc3ZYM2Jo?=
 =?utf-8?B?OHU1V0xZRUhBZ3lLMWpUdURnWE5mRFV1S3kxTkxLQmh2aU01NEFsS3ZzZmht?=
 =?utf-8?B?NE5FQkN2Rm96Tm9aWWhzWEFTZDNwV2dabGhmczMyeXRrdEkzdEVweFFwRUhr?=
 =?utf-8?B?eDFWSjErT0VKMXovQmkycStubWRodytXaGY0Q0lGTlB1QkRVckdJSjVOd3FN?=
 =?utf-8?B?RGRncE4wSUdHd2dKZWQ4ZHN0RzRTZnprbllXSzJQNEFpYUlHRkM2Z0h2b1Bk?=
 =?utf-8?B?UXZybmwxTzFHSDU3dXVVb01XdnhocXpERVNMVEx5ZTJpWDZQcVN2OVFTQlNo?=
 =?utf-8?B?UnpHaE9wTURIVGJBSWJpcE5xN2xzVGpjWXZmZGpWTXRVcDkrTU14dDFlN1Rx?=
 =?utf-8?B?MGdPcnEwcm95aUljTjFibUdaQ1lGMEdRR1Z6UFZZdnMxTWRIcmxHYjg5RjhB?=
 =?utf-8?B?RVVXR2JqV0htWkFzN012TTR0cXBaZDBIOUkvdHg4c1FQcEdZeGU5Nk1XM1lm?=
 =?utf-8?B?RERBMEJpUS9vdjYwZFBrdXRzQkVvUWtUN2QvTkJUVW1EaC93TEJIZDZZQ001?=
 =?utf-8?B?cnNJWnA1cVBkWHFLdEdxOTBma2RBVUthL05QWGY5US9ZU2pTMDlQRkFnZ1RZ?=
 =?utf-8?B?dnhkSTJlS2xjMTRncVR5cUZyUDlWVDdPSGszOUhGc3BKK2tyWTM2VGtRZHgv?=
 =?utf-8?B?UmRCTTFTMjRscUhZV3YraWJRTVdpdnFqcFRHUzEwM2dLTG1BamdsbDZMOEgr?=
 =?utf-8?B?amxWOVJLdFo4bk9Bd2t2Wi9XMzZjTnAzS3Y1Q2V5Z1NUNGRCbkFSVFNENWRi?=
 =?utf-8?B?T0RFMkFoRVlTQ24vazVrZEJxRXp6RSszVWxSTnZVaFBIMFE2VFZhQ1R1Unk2?=
 =?utf-8?B?bmZYK2hIaThuTDJnNW9vY2ZrMUtqUXBjMEdEWE9QcXoyOE5NQjV3SkRtY1dp?=
 =?utf-8?B?S0dCbHdYMExmWkFBR05lM3oydmJQdXp4QWNZWndzMnFuSGZFV0tPd2FtbUtY?=
 =?utf-8?B?MVpOZEJsQlFRYlp1T1g1SUEvWjh3ZlUzQUVxMi9uZ0ZUd2o5Rnphb0xRSTgz?=
 =?utf-8?B?c3FsS1puRXV1Y0VFaTZvTTBWOVprWi9Kc0RRZE5ZMU1SUXR2U3FyNHp4aUpv?=
 =?utf-8?B?MXlHS2hpV29Fc3BPS05ocE5DWnZqWkQ2QzlsMmdpNG5FSGRrbnB6YnNsQ01s?=
 =?utf-8?B?RDkyaWlyQXZ1cS80SFJWOHdJTU1zUS9IdHpmRWd0ZHV5VTUvVnVTSXZZUTdu?=
 =?utf-8?B?T0lLa1RiMVBLZ2QyeG5jeFdqaHlaVlptT2QvMWx3RlFVOFZrQ3dUZElmcTI1?=
 =?utf-8?B?U3NhWlFxRlFlNXpWSEhMUW5KdGppazZXdUdOaEVCVis5K1JHczNFSVRQamda?=
 =?utf-8?B?WDJnTWRDVU1DWmhLd0NYTDZteXlXNjAvRVkrQWkwcnl4dWZHdnRtYWJNZnh1?=
 =?utf-8?B?R21KOVprblN3V005OTk1YUovMHBXNVpyWldmK0picysxa0xodW9rOEQvTHp3?=
 =?utf-8?B?ZnA4TTFubGpsb1N3NjJuSjJqR1l0VWxvRGVjRE4yazAveEJIN3dMOGhZUFV4?=
 =?utf-8?B?Zm5OUnNzQW1RUkJobGY5NTFkMEQvNVBqVXV5RzJDL3JXVnhKZGJqNEkrc0ly?=
 =?utf-8?Q?6+Gi8P1QUKo2VzFCeunSA/MR0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b692bca-9915-4eb3-009f-08dcf9c7bc07
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5445.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 16:19:03.2049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uuc4UoN7CBgFZUb3xY5XiOfLoeneWDdau578hmCKwnPAmnoV2hdltjSzP+h7mx+wwpDSnrSODaMO1g7BYQJKUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295

On 10/31/2024 7:53 PM, Jason Gunthorpe wrote:
> On Thu, Oct 31, 2024 at 09:16:20AM +0000, Suravee Suthikulpanit wrote:
>> @@ -1148,6 +1146,28 @@ static bool copy_device_table(void)
>>   	return true;
>>   }
>>   
>> +struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid)
>> +{
>> +	u16 f = 0, l = 0xFFFF;
>> +	struct ivhd_dte_flags *e;
>> +	struct dev_table_entry *dte = NULL;
>> +
>> +	for_each_ivhd_dte_flags(e) {
> 
> Maybe the list head should be on the iommu? I don't know how long it
> would be if it is worthwhile.
> 
>> +		/*
>> +		 * Need to go through the whole list to find the smallest range,
>> +		 * which contains the devid. Then store it in f and l variables.
>> +		 */
>> +		if ((e->devid_first >= devid) && (e->devid_last <= devid)) {
>> +			if (f < e->devid_first)
>> +				f = e->devid_first;
>> +			if (e->devid_last < l)
>> +				l = e->devid_last;
>> +			dte = &(e->dte);
>> +		}
> 
> f and l are never used, why calculate them?
> 
> Isn't (e->devid_first >= devid) not the right way to check if devid
> falls within a range?

Actually, I missed one line. I intended to do:

+         if ((e->devid_first >= devid) && (e->devid_last <= devid) &&
+             (f <= e->devid_first) && (e->devid_last <= l)) {

The IVHD device entry can be defined for a range of devices (range 
entry) or for a selected device (dev entry). So, a particular devid 
could fall into both a range entry and a dev entry. For example:

AMD-Vi: device: 0000:00:00.2 cap: 0040 flags: 30 info 0000
AMD-Vi:   DEV_SELECT_RANGE_START       devid: 0000:00:00.3 flags: 0x0
AMD-Vi:   DEV_RANGE_END                devid: 0000:1f:1f.6
AMD-Vi:   DEV_SPECIAL(HPET[0])         devid: 0000:00:14.0, flags: 0x0
AMD-Vi:   DEV_SPECIAL(IOAPIC[128])     devid: 0000:00:14.0, flags: 0xd7
AMD-Vi:   DEV_SPECIAL(IOAPIC[242])     devid: 0000:00:00.1, flags: 0x0
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID00]) devid: 0000:00:14.5, flags: 0x40
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID01]) devid: 0000:00:14.5, flags: 0x40
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID02]) devid: 0000:00:14.5, flags: 0x40
AMD-Vi:   DEV_ACPI_HID(AMDI0020[ID03]) devid: 0000:00:14.5, flags: 0x40
AMD-Vi:   DEV_ACPI_HID(AMDI0095[ID00]) devid: 0000:00:00.4, flags: 0x30

Note that the logic only store the entry w/ flags != 0.

For devid 0000:00:14.0, we want to get the dev entry

     DEV_SPECIAL(IOAPIC[128])     devid: 0000:00:14.0, flags: 0xd7

> Based on the comment it seems like you want something like this??
> 
> struct dev_table_entry *amd_iommu_get_ivhd_dte_flags(u16 devid)
> {
> 	struct dev_table_entry *dte = NULL;
> 	unsigned int best_len = UINT_MAX;
> 	struct ivhd_dte_flags *e;
> 
> 	for_each_ivhd_dte_flags(e) {
> 		/*
> 		 * Need to go through the whole list to find the smallest range,
> 		 * which contains the devid. Then store it in f and l variables.
> 		 */
> 		if ((e->devid_first <= devid) && (e->devid_last >= devid)) {
> 			unsigned int len = e->devid_last - e->devid_first;
> 
> 			if (len < best_len) {
> 				dte = &(e->dte);
> 				best_len = len;
> 			}
> 		}
> 	}
> 	return dte;
> }

This logic would work also. Thanks.

> (and it would be smart to sort the linked list by size, but again I
> don't know how big it is if it is worthwile complexity)

The list should not be too long (only a few entries). So, I think it 
would be okay to just keep one list for the whole system.

However, we would need to also add logic to check PCI segment ID, since 
the device table is per PCI segment.

I will update and send out V8.

Thanks,
Suravee
