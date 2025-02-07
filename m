Received: from wind.enjellic.com (wind.enjellic.com [76.10.64.91])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF7DA1DC9B4
	for <iommu@lists.linux.dev>; Fri,  7 Feb 2025 12:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.10.64.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738930635; cv=none; b=ngSPg/rGHKnostVXR8JTDD5xENx7EyYUWMglku7hd558ibWyjzfcmwpNwl/am38ubSU18SQSB5fWWOEtGZ4R9z5A3V0+tUW1RkUCZnrzECCExYiY2ZqOK3UgwP6jX4QWgt3mE7usyp1jJl67AZ8Cjwat6gmS9BxhHV1/4VAq2YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738930635; c=relaxed/simple;
	bh=Diwc8kaOpiUiKonF5IYBToi/IYCdpwMOdLIk8dSBMf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Mime-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ifFJmpXC7RK4M64vVsz1VwYrdMylkhaLLPocfDh3nQdAzVESsLEL7CfT5a7x5mOlq/CL+7LyCb+503My7e2L1PiwgVI0tUkKPi8k5PPG4wx8n4hneE4lnn7DA+lNrXHUbttMrN3C+SZN5jf3fZgERjPnLnHDUadPJ1PDUFrUwXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com; spf=pass smtp.mailfrom=wind.enjellic.com; arc=none smtp.client-ip=76.10.64.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=enjellic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wind.enjellic.com
Received: from wind.enjellic.com (localhost [127.0.0.1])
	by wind.enjellic.com (8.15.2/8.15.2) with ESMTP id 517CGfoY007959;
	Fri, 7 Feb 2025 06:16:41 -0600
Received: (from greg@localhost)
	by wind.enjellic.com (8.15.2/8.15.2/Submit) id 517CGcXR007958;
	Fri, 7 Feb 2025 06:16:38 -0600
Date: Fri, 7 Feb 2025 06:16:38 -0600
From: "Dr. Greg" <greg@enjellic.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Hector Martin <marcan@marcan.st>, Dave Airlie <airlied@gmail.com>,
        Jason Gunthorpe <jgg@nvidia.com>, Greg KH <gregkh@linuxfoundation.org>,
        phasta@kernel.org, Christoph Hellwig <hch@lst.de>,
        Danilo Krummrich <dakr@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Abdiel Janulgue <abdiel.janulgue@gmail.com>,
        daniel.almeida@collabora.com, aliceryhl@google.com,
        robin.murphy@arm.com, rust-for-linux@vger.kernel.org,
        Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
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
Subject: Re: On community influencing (was Re: [PATCH v8 2/2] rust: add dma coherent allocator abstraction.)
Message-ID: <20250207121638.GA7356@wind.enjellic.com>
Reply-To: "Dr. Greg" <greg@enjellic.com>
References: <20250130154646.GA2298732@nvidia.com> <2025013030-gummy-cosmic-7927@gregkh> <20250130172437.GN5556@nvidia.com> <2025013148-reversal-pessimism-1515@gregkh> <20250131135421.GO5556@nvidia.com> <2b9b75d1-eb8e-494a-b05f-59f75c92e6ae@marcan.st> <Z6OzgBYZNJPr_ZD1@phenom.ffwll.local> <CAPM=9tzPR9wd=3Wbjnp-T0W8-dDfGah-H3Ny52G85B+2Ev9ksA@mail.gmail.com> <208e1fc3-cfc3-4a26-98c3-a48ab35bb9db@marcan.st> <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wi=ZmP2=TmHsFSUGq8vUZAOWWSK1vrJarMaOhReDRQRYQ@mail.gmail.com>
User-Agent: Mutt/1.4i
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.2.3 (wind.enjellic.com [127.0.0.1]); Fri, 07 Feb 2025 06:16:41 -0600 (CST)

On Thu, Feb 06, 2025 at 09:58:36AM -0800, Linus Torvalds wrote:

Good morning to everyone.

> On Thu, 6 Feb 2025 at 01:19, Hector Martin <marcan@marcan.st> wrote:
> >
> > If shaming on social media does not work, then tell me what does,
> > because I'm out of ideas.

> Because if we have issues in the kernel development model, then
> social media sure as hell isn't the solution. The same way it sure
> as hell wasn't the solution to politics.
>
> Technical patches and discussions matter. Social media brigading - no
> thank you.

I truely wish that technical patches and discussions were the currency
that matter but I believe we are struggling with that, at least in
some venues in the kernel development process.

No one should construe that statement as an endorsement of berating
people on social media as the 'fix'.

I come at this from the perspective of having worked on Linux since
around December of 1991.  I first met you and Tove in 1995 at the Free
Software Conference at MIT that Stallman sponsored.  When we first
met, I told you that cancer patients in North Dakota were enjoying
more time with their families because of what we were able to do with
Linux and optimizing medical processes at our Cancer Center.

RedHat paid me to speak at a number of conferences in the 90's talking
about how Linux was going to dominate enterprise computing, given that
it was about technology people doing the 'right' technology thing.

I'm seeing things that make me regret those words.

Probably the last technical contribution of my career is leading an
initiative to provide the Linux community a generic security modeling
architecture.  Not to supplant or replace anything currently being
done, but to provide a flexible alternative to the development of
alternate and/or customized workload models, particularly in this era
of machine learning and modeling.

Four patch series over two years, as of yesterday, not a single line
of code ever reviewed.

For a contribution that touches nothing outside of its own directory
and does nothing unless people choose to execute a workload under its
control.

We were meticulous in our submissions to avoid wasting maintainers
time.  We even waited two months without hearing a word before we sent
an inquiry as to the status of one of the submissions.  We were told,
rather curtly, that anything we sent would likely be ignored if we
ever inquired about them.

We tried to engage, perhaps to excess, in technical discussions
attempting to explain why and how we chose to implement what we were
proposing.  Including input from advisors who are running production
IT systems that feel that there needs to be better approaches to
addressing their security needs.

There were never any relevant technical exchanges.  The discussion
consisted of, we have decided to do things a certain way, no
discussion, if you don't like that you should really consider doing
something other than submitting to upstream Linux.

The all powerful sub-system maintainer model works well if the big
technology companies can employ omniscient individuals in these roles,
but those types are a bit hard to come by.  Lacking that, there is the
tangible risk of stifling innovation and Linux is the only place that
innovation can occur in the operating system space.

Not sure what the fix is, from a project management perspective the
technology industry has never faced a challenge like this.  The fork
model, which was the classic protection in open-source, doesn't work
at this scale.

We have a Code Of Conduct that we can't scream or hurl four letter
words and insults at one another.  Maybe it already exists but a Code
Of Standards for maintainers would seem to be an imperative if we are
going to move forward productively.  Jim are you listening?

Obviously respect and open-mindedness to new ideas appears to be the
grease that makes all of this run smoothly.  Unfortunately that seems
to be about as rare a commodity as omniscience in our industry.

>                  Linus

Linus, best wishes to you and your family, it has been a fascinating
ride and thing to watch.

As always,
Dr. Greg

The Quixote Project - Flailing at the Travails of Cybersecurity
              https://github.com/Quixote-Project
