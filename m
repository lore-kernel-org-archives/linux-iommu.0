Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8657D5FB95;
	Sat, 18 Jan 2025 01:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737162233; cv=none; b=h/m6JKlMCSNT17aYTu47+AWtw/hykDHb3UnT5YWmnWwD5O3NsUSdQwZm+gv29gxzjkDiDncFZOtguZO+osz+GFseA5l2TuX/GZnhTr8dHc8wc2mJC59BP6ePmiaO8n6PnIC3zOqCWbcELT+ReHBoLN0kBR2aPxFqgyZIelZjWRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737162233; c=relaxed/simple;
	bh=zWGX9MPXZ+eT05lfY+zSlGG4+MCjUc0nj6r4y/eop1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cjVAINC6QwmV/grl/CaiEQKSoYKT3XvzmsXro65bdKri3AWytTxFM6TA2ECVWwr0isp6lVFoL8cpMCYINJkT3phG+4JwkJ2HJJBH71uCgRYesz8YoF2YG/KTbDiTnsrCxt+fYn2jQCbboUP3Jj49HjxyEb6S40zrpF6ttoQzQps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A5A4JJ00; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A5A4JJ00"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282DFC4CEDD;
	Sat, 18 Jan 2025 01:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737162233;
	bh=zWGX9MPXZ+eT05lfY+zSlGG4+MCjUc0nj6r4y/eop1A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A5A4JJ00iRZwlrZHeRlT3YXeDYbUT5aWmbI/gl9MDBODe1bLqnN+ECj4FL6sQn00c
	 jbHpLSc/jefQmu2tDc3csjz2pywdk62sw7GvELSpSY1VuBKDpdHyBz+1INclZg1ZAU
	 mc557uV7XrpR+h3KI3HWhV+d8wjx6Ry2tVHjLKrYGIZkgEgf8j+VcMqisxefQRUzbd
	 8tzSXvB0ppbxIYpp6WwqwgMvNgQwJ+xL/VnyZHABvNP/ubYmFzvsHj9Ng6OgBTaqYi
	 nUofy4HSWgjY8booxIgSMElCMo8oUrMN7LAYPfEHlm4d/URbIbFn+KfgUHdNT9Ix2N
	 K4Pai9QxTZhAA==
Date: Fri, 17 Jan 2025 18:03:49 -0700
From: Keith Busch <kbusch@kernel.org>
To: Stefan <linux-kernel@simg.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Thorsten Leemhuis <regressions@leemhuis.info>,
	bugzilla-daemon@kernel.org, Bruno Gravato <bgravato@gmail.com>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
Message-ID: <Z4r99SQYV9v5vBuR@kbusch-mbp>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info>
 <Z36UsE5dj6j5HhkX@kbusch-mbp>
 <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <00b01ab3-ec9d-4a35-a593-c9fc764e0f04@simg.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00b01ab3-ec9d-4a35-a593-c9fc764e0f04@simg.de>

On Fri, Jan 17, 2025 at 10:31:55PM +0100, Stefan wrote:
> As already mentioned, my SSD has no DRAM and uses HMB (Host memory
> buffer). 

HMB and volatile write caches are not necessarily intertwined. A device
can have both. Generally speaking, you'd expect the HMB to have SSD
metadata, not user data, where a VWC usually just has user data. The
spec also requires the device maintain data integrity even with an
unexpected sudden loss of access to the HMB, but that isn't the case
with a VWC.

>(It has non-volatile SLC cache.) Disabling volatile write cache
> has no significant effect on read/write performance of large files,

Devices are free to have whatever hierarchy of non-volatile caches they
want without advertising that to the host, but if they're calling those
"volatile" then I think something has been misinterpreted.

> because the HMB size in only 40MB. But things like file deletions may be
> slower.
> 
> AFAIS the corruption occur with both kinds of SSD's, the ones that have
> own DRAM and he ones that use HMB.

Yeah, that was the point of the experiment. If corruption happens when
it's off, then that helps rule out host buffer size/alignment (which is
where this bz started) as a triggering condition. Disabling VWC is not a
"fix", it's just a debug data point. If corruption goes away with it
off, though, then we can't really conclude anything for this issue.
