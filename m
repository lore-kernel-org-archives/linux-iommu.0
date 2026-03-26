Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1361A3C1978;
	Thu, 26 Mar 2026 10:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774521410; cv=none; b=e+byWNrlhS/vZU56izZzgorROuqI8oIOQqrwLajt7L0bhXvEKc3PNcKZK5yNLnk+hTfxWBgjRf0ltE1hcTI+IMktLEhNxjjQHmU3/G9Ff9Q6l8Oe3TdwsIv0DfgRGQLvCOm8rnKaPMxZpP1Tc+8lS9Mest6q5vb5O0k4SYUJjDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774521410; c=relaxed/simple;
	bh=TZUkqyewAh/iW5hTyw7z5DMFSTSOrWPIyD3TwqBeLCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jfhjyGQJMf79ltWNDrh0y/5yqfO1L/2yAnukovXN031cmaPZ0ekRhYnDVx6ZegoRbNCZ/D9we1TZ+htXxS3F0h2oX5fIptLsaNSGxA1ap22U6LIqj8aTvW2qHOigzmRGUzplPkRmH3857PrvIV3Ty5Zh0T7xvIDOeb5W9IPQEDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmXHy1PH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmXHy1PH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84ED9C116C6;
	Thu, 26 Mar 2026 10:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774521410;
	bh=TZUkqyewAh/iW5hTyw7z5DMFSTSOrWPIyD3TwqBeLCY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JmXHy1PHJujpzJrL/ugSi3a0z15TkCvE5q+1YGZJCrB7WiGhNJUScJAX8K6uXGRoe
	 2fL5bFytm1xZVzAOMLX4bnmnZkv6lenEpi33OyEHNtHiixSorD3YVb+zS0ZaaX8nBe
	 mSRC1Cxb9JaqX3S4sjTrCCZ1Qif3o9hYaKYl4FZkfihZsj9r6+DJxHSzYtrAX5EaEA
	 kBJM5mmeiI4a1202X1V7OS9camJefmXU572F1k8+97l3JEfhfYgd3eEm7yStDFPYb+
	 LH7itLoafYOu9cxSwRe2GeBAHRcmCe163/vlqcaYdlOGnDFqfHLki2+dwQY6cNC3ow
	 qGSEQMvt4ttJQ==
Date: Thu, 26 Mar 2026 12:36:44 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dma-debug: ensure mappings are created and released with
 matching attributes
Message-ID: <20260326103644.GT814676@unreal>
References: <CGME20260323202058eucas1p1946c1763123f2ceb493ebef25165f453@eucas1p1.samsung.com>
 <20260323-dma-attrs-debug-v1-1-6275228ca300@nvidia.com>
 <6d0eabf8-06c6-4b87-ac73-e6e4136c0691@samsung.com>
 <20260325175622.GS814676@unreal>
 <f09c9c3e-ae11-440d-b36e-b88fd4645648@samsung.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f09c9c3e-ae11-440d-b36e-b88fd4645648@samsung.com>

On Wed, Mar 25, 2026 at 09:54:59PM +0100, Marek Szyprowski wrote:
> On 25.03.2026 18:56, Leon Romanovsky wrote:
> > On Wed, Mar 25, 2026 at 06:28:41PM +0100, Marek Szyprowski wrote:
> >> On 23.03.2026 21:20, Leon Romanovsky wrote:
> >>> From: Leon Romanovsky <leonro@nvidia.com>
> >>>
> >>>
> >>> The DMA API expects that callers use the same attributes when mapping
> >>> and unmapping. Add tracking to verify this and catch mismatches.
> >>>
> >>>
> >>> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >> Applied to dma-mapping-for-next, thanks!
> > Thanks a lot.
> 
> It looks I've hurries a bit too much. This patch is not yet ready for -next:

Sorry about that. It seems my test machine is a bit too optimized for my
usual workload.

At this point, I'm confident the idea is sound. I'll resend the patch after
the merge window, so we'll have a full cycle to catch and fix drivers that
do not use the same attributes.

Thanks
