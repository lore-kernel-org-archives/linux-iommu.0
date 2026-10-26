Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793047748;
	b=lfl1AKlhqIvRwOxfTuBy3DzdHFjcAZls0iXGDwJLYO0ZWFyEAVPfYURrzj722LhgRHpU
	 dQctbsz0R86mbY2cPvvIUPyQn4f2BaMDrChhT4/HS06hme6uHSjdt83vsSxOpEqppVSBG
	 UtdJjyBtsmlxU1xjfBEj1ZEnoQBNCwAvBr4hSWg+fGmofmtF8fFKq5Ka0Br1XdgVdDm+1
	 qlvQ703rHSC1dYN7Kei2Jw0p5LrvKNHRtO6Wwf1npp1o3SE0GjyNDQGjYDR2/Mq07sTlQ
	 CEHDzHYS1GOl7GwL/9lV59Cm7QMTR8fbN/GgeLPbXYMsOC8u896I2lrUEPyuf4Nonyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793047748;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:Content-Transfer-Encoding:
	 In-Reply-To;
	bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
	b=r/yLckGpSAJLpCAr8aSPXohUSyH5eJllLSxd9RRZ0ZqXGPnDwmeBZjJsGStsJ33Ud+39
	 xkH6w+9mnIz5juZZypEEiQabxpbd9BDOh2thTh/jHOOHcPXSKyyFb2uKNHwAhINK1Im5r
	 ViJwWTJ6oz1ygyKTLWrOCR9UYfqvxGBlYqPHnrsZuROrruTap3GEOPfPEhPMMa4iVOJJC
	 Ma07P0zi8iLRisihm57sF4AKud/Zscn5ru48r4eD94eBr0VAURFmzTXRC80ZsOYdXLZ3D
	 mtER9MKOvkSGiS5bNN10+/Yedo6dWBf7P7omdIE7l9/3iXs00zZv4Io1cxYpjshSvuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I8ny2eYf;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F58606A322
	for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 20:49:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A8F58606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=I8ny2eYf
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so2449683a91.1
        for <iommu@lists.linux.dev>; Mon, 26 Oct 2026 13:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793047747; x=1793652547; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
        b=I8ny2eYfD63YuoznNBRnaqrylgyuo6hQ0ejior0CkVNnOBtKspgH/HWTSch8ITj0aR
         k22HVJR/28xS1aRLIy6WmRYZb6+0+HiqBQMffwo8NZvKtuFD0TJMC8pVnNSkgaqGOyFU
         MskxXN/GAnyryur/vVOAsZNwpkDq0kKCWp6eWyrvS+8+mSPKkVcEaYRUXUOBVWTfB0EC
         cC9jPgBjPXkupOx5LlPVloHK7ST7D7WLOu5RXqeq3RiR939D7v//HcI7HVPbkVoVqqAt
         CpHdtoINveo37GeLvoU7P8W3Zg7OBE+6yw+8OQe7LXYnY7qeIR8XJ26uUPn/+r7XK6Wg
         7fzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793047747; x=1793652547;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=PJBAWhG3vQY26e/Nvx85KnaVoYI7FZuNNNc/vdxGNMI=;
        b=IW3uyY4UKfTnnD39hpXxLmk5LDN/xPuiu7JNx2eVAZs6OcDr9zZBt39wxi66jO+9dG
         LPl0/G0NVL11MdzF1Ci0LQV/Tmx/MSHTKjdBJ3T5LWMR7Odf/dl+h/LMgqpR07CDRdOZ
         xyMZKxhTE55SfPDPDW7ap2cDqSfWKaXILclmOhzeJMnlxg0QQEm6VF04MhAi031pVO63
         ZyIrIB1q08zfMc7kmmQiUZLxhpEGDvIV1jh5LPxw1U28jUwV+F8YJmr7Ry3vcdxkTAC6
         FkVc6pIL6ZsUV3Fc1+KyuJzdk1sthLxOWrgxg+/3bl03qnxhkbb9T4/hsE2DqORAgdRC
         gpTg==
X-Forwarded-Encrypted: i=1; AKwUvByM0VBRuuYNZqh/RuC2vvvjvcqB8mHM77R4bgftuVXen+L+oodAZItsVOGpHzjP0sY5cHB8Gw==@lists.linux.dev
X-Gm-Message-State: AFq9FYJqq80OTQDV0ZMutAB7yIBPY/Pqro8pOfPRbwUcBaIQPn2cF3AA
	0BN2OycsWz5eePHFg3W0awtvTpkd3B2H8yQgE59lEs6X135ySP7SaLBwQxCOMTHniw==
X-Gm-Gg: AYBFou0ON7YmTy3BHgcCX7N/d47wQ3mNDR7talMncUxpLw/7d1RsAmthoC5AwImTbqO
	9bGLChXjmgoQDkpiiPzRaBYIHBxLtS9Lp9tj480PeB4qUnUQRFa85w5H/owprX8tGul/qpKXGLj
	ilkWMkodJWhVAxm0AH+4LKyGxsRN3KWPlqZZiHTCMGrVJp0tVqWbEOYRKCNa4kXJTuf+zHbws+S
	sAkVe5T8J7kwSg1aC44JMK7TK+Sg4Jhz9+4QKfzfRm6Y5A7BvKdQWt2v5hy6qyaQJqfr0qGIAd8
	p+Kw0eL6ARUHUhJl9LOVShTHhM/4CwNNXCe4CoYHmJwjDnbH1rzQxNrl5Qsz8q37LaZtXw7bYzf
	o/QpwliRdq7BovKLLIeYF7RY3AWEPDUrOJJEKsQL3Yz/tv4Wvi3K6k8sLjy8bxwE6RvSlgCFVi5
	xBqmKzEpvpp8y7CMQSkO26nT8J73dD55slL/mnuO5RZdGlE3XS//CZ4sAWxr4zxE0B2+ZMzCyT/
	6fCOULmlGIb+Qe1ANDH2Co/GPvoYUxkM+gmNgL5vI8+Bci6HBz7lh/UrxnuIiCAtYGOp/lrmPFw
	9+zuFtazu9yONJ+5
X-Received: by 2002:a17:90b:5105:b0:3ac:9176:e81c with SMTP id 98e67ed59e1d1-3adeae76765mr6903041a91.46.1793047746368;
        Mon, 26 Oct 2026 13:49:06 -0700 (PDT)
Received: from google.com (64.75.127.34.bc.googleusercontent.com. [34.127.75.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae4066aec8sm743744a91.15.2026.10.26.13.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 13:49:05 -0700 (PDT)
Date: Mon, 26 Oct 2026 20:49:02 +0000
From: David Matlack <dmatlack@google.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>
Cc: tarunsahu@google.com, Andrew Morton <akpm@linux-foundation.org>,
	joro@8bytes.org, Mike Rapoport <rppt@kernel.org>,
	Pratyush Yadav <pratyush@kernel.org>, maz@kernel.org, arnd@arndb.de,
	jgg@nvidia.com, robin.murphy@arm.com, loganodell@google.com,
	oupton@kernel.org, kevin.tian@intel.com, alex@shazbot.org,
	dwmw2@infradead.org, pbonzini@redhat.com, seanjc@google.com,
	will@kernel.org, Alexander Graf <graf@amazon.com>,
	Bjorn Helgaas <bhelgaas@google.com>, baolu.lu@linux.intel.com,
	linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org,
	sagis@google.com, linux-mm@kvack.org, kvmarm@lists.linux.dev,
	iommu@lists.linux.dev, linux-pci@vger.kernel.org,
	kexec@lists.infradead.org, skhawaja@google.com, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 3/4] liveupdate: Replace compatibility string with
 a 2-bit pair feature header
Message-ID: <at-8vkVpN2SF3XgB@google.com>
References: <atlKsD-aJB3mJr2j@google.com>
 <CA+CK2bABt4OZO31TenVF2+uBUWVwViWbvfE00=0xbAw=f7K9SA@mail.gmail.com>
 <atl7peoVHdP5hz7z@google.com>
 <CA+CK2bBFXnJA1kddbLKGq0DAHDgjYhsTSQQay-xeX7jJC1V_UQ@mail.gmail.com>
 <CALzav=e=ho2gVrn+7KpZ3ZyasvH2u15-pC-RSRSS7KcMfKqUJQ@mail.gmail.com>
 <CA+CK2bAJo8dnTOyKMgnnMnk-SCXbTsv+JCLEOWkjyj-wqtEkHg@mail.gmail.com>
 <atpNFEFIlqAoYIwH@google.com>
 <CA+CK2bB2C3Am5ssRuzYpfiU7_vB81vxMGc19HQLq7N=_7YrbTg@mail.gmail.com>
 <attmFVIFU_mS0Y7p@google.com>
 <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+CK2bDXDWbww_d3sD6OZqpo37V1a3t76_ubbrXLQS=9DB3dWA@mail.gmail.com>

On 2026-10-25 04:38 PM, Pasha Tatashin wrote:
> On Fri, Oct 23, 2026 at 9:50 AM David Matlack <dmatlack@google.com> wrote:

> > Sure but why deal with all the complexity just to save 8 bytes? All of
> > these structs are allocated on folios and there are kilobytes of unused
> > space to fit this header. And even if we optimize that we are talking
> > about 8 bytes per FH/FLB... or 16 bytes for structs with arch-specific
> > sub-structs like the KVM ones.
> 
> The reason I care about keeping the header compact is that we are
> defining a foundational kernel ABI and want to use this header across
> almost every serialized data structure so we can evolve them later
> without breaking compatibility. While some top-level structs are on
> sparse folios today, other serialized structs are tightly packed, and
> we are looking to add KHO slab support in the future where tightly
> packed allocations will be common.

My intuition is we will have a small number of headers per preserved
file and per preserved FLB. One for the top-level struct and then
optionally a few more for sub-structs like arch-specific data. That is
why I am less worried 8 bytes per header, even if we fix the folio
problem.

Maybe where our visions differ is when there are collections of
serialized structs, like KHO blocks. For collections I don't think the
elements will each have their own headers. Otherwise the elements could
be different sizes.

Instead I think the struct that owns the collection will have a header
that includes features for fields in the elements. The header defines
which fields in all elements are valid. The field contents then convey
the per-element information (which might include 0 or -1 values to
convey this specific element doesn't have this data).

> That said, in your proposal, as long as nr_flags == 0 is allowed when
> a struct has no feature flags yet, luo_ser_hdr_size(hdr) is already 8
> bytes and only grows to 16 bytes on the first feature flag. I am OK
> with that.

Yeah the header will be 8 bytes until the first flag is defined, at
which point it will grow to 16 bytes.

Great, sounds like we are aligned on the header. s/luo/kho also sounds
good to me.

> > > This is not an issue on the incoming path, we never cast incoming data
> > > to struct name##_hdr or access ->payload directly. Instead, we parse
> > > the incoming buffer, dynamically compute the header size from the
> > > continuation bits, and cast the payload offset to "struct name *"
> > > based on the negotiated feature flags.
> >
> > How?
> >
> > This is the only data structure that describes the header. Are you
> > saying the incoming path will parse the header purely with a void *? Or
> > use this header but just be careful not to access payload?
> >
> > We should have one header structure that can be used on the incoming and
> > outgoing path. We should not have one header data structure that can be
> > used on the outgoing path and one that can be used on the incoming
> > path.
> >
> > Also we need a standard header that can be shared across all structs,
> > not a per struct header. Otherwise you will need to do weird casting and
> > overlays to implement the shared helper routines that parse it.
> 
> Having DECLARE_KHO_SER_WRAP() in include/linux/kho/abi/ makes it
> immediately clear just by looking at kho/abi/ which serialized structs
> have the versioned header and which do not, while also enforcing the
> header when preserving and static-asserting the combined struct size a
> compile time.
> 
> So with your header (and let's use KHO as we want to version KHO
> structs as well):
> 
> struct kho_ser_hdr {
>         __u32 size;        /* Size of header + payload in bytes */
>         __u32 nr_flags;    /* Number of features encoded in flags[] */
>         __u64 flags[];
> };
> 
> The wrapped struct will look like:
> 
> #define DECLARE_KHO_SER_WRAP(name, expected_size, nr_feats)                \
>         struct name##_wrap {                                               \
>                 __u32 size;                                                    \
>                 __u32 nr_flags;                                                \
>                 __u64 flags[DIV_ROUND_UP(nr_feats, 32)];                       \
>                 struct name payload;                                           \
>         };                                                                 \
>         static_assert(sizeof(struct name##_wrap) == (expected_size),       \
>                 "struct " #name " size mismatch!")
> 
> On the incoming kernel we don't use struct name##_wrap, but we use
> struct kho_ser_hdr for the wrapped data, validate the flags, and
> unwrap it via kho_ser_payload(hdr) to get back the struct name *
> payload type.

I still think it's not advisable to define name##_wrap since anyone
could accidentally start using it on the incoming path and we wouldn't
notice at first (especially since same kernel Live Update tests would
keep working totally fine). I also don't think asserting the combined
size buys us anything. The header size is just a function of the
number of features, and what we are trying to protect against is
structs embedded in the payload changing size.

So I would just do:

  /* Marks struct name as a KHO serialized payload with a kho_ser_hdr. */
  #define DECLARE_KHO_SER(name, payload_size) \
          static_assert(sizeof(struct name) == (payload_size))

  DECLARE_KHO_SER(luo_memfd_ser, 16);

Plus helpers that allocate and initialize the header and return the
payload as a typed pointer. Both the outgoing and incoming paths find
the payload the same way, by computing its offset from the header,
rather than through a struct with a fixed payload offset:

  /* outgoing */
  hdr = kho_ser_alloc(luo_memfd_ser, LUO_MEMFD_NR_FEATS);
  ser = kho_ser_payload(hdr, luo_memfd_ser);

  /* incoming */
  hdr = phys_to_virt(args->serialized_data);
  ser = kho_ser_payload(hdr, luo_memfd_ser);
