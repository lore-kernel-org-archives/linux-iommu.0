Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF672FA20
	for <iommu@lists.linux.dev>; Thu, 20 Jul 2023 16:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0480EC433C7;
	Thu, 20 Jul 2023 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1689872382;
	bh=VQP4is4iOB2/41AHouFlM3A0fVhNC+wCz4HgAMyDQJA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMBoI2XM8Qy1bdgkB4k3gZ/g21ckwokUfTE4m3rYc60ZnJMwhRxAw4E/ku8iXOhdm
	 5cHctZA2oLj/p+se92cTa8MbmUQaSeVtxBtrV/dk47aRPFjGILnGgZU6sgRGDL2jaD
	 ZyZJbtkv8Kse+lZlsju/ncyPaxn554dwqIf7uArc=
Date: Thu, 20 Jul 2023 09:59:41 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Yajun Deng <yajun.deng@linux.dev>, corbet@lwn.net,
 m.szyprowski@samsung.com, robin.murphy@arm.com, paulmck@kernel.org,
 catalin.marinas@arm.com, rdunlap@infradead.org, peterz@infradead.org,
 rostedt@goodmis.org, kim.phillips@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH v3] dma-contiguous: support numa CMA for specified node
Message-Id: <20230720095941.76803bbda5ad0c5103713d0c@linux-foundation.org>
In-Reply-To: <20230720115408.GA13114@lst.de>
References: <20230720082517.GA7057@lst.de>
	<20230712074758.1133272-1-yajun.deng@linux.dev>
	<25942dafbc7f52488a30c807b6322109539442cf@linux.dev>
	<20230720115408.GA13114@lst.de>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jul 2023 13:54:08 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Thu, Jul 20, 2023 at 08:47:37AM +0000, Yajun Deng wrote:
> > It's based on linux-next tree.
> > 
> > This patch should be after my other patch in linux-next tree.
> > a960925a6b23("dma-contiguous: support per-numa CMA for all architectures").
> 
> Where did this land?  dma patches really should be going through
> the DMA tree..

It's in mm-unstable with a note "hch" :)

I'll drop it.
