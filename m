Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5119318656
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cyZJjq7H"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eB/s9Y6w4YeBVavpvimiNB3pmiRKF4zEjUazPrN+Ua0=;
	b=cyZJjq7HlojAl3FmxBcGJ4ij1a2AxYco8zD3KH+lcQ0TLc2SiUrXU0JnytOV5ZwyZYaB5n
	mdmOQkGuNAluOFlcSZ9BebEaUWcBdLV+ROAdhj1cm8IsF3jq+L6xkDbN268uDsiKUI5l11
	vgxQTDlwgOTJien8+ri6uAX4pNS0Apo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-FbDQwZgwOZ6xIDRzvzI-3Q-1; Thu, 05 Oct 2023 08:59:46 -0400
X-MC-Unique: FbDQwZgwOZ6xIDRzvzI-3Q-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-32661ca30d9so685343f8f.0
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:59:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510785; x=1697115585;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eB/s9Y6w4YeBVavpvimiNB3pmiRKF4zEjUazPrN+Ua0=;
        b=rRS7vWmT07U5TmsQcjVLKvhhP47o5ayYx9TomnNIzFTR+dO8F/ZTN6sdm1D9a74bUr
         STXhkgy0yINP1cgkmCfUHrhx60Rr4l7XY8nLt90vdnMM4j1v4PFnim4iqhJBzt5AuFJ1
         kSVIBQnnfqU/cD+i88RkAQjO1Lov8BOyp6IkUVEyxcsTqRaQzt2589VXV1z2+Uy1QFdY
         F0xicuP5tYUE1KxhS8Y6w8+GIFd28THEdz0D9ziEATYwPWWC3Os8vR6Iqwz0wOzGWeSx
         66JGz5mcDsxRDsE7+ap9356kqQ/OJ0H0e32s8vsk4eqFHQCJLpCWg5O4BOzvNc3MxuXc
         oQOA==
X-Gm-Message-State: AOJu0YymiQHreKy67FlZstiNLf9X5xHEBtudfO6VxhH4B4ex69QmX0ab
	sdU3mODUXXxFUJrBkw4fXNC/7PFkYqj6kjCt66H4BWq9M5s8CzNWgv0n9N7iNnyltdoWRyOorrh
	9cSpi5/VOCei2QI4kE1K6W/c=
X-Received: by 2002:adf:cd0a:0:b0:31f:f72c:df95 with SMTP id w10-20020adfcd0a000000b0031ff72cdf95mr4843463wrm.21.1696510785511;
        Thu, 05 Oct 2023 05:59:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvEI5pQfZk4ZhyDAwt1LECiXblBVoH3ImmjiThxEXrj19IR2Tsvu0M7XCB7fYKnjR2dSYpvA==
X-Received: by 2002:adf:cd0a:0:b0:31f:f72c:df95 with SMTP id w10-20020adfcd0a000000b0031ff72cdf95mr4843445wrm.21.1696510785139;
        Thu, 05 Oct 2023 05:59:45 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d6542000000b003196b1bb528sm1752733wrv.64.2023.10.05.05.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:59:44 -0700 (PDT)
Message-ID: <b52c3e6a5df217b529565eae6e15c3fe246e2c5d.camel@redhat.com>
Subject: Re: [PATCH 10/10] KVM: SVM: Rename "avic_physical_id_cache" to
 "avic_physical_id_entry"
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:59:43 +0300
In-Reply-To: <20230815213533.548732-11-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-11-seanjc@google.com>
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
> Rename the vCPU's pointer to its AVIC Physical ID entry from "cache" to
> "entry".  While the field technically caches the result of the pointer
> calculation, it's all too easy to misinterpret the name and think that
> the field somehow caches the _data_ in the table.

I also strongly dislike the 'avic_physical_id_cache', but if you are refactoring
it, IMHO the 'avic_physical_id_entry' is just as confusing since its a pointer
to an entry and not the entry itself.

At least a comment to explain where this pointer points, or maybe (not sure)
drop the avic_physical_id_cache completely and calculate it every time
(I doubt that there is any perf loss due to this)

Best regards,
	Maxim Levitsky

> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 10 +++++-----
>  arch/x86/kvm/svm/svm.h  |  2 +-
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 6803e2d7bc22..8d162ff83aa8 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -310,7 +310,7 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
>  	WRITE_ONCE(table[id], new_entry);
>  
> -	svm->avic_physical_id_cache = &table[id];
> +	svm->avic_physical_id_entry = &table[id];
>  
>  	return 0;
>  }
> @@ -1028,14 +1028,14 @@ void avic_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
>  	if (kvm_vcpu_is_blocking(vcpu))
>  		return;
>  
> -	entry = READ_ONCE(*(svm->avic_physical_id_cache));
> +	entry = READ_ONCE(*(svm->avic_physical_id_entry));
>  	WARN_ON_ONCE(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK);
>  
>  	entry &= ~AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK;
>  	entry |= (h_physical_id & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK);
>  	entry |= AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
>  
> -	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
> +	WRITE_ONCE(*(svm->avic_physical_id_entry), entry);
>  	avic_update_iommu_vcpu_affinity(vcpu, h_physical_id, true);
>  }
>  
> @@ -1046,7 +1046,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
>  
>  	lockdep_assert_preemption_disabled();
>  
> -	entry = READ_ONCE(*(svm->avic_physical_id_cache));
> +	entry = READ_ONCE(*(svm->avic_physical_id_entry));
>  
>  	/* Nothing to do if IsRunning == '0' due to vCPU blocking. */
>  	if (!(entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK))
> @@ -1055,7 +1055,7 @@ void avic_vcpu_put(struct kvm_vcpu *vcpu)
>  	avic_update_iommu_vcpu_affinity(vcpu, -1, 0);
>  
>  	entry &= ~AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK;
> -	WRITE_ONCE(*(svm->avic_physical_id_cache), entry);
> +	WRITE_ONCE(*(svm->avic_physical_id_entry), entry);
>  }
>  
>  void avic_refresh_virtual_apic_mode(struct kvm_vcpu *vcpu)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 8b798982e5d0..4362048493d1 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -261,7 +261,7 @@ struct vcpu_svm {
>  
>  	u32 ldr_reg;
>  	u32 dfr_reg;
> -	u64 *avic_physical_id_cache;
> +	u64 *avic_physical_id_entry;
>  
>  	/*
>  	 * Per-vcpu list of struct amd_svm_iommu_ir:


