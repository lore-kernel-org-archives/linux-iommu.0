Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A377C4534A5
	for <iommu@lists.linux.dev>; Fri,  9 Oct 2026 15:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560241; cv=none; b=pMV26wQpPzUJQT00iQSEChi/FN4L499fkFQzOV+g9cMbsSrl+Js241AvGnBuglJ75Nao+2nc5uN+qu5CLF63eYWdxJMh4sx9wHz21r5jJHdPxs6+Md8tCXf93pEJkleHSaIyRmRVirU4MQGuRa5ZlTeK75fnxc9t+vTMcNf74UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560241; c=relaxed/simple;
	bh=kchR3tVkjsk4qWQmvkQz/q7IH2xX7SZwPFm09c1mZGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GcamsoqwSpdeXObFWfHi25oNRKK2Vj8ZwqEpmgEyTkA1dfo/xjcjCGRj+qDn57tTxLYsFoFmjEjPVkEQD0xb/XZ95EhEkbbeUCH7WE9hZHEp1GgABOZHjFEjmYqSoQgPZ9tWBwM4kbwN/NHGdsOLSFaXWtcI3sOpGg6ysqXdElc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ8jwhPt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ8jwhPt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB7E61F000FF;
	Fri,  9 Oct 2026 15:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791560240;
	bh=kLgpLQENCeXHMZ4r/LduUsI/Qb8wWOkpqbiHZFcOMxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VJ8jwhPtr5b0JPDRMAC0FHI1wuMC/MGaiRyKN1N8/ndV1HO6Q6ox8I3kOCbjBTBML
	 keOQ9pfgaIKn6fIOxv66OSyD7YK/CnmLrEKHz39U6MX2ZI757rKIgjRPXDXr1Qygrx
	 o2vbODyY9paPenMBASgTCI6bO1AwvxZv9uP6i32D+EUHhzhYqqeHGEgOKOxc9nP3cM
	 fe8ZKif+f9EolQEU6W+0NBiLB9mRXaIox9U73wnowSa9h3ddYsPWtA+9WJgJ/58Lju
	 6MIRyv9kMa4yqBcCx6dJKhBDPCUdvzcEOoL01wNtKmqxsDxjOTeP8WcUG4lI7ixv/z
	 xrx+WQr9VJcsw==
Date: Fri, 9 Oct 2026 09:37:18 -0600
From: Keith Busch <kbusch@kernel.org>
To: Adrian Huang12 <ahuang12@lenovo.com>
Cc: Christoph Hellwig <hch@lst.de>, John Garry <john.garry@linux.dev>,
	"sagi@grimberg.me" <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Jiwei JW10 Sun <sunjw10@lenovo.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [External] Re: [PATCH] Revert "nvme-pci: clamp max_hw_sectors
 based on DMA optimized limitation"
Message-ID: <askKLgBhLzjaOyfF@kbusch-mbp>
References: <20261006120248.147654-1-hch@lst.de>
 <8cf8a8ea-c9c9-434b-aec6-e361280a88a4@linux.dev>
 <20261008123724.GA22096@lst.de>
 <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TPZP295MB0013C6E51C73799E49B8EFF4B3922@TPZP295MB0013.TWNP295.PROD.OUTLOOK.COM>

On Fri, Oct 09, 2026 at 09:11:56AM +0000, Adrian Huang12 wrote:
> 
> BTW, with this reverted patch, I'm setting up the test environment to
> check whether the issue does not appear with a newer kernel that
> includes the updated IOMMU subsystem. I'll share the results by the
> end of next week.

It does sound like an IOMMU implementation issue if the revert regresses
your testing. Let's say the application wants to write 1MB of data:
we're DMA mapping the same total amount either way, so I don't think it
should have been more efficient for the driver to send eight 128k
mapping requests vs a single 1MB.
