Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA93B197
	for <iommu@lists.linux.dev>; Fri, 24 Feb 2023 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/rWlsTTsqwQRBH1/dsrlrPiKOJY/AEr+/TWJdGdG9rM=; b=WV54+Xhc8CTfs8oWGtxYegWSsl
	sWZ04PYxAWNBY6BnzM+EIYh3/2nvfW4iYqfXiZG3wuS+UhMRxpqvw0ahZdKtXR/Wkyq+7ZcdjgMY4
	6lKdJSyy3aRy3LFyILuCWoFnLjKJudUE7kg4m2s/fojGyLMppBK8+mR+KF9b9RP7d2yLUJdJZ4Clu
	QkwUZKpFLgw7KEWRe+VL9BMAcgKgA6ACljFH4Y4bD5f9bOhg0xI0nkqWr39ZcOSb7hszFGstCkhv1
	Fq0OwTlVg5c+E0ARozgQLN5HL2YhwJAlsbq484gTv9oEOcA+xDWXrNXaCSR8QRV2RhVHLMcYJprPQ
	LAhvWNQA==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pVbiR-003HyC-Ph; Fri, 24 Feb 2023 17:18:39 +0000
Date: Fri, 24 Feb 2023 09:18:39 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Nick Alcock <nick.alcock@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
	Masahiro Yamada <masahiroy@kernel.org>,
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
	Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 21/27] kbuild, dma-mapping: benchmark: remove
 MODULE_LICENSE in non-modules
Message-ID: <Y/jxb+2bZcQ2PuK5@bombadil.infradead.org>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-22-nick.alcock@oracle.com>
 <20230222144856.GA14220@lst.de>
 <Y/acoc6MDKNnrG+g@bombadil.infradead.org>
 <878rgopfdl.fsf@esperi.org.uk>
 <Y/fR0KnxKP2rF3Da@bombadil.infradead.org>
 <87pm9zm9gf.fsf@esperi.org.uk>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pm9zm9gf.fsf@esperi.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Fri, Feb 24, 2023 at 02:20:16PM +0000, Nick Alcock wrote:
> The only problem that I can see with that is that this stops us using
> MODULE_LICENSE for modinfo construction,

Yes, the requirement shifts to having us *write* the module license
from the combination computation of files from SPDX, so although not
present anymore what changes is a new target / goal in ordering which has
us construct that define for the file.

Easier said than done of course.

  Luis
