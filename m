Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4F61F583D
	for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 14:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744381970; cv=none; b=tF+8BKG+qCGjHKLbTXT+ZD4LJLXz5G8TyE7aMIqqJMQVlwv7OvA49wnfLgCS5s7XHpszqIoKJ3q+Q3/+NqGw1nolI2Vi01UqC6hUALhXIC9szsog+NqUOn+e+V5J+ahAOZh7nFxPCIHXAGt3cT8q0y3z61acVnHQNp4ctvfVjeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744381970; c=relaxed/simple;
	bh=0uBVlVl6zt2smmydXiApRvxiKMlTSisj2Yu/ktHw5O8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pdzuCcqWQTogv7PBCoizhDEgpU0i0XiETYSYebIicwYIujOJ4/NMNjJNZUZnwMIxxGrL/MgSKs2l1dHmD1yIPVOanISKPQ/L+mKv9jPRuoRs174qwPUvoL2MgMdjbQrTJFx9hsdJLqCM783AGDRAadRkh+d7DYPnJYGGA2m/OO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F+pRbz7T; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F+pRbz7T"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-736cd27d51fso1821316b3a.2
        for <iommu@lists.linux.dev>; Fri, 11 Apr 2025 07:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744381968; x=1744986768; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WdYWtwGlFqkOjqypokEB9CfaYMOynOKxQo9pc/iInzs=;
        b=F+pRbz7TEUMQ1iz/rW1nCiWHRfI2vJ0fRARQtKd5aqgOxKkQvY+F0uR7MmZUv/OY/l
         dDO1HkUAeO+svVtXvzbRA/Aq3tLJnjuL0MVNE3hWTkxlYzRK8LWVut+jlnqBN2g23pjY
         isDh9T7KSXSI7MpBKeZHWTSoZAYn+aZPqcM1mkh5qarQ1HtiAOvZ5byWJ9CvVBb/K6gt
         4sOBauTaWR5+hEM0iqcwyLQyBBffA/VMhv2B6rm8n37nPiFe5wSELQZCQpXks8E6u/Gh
         6sDLjI7IDb9HHorjb1XQUPMKgb5viqJnRrmxsy+aTFyo/T75h9r4ryJtGCvKNW+PTIrM
         X+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744381968; x=1744986768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WdYWtwGlFqkOjqypokEB9CfaYMOynOKxQo9pc/iInzs=;
        b=FcOV9rkLf3m4efeSI8nvOu7VwR1JgEvQGa6G1k1Jrn3uSCjXGmALiV8ByJVvqyflje
         1Gc1OBMvdzHs7y0Rm+y66kUZeu6M8xHNZyniyBTywinhO1txRT4kSmFuxL+jHQ/mVPP7
         GinuZVsOoENNIQ9IjsU8Ua6n6LIT0mvJOlGzStYdWpfIDClEh1Oo8q7RUi/7CSL3y81D
         cnEmIwKCjplTmHCz/+RsKFe3oQJKGrl6+oT/LbUm4ZBji7nduo9ZeYXpki0l18rvGFS8
         7yWrAgQetSSNm6ofjosx5Eb2EBLKsmvQq3iVQsOqKbRZEz3pbsvi73t9PAQWfjQAUA9N
         yr4w==
X-Forwarded-Encrypted: i=1; AJvYcCViZm3JrYXsZFUUDGSseHOQW+BegKLEvVVt8jJIiRznaBMuGN2s6p4gzI+1ggiCKC1Y9GxvVA==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywn7+l8BxFVzWdpnyJaRr91fCqVYJ2UQu1yHniaTIPMLh/B6R/w
	qlhDiJfYiOeQf2bJbYPAgrHlbDS4YIKIRQwybcruKegu8r+Ht1pmuX46GojIvj3p63wfjzeEG1L
	TpQ==
X-Google-Smtp-Source: AGHT+IFyxCzl6htX/DS8ClLuQoR7pJ/TqB4Bmf2NEvfb9DmOqq4wCNxnwjdldtCmTRsZzd2uBHMx+RmD5A4=
X-Received: from pggs1.prod.google.com ([2002:a63:dc01:0:b0:af2:50f0:bc79])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:32a2:b0:1f5:7007:9eb7
 with SMTP id adf61e73a8af0-20179983274mr4861364637.37.1744381968654; Fri, 11
 Apr 2025 07:32:48 -0700 (PDT)
Date: Fri, 11 Apr 2025 07:32:47 -0700
In-Reply-To: <d6ccf531-2ed0-4e38-97a5-2b747497fadb@amd.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-10-seanjc@google.com>
 <d6ccf531-2ed0-4e38-97a5-2b747497fadb@amd.com>
Message-ID: <Z_knw1j6KeaEHVxr@google.com>
Subject: Re: [PATCH 09/67] KVM: SVM: Track per-vCPU IRTEs using
 kvm_kernel_irqfd structure
From: Sean Christopherson <seanjc@google.com>
To: Sairaj Arun Kodilkar <sarunkod@amd.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, kvm@vger.kernel.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Apr 11, 2025, Arun Kodilkar, Sairaj wrote:
> On 4/5/2025 1:08 AM, Sean Christopherson wrote:
> > diff --git a/include/linux/kvm_irqfd.h b/include/linux/kvm_irqfd.h
> > index 8ad43692e3bb..6510a48e62aa 100644
> > --- a/include/linux/kvm_irqfd.h
> > +++ b/include/linux/kvm_irqfd.h
> > @@ -59,6 +59,9 @@ struct kvm_kernel_irqfd {
> >   	struct work_struct shutdown;
> >   	struct irq_bypass_consumer consumer;
> >   	struct irq_bypass_producer *producer;
> > +
> > +	struct list_head vcpu_list;
> > +	void *irq_bypass_data;
> >   };
> >   #endif /* __LINUX_KVM_IRQFD_H */
> 
> Hi Sean,
> You missed to update the functions avic_set_pi_irte_mode and
> avic_update_iommu_vcpu_affinity, which iterate over the ir_list.

Well bugger, I did indeed.  And now I'm questioning my (hacky) testing, as I don't
see how avic_update_iommu_vcpu_affinity() survived.

Oh, wow.  This is disgustingly hilarious.  By dumb luck, the offset of the data
pointer relative to the list_head structure is the same in amd_svm_iommu_ir and
kvm_kernel_irqfd.  And the usage in avic_set_pi_irte_mode() and
avic_update_iommu_vcpu_affinity() only ever touches the data, not "svm".

So even though the structure is completely wrong, the math works out and
avic_set_pi_irte_mode() and avic_update_iommu_vcpu_affinity() unknowingly pass in
irq_bypass_data, and all is well.

struct amd_svm_iommu_ir {
	struct list_head node;	/* Used by SVM for per-vcpu ir_list */
	void *data;		/* Storing pointer to struct amd_ir_data */
	struct vcpu_svm *svm;
};


struct kvm_kernel_irqfd {
	...

	struct kvm_vcpu *irq_bypass_vcpu;
	struct list_head vcpu_list;
	void *irq_bypass_data;
};

Great catch!  And thanks for the reviews!
