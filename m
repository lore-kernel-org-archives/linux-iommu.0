Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D203615B13A
	for <iommu@lists.linux.dev>; Tue,  2 Jul 2024 11:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920550; cv=none; b=E1jThogl/naASD1QpNjKZO6mUtPaMT5Gj9yjWTyJwFTMbL/rhSp2j7X8eV1PShX6AIZr6vj2fQgvPS635IfGrL1jel6KDb62AnXBMfan970YnBLYJgfkalPkoc5xB+dA9Rg/BUrv7nHNpnIEvEQGBZrg0VaNsHVJXaA9c/GUxl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920550; c=relaxed/simple;
	bh=CSDp0Kjf9T+YEv4esT9ENtMXUWkulqNayIL24uir92U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AczfICxo5wAq50b8Hnn11PBWSaqOg9Ao6sawFAsZW/kl1DMHPIC7/uDCNQOVYjHptbW1kTQVqIH30nKL4Ib77VB0LOpCciWltfAUTBT4khqSK5kzGIzO7LaaorxUsvLkW3X9mOJlVlmHEaQLYENX+r2wCjB1GS42wFb1rHCromI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=W6dVRP/z; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="W6dVRP/z"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2TLZ2EcauKjsbeam016hdYPz0zR3/sGYiF8w/1BurKY=; b=W6dVRP/zFPi/jGY0p4nIVNK5uU
	l9wq51ERjtpN/SYph8Is+XWQQvXc2zxTnxwpq7ksCF6HkgjQQkfJRq3F3WgHzxqBIXZuHtLosEhc1
	I1LLtwvNMS6Xr8qc3uzYNHwaPjWDT8JmFK1Ys9sK6Z207+CVlYggRZZ8p2xOZy6r4JJG4VV5mD4f0
	H+Yj09D/EFXhDh1+/u6CJn4aiOJudECB532Dng8F3nsia8c4yIZMhOh4kQZZLB6opaj9ksPEp7pFk
	lu0kooCKctrMBGNDrZ/Z5V8SHbNPkIr/iPueDLK2Cwmw74zT7iePkkwdtOxE1BjZRDCEDojTwXW1n
	9cPhnKVQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sObty-00000006Vi5-1Ylw;
	Tue, 02 Jul 2024 11:42:26 +0000
Date: Tue, 2 Jul 2024 04:42:26 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux.dev
Subject: Re: lack of permission checking with intel-iommu?
Message-ID: <ZoPnop_nJGZ2DQTA@infradead.org>
References: <ZoOwc7O5W0PUeja5@infradead.org>
 <ZoO0KxkU_JNO0av4@infradead.org>
 <4d84afa1-e2ce-4e1b-8fe3-1d3fb0db2ba0@linux.intel.com>
 <ZoO5ZeYtA6qLIs21@infradead.org>
 <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d0c9d4b-b233-4ac8-9a46-9da24f1c5536@linux.intel.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jul 02, 2024 at 05:12:32PM +0800, Baolu Lu wrote:
> In this case, Intel IOMMU doesn't block device reading as the first-
> stage page table only grants two types of permissions: Read-only or
> Read-write. Write-only permission is not available.
> 
> Do you have a functional requirement for Write-only permission? If so,
> we can choose the second-stage page table.

No functional need, but it would have found a device bug.
