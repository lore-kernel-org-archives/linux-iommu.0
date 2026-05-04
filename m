Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC9637B415;
	Mon,  4 May 2026 22:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777932292; cv=none; b=Ori5L8ZnoB95fzXBo3ReD5hg102r2T6r52CQ9pwIQZBl7omejTcuPw94beuSdFR1TQOon36MqEHbMlCLbLE7rv5UU3nd+Hs9XRZMxYOi64ADbNUezujirXMFO8WFIQM2mxeLF6nw2jkjTbbbwfI2MlOyHfXFL5PzV0uCZTOZHtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777932292; c=relaxed/simple;
	bh=d7uP+s+lhqI8Q9mHdC9Wdrr8e2FIA5NOrAU8TxiL0oA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=MHNSuXQmLrBcYPe90lAC1aRf+R0mD6w1dV9ZiqbRrFrsK3m9MuwyiIIo0XAz2I1Tz+7Yba37KfiIGGJEQol6yzABnPAqh5BAVHIcLkyab8sowsUWmqfo01dDhLLEAhhySdbbEmh/oz8A9BoQ5xmj6UvsiCc9RRwDS1nidSXiPcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hW8touS3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hW8touS3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F211C2BCC4;
	Mon,  4 May 2026 22:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777932292;
	bh=d7uP+s+lhqI8Q9mHdC9Wdrr8e2FIA5NOrAU8TxiL0oA=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hW8touS354oPIA7u1pz20iBsGUFtzrUCQomo4oZytEL7gGWNh4LV6mfKSbZ/VkL1o
	 PDowkfzImr0kieYX/9YLU0UzaUIdQMz8Enu4bGo4oNQ9wNlmysZ7qMngeAgW5YpEnJ
	 rsEOV5b9CpOlZpKeCQ4iahShOTK/8C29Vch/mvlwJx8GqHYkOpiq5vrlM8JoL6WuZY
	 S8Ar5hcE2HCRjsIVOb1zMykBzvahv1q9+Tii3+/C0ijusM5R6akyZQIKMgfRb2Ch99
	 nrOlKfy5WbvbgzbEzrhKiw7hcAudfko9eAq9xhszwmTqdJIGeZM2PiWqIvLBnYXVpe
	 dRoWMFg1ffFFA==
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 05 May 2026 00:04:47 +0200
Message-Id: <DIA8E91NKUP3.247LCXIKRDJEA@kernel.org>
Subject: Re: [PATCH v2] rust: io: use newtype for PhysAddr
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J . Wysocki"
 <rafael@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Joerg Roedel" <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Robin Murphy" <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>
To: <x@2005.tr>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260503103050.200526-1-x@2005.tr>
 <20260504111421.72130-1-x@2005.tr>
In-Reply-To: <20260504111421.72130-1-x@2005.tr>

Hi Favilances,

(I assume you are Favilances; asking since the mail came from just x@2005.t=
r.)

On Mon May 4, 2026 at 1:14 PM CEST, x wrote:
> From: Favilances Noir <favilances@proton.me>
>
> Currently, PhysAddr is a type alias for phys_addr_t. This means
> that physical addresses can be mixed with unrelated integer values
> without Rust noticing.
>
> Use a transparent newtype for PhysAddr instead, and update the
> affected call sites to perform explicit raw conversions at the FFI
> boundary.
>
> This keeps the existing phys_addr_t representation while making
> physical addresses distinct in Rust type checking.
>
> Drop the unused Clone and Copy derives from PhysAddr, as pointed out
> in review.

This should be part of the version change log and should go below the "---"
line.

Please also consider the subsequent replies to this feedback, which point o=
ut
that this should indeed have Clone and Copy (and probably also other derive=
s
such as PartialEq).

For instance, consider the case where you call into_raw() because you need =
the
raw value but then still want to do something with the PhysAddr. Without Co=
py
you'd need to write something like:

	let r =3D p.into_raw();
	let p =3D PhysAddr::from_raw(r); // `r` implements `Copy`.

	// Use `r` and `p`.

> Signed-off-by: Favilances Noir <favilances@proton.me>

<snip>

> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index fcc7678fd9e3..999fa285a6ec 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -21,9 +21,24 @@
> =20
>  /// Physical address type.
>  ///
> -/// This is a type alias to either `u32` or `u64` depending on the confi=
g option
> -/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a u64 even on 32-bit archi=
tectures.
> -pub type PhysAddr =3D bindings::phys_addr_t;
> +/// This wraps either `u32` or `u64` depending on the config option
> +/// `CONFIG_PHYS_ADDR_T_64BIT`, and it can be a `u64` even on 32-bit arc=
hitectures.
> +#[repr(transparent)]
> +pub struct PhysAddr(bindings::phys_addr_t);
> +
> +impl PhysAddr {
> +    /// Creates a physical address from the raw C type.
> +    #[inline]
> +    pub const fn from_raw(value: bindings::phys_addr_t) -> Self {
> +        Self(value)
> +    }
> +
> +    /// Turns this physical address into the raw C type.
> +    #[inline]
> +    pub const fn into_raw(self) -> bindings::phys_addr_t {
> +        self.0
> +    }
> +}

I like the explicit methods, but I can also see that this might become a bi=
t
verbose; maybe consider adding From impls as well.

I think eventually we also want {Try}From impls for usize etc., but let's w=
ait
until we have a user.

Maybe also consider a Debug impl that prints a hex value.
