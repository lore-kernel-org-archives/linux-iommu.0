Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425E810A3E
	for <iommu@lists.linux.dev>; Thu,  9 Jan 2025 08:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736410100; cv=none; b=EeQEl2pCJCzszDt58y2xOQvAiQxjMPq4qn2+lU1/Lx7DSu9huISZEXE2ScTOvTdwSEEzMkLhwsEMsEzICqyyt3Q9W9Im9i/OTcO4lGAj71h6y70aJPSWbRQbjAo56ylkaLmX0rdn6+AmUXYxdEQXRAh60okkDuKfu5BEN4dD5Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736410100; c=relaxed/simple;
	bh=BE/AG1UuHHUmSzQQDdLBq00na0eqCeYNXhbMLhM74Tw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0Pr/9p4rf8HcJ1crdi+naIXQOqWAhA4zSJJk5wkU+Zk043BS4cpTcjsFnn68dQREO/PhOCn5ETx9EADw1JiIfvXuZpIHTX3cqnswIW+BZ6ATQTAGX7QEepijIYL70JP/UzWB0CnjPn3M++wgC9kjyK1dn6wt3DrDRs+uN1AIbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1C31268AFE; Thu,  9 Jan 2025 09:08:13 +0100 (CET)
Date: Thu, 9 Jan 2025 09:08:12 +0100
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
Message-ID: <20250109080812.GA20431@lst.de>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com> <20250108122825.136021-3-abdiel.janulgue@gmail.com> <20250108135951.GA18074@lst.de> <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com> <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z36X_ZnCmBQBMoZ6@pollux>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> What does "your code" mean? Duplicated in every driver?

Yes, interfaces to the DMA API should stay in readable C code and not
in weird bindings so that it reminds greppable and maintainable.

