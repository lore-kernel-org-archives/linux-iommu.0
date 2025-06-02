Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314C32494FF
	for <iommu@lists.linux.dev>; Mon,  2 Jun 2025 21:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748901551; cv=none; b=dmvxrTJUwh2v3DXqz6+84PshcUw050Rpwkjkb5TAwK95aG2Q5juClc0YQt5T6jxPOSisWEHHFOyyH3lisHt/DUomeHaf6l8pKlhjK1r/vHoeM+JXccndIhbBMQ1wqe+85BYV2YM39qFvHHq2+8DFs6g06CYbKUY/n1QTOeXROc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748901551; c=relaxed/simple;
	bh=Uq9DQhTBlwgkIbB9t2H8Mj9IDlkH0ESm4U+MMqQIJRk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=G7pYIeWwbvBeLINye9sgLVN7g98JLDnKHNKa3mzUBPfqG0WP32UPj9pXdrMJEJ3fb9JpVKMEilx9G7KbIK18zBVmZgKvIqb7WzWomQVskzeSZsph+Xi82RcMkC/AVL697Nwak0tRGasLS245QSWg7V6Kc5PNNQ2ejfQC8zRZ3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XSzyajGQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XSzyajGQ"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-742a969a4d0so4178375b3a.2
        for <iommu@lists.linux.dev>; Mon, 02 Jun 2025 14:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748901549; x=1749506349; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9QhFqKOR2kUc+mUo1rVAi0osS9Bm5VIMXg1evYyHe/E=;
        b=XSzyajGQLVk87HPUK2udgDR9Fsq0giYs2nrT1q0uGW8q/ho25c8Om269tBiSNSD0NY
         VadoPA3iEHFOEcpHJJRz7HaeR2TACYyrmQrIJebFOYuUFIiNvybbaTjvz5dkn0f7oJC4
         oVthMpcWLZXbfbmwHrM2t8SYAHmWTBiOcCHsk9iLo4luNQbNzLpjd99KDNmxRSVak3UO
         i6Fvwe5pZL2rAYmsp0HUfnN2S0JBaKnzla2OKi2RcY9he1aazmAf/BhZpVd//wka+XXN
         +aRnUdb1A2FxpKNGBjtxuKB6AyWIS5U63ob6V4Iiecl3zqNgJMafewICHFDfgLRpPyzs
         pwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748901549; x=1749506349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9QhFqKOR2kUc+mUo1rVAi0osS9Bm5VIMXg1evYyHe/E=;
        b=lpzVal/3DzrfUurGITLwTcVHiGMpNRWXvFD0Wc5fT73JNh4VWpbPccTVv4WtpW/Oul
         t3hl/7kIsTjvR+XJcdBA1vIBfTZBrDfVq2F9gVJ4CqJe5xfCuCp5H1kQCx0/L4aZsDPN
         rxhPsmxgUDg+xzH+CPw3dY6XC7LCRAUcInwb4rW1G/Y7SesAjSThI7QNLe3fWzLmKizS
         JwuoZ083znzrdt8/e5aNdCAZgDTASq1Z0qnpvdLDwGJdRI6wVfXOsVLwnTchUNKSlL6s
         +cKFcSCQdqFiFcDwHwQ4X8zZaVp7jnUoDDsxZw4fJ6WJccP77DZRTAV2XdVaT011NMyU
         l8Yg==
X-Forwarded-Encrypted: i=1; AJvYcCWl4F2m56Lvyp0pwvKrd5jNacNG7ptqCThcspXYCq1L7DWfN2yVShtRsbASkZSJsFrhvWjY6Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzwJXYi4P+FQbTl0ex2Nlfjn2JQ3jxkKVcSJEXHJyxPRqmro4ps
	NKpM7sazo+43XhtvRlPoGGZeAyDJ0MUuzFlCyEj1PIVBtkINqt1FiX5TFs/RMdo5deTbJDyHltv
	jJcf5wQ==
X-Google-Smtp-Source: AGHT+IG/GylPU+EY1o8XPm4YfEWI7SwzwPYH9j1avW8aqFxashcL73XjO9G4c/63vKt1A0SaKoI+30XGpcg=
X-Received: from pfjg6.prod.google.com ([2002:a05:6a00:b86:b0:747:a049:d575])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:986:b0:736:450c:fa54
 with SMTP id d2e1a72fcca58-747d1831e8amr11523980b3a.6.1748901549480; Mon, 02
 Jun 2025 14:59:09 -0700 (PDT)
Date: Mon, 2 Jun 2025 14:59:08 -0700
In-Reply-To: <9a64d394-e693-49fe-887b-3e4fa0f70878@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250523010004.3240643-1-seanjc@google.com> <20250523010004.3240643-39-seanjc@google.com>
 <9a64d394-e693-49fe-887b-3e4fa0f70878@amd.com>
Message-ID: <aD4erDTWk2VUIldC@google.com>
Subject: Re: [PATCH v2 38/59] iommu/amd: KVM: SVM: Infer IsRun from validity
 of pCPU destination
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Vasant Hegde <vasant.hegde@amd.com>, Maxim Levitsky <mlevitsk@redhat.com>, 
	Joao Martins <joao.m.martins@oracle.com>, Francesco Lavra <francescolavra.fl@gmail.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, May 30, 2025, Sairaj Kodilkar wrote:
> On 5/23/2025 6:29 AM, Sean Christopherson wrote:
> > Infer whether or not a vCPU should be marked running from the validity of
> > the pCPU on which it is running.  amd_iommu_update_ga() already skips the
> > IRTE update if the pCPU is invalid, i.e. passing %true for is_run with an
> > invalid pCPU would be a blatant and egregrious KVM bug.
> > 
> > Tested-by: Sairaj Kodilkar <sarunkod@amd.com>
> > Signed-off-by: Sean Christopherson <seanjc@google.com>
> > ---
> >   arch/x86/kvm/svm/avic.c   | 11 +++++------
> >   drivers/iommu/amd/iommu.c | 14 +++++++++-----
> >   include/linux/amd-iommu.h |  6 ++----
> >   3 files changed, 16 insertions(+), 15 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 4747fb09aca4..c79648d96752 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -832,7 +832,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   		entry = svm->avic_physical_id_entry;
> >   		if (entry & AVIC_PHYSICAL_ID_ENTRY_IS_RUNNING_MASK)
> >   			amd_iommu_update_ga(entry & AVIC_PHYSICAL_ID_ENTRY_HOST_PHYSICAL_ID_MASK,
> > -					    true, pi_data.ir_data);
> > +					    pi_data.ir_data);
> >   		irqfd->irq_bypass_data = pi_data.ir_data;
> >   		list_add(&irqfd->vcpu_list, &svm->ir_list);
> > @@ -841,8 +841,7 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd *irqfd, struct kvm *kvm,
> >   	return irq_set_vcpu_affinity(host_irq, NULL);
> >   }
> > -static inline int
> > -avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu, bool r)
> > +static inline int avic_update_iommu_vcpu_affinity(struct kvm_vcpu *vcpu, int cpu)
> >   {
> 
> Hi sean
> 
> What if define cpu as "unsigned int" instead of "int" and use nr_cpu_ids
> as invalid cpu id ? I see that it is common in the other subsystems to
> use nr_cpu_ids instead of -1.

My vote is for -1, as it makes the KVM side of things much more intuitive

E.g. this is pretty obviously saying "no associated CPU"

  avic_update_iommu_vcpu_affinity(vcpu, -1);

whereas this honestly just looks a bit weird.
 
  avic_update_iommu_vcpu_affinity(vcpu, nr_cpu_ids);

It also requires knowing what cpu numbers are strictly packed in the kernel, i.e.
that nr_cpu_ids is guaranteed to be greater than the cpu numbers themselves (e.g.
the the kernel can't have nr_cpu_ids=2 with CPU0 and CPU2 being the two CPUs).

I also don't love that nr_cpu_ids is __read_mostly, i.e. isn't const post-boot
(though at a glance, it looks like it could be __ro_after_init on x86 at least).
