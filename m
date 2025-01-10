Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7B51FA4;
	Fri, 10 Jan 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736467815; cv=none; b=cfHrTCESEz4LknqqmOM+dWOdtpS4T/VM2K6Qo3BXhl2PwfBpWQNlrE8Mh13hNNys6L2M7x02kc39s8beinqXFpMPCFHS0Xyotr9dGTEb+DXeg7ol6YX8gWaCWqDupTpJJjS72KupcGRWQHLAhGhmPVwQaPy7lNvgE7L4RVzrxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736467815; c=relaxed/simple;
	bh=Y0Ev5vFJ6GI2V8OhWS1fMtIGvX6uJFWfskQrPfOqLoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bukFM2EhpRAtr09lSdxZhl3S2e3kF7q4zpb8F47tnJakgubTCf+QAX4tc99OuHg0HzJ8GgmYQJgozMHWmc6b9jJHJqI0E3qSjDwcSUgHSkhj/WHCL7k4LhdpcYd5aSQBuzrUqyrRYLPxlfO+F3+L112LZG7RkC119VlidkE+QWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s8ddMMcO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s8ddMMcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9CAFC4CED2;
	Fri, 10 Jan 2025 00:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736467815;
	bh=Y0Ev5vFJ6GI2V8OhWS1fMtIGvX6uJFWfskQrPfOqLoE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8ddMMcOHDytrw8LpPlwyuzfeUNjRam3nGoUqXYlTGBsUDoSSmIRSIKaz3mn58tjf
	 imZ4xGWe7H/vJjfs9kL/evXzb0mklqLXTfHAj0LP3hNr6X5vDnU9ZyzFAPjckuwYev
	 shlD+oX6cugaJtXxYAoW4Gw9tyvRiSCpyJ3+TMw7kW9QXX5Rb/b+qqc5+e/pn2H+K5
	 osPCMoa4NbeLa39ylst2LNq9GsPnonbntrQIUYvq9Lqb0urIGm8XkNEXECOl1kAaYw
	 1FcQzqemS48nnOLyAiJtZqs5TzwmGRYlFNOc18VRtx080WmphedESbP6x6zh7u08TH
	 oBIKIhiSvYgpw==
Date: Thu, 9 Jan 2025 17:10:12 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Regression] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX
Message-ID: <Z4BlZCWzu3OV3V2U@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp>
 <20250109082849.GC20724@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109082849.GC20724@lst.de>

On Thu, Jan 09, 2025 at 09:28:49AM +0100, Christoph Hellwig wrote:
> On Wed, Jan 08, 2025 at 08:07:28AM -0700, Keith Busch wrote:
> > It should always be okay to do smaller transfers as long as everything
> > stays aligned the logical block size. I'm guessing the dma opt change
> > has exposed some other flaw in the nvme controller. For example, two
> > consecutive smaller writes are hitting some controller side caching bug
> > that a single larger trasnfer would have handled correctly. The host
> > could have sent such a sequence even without the patch reverted, but
> > happens to not be doing that in this particular test.
> 
> Yes.  This somehow reminds of the bug with an Intel SSD that got
> really upset with quickly following writes to different LBAs inside the
> same indirection unit.

Good old https://bugzilla.redhat.com/show_bug.cgi?id=1402533 ...

> But as the new smaller size is nicely aligned
> that seems unlikely.  Maybe the higher number of commands simply overloads
> the buggy firmware?

Maybe the higher size creates different splits that better straddle some
unreported internal boundary we don't know about. This all just points
to some probabilisitic scenario that somehow happens more often with
a lower transfer limit.

The bugzilla reports disabling VWC makes the problem go away. That may
be a timing thing or a caching thing, but suggests a kernel bug is less
likely (yay!?); not easy to tell so far. It's just concerning multiple
vendor devices are reporting a similiar observation, so maybe these are
not even the same root problem.
