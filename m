Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC88211461
	for <iommu@lists.linux.dev>; Mon,  3 Feb 2025 23:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738623964; cv=none; b=PVWUGbX6JRQWAxs3saTGQ9pyqiyaBTEz9hTHt4ZUmKjsFZ3i5Cmh1OthmuDIx2Axg7bQyAvrORwN6x0/7oBvyNE5EzeTwUQd+lZyW0uY+fIzaAl9MMsljN5IrwmnEg8VSxfYV2f4KSPDHCbD55im4KlE961rg4N498gw9YezL3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738623964; c=relaxed/simple;
	bh=Or61prp2JoWermlq0N0myo+ho5ATNuTOQBsd9am+q9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmE35MHRWEs7PHnoU47QrSZKByhUaIq2ITLO8UqZEqJw3/UxyqJvh0nyOFtZ2F454867HQB1tBOSoqshUmp/1geZHV6mBgyt33SC4UzhMyhG+d5F+I+DcC3sCINpRVDysYsIgfGjGODbFnui/2dFQ1CsBiH0vStgyGfpbeAVL70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=Xq938RPZ; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="Xq938RPZ"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id 1548941F5F;
	Mon,  3 Feb 2025 23:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738623958; bh=Or61prp2JoWermlq0N0myo+ho5ATNuTOQBsd9am+q9M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Xq938RPZcUb8Vb9SDH6Q1xJl8Dsy7zVmMTU6qd/uinv7fNRPqS3lw/L4Ly7FqafFE
	 7kon9FNHyEGxnOglImPsruQRbSYB66H2hdcaeHKlrKMA/cJNdRCE9umuTjNKp+IK+8
	 2JC6XXsCteu8oLH+TsK4TY9K/6QQhDSOuFQVCA9x4FRxXwlIpR3F5NqpAA3Td2Mb8d
	 5RAzb9e/MelkuGaVuDnqKG5SLjx/B44PVJmLhY3T/ps999F5fPqWTRznUebarP4yB4
	 fF6CHPma6fi2aukS0vN51wOkkUCEWyTWwVby33hkpdDqamModuylZKOts8ZuguQMRc
	 4T3n8xZ3DUGTA==
Message-ID: <1d53fccb-8349-443e-9190-ef621526603c@marcan.st>
Date: Tue, 4 Feb 2025 08:05:54 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.
To: Paolo Bonzini <pbonzini@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>
Cc: phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
 Danilo Krummrich <dakr@kernel.org>,
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
 "open list:DMA MAPPING HELPERS" <iommu@lists.linux.dev>
References: <Z3-NqwAG_96yq8VD@pollux> <20250110083955.GA5395@lst.de>
 <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <5d5a6640-2f14-4d80-bc5e-4d8274251793@redhat.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <5d5a6640-2f14-4d80-bc5e-4d8274251793@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/02/04 4:22, Paolo Bonzini wrote:
> On 2/3/25 19:46, Hector Martin wrote:
>> Adding Linus
>>
>> My 2c: If Linus doesn't pipe up with an authoritative answer to this
>> thread, Miguel and the other Rust folks should just merge this series
>> once it is reviewed and ready, ignoring Christoph's overt attempt at
>> sabotaging the project.
> 
> Hold your horses...  I agree that they should just merge the series in 
> the unlikely event that Linus doesn't chime in over the next two months, 
> but I would very strongly suggest that it's sent to Linus (assuming he 
> doesn't jump in now) as a separate pull request.
> 
> This is almost always a good thing to do when you have commits that 
> merit specific attention (example: 
> https://www.uwsg.indiana.edu/hypermail/linux/kernel/2109.2/10311.html).

Sure, as a separate PR is fine.

> My 2 cents as someone that is certainly not any kind of VIP, but has 
> been in MAINTAINERS for quite a while.
> 
>> Rust folks: Please don't waste your time and mental cycles on drama like
>> this. It's not worth your time. Either Linus likes it, or he doesn't.
>> Everything else is distractions orchestrated by a subset of saboteur
>> maintainers who are trying to demoralize you until you give up, because
>> they know they're going to be on the losing side of history sooner or
>> later. No amount of sabotage from old entrenched maintainers is going to
>> stop the world from moving forward towards memory-safe languages.
> 
> I have a question, which is unrelated to my opinion of Rust for Linux: 
> in what way do you think this tirade is actually helping?

There have already been high-profile departures from the Rust for Linux
project due to the open hostility of certain kernel maintainers. The
tension in the air is palpable, and so is the lowering morale.

I'm encouraging the people involved to stop playing nice and start
playing hardball in these cases, because playing nice does not work with
some people. Taking the high road only works with people who want to
cooperate and reach a solution that works for everyone. People who
openly do not want to cooperate nor reach any sort of reasonable
solution should be shunned and ignored, as is the case here.

> 
>> FWIW, in my opinion, the "cancer" comment from Christoph would be enough
>> to qualify for Code-of-Conduct action, but I doubt anything of the sort
>> will happen.
> 
> FWIW I agree that it was borderline and probably on the wrong side of 
> the edge.  But I am happy for one that Christoph has since expanded 
> beyond the "cancer" comment, because that's at least a technical 
> argument, unlike yours above.

My argument above may not be "technical" in the technology sense, but it
is quite specific and objective: Christoph has made it *very* clear that
he is not intending to reach any sort of workable solution. He has
decided that he doesn't want Rust in the Linux kernel and will do
whatever he can to stop it, which fundamentally clashes with the goals
of the R4L project in an irreconcilable way. He may have his own
"technical" reasoning for this, but this is irrelevant, because there is
no way to appeal to his technical concerns and the technical goals of
the R4L project simultaneously.

What he is doing is quite literally the dictionary definition of
"sabotage". Since his goal is to sabotage the R4L project, in its
fundamental goal, no amount of purely technical discussion will allow us
to reach a workable solution. Therefore, the only possible reaction is
social in nature: Ignore Christoph, and work around him.

- Hector

