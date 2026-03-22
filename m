Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0546175A7B;
	Sun, 22 Mar 2026 22:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774219474; cv=none; b=GICMrQYUg7evgKuQq7hhu/aye55zdZTdDvnueZoNYUgd3Fg5aJy7dvYBxd1tzrP2lWnJgdL1T4E/HClshtAKIodnFdV/xNQ/LzXVwcr8QPvasAU6qC6iSYpEXbWXwZzlSJDsD8tLkLjEaOeBUEDxfguIVvkblbRfO/5wCIbds6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774219474; c=relaxed/simple;
	bh=6hZJNTCd20BU5NgurAZ+cW59ZrrC5upeRvDtAPs/bnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UVDbyUWE1nPYiAdQYVgOExQO4Xvy4C9jsaVTtSqit8KXca4UHeZO6Fo6vK3N7ycbyzwzaOjXiieWdUiRwdSsuq8D/eOKa6CsqEZSeQyJst0WA4eTNp6RERl64QAcvNU/QxAf0FcSZCE/VKaCole4xweqIyjQgIGdT5L++FNlSu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oUGcCIcX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oUGcCIcX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07631C19424;
	Sun, 22 Mar 2026 22:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774219474;
	bh=6hZJNTCd20BU5NgurAZ+cW59ZrrC5upeRvDtAPs/bnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oUGcCIcXbmu9pKFb/XiPZ6L/LpzaBj6DRSPAJOtIMR2p/kth6TsDGk8ci/iynG/86
	 RHOSP0ehYRHEazOvptm9gxp2OnritUAd4HEg+ZSEyRtPUgFfh2H6+bWNcHcoX6cHhX
	 2dsEXvEWY9XCEhYPb+LbZpVUwWcOvoK6w4I97QyGHbfxr1rE1Br0arT2lTuXqpVpWj
	 Y/JnxZ4HjRuYVb1TX1XlMJt6e69X6tmSb54BcmTwHfW9gJLBzarpdarMTSAOJl+A0I
	 olkvTv79301bpP9WYBcHiix+Y/6cXL7AXrh9eo6bXkGkuEDih9Sl4w1pSzc6BnfIGb
	 MAQE19e98XSNQ==
Date: Sun, 22 Mar 2026 17:44:32 -0500
From: Rob Herring <robh@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Saravana Kannan <saravanak@kernel.org>, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, Krzysztof Kozlowski <krzk@kernel.org>,
	Oreoluwa Babatunde <oreoluwa.babatunde@oss.qualcomm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH 0/7] Refactor reserved memory regions handling code
Message-ID: <20260322224432.GA16628-robh@kernel.org>
References: <CGME20260313150809eucas1p169ab0904a217a04e0601e2ef01854c73@eucas1p1.samsung.com>
 <20260313150802.1121442-1-m.szyprowski@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313150802.1121442-1-m.szyprowski@samsung.com>

On Fri, Mar 13, 2026 at 04:07:55PM +0100, Marek Szyprowski wrote:
> Hello,
> 
> The reserved memory regions handling code was reworked to handle
> unlimited so called "static" memory nodes in commit 00c9a452a235 ("of:
> reserved_mem: Add code to dynamically allocate reserved_mem array").
> 
> The side effect of this rework was a set of bugs fixed later by commits
> 0fd17e598333 ("of: reserved_mem: Allow reserved_mem framework detect
> "cma=" kernel param") and 2c223f7239f3 ("of: reserved_mem: Restructure
> call site for dma_contiguous_early_fixup()"). As a result, the code in
> drivers/of/of_reserved_mem.c became a mix of generic code and CMA
> specific fixups.
> 
> In this patchset I try to untangle this spaghetti and perform some code
> cleanup. I hope nothing breaks this time.

This all looks good to me. Can you respin and fixup the issues.

Rob
