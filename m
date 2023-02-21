Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2046.outbound.protection.outlook.com [40.92.89.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873E26FC4
	for <iommu@lists.linux.dev>; Tue, 21 Feb 2023 17:27:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W68hDxXPRohYnsWwHsYvW/K3jhXiY6IOVB+v1/dmaUYNQocpscTgEJKewjCzwpkk3NAbH/YqriI7bEwxPaS99ZguHWAEVu9AEDCAktgnJKgGGQt0HsKtEpOemgowrDUz07NTvHm1spcYasvPlj4PhXoeBrWu3fb49vqOFmtqD3Spp2AG/tSA0pJFHDuLgbWrijvtByG5Q7p9q0Mut/cVc+MYTWWjFdfLMUrjwxeF+bBe82iEIIGs6ygcrmLNEb3WhoqGnd+8AOY9mzfjRQMUMvbM6pAFzkkzjmAEzYNC6u5+xlfTsy4sm8LoltNTLlGlafnK55GiGk4PT7bb7KorLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UODAit3Yw6HQRQHt6NE+acmNU8J1r4pwhSTsECvd0aM=;
 b=NvBlUW9DO7rF7pUQeJffJoy95D+PKi/PrOc4EZJZeX3nkH16mtmyM6sJEjQs1Lq5gDT17ZJVwwLigfYvLrvQgE79lejC5LF6QwatirkjKLWAEnlPx0XbHW8dJwOLApq/hsI3c+QIm7PThd800xFqgNP0AMhFsMDp+QVzsaPRYn4nkeOFXGis4RFmRFAy320nrOprsRggIbmdBYhTk28X5z+k9+L4jmUvUB7aKQfbxFEffIP0qF9FwmuEO/SvoFklH+TWRdmbA0qO3FGdC+WtefN9k8GPyvpW6q1rAYhy3J7/BawzkU9BejP1gnOIy5sNifZRLlF0H9Rw1REYh1UCZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UODAit3Yw6HQRQHt6NE+acmNU8J1r4pwhSTsECvd0aM=;
 b=CBJEYdA6ZCZxxZ9DrrQ1a0jRO7po+b1COWmSmZDILUAQmw6GTjRUNp/4c5uIDbp45m0ZHlKCbnT7zzO3nLV5U/WIoyj8l8jPwsRvXnieik4nAQQPhCTzT2lL9TppiDRp4EPX6N/Md1+r97DL3FQaIRTeiEl+r5kq+n6rgzR0P7bR0Xrjhxtox3ErU+9vrxpKXtw4MX+tZT/m6H2LzB0OHg6/L755y30L7xqu7kgupNIdEVSIkb+2YKvuptJbaNeHPgtKPGM2qQv6/JNR/Cn/uYxx+HkYaxkPR9FtSCgn8N7VnCK4wTxiTRci4GtsJNYJV05jVygR6+FYLw688cC3bg==
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:40e::16)
 by GV1P193MB2006.EURP193.PROD.OUTLOOK.COM (2603:10a6:150:2c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 17:27:45 +0000
Received: from AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8]) by AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 ([fe80::3d5a:43b6:acd8:3be8%9]) with mapi id 15.20.6111.021; Tue, 21 Feb 2023
 17:27:45 +0000
Message-ID:
 <AS8P193MB2095CD44400D95C79C262249D2A59@AS8P193MB2095.EURP193.PROD.OUTLOOK.COM>
Date: Tue, 21 Feb 2023 18:27:43 +0100
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
From: Martin Bayern <martinbayern@outlook.com>
In-Reply-To: <77bf61fd-485e-7162-c0d3-c1bd7735deaa@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TMN: [q9UB6ALHsXbLp2Kd4xJGlCxugwA3daaN]
X-ClientProxiedBy: ZR0P278CA0012.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:16::22) To AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:40e::16)
X-Microsoft-Original-Message-ID:
 <095c238f-432d-d1a2-8fbf-f796b2cd5ee7@outlook.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB2095:EE_|GV1P193MB2006:EE_
X-MS-Office365-Filtering-Correlation-Id: d4669d60-1caa-4603-ba7e-08db1430f1c6
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6nQU8OGSYT8pmBBDs/rGsX1WvmjnOr9HJN03iScBVJuHj2AzdGYiUPkYtqTn3QkOUzE1D2sKNSCIwtFmb39J2eyXFMpbV2X6cBKW1+AZDjpOXZvh74Ju1k/0gNa+ykZvaoHaz3Hoaw26BGC6akhjXQ+nqq9qSwG3qS1i63Vp3+tP/+gL0pLlKe8lQSW4BZMnKSPdTd1XivHNgmIOyYt4Hvw7reqNPaMqLqAU6fVNKRdN2v4z8fZ2ops/J1+T0DJHcfW1nw6YJzsBNGz1CvaTVdFMBHqa6pQMHfKLJd4qr8EFtYIgd+9D6e3QP7Foiu8a5JtGB001/JwghwNzrPsyWInQZ7sAYRuu4I7Tb47P4pmHD0pctWTHgcQUwTv/JJ/3AIeqqueEsxhklC8DmdNi4dNV4dQkXlbC2Ms2rRkFU/8P17cO+IcpZRUpI3Tl/GGcbbuPZpu6j/n6epnUb2BK6O1FfxwU3HtctyTiyidtzjDo6YeqOma91Hs7gVPktLfGzyajYCLEmifZ8iGDE++t1Kh6bGtaGZMmr2/T/Oz/kG4pxbJcUeCsWwlARdCHjUNWohkZiQPvuDi7fwuotwGIneZxt8P0s45T5s8hJ2/Q14WZLl6kpPA2JvBh6XBAVoQMgwxnulmEpXit/Dv0gI1Rug==
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZDV1SWQxYUlZTnA5TWl0Wko5WkhVVFFRWndRUE5adDNHWm5nQVlsWnYzZ3Nr?=
 =?utf-8?B?bzhjR2pvdTNuWWxsK0E5QUpGNXlIRFVhSGxvbFh3MmlTOXNJU0F1VnNhbGpl?=
 =?utf-8?B?RDh4bHoyazJMZTJ0QnpEb1FZd1RzRldXYkEvMzJ2L2FCSFdUTm56ZXhSbjV4?=
 =?utf-8?B?dzJnSTBTRnZqVmZ6Yk5haXVnR1ZtNXFTcThodFBrRXlJQmdDbmlmNkY2cDFv?=
 =?utf-8?B?TTB1MFYyNXhTVWNaM0FZYjNVWDg4TmRlN2xIYVZhMkI0SGQyNzFsN2hDMHE3?=
 =?utf-8?B?Vmt6azYyZHlISDhUNVJ3cm9LTi9Tc0pNU3V0QmxabjEzZmJCdkI2NTZpbjln?=
 =?utf-8?B?YUdJa0pWUE1idWFsZDhQT1VIaXVtcDRPTFN0MElRcWFlRmtnTUdBT2g5bVNN?=
 =?utf-8?B?Z2hlNjRDUDR2RENYWkpCajI3MGVuYTFtUTRyQit4SHluMDA1NDVFOUdVUk5C?=
 =?utf-8?B?NVlJT1UwREhaSnp3OEFpT2QvbS9Ud2hUVE9WMlFEQVEwcHRDNkxCYjBhL29L?=
 =?utf-8?B?MGRGQnBkSFcxSXFod2c3b21HSnNZbXZZUmZ4Y1lFSU5EaWRoaDRYQkI1aFRk?=
 =?utf-8?B?S0I5cm1GQnFURGhOVkQzZnBnSE9QSGxBblhYN2FsdlEwVHhxTmpEa01qK3JR?=
 =?utf-8?B?VWZtZnZYU3p4Wm5rcFVmZnFFTUhlaGZORWFxRWl4bVV4TTJNUEpFYXFXeHgz?=
 =?utf-8?B?bEF4azlXL1V0elVzVS9iRWZScjBMUEg4RldZbmxPNllBNFFOMnFYMk9qYUdI?=
 =?utf-8?B?TWVWTzVRWE4wTFFaU2hFWm5lNGpxQlppVElYeGhkVnZSdUVMV0tleTVkZm5Q?=
 =?utf-8?B?Y0s0TEJYVk9UNVRFNU41RkgrdGdEVGRFRGhiRm5BNFZNQlZzeUJwNVUwQ1lX?=
 =?utf-8?B?UkhuVng0RTA4VlVrVVAxU25sK0JYSVJzMndyU1VEUDFRTldmaWUyMUFZcnlq?=
 =?utf-8?B?Mno0c0wzbkNrOW1iVi85U2NHWGJmV0dPeG1xYTNJV1ZJTURCOTg3KytCUUFM?=
 =?utf-8?B?WkZiOTFHeUdSWDYrVmhTZUFzWlVmMWpRL2NpeGtGbGVsR3RrV1IrL0ZxVktO?=
 =?utf-8?B?L2FuWHJZbThPL2VCaEh5M2dQc1ZYS2RsK1dYSFRiM3JuUnpzSmFRMU1LR2lK?=
 =?utf-8?B?bGtEZnlXNFNLOVpzN3JWQnBPUzdyUG1xQWtDT0ZUY1BNNWRpYVRCTWlFM0hH?=
 =?utf-8?B?OHVVOHc0b08yZ2ovUHpPYWdlNTRVakppdzRNUkNsSWNOc2gyeURWN3NPOUk1?=
 =?utf-8?B?cjhxNVFMd0Z3WnBIVTU3TzJQeTM5OE5PeklJcW1KYUpkRXQySllrU1o2K2p5?=
 =?utf-8?B?ditOdHYvVmR4OGRYVjlzbEg4VmwvektRTm51cDVxQ0ZBY3JmaS9JbUM5dHkw?=
 =?utf-8?B?MHp4MVZOaEdheDZRbnRId0xIM2EwTWIvdGg3eHR2cUZ0cjVNUFJTMWJYc2g5?=
 =?utf-8?B?aUVNSjNHMjhodTZraGplOEFwdnBpMkxGNjVmOWlsdG5mM1NlVFJDNzNKQURQ?=
 =?utf-8?B?Y0NYc2JwMUlHNnd3d0VmUWdZK1dvQSsrTlhrVFlrQmZxTFVoalRrM1orcTQ3?=
 =?utf-8?B?MXJwOEZKT1cvTzhvb0FQZmFFRXFSNDBjeW5iU25FUldHY0hsa0ZNUTFFZ2JY?=
 =?utf-8?B?N3Qvd2lpZHBnblZrNXJWREw4eHlsQjdVU1dnc25UVVRST1FhaUtrSVdoa3pp?=
 =?utf-8?B?Y0dCMDQvMEszTkMveWIzWVpMa0ZKRTlBQlNPbkN5MytReFNXL21SeVlzWENo?=
 =?utf-8?Q?nll0XCW4PuBfrDJpnQ=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4669d60-1caa-4603-ba7e-08db1430f1c6
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB2095.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2023 17:27:45.6156
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P193MB2006

Hi Robin

thanks for your replying.

On 21.02.23 12:43 PM, Robin Murphy wrote:
> ...so given the implication that this is an older kernel, your 
> "internal error" below is almost certainly the -EINVAL from that check.
>
> The rest of the information here also points to why you have that 
> grouping, and unfortunately it appears that it's not just down to ACS 
> but to a fundamental limitation of that platform. Looking at the 
> upstream Tegra DTs which match that PCIe layout, it appears there's 
> only a single StreamID for each whole PCIe segment. Thus all the 
> devices and functions *have* to be grouped together since the SMMU has 
> not been given the ability to distinguish one's traffic from another's.
>
> Even if you could solve the platform device conundrum (which is not 
> reflected in the upstream DTs, and I can't speak for whether the 
> downstream kernel actually *needs* an "iommus" property there or not), 
> the best you'd be able to achieve on a system like that is to give the 
> whole group over to VFIO, PF and all. 

I tried to apply your patch to the current v5.10 kernel, there are so 
many sub-patches needed to be applied as well, so I give up that.  and 
then,  I tried to give the whole group over to VFIO, PF, and VFs, I 
cannot give the PCIe bridge to VFIO since I got a permission error.  
after that, I saw VF is in use by vfio-pci with lspci command, but try 
to start vm with virsh, but still got the same error.

martin@ubuntu:~$ virsh start --domain vm1
error: Failed to start domain vm1
error: internal error: Found invalid device link '141a0000.pcie' in 
'/sys/bus/pci/devices/0005:01:00.2/iommu_group/devices'

I'm going to completely give up on implementing SR-IOV on NVIDIA 
platforms, too bad I posted the same question on their forum with no 
response. So if you want to try SR-IOV on an ARM-based platform, don't 
use an NVIDIA Orin board.

do you have any idea which ARM-based platform can be used to implement 
SR-IOV?

Kind regards,

Martin

