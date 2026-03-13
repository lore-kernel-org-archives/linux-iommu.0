Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D173DFC65
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430552; cv=none; b=rhR6BFMUEiAR2VkelUiB0q16Pwetwa0n1QSsmG58qXUK2DFTIAmg/0AFo4UEQFvnuh1AXHmk25NVPpVeSZxO0hjgdLm3pooNV6mu4aOHmIn1Wb3P057gmmQA/FgKzcwKbFL333hGcUNn/1+3dSpsh9lSld85MpjmSE/UcQsUEu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430552; c=relaxed/simple;
	bh=mGDB2/aNMF4NAPsMQOXdDPMtSxxKwkdGGDBa9oypOYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ye+IURyyDwOpSrb5N8qDgshB5JuaBiYC6Eo6/FtipdAEp3i8Gmw4KRnhfq+uFioP/e763JkSF3sb6gbHtE/65t34IhrYz/ZX0NeguzpL9gEZHmxqxWdOuPhdFvoneHvlkZk68aNnNylL1Ait8efqqF7usDwAk7Hlhw9/ztVmN6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D8F7F14BF;
	Fri, 13 Mar 2026 12:35:37 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC8E23F694;
	Fri, 13 Mar 2026 12:35:41 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:35:39 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Barry Song <21cnbao@gmail.com>
Cc: m.szyprowski@samsung.com, robin.murphy@arm.com, will@kernel.org,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, Barry Song <baohua@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Ard Biesheuvel <ardb@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Ryan Roberts <ryan.roberts@arm.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Tangquan Zheng <zhengtangquan@oppo.com>,
	Xueyuan Chen <xueyuan.chen21@gmail.com>
Subject: Re: [PATCH v3 3/5] arm64: Provide dcache_inval_poc_nosync helper
Message-ID: <abRnC8dlwyAdJc2Q@arm.com>
References: <20260228221125.59863-1-21cnbao@gmail.com>
 <20260228221258.59918-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228221258.59918-1-21cnbao@gmail.com>

On Sun, Mar 01, 2026 at 06:12:58AM +0800, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> dcache_inval_poc_nosync does not wait for the data cache invalidation to
> complete. Later, we defer the synchronization so we can wait for all SG
> entries together.
> 
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marek Szyprowski <m.szyprowski@samsung.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Ada Couprie Diaz <ada.coupriediaz@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Ryan Roberts <ryan.roberts@arm.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Tangquan Zheng <zhengtangquan@oppo.com>
> Tested-by: Xueyuan Chen <xueyuan.chen21@gmail.com>
> Signed-off-by: Barry Song <baohua@kernel.org>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
