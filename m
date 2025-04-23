Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F60285414
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 15:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421679; cv=none; b=rKCYm2oHbHYGH0Ns+cwK2PTwji3818gTRMoNlK3tEQR8v6imrWe9QP4t2zFNFWJJj7NeJhg0QgUFG8V9s9D0HEMSKziOWWLuVzVVp7LU13ImOX3qgMesR/NwKhV0chxVuEUY2N0RzXomx+bc2Ftzse2al4+DEvEYrGMHpcxEl8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421679; c=relaxed/simple;
	bh=ocihTxHKjDV8ZWlIROTSWda+Ts4l5IXkFmD+6cfyN3U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=SrkITh4CpzUqYD/gTS8HvdC9fvbjvRvXfRR4nG4HPDErlSsLM260muQD00uel7n3hLwdj7pT54CYkUYW5qE9Kd6INQ8eZAMrvzqTmDO94P9sajIdWJ0cRCgI6CCob6KCBQmhk9TrBW08J06wR1GFES79ECqgrbX9ky22uZhWHx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UjLfgPkj; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UjLfgPkj"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43ea40a6e98so59714235e9.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 08:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745421675; x=1746026475; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li+3GRicRppsnv6S7lrbfl1VCvjPKVNnD9s3Fy6S0jw=;
        b=UjLfgPkjV5FjEC7KHZ+0AgCAGYiteV+hl1LNhnrjxq9z9eA0LfnEX5bAfm5O8UoDxR
         ERYGAqsBXkuhA27YilzsWZW6TCSLpLxbRrEgoTO4HC/pWpDKzNI2YXLlvUm0jUJKiBwp
         scxaLiCdN4Gd+Ki9eDZ6JliEYuTlX/okiZuMz1GEfuR+iZ150WMqpD8g/QztqRUy1lbq
         351YxZnCMSDcBcfZa0ffUmOJHko7uCj1CEPc1CxKnvFxkmSvEThPiGeOiWYYQs3EhX/F
         3MNBmmnGQVWBg0o0FLgb4pRY5ukTU3QNAh0+2bAspiqVY56NA6wl2LwCIUvF85HkP8GJ
         XjXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745421675; x=1746026475;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Li+3GRicRppsnv6S7lrbfl1VCvjPKVNnD9s3Fy6S0jw=;
        b=s8zIok/72o0FG0fvWMMYsCauVQfxV20tqmm8tNDnKHmH7BXlZjNusTr8+ia1SrAOqo
         Gh9D6t+X8PetyrEY1Vwd1g/EotqK0g1MBxpudmeqrzpWFjxU40vcE2Bsuc/XSjg6obvQ
         d+z4W1gXWYDFG7Ags+KsG+4xKN3uW7QqL7cj8iw9JcL0SdpKNhBDk0iM0oAtftDRk1CH
         foLFNjCzYzgHow+R4iH8l+XUpdzU8gn9/6225QFeunAEawu2w3WrCWELweuLzuTybcc3
         q5dgCCRX2HZVxVDhuur0bDSX1JqwdOcmVpZGvBIrGKt39786Z6PbeGK7BnaRJXDe7aPW
         d6Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXQqveEvI25aBQ+81JM8M1Zim9+mTn0s9Hk+o5qDYawafRcXofGwt3a/NTi4K0RjcQ9XFfnOg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyj4w2iREvcXKWsdBgcY8M27qkoPfEdxwMByDWibFeXufSPNzC9
	MFETn3qgNc8sX8Hx/L/78Lu33rW3RrNifdWWmwWcBjHuvvnH9lwF
X-Gm-Gg: ASbGnctdlIR+smGJKiVK2N4SQLdzCeRHNjZyHw3DJArAwD1J2Kwkw/e6AL6MN0XAeEK
	d4WKmpsvLt60ZT236Zv6PZ530NLskY/cN19rDHpmm/r/YUAiZo9KsyfWSHt8cn5qDskIPfVegub
	PkgvnzbODIvS0CE0EUn9EcB9biJbDi8JNGoOHvZSvKP5a9h7uphYohEkIn6s3gPMh75xcfN+Oi7
	bkNU2BefpXveV91DGhBN/Eb9Hv/eXNwovA0iN+SADp2DLlPirU2VB7pnQLfPYDRE12Zotd2MfGw
	8UIDFENE2fgXbBhfO25Tw2vMsKm2zk5ZsmgjXerSiWW/F3hp6DdBmfkcS5vEhq0J9i/xWWMtdkO
	6bFHTFLvi3xeYVfOGF0OY7g==
X-Google-Smtp-Source: AGHT+IENHJTw1XWaNUx/Z8DhUmtsOHouN2kWNcGXTJkXEi3Tx5xDITR7zmfelv88F8OaG9mu2r1gXw==
X-Received: by 2002:a05:600c:8716:b0:43d:745a:5a50 with SMTP id 5b1f17b1804b1-4406abb420dmr179538155e9.19.1745421674445;
        Wed, 23 Apr 2025 08:21:14 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:c06f:b161:cbfc:6bf0? ([2001:b07:5d29:f42d:c06f:b161:cbfc:6bf0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-44092d22f69sm28990695e9.10.2025.04.23.08.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 08:21:14 -0700 (PDT)
Message-ID: <15e24c455fb9fca05b5af504251019b905b1bd77.camel@gmail.com>
Subject: Re: [PATCH 31/67] KVM: SVM: Extract SVM specific code out of
 get_pi_vcpu_info()
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: seanjc@google.com
Cc: baolu.lu@linux.intel.com, dmatlack@google.com, dwmw2@infradead.org, 
	iommu@lists.linux.dev, joao.m.martins@oracle.com, joro@8bytes.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	pbonzini@redhat.com
Date: Wed, 23 Apr 2025 17:21:12 +0200
In-Reply-To: <20250404193923.1413163-32-seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-04-04 at 19:38, Sean Christopherson wrote:
> @@ -876,20 +874,21 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd
> *irqfd, struct kvm *kvm,
>  	 * 3. APIC virtualization is disabled for the vcpu.
>  	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
>  	 */
> -	if (new && new->type =3D=3D KVM_IRQ_ROUTING_MSI &&
> -	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
> -	    kvm_vcpu_apicv_active(&svm->vcpu)) {
> +	if (new && new && new->type =3D=3D KVM_IRQ_ROUTING_MSI &&

The `&& new` part is redundant.
