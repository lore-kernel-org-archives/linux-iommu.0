Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ACF7E574;
	Sat, 10 Aug 2024 06:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723271362; cv=none; b=uJkkaAAUluzco/v+pG7zhS0Uo8PnawCa8tor8HWcEApJ2o3b/ET10xcvmSbtIO0y0Hy1eb/3K7UvO3Gq5d+4Y/PrV59C5MGsJdbAqdJAJM4Dy0ugQ9etvKZhbMIIRzHdSfo7AHOGpF33IldNJ+JVbmj3eVHebvBxvJabDQsZz0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723271362; c=relaxed/simple;
	bh=k/5VlWzwVVowwhlqRYhC2v/c3NubWye5YxtUtbW0KLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ya2155vhFQGbFp+j31lm29QpKP/oL/PjA/3NFLK8NCuJVq8zA3P/5U6Nd31FjiK94sWp7xCdmAHYewkVerPL5ohuSKK4WIvIMvIbaNJoP/JanQ4D0wVxGeOPbHnwmRVk5gZUrVJPpEx6DoSVV2Xr7+gUtuGiWwwD2iTvIEZi9Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hhXJSjSx; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hhXJSjSx"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=twKdxJ32BgNeyLtIrT8zoE0CD1rdmGNP99uLtFb/tD0=; b=hhXJSjSxHucrMjs0oDBzDe8Y3d
	Dg0oPyQ+m8N8Xi/57uZMtG/H76Rwse4Rvs8ch8Vbg9g5DXlVVZR0LTgS+d7/TJbKL3bpa2V2ZBUQ4
	GgdWycCmimOpNv2pHYcyjuXRSddPo3LiOL0oiktYM457T37utG9bdVklqNeRA2E/+D4fcv8UmWspT
	4tN+xPZqnN9rl6ZzSeJxUP5WM9uilkwwU95P46nXPS+AwWMhpkZ+TqeV5PZkiqvO4rqMn+IxkOOdA
	3rOM46CJAaKLHXdLqotlkKM09TqLlqgEMewbokGQy11/ySVXBj+Xav5sujyXqnIcKxKT7krUU/46/
	a4aYkjKw==;
Received: from 2a02-8389-2341-5b80-5d7d-cd8b-d335-1928.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5d7d:cd8b:d335:1928] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1scfbJ-0000000DIWx-3VSZ;
	Sat, 10 Aug 2024 06:29:18 +0000
Date: Sat, 10 Aug 2024 08:29:14 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fix for Linux 6.11
Message-ID: <ZrcIusRi8Z1nlJTw@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit 94ede2a3e9135764736221c080ac7c0ad993dc2d:

  profiling: remove stale percpu flip buffer variables (2024-07-29 16:34:17 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.11-2024-08-10

for you to fetch changes up to bd44ca3de49cc1badcff7a96010fa2c64f04868c:

  dma-debug: avoid deadlock between dma debug vs printk and netconsole (2024-08-06 10:29:32 -0700)

----------------------------------------------------------------
dma-mapping fix for Linux 6.11

 - avoid a deadlock with dma-debug and netconsole (Rik van Riel)

----------------------------------------------------------------
Rik van Riel (1):
      dma-debug: avoid deadlock between dma debug vs printk and netconsole

 kernel/dma/debug.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)
