Received: from mail.marcansoft.com (marcansoft.com [212.63.210.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158331A2C04
	for <iommu@lists.linux.dev>; Fri,  7 Feb 2025 19:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.63.210.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738955934; cv=none; b=ssZauD7nB3z807VyXLToBZXTzEfZA4Khr3y5Wobv5pqkKNW0g1ARNhDAbmILW6JSBu4ajSlKmfLEWM0DLW/ijt6eP8U98Ss+JuZI8ir7t+tTh06MGCmSGwZtu4dlNvUDWT4ggLnrs8ZL3liP9B55jvWLy4bvzhSJI133qBvFDf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738955934; c=relaxed/simple;
	bh=hzKbZ8fP/OSMSD/R0tqD9tsgwLS5wn2Ud2IztAjubuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kR35vXp93XHQz1wOx971fHntEFJQsXk8fpNfrKxofHhJx6lD6krwQ6/Acwt2DwpK1F2a2D8JZaDVHf1ZDgd74Aek59WeeWJkFquz8gF5zqOAQtsqXj5BvZ5+0/otvwMuJt1cHgFpW5ncCdXI3D++D2oU99wTxWD944zPXc8+00w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st; spf=pass smtp.mailfrom=marcan.st; dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b=sHjNiqpm; arc=none smtp.client-ip=212.63.210.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=marcan.st
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marcan.st
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marcan.st header.i=@marcan.st header.b="sHjNiqpm"
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: marcan@marcan.st)
	by mail.marcansoft.com (Postfix) with ESMTPSA id B39684203E;
	Fri,  7 Feb 2025 19:18:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=marcan.st; s=default;
	t=1738955928; bh=hzKbZ8fP/OSMSD/R0tqD9tsgwLS5wn2Ud2IztAjubuM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=sHjNiqpm+Nd9HwV76Weu9j8XnhP47P+uq7573nSGjE9eJAyMBGyfSz+yDqxX6/PbL
	 qGSrltV/BCfiDLNFTn81hhoQodk3U1539JLY+XxQxsYSYqNw5pmUFc1mBnVZftWSlu
	 xlcYlCzr/llfrxVde6Zuv+94X0XSE9sUPZTFGxNLXwKD6ciSyz2pWKO2yZz9Q6rXCS
	 L0fglNEajp8MokCOE25A31kFkq2rWrA5e+tWOksyAmdAJG3AC0U8m5vtM2BC02b0ck
	 hByJ4GYVkOtsVXJaITTvCU2bOyI/hIwth37+vWN3sNvsFpWOjkzlICkMkNrTaWi1/1
	 +DLBb/GdHKTjw==
Message-ID: <ae11fa0f-7b3e-4dd7-8b4f-da0e9daa99bd@marcan.st>
Date: Sat, 8 Feb 2025 04:18:44 +0900
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma
 coherent allocator abstraction.)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
 Danilo Krummrich <dakr@kernel.org>, Dave Airlie <airlied@gmail.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
 phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
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
References: <2025013030-gummy-cosmic-7927@gregkh>
 <20250130172437.GN5556@nvidia.com>
 <2025013148-reversal-pessimism-1515@gregkh>
 <20250131135421.GO5556@nvidia.com>
 <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st>
 <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local>
 <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com>
 <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st>
 <Z6UPXxEJYpanU9iU@cassiopeiae>
 <4c0a7cf9-26e1-4a19-8a6e-7c30bc3aef86@marcan.st>
 <20250207-mature-pastel-rottweiler-e6dbd9@lemur>
 <1bbdf8b7-a70b-4994-865e-7fcb8d53ebef@marcan.st>
 <CAHk-=wiQUya5_zTwLFNT2XkX-bf_H1vJiJ3zuADnO-3EwOOjVA@mail.gmail.com>
From: Hector Martin <marcan@marcan.st>
Content-Language: en-US
In-Reply-To: <CAHk-=wiQUya5_zTwLFNT2XkX-bf_H1vJiJ3zuADnO-3EwOOjVA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2025/02/08 3:33, Linus Torvalds wrote:
> On Fri, 7 Feb 2025 at 10:02, Hector Martin <marcan@marcan.st> wrote:
>>
>> Meanwhile, for better or worse, much of Linux infra *is* centralized -
>> for example, the mailing lists themselves, and a lot of the Git hosting.
> 
> The mailing lists are mostly on kernel.org, but the git hosting most
> certainly is not centralized in any way.
> 
> The kernel.org git repositories used to be special in that I didn't
> require signed tags for them, because I trusted the user maintenance.
> But I was encouraging signed tags even back then, and once it got to
> the point where most were signed anyway, I just made it a rule. So now
> kernel.org isn't special even in that respect.
> 
> Now, kernel.org is very much _convenient_. And you see that in the
> stats: of my pulls in the last year, 85% have been from kernel.org.
> But that is very much because it is convenient, not because it's
> centralized.
> 
> But that still leaves the 15% that aren't kernel.org.

For all intents and purposes, 85% centralized might as well be fully
centralized. That is, any downtime on kernel.org will affect the
community effectively the same as downtime on a true central SPOF would.

> More importtantly, not being centralized was very much a basic tenet
> of git, so *if* git.kernel.org were to become problematic, it's very
> easy to move git repositories anywhere else. Very much by design.

And this is why, over focus on *decentraliation*, I think we should be
focusing on *recoverability* and *data availability*.

There are two distinct scenarios. If kernel.org goes down for a while,
that screws with people's workflow. They can find alternatives, but it
will cause immediate, acute disruption, even while using "decentralized"
git. You still need to tell people where the new repos are, reconfigure
remotes, etc.. If the disruption is expected to be short-lived, a lot of
people will choose to just ride it out, rather than find alternatives,
or will only use alternatives in an ad-hoc manner where strictly
necessary. Nobody does a "true" complete migration to another Git
hosting when faced with a brief, temporary outage (heck, even just the
time it takes to push a Linux Git tree from scratch to somewhere new is
much longer than ideal, more so if your internet connection isn't the
best or the routing to the server in question isn't great). At most you
push whatever you're working on as needed somewhere else.

If kernel.org goes down permanently or long term (or becomes
problematic), that's when you start doing a full migration. And thanks
to the Git design, this is possible - not because it's decentralized per
se, but because everyone has local copies of almost everything, and they
can easily be restored onto a new service.

The same goes for a forge scenario. If it goes down briefly, you fix it,
and you can still use email to communicate with people ad hoc and send
git changes around through any other hosting. It's still Git at the end
of the day. Emailed patches and Git trees aren't going to become
unusable just because most or all of the regular development happens on
a forge.

And if it goes down permanently or long term, or becomes problematic,
what really matters isn't that it's "decentralized" as in federation.
It's that the data is available, in much the same way it is for
lore.kernel.org, and that people are actively backing it up (and it
isn't hard to arrange for a handful of folks/organizations to have up to
date mirrors, you don't need a Git-like scenario where literally
everyone has full repo dumps; heck, I have a big NAS at home, I'd
volunteer myself). Then, the service can be restored elsewhere when
needed. If the issue is with the specific forge software used, you can
always develop a migration plan to a different software (which, if the
risk is managed properly, shouldn't be a time-critical process anyway).

- Hector

