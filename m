Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ABA7A59;
	Tue, 28 Jan 2025 07:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738050101; cv=none; b=aK/f6Y30YmI/WL6xKPLiKWvdb/7KLfIQ/ZZV5TDW38ZLnXWNaV1IoAJ4ih7N2reTrOm06dFDtitaR5uehymIjLpzfWvddVreodxtvWY4iq1DpNg9mvyZIVcjejcYmmtMT+8DQJjUL03C1zh83i6NpJ6GqdYB+EGusCQZj0M9BbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738050101; c=relaxed/simple;
	bh=UiB7ecp4xCLQywwcdANr2iiRrFEL7goW/BSNhrbOqpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSNzyTnbsAi9VUMwRF6gUGMApdoKcpFd2oQtN4i7GA2+2/hjChy6Mq0czZQ1oLt18IDkekadt1xmFWafo5dZxUKz39mTss2LdzHRcnOiVAC2VIkM6Rsn0gtVEpTeYy7QIsUotvpUN/AQfiE91O8gMl4FTYsa47tUCvcQWHrQh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4549968D05; Tue, 28 Jan 2025 08:41:33 +0100 (CET)
Date: Tue, 28 Jan 2025 08:41:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Thorsten Leemhuis <linux@leemhuis.info>
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	Bruno Gravato <bgravato@gmail.com>, Stefan <linux-kernel@simg.de>,
	Keith Busch <kbusch@kernel.org>, bugzilla-daemon@kernel.org,
	Adrian Huang <ahuang12@lenovo.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	linux-nvme@lists.infradead.org, Jens Axboe <axboe@fb.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	LKML <linux-kernel@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: Re: [Bug 219609] File corruptions on SSD in 1st M.2 socket of
 AsRock X600M-STX + Ryzen 8700G
Message-ID: <20250128074133.GA22435@lst.de>
References: <401f2c46-0bc3-4e7f-b549-f868dc1834c5@leemhuis.info> <Z36UsE5dj6j5HhkX@kbusch-mbp> <20250109082849.GC20724@lst.de> <210e7b28-de05-44bc-9604-83a79ae131b0@leemhuis.info> <726275aa-a3c2-4dbd-9055-a14db93efa29@simg.de> <CAOBLbT8103fAyoFNF8=YcEM1sM6HodcUe=Ee5NsE2hUkfCYv7g@mail.gmail.com> <3b693647-5e82-4c39-8017-22cada56eb55@leemhuis.info> <20250117080507.GA25953@lst.de> <f81bb87a-c181-4973-be05-f7df84133a46@leemhuis.info> <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <10e39c88-4667-4c61-b3eb-3dd7ee3074c3@leemhuis.info>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jan 20, 2025 at 03:31:28PM +0100, Thorsten Leemhuis wrote:
> My former colleague Christian Hirsch (not CCed) can reproduce the
> problem reliably. He today switched the CPU to a Ryzen 7 7700 and later
> to some Ryzen 9600X – and with those things worked just fine, e.g. no
> corruptions. But they came back after putting the 8600G back in.

So basically you need a specific board and a specific CPU, and only
one M.2 SSD in the two slots to reproduce it?  Puh.  I'm kinda lost on
what we could do about this on the Linux side.

