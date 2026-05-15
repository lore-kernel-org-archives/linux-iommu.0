Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F290F1F131A
	for <iommu@lists.linux.dev>; Fri, 15 May 2026 05:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778823221; cv=none; b=U19eqyGnSe4wYifxpq+i9IX5W4FSB+xMny326j6sYph5feOIT+IWO4Bra+fR0kEPDBPoXavaPBuqRi7PhwQ2cv0kFk+apftc130cWBIq9FztrN5ZmZ7D5HYrfuhB1TBpur1NXD0W1d7HRMAlM2jwhzaRhiaaEDnD8iXaI6eVykU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778823221; c=relaxed/simple;
	bh=IdE+5QckUKJsOY0SqFgq0B6ndKFhdOzLoIpIy9ewB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rWK2GBEYdGt39vOoo7Utjq2F1/V7mF1bWtUSjnwbptjnNyPRus38fPCEG51l4Xd4NAWj6eqcSmrfZxEvSuvjy/RhKLU7jYeXUMwGp/jn2jpNnwLG4prbKwaZFKetw8vHwLkAdQidwH+oU2a7yoMd0f0vDGe/XTq1V4OywdhD9qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=OXfvDGUC; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="OXfvDGUC"
Received: from 8bytes.org (p4ffe1d30.dip0.t-ipconnect.de [79.254.29.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 141E31C4468;
	Fri, 15 May 2026 07:33:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1778823218;
	bh=IdE+5QckUKJsOY0SqFgq0B6ndKFhdOzLoIpIy9ewB1Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OXfvDGUCpdzhSStQ+5FNvvKVKIb5bfI/tra6RxWRl0Fr2cYISLt/6jKIL/8zFFMUw
	 vWsx/uVSMjivtppJdFHNbmf+jv4wMl9AhP9Qx7u1fu63p/02JLQPWoQqnZSwbLsO1E
	 cq+s6oAEbTMsFV3FwtxlK7Ql6h72snP3f6N0WpBbnRAnIXZBke5ErYsyAkVNjy9Chk
	 doFiCUTBPkwDzwfXcwwrkSfvBt1w/faR29lPievpO6aqHngZX3zZu1nZArv9LmwKoo
	 x6BReTY5Lde7ZIuxqYXMOqAwIp9qSU4+y9gzQ71IMATyL/PSBipmyuCrT18rqYd2qd
	 olhFsvpT6ZoNg==
Date: Fri, 15 May 2026 07:33:37 +0200
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: fangyu.yu@linux.alibaba.com
Cc: will@kernel.org, robin.murphy@arm.com, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, jgg@ziepe.ca, 
	kevin.tian@intel.com, jgg@nvidia.com, nutty.liu@hotmail.com, guoren@kernel.org, 
	kvm@vger.kernel.org, iommu@lists.linux.dev, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iommupt: Fixup build warning by using BIT_ULL() for
 RISCVPT_NC/IO
Message-ID: <yol3yy64tafo77wp25mrvsehceovq5radmt6wdoc4jz5alsoqj@awpnkmdnzxox>
References: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260512144330.91113-1-fangyu.yu@linux.alibaba.com>

On Tue, May 12, 2026 at 10:43:30PM +0800, fangyu.yu@linux.alibaba.com wrote:
> From: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> 
> Fix build warning on 32-bit configurations by using BIT_ULL() for
> RISCVPT_NC and RISCVPT_IO.
> 
> Fixes: 6c21eb174c6c ("iommupt: Encode IOMMU_MMIO/IOMMU_CACHE via RISC-V Svpbmt bits")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202605121350.wZxB51k0-lkp@intel.com/
> Signed-off-by: Fangyu Yu <fangyu.yu@linux.alibaba.com>
> ---
>  drivers/iommu/generic_pt/fmt/riscv.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.
