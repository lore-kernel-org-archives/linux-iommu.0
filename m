Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F511A28D;
	Wed, 11 Jun 2025 03:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612409; cv=none; b=qnTb/m8vCCtb5mrkJMBB3OdNYIxuPhOnioORq6VWQ9ZCmKDxY+bidQN/KXO4rBPD287q93qWglxfFGUaGn/3+/8sFnc24EVl0MXOOA88qHWJ+vBJPN2k+VSIKM4pZtpjL9vhcW0CApDX7QTGH2iPqIPtWCyb18AbFnZa07BvVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612409; c=relaxed/simple;
	bh=uYuWesBo4JGBNYOWlZORtJwdtxBUAbDm2zn76MvkOUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSNvF1DDNQ1VOGsEyL37A6Rq6NBk1xuRmILwH4F2XwDWvws0skL1gr+hhbdxPDSDbgz5VhEtNqv3Sm05Psi6zHynLtWRVslfEEZQQX7afOXcYF42+QT6Pb8JPGCrEh05jcarYJbuyg2gJ2L5UJoHA2Wbd+oGZ/4hNh7ydnjZp8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EeC3JQdB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EeC3JQdB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uYuWesBo4JGBNYOWlZORtJwdtxBUAbDm2zn76MvkOUs=; b=EeC3JQdB867FhRc1yLJ36KiOjP
	t9DnSIZ3n2w6vcT1NwHeZrWa6DkwMSTjWWlYfkkvzmvpqP3KYduEdekJRKPOgZ8mZ/val6Smj+DXy
	zinLA7W6QV3gqe4KP4Rq6v10M+tu8kFKQJLUjvgW/SPtFfVJOR2Fm/CjMjWrgRIe4ubkWEwYefglk
	GHrKKzgip/MSM8PTyWMzyEnRGDLzXR8rI0Gg8gb2ERdCYdbNT+lIqX8jEM89l6Ed0FGEIWkWm8NdG
	7l66j3DokAhXupveplizevJf8Xmx7iUKnDHTnbqNqe4hF+O3XtMSVA/a3L4LsP78P2bjbQlxIROBl
	lsZp9ksA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPC6s-00000008jdS-3VDi;
	Wed, 11 Jun 2025 03:26:42 +0000
Date: Tue, 10 Jun 2025 20:26:42 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, iommu@lists.linux.dev
Subject: Re: [RFC][PATCH] iommu/dma: Do not call swiotlb tracepoint when not
 defined
Message-ID: <aEj3cmuigHRMB5H6@infradead.org>
References: <20250610202457.5a599336@gandalf.local.home>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610202457.5a599336@gandalf.local.home>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 08:24:57PM -0400, Steven Rostedt wrote:
> Hopefully someone else can make a proper patch. I will be pushing my work
> to linux-next during this cycle.

Just move the trace point into swiotlb_tbl_map_single.

Note that the current callers can't agree if they want to trace the
physical or dma address, so that'll force standardize that as well.

