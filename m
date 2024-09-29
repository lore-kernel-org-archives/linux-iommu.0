Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDEF45C0B;
	Sun, 29 Sep 2024 06:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727590297; cv=none; b=pPtz1twK5FsP1Wv4Oh54DAGdVgkX8vlHfonF6xISweysVDe4ky9RrfCelGhRyhar5KOIEEfQh298/LpmmuC9XMuo4RBQAbDvTzLMaWyno8r1n91nyFmM2yZeHm8YV5vjyMnlqSoqTGTRqwatxzTGJc7t+KwQr7f0Gb8YqJEWssw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727590297; c=relaxed/simple;
	bh=Vqgnc+YtHtMndXB6U7oRfFpRqTHg49ZzmGVeR9qtLHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=urtLqCXOYjbdoFNpE4XX8R9vmhpYnygKxRPvdq3MQ7KTbPIiCjH6Ie7pzKLyKYo74IjoBhFyimaEd4sCmpEba0cB9Eoi6/g9sQYSVXHSBP73MxNGSxsWX36iElurasetzDCEB0i3mArbkAqezCt2FBj64XR2poasdf/HAQaUwKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mets9J7E; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mets9J7E"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=4+phOqV6atYOpBMLYLq6uiyyk+GbvRj3BC/6NaL3TEw=; b=mets9J7Eos2arY46ekbS26aEdm
	iJHlSz9ejRXhajsgbLsgmaihIoBgNviQz01Qfam0jjOY00kflFtbBHBEjzDFZXJmFWmRY99iRhCIk
	93fZO/i8ukdxfIZ+TfebBnZHLMA66ppRV1x1kpvPH+gfxKqo+kUMzSt5WclzQwuGlOU9Cbmqqm5Ms
	kYbFbQnoJyaOv5gKi9nXFmTaovho41IpG3fLN3jDm9SetIEEpW7TcvReM9arUwOF1ilEQuz4LK1vW
	MGg1Yn6V55sL+r5daypWUuJlr47X7op4IAzdTRynX7OArO83qG7GCJ8G+qKWclrIEHw6BJOaYb2JI
	1CHRVcig==;
Received: from 2a02-8389-2341-5b80-d0f8-a0ce-5717-ce1d.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d0f8:a0ce:5717:ce1d] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1sun9W-0000000EFjR-0Ko3;
	Sun, 29 Sep 2024 06:11:30 +0000
Date: Sun, 29 Sep 2024 08:11:25 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.12
Message-ID: <ZvjvjcC9VhDkb9Rf@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit b348b6d17fd1d5d89b86db602f02bea54a754bd8:

  dma-mapping: report unlimited DMA addressing in IOMMU DMA path (2024-09-23 08:38:56 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-09-29

for you to fetch changes up to bfc4a245a794841cba5cf287034a0f60d3087402:

  dma-mapping: fix DMA API tracing for chained scatterlists (2024-09-26 20:08:12 +0200)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.12

 - handle chained SGLs in the new tracing code (Christoph Hellwig)

----------------------------------------------------------------
Christoph Hellwig (1):
      dma-mapping: fix DMA API tracing for chained scatterlists

 include/trace/events/dma.h | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)
