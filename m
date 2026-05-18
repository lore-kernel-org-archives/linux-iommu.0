Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E5045349A
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 13:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779110966; cv=pass; b=IfbbKpP1x1un4NX/qID6DnnWTINvnthxZNbx8cZBb4JPuqpp5vMIVcMVyZwLiWtien37udfTeTY87tm4hiQyDhcS97plrLRGn5kA1xCSS2vNGnJjQ8A/IOabS2KVDAEl0Brhsju5cIpSUtMHS0kMwgRT0Zu4YlSRFWQwCacuBXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779110966; c=relaxed/simple;
	bh=FbLRtTEpwJTAAU8+iVykI25t0IBt4hZbFgxuZDk6AY0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D3/mk9Hez3MpZho8Vzmq8eiYhR6EzxiguIxOcLzySB7f+EZ9tg2FHfW+ZCmtkHohzkABRVZS72EXyfYzOkY8+8kl0zvxzaei8sq4fYdK7eo90jRWyR16kkK2S5bcOyyjbOT4zUOHNv5hbhwS1U4QRfZztsugovXA5H9qwXjy8/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y94dnkX5; arc=pass smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y94dnkX5"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7dca00c1591so557225a34.3
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 06:29:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779110964; cv=none;
        d=google.com; s=arc-20240605;
        b=F5TefNQxTHflKPbgJesqGSV1AI2VpyJoa9rPHZnp0hZSkDG9tE05WcdqxAZFn9Axrf
         Q7rYRuiA4YiNM/ZDm4DQ4EyGChkG1wZfjw96wVkS/ZZefaH+TNN85Fh8bPTejnqvC1jW
         jWLzOGw1VKljErhBtaWQAZmstBdQgr5FVyD7IYIJG+wV4XTeU/Fux+ocmetHdxl8AhAk
         57z/0lZ3sKVJRlXcdB6P6Tb9ojO0V8V3aUXvLV40qWuZWHaxuBdzxufohCjroI2Ad63U
         ychUOquP0cpT72En+Jw0LC8rcKriv9JvJiwJz/hCaH8IN89yRx60p3nAc56EPAq0pRlw
         C0yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FbLRtTEpwJTAAU8+iVykI25t0IBt4hZbFgxuZDk6AY0=;
        fh=2xE6dQgx0XTad5zw1INmlLryRGg5Zjss1RI7ubg3eyc=;
        b=BZjX78yJdu3K9+o89dZaRDQaFUGpUiLEtMFreoSLP1qa/hHIroQXhF3wXI8ldX2AVX
         DZUXkdhTZvMpOjBMLz8b4a6ZWZ8PKIHx6uCtojmAKFx+gwgLMa4fKb8LaTHxUlyVwAWs
         GL5tOVJJbmWHJYF2cZ0e1z53DvjBr+rmxHA2naxhPp7MC/j2MSOonW+aDPxFnLWAZXfC
         lXwqsYKW/TGIzwZbP0raU1hChWzKhUHIjKd+mas9CN2+OMOv/NucqXujUbP06mqChAu3
         F2BN5G1GgPvzCVKVG26J5N3yO0/W1MDPbjVjP/PGJXUUFYpOE0FQ9y1rS9AdBK/HHCfi
         k6VQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779110964; x=1779715764; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FbLRtTEpwJTAAU8+iVykI25t0IBt4hZbFgxuZDk6AY0=;
        b=Y94dnkX5JS2W/JzxS++NmJwfeLsyv+arEynR7Ks4execfCHEQFs1PlzYNb9hz6scYK
         KN0pmHqVKJm6GlrZgZ1rAUB4yX/M88WBAqEJyVjelY/4zIV1pyWS9e6B/pDMOUJ5z0u9
         GM47X7g30JW2r8sPuoXN4sH7lWTE24W/xSZGmPnLLnl7pVr/4inDY9ix6M6Rk/V8eKlf
         +7dqh2lVv0srEGI/R+KD8sAjdK1pJWpOct0J5zCnrJZvlROtqGR/mayt7FAu0Sx92T4L
         9vCaKNn8hlizVBmClFTmEZyjOA09qj9yoNXrcSyAl/Hkpw0kYxHrah1zjBYHv5L96ben
         zpKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779110964; x=1779715764;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FbLRtTEpwJTAAU8+iVykI25t0IBt4hZbFgxuZDk6AY0=;
        b=XloMVs0NsFidnKRDmdVqnX5pwBcdxCNOH1giKk39HwApkuDTwWx2qvEZnD2D+6R8dW
         /jPGgToj36TnBywY9mqlpU0M/StOutIgNFhopZ2iBBEgrIdn+WtyEfX6SoQd5rsBhjss
         jLMx4SQtoMBXVc7Y/drdy/tg8a0WZjw5yg8da+B5FsbQaSZfoFnL7iZmS8sTzIUNxVg9
         7yNr9hZCsLaosZLoyXHBzF4X+1w2pCocegZ9J7Ygoa2k9kFvVKLlvv4ZZRQdAh6Hkcbr
         f1RMIsf64bGmn7Uq5BFdAL5V8BDT/eYQX4l29kalpcKuuuw6p4lP4Ei3/BMW4f+yebfu
         XxcA==
X-Forwarded-Encrypted: i=1; AFNElJ/nLfjvI/Osaq/x7x/biqr1cJyzspt8ucbnRGeNifZ0X75iH7wHtFLM7YuEyoqFFWRbGlNfXA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyYQyVq8GkAb2BhGMKKVzHMs5jIB/dZWP8zZZYMbaSBF9Tz2XqG
	vtsG0lpnra40XxFyVqeAxNetY7nSvbL9HVQCvj01/dhOUVZJ7a/aBljUPubAZvjaXP6znXU+5u8
	5mkI8fhHAN1qkvlJwodljo6KuwcJSJzw=
X-Gm-Gg: Acq92OHTEkd+Xhi1r+3WPKdug2fJA7e9Vg0ZPlzkR8O8CmBCDF7wOWkesnaHZnmqsBL
	9VhA3BPOKt2g0YGwpVbwvCO7AQ82QxwOkSyJ75PdsmADZuwjLc1HkUIOzZ1e3RdmVWlsm74IexL
	g36bKR/XlSWaVm64Wk9v+z1v8poU/qj5AglJuAHBeRv0Tysg0xMOs6qxjjhpOTRKD1F52TWwRsJ
	ooQSwhcIdPndBfIkdSh+T3q4c8Fq3+5z4+JvdTNFcuUYQQm5yNxR6JSjN5icp+ZBjoa6HBmGjOp
	KieUY/e5nIleWkW0EBLx
X-Received: by 2002:a05:6830:6119:b0:7db:a8b7:c565 with SMTP id
 46e09a7af769-7e4f2ba838fmr9120389a34.20.1779110963789; Mon, 18 May 2026
 06:29:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com>
 <20260518121047.GR33515@unreal> <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
 <20260518125330.GT33515@unreal>
In-Reply-To: <20260518125330.GT33515@unreal>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 18 May 2026 18:29:11 +0500
X-Gm-Features: AVHnY4KRzVUJdFevpLtBz65edDDcjjCiWexJQfGrQvrWPPxXK3DCEHiGnS-1YIA
Message-ID: <CABXGCsMA+uZtoup+QtGsPQcyF6TZimxYFOR2sDQksNkLpJq+2g@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
To: Leon Romanovsky <leon@kernel.org>
Cc: m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com, 
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:53=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> Actually, later in that thread, people agreed that this debug message
> correctly pointed out the underlying issue in the code.
> https://lore.kernel.org/all/20241015075418.GA25487@lst.de/

The full thread is more split than that. Christoph in the message
you linked says the warnings are "perfectly valid because the I/O
patterns will create data corruption on non-coherent architectures.
For direct I/O from userspace the kernel can't prevent it".

Dan Williams (original author of the cacheline tracking) earlier in
the same thread:

> I don't see an easy way out of this without instrumenting archs
> that can not support overlapping mappings to opt-in to bounce
> buffering for these cases.
>
> Archs that can support this can skip the opt-in and quiet this
> test, but some of the value is being able to catch boundary
> conditions on more widely available systems.

So Christoph scopes validity to non-coherent arches, and Dan
explicitly recognizes the "coherent arches skip the tracking" path
-- with the trade-off of losing boundary-condition catching on
widely available systems. That's the same trade-off 3d48c9fd78dd
already accepted for the sibling err_printk, which this patch
extends to (2). In both cases the production cost (spurious splats
on real workloads, e.g. NVMe block I/O) outweighs the diagnostic
value on coherent arches where bus snooping prevents the corruption
the warning is about.

> How difficult is it to annotate call sites?

For some callers it's tractable -- virtio via DMA_ATTR_CPU_CACHE_CLEAN,
RDMA via DMA_ATTR_REQUIRE_COHERENT. For others, Christoph himself in
the same thread:

> For direct I/O from userspace the kernel can't prevent it, but
> for raid1 we should be able to do something better. As raid1_
> sync_request is a convoluted and undocumented mess I don't have
> a straight shot answer to what it is doing (wrong) and how to
> fix it.

DIO from userspace is unfixable from the kernel side per that
message; raid1 acknowledged as needing a fix Christoph didn't have.
Two years on, those cases (plus dm-thin and io_uring polled tests
from Ming Lei's report) still don't have an annotation path. This
patch covers what annotation can't reach without preventing future
annotation work.

--=20
Thanks,
Mikhail
