Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636915A0
	for <iommu@lists.linux.dev>; Fri, 29 Sep 2023 00:24:21 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5a2318df875so13371637b3.2
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 17:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695947060; x=1696551860; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VK3yYTqUyZzwJjWPYCCiURL3L8OGDHEDjPYeZ/hC2E0=;
        b=LURjmy2fNFHxW2Lor17capi6cbXmLpnEJL5Srb0hk7jeYepW8IuFvU3vyNW3cLWlws
         gmcK/8nIqHEm/r0Kw5MNZ6VYer/W3Hxg9P+Az2/BIE7mVmb73hQu+ETpZC5XzL2b32kk
         UrjefnodTZKUOmr6w9xJYLjQNyhOfWkrspfYlcNGq/HhNcESpF0az9TptwMa+RtdCuHR
         jAIwfjqO27zbyWHYDuA26T1nhMf2tjjGDUIYR7UvxhpQVA02OSkcQB6yZ5kwNrcUiG7O
         QdB8lzoKThwmzPiJOemK4cym5Bkp++MQFPQ/nLHt/fTpMDpT77rJfVXcTec2yuh+vG6s
         Kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695947060; x=1696551860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VK3yYTqUyZzwJjWPYCCiURL3L8OGDHEDjPYeZ/hC2E0=;
        b=K5gL8o0qOSE3VK2e7JoWVTzCFfMMmK3qPIObiIoFpUD5v1VDa5WMGyZAAve8x4brhl
         qa67IuNWnqlQOr5Q68X1JmoAKsmQA0xsJKJfyT9DNwJqIYcf3tvcY34agZtHPAmDrnN2
         G77zFjEdroUri7vHZaHA+vN8oAUqZUp44sv6dTXaAxRUPeNJZTlzvITz4PFKx2MsUzUV
         BfawbvA5k59pO/gKWDKBllhxS4Tom3EmC0koempv3Or60AWWF5M/bMt8eqo0llNzSQvQ
         7v6mcyo5v3Au+COgH3rS1AxvW2M0V1BxzT6kxi3TKsCoLUTsmOA0q0WSrAHCA3iB7iPp
         4/MA==
X-Gm-Message-State: AOJu0Yyq6pCo1yUl0KjoA0NwAlwEoR020XqFYD59BLgkRQxNLKDjmHkB
	eaf8QtD6Q0037f+SL6i2h3Kub0y6LiU=
X-Google-Smtp-Source: AGHT+IEOayytUoGF6yiau9EKJIk7fPZSTKse/XCvu4K9plygAETxpWB9IOofC6SPGiHL7SAKxLP/YXrGXcc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:aa48:0:b0:59b:f493:813c with SMTP id
 z8-20020a81aa48000000b0059bf493813cmr44356ywk.9.1695947060234; Thu, 28 Sep
 2023 17:24:20 -0700 (PDT)
Date: Thu, 28 Sep 2023 17:24:18 -0700
In-Reply-To: <20230928173354.217464-2-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928173354.217464-1-mlevitsk@redhat.com> <20230928173354.217464-2-mlevitsk@redhat.com>
Message-ID: <ZRYZMr4fuaywW7fP@google.com>
Subject: Re: [PATCH v2 1/4] x86: KVM: SVM: always update the x2avic msr interception
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, 
	"H. Peter Anvin" <hpa@zytor.com>, Paolo Bonzini <pbonzini@redhat.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, Joerg Roedel <joro@8bytes.org>, x86@kernel.org, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, linux-kernel@vger.kernel.org, 
	Dave Hansen <dave.hansen@linux.intel.com>, Will Deacon <will@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Robin Murphy <robin.murphy@arm.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> The following problem exists since x2avic was enabled in the KVM:
> 
> svm_set_x2apic_msr_interception is called to enable the interception of

Nit, svm_set_x2apic_msr_interception().

Definitely not worth another version though.

> the x2apic msrs.
> 
> In particular it is called at the moment the guest resets its apic.
> 
> Assuming that the guest's apic was in x2apic mode, the reset will bring
> it back to the xapic mode.
> 
> The svm_set_x2apic_msr_interception however has an erroneous check for
> '!apic_x2apic_mode()' which prevents it from doing anything in this case.
> 
> As a result of this, all x2apic msrs are left unintercepted, and that
> exposes the bare metal x2apic (if enabled) to the guest.
> Oops.
> 
> Remove the erroneous '!apic_x2apic_mode()' check to fix that.
> 
> This fixes CVE-2023-5090
> 
> Fixes: 4d1d7942e36a ("KVM: SVM: Introduce logic to (de)activate x2AVIC mode")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---

Reviewed-by: Sean Christopherson <seanjc@google.com>
