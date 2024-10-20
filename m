Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6BC8BEA;
	Sun, 20 Oct 2024 04:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729398434; cv=none; b=adI1mgpSp6U5T1qgbj+r4evVH7TmRkZ44DHKx7zAaxB+KqYmzSccMG8ixUEKXQl45V7Y2hvGeYBZkoPdq1PAlNITf477mlbEJvpaOy1ZM1viqHMVZxloNmZ3dgruMbjsiDyLvEQaK5oJNjoVp5nuj2YoxpZYLeJiPtOVhm7sh1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729398434; c=relaxed/simple;
	bh=R7afB7kZheRAQV+IWrBAI07VyGBl9Ftr9eBlYQHVTME=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=J09B6HFGuxHoQlKHWMefIwCSVoFWQ6QrFcZzoBbjUXwDl82a65z0RI2Wf9cg3KMVD9PyYOUrX5wtq/5LhcySnqFw5Gw5H9UyFs2EKxYJS1IJrzq9kDLK8OfG60VC8nIJDa52RUXpdsHEvoKrAXKnal97/a7jvcjXF8cCDbiBDiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=opRycYCQ; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="opRycYCQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rp4NjvAKWUSmea0H5FdYDF5WWKuL4vnrCRAaXVqXY1Y=; b=opRycYCQDKVapUmnAJXqmT6KLN
	4IspGfbIxNzJcfxTnbPmV9gOl6WVoCM1HtelHa69CiR8P6IVZ2WScZ5qno8J2YzMQqlnUQdxNmElv
	GPTF2gj5iTfiftsBxu4Ba685cMWQwroNAuEirGPqKHW25BwGSEYI9HBg7o3Lr0HUeW6CUkUeHU9NA
	08TwNg6EmshHx44V/ely/piHJxr3E5gVGTB8jRixNZVURjA0vzRFxV7/DP8JKr8eneRKgXyWeVEGd
	EFc8175baAV3V77HbkPww6i/FBGIHtd06DEVs0EqrWke/8nNsoSL08Dl3f84rYSFtIs+Pxp1D76Kc
	MlwfrZWg==;
Received: from 2a02-8389-2341-5b80-466b-0bd2-0363-cfd1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:466b:bd2:363:cfd1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t2NX1-00000004OwU-18Ph;
	Sun, 20 Oct 2024 04:27:07 +0000
Date: Sun, 20 Oct 2024 06:27:04 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.12
Message-ID: <ZxSGmK5gbvmANA9U@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit c964ced7726294d40913f2127c3f185a92cb4a41:

  Merge tag 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma (2024-10-16 13:37:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.12-2024-10-20

for you to fetch changes up to 78b2770c935fc1434a95cc17613fe31165b02dfe:

  dma-mapping: fix tracing dma_alloc/free with vmalloc'd memory (2024-10-17 17:41:29 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.12

Just another small tracing fix from Sean.

----------------------------------------------------------------
Sean Anderson (1):
      dma-mapping: fix tracing dma_alloc/free with vmalloc'd memory

 include/trace/events/dma.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)
