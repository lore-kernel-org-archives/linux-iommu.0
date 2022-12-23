Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AD38476
	for <iommu@lists.linux.dev>; Fri, 23 Dec 2022 14:03:22 +0000 (UTC)
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2240568AA6; Fri, 23 Dec 2022 15:03:13 +0100 (CET)
Date: Fri, 23 Dec 2022 15:03:12 +0100
From: Christoph Hellwig <hch@lst.de>
To: Lorenzo Stoakes <lstoakes@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>, linux-arm-msm@vger.kernel.org,
	linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, iommu@lists.linux.dev
Subject: Re: [PATCH 2/2] vmalloc: reject vmap with VM_FLUSH_RESET_PERMS
Message-ID: <20221223140312.GA26826@lst.de>
References: <20221223092703.61927-1-hch@lst.de> <20221223092703.61927-3-hch@lst.de> <Y6WB2ZGoL7FaFK+f@lucifer>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6WB2ZGoL7FaFK+f@lucifer>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Dec 23, 2022 at 10:24:25AM +0000, Lorenzo Stoakes wrote:
> Might it be worth adding a specific vmap mask that explicitly indicates what
> flags are permissible on vmap()? Then this could become e.g.:-
> 
> 	if (WARN_ON_ONCE(flags & ~VM_VMAP_PERMITTED_MASK))
> 		return NULL;
> 
> And would be self-documenting as to why we are disallowing flags (i.e. they are
> not part of the permitted vmap mask).

That's probably a good idea.  It might need some time to audit
for use of all the flags, though.
