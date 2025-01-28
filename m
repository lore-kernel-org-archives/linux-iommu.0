Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396031A00F2;
	Tue, 28 Jan 2025 12:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738068792; cv=none; b=QKWAZeeZYqQZ6lq5If2AKOgdgSXcaoYuOiKPTYCr/Nq2vxdwVr7/OFLuEv9o9PfyGe3FfBIxHWTlATgteg21a31VLbTQZeMsAskxFd2hejxqi5Rhfu7LBV8XZeLNACz9z6LvBM1HS1K8wE1b2YR3+2lv2DAMI+T6cSyjDe9w/CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738068792; c=relaxed/simple;
	bh=g9esA23aWQXKEvIglr8qJI60omsEZ+FKG+nYdSoTJsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oBmRWivi7NYN4gnpy6/XscspIZxBQ8e2SrbODFE3aeyXCs8qx93fl88xJCJz71abhpOn81bu4bg7b6DPvR/dq/CQh4TUjBjMczzt9ThFAq/Wz2Q77dQG9YwesgcbDsayjP4vYou93+UNT2vM24+s9tjOHbekkkReXBE694G8f6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=JTXSM7EU; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="JTXSM7EU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=rpSdR0uBhRphI/wuWnMmY4Un2x5yTM9tPeGLls7JB94=; b=JTXSM7EUv6uE+eIc
	93cPRwTsic33zKymbWTDw11/Vo3/Io38hVLekPq3vafpO2bBteZG5KNWG8fu/azc9VGwxyoo8+jaY
	yBBDxaBqqJ0gMe8bmnRpxApmVWSJ/of0UVCPdwrRI9tnqlze8qx4kSkX/77x+GaYcqJwgcz4dM6En
	7ZzqmWpZpfuZUef62IqLLc56C3ikY4TwrVjCliw4OxqSuvq51lGonnulxQrgAK3aBk2Ig28TTPk3Q
	RdsJAPG3E3q+ieqr4qPDy1DFYCcleYo6h05tXmnuxodEd7z0W8qmov5i/LZaP0RYAnIc6VMMWnEhM
	cnzjn6t4Q7t2Zb/69Q==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1tcl5N-00CT31-0U;
	Tue, 28 Jan 2025 12:52:57 +0000
Date: Tue, 28 Jan 2025 12:52:57 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Stefan <linux-kernel@simg.de>
Cc: Christoph Hellwig <hch@lst.de>, Thorsten Leemhuis <linux@leemhuis.info>,
	bugzilla-daemon@kernel.org,
	Mario Limonciello <mario.limonciello@amd.com>,
	Bruno Gravato <bgravato@gmail.com>, Keith Busch <kbusch@kernel.org>,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of AsRock
 X600M-STX + Ryzen 8700G
Message-ID: <Z5jTKTfKUeLm4uJT@gallifrey>
References: <20250109082849.GC20724@lst.de>
 <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info>
 <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de>
 <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com>
 <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info>
 <20250117080507.GA25953@lst.de>
 <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info>
 <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
 <20250128074133.GA22435@lst.de>
 <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <379bba80-df0f-44c5-a15e-fd4393c52b8f@simg.de>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 12:50:39 up 265 days, 4 min,  1 user,  load average: 0.01, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Stefan (linux-kernel@simg.de) wrote:
> Hi,
> 
> Am 28.01.25 um 08:41 schrieb Christoph Hellwig:
> > So basically you need a specific board and a specific CPU, and only
> > one M.2 SSD in the two slots to reproduce it?
> 
> more generally, it dependents on which PCIe devices are used. On my PC
> corruptions also disappear if I disable the ethernet controller in the BIOS.
> 
> Furthermore it depends on transaction sizes (that's why older kernels
> work), IOMMU, sometimes on volatile write cache and partially on SSD
> type (which may have something to do with the former things).

Is there any characterisation of the corrupted data; last time I looked at the
bz there wasn't.
I mean, is it reliably any of:
   a) What's the size of the corruption?
          block, cache line, word, bit???
   b) Position?
          e.g. last word in a block or something?
   c) Data?
          pile of zero's/ff's junk/etc?

   d) Is it a missed write, old data, or partially written block?

Dave

> > Puh.  I'm kinda lost on what we could do about this on the Linux
> > side.
> 
> Because it also depends on the CPU series, a firmware or hardware issue
> seems to be more likely than a Linux bug.
> 
> ATM ASRock is still trying to reproduce the issue. (I'm in contact with
> them to. But they have Chinese new year holidays in Taiwan this week.)
> 
> If they can't reproduce it, they have to provide an explanation why the
> issues are seen by so many users.
> 
> Regards Stefan
> 
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/
