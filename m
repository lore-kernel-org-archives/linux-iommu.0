Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C73125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGv+44t8"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmjmV2FL8ELc9fhvem7XqWCaaiXwmt6kD+gkjkkdF+o=;
	b=GGv+44t8UUESQGkFu3daVrvHAt/nqxw2iCVggFedW5kl6Q+uvvA44mj+B/hlPVeCDlTtLu
	pY4DXOD8+o4mUyFEayVZNW8rG3ugHU/7q3oqW6Kcz1ulM4EWbinJmGRo3kf3znedd3B2pS
	PWjwY9L09bNz7kcjJ6GRu8Kg4YI2UZY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-hJukHfh4NVKRwTU0GeTVHw-1; Thu, 05 Oct 2023 08:52:21 -0400
X-MC-Unique: hJukHfh4NVKRwTU0GeTVHw-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4063dd6729bso6393295e9.2
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:52:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510339; x=1697115139;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zmjmV2FL8ELc9fhvem7XqWCaaiXwmt6kD+gkjkkdF+o=;
        b=rAZ6RjO9jt8MxWrKngkLdVs64VxEkHAyWhr16lNiIhlQ1j1qpjdF/zCsLaW+IobosK
         kdpwhR5hc765jT4DMegTJDB+GKyUatTm6CzdtHl5dCWzgbb5Tzd2qdetWT/ICC9jGqO6
         QKaPmgxGc27utRBgcZ7TSSkizX1Vx9eq1jHVR6+CjOYJjel4VUgdt3QIgazks6hCFDLR
         vvWbQLnVpAjd0z1VXruB7WNQqWoWrjR8UZZdiX2gd51flOsCUpgXUfZTZx8vTMA+Xp6f
         cbqGW0NLSOz2/WQG2+u+b3oc+MFcVwFri+bwfAZd6uA6WMK1bF1kVxwuu8rQI4NNLjWI
         gWkw==
X-Gm-Message-State: AOJu0YzzZtP3diazkhK6dmfMiQQoldPuLOuj/S7slBJ6hPvuVtz3H/j/
	l562plIqzShsLA0AJj9DnzbHYdl9xocEeNfg12Wz74ZruWOs2PYccjHEckzq4eSOCYMVhFlMiJy
	FQs44/sIvmI2dTV0=
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id x23-20020a1c7c17000000b003fe0ba7f200mr5396605wmc.20.1696510338930;
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHxwrlRRVC5KgOB6WbF1XYVweDYi+0tB1CX4lseGUm0j72BT+/pFJ39YKJShc6AHamwCvT6eg==
X-Received: by 2002:a1c:7c17:0:b0:3fe:ba7:f200 with SMTP id x23-20020a1c7c17000000b003fe0ba7f200mr5396595wmc.20.1696510338583;
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id z7-20020a7bc7c7000000b003fee567235bsm3734745wmk.1.2023.10.05.05.52.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:52:18 -0700 (PDT)
Message-ID: <1d9377235ada012bc09e1864c4ef7522b8ef02fd.camel@redhat.com>
Subject: Re: [PATCH 08/10] KVM: SVM: WARN if KVM attempts to create AVIC
 backing page with user APIC
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:52:16 +0300
In-Reply-To: <20230815213533.548732-9-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-9-seanjc@google.com>
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
> WARN if KVM attempts to allocate a vCPU's AVIC backing page without an
> in-kernel local APIC.  avic_init_vcpu() bails early if the APIC is not
> in-kernel, and KVM disallows enabling an in-kernel APIC after vCPUs have
> been created, i.e. it should be impossible to reach
> avic_init_backing_page() without the vAPIC being allocated.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 522feaa711b4..3b2d00d9ca9b 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -300,7 +300,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  		return 0;
>  	}
>  
> -	if (!vcpu->arch.apic->regs)
> +	if (WARN_ON_ONCE(!vcpu->arch.apic->regs))
>  		return -EINVAL;
>  
>  	if (kvm_apicv_activated(vcpu->kvm)) {

As I said I prefer this to be folded with patch that adds the avic_init_backing_page().

Best regards,
	Maxim Levitsky

