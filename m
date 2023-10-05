Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F51125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEfGYb8Q"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/v0adbAqkr0AOlDohQDmkNPQwTJI1a9Z/VKG7A0hBWA=;
	b=gEfGYb8Qhfhlb2nsPwIA0BvXzYZsCvQJsTRtSCq6BUkFzLv7eIseLM6XXMxhA8UViChJHs
	Bj6UuhToIIcWzCixtQfzLFYpHBps6aCzrfTNBCZATe77MV+bDbOGFopw8f8EFXp2SixWrz
	i+QIcjxCUrWj6rjAcVcWt4iynaMXvy8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-189-8e8r4kHVML-NhcLwW9kqsA-1; Thu, 05 Oct 2023 08:50:19 -0400
X-MC-Unique: 8e8r4kHVML-NhcLwW9kqsA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-9b65d7079faso73199866b.1
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:50:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510218; x=1697115018;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/v0adbAqkr0AOlDohQDmkNPQwTJI1a9Z/VKG7A0hBWA=;
        b=tmWYXDm6sEmiXLMwqM6gEnNnzCr6Sw9881YfrtQXdNCIJe992R6U+P4nJpti5E/8va
         k5Ppj+FAIfVVxSPL2hQpWAKekrVnQ3LteYRvzR4aN2GBbTHHVbrT7iR+rVtUIF+PihLf
         daGkALsqHMhQYptGbxVufM0VOVO5S/3ZAlEabhKlPzJwxedXEFdGpNLw2j/whLj41Tw5
         tq3NIvg8tT+HDRL5GyNYnZHTE5lH8GomZ0i8SthR/0NeIm/8hNBnnxpBx88I6omvusyI
         huBnoqSN21cGYcgmV4ofV+kkNDt/1RZrcSOBBdGfbXk5dY1XyACqzG6ef9HJmqZYLH//
         EJjw==
X-Gm-Message-State: AOJu0Yw3UDvoNQRqkORirMBtcYd3OGgsseDKYY9KoVxsY7C5r1R/x3O+
	BFk+JBUL/6i3m8gapa2efUTI9MVFfVhVeosmoAtwQaLCNZy0ySxWB0PtlPDnfs3b3NB0sdpFyZW
	5bQaxtWFKf6FX0uk=
X-Received: by 2002:a17:906:7695:b0:9a9:f042:dec0 with SMTP id o21-20020a170906769500b009a9f042dec0mr5192581ejm.38.1696510218114;
        Thu, 05 Oct 2023 05:50:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2efrRPPi83JP91rlrZljdGCEsxo2DgTBNLkMExdPWWdkcKxpdXsDYMgxNAP+P4MsbasM+Fg==
X-Received: by 2002:a17:906:7695:b0:9a9:f042:dec0 with SMTP id o21-20020a170906769500b009a9f042dec0mr5192565ejm.38.1696510217875;
        Thu, 05 Oct 2023 05:50:17 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id i2-20020a05600c290200b004063d8b43e7sm3701061wmd.48.2023.10.05.05.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:50:17 -0700 (PDT)
Message-ID: <e1fa222fb8b48d5268a8be85dbb66e91af45e89a.camel@redhat.com>
Subject: Re: [PATCH 04/10] KVM: SVM: Add helper to deduplicate code for
 getting AVIC backing page
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:50:15 +0300
In-Reply-To: <20230815213533.548732-5-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-5-seanjc@google.com>
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
> Add a helper to get the physical address of the AVIC backing page, both
> to deduplicate code and to prepare for getting the address directly from
> apic->regs, at which point it won't be all that obvious that the address
> in question is what SVM calls the AVIC backing page.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index b8313f2d88fa..954bdb45033b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -241,14 +241,18 @@ int avic_vm_init(struct kvm *kvm)
>  	return err;
>  }
>  
> +static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
> +{
> +	return __sme_set(page_to_phys(svm->avic_backing_page));
> +}
> +
>  void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  {
>  	struct kvm_svm *kvm_svm = to_kvm_svm(svm->vcpu.kvm);
> -	phys_addr_t bpa = __sme_set(page_to_phys(svm->avic_backing_page));
>  	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
>  	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
>  
> -	vmcb->control.avic_backing_page = bpa;
> +	vmcb->control.avic_backing_page = avic_get_backing_page_address(svm);
>  	vmcb->control.avic_logical_id = lpa;
>  	vmcb->control.avic_physical_id = ppa;
>  	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
> @@ -308,7 +312,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	if (!entry)
>  		return -EINVAL;
>  
> -	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
> +	new_entry = avic_get_backing_page_address(svm) |
>  		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
>  	WRITE_ONCE(*entry, new_entry);
>  
> @@ -859,7 +863,7 @@ get_pi_vcpu_info(struct kvm *kvm, struct kvm_kernel_irq_routing_entry *e,
>  	pr_debug("SVM: %s: use GA mode for irq %u\n", __func__,
>  		 irq.vector);
>  	*svm = to_svm(vcpu);
> -	vcpu_info->pi_desc_addr = __sme_set(page_to_phys((*svm)->avic_backing_page));
> +	vcpu_info->pi_desc_addr = avic_get_backing_page_address(*svm);
>  	vcpu_info->vector = irq.vector;
>  
>  	return 0;
> @@ -917,7 +921,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>  			struct amd_iommu_pi_data pi;
>  
>  			/* Try to enable guest_mode in IRTE */
> -			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
> +			pi.base = avic_get_backing_page_address(svm);
>  			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
>  						     svm->vcpu.vcpu_id);
>  			pi.is_guest_mode = true;

Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>

Best regards,
	Maxim Levitsky

