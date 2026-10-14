Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011027.outbound.protection.outlook.com [52.101.57.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FD330B517;
	Wed, 14 Oct 2026 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791965926; cv=fail; b=YVmrZGOeC/lWVlnMwJGLi77OzMrsyZfqvxHu7pc3c3t7Kezz4iYvQbciZbTUSWQJ0bjDecTWfhoBTCv6NJrFCPVVfcgHBz1cczTdTrUydxK2q+QVnhtRblxxePAqnRGz9giBrqmUKMV8o3gjM3zYDnG75Q+UlIMUdVKubov9ifs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791965926; c=relaxed/simple;
	bh=pZuKXL+/CjMooqGp5Hh5+kCSsAKZYzHwzsgyT7jkLF8=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=m6ZGDkERoIVc0Qio4b/nDlNKBHAcofaFRnwmblw0yrS8+RE9sd/+NO9Yj1mY2/4qb7gxWLONOwDUPB8rxdsLeuXcLvWl2E5o87YPemx8JSx2eSZFti5fZynW5SiLLQrSOO9SoUrhujM8Gq0YiTzCEBLiELb/YHmf58xAwK5NAms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x0W3CTep; arc=fail smtp.client-ip=52.101.57.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x0W3CTep"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mk0I2KYY4brVYkRiVaEkPYi6HeOEQ4gQ+Vc7Durlch9LzBIvJGkTUtr9F6xvUzbH8NNLGpTHjwrAtl1SMxLkUdOJIJPqfcQWuB3febllDDE06ejbnSqGAqxEHd85H1RkGw0zy3UVFcyGQt54XKMaixeDt6wSWQra1rucSowYdQKjaOnn8anMGN+DkR91tq8SyjOPOU1/ITVB8bPBAjbTwP5E7yumrhxH8NWeUI7Wzyk4LJ+Z4neYO4JEOCBKO7wylQtRTailGETCthtB5GNR3oDALbCiLGDL5jUSAvjqB1jA4oZPGPUDm5uif6ojHjhcC5iGRm4TI9mfymZBTIEOSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B/O6P/5Mykn6grmjNggrSRIITjQ1hZN2/tusJ7WQk0I=;
 b=k8JeDCYWX9r8SlVwxnpxsxxibo9DufkK8wo5a82yYpbdDs1EKqsercGZGYTMfQgOAjfI42xw8KZT24LOIGk7rRCW5T72Mvvuvwjj+YuhTv51mTKVbo/VuE+nbZwFmV40bcYjA9sR1mNkIq1Rc+gfqTgqiVJ103RHMdP3TbjPXxCiCjds5GZJy5bwSWshxDMyuwqpJhuXSbvgovzEbTpLm5Ww9vVyg7kcjPVo/pzMngWUM/eYDwTL39cnOszoT2aGikEBQAm9ZGrxqB+FaZmJKy5WWtechp63o7VfrXzKL3x1ZGrZLC+zpqgrEBG0HY2fpiequ0rSJL9llc+v2xtbEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=alien8.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B/O6P/5Mykn6grmjNggrSRIITjQ1hZN2/tusJ7WQk0I=;
 b=x0W3CTepWnJgzEAVBsyan4wnQqFsTDhO6in1fe5iRWYo8DjYm9rZU0uJ+y8cXTX9wSJLqrXdqvTta4dJn2uibj+1RAVfax/8LQYM8QjeSmaJ8WXOjvn7EwmYktjmBU/bS/C+GAyyJJBx+hkWZ3TIybcKCgVyOaND2wV25/YGfhU=
Received: from SJ0PR13CA0111.namprd13.prod.outlook.com (2603:10b6:a03:2c5::26)
 by PH7PR12MB9223.namprd12.prod.outlook.com (2603:10b6:510:2f2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 08:18:38 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::86) by SJ0PR13CA0111.outlook.office365.com
 (2603:10b6:a03:2c5::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 08:18:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 08:18:37 +0000
Received: from [10.85.37.249] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 14 Oct
 2026 03:18:23 -0500
Message-ID: <98ce2887-7df0-47e4-b1f6-4dba2442126f@amd.com>
Date: Wed, 14 Oct 2026 13:48:16 +0530
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <sarunkod@amd.com>
Subject: Re: [PATCH v4 6/7] KVM: SVM: Add support for AMD IOMMU Guest APIC
 Physical Processor Interrupt (GAPPI)
To: Vasant Hegde <vasant.hegde@amd.com>, "Borislav Petkov (AMD)"
	<bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, "Joerg Roedel (AMD)"
	<joro@8bytes.org>, "Paul E. McKenney" <paulmck@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Breno Leitao <leitao@debian.org>, "Christian
 Brauner" <brauner@kernel.org>, Dapeng Mi <dapeng1.mi@linux.intel.com>, "Dave
 Hansen" <dave.hansen@linux.intel.com>, Eric Biggers <ebiggers@kernel.org>,
	Ingo Molnar <mingo@redhat.com>, Jakub Kicinski <kuba@kernel.org>, "Jonathan
 Corbet" <corbet@lwn.net>, Kiryl Shutsemau <kas@kernel.org>, Li RongQing
	<lirongqing@baidu.com>, Marco Elver <elver@google.com>, Paolo Bonzini
	<pbonzini@redhat.com>, Rick Edgecombe <rick.p.edgecombe@intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, Sean Christopherson <seanjc@google.com>,
	"Shuah Khan" <skhan@linuxfoundation.org>, Suravee Suthikulpanit
	<suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@kernel.org>, "Will
 Deacon" <will@kernel.org>, <iommu@lists.linux.dev>, <kvm@vger.kernel.org>,
	<linux-coco@lists.linux.dev>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>
References: <20260821055611.27138-1-sarunkod@amd.com>
 <20260821055611.27138-7-sarunkod@amd.com>
 <bdf29f6c-9f2e-4230-b5f5-5f25827f5b7a@amd.com>
From: Sairaj Kodilkar <sarunkod@amd.com>
Content-Language: en-US
In-Reply-To: <bdf29f6c-9f2e-4230-b5f5-5f25827f5b7a@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|PH7PR12MB9223:EE_
X-MS-Office365-Filtering-Correlation-Id: fe97b226-96ed-4475-914e-08df29cbbfa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|23010399003|36860700016|921020|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	x0mCN7IgDrXaghCoGHC8EOOtM8J9EznMQ5iRwYmRp5yf7WuNBtJgF8oJ6lNTAlVGQT048kBC15ZMn/tUhbuaBA4jrrsRQQZc03AjEREekTcRVUatJ5f3/rZWdi1Aor+5ortiiX3PHIgjT34MJFHo3akPBAG7FcXyA6beB6narutttyAtyOxnr/jQOtUtxMVsxlK2g5sGvp+4B4Luxa5fGlicuDOCm1flvrM1I5cBq79ZWtG47wHQLSilkjchlvV8IuGSvS6JTq65eZ+P6VYXdnPV3Q58xpKQ4iYS2RChAowuWRKKD16puSfAC+Buv912NUpGtmhiftWSUDI6CC7ANthOuyZqnL1VGXccI3nvgtEslBXK6Asje6NVFrGfDsmWcyGCJ/WKwSLM2DnzpRb8Fa9sxXjK/q7YsY/78AxKYeLSCms3hLkEznAFNGHlpiKMAmTu+TrJlVBFhhWBEzA2FrD3WG3v4qDYNoXv18nlTw2nRQY+UYUxQOn3BOvAUG2MCQ9pLLQkt70SA3Tpm32fh8H/BbahAbyTFcHTQOwvec1tHEhuFrRvBAog35IXV1icuzbf+ZGCgTI1ldy9xzldrl0pRBqSrowUAmEwGnQ3T9rFFH9kvNk8w74oMKbN5eRSJaMT0JvFvlPVoPAeNecp0hVNn82pEc0yM40oAYYyEyx5jh8c8XCEJURqrBHAXSjE4byoXAY/nuLOXtg9Pht9XxSEGdc/ERSVdBcw7vv/585KlvZzY8rskQwyvzAEUOja
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(23010399003)(36860700016)(921020)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	MHYhb8X9cbYSojlSMYY+HfWhsiQsq9YRiZ5FqVTR1WzQhsPZG8ys6P5XadM0WMefVwmFId5fZxnjtCZNM15JcILg8Rad8YWzG0xhcGrIcaVLKdy512HsrLWAEf5Nt91zBindduNSI/dVwcyByDACQY7d1N0f6t7mKUtlKLYDoskxKfhEqjZiUtJ8/N/5H2HOQnyAV5tomJUXKQW3KHJCzQNpluUEl6b5arec9Ntwv8Mj/NwmjwShSDmgfcgxHc4MytPGnste6QdTNx8GD9oHyId4fzNgrellsHtpfyIWUg/XNra5Id5ZDcMtLgeNiFMGIu1hnPOnhaOGmoo4VagoA1kflfwcBE+dg60KTVJehZvlM6umKFTndO0rF6LQ4KYCPJAqdF2rCg+Qocer2ExKbqPYW1yNANbMlBu99SOuFUcLmAXiC4Kn7VjcrY91GsOr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:18:37.9234
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe97b226-96ed-4475-914e-08df29cbbfa8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9223



On 8/21/2026 9:45 PM, Vasant Hegde wrote:
> 
> 
> On 8/21/2026 11:26 AM, Sairaj Kodilkar wrote:
>> With AVIC guest-mode interrupt remapping, device interrupts are posted into
>> the guest vAPIC backing page by the IOMMU. When the vCPU is not running
>> (IRTE[IsRun] = 0), KVM must still be notified to schedule it. The legacy
>> path uses the GA log.
>>
>> GAPPI (Guest APIC Physical Processor Interrupt) is an alternative to the
>> GA log mechanism provided by the AMD IOMMU. With GAPPI enabled, the IOMMU
>> still updates the vAPIC backing page IRR, but the host wakeup notification
>> is delivered as a physical APIC interrupt to IRTE[Destination], using
>> IRTE[GATag][7:0] as the vector (POSTED_INTR_WAKEUP_VECTOR).
>>
>> SVM follows the Intel posted-interrupt wakeup model. Each pCPU maintains
>> a list of blocked vCPUs that may be woken by a GAPPI delivery to that CPU.
>> When a vCPU blocks while waiting for an interrupt, SVM enqueues it on the
>> wakeup list of the pCPU on which it was previously running and passes that
>> same pCPU's physical APIC ID to the IOMMU to program IRTE[Destination].
>> The rationale is that the vCPU is likely to run again on the same pCPU,
>> which is common when vCPUs are pinned; targeting GAPPI notifications there
>> reduces unnecessary VMEXITs from GAPPI deliveries on other CPUs. SVM
>> registers the GAPPI handler via kvm_set_posted_intr_wakeup_handler(). On
>> delivery, it walks the local vCPU list and wakes vCPUs with a pending IRR.
>>
>> All GAPPI logic is gated on amd_iommu_gappi. Without it, KVM and the IOMMU
>> falls back to the legacy GA log mechanism for vCPU wakeup.
>>
>> Signed-off-by: Sairaj Kodilkar <sarunkod@amd.com>
>> ---
>>  arch/x86/kvm/svm/avic.c | 72 ++++++++++++++++++++++++++++++++++++-----
>>  arch/x86/kvm/svm/svm.c  |  3 ++
>>  arch/x86/kvm/svm/svm.h  |  5 +++
>>  3 files changed, 72 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
>> index dd497530d365..18ac24ef40e1 100644
>> --- a/arch/x86/kvm/svm/avic.c
>> +++ b/arch/x86/kvm/svm/avic.c
>> @@ -874,6 +874,8 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>>  	INIT_LIST_HEAD(&svm->ir_list);
>>  	raw_spin_lock_init(&svm->ir_list_lock);
>>  
>> +	svm->gappi_cpu = -1;
> 
> Can we initialize it to CPU0?

Yeah, I think we can do this, I was worried about passing gappi_cpu=0 to
kvm_pi_disable_wakeup_handler() when vCPU is not in list but I think it
should be safe because of list_empty() check.

>> +
>>  	if (!enable_apicv || !irqchip_in_kernel(vcpu->kvm))
>>  		return 0;
>>  
>> @@ -886,6 +888,20 @@ int avic_init_vcpu(struct vcpu_svm *svm)
>>  	return ret;
>>  }
>>  
>> +void avic_destroy_vcpu(struct vcpu_svm *svm)
>> +{
>> +	if (amd_iommu_gappi && svm->gappi_cpu != -1) {
> 
> Redundant amd_iommu_gappi check?

I am not sure if we should call kvm_pi_disable_wakeup_handler() outside
amd_iommu_gappi check. Although it is safe to do so, I want to have this
call inside amd_iommu_gappi check.

Thanks
Sairaj.

> 
>> +		unsigned long flags;
>> +
>> +		local_irq_save(flags);
>> +
>> +		kvm_pi_disable_wakeup_handler(&svm->vcpu, svm->gappi_cpu);
>> +		svm->gappi_cpu = -1;
> 
> Redundant assignement?
> 
> -Vasant
> 

