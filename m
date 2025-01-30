Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC11DA5F;
	Thu, 30 Jan 2025 16:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738253506; cv=none; b=KmB0yiz3ZfgJvYvtTxhZLpC63r3SxtxkmOF6d6g9kCr0Ukp0oX2PhqSBvCofsD6kJ0oWkdQaCF3DVISyhTgKSrH2RlTlhhomc4Fw82npK7SMOk8jHWxdrH/hU0hwq4dUz9fUF+ai2jeD5iMqiQzscjr5MMbUFJhkWl3CMsBWFBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738253506; c=relaxed/simple;
	bh=wuudZ+Kk0FfZzmSB0ISGNWeut8WxUl/ah4/eXNRVmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oGtdtEYUC20g3tSAh0iZG2rbxpzG8tABJqTZ/qoHVhSBVFXTknMKQYN1f4isEfmZmGYOicoclpt/9bfEFtmIDqUZGyhZQNg7pxcZYdApbQXuR7XoIHbZNbLoXl4W9m7yof9Lh11BLLbdyk3j2kkyMwQQlAyzdgrMWJ3wJsuMuyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A0Y+oxR/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A0Y+oxR/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 754A9C4CED2;
	Thu, 30 Jan 2025 16:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738253506;
	bh=wuudZ+Kk0FfZzmSB0ISGNWeut8WxUl/ah4/eXNRVmdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A0Y+oxR/zZlo6DKq7jrn2mYqDOVlpPC8isqRZqAJ78Yh3N9a8NII3Dacy67zh/DyQ
	 eHXxGw7ES7UfctDRiezRJLIVdw02VxYe8g7dreo9WRNS2c4/AV0Gh2lJS+OFzGhfPM
	 E/XmeUIUW2i1QoG9FUY/TOtxt1bLpmiyJJmElA0E=
Date: Thu, 30 Jan 2025 17:11:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
	Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <2025013030-gummy-cosmic-7927@gregkh>
References: <20250108151858.GB24499@lst.de>
 <Z36X_ZnCmBQBMoZ6@pollux>
 <20250109080812.GA20431@lst.de>
 <Z3-NqwAG_96yq8VD@pollux>
 <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux>
 <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130154646.GA2298732@nvidia.com>

On Thu, Jan 30, 2025 at 11:46:46AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 30, 2025 at 02:19:16PM +0100, Philipp Stanner wrote:
> > would some sort of official statement by the "entire community"
> > reassure you that the burden of keeping Rust abstractions working with
> > any changes on the C side rests entirely on the Rust side's
> > shoulders?
> 
> You'd have to reconcile that with the recent event where Linus defered
> the MM pull request and some C patches were dropped because of rust
> kbuild bugs:
> 
> https://lore.kernel.org/linux-mm/CAHk-=whddBhfi5DUi370W3pYs+z3r2E7KYuHjwR=a1eRig5Gxg@mail.gmail.com/
> 
> It seems to me the message is now crystal clear, and the opposite of
> what you claim.
> 
> All PRs to Linus must not break the rust build and the responsibilty
> for that falls to all the maintainers. If the Rust team is not quick
> enough to resolve any issues during the development window then
> patches must be dropped before sending PRs, or Linus will refuse the
> PR.
> 
> Effectively this seems to imply that patches changing some of the C
> API cannot be merged by maintainers unless accompanied by matching
> Rust hunks.
> 
> If there are different instructions to maintainers I would be
> interested to know.

That's not the case, the one you point at above was a tooling issue that
people missed due to the holidays.  Fixing it up was simple enough and
people did so and moved on.

Once a core api changes in a tree and it hits linux-next and that blows
up a rust build, obviously people should notice it then and the rust
maintainers/developers have said they will fix it up.

So the claim remains the same here.  It's just like staging, api changes
to subsystems are allowed to break staging, and rust code, and
maintainers do NOT have to fix them up there, that's up to the staging
and rust maintainers/developers to do so.

thanks,

greg k-h
