Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794470678;
	b=PoMu1fLQjn5/GWAf/FwxxPqH2eI4PNLhECJhY1VgMvac/bhIk3u3XOggyWlQ6WwE3Apm
	 Ea8vmFE83jbsBwCFsoGe+/FHdxiarjlfiCdPOMVyGt65chsOzeBml2mxw130LTMF8C8R4
	 t1Rc8T91MnwasOq3gY4wMLuNTMAuntwikMjpiN9UCROM+OjZxR80a4t9uw59jxUVKcVnM
	 /V5aOr8hhgoWueGbZNTjrLtf4fOi1yOoBzvfH3pHNYEGuJZOImEYZg9JPYPc2Ckpoli6v
	 ohLU8J0ef0crSxD4AthSXxpdh09DvkI09YKY07KI+wlNr9hLSxQdhd+kDDL7aDuCihQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470678;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=bZnjmRjaw3mt+xCJw0WA+CLEo0XUahYdWgL+JaOD3TI=;
	b=AZuMT/e2JiwGi4TDAWjU/u3dCG5u3xXB9I6X0DA3E9R6nOPhjv6EeIKVE23/9UcXQq06
	 1iY4VBRiZGs01gJqHkqqKB+Uq1W/asltRtqVNxiBjUajeRFaSEfFoAIwpxiC6AQdrLY5x
	 e/AUtmW4NVcNq5XLAsy6bAEZdchY3AY6NaOtLTMnQnHDR/4gM/jXb8OuXE9ee50SNwoiK
	 6WKCLdPKN6sEAcsxE/K9RO9jfCblCKFH/gKiOZgQHUA6fif52FNQB2ZEpRRDETguPhRLP
	 eykDq9vBtAhMP5/K+a4WSrs13jE59t9HESzMbY9D4l7/G28BDrQCc2BDxy9S/3lKFyg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnIUGND3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.48
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A12606A32A
	for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 08:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44A12606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WnIUGND3
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5c154a41f8aso47448e87.2
        for <iommu@lists.linux.dev>; Thu, 12 Nov 2026 00:04:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794470676; cv=none;
        d=google.com; s=arc-20260327;
        b=o6b2wdL0oBmCEJQfhg6SeZJ6uQWgJyFiR/Fe0O5sH6Vu21eCp9KSPPFtehQgQ0/QDp
         sziAz+hUJDZa1jCfVjKdXwX0/Ib3C4eW9DFiu2HlvR/0zHIfeaWZfyOIap5hJz9dIZ64
         XZpXPAFtNeRp3U3KvZ0Epq+/DpJrbeoSUGjFOLU/TZkHJjrxOncg1wUZNIddvoec2mwa
         F6f074aln4AQutQK+WfsWVa0BkQB27Hn350Oe9mHc/PIIPpzgP54lvoZLl2xaMGwT661
         YBlRjttmJycSz2lXD7+gPKWb47X0zW9DjrUJXRU4FpjDLVgqQMvHFxyC4PN2St0Nu5+P
         c5BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=bZnjmRjaw3mt+xCJw0WA+CLEo0XUahYdWgL+JaOD3TI=;
        fh=9zcLQLyUO55diP1zR0ZF1WjS9iQgo9JUrKk0w9mYR1g=;
        b=oNWbMhE1CA5hyXni9GsA7FXILzaKhcR4BwHhBkymsm2zP9AkXj/CJo/LqFewkIW+hM
         MQb+QnZpnHPGFZLJ1yfgo1MYvSO9ORj+rjSklN+Ueznf/1VxDzl+uz6sGYT+5E7bqM1x
         8pXFMAAdNyqOud17gb26mwkEq2u5XclPeWRxaR84c6K7QEv5H41NxtDdj3VlOQKjRzEM
         Du+8+xkNY9qMwLApQYi33h0AGK5IuImnu2zdT2GfClYZMow4/gCVOBvYusO3oNQDD7k8
         ArVdAnUYidGbd/hvlQ3ZXFlCNZweV9U4Sc5VPi3HyyVumxXtuOh53GyNecEusrFNAsBV
         Ylvw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794470676; x=1795075476; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bZnjmRjaw3mt+xCJw0WA+CLEo0XUahYdWgL+JaOD3TI=;
        b=WnIUGND325gHugaoNEz0YRBOJERoX0LfSvPBe4tYY28AfYl0QEHcjluhuZHG0Ppe0Y
         etexbNEvTxDxji7Wxq6le+oEUzjz7Xx0hf6DEzjIO3+z3rRvQBfi4350fb2awhEGhjv2
         xXnzL0z1C5QXeWADxI7kyXJtC1jU5WzegW0cTJ7+wox8osRRg8GtqU0Sb9qedUyd2pBo
         +Gl+gVFrD8R9yPGDHTE8ZnQP3aDFnAE1hDqISmoMlvg1j0Z1+NmfPbN/jWeF4e/tlciM
         lDI4UAbjbnleBAeIwt7HOBwUUub2RVXoVx2I1BBYzv0WEVdEJ1EOyJqqWqNcYZYVuJRY
         OLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794470676; x=1795075476;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bZnjmRjaw3mt+xCJw0WA+CLEo0XUahYdWgL+JaOD3TI=;
        b=M/YDFcgb7M23li/IMGaDM6D6okrfhfb1BSSAot9hwLUfKF/oGVkamKLkxbu4N+3iBG
         HE/p8otjBpfyBH1Qt/c7O7mpPGcQjKeHCt976Z3ebID2dY8e7/UnHkoVgJR8CtU4preT
         NVcICFmY5JwlUNQWTDlj1PWYOBWFD++UuTcI0riGafL/gejqgf1s2gR6Zcm8/G1Qevmb
         KEeyDqs6fQ4Q+2e8QzUl88OaEzedyC6MLrmix99ru8CSd43eFWl16c+a97EtCkfpk0cz
         pQM/fmWWLvk+sxDIpB9FdWvFJhKBZBqtB3ulb0Aak+07v/HqGcVC8v4dgWjWU9P5cFDm
         tydw==
X-Forwarded-Encrypted: i=1; AL+hErElDTQhLaDf8QLIdfuUlztTwCsMM1M1bQEKnLCrcgAKxUSEOZ9nHnZSjNZzkCTU6sBSWSLXCA==@lists.linux.dev
X-Gm-Message-State: APuU4Z9GCR5osDxK0FvgaSW39DiNQ4aAJVW4B14yVgAmzUFCv3Uhilmt
	TJ7XP7moUCwnbjE1hW7EHfAxGHP4FRRPdHFCFGUVzsteOykeTAvWjv7Nbkiy0cSUfOYvhw8FzGd
	NfECDoJ8jgBdnLMkvRsXEdbS4EuvzEas=
X-Gm-Gg: AYBFou3nUt1lyLnBS9C1OIBMrE+LifJeeXVlLAhC6J50rmzPIDwawZA0EBqZGLn64VL
	dcd2GaFNE7QN23L62fFMis9It1lIDntF2pVDna3ZvFpyOILVaQUVodAkKY+Z3Zi60gpYP+wRpXW
	Jy8vN7Te3M3opI2w09/eKHzJX8FOVQm0SCuLCZyYr5gZwkMdpL5ERqWDSDAnBxVKjooPEnlai60
	z+OqXrh5HB/WIjmSFJeNDtBVzJutIpnfzQfGgqXPuu+LI9S/6eXsZr3QpFtgCTj6O+AkgjPnL50
	DKirLWQf6cR+v1FbGQRR7BZIHM+I2jIXSlXHNGJ4vUZVgoRhG2cLOMIwv54gn6s2ekJfCM3nGcl
	YrYmAzzrCawT20VBenXFIkgYzAxUlVVBsRSXn7UG1aL4FnFg+exXJFSeuQNNYdq8bbL3Eaxw=
X-Received: by 2002:a05:6512:228e:b0:5c0:62:7fc3 with SMTP id
 2adb3069b0e04-5c15d65ace3mr1565808e87.5.1794470676380; Thu, 12 Nov 2026
 00:04:36 -0800 (PST)
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
References: <20261110-sun50i-iommu-prefetch-v1-0-43428e792ef6@gmail.com> <XuGVSzNrS7KQLWfGI0rB-w@gmail.com>
In-Reply-To: <XuGVSzNrS7KQLWfGI0rB-w@gmail.com>
From: Arun Iyengar <aiyengar1990@gmail.com>
Date: Thu, 12 Nov 2026 00:04:24 -0800
X-Gm-Features: AclHuK-rZwZBd82aiWDx-zqymsN3quC1b31liF4avq8uA1RRs7r6BZowIVjwmt4
Message-ID: <CAEy9hNUi0EmC4BC=TjpahO=jyKXBnAxHz-0C1KYPb7ZYfxDN_A@mail.gmail.com>
Subject: Re: [PATCH 0/2] iommu/sun50i: Don't report TLB prefetch walks as page faults
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Chen-Yu Tsai <wens@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, iommu@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jernej,

On Tue, Nov 10, 2026, Jernej Skrabec wrote:
> First off, display engine isn't in merged yet. Second, I don't observe an=
y
> such issues with my wip H616 code.
>
> I think it's best to wait until driver is merged and can be retested and
> merged then, if needed.

Agreed, thanks. In mainline the only H616 IOMMU master today is the video
engine, and the faults I saw came from the display scanning out a
framebuffer through the IOMMU, with the out-of-tree DE33 code I use. I'll
drop this series for now and retest once the display driver is merged.

Out of curiosity: does your WIP code map the framebuffer through the IOMMU?
In the boots where fbcon takes over the display, the fbcon buffer
(1024x768, 3 MiB) is the first IOVA allocation, so it ends right below
the top 1 MiB, which stays unmapped, and the prefetch walk for the page
after it fails.

Best regards,
Arun

On Tue, Nov 10, 2026 at 8:04=E2=80=AFAM Jernej =C5=A0krabec <jernej.skrabec=
@gmail.com> wrote:
>
> Dne torek, 10. november 2026 ob 07:05:16 Srednjeevropski standardni =C4=
=8Das je Arun Iyengar via B4 Relay napisal(a):
> > On an H616 with a display scanning out, the IOMMU reports page faults
> > with master -1 at the IOVA right after the end of the framebuffer: once
> > at the first fbcon frame, and then once per frame for a while after
> > each TLB flush, e.g. while a video decoder frees its buffers. They are
> > failed walks of the TLB prefetcher, which the hardware flags with bit 3=
1
> > of the page table interrupt registers and no master bit. Patch 1 stops
> > reporting them. Patch 2 makes the remaining fault messages say which
> > walk failed and what the interrupt register held.
> >
> > Tested on an Orange Pi Zero2 (H616) with HDMI forced on at 1024x768 and
> > three 4K H.264 decodes through cedrus, on 7.3 kernels with and without
> > the patches:
> > - without: 214 "Page fault ... (master -1, dir rd)" lines;
> > - with: none, no "Page fault" line at all, and no decode errors or
> >   timeouts.
> > Since the patched kernel prints every fault that is not a masterless
> > prefetch walk, this also shows that the hardware sets bit 31 for these
> > walks.
>
> First off, display engine isn't in merged yet. Second, I don't observe an=
y
> such issues with my wip H616 code.
>
> I think it's best to wait until driver is merged and can be retested and
> merged then, if needed.
>
> Best regards,
> Jernej
>
> >
> > These patches were developed with Claude (Anthropic) as a coding
> > assistant. It investigated the problem and wrote the code and the commi=
t
> > messages; I reviewed them, and they were tested on an Orange Pi Zero2
> > (H616) as described above.
> >
> > ---
> > Arun Iyengar (2):
> >       iommu/sun50i: Don't report TLB prefetches of unmapped pages as fa=
ults
> >       iommu/sun50i: Print the page table level and status of a fault
> >
> >  drivers/iommu/sun50i-iommu.c | 50 ++++++++++++++++++++++++++++++++++--=
--------
> >  1 file changed, 39 insertions(+), 11 deletions(-)
> > ---
> > base-commit: 2cf4be57b301ed2d7af82e70cff5dfd96894d8de
> > change-id: 20261110-sun50i-iommu-prefetch-85cc9ecff559
> >
> > Best regards,
> > --
> > Arun Iyengar <aiyengar1990@gmail.com>
> >
> >
> >
>
>
>
>
