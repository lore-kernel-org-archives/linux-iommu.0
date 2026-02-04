Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4D43D4105
	for <iommu@lists.linux.dev>; Wed,  4 Feb 2026 18:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231172; cv=none; b=NnjUX1cZsFU/HdLpC/6si3L1flr7p4TT6LaKs5o3NJKv4fi37MnurQKjRwpfRqzzkY2LU8t7spoI7p1E3NkdCV3+XGah9jSYXzfp2wMBLb3gUH8Q7CKMgN0pABmziRhK6HHzMqy12XAq8Jdgag3JHFjCyDniwGEsy1OlT6j2V1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231172; c=relaxed/simple;
	bh=OyL8fODsYoVU59qCOPkd4DgQIQzu+v6ObYfqbn867xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLTQLAOM4BhZJe1S2kWpyxie37pgJ5PGp0ky9koRFZPFqtOkK4KWMwp6HTWc3s4pa84rsIsSIh0v0L7V/1Ljm0YQCJnAy9t5EMdKTkySDOnd4JphuGRn1ooKAfP1bTl9RCW+ILU7rgh/4V4LKGGyuRy/4ISfrJbIIS61cY2O1OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C45B4339;
	Wed,  4 Feb 2026 10:52:44 -0800 (PST)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BE2D83F778;
	Wed,  4 Feb 2026 10:52:49 -0800 (PST)
Date: Wed, 4 Feb 2026 18:52:47 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>, suzuki.poulose@arm.com,
	steven.price@arm.com
Subject: Re: [PATCH] arm64: swiotlb: =?utf-8?Q?Don?= =?utf-8?B?4oCZdA==?=
 shrink default buffer when bounce is forced
Message-ID: <aYOVf066Fdr9L-nw@arm.com>
References: <20260120070102.182977-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120070102.182977-1-aneesh.kumar@kernel.org>

On Tue, Jan 20, 2026 at 12:31:02PM +0530, Aneesh Kumar K.V (Arm) wrote:
> arm64 reduces the default swiotlb size (for unaligned kmalloc()
> bouncing) when it detects that no swiotlb bouncing is needed.
> 
> If swiotlb bouncing is explicitly forced via the command line
> (swiotlb=force), this heuristic must not apply. Add a swiotlb helper to
> query the forced-bounce state and use it to skip the resize when
> bouncing is forced.

I think the logic you proposed in reply to Robin might work better but
have you actually hit a problem that triggered this patch? Do people
passing swiotlb=force expect a specific size for the buffer?

-- 
Catalin
