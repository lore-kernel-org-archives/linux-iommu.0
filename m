Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC715028C;
	Wed, 26 Mar 2025 23:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743031132; cv=none; b=hP8A5RasCcg/ZuwINYwR8Dv+pZm5U0WmyKCTrdgPcQW4hUu0KDXwBDUQH1+UNp+NJYA7gLIGZCKDYWKG5JMe7kO++3T0G/VKzieK8BEoJPU3kCzQmiwlhy9Z1uH7kdZTCvSjJIYNYJvCvXxTw59tLkDLtygqL6lkGAHax5ze2y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743031132; c=relaxed/simple;
	bh=p5JKqrbWrX8FfGI0rzzltrJ4PF8nvFSKI7H7dsGv5EU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HN3ZcVrWK30okeXvFbg7ei9JVZkPTBNmzeOKFpSIEkL2RQW+1jAIDQheNwbM46TfE37SI99bWzBpDQveDjKvEXX5gZ5/1S30yzskaECDGZulxRb6zNaGVJ/z5isu6/P3um3adBMXzwKRNRoWrblxNu5MN1v3RHe/Vb5VxmB0igM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCMFmHML; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCMFmHML"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D621C4CEE2;
	Wed, 26 Mar 2025 23:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743031131;
	bh=p5JKqrbWrX8FfGI0rzzltrJ4PF8nvFSKI7H7dsGv5EU=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=hCMFmHMLpOpeqHRb4ubgIi3ZQElfMyBgqdTbTKiTZlu9xbQMnH5roeuJHv46HB1X2
	 KyuGXCZSSBMjWtMDJlQfwYZxqepbZ0iGbdcEQag16F2ztX+LrVkHM0hQeCvXFky3zP
	 q05mF2uyOvGuUE07+3CongIB7B66sCDW9NYvnHFM+3eTqDhL100W1gmgZUQ193nzUs
	 AkAXTRbCKhfF4dnN2AhDnDUX9hUU1Flrqfsm/fmAd6tUBDH2PXBNjGxi8uwkRjfAqN
	 oyI/BHW8k39SdcRy1vtTw+j4boJe+oOQzyG7BWX5SQ0yrQS9h4oWwPzeLDx9ReFNT8
	 1KkJm/h14QNWg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 2B33BCE0C2A; Wed, 26 Mar 2025 16:18:51 -0700 (PDT)
Date: Wed, 26 Mar 2025 16:18:51 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev
Subject: [BUG] vmlinux.o: warning: objtool: iommu_dma_sw_msi() falls through
 to next function alloc_io_pgtable_ops()
Message-ID: <5dd1f35e-8ece-43b7-ad6d-86d02d2718f6@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

Building next-20250326 using clang version 19.1.7 (CentOS 19.1.7-1.el9)
gets me the following warning:

vmlinux.o: warning: objtool: iommu_dma_sw_msi() falls through to next function alloc_io_pgtable_ops()

This surprised me for a couple of reasons.  First, from what I
can see, iommu_dma_sw_msi() does not fall through.  Second, it
is in drivers/iommu/dma-iommu.c while alloc_io_pgtable_ops() is in
drivers/iommu/io-pgtable.c, though maybe the compiler and/or linker saw
fit to rearrange these functions' object code.

Please let me know of any debug patches or fixes that I could apply,
or any additional information that you might need.

						Thanx, Paul

Note to self: Run 2025.03.26-14.37.10-remote on first test system.  ;-)

------------------------------------------------------------------------

int iommu_dma_sw_msi(struct iommu_domain *domain, struct msi_desc *desc,
		     phys_addr_t msi_addr)
{
	struct device *dev = msi_desc_to_dev(desc);
	const struct iommu_dma_msi_page *msi_page;

	if (!has_msi_cookie(domain)) {
		msi_desc_set_iommu_msi_iova(desc, 0, 0);
		return 0;
	}

	iommu_group_mutex_assert(dev);
	msi_page = iommu_dma_get_msi_page(dev, msi_addr, domain);
	if (!msi_page)
		return -ENOMEM;

	msi_desc_set_iommu_msi_iova(desc, msi_page->iova,
				    ilog2(cookie_msi_granule(domain)));
	return 0;
}
