Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F351F208961
	for <iommu@lists.linux.dev>; Sat, 10 Jan 2026 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768038006; cv=none; b=H81bXivB6GWxYC2VK/ixdCMAZ3w50Fb1QV/OVKyBALkmm/GCj1czICVsfSOnblwrZjjhvhfud3jpOJyYZdgPM9diN+dv6SgMYy0o8Fsx4Nab3FWGJMr6SnpQMnM/YxCh/k13lSiO1FHImNaSYNGSqJEc+2vUGWdS4gqfkrJGquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768038006; c=relaxed/simple;
	bh=6fq1TSfZTYokB0lCyMlJiD0EF5/9jcc8RaZfRRbOJME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=elaRFwdNWV2Qp7fAXvqRSxwiP3rcpzyG56iTaDuPAXx2sL2GeZX8wB+34jkPr7UGfz2V/PgMEscR+CD8W79YxTeGdmKTRgAmOCmnhNXej9Yjg2B9p9sL+KpRs+SVZ0oO5Z4MjrZHU/hjf/aHesH0vHdFmslqf2/qPaWvcGe2GD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=jr3gzTJ7; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="jr3gzTJ7"
Received: from 8bytes.org (p200300f6af1d9600dfc71246d978d903.dip0.t-ipconnect.de [IPv6:2003:f6:af1d:9600:dfc7:1246:d978:d903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 76A845EC7D;
	Sat, 10 Jan 2026 10:40:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1768038003;
	bh=6fq1TSfZTYokB0lCyMlJiD0EF5/9jcc8RaZfRRbOJME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jr3gzTJ7NPfbEer7QD/gbJ8Wpne79ma+ck874HxTxWiE5dqwPnucByBew6DBp2PC7
	 wKwK/ZtI7VQkgWPgtYsL/HhjwMA8m/PeN4qVUk0Qudhbz190e+QUap79pwrmg/j/EN
	 I0p/eDPvD9TH1DugOAZm4WDA33/JXfyB+PHR6br1UkqeckOz2Bo4NcsBCblcXns1EB
	 EwpRmtbvPKTMGP1jWw/T/wlhSaHhkVI3YFzZER6ITNZICgsFJ/vLoQv980OeRoieCO
	 XSXhxNBuCy6tbJPdkfwp8byNQRqSKVI+crOuwykmgCVBq0aPJ5qlGU4Sx533zOAEVk
	 alcNWWzbfJdrw==
Date: Sat, 10 Jan 2026 10:40:02 +0100
From: Joerg Roedel <joro@8bytes.org>
To: Carlos Llamas <cmllamas@google.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Kevin Tian <kevin.tian@intel.com>, 
	Vasant Hegde <vasant.hegde@amd.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	"open list:IOMMU SUBSYSTEM" <iommu@lists.linux.dev>
Subject: Re: [PATCH] iommu/sva: include mmu_notifier.h header
Message-ID: <a45wt3ivpwvkyarq2z7nc2fz7grqscmyrd2rzbzkkamhzpij7f@ohcswnkkqrea>
References: <20260105190747.625082-1-cmllamas@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105190747.625082-1-cmllamas@google.com>

On Mon, Jan 05, 2026 at 07:07:46PM +0000, Carlos Llamas wrote:
> A call to mmu_notifier_arch_invalidate_secondary_tlbs() was introduced
> in commit e37d5a2d60a3 ("iommu/sva: invalidate stale IOTLB entries for
> kernel address space") but without explicitly adding its corresponding
> header file <linux/mmu_notifier.h>. This was evidenced while trying to
> enable compile testing support for IOMMU_SVA:
> 
>    config IOMMU_SVA
>           select IOMMU_MM_DATA
>   -       bool
>   +       bool "Shared Virtual Addressing" if COMPILE_TEST

This patch should be part of a patch-set which does the above. As-is, this does
not qualify as a fix or a standalone change.

-Joerg
