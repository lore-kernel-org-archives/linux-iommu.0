Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F214A9B
	for <iommu@lists.linux.dev>; Mon, 10 Jul 2023 20:26:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AAD0C433C8;
	Mon, 10 Jul 2023 20:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1689020772;
	bh=Xjx+HnYnS65YQoXatRuMi3xuh6WSWvutNLaaTXSjmko=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBgdqqvtm7sLAyH42SzguqVkleEGLdFy5ZE6qE+rQlIsaIfZSqgRARIqrMtGI51yh
	 qGgvheCjkZYPDKQiZNGvKdjdUbOF1fuoXER7AoVIvZo0BvnDaisoszvYqQsbrbH6Gu
	 c0GfnqKot1svigDw/XN/SGEe48D56tu1Y7DAHcZY=
Date: Mon, 10 Jul 2023 13:26:11 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Yajun Deng <yajun.deng@linux.dev>
Cc: corbet@lwn.net, hch@lst.de, m.szyprowski@samsung.com,
 robin.murphy@arm.com, paulmck@kernel.org, catalin.marinas@arm.com,
 rdunlap@infradead.org, peterz@infradead.org, rostedt@goodmis.org,
 kim.phillips@amd.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev, linux-mm@kvack.org
Subject: Re: [PATCH] dma-contiguous: support numa CMA for specified node
Message-Id: <20230710132611.ccf619f06f3ead06986cb7f4@linux-foundation.org>
In-Reply-To: <20230710074944.3501810-1-yajun.deng@linux.dev>
References: <20230710074944.3501810-1-yajun.deng@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 10 Jul 2023 15:49:44 +0800 Yajun Deng <yajun.deng@linux.dev> wrote:

> The kernel parameter 'cma_pernuma=' only supports reserving the same
> size of CMA area for each node. We need to reserve different sizes of
> CMA area for specified nodes if these devices belong to different nodes.
> 
> Change kernel parameter from 'cma_pernuma=' to 'numa_cma='. If node
> isn't specified, it will reserve CMA area for per-numa node. if the node
> is specified, it will reserve CMA area for the specified node.
> 
> At the same time, print the node id in cma_declare_contiguous_nid() if
> enabled CONFIG_NUMA.

Changing an existing kernel parameter will break existing setups.  It
would be preferable to add a new parameter for this?
