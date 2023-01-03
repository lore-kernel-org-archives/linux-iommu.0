Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666A120E4
	for <iommu@lists.linux.dev>; Tue,  3 Jan 2023 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UReA0GcbImXPJjMHdixxp2/Qho2HPlkyMr6BQp2ajFI=; b=yfYfzTAYTGUnzLhcx0NbKYMkf9
	wJhF9Bxy6gjtP5Ag4QqUwmDyPOQZLpJFcQdvXlifXi0GsPDhRQ2CxiwLkF0Dp1BmQQFyDpLFYKWk7
	09199BZgj0hE8s90A+EMUSzY50ZR6tgdzsVBUymHePpgnzFyfughIXYI5zw4TTs+mL2qGMaVhmuBI
	lOT2yKkoUHtX6ZEMBewPOoaNNZ/4uwL5FOapeMu8cvd5FNHnIGVpn6ptuLUttMLWEJ7BgArN7TBPV
	FyhMqTbjxczL8BR5AOZaxU4KzT6m6bNU4HmnW0SllhWycoBdQVi36wQY7zwBC/mwVrM/zMfV4Mpku
	lV7ah/Bw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35900)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1pCdwu-0005Ak-AK; Tue, 03 Jan 2023 09:51:11 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1pCdwr-0001xG-NH; Tue, 03 Jan 2023 09:51:09 +0000
Date: Tue, 3 Jan 2023 09:51:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Igor Klochko <igor.klochko@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, iommu@lists.linux.dev,
	robin.murphy@arm.com, m.szyprowski@samsung.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arch/arm/mm/dma-mapping.c: fix __alloc_from_pool
 returning a dirty buffer
Message-ID: <Y7P6jeHCoTVRhl7X@shell.armlinux.org.uk>
References: <14dccd8c-e29a-fe93-5d4c-f0c3ff4f2430@gmail.com>
 <20221223143938.GA29147@lst.de>
 <43ef46fc-2fbc-31b7-d683-f7496b39dae5@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43ef46fc-2fbc-31b7-d683-f7496b39dae5@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Dec 23, 2022 at 11:51:43PM +0100, Igor Klochko wrote:
> Thanks Christoph,
> 
> Added fixes and a changelog.
> This issue is present in all current LTS versions.
> 
> ----
> Buffers allocated by __alloc_from_pool() should be zeroed out as done by other allocators.
> Certain drivers expect a clean buffer and clearing the buffer is beneficial from the security point of view.
> ---
> Fixes: 36d0fd2198da3 (*arm: use genalloc for the atomic pool*)
> Signed-off-by: Igor Klochko <igor.klochko@gmail.com>
> ---
>  arch/arm/mm/dma-mapping.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index c135f6e37a00..bb2bb3ab497a 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -366,6 +366,7 @@ static void *__alloc_from_pool(size_t size, struct page **ret_page)
>  
>  		*ret_page = phys_to_page(phys);
>  		ptr = (void *)val;
> +		memset(ptr, 0, size);

I'm not up to speed with the current structure of the DMA implementation
on ARM, but isn't this going to make cache lines dirty for the returned
buffer, which will corrupt DMA on non-coherent devices?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
