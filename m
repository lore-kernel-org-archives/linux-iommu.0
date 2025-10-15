Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E246934BA41;
	Wed, 15 Oct 2025 00:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760489022; cv=none; b=XIrkFmIa261jQCnh+k/kBGa8fyPnk0h/PBC6yEVDU7EDFwcr0JBrMYtv8zcW4Fy/Nnm8upi/CCSll46p+8h3OoNArQ2rF9TD93k9n17/VEVXbHS8s0EaRDh8LWFADUhox/EW6npbXsM43uu0tWZ/6O3zR+1/rQfhqK51lfSn5Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760489022; c=relaxed/simple;
	bh=KlTltCVjzil8zVBXTbYHXZHdEEBKkgd41/qdQ/Dc+Ms=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=G3GI0EOsYWBugA6+DfEISsTRMHAXYIFuXJMaarNyBC22oYSk01MezfD8eVyWjF7uAp2Am2uNyr7ZWgXtSmanLXkWJWETSqBjgIpdu0ZMfCffr+A93mHnP2pNv0dD9FaPEyIIbkdRhhO2MQe7jJn5Fqgww2ohoop31cWlLOBLEKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=v9QnkIUm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="v9QnkIUm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F03C4CEE7;
	Wed, 15 Oct 2025 00:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1760489021;
	bh=KlTltCVjzil8zVBXTbYHXZHdEEBKkgd41/qdQ/Dc+Ms=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=v9QnkIUm4Z6bwO4R7RVxKZnIh4L+AuvydsQgUMCypyYdq/0R1FL+RIIM99oNJyAcK
	 6Mz5UDsCYld2vxhsaBOiTiIFgLsE426IcH1omBVfvpHcRoz04HtnsJmgdMsefK11w5
	 F1D0Ln/JMyOu5c0utKnsEIauL5D5p5udyEj+lvQE=
Date: Tue, 14 Oct 2025 17:43:39 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, Robin
 Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>, Jason
 Gunthorpe <jgg@nvidia.com>, Jann Horn <jannh@google.com>, Vasant Hegde
 <vasant.hegde@amd.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@intel.com>, Alistair Popple <apopple@nvidia.com>, Peter
 Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Andy Lutomirski
 <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>, David Hildenbrand
 <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>, Michal Hocko
 <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
Message-Id: <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
In-Reply-To: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 21:04:30 +0800 Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This proposes a fix for a security vulnerability related to IOMMU Shared
> Virtual Addressing (SVA). In an SVA context, an IOMMU can cache kernel
> page table entries. When a kernel page table page is freed and
> reallocated for another purpose, the IOMMU might still hold stale,
> incorrect entries. This can be exploited to cause a use-after-free or
> write-after-free condition, potentially leading to privilege escalation
> or data corruption.

Is only x86 affected?

> This solution introduces a deferred freeing mechanism for kernel page
> table pages, which provides a safe window to notify the IOMMU to
> invalidate its caches before the page is reused.

Thanks for working on this.

Can we expect any performance impact from this?  Have any measurements
been performed?

Only [7/7] has a cc:stable, even though that patch is not at all
backportable.  Please give some thought and suggestions regarding
whether you think we should backport this into earlier kernels.

If "yes" then the size and scope of the series looks problematic.  Is
it possible to put together something simple and expedient just to plug
the hole in older kernels?

>  arch/x86/Kconfig              |  1 +
>  mm/Kconfig                    |  3 ++
>  include/asm-generic/pgalloc.h | 18 +++++++++
>  include/linux/iommu.h         |  4 ++
>  include/linux/mm.h            | 71 ++++++++++++++++++++++++++++++++---
>  arch/x86/mm/init_64.c         |  2 +-
>  arch/x86/mm/pat/set_memory.c  |  2 +-
>  arch/x86/mm/pgtable.c         | 12 +++---
>  drivers/iommu/iommu-sva.c     | 29 +++++++++++++-
>  mm/pgtable-generic.c          | 39 +++++++++++++++++++
>  10 files changed, 167 insertions(+), 14 deletions(-)

It isn't obvious which tree should carry this.  Were you thinking the
x86 tree?
