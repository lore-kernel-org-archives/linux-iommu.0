Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8475E21CC4F;
	Wed, 25 Mar 2026 03:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774407652; cv=none; b=aUY7jCGgqnBaY6ciyL0SipQqWUP6q/vx8o0ucQTmYFDdjgw573thJB6jCT2kp0MOH6ENDd9qpbNgeBwHGicboqMHxkrpxyaHk3FGSmFMSdU6TEmJZE6lkdVKjqbjQJUWulkYF0wmEclLn0RAPhpvP9O6CnkcBRPPqYaS0spT+v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774407652; c=relaxed/simple;
	bh=CztaiS5T9Q+yyRl7KzG9kGIQBhdxneoXFQM3HOBtAYY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Th82QAIwHREiPP2yqWlUp9iQIIWunqfEM0QIGQTceT13M8bmly1LXysPSSaIkKcvFjgLNQBaAAAhUwvmCedgwXzkHrAZXSYKiftj9nR8uJyif131O0iOK1G4MdL/8RY5lMH/VksM/CmlND30fBXwuPdAusG6WnqZ1WYG1ewCy8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=XCVnXnZa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="XCVnXnZa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D71C19424;
	Wed, 25 Mar 2026 03:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774407652;
	bh=CztaiS5T9Q+yyRl7KzG9kGIQBhdxneoXFQM3HOBtAYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=XCVnXnZavwdON8NRKJfAiFXpB5TStIYEHPdUlg+y8LdWa47dj9YZ+8VWCRCIIpahG
	 BGGIXix0gfwZs7BicIJQSESLJ9v1NWmhD+hSWmTF1DfEr5KAiu448/aM8ZC1P1tLVY
	 BAUfZ+JJLeaX32H1tyfB+Lk6B9LBLpcgWv2TnCcA=
Date: Tue, 24 Mar 2026 20:00:51 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Rob Herring <robh@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-mm@kvack.org, iommu@lists.linux.dev, Krzysztof Kozlowski
 <krzk@kernel.org>, Oreoluwa Babatunde
 <oreoluwa.babatunde@oss.qualcomm.com>, Saravana Kannan
 <saravanak@kernel.org>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v2 0/7] Refactor reserved memory regions handling code
Message-Id: <20260324200051.65f45cbb445c6ec3f8f6399b@linux-foundation.org>
In-Reply-To: <CAL_JsqKbfFfWOzDL_KJLg7Gu-wCqE1Ch+yZ6-g-cNJD-rMzxXQ@mail.gmail.com>
References: <CGME20260323100908eucas1p2f471760fe1b26181c9b0cb90dd0739a6@eucas1p2.samsung.com>
	<20260323100901.4079171-1-m.szyprowski@samsung.com>
	<20260323131822.abae01e95817011f24bb8237@linux-foundation.org>
	<CAL_JsqKbfFfWOzDL_KJLg7Gu-wCqE1Ch+yZ6-g-cNJD-rMzxXQ@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Tue, 24 Mar 2026 20:49:14 -0500 Rob Herring <robh@kernel.org> wrote:

> On Mon, Mar 23, 2026 at 3:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Mon, 23 Mar 2026 11:08:54 +0100 Marek Szyprowski <m.szyprowski@samsung.com> wrote:
> >
> > > The reserved memory regions handling code was reworked to handle
> > > unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> > > reserved_mem: Add code to dynamically allocate reserved_mem array").
> > >
> > > The side effect of this rework was a set of bugs fixed later by commits
> > > 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> > > "cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
> > > call site for dma_contiguous_early_fixup()"). As a result, the code in
> > > drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> > > specific fixups.
> > >
> > > In this patchset I try to untangle this spaghetti and perform some code
> > > cleanup. I hope nothing breaks this time.
> >
> > AI review wasn't able to get all the patches to apply, but it asked a
> > few questions:
> >
> >         https://sashiko.dev/#/patchset/20260323100901.4079171-1-m.szyprowski@samsung.com
> 
> Now I get these in several reviews. Just posting links here really
> doesn't flow with the review process. How are we supposed to answer
> when AI is wrong? Manually quote everything? No thanks.

yeah, I know, it's quite dorkward at present.

> To answer this one, I think 1 comment is wrong, 1 is right, and 1 I'm
> not sure about.

Well that's good.  Really good.

I view Sashiko as a tool mainly for authors - view it as checkpatch on
steroids.  Reviewers will probably choose to take a pass if it appears
that the AI activity will result in a new version.

> Don't get me wrong, I think this all looks promising. I know email
> support is planned, but please get that in place before sending
> reports. Really, I'd rather just get the emails or mbox to review
> first and then decide what to send for things I maintain. At least
> initially.

"at least initially" is what we've got!  Be chill, it'll happen.
