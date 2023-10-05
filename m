Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79065F9C6
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QfzW6ZaU"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510720;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/r6/vxDZ7SlHr2MUNh2FMyN5pOqeM6f7KWklCXeGbBg=;
	b=QfzW6ZaUmZZh+zq1/a3AfmouK2P2ijSJeVcMaNePW6hJ1xru36iXwFSXn2LMOse+ifggFu
	m8HJ9Ev5GcbJ7780me/pJ8Rw/3LHB17gDSYA6pOlKHKM0kOzhyejAaym0gZr42Ac5AacBF
	ptB00il3gFo4qFoIEI4PveU4KkHndrI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-IRmXmx91O0aOCdkZr6QfEw-1; Thu, 05 Oct 2023 08:58:34 -0400
X-MC-Unique: IRmXmx91O0aOCdkZr6QfEw-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-406c6de2cfdso2670875e9.1
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510712; x=1697115512;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/r6/vxDZ7SlHr2MUNh2FMyN5pOqeM6f7KWklCXeGbBg=;
        b=Iuvv1ln3pj4RCgvXbHRoQ3kQH3xifXIoVxQp1wAxcK82ieFu6KCnBVAMoruJ2CuMBM
         P4V+2MWY69SihANB8Fp/4bKCrGA40YYsXDU/HmGYzhyDH8csj4EJ6qvLGp38+vdNhnEF
         vMjAt5ekKpSXFevrVDea7YUjpEIawLNKgiyUBlb1emAhePkv/e3urIuJHA3PeianDaeG
         ikSbn1xnf6PM1dQq+9C/WO0KABkEkSdnYXxKJXsl4OHrFzwzS2xzF/Lz1kWQheMHsyWT
         XPriEkb+0tNWUjFKJ9HBJszgAu2XoSU0Fw7gYRqKd8/7+nzWHXaosouZEtegOh3zasIo
         nL6Q==
X-Gm-Message-State: AOJu0Yxxn/i37qU/jtxJS9VB5l1rkfmx3FTDBN9gFx8Pt7vMgNeSxaMp
	gVQEaNjExuNEZ/+lW5ivSmpt85fn81tfw6g8PoNtmiJMlSxirAjY3qqWitogUPMhemNX3JVA6Rx
	ydjS2r4JO5h1GDpeBuodC9iA=
X-Received: by 2002:a1c:7914:0:b0:401:1b58:72f7 with SMTP id l20-20020a1c7914000000b004011b5872f7mr4896063wme.38.1696510712648;
        Thu, 05 Oct 2023 05:58:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7lzNVbgVxPFaaWui24YMcE2z6WO73JBOPVtj5jYlX2YjQWj64rpJKORnSmCPW9jT0XGo+RA==
X-Received: by 2002:a1c:7914:0:b0:401:1b58:72f7 with SMTP id l20-20020a1c7914000000b004011b5872f7mr4896043wme.38.1696510712176;
        Thu, 05 Oct 2023 05:58:32 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b004064741f855sm1453766wmj.47.2023.10.05.05.58.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:58:31 -0700 (PDT)
Message-ID: <b61bcea5033edfbc558637edb6cb3bbf690b3cf6.camel@redhat.com>
Subject: Re: [PATCH 09/10] KVM: SVM: Drop redundant check in AVIC code on ID
 during vCPU creation
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:58:30 +0300
In-Reply-To: <20230815213533.548732-10-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-10-seanjc@google.com>
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
> Drop avic_get_physical_id_entry()'s compatibility check on the incoming
> ID, as its sole caller, avic_init_backing_page(), performs the exact same
> check.  Drop avic_get_physical_id_entry() entirely as the only remaining
> functionality is getting the address of the Physical ID table, and
> accessing the array without an immediate bounds check is kludgy.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 28 ++++++----------------------
>  1 file changed, 6 insertions(+), 22 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 3b2d00d9ca9b..6803e2d7bc22 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -263,26 +263,12 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  		avic_deactivate_vmcb(svm);
>  }
>  
> -static u64 *avic_get_physical_id_entry(struct kvm_vcpu *vcpu,
> -				       unsigned int index)
> -{
> -	u64 *avic_physical_id_table;
> -	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> -
> -	if ((!x2avic_enabled && index > AVIC_MAX_PHYSICAL_ID) ||
> -	    (index > X2AVIC_MAX_PHYSICAL_ID))
> -		return NULL;

While removing this code doesn't introduce a bug, it does make it less safe,
because new code just blindly trusts that vcpu_id will never be out of bounds
of the physical id table.

Bugs happen and that can and will someday happen.

> -
> -	avic_physical_id_table = page_address(kvm_svm->avic_physical_id_table_page);
> -
> -	return &avic_physical_id_table[index];
> -}
> -
>  static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  {
> -	u64 *entry, new_entry;
> +	struct kvm_svm *kvm_svm = to_kvm_svm(vcpu->kvm);
> +	struct vcpu_svm *svm = to_svm(vcpu);
> +	u64 *table, new_entry;
>  	int id = vcpu->vcpu_id;
> -	struct vcpu_svm *svm = to_svm(vcpu);
>  
>  	/*
>  	 * Inhibit AVIC if the vCPU ID is bigger than what is supported by AVIC
> @@ -318,15 +304,13 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  	}
>  
>  	/* Setting AVIC backing page address in the phy APIC ID table */
> -	entry = avic_get_physical_id_entry(vcpu, id);
> -	if (!entry)
> -		return -EINVAL;
> +	table = page_address(kvm_svm->avic_physical_id_table_page);
>  
>  	new_entry = avic_get_backing_page_address(svm) |
>  		    AVIC_PHYSICAL_ID_ENTRY_VALID_MASK;
> -	WRITE_ONCE(*entry, new_entry);

Here I prefer to at least have an assert that id is in bounds of a page 
(at least less than 512) so that a bug will not turn into a security
issue by overflowing the buffer.

> +	WRITE_ONCE(table[id], new_entry);
>  
> -	svm->avic_physical_id_cache = entry;
> +	svm->avic_physical_id_cache = &table[id];
>  
>  	return 0;
>  }

Best regards,
	Maxim Levitsky

