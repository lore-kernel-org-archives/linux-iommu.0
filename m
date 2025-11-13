Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F9C82F6908
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047360; cv=none; b=srnXKKiGIBiHV8330HQVStFXhqFJ2hqVGeVjN4eNFq8aMO49b8rEDCT8RTq42cfpKjrysYS2+RYEoZSp0TrCkF0Msj98DjVxvWBGyIX2T3loMdaSlHuhUaj1etkSTLqkqso2TUFpjby8+/Q1DilO16Zs8tPCBabyT/2diM0FxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047360; c=relaxed/simple;
	bh=GXUVT5DeTUDwirgImMsBRE1IapdOHh4ftY+jbZ509jc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EFD3alatEfSmImZXG9uh9i4ZFf/HECDP73MawuWcWY02ZwDKOCN86ycFE/Y5FeZTsXxR+fwFZjrhn2Ll/slfZy+1NKfWLtyA7D64EnMHCS3h7zUGWHbUlHmaSYIJcqLTwXRN2y1Wy7mBWFu3R/RO5ZkNnG3MINvwIHszltPXSFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=mVFHUc32; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="mVFHUc32"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 43B9D5AE33;
	Thu, 13 Nov 2025 16:22:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763047357;
	bh=GXUVT5DeTUDwirgImMsBRE1IapdOHh4ftY+jbZ509jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mVFHUc32qYmz2AOOYJ81HTJSqKoMAqN8tszCwc3WyrYjezNQ/u7e62qXkmiZfapHf
	 4DOUEyZu2kcl3bfXm+YoDkAYgfDd2Q1Lzv3VUqpvtKYkjymzgaZtPR5AhncsYeY4A7
	 FfW0D0R0PaloccwbK391s5/zVz9EmPGtMthi2LgyOfLK3nWxS4WuUMT4XPgbPuSevm
	 A8cNM9O6Jjfh9bNPDcTgyFdz7YQFfQEdnTIlA9zlvoWmcAZJr7IfkABSw8k+XXcIVQ
	 DKL70gSgyD71AFgp6ZK5c4fuIP/bCWrho57kl6glqSvELPP23pdfd9bhTD/FApK9Y9
	 HmQgZ2kU5Ex8A==
Date: Thu, 13 Nov 2025 16:22:34 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Jinhui Guo <guojinhui.liam@bytedance.com>
Cc: suravee.suthikulpanit@amd.com, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] iommu/amd: Fix pci_segment memleak in
 alloc_pci_segment()
Message-ID: <yzhwgps5cawvflyg2jtl4x6zlu6bnrfpjy7hbler6v5qbdgit5@s6ijyxynxhx3>
References: <20250928053657.1205-1-guojinhui.liam@bytedance.com>
 <20251027165017.4189-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027165017.4189-1-guojinhui.liam@bytedance.com>

On Tue, Oct 28, 2025 at 12:50:17AM +0800, Jinhui Guo wrote:
> Fix a memory leak of struct amd_iommu_pci_segment in alloc_pci_segment()
> when system memory (or contiguous memory) is insufficient.
> 
> Fixes: 04230c119930 ("iommu/amd: Introduce per PCI segment device table")
> Fixes: eda797a27795 ("iommu/amd: Introduce per PCI segment rlookup table")
> Fixes: 99fc4ac3d297 ("iommu/amd: Introduce per PCI segment alias_table")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>

Applied, thanks.
