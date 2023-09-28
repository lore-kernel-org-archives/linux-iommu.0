Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3578836
	for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 15:37:20 +0000 (UTC)
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-59f4f2a9ef0so224439207b3.2
        for <iommu@lists.linux.dev>; Thu, 28 Sep 2023 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695915439; x=1696520239; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ESjv6/OZiwDAaibxySOEd24QWBP6h1ze9OpmoOfalec=;
        b=vRWk/+abzA31TTJq+SoWguUr15n2e1mCvz8gTCpcIJFXjB98x1YTVhpGQu3iD3cUQf
         i/smeZoZG7DI14ApuNP/rq8hxs89AwdD+PJOVxUEb2Ww+aFkEFNOecChK3vC57FCJVm1
         /HAi4wIPb4WTJZ0THOKe2hEMWK5OjRz8xF+bFar8QgtgtMFg6wxyuN6TJ785Gpq+eMgl
         h0gIv9L3jy4lNV8pxW2je8+s7bVMrVrHwjHW8SlkJK6SKc5oeDDF1gETMU598LhpyOyP
         8Ak7UV6z57RrbAZYXrRXg02enz2laz8VLXmCQKNvmk+sK/kSg2BjIHz68ZkgmlKPQPI8
         DVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695915439; x=1696520239;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ESjv6/OZiwDAaibxySOEd24QWBP6h1ze9OpmoOfalec=;
        b=IGKWN3Lqzx1PuXq/dI29dNuaiBUqfRkY4sKbWXi4TCSv5N27mulbO0oosGqUgcu/mu
         23B21KeitJArmC7Lf7eIgG3VpFHDnkjPt3nPy4f4SgBKE1bS+gABVZL35O9IEHjS8j2w
         GL2xftRpjINYKefj43sjl+1/FGISCobRnuXUfE/dpZtHeo9WI1BaUgovbPbq8B97mL98
         +f84gD/4mC61/RjvAzJYkn6FGFIxg8YOpDZ6KXuh5oMFum4uoCVWo97LgCqG86GtMQj+
         f1ljNhPA8yVGNfEw4f2Tn732v9KCeuw99M5pxKYPIL8eYxJrZpXYLovqRfSsMCDCLitU
         9xUQ==
X-Gm-Message-State: AOJu0YwB5CP/DG14hj2n4sPVSDvI6msZPuRgsudytaT4RFKh0/ptPWbX
	kVYv8SsA7dlfG2mYKfnpTaF2hKdm+uc=
X-Google-Smtp-Source: AGHT+IEGP17fNTPrQ4AyY729ngrGoUL/gl5UpyjrVFFDHHoJHMKzXnWTPF8kdaQC3pFKL2kLKxYzCqKL1hQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:b709:0:b0:5a1:d329:829c with SMTP id
 v9-20020a81b709000000b005a1d329829cmr24447ywh.0.1695915439513; Thu, 28 Sep
 2023 08:37:19 -0700 (PDT)
Date: Thu, 28 Sep 2023 08:37:18 -0700
In-Reply-To: <20230928150428.199929-6-mlevitsk@redhat.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20230928150428.199929-1-mlevitsk@redhat.com> <20230928150428.199929-6-mlevitsk@redhat.com>
Message-ID: <ZRWdrtHynEbtQnpZ@google.com>
Subject: Re: [PATCH 5/5] x86: KVM: SVM: workaround for AVIC's errata #1235
From: Sean Christopherson <seanjc@google.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Paolo Bonzini <pbonzini@redhat.com>, x86@kernel.org, Robin Murphy <robin.murphy@arm.com>, 
	iommu@lists.linux.dev, Ingo Molnar <mingo@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM: SVM: for the shortlog scope (applies to all relevant patches in this series)

On Thu, Sep 28, 2023, Maxim Levitsky wrote:
> On Zen2 (and likely on Zen1 as well), AVIC doesn't reliably detect a change
> in the 'is_running' bit during ICR write emulation and might skip a
> VM exit, if that bit was recently cleared.
> 
> The absence of the VM exit, leads to the KVM not waking up / triggering
> nested vm exit on the target(s) of the IPI which can, in some cases,
> lead to an unbounded delays in the guest execution.
> 
> As I recently discovered, a reasonable workaround exists: make the KVM

Nit, please just write "KVM", not "the KVM".  KVM is a proper noun when used in
this way, e.g. saying "the KVM" is like saying "the Sean" or "the Maxim".

> never set the is_running bit.
> 
> This workaround ensures that (*) all ICR writes always cause a VM exit
> and therefore correctly emulated, in expense of never enjoying VM exit-less
> ICR emulation.

This breaks svm_ir_list_add(), which relies on the vCPU's entry being up-to-date
and marked running to detect that IOMMU needs to be immediately pointed at the
current pCPU.

	/*
	 * Update the target pCPU for IOMMU doorbells if the vCPU is running.
	 * If the vCPU is NOT running, i.e. is blocking or scheduled out, KVM
	 * will update the pCPU info when the vCPU awkened and/or scheduled in.
	 * See also avic_vcpu_load().
	 */
	entry = READ_ONCE(*(svm->avic_physical_id_cache));
	if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
		amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
				    true, pi->ir_data);

> This workaround does carry a performance penalty but according to my
> benchmarks is still much better than not using AVIC at all,
> because AVIC is still used for the receiving end of the IPIs, and for the
> posted interrupts.

I really, really don't like the idea of carrying a workaround like this in
perpetuity.  If there is a customer that is determined to enable AVIC on Zen1/Zen2,
then *maybe* it's something to consider, but I don't think we should carry this
if the only anticipated beneficiary is one-off users and KVM developers.  IMO, the
AVIC code is complex enough as it is.
