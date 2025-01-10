Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1F217B500
	for <iommu@lists.linux.dev>; Fri, 10 Jan 2025 08:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736498410; cv=none; b=BnRoYfDE9A40vt1tDxoJm0HTSjS05wPrM5b7qQ6u6ddXf1Rmjf7GUKkVV+N5yl22arXUlTGoOjJvx5mEfEzb4oZUu7Km+kLy8FulnF6+7rdke6/c6YtFAoOLbNERZwu2HD+yqn/Q4SoowKxKPT8feKJFjiTOcWgJhcDneNUrKZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736498410; c=relaxed/simple;
	bh=F7nMCLL8IWCJEFpYDgPKB/haxS1UrdBpnxz0kMcurr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iuRiOwymIt5TcDSiZH2eUoUyXNpSs6LHyMWfYGf5f2skBpNWb/xlHRG8cxChFVZzg1sdIs3CdXMQo6DK+qoBuBWGnaqBPADKxsStj0pJ9wEadzo2rf1rsX+gz/Vo75du1fkpy2byQX0fKNwCFiJhxLnqCOZ9rMNAFoMQY/sLRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E559768BFE; Fri, 10 Jan 2025 09:39:55 +0100 (CET)
Date: Fri, 10 Jan 2025 09:39:55 +0100
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
Message-ID: <20250110083955.GA5395@lst.de>
References: <20250108122825.136021-1-abdiel.janulgue@gmail.com> <20250108122825.136021-3-abdiel.janulgue@gmail.com> <20250108135951.GA18074@lst.de> <CANiq72=R2N+QiCiHZQu-6YJ9aYpn_bik3BW3U=nAW3jL7unzLw@mail.gmail.com> <20250108151858.GB24499@lst.de> <Z36X_ZnCmBQBMoZ6@pollux> <20250109080812.GA20431@lst.de> <Z3-NqwAG_96yq8VD@pollux>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3-NqwAG_96yq8VD@pollux>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Jan 09, 2025 at 09:49:47AM +0100, Danilo Krummrich wrote:
> On Thu, Jan 09, 2025 at 09:08:12AM +0100, Christoph Hellwig wrote:
> > On Wed, Jan 08, 2025 at 04:21:33PM +0100, Danilo Krummrich wrote:
> > > What does "your code" mean? Duplicated in every driver?
> > 
> > Yes, interfaces to the DMA API should stay in readable C code and not
> > in weird bindings so that it reminds greppable and maintainable.
> > 
> 
> Rust drivers shouldn't use C APIs directly, but rather use an abstraction of the
> corresponding C API.

Don't force me to deal with your shiny language of the day.  Maintaining
multi-language projects is a pain I have no interest in dealing with.
If you want to use something that's not C, be that assembly or rust you
write to C interfaces and deal with the impedence mismatch yourself as
far as I'm concerned.

