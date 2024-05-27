Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B331F13AA59
	for <iommu@lists.linux.dev>; Mon, 27 May 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716817762; cv=none; b=OntCHm80soi0razQjh3UM6D0Fs0qsPp0AVVk1jNEWDKbzCV10WLVaT/qAodd+8RVMxEV+eMUIvqvcKZnmEVOhGrymWQquVeiwfaAlEPnd0ReSe5UhWpkjZzlICv/Q4DFquuHdKhbfTnuva0oMtNCvqJ+3zhNEmOYtsReMDgrvxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716817762; c=relaxed/simple;
	bh=gqza+53r5VdbcAND+Hi9YfxVDyGCS9djsD4wSOb5XXI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNygDAISHlSJrueL2AvgWRcFtE7f/pMEKFfXZjUD61Skv11MBM1dUNVznL82BbCy0RntATNB8l9q8inMuCFFNm2n7vsy9KUQfsDVdplXn/w7O8CEGJi+o3C9HB3DRLRrv0IbZxabO9CrTEmEJJsTzQWMmCl38NoCLXeAbLJtBRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=tkh5WiiA; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="tkh5WiiA"
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 8D9221D2C84;
	Mon, 27 May 2024 15:40:05 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1716817205; bh=vzQMaKe8PWq8/rJIUTZI8C7BenHzVSRhtEQYf/oFXl0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tkh5WiiAboiiWDCmRyyPkyqW3L3y4BGcfr2IVSnE000zAnqBVehCthCdnt5HF//Sf
	 czWPcJDgPtMJeXWAkPQwwXCxQQYI4WGwg+p5mOVXBF+GkXoUOfuVV9qY3AoaiJXLxs
	 e9GUxse0caC3zHiaONykC3nFyUL3lg53epva4av26V9xw0s1SBYvTDo7Qji/wa2IoI
	 fumT5hlRv1YqUyyTPtH7ewdcG1PbAgqKxLwSAYNmZNiPFdvzI9Lv55koPkJ4oesE5v
	 JAFFt/4bY8BqC4KrocxDMv8WX9CSCk/Hqqqufv854ToBcEuh8x4I+eO5TCCW/o9CYY
	 QOtkOYjfT/2CA==
Date: Mon, 27 May 2024 15:40:04 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, Michael Kelley <mhklinux@outlook.com>, Bagas Sanjaya
 <bagasdotme@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] Documentation/core-api: correct reference to
 SWIOTLB_DYNAMIC
Message-ID: <20240527154004.41a41caf@meshulam.tesarici.cz>
In-Reply-To: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
References: <20240527131314.22794-1-lukas.bulwahn@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 15:13:14 +0200
Lukas Bulwahn <lbulwahn@redhat.com> wrote:

> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit c93f261dfc39 ("Documentation/core-api: add swiotlb documentation")
> accidentally refers to CONFIG_DYNAMIC_SWIOTLB in one place, while the
> config is actually called CONFIG_SWIOTLB_DYNAMIC.
> 
> Correct the reference to the intended config option.

Good catch!

> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>

Reviewed-by: Petr Tesarik <petr@tesarici.cz>

Petr T

> ---
>  Documentation/core-api/swiotlb.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/core-api/swiotlb.rst b/Documentation/core-api/swiotlb.rst
> index 5ad2c9ca85bc..cf06bae44ff8 100644
> --- a/Documentation/core-api/swiotlb.rst
> +++ b/Documentation/core-api/swiotlb.rst
> @@ -192,7 +192,7 @@ alignment larger than PAGE_SIZE.
>  
>  Dynamic swiotlb
>  ---------------
> -When CONFIG_DYNAMIC_SWIOTLB is enabled, swiotlb can do on-demand expansion of
> +When CONFIG_SWIOTLB_DYNAMIC is enabled, swiotlb can do on-demand expansion of
>  the amount of memory available for allocation as bounce buffers. If a bounce
>  buffer request fails due to lack of available space, an asynchronous background
>  task is kicked off to allocate memory from general system memory and turn it

