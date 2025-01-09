Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48784A1A;
	Thu,  9 Jan 2025 08:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736412594; cv=none; b=DJJ5dUczUMdouQHJNNJaHzQLkY6CQuym9+wwfx58gj2gXhQZ0s1TWwsV+GoiFqQdGuH4y6oLzf34Adj71agMX0TqyPp2DyIfCRJs5A5HYl0UG3zDlNWy7AQlam/nwAVI9Cip91C4yFDWvmUfSDI9Vvi5p3ZAe0rxF3ZdDvKVsGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736412594; c=relaxed/simple;
	bh=kpgEk9RJksdsOkbGrDIsNPyEu+PqwsNxI7GM0COYBEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e6Cmf9aiWa0dxEfy+yND0AyGn709EafjUefNtg5FqOMdRHN7XQ/6XR3GBqxKA+21ceTpB5AagUll/SCcgw9sw1tPS8MHRzlQDhkAoKlPZIBpgnfTGUiZCh4oggPPzDcBRf1qX1nen9EgVEttUYS2i6LZ+/vq4yvWDkUVJPl8ELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QN0ELF74; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QN0ELF74"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F1B7C4CEDF;
	Thu,  9 Jan 2025 08:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736412594;
	bh=kpgEk9RJksdsOkbGrDIsNPyEu+PqwsNxI7GM0COYBEM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QN0ELF74Ex84hj7yOuS5fOFYzoWufpT7nDot/pqBqbFprOYp+S+0Rtks9fY86Og27
	 W8o0nAquhu272tholwyK+ssj9BFcYDw0Cl6+eGpG7KCCXdtt6Gly/+wJn+EU7A1tkR
	 kIG9KySmPxaAO2Ru9WAfo/V71JjQyX4/LvVw1JzC0g5EpukWBC/q3N0yYkaUFfCzYg
	 zAFUweqzZkGiccJDCm/8VQAp5221TqLbC0ah4GYDXnQSdrM3fXstML27hTh4V6WEec
	 fucTL3sFoub10CE+2zOS03RAnbcbdPaDlYRWNNHCUqtaOhQ1is9XrblU90PLfwGAfE
	 fQ8lfGsKkAloA==
Date: Thu, 9 Jan 2025 09:49:47 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <Z3-NqwAG_96yq8VD@pollux>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com>
 <20250108122825.136021-3-abdiel.janulgue@gmail.com>
 <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109080812.GA20431@lst.de>

On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > What does "your code" mean? Duplicated in every driver?
> 
> Yes, interfaces to the DMA API should stay in readable C code and not
> in weird bindings so that it reminds greppable and maintainable.
> 

Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
corresponding C API.

One reason for that is that some requirements C APIs naturally have, can be
abstracted in a way, that the Rust compiler already ensures certain things and
hence drivers have less potential to produce errors.

(I understand this is very abstract and we can go into details and examples, if
you like.)

So, in the end, Rust drivers would just end up with each of them including a
copy of those abstractions, rather than using the C APIs from all over the place
within the driver.

This wouldn't help with what you ask for, it would just duplicate the "problem".

If you don't feel comfortable maintaining the Rust abstraction (or just don't
want to), that's fine. I don't think anyone expects you to do that, we can take
care of that instead.

From your perspective, I think you can just think of the Rust abstraction as a
single driver calling into the DMA API.
