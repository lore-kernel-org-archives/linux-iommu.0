Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D3215A848;
	Wed, 24 Jul 2024 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721831980; cv=none; b=Eo0h5diTsZPEBwQjNjGej4TF1CPTIFzV1BpgutvnOzycuvEmYqjHhjnka3TTny8hJRZYq+m1gA6QidI8Su3iZw2ewX9pAnjhwlsfiA6NPcXIVUo57mI0HkVga52QfEEpIcuIA2GKmuUPUvunVtfolQlfTGIH9vg7uXYB0TFodLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721831980; c=relaxed/simple;
	bh=sB7n+OYA8gXRqGolP7XN3wEU1u4762TubIlbKHjg/RU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IU9B/va5yitJgZ8vG7OcXCdV/6gPLxuhkK0zz2+OpuTynT7j9sLnfdt8os6tdpgKJLYcJhx3j8nLdOepdTPWrju5JkuzBmWpprLrK0t3F9rC8zAY3G1OqMbYfpJPA11sr4w1GSILR4tEWFHSORW382MMY/Q6a0htT4j/Df2ZjpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=17LH/IIG; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="17LH/IIG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=owA2S7JBvzLMDpGnTwixETsIBLU39zqh5W94gNMkyw0=; b=17LH/IIGtrm9gSVXGhPQi1a0en
	lkkhLi5NWhCWafQLCOReyOGW0GQF1oJ/07gfKKrvRZLAgecDGK24pN+14J436Bz95EFvqDlfUmWek
	Qy5GAX5gCqKOylQDmsxZCuzGmiVvDCYyhWnZfmlp0kmp1yfS3UV17JifEMGv5goUJmhZZuOTQW7Lw
	MMB/Sk3uPvnRqKQBUMz4ABDohjGyJ0OKv6mGiJU6mk3ZlNM1hxDmuOKQ64n9iv8aC1mj14h7sEfi+
	oySICLrq7enANv2PBWzI+4fhKYM+KVLFPDycwVY8HWJ7t/EpcnGJj7+9p1bxXzAI05hqY0ejINm5O
	AlklYg7Q==;
Received: from [64.141.80.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sWd9U-0000000Fd2j-0BGz;
	Wed, 24 Jul 2024 14:39:36 +0000
Date: Wed, 24 Jul 2024 07:39:35 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.11
Message-ID: <ZqESJ3kPSvh3mG3G@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit b69bdba5a37eb6224039e9572e0e98fc3a931fee:

  swiotlb: fix kernel-doc description for swiotlb_del_transient (2024-07-13 07:36:10 +0200)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-07-24

for you to fetch changes up to 28e8b7406d3a1f5329a03aa25a43aa28e087cb20:

  dma: fix call order in dmam_free_coherent (2024-07-19 07:27:28 +0200)

----------------------------------------------------------------
dma-mapping fix for Linux 6.11

 - fix the order of actions in dmam_free_coherent (Lance Richardson)

----------------------------------------------------------------
Lance Richardson (1):
      dma: fix call order in dmam_free_coherent

 kernel/dma/mapping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
