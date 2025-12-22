Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC642F6191;
	Mon, 22 Dec 2025 14:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414237; cv=none; b=az9n4djOGuYJTkHfIjYASJ3OGOLsEN07EFuTNn9VAd/WnQqe3MdX6EEpoTP7Q8Oqz0MAY8fG50gFHymDtQTrFoDph9eCnGuVxDo7piS9rp1KvNo087VyHT2Tn8M+2a+5tQW+EYx2f+vUBzmaZjZPfg/fzmupSjb3Pm8YMrYyweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414237; c=relaxed/simple;
	bh=SZAm6zJ37Q2ZZv5+muaWfz5RqEM3fSD2IIVjceAvlJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y1wZ1vo1zpcHWrnMb/LK+t38lWrf+50ZVY9kRJBDsbMT2NmV1d8soHbkZOxq4R8e3PNPJWDkRbePuUVoAF7rZFOrY1q+DDH/W4zKg3HASE4q441M6esFi/eu2rWUj4VyHSc9ZSca7QWLL74KnHTExgAvlg4sVwMsmMkns+r9GTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qt3TN6x8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qt3TN6x8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEBA2C4CEF1;
	Mon, 22 Dec 2025 14:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766414236;
	bh=SZAm6zJ37Q2ZZv5+muaWfz5RqEM3fSD2IIVjceAvlJI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qt3TN6x8ZQV1g5ges+vWN1E5qT30zPvn5wSLwaVNCYv5CaE7v2scphPfC78SHmZFu
	 mkzALcOFJ+V5rf78zsbkLicFTam0yM8lp2Abfub0UfvwwzH7Ss5WgxTLuUcWhQH9kG
	 9IOErza6afnba4FQdGMaJCnw7W9aqR/uiKioePYuJch5nigBFgCyLxkbNgCsRfB5G+
	 iw3add+Q8/oNt7xTRtK7MPlWTUqeZCHTE8eOdiYQFsHayBU22SrFaR2UIgNw8xEEkL
	 nm5DYQjZfes261dUuMNO6bP8x75F1dCbBLv4mR1bqnweOD51HlIAh6a5PZ6zMrdOlg
	 R2z/4AzU2TMWg==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
	maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
	akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
Subject: Re: [PATCH v2 3/4] coco: host: arm64: Handle hostconf RHI calls in
 kernel
In-Reply-To: <c40414b5-ade9-4d2f-bd73-2167e923b3d6@arm.com>
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-4-aneesh.kumar@kernel.org>
 <c40414b5-ade9-4d2f-bd73-2167e923b3d6@arm.com>
Date: Mon, 22 Dec 2025 20:07:06 +0530
Message-ID: <yq5ased2twfh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
>>   - Mark hostconf RHI SMC IDs as handled in the SMCCC filter.
>>   - Return version/features plus PAGE_SIZE alignment for guest queries.
>>   - Drop the 4K page-size guard in RMI init now that realm can query IPA
>>     change alignment size via the hostconf RHI
>> 
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
>> ---
>>   arch/arm64/kvm/hypercalls.c | 23 ++++++++++++++++++++++-
>>   arch/arm64/kvm/rmi.c        |  4 ----
>>   2 files changed, 22 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
>> index 70ac7971416c..2861ca9063dd 100644
>> --- a/arch/arm64/kvm/hypercalls.c
>> +++ b/arch/arm64/kvm/hypercalls.c
>> @@ -8,6 +8,7 @@
>>   
>>   #include <kvm/arm_hypercalls.h>
>>   #include <kvm/arm_psci.h>
>> +#include <asm/rhi.h>
>>   
>>   #define KVM_ARM_SMCCC_STD_FEATURES				\
>>   	GENMASK(KVM_REG_ARM_STD_BMAP_BIT_COUNT - 1, 0)
>> @@ -77,6 +78,9 @@ static bool kvm_smccc_default_allowed(u32 func_id)
>>   	 */
>>   	case ARM_SMCCC_VERSION_FUNC_ID:
>>   	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
>> +	case RHI_HOSTCONF_VERSION:
>> +	case RHI_HOSTCONF_FEATURES:
>> +	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
>>   		return true;
>>   	default:
>>   		/* PSCI 0.2 and up is in the 0:0x1f range */
>> @@ -157,7 +161,15 @@ static int kvm_smccc_filter_insert_reserved(struct kvm *kvm)
>>   			       GFP_KERNEL_ACCOUNT);
>>   	if (r)
>>   		goto out_destroy;
>> -
>> +	/*
>> +	 * Don't forward RHI_HOST_CONF related RHI calls
>> +	 */
>> +	r = mtree_insert_range(&kvm->arch.smccc_filter,
>> +			       RHI_HOSTCONF_VERSION, RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT,
>> +			       xa_mk_value(KVM_SMCCC_FILTER_HANDLE),
>> +			       GFP_KERNEL_ACCOUNT);
>
> minor nit: this is needed only for the Realms ?
>


That is the kvm forwarding of the RHI hostcalls to VMM. We are updating
smccc filter that the SMCCC FID range [RHI_HOSTCONF_VERSION, RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT]
will be handled by the kernel. This is needed because it is the kernel
that is dropping the below check in kvm_init_rmi().

 	/* Only 4k page size on the host is supported */
	if (PAGE_SIZE != SZ_4K)
 		return;

We want to make sure RHI support and dropping of the above check happens
in the same patch and is part of the kernel. 

>
>> +	if (r)
>> +		goto out_destroy;
>>   	return 0;
>>   out_destroy:
>>   	mtree_destroy(&kvm->arch.smccc_filter);
>> @@ -376,6 +388,15 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
>>   	case ARM_SMCCC_TRNG_RND32:
>>   	case ARM_SMCCC_TRNG_RND64:
>>   		return kvm_trng_call(vcpu);
>> +	case RHI_HOSTCONF_VERSION:
>> +		val[0] = RHI_HOSTCONF_VER_1_0;
>> +		break;
>> +	case RHI_HOSTCONF_FEATURES:
>> +		val[0] = __RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT;
>> +		break;
>> +	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
>> +		val[0] = PAGE_SIZE;
>> +		break;
>>   	default:
>>   		return kvm_psci_call(vcpu);
>>   	}
>> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
>> index 9957a71d21b1..bd345e051a24 100644
>> --- a/arch/arm64/kvm/rmi.c
>> +++ b/arch/arm64/kvm/rmi.c
>> @@ -1935,10 +1935,6 @@ EXPORT_SYMBOL_GPL(kvm_has_da_feature);
>>   
>>   void kvm_init_rmi(void)
>>   {
>> -	/* Only 4k page size on the host is supported */
>> -	if (PAGE_SIZE != SZ_4K)
>> -		return;
>
> For the record, these patches doesn't necessarily solve the Host support
> fully. The KVM still needs to support splitting pages for RMM's 4K.
>

We already delegate RMM granules and setup stage 2 in rmm with
RMM_PAGE_SIZE. ie, the shared patchset can be used to setup a 64K host
with 4K Realm running on a RMM using 4K RMM granule size.

>
> That said, this can be ignored as we rebase the KVM to only support
> RMM v2.0, where the Host can set the RMM's Stage2 page size.
>
> Suzuki
>

-aneesh
