Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7B269880;
	Fri,  2 May 2025 17:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746205660; cv=none; b=QoAX1FZfVb0mNlS4QrZ2j8d0OuM2YIyA2jjJ2UUWcw67Ij5udp+yhJbfeDqCbeoAJcViut6YEKrarsteCSB4Eefn09Q6JpLKxgoKozPVKo/AQTNfoCxSXpB85Ej32eEffX2W3i+uYfh6mdMTZhClN0S3R71VuSKZNuUusB/pHFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746205660; c=relaxed/simple;
	bh=MXrACGyqOXVDhEpixyz+BKgn/54QO0zKMHCOhJK/g/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=NV8Ste1oYEU7YQqgJmaD5zhu37w6PwjtlLqs8Czm/mP4Ah3LZ57kZ1tsVSVAEMTnWH5mLzAxFSaHysmKtf2J9MoLuRopU1MAmp9wmO7Y65LzW4vcJsFS8YU+RRL0au1mB/KSXjweVohGvu/ap37EVas5YWhUOR+hXlWH+Xnrs3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J253chSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J253chSf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DCFCC4CEF1;
	Fri,  2 May 2025 17:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746205659;
	bh=MXrACGyqOXVDhEpixyz+BKgn/54QO0zKMHCOhJK/g/w=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=J253chSfz1Zth/9KTy40/Pi1vYhW0Rzzbthbcj+GVZ18ko3rOCUZLGTyhhxwFgx0r
	 W2Ho1najoPyOqqBHByYN1KulAmWUNVyKHoQJtusev5e9I3XUKS4eHmSfJY2U7zM+it
	 4jaVUpVQ1hkUGs3e5Og32KvWDsKFyOC8EQTJkDGzlwc4eaM9PfMnxie1wr6MvSqI4H
	 yCwpAD1kTF65nqbFtIFxxqmN9L5M1KeNBG3fDW3fnoDEU6F3kbh2lvMHWYv9oyyK2m
	 AhBD0dLSaOPzHXCf7qmm7SStTCcGe9xMIKrAm+pWoKqGTq9qQAbbEXsojEqabNRHut
	 z32AYz4whVdzA==
Date: Fri, 2 May 2025 10:07:36 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
X-X-Sender: sstabellini@ubuntu-linux-20-04-desktop
To: John Ernberg <john.ernberg@actia.se>
cc: Juergen Gross <jgross@suse.com>, 
    Stefano Stabellini <sstabellini@kernel.org>, 
    Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, 
    "iommu@lists.linux.dev" <iommu@lists.linux.dev>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
    "imx@lists.linux.dev" <imx@lists.linux.dev>, 
    "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 1/2] xen: swiotlb: Use swiotlb bouncing if kmalloc
 allocation demands it
In-Reply-To: <20250502114043.1968976-2-john.ernberg@actia.se>
Message-ID: <alpine.DEB.2.22.394.2505020955140.3879245@ubuntu-linux-20-04-desktop>
References: <20250502114043.1968976-1-john.ernberg@actia.se> <20250502114043.1968976-2-john.ernberg@actia.se>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Fri, 2 May 2025, John Ernberg wrote:
> Xen swiotlb support was missed when the patch set starting with
> 4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from
> ARCH_DMA_MINALIGN") was merged.
> 
> When running Xen on iMX8QXP, a SoC without IOMMU, the effect was that USB
> transfers ended up corrupted when there was more than one URB inflight at
> the same time.
> 
> Add a call to dma_kmalloc_needs_bounce() to make sure that allocations too
> small for DMA get bounced via swiotlb.
> 
> Closes: https://lore.kernel.org/linux-usb/ab2776f0-b838-4cf6-a12a-c208eb6aad59@actia.se/
> Fixes: 4ab5f8ec7d71 ("mm/slab: decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN")
> Cc: stable@kernel.org # v6.5+
> Signed-off-by: John Ernberg <john.ernberg@actia.se>

Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>


> ---
> 
> It's impossible to pick an exact fixes tag since this driver was missed
> in the flagged patch set. I picked one I felt gave a decent enough picture
> for someone coming across this later.
> ---
>  drivers/xen/swiotlb-xen.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
> index 1f65795cf5d7..ef56a2500ed6 100644
> --- a/drivers/xen/swiotlb-xen.c
> +++ b/drivers/xen/swiotlb-xen.c
> @@ -217,6 +217,7 @@ static dma_addr_t xen_swiotlb_map_page(struct device *dev, struct page *page,
>  	 * buffering it.
>  	 */
>  	if (dma_capable(dev, dev_addr, size, true) &&
> +	    !dma_kmalloc_needs_bounce(dev, size, dir) &&
>  	    !range_straddles_page_boundary(phys, size) &&
>  		!xen_arch_need_swiotlb(dev, phys, dev_addr) &&
>  		!is_swiotlb_force_bounce(dev))
> -- 
> 2.49.0
> 
