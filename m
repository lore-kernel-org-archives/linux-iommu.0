Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF13654
	for <iommu@lists.linux.dev>; Thu,  6 Oct 2022 07:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=qFJULb+WSRPTZkC19zGZkZ8HigzeVEI8kRHkmY9EyoI=; b=GlGxCbuP+yqCHef+u84g4LHpMb
	fWr0WXsPq7gpI5zoCUMFLxoMqPGshllOa/13KQXeU+aGcI8+68NqwyRSITMQSsvUEouvkW3bPEqW7
	GfKQ2k8Ebb5XKGRz7XeFoRtcEgtzuoCTFIi0xzboMYP7jr/pBcYWaj1SytS9GxDaKUkRtnPrPl7XL
	vENLgwhNEFMixJHxe+uKGasSjxyc09oeSNE8Mx09URSTzXYcP0rsvpiTLnRbmmkoiMSEu7ALBUUTH
	mGSptI4IdcDlVChoXSe9tmnn5O7/kdUFD9qDmblhfbG0qa6GrXzHYayG12CitG1DM7SsjdokSk2tR
	IVuWSVhA==;
Received: from [2001:4bb8:180:b914:9f51:af7e:d950:bc8d] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ogLcJ-000UQx-6S; Thu, 06 Oct 2022 07:48:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Russell King <linux@armlinux.org.uk>
Cc: Robin Murphy <robin.murphy@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
Subject: mvebu DMA fix
Date: Thu,  6 Oct 2022 09:48:22 +0200
Message-Id: <20221006074824.521457-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi Russell,

the first patch fixes the regression that overwrites ->dma_coherent after
the mvebu notifier set it, and the second one removes a now unused field
in the arm arch_devdata.

Let me know if you want to take these, or if I should route them through
the dma-mapping tree that introduced this problem.
