Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21DEE22FAD4
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 16:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131391; cv=none; b=IP/JeSl9h1oeL3tDXAfpefXcFLvgzPYt+7CrmrZv39GXCoxcA+vWp740YiGxVuV4SZpm6qJbw4olFBI8U1xDc/YnrQ3fg5pE8Pjz43Ndl39jrMSkC856QlGfO6CdiO9Nj5F8ynNlA9ljUPF4RqLztEMeqx3YCX21RVrtRRRLUDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131391; c=relaxed/simple;
	bh=ui27zm5xeVaAzXi3FmlNniTZbfTn7x5YIb5gF8ry/YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sA17CVr5kgTPtuc5ICf6atDolcYWJqIGCjMwjovLPSHPa22QugeXXKMKbPRFfcM195jnRCzgvOx24rQnKsv3/oFJrwb4skNltGBh16rOHVdJQYN2xkgB8mTdtPiRstTD7alIkHSOYnjBGOJIQjr8bFXk9ZP566fBjRn7a42MP8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RHEN3niv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RHEN3niv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744131387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=E9Oi7X3AFMJmWqGScJGe9PfkTBfxlDnp+fLip/J53BY=;
	b=RHEN3nivuIaBLcrETVvM5eX9zbStnkVnHwld4bibmU6b7FC/SpZuXfGL2z56SnJPllxJ29
	knOOE6YUPhyCBXUFuSRSxbnCJ0P/0y0jCpUZST/OPATAhmyy3Y72Jq17S29NC4O638+VqJ
	AYTgzVoUObhqdnzQgdfccnOtBMIVUig=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-578-LCWLXa7EMc2HlXTtiSuDzg-1; Tue, 08 Apr 2025 12:56:25 -0400
X-MC-Unique: LCWLXa7EMc2HlXTtiSuDzg-1
X-Mimecast-MFC-AGG-ID: LCWLXa7EMc2HlXTtiSuDzg_1744131385
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-ac6b047c0dcso547045966b.0
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 09:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131384; x=1744736184;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E9Oi7X3AFMJmWqGScJGe9PfkTBfxlDnp+fLip/J53BY=;
        b=j/m2C5jsnLTTvD923N03j6Qrrm5yh7vo0Ha/2+1IBZDB4mrBfHaPIqPfLcN+OBB0sz
         Rn2oBSqoEvam9K3qx93LYy8F6nF0bWloJ8f51BqXYgpPGhaW3ESG9dPeB2CKQv8Py1Aa
         X7nqD+pkw0a64CgH4/gy/rBAlD38Xg9DDh87b+S1Ma1xGjCZdoQB3z6Orj0JZrOhHj7P
         GSt9I7mm/u+s4dPGZrZLOjaypN/IJOULm/ql/G7ZANxzUDPf/s1iwSFAhdQoxsw8MGWy
         22UwkFrqpHOmPfW98UTFIKHEyg6SyUIxFNYTUWvyRUiu7yUTAm69xFXuTizoAmaJjHIV
         aGyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUP6Y4o8cG6zJV7OEVol7ZHr7N6oz9rSnq61NuMJsZYP59dDJd0WlERLEXEOh8HmDes4MMHZQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw1SRR/3yjVXpa6fl7xp2/2JYnVm0kzCH3P/MfZRUqUMWZiqmbN
	0MQJvBCehc8SwzobZtEZpwQCjUWXEtYDDPZVLV70wIc0WCaELxr/lxU+OQop0oGMgM2JoRJExME
	nIx8MWSCYiPBWzPyd0TJAmcQLrTF8g7RKsI+x4D76Esq9mY3YEsC3X1yNXb8y
X-Gm-Gg: ASbGncv0FH9B+PoIRd8Q+qmWH4532jjUw+BgxtRfbmO9ra5yl3lVST+Uz6jRFccNnhk
	fhk3Bjqdg2/GG1oKKYvwPxJ/ANGlvD/FNcoweTSN3NV14l8KIcXUYGEYSosSh4mSRjiaYhkq0+P
	j4Z0p4o0SSzFVTLo4Szrt5lwIDH7NHwjybWvqUzk0t382E6OrWSiGYfqkVk6hB183U4R5ru7u5N
	iiQaye49ITHhbsYKxBizchlhOgzG0MfWvCcoJAX9ga7lM9gLrZFVBa0+uHwcWNPCW3ueSzihC82
	0EN9YRWYsYSy3EXVrdRj
X-Received: by 2002:a17:907:1c27:b0:ac7:391b:e684 with SMTP id a640c23a62f3a-ac7d19fbafamr1721931066b.58.1744131384279;
        Tue, 08 Apr 2025 09:56:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFvwZq/8CSJ7jP/bhL9dk7f744UVGAq3vceD1pIVDnxCan5FgHCDdnZvydgz36ZxBMRsmkHog==
X-Received: by 2002:a17:907:1c27:b0:ac7:391b:e684 with SMTP id a640c23a62f3a-ac7d19fbafamr1721927966b.58.1744131383804;
        Tue, 08 Apr 2025 09:56:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.197.100])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f087f0a303sm8700131a12.44.2025.04.08.09.56.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:56:22 -0700 (PDT)
Message-ID: <70eb5830-b7a4-4b8d-990d-7423b23192e5@redhat.com>
Date: Tue, 8 Apr 2025 18:56:21 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 29/67] KVM: SVM: Stop walking list of routing table
 entries when updating IRTE
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-30-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250404193923.1413163-30-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: LKdIP_0Dz_dPbMjYfsVjU27YjnDVtpZOPkCxI7_qT8A_1744131385
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 21:38, Sean Christopherson wrote:
> Now that KVM SVM simply uses the provided routing entry, stop walking the
> routing table to find that entry.  KVM, via setup_routing_entry() and
> sanity checked by kvm_get_msi_route(), disallows having a GSI configured
> to trigger multiple MSIs.

I would squash this with the previous patch.  It's not large when shown 
with -b, and the coexistence of "e" and "new" after patch 28 is weird.

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/avic.c | 106 ++++++++++++++++------------------------
>   1 file changed, 43 insertions(+), 63 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index eb6017b01c5f..685a7b01194b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -852,10 +852,10 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   			unsigned int host_irq, uint32_t guest_irq,
>   			struct kvm_kernel_irq_routing_entry *new)
>   {
> -	struct kvm_kernel_irq_routing_entry *e;
> -	struct kvm_irq_routing_table *irq_rt;
>   	bool enable_remapped_mode = true;
> -	int idx, ret = 0;
> +	struct vcpu_data vcpu_info;
> +	struct vcpu_svm *svm = NULL;
> +	int ret = 0;
>   
>   	if (!kvm_arch_has_assigned_device(kvm) || !kvm_arch_has_irq_bypass())
>   		return 0;
> @@ -869,70 +869,51 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   	pr_debug("SVM: %s: host_irq=%#x, guest_irq=%#x, set=%#x\n",
>   		 __func__, host_irq, guest_irq, !!new);
>   
> -	idx = srcu_read_lock(&kvm->irq_srcu);
> -	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> +	/**
> +	 * Here, we setup with legacy mode in the following cases:
> +	 * 1. When cannot target interrupt to a specific vcpu.
> +	 * 2. Unsetting posted interrupt.
> +	 * 3. APIC virtualization is disabled for the vcpu.
> +	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
> +	 */
> +	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
> +	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
> +	    kvm_vcpu_apicv_active(&svm->vcpu)) {
> +		struct amd_iommu_pi_data pi;
>   
> -	if (guest_irq >= irq_rt->nr_rt_entries ||
> -		hlist_empty(&irq_rt->map[guest_irq])) {
> -		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
> -			     guest_irq, irq_rt->nr_rt_entries);
> -		goto out;
> -	}
> +		enable_remapped_mode = false;
>   
> -	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
> -		struct vcpu_data vcpu_info;
> -		struct vcpu_svm *svm = NULL;
> -
> -		if (e->type != KVM_IRQ_ROUTING_MSI)
> -			continue;
> -
> -		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));
> +		/*
> +		 * Try to enable guest_mode in IRTE.  Note, the address
> +		 * of the vCPU's AVIC backing page is passed to the
> +		 * IOMMU via vcpu_info->pi_desc_addr.
> +		 */
> +		pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
> +					     svm->vcpu.vcpu_id);
> +		pi.is_guest_mode = true;
> +		pi.vcpu_data = &vcpu_info;
> +		ret = irq_set_vcpu_affinity(host_irq, &pi);
>   
>   		/**
> -		 * Here, we setup with legacy mode in the following cases:
> -		 * 1. When cannot target interrupt to a specific vcpu.
> -		 * 2. Unsetting posted interrupt.
> -		 * 3. APIC virtualization is disabled for the vcpu.
> -		 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
> +		 * Here, we successfully setting up vcpu affinity in
> +		 * IOMMU guest mode. Now, we need to store the posted
> +		 * interrupt information in a per-vcpu ir_list so that
> +		 * we can reference to them directly when we update vcpu
> +		 * scheduling information in IOMMU irte.
>   		 */
> -		if (new && !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
> -		    kvm_vcpu_apicv_active(&svm->vcpu)) {
> -			struct amd_iommu_pi_data pi;
> -
> -			enable_remapped_mode = false;
> -
> -			/*
> -			 * Try to enable guest_mode in IRTE.  Note, the address
> -			 * of the vCPU's AVIC backing page is passed to the
> -			 * IOMMU via vcpu_info->pi_desc_addr.
> -			 */
> -			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
> -						     svm->vcpu.vcpu_id);
> -			pi.is_guest_mode = true;
> -			pi.vcpu_data = &vcpu_info;
> -			ret = irq_set_vcpu_affinity(host_irq, &pi);
> -
> -			/**
> -			 * Here, we successfully setting up vcpu affinity in
> -			 * IOMMU guest mode. Now, we need to store the posted
> -			 * interrupt information in a per-vcpu ir_list so that
> -			 * we can reference to them directly when we update vcpu
> -			 * scheduling information in IOMMU irte.
> -			 */
> -			if (!ret && pi.is_guest_mode)
> -				svm_ir_list_add(svm, irqfd, &pi);
> -		}
> -
> -		if (!ret && svm) {
> -			trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
> -						 e->gsi, vcpu_info.vector,
> -						 vcpu_info.pi_desc_addr, !!new);
> -		}
> -
> -		if (ret < 0) {
> -			pr_err("%s: failed to update PI IRTE\n", __func__);
> -			goto out;
> -		}
> +		if (!ret)
> +			ret = svm_ir_list_add(svm, irqfd, &pi);
> +	}
> +
> +	if (!ret && svm) {
> +		trace_kvm_pi_irte_update(host_irq, svm->vcpu.vcpu_id,
> +					 guest_irq, vcpu_info.vector,
> +					 vcpu_info.pi_desc_addr, !!new);
> +	}
> +
> +	if (ret < 0) {
> +		pr_err("%s: failed to update PI IRTE\n", __func__);
> +		goto out;
>   	}
>   
>   	if (enable_remapped_mode)
> @@ -940,7 +921,6 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   	else
>   		ret = 0;
>   out:
> -	srcu_read_unlock(&kvm->irq_srcu, idx);
>   	return ret;
>   }
>   

