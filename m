Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A183C092;
	Sun, 22 Sep 2024 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727001168; cv=none; b=li1iYxojYPQBL+hqOI5fchi13FXjKO2Y/d+X5+x2JBXxUcSDrZu0rRlnXSb+lxRZizh/8RhYkBxUu/EUOl5/AUbHQqUtoRvjyjwIIQvPJw/oVPoKy8h+/Q4tHxGmKy/jAnVj44lYEuFTzj3hwnbZGbsOv+g8qnVTi/3TzqtHWOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727001168; c=relaxed/simple;
	bh=BhbO5ipZDRxehMltOLlsjNEgp8qOVf114X9DSmKelLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GdlDMrveZRHg0k9QEn2qtnrrVOzIXGlOBaPlkp8zt4a0Cvmj2KW6qNDjtJAUHZnxXwgcBG+/W5YjWGxGh7AaKj2nRPQ8wlOmWWChUjZcc5SYYNBU/K9Uwi696+N99d30NyKJVrDIoQS45uQRvYciXUkT2DeGgwvgNtO1AMiMxNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iU/RolNA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iU/RolNA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1B19C4CEC3;
	Sun, 22 Sep 2024 10:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727001167;
	bh=BhbO5ipZDRxehMltOLlsjNEgp8qOVf114X9DSmKelLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iU/RolNAxYoqIMb4RoEtyr8yk6jQIZRvpP5AIocuduFOCye3foeUix7WuzyjSPuka
	 xsz1CELcbtjgkGFVUoM8XnO2hBWlnmJMhF06cBk8xRDzYMOJz8z3+MufdG3B2ts8Xk
	 U54SqQBmxXF3UxSOdngnOJVdudybdeYg9gtUA+lr0td0B+5mSSUS+TXEF+y0UGpK8E
	 FLuzaSHTl5Ytl5vHN4U+F4swQyoYC25+xB1Nh/KXVn6Qvybzh/u9tlWc1hXZtxRLWc
	 un6WmRrB3MLt3K/4kYXq/NApI9QUuMuqoosOWeEpTeh46C8oLDeqL1M1JsNyFWe+3/
	 CYWdGrYQJn/1Q==
Date: Sun, 22 Sep 2024 13:32:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Xi Ruoyao <xry111@xry111.site>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <20240922103236.GA11337@unreal>
References: <Zu1byUGU832iWBUp@infradead.org>
 <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
 <Zu5VoW1ZkViSOws3@infradead.org>
 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
 <Zu7PW07FmBgs_dpI@infradead.org>
 <38bc765eaba8a646a87ce14e1ff06f28d449fcd5.camel@xry111.site>
 <Zu-kCdMau6127_vM@infradead.org>
 <11368b7c0b7370aea61b3dda73e462fb70f306a7.camel@xry111.site>
 <Zu_FDfHZAVzPv1lq@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zu_FDfHZAVzPv1lq@infradead.org>

On Sun, Sep 22, 2024 at 12:19:41AM -0700, Christoph Hellwig wrote:
> On Sun, Sep 22, 2024 at 02:56:57PM +0800, Xi Ruoyao wrote:
> > With SND disabled, b5c58b2fdc427e7958412ecb2de2804a1f7c1572 boots fine
> > (no oops), but the camera does not work. 
> > f69e342eec008e1bab772d3963c3dd9979293e13 boots fine and the camera works
> > fine.
> > 
> > So the first bad commit is b5c58b2fdc427e7958412ecb2de2804a1f7c1572.
> 
> Thanks a lot for the bisection!


Christoph,

Another chunk that is missing according to this BZ
https://bugzilla.kernel.org/show_bug.cgi?id=219292:

diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
index b839683da0ba..cf3b89e681a3 100644
--- a/kernel/dma/mapping.c
+++ b/kernel/dma/mapping.c
@@ -926,7 +926,7 @@ bool dma_addressing_limited(struct device *dev)
                         dma_get_required_mask(dev))
                return true;

-       if (unlikely(ops))
+       if (unlikely(ops) || use_dma_iommu(dev)
                return false;
        return !dma_direct_all_ram_mapped(dev);
 }

Sorry for such a mess.

Thanks
