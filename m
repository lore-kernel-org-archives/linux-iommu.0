Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0344A00
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 17:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131634; cv=none; b=Y2LEZ1WDLsV2vjb2p9XyfKim7ERyjT2JSdlgsWngF88CRQugGGX6HNiQvG3hTcpK/B0bDgg4y7+fRBWmq8BUdORDXbNSs6/cLtQiCygju9LhzGggQQriZ+UadESgxU6qlfOTFjr+v/1pb5WbRDmiJ9u8v1WrL+jGPav6XpOamDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131634; c=relaxed/simple;
	bh=8opHdR+ZhPf/pDhP5CUJEW+6bhJpr6eKU3OX78G4zYo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RU0A7f+o0cqt+aVThaWEF499HQufcdjk7OvV0oh7g/Up6tvL0AYyhlwLQzXAYiwmVh2kct2eyQ0GMCHugqz6xbUfhKRKil9HPPFKbqLKd43cL3kS6ucFNCBfucPcMZ5MZZSMQPVPPWttWAmOhgFDWcaMwnr8ZBHIodwYgkTEYQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bn33a8L9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bn33a8L9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744131631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=GK08jeM4D/oPy2IEdVDpdXD3DlKeA5qJPrv3gDqseh8=;
	b=Bn33a8L901j+FD8udDB5EDrj9VHTQkoQWrtzK69+ZILfSV7t+ofEki9NVP8prfLOwDzZif
	8/+bljkcXjssLkgBLIQRrHUHV5NHsnVc19HTLxrb+8WnOdgIUrtzfTNMQp2ggoyPsnUauq
	Jrp+KtoMCp1BJkBfrB4UWMExFvyK5Ws=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-tGF9Rv8XNHCJgq-vZoIQTw-1; Tue, 08 Apr 2025 13:00:29 -0400
X-MC-Unique: tGF9Rv8XNHCJgq-vZoIQTw-1
X-Mimecast-MFC-AGG-ID: tGF9Rv8XNHCJgq-vZoIQTw_1744131628
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5e5bde483cdso5304130a12.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 10:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131628; x=1744736428;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GK08jeM4D/oPy2IEdVDpdXD3DlKeA5qJPrv3gDqseh8=;
        b=in1pOFAEl7mG7wn1DLRM629sQQs1x3f6LV0EWKnHl1LUAL9F8WrmIUIghb3+bhDrbY
         XaZpsugPI8NtnUUcdqCEzC8GK0R4hrKdIbZKpRbxYlAodixk81PUyYDoLRC6Tiu6WzpK
         GA75L7UyzNOEqsqTYVVvdQWLFDxPmax0UjCBD+9Tg+S8Sd7NybZE1L713HsdcWSm/EP0
         rRcac82CS1t/h+xRO3hh8WPprMGb0Gy530Qhc3amrI7WbH8rD8HDBDjYLSe1aNrOhCFJ
         sGm6vNN9x3vPMtU9phiLlfM6Vm/dpyzHF6MKrNskcaYfq4uj6fi1IyczTYfVbtD2goE8
         W18Q==
X-Forwarded-Encrypted: i=1; AJvYcCWKSOG+VzxVSJMNpfL2xxx1NKLQpR2RjyEzDMtKESCvNcTsKxdvbkn1iucSWFfnavi5+FTliw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqcuLZGago39wmG3YLPCgm1KD2NKU31Qsw6BtBabfwK3nEgPQ+
	6cmyj9TED7kCShya/wzdVjbWVtzAg4gDYnMejLANxhiE8xB5TTUHnZlByQEz8zERy65T+83C070
	l92zAjDSl5g2qoZcb5yr7yW2LLCzkGxvFatDiRPW0+TRDk0XROk2/
X-Gm-Gg: ASbGncs61RbGxM/14j4ENpunMB8cX6EcE5FOJBVJXHP5d63hw5yy8mWOlaZVrNB06Rd
	7xe3KC5eW0dkVwGyP2boaKXy11S01bLyRVy+UEmR5AelbGHB5BaEIrhpcLTQJ8VtE+B0j5PN80I
	L4MXHLIZAoMqkMXMkK/RKN4SKXSsjxugscls45uB+VOu3dtwFDdEvON+WmDSwTNh6XHRrB/sqLL
	++EjkhQPiWxe7tJR88VibcYKlg0Czat3x/x32Jb1RfcST6vQxdLqHy+sfUU0hFZPu67T1vXpFBG
	7jZjWmpNTzpc42dQtKjK
X-Received: by 2002:a05:6402:5205:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5f0b4311322mr14406475a12.23.1744131628386;
        Tue, 08 Apr 2025 10:00:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK6vErHby9HMTnCSSHqaiUuBbgGb4cEfNQbWDSQtJjqb2mU3HLBP3xcUiEN9weMs9qFPHtIA==
X-Received: by 2002:a05:6402:5205:b0:5d0:bf5e:eb8 with SMTP id 4fb4d7f45d1cf-5f0b4311322mr14406449a12.23.1744131628031;
        Tue, 08 Apr 2025 10:00:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.197.100])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5f0880a535fsm8573392a12.80.2025.04.08.10.00.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 10:00:27 -0700 (PDT)
Message-ID: <d270ff32-7763-40d5-a4dc-3970383571dc@redhat.com>
Date: Tue, 8 Apr 2025 19:00:25 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 30/67] KVM: VMX: Stop walking list of routing table
 entries when updating IRTE
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-31-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250404193923.1413163-31-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: k3Rjd5pXW3TnlOUb6V3LSNkZoY6tkperFZTi1_j8j68_1744131628
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 21:38, Sean Christopherson wrote:
> Now that KVM provides the to-be-updated routing entry, stop walking the
> routing table to find that entry.  KVM, via setup_routing_entry() and
> sanity checked by kvm_get_msi_route(), disallows having a GSI configured
> to trigger multiple MSIs, i.e. the for-loop can only process one entry.
> 
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/vmx/posted_intr.c | 100 +++++++++++----------------------
>   1 file changed, 33 insertions(+), 67 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/posted_intr.c b/arch/x86/kvm/vmx/posted_intr.c
> index 00818ca30ee0..786912cee3f8 100644
> --- a/arch/x86/kvm/vmx/posted_intr.c
> +++ b/arch/x86/kvm/vmx/posted_intr.c
> @@ -268,78 +268,44 @@ int vmx_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   		       unsigned int host_irq, uint32_t guest_irq,
>   		       struct kvm_kernel_irq_routing_entry *new)
>   {
> -	struct kvm_kernel_irq_routing_entry *e;
> -	struct kvm_irq_routing_table *irq_rt;
> -	bool enable_remapped_mode = true;
>   	struct kvm_lapic_irq irq;
>   	struct kvm_vcpu *vcpu;
>   	struct vcpu_data vcpu_info;
> -	bool set = !!new;
> -	int idx, ret = 0;
>   
>   	if (!vmx_can_use_vtd_pi(kvm))
>   		return 0;
>   
> -	idx = srcu_read_lock(&kvm->irq_srcu);
> -	irq_rt = srcu_dereference(kvm->irq_routing, &kvm->irq_srcu);
> -	if (guest_irq >= irq_rt->nr_rt_entries ||
> -	    hlist_empty(&irq_rt->map[guest_irq])) {
> -		pr_warn_once("no route for guest_irq %u/%u (broken user space?)\n",
> -			     guest_irq, irq_rt->nr_rt_entries);
> -		goto out;
> -	}
> -
> -	hlist_for_each_entry(e, &irq_rt->map[guest_irq], link) {
> -		if (e->type != KVM_IRQ_ROUTING_MSI)
> -			continue;
> -
> -		WARN_ON_ONCE(new && memcmp(e, new, sizeof(*new)));

Alternatively, if you want to keep patches 28/29 separate, you could add 
this WARN_ON_ONCE to avic.c in the exact same place after checking 
e->type -- not so much for asserting purposes, but more to document 
what's going on for the reviewer.

Paolo

