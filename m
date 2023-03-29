Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57562C2C0
	for <iommu@lists.linux.dev>; Wed, 29 Mar 2023 23:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=oyV0m3hpkmf/Omm6/ygnd+OzLKd+xn/T/2Yt4qkeb2k=; b=ut3ZlDnM9Hqib8b5Mnhg6DPxVR
	rjn8vcgXe5a0tG7JKoL9mXfvZCmeGwjNbW4L+8TkhU93oF65YHQ+w9o81Kp9AcfZ2Apb6yE0Z2O6o
	dzm0hLjC/dGvFXrXQv+G2h5fWhzQ1OVd/5jvxPQ02Pp//34vEAQ5tZ7F96wgyhJXOQrLcyX/Ire3x
	cr1CXYZct8x4ArTXQBcqitMME3vF/FjuYqPFMRhbgS0TPmfAx1D9RJSgXXIV2U9Jhel6woa/WNkGt
	ydC4Mkqsk3QxqgZqP0BZf7Iw6Hge5ZpNptkKcLSDA6InfbUHpJkT+qAY8OvKwyYvb8WT49jmGc2kh
	+Drr07Ig==;
Received: from [182.171.77.115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1phfYl-0026AV-0g;
	Wed, 29 Mar 2023 23:50:31 +0000
Date: Thu, 30 Mar 2023 08:50:28 +0900
From: Christoph Hellwig <hch@infradead.org>
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Desnes Nunes <desnesn@redhat.com>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
	noreply@ellerman.id.au, Arnd Bergmann <arnd@kernel.org>
Subject: Re: [PATCH -next] dma-debug: Use %pa to format phys_addr_t
Message-ID: <ZCTOxOGDPoJoZDNW@infradead.org>
References: <20230329071405.1568021-1-geert+renesas@glider.be>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329071405.1568021-1-geert+renesas@glider.be>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

I've applied this as it is the first fix I got into my mailbox for it.

Arnd sent one a little later, which uses %pap instead of %pa, which
confused me a bit.  The documentation seems to allow both without
any recommendation which one to use, which confuses me even further.
