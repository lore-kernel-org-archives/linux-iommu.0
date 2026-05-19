Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB3FE3CDBB4
	for <iommu@lists.linux.dev>; Tue, 19 May 2026 08:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779178311; cv=none; b=ehSoFKNX8MKxXM8Z2cI0gk/Fbkwz8dEwm7Yw8QXBwvACEBDkgWrPNBKn705U1m6EF8n1+A+RfxiOdF4VlCGBLSbI97C5jY4T5QFlXzChUOYpZ3t8pnjOBvucr7dZTNM4z+Qo+qpamJMuXkDmTgObLBARlE9HVxoUi8rIvXmI0Zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779178311; c=relaxed/simple;
	bh=yreApj1csXszXO5CKw+Pkc1FnIuaiI6WFdf2uHW2Ogs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IEJSflGcO6TZ0bfeIDpXdkvaCs8IaVishbjZIdrJ/CN4tYv/esH97qe+19kAKfwGLXB3BU2ALsbItFPwsMS4uZ4PE5dtNlryb+/rNuF3vPshxiXgckg392CYMtt9oHOn29ahrMI0kSSzAMwygSD9IaMuD6h1Rr0A+9elESIaAsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IYYxEEOe; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IYYxEEOe"
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-2bc763c7256so77632015ad.3
        for <iommu@lists.linux.dev>; Tue, 19 May 2026 01:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779178310; x=1779783110; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=7ut72Gkptn/NBySJV/auF15VVBqcdKlrwYtyzCOsNz0=;
        b=IYYxEEOefyFENAH7OSNTLBISKcowyAUWFSyFVKFyAC1DWXHb3bsmy/uUhvNEEuD0BC
         z2C87ce+bUazWEVYrLOlONpx1AwlObaz5RGzqQxTZcaWNG3cu1xC6Wu4v7TFQXlEf+LD
         Wa3RvwVMB2Wvo+r7KQi3IXfsQyLgJH7ntjplrWKQ6itHGcF3TjuHf+zPJMe2z1gsPOyn
         zh3ejVhiY1XfX8l/gF1VCSvF3Pe1ye6fj8wwJtgh1acMyAHaSUSC70U8pVy+Fkmm7S2M
         /oGa3tEHx9OaxKLHRjyWbsCfh3bQCc8VEXrVuxxdx2X7DJp3fiBQBkb9pX2+nG8zvTXb
         UGdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779178310; x=1779783110;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7ut72Gkptn/NBySJV/auF15VVBqcdKlrwYtyzCOsNz0=;
        b=tYwXumgpFt7SMJWhXrCgzW7Z/qarV53pKY4KyEm1l6MofbGQtjtPmLVtO1szk6dSh+
         Uy7aU+m2EP9Qpaz1/nGdJRj3K9lh99MAH7LRKDjr+4adhqUz762dzMzkp+3/e9eOrL5A
         GQD8+vOeySSM4+lR1I/ys/k5+1JX+fHr/bbMxkwSeezi2sNMFfW1k9WXoI5SG6MmAAqc
         goxyepfLQD2IHXg7DEaktLypsE8/iZJM3keC7jwbjFIYD72VBbNRxA47HI2TdjdcFJaD
         dSKnFueDfh5NIPH9sXf0s6S34Fjo9qa6QDujOkU6FagZtn3t0WFVztVMaZ8XeWv3OsBn
         3tVA==
X-Forwarded-Encrypted: i=1; AFNElJ9966XXQDzSVPxbJmn3nAzG+MME8yR4ByM04TJ4RgTEF2HnyK3aeu8NPhR89BWKXIRHBcjucw==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywirp8XSASnPxxT8SZFatV5ZVLO8k9ki8HROAyGoMAJvJQVXZHE
	DSa8rl9klpOy9HdlVKqSu7vj2rUBHF34nEKEcLzR3FfcW2ao8JjCraXVNRMtXYZIZVplEBZ6rra
	6CJxEjJO01LsOjl2IJ301HlgwnA==
X-Received: from plvv3.prod.google.com ([2002:a17:902:d083:b0:2be:3026:1d0f])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:f08d:b0:2bd:2051:13ed with SMTP id d9443c01a7336-2bd7e87ef1amr129360345ad.23.1779178309741;
 Tue, 19 May 2026 01:11:49 -0700 (PDT)
Date: Tue, 19 May 2026 08:11:47 +0000
In-Reply-To: <20260518175249.GS7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260518175249.GS7702@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260519081148.1301245-1-joonwonkang@google.com>
Subject: Re: [PATCH] iommu: Allow device driver to use its own PASID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, kas@kernel.org, 
	kees@kernel.org, kevin.tian@intel.com, kirill.shutemov@linux.intel.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, nicolinc@nvidia.com, peterz@infradead.org, praan@google.com, 
	robin.murphy@arm.com, ryasuoka@redhat.com, smostafa@google.com, 
	sohil.mehta@intel.com, tglx@kernel.org, will@kernel.org, x86@kernel.org, 
	xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

> On Mon, May 18, 2026 at 09:06:54AM +0000, Joonwon Kang wrote:
> > > On Fri, May 15, 2026 at 09:46:05AM +0000, Joonwon Kang wrote:
> > > > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > > > index 0ca3912ecb7f..61e2e52105e5 100644
> > > > --- a/arch/x86/kernel/traps.c
> > > > +++ b/arch/x86/kernel/traps.c
> > > > @@ -864,6 +864,8 @@ static bool try_fixup_enqcmd_gp(void)
> > > >  		return false;
> > > >  
> > > >  	pasid = mm_get_enqcmd_pasid(current->mm);
> > > > +	if (pasid == IOMMU_PASID_INVALID)
> > > > +		return false;
> > > 
> > > If you do this then probably you should get rid of mm_valid_pasid(),
> > > mm_get_enqcmd_pasid() already has the NULL check so the two functions
> > > are kind of pointless.
> > > 
> > > You also missed the other place calling mm_valid_pasid() that should
> > > really be sensitive to this as well:
> > > 
> > > static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> > > {
> > > [..]
> > >         if (mm_valid_pasid(mm) &&
> > >             !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
> > >                 return -EINVAL;
> > > 
> > > Make that removal a prep patch
> > > 
> > 
> > Thanks for pointing this out. I think mm_valid_pasid() is to check if SVA
> > is currently in action while mm_get_enqcmd_pasid() is to get the PASID for
> > "ENQCMD instruction execution".
> 
> > Since it is now possible with this patch to activate SVA without involving
> > EL0(for ENQCMD-like instructions),
> 
> I see, this thing about which is about LAM should remain, yes
> 
> But all the "EL0" machinery about trapping and enabling ENQCMD should
> be moved over to mm_get_enqcmd_pasid() and never call mm_valid_pasid()

Yes, it makes sense. Let me fix that in the next version.

Thanks,
Joonwon Kang
