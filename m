Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400D4254842
	for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 13:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740403325; cv=none; b=s+Hoz0ANrv6LpatYUz7PxIqCJtBST3nkGUQeQ4chOreQAi1BRPvHT7+zQmsLcWF9bL70XFDKkwrgUO9U7f19ruO+aduO7hO1Y9lY4dByfHjmgb+JGo0kHFrWcBlgm2e3C18WxNrECZva+lOYKqRijLE9WqB1Uu8/b7zks31T1io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740403325; c=relaxed/simple;
	bh=Xj1kzyc2WJ6AjAa3xK3LVX/Vz40HDej/IgKIgDxXOQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tB4yTTxzQ2ElnO5Q9c8CVogXEvIM15UvIUkgW49Sp8DVb0nwlcC5lVQlWSr1l1RiDn+RUds62bRsEsZ6LhGW5L/Hx1HkQ23QbmBq94rlfYO21A5Yk+f/LRKZq2hSUv20rC0ABD4zRg14pX9FsTmYMQwUB0yoZtYMDirx9Xt+rQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r8ui+64o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r8ui+64o"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-38f403edb4eso2507475f8f.3
        for <iommu@lists.linux.dev>; Mon, 24 Feb 2025 05:22:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740403321; x=1741008121; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N/oiaAMAVxmEUGQ/a+kIBTCrAHvCn9ugUOtP/RUtk38=;
        b=r8ui+64oXqIyyTeE8jGcnXJ3PSTWmcVOb7PoZ6OJ2Bbri2k8L4wCUiS29ZnkbF1BpZ
         6jaQR3d6p7zembWUMYivVF5HAgbUxRYfBbhZVoG3XBUQozySdt4GQX5vLkka8OZru/VW
         eDB7T+dTpFEKBIbGgVbzbxMUlU+37x0UEasMxiB6dU6q3SJJgLrVT8chlu9iQyMPJBBA
         RO6ygENbMk50bX6JtHFD/hsotlbpxx6jt08JuBKPpvPEyslvAUWfbOoD+wvvh1Fc56VH
         iE+ISUpgpKM42pnD2MIlUqewo/6CmASByNfuZJHDY3x6jCHU8NBPsB3L1/yjlE715O/P
         muPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740403321; x=1741008121;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N/oiaAMAVxmEUGQ/a+kIBTCrAHvCn9ugUOtP/RUtk38=;
        b=IIGRDh1L1yxhN/TgTaTbSJDv9GKuteJG+myoasrMTJErzgjGB8D4GCI1F1uKvy+UZ8
         iVh8qvwEwEvbZ54bHh+MDhgMh9KuB6lkoKaRS3E9xe2B4CU7l3ppidlPraQlq/cVj2X3
         4jq/iaBhwPJipvkK97dcXUeyAbo5420drJzQ0v8vG8yVe7rbQEexn/f28PgFvth0LkUa
         J+Yk3zDdkoIs2kM1UrJIUXlSeQdH99HD4378hBQSq+6kVSIRwJSztc4tI9xSksJGghQJ
         T8icbsmRXoMplGjZR/lkannKdmMzUi+URT6QyBLKBpMZt7YDn3Flo7KRs08Ua4T8SaRS
         x35A==
X-Forwarded-Encrypted: i=1; AJvYcCW9THT0Ali5s9cFOU/npILfTTAnGizLjkGti6iJZDzQzq+p1NuBuD8ffkVR6PeFE2UD1uOUrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxGijVUoFOdzU81WO9hFHpitsYC/6gudzFpxS3QJeHleqSHH7W5
	mSBVd9b02UXb4f9HkcAB4xn6JTACTGHXdDr9HXQDamGvZ42Aak+g8tBH4QaBlQVOjlvoS7mCw8d
	29hsqV2J0P4VZwDJPYR+EYzoLzYrmUgU8YaDN
X-Gm-Gg: ASbGnctx+uhtIkLuHUjOFkq9upEyfO8DvFAEeHpX2PUr52dknUY+84favdLPMhIky4j
	W1gY7G/6bx6FMgPCllWk62Pxv7weXsdp8n3f/YhxbMObQ+Eco/0uEx9yp2YcS6jIKdujrXupIhH
	OXAyYUTacnLCbFImvXFBXdnyUW5Bd3wF22BTpo
X-Google-Smtp-Source: AGHT+IFATPleR0RJ6PuqfMEUDzRhsvzlMhaXdbWqxYCjtXu9VzNOnOg+cerl/y4Uo40ThVMEEUAZP+PRp26SoFcKstI=
X-Received: by 2002:a05:6000:2a4:b0:38d:e48b:1766 with SMTP id
 ffacd0b85a97d-38f6e75848cmr10390968f8f.6.1740403320054; Mon, 24 Feb 2025
 05:22:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com> <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 24 Feb 2025 14:21:47 +0100
X-Gm-Features: AWEUYZmLTsIy1fyUwTzeMd_646qNT7R9svbjnKF5MTp-t9JjPz9vZCjijiRddJM
Message-ID: <CAH5fLggU_sU56dEz6hQvMwjY=G2TuC9GYiVEBZFtE=Tk2QW4Fw@mail.gmail.com>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: dakr@kernel.org, robin.murphy@arm.com, daniel.almeida@collabora.com, 
	rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Valentin Obst <kernel@valentinobst.de>, 
	open list <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 12:50=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Add a simple dma coherent allocator rust abstraction. Based on
> Andreas Hindborg's dma abstractions from the rnvme driver, which
> was also based on earlier work by Wedson Almeida Filho.
>
> Nacked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>

> +    /// Create a duplicate of the `CoherentAllocation` object but preven=
t it from being dropped.
> +    pub fn skip_drop(self) -> CoherentAllocation<T> {
> +        let me =3D core::mem::ManuallyDrop::new(self);
> +        Self {
> +            // SAFETY: The refcount of `dev` will not be decremented bec=
ause this doesn't actually
> +            // duplicafe `ARef` and the use of `ManuallyDrop` forgets th=
e originals.
> +            dev: unsafe { core::ptr::read(&me.dev) },
> +            dma_handle: me.dma_handle,
> +            count: me.count,
> +            cpu_addr: me.cpu_addr,
> +            dma_attrs: me.dma_attrs,
> +        }
> +    }

The skip_drop pattern requires the return value to use a different
struct with the same fields, because otherwise you don't really skip
the destructor. But I don't think you have the user for this method
anymore so maybe just drop it.

> +    /// Retrieve a single entry from the region with bounds checking. `o=
ffset` is in units of `T`,
> +    /// not the number of bytes.
> +    pub fn item_from_index(&self, offset: usize) -> Result<*mut T> {
> +        if offset >=3D self.count {
> +            return Err(EINVAL);
> +        }
> +        // SAFETY:
> +        // - The pointer is valid due to type invariant on `CoherentAllo=
cation`
> +        // and we've just checked that the range and index is within bou=
nds.
> +        // - `offset` can't overflow since it is smaller than `self.coun=
t` and we've checked
> +        // that `self.count` won't overflow early in the constructor.
> +        Ok(unsafe { &mut *self.cpu_addr.add(offset) })

The point of the dma_read/dma_write macros is to avoid creating
references to the dma memory, so don't create a reference here.

Ok(unsafe { self.cpu_addr.add(offset) })

Alice
