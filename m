Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD563D331A
	for <iommu@lists.linux.dev>; Thu,  9 Jul 2026 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783579183; cv=fail; b=T/mVddvtpqgK/NXQPnvqsAMAxkrQSwMElYRUk6HSry7SfiavQ9Z0a3vDAUNXBmlQiSyxGeosNVUibPrTvCSLwRmQK4dJFrjCX/naL//bxxrVGUbnzryj2wBRJORbIEDvCQJNStw2A5jxEfoEABhASVOL3hORf1m6vLg5YX7QHTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783579183; c=relaxed/simple;
	bh=j0bs/ZJvaypzxxqVSJGU/ZMn/WYTVibvxogKjAJpkuU=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a1/6hUBXbM8wzCJOUmmBBcWSzZlVxR5+X9wEhKspfo8tXgVxv+zHMVthJsD6JKGU2K5OdKqWF71mJynGtsZzmycZgTmTRBUO8+MDnIuy0ijUAZgOAl16IqWB1OEDAYwmPM9gTYg9M2OyAMMPHygDMbSFsULcqHX6dqdf6F+leYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f2nvoHjS; arc=fail smtp.client-ip=52.101.48.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f2nvoHjS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R1gNgfm4g68kFvHcgYeUcI/CFdxj7xhCVJdmoa2fK6aVcU9ehF27TIRK/DfUpWAHMJDxJzFM14ujdusaiMalclB5bj1WL3LHZuMpQLSUR4PCJ8LDamOn0pg8hMDKCzKJR0i5qMkFyEJhkFX8NQRLTZ3NGTbEP/st1eQT9FPre+hFf02MUJY23+E4zO62AQhz6NQSGSeZor9eV8Cq0vnK0fUKjxdMOd8eBvTHA2Uz0cIBjHzQvpxglu5D4XirTYw4sfGIJYOJ1KgMqat0Hwn7un4OxE6Mn2RegRfBAUeG8WWu5OYC0LVBdHLtY1bKP1kfVVCCwv5RKF6UeR6u3y7a3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3+a5Hvf2TIP2QULy/NU9+QNCtfqfx3L6BgWsvAZfsx4=;
 b=mXdVcA/cj5xeH9gdGJkyBi51fJEsKnSSrcC0GTMJGzq9u5AzpBgS0Tb/uZZLrQ1OOhOX83XZJgoGR8kFCsrnC3hzZezFf4Wr/Wh2qbYwDluMdpU7Nu7wqwfHlklxDCHAshBSKcXfM0jvjpA7001CUgILEX8iuB5tWpQyTBTPkmDbeNPGiA4jnTVWWGxAodPYUSHUV+al0whtpJiAGRFv4YwhvwliE1xoQz7MsSSbDTUkLmRNNAloyhDaEE4B9zVxDiavRi4LSTsAzOgduNtYVGMfMKF1qGPQ0SK76FrAecFnZbBTSfx6xOGJVjzKSYIYc3mWjkQd/Sg0n4AWW0+nSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3+a5Hvf2TIP2QULy/NU9+QNCtfqfx3L6BgWsvAZfsx4=;
 b=f2nvoHjS2K5Zksmgox49DWPsnb/+tlQVL2hVB5EWx1TA5A8bx3J9gYp47GwcS2AhTfy+AJFMTlP8ZH3cO8bn0+2uaasWgo0s3gCdnlChBYM6mO440DRHzbRjjZT8nORe8HV2P52xYnJYMR2D2lI5xX9CeqkAEhFK3zHa+uCc4X0=
Received: from BN9PR03CA0349.namprd03.prod.outlook.com (2603:10b6:408:f6::24)
 by SN7PR12MB6716.namprd12.prod.outlook.com (2603:10b6:806:270::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.16; Thu, 9 Jul
 2026 06:39:32 +0000
Received: from BN2PEPF000044A3.namprd02.prod.outlook.com
 (2603:10b6:408:f6:cafe::50) by BN9PR03CA0349.outlook.office365.com
 (2603:10b6:408:f6::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Thu, 9
 Jul 2026 06:39:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A3.mail.protection.outlook.com (10.167.243.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 06:39:31 +0000
Received: from [10.252.200.247] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 01:39:25 -0500
Message-ID: <f3037b16-0974-4c6a-9914-50f0401af656@amd.com>
Date: Thu, 9 Jul 2026 12:09:22 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Robin Murphy <robin.murphy@arm.com>, "Suravee
 Suthikulpanit" <suravee.suthikulpanit@amd.com>, Thomas Gleixner
	<tglx@kernel.org>, Vasant Hegde <vasant.hegde@amd.com>, Will Deacon
	<will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
Subject: Re: [RFC PATCH v2 1/5] iommu/amd: kvm/svm: Improve API between SVM
 and AMD IOMMU
Content-Language: en-US
To: Sean Christopherson <seanjc@google.com>
References: <20260708091408.12106-1-sarunkod@amd.com>
 <20260708091408.12106-2-sarunkod@amd.com> <ak5SXWcvtVLL0eKs@google.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
In-Reply-To: <ak5SXWcvtVLL0eKs@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A3:EE_|SN7PR12MB6716:EE_
X-MS-Office365-Filtering-Correlation-Id: 5da43bc7-86bb-4d0d-4024-08dedd84d542
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|376014|7416014|1800799024|82310400026|18002099003|22082099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info:
	sUDL05ik9KvTZHf0byvPzSs4EvGJp9EOpLJgZ/37QtNflZroXTs+nFU4vHU4amdNCBVhkrx1W+sXkSoRGIoiGJQ4bGCmXBpD6VWRB40dmJ8+P0REW/DjKH+pqljuSbibXYtvkkbp5MWABssi1lFcZss53R3FqW79xwegZHPq100DiBQdAIN3qus0vPUSfsv6TMPAnnP/Cw3GKsv/wj3bsuaBaPWOeO9vkmUeMkZ2Ij6Owuq+BlmNlJezLDzPM2FbhKHs8OhYwvEnkijzwGJEDjauUlnkVbYH1NA4uaESn63XAF9uxi2cNxfHbpbLw+v+5csNAMLEfQCXo4QXJmUndFQAGAK6j70aKhuSrkkq/RUChGqdDaujSh4tty+JBHKcqO2NcXInwi3IVoVziyEujKvuO3DOy8HUSWhhiTmZbQlm2B6AenQXhq/lX21h5p4wO4Dm7geEimfgM0y0GHN1rmQSedlLmNGEF8DoYmLByAcO54SzvyGqnebm07dopAPL0+fzYOuNLRpUOgn+Sy4QhuXHT6OgGZreNmSAFmT7qP73Wyh13LQ94VbGQqn7YyuM42kefYmTNQNXP6TNzE1hdD/SJu/XFx8+Jt9uTkT7PslCjAKIKi2HxULR6cDTFoLs1Xx3/IYfJyuW6W+0es+hLvZkGERwFe8Gr/7TfGAd7MRbWavvcTxkCVNgpZvOaWFqnpxzUqeBPdon4TgNPss1Tg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(376014)(7416014)(1800799024)(82310400026)(18002099003)(22082099003)(56012099006)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	woU8V7sZMEbzH3qdC5fum6OjVcJ5KvyKi3IwnFVuVR9zjOAd37T4w0814ZvnpYYlEv57ARobMbPTfIR6qz5gCfJ47eW+3cRBN5EIdRLcHuP8QKRGGvnUkgFUFcqW9bO9AGkdpoZz4RUfrCVb12+y3VnyaREHGFMu+iVqyM4wTTRJsphsiLQxY2hnssLI6IQrc9pZH7HNom7igZsxMmEqybyGefQckcCYfYnxTrWhFc8HlSHoKbij0njO+HRVEhe32E8KaheJ9+7vLU5gFlCXBa+jVhcBEpXwI0wmIc/QQaPldns+19NFj2OAGIVloDMvuS0Bss3VVVsvY5xxMs9kpFgnA10Hpj9GWZ8Fa37K6t0WgXyTmIdFC/IlKaOitVF9XQUpE//jZgYezodWls1CEuXpbbB2l+RlHUueR7Ch5VJS5pz9O9cemDizvfrdfgil
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 06:39:31.6096
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da43bc7-86bb-4d0d-4024-08dedd84d542
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6716



On 7/8/2026 7:06 PM, Sean Christopherson wrote:
> This should be two separate patches, one to rename the @cpu param/field, one to
> replace @ga_log_intr with flags.  "Improve XYZ" is the equilavent of a do_work()
> function.  And I'm having a hell of a time trying to review this because of the
> overlapping churn.
> 
> Actually, if you insist on a "flags" field, three patches: rename, convert to
> flags, add the dedicated RUNNING flag.
> 

Sorry for inconvenience, will split the patch and improve the verbosity
of all the commits.

> On Wed, Jul 08, 2026, Sairaj Kodilkar wrote:
>> The name "cpu" in the parameter is misleading as it represents the
>> physical apicid of the cpu. Hence rename it.
> 
> Hrm, I was going to suggest having KVM pass in the actual CPU instead of the APIC
> ID, because the fact that the IRTE takes an APIC ID is an implementation detail
> that would ideally not bleed into the API.  But unfortunately KVM uses the entry
> in the physical ID table when filling amd_iommu_pi_data.cpu, so taking the APIC ID
> probably is the least awful approach.  :-/
> 
>> Introduce flags to determine the state of the vCPU (running or not) and
>> posted interrupts.
> 
>> This is useful as following patch overloads the apicid (formerly cpu) field
>> to determine GAPPI destination when vCPU is not running and it can no longer
>> be used to determine if vCPU is running or not.
> 
> Rewrite the GAPPI behavior with --verbose to explain *why*.  The only reason I
> could suss out the why is because I already know how Intel posted interrupts work
> and so could intuit why GAPPI would want to keep the APIC ID valid.  Without that
> knowledge, this is unreviewable.
> 
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>  arch/x86/include/asm/irq_remapping.h |  4 ++--
>>  arch/x86/kvm/svm/avic.c              | 22 ++++++++++++++--------
>>  drivers/iommu/amd/iommu.c            | 24 ++++++++++++------------
>>  include/linux/amd-iommu.h            | 14 ++++++++++----
>>  4 files changed, 38 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/irq_remapping.h b/arch/x86/include/asm/irq_remapping.h
>> index 37b94f484ef3..40a2206a33c0 100644
>> --- a/arch/x86/include/asm/irq_remapping.h
>> +++ b/arch/x86/include/asm/irq_remapping.h
>> @@ -35,8 +35,8 @@ struct amd_iommu_pi_data {
>>  	u64 vapic_addr;		/* Physical address of the vCPU's vAPIC. */
>>  	u32 ga_tag;
>>  	u32 vector;		/* Guest vector of the interrupt */
>> -	int cpu;
>> -	bool ga_log_intr;
>> +	int apicid;
>> +	int flags;
> 
> Why use flags?  This is on-stack data, packing booleans into flags adds no value
> IMO, and makes the code way harder to read.
> 
>>  	bool is_guest_mode;
>>  	void *ir_data;
>>  };
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index cdd5a6dc646f..7862b13c5409 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -932,6 +932,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>  		struct vcpu_svm *svm = to_svm(vcpu);
>>  		u64 entry;
>>  		int ret;
>> +		int posted_intr;
>>  
>>  		/*
>>  		 * Prevent the vCPU from being scheduled out or migrated until
>> @@ -949,10 +950,11 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>>  		 */
>>  		entry = svm->avic_physical_id_entry;
>>  		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK) {
>> -			pi_data.cpu = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
>> +			pi_data.apicid = entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
>> +			pi_data.flags = AMD_IOMMU_FLAG_VCPU_RUNNING;
>>  		} else {
>> -			pi_data.cpu = -1;
>> -			pi_data.ga_log_intr = entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
>> +			posted_intr = !!(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
> 
> "posted_intr" is misleading, and IMO flat out wrong.  Even when a GA Log Intr
> and notification is logged/sent, the virtual interrupt is still posted to the
> vCPU's virtual APIC.  I have no idea what you're trying to capture with this
> code.  And that is yet another reason why this patch needs to be split up: so
> that you can explain the reasoning and logic behind this refactoring.
> 

I needed an generic name for boolean that is being used by both GAPPI
and GALOG, hence I replaced ga_log_intr with posted_intr. But I can
understand that it can lead to confusion. How about replacing
ga_log_intr with wakeup_intr and AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR with
AVIC_PHYSICAL_ID_ENTRY_WAKEUP_INTR

Thanks
Sairaj

>> +			pi_data.flags = posted_intr << AMD_IOMMU_FLAG_POSTED_INTR_SHIFT;

