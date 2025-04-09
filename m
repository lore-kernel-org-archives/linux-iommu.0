Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2157625C6E3
	for <iommu@lists.linux.dev>; Wed,  9 Apr 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744194886; cv=none; b=ADtakDPzhrph+olpzsYE2bR+6waN9oZXtu8U+mZjPLSX1U5zdc8bzA9nEzKM5rZ5sArvcJEsNJzopMOY9l+HDUA2/Lfc3nGdB4tyCdOaKmOIyTwOAqa7bgutTJLE5NRa4+xKlcpqvXj+4axBCssen9ojZX3ggNu5vSkTYlioBE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744194886; c=relaxed/simple;
	bh=olQZtL56G3qiiGSixDoFhUE1yoNM/sKK2exsoUb/CtE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ftLFiJPm2Q8kvj3+aabvmSoraqJoqvSGX1qul2L+QzQNnv3NjpLuHCQUri2D2iUdcBZP3Dsf3LS5B+PuSFZNOVYe8AGiRMhUZWkC3t5rzodD/plfX5bx/0fsyfdwUFMtVwCgpk5P01SYD3Is4MDjOKCHWbL3wQX2tMrqQpBeKYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OvOlpZPS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OvOlpZPS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744194883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=4H8PRcz9kE5G+sMw4/i5Qo16r31sg5CuatyJyR3ID10=;
	b=OvOlpZPStf10qOFt23/3a5wKStTwwXAd3K0QCZfaqFqGIFJGHn9sB/Xui3znHpJH0n4vcY
	ck84eV4WmmZJjS7q+1SPkBhHZWn136Lwf/V05Jks/YPP3kvPZ/C7vzQuNY/BvsoIdUNKSb
	dxUpwySkFBuEbxskdR95tc1pQouYbyA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-XU8JDMG5NJy5OnIouTSN9A-1; Wed, 09 Apr 2025 06:34:41 -0400
X-MC-Unique: XU8JDMG5NJy5OnIouTSN9A-1
X-Mimecast-MFC-AGG-ID: XU8JDMG5NJy5OnIouTSN9A_1744194881
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-391425471d6so2485838f8f.3
        for <iommu@lists.linux.dev>; Wed, 09 Apr 2025 03:34:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744194881; x=1744799681;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4H8PRcz9kE5G+sMw4/i5Qo16r31sg5CuatyJyR3ID10=;
        b=UN2pdu1W7JVZfFBSnYXoEmn/G6CRd2XAU2B7U98z8r6tGbbnWYoI040DNQYT4NtJvv
         MT2vGeA/OkrNKfYXETBxN5umT9/aaPApvVX+DE56U7Gv3M6HpynM5pqkzhgFz0l0NI//
         QaOJeDqEY1V0eO7qClBRC69mNLMf1yeXmiAdYb21AwIPJ0Uduy2q4x+7m34rAwZIK465
         Fy08QGG+1BkFeTmoYVMbHuM/0LTKYXRJUCvPxBXBgr5PwXKXCNpQczeX0FVLQMt8bfB0
         ztcAQC3Uew1JU0tJzEvUHqZFt+OeqLlnkkFUQpoNknjTbPqnI8eWLcSXMsnbixAPBOLs
         TdWA==
X-Forwarded-Encrypted: i=1; AJvYcCVIbp/aT09cJD5PAIjIFIpOG6kQcNToVTkEgZIft8NcJFDXo7Q/tMskuVSRvBrsoCMt6VLOUw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwOP6ef23RI/FDd5SjNOc2OML/d2KRLVrJuikg8Mugw0KhXfOY7
	wx51wzsknuf59kpmdDyuVoL3pOI4MdvrVyPnKl+KJpR9BQj56wMR5K/C8FZ4tJ08r1Y825g4LXa
	1SrQlm1q6iPK2YyAjbvHJ5hNydvoknDBoKi1gHoo20QNJGgHS5g3H
X-Gm-Gg: ASbGncu412AqGVkvj/3f7354MIUZT7Ahut+jbrv8EHfjpwYUQDTQoK4kOul/S+MGptC
	uDw1h9zb3JaDtFAkP6ITmcJ+92dJGtXqD+NVfWgbUpmzPiUIo9xp8Zd3AdsCnv2Y7EMzkTFd2Jf
	eZxstkf8jJqx7EBSVCMKZvLHF0vZyHmZOEm4PyMaGYvJIHLzV6q1QGTqg9wZBe6VUJyKdgzjlCw
	jL72p2WlpPJttjJa+l7p3oc/Hnl6rFaiXR8QmVjCXSw0HvjNBwOkds7WmS4XFePQ9S0uM7kw3v5
	fPoANmky1O9BA7MUBg==
X-Received: by 2002:a05:6000:4022:b0:399:6dc0:f15b with SMTP id ffacd0b85a97d-39d88569a25mr1721402f8f.48.1744194880711;
        Wed, 09 Apr 2025 03:34:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoPbh5ydBfBUIym2SO8+VAgmiWv7o/xlS5KOZTpx13Fg+rZSyZ0ck7d2mzyA9Fu3/NC39+GQ==
X-Received: by 2002:a05:6000:4022:b0:399:6dc0:f15b with SMTP id ffacd0b85a97d-39d88569a25mr1721375f8f.48.1744194880305;
        Wed, 09 Apr 2025 03:34:40 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.110.254])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39d89376f39sm1229222f8f.21.2025.04.09.03.34.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Apr 2025 03:34:39 -0700 (PDT)
Message-ID: <352949ba-e4b8-477b-ad48-eb5e8aa57d86@redhat.com>
Date: Wed, 9 Apr 2025 12:34:38 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 65/67] KVM: SVM: Generate GA log IRQs only if the
 associated vCPUs is blocking
To: Sean Christopherson <seanjc@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-66-seanjc@google.com>
 <4c396e79-845a-481a-8a3e-4a7f458371b8@redhat.com>
 <Z_WVsZQbY23XrhAG@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <Z_WVsZQbY23XrhAG@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UiCEzKV9AHRYZmDiaAA9WASi-Gucvl7Aqoeeh2OZ3s0_1744194881
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/8/25 23:31, Sean Christopherson wrote:
> On Tue, Apr 08, 2025, Paolo Bonzini wrote:
>> On 4/4/25 21:39, Sean Christopherson wrote:
>>> @@ -892,7 +893,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
>>>    	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
>>> -	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic);
>>> +	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic, false);
>>>    	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
>>>    }
>>> @@ -912,7 +913,8 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>>>    	__avic_vcpu_load(vcpu, cpu, false);
>>>    }
>>> -static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic)
>>> +static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
>>> +			    bool is_blocking)
>>
>> What would it look like to use an enum { SCHED_OUT, SCHED_IN, ENABLE_AVIC,
>> DISABLE_AVIC, START_BLOCKING } for both __avic_vcpu_put and
>> __avic_vcpu_load's second argument?
> 
> There's gotta be a way to make it look better than this code.  I gave a half-
> hearted attempt at using an enum before posting, but wasn't able to come up with
> anything decent.
> 
> Coming back to it with fresh eyes, what about this (full on-top diff below)?
> 
> enum avic_vcpu_action {
> 	AVIC_SCHED_IN		= 0,
> 	AVIC_SCHED_OUT		= 0,
> 	AVIC_START_BLOCKING	= BIT(0),
> 
> 	AVIC_TOGGLE_ON_OFF	= BIT(1),
> 	AVIC_ACTIVATE		= AVIC_TOGGLE_ON_OFF,
> 	AVIC_DEACTIVATE		= AVIC_TOGGLE_ON_OFF,
> };
> 
> AVIC_SCHED_IN and AVIC_SCHED_OUT are essentially syntactic sugar, as are
> AVIC_ACTIVATE and AVIC_DEACTIVATE to a certain extent.  But it's much better than
> booleans, and using a bitmask makes avic_update_iommu_vcpu_affinity() slightly
> prettier.

Even just the bitmask at least makes it clear what is "true" and what is 
"false" (which is obvious but I never thought about it this way, you 
never stop learning).

You decide whether you prefer the syntactic sugar or not.

Paolo

>> Consecutive bools are ugly...
> 
> Yeah, I hated it when I wrote it, and still hate it now.
> 
> And more error prone, e.g. the __avic_vcpu_put() call from avic_refresh_apicv_exec_ctrl()
> should specify is_blocking=false, not true, as kvm_x86_ops.refresh_apicv_exec_ctrl()
> should never be called while the vCPU is blocking.
> 
> ---
>   arch/x86/kvm/svm/avic.c | 41 ++++++++++++++++++++++++++++-------------
>   1 file changed, 28 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 425674e1a04c..1752420c68aa 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -833,9 +833,20 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   	return irq_set_vcpu_affinity(host_irq, NULL);
>   }
>   
> +enum avic_vcpu_action {
> +	AVIC_SCHED_IN		= 0,
> +	AVIC_SCHED_OUT		= 0,
> +	AVIC_START_BLOCKING	= BIT(0),
> +
> +	AVIC_TOGGLE_ON_OFF	= BIT(1),
> +	AVIC_ACTIVATE		= AVIC_TOGGLE_ON_OFF,
> +	AVIC_DEACTIVATE		= AVIC_TOGGLE_ON_OFF,
> +};
> +
>   static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
> -					    bool toggle_avic, bool ga_log_intr)
> +					    enum avic_vcpu_action action)
>   {
> +	bool ga_log_intr = (action & AVIC_START_BLOCKING);
>   	struct amd_svm_iommu_ir *ir;
>   	struct vcpu_svm *svm = to_svm(vcpu);
>   
> @@ -849,7 +860,7 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
>   		return;
>   
>   	list_for_each_entry(ir, &svm->ir_list, node) {
> -		if (!toggle_avic)
> +		if (!(action & AVIC_TOGGLE_ON_OFF))
>   			WARN_ON_ONCE(amd_iommu_update_ga(ir->data, cpu, ga_log_intr));
>   		else if (cpu >= 0)
>   			WARN_ON_ONCE(amd_iommu_activate_guest_mode(ir->data, cpu, ga_log_intr));
> @@ -858,7 +869,8 @@ static void avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu,
>   	}
>   }
>   
> -static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
> +static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu,
> +			     enum avic_vcpu_action action)
>   {
>   	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
>   	int h_physical_id = kvm_cpu_get_apicid(cpu);
> @@ -904,7 +916,7 @@ static void __avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu, bool toggle_avic)
>   
>   	WRITE_ONCE(kvm_svm->avic_physical_id_table[vcpu->vcpu_id], entry);
>   
> -	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, toggle_avic, false);
> +	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, action);
>   
>   	spin_unlock_irqrestore(&svm->ir_list_lock, flags);
>   }
> @@ -921,11 +933,10 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>   	if (kvm_vcpu_is_blocking(vcpu))
>   		return;
>   
> -	__avic_vcpu_load(vcpu, cpu, false);
> +	__avic_vcpu_load(vcpu, cpu, AVIC_SCHED_IN);
>   }
>   
> -static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
> -			    bool is_blocking)
> +static void __avic_vcpu_put(struct kvm_vcpu *vcpu, enum avic_vcpu_action action)
>   {
>   	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
>   	struct vcpu_svm *svm = to_svm(vcpu);
> @@ -947,7 +958,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
>   	 */
>   	spin_lock_irqsave(&svm->ir_list_lock, flags);
>   
> -	avic_update_iommu_vcpu_affinity(vcpu, -1, toggle_avic, is_blocking);
> +	avic_update_iommu_vcpu_affinity(vcpu, -1, action);
>   
>   	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR);
>   
> @@ -964,7 +975,7 @@ static void __avic_vcpu_put(struct kvm_vcpu *vcpu, bool toggle_avic,
>   	 * Note!  Don't set AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR in the table as
>   	 * it's a synthetic flag that usurps an unused a should-be-zero bit.
>   	 */
> -	if (is_blocking)
> +	if (action & AVIC_START_BLOCKING)
>   		entry |= AVIC_PHYSICAL_ID_ENTRY_GA_LOG_INTR;
>   
>   	svm->avic_physical_id_entry = entry;
> @@ -992,7 +1003,8 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
>   			return;
>   	}
>   
> -	__avic_vcpu_put(vcpu, false, kvm_vcpu_is_blocking(vcpu));
> +	__avic_vcpu_put(vcpu, kvm_vcpu_is_blocking(vcpu) ? AVIC_START_BLOCKING :
> +							   AVIC_SCHED_OUT);
>   }
>   
>   void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
> @@ -1024,12 +1036,15 @@ void avic_refresh_apicv_exec_ctrl(struct kvm_vcpu *vcpu)
>   	if (!enable_apicv)
>   		return;
>   
> +	/* APICv should only be toggled on/off while the vCPU is running. */
> +	WARN_ON_ONCE(kvm_vcpu_is_blocking(vcpu));
> +
>   	avic_refresh_virtual_apic_mode(vcpu);
>   
>   	if (kvm_vcpu_apicv_active(vcpu))
> -		__avic_vcpu_load(vcpu, vcpu->cpu, true);
> +		__avic_vcpu_load(vcpu, vcpu->cpu, AVIC_ACTIVATE);
>   	else
> -		__avic_vcpu_put(vcpu, true, true);
> +		__avic_vcpu_put(vcpu, AVIC_DEACTIVATE);
>   }
>   
>   void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
> @@ -1055,7 +1070,7 @@ void avic_vcpu_blocking(struct kvm_vcpu *vcpu)
>   	 * CPU and cause noisy neighbor problems if the VM is sending interrupts
>   	 * to the vCPU while it's scheduled out.
>   	 */
> -	__avic_vcpu_put(vcpu, false, true);
> +	__avic_vcpu_put(vcpu, AVIC_START_BLOCKING);
>   }
>   
>   void avic_vcpu_unblocking(struct kvm_vcpu *vcpu)
> 
> base-commit: fe5b44cf46d5444ff071bc2373fbe7b109a3f60b

