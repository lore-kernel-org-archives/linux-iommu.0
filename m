Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CD422E736F
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 12:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254369; cv=none; b=kMbEOiF6jvlPJhv4YpmPKgsjSR5GhEOjYhLwrY1g6pdA14lSh4KsheiErF3ZNdivGw7Ky4Ty4ECJ9NxnYKZA4DSKXTfjUwR54Gu2ukHKwE8HhMPtHzqr0sdsuxiyL6u7vNexdVKa9h+v3QWy5oHlIk1VceZgbR+G/r+kwr6wyAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254369; c=relaxed/simple;
	bh=nEAgWl8CnNrhZ8oAkdEcKHVJtleKvq6lmyvIKfjrStk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=StCaxdHtRx0EUmc1PWDfrBZD1+nOlYenGCcbdrgD+k8SoP4JJhbTmoWmH3/jJAuHgWPyqR8rCJmcmW8Cs0Yh+XGOwWLUc0GW5Lf8obw3dt2eMNnp0wKMmUms9qSBxW/QQ7wEJNshMFukHhRH4BQ6qaHOQjlYcKg8/bHLwDyrZSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Received: from 8bytes.org (p200300f6af404a00e4ccc4fdbbd66590.dip0.t-ipconnect.de [IPv6:2003:f6:af40:4a00:e4cc:c4fd:bbd6:6590])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id C66711C7465;
	Thu, 24 Sep 2026 14:52:46 +0200 (CEST)
Date: Thu, 24 Sep 2026 14:52:45 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com, will@kernel.org, 
	robin.murphy@arm.com, iommu@lists.linux.dev, liam@infradead.org, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, ashok.raj@oss.qualcomm.com, jgg@ziepe.ca, 
	kyle@mcmartin.ca
Subject: Re: [PATCH v5 0/3] iommu/iova: convert from rbtree to maple tree
Message-ID: <arUZwesREX05SZ0J@8bytes.org>
References: <20260818152505.1057922-1-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818152505.1057922-1-riel@surriel.com>

Hi Rik,

On Tue, Aug 18, 2026 at 11:25:00AM -0400, Rik van Riel wrote:
> Occasionally production workloads at Meta run into the linear search in
> alloc_iova() in ways that cause real issues. For example, when enough
> CPUs at a time fall into the linear search trap, systems have been known
> to get stuck for so long that it causes soft lockups.
> 
> This series indexes the iova ranges in a maple tree instead. Its gap
> search makes alloc_iova() O(log n).

Thanks for working on this, I really love the idea and more efficient
allocation complexity. For long-term maintainability a few things need to be
sorted out, though.

First, I will ask AMDs IOMMU driver team to do some performance and regression
tests with this series.

> struct iova loses its rb_node and shrinks from 40 to 16 bytes.
> The maple tree keeps its nodes outside the entries, so total memory
> use ends up about the same as before.
> 
> Patch 2 handles the one thing the maple tree does that an rbtree does
> not: erasing an entry can result in the need to rebalance a tree, and
> allocation of maple tree nodes.
> 
> iovas are freed from atomic context, and GFP_ATOMIC allocations mean
> the erase can fail. When it does, the entry is marked IOVA_DEFERRED
> in place and the struct iova is freed. The marker keeps the range
> reserved until iova_drain_deferred() retries the erase.
> 
> Ashok Raj asked on v4 whether the marker store can fail in turn, since
> the WARN_ON_ONCE there reads like error handling for a case the comment
> claims cannot happen.
> 
> Code examination shows that, with the current maple tree code, the
> IOVA_DEFERRED maple tree store will never result in an allocation,
> and cannot fail. This series adds a test case which allows us to verify
> that maple tree property continues to be true.
> 
> Only a corrupted tree, one no longer holding the iova at its own range,
> can reach a store type that allocates. The WARN_ON_ONCE is more of an
> assertion than a recovery path.

This is a lot for the interface contract between the IOVA code and the Maple
tree. We need a way to test and enforce that the maple tree implementation
adheres to the requirements of the IOMMU code going forward. You mention that
there is a test included, not sure if it covers all expectations this code has
(especially when the expectations are different from the ones in core MM code).

The last thing we want is regressions in one of the IOMMU-layers core
componentents because of changes to core MM code.


-Joerg
