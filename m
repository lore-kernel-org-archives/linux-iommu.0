Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AC21D5B0;
	Fri, 21 Aug 2026 16:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787328965; cv=fail; b=edQ/pDMK8KGJAcdwYf/BRHQO62lWwNC8AC7+U4wuSfU81rIEajrothJsxF1k2/jwTKbHDoTqqE+JPjGoLDlFJ4LH872JmLIaj4Cf/m4zkWUvz95pKOzi2S8RGzsIwjzgMwG+A2DE82fsPLVqD85qLepbqPAc3+1v7XIO9bgleM0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787328965; c=relaxed/simple;
	bh=ixVpo+4gK30G566oqUb650vlyonYqrkR+Owepfyiigg=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gNIdooha0GjP5maKbnGA3ndYn1VsAuCeJ47uWxMLbGlZT4NFoyRWdcljLuyi3C7JUkrqCWv7a/rAdV8ovJ/wa2YtKv56VZ1pdTEYSLFZV9ms1o6NKTdH4kUoK7MLah/qMclnTNldKjoN0/pkwXZ5OBIxtNsRyARGHCOk90HbggA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4CswoQ1w; arc=fail smtp.client-ip=52.101.85.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4CswoQ1w"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DPVJHXSsfwGnL3w1VHzpQ1iMhGp/um3jzOv/CatBe1MSP8OssI55ry1r8qu/AcNIOZjsXqaCKvJRDWv2eXKYGVcW3fb3nVVRseFZ61jAjMzcsHp6oOIpih+bPMnoT/lLzK+PDhgY9EBTcZ1H4npxRbVH5DvADx/SNqXIJDYPmrsfH1Z1hley2TP0aM/LGpzY1nYW4zZNNBkGhkrwSexBy+fPwPyCe/szXFZcCRd/tC0ExCryyJmfk/+8TQNTO/zJ66Ha+BRh2gh2aMEhMgC7lh8YtTyqbpCqyg5NNNSul5lTPhXmQHLU7jIgT48BC55x10PIQmtjP0Am1EF0kv3gHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqe1E103Ra+MbKN1UbsfRw2+/mRGO1r2RfOgxjT48Cg=;
 b=VOLzv8rBjlZK1JoufX8CgC43yjIq/9EL+jU4mDt/acXt8vtdu8Kng+zO26Y5pAH5F0tYgCM3Uk0nip94CeE8cenGTfw4gfPz7eTgwBigcg1SmBU+Zh2NTcdOZa2VvDh/u32MFta+26nLx5MlFuKzW3IZf1reebDC+Gq4ecr/w6n5LB/LhlUwFy0X65Se0M5tLqMr0Zke/MfqfFHtAINt4HjZZ3haVmgaU1PuAO7q1pOnvdVxqdlHA/M0ygJFtOelCNCu1+XukdBVRTvBBOgpFjb12CsPNXGhNAWdPoQ3zY6h95KOjDqKTXtcM5olZrB2Mmc0r1HZ3y2wjBTOgEqVpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqe1E103Ra+MbKN1UbsfRw2+/mRGO1r2RfOgxjT48Cg=;
 b=4CswoQ1wM4Rn9KO1HR5ewg7vs2lG6m5qfOyN+cl8dDhwlr1eKt0X8Wd1QCqjApvrI+1N6pPreM9MflkiQjdELrtZS5h/ok7jgNJpVO+WKGaw43Lz8HjJy4UcZswlubysh4gYV8EyUcc69hSzs9VDKR1CxTJ/8LRaWtbP/uEGc9E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL4PR12MB9505.namprd12.prod.outlook.com (2603:10b6:208:591::16)
 by DM4PR12MB8449.namprd12.prod.outlook.com (2603:10b6:8:17f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Fri, 21 Aug
 2026 16:15:48 +0000
Received: from BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83]) by BL4PR12MB9505.namprd12.prod.outlook.com
 ([fe80::73aa:eb8c:a86b:5a83%5]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 16:15:48 +0000
Message-ID: <bdf29f6c-9f2e-4230-b5f5-5f25827f5b7a@amd.com>
Date: Fri, 21 Aug 2026 21:45:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
To: Sairaj Kodilkar <sarunkod@amd.com>, "Borislav Petkov (AMD)"
 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Breno Leitao <leitao@debian.org>, Christian Brauner <brauner@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Eric Biggers
 <ebiggers@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 Kiryl Shutsemau <kas@kernel.org>, Li RongQing <lirongqing@baidu.com>,
 Marco Elver <elver@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Robin Murphy <robin.murphy@arm.com>, Sean Christopherson
 <seanjc@google.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, kvm@vger.kernel.org, linux-coco@lists.linux.dev,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-7-sarunkod@amd.com>
Content-Language: en-US
From: Vasant Hegde <vasant.hegde@amd.com>
In-Reply-To: <20260821055611.27138-7-sarunkod@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN4PR01CA0095.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:2af::10) To BL4PR12MB9505.namprd12.prod.outlook.com
 (2603:10b6:208:591::16)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR12MB9505:EE_|DM4PR12MB8449:EE_
X-MS-Office365-Filtering-Correlation-Id: b7d516bb-2961-4c47-5216-08deff9f7630
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|366016|10067099003|56012099006|11063799006|4143699003|921020|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	WpcjvDrDQe3U9Cq9GxF7oEwoM7BdZ+XP6LXeIopFDRt901muFzTUPkIw0QDjtjOVjDc3TF9umZJM7dvghL+7g4qjSvoCQIDyiefxB+t0D2dGDYX9MGJPhfkIeR9jC7GfK6ji5nEV2LI50wTRYR5UUWFGM1dDfuIKP4+4ZmY9DASukz2BRGZG60NYcctWf0pHyIdaJCPVl2EHOhqwSvpggd2Vno76glfqaz7CblipeT8fkkZjGVyqN+xYA+z2LCTuqG+bryPVbq3nOFvoqpU/NLeip/xZIMvOLn3jdc9h8A5AeCdq48kWGkn9/IN3270+HHldQjuuDmrHMvMFygNAJCrGrk5aKBNgeRjR9dTOPWj/TernEspIZQP7Ru5g7v0bMnjCKjKb07la1IWpQm0EMOudkX8mfAnrk0loJBknpw3qNJt+Y2oNMPZAqs+FlXD2fXpCLf67zoTSehLO1KJGKrkIFBzaUkQUy/PIAgCp/XHYkwRe0IXcmCZxwm3D95dQzfgTmqHqthB4eyDpQVsVE3BsLo1YC3ba9zrQScKqJWoY3kX9toXx+CSmXkSWScDneV6fRRN0Y/vhSOXhW7sEh7iwJt6gdLoThGyEWaUrHP8DoTAXKsAHOhqyzA1zFrqEX+9yiUpUvYX6le64+1KdVvkdkL9uCQdK/wQQxMi9YYPZ7uKj7Fd8I07x8HaX1Hd2ffO89/Iw77g6zYpkEiCecw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR12MB9505.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(4143699003)(921020)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VnRsN3duVWlSMzh5Um0xNGNRbGR4MVhOYzFiSEVjbXJoZVZFaVpRMFhDSGc3?=
 =?utf-8?B?WVN2VExtSmplNjJCMzFlYTFmRzFITGx1bE16M1Vha2tDK1VHRjZrSUdnYmd3?=
 =?utf-8?B?SGJ6Z2tscXl3RTBobDRCaWRZM1NkdzhoQXdqMGlucU0vUFJVSEE3am9LMjYz?=
 =?utf-8?B?eHNhR3dGNUVqbnNoWHlZaHJWVGxVOE5jdGE4b21wbXV2b29DVExxQ0dTS1Vx?=
 =?utf-8?B?Mld0cEFOMXNiZDR0b0RMenovQVVmaUxuZkJxMlhkdnZwRmRmQURKcTdJN2xr?=
 =?utf-8?B?ejBRUmF0Z1pYY09SVFJnYmlMWWNFVjRVRWNpbG8wNEU0WU82Z1BlMngyKzdn?=
 =?utf-8?B?eFV1R2FCZU1vVGR3WkdBVnlzbU9iVlJjT0JLTENEYjY4cTQrR0ltWWV2MGlx?=
 =?utf-8?B?enhXanZKclpvb1pDMG1KbW1PVnlZeEdtR1NNZUhkUDJxRk9mNGt1UEs5blkx?=
 =?utf-8?B?U21sRFZyZnVvVWMwbzVKODRnbWh5QzNmcTEzelYyTVVKUmZjSDlFTGZxbVMy?=
 =?utf-8?B?WmtmUzl5OUVEOVRvbUlGbFYzWUJ0SCtLZlltOGczSmxEamRtN0RyWmdvaG5s?=
 =?utf-8?B?N1ZtMmo2aUI1RFFvUmV0SWdzNmE3T1BXaUE5VHNmT0F4TlcxZ1dsYzhYM2xR?=
 =?utf-8?B?bUUwdzFXMmNWU1Z6emZYQ0gwQW84NnJORllYSnViNFY1bGxHSzA0RkhWOEpM?=
 =?utf-8?B?Q3JjbDJ3SmVrV3A2czU1b1luWVBwbEkybUVmZGNhUXdVYWpTc1ZoRDlXRWxD?=
 =?utf-8?B?NWNtTC8xWjZ6NmdjUGdPM3NOSnJud1B3dlo3aERIQnZtV25LZUR1aUZqVTFy?=
 =?utf-8?B?a2xJNGdzNlRxTjRiaXlEWUora1ovUWwvSFV1OVdVUXd3YW5BajVveTNnM2Fn?=
 =?utf-8?B?QjQwV0w3TktkSzFJaWJJT25qTU9xMlVMV3AxNThrSTZLNVhBM2lGUmV5ZXdD?=
 =?utf-8?B?alA0d3RHWmIxT05Lc3BtYk9vLzFaUDNyM05CUlBGQ1dZcDMwdkZIRWt4bE1o?=
 =?utf-8?B?MUZtaU04OHQwSnJJREZweFY4YVlreVA4TUo5Z0NqYlp0aEJPVUFONFNXVzQv?=
 =?utf-8?B?T1ZRTHhzVmd0NW1ZeHJML1czZldrcDExc1MrNEgvT3dOK0xURUNQZVErbFNR?=
 =?utf-8?B?WGZxcGV4dEdieGUzOE1NTit1VGZvVzhYSU9DMEt2cGpvSXdUTVZMTDFNT3Fs?=
 =?utf-8?B?Z3ZPV21zM1JjbjVIcFhrc2dFWXJXR01SWmNPdFpUTzJ6K3MwS1ZvM1V3SXJ5?=
 =?utf-8?B?eERncFBjUm91TUk5TVI1ZW5ySDBJdWttbnJQN2dZeVRxR3pmSlIrLzJnWTZq?=
 =?utf-8?B?bWRDUkR2MTRReHVmcU9JV1F4TjhnMGxWbVVOb3dKUE9iWlRTc3hlbWxNTVlq?=
 =?utf-8?B?NXMwMm4vU3FENG8xRE9FZGU2Q2hWVDI1WGVIWGhCRHNaSTdiek9tOW1ucnYv?=
 =?utf-8?B?dUlBYTBUdWpQZGk4ZytQa3ByNi9PQ2Rya2o4ZEMvR3pqU2RtaHZoalJwZk9z?=
 =?utf-8?B?Z3NOMU9rTG9pR0s5WHBtRTlNQmsxTHo2NngwMjRVVUJmYXg2R2pJdHdQQ1lV?=
 =?utf-8?B?NUNIRXN1WnJwTmJWaEMyVS81U3hMU1pqUUxONkUzdjBWZjBqQzRLM1M2V3Rs?=
 =?utf-8?B?Zlh2STRrSUE0aU1ZU3NyUUUrMWF2b2FVSVBpaEQvSVdLVlE3eDBGTklYOTly?=
 =?utf-8?B?QnV1VExmbWY0TFJ1dGo1V2RacmNnWUFjNUltMi9uU0IyU3NmMGNvWmUwQnY0?=
 =?utf-8?B?V1B0Tld3R1RjQkUxZ1N4bmI5aitIVTM5eURMMlV6VGdhbDYxQTFvVGsvdDNP?=
 =?utf-8?B?ZE9LWVRGRUpyRGJHNGtGaVpZeHRRa2pURjhxYmdOb1hVUHBBY2Fybm0wbDJn?=
 =?utf-8?B?K3J3OGcyMnVaakl2Ynkza1N1c0ZxeDlGSEZkL2FXNTdyalZTb3FYZVMzK281?=
 =?utf-8?B?ZTNFaTZKVGZ2SlBFVEQ4ZnNmcjY5L3BYT0lJdGs4d3dyNUkwd1JRMnl1SHp6?=
 =?utf-8?B?MU5OM1l4WFlITFlVVjZIb0t6SVBRZDQwekRRTTVpWDRaam5VTGJ3bzVjYVph?=
 =?utf-8?B?OFcySE9VOHBveWlld1pNb1FoTUp2Rm5mR2J6L2hFcjNSSHYvQXozM1ZBeGha?=
 =?utf-8?B?RzhtRjdTd2Q2SFVkYkV6UlRQRnkzV1d6WVBPLzRIYXhwR2VIbi9jemZ0U3BS?=
 =?utf-8?B?aVZyVXZXSVVITDR1MlF3SGNZcmFEa1d5S1p5SS9VbUc2M1ZwNXNiZ2Y5cWo3?=
 =?utf-8?B?VEw3QndPbnp0amUrcFVnY2JNQk13OXgvTElXKzVKdllaemRHckFqalF6cFNR?=
 =?utf-8?B?a0pyVUNIaFJoQUI2ZjdpVCtvVkZiZmNiZGtPMWNnSzc3d1BiMlN5QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7d516bb-2961-4c47-5216-08deff9f7630
X-MS-Exchange-CrossTenant-AuthSource: BL4PR12MB9505.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 16:15:48.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QuTWxc2f83RtAUVCvTzdZXC4+4K+6rPzISFdFH1t1v0+lzLQS+TWljDxCSzwy69p0BKEETvw4j9hRgK6QG9Mcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8449



On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
> With AVIC guest-mode interrupt remapping, device interrupts are posted into
> the guest vAPIC backing page by the IOMMU. When the vCPU is not running
> (IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
> path uses the GA log.
> 
> GAPPI (Guest APIC Physical Processor Interrupt) is an alternative to the
> GA log mechanism provided by the AMD IOMMU. With GAPPI enabled, the IOMMU
> still updates the vAPIC backing page IRR, but the host wakeup notification
> is delivered as a physical APIC interrupt to IRTE[Destination], using
> IRTE[GATag][7:0] as the vector (POSTED_INTR_WAKEUP_VECTOR).
> 
> SVM follows the Intel posted-interrupt wakeup model. Each pCPU maintains
> a list of blocked vCPUs that may be woken by a GAPPI delivery to that CPU.
> When a vCPU blocks while waiting for an interrupt, SVM enqueues it on the
> wakeup list of the pCPU on which it was previously running and passes that
> same pCPU's physical APIC ID to the IOMMU to program IRTE[Destination].
> The rationale is that the vCPU is likely to run again on the same pCPU,
> which is common when vCPUs are pinned; targeting GAPPI notifications there
> reduces unnecessary VMEXITs from GAPPI deliveries on other CPUs. SVM
> registers the GAPPI handler via kvm_set_posted_intr_wakeup_handler(). On
> delivery, it walks the local vCPU list and wakes vCPUs with a pending IRR.
> 
> All GAPPI logic is gated on amd_iommu_gappi. Without it, KVM and the IOMMU
> falls back to the legacy GA log mechanism for vCPU wakeup.
> 
> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
> ---
>  arch/x86/kvm/svm/avic.c | 72 ++++++++++++++++++++++++++++++++++++-----
>  arch/x86/kvm/svm/svm.c  |  3 ++
>  arch/x86/kvm/svm/svm.h  |  5 +++
>  3 files changed, 72 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index dd497530d365..18ac24ef40e1 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -874,6 +874,8 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  	INIT_LIST_HEAD(&svm->ir_list);
>  	raw_spin_lock_init(&svm->ir_list_lock);
>  
> +	svm->gappi_cpu = -1;

Can we initialize it to CPU0?
> +
>  	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
>  		return 0;
>  
> @@ -886,6 +888,20 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>  	return ret;
>  }
>  
> +void avic_destroy_vcpu(struct vcpu_svm *svm)
> +{
> +	if (amd_iommu_gappi && svm->gappi_cpu != -1) {

Redundant amd_iommu_gappi check?

> +		unsigned long flags;
> +
> +		local_irq_save(flags);
> +
> +		kvm_pi_disable_wakeup_handler(&svm->vcpu, svm->gappi_cpu);
> +		svm->gappi_cpu = -1;

Redundant assignement?

-Vasant

