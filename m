Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FAA1A23AF;
	Thu,  6 Feb 2025 19:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738870632; cv=none; b=bPtXAUcGEsz2HwmX1df4K0PPZhOfUzTOEJ859o1KGeiqVwcj9uH4cQD97y23/avU7eTWXBADQKzyEuFrcPjJw2VpGMNqhRMjKLXlVOep+fRn3c/aZ4NW1V2ULsWZlhCeqYSTEF3mbG7INcRJJUtvPcJXwoS964qhFQlkxjYueR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738870632; c=relaxed/simple;
	bh=kFFbN5GilgzCBInhcFGZK609ZeBEHIl+9Imwq3sgYhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MZFgXsX11AFUI/lyCK40urE6w7qX+mqphAG3TP2eg5BZinB5yAj01I1SLodTGJ4P4mXbpOyeSE/OKO/HpOXWhklh3LQCjSg1rs190OXeutVOsd2AXjJ+/1IH286zYDsN7wUXWNTyyuWIJt7r1+Y7SWTRpKgr4O0nGoTYR7f3dW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSFuw6dH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSFuw6dH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACB89C4CEDD;
	Thu,  6 Feb 2025 19:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738870631;
	bh=kFFbN5GilgzCBInhcFGZK609ZeBEHIl+9Imwq3sgYhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iSFuw6dHOFmyoN0qkh+tyFfnApmZkkYqCkDcyWcFePnH0NPRfwI2TvVO0PrkNzYIv
	 PgHawYmZvnj8oql/w+X3jWNXPIH/njq/5QG5+g2LOQayS4dNAjM1yDEyXCF0hHpxM1
	 slWbefs75ydaGMvmhxHf/6I2HFeRjudLWSHZ4ahw4DzMBumOeEu2zPNI6vvpFhZvbJ
	 ZfqtgPF26y4rSv1mHzhmMM3aiSTYrdqyn1A/P/OsD+XzBUeDCMPkJ0+nsjlwwYkfPE
	 b+KsEySBmXUN80EDVHPrloS+tODER3/Bgv4QXzgy5w3PcG0vIU74728ZAQ+qEf7EsL
	 Zeq/tT3XXw7vQ==
Date: Thu, 6 Feb 2025 20:37:03 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Hector Martin <marcan@marcan.st>
Cc: Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>,
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
	DRI Development <dri-devel@lists.freedesktop.org>
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
Message-ID: <Z6UPXxEJYpanU9iU@cassiopeiae>
References: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>

On Thu, Feb 06, 2025 at 06:19:42PM +0900, Hector Martin wrote:
> 
> If shaming on social media does not work, then tell me what does,

Most importantly be *consistent* with good technical arguments, calmly focus on
your actual matter rather than escalating any surrounding details.

Accept that sometimes things can't be reached directly, but additional work is
needed to change the preconditions.

Goals aren't reached by burning bridges, but by building them. Sometimes you
may not be able to build a bridge where you would like to. But you can still
look for alternative routes with and within the community.

Surely, it does take time and energy, but certainly there's no shortcut.

- Danilo
