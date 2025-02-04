Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85CB23D81
	for <iommu@lists.linux.dev>; Tue,  4 Feb 2025 05:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738646964; cv=none; b=M5ycH1fcTxstV1BHaeYGSBgsB1C6KmDBDggqMyD3EArLOYmLEUcbVxHJLE9eapGy8Cmi3rmEtxzT/GJtGDbBzJpPyr9i0X3glcndBnpz4XLKnk/6uGAhHlu43t2q/bWVh4zx8t0JfmnnglUwlMa9o2MYkgPk8Z3sTHC4BXoyL6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738646964; c=relaxed/simple;
	bh=JSVZJky8YAb/dm+iJ2XrDIiSy8BRxQHy5geH9yi46bU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IgNvLDDwprBpPcInWPbIUYis5Tg0Kd75WWOTJUhh/tJapavWdHTfjRkmeLYbbV2jSPU8R1p3bbpVxPWhOLNfDLnsWLA90xhMb8B3ZVyD8wGbHEyxV2EWQwMFNgMwdtL+KULof2sXStMZ2x7kHxBAyue9W1bGmaSuiTiK5Vqz8ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id DDEF768AFE; Tue,  4 Feb 2025 06:29:16 +0100 (CET)
Date: Tue, 4 Feb 2025 06:29:16 +0100
From: Christoph Hellwig <hch@lst.de>
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
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
Message-ID: <20250204052916.GA28741@lst.de>
References: <Z36X_ZnCmBQBMoZ6@pollux> <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de> <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux> <20250128092334.GA28548@lst.de> <Z5qeoqRZKjiR1YAD@pollux> <20250131075751.GA16720@lst.de> <c3a56770-d483-409a-8586-610ce6a718e7@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3a56770-d483-409a-8586-610ce6a718e7@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Feb 03, 2025 at 10:17:22AM +0200, Abdiel Janulgue wrote:
> I do acknowledge your reservations about the possible maintenance burden 
> due to the introduction of a rust (or another language) consumer of the 
> dma-api. But I was hoping that we could arrive at some sort of common 
> ground?

The common ground is that I have absolutely no interest in helping
to spread a multi-language code base.  I absolutely support using
Rust in new codebase, but I do not at all in Linux.

Thank you for your understanding!

