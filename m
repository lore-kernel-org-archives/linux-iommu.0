Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B2A8125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EX5G3FSt"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510211;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xzJsIbEdC1wOEGvDx6w4HMSs5sdtsVv5hyJaAp9aFTU=;
	b=EX5G3FSt4d9ctyfOf8i+2PXcKIiYbGoASbsRZcHKhR/FAKyMdjTGSmXNyKU+nwWRZ4fxc3
	EOmqYGYiDp3Y/FRUcX//41zyGm8jxEuRT/2jzyf55O8EWAGz0pTHBF7aTZOQOdVE0Hi7B+
	AbExwbDBteTuQX+uN15KCLJNa+mq2Fg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-544-TMqslwPoMzuzREH0m0G-GQ-1; Thu, 05 Oct 2023 08:50:00 -0400
X-MC-Unique: TMqslwPoMzuzREH0m0G-GQ-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4055ce1e8c4so9593195e9.0
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510199; x=1697114999;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzJsIbEdC1wOEGvDx6w4HMSs5sdtsVv5hyJaAp9aFTU=;
        b=Uin/Q3oa3gSmNB4/R12wLDSqTYSWU/O25K3Cw0/mea3JhlMj5+4DjOg4zjEsxroTYj
         mnSUc0lF2Zk0+QKyxcvRBG2pUdNyj9KExkjkY0SHt8tT58SHv2IYq+t90kBBkFWwR2/a
         CSX+z+JUaEpf8++7mfA2G9/reBWw86zfKy67s8VFgpBG0YHN2cr79dC0xwvFKUPJ8axT
         FZq1FC0Z7nk20vKL9rmntvbUXG7qpMo7jo5frf6oL7X9hBKdLUZjH3XVSFCq6RN0OxeA
         VmJfWqPVwVvucsQqZ2Azr/K7KqlpT968nI6zSja9iRKLsp8ChhX/zqcjV9WjD/wYJJcx
         CYjA==
X-Gm-Message-State: AOJu0YxsmMoIg7UNH3KIPan6pAyNYMGGz8SiwwbIVcJkeJ80Hv0gqTCS
	w3deYgYIF41jQIhyhLbrcLdiR/BcPYxkezuN4czF0j1fj4+HqyZOkA+2q1p6JTGXYwUAaFWbOSl
	7QF49MMhR8wWLD2Y=
X-Received: by 2002:a05:600c:1c96:b0:405:3622:382c with SMTP id k22-20020a05600c1c9600b004053622382cmr1352348wms.17.1696510199505;
        Thu, 05 Oct 2023 05:49:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEH/NInPYmO1UfH7A7RZ9fUuJQjy8h9hg0sJsC7opG/J+MuehyjgG03sU18g5lM4H7ISOKsIQ==
X-Received: by 2002:a05:600c:1c96:b0:405:3622:382c with SMTP id k22-20020a05600c1c9600b004053622382cmr1352337wms.17.1696510199189;
        Thu, 05 Oct 2023 05:49:59 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id v5-20020a05600c214500b003fbe791a0e8sm1486081wml.0.2023.10.05.05.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:49:58 -0700 (PDT)
Message-ID: <74477cff348512fd88da8bb8fa901207fa29e316.camel@redhat.com>
Subject: Re: [PATCH 02/10] KVM: SVM: Use AVIC_HPA_MASK when initializing
 vCPU's Physical ID entry
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:49:57 +0300
In-Reply-To: <20230815213533.548732-3-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-3-seanjc@google.com>
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
> Use AVIC_HPA_MASK instead of AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK when
> initializing a vCPU's Physical ID table entry, the two masks are identical.

Masks are identical, but they refer to different things. 
AVIC_HPA_MASK is about avic's fields in vmcb, while AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK
is about the portion of the physical id entry which has the address.

They are the same currently but for documentation purposes I don't understand
why removal of one of them makes sense.

IMHO, it's best to define them to the same value, e.g:

#define AVIC_HPA_MASK	GENMASK_ULL(51, 12)

#define AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK GENMASK_ULL(51, 12)

Best regards,
	Maxim Levitsky


> Keep both #defines for now, along with a few new static asserts.  A future
> change will clean up the entire mess (spoiler alert, the masks are
> pointless).
> 
> Opportunisitically move the bitwise-OR of AVIC_PHYSICAL_ID_ENTRY_VALID_MASK
> outside of the call to __sme_set(), again to pave the way for code
> deduplication.  __sme_set() is purely additive, i.e. ORing in the valid
> bit before or after the C-bit does not change the end result.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/svm.h | 2 ++
>  arch/x86/kvm/svm/avic.c    | 5 ++---
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 1e70600e84f7..609c9b596399 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -285,6 +285,8 @@ static_assert((AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == AVIC_MAX_
>  static_assert((X2AVIC_MAX_PHYSICAL_ID & AVIC_PHYSICAL_MAX_INDEX_MASK) == X2AVIC_MAX_PHYSICAL_ID);
>  
>  #define AVIC_HPA_MASK	~((0xFFFULL << 52) | 0xFFF)
> +static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == AVIC_HPA_MASK);
> +static_assert(AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK == GENMASK_ULL(51, 12));
>  
>  #define SVM_SEV_FEAT_DEBUG_SWAP                        BIT(5)
>  
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 7062164e4041..442c58ef8158 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -308,9 +308,8 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	if (!entry)
>  		return -EINVAL;
>  
> -	new_entry = __sme_set((page_to_phys(svm->avic_backing_page) &
> -			      AVIC_PHYSICAL_ID_ENTRY_BACKING_PAGE_MASK) |
> -			      AVIC_PHYSICAL_ID_ENTRY_VALID_MASK);
> +	new_entry = __sme_set(page_to_phys(svm->avic_backing_page) & AVIC_HPA_MASK) |
> +		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
>  	WRITE_ONCE(*entry, new_entry);
>  
>  	svm->avic_physical_id_cache = entry;






