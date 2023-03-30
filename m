Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58702944A
	for <iommu@lists.linux.dev>; Thu, 30 Mar 2023 22:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=lTLIbbxbky13nUCsW3l6ilyAtIxc9wDeo61C7fhVk+A=; b=NPbs4KCrjzxCRI1mU8uJBqxU5t
	wHRIFNCmP2ceMR9KpAs3LuIEn1sQlQuq0hJYKr3oLqsu6Z7XzWQuKIgfpPUMdgBU0B8xcwGUYaErL
	v2+ixOgr1+LcU22js9hZrIxTHvheRObZmMF/ciEog4jAlb5pJw9ai5Wej9+CaneIjy5D57YoWo1ug
	aUBAoeV1tEyJIq7a/m7pyqvC00o+JHMB/vjxv1IpuR9D8PNkEJFY4lM9KdzA+POWFV1lkonUgoHlr
	WKN4ISETU9UY4LOW87dm5yyNY66hcts60X/BifWruf+c8ETAFQqiUt8TBrpHjVS7K/l3+xuF4nwTI
	4xwN4M9A==;
Received: from [182.171.77.115] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1pi0zr-005FV0-32;
	Thu, 30 Mar 2023 22:43:56 +0000
Date: Fri, 31 Mar 2023 07:43:52 +0900
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev
Subject: [GIT PULL] dma-mapping fixes for Linux 6.3
Message-ID: <ZCYQqGH+kCQLDLa0@infradead.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

The following changes since commit eeac8ede17557680855031c6f305ece2378af326:

  Linux 6.3-rc2 (2023-03-12 16:36:44 -0700)

are available in the Git repository at:

  git://git.infradead.org/users/hch/dma-mapping.git tags/dma-mapping-6.3-2023-03-31

for you to fetch changes up to 0eee5ae1025699ea93d44fdb6ef2365505082103:

  swiotlb: fix slot alignment checks (2023-03-22 09:03:17 +0100)

----------------------------------------------------------------
dma-mapping fixes for Linux 6.3

 - fix for swiotlb deadlock due to wrong alignment checks (GuoRui.Yu,
   Petr Tesarik)

----------------------------------------------------------------
GuoRui.Yu (1):
      swiotlb: fix the deadlock in swiotlb_do_find_slots

Petr Tesarik (2):
      swiotlb: use wrap_area_index() instead of open-coding it
      swiotlb: fix slot alignment checks

 kernel/dma/swiotlb.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)
