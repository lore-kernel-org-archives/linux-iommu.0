Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13D8125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eWC4usaX"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rHlDcpYqvRVbBwfdymZ9aLtHILbpbHaMo9iVj1JrDzc=;
	b=eWC4usaXbL92HTg0j+At+//ZtKbLcAGxX92XixT2fuetOl9oMPWLUGQMySlchHu1+TiVUx
	mPQBimNCro8oqHTUGeXhOH7OvwpsaQl8+DkMuAzy5gI0zRRQuOn5+GDxia49nRJjbzOlyD
	M5fqABPte5oVOycBgqyoap9bNdJV3R0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-enEOmHtBOb-2BNyQcYbJiQ-1; Thu, 05 Oct 2023 08:49:52 -0400
X-MC-Unique: enEOmHtBOb-2BNyQcYbJiQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-325a78c806eso680790f8f.1
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510192; x=1697114992;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rHlDcpYqvRVbBwfdymZ9aLtHILbpbHaMo9iVj1JrDzc=;
        b=JO5t9TLtk2ToNIa+5eIH+KdTw3KoUVbzpYsph5mP13m0D+QfLyUL0UD8fVhPK5aWqY
         N6RjUWNFPnf5j2cRBWj/MawRdjhVWNFRpL9wDxS51mOC2SGGwJAUJPbWituwKExo3ddM
         +paLN4lxldsiRilePEmi4ivT8gnhHnHOVYFBU0RuFjMZZbO2FPFbo1prheA+svkYc1gc
         MrDi7AHRXXGZiWH1ivPdCFX/HAPP7Lfx0HdrBlhxGCFUcLvSLyuSpAq+6zGgPGLgDlvP
         0615ijZaGAeiC73IU+sGe1TWUVRjMSKPv6tu8IpP1WoTcwy8CcIcxL6wSoXeIyjdsSqU
         RuYg==
X-Gm-Message-State: AOJu0Yw4zUSFoeQRHUOiy3YsqXzntBQhPsoTmSKUv0ex/yj1yGyo0T2S
	eier5tST3WKU+JLiVkNjSTR2CQghXRegf3CZtRKE/mXJ0u7+81pSBVHjx99b4clrl5o5iOopLM3
	CGlufMODMlNcLGYo=
X-Received: by 2002:adf:d0cc:0:b0:325:1a1:1052 with SMTP id z12-20020adfd0cc000000b0032501a11052mr5064646wrh.29.1696510191826;
        Thu, 05 Oct 2023 05:49:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZHJVnS3AX4sTAeuTlcu+imxj8xColT0TARU2HpMGu+8c9DPPYsxChjGTAZorisoDDrTSayw==
X-Received: by 2002:adf:d0cc:0:b0:325:1a1:1052 with SMTP id z12-20020adfd0cc000000b0032501a11052mr5064632wrh.29.1696510191545;
        Thu, 05 Oct 2023 05:49:51 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id y8-20020a7bcd88000000b00406447b798bsm3709768wmj.37.2023.10.05.05.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:49:51 -0700 (PDT)
Message-ID: <8dfb288e02cdd34e777061e725a5da55ebec6cf1.camel@redhat.com>
Subject: Re: [PATCH 01/10] KVM: SVM: Drop pointless masking of default APIC
 base when setting V_APIC_BAR
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:49:49 +0300
In-Reply-To: <20230815213533.548732-2-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-2-seanjc@google.com>
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
> Drop VMCB_AVIC_APIC_BAR_MASK, it's just a regurgitation of the maximum
> theoretical 4KiB-aligned physical address, i.e. is not novel in any way,
> and its only usage is to mask the default APIC base, which is 4KiB aligned
> and (obviously) a legal physical address.
> 
> No functional change intended.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/include/asm/svm.h | 2 --
>  arch/x86/kvm/svm/avic.c    | 2 +-
>  2 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 72ebd5e4e975..1e70600e84f7 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -257,8 +257,6 @@ struct __attribute__ ((__packed__)) vmcb_control_area {
>  
>  #define AVIC_DOORBELL_PHYSICAL_ID_MASK			GENMASK_ULL(11, 0)
>  
> -#define VMCB_AVIC_APIC_BAR_MASK				0xFFFFFFFFFF000ULL

While this mask is indeed not needed now because AVIC doesn't support non default APIC base,
this mask will be needed in my upcoming nested AVIC support, because nested hypervisor can
ask for any apic base it wishes for.

> -
>  #define AVIC_UNACCEL_ACCESS_WRITE_MASK		1
>  #define AVIC_UNACCEL_ACCESS_OFFSET_MASK		0xFF0
>  #define AVIC_UNACCEL_ACCESS_VECTOR_MASK		0xFFFFFFFF
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index cfc8ab773025..7062164e4041 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -251,7 +251,7 @@ void avic_init_vmcb(struct vcpu_svm *svm, struct vmcb *vmcb)
>  	vmcb->control.avic_backing_page = bpa & AVIC_HPA_MASK;
>  	vmcb->control.avic_logical_id = lpa & AVIC_HPA_MASK;
>  	vmcb->control.avic_physical_id = ppa & AVIC_HPA_MASK;
> -	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE & VMCB_AVIC_APIC_BAR_MASK;
> +	vmcb->control.avic_vapic_bar = APIC_DEFAULT_PHYS_BASE;

Here I agree that the '&' is functionally pointless, 
although I am not sure that removing it makes the code more readable.


Best regards,
	Maxim Levitsky

>  
>  	if (kvm_apicv_activated(svm->vcpu.kvm))
>  		avic_activate_vmcb(svm);





