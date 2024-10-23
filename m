Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050F3145A17
	for <iommu@lists.linux.dev>; Wed, 23 Oct 2024 05:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729661117; cv=none; b=pn9Y0Hr31/h0FfJo5Nx3iMq/sBqWqZ68W+fah/8vNHddM8WRQOo8mGMa1MPnuwElEwcAFtJ86DeN21rB9C+pBkt8QeOKzacHxA16klJKx/YjlHyW6o0EeaHFryC5mId+CEbVtvgWdZh3yub/x2hvU9BYIlxxhEKuXYHwYhEeleg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729661117; c=relaxed/simple;
	bh=dH7sumfRKLsXwOvw9J/TlCSVbFr48GTZAZtXJM8YlKA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rFjHUB1j5ALmTOmBY1GjdmJxMF77DUJyzQexOoThsc2qS1zp4/lZ+N65bzBBf/nfDFv/VQtcycIbjn99k5H9X52803rH+VK4Hcg6HepD4fUjmDyt6mmxcUpdeRlkh2+tCsq30koHu5U3nBq0VoBAeC9PqjsAXDBtg5NbUupWGms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zu7usg+8; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zu7usg+8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K2euZn4YReHuO0ZACE3rQF7IxTOytDIaoO+QZg522wE=; b=zu7usg+8orFOl0+dSCCDSe2bHr
	4zzBUJreNICZTbFF8xhDvj2ebe4lvm4yznHcea2kdojpfMBuWepehtyMZuaRObKsgmtydJgk0+vlj
	b3lr9dh27gju1IUysUIaF7ukcbVTxUHx0wgBfNoaoh5J/FvJWmVeE+UonKnydhJow6clCYJhcV5q6
	EzgWr3XIvTxscv/8HbQqJCzI9pA1cnqH5uE9H+YoO67hUguL0Ppuj2WI/J34dGhdfi35/8gpVs5tz
	mXcw5mBNlzymb7ymDDGzSr5LL468DvFFZqXk4EOXmkV6LPzrWQ7cy8ygMI5uXpuiVdchurgArSbrW
	8J1ciIGg==;
Received: from 2a02-8389-2341-5b80-8c6c-e123-fc47-94a5.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:8c6c:e123:fc47:94a5] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1t3Tru-0000000D2dI-23yU;
	Wed, 23 Oct 2024 05:25:14 +0000
From: Christoph Hellwig <hch@lst.de>
To: iommu@lists.linux.dev
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>
Subject: dma-debug cleanups
Date: Wed, 23 Oct 2024 07:25:02 +0200
Message-ID: <20241023052511.309695-1-hch@lst.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Hi all,

this series has two little dma-debug cleanups.

Diffstat:
 Kconfig |   17 -------------
 debug.c |   81 ++++++++++++++++++++++------------------------------------------
 2 files changed, 28 insertions(+), 70 deletions(-)
