Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEAD27979C
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 15:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745423760; cv=none; b=UjIGurQj6k6qC74Z77uWj1Vy9CdGNLbfcw/ZXpED5TYNZg73Z8EgTOOQi7rz3rRuz60INkkzDyFDAGQafTcc8mue60n711Dtlmevb8M7helZ9WaF95pNDbRfhZFLLoaGoQ5jDnM6PXvCyNfR4zuLT2mOppBbg7TaFauYgeBtLRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745423760; c=relaxed/simple;
	bh=+2Q0TqTUlO+XxdYqin3kJ59kqtlT8h5Kw4yFiitoAu4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=KEFY/3Punw4TZnMRaH+GmcrYlixDBpC4J8c9i4pv7mZ9GkVzNJPnFCG+OFDE/+oBxSt8RWiPa4tLx1CtvEjgbWaQPGZyJ0OXD3RBMs22AxhPS/h8q3SL5PyPZvnG3Z6k9ZGHs6TcvnT7uqil0hIWAGAi8dos3LzVZ2kA08gA9NQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d+KIuWYc; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d+KIuWYc"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so3786285a12.2
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 08:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745423758; x=1746028558; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jmJGVTNM68EN1Na+PFsjzt6zkvxFPDOKXQFGaHd/MNo=;
        b=d+KIuWYcmNK42KkbSD/5aDkPHOnDAYHSVNVfayeamQX4zVuPGlPJETvks4apJge1lG
         tgubiOywao6oE1bjbxPYsc3V1XKTiCblMV40X0wOlDX1ETE8gmlV+yEQdcemvUZdzA3R
         pCauc0vKFLmz77SEtIiCjpaHF21TH5jV96prLJhKznNvjLQnoUbAn6KeISe7NG8nYlqm
         0F0efR7CdqcPzjetZElPFY8e4Cg4bm4zKG74x6HtmBG92XmRLUowFf0MjMKbF8Pg0Q/X
         wIo+pYO2IDEM46AKH0c/X3qlgr+ORUCVhH+rjfuxJkF1tNLv7isDb3gP0WI7mOt+BVRy
         9Csw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745423758; x=1746028558;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jmJGVTNM68EN1Na+PFsjzt6zkvxFPDOKXQFGaHd/MNo=;
        b=Cxsei3YpcMWIDGR6ZrdnMth/waES9AIybb4RjQf27qvbyNllFSdB4N4qdN/pmlngOw
         4u5i6t0BjYcWp6TfkX8nH1u+xANnePaIbUQyCUjF7UWsTMQN8OtHPNWosNiU7OYoz/j6
         5cSixhbHMOskTVlSuhvCeg4VJBGgJGky0vm3idv9g3IGmLCTYJqpUHPQV9F8t//Ab7Ye
         1Js51HjUP4FBkjEQ+am+ieKALF8/rNldYe6OVyAAFyOo0+1YMcBCxyxDGzLwrD/8vDqw
         gs9oJuQ2J99YsWp7neV55vq2BB17zELppbKTTFz3viIc/ncYJe5ns+aXoqeGvBK7v4x7
         FTqw==
X-Forwarded-Encrypted: i=1; AJvYcCVCpepXMki/dS80GK1tcdITwBlOdOGFHLyrdEoI5ujECtInamjO9cKjSW0laBr5Xp+GLX9ceA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy56VsYisqdqqDsKBdSE7+JOLuBElSoX7FqloFd1v9hl/7Tq30G
	bZNgL8/Yj3QK/IWFgASyaK2/GA6OKXMzs+dubRXgzN9ggUDxwmA5ZVtDMz1vs2s4IHr5xJ6lLdH
	J0w==
X-Google-Smtp-Source: AGHT+IHnOGraDXWHVwtcHF/KJZows5bTw5g1o0e7YCWv5QZQLWNkV6iHhA0+G3682VIduWV5Xwdn6KbTATw=
X-Received: from pjyp14.prod.google.com ([2002:a17:90a:e70e:b0:2fa:15aa:4d1e])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2404:b0:309:eb44:2a58
 with SMTP id 98e67ed59e1d1-309eb442db3mr417907a91.22.1745423757994; Wed, 23
 Apr 2025 08:55:57 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:55:56 -0700
In-Reply-To: <15e24c455fb9fca05b5af504251019b905b1bd77.camel@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-32-seanjc@google.com> <15e24c455fb9fca05b5af504251019b905b1bd77.camel@gmail.com>
Message-ID: <aAkNjKIleB97r2fe@google.com>
Subject: Re: [PATCH 31/67] KVM: SVM: Extract SVM specific code out of get_pi_vcpu_info()
From: Sean Christopherson <seanjc@google.com>
To: Francesco Lavra <francescolavra.fl@gmail.com>
Cc: baolu.lu@linux.intel.com, dmatlack@google.com, dwmw2@infradead.org, 
	iommu@lists.linux.dev, joao.m.martins@oracle.com, joro@8bytes.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, mlevitsk@redhat.com, 
	pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Apr 23, 2025, Francesco Lavra wrote:
> On 2025-04-04 at 19:38, Sean Christopherson wrote:
> > @@ -876,20 +874,21 @@ int avic_pi_update_irte(struct kvm_kernel_irqfd
> > *irqfd, struct kvm *kvm,
> >  	 * 3. APIC virtualization is disabled for the vcpu.
> >  	 * 4. IRQ has incompatible delivery mode (SMI, INIT, etc)
> >  	 */
> > -	if (new && new->type == KVM_IRQ_ROUTING_MSI &&
> > -	    !get_pi_vcpu_info(kvm, new, &vcpu_info, &svm) &&
> > -	    kvm_vcpu_apicv_active(&svm->vcpu)) {
> > +	if (new && new && new->type == KVM_IRQ_ROUTING_MSI &&
> 
> The `&& new` part is redundant.

Ha, good job me.  Better safe than sorry?  :-)
