Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1052122619;
	Wed, 29 Jan 2025 21:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738186410; cv=none; b=gsOTmnjxPQNIQfXHwPOQ8+NI8x+9fkjV9yRYXyIbzCsV/LiGmLaODs1aduGkDhL+zuahb8UU78LDo8KJxJQFVuqE1NIVOi3av2LAMAQcGWbIhzGH2QZVfmxhTYo+pTiCniirFCYV3jPaEQ91SAlstylpNtHvzgw5Ua3Xoit6Eow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738186410; c=relaxed/simple;
	bh=h/cQnz9PXbCjGYQAWuFFP0csETsOS4lQ0r2XZpJmQT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZXHssDJYx0ZNDUh2waz6GqEcFqPvd0M2r7aQLC1ko/df23xYtE7gqQ9rh/9m8LlAnpfGyYediOSxCv6oc5wKvD1MhyQwNb0wW7z7POv8/XdPbxuMme6A8VwbllylhhyUvwiQ7pKJu8oe1o0NfUaojusOr7abKKaFatf4v4N8QmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AyiJeoDV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AyiJeoDV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E340EC4CED1;
	Wed, 29 Jan 2025 21:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738186409;
	bh=h/cQnz9PXbCjGYQAWuFFP0csETsOS4lQ0r2XZpJmQT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyiJeoDVU90Fub9EsdRxY7zvtDDnHc8TKuZHPma1isJ0uzuTHduzdF+quRF5GqhDw
	 2g7m4BfhMIZE+6zz44pBch7rZKDYtwdeVEroa1BtMYBzpI/hiSzrVzGI4JeRIp8944
	 esewl9bYKOuUCC3jlmgq78gWzNGrwCO9JYVnFXiQSlYXaRXOkg6hdhVm7TpFN7s67c
	 Mv8HQ8B+qitRyPhm0U65MzxdtH7Od2SkVZjAIEEu/AYr/tvCxPcTqBZj+5W5GeamnW
	 QthXO7I0fEnQMq22X6g9AqHL+k/nfDr+yMmYdGbChw2/YG5A9EXk3esC34ej5uK3o+
	 7hJqIHcfIl6aA==
Date: Wed, 29 Jan 2025 22:33:22 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
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
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <Z5qeoqRZKjiR1YAD@pollux>
References: <20250108135951.GA18074@lst.de>
 <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com>
 <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250128092334.GA28548@lst.de>

On Tue, Jan 28, 2025 at 10:23:34AM +0100, Christoph Hellwig wrote:
> On Thu, Jan 16, 2025 at 02:17:24PM +0100, Danilo Krummrich wrote:
> > Since there hasn't been a reply so far, I assume that we're good with
> > maintaining the DMA Rust abstractions separately.
> 
> No, I'm not.  This was an explicit:
> 
> Nacked-by: Christoph Hellwig <hch@lst.de>
> 
> And I also do not want another maintainer.  If you want to make Linux
> impossible to maintain due to a cross-language codebase do that in
> your driver so that you have to do it instead of spreading this cancer
> to core subsystems.  (where this cancer explicitly is a cross-language
> codebase and not rust itself, just to escape the flameware brigade).

I accept that you don't want to be involved with Rust in the kernel, which is
why we offered to maintain the Rust abstraction layer for the DMA coherent
allocator as a separate component (which it would be anyways) ourselves.

As explained previously, this component is just a user of the DMA coherent
allocator API (just like any other driver) and the reason we want this component
is because otherwise this abstraction layer would end up in every Rust driver
that needs the DMA coherent allocator as duplicated code, which for obvious
reasons isn't desirable.

Throughout this conversation I did not see technical arguments or concerns
against this, but I did recognize your opposition against Rust in the kernel
and cross-language projects.

Being a maintainer myself, I think it is outside the scope of a maintainer to
restrict the usage of a public kernel API for a certain entity arbitrarily and /
or by personal preference, which, as it appears to me, is the case here.

@Greg, @Linus: I believe this would be on your purview.

Please find the full thread in [1].

[1] https://lore.kernel.org/rust-for-linux/20250108135951.GA18074@lst.de/
