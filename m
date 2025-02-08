Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5823C8D6
	for <iommu@lists.linux.dev>; Sat,  8 Feb 2025 08:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739003474; cv=none; b=MVwFUnyKZyNqgiQ3msO3qpXS/cTIrMNkcC8EF2tCs+sEYy9ZKH1ppjjL7FnwGcnbo9dyT3zvMTVTvrNsRz3Iy2p0wQcaBYDrb9V5yWUEJ2MrV4kewZb5Yw2stYXUpV20S3L+B08CGxqKN3VHaGDkmaDDCvbCRhe9vIAkucZTR6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739003474; c=relaxed/simple;
	bh=jmD7D9XcUagZ6PsaNTcK9z4/ha7zuHykclPHicgLzS0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dp0BZzR2uFAxTtijoYZe9NqJskXdxEi9OKYIIxPBdGv1r89vdFFz11xuMdz2qcmlQxfV8OnbGFSo3Gqw6R+h/RFLhvaRi1H/UgCqRoQC7wvwe5qt8M3mGgFpLb5M+DcL8C/STOAAsQw8tlL60O+VZq9RZ+B+6Nnx0GlyfzEBw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=bgHr7qhZ; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="bgHr7qhZ"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A1144427ED;
	Sat,  8 Feb 2025 08:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1739003468; bh=jmD7D9XcUagZ6PsaNTcK9z4/ha7zuHykclPHicgLzS0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=bgHr7qhZXl0G147DE6p2b5mUeL7LjemjbVzNhkEv82IActVuvakyui/C44c6MJ05L
	 3z+wqhhacacBBogX69nFHWE/erjMEUIKmJkFToHpqc3/+P/QS9LXtsszHdpxat02av
	 N3rSmf8MoSJyqdqiw03A8qyNP9E5hwOzX+Bspaeyuj0UyL3SpeXDREyRyaG5m7ePVG
	 Akw6ywLY06vS1uQ16+haxN+JR8K+F69eoph8SM5J09d7b0OHV57iQQri79SjGNgOwL
	 nnCG0cfTcJkiNTC17V2AjmrUXHLRsIJXt5SMfYMsOVqXxik/+GPPvTzYTpCUbMYAFv
	 ZAMZrqtLu2ZcA==
Message-ID: <1e8452ab-613a-4c85-adc0-0c4a293dbf50@marcan.st>
Date: Sat, 8 Feb 2025 17:31:04 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Steven Rostedt <rostedt@goodmis.org>, "Dr. Greg" <greg@enjellic.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bj??rn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
 <20250207121638.GA7356@wind.enjellic.com> <Z6bdCrgGEq8Txd-s@home.goodmis.org>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <Z6bdCrgGEq8Txd-s@home.goodmis.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/02/08 13:26, Steven Rostedt wrote:
> On Fri, Feb 07, 2025 at 06:16:38AM -0600, Dr. Greg wrote:
>>
>> Not sure what the fix is, from a project management perspective the
>> technology industry has never faced a challenge like this.  The fork
>> model, which was the classic protection in open-source, doesn't work
>> at this scale.
> 
> Maybe not quite a fork, but I wonder if the Rust project did something similar
> to what PREEMPT_RT did. That was to keep an out of tree patch. The full patch
> was just merged last September after being out of tree for a good 20 years.
> 
> In the beginning there was a few things in that patch that Christoph was
> against, but over time he became accepting of it.
> 
> Yes, being out of tree is very difficult because you have to constantly rebase
> (we actually found quilt being a better tool than git in this case!). But it
> also gives you full flexibility to try new approaches. Just because something
> is out of tree doesn't mean it can't be published and used. Red Hat and SUSE,
> as well as many others shipped PREEMPT_RT while it was out of tree.

By kernel and mesa policy, while a drm/ kernel driver is not merged with
a stable UAPI, the mesa side cannot be merged/enabled either. That means
that every day the driver isn't upstream, our users suffer due to
various container technologies not shipping the driver in userspace
since they ship upstream mesa.

The process is *designed* to encourage upstreaming early and *punish*
downstream trees.

It's not just distros shipping, or even typical container technologies
like Flatpak (we have a workaround for that specific one). We'd need to
get stuff like Android/AOSP to ship the patched userspace driver so it
works in Waydroid, which some people want to use. It is an impossible task.

Never mind that distros aren't, in fact, inclined to ship out-of-tree
kernels. PREEMPT_RT was an exception due to its general usefulness, and
even then was not available everywhere, and had a reasonable excuse for
being out-of-tree so long due to its intrusiveness in core code. Rust
and the Rust drivers aren't even remotely as intrusive, they just stay
off to the side in their own directories. Nobody wants to ship
downstream kernels just for random hardware support.

Out of tree doesn't work. People, both in the kernel and out of the
kernel, want things in tree.

- Hector

