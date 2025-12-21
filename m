Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5938309EFA;
	Sun, 21 Dec 2025 20:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766347866; cv=none; b=UHnpn5cABU6xFiHGG1O6XNf1vBtVaIE5YCazKpX+iDoSQeVCm24lusI3FVlNjh/8WEJ8i6kg8ofcojEiyjDI18VyWNHLzcpdomqATrVCGOjDld3l83l1Hi4FxkYWvBZ/rMY4GjXajmKrd/8g8DG5vr3GuDjtX1MAs/AbuZ2qpVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766347866; c=relaxed/simple;
	bh=fvEv76oGt8V3B+GeREgbFg1YQOpI+FtLtZj6QQ7/ZLk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DTW/39tq1lCdT1mP28xnS9lj6P4MdiSkDSUJ+Q1uvD+00Nm7uZgF6qSM8J1vAFr8am1LXbcrIwzGqfD4ntW+pXQk/womyH4o6znxadsr44wN0rg4HCccIDwDBeWuIw4E02OQrWyiwNElY2pHiQD6xXAVPdFQDBhPGVlHyV9RNlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E2F39FEC;
	Sun, 21 Dec 2025 12:10:48 -0800 (PST)
Received: from [10.57.79.145] (unknown [10.57.79.145])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CA7273F778;
	Sun, 21 Dec 2025 12:10:53 -0800 (PST)
Message-ID: <c40414b5-ade9-4d2f-bd73-2167e923b3d6@arm.com>
Date: Sun, 21 Dec 2025 20:10:51 +0000
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] coco: host: arm64: Handle hostconf RHI calls in
 kernel
Content-Language: en-GB
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 linux-coco@lists.linux.dev
Cc: Catalin Marinas <catalin.marinas@arm.com>, will@kernel.org,
 maz@kernel.org, tglx@linutronix.de, robin.murphy@arm.com,
 akpm@linux-foundation.org, jgg@ziepe.ca, steven.price@arm.com
References: <20251221160920.297689-1-aneesh.kumar@kernel.org>
 <20251221160920.297689-4-aneesh.kumar@kernel.org>
From: Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20251221160920.297689-4-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21/12/2025 16:09, Aneesh Kumar K.V (Arm) wrote:
>   - Mark hostconf RHI SMC IDs as handled in the SMCCC filter.
>   - Return version/features plus PAGE_SIZE alignment for guest queries.
>   - Drop the 4K page-size guard in RMI init now that realm can query IPA
>     change alignment size via the hostconf RHI
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> ---
>   arch/arm64/kvm/hypercalls.c | 23 ++++++++++++++++++++++-
>   arch/arm64/kvm/rmi.c        |  4 ----
>   2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/kvm/hypercalls.c b/arch/arm64/kvm/hypercalls.c
> index 70ac7971416c..2861ca9063dd 100644
> --- a/arch/arm64/kvm/hypercalls.c
> +++ b/arch/arm64/kvm/hypercalls.c
> @@ -8,6 +8,7 @@
>   
>   #include <kvm/arm_hypercalls.h>
>   #include <kvm/arm_psci.h>
> +#include <asm/rhi.h>
>   
>   #define KVM_ARM_SMCCC_STD_FEATURES				\
>   	GENMASK(KVM_REG_ARM_STD_BMAP_BIT_COUNT - 1, 0)
> @@ -77,6 +78,9 @@ static bool kvm_smccc_default_allowed(u32 func_id)
>   	 */
>   	case ARM_SMCCC_VERSION_FUNC_ID:
>   	case ARM_SMCCC_ARCH_FEATURES_FUNC_ID:
> +	case RHI_HOSTCONF_VERSION:
> +	case RHI_HOSTCONF_FEATURES:
> +	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
>   		return true;
>   	default:
>   		/* PSCI 0.2 and up is in the 0:0x1f range */
> @@ -157,7 +161,15 @@ static int kvm_smccc_filter_insert_reserved(struct kvm *kvm)
>   			       GFP_KERNEL_ACCOUNT);
>   	if (r)
>   		goto out_destroy;
> -
> +	/*
> +	 * Don't forward RHI_HOST_CONF related RHI calls
> +	 */
> +	r = mtree_insert_range(&kvm->arch.smccc_filter,
> +			       RHI_HOSTCONF_VERSION, RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT,
> +			       xa_mk_value(KVM_SMCCC_FILTER_HANDLE),
> +			       GFP_KERNEL_ACCOUNT);

minor nit: this is needed only for the Realms ?

> +	if (r)
> +		goto out_destroy;
>   	return 0;
>   out_destroy:
>   	mtree_destroy(&kvm->arch.smccc_filter);
> @@ -376,6 +388,15 @@ int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
>   	case ARM_SMCCC_TRNG_RND32:
>   	case ARM_SMCCC_TRNG_RND64:
>   		return kvm_trng_call(vcpu);
> +	case RHI_HOSTCONF_VERSION:
> +		val[0] = RHI_HOSTCONF_VER_1_0;
> +		break;
> +	case RHI_HOSTCONF_FEATURES:
> +		val[0] = __RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT;
> +		break;
> +	case RHI_HOSTCONF_GET_IPA_CHANGE_ALIGNMENT:
> +		val[0] = PAGE_SIZE;
> +		break;
>   	default:
>   		return kvm_psci_call(vcpu);
>   	}
> diff --git a/arch/arm64/kvm/rmi.c b/arch/arm64/kvm/rmi.c
> index 9957a71d21b1..bd345e051a24 100644
> --- a/arch/arm64/kvm/rmi.c
> +++ b/arch/arm64/kvm/rmi.c
> @@ -1935,10 +1935,6 @@ EXPORT_SYMBOL_GPL(kvm_has_da_feature);
>   
>   void kvm_init_rmi(void)
>   {
> -	/* Only 4k page size on the host is supported */
> -	if (PAGE_SIZE != SZ_4K)
> -		return;

For the record, these patches doesn't necessarily solve the Host support
fully. The KVM still needs to support splitting pages for RMM's 4K.

That said, this can be ignored as we rebase the KVM to only support
RMM v2.0, where the Host can set the RMM's Stage2 page size.

Suzuki

> -
>   	/* Continue without realm support if we can't agree on a version */
>   	if (rmi_check_version())
>   		return;

