Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438442DCBE6;
	Fri, 30 May 2025 15:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748618329; cv=none; b=jHcwfMO9LiBXZ0sqeusfZJlabznSdtWiDe4hiwdAn8JcwYfPgjipvY2vTxVAS66QV9P62F5F6wM0/Zv9CMB0opf2/BWEuHIrIejBjcMm4sBtFE3unH8M6n6FUbQ6G3enHtbCz/t2ORgcRZDJuvjsCCCBDV5tVDqnQVT7ZwMk/WA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748618329; c=relaxed/simple;
	bh=JFkH1IRB/jb+tl+zY+0MlXrW3edDeFzFQcEIrpMJvrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/TzCe0N4OubplhMQSCDJRbo+VMndxslInUdIZd9pU8wjdHjqg8QHwzZLks06qfvabs9NNWHCBlna7fIvtUnwHKyFr06V4ziz4a1zRrbWTpUwwEAgRapfJ52LjFUhIesK2G5d/fu6S39hTDKSQ4OwlNwQfH67eb9+BbxZnV7bSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UnXhts/v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UnXhts/v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E84C4AF09;
	Fri, 30 May 2025 15:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748618328;
	bh=JFkH1IRB/jb+tl+zY+0MlXrW3edDeFzFQcEIrpMJvrQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UnXhts/vjTwLLc/TdnWHrRILPgiI1L6waApW94tlfowaftv9aKOZckhPmJJ3mOpLy
	 YNVKs+I0ehui9dDpLRdlpYU9Eo+UFAELw98+/XbwYPPbULtX4sJUVhxduQkh1EQExO
	 fcHX4xacldwW2hrGoPvKmzTZZECfgL+kCXtXDu8xewHTzT1+9seUpmabV7l0nquUyV
	 T4pdIhCNUU0v8BvU9b438T/83jcnIONdLRcTbLbWcdm5ltr1oyi/0n8AVjpmrHklXE
	 osAzirRgppdxE512nQePPYbLgSDg5tvvYlXURooK7oYLaHPkMf8dkbsCx+3NUH4oDm
	 PYK9cMQmeq8OQ==
Date: Fri, 30 May 2025 17:18:40 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Alexandre Courbot <acourbot@nvidia.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>, lyude@redhat.com,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Valentin Obst <kernel@valentinobst.de>,
	open list <linux-kernel@vger.kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, airlied@redhat.com,
	rust-for-linux@vger.kernel.org,
	"open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
	Petr Tesarik <petr@tesarici.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sui Jingfeng <sui.jingfeng@linux.dev>,
	Randy Dunlap <rdunlap@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aDnMUNCEJ8yhrKbX@cassiopeiae>
References: <20250528221525.1705117-1-abdiel.janulgue@gmail.com>
 <20250528221525.1705117-2-abdiel.janulgue@gmail.com>
 <20250529004550.GB192517@ziepe.ca>
 <DA9JTYA0EQU8.26M0ZX80FOBWY@nvidia.com>
 <20250530141419.GA292183@ziepe.ca>
 <DA9KQF9CY77R.77PBMU8Y1FPY@nvidia.com>
 <20250530145026.GB293473@ziepe.ca>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530145026.GB293473@ziepe.ca>

On Fri, May 30, 2025 at 11:50:26AM -0300, Jason Gunthorpe wrote:
> On Fri, May 30, 2025 at 11:44:26PM +0900, Alexandre Courbot wrote:
> 
> > I would be fully on board with a simpler design, definitely. The reason
> > why I've tried to keep some doors open is that as you mentioned
> > scatterlist is used in many different ways, and I am not familiar enough
> > with all these uses to draw a line and say "we will never ever need to
> > do that".
> 
> I think it would be better to grow as needed. It is hard to speculate.
> 
> We also have the new two step DMA API, so it may very well be the only
> use for this stuff is very simple mappings of VVec like things for
> DMA, and maybe this all gets rewritten to use the new DMA API and not
> scatterlist.
> 
> Having a rust user facing API that allows for that would be a great
> thing.
> 
> IOW I would maybe reframe the task here, it is not to create simple
> naive wrappers around scatterlist but to provide a nice rust API to go
> from VVec/etc to DMA mapping of that VVec/etc.

I agree, this is likely to be the main use-case and I also think it makes sense
to focus more on exposing higher level APIs in this respect. We can still expose
more low level API details if actually needed.

However, also for the API details we do not expose to drivers, we should aim for
creating safe abstractions for internal use if reasonable.
