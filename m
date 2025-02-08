Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54093157E6B;
	Sat,  8 Feb 2025 04:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738988821; cv=none; b=YkXy0Bt8IqnXHDR2OJxvXrxT8ReG5bGLrysJICAXV2YKQl2nJmTdWkG1eJ3u8r8oow0yqNTuaDRQrKZNGdDFUfayE/qHYRAH+JAL2PRpi40g91HcxEVdU92X956naUJ9uwtGP6P/OdJt/POA27J2PvgUQva9jO7+VyGB6OlYD/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738988821; c=relaxed/simple;
	bh=ym5ptxT+2nYTumEwJVEIgFvQ7+f+3l2P58kYEQGXqFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RFdLfz4YBfSUlEz6F4Lks8QhKLmTpJbvD4XMxs3rdrGUcIoqu+Tn4uVzMPaX0dWfda2zieWPWZ9NL1QmhKS4zcHGQD2M9rK3d9egeu2z6nHaRLZNcD7tHkr9wefFHjHJ7VdyV9O5IyyqVdKSZoIAWoDQ71Ug04NnWPuWTJmRb7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D165EC4CED6;
	Sat,  8 Feb 2025 04:26:57 +0000 (UTC)
Date: Fri, 7 Feb 2025 23:26:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
	Jason Gunthorpe <jgg@nvidia.com>,
	Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
	Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Abdiel Janulgue <abdiel.janulgue@gmail.com>,
	daniel.almeida@collabora.com, aliceryhl@google.com,
	robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
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
Message-ID: <Z6bdCrgGEq8Txd-s@home.goodmis.org>
References: <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207121638.GA7356@wind.enjellic.com>

On Fri, Feb 07, 2025 at 06:16:38AM -0600, Dr. Greg wrote:
> 
> Not sure what the fix is, from a project management perspective the
> technology industry has never faced a challenge like this.  The fork
> model, which was the classic protection in open-source, doesn't work
> at this scale.

Maybe not quite a fork, but I wonder if the Rust project did something similar
to what PREEMPT_RT did. That was to keep an out of tree patch. The full patch
was just merged last September after being out of tree for a good 20 years.

In the beginning there was a few things in that patch that Christoph was
against, but over time he became accepting of it.

Yes, being out of tree is very difficult because you have to constantly rebase
(we actually found quilt being a better tool than git in this case!). But it
also gives you full flexibility to try new approaches. Just because something
is out of tree doesn't mean it can't be published and used. Red Hat and SUSE,
as well as many others shipped PREEMPT_RT while it was out of tree.

Note, even though PREEMPT_RT started in 2004 and wasn't fully merged until
2024, it slowly did creep in bit by bit. For example, here's a few things that
came from the RT patch, and each was rewritten at least 3 times to become
acceptable by the upstream maintainers:

  - NOHZ
  - High res timers
  - threaded interrupts
  - mutex code (yes, before RT everything used a semaphore)
  - lockdep
  - ftrace
  - generic interrupt code
  - generic timer code
  - priority inheritance
  - SCHED_DEADLINE
  - RT push/pull scheduling

and more.

Point being, if you are having issues with getting code upstream, don't be
afraid to make it out of tree. Just make it easy for others to use. And slowly
move your code into mainline. This is also a way to prove beyond a doubt how
useful your code is. The number of users is a technical argument. Linus does
pull things in when there is a large user base, even over other maintainer's
objections (see sched_ext).

It worked for us, it can work for you ;-)

-- Steve

