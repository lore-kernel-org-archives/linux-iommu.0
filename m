Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3911B16631C
	for <iommu@lists.linux.dev>; Mon, 25 Nov 2024 07:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732521559; cv=none; b=CJ7hMsxXzk1S5Bf9+pT04NUTtsCySIU26a3Rz5b1zzcXT/4coIyUfUKhJv9MicGKkJTALlE41p4T6Nok+gVlqU8R0BMfyq9qnHf/6d4TKa3dHhSI8l+hJAHOrVctqN9UDDWujHOGX0iC8hrwOpy4LbTRYZBFCw8NCzj6Bt6F4hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732521559; c=relaxed/simple;
	bh=5rJUHt6p/pfbaB4JGJQHSeD1oGo6QqO79iCVlnO7ZXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5MrMec9U1vENr8ovGA3pNGH1maoAwmuybiy5VJ5PlTIg4l0qwsXECZkP5e+G7c2ihZXDsKgo+H/apn8+37+7LPWD6yyVuWTzYd7yAERCR3PXHtEwa/GZP2rafMpBuCb0P4xP1AOouotMbZPrWhGHPhkTEKGFIHiUlzCcq8UnVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 27F6768D09; Mon, 25 Nov 2024 08:59:13 +0100 (CET)
Date: Mon, 25 Nov 2024 08:59:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Johannesmeyer <bjohannesmeyer@gmail.com>
Cc: Tianyu Lan <Tianyu.Lan@microsoft.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Raphael Isemann <teemperor@gmail.com>,
	Cristiano Giuffrida <giuffrida@cs.vu.nl>,
	Herbert Bos <h.j.bos@vu.nl>, Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [RFC 1/1] swiotlb: Replace BUG_ON() with graceful error
 handling
Message-ID: <20241125075912.GA16480@lst.de>
References: <20241122191304.4182642-1-bjohannesmeyer@gmail.com> <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122191304.4182642-2-bjohannesmeyer@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Nov 22, 2024 at 08:13:04PM +0100, Brian Johannesmeyer wrote:
> Replace the BUG_ON() assertion in swiotlb_release_slots() with a
> conditional check and return. This change prevents a corrupted tlb_addr
> from causing a kernel panic.

We'll at least want a WARN_ON_ONCE here.  But what is the threat model
here?  The tlb_addr is handed out by swiotlb and should not be modified
by the driver.
