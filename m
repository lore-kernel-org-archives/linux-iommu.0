Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF43025776;
	Mon, 14 Apr 2025 05:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744610067; cv=none; b=H39MjFug5LA8N/fbe7/BCDdT6sj3zyHsCp5/Z8MG6X8YmQ+gQ/B045Yuc5TSqZ6Jt5uKSlRq81QPIGzbxXX6hm7489gzY1k1JNyhhwvI/+fif1oT76OPJqCHuWT5b6lrYhWtoWcay1qrxwtHEQDitl1UrwExXNM27AuZ+M3629c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744610067; c=relaxed/simple;
	bh=DQstRcboPg7yqdEeblHqWSxT0o6R4l3Bj6xMfme59uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OrFJ7SK8xdDgvHzMc8u/g8MS/YzToA/wLvIZnglUFve+S1wTfkMjY/Z8uEgWliw7TQ6TrzJPmoCiiW9UoPblXD+0oK2O2LYZ4MKZG+4RasS6Vylv/FPF2NLbsTbuR1CHlfTaZU9VLjJ98OaDJ/f+NMUr6FJVTBgBYsnzRb3c/rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=INFRpx36; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="INFRpx36"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wJugVzfkkDA7CScDRJruji7iDQ80Nm9hVpaYI7P+iAM=; b=INFRpx3678AI8vnZNyR3CJ/aoc
	YlmbAuRQ7rDQDsU7rmc93TbE9H2SB1gdt9wGE9L4QjOwdC2rCZbo9oazzV+dfObikl7VIgNjOxBT5
	vLrKGF9kVbS47PtYki5IZj5jnZDLbNspxdOxvmcrqAnAjlT3zM6S2HDW6bNcdvIwfyPEsyu7qaJbG
	RAtFJeFrnpA06eXFti82PzITTymF7rbYn/sa0jOvCtIvzYNOjXpmlAhOgHdSGxswBLNA4ikli0zLf
	DMQfbnpNafo91x1+IgUaNw4pF3baDwpEfwSnKg0kEdM5/mVhiWKQziODrubSltrogLMEkQNrLau9D
	h2djS0Qw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Cly-00000000kEJ-1sU7;
	Mon, 14 Apr 2025 05:54:22 +0000
Date: Sun, 13 Apr 2025 22:54:22 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Balbir Singh <balbirs@nvidia.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Ingo Molnar <mingo@kernel.org>, Kees Cook <kees@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andy Lutomirski <luto@kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [RFC] dma/mapping.c: WARN_ONCE on dma_addressing_limited() being
 true
Message-ID: <Z_yjDsmjjCAMHUrh@infradead.org>
References: <20250412094110.3208838-1-balbirs@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412094110.3208838-1-balbirs@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Sat, Apr 12, 2025 at 07:41:10PM +1000, Balbir Singh wrote:
> In the debug and resolution of an issue involving forced use of bounce
> buffers, 7170130e4c72 ("x86/mm/init: Handle the special case of device
> private pages in add_pages(), to not increase max_pfn and trigger
> dma_addressing_limited() bounce buffers"). It would have been easier
> to debug the issue if dma_addressing_limited() had a warning about a
> device not being able to address all of memory and thus forcing all
> accesses through a bounce buffer. Please see[2].
> 
> A warning would have let the user of the system know that in their
> particular case, use_dma32 is set due to the addressing limitation
> and this would impact performance of the driver in use.
> 
> Implement a WARN_ONCE() to point to the potential use of bounce buffers
> when we hit the condition. When swiotlb is used,
> dma_addressing_limited() is used to determine the size of maximum dma
> buffer size in dma_direct_max_mapping_size(). The warning could be
> triggered in that check as well.

dma_addressing_limited is a perfectly expected condition, and returns
true for many devices and still plenty system configuation.  A kernel
warning with a stacktrace is not acceptable for that.  A simple one-line
dev_info might be ok, but could still be rather spammy on many systems.

