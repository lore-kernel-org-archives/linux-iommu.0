Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C43E51E9
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 09:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779095218; cv=none; b=DM7rGEo7FUmslj1uMtNDa0nNttJs0zj5HTu3gmJp/i2v/d4v4RXt9LA1VtXPUVk47gdmk7HgMNy82z3K+BhynfTLjZXxflGhsmwVUhj+P4yIepWk1+4fX1h2w38+3anckOkZGeHDHtawlYxuMUTCQcX3UjFwdqpqTfhFUWYS1Tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779095218; c=relaxed/simple;
	bh=2qZ5Z7v49mZdp9tTq4z3AExRs8n1ya/74CMZmv6hrg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FrWD6ABCajwsIdpRTHuoF3xAS3eILAWpzryG3q3QSK8L8KAuPLxbSXC7hjJzQhzbWdCo6Ml5ETsUEdEIJGn9xNUJfbhxUHfo1Dd5vRys3G1+tCq/QzfcE9dv0A4Bb6a3StdNjHGg+gSfTEyaYW3ztC/pqzieyihsvkDR80SxMW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DD/9pkOU; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joonwonkang.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DD/9pkOU"
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2b9a3c3c4eeso23086475ad.3
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 02:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779095216; x=1779700016; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UOPk9lUKmu3dyT3km0TD9pgYxeOvFnYVbbb0LRmiqBQ=;
        b=DD/9pkOU1J9Ss1g4pBcOykGTFyUc1gWmOKA1Vrghu4nv4SMqgCfC2uswA8XiN195sS
         GQLE8pt8xfZ/A2l5IGNLHZ2JTfrL7QO+7SKTuEVQSzZnAfBiodpxfixAb9DdsogX9s2k
         +c0vSzUFpQ2JgX27yljSVz29DP7C9lBJ2Yc5d7GmUVARR1V4mGQmqqTPh1h75v/Ha32E
         okRf4ciavITQcTOGFel6tqDoCgKnffI35YSZsziYGC+eOmB0HN8g+kHU9004KGodA65a
         FCrV6Snhpdn9ijq9LN/Mv6fXNxLI0UY13KVD7IQ0Ra0T627YCsQTU/E1lJoM2ZNHeppB
         o1RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779095216; x=1779700016;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UOPk9lUKmu3dyT3km0TD9pgYxeOvFnYVbbb0LRmiqBQ=;
        b=MzLhA0EAuRcbedjOm6JeYvKCl6p0Z+aPKVpayFPTlSOqPZKkmhHhiGjkMIOReFw3he
         hdYwaqttjNdqhu7uoq4gICQ2/Nv31FTTGXkWc+RC6WBr6ukXYv71AeGJfyQpXsCroKpX
         ElIg5lC01dHctw8y6HC5xvgKFVXdwmIxKjt1mNZGHXbGGqu/jBmZls+SOOEiqv4CU01R
         sJbJ0RgUqOeuOqJp+3SRtq3DyObj6uSoPqoUQlsfXGx+pgmP2QcE6qvlFfMTJDq3yK6k
         F8ICqly6xXN4xkfWw+WPKER8LQWfArd1Ay1OaOcPriHiUNtWIHj9zHm6qsEksl/ZHkx9
         ddDQ==
X-Forwarded-Encrypted: i=1; AFNElJ/3AltkYKwB8PIeljq2HhcY2f5d9LDER9oeTVpC4A1n7/V2+ZWZN4N5mPgmhZAa32P8ecP9cA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZ/K4NeRiVsJJtFHOM6XU2qz6HGGSx2Y5sSem84fP5GNgp/ysQ
	a1OoXZKj2IczPVUzTvdDmixqFAtCasPfUbjmsuo+9+QhHvw+nZLHhah13Es18HPvJyIt4lGpXRF
	Ln3gQCyeDYVGFC5FTcITISuyUxA==
X-Received: from plbv16.prod.google.com ([2002:a17:903:44d0:b0:2b2:488e:b71])
 (user=joonwonkang job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:384c:b0:2bc:6d46:ae9d with SMTP id d9443c01a7336-2bd7e8ca92cmr152641245ad.17.1779095215808;
 Mon, 18 May 2026 02:06:55 -0700 (PDT)
Date: Mon, 18 May 2026 09:06:54 +0000
In-Reply-To: <20260515231808.GQ7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20260515231808.GQ7702@ziepe.ca>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260518090654.730478-1-joonwonkang@google.com>
Subject: Re: [PATCH] iommu: Allow device driver to use its own PASID space for SVA
From: Joonwon Kang <joonwonkang@google.com>
To: jgg@ziepe.ca, kirill.shutemov@linux.intel.com
Cc: Alexander.Grest@microsoft.com, alexander.shishkin@linux.intel.com, 
	amhetre@nvidia.com, baolu.lu@linux.intel.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, easwar.hariharan@linux.microsoft.com, 
	hpa@zytor.com, iommu@lists.linux.dev, jacob.jun.pan@linux.intel.com, 
	joonwonkang@google.com, joro@8bytes.org, jpb@kernel.org, kas@kernel.org, 
	kees@kernel.org, kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, nicolinc@nvidia.com, 
	peterz@infradead.org, praan@google.com, robin.murphy@arm.com, 
	ryasuoka@redhat.com, smostafa@google.com, sohil.mehta@intel.com, 
	tglx@kernel.org, will@kernel.org, x86@kernel.org, xin@zytor.com
Content-Type: text/plain; charset="UTF-8"

> On Fri, May 15, 2026 at 09:46:05AM +0000, Joonwon Kang wrote:
> > diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
> > index 0ca3912ecb7f..61e2e52105e5 100644
> > --- a/arch/x86/kernel/traps.c
> > +++ b/arch/x86/kernel/traps.c
> > @@ -864,6 +864,8 @@ static bool try_fixup_enqcmd_gp(void)
> >  		return false;
> >  
> >  	pasid = mm_get_enqcmd_pasid(current->mm);
> > +	if (pasid == IOMMU_PASID_INVALID)
> > +		return false;
> 
> If you do this then probably you should get rid of mm_valid_pasid(),
> mm_get_enqcmd_pasid() already has the NULL check so the two functions
> are kind of pointless.
> 
> You also missed the other place calling mm_valid_pasid() that should
> really be sensitive to this as well:
> 
> static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
> {
> [..]
>         if (mm_valid_pasid(mm) &&
>             !test_bit(MM_CONTEXT_FORCE_TAGGED_SVA, &mm->context.flags))
>                 return -EINVAL;
> 
> Make that removal a prep patch
> 

Thanks for pointing this out. I think mm_valid_pasid() is to check if SVA
is currently in action while mm_get_enqcmd_pasid() is to get the PASID for
"ENQCMD instruction execution". What prctl_enable_tagged_addr()
semantically requires here seems to be only checking if SVA is activated
or not regardless of whether EL0 can execute ENQCMD instruction; the
function wants to return error if SVA has been activated when LAM is to be
activated as they are mutually exclusive [1]. So, I think we should leave
it as-is. I am adding the author Kiryl as a reviewer for confirmation.

Since it is now possible with this patch to activate SVA without involving
EL0(for ENQCMD-like instructions), callers should be able to distinguish
between if SVA is activated and if EL0 can execute ENQCMD-like
instructions in addition to the SVA activation. mm_valid_pasid() is for
the former and mm_get_enqcmd_pasid() is for the latter. So, I think there
will be loss if we make the latter API serve for the former.

Or, I guess we could rename mm_valid_pasid() to be more specific like
mm_sva_activated() or mm_sva_in_use(). What do you think?

> I didn't try to check the rest closely but the approach looked sane to
> me

Thanks. Sashiko reported valid points [2] and I will handle them in the
meantime.

[1] https://lore.kernel.org/all/20230312112612.31869-12-kirill.shutemov@linux.intel.com/
[2] https://sashiko.dev/#/patchset/20260515094605.3195841-1-joonwonkang%40google.com

Thanks,
Joonwon Kang
