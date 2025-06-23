Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E407F28ECDF
	for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692610; cv=none; b=SKBK+wK3sQgTP0NlEYWjuETyFqfd0vszZrhBG4YiyTFCMGhAEeIkEfIFHwM0gSolLqsqwkC31cNvrVwQ/21vphrf7s4giu9VxMKxyI9yTK6EW3SwiDkJMlEL7P6Lgr5PhuszAUcwL889rZVACI4+CG/Fo2bj/6Xx+pQE0JNdSlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692610; c=relaxed/simple;
	bh=L/cfSGnSX28XY4cLKESl0PHduhleGIW8TtQJ6a7uSMg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=PKke9as3/eOlmffJ2KOs4XKO5NJoegsNhMc+l2Ms5cY+SmvTRG6s7qXLwFTUyvle4v534Ufytvo4N6PinqC0CMel+RH69dnT1JBoL9bA/VgRHUWqogHvEM/0cELFAqbLU3urH6Mo6fXxr1rPp9UhQbpoDdd8BGa3swdScKPe9uE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1HXLUdgZ; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1HXLUdgZ"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-23638e1605dso30301715ad.0
        for <iommu@lists.linux.dev>; Mon, 23 Jun 2025 08:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1750692608; x=1751297408; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=KdWZjBOZrnoU5S/xxe3p4LyXR96yMFXC81nKL3+yk3w=;
        b=1HXLUdgZVdg9xeEiuy2UdlWq8CG+frtcwPIraHkPh1Z0IZR/XOszgOemOC9YPEEHUF
         q1KVailL+EelZxZFFnlv7upC65+yse/hTSHoBBz/ERawX5oR3desG7b0VTBS09vvZvFb
         8elgoCsEbdSOBYsk0nRgVzeZ3y2YKMN08a3Fu3ARBfPlpjG5fk2Fso3ZR/vUyZ+b3Kpi
         nh1HcK1+BU5FSVb0R+UksyGgWza6Ynv4LCYKApBy2+Qd22nLHLUfwumkOmZO2DDzHYGT
         B4iMXs0XaG01QT//K7DBX0J7lZxPabgNl2ncelMKfh7w91fYGa8IBLRMJfz/XWX85lEr
         fR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750692608; x=1751297408;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdWZjBOZrnoU5S/xxe3p4LyXR96yMFXC81nKL3+yk3w=;
        b=eBhZonBEZakSk4tWrLQE1U+ue6WzVOfLZn3GKvCHnHFcTHNOv7uY1AaEPhq3c9eDNF
         JUKikWZHFQ7gB4L/KFQ43N+bfmOqdBBhPmkDrEE2Y5/pwTPskp4iu05ZfJndDnVlLoHB
         LiPDGtTk+WBKlxSXXwlv0bzcCfF2QGGVzVVIeSLQkwjobmB1DF6U0yXEEXn2QNAGlwKm
         mP6Eh6Z3nhF1IIIEjY4vqQthH+koP3PVBgXQMFGUDNmgj9IUEWveBoqN2jbVxbBBkbJM
         DMmvx4VnBfohNpiNg/BLmnjYFzUqRgk3vnklzfSJzksiZbd2jBO93Z4R0dtG43Mjit6k
         Bn3g==
X-Forwarded-Encrypted: i=1; AJvYcCX+8GS8lrbf1JUM1JS8iVcPc3NynXQ9X3I6PNlL3dz4WrEGkS7p14fr4aWuI/YKOuqPq1JVpg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz9wZ9TIb/TH0kW6N+tW848q2aajmz/JnYCUicFrFu+4b8Sncvt
	J9B5R1czOxuTcQsxhh2AD2CScdAjnoDkO23VpB0Qe2xVixMcdihARNZTVe0hDu6d7fVwBa3O1iG
	5OtPOsw==
X-Google-Smtp-Source: AGHT+IEMdoRNFqlp7zHt8uHjKfPleNVgWrvxFNisVXQLf3SXuV2EWfHq7AYIrMPraED+yf8roaT/XGVYptg=
X-Received: from plhw5.prod.google.com ([2002:a17:903:2f45:b0:234:a456:85ba])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da8c:b0:236:6e4f:d439
 with SMTP id d9443c01a7336-237d9965716mr203757385ad.23.1750692608274; Mon, 23
 Jun 2025 08:30:08 -0700 (PDT)
Date: Mon, 23 Jun 2025 08:30:07 -0700
In-Reply-To: <jskiyda3defofthrtniugcdbcoftx4o5yvgt47koswq64qf7d7@2pzrr5v5yssy>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20250611224604.313496-2-seanjc@google.com> <20250611224604.313496-20-seanjc@google.com>
 <jskiyda3defofthrtniugcdbcoftx4o5yvgt47koswq64qf7d7@2pzrr5v5yssy>
Message-ID: <aFly_5c0aqTOGEem@google.com>
Subject: Re: [PATCH v3 18/62] KVM: SVM: Disable (x2)AVIC IPI virtualization if
 CPU has erratum #1235
From: Sean Christopherson <seanjc@google.com>
To: Naveen N Rao <naveen@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, Oliver Upton <oliver.upton@linux.dev>, 
	Paolo Bonzini <pbonzini@redhat.com>, Joerg Roedel <joro@8bytes.org>, 
	David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>, 
	linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	Sairaj Kodilkar <sarunkod@amd.com>, Vasant Hegde <vasant.hegde@amd.com>, 
	Maxim Levitsky <mlevitsk@redhat.com>, Joao Martins <joao.m.martins@oracle.com>, 
	Francesco Lavra <francescolavra.fl@gmail.com>, David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="us-ascii"

On Mon, Jun 23, 2025, Naveen N Rao wrote:
> On Wed, Jun 11, 2025 at 03:45:21PM -0700, Sean Christopherson wrote:
> > diff --git a/arch/x86/kvm/svm/avic.c b/arch/x86/kvm/svm/avic.c
> > index 48c737e1200a..bf8b59556373 100644
> > --- a/arch/x86/kvm/svm/avic.c
> > +++ b/arch/x86/kvm/svm/avic.c
> > @@ -1187,6 +1187,14 @@ bool avic_hardware_setup(void)
> >  	if (x2avic_enabled)
> >  		pr_info("x2AVIC enabled\n");
> >  
> > +	/*
> > +	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
> > +	 * due to erratum 1235, which results in missed GA log events and thus
> 							^^^^^^^^^^^^^
> Not sure I understand the reference to GA log events here -- those are 
> only for device interrupts and not IPIs.

Doh, you're absolutely right.  I'll fix to this when applying:

	/*
	 * Disable IPI virtualization for AMD Family 17h CPUs (Zen1 and Zen2)
	 * due to erratum 1235, which results in missed VM-Exits on the sender
	 * and thus missed wake events for blocking vCPUs due to the CPU
	 * failing to see a software update to clear IsRunning.
	 */
