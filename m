Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C635125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDRQ47XB"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/wFXkRm4gY14hMhsAT8GvHSV1B4LV0i4em53ilYk8fI=;
	b=NDRQ47XBUlyDnDp11fc/UQlPAfh1tbOO/nDg+cPZzyfD+O0aNv4Rd7nhWR36td8Cwx3O3j
	90RfhUw2nqSuS55xNcZwL/+PTJpR9asTbjxxSpB+WpntMlO0wSsCDyZG/74Mov6+IO38NB
	u0C26GYfMOMeDIp+uKEHYqYJtvawCUU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-tVAJaDF1NyaDpH9WaoEZ7A-1; Thu, 05 Oct 2023 08:51:29 -0400
X-MC-Unique: tVAJaDF1NyaDpH9WaoEZ7A-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-32323283257so801810f8f.2
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:51:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510288; x=1697115088;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/wFXkRm4gY14hMhsAT8GvHSV1B4LV0i4em53ilYk8fI=;
        b=QcinzdX6aTYH3ZUVgcSYP/U0ooRMsIgM9N37ko2NJAGEsPWo20h087dj5hjrSNuX8+
         a9iHZCXhPS0K9dPQrSdU2jDD9UQuw/LIyR9pGu6WwbE0wQcVEiDAOSeboxY51+IpM7a7
         5prhkR0uXqpVdIEweF97X+0YTPf6lFyTfuxMPg1V71VtP0dgjBDZ3jnzEulLRLozr5Tm
         NNq5t+mTbTY/C//TD985L+r2T1KgZFs/RGjTboEV404K5I0ixjls7I7Ep76IHQ9wDBpb
         nNqRY5hvjHgY64UfNvJer7fxHZ6JoPsHXKSZDdL5KtTlq1MwF6mL0AwhTozLB+Bj00vf
         x0rw==
X-Gm-Message-State: AOJu0YzfsmdcnNlQLJaiHfQwTXW/6RRHWHWhyaozV96QZEPDuhvWjE6I
	Qy70Vp/Ts62ebuZtZk/CNJ6lu4SfpD5mKTjjMhfS3wANfj3Aq+ABZwp1wSRLXpfwUyFIA//T54x
	tp2ESWOrLdfOeWmQ=
X-Received: by 2002:a05:6000:108d:b0:31f:a62d:264 with SMTP id y13-20020a056000108d00b0031fa62d0264mr4737274wrw.37.1696510288049;
        Thu, 05 Oct 2023 05:51:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXTzdXlNC9fz+PgD6KTMShrngrXbnyjvf54XpsWr2w2xQiZBM3CY1iJbVUEVIYWDGQd06vjw==
X-Received: by 2002:a05:6000:108d:b0:31f:a62d:264 with SMTP id y13-20020a056000108d00b0031fa62d0264mr4737259wrw.37.1696510287743;
        Thu, 05 Oct 2023 05:51:27 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id b2-20020a5d5502000000b00323330edbc7sm1730082wrv.20.2023.10.05.05.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:51:27 -0700 (PDT)
Message-ID: <08a44cace7c5da396b5b81415a66eaa1737c2a8b.camel@redhat.com>
Subject: Re: [PATCH 07/10] KVM: SVM: Inhibit AVIC if ID is too big instead
 of rejecting vCPU creation
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:51:25 +0300
In-Reply-To: <20230815213533.548732-8-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-8-seanjc@google.com>
User-Agent: Evolution 3.36.5 (3.36.5-2.fc32)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

У вт, 2023-08-15 у 14:35 -0700, Sean Christopherson пише:
> Inhibit AVIC with a new "ID too big" flag if userspace creates a vCPU with
> an ID that is too big, but otherwise allow vCPU creation to succeed.
> Rejecting KVM_CREATE_VCPU with EINVAL violates KVM's ABI as KVM advertises
> that the max vCPU ID is 4095, but disallows creating vCPUs with IDs bigger
> than 254 (AVIC) or 511 (x2AVIC).
> 
> Alternatively, KVM could advertise an accurate value depending on which
> AVIC mode is in use, but that wouldn't really solve the underlying problem,
> e.g. would be a breaking change if KVM were to ever try and enable AVIC or
> x2AVIC by default.
> 
> Cc: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/kvm_host.h |  6 ++++++
>  arch/x86/kvm/svm/avic.c         | 16 ++++++++++++++--
>  arch/x86/kvm/svm/svm.h          |  3 ++-
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/kvm_host.h b/arch/x86/include/asm/kvm_host.h
> index 60d430b4650f..4c2d659a1269 100644
> --- a/arch/x86/include/asm/kvm_host.h
> +++ b/arch/x86/include/asm/kvm_host.h
> @@ -1243,6 +1243,12 @@ enum kvm_apicv_inhibit {
>  	 * mapping between logical ID and vCPU.
>  	 */
>  	APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED,
> +
> +	/*
> +	 * AVIC is disabled because the vCPU's APIC ID is beyond the max
> +	 * supported by AVIC/x2AVIC, i.e. the vCPU is unaddressable.
> +	 */
> +	APICV_INHIBIT_REASON_ID_TOO_BIG,

I prefer APICV_INHIBIT_REASON_PHYSICAL_ID_TOO_BIG

>  };
>  
>  struct kvm_arch {
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index bd81e3517838..522feaa711b4 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -284,9 +284,21 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	int id = vcpu->vcpu_id;
>  	struct vcpu_svm *svm = to_svm(vcpu);
>  
> +	/*
> +	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
> +	 * hardware.  Do so immediately, i.e. don't defer the update via a
> +	 * request, as avic_vcpu_load() expects to be called if and only if the
> +	 * vCPU has fully initialized AVIC.  Bypass all of the helpers and just
> +	 * clear apicv_active directly, the vCPU isn't reachable and the VMCB
> +	 * isn't even initialized at this point, i.e. there is no possibility
> +	 * of needing to deal with the n

Which helpers do you bypass? I see a call to normal kvm_set_apicv_inhibit() as it should be.

Note that userspace can add vCPUs at will so this can happen any time during 
the guest's lifetime so I don't think that this code can bypass anything.

> +	 */
>  	if ((!x2avic_enabled && id > AVIC_MAX_PHYSICAL_ID) ||
> -	    (id > X2AVIC_MAX_PHYSICAL_ID))
> -		return -EINVAL;
> +	    (id > X2AVIC_MAX_PHYSICAL_ID)) {
> +		kvm_set_apicv_inhibit(vcpu->kvm, APICV_INHIBIT_REASON_ID_TOO_BIG);
> +		vcpu->arch.apic->apicv_active = false;
> +		return 0;
> +	}
>  
>  	if (!vcpu->arch.apic->regs)
>  		return -EINVAL;
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index a9fde1bb85ee..8b798982e5d0 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -632,7 +632,8 @@ extern struct kvm_x86_nested_ops svm_nested_ops;
>  	BIT(APICV_INHIBIT_REASON_PHYSICAL_ID_ALIASED) |	\
>  	BIT(APICV_INHIBIT_REASON_APIC_ID_MODIFIED) |	\
>  	BIT(APICV_INHIBIT_REASON_APIC_BASE_MODIFIED) |	\
> -	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED)	\
> +	BIT(APICV_INHIBIT_REASON_LOGICAL_ID_ALIASED) |	\
> +	BIT(APICV_INHIBIT_REASON_ID_TOO_BIG)		\

>  )
>  
>  bool avic_hardware_setup(void);


Best regards,
	Maxim Levitsky



