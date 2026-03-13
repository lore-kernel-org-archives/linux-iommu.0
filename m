Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF2A3E0C4F
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430519; cv=none; b=TqlsTJmtDFzirBlAidDgM4+MSF2am4kEDNYYXi3etJ6LtPKD9oTMlp0VNTs8WBpt++etkXCbtAcmgIbebxIj8BgXxCyFg70H6InRL4oqb+m0J0SEtv/npnGarpEoOBvJKN0U48Oh34u4/HhkTGBI1LV3HijJPBgbOcBQYxNLCbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430519; c=relaxed/simple;
	bh=vl6yGQtIFFqkS3HANtV9j7uAw86OM2gFBTE+CJEzuS0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VRdd5Z2erSNBZhU+DRcQokuSy8FTyOArcelv3tO63brDeIU5WfCv2m20YyEDcfr4Ot1OkFVhnksgB7utKX5EzSG/gp4up+BqtGZYPmJ4meVZ9ybQPMmRWWZF+3Yov8+dVwhybdPXk13SLywV7zStUkEURxaj5Jg3b2qFkIbCoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 177FD1758;
	Fri, 13 Mar 2026 12:35:07 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA6993F694;
	Fri, 13 Mar 2026 12:35:10 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:35:08 +0000
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
Subject: Re: [PATCH v3 1/5] arm64: Provide dcache_by_myline_op_nosync helper
Message-ID: <abRm7DPWntjBB7Ji@arm.com>
References: <20260228221125.59863-1-21cnbao@gmail.com>
 <20260228221216.59886-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228221216.59886-1-21cnbao@gmail.com>

On Sun, Mar 01, 2026 at 06:12:16AM +0800, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> dcache_by_myline_op ensures completion of the data cache operations for a
> region, while dcache_by_myline_op_nosync only issues them without waiting.
> This enables deferred synchronization so completion for multiple regions
> can be handled together later.
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
