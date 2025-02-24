Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8639C175D48;
	Mon, 24 Feb 2025 14:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740408056; cv=none; b=fOnHNEi8OZjfyEnVVt0RYIUbDgOvgSCSGufVk7kiEIMs06BWjGMvwCwemDZPxc7aW3CxcDGrAp6bEJgj2wxYf/Eq027WwZoE1Zf4jZOYnQjT/tPSHtPFoi5UHwreioL/ZrkiuKFOyV8Av32axwP4/IGBTKEcEdQIW+1DpFDo7EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740408056; c=relaxed/simple;
	bh=atez909ByKCpVKxkv1yk7K5PovM8idCDHM2diH+STDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VCkPBktRGCOlC5Dc3ZCKAUV2ahgsnE3iqEZ2Hg5l60jezaWiwPYpJFl3owaqq81WXDHz7Yg7WBL6APvdh5ruJUOtEdT0HyWGdPBR67ZT51ebp2pTagEeeS88H8zP2eFAvHcgPiC5klThHfCbboJr8OP30YvKRQcmG4mkaOEIowY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q4rATfr/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q4rATfr/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD99C4CED6;
	Mon, 24 Feb 2025 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740408056;
	bh=atez909ByKCpVKxkv1yk7K5PovM8idCDHM2diH+STDw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=q4rATfr/MwWZYyMQ6kJymyqhZZhzpeI6ciW5YUjQBpOvnPVCrer8x3OvL4hsmUmR8
	 g9inTtAYey/g9uaYxuhGaITUzEuggJX9H+6zKZUhm7IggMthhQnToMSgBJeFK4A4vu
	 wBbjm5U4PrRLIAvaWlg8y8S6Kyh3P1nNusZIYp7kGUOqKDSHeW3+nHOTa/GV+YE/A5
	 PtJQZErcOqoV+lJrYUqmt1RyitazHzszIieua+otanwn3DAZiv4GZrCCdXspi5P0pT
	 +cbaYAErzfJdCdhtKko5L1UdooJC35z7EWXURE1VUj2V91U2TFtnKOpLqU64YWPMqX
	 pLSTYUFeHdxCA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: "Abdiel Janulgue" <abdiel.janulgue@gmail.com>
Cc: <aliceryhl@google.com>,  <dakr@kernel.org>,  <robin.murphy@arm.com>,
  <daniel.almeida@collabora.com>,  <rust-for-linux@vger.kernel.org>,
  "Miguel Ojeda" <ojeda@kernel.org>,  "Alex Gaynor"
 <alex.gaynor@gmail.com>,  "Boqun Feng" <boqun.feng@gmail.com>,  "Gary Guo"
 <gary@garyguo.net>,  =?utf-8?Q?Bj=C3=B6rn?= Roy Baron
 <bjorn3_gh@protonmail.com>,  "Benno
 Lossin" <benno.lossin@proton.me>,  "Trevor Gross" <tmgross@umich.edu>,
  "Valentin Obst" <kernel@valentinobst.de>,
  <linux-kernel@vger.kernel.org>,  "Christoph Hellwig" <hch@lst.de>,
  "Marek Szyprowski" <m.szyprowski@samsung.com>,  <airlied@redhat.com>,
  <iommu@lists.linux.dev>
Subject: Re: [PATCH v12 2/3] rust: add dma coherent allocator abstraction.
In-Reply-To: <20250224115007.2072043-3-abdiel.janulgue@gmail.com> (Abdiel
	Janulgue's message of "Mon, 24 Feb 2025 13:49:06 +0200")
References: <20250224115007.2072043-1-abdiel.janulgue@gmail.com>
	<k3GMnfXzzvUVOgSnuMlEq3eVRyq1qjcf_tDtILRbOwj08EIQpwQ4bGtGhwWufr8lUn-VlHnNjP8FxIA48Jv-Ug==@protonmail.internalid>
	<20250224115007.2072043-3-abdiel.janulgue@gmail.com>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Mon, 24 Feb 2025 15:40:44 +0100
Message-ID: <87seo3z9qr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

"Abdiel Janulgue" <abdiel.janulgue@gmail.com> writes:

[...]

> +/// Inform the kernel about the device's DMA addressing capabilities. This will set the mask for
> +/// both streaming and coherent APIs together.
> +pub fn dma_set_mask_and_coherent(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask_and_coherent(dev.as_raw(), mask) }
> +}
> +
> +/// Same as `dma_set_mask_and_coherent`, but set the mask only for streaming mappings.
> +pub fn dma_set_mask(dev: &Device, mask: u64) -> i32 {
> +    // SAFETY: device pointer is guaranteed as valid by invariant on `Device`.
> +    unsafe { bindings::dma_set_mask(dev.as_raw(), mask) }
> +}

Sorry if it was asked before, I am late to the party. But would it make
sense to put these to functions on `Device` and make them take `&self`.

> +
> +/// Possible attributes associated with a DMA mapping.
> +///
> +/// They can be combined with the operators `|`, `&`, and `!`.
> +///
> +/// Values can be used from the [`attrs`] module.
> +#[derive(Clone, Copy, PartialEq)]
> +#[repr(transparent)]
> +pub struct Attrs(u32);
> +
> +impl Attrs {
> +    /// Get the raw representation of this attribute.
> +    pub(crate) fn as_raw(self) -> crate::ffi::c_ulong {
> +        self.0 as _
> +    }
> +
> +    /// Check whether `flags` is contained in `self`.
> +    pub fn contains(self, flags: Attrs) -> bool {
> +        (self & flags) == flags
> +    }
> +}
> +
> +impl core::ops::BitOr for Attrs {
> +    type Output = Self;
> +    fn bitor(self, rhs: Self) -> Self::Output {
> +        Self(self.0 | rhs.0)
> +    }
> +}
> +
> +impl core::ops::BitAnd for Attrs {
> +    type Output = Self;
> +    fn bitand(self, rhs: Self) -> Self::Output {
> +        Self(self.0 & rhs.0)
> +    }
> +}
> +
> +impl core::ops::Not for Attrs {
> +    type Output = Self;
> +    fn not(self) -> Self::Output {
> +        Self(!self.0)
> +    }
> +}
> +
> +/// DMA mapping attrributes.

Typo in attributes.


Best regards,
Andreas Hindborg


