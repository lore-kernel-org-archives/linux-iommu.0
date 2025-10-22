Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45A52EE268;
	Wed, 22 Oct 2025 19:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761159708; cv=none; b=a9I1YjEUQn7S66+Y6KAPBT/8nBlTUDIX8GMMYKPSR3JrT5OQ8yILYAIENN3C99wE4LNcHhODSn6RIz6z77EphVu0IERXciNoAtn58HCm5fFu6+/ZNcj4yi78oY5L5HG01YYE6eZHKVvkiyqwbaCt6lnRcrL+XBz1tzpBPEptd34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761159708; c=relaxed/simple;
	bh=63JTUs9ISlbnK/ywl75Qru/f+JAbONgW7SG760Easek=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=INwE961yIkZdU4VylqOIn+UYf8WjQ7db5bxrrcv6Re29WBL5BIXbdCnEngoToSTaz5jOJqVQb4wRGVe2/sDJaS39UfYEKpRhiCkinHJkto5tNJdAcTi/gBXNt7n/dxARjfbyZImJ5DomV/QsIbsBj4s3xdjhzqf995wbd92Ut2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=DLP7eQuc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="DLP7eQuc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69221C4CEE7;
	Wed, 22 Oct 2025 19:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761159708;
	bh=63JTUs9ISlbnK/ywl75Qru/f+JAbONgW7SG760Easek=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DLP7eQuco3iL4+EDDGQaDuup0GPJKZ1mjzs1noT010gML+XFvZmlPNc7QLieETuep
	 RMd7svIb28wljNf91dzLg4ldy4cNp1e/9J09yJyqLdtp3ZIZoH1UGWkvJjYRHgCYG6
	 gLPB83VfK8aUUQBUcWdlUY4ndoUjGeXkiqFLgHNE=
Date: Wed, 22 Oct 2025 12:01:46 -0700
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
 <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>, Vinicius Costa
 Gomes <vinicius.gomes@intel.com>, iommu@lists.linux.dev,
 security@kernel.org, x86@kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/8] Fix stale IOTLB entries for kernel address space
Message-Id: <20251022120146.d683b5f1e2e4ca324a92aa8f@linux-foundation.org>
In-Reply-To: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
References: <20251022082635.2462433-1-baolu.lu@linux.intel.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 16:26:26 +0800 Lu Baolu <baolu.lu@linux.intel.com> wrote:

> This proposes a fix for a security vulnerability related to IOMMU Shared
> Virtual Addressing (SVA). In an SVA context, an IOMMU can cache kernel
> page table entries. When a kernel page table page is freed and
> reallocated for another purpose, the IOMMU might still hold stale,
> incorrect entries. This can be exploited to cause a use-after-free or
> write-after-free condition, potentially leading to privilege escalation
> or data corruption.
> 
> This solution introduces a deferred freeing mechanism for kernel page
> table pages, which provides a safe window to notify the IOMMU to
> invalidate its caches before the page is reused.

Thanks, I'll add this to mm.git for some testing.  I'll suppress the
usual email flood when doing this.

The x86 maintainers may choose to merge this series in which case I
shall drop the mm.git copy.

As presented and merged, the [1/8] (which has cc:stable) won't hit
mainline until the next merge window.  So it won't be offered to
-stable maintainers until that time.  If you believe [1/8] should be
mainlined in the 6.18-rcX timeframe then please let me know and I'll
extract that patch from the series and shall stage it separately,
