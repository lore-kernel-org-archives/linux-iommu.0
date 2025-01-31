Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C8314F123
	for <iommu@lists.linux.dev>; Fri, 31 Jan 2025 07:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738310279; cv=none; b=Hh4Ae1EKY3oLre+QZADKKkxTnTuatnC2kuPEN3npqOWBChbmZ2xl+ATwmGTj85a9wBw6OIcE3TtztmBbmq/FOnlhbtldXDROiA3piWfdeOL3ixastB9WkvkWSvAFPjkTEKpt57bogP+0r6qAXzDtpWY0MlmGem5qfDCHsJCylA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738310279; c=relaxed/simple;
	bh=Kjq8y6HvSNYk7y3ysI830QvgE7bPZ4g3vNr9rSG4MAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LPOdGNhhqf/2swAYTJ93YrXl1JPKss8P50ZhyqLroczVHVuXsgN1mi6Erxq6Bf0kKNjD1jWo0knz1OFGkUiK24S8EZDIQN975MBLROvc/1Ildf/r6rPMv6m/Dz+sAfgKeopjHBcoJzoPA5ewq3l8fjzZ76u6SIRsECh4qB2D/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 6B4C668B05; Fri, 31 Jan 2025 08:57:52 +0100 (CET)
Date: Fri, 31 Jan 2025 08:57:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <20250131075751.GA16720@lst.de>
References: <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com> <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux> <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de> <Z5qeoqRZKjiR1YAD@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5qeoqRZKjiR1YAD@pollux>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 29, 2025 at 10:33:22PM +0100, Danilo Krummrich wrote:
> I accept that you don't want to be involved with Rust in the kernel, which is
> why we offered to maintain the Rust abstraction layer for the DMA coherent
> allocator as a separate component (which it would be anyways) ourselves.

Which doesn't help me a bit.  Every additional bit that the another
language creeps in drastically reduces the maintainability of the kernel
as an integrated project.  The only reason Linux managed to survive so
long is by not having internal boundaries, and adding another language
complely breaks this.  You might not like my answer, but I will do
everything I can do to stop this.  This is NOT because I hate Rust.
While not my favourite language it's definitively one of the best new
ones and I encourage people to use it for new projects where it fits.
I do not want it anywhere near a huge C code base that I need to
maintain.

