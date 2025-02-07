Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89031D618A
	for <iommu@lists.linux.dev>; Fri,  7 Feb 2025 09:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738921318; cv=none; b=OCeen6XAOidc4u8yzbu79s4ZSmkcJMoZv5oRriZxAy5YbyRUkCWbCMJOPZoudkmFDFFRflnf4/qebD6pKZpvD8e9Ldp3LsLhxeSsDoNB3ZkMaOOJ7uaK6rFJ4Lft3qdN4iJdKV1f4HaPpPSUi/lpm+4SDryM6keNhNROHmIgiyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738921318; c=relaxed/simple;
	bh=hhnpORnNFDm++vxXeAvT3ViAqcibr/gkMJz681ofVAg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=oX55c278I112osxHXidmKs3bvn/xjp/tgwAoIjfxFaqXc8kzua2GDcWQeo+CfG6ayoCBxiPmJTXeB2sRvumuRF2wmWJ50rTq2wZ9miF4Gm26IUZEYuuGXDawEKupxd5YzRAETxms/AV0vxPo8+LFpOljzR2RRGbMCKK2w543ih0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=f7x/497T; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="f7x/497T"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id E3B5D4267F;
	Fri,  7 Feb 2025 09:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738921307; bh=hhnpORnNFDm++vxXeAvT3ViAqcibr/gkMJz681ofVAg=;
	h=Date:Subject:To:References:From:Cc:In-Reply-To;
	b=f7x/497TTlA4J5xS7wcETrqljbIFDYnQPGz7GoXWbwqFSu9urdwpcvIrY+8o3XZcA
	 TKfS1WhrKKEMfg1qLi3a6lO9cyEqRo+9achweDSe5w5Lo6bHCDeENj9825sXBESxxf
	 cx15qwbuKNy0PvNPfAG1rI92kJuBoJDVgF5d1UdN673RwcUGRoVVuaoT7NJCdHJriX
	 OjpETvSeS3LFTVSf9I1qM88ISy3JcYeJlpIpJ6KgGLOUB56St6xHaPWJ7uBhIV95Bd
	 DdlNwPA58ACr4ylOhUfT4gaVFSUa3okurftv8s9W5VRoein3+Bg15fTiL2XpjL2s8/
	 4idRRZn6TKG8Q==
Message-ID: <4c143b85-063a-4413-a6ca-e9d80e26da96@marcan.st>
Date: Fri, 7 Feb 2025 18:41:43 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Simona Vetter <simona@ffwll.ch>
References: <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
Cc: Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, phasta@kernel.org,
 Christoph Hellwig <hch@lst.de>, Danilo Krummrich <dakr@kernel.org>,
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
In-Reply-To: <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/02/06 3:52, Simona Vetter wrote:
> On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
>> Adding Linus
>>
>> My 2c: If Linus doesn't pipe up with an authoritative answer to this
>> thread, Miguel and the other Rust folks should just merge this series
>> once it is reviewed and ready, ignoring Christoph's overt attempt at
>> sabotaging the project. If Linus pulls it, what Christoph says doesn't
>> matter. If Linus doesn't pull it, the R4L project is essentially dead
>> until either Linus or Christoph make a move. Everything else is beating
>> around the bush.
>>
>> Rust folks: Please don't waste your time and mental cycles on drama like
>> this. It's not worth your time. Either Linus likes it, or he doesn't.
>> Everything else is distractions orchestrated by a subset of saboteur
>> maintainers who are trying to demoralize you until you give up, because
>> they know they're going to be on the losing side of history sooner or
>> later. No amount of sabotage from old entrenched maintainers is going to
>> stop the world from moving forward towards memory-safe languages.
>>
>> FWIW, in my opinion, the "cancer" comment from Christoph would be enough
>> to qualify for Code-of-Conduct action, but I doubt anything of the sort
>> will happen.
> 
> Yeah no.
> 
> https://chaos.social/@sima/113942119012147959
> 
> This was about you, because typing a proper answer takes a bit longer. It
> was also about your toots on fedi, like this:
> 
> https://social.treehouse.systems/@marcan/113941468353031993
> 
> And "haha it's only a joke" does not work with your public profile and following.
> 
> I do understand the frustration and temptation to just burn it all to the
> ground, head the call of the sirens, or maybe for me more pick up goat
> farming in the Swiss Alps. But you can't have it both and expect to also
> be part of and contribute to the same community. And personally I don't
> appreciate getting drenched in gasoline while I'm trying to quench flames
> on the ground.
> 
> And this isn't the first time or the second, by now it's a pretty clear
> pattern over some years. And with the first I could explain why you react
> like that and you had my full understanding, but eventually that runs a
> bit thin as an excuse.  Now I'm left with the unlikely explanation that
> you just like thundering in as the cavalry, fashionably late, maximally
> destructive, because it entertains the masses on fedi or reddit or
> wherever. I have no idea what you're trying to achieve here, I really
> don't get it, but I am for sure fed up dealing with the fallout.
> 
> Cheers, Sima

Since we're into complaining about social media posts on the list now,
I'm going to link one of yours:

https://chaos.social/@sima/113961496955043901

An R4L maintainer quit after multiple rounds of hostility, including
some completely unacceptable public comments bordering on downright
harassment from tytso, a situation which was widely publicized.

If, according to you, that's "shockingly smooth" with "no outsized
drama" other than "what I stirred up" (I guess you also missed the whole
LWN post about this thread before I posted anything on Fedi? That's how
I even found out about this), then I'm glad I'm disengaging with this
community. The Stockholm syndrome and utter denial is palpable.

I thought I could work with you on these issues; I don't know what
happened over the past year since we last had a private conversation
about this, but clearly you've changed your mind.

Thus, as you kindly requested of me in social media,

https://chaos.social/@sima/113961283260455876

I will now proceed to fuck off. Good luck.

- Hector

