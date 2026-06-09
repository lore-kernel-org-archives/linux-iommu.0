Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4F53B19CD
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 17:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024621; cv=none; b=FWOWW39dEL8Rr2on0LZNXfNtakKW4rJD0mpDilxxSCoa5LYk2vucH9VRKDMllrevNg5RLAMvNBH8zgu2KxmPR6DnJn2zwuqrKAvXX/VKJ6aoMRRepCvjSEwv1fMjIo8CwKJFyM3iYX4WMIRO+PJN2z2mmdZ2jIVdV9fKtzBH62o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024621; c=relaxed/simple;
	bh=S+ORIibTBKQ0pFdjGliKCIE3wa/sE73a0IDa+NYkQBE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pmMsx6rR8NicTXt3A76h7ljtcg5MQYmMC5i8mw6eGgXuaWUfsgvkHAcmCY0CqklJMggFWsCTW6W6lIy14YbghygE/y0oEeM+VRKcH8fX4DWyJTfSDBKzZdQyvEEaFrIHoQ8X3dHB2Xq7QV8mERf2gDNEtow/ACXXO6wV8TP3GFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cRAKbirO; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRAKbirO"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2bf22c18ad3so551825ad.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 10:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781024619; x=1781629419; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=S2CN/F+xLRpEvDTUPWxMr6FI2U9i+V7+WZC6JlOTISM=;
        b=cRAKbirOblT/a2V9ipsycFxgWBWGFzRCCXF395Et5rLrYGG9sejIuGXE2ofTCJ05ha
         W3vSq102fT2pBWdp7gqC6b4iaoKKe2yilyEmunxeMUDay28lz4w5Cbq4ViSucnAlyrgh
         hM7hMmX2DriCEDNg09y8qfXv8uEgK+vCN4cl6tgASMxVjKG69XuU2tRqTL62k1xFkPkd
         eEysYAZYCAjXl2N6xaitXnfW/C0PHc52a4Wp7e13P6QXaMfWkxTSX3ufare4ZuZYEPA8
         vmGrVhTEfD0oIb2VonTlivIhChfBEZ87hT6z0VJub9TPpjBiTCrB/4MWaJX45b6Za5J4
         7aTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024619; x=1781629419;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S2CN/F+xLRpEvDTUPWxMr6FI2U9i+V7+WZC6JlOTISM=;
        b=qJUVC8nZoQQaJujr7M/7UF7jey4Ktb2iJfJbTfsm/GrcA7w6N6gqkRdahdPUuClMrB
         9TvlEe+1aD3ubd2xeiYcAxA4tcHWCdwyujkPVtUcf1aQ20Cgq3N1CZi658pF9UUUmDHr
         lOyz/N5MrE2i0Z926+TRZNmV4dPkjyOHoiKzsEINmJ6EW6+D1gPtWhBOyXxnngFr4ISI
         fT/F5iSHc2JstXauUkMMgWjuofttwPDm59DgF/OZJ5l7ZjTQM0wVXKxRCozDcyyPxsbN
         U0DDeVka4Qs67qfI4V4uHBeAMb58RroOvXliu4qCui9/GGEBCJr4z8+qIDW42dsHyZry
         FphA==
X-Gm-Message-State: AOJu0YxzjlI82QgIW7nh7wevvknx/N03kzu+HaOf5GjMML5UhYMrbfpf
	Zd/+52nEe2X1RXfh4tBOUfHFlncX7UDQcuNhFp0TZ6YzZzFWnmFt37rfbI7/QbNwhLSbyedaZAu
	8rx66mw==
X-Gm-Gg: Acq92OG8HC69zB6h4tEHXnc/6HziUb2GbZLkBc+hj37DzZZwVXyx3eha3+TTtiKGYZc
	LCWgrcsc4cTqobfVKilMirBoNf0gj8OYUKCmSFuvsngDgFweLkalq3VuAi0XAjIsVjxGTTvhO+y
	uEhFjhfj5fGP1GXdZNiOpwgDeFGcou7g3tCM7b8JSC2Y3/bnciy4xLF4WTOY3SrYXQe4T5Ehcjd
	yIPxz22bVEr1rneKZ9VEb71zfQCHP5noHNkgQNUOB5q4QsicwsJbkSTVuhI5rnkRVa9encZDMJk
	CyUwJAraJX1MSVZEN4mBbOxYQDJOMckh7G0O54IdzQTh3by1H6WhbdvmORlg1JDqJVGt0Okgekc
	gxsLXFT38EdjNn/swIlgtVctvT5yrNSFm3skPEq3Y/QpiT2mLJ1+9/ZRvGI7ODhCH2eXsGvjpRO
	iQhw0sqNYQbBAYqeA2KUvwUimYkRbVTqYfryQwvy+I2PJtULYfOBCuIbDNECvuFEFEAGGG5/hXX
	cYveIM3emPYgkWycuzqfJc41dYdFw==
X-Received: by 2002:a17:903:3d10:b0:2bd:6dad:3dfa with SMTP id d9443c01a7336-2c1eb9443abmr8784635ad.24.1781024618140;
        Tue, 09 Jun 2026 10:03:38 -0700 (PDT)
Received: from google.com (25.75.145.34.bc.googleusercontent.com. [34.145.75.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c86151154a8sm10528937a12.22.2026.06.09.10.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 10:03:37 -0700 (PDT)
Date: Tue, 9 Jun 2026 17:03:34 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, "Joerg Roedel (AMD)" <joro@8bytes.org>, 
	Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leonro@nvidia.com>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Mark Lord <mlord@pobox.com>, patches@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [PATCH rc] iommu/dma: Do not try to iommu_map a 0 length region
 in swiotlb
Message-ID: <aihHRieLr9oEaNEK@google.com>
References: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <0-v1-8536728bc89f+469-swiotlb_warn_jgg@nvidia.com>

On Mon, Jun 08, 2026 at 03:10:04PM -0300, Jason Gunthorpe wrote:
>iommu_dma_iova_link_swiotlb() processes a mapping that is unaligned in three
>parts, the head, middle and trailer. If the middle is empty because there
>are no aligned pages it will call down to iommu_map() with a 0 size
>which the iommupt implementation will fail as illegal.
>
>It then tries to do an error unwind and starts from the wrong spot
>corrupting the mapping so the eventual destruction triggers a WARN_ON.
>
>Check for 0 length and avoid mapping and use offset not 0 as the starting
>point to unlink.
>
>This is frequently triggered by using some kinds of thunderbolt NVMe
>drives that trigger forced SWIOTLB for unaligned memory. NVMe seems to
>pass in oddly aligned buffers for the passthrough commands from smartctl
>that hit this condition.
>
>Cc: stable@vger.kernel.org
>Fixes: 433a76207dcf ("dma-mapping: Implement link/unlink ranges API")
>Reported-by: Mark Lord <mlord@pobox.com>
>Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
>---
> drivers/iommu/dma-iommu.c | 19 +++++++++++++------
> 1 file changed, 13 insertions(+), 6 deletions(-)
>
>This was discovered because iommupt errors on mapping length=0 instead of
>making it a NOP, so it is an became an issue since commit d6c65b0fd621
>("iommupt: Avoid rewalking during map") making it a regression this merge
>window.
>
>diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
>index 54d96e847f161b..381b60d9e7ceaf 100644
>--- a/drivers/iommu/dma-iommu.c
>+++ b/drivers/iommu/dma-iommu.c
>@@ -1918,12 +1918,18 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
> 			return 0;
> 	}
>
>+	/*
>+	 * After removing the partial head and tail, there may be no aligned
>+	 * middle left to map.  The tail still gets bounced below.
>+	 */
> 	size -= iova_end_pad;
>-	error = __dma_iova_link(dev, addr + mapped, phys + mapped, size, dir,
>-			attrs);
>-	if (error)
>-		goto out_unmap;
>-	mapped += size;
>+	if (size) {
>+		error = __dma_iova_link(dev, addr + mapped, phys + mapped,
>+				size, dir, attrs);
>+		if (error)
>+			goto out_unmap;
>+		mapped += size;
>+	}
>
> 	if (iova_end_pad) {
> 		error = iommu_dma_iova_bounce_and_link(dev, addr + mapped,
>@@ -1936,7 +1942,8 @@ static int iommu_dma_iova_link_swiotlb(struct device *dev,
> 	return 0;
>
> out_unmap:
>-	dma_iova_unlink(dev, state, 0, mapped, dir, attrs);
>+	if (mapped)
>+		dma_iova_unlink(dev, state, offset, mapped, dir, attrs);
> 	return error;
> }
>
>
>base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
>-- 
>2.43.0
>
>

Reviewed-by: Samiullah Khawaja <skhawaja@google.com>
