Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691C633F381
	for <iommu@lists.linux.dev>; Thu, 13 Nov 2025 15:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763047592; cv=none; b=db+KvOP0Hir4y6jynuPJt1fYJC4ONhMgCDY29On9V9BAGotwqQDPaG7gCgtNlflrH/xClQd2vWO5WCkrWeQn1kIPqrdV5/7ONHBhNYF2coc24LABBOdrfKcnw+om+XUuxD4k8fU53kC2zhzueS1UmEBJC67/COWKB8t8wgjVyek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763047592; c=relaxed/simple;
	bh=s472zsbluvHBJ6plUrkXJmLD7ld7k9PFgMkG2zSfpIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CJ2WHGb2c49c8VH+zeNGGbZ8riqYRc8tSF6CJTfqEGa548WzQfDBs/1rGtoVt/54pW3x3ass1d2/JTNxSW/Ru3PyS3FsGD0ETYvL5hzKsiEFwOUXs8Q7sMAi8B9jnN0qb7Qn2SN9J8C7PVI57aA4Eu5srBEpgvXTInYSo7RuE98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=Ebvsvxmd; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="Ebvsvxmd"
Received: from 8bytes.org (p549214ac.dip0.t-ipconnect.de [84.146.20.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 4A56B5B346;
	Thu, 13 Nov 2025 16:26:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1763047589;
	bh=s472zsbluvHBJ6plUrkXJmLD7ld7k9PFgMkG2zSfpIQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EbvsvxmdaAUiKIrIJ9Dmgy9iXPmtvW/B8NGzUPWFuvCOmz5V4p7Z1Y0D2VQCRUa+a
	 09CBLDe3xbyzg9C7VTkn/fes2gS9KthfSZE+fjqhqeuUXbm7s2VqYuFIX31uNOqodR
	 u76zNi3L36eR5OMkZ25GsRLikY3Cc7Wuw2l0akxrNvIfnPazZ4i/XLrjIPYFu6W6Bl
	 gXbnFNHsXY1VlYvXyOnxY81AQW04CdNT8gMDZ4vGb+THnTIF4CcgTea5z+nloazEcm
	 ETsUH8q8ICrqQ3v/VpEQ8m2rbTDT26kU2kjPyo6bPH5yV95OrCNF+LIFBjwEDdL/jq
	 GU5QO7nA+csfw==
Date: Thu, 13 Nov 2025 16:26:26 +0100
From: =?utf-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
To: Mostafa Saleh <smostafa@google.com>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, robin.murphy@arm.com, will@kernel.org, jgg@ziepe.ca, 
	praan@google.com
Subject: Re: [PATCH v6 0/4] Move io-pgtable-arm selftest to KUnit
Message-ID: <xop3ddd56mar3nvszw3owayadp6rupsoo7ajjy5y2b2qr2ud5k@cvtdizo3laof>
References: <20251103123355.1769093-1-smostafa@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103123355.1769093-1-smostafa@google.com>

On Mon, Nov 03, 2025 at 12:33:48PM +0000, Mostafa Saleh wrote:
> Mostafa Saleh (4):
>   iommu/io-pgtable-arm: Remove arm_lpae_dump_ops()
>   iommu/io-pgtable-arm: Move selftests to a separate file
>   iommu/io-pgtable-arm-selftests: Modularize the test
>   iommu/io-pgtable-arm-selftests: Use KUnit
> 
>  drivers/iommu/Kconfig                    |  11 +-
>  drivers/iommu/Makefile                   |   1 +
>  drivers/iommu/io-pgtable-arm-selftests.c | 214 +++++++++++++++++++++++
>  drivers/iommu/io-pgtable-arm.c           | 203 ---------------------
>  4 files changed, 221 insertions(+), 208 deletions(-)
>  create mode 100644 drivers/iommu/io-pgtable-arm-selftests.c

Applied, thanks.
