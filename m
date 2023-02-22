Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01olkn2043.outbound.protection.outlook.com [40.92.64.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D258929A8
	for <iommu@lists.linux.dev>; Wed, 22 Feb 2023 19:31:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iMTD4Zf+u6/KmvgJ9WmpaqcZtSDB/lAXNa2FMjxgz5EiodUfUn8PYiTa7UAW8VIiQOc+3iLtV3M/FJhgNtKbpheh9gj/47u2YHVitYK2HQkZLrW14hvkQwke85FjgmnROz5zizWVQ/beZkH7Iy/nSGYpirXMEu3V3BKPKUIngoSK7VHLaA0p5O3+H/ONPWzcP3HwGeBMMUYHl2r5Z/goxcyydJUIigyIYpjC6rI2VxxXcNvE/1kCuvLKOLolNkkxRgLy16oRm9srHC0Zsd3Vm3mTTmVI8xWODrwqS8sSw8C6iB08lqN2IEdmvCMx5TvwC5j5QwB7f5TmxXnb6ZwDbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvs0fyO2aswKMoKsdvu+1xpbB1U9q/W1CErvX1L/ebo=;
 b=ZAWIkx6VOIo/HongEMEebB6ZZV/mJrl7tcwJeKf70EthrKQg+v7weDZiS3IEymRdzumyIResagK1TC1OappN1cwBsXEiNU8//9Np42P0kUZpTafG2OufZ4LE31FxBxsrj+w0Fnsm1+wK6zlMQUVXaqaVO7h44480zAtgDc+6cr+vjMcrXkAn6qQOhanotd6dBUlooSv9ep1gyz+Jjwnv/QrLwb6ISDNIkSRV48Tx+DRQGZTUz7i4EY/LOSTAXIAyT28+oKllgcM4xTyyAdCN/EJAkejeHkbHWH/LCDaGLBCiy0S7Vbeqou0VK5anu1lP0EGnDRvNh0lpZhoEjbGoEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvs0fyO2aswKMoKsdvu+1xpbB1U9q/W1CErvX1L/ebo=;
 b=VYLpbOJKVYM0AMMbp86ozLvHU6kj57YHOKiv3Rt+e+qXWL9wZQv6LCaJk4nPX7IEF3KzaK8+DdvnUhjWvOJASpaxkkhY2YGWYdLGrQ0RiKqdL8os6W/Fkd1rfijbiLSQFHvWjQGSO9fvPvpxfY6zVsks3oUa/Mi1ofhXNnLL5hRceJ4q7uo7c9Sk5q8FL0VLTFkw7Gtkb1yCv27tQjSuDyPcdpkSbnhVf1cNqFm8oeM8ckBqDoMP+hOgKDZblaZRCYUGpMXpyzBCxJAxWHNWIOL2qhzscgDm7uTYGGS3CPgwUHCZyRycc/dSZj4nLYxnHH9qSaG49qt+FMSXS0kfyg==
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::16)
 by PR3P193MB0846.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:ab::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Wed, 22 Feb
 2023 19:31:28 +0000
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::a948:f3d:75c5:1a0a]) by AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::a948:f3d:75c5:1a0a%6]) with mapi id 15.20.6134.019; Wed, 22 Feb 2023
 19:31:22 +0000
Message-ID:
 <AS8P193MB20955442176F3BFFB022CACAD2AA9@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Date: Wed, 22 Feb 2023 20:31:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: SR-IOV on ARM64 system with SMMU
Content-Language: en-US
To: Robin Murphy <robin.murphy@arm.com>, will@kernel.org, joro@8bytes.org,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev
References: <AS8P193MB2095640357779A7F9B6026F8D2A19@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <c8366f3a-3eba-6a54-558d-c87350187793@arm.com>
 <AS8P193MB209596DC2B89931C57C565BDD2A49@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
 <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
 <e182594b-5cdb-881d-59c8-a20dc90b62fb@arm.com>
 <PAXP193MB2105A8519929AD3E4A508F25D2AA9@PAXP193MB2105.EURP193.PROD.OUTLOOK.COM>
 <28ef1727-161d-1165-3878-08f7534f6e47@arm.com>
From: Martin Bayern <martinbayern@outlook.com>
In-Reply-To: <28ef1727-161d-1165-3878-08f7534f6e47@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TMN: [wNt03fAj55N2nUswgnlpXsbWF8BS7s2S]
X-ClientProxiedBy: MR1P264CA0157.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:54::16) To AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40e::16)
X-Microsoft-Original-Message-ID:
 <f8b1dbc7-4242-78ff-803f-5bc6a7797ccf@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2095:EE_|PR3P193MB0846:EE_
X-MS-Office365-Filtering-Correlation-Id: 33a90388-6909-481b-8631-08db150b6148
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	oni4DHRAjY2y8qSxxBR3P9iSI3L4Iv7VLL3HycFpSPYVb2NWw5adpasoeCXeDXjQeadhwad5lWdia94PZvVpxcBDwSvlShNqVHQUrLoo+m10BQuCd7XMGNrj9FjRbxWry3FtphsD7mD5HE/UV6mz6V2REuWgwTlzM+SigmMXFUQ+19LIjanfhmN+GPaV9U0l87wUxw8tu4JuznQ7B6X6rtm/YvC3T9kaG9ml3Y66bZLnr/fgXxTMhfAMOrq8tqUeim2fNON0d+UiUaEF9gR0pQTy0q/xADqg8o3zv+FNREvTz4FyYcoCFqiS48EpYaU681jbrg9Wsfwe6/WpqFET2XGsQRkG9gWTwah4PuhXzTBQ93m8cAglZ1eT4jCbn+ROFYTMtf1Gx+/RS5TcnRlyq3Sb7sat+MmDAJIXQ5Qc3NjSMpBFibP2VNQd8i44JdMzSJZU7i2ajEScfRY7ODmTwfXvHsfWs1xCgyTA3i/tSeZX+UHuemR4/rpVhjklMkCoaOBPrhklYc7/vYEcz6KevQHblIcySAplw77w/VS5fWI90/rymP5l1ODxXUJcXvzc+X5CgdKeU3cDYTlveDJsAOcxJsNmG3cK6hWaV9bD9bEmg1vriP6cX1vOrj2tkcrsQ6GQDisCRBcAZhIt6sDRFQ==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEdsZlFYNkZvR2ZKVnRrVVhoRzBzSmhKcFpsRVpMM3lqUWpSdGxSVWR2SkVz?=
 =?utf-8?B?bWgxS2dLQytOeWU5dzUrZ0ZXOTlWZ2R3WDYxcnJSMmw3d3grNE5BQm84ZDM0?=
 =?utf-8?B?V0MwT3FrcTN1N09UUThEU1BpVmd6MDQ4emt6YTZTSHB1eFhoN3BhcTdVdis4?=
 =?utf-8?B?M0V3QnJzS2hncGRyS2I3QW13dGJMemF3SmNSOWZrcVFuNWxUZWtwTFpmb1Rp?=
 =?utf-8?B?U2NwOG9Jd2cwdnVXaW1Xbko0dEhQeVJrdkEraWdyRWFSYUxRdFF3eHorY1M1?=
 =?utf-8?B?aDBMV1hGWHdzT3NyWUR5cXUxZ3FCTGZmWkVjdE5FTVl1dGt2SDd5TWxjRGV2?=
 =?utf-8?B?OEJoeGZHdDZ0WmZMdktlb3ZVa1RjRVZiaHk0MXJ5VTdGVHhPRGh2cFVGV3Av?=
 =?utf-8?B?S2pWSzk3ZUFseUZwcERKOVlpTTNDd3RDTXFSVHFVN2ZvSytEc3dBMjBmOTl5?=
 =?utf-8?B?cWxZTTlRM1ZXYng1dm5UYmNWWXZTS005a2hlL3pQNXlJR3FsUkxuU24wZGt0?=
 =?utf-8?B?K2YvTFpaR2ZkTCtmdC9pUFpPK0ZRaWdNOEFMSi9zRE84RnpsMHNJaFMza1c3?=
 =?utf-8?B?ZS9tcTlNam9lZlhZTmJoUCtiREpmNkY5eUk3dzdnRmlLbnpWRUNoYXE4enZ6?=
 =?utf-8?B?SkJ5SStRRk9Pa2tiTnZ5cW5uN1hFN3RyRTZZeHlGdDBSUUlJKzhBZDZ4b1VX?=
 =?utf-8?B?ZHdIU2t4bzg4ak4vOU1jaUErOXZla01xU01lV3pzYkZvT3NXNzhSbGQ1a3Vl?=
 =?utf-8?B?bEhjN21mbVRpMGRJcFFKWkdkVE5vTzYrVklXdjJkb2xCLytXeEVZeVhueTFL?=
 =?utf-8?B?Nnl2THRHWEhNYUVHdmVsRlc5V0tFcHQ4QitsZDFWOWp5cm5GVmxRcVE1My9z?=
 =?utf-8?B?NTFYZFhDU28wQmJpcjVBWEIzdWVockhQRTZ2TjZQa2RoUnovM3NNdkoxdWNh?=
 =?utf-8?B?OHhST21TNFZxbnp3UTM4V1luQVVpaEI0aFVMK3VLd2RabzRxRXhVR01qZ0RE?=
 =?utf-8?B?bWpBS3hQak1yckJlUEg5ZTJHTVM0NTYycjVUY2tDUm9aeTgvQ2tGaHZTYWwx?=
 =?utf-8?B?c1dJQ2JZN3NDRGpQanpyaWtYQ3MrODhnUXNFTmtFWWtrV0c2b0RWQ3cxbXV0?=
 =?utf-8?B?ZXdaME9aUHNpRy8zR1VyaWxqRFIxRXZyS2Rwd1BYR0liRzNzUTd6S2tvRkE3?=
 =?utf-8?B?Wkx1Tllwa2U4c3BnODN6ck8zNndqVEM1ZDRiYmRrYktsT005WTR4WUN4MkJN?=
 =?utf-8?B?TDhBSUlBOVVoMHFLYTY2cjhQelR0L2J3amZFUmtEYVp2d0hpM3VXSVU1N0tC?=
 =?utf-8?B?a1J4MWVYanUxaktXbG9XVDExL1hiZUJpUzk0bFpHekdKVG9jMHVJaUVTNUd1?=
 =?utf-8?B?UzFwM3pOQlR0bkplcXkra3hDejh2NmkzckFnUWNoVlBIYTNCdWI3VVFPT1BE?=
 =?utf-8?B?eUVjejM3S3JoLyt6bEFwK3RhSFgvNUl1VHROa2hPRmdhdG9yWUdhdHFlMGxM?=
 =?utf-8?B?RnIzMHlRQ2dSOXh2Q0tyVDBPckdKTjl6dzU3M0NreVpzUlZSZHZ1Q1RUREpO?=
 =?utf-8?B?QUIwbERkeUVlZTl1dGl4YlpRNjRxOG5mTlhRNmFnUzUyUjdJYTh1aXFWT2tJ?=
 =?utf-8?B?OURpQXdKL0prbllqL3lQVmM1dEpWSG43NW9Nd0hoUzd4ak4zNkp6YjhTWEFn?=
 =?utf-8?B?VVQ1MnFxb0E0S1hRclFMU3pTaHJMNFlXRTZ2Vy9YN1VSek9vdjJMZDQ2U2ZX?=
 =?utf-8?Q?BFLigTswt5xQBTuLfg=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a90388-6909-481b-8631-08db150b6148
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2023 19:31:22.8866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0846

On 22.02.23 1:38 PM, Robin Murphy wrote:
>> hi Robin
>>
>> Thank you so much for your support on this!
>>
>> On 21.02.23 8:30 PM, Robin Murphy wrote:
>>> The only actual solution to that problem is to make the platform 
>>> device not be in the group to begin with. As mentioned, that is 
>>> presumably because the PCIe node in the DT has an "iommus = ..." 
>>> property (not to be confused with the "iommu-map" properties which 
>>> are for the PCI side). I'd expect you could probably get away with 
>>> removing that - the only reason I can imagine it being functionally 
>>> necessary is if the root complex has internal DMA engines that the 
>>> downstream kernel is using.
>>>
>>> But yeah, by that point it's arguably just an exercise in achieving 
>>> satisfaction by making *something* work, rather than a really 
>>> practical prospect
>>
>> I search the keyword string "iommus" in NVIDIA Orin/Xavier related 
>> dts/dtsi, but there is no iommus attribute node, nor iommu-map. 
>> Relevant questions have been posted in the NVIDIA forum, and I hope 
>> NVIDIA can respond. Please let me know if you have any other 
>> thoughts/suggestions. I'm currently working on study of the drivers 
>> of smmu and iommu, trying to figure out the root cause of it.
>
> That sounds like the properties are getting added dynamically by the 
> bootloader (or possibly an overlay), or it might be using a DTB from 
> some other source entirely - I'd check under 
> /sys/firmware/devicetree/base/ at runtime and/or decompile 
> /sys/firmware/fdt to see what ends up actually passed to the kernel.
>
> Unless the downstream kernel has made major changes to the IOMMU 
> logic, it's the only way to explain why the SMMU driver would be aware 
> of the PCI controller platform device at all. 


Hi Robin,

Thanks again, your interest in this topic is greatly appreciated! I 
hope, I could implement SR-IOV on this ARM based system with your support.

Might be an overlay, I'll double-check and get back to you asap.


Kind regards,

Martin

