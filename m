Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527F19CD14
	for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 15:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719244139; cv=none; b=iggO/qtswcYMuvuOXED7DaULQGtd30hn5VFH4RNAQzogu5RAVd6K+8ok7LBhcQoStcxd4lsH2W/kQwEJrIrDswK2ygFxJhbd6LyYtsEzTlzOLAa895iS5Xyn0wL3O1PYTKC9OaqZpG8gvEy75/KQpOd++dkslQQaSnWPDRIbQv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719244139; c=relaxed/simple;
	bh=GqaP3vGD7gvrzGgNXX4qO07+i06y1ReV6MZ9SSpLyZk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=e6CZ175QBVNNblgXIEXcFuBHcfPlYLLHxcxRBqBh0d7KgLaeW+35vmF9tv8Y/kLXMYDagFGjsJXqX17d29oLzSh64+NOQhIscenRAaShYsOjBpLJy1Lc+O4Zi8V77WTX3Q/McpQjmTgipYebSIt8JbtFuNv69lIuxl5sw+P+cqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HtCxv0vb; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HtCxv0vb"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dfdff0a9f26so8277845276.1
        for <iommu@lists.linux.dev>; Mon, 24 Jun 2024 08:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719244136; x=1719848936; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=w0TfFi1A5eAUOELglH+ORGjDb5xIqjGuRnaKSa2m3Gs=;
        b=HtCxv0vbBmY2+9yHlwyieFyCkaAmqt2tbYogLDk8re7kiKFsyQ3BXCdCqrnkaq8wDc
         E/ELxBH6x7+TC6aGQeTh1eyZO0SRrQN5kxSa25v2QsAOhml4dyMJLcd9oU5PSJMFubvL
         yp3+o++UUNWn+gyFlYIBL3MfkJfcAxstrU0HFfewfM6/TpD3gGyJIZNqL4mEzh31Wmi6
         buWAqJoDAxA6sSDuEy+BXLuO43Ou5z8Wfc9TJTKmjhbsvI4pLk1/tEehdequ6XkkmnJ3
         YMxlFmFx/FzzIqyNMH3Ue1Md+yiUWpV+isZ8Bhpi1QBYZU0Qsx5RpnZpEUvCM4jTb+ca
         D2mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719244136; x=1719848936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w0TfFi1A5eAUOELglH+ORGjDb5xIqjGuRnaKSa2m3Gs=;
        b=WE7DCTSkrrWi9CkTX39GfKLc8B/2dPba9OdxYumFQjhIYsuLOyYYwb4s8f8MZVOKuV
         lK1aZC3qmPvOtuttm8mKoF7AmDBBr546V8yWX2dK8RByLXI7PLLaMbpVQd+RAKoQkGPD
         pzVNNRoPqPGZ3dMBcNgucdQTS0uG/66F70LYOL2RCgy3LwwEqGt8lMIlwyz4dPS/Aa7E
         Bmtss1Dhabp5e99j+dwkzhsiUxnDjGHk3fMsjO9Ydtkl2lbK2m7a4MQu4b1/ZhrjLGpM
         O7p3PIwCD7beVb3arnWXT5mfJUgWxOFlWPvUB1Mz8cIcSsCak0SgkFDy/mc76swPM1AS
         QNRw==
X-Forwarded-Encrypted: i=1; AJvYcCXb6AYHpfYMetedOnYlndiFjgOcCVfYNPTcUnFY7Gkw6a8aNjyCO12DFIGN+fKRKUBfvofgGo8W6mtUnUHLdWKQB1YH2Y4=
X-Gm-Message-State: AOJu0Yw7mEOF/liqqIR/bWqGRkphwcB4f0WwtC5UFQchKu23sEqFLyo4
	2nT5YJhaJqkxQA1mi4gioASqtDSjwOkthL1XeVCR0cZvgJsrIsp0KisFPYgGajOwtqqBqC1fAZA
	eJA==
X-Google-Smtp-Source: AGHT+IF8kv5cg7jBtfLj5KChqQb0E4AVt+N3NAFysUC46dBIyhEpZe/ChMcBWGfHF7p7NpzSNPuuniqMZ0A=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:705:b0:df4:8ecb:ae57 with SMTP id
 3f1490d57ef6-e030108f81cmr16300276.10.1719244135814; Mon, 24 Jun 2024
 08:48:55 -0700 (PDT)
Date: Mon, 24 Jun 2024 08:48:54 -0700
In-Reply-To: <20240208151837.35068-2-shameerali.kolothum.thodi@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20240208151837.35068-1-shameerali.kolothum.thodi@huawei.com> <20240208151837.35068-2-shameerali.kolothum.thodi@huawei.com>
Message-ID: <ZnmVZo8awnuFdQjz@google.com>
Subject: Re: [RFC PATCH v2 1/7] KVM: Add generic infrastructure to support
 pinned VMIDs
From: Sean Christopherson <seanjc@google.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Cc: kvmarm@lists.linux.dev, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com, 
	kevin.tian@intel.com, jgg@ziepe.ca, alex.williamson@redhat.com, 
	maz@kernel.org, oliver.upton@linux.dev, will@kernel.org, robin.murphy@arm.com, 
	jean-philippe@linaro.org, jonathan.cameron@huawei.com
Content-Type: text/plain; charset="us-ascii"

On Thu, Feb 08, 2024, Shameer Kolothum wrote:
> Provide generic helper functions to get/put pinned VMIDs if the arch
> supports it.

IMO, this has no business being in generic KVM.  Multiple architectures have
constructs that are _similar_ ARM's VMID, but AFAICT the exact semantics are very
ARM specific.  I.e. odds are very good that the only thing that can actually use
kvm_pinned_vmid_get() is the SMMU, because the concept won't fit any other
architecture.

The other issue is that other architectures support building KVM as a module,
which makes it much more difficult to guarantee the safety of these hooks.

> Signed-off-by: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
> ---
>  include/linux/kvm_host.h | 18 ++++++++++++++++++
>  virt/kvm/Kconfig         |  3 +++
>  virt/kvm/kvm_main.c      | 23 +++++++++++++++++++++++
>  3 files changed, 44 insertions(+)
> 
> diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> index 7e7fd25b09b3..610e239bea46 100644
> --- a/include/linux/kvm_host.h
> +++ b/include/linux/kvm_host.h
> @@ -2311,6 +2311,24 @@ static inline void kvm_handle_signal_exit(struct kvm_vcpu *vcpu)
>  }
>  #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
>  
> +#ifdef CONFIG_HAVE_KVM_PINNED_VMID
> +int kvm_arch_pinned_vmid_get(struct kvm *kvm);
> +void kvm_arch_pinned_vmid_put(struct kvm *kvm);
> +#endif
> +
> +#ifdef CONFIG_HAVE_KVM_PINNED_VMID
> +int kvm_pinned_vmid_get(struct kvm *kvm);
> +void kvm_pinned_vmid_put(struct kvm *kvm);
> +#else
> +static inline int kvm_pinned_vmid_get(struct kvm *kvm)
> +{
> +	return -EINVAL;
> +}
> +
> +static inline void kvm_pinned_vmid_put(struct kvm *kvm)
> +{
> +}
> +#endif
>  /*
>   * If more than one page is being (un)accounted, @virt must be the address of
>   * the first page of a block of pages what were allocated together (i.e
> diff --git a/virt/kvm/Kconfig b/virt/kvm/Kconfig
> index 184dab4ee871..a3052c8e3ac4 100644
> --- a/virt/kvm/Kconfig
> +++ b/virt/kvm/Kconfig
> @@ -108,3 +108,6 @@ config KVM_GENERIC_PRIVATE_MEM
>         select KVM_GENERIC_MEMORY_ATTRIBUTES
>         select KVM_PRIVATE_MEM
>         bool
> +
> +config HAVE_KVM_PINNED_VMID
> +       bool
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 10bfc88a69f7..f84d6da5f464 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -3918,6 +3918,29 @@ bool kvm_vcpu_wake_up(struct kvm_vcpu *vcpu)
>  }
>  EXPORT_SYMBOL_GPL(kvm_vcpu_wake_up);
>  
> +#ifdef CONFIG_HAVE_KVM_PINNED_VMID
> +int kvm_pinned_vmid_get(struct kvm *kvm)
> +{
> +	int ret;
> +
> +	if (!kvm_get_kvm_safe(kvm))
> +		return -ENOENT;
> +	ret  = kvm_arch_pinned_vmid_get(kvm);
> +	if (ret < 0)
> +		kvm_put_kvm(kvm);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(kvm_pinned_vmid_get);
> +
> +void kvm_pinned_vmid_put(struct kvm *kvm)
> +{
> +	kvm_arch_pinned_vmid_put(kvm);
> +	kvm_put_kvm(kvm);
> +}
> +EXPORT_SYMBOL_GPL(kvm_pinned_vmid_put);
> +#endif
> +
>  #ifndef CONFIG_S390
>  /*
>   * Kick a sleeping VCPU, or a guest VCPU in guest mode, into host kernel mode.
> -- 
> 2.34.1
> 
