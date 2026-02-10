Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43CC32FA32
	for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 20:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753944; cv=pass; b=ETCyblXs8ONwbwMgRhLuuwyr+VhnrE11CMdA+nDjUs1IzV54xtaNOVyszpqTagASEnUBb5RS4J7CfWiAUKOLUPmUABp2qXEnSctmaF4VeQldbVnu+F71t7xbGQjnyAjrQ0/ZcGk/1R29YQiJ5x6C1Fm9mVyhI6j/c/wu9RW89LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753944; c=relaxed/simple;
	bh=FjgzgAFhvlP8wZ+0kqVUcsibosrCr2odjKDIt5RjDY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UQQnfVvuRZ8TJzTs4iwylbmBb2P8ztTvmE9+XI6pR+2gJj/3OKTG3qBcgShWoCh6fwenTIRY7RVb3o24zU2LNwBc6aNKNMAZTQZoEfbsdf7K97Zoc+cbU+J6JwXg6rDvzv87NV6G3ipGcQaoTlQKZLZEVT/fiW+tqOfuZtlNrlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QqLr1BoK; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QqLr1BoK"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b8871718b00so734252866b.3
        for <iommu@lists.linux.dev>; Tue, 10 Feb 2026 12:05:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770753941; cv=none;
        d=google.com; s=arc-20240605;
        b=Uoi0otnxp2h2BLpZZtKPKK98QGQYLlzCiitp7rJL550fjeCYaa1b3xoPkn3LJBscjP
         gYOgLlydK+ZY+43LDVrmLdRVbOanyOa7dlkhWwyJOhpuad4GzaAfxJ4he7pYGXD6/hGW
         xMpWIchvg+MFfi4okRAena5QD4mdwlv1EC2WZAgQo95DpbOcjLYFAKV5kntzcO+VD2fL
         nYbG76C7H/X9/eCgBgOJsK17IGe+rnoAVf4A9FkuhrPEnnFtZWGP1VXV8RKnA6MkVI4D
         ijzlLN/MSEeLHOEMyaxrFr26bf1m8mAw47noICnXr0N3ooMPPIVrY7yw6bdlVPy5KyOb
         aY/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EUYV2jK4EVNH8IU6ztF+fhRopz1DxZCdX+to/Ge4VzA=;
        fh=t6WZyBwMPexw+Susb+wbTirb0sjBzh2A3cVm3a24CEQ=;
        b=RE18WlxJG901t9N9y1v54AOklD9aHOkOYuAFruqMbrba6ST4YJv1nME7C8CFz2h7ye
         IRCYvc7cQRlf+4KuZIMXXV3M82HQDeEOLqaNeIHLoGhjpoRA0R2sH0ffcnQeTDIKR/cE
         Wwchqu4oKQiGmCtcJm8J08wJzWeYpIrPLntY7Fm7vpKbioRhEVXME1viNYeUWGfoyYFp
         Lk9fayVqmR1ETR9qYFnpepjBxMq3mV3Q/0i7QKtFIoXmY/d2upwIAfne6FemeCI4aFi/
         bu9bIRay2FB+y4fe+Kyt6DGI507Pz+dCHHj6z+AzpG4K/SKHy/FIGck6Iwe5el5lEkC0
         2SEg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770753941; x=1771358741; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUYV2jK4EVNH8IU6ztF+fhRopz1DxZCdX+to/Ge4VzA=;
        b=QqLr1BoKOhN2KxyeFfcTqEMIKhUfWgVlEEArXxpaEeHU0hmXYZD6nMfDIKrGuRM3Vx
         rbKiufW82yBb/4pKq7rfiu/pbPy4tgVvDcykTyr6RFCkAkI2ucScu1uQB0wR1GCBXIOV
         VeLlSqZwv6tGGPrrhNMSHXNYP+PjIerfyTWr282/gZpwGN7uYKsittPrfwWs+gtWQm0l
         wTw+hIQLpLBouQUr+79ykf81Pp8mNc2FH0J/CTKeq+Ul+aX1l0Yzfcr4kUQLAVqqY5BQ
         UBwYmUSmogI05+CqFlwsahxKq+zRv2X/Hq2yf5OPd1oMfgf9kWe+iJvZFdOWD/yot9Gj
         4OUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753941; x=1771358741;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EUYV2jK4EVNH8IU6ztF+fhRopz1DxZCdX+to/Ge4VzA=;
        b=AKyw2JmDsPSBSmvU8sd+owlY4xWhAn6VxKaG9VIbUqkxif3qZ34N36GZRGACU15Z1q
         WNzSsylS1jKrGhstmHtN1P6irRKImTGAwpFVTdsfLwU8pPNJataQrj/ROqn6y38IzK/h
         hodm5Ojp6O5pgczt1ERsNnd9Ucl6H7CcMkaa3BxGplDxiYhGqJqFLlpFTW1BtzXIynxe
         ZWPo8IV1krIVKX/PJWkBTEEigRaqonQn5bYZhYLcDabqadYRoPsZwQWNU9T8i6igUnL5
         EeKhdXl9/C5A5Kdj3Trurmt/D6SyHrMpss3C4udDqC4lidJ+Mfawt04rbBzbUpCf2GCU
         7/kA==
X-Forwarded-Encrypted: i=1; AJvYcCWiskIGGA+VvkhlXWbhJSA6jLCE96rkUamxqy+HnvNx0yoV9zNT2ISaZu4gdQglGCnlTU13cg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmSjvGYJwtJZjf1tFuGzHPPL+BIzX29ba7q2pmSl2QKffID+FR
	rC/E7H7/yQmJMiBnm/GcPAh2HNPoKXBQwMfW8QtdN3CY0BTad8NMNORggaFMv5SEyB7UG5BbG48
	NFsqGKDVab2K2pX0ey+oMCuRdaAic9Ikv3zfhf9I=
X-Gm-Gg: AZuq6aJKYP3Wfj0WMGNZJJ1t4mfVgXhAyPhFa2/T8FAeHx6+vy4YgTVitt9/gBof7uD
	hjkPdJch8L/bI7Njr4xw9pKCAMwqCpnZ3Byz1eXRwwRucLN3/SvoIhz47I5dDR/e/hYlI6hnbae
	uzw7oa2/DDnGwNqraHPCnar/D725LsbEh/JPKVEJxKYwjwN00vNScQKAkgfWtNK5Ov1yPSuDc4l
	VHeOaaDAkdS9YlrMcPtB99c2ylrHLG3oIIxMwL7yeaLt/OmwS8KEYWw7XyesNPI5kxz2f3rVFpZ
	LkCIl1Nq/4gJKzqXMdXdjLLhyFD21Shzuztw
X-Received: by 2002:a17:907:720d:b0:b88:48ba:cd7 with SMTP id
 a640c23a62f3a-b8f6a8e0786mr22320766b.3.1770753940692; Tue, 10 Feb 2026
 12:05:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260209153809.250835-1-jiri@resnulli.us> <20260209153809.250835-5-jiri@resnulli.us>
 <CANDhNCoHEZsNRmU+3z5AbeAy05H7PTtUdTq1apNd5k0f9hWW8A@mail.gmail.com>
 <hwdezwktndbm6hoko3rz5lffgfljodegcygzf6rbdf2ferokj6@ftk2uk3rqfdq> <20260210124819.GC12887@unreal>
In-Reply-To: <20260210124819.GC12887@unreal>
From: John Stultz <jstultz@google.com>
Date: Tue, 10 Feb 2026 12:05:28 -0800
X-Gm-Features: AZwV_Qgy-DNinnCzC9ZTU6U_Twqy09ClMg2rE0gJxLuPqw6IHh5sTKTnvXMZwaA
Message-ID: <CANDhNCoaYoe5Ckin9CnZT2LdQJ2K7amBSUS9GBDzbx_1=U9txw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dma-buf: heaps: allow heap to specify valid heap flags
To: Leon Romanovsky <leon@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev, 
	linux-media@vger.kernel.org, sumit.semwal@linaro.org, 
	benjamin.gaignard@collabora.com, Brian.Starkey@arm.com, tjmercier@google.com, 
	christian.koenig@amd.com, m.szyprowski@samsung.com, robin.murphy@arm.com, 
	jgg@ziepe.ca, sean.anderson@linux.dev, ptesarik@suse.com, 
	catalin.marinas@arm.com, aneesh.kumar@kernel.org, suzuki.poulose@arm.com, 
	steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com, 
	ashish.kalra@amd.com, suravee.suthikulpanit@amd.com, 
	linux-coco@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 10, 2026 at 4:48=E2=80=AFAM Leon Romanovsky <leon@kernel.org> w=
rote:
> On Tue, Feb 10, 2026 at 10:05:14AM +0100, Jiri Pirko wrote:
> > Mon, Feb 09, 2026 at 09:08:03PM +0100, jstultz@google.com wrote:
> > >On Mon, Feb 9, 2026 at 7:38=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> w=
rote:
> > >>
> > >> From: Jiri Pirko <jiri@nvidia.com>
> > >>
> > >> Currently the flags, which are unused, are validated for all heaps.
> > >> Since the follow-up patch introduces a flag valid for only one of th=
e
> > >> heaps, allow to specify the valid flags per-heap.
> > >
> > >I'm not really in this space anymore, so take my feedback with a grain=
 of salt.
> > >
> > >While the heap allocate flags argument is unused, it was intended to
> > >be used for generic allocation flags that would apply to all or at
> > >least a wide majority of heaps.
> > >
> > >It was definitely not added to allow for per-heap or heap specific
> > >flags (as this patch tries to utilize it). That was the mess we had
> > >with ION driver that we were trying to avoid.
> > >
> > >The intent of dma-buf heaps is to try to abstract all the different
> > >device memory constraints so there only needs to be a [usage] ->
> > >[heap] mapping, and otherwise userland can be generalized so that it
> > >doesn't need to be re-written to work with different devices/memory
> > >types.  Adding heap-specific allocation flags prevents that
> > >generalization.
> > >
> > >So instead of adding heap specific flags, the general advice has been
> > >to add a separate heap name for the flag property.
> >
> > Right, my original idea was to add a separate heap. Then I spotted the
> > flags and seemed like a great fit. Was not aware or the history or
> > original intention. Would be probably good to document it for
> > future generations.
> >
> > So instead of flag, I will add heap named something
> > like "system_cc_decrypted" to implement this.
>
> It is problematic to expose a user=E2=80=91visible API that depends on a =
name.
> Such a design limits our ability to extend the functionality in the
> future, should new use cases arise.

Yes, how userland chooses a heap name is an open problem.

 The difficulty is that userland is the only thing that knows what
devices the buffer will be shared (and this knowledge may be
incomplete if userland passes a buffer between processes) with, so it
has to pick.  But the kernel doesn't give it a way to solve the
constraints of what memory types work with what devices. There have
been some proposals for device sysfs directories to have links to heap
types they support, but that also requires every driver to understand
every heap type. And then you get to the fact that performance is what
folks really want, not compatibility and that may require some system
specific knowledge to decide.

The working solution right now is to have the system provide a  [use]
-> [heap] mapping for a specific system.

I think of this as similar to the vfs and /etc/fstab. So /home/ might
be /dev/sdb1 on one device or dev/sda1 on another.  You need some
system specific configuration.

In Android, this mapping is done by Gralloc, so buffers are requested
for a use and then Gralloc decides which heap to allocated from.

Unfortunately there doesn't seem to be a similar standard convention
elsewhere.  And I'll admit even then the enumeration of uses/pipelines
in some general form is also difficult problem (and is somewhat more
bounded for Android).

thanks
-john
