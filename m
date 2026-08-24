Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 825833F7AB2;
	Mon, 24 Aug 2026 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593210; cv=fail; b=qVI/5s5CXM6XjpL3utCz2jhIKRiTEcKdDGvoMr0O62GuRI9qLHi7yTtkpCJCkb9TNUJe6ywyRfjU1YXYIrpfwzPSMRCRLhEG7CDFC7JXi63dhZtOo0EXDXnY1Liu1nxn87VUHn+utjch71z+LYNjKYhuGq7ZHhVR1DiUEzqx+kA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593210; c=relaxed/simple;
	bh=GcR11YXyOGhv9NFHgVmIYVewGTyLZeiLhaqEM3LxxAw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GM7XXaxRIoW89RSB8XTi6FZLF4qDx4YXOrRbdhwqRhtryZ+Zp1sYTSC3ZjmgW9h5LhvFwa1HTMWYwUFGPVLrRwm0TQ7nETAaqvbuvsWf84HpAyEoR558I55bdeeJLrnBfwLKVpO9L945+50E+dI4RQ1rQ9s8smoNb+S2lOBRE5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oZ6mOelA; arc=fail smtp.client-ip=52.101.62.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oZ6mOelA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vinsGQLtP5GotQKqYyokZ3Hz2bsFG3cAYPQQLqMB0ysaRwlaIUn93yJYg9Ghd0UWjk0nUs2gtKvUWE5BeLcWWME9lMyCrUpjZYtrfeC7sjD4x/aXyeg2R9dbrohZWXjwpha4Sli3dTwkHYDWosmUfAoilnWOcu63lzNqLQ4nDvs8MCVNfSdm8RPsQO95CLnaIFthXePmP7fgyYTPkJBijouPTr36oB1x9M56H79xdVcmLS06l7SBZ+bVWrptob8L2DpxXtR9bFqqOVKnyWt/MDDRa9lWpGiwZj3xpJzuMZq4FjMfCPMQO/TKdNEjkTQ/PMxg7VmRbbvJvwlhwH7T3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yy69JTXANbpacnoRgwXDT/HpLZGsuyIy0GB5rY4Wvcs=;
 b=ipQdfccn/EhxsnGiUQgAfEGhYYNDKpkR2t6NLA9dbBDK6P7zfUb2YmDrtgTdanth13/G+18zcenKK3GmALUBwIil0pt4bUUVsMYGWA9nPRSo72v0ANUM/Wi4l2z6tVDsU3k6VCrHx8p0poSTnJdzlhq2m4oKTISIKugrRyXE72FRWLjG9iZuMWW6QG1CFTuFJMcUxGFuzibrQ7q3xBFxhSeHHK4KrtBAdX4cKB3lMgmq8T0jMfr4Fi57PnUq2J5YFywvGE5+LrMuuwyNGgoQgTVTLzF+bbsTG1W6EY/VaXOTG5smLQ/W4ryH32smsGbLXF7BzhKMtHrgtwMKwWBF+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yy69JTXANbpacnoRgwXDT/HpLZGsuyIy0GB5rY4Wvcs=;
 b=oZ6mOelA5UVQZh/9FDisHKBImcUQ/GOR4WHfY4t2wfVxcRa2S/zusLt+TgBNQ4mb+4+W0kusHGvItizvNciEk3MEwO29jydcJIcT9LqkprAyraOIvqU80BgJ2v537vj34c3EmJZ+dOaaoxY/hbzxlw8csMgYihPvurLxcYVjg3PYeqZhMj+JR6VdHlJRclIuNkraOx/czuUsMkDChgAmgwYuSWqhMYOMbnS1nqrg34HQbeWwgs1GxQ5Cm9p3xVR/RlsxCHoH2OCHIQDsxMp0M0a3JdwN50/gUdht2Bl7XSz35ra8xECeUhmaLlvXikT/aCTT9u4xiWGjy6cYVtb0WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8728.namprd12.prod.outlook.com (2603:10b6:610:171::12)
 by SN7PR12MB8820.namprd12.prod.outlook.com (2603:10b6:806:341::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Mon, 24 Aug
 2026 17:39:51 +0000
Received: from CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7]) by CH3PR12MB8728.namprd12.prod.outlook.com
 ([fe80::2641:1046:bdf3:93d7%6]) with mapi id 15.21.0339.012; Mon, 24 Aug 2026
 17:39:51 +0000
Message-ID: <7c963219-6afc-4595-b472-b4c56c90695b@nvidia.com>
Date: Mon, 24 Aug 2026 19:39:45 +0200
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH] swiotlb: avoid double copy with swiotlb on tx socket
To: Luigi Rizzo <lrizzo@google.com>
Cc: Mostafa Saleh <smostafa@google.com>, Jakub Kicinski <kuba@kernel.org>,
 rizzo.unipi@gmail.com, m.szyprowski@samsung.com, robin.murphy@arm.com,
 willemb@google.com, kuniyu@google.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, gregkh@linuxfoundation.org,
 rafael@kernel.org, akpm@linux-foundation.org, david@kernel.org,
 netdev@vger.kernel.org, linux-mm@kvack.org, iommu@lists.linux.dev,
 driver-core@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20260615234220.3946885-1-lrizzo@google.com>
 <20260615172535.080cf94f@kernel.org>
 <CAMOZA0KAHKsvA9yRcdrjG13S+=rJhw-Cvnw2WdLjGGY0azG0kw@mail.gmail.com>
 <ajEuUZMgS_NRmDcp@google.com>
 <ac473a83-c77f-4a41-bc86-8a857d2d6e36@nvidia.com>
 <CAMOZA0LJ9qTs+d5Mg9CB1Pio-Kw1HDmuVSMiz=zUZdWFC7zqdg@mail.gmail.com>
Content-Language: en-US
From: Dragos Tatulea <dtatulea@nvidia.com>
In-Reply-To: <CAMOZA0LJ9qTs+d5Mg9CB1Pio-Kw1HDmuVSMiz=zUZdWFC7zqdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b8::20) To CH3PR12MB8728.namprd12.prod.outlook.com
 (2603:10b6:610:171::12)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8728:EE_|SN7PR12MB8820:EE_
X-MS-Office365-Filtering-Correlation-Id: 6aa8fb02-37ab-4ebd-0926-08df0206b31e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|7416014|376014|366016|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	zSh034ec2htCzMyWDiReoRjMpxgnZOPUP1att33YlzuYDvKCSbTBNfjb0k1TS7F0ExntpukLX1Iau+ovGSARZFm/sqcQFE2ZxPNpI4Gm23dl7zMplopEYMqxv6CsMPgotnazUYHct6nZ7EFy8USrE0Qhh4NNorb66BGe/lPH2+SPI98gQY+7zY0GyDW3PPiu2DDUH1Sc3F0q6F2+RZuuzTyhHo7bz32HrEWobvh8jxfLpoL8pqV31rArz1wXds+eQVPDuY3Pw+UtPaHUdvj9VxU2SnmL6Z5gO2PbFAmOW+vbwOBNvcHEW1evxBX+3tmrZg59v5UKTgTVRhZ2ikATUxS4iBkplTI4q7i+wnNlbGqN/Yb2Oya/p9t/qKevFiBuTV9/Uw4wwtgKoupTqpdzhdN6qPIjtK+QglZILD5rQDumZsL327D9aS2tV7I83zFR4tF06QXbcF66qRNnRQgug1lY7cvNEfB7U7aRqgPvSjq7RsXnK6qXJJ4mug9FayiIG4siANefiBZX/hfCY4LL7wgYziZZbpO5MldVvZxzNZpqpD0dtNcCuaqfP9ESqjooI88AWjw2UxqmNMWk4GVp6E94/+0hlflYOKXwf0Zd4VZB8k+XBLCSdrP+FhEDX3Cq8wnuhWdvw4SzvF+Axn6uxTqgwefwKj3VyVLpRjJRq0w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8728.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(7416014)(376014)(366016)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bDJwZ010NjYxQUNuQUx0dHBHcnNKWUhVTEFWRHQyV3JIOHZ1WU1sSjNoTVhH?=
 =?utf-8?B?R2J3cm1tZkEzY1FiNG16c0VMY1psbDRsZVZZMk9mbXN5OGtvd0V5emlOcm56?=
 =?utf-8?B?U25KbnBlV2x1bElHVDhjeDNLMTF4cjJRL3d1bDJnNFVrY3REZDRyL0FNT2NR?=
 =?utf-8?B?V0ZPS3Ztd1QyUHlvd1ZXaXJoa3d1VlpNWU9YZGIwQ1pORVVUTkVGV0k4K3hU?=
 =?utf-8?B?Yi9iTkdJVHZoRVZrTUd6SWJRSzVQb0tMbWUwT0kxZjlJZ1NqWDdpNUtsUWNJ?=
 =?utf-8?B?ZGxpV2JTbG9GaEVDbkR5QWh3TGFvT3V6TzBkaGJkVE5ONndPUjhwMXFXbXA5?=
 =?utf-8?B?SVVOK0NueDl1ZmU4UjlCOHZUSjRjYTE0T0JidHFKVTlTYW9nQmRjT1d4MGcr?=
 =?utf-8?B?ZjZPNTVqc2c5K3Bld25wMFdva1R6aXhBQ1BTMzMrUmxVemUvYWNYR0NJVkU1?=
 =?utf-8?B?NVRoeFJBZDRtaFYzcHZkUy9FcUQyQ2dJeWtnaCs5UWk3c2NtUzJYcE03c1Qw?=
 =?utf-8?B?MjJCN2Vpb0dodHJ2NjBVZGo2TzNrcEg0VHpHMStUVmZ2Yk8yOC9jOXh5NGtw?=
 =?utf-8?B?VHpQTVBrMmlMV28wT1FnL2pLUkcwdGY2MHhNK0hRU04xVG9aaVZ1cTdzVUJm?=
 =?utf-8?B?L0dMaXVxQ0V1dFlCcFJwaTVmTUlPVEtURWk1U1FqREhEa0pvekZBVmhmeW5u?=
 =?utf-8?B?aTk1bUNDc05nN0VZdThCbm9oaXRwL1Z1Um45WmdKczlXdm5JeVQwcXRsVW9M?=
 =?utf-8?B?NzdYTDc2aEFpVlZ5ei80OHdOWjFaR0pvWmlDMjArdVAwZTNEUit3SlR4M0sz?=
 =?utf-8?B?UzZ3aTJrcjlCNUFWZXFSVURoQ1NsekhReVZ5RWNaL2VGRHJpNHZnOWpUc3Yz?=
 =?utf-8?B?eEVPS0UyUlo2WVNUMzl5R2ZyOSt6M3NqeFN0VDRpU2twUEVZdHZPckIwR3VY?=
 =?utf-8?B?eXYvZGRLdnd1SU1jZzJBZGFFalMxNXh5ZnB6VUdCamxvNUxJOFBBOVdQSGNk?=
 =?utf-8?B?VHEwRmErcXBMcUVJSFRpUEs2SmI5WWdNcXlYT3lLLy9IMFQzNHBJeERmOEwy?=
 =?utf-8?B?RmV1OWNoSkJNRWxDQWdacXlFeTdkOWxLMkNkTHozWUtqdTdrREZrd2ZDVGVv?=
 =?utf-8?B?UG5NT1E3cnhxaEV3V0lCb0E0dm5TSnR3ZDVPNWZzVjZucVg0alROQUF3bkU2?=
 =?utf-8?B?ZEQvcDloK1hhTkgyUlpHVFYvRW5uZUc1a2d0SHlzei84RVo5T1NIUE1SUURL?=
 =?utf-8?B?WUdqaW12NC9oVHM2dWF0dXdsZksvWWNmMUdMZEVyUGpYSktVMXBuOUlHYWRV?=
 =?utf-8?B?SWJIZ2ZLV3NlY2dScEJNRXFjb051R1dLcERqRjltVkkzR29oRlNibTN1dDJy?=
 =?utf-8?B?d3didHlIbkY2dHdCb2FFd2lEY25uTmZzZWlqcDlDM25EaXlUdmkyT2RMR3B5?=
 =?utf-8?B?bER1NXhVRWM1MVdCQ2d0eFVqSEtqU2FrRjJUbGdiZXRkSmpiZlZhdFZCWnl0?=
 =?utf-8?B?VUduNEp5bG9WWU5jVlM5L2dkSVlnOWxJRGNmOWpTSHFIV1R5OU1ybTlPSWtO?=
 =?utf-8?B?eXRHY3cxNEJFdWp6ajMzdzlDdytHV095dWRUcTVwZGl5b0Y1WFhQTGozWFBU?=
 =?utf-8?B?Zm15T1VCMnNySkJSZVVTTDdwZ3EyRjFYWDVhNXZWMHFMVEJmVmJ4bGdHY3lv?=
 =?utf-8?B?azFEcnp6eGt5Z1p2MDYxazcvc3RYVVZ6UzVDaGYwcHl3di9jOGwyR1MzZjBT?=
 =?utf-8?B?ZDVZSmc4VHdPQ1AvQS9PT1ZHeTVETWJGM3A5QXRWUkVzdzBjVS9rczlJZWVT?=
 =?utf-8?B?aXFlMWc5dGc2MVNZRG0xcjl4L2xjemp4c0J5cnFSdGtHM0loQzlPUC8wbmVM?=
 =?utf-8?B?T2JQakVDRjN1UWVNallONEpUUnZmNHZ1K2tBOGYyeUlNUTJEUkVIaHA2VFpX?=
 =?utf-8?B?VmNzdzgzRy8wMkRPTG9DN25HRzVRbk9MZ0RDNDFwMUxJNXNuNGZFVGhUS1pp?=
 =?utf-8?B?NWt4RnhaMkNiKyt2UENSaTBHMk9iaFpOZmIvWlJiV3dWa29sMzAwQkVYYlpL?=
 =?utf-8?B?QUdCTkZ0SjE4MTlaZ3FkTlI4cForRVpZcTl0S3lTd2RtU2hqc2NJWGdLUUQv?=
 =?utf-8?B?cnRleEVCOUdZVkgraWc3by8wZ3BNVXo5NWFYT1FBbDlGbGNpR3lxUUtiQ093?=
 =?utf-8?B?Ri8wTVFhUXFKMEROM1Z2VmlNL3hmdzVRWTVjUFpWeUhUSWhjKzlkQjJodzQ2?=
 =?utf-8?B?d1UvQjlDSmxTQjFqS3gvWmYzb2pEb3NmSDE2TVphaTV2d0dwMkxzT3padmxG?=
 =?utf-8?B?VVo0SWtRNysvZjgyalJGR1djNEZHckh1TFN1cjV4VnJ6bG9UNitMZz09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6aa8fb02-37ab-4ebd-0926-08df0206b31e
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8728.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2026 17:39:51.0123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P6KjGrZaaNdICWHQaFk8MKfolZ9F2W9fMqCF2Og4fpLjfSnhQcJEcGS3VdtR3KLpofuv8hn7FRDsaT8QC0yu9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8820



On 24.08.26 17:32, Luigi Rizzo wrote:
> On Mon, Aug 24, 2026 at 10:59 AM Dragos Tatulea <dtatulea@nvidia.com> wrote:
>>
> ...
>> An example of this is Jiri's system_cc_shared heap which is a dma-buf
>> heap with decrypted memory for userspace.
>>
>>> I am still looking into this, I was planning to bring this up in the
>>> upcoming LPC.
>>> I will give this patch a try. However, I believe that we need a more
>>> generalised concept for CoCo pre-decrypted allocators in the kernel.
>>>
>> There is a talk at LPC in the networking track about this [2]. This is
>> exactly the type of discussion that I was hoping to have there.
>>
>> Besides the issues mentioned in this thread we've also found that a lot
>> of overhead can come only from swiotlb allocations when running many queues.
>>
>> I will add information about this series in my talk. Hopefully I will also
>> have time to add some numbers for comparison.
>>
>> Sorry for the late reply but I spotted this thread only now by
>> accident.
>>
>> [1] https://lore.kernel.org/all/20260325192352.437608-3-jiri@resnulli.us/
>> [2] https://lpc.events/event/20/contributions/2464
> 
> Thank you for the feedback and links.
> 
> Do you have some code describing [2] ?
> 
Not yet I will send a link once I push it somewhere. But the idea is simple:
a driver side alternative data-path which uses pre-allocated coherent DMA buffers.
This doesn't make memcpy go away but eliminates the swiotlb all together and it
reduces the DMA map/unmap overhead.

> I just sent a cleaned-up v2 of my previous series, if you want to try
> it please use the latter.
>
Thanks! Had a quick lock and wrote some comments.

Thanks,
Dragos
