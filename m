Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374ED230264
	for <iommu@lists.linux.dev>; Tue,  8 Apr 2025 16:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744131480; cv=none; b=g5aTEg0eP6fk0Nvb17/E5koAcqdpx7NWdhI7//7nLKnQLp+MFtWVajz66FemMujZXuwIPd5sFcQ4zeCx8acb2NPSro+jjtmdU4+3vXvNNk/tIRbHk1awBziWDnWfJ3tZjvQc3r15Jqpaaglx4tHsNNFYi/tvVYwQakDvnehIFbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744131480; c=relaxed/simple;
	bh=E/UgzG4NaYP4/YEsbqahDbER43TJcbSBQEzVlGvZq6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C5o+vEylZT0HBcxrccRTiJL8ScKrT1ClsbKNKHQpj1Wz3skX9NAzCSpFHyGXByCZQ/AuKZDiUcZAGBTeFe/NT9/SAsatWiHygQWWPt9HYjfFc8jYR60UFW8JTCcitrrw0pjy6n5o5COuB3QPS8jF/jR+1PcPhEJ9O41PuzDqFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=US0wp8ep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="US0wp8ep"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744131476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=Ur0KNcNU+Bbe3ulpEE4AO76I8ACxlXZkuuWpkfCf0Jc=;
	b=US0wp8epZT/kxH/tS7JMGKEgBlevO0yfGNNxL0z7lN7HbwSyaXhZleS5jWcbWYa318S1Zi
	SD4kc0ZW05cflIbNM/hbyyqbA/ig1EruCNrAXHNDrPC/iOz4hCWceTmvbpg9qG7b3OPxZ7
	+FZi2TFQgS9s8gDz1uGVce3ek05dXXs=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-569-2dRJpHa5MCG3-9ONoGW9ew-1; Tue, 08 Apr 2025 12:57:53 -0400
X-MC-Unique: 2dRJpHa5MCG3-9ONoGW9ew-1
X-Mimecast-MFC-AGG-ID: 2dRJpHa5MCG3-9ONoGW9ew_1744131472
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ac6ce5fe9bfso53785766b.1
        for <iommu@lists.linux.dev>; Tue, 08 Apr 2025 09:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744131472; x=1744736272;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ur0KNcNU+Bbe3ulpEE4AO76I8ACxlXZkuuWpkfCf0Jc=;
        b=JZ18sBdAyGikkz7pF+uyFBU3w/EIA2CZUzSCTRynphzWCb8fth2QtRKLc4iyJskytt
         84FVDaR7BqvyKKOrz/Iu27Aj/+fzAb/bslB5l2pqzPguQxbu5xmji2erIkafB5Ox6elB
         czi3KObb6CL/+Hgue05yI4vbk/BzFJQeAhWOYasVVAhgaintQxzJpQSYd4nEXDg4cIIc
         iK28I48xIe6ovON0FmlEUStzbYGdr9aFEq+qMmg9XjQHEMt4noA8NHotnPYWqL+KRrRv
         8Qev7r/iGq9pTgRmsg3hR2zuEajJZa0jXRviG1ExMbWQ+rcegozaVF9E1gpk7PQwD2fU
         u/oA==
X-Forwarded-Encrypted: i=1; AJvYcCX61fdUhKYPqSDBFrXgUgCfX7v2kzki7x1jCd3Ph/bUgDl08n4J8aYHF6Cjuumy/+cKX8RaHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzojlPIKfIm5pHPZougkDzdeWGcyUPxzkUctjB0iuoz8lqa11Iv
	bJi5NcltZtsN/Vnz9zPlFcGJnKgrLj10q4Q7GOogBmXTtjwAHQliC8XMYVylQ0vKETtmtKrRn82
	ixmS3QpItPKEn1anrN73zeeUtjaWt9JW/CLeKtYIZoOGgysbdRPSi
X-Gm-Gg: ASbGncsB+Jrx44nlahgnhdOMR7ondgwFwsAE92WEIF9VYW2TzH/VVVNS57ReImOMTNX
	t3fVDQD/T6FN/LG8hpyyQb+J+XNi7WWLcMlwxXvtBqPy/6Ptj2ZYFTDe7m6gGU1SK15fsF2OQyw
	0tvxDRlQIpc9ohTBTJG6Cg517QRQjwily3UKlAy48v4ExntBfq/zcxdfVOVCxrdkHHHp9q663UI
	dPzVpA1+m4PVyZrgMjU3GBZZfF6JBb9Z7f0cklQF7X5Gpg0FM6IZl7JAMyJ/J4lU6wOAtNM5whp
	pJomNZR3M44Ubs8QvFdj
X-Received: by 2002:a17:906:6c91:b0:ac7:f348:b8bc with SMTP id a640c23a62f3a-ac7f348c1a4mr846858466b.61.1744131472360;
        Tue, 08 Apr 2025 09:57:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoJBXVzWDsYpEAyABHK22MH5Y16LHSd5i/jqdw+5ay+0S5ZKY/E+1W+Hg+xuoMz9rwwMee0Q==
X-Received: by 2002:a17:906:6c91:b0:ac7:f348:b8bc with SMTP id a640c23a62f3a-ac7f348c1a4mr846855866b.61.1744131471892;
        Tue, 08 Apr 2025 09:57:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.197.100])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ac7c01c2e6dsm953029866b.174.2025.04.08.09.57.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 09:57:51 -0700 (PDT)
Message-ID: <8b061b2d-7137-498e-93b2-0cb714824d7b@redhat.com>
Date: Tue, 8 Apr 2025 18:57:49 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 26/67] iommu/amd: KVM: SVM: Delete now-unused
 cached/previous GA tag fields
To: Sean Christopherson <seanjc@google.com>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Joao Martins <joao.m.martins@oracle.com>, David Matlack <dmatlack@google.com>
References: <20250404193923.1413163-1-seanjc@google.com>
 <20250404193923.1413163-27-seanjc@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250404193923.1413163-27-seanjc@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TfRumFGtnSsiEGBN_IElW8nZA00giiXutl80ICqD9Xw_1744131472
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/25 21:38, Sean Christopherson wrote:
> Delete the amd_ir_data.prev_ga_tag field now that all usage is
> superfluous.

This can be moved much earlier (maybe even after patch 10 from a cursory 
look), can't it?  I'd do that to clarify what has been cleaned up at 
which point.

Paolo

> Signed-off-by: Sean Christopherson <seanjc@google.com>
> ---
>   arch/x86/kvm/svm/avic.c             |  2 --
>   drivers/iommu/amd/amd_iommu_types.h |  1 -
>   drivers/iommu/amd/iommu.c           | 10 ----------
>   include/linux/amd-iommu.h           |  1 -
>   4 files changed, 14 deletions(-)
> 
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 9024b9fbca53..7f0f6a9cd2e8 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -943,9 +943,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
>   		/**
>   		 * Here, pi is used to:
>   		 * - Tell IOMMU to use legacy mode for this interrupt.
> -		 * - Retrieve ga_tag of prior interrupt remapping data.
>   		 */
> -		pi.prev_ga_tag = 0;
>   		pi.is_guest_mode = false;
>   		ret = irq_set_vcpu_affinity(host_irq, &pi);
>   	} else {
> diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
> index 23caea22f8dc..319a1b650b3b 100644
> --- a/drivers/iommu/amd/amd_iommu_types.h
> +++ b/drivers/iommu/amd/amd_iommu_types.h
> @@ -1060,7 +1060,6 @@ struct irq_2_irte {
>   };
>   
>   struct amd_ir_data {
> -	u32 cached_ga_tag;
>   	struct amd_iommu *iommu;
>   	struct irq_2_irte irq_2_irte;
>   	struct msi_msg msi_entry;
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index 635774642b89..3c40bc9980b7 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -3858,23 +3858,13 @@ static int amd_ir_set_vcpu_affinity(struct irq_data *data, void *vcpu_info)
>   	ir_data->cfg = irqd_cfg(data);
>   	pi_data->ir_data = ir_data;
>   
> -	pi_data->prev_ga_tag = ir_data->cached_ga_tag;
>   	if (pi_data->is_guest_mode) {
>   		ir_data->ga_root_ptr = (vcpu_pi_info->pi_desc_addr >> 12);
>   		ir_data->ga_vector = vcpu_pi_info->vector;
>   		ir_data->ga_tag = pi_data->ga_tag;
>   		ret = amd_iommu_activate_guest_mode(ir_data);
> -		if (!ret)
> -			ir_data->cached_ga_tag = pi_data->ga_tag;
>   	} else {
>   		ret = amd_iommu_deactivate_guest_mode(ir_data);
> -
> -		/*
> -		 * This communicates the ga_tag back to the caller
> -		 * so that it can do all the necessary clean up.
> -		 */
> -		if (!ret)
> -			ir_data->cached_ga_tag = 0;
>   	}
>   
>   	return ret;
> diff --git a/include/linux/amd-iommu.h b/include/linux/amd-iommu.h
> index 4f433ef39188..deeefc92a5cf 100644
> --- a/include/linux/amd-iommu.h
> +++ b/include/linux/amd-iommu.h
> @@ -19,7 +19,6 @@ struct amd_iommu;
>    */
>   struct amd_iommu_pi_data {
>   	u32 ga_tag;
> -	u32 prev_ga_tag;
>   	bool is_guest_mode;
>   	struct vcpu_data *vcpu_data;
>   	void *ir_data;

