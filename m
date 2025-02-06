Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 135EF226170
	for <iommu@lists.linux.dev>; Thu,  6 Feb 2025 09:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738833597; cv=none; b=S41YIzTL2lFbWbtpiNkHR5KzjDwfbUNcblAqe3Aqqtv2wBjTdV2wS9DKIz5rdlwOUpE/xUkQH1rlV9Vo1ahHmMaPG1kWKyYM4RdKM62K9Nd6NGj1hAqF7jm60wLDACYU2rPKvlbAMeNM7EOW6itkG8B71zhNw465d0s9fksB89Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738833597; c=relaxed/simple;
	bh=Ufb2eylb3+DnuZABfILPsWYDDimlj3OEATXOyCLWYkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bMNLwQ5fdWVSK2gfMWig1yQ1FIdSnq2ItQpjJCd4MQYJsTrnUtiwGP1xR6XHiAQTVjU/kncpx7febLnwCxODbv8dIlHSS+naSQpl41G0XUwsgK1KWtZZUZo93V+0q4/TFHSfXM1KHxPSZ6gFYT3grPRQnQD0gE5jNseSw5213Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=zOA0+CLt; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="zOA0+CLt"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id CF00243598;
	Thu,  6 Feb 2025 09:19:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738833585; bh=Ufb2eylb3+DnuZABfILPsWYDDimlj3OEATXOyCLWYkI=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=zOA0+CLtKNsbLq+FloF3HrT3spuPM67n3zW1PnjeqhurqVEghbvreCtJk3UUO/aDR
	 A5BswsLuMQ1zvz7S07JkFOGDqlLzi7eXZK2zSZGA2Yj3DDODssYzz/jKZUwuD1EX/m
	 vSOHmE4ZOQU63PQZ8eTDZ6R48nQVxP4GjQojjbmFpN1GadB/vEO1ce+G/8+dbs86fQ
	 BGrxg2G990/5xcNKQ1GKVr7zVvQU6xndun8rBOmX/gv9A4+YYqf0pVPVPxkPfflMUW
	 EgJT5f90yw9EPghXDmuajr8XaT8en616WmuK8sa9o/ngtnxfOmVs0qOhapy16ySZsQ
	 SxRklUSEz735w==
Message-ID: <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
Date: Thu, 6 Feb 2025 18:19:42 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Dave Airlie <airlied@gmail.com>, Jason Gunthorpe <jgg@nvidia.com>,
 Greg KH <gregkh@linuxfoundation.org>,
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
References: <Z4D5a5NYrAbNxUL6@pollux> <Z4kG5AcVeQKegLnb@pollux>
 <20250128092334.GA28548@lst.de>
 <293df3d54bad446e8fd527f204c6dc301354e340.camel@mailbox.org>
 <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2025/02/06 5:36, Dave Airlie wrote:
> On Thu, 6 Feb 2025 at 04:52, Simona Vetter <simona.vetter@ffwll.ch> wrote:
>>
>> On Tue, Feb 04, 2025 at 03:46:14AM +0900, Hector Martin wrote:
>>> Adding Linus
>>>
>>> My 2c: If Linus doesn't pipe up with an authoritative answer to this
>>> thread, Miguel and the other Rust folks should just merge this series
>>> once it is reviewed and ready, ignoring Christoph's overt attempt at
>>> sabotaging the project. If Linus pulls it, what Christoph says doesn't
>>> matter. If Linus doesn't pull it, the R4L project is essentially dead
>>> until either Linus or Christoph make a move. Everything else is beating
>>> around the bush.
>>>
>>> Rust folks: Please don't waste your time and mental cycles on drama like
>>> this. It's not worth your time. Either Linus likes it, or he doesn't.
>>> Everything else is distractions orchestrated by a subset of saboteur
>>> maintainers who are trying to demoralize you until you give up, because
>>> they know they're going to be on the losing side of history sooner or
>>> later. No amount of sabotage from old entrenched maintainers is going to
>>> stop the world from moving forward towards memory-safe languages.
>>>
>>> FWIW, in my opinion, the "cancer" comment from Christoph would be enough
>>> to qualify for Code-of-Conduct action, but I doubt anything of the sort
>>> will happen.
>>
>> Yeah no.
>>
>> https://chaos.social/@sima/113942119012147959
>>
>> This was about you, because typing a proper answer takes a bit longer. It
>> was also about your toots on fedi, like this:
>>
>> https://social.treehouse.systems/@marcan/113941468353031993
>>
>> And "haha it's only a joke" does not work with your public profile and following.
>>
>> I do understand the frustration and temptation to just burn it all to the
>> ground, head the call of the sirens, or maybe for me more pick up goat
>> farming in the Swiss Alps. But you can't have it both and expect to also
>> be part of and contribute to the same community. And personally I don't
>> appreciate getting drenched in gasoline while I'm trying to quench flames
>> on the ground.
>>
>> And this isn't the first time or the second, by now it's a pretty clear
>> pattern over some years. And with the first I could explain why you react
>> like that and you had my full understanding, but eventually that runs a
>> bit thin as an excuse.  Now I'm left with the unlikely explanation that
>> you just like thundering in as the cavalry, fashionably late, maximally
>> destructive, because it entertains the masses on fedi or reddit or
>> wherever. I have no idea what you're trying to achieve here, I really
>> don't get it, but I am for sure fed up dealing with the fallout.
>>
> 
> To back up Sima here, we don't need grandstanding, brigading, playing
> to the crowd, streamer drama creation or any of that in discussions
> around this.
> 
> The r4l team and drm maintainer team have this sort of thing in hand,
> it's not like we don't understand the community of the Linux kernel,
> and having this first reaction to blow shit up and dramatise it just
> isn't helpful.
> 
> Being toxic on the right side of an argument is still toxic, please
> try and be better, and maybe take a step back and consider is what you
> are posting going to help the discussion or just adding pointless
> drama to it.
> 
> Dave.

I'm tired.

I'm tired of seeing positive, technically impressive kernel projects
blockaded delayed by maintainers with no technical justification, and at
best end up moving along at a glacial pace.

I'm tired of seeing important contributors and maintainers give up and
throw the towel after enduring repeated misbehavior and hostility
towards their efforts from others.

I'm tired of getting messages, privately and publicly, from all kinds of
people, saying they won't touch the kernel with a 10-foot pole due to
the hostility and the baroque, regressive process.

I'm tired of seeing people get away with using words like "cancer" to
describe others' work, with zero repercussion.

I'm tired of *politely and calmly* calling out hostile and unwelcoming
behavior from maintainers and suggest ways to improve, only to be
ignored and nothing change (note: this refers to other instances, not
this instance).

I'm tired of having to spend hours or days of my time to upstream simple
things, because even the simplest of changes en up in a bikeshed.

I'm tired of having to manually format code instead of using clang-format.

I'm tired of drive-by nitpickers who send useless review comments on
code they don't take the time to understand.

I'm tired of having to review patches in an email client, where I can't
even tell which patches are for me to merge and not without writing
complex filtering rules to correlate email bodies with kernel subsystem
paths, which I don't have the time to write and maintain.

I'm tired of having to type a half dozen `b4` commands just to send a
change.

And I'm tired of hearing things will get better if I just "trust the
process" or let people work from within, while nothing seems to have
actually changed in years despite endless discussion about these
problems on the sidelines.

If shaming on social media does not work, then tell me what does,
because I'm out of ideas.

- Hector

