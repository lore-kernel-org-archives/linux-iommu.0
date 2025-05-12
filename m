Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798D8255F26;
	Mon, 12 May 2025 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080616; cv=none; b=GKVf/lc4CSJRXO188OBdRv0CIghm+N5ocnqn3NtXrvb47L5lyWrvzpBPdSyqGTMLXYSStAFGSKvbI23VOlzvgAZ2AcIKks4sTyJ0J20Q7onmsri80gGGtbe4/MWQz6lS5x9SQsmtaZQJ/iDEioKzB1tveXTUZVdHVPr0f3NaVJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080616; c=relaxed/simple;
	bh=xqXIdlGotyYVN9hiLHimpgWuDMr+ucpVdDOKTtAF3uQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qEpwaCp5hTnHaHeOyh2fTDMhZ91kWF7vYeOobMD4R+krQKaEh7vbjAe8wX8c5bssEDaQ3tpbccGT/zJFQIxpO/dVHFkETdjKP97jJOo2hhR21kajbl/0B6ZudsGqpkTC3XK/OyBFYQ4w1Js/XtBKF8z/F2ylKJ1BMkyaZk3RZoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JYoa9Zb9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JYoa9Zb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0994DC4CEE9;
	Mon, 12 May 2025 20:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747080614;
	bh=xqXIdlGotyYVN9hiLHimpgWuDMr+ucpVdDOKTtAF3uQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JYoa9Zb91X0EB827NnAIqMyOyR9Gw9o/zIhA+XBE+dDsj/lTmZsXVq1c//aP1rg/D
	 nYUMtWbzZgSOoh3dv0UDPXvXhLt7KPzhFBrZMePVN76V5hbEhxExoGA2Y5qv87cQsF
	 oqgcrrSIPntg1zm7+thw3I8fQNmXevLHtH269bNU/wmGtamQxLYCT/AVRX97Eyfmqz
	 GWR9Fc1gTLLO+o1KePxvizASMl5LwdXkjudyTiuY8d9s+4y34cxAH4xBSrBeyYC8lW
	 b33LFLhJRK9lcEiNs+ZRi8XlvQKJ3yLtFyXWNezEcXEI8VLfYyDt8lKx8uigIbjc0C
	 PYummlwUg7tSw==
Date: Mon, 12 May 2025 22:10:07 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
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
Subject: Re: [RFC PATCH 1/2] rust: add initial scatterlist bindings
Message-ID: <aCJVn4LCCoe35SrU@cassiopeiae>
References: <20250512095544.3334680-1-abdiel.janulgue@gmail.com>
 <20250512095544.3334680-2-abdiel.janulgue@gmail.com>
 <20250512164247.GF138689@ziepe.ca>
 <AC0FC018-4440-4027-9943-12FFB481AA6E@collabora.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AC0FC018-4440-4027-9943-12FFB481AA6E@collabora.com>

On Mon, May 12, 2025 at 05:01:45PM -0300, Daniel Almeida wrote:
> Hi Jason,
> 
> >> +
> >> +    /// Map this scatter-gather table describing a buffer for DMA.
> >> +    pub fn dma_map(&mut self, dir: DmaDataDirection) -> Result {
> >> +        // SAFETY: Invariants on `Device` and `SGTable` ensures that the `self.dev` and `self.sg`
> >> +        // pointers are valid.
> >> +        let ret = unsafe {
> >> +            bindings::dma_map_sgtable(
> >> +                self.dev.as_raw(),
> >> +                self.sg.as_raw(),
> > 
> > Can't call this function on an unbound driver, didn't someone add
> > special types for this recently?
> 
> JFYI: I think that the “Bound” state is still WIP and not upstream yet.

It's in driver-core-next and queued up for v6.16.

There's also a signed tag [1] that can be merged into other trees, such that
this can be used right away.

- Danilo

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git/tag/?h=topic/device-context-2025-04-17
