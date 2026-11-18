Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795000617;
	b=QFYG1DAm2iuwM8vzipUZC/N3DRqzcj991/FoBbB0xdnUL7XY1PjZLqzhaikEN1XWZX8i
	 RNq53ujeESyqmQ9TrP98JjW0z2h7azOq7Ld1FuP7VaW8Lr/j8jGO0orVbAiyX0oRGqijx
	 eBIDWhioGfX395Bnt3wFnriR7FL8iHAdxzi7Tl8JwSUy0nLYTZ9aD3W6e9jlpEvhxSt+5
	 Br/9MKRjtDYF0N6+E/z7GQKmJWaV64UO3u6XIIgB7bBj7upvKQ5UjfWOLCNjaIKsm0yNw
	 UIdBZU7bp9I9z0vpCLOBfGXBY5XQuOnyvZnubmopX6nTHG6LWLFNsr+JmBN2Ddp+bqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795000617;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=VdBK9iPCpdL4SaGML/svEnUVQsDV7jsVMj4rTVCaMEQ=;
	b=ZrnTRsM8Ijlr56h9X0hKIQ8mANz8NY3ZB9Q59rA6L0Q09xaGrfWHcUHu4Jc8TfUnJjZU
	 sRlBdT589ly05Goe44O65YrSEvWbNpkudRhLHQvuesBLssxQdbgf3lp6iB5lvDRUKJpog
	 x8zwDbQQs5YJkY8KcprjUv2iJGbjlZTQ2ORBDPcX5q7R76y8t03qVkuaR7LL1gc9ksx/9
	 IGfTXcb7amT8Ky8RwjGLzXHfPJqVd10Gqbh/B2F/Kro3sYCFzsdq6v1YENppOLd1ki96u
	 YnjcWvxk5XtkvlVLRNfyR6qIwctcavwDuWKIGhRM5BwGFNMRaJ3MdhbpwU98aq/phMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PejMrKkw;
	arc=none smtp.remote-ip=209.85.128.72
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0794F606A325
	for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 11:16:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0794F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=PejMrKkw
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a20e41008cso6828945e9.1
        for <iommu@lists.linux.dev>; Wed, 18 Nov 2026 03:16:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795000615; x=1795605415; darn=lists.linux.dev;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VdBK9iPCpdL4SaGML/svEnUVQsDV7jsVMj4rTVCaMEQ=;
        b=PejMrKkwCRuT/G1jdYsCezqnR5kjGR3+QKlB91NTpCwyqV3zR42UpMbQgcXhRln34C
         J4B9amOwyyQ+8suNOP/k4sa1086OQUm/KSeCQACgosKjKjjURm6osFu1hOz46d0waM+d
         +q64lwfANsxb2yBv9WKcq+r4Lx6sPW/n94IXqktMPSkXatxhLuI4CvLCi0e83D6LUAGQ
         tmXmFAC61PjFnS5AnhWfjwQqHF8ALE7bJWWKzy4UHUem+8iIvRIrayCqae9LfwzeniAw
         Ik3jE55xBlimecs4YJBSe5EVka6Q1JNh0DP1y3Pc9u8+EH+Ni0mP1CW7K/vC9El/513V
         +sIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795000615; x=1795605415;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VdBK9iPCpdL4SaGML/svEnUVQsDV7jsVMj4rTVCaMEQ=;
        b=0iabbiqL+zYGiiAwqeNLcuSRrPnLPirzLwlxFxomNbq7+rna0jB5JqcJaTBpezUqVw
         NcJPjB2KQTtAaxK+HRxIZVqNBPUU3iMFWY2IRWLQ+QaFyWwpY7lgeESrGXOE2+rJe8ee
         n4CKP0aB7kgQ+ZMWDiNdeaPNurMKGC0XnB+/VBcInT2SiKLD9tbaNy2P6V9Y0RiYMCum
         wXe53hyAX1zmOrO2/vVgUIn1P2iT7OC77D+Gf8/cHn7CMJ82JMUoWcpbYIDPFVyE4tQg
         URzx8Za0sannpGS+lyFHKd0OyeADqpX/UIGuSCA4z4IEDjP2hwtTVBQHm8mtpc6qgZXY
         Q6sA==
X-Forwarded-Encrypted: i=1; AL+hErGPGzJWBXC5q3e+WEu4tXSHYlP03n6oUKvpQn8SlKw1Scz1IIdBedHsB58w4BqD8Ba6WJB+5g==@lists.linux.dev
X-Gm-Message-State: APuU4Z8/KMaztZif2/iuN1HhWjM3p56l6myncwQzx4p56ayQBfGuN6Gd
	1IWZQdc6WZks8pX8ij2une6A6+Nxlqwdf0X3+rHFNLBb8J02OpOD9L0qGhW3Hzb0XaGRSos2DCM
	10A3JX9IF0q42Ygrc5w==
X-Received: from wrsw6.prod.google.com ([2002:a5d:4b46:0:b0:4a5:1c26:11b4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d06:b0:4bb:6f45:2a6d with SMTP id 5b1f17b1804b1-4bb7da14a3bmr43246995e9.12.1795000615091;
 Wed, 18 Nov 2026 03:16:55 -0800 (PST)
Date: Wed, 18 Nov 2026 11:16:53 +0000
In-Reply-To: <0d26baaa-92ae-43ff-9a76-a81cad624dcf@kernel.org>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
Mime-Version: 1.0
References: <20261117-tyr-remap-2mb-v1-0-2a8efd4c8180@google.com>
 <20261117-tyr-remap-2mb-v1-1-2a8efd4c8180@google.com> <0d26baaa-92ae-43ff-9a76-a81cad624dcf@kernel.org>
X-Mailer: git-send-email 2.56.1.703.gf848ed807c-goog
Message-ID: <20261118111653.448550-1-aliceryhl@google.com>
Subject: Re: [PATCH 1/4] rust: drm/gpuvm: add GpuVa::data_ref accessor
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Deborah Brouwer <deborah.brouwer@collabora.com>, Sami Tolvanen <samitolvanen@google.com>, 
	Matthew Brost <matthew.brost@intel.com>, 
	"=?UTF-8?q?Thomas=20Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"=?UTF-8?q?Onur=20=C3=96zkan?=" <work@onurozkan.dev>, "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Boris Brezillon <boris.brezillon@collabora.com>, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Tue, Nov 17, 2026 at 08:40:20PM +0100, Danilo Krummrich wrote:
> > +    /// Access the driver-private [`VaData`](DriverGpuVm::VaData) associated with this mapping.
> > +    #[inline]
> > +    pub fn data_ref(&self) -> &T::VaData {
> > +        &self.data
> > +    }
> > +
> Why data_ref() instead of just data() or a Deref impl?

I guess this came from mirroring UniqueRefGpuVm, which uses the names:
data_ref(&self) and data(&mut self).

I think it makes more sense to rename to data(&self)/data_mut(&mut self)
for consistency with other similar APIs. But we should also update
UniqueRefGpuVm if so.

We don't want to go the Deref/DerefMut route because mutable access needs
to return a `Pin<&mut GpuVa<T>>` which doesn't work with DerefMut.

Alice
