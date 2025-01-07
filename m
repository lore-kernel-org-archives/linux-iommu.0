Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F259113B58D
	for <iommu@lists.linux.dev>; Tue,  7 Jan 2025 08:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736238761; cv=none; b=PvXHbW9J+rqbFi4IxBConBjFM3vfNM2EWgssuIdjYOni9eTZBQk0KC9+YRGD1jKl3ymgM62n4Bj6vStWBNCCkf39RVEfJmpHFZK8jRSpuduqVTCNnowj8nJKuqkZ2Q73pHluvKY/JWxU2ufrzMuv8aH9TgujOxnihERpOlhz4e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736238761; c=relaxed/simple;
	bh=Ghj9OfMPmJcnSIAc8VA1uUGc/YVEJkgRnkYqAChTPRA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CecslCUI4II2nM0Y9wAmmhw7/xoTK5oZN1IxWy+5i2NDxGSAsfBwYFlhE1vJa/P2gsX2SH9PwUhN4uwnukzTdclXzFmUtP4x+mEmsSmfWjWrN8fe2HHAqWS65sNzmMDzqk+iLcVSSGORvqA8nFMILXdusiLSi1HYjryliof3Cbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=8Gk7gLPH; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="8Gk7gLPH"
Received: from 8bytes.org (p54921e31.dip0.t-ipconnect.de [84.146.30.49])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id A78052E001D;
	Tue,  7 Jan 2025 09:32:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1736238757;
	bh=Ghj9OfMPmJcnSIAc8VA1uUGc/YVEJkgRnkYqAChTPRA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=8Gk7gLPHozVJ1x3OfrMbm6pRoTETlI1lJIAEGGHpj2Pnu6/Rt0qKbunau8X0d1Xwb
	 lbx6LqpLNfExTJyeHSxE45LvF9ogjlecDxehM23xoW3vWielqtYMN7Kx86YCOHTYuy
	 YsqqgIIGs9lkY22skvAfb1Nxoi8i1icK+heY1MpXPlNznHlisvTBp3Hn3m31OHIUFT
	 BQVnC83CINAATdszl4Lfjt98xVGzDmEhHDVSVwOFa1TXMcWxB1xveWYnEK/tjaEqvJ
	 TBxDOYSOfuO4R1N88eMIlIaeKEKsUzgjOd4Yhtfx+xE0jCZYmrW7W7YdXMR4IpPXSC
	 Rb6f8+XUC9xQQ==
Date: Tue, 7 Jan 2025 09:32:36 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Kees Bakker <kees@ijzerbout.nl>,
	Zhenzhong Duan <zhenzhong.duan@intel.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] [PULL REQUEST] Intel IOMMU updates for v6.14
Message-ID: <Z3zmpDToYOoOpYpq@8bytes.org>
References: <20250107021746.6908-1-baolu.lu@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107021746.6908-1-baolu.lu@linux.intel.com>

On Tue, Jan 07, 2025 at 10:17:41AM +0800, Lu Baolu wrote:
> Hi Joerg,
> 
> The following changes have been queued for v6.14-rc1. They are about new
> features and code refactoring, including:
> 
>  - Remove domain_alloc_paging()
>  - Remove capability audit code
>  - Draining PRQ in sva unbind path when FPD bit set
>  - Link cache tags of same iommu unit together
> 
> These patches are based on v6.13-rc6. The complete patches are also
> available at:
> 
> https://github.com/LuBaolu/intel-iommu/commits/vtd-update-for-v6.14
> 
> Please consider them for iommu next.

Applied, thanks.

