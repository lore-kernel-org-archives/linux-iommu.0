Received: from mail.8bytes.org (mail.8bytes.org [85.214.250.239])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EA0B34F470;
	Fri,  5 Sep 2025 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.250.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757075279; cv=none; b=DD/eqKN7+yZUOn5qr/pTgtYK9jBRGiJ5/jjzv09a3f12lYfAy2Vu/sCgS7KWtEkAysNmypvsN7MMAghmW0qaMWEqJTmVhaerRYybVMytS4l35EloO446lFkJGD6sbOMLtcCiDwr0Qtv7iVt4Y4kQBoJVJtDg+G6p16Kq5YQldQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757075279; c=relaxed/simple;
	bh=8CjpBmvrUyioClQv+4t4qWqIJCFOr+widzD2jXtprWQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IUXZez1U+EgxdJI/xhsKDJJU8qbxZqW5RVLywEcZsT0Ezjh3v80JVIi/D137v5VeEBIdgHwR7W6f4vT3qxBaN8nH4qLWWNRfAAyCm1VqGrRg9kKcgha9t23G4ftHA1wQyuOLNi6gjocyX4UsGeaiZt9O1SRFJ5I+X9KuXaCWFhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org; spf=pass smtp.mailfrom=8bytes.org; dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b=EONzcNdO; arc=none smtp.client-ip=85.214.250.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=8bytes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=8bytes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=8bytes.org header.i=@8bytes.org header.b="EONzcNdO"
Received: from 8bytes.org (p54921b16.dip0.t-ipconnect.de [84.146.27.22])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.8bytes.org (Postfix) with ESMTPSA id 0745E52C54;
	Fri,  5 Sep 2025 14:27:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=8bytes.org;
	s=default; t=1757075277;
	bh=8CjpBmvrUyioClQv+4t4qWqIJCFOr+widzD2jXtprWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EONzcNdOrHAgSS/R7sA/baWHgglBoaJyxqbKCl822wd1J4gyDGD3l/KbFg2hELjEK
	 vLeMx68mqhnKsTRVe9eBoqtwlB0+LWgE056t4AgZv0ORHNQLtDHHnc9ZGlAwnKB8yD
	 ldX1vNQbZI3mH4SvUcLnuBS59Qa0BPCvCFfFyAcuueshf3YcVvozVNyNyggswjdp4o
	 Lf9EUiW+syyScoa+KmA/VzpNHaK2WLBvy0FDdBKUUZz83WOmPmcceOdQP15y2La0tP
	 c7qO4at7A4tF6CoGXTpycfyBZvVlz8HhdiJkEo1ZPjya2kD98eteQyZYjUWNqedGzV
	 1In0f20sVWSKQ==
Date: Fri, 5 Sep 2025 14:27:55 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Janne Grunau <j@jannau.net>
Cc: Sven Peter <sven@kernel.org>, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Neal Gompa <neal@gompa.dev>, Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH v2 0/3] iommu/apple-dart: Four level page table support
Message-ID: <aLrXS9Z-F31SEd_G@8bytes.org>
References: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821-apple-dart-4levels-v2-0-e39af79daa37@jannau.net>

On Thu, Aug 21, 2025 at 12:15:57PM +0200, Janne Grunau wrote:
> The DART instances found in T602x based SoCs (Apple's M2 Pro/Max/Ultra)
> indicate an IAS of 42 bit. This results in alloc_io_pgtable_ops()
> failing as io-pgtable-dart supports at most 36-bit IAS.
> The t8110 DART design supports 4-level page tables. Implement support
> for this in io-pgtable-dart and mark DART stream with more than 36-bit
> IAS as 4-level page tables.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>
> ---
> Changes in v2:
> - simplified 4 page table level use in apple_dart_hw_enable_translation()
> - use "iommu/{apple,io-pgtable}-dart:" as commit subject prefix
> - added Sven's Rb:
> - Link to v1: https://lore.kernel.org/r/20250814-apple-dart-4levels-v1-0-db2214a78c08@jannau.net
> 
> ---
> Hector Martin (3):
>       iommu/apple-dart: Make the hw register fields u32s
>       iommu/io-pgtable-dart: Add 4-level page table support
>       iommu/apple-dart: Add 4-level page table support
> 
>  drivers/iommu/apple-dart.c      |  50 +++++++++-----
>  drivers/iommu/io-pgtable-dart.c | 143 ++++++++++++++++++++++++----------------
>  include/linux/io-pgtable.h      |   1 +
>  3 files changed, 121 insertions(+), 73 deletions(-)

Applied, thanks.
