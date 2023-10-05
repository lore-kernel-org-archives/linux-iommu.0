Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2104C125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ceU7vIjz"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fN4rywtIClGLgr9iO8QvKioIZUSwe1mYyPLau7XRIeI=;
	b=ceU7vIjzywO2hNKDd5aIrqxQXPb7c9YVaIelfhVUHMbGgEGOfGZ59IA0KGJb1SXude0Spc
	DmUbLj1eWuGy5U96Hztz2L9aPfrFT5g1REUI5yaruhJiPNWJ9QjeXpzkj59vmNJHX80Ynf
	Z97hE1UEPsLaDXwRu3Mdt5kW7npBIZk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-cm6ErfSGMxGQaH_ItXaY7g-1; Thu, 05 Oct 2023 08:50:06 -0400
X-MC-Unique: cm6ErfSGMxGQaH_ItXaY7g-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4065ca278b3so5582155e9.3
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:50:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510205; x=1697115005;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fN4rywtIClGLgr9iO8QvKioIZUSwe1mYyPLau7XRIeI=;
        b=myD1T14eVQkItjKe4nDiv2/P9fgcU3OLdw568A65lXMi0hB3VKUVFfwH/gxAvcz4Kt
         a0Qc8OWi0NojASCm1MP53v4sptZgHmQ96yjjHV4BFYEEEGE9zdRnMIxU5F3LLwFFad/2
         mVC6pTu6hJCZFUwAjzt+dr2YdVXEu7dpBcjazkx8gq1KpEracvYb/kt2iOwUGROT1nvi
         tkK4wKsDLAJuusOhy+2przakDsvwnkOGAfnv9Wzen466xg3cqymXzRF2UWPM1N6oyaJy
         ko4pZy6u+qee2vfZg2PSAg4CM+5zmvXrImgO153vGcuschOz0Y604V2FBfj132oGf4bJ
         xMjw==
X-Gm-Message-State: AOJu0YycfSI/Zes9GgdkZ5QBHG/9evceqsvfVGCNCS2XJAloaglpW6km
	s5JzQgE8M5IB3WeToVNV1SDjORqNgzz/qRKuXxf+qh0ZEXzIoI4VJ49tCN4LXOlCPyzre3CxU0I
	dPPM+0NwXDwq3bBs=
X-Received: by 2002:a7b:c45a:0:b0:403:e21:1355 with SMTP id l26-20020a7bc45a000000b004030e211355mr5037549wmi.36.1696510205656;
        Thu, 05 Oct 2023 05:50:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpBIBRsUtXmd1zuy28OswvBTug2UVeZ6ce+whr/gNXaKYzhXK2GemstswBPWAEP8JlWWGstQ==
X-Received: by 2002:a7b:c45a:0:b0:403:e21:1355 with SMTP id l26-20020a7bc45a000000b004030e211355mr5037533wmi.36.1696510205379;
        Thu, 05 Oct 2023 05:50:05 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id x13-20020a1c7c0d000000b00402f7b50517sm1450210wmc.40.2023.10.05.05.50.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:50:05 -0700 (PDT)
Message-ID: <69584e11f9340e1420a47fc266eb7816139b294f.camel@redhat.com>
Subject: Re: [PATCH 03/10] KVM: SVM: Drop pointless masking of kernel page
 pa's with "AVIC's" HPA mask
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:50:03 +0300
In-Reply-To: <20230815213533.548732-4-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-4-seanjc@google.com>
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
> Drop AVIC_HPA_MASK and all its users, the mask is just the 4KiB-aligned
> maximum theoretical physical address for x86-64 CPUs. 

Typo: you mean 'current max theoretical physical address' because it might increase
the future again (Intel already did increase it, couple of times).


>  All usage in KVM
> masks the result of page_to_phys(), which on x86-64 is guaranteed to be
> 4KiB aligned and a legal physical address; if either of those requirements
> doesn't hold true, KVM has far bigger problems.

I do think that a build time assert that max physical address is as expected
by AVIC, is needed.

Consider this: intel/amd releases yet another extension of the max physical address,
the kernel gets updated, but for CPUs which lack this extension the max physical
address will still be 52 bit and should still be respected.

My CPU for example has 48 bits in max physical address, while the kernel
thinks that max valid physical address is 52 bit.

I understand that this is a theoretical problem but at least a build time
assert that kernel max physical address matches avic's should be done.

Especially if we consider the fact that this patch also fixes a purely theoretical
problem as well.

I do agree that masking output of page_to_phys is pointless and even dangerous,
but asserting that we are not trying to use address which is 
outside of AVIC's capabilities is a good thing to have, instead of relying blindly
on the kernel to do the right thing.


> 
> The unnecessarily masking in avic_init_vmcb() also incorrectly assumes
> that SME's C-bit resides between bits 51:11; that holds true for current
> CPUs, but isn't required by AMD's architecture:
> 
>   In some implementations, the bit used may be a physical address bit
> 
> Key word being "may".
> 
> Opportunistically use the GENMASK_ULL() version for
> AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK, which is far more readable
> than a set of repeating Fs.  Keep the macro even though it's unused, and
> will likely never be used, as it helps visualize the layout of an entry.




> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/svm.h |  6 +-----
>  arch/x86/kvm/svm/avic.c    | 11 +++++------
>  2 files changed, 6 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 609c9b596399..df644ca3febe 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -250,7 +250,7 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  #define AVIC_LOGICAL_ID_ENTRY_VALID_MASK		(1 << 31)
>  
>  #define AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK	GENMASK_ULL(11, 0)
> -#define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	(0xFFFFFFFFFFULL << 12)
> +#define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK	GENMASK_ULL(51, 12)
>  #define AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK		(1ULL << 62)
>  #define AVIC_PHYSICAL_ID_ENTRY_VALID_MASK		(1ULL << 63)
>  #define AVIC_PHYSICAL_ID_TABLE_SIZE_MASK		(0xFFULL)
> @@ -284,10 +284,6 @@ enum avic_ipi_failure_cause {
>  static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_PHYSICAL_ID);
>  static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
>  
> -#define AVIC_HPA_MASK	~((0xFFFULL << 52) | 0xFFF)
> -static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == AVIC_HPA_MASK);
> -static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == GENMASK_ULL(51, 12));
> -
>  #define SVM_SEV_FEAT_DEBUG_SWAP                        BIT(5)
>  
>  struct vmcb_seg {
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 442c58ef8158..b8313f2d88fa 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -248,9 +248,9 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  	phys_addr_t lpa = __sme_set(page_to_phys(kvm_svm->avic_logical_id_table_page));
>  	phys_addr_t ppa = __sme_set(page_to_phys(kvm_svm->avic_physical_id_table_page));
>  
> -	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
> -	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
> -	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
> +	vmcb->control.avic_backing_page = bpa;
> +	vmcb->control.avic_logical_id = lpa;
> +	vmcb->control.avic_physical_id = ppa;
>  	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;
>  
>  	if (kvm_apicv_activated(svm->vcpu.kvm))
> @@ -308,7 +308,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	if (!entry)
>  		return -EINVAL;
>  
> -	new_entry = __sme_set(page_to_phys(svm->avic_backing_page) & AVIC_HPA_MASK) |
> +	new_entry = __sme_set(page_to_phys(svm->avic_backing_page)) |
>  		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
>  	WRITE_ONCE(*entry, new_entry);
>  
> @@ -917,8 +917,7 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>  			struct amd_iommu_pi_data pi;
>  
>  			/* Try to enable guest_mode in IRTE */
> -			pi.base = __sme_set(page_to_phys(svm->avic_backing_page) &
> -					    AVIC_HPA_MASK);
> +			pi.base = __sme_set(page_to_phys(svm->avic_backing_page));
>  			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
>  						     svm->vcpu.vcpu_id);
>  			pi.is_guest_mode = true;




