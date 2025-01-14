Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28C21FECC6;
	Tue, 14 Jan 2025 19:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.11.138.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736884419; cv=none; b=JE0jSshkk4z6S2KlIFAfrVxty3+ZZ3WWq+iVjEd8eIAB7WJ9QDO8/VJHDsD3CLkM2kbpbn7c/ufgvXdpM/WAFcwZ06IgICKvi/+fiK9N5G4uOtHjp2rADDfcxnJgKXp2CCQDiILTKGXBfE+z+1XMHMTFAYYiL6dnf9nSWXT2aeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736884419; c=relaxed/simple;
	bh=bkYFYEGRngG55fgjgFSgaVYt0yDUqa8cDlXazrfFaxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UWdxV79zQJ8ciM3shPseXfv9aAfI1rxiHGCd9Bb1DKMdLSqmVltRsO/V3sXv5GfTgLllBaRd5Xyie+JTR1mrOqC+fgclJgfipCbMb3j+c1R5w7DZUieWkfF2LRYvB8RCn4jEwhLreDS/bDKnnwQ/vxtMU8162dpnfisR5O3Zlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de; spf=pass smtp.mailfrom=sntech.de; dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b=MjPzkRGP; arc=none smtp.client-ip=185.11.138.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sntech.de header.i=@sntech.de header.b="MjPzkRGP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sntech.de;
	s=gloria202408; h=Content-Type:Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=elTGNPu988fAjTrte4nu/pddpSDUwQszKGZ49ovLxfc=; b=MjPzkRGPKNYsvU1uc5+Pq6wcAk
	27LVQ7PmktQQgGI9NXBvjERYPeKgL/L/mmM8IYrZHYoxkYntegNpyD6rbfvpjzklp/+3WBdfdAjIU
	MVdwcwYs3owINMW/gYHJCzQeJLLQCkKuZ69pXn7H7k7y3ejKT54v2Pyw04AoHR03krcXLFuVN1/Yg
	/U9ZdogGhdv/hjp3ZptTFSmiIQ0TZhEq9m4dooWWKF/1TLw0RyEu5NAV85NJfSWm1htFSo02TiMYx
	xLItCJwAaQZY/+OEoHtJ8mYm4kGL5qCdE5Rez7RfWfvW1fMzbelTJ+hRurFzyZ2FFTEaBPLDlA9+O
	fXQof7lQ==;
Received: from i53875b2c.versanet.de ([83.135.91.44] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1tXmyf-0007Mt-L4; Tue, 14 Jan 2025 20:53:29 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 Joerg Roedel <joro@8bytes.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-rockchip@lists.infradead.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] iommu: Use str_enable_disable-like helpers
Date: Tue, 14 Jan 2025 20:53:28 +0100
Message-ID: <23826147.6Emhk5qWAg@diego>
In-Reply-To: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
References: <20250114192642.912331-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Dienstag, 14. Januar 2025, 20:26:42 CET schrieb Krzysztof Kozlowski:
> Replace ternary (condition ? "enable" : "disable") syntax with helpers
> from string_choices.h because:
> 1. Simple function call with one argument is easier to read.  Ternary
>    operator has three arguments and with wrapping might lead to quite
>    long code.
> 2. Is slightly shorter thus also easier to read.
> 3. It brings uniformity in the text - same string.
> 4. Allows deduping by the linker, which results in a smaller binary
>    file.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---

>  drivers/iommu/rockchip-iommu.c              | 3 ++-

For the Rockchip part
Acked-by: Heiko Stuebner <heiko@sntech.de>

> diff --git a/drivers/iommu/rockchip-iommu.c b/drivers/iommu/rockchip-iommu.c
> index 4b369419b32c..323cc665c357 100644
> --- a/drivers/iommu/rockchip-iommu.c
> +++ b/drivers/iommu/rockchip-iommu.c
> @@ -25,6 +25,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/slab.h>
>  #include <linux/spinlock.h>
> +#include <linux/string_choices.h>
>  
>  #include "iommu-pages.h"
>  
> @@ -611,7 +612,7 @@ static irqreturn_t rk_iommu_irq(int irq, void *dev_id)
>  
>  			dev_err(iommu->dev, "Page fault at %pad of type %s\n",
>  				&iova,
> -				(flags == IOMMU_FAULT_WRITE) ? "write" : "read");
> +				str_write_read(flags == IOMMU_FAULT_WRITE));
>  
>  			log_iova(iommu, i, iova);
>  
> 




