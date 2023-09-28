Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4C913AFB
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 16:03:32 +0000 (UTC)
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-1c73fb50da6so2726695ad.0
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695917012; x=1696521812; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=MFUmYNpX6rTwdApxep2QFE0XCc25ZJa3cg6mPE92sAo=;
        b=annwDoNexAKHEjtE6ToO/ncY3ra4Ll36dbgFLVk24GMCvUTHumvCU7ILdJDvsMm2c7
         PM5abWvLO9Ru7JUgRyWlRm1fA3JkROJsn+imKv+iYh3iq4q2ZTqSS+GCZ15sAt5yvfMD
         82fS5kx7o5aCKpGv8O01KivIlf8b/8ukUNy1hlDFLLAALAfjNG0hAOgVEhN+ckU6S3yB
         aT9q5qVuUEkVnyLG202SJDjwtERN4aVqy+hHEvQdj1x25t0uuGs1PsFRV/6JZTNlk2/9
         P/hA+qHOayq/RjV7bFR6iJedHxFQg3wqpa5zyr2CnnON/b/muTwHf5gG3AEFYm2wqZL3
         SIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695917012; x=1696521812;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFUmYNpX6rTwdApxep2QFE0XCc25ZJa3cg6mPE92sAo=;
        b=ReXtjb1ZKh+X/jJFWrzPt6Q+HFTTq11qdTxBu0o1vKfZdmR85w1RLKLY7r0FqaD31V
         q3WBYtiF5UJgAnHrPMwTBO8M4ODRKoiRMdn0gHOorq3LvRiIbogxv67bxmnEhWCWAZaG
         IR1jeo9+YzY3JTdxNbqoFhWnzlC3ce3DLmi8yDk5sAHKCJkJXoC/NtkEbLCJL8PJbnW0
         W5JRnRs1VWy6PmZMdcAFNPymVmf4MiZvW6tv7jf5+p04bKSm+6xZRgi2SZFwpK7UDL22
         yHMabQeeSgHmmIpDxAxiOAumbMGIz7di+t544UVFKWN7hRLVuBl4ha+8kD955h2UX6v1
         bNmw==
X-Gm-Message-State: AOJu0YycIq/OUbeSMXZZOarMjm4KCFrGzOZYyLCqe+HuPuaX96VpL+qw
	Bc79Fqb7dxpC7LCZFNAcz7q9hKkk+78=
X-Google-Smtp-Source: AGHT+IFNYZN6ptDJkMmwLSNuZPQjEWOAcWQREE8N0qlp/jqzMy/uAdJQYt5rwc8mhcDZlWu1erWrGHWMPok=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:902:e5c7:b0:1bb:c7c6:3462 with SMTP id
 u7-20020a170902e5c700b001bbc7c63462mr21438plf.8.1695917012352; Thu, 28 Sep
 2023 09:03:32 -0700 (PDT)
Date: Thu, 28 Sep 2023 09:03:31 -0700
In-Reply-To: <20230928150428.199929-4-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com> <20230928150428.199929-4-mlevitsk@redhat.com>
Message-ID: <ZRWj0_VGvrg148He@google.com>
Subject: Re: [PATCH 3/5] x86: KVM: SVM: refresh AVIC inhibition in svm_leave_nested()
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
> svm_leave_nested() similar to a nested VM exit, get the vCPU out of nested
> mode and thus should end the local inhibition of AVIC on this vCPU.
> 
> Failure to do so, can lead to hangs on guest reboot.
> 
> Raise the KVM_REQ_APICV_UPDATE request to refresh the AVIC state of the
> current vCPU in this case.
> 
> Cc: stable@vger.kernel.org

Unnecessary newline.

Fixes: f44509f849fe ("KVM: x86: SVM: allow AVIC to co-exist with a nested guest running")

> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> ---
>  arch/x86/kvm/svm/nested.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> index dd496c9e5f91f28..3fea8c47679e689 100644
> --- a/arch/x86/kvm/svm/nested.c
> +++ b/arch/x86/kvm/svm/nested.c
> @@ -1253,6 +1253,9 @@ void svm_leave_nested(struct kvm_vcpu *vcpu)
>  
>  		nested_svm_uninit_mmu_context(vcpu);
>  		vmcb_mark_all_dirty(svm->vmcb);
> +
> +		if (kvm_apicv_activated(vcpu->kvm))
> +			kvm_make_request(KVM_REQ_APICV_UPDATE, vcpu);
>  	}
>  
>  	kvm_clear_request(KVM_REQ_GET_NESTED_STATE_PAGES, vcpu);
> -- 
> 2.26.3
> 
