Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3FE1DE4CC;
	Fri,  7 Feb 2025 10:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738925482; cv=none; b=VLNyPeyHPx3PYdECtltC2EEoAEJBoeu3FI/b3p6Idk27rLveUDN5nDhCFjt7LESHw3oX8SHknC9qid94icrTBapLwPc1Cz8cN4+3RMdQ5jFmXq8ZzOLuSXWWvMJy0sgMCVE90EhNcu2mEdvgiobqz1E0Bu4pl6YejqQRdDKJm+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738925482; c=relaxed/simple;
	bh=MzcVNhMxXBx2E3qC8/y/P/Qle44XJcvW/ssofTN4iaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qc6vaKczyg+fiAozYmnQsQVfIY28NaKxwdoz65wdYRfqhv+8NqTHL0zIFgOMmkQIkv38tYgZzpboVqW8YGlNjxhq+z2PyGuhTMcAFK/ruemFY5XHmO9jHNVqRr2jF1uSABKNp9Y37Wep0R6mrzOUB3Efmb9CH6gBUc4Jrv1RYzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YLJd763n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YLJd763n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E311C4CED1;
	Fri,  7 Feb 2025 10:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738925481;
	bh=MzcVNhMxXBx2E3qC8/y/P/Qle44XJcvW/ssofTN4iaQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YLJd763nKR/qpPon6brx/5IRYFRIzFN/u8Zww/XQOZxOtuqw3zHr+Hq1mqttty5km
	 T/WKXSPleOBA5p637odXy0YN3ziva5TPf0Hvr3pcH9ojqSo+tn6970GZr7g9N1gBUX
	 5b7m1AEZvdvP6HhP9zKqasmHoA2fA1KVRjq9ewoE=
Date: Fri, 7 Feb 2025 11:51:13 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hector Martin <marcan@marcan.st>
Cc: Simona Vetter <simona@ffwll.ch>, Jason Gunthorpe <jgg@nvidia.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
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
Message-ID: <2025020738-observant-rocklike-75cc@gregkh>
References: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com>
 <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <4c143b85-063a-4413-a6ca-e9d80e26da96@marcan.st>
 <c5a49bcb-45cf-4295-80e0-c4b07083df00@marcan.st>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5a49bcb-45cf-4295-80e0-c4b07083df00@marcan.st>

On Fri, Feb 07, 2025 at 07:20:03PM +0900, Hector Martin wrote:
> And I do believe the fact that essentially all high-level Linux kernel
> maintainers and contributors are paid by corporations to do it is a
> major factor that has caused this community to become wildly out of
> touch with what it means to be a community FOSS project.

Please note, that ever since I started keeping track of this type of
thing, way back in 2003 or so, it has been the case that over 80% of the
contributions come from company-funded developers.  Which means it
really goes back before that as well.

And that's good, it means that we have backing to do this properly, from
the companies that benifit from it.  To not have that would make it much
harder for any of this to work properly at all.

So don't try to play the "you all work for companies" card, that isn't
going to fly as obviously we all speak for ourselves here, and our
companies _know_ they can't tell us what to do, but they give us insight
into the problems that they have with Linux in order for us to help
change it to make it better for everyone.

Because again, everyone has the same problems (individuals and
companies), and so solving it for one "group", solves it for everyone.

thanks,

greg k-h
