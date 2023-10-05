Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 389A9125A3
	for <iommu@lists.linux.dev>; Thu,  5 Oct 2023 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z4DWdcEr"
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1696510252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gz/nfygGmbnXJsd+IS1AZ3tkRriknqzPVzuD8/FrAdY=;
	b=Z4DWdcErnrZ9At8BEZWxbqj+WilPeR+MUAIwm9qi/a37pkOJibdy8l23V7TG5D13EeFlpW
	BexBKaoJnzMhr84c2gG+n7ZdEY1auvOv/GWIGehTk0jQKKKeLRiYDy9Qci7Su+XkMMEtLO
	uor6bAetWN8NIsyzXjCZzE3xBD/IH5o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-54qpMdZ_M26EOgnoPMqcRA-1; Thu, 05 Oct 2023 08:50:49 -0400
X-MC-Unique: 54qpMdZ_M26EOgnoPMqcRA-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4066e59840eso5624725e9.1
        for <iommu@lists.linux.dev>; Thu, 05 Oct 2023 05:50:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696510248; x=1697115048;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gz/nfygGmbnXJsd+IS1AZ3tkRriknqzPVzuD8/FrAdY=;
        b=j2KPI6xi+UjvYExD5cHH0o4Bhw1XVwYfqqMvnZ7afAVti7pbBSUDYJgdBLpDXfUrdV
         rW6nmB2E/yP9n2NAy0zYJ5fT4AVvnnu69vmb1zVm7qRrQSCOwHz5UNfhwvO3COOLnGFG
         aCOLbOL7EX+6afYatO2thY206B3Rad/F1IJwucjafp3t4p5pKi+YUGMEJo/QG/+PeXrF
         5OxlMInf0LYZJimBXozroMedX3emAJ0g5y6RQZ+gWdLlg82Affz0YsiJuuEu8QK6F4RI
         vJjPMeMb8Nqqz6iHo1bOdNkEJVC2DO6lZycEHfGlxriWbis6CU/bF7TrdCR86NF4S2lY
         xULA==
X-Gm-Message-State: AOJu0Yzf7W1rrtRL7MFWMPaxmQUXkogRkOdfkLvXKDIMzxlCXjMprua7
	MMFGXr4At4ejKGUEdfCWRhKFW0lIO47Mm3y9pCCnr2k4Ha8j5wwEq39WJ4NLVT1IwHXgRLSBnVC
	QYNd+IszyHeQVBTw=
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id n21-20020a7bcbd5000000b003ffca80eda3mr4776378wmi.10.1696510247893;
        Thu, 05 Oct 2023 05:50:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/SJNiXj3XatMAFFcAo+yGfpoct1qUkwh1sePQUc9yGeKWgR2qxGA7p6oIQPZObYy145GAeA==
X-Received: by 2002:a7b:cbd5:0:b0:3ff:ca80:eda3 with SMTP id n21-20020a7bcbd5000000b003ffca80eda3mr4776365wmi.10.1696510247529;
        Thu, 05 Oct 2023 05:50:47 -0700 (PDT)
Received: from starship ([89.237.100.246])
        by smtp.gmail.com with ESMTPSA id c11-20020a7bc84b000000b0040648217f4fsm3706589wml.39.2023.10.05.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 05:50:47 -0700 (PDT)
Message-ID: <4ae1b1aeae6662c56c982c916e550ddcd8543aa7.camel@redhat.com>
Subject: Re: [PATCH 06/10] iommu/amd: KVM: SVM: Use pi_desc_addr to derive
 ga_root_ptr
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Sean Christopherson <seanjc@google.com>, Paolo Bonzini
 <pbonzini@redhat.com>,  Joerg Roedel <joro@8bytes.org>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Thu, 05 Oct 2023 15:50:45 +0300
In-Reply-To: <20230815213533.548732-7-seanjc@google.com>
References: <20230815213533.548732-1-seanjc@google.com>
	 <20230815213533.548732-7-seanjc@google.com>
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
> Use vcpu_data.pi_desc_addr instead of amd_iommu_pi_data.base to get the
> GA root pointer.  KVM is the only source of amd_iommu_pi_data.base, and
> KVM's one and only path for writing amd_iommu_pi_data.base computes the
> exact same value for vcpu_data.pi_desc_addr and amd_iommu_pi_data.base,
> and fills amd_iommu_pi_data.base if and only if vcpu_data.pi_desc_addr is
> valid, i.e. amd_iommu_pi_data.base is fully redundant.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>  arch/x86/kvm/svm/avic.c   | 1 -
>  drivers/iommu/amd/iommu.c | 2 +-
>  include/linux/amd-iommu.h | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index e49b682c8469..bd81e3517838 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -919,7 +919,6 @@ int avic_pi_update_irte(struct kvm *kvm, unsigned int host_irq,
>  			struct amd_iommu_pi_data pi;
>  
>  			/* Try to enable guest_mode in IRTE */
> -			pi.base = avic_get_backing_page_address(svm);
>  			pi.ga_tag = AVIC_GATAG(to_kvm_svm(kvm)->avic_vm_id,
>  						     svm->vcpu.vcpu_id);
>  			pi.is_guest_mode = true;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index c3b58a8389b9..9814df73b9a7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3622,7 +3622,7 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
>  
>  	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
>  	if (pi_data->is_guest_mode) {
> -		ir_data->ga_root_ptr = (pi_data->base >> 12);
> +		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
>  		ir_data->ga_vector = vcpu_pi_info->vector;
>  		ir_data->ga_tag = pi_data->ga_tag;
>  		ret = amd_iommu_activate_guest_mode(ir_data);
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 953e6f12fa1c..30d19ad0e8a9 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -20,7 +20,6 @@ struct amd_iommu;
>  struct amd_iommu_pi_data {
>  	u32 ga_tag;
>  	u32 prev_ga_tag;
> -	u64 base;

I think that a comment describing where the base address of the apic register page is taken now is needed, 
because before your patch the 'amd_iommu_pi_data' was self documenting, since it had all the info 
about the PI remap entry, but now it doesn't.


>  	bool is_guest_mode;
>  	struct vcpu_data *vcpu_data;
>  	void *ir_data;


Best regards,
	Maxim Levitsky





