Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27AAF3DD507
	for <iommu@lists.linux.dev>; Fri, 13 Mar 2026 19:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773430535; cv=none; b=hk7wCT29N7fMYSlI17m9u3TurcADO9S+XNHR92UXQ8WcRwjtZkU3B2pV5xruae1zj8+xYw3D+3ClJl24N6f9WHXUfzf4yr1pKICmaxFLb/98Vw0W7uCZeOAfOZ1XYeNjpGa4dljAQhIxNgui82Vn1LfM3vQbUGjQ7tkBXPUjb/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773430535; c=relaxed/simple;
	bh=8zCKLE27ZI9HLBciP9qvdAQ3kreiN+/juUMvT5BBn+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TiNZ0jAeno4IeyblyYXcUVsMJCam8VRqBwsChGwxWVqc01CaDTAsz1ob9g6N86CTJaZrLp+/L8+Jg3khJs1QPd4u/jmKwb91bTmxZ0TyB3wn8Rj9cmkAWCTK/Y6k/sDmuzHGFzpKEGBU/LkbUhlqfITI5vNVWWNzX+ksggPYRVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 18B7114BF;
	Fri, 13 Mar 2026 12:35:21 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BD9503F694;
	Fri, 13 Mar 2026 12:35:24 -0700 (PDT)
Date: Fri, 13 Mar 2026 19:35:22 +0000
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
Subject: Re: [PATCH v3 2/5] arm64: Provide dcache_clean_poc_nosync helper
Message-ID: <abRm-nRamCJPvulr@arm.com>
References: <20260228221125.59863-1-21cnbao@gmail.com>
 <20260228221239.59903-1-21cnbao@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260228221239.59903-1-21cnbao@gmail.com>

On Sun, Mar 01, 2026 at 06:12:39AM +0800, Barry Song wrote:
> From: Barry Song <baohua@kernel.org>
> 
> dcache_clean_poc_nosync does not wait for the data cache clean to
> complete. Later, we wait for completion of all scatter-gather entries
> together.
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
