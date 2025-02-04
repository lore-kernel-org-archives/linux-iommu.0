Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86696215777
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738688063; cv=none; b=eEKjbFU80HV3jLpjBTIAmsHVPQPPH36aSsHoFLd5kH7vkDDdMSPoPzS4za4E1KJ45qYRrViNvck7oMHh73Iqf3OFbOqLl6AqBfFIBCQlXNTIJSOh5r4jUcnnbcS/eWcR0Nyq494igbEtGRNzEBEReqxIDyBmJMCYsb/PrTnH2mY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738688063; c=relaxed/simple;
	bh=dvbGjmFPIipFOAHao5it2MHqCCB+34eacpcE+gOPX6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlFIqynpt4BGkPQ8hcJtmDqpckNmqXN5tI5I50tJV6zTicy8zVN9f6sYzmyL+W0JKaG/vEyc0u+X7UD2K5TGKAEYI4hUrOkdxF2CO9ITEogKiPDwCKaHkfm913nMGvdSZpZo8QYZI7B3ShYt1ygAzZQiPl82lCStIvhR746FYpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kSguWrh6; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kSguWrh6"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3eba50d6da7so1643771b6e.2
        for <iommu@lists.linux.dev>; Tue, 04 Feb 2025 08:54:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738688060; x=1739292860; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ufxqeTPbh5jVi4KeE739Ux/m/0UeBoN+5T7+ZjE4za4=;
        b=kSguWrh60R/64sDkZ7XXkE5M+4jkFaWx7Wgoxyogd3cCBN8hH1ackxVcjvN5cr7AD+
         r0OiGI7jmRrhSm92vWcEMkaM2sAKamRmzKNg6TIbLD/FBtrGFu3PJLSzWQT/1zEy2ugo
         Saa0ukJDW0euNNJ0YQ0zwmM8HNgj3rfkV93VggZbu5wjj1haSIKVXFzN7cKo2QLbn/d0
         XPbaEP2BQjV18GH1m2bhJzxB5PPNVSKz7jquTrdtqwY8k1Fn4CJS2f2J+z//VSU58hRA
         jpZsBxj3+DB9UP+k4glZaI2gU/kZgpaTlOg9NJEwcA43tqNMn+MJL8XxzXggok93gXzf
         h3zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738688060; x=1739292860;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ufxqeTPbh5jVi4KeE739Ux/m/0UeBoN+5T7+ZjE4za4=;
        b=sFXCCvNhUOntARVhYU8+YULNtFpcY1e8vNy+LvnBF5ZDDIJ6gHbC3Fma+TArEKKVp4
         tCHPvew+pwM9nZBsH4TvC/71Z+sOBvd8gNpsm+Tw3XsShiRQBmiGvM0OdWi1ZKQ28ECP
         afhdV8XM0U7v2CyzoTUBW5aGzcXYkZNClsSKC7C71jQwqKfWDetLEHIeUiEofNLeFk4S
         YXIQHfvGwOwq8jE9zMGEmUKcdAifLqkqICohaEEXoCNqkfKKy2VBLDOlvEfgIwswMiYv
         XnU1ilnFD+RC/i1kBqGXR3SGLAn1xt/ZFoWq7nikSwXNII2uYRC6W7ml6b2y7JEaUN14
         zUxw==
X-Forwarded-Encrypted: i=1; AJvYcCUQQusTyWTB2eBZWOShcPED9aM/at14veNiqWWCY6x/G24gyMcGkc9PhNDqer05DymUe19EUA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwH9NuKk9sV2zHZYEc1TPGFHX5B3YmGtkousyWD6CxBZ2omLZwp
	G6s0YwOpz6xAmWcgyD5eOZUjLf8QWq3Bsxo+rc7iJT2g7h81ePRCZPIfiDPR1gxPAlFFD5wZVCq
	g6KQxqI8Kv38B0KfP2668FHWKLmk=
X-Gm-Gg: ASbGncsHV9DneBJcgvgvR1dIo3H6N29OdAx/s8ZowadMFQ4R2ICQ9j9piw8FFOWFqZi
	ltlioNdL07fUdNs9FF1adHhtU9+yNYNbDVrIhPE5IGe6laYbgDSM7vWfyF5nh/wTIAyEc9EvXJQ
	==
X-Google-Smtp-Source: AGHT+IF7EnaFEJFCSlyCLr+nn83vnKdF6Emxb8uA3hFJPTocYeG615mU6+dytSHRjTRpgNZMbqe79WfG5L4cwrXkxj4=
X-Received: by 2002:a05:6808:1b99:b0:3eb:6044:5a85 with SMTP id
 5614622812f47-3f323a76658mr18482915b6e.20.1738688060469; Tue, 04 Feb 2025
 08:54:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com> <20250108122825.136021-3-abdiel.janulgue@gmail.com>
In-Reply-To: <20250108122825.136021-3-abdiel.janulgue@gmail.com>
From: Thomas Hampton <thomas.j.hampton@gmail.com>
Date: Tue, 4 Feb 2025 10:54:09 -0600
X-Gm-Features: AWEUYZmrSMVxm_k1uivRyBQVGcUir-2h4LgjAJyf97InNoJiKzYSKb_gYdAF1GQ
Message-ID: <CAEmX-ZUbPqNUBj2-xAf=5uGE_GWAQQ79akADZCDxNsmx7Lf9VQ@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com, 
	aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Valentin Obst <kernel@valentinobst.de>, open list <linux-kernel@vger.kernel.org>, 
	Christoph Hellwig <hch@lst.de>, Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com, 
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"

On 1/8/2025 6:27 AM, Abdiel Janulgue wrote:

> +    /// Returns the base address, dma handle, attributes and the size of the allocated region.
> +    /// The caller takes ownership of the returned resources, i.e., will have the responsibility
> +    /// in calling `bindings::dma_free_attrs`.
> +    pub fn into_parts(self) -> (*mut T, bindings::dma_addr_t, usize, usize) {
> +        let size = self.count * core::mem::size_of::<T>();
> +        let ret = (
> +            self.cpu_addr,
> +            self.dma_handle,
> +            self.dma_attrs.as_raw(),
> +            size,
> +        );
> +        // Drop the device's reference count associated with this object. This is needed as no
> +        // destructor will be called on this object once this function returns.
> +        // SAFETY: the device pointer is still valid as of this point due to the type invariants
> +        // on `CoherentAllocation`.
> +        unsafe { bindings::put_device(self.dev.as_raw()) }
> +        core::mem::forget(self);
> +        ret
> +    }

Would it be feasible and prudent to avoid exposing `pub fn
into_parts`, `pub fn first_ptr`, `pub fn first_ptr_mut`?

It seems like some sort of functional access method might be better
for keeping future Rust code maintainable and Rusty.

For example, making client code from:

> {
>    let ctrl_id = unsafe { &*(id.first_ptr() as *const NvmeIdCtrl) };
>    number_of_namespaces = ctrl_id.nn.into();
>    mdts = ctrl_id.mdts;
> }

Into something like,
pub fn expose(self, op: F)
  where F: Fn(*const T) {
    op(self.cpu_addr);
}

let number_of_namespaces;
let mdts;
id.expose(|data| {
let ctrl_id = &*(data as *const NvmeIdCtrl);
    number_of_namespaces = ctrl_id.nn.into();
    mdts = ctrl_id.mdts;
});

And to avoid code docs like:

> /// The caller <...> will have the responsibility in calling `bindings::dma_free_attrs`.
