Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7230A5381E;
	Sat, 21 Sep 2024 13:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726926694; cv=none; b=Q/INNP4QUSST5wUraHkfEJugaVLl3Sm/9HHyE5S/CuoRWZ5/Wfsxp8pbIs8k8OCb0KnUyZ3VpVl3lFrW3vvcfF9ZAEatqazf3kQIju4qiRSWq/iK//KleGWIra2f6csuKpLanuRX7YVNMVC78qv4GYExjGHBy0mBlJ/CL+Ni53s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726926694; c=relaxed/simple;
	bh=uEPHwKOwDwyDpCgNG2Eql15E7gXc08kmI5OWv67JbMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ+KBzSPxBxKqUPC+oLNJAam2zH+JAZCN0fbfvhxXXR/61zhiPa34a4EGbIV86ZcOsLmZL3K2kH2YaBbJDJJgB1sSBClkQWBsIndGmhadGuos1OwvdnGed2eIL02mY8h7uUsxbAYmb1tE3KuFnu/ZlsDonqYWv44o/xBvGp3hm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=VDSvv7Wy; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="VDSvv7Wy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BvAi/YqAza3e3jdL6+tl6Tsbxzn6R4jK+oLVTD1k83M=; b=VDSvv7Wy0jUviHcxSX44GcZL6x
	wb7bLgZekg8xQ0dV47Vh1YAisUoLLTjOS5kVaDKWdGVPNOJQUd9a+AE5z/ZYSGNqs/FG+Y3PaHu9Z
	0mGPuerxnpnaHWJLTRURwt5AKtSI9NDqUmdyr93gyzN9t/F4J3+txqjR+SHF89v+52UP6i7+mw7wN
	VmxH2iudg0nceBoMxUFIGyIbNjKFsTBSNYVl+9uzPl80DpUanQYbqaDsLCKTHeHuSMN/xX7y9CX0m
	0NyiMR25F73GENfOQuOrc1ig8wU/48vN/8Jp+ufDaKTuEiIMGnI1A0wwKaTn6HwrzwLLPDi+ptQhi
	8bquAzYQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1ss0WB-0000000Dlfq-17SY;
	Sat, 21 Sep 2024 13:51:23 +0000
Date: Sat, 21 Sep 2024 06:51:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Xi Ruoyao <xry111@xry111.site>
Cc: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: Re: [GIT PULL] dma-mapping updates for Linux 6.12
Message-ID: <Zu7PW07FmBgs_dpI@infradead.org>
References: <ZuvYnXzbM2qfXQPT@infradead.org>
 <971fbb889da38ca4e60f3dedde29ea43e9338d68.camel@xry111.site>
 <Zu1byUGU832iWBUp@infradead.org>
 <Zu2Bd50GdSxF_-eA@infradead.org>
 <19e4bdbcda78ace200c78c56eb7173097337b921.camel@xry111.site>
 <Zu5VoW1ZkViSOws3@infradead.org>
 <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a84a7c6f943209cc87a54075ed22df37ebda5f8.camel@xry111.site>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Sep 21, 2024 at 03:56:11PM +0800, Xi Ruoyao wrote:
> because the laptop has no serial output.  And the behavior seems not
> deterministic.  I have some transcript of messages I photoed in several
> boot attempts though:

Can you send me the photos of the messages?  Probably best offlist
as the lists don't like attachments.

