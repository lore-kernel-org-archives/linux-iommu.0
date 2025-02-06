Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2637D1F5FA
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 20:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738872997; cv=none; b=ZFGd50XpHFBEQEoFlsUz3b/d2ZrLth20HZ+cI+TBtHSXezDFcuvuNFN8gmhPaISGhdCdD1Fd0iify1q0yjMe3aQ7zbaY9SqGDg40HFye69wDfDB29B8ORo348kc3BsfnQxQMCoKhbc9hl/ILHunTe12wnW+NXGb7Ixs3sVk3jvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738872997; c=relaxed/simple;
	bh=dVmSeA3RVfgoXEDG2BHXWi9s1id5dEEj/10AB/V328c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SOdFabr1Hds688EiG6gtx6NOdE1wz9Fa2Wx77jPZboqMDmXNLzrKdGe63kxBxsh8SR/zmFBFDiSalCNQAyX1ERpukzLYvjty6QI/FecxwLK9/bSyXKGk/ZylHjjDnu9yeGSojhVKd2yUgJQNKfzY7j7vE/Z3aeeckIg33cz9Cyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=jqDv2pxs; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="jqDv2pxs"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id A663343A93;
	Thu,  6 Feb 2025 20:16:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738872991; bh=dVmSeA3RVfgoXEDG2BHXWi9s1id5dEEj/10AB/V328c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=jqDv2pxs24XMA/Mh3ALyWty1xNykwX8hsRBd2TGCr7bGuK4azwnZ+PGk0XigOjkMj
	 JVTSYvDYLontyV+BE/OTk3LnBsjz5V1gVmb3hbC0XPeT05lXRczLcaMXZICLe/wdwn
	 GiM3qYJDnR2O5i8oBf2HOScSJYpn8sr1YQMlTKb+DvCHl0eFzyJ1fFfJwwfl2L37pE
	 oluPWB2/5lrBNcDa+/qNgxPq8ZiZgCvLmvtc02ukBnZRWRq0zgAtALZb4/dIUyrNlP
	 te5o9xsEOES567rGqcNWsPZwr6kzl/Cez5BGr1TejE6ObhokRigzIFIhhjN2eCaxA4
	 YuB6Y7PkcZz4g==
Message-ID: <4c0a7cf9-26e1-4a19-8a6e-7c30bc3aef86@marcan.st>
Date: Fri, 7 Feb 2025 05:16:28 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Danilo Krummrich <dakr@kernel.org>
Cc: Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Abdiel Janulgue <abdiel.janulgue@gmail.com>, daniel.almeida@collabora.com,
 aliceryhl@google.com, robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Valentin Obst <kernel@valentinobst.de>,
 open list <linux-kernel@vger.kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>, airlied@redhat.com,
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>,
 DRI Development <dri-devel@lists.freedesktop.org>
References: <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <Z6UPXxEJYpanU9iU@cassiopeiae>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <Z6UPXxEJYpanU9iU@cassiopeiae>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/02/07 4:37, Danilo Krummrich wrote:
> On Thu, Feb 06, 2025 at 06:19:42PM +0900, Hector Martin wrote:
>>
>> If shaming on social media does not work, then tell me what does,
> 
> Most importantly be *consistent* with good technical arguments, calmly focus on
> your actual matter rather than escalating any surrounding details.
> 
> Accept that sometimes things can't be reached directly, but additional work is
> needed to change the preconditions.
> 
> Goals aren't reached by burning bridges, but by building them. Sometimes you
> may not be able to build a bridge where you would like to. But you can still
> look for alternative routes with and within the community.
> 
> Surely, it does take time and energy, but certainly there's no shortcut.

I'm not talking about individual technical problems. You cannot solve
social and community problems with technical arguments.

Yes, given enough patience and technical argumentation, you can get code
into the kernel, or maybe even get some existing code refactored. That
doesn't change the fact that the process is often quite terrible,
hostile to newcomers, demoralizing, and by wide consensus much worse
than practically any other FOSS project, even those of similar scope to
the kernel.

And what I see, is very little effort to improve that status quo, or at
least very little that yields any actual change that isn't just
band-aids (e.g. tooling like b4, which is nice and appreciated, but
doesn't fix any underlying issues). And that's not going to change no
matter how many long technical arguments we have on the MLs (or even off
MLs, since MLs are also not particularly good for this, and I've seen
multiple arguments only reach a resolution after being redirected to IRC).

But I've used up all my spoons for this, and clearly Linus doesn't think
there's a problem in this thread worth replying to other than myself, so
I'm giving up on fighting for any change or being part of the kernel
maintainer community. Whether the rest of the kernel community chooses
to continue to live in an ugly bubble or actually try to fix some of
these systemic issues, is up to them.

- Hector

