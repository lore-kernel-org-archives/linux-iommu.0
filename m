Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EFA158D8B
	for <iommu@lists.linux.dev>; Tue, 28 Jan 2025 09:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738056228; cv=none; b=YlGsVV9QTdrogCHwcwqsi2YGAkbanPIpztj3hCC9fAcqgpfUO6cPrVFxAxGonPEFu5UTewfraNthJ+52fvxnqIamWHMyOf1PdSX1rYDZcKYkbMB6KA+efUONG7k8+9qVrdyfLSe4YVGZN3zQM5pC1vPiGKTp2fsh1FumPV/AX7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738056228; c=relaxed/simple;
	bh=28D0BoKDOL+gtl6mKl/d1chY34vUYBNsUVs/rXTlBO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PNwWKQZOgDgBOWqDE5UnFDpktHyt9Z/mA3nwUKJo1/73TUYQFP7ipAQwJZwv7OX2zxBUvhN10XSqsFTe94DMvpYrXmJtrLN3esndK7p536D9RpqPn8WJmArxCVaH3tD8lWM7m3YLiexpLeMsLaY7GMVNJLzo9d8xLGojEByIfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C0D9068C4E; Tue, 28 Jan 2025 10:23:34 +0100 (CET)
Date: Tue, 28 Jan 2025 10:23:34 +0100
From: Christoph Hellwig <hch@lst.de>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
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
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
Message-ID: <20250128092334.GA28548@lst.de>
References: <20250108122825.136021-3-abdiel.janulgue@gmail.com> <20250108135951.GA18074@lst.de> <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com> <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux> <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z4kG5AcVeQKegLnb@pollux>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 16, 2025 at 02:17:24PM +0100, Danilo Krummrich wrote:
> Since there hasn't been a reply so far, I assume that we're good with
> maintaining the DMA Rust abstractions separately.

No, I'm not.  This was an explicit:

Nacked-by: Christoph Hellwig <hch@lst.de>

And I also do not want another maintainer.  If you want to make Linux
impossible to maintain due to a cross-language codebase do that in
your driver so that you have to do it instead of spreading this cancer
to core subsystems.  (where this cancer explicitly is a cross-language
codebase and not rust itself, just to escape the flameware brigade).
