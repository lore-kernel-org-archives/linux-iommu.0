Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1159B17C4
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 04:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: by verein.lst.de (Postfix, from userid 2407)
	id DD76567373; Wed, 18 Oct 2023 06:43:33 +0200 (CEST)
Date: Wed, 18 Oct 2023 06:43:33 +0200
From: Christoph Hellwig <hch@lst.de>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc: x86@kernel.org, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, luto@kernel.org,
	peterz@infradead.org, kirill.shutemov@linux.intel.com,
	elena.reshetova@intel.com, isaku.yamahata@intel.com,
	seanjc@google.com, Michael Kelley <mikelley@microsoft.com>,
	thomas.lendacky@amd.com, decui@microsoft.com,
	sathyanarayanan.kuppuswamy@linux.intel.com, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev
Subject: Re: [PATCH 04/10] swiotlb: Use free_decrypted_pages()
Message-ID: <20231018044333.GA15759@lst.de>
References: <20231017202505.340906-1-rick.p.edgecombe@intel.com> <20231017202505.340906-5-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017202505.340906-5-rick.p.edgecombe@intel.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Oct 17, 2023 at 01:24:59PM -0700, Rick Edgecombe wrote:
> On TDX it is possible for the untrusted host to cause
> set_memory_encrypted() or set_memory_decrypted() to fail such that an
> error is returned and the resulting memory is shared. Callers need to take
> care to handle these errors to avoid returning decrypted (shared) memory to
> the page allocator, which could lead to functional or security issues.
> 
> Swiotlb could free decrypted/shared pages if set_memory_decrypted() fails.
> Use the recently added free_decrypted_pages() to avoid this.
> 
> In swiotlb_exit(), check for set_memory_encrypted() errors manually,
> because the pages are not nessarily going to the page allocator.

Whatever recently introduced it didn't make it to my mailbox.  Please
always CC everyone on every patch in a series, everything else is
impossible to review.

