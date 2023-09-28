Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C058374D9
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 15:46:31 +0000 (UTC)
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-d866d13c637so16669991276.3
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 08:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695915991; x=1696520791; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UkV6DJLEp14NQoEGpYmTcHsFBbLNhclSblSFOKPN4t4=;
        b=yO5aMP9+wBQRky3LIPAxVd6SsnTk+Rt1sDntF0jcnw35TiNwVeL+L3R1Uvy29fZXWw
         RFRGa1v6cXdAkr0iGl2gBmX37/y5onGoHk+beBRk5aZTSMo59TfSFucIlkS5W9Y2M3xM
         MKmX7F2uvdi4bEGCLnYWN1eTtJB5DtBA2vXYujcuqoqRgSE0ALYpD9nNPE/sNzKOWBJa
         PuNsjxgdmbTSM4AUm5qlKGj/09HOCTmVf5XTBbA2OLYTI6uLfw6SDrTA+U7EDCRDI+W+
         9cRyEOdy3tJiMtM7qstUmz+xPV4SW9bGqpUKNSz+sAymqd7YkTDqKgTcNGUCBjZZEpt0
         1+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915991; x=1696520791;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UkV6DJLEp14NQoEGpYmTcHsFBbLNhclSblSFOKPN4t4=;
        b=nVucsi3WOQisxOYWr4AIpX6qsGil+zStchUs/3E4DCTaa/Nna5j1Zi/atf3Whhz7sR
         GA+MvWepWe8slJe5NaQevZIKcCZ1GcDH8QkZms9c/1R+8p+6BXE0B/6Swoe1MH0e3BXd
         e0FV0aYeg3GcSgu5T7bL5wVygeOIodXua4q2HAww4pxTkXGdP0z63+/QEJ5SflRYTxVj
         ZEQIGjCe7iuGPC3RFrTPbmj/W+fogSVXgP3z2Q3nFkbN/wwNq7lVXWocHS9Dsxgpgyjk
         ynhAeXaaasY1WlsvR+rHcIZqseIfq9vRjVKtj2Qu4RlUV551AnorlXUZTKuuOSoyOsOq
         b2xg==
X-Gm-Message-State: AOJu0YzqrXcB1eIwsnFJBs/9SjHBd9TR/0ww5eK1a716iV0+j/BgFLBA
	vE4fPDTDtVFKiSyzz7c/pUWXXshq8NY=
X-Google-Smtp-Source: AGHT+IEWX4T56HPfxAmtAicLu3EcKVpChcE7iMMF3BlcUKBkp8bJf66fPphCxJhGyetbdNcj2NdIprAzUe8=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:5f4d:0:b0:d7b:8acc:beb8 with SMTP id
 h13-20020a255f4d000000b00d7b8accbeb8mr24990ybm.2.1695915990966; Thu, 28 Sep
 2023 08:46:30 -0700 (PDT)
Date: Thu, 28 Sep 2023 08:46:29 -0700
In-Reply-To: <20230928150428.199929-3-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com> <20230928150428.199929-3-mlevitsk@redhat.com>
Message-ID: <ZRWf1Z7JCMUT92zt@google.com>
Subject: Re: [PATCH 2/5] x86: KVM: SVM: add support for Invalid IPI Vector interception
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> In later revisions of AMD's APM, there is a new 'incomplete IPI' exit code:
> 
> "Invalid IPI Vector - The vector for the specified IPI was set to an
> illegal value (VEC < 16)"
> 
> Note that tests on Zen2 machine show that this VM exit doesn't happen and
> instead AVIC just does nothing.
> 
> Add support for this exit code by doing nothing, instead of filling
> the kernel log with errors.
> 
> Also replace an unthrottled 'pr_err()' if another unknown incomplete
> IPI exit happens with WARN_ON_ONCE()
> 
> (e.g in case AMD adds yet another 'Invalid IPI' exit reason)
> 
> Cc: <stable@vger.kernel.org>
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/include/asm/svm.h | 1 +
>  arch/x86/kvm/svm/avic.c    | 5 ++++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/svm.h b/arch/x86/include/asm/svm.h
> index 19bf955b67e0da0..3ac0ffc4f3e202b 100644
> --- a/arch/x86/include/asm/svm.h
> +++ b/arch/x86/include/asm/svm.h
> @@ -268,6 +268,7 @@ enum avic_ipi_failure_cause {
>  	AVIC_IPI_FAILURE_TARGET_NOT_RUNNING,
>  	AVIC_IPI_FAILURE_INVALID_TARGET,
>  	AVIC_IPI_FAILURE_INVALID_BACKING_PAGE,
> +	AVIC_IPI_FAILURE_INVALID_IPI_VECTOR,
>  };
>  
>  #define AVIC_PHYSICAL_MAX_INDEX_MASK	GENMASK_ULL(8, 0)
> diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> index 2092db892d7d052..c44b65af494e3ff 100644
> --- a/arch/x86/kvm/svm/avic.c
> +++ b/arch/x86/kvm/svm/avic.c
> @@ -529,8 +529,11 @@ int avic_incomplete_ipi_interception(struct kvm_vcpu *vcpu)
>  	case AVIC_IPI_FAILURE_INVALID_BACKING_PAGE:
>  		WARN_ONCE(1, "Invalid backing page\n");
>  		break;
> +	case AVIC_IPI_FAILURE_INVALID_IPI_VECTOR:
> +		/* Invalid IPI with vector < 16 */
> +		break;
>  	default:
> -		pr_err("Unknown IPI interception\n");
> +		WARN_ONCE(1, "Unknown avic incomplete IPI interception\n");

Hrm, I'm not sure KVM should WARN here.  E.g. if someone runs with panic_on_warn=1,
running on new hardware might crash the host.  I hope that AMD is smart enough to
make any future failure types "optional" in the sense that they're either opt-in,
or are largely informational-only (like AVIC_IPI_FAILURE_INVALID_IPI_VECTOR).

I think switching to vcpu_unimpl(), or maybe even pr_err_once(), is more appropriate.
