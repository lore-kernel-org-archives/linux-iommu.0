Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F472857F5
	for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 17:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744306191; cv=none; b=BoG9/CLwG39J+4URABXG9EllgjbCrBnPoeLGkycg6kbwPZRZ81VFFnVpKPaqKykbuWz6bl+2xQ1xKh8SKWUg3xeLkW5OoEn/TOskvdVOgKZzjTrv6dI5LQl556ZEdtthUr82NT31CCcQi0l3cRFwbfj/5B5zSeDuh+NHhS3K+Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744306191; c=relaxed/simple;
	bh=8RGWQcgCimLPvpiAlk+5F2R9ep2gNgiJpKOuy3wGtDc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pX2MAPFzqZVDlVVhw3cJ6i8Th3rOl/Iwuy8/Hklh7C80NMPwqSeN2I2WOGnZJeMuLnmiwjJ8jsBHVRjcgCFnHY7QHIoP0r1PQXLvFylLotm83SxLfV1JvyLiSz83+DHjTSL4txEUBJJwoRvCbDpi0wgWzecYBPEILm6SB+7uKcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=H0jmrKx1; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="H0jmrKx1"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-73720b253fcso843463b3a.2
        for <iommu@lists.linux.dev>; Thu, 10 Apr 2025 10:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744306189; x=1744910989; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=THh7USP0TMmHVXYAIYVxQL6srWNoxeq+S60T+Iuc4Go=;
        b=H0jmrKx1Y7Wwb2jKkNKiTtmE5HOHTq17sSQ25/eU2D/OEikREBVWwJsdBrBO5UBY5q
         JVtq7xwGguJIrbinNnexvkSaRfSQ/9FwCYoNIaI0HP5hYW6S81kTbT3b1FPnOgdMicy9
         6sOhQfgzf75gpQ0hWU/9DEPWPJQrTds02GVmmTx4aZvqkgZVOJQyNq0QOb0+Xx0MCt/x
         ExgcQn2UX1lvVRze9V/QtQmt0FAc9MrnDg8tp2F+Q3vZ/6hKhjBtho8w0wOl15qlyqia
         aUUm1DN1sKDPIjO0PidwhuQDALjLrXrY1Id1bDRQ9ZPj/YL5BWMIh1Zb6YU9KG3zTmAe
         BydQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744306189; x=1744910989;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=THh7USP0TMmHVXYAIYVxQL6srWNoxeq+S60T+Iuc4Go=;
        b=Zc+EASJa75Zo1DqdnFFLNn750FmyxtHE2o/rtIWG+M7iA6jBkgQSTgVjlcReW1YWpd
         rDrV34b1X3ZZFGTlCt0Sn/NYATp23WhZNOtRoQoy9o+oVx7pKN8fQeUtsex3OGpPvDdF
         MXv8eFHUHmzj8d+qAjh5+0vGOGoYI2qa7ZN/rSUwmD35f1JXh8bKMKUAMViiXQyHD/Di
         H30eS1wcOcafJ+lkWWl9/TPbSzn+44MkXBta/y2BRPVmv5HDp6tuLkh25Pyx0Q8V+o1X
         wyo5BRqk0GaQfTjIg6txgC+utrXvBvRNUSlCzcUZjW+2oLxbBYpxh1O0NkSFquxxQYhO
         SzRw==
X-Forwarded-Encrypted: i=1; AJvYcCUyGgiubyIOnUWUjtC1+mnLvb7P5nRKpeOPcisYMzaLNZ0pF5T+q+mB/sKXT4hvP/7QKPiQHA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyQZKsWNvT8hnlQ6+9/tvWqvBz8VWeuzhaFGgcELfds9KfsWNkd
	zWy3Sk94AYEzmyM0zzDWBaeeLmaPJWLpmK+6Z9xfrODdH0m0UrWW4EAf0rGLP7YWFSjN2Oga3Nl
	z9g==
X-Google-Smtp-Source: AGHT+IEzEm4pFNJ9RE2IrAYwwiomzZvMX+btxSqy0ddwSL3trJyRQq2fiWUm5uHQQn8B4/4qgmhNau+bVpY=
X-Received: from pfbcw22.prod.google.com ([2002:a05:6a00:4516:b0:736:79d0:fd28])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:891:b0:736:34ca:dee2
 with SMTP id d2e1a72fcca58-73bc0a15157mr4684403b3a.4.1744306189171; Thu, 10
 Apr 2025 10:29:49 -0700 (PDT)
Date: Thu, 10 Apr 2025 10:29:47 -0700
In-Reply-To: <bba773d0-1ef9-4c9f-8728-9cf0888033ad@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250404193923.1413163-1-seanjc@google.com> <20250404193923.1413163-65-seanjc@google.com>
 <9b7ceea3-8c47-4383-ad9c-1a9bbdc9044a@oracle.com> <Z_fnrP4e77mKjdX9@google.com>
 <bba773d0-1ef9-4c9f-8728-9cf0888033ad@oracle.com>
Message-ID: <Z_gAC9DLG-q9poGV@google.com>
Subject: Re: [PATCH 64/67] iommu/amd: KVM: SVM: Allow KVM to control need for
 GA log interrupts
From: Sean Christopherson <seanjc@google.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Maxim Levitsky <mlevitsk@redhat.com>, David Matlack <dmatlack@google.com>, 
	Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, 
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Joerg Roedel <joro@8bytes.org>, David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"

On Thu, Apr 10, 2025, Joao Martins wrote:
> On 10/04/2025 16:45, Sean Christopherson wrote:
> > On Wed, Apr 09, 2025, Joao Martins wrote:
> >> On 04/04/2025 20:39, Sean Christopherson wrote:
> >> I would suggest holding off on this and the next one, while progressing with
> >> the rest of the series.
> > 
> > Agreed, though I think there's a "pure win" alternative that can be safely
> > implemented (but it definitely should be done separately).
> > 
> > If HLT-exiting is disabled for the VM, and the VM doesn't have access to the
> > various paravirtual features that can put it into a synthetic HLT state (PV async
> > #PF and/or Xen support), then I'm pretty sure GALogIntr can be disabled entirely,
> > i.e. disabled during the initial irq_set_vcpu_affinity() and never enabled.  KVM
> > doesn't emulate HLT via its full emulator for AMD (just non-unrestricted Intel
> > guests), so I'm pretty sure there would be no need for KVM to ever wake a vCPU in
> > response to a device interrupt.
> > 
> 
> Done via IRQ affinity changes already a significant portion of the IRTE and it's
> already on a slowpath that performs an invalidation, so via
> irq_set_vcpu_affinity is definitely safe.
> 
> But even with HLT exits disabled; there's still preemption though?

Even with involuntary preemption (which would be nonsensical to pair with HLT
passthrough), KVM doesn't rely on the GALogIntr to schedule in the vCPU task.

The _only_ use of the notification is to wake the task and make it runnable.  If
the vCPU task is already runnable, when and where the task is run is fully
controlled by the scheduler (and/or userspace).

> But I guess that's a bit more rare if it's conditional to HLT exiting being
> enabled or not, and whether there's only a single task running.
