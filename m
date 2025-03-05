Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773DD41A8F;
	Wed,  5 Mar 2025 03:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741145061; cv=none; b=eB0tcMUCgtPr2pvXmlGzEhLFz0Vatho4TeOYRa2sRt/Hd768g4Cdjmpgwt2pd4+lKlBkJp0UTzrCu9R0/o5lIATaPmHUO6HDwWMeyHw0s7tFORDCwArip3VtMO0oYbJe9cZfhhFNejF68U16GcN/HcFzJGNJhg73Gap+NhZMMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741145061; c=relaxed/simple;
	bh=IalM6GcSrc2FXSX/2tWDq59g6jT4l3qYVHbrQtNGqOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cPuq5t68BfJ78DhFg+VfNbq3mGA6VYOjHaQBTTv/r4f5qnrZdcLKqD01EHqBR/zs70eieYQKQ7wxX2SekQLdz8In7kHMgf0KmbuOqM1w4ZTOqjL5K124tfETZnWWWXuliuwSdTobu+42ONo4xpW2mr9iTZrIRcJqo6lJq/D6TNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l4ZlMlgg; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l4ZlMlgg"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c0155af484so868660785a.0;
        Tue, 04 Mar 2025 19:24:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741145055; x=1741749855; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VCYzw7AYHEWhjh2pCKxrHo8DdwWDp+puWkHCQL3OAfM=;
        b=l4ZlMlggVBeFGuN2A3qHjzJxJKs/hpkk008xV2F3bNf2feIT4IAx0kH3GM65zxcoQy
         PrryM1nRmkrgYnOhTYtvE67M6x6pjI6d9aAVsCLI3Bo5P9ufdYyoEFsZJljV+38LDKhz
         kAITzGWcLvhIsHBIIjuT+/U127BW8ftE1PaYjY6GfIaAyGG+GMnjBldUQC3f2MNZRiNC
         FLTmhQMjqBnN4YbgIWZ86tPaVGNjglfZB7e38DwD7cJGurYeKi1jI8oK6dInvAtl9u0+
         6DvT5TvzXAquiSebnwifpHcjXEXGD1ilZUC96YTr1VmJq3XtDFoDub/0ypuHgbhuzei+
         MrKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741145055; x=1741749855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :feedback-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VCYzw7AYHEWhjh2pCKxrHo8DdwWDp+puWkHCQL3OAfM=;
        b=ghI8v96UW8Ldlu9pqs+wXZwFzW0hG8nSsYE45NWuWWlNrA9JyolRPCGKyFLBlDIBqj
         vYiQmKL6Vyci82A+eLLKjpYwbIpmEe9nZklpPrmPpF/ewowOAehw93m6+V7gxGVCPz3z
         HiwThFOQCABMGfiwz7IDaLjyc5/VRZydg+5NlVtfA6O26OGPqN64wPX00MnnL8ERODcd
         6f1IJ7qQpzQvbhNX2/jKIls02RgvexdVDmXkcHFxLnPbJ5K5CVEs13qtHWiw7/1TFkfT
         2zdbupv8VgGbXFwaphZN4ZvnKxF96dofoxs+vmKK8o6cFpRc5eZih980LSxC3pzq2aqG
         G3iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVF9d4CWm7jP1G5ZIB8a6g1nalC6yW/+qEEvgLC/yW675ydz/URi3ZRyCnW1O8PC1pT+7DohA==@lists.linux.dev, AJvYcCW4/mmSv55kGe0qZUht1SFEdvxE6cxxuvnk5UaIJ2S8YV5IlRD5kEV4H/CioEiif0VegTswxQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YysyP60qoROGWSpiHsrgAUDs0RoPrO4ONg3xzOfRTlE4QwRHmX+
	zEnQLxkMq4S0cZS8E5zhR2xIaSQGUWePuRb2vHyS0kysMS4kXDF2
X-Gm-Gg: ASbGncv+5KCIH43AJ+EA29eXgeWPC8cOGgMjr6isLfMtvkZUmG8bRdfRqIreeBluxne
	EyV74hKqNo+RiCM35HwqqtXeJb1DdKq+mEfAs92tg5hqPdYJ/JQmn30P6N6w51rpdzQDwkrvMy2
	JRyMGVhsTyXnwE+VOpnWQzR0mKck61npkIpQBUTZaqchc9iNv8Ro5B3QFkEv9HiO6eEcNHBhDD5
	dX6p/KkrRbyNY19ravP/skYqF3YM1lLIQiHeCqZYLJeYgdJahdA3tDEj/+nNBSlqoBdOVA7/mlv
	9TKb2I34q6V8rRA/16d83bKfPHLk4ZAYLcWhrmycvJZmpcw1KEXBELP8nEp5R3fTDL88FaZElk7
	Mq/2ih3zFBPpq5+CT5vfgiOcEX3g2ZFnpk1k=
X-Google-Smtp-Source: AGHT+IFkyQ73hd8BMJx+FC6q+VcIyRCQMDhKffer4K2eUcYMOGHylCr7hZHPBGmpGtT4iP9zVL947g==
X-Received: by 2002:a05:620a:6087:b0:7c0:97d7:27dd with SMTP id af79cd13be357-7c3d8ec7ebdmr335437485a.48.1741145055135;
        Tue, 04 Mar 2025 19:24:15 -0800 (PST)
Received: from fauth-a1-smtp.messagingengine.com (fauth-a1-smtp.messagingengine.com. [103.168.172.200])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c3edff13sm291499985a.69.2025.03.04.19.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 19:24:14 -0800 (PST)
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id 0DC551200074;
	Tue,  4 Mar 2025 22:24:14 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 04 Mar 2025 22:24:14 -0500
X-ME-Sender: <xms:3cPHZxPDh_XhD3GBFoAYAvygkcvXFCcn57YSjIdiUZx01UJKNk2W2Q>
    <xme:3cPHZz89ixupj5JKX_bBZoIIAORmtaivv-bxCC4OTSp8w8cJNttQUh656XAn3IITF
    x6vtyrDjIXGafZhrw>
X-ME-Received: <xmr:3cPHZwQGxOJe9SmxeS21xY5OBvZZ3Zik0482r-TSjEtzNvcs5hPEC9aATA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggugfgjsehtkefstddt
    tdejnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrg
    hilhdrtghomheqnecuggftrfgrthhtvghrnhephfekvddvtdekgedvgefgveduhfeihfej
    heffkeefveehffehhfehkeetheeileejnecuffhomhgrihhnpehruhhsthdqlhgrnhhgrd
    horhhgpdhkvghrnhgvlhdrohhrghdplhhlvhhmrdhorhhgpdhgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquh
    hnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudej
    jeekheehhedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrd
    hnrghmvgdpnhgspghrtghpthhtohepvdefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopegtohhmvgigkhesghhmrghilhdrtghomhdprhgtphhtthhopehpohhsthesrhgrlh
    hfjhdruggvpdhrtghpthhtoheprgdrhhhinhgusghorhhgsehkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegrlhhitggvrhihhhhlsehgohhoghhlvgdrtghomhdprhgtphhtthhope
    gurghnihgvlhdrrghlmhgvihgurgestgholhhlrggsohhrrgdrtghomhdprhgtphhtthho
    pegsvghnnhhordhlohhsshhinhesphhrohhtohhnrdhmvgdprhgtphhtthhopegrsgguih
    gvlhdrjhgrnhhulhhguhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepuggrkhhrsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehrohgsihhnrdhmuhhrphhhhiesrghrmhdrtg
    homh
X-ME-Proxy: <xmx:3cPHZ9uTcfObnarRoojUAy1B_6gP4rES_VkXm8sJwlr1UboBuD-JSQ>
    <xmx:3sPHZ5d6WiZvDs9uXESVzy4wnfv3ZEHD2c1vVWrS9vx80O3ecyIZiw>
    <xmx:3sPHZ514xBSASLkKzslb0SuhJGoVZCT8EOi3vDjXTV0-oht4gz3jJA>
    <xmx:3sPHZ1_6XSVlJL4v7FeTINqX_Csf78PYDrJ2m-IDjBRJLfcR26ud_g>
    <xmx:3sPHZ0_BOZIPQUysHVDA8plP6TjC8p2sFvHD77OMAoU1956cqb_cnRtZ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 22:24:12 -0500 (EST)
Date: Tue, 4 Mar 2025 19:24:11 -0800
From: Boqun Feng <boqun.feng@gmail.com>
To: comex <comexk@gmail.com>
Cc: Ralf Jung <post@ralfj.de>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Benno Lossin <benno.lossin@proton.me>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, dakr@kernel.org, 
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Trevor Gross <tmgross@umich.edu>, 
	Valentin Obst <kernel@valentinobst.de>, linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, iommu@lists.linux.dev, lkmm@lists.linux.dev
Subject: Re: Allow data races on some read/write operations
Message-ID: <hkhgihg4fjkg7zleqnumuj65dfvmxa5rzawkiafrf4kn5ss6nw@o7kc6xe2bmuj>
References: <87bjuil15w.fsf@kernel.org>
 <t4HxdvR7WBX_861hiTXo72jqC9F9oRpIzgA_dD2yhcSuLISEkC-shMfSgllrFPpnkSZXGfRcc47keudMooNiIQ==@protonmail.internalid>
 <CAH5fLgg5MuUu=TX8mMsPf5RcLhMLHSU4Vct=h8rFX6Z7HjPxeA@mail.gmail.com>
 <87ikoqjg1n.fsf@kernel.org>
 <KpWTCfIlcLYFBpSvWPfALJ9VQn5a99_RAvxgMBc1aCrSalPB-qaW9IhXyaDG7HM1AcFPX5chj_Yr7IQp3F7UqA==@protonmail.internalid>
 <CAH5fLgh6ubawHh76wq7JPbcuBCWhm91m7Rc01MVsX-a3C6qaVA@mail.gmail.com>
 <87mse2hrd8.fsf@kernel.org>
 <Z8YMTiKS4T9wC4t_@boqun-archlinux>
 <ae8ac31f-c6ad-46ae-80dd-10ec081a16d1@ralfj.de>
 <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <88456D33-C5CA-4F4F-990E-8C5F2AF7EAF9@gmail.com>

On Tue, Mar 04, 2025 at 12:18:28PM -0800, comex wrote:
> 
> > On Mar 4, 2025, at 11:03 AM, Ralf Jung <post@ralfj.de> wrote:
> > 
> > Those already exist in Rust, albeit only unstably:
> > <https://doc.rust-lang.org/nightly/std/intrinsics/fn.volatile_copy_memory.html>.
> > However, I am not sure how you'd even generate such a call in C? The
> > standard memcpy function is not doing volatile accesses, to my
> > knowledge.
> 
> The actual memcpy symbol that exists at runtime is written in
> assembly, and should be valid to treat as performing volatile
> accesses.
> 
> But both GCC and Clang special-case the memcpy function.  For example,
> if you call memcpy with a small constant as the size, the optimizer
> will transform the call into one or more regular loads/stores, which
> can then be optimized mostly like any other loads/stores (except for
> opting out of alignment and type-based aliasing assumptions).  Even if
> the call isn’t transformed, the optimizer will still make assumptions.
> LLVM will automatically mark memcpy `nosync`, which makes it undefined
> behavior if the function “communicate[s] (synchronize[s]) with another
> thread”, including through “volatile accesses”. [1]
> 
> However, these optimizations should rarely trigger misbehavior in
> practice, so I wouldn’t be surprised if Linux had some code that
> expected memcpy to act volatile…
> 

Also in this particular case we are discussing [1], it's a memcpy (from
or to) a DMA buffer, which means the device can also read or write the
memory, therefore the content of the memory may be altered outside the
program (the kernel), so we cannot use copy_nonoverlapping() I believe.

[1]: https://lore.kernel.org/rust-for-linux/87bjuil15w.fsf@kernel.org/

Regards,
Boqun

> But I’m not familiar enough with the codebase to know whether such
> code actually exists, or where.
> 
> (Incidentally, there is a compiler flag to turn the memcpy
> special-casing off, -fno-builtin.  I pretty much expected that Linux
> used it.  But I just checked, and it doesn’t.)
> 
> For Rust, I don’t know why we haven’t exposed volatile_copy_memory
> yet.  All I can find are some years-old discussions with no obvious
> blockers.  I guess nobody has cared enough.  There is also a somewhat
> stagnant RFC for *atomic* memcpy. [2]
> 
> [1] https://llvm.org/docs/LangRef.html, search for 'nosync'
> [2] https://github.com/rust-lang/rfcs/pull/3301
> 
