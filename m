Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8321B3FBB4F
	for <iommu@lists.linux.dev>; Mon, 18 May 2026 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779107010; cv=pass; b=p792fY7dz19J4xydrbBtrGQb9HXe+B+Sb8m54nwVNP+pf2CjYQN+IGtDSLXVCXSn2KrYU9rfcX8Xxk/WMrh5LUVgRQVSiJIyck2c+4JpXI1LCqkR9JFUcWl0L34/wkIaCLBmKowWHuyUbwkFOdR1PYlyp0WRRx4YfucasBEReOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779107010; c=relaxed/simple;
	bh=2KY+l4KABgbuZep6wNlHpDlJAxhChbrnfe5+nzYJR08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CCehhrRSCmjUaov3qb2XrHKGxTp3nBnBNlHmKfNvi4ComiJCcR6IU/V/fFxHGGRv2PWndmpna1uKkCl2i9fh837dGA8dsZnWBxVn4f/hyrX3IE8HIdKCuiBFOwfqpSWdsAtL6pUOGY8Ojyt72ahqn0i5aoc7Y31GTe2ersg0XGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az9NuYTe; arc=pass smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az9NuYTe"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7de7c57b52cso2142948a34.3
        for <iommu@lists.linux.dev>; Mon, 18 May 2026 05:23:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779107007; cv=none;
        d=google.com; s=arc-20240605;
        b=YC4S/DfgoVjzvFpCnxf8th6AuPal7RunvPCZ80VfUbNSgl94zMmApuCRtUu7vXLoQ8
         WVWaL0vl4I/WJbipGDJVMjiVYA86dWyqBG2MiI1I10971HtnN7hDCj4g8JDY56gbd24u
         VLjI94v14RHNQnfNSqrrXUN1t5NKRl99ttzdI1bmomtfzQEMaNq/+6jr4nHwhnbU91Jx
         ykavYfolCoo0M01H0bawMX6dE2Tt0lqKfkA1zgSw3hnpUN41H/OxW0+YRWAZ96K7s5Xp
         T7xDLjK0urNxgYO5TGqJvaNOWjHYhXtxvJUxeKarVecy3U4AkdBCot8egFJiJnKxNats
         9JrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JnuXCK8uoxEZUhNS5OWJfu139xXDy1s47+cQszMom/4=;
        fh=u8L7HXgPnuxM4vspBpxheIoB6GGmScjyeGNcR+jR2Ko=;
        b=V8FLwlc4dxwfVnOyrW2u98+1NUMAT4Fxe6+QZjTbacuJv+5xax0AYKcP2BZun/iRFP
         iBv939jPIM6HAI/tcg3JLI/ccximndgsR2RoBX3CRwN9R3l6A2SXDR3LOtwUx0WQhVZC
         EGLu3Ik5JrnkS1NuGCffBu0rQBrSARAgfiyb9zPlv40u2mr48esE9oIAFnYL11x3JuJw
         WOiF86SwEFEgJLiiqj4438ffPRDCJniZ1h7NoAAVRJsyDLDa9w9uSdUTMq7X8GTvCSnX
         SQGrge0rnOyP7jN9EUKGH028b+ynN+gLYfKt4eoG7WpEiDbPUHLUfWCkcwCgqAou9k8r
         ur1g==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779107007; x=1779711807; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JnuXCK8uoxEZUhNS5OWJfu139xXDy1s47+cQszMom/4=;
        b=az9NuYTeAQ/CFOOkdSfpUJCjX3qu1eTIGqJErg6QRX1lB4PczCsl4+7rQRHK4N5PZi
         HfxtLs1NeUqdQGcYFgIqDh20CI0mR5vcWL9aFCK6mvNksqYEuGI9//IQNuLGd1WBbXwY
         I7JHDjyOcYWhzM9Pnfpn1VdErAaLyoO0ndhRQe4zerYO2H0n/MMsTkh727hJ33hQctSp
         ApwcOJx9b6I4HZBslneTsF5DLxUVQzImxcwBKX63qYPiWCC+rjR6400BU5QIQczXKc4P
         LiSBboX7JYuMSDQetfvD0j/mQUqpNjHEix5VSe076EH34rfeaC5Q5UrzGBVuxbJM/M9m
         UZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779107007; x=1779711807;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JnuXCK8uoxEZUhNS5OWJfu139xXDy1s47+cQszMom/4=;
        b=YdVnPs1rsga/8HSCrzy1h5Ugh7mY9Ip5jN+/bPc92YDodiLgCKObxAwRVlgjoeOcC/
         braIIvt9aJhM8lYabPusCR2MXuCQHYkW/m/Ovvu4J05J4ILcYAvxQBh7xHcETXXn4VPk
         0G/2SnAvjjU6duZpEm8elRmwZnfOvyvsBkdVhdbMHaxJGwxx1zM1e9b3Ufxvx8z0ARkU
         oU9AfpjWDPhaR2NNQ4uQ5KWvI21Iv0CqCygUa22QATQ/Lz1DO00Iudu+uyMsNDmW7NPI
         0bYF/DF+k51/a90BRzdy7yxgkxuqzlJLsKN+P9/vkRpDNbXEu6psniStZUwnwzwz7bro
         V9YA==
X-Forwarded-Encrypted: i=1; AFNElJ/Vrm/0d8frKR1keC6OqaeDD+89v6B2KN1/7EAvYIy/Wy6PmUSawSLsig5EEl/HmynKi5LIHQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YzxLtZ30J83p3M06EDwhGV43zv74RTO8QyxCMenvpajEfoPfuCz
	mfgXXh2D9Bfu2UbJy+voHVTq6Q7ykZdlsMslxn9NcgrBcmc3k/30jrwQBa83yaXFcsajxBPWD6g
	6T0wPqe5jAPfKv1uSTVd9don+XDJ5d2Q=
X-Gm-Gg: Acq92OFSF4U1teR79gDONqekUxdfBnONcerfd861Gg/GnVffVKS6B6G/bJ0222G2gmp
	wDiHh7K72MhaQqdL612frJCBF5m8w6UYW3oa5k903sybDDwI3w8d9PFn4aNxJTbxQ3MTLWE4KhX
	kC1HSxJ4WZ2JPJkdtN89A++h+c7pnPFGdBWD94kG0Ou3pFi2tSRenv8uZjs7cVpt5+R3nLRC6qk
	oRPpSaLfbqbzbHNuCREaDtk2DQURp1GnpnZM8hak6wa1oH6w2QVsF6nHTPzCvSu7jO5v62eOn9u
	N+aifeO7NA==
X-Received: by 2002:a05:6830:628a:b0:7e3:d199:3164 with SMTP id
 46e09a7af769-7e4f2aa4df0mr10347634a34.11.1779107007428; Mon, 18 May 2026
 05:23:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260518113251.64844-1-mikhail.v.gavrilov@gmail.com> <20260518121047.GR33515@unreal>
In-Reply-To: <20260518121047.GR33515@unreal>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 18 May 2026 17:23:15 +0500
X-Gm-Features: AVHnY4IuUumzafdQOomWR5BgdVS9CC-sLKal-Vm3yKtkFJ36eL7xAWcRgDOpsQw
Message-ID: <CABXGCsMxZ7VieyzWEmpGdxohdbTJ_qf_1ZOw0eF5g9i0YeOc3w@mail.gmail.com>
Subject: Re: [PATCH] dma-debug: skip cacheline overlap tracking on
 cache-coherent architectures
To: Leon Romanovsky <leon@kernel.org>
Cc: m.szyprowski@samsung.com, hch@lst.de, robin.murphy@arm.com, 
	djbw@kernel.org, akpm@linux-foundation.org, catalin.marinas@arm.com, 
	harry@kernel.org, ming.lei@redhat.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 18, 2026 at 5:10=E2=80=AFPM Leon Romanovsky <leon@kernel.org> w=
rote:
>
> I would say this reproducer is incorrect. From what I recall, the only tw=
o
> legitimate use cases for cacheline overlap are virtio and RDMA.

The wild trace in the commit message is NVMe block I/O -- neither virtio
nor RDMA:

  add_dma_entry -> debug_dma_map_phys -> dma_map_phys ->
  blk_dma_map_iter_start -> nvme_map_data

The block layer submits many concurrent in-flight requests; small
kmalloc'd buffers naturally land in the same cacheline under high IOPS,
which is incidental rather than intentional overlap.  Ming Lei's report
linked in the commit message [1] enumerates additional non-virtio /
non-RDMA cases hitting the same WARN: liburing iopoll tests, raid1,
dm-thin and other storage utilities.

> The first intentionally relies on it for small allocations, and the secon=
d exports the
> cachelines to the user space and cannot operate on non=E2=80=91coherent a=
rchitectures.

The reproducer isn't claiming to be either of those.  It deterministically
reaches the same state-based gate the wild NVMe trace hits
(!is_cache_clean && overlap > 7, with direction !=3D DMA_TO_DEVICE, after
the v2 coherent-arch / SWIOTLB-bounce suppressions are evaluated).  Since
that gate has no subsystem-specific term, any caller -- synthetic or real
-- reaching it with those state values triggers the same WARN.

If the broader concern is that the block layer should opt into your
coherency-attribute work rather than relying on debug-side suppression,
that's a reasonable longer-term direction.  But it's additive: even with
opt-in adoption, the WARN remains a false positive on coherent arches
for callers that don't annotate -- which is exactly what v2 (3d48c9fd78dd)
already established for the sibling "cacheline tracking EEXIST" err_printk.

[1] https://lore.kernel.org/all/ZwxzdWmYcBK27mUs@fedora/

--=20
Thanks,
Mikhail
