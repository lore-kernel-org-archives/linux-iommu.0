Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DE534746A5
	for <iommu@lists.linux.dev>; Wed,  2 Sep 2026 11:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788348170; cv=none; b=XLakuyV7zcgxO9a3L2XLjL6AObBnpHePaZNmZ1mxJDsVsA/aPryyS82Zlk62XavCmkDI4sSak+P7f6p7BXoTBAT4h3lrTgzj4jn0hODJJXYHLJiyGfqOwZszckx6yKuxbHwM9VMO7XNn7ZnYx6+KPJQYtXvAkqE2Nsqm0mLwVB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788348170; c=relaxed/simple;
	bh=hLAeniJJgZxr1vBaB9I/irR39/2wmQpDrTfM6QLVtjw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VfvDGnkAyKCSFqCdKHkFasTnJZEYfpUnK4n+g6AJD69hdUR7PR8FJYGLnowa2d4GJILAtL9q/qklig2cxvPJWGK9UEne14jtDb88AjCTc7weDa/gnmLLpOufLkqOHv0xR8gak+egoDjwK/GzTH6K/joHRtOJtYYUSqeXt1mOBXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XUT8yFQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XUT8yFQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEED1F00A3D;
	Wed,  2 Sep 2026 11:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788348163;
	bh=VI+zTa/H4brk4hljsWHx5rnTWZGudrTivFOtubthDSY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XUT8yFQFIDAXpJNheMQDAc0u9jQeTZYSg6YEzu3bttwqEFwjfRvwneXYGPOPvT3do
	 1AHDF3G8NEShvO5v/yxoQTav/PLUJRBdY/qGxocMEvdFe5dDJeR9keggoBS64Q91Wl
	 N5Kpbazegv+XETjnI5S55SxA6pij6Ye8shiUFa0VgJ9SKHXpdyYeYlK5rHcI9X9WX+
	 TCc4kIk/23CsoMmoQtjuLIMyKa+9djFumuYiKepkDd1PPUgmnTZvSQ8JJOrsqtGYNg
	 Z926LX0rZkRzyFwif0h1ZLRm22R9hD0JPofEKDATAbHh6I2bNhRKOY2xqY5VQTCD/c
	 Puq7EMndNkPGw==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 5622A198003A;
	Wed,  2 Sep 2026 07:22:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 02 Sep 2026 07:22:41 -0400
X-ME-Sender: <xms:_gaYaivawVJwMuL9zUKR0N0wUoDQHsvFMWRhd3fVHlDEVSYpdqRdwQ>
    <xme:_gaYai6Yec-jc2kQ7kNbWqp2eEC8TnOxxQjiNHahL1ufRXnGyZsZ6kj-RbfMg8f8_
    WbH9VuFpYu_UK6mBOboPS0f9UkXNv3kaer1kXaQY7gzR9ZEb9Nm0fU8>
X-ME-Received: <xmr:_gaYasdF2BPNtoAy21DfX8FMRVmh1bFwOSyk-ZKYAt-0SFm8Ob1C1h6h2ag>
X-ME-Proxy-Cause: dmFkZTFz6itMPqahSEtPkdJJ9WVlua6VjGYOXQgtB6H3nUwkTCAeCZ7daCaLn5zON1t/5A
    MwWZ4U0HUxKeDH0x08LvUy2Gpht1F9Gi71lOZ5nSHj0qarS92q8yZpXwg0ERpN7IexVqoQ
    rCXc+94u/RibKKQ9IAsd+X4y4hMuNhJyDmQvT5hKcDPMF120/cUdT4/Tq6AmKcsnk6v++5
    /oMEJEwD2wTfPUps0KMjrJxACRV2mqyYw3yu2TEQqOIdZmcFBbdRWzRh0bZZ8Gg7jrLNBY
    /TrgKqBEcdSeQqKtKM3yTlGC1/LlhFGaVy0VgQb9RdHKxxi/xfP8tbOhqqNspPwC1LnlR4
    RG00hbJbFkJixN0Y1uvZGtWRKNW9GgQv0IUgu6Oj3n7otFGxiy5XG76k+BR8k/O5iTYyF/
    FwpvXpT5pTGZbkjJlNIncDpg8NyX3LveylVcs+7DDs+LjyVgJVc3vR2rX+orXLmT+GbvLo
    UB1XA2t094+SPBpEqpc0W3Veap6B3/IUiWyZ/VzXmA7W6UgTdY78NL3S2pjVQh9yv2zF3w
    y0j/VnrJMFr4g4vKBArfmHHGNrIMnN2ZwIswOcTI1aL8aaWcvaLXiHk3aRV9kK8TY9zKSc
    2Tx3FbzLtX8FSrS4lQBH+Qxvy4hUXNh7dUkgEPSxc9dcoig7jpmfVyTyjLNw
X-ME-Proxy: <xmx:_gaYaqWu3P8bxchyU4iAh9qlll9KgTrepKuTfuum4GUdJ6UuUGsaKA>
    <xmx:_gaYapXmRHSBDfLJpqErgSpOQTwWnhY_mn92ggpAUG_HmjSIG9rO7w>
    <xmx:_gaYarSmOMMgSDvkOfA8PkuNSGYnT6lbGfMqM985o2faUNa_DsYlYQ>
    <xmx:_gaYao1j08e-Eqgp_24jYNAKcMcrnhJ7jNSbbbhUPeLUfzLxa1xscA>
    <xmx:_gaYasIG3WWRsMQITpsJ2YlV5g3ZKL1IU4QAICJOX_RDeg8ll1NKyqXd>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 07:22:38 -0400 (EDT)
Date: Wed, 2 Sep 2026 12:22:36 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, jgg@nvidia.com, joro@8bytes.org, 
	praan@google.com, kevin.tian@intel.com, smostafa@google.com, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	jamien@nvidia.com
Subject: Re: [PATCH v10 04/13] iommu/arm-smmu-v3: Disable the EVTQ and the
 PRIQ in a kdump kernel
Message-ID: <apgG2jvqgd4T58br@thinkstation>
References: <cover.1788130528.git.nicolinc@nvidia.com>
 <861f488cbbfa84a4d222a22615adbe5d2617bc87.1788130528.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <861f488cbbfa84a4d222a22615adbe5d2617bc87.1788130528.git.nicolinc@nvidia.com>

On Sun, Aug 30, 2026 at 04:18:05PM -0700, Nicolin Chen wrote:
> A kdump kernel cannot use either queue. The crashed kernel's CDs and page
> tables might be corrupted, so events would spam the EVTQ, and there is no
> way to serve the page requests that would arrive at the PRIQ.
> 
> The reset routine still enables both of the queues and then masks the two
> enable bits back out, having already programmed the queue bases and taken
> the interrupts of both.
> 
> Clear ARM_SMMU_FEAT_EVTQ and ARM_SMMU_FEAT_PRI in the probe instead, so all
> of the queue handling, i.e. the interrupts, the IRQ_CTRL bits and the CR0
> enables, keeps away from a kdump kernel via the feature tests.
> 
> Both queues also go unallocated now, as the two allocations test the same
> features. Each of them is sized from the maxima that IDR1 advertises, so up
> to 4MB apiece on a 4K-page kernel, which a kdump kernel would otherwise pay
> for every SMMU instance out of a small crashkernel reservation.
> 
> The IOPF workqueue of the event queue stays allocated here, as untangling
> it from the SVA and the stall features takes a pair of changes carried by
> the PRI series. It costs a struct and a workqueue rather than the megabytes
> that the two queues take, so leave it to that series.
> 
> Suggested-by: Kevin Tian <kevin.tian@intel.com>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Suggested-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Suggested-by: Will Deacon <will@kernel.org>
> Link: https://lore.kernel.org/all/amiBagGKn-Aym1DK@willie-the-truck/
> Assisted-by: Claude:claude-opus-5
> Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>

Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
