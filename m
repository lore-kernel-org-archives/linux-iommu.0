Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAEDA125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a6t0cpqg"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510247;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xcvsqfs+0EpVaBq57CSBuRBfpi+Ba+5rBlUn7RyIyWg=;
	b=a6t0cpqgPH+oDfW4hDdqjeHDGE9hCiEJNbup8PrwdGuGeMCX7iJWxUxXPH3hzH3GewK1va
	UXOmpdKDaeXZvwkvsdO5qoPuWz3xedi81MFynoW5v46wwstmt42NnyE4f8Oe0hjoxJDiP/
	GLpw+6JL6or2pXKp2x/Yjc2uDIEUaE8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-151-vSsrqeoHPX6nK2fDAa_WqA-1; Thu, 05 Oct 2023 08:50:31 -0400
X-MC-Unique: vSsrqeoHPX6nK2fDAa_WqA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40566c578b7so6837385e9.0
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:50:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510230; x=1697115030;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Xcvsqfs+0EpVaBq57CSBuRBfpi+Ba+5rBlUn7RyIyWg=;
        b=t8Ca357lA1gOgFyDSmoQBc77/GxiVL5M9/zpt1wOY1WLammzldHRXnlIf6AEqpe3rV
         Mg8vTnNxmSMFIuDFY/mftK0SMSNp2BwKKDnImb6DSGzmrmNnhBUq/93qitF3i0LdFGhf
         SqK65pBe8ajj5it4mbv2lX0ejapLQXidaqWoi42hdHh0mp8M8FtxAH0tJ5+N1AJuLeXL
         KWSXlXjnKCKn/TZDgFk9Ek+XD2Xtr2L3uLKeEUM/mfADomBaqmwiimQI8QXxJwr0IaOX
         5GFrZo7oLAMldSkkG8+CY/TbK9AZqPiK+6x8yKD1Yw8Atw9CwX7Ko4Pf9mqse0NKzVDl
         gMLQ==
X-Gm-Message-State: AOJu0YwV8g2Tcb2/f/Gq/H0IhXJ+MGR/dDdoZyrsw7NVfzK2I6Sw18DX
	oCCNJSx1fif1T8acqExuLRHxa9y4IANhXOG9j5auRFSR03U6eAk/Dtt2SdeVz7PKMBHBAnMjsqB
	3mZW+1CI5NYLY0Q8=
X-Received: by 2002:a7b:ce8a:0:b0:405:4776:735a with SMTP id q10-20020a7bce8a000000b004054776735amr5323315wmj.2.1696510230557;
        Thu, 05 Oct 2023 05:50:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG/nNVNIiyNjSawDybdIlilVc6D36h0kbYPNWFpdsCIWytAI5dR7THMDUcsxYxTxZ4KOTFEUA==
X-Received: by 2002:a7b:ce8a:0:b0:405:4776:735a with SMTP id q10-20020a7bce8a000000b004054776735amr5323302wmj.2.1696510230236;
        Thu, 05 Oct 2023 05:50:30 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id t14-20020a1c770e000000b004054dcbf92asm1452694wmi.20.2023.10.05.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:50:29 -0700 (PDT)
Message-ID: <c09766568221adac7e532dc4ae283d7f367571a3.camel@redhat.com>
Subject: Re: [PATCH 05/10] KVM: SVM: Drop vcpu_svm's pointless
 avic_backing_page field
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:50:28 +0300
In-Reply-To: <20230815213533.548732-6-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-6-seanjc@google.com>
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
> Drop vcpu_svm's avic_backing_page pointer and instead grab the physical
> address of KVM's vAPIC page directly from the source.  Getting a physical
> address from a kernel virtual address is not an expensive operation, and
> getting the physical address from a struct page is *more* expensive for
> CONFIG_SPARSEMEM=y kernels.  Regardless, none of the paths that consume
> the address are hot paths, i.e. shaving cycles is not a priority.
> 
> Eliminating the "cache" means KVM doesn't have to worry about the cache
> being invalid, which will simplify a future fix when dealing with vCPU IDs
> that are too big.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c | 4 +---
>  arch/x86/kvm/svm/svm.h  | 1 -
>  2 files changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 954bdb45033b..e49b682c8469 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -243,7 +243,7 @@ int avic_vm_init(struct kvm *kvm)
>  
>  static phys_addr_t avic_get_backing_page_address(struct vcpu_svm *svm)
>  {
> -	return __sme_set(page_to_phys(svm->avic_backing_page));
> +	return __sme_set(__pa(svm->vcpu.arch.apic->regs));

I overall agree with this patch however the old code was safer:

svm->avic_backing_page is set to physical address of the apic registers
only in the avic_init_backing_page() and after checking the 
vcpu->arch.apic->regs != NULL and now in theory NULL vcpu->arch.apic->regs
are not checked.

I know that you later add a patch which adds a similar warning, but I prefer that
you fold it with this patch.
 
>  }
>  
>  void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
> @@ -305,8 +305,6 @@ static int avic_init_backing_page(struct kvm_vcpu *vcpu)
>  			return ret;
>  	}
>  
> -	svm->avic_backing_page = virt_to_page(vcpu->arch.apic->regs);
> -
>  	/* Setting AVIC backing page address in the phy APIC ID table */
>  	entry = avic_get_physical_id_entry(vcpu, id);
>  	if (!entry)
> diff --git a/arch/x86/kvm/svm/svm.h b/arch/x86/kvm/svm/svm.h
> index 2237230aad98..a9fde1bb85ee 100644
> --- a/arch/x86/kvm/svm/svm.h
> +++ b/arch/x86/kvm/svm/svm.h
> @@ -261,7 +261,6 @@ struct vcpu_svm {
>  
>  	u32 ldr_reg;
>  	u32 dfr_reg;
> -	struct page *avic_backing_page;
>  	u64 *avic_physical_id_cache;
>  
>  	/*


Best regards,
	Maxim Levitsky



