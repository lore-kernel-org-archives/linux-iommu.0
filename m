Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80A941C2FC
	for <iommu@lists.linux.dev>; Tue,  9 Jun 2026 13:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781010262; cv=none; b=e6/Xg53piifYWfcJtFc+WOkDML3ShzYn60/wXKWJbDdUOQKBe298o4brgpP1WU5qDC8xFRDYlPp9O3irM7sWE/uJHYOb5iirqaOFpmwTyvR7WSybpDh5vWTNDi6rrA7PiAErw/OSJTfOy2fBbXc3EzSIIMXbLqA18NntBcQSpi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781010262; c=relaxed/simple;
	bh=0j4G3a5uw0h8NWKrxirXJa6aM0X5kRKkicKFHlR0YPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iy1/d21c6Z7Wg+vUjrIz5+QZEWXyLSe8WyeJk1saX/AoPrhWJ0vqt6pZi9CpwnmPYU/YjgCpvLuDDjqssIgjqDq3GoS3vFrrVK/hPIXUM5NgPGf78axfD2Hp4JXRcEk0rNcQMIF6ifkN0tvTuS2NRikXwoCMxABZR7H+kU9r07Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=JXmbioMW; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="JXmbioMW"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-69de16f5e80so2383386eaf.0
        for <iommu@lists.linux.dev>; Tue, 09 Jun 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1781010260; x=1781615060; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BVZI5mT3es8kfvtZchuw47hPTdSf/Ai//CNlNdsP0KI=;
        b=JXmbioMWLm77WopQEfs06LkxiXmeDLAlNooX53CEDh2Utdsj8wa6VRHM8awNPFLK8u
         NVKc9AI+QzyultZX0xp8Wf0KJmVjR8V+xWWdAUcyR68eLPXqAJkSW2SF1697WUUlSFsD
         EEhE2lq70sBpix4nmf/xMDCXANY2ebNtmJsLTk9v4tuu64giPdGSM2coHmZ5RU6dBQ22
         6DLHaSAwveygJq57EtgbC3EPMmydIM2x1TXIsHjdm3thQadh5I+PdKnBOU8JG6fqivWg
         x5sBnLZlRuVSRdqqvJ/cwg8SSUv7CQ3kmQ50n4DjEJVKLZeD5iAYkfeXr7QgsDvTYB4K
         0VaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781010260; x=1781615060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BVZI5mT3es8kfvtZchuw47hPTdSf/Ai//CNlNdsP0KI=;
        b=mi/DQE+SsQL+PBx60Txcm1sjkgTPi/ai114kjj51MtnJmFRwDR4MGHxJI68aNjvzuQ
         j76+3yMyO1s+Rkmdb5zgkURPTF8eBARfgeR6ZaCtVaK8ygFdZ8Nv0S20kmncUlAjA9sQ
         jP3i+EQYRp5we2gYhc+h9lhJJff10Ke7woSRs4Vz1nBExMge96Gy3he3eHwXdS2mN0Xz
         a5h0k+TEt46ZRyiO8xJ1TxirnUKjKA2/6tyQ8ZHCiaVsCR1aSJPSzoKdKzDj18XKZvTo
         y40sXNb7Vn3+SUJl1UGZWo28MVS3oPTv8PWxJX6C7eGhbtgUnMgvilwumkyIKwVafeg7
         BVuA==
X-Forwarded-Encrypted: i=1; AFNElJ91UFZdKTdM/I1p5r/fWtqmi7EfgPZ/yw7LXSU6QH2t+PKf+NzAipvFRl1kxzO9Qn1jY6Oy0w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwQIb2yW+4WRpvAWNi4zTWVbx3ggcccfBXOVV0uL3kqtbH757Qu
	H3MjAA92kvKWDaHdWo0Hto2yWaqY1eC/D+XsfvIlW3k+49Ai47DcMR1f7ss4FbttyzY=
X-Gm-Gg: Acq92OGRElgMe5VinaknNcFZqYLJ7asnqFhd5PZ5JZ29yAYtCbfmdYe8apZG0AKLfmi
	XiKMtJLUnZI7+4Tha8CHQvlLvh6y16DzWL8qUIDZ1vS7s3QHWag1xdJZzdUaxydiZJjx4I1YqQF
	EfqkmL0EFTB1PePJzKSj3icluHeMbSvzLrYNPMZLGh0LBAOrncfWJVR9Oq5uTYRzDJpAGfL/td8
	2HlXhZmDHWkrknpVZLb4Qq1NIjDrJ7k+ADKJmOfZuOmvE6N7cQbZBsTLN13OLUPFmnSKApwFL0V
	c5fsj1I/PDVt5AZBPQ9YRHwUgoWZGcShguuEM9CYOVeJTOC3a1mMRSMapi+MAniEvfBa3FC+9JY
	QT9Ik45etS9CLp4aXPlivWgrPMqVC4OIacndLLvoBOrKjfyvoxyuiYWrHapRAMgnasi1NyWp4ja
	2xkYXjY/l9u6rq5TawhOghKQt6iUEyOXoL7I2Blu70OOFXMfU0w75HBr5y/fCY98gqaWs+7Ln9W
	D5zvgM/GdDBM6Vr
X-Received: by 2002:a05:6820:1529:b0:69d:e746:6ec9 with SMTP id 006d021491bc7-69e68b09a59mr9951509eaf.9.1781010259454;
        Tue, 09 Jun 2026 06:04:19 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cecd06d600sm203777536d6.35.2026.06.09.06.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:04:18 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wWw7u-00000001vgP-1tLR;
	Tue, 09 Jun 2026 10:04:18 -0300
Date: Tue, 9 Jun 2026 10:04:18 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Rik van Riel <riel@surriel.com>
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
	robin.murphy@arm.com, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, kyle@mcmartin.ca,
	Rik van Riel <riel@meta.com>
Subject: Re: [PATCH v3 3/3] iova: defer maple tree erase on GFP_ATOMIC failure
Message-ID: <20260609130418.GI2764304@ziepe.ca>
References: <20260603033653.4144138-1-riel@surriel.com>
 <20260603033653.4144138-4-riel@surriel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260603033653.4144138-4-riel@surriel.com>

On Tue, Jun 02, 2026 at 11:35:48PM -0400, Rik van Riel wrote:
> +/*
> + * Remove an IOVA entry from the maple tree. Returns true on success.
> + * On failure (maple tree node allocation under GFP_ATOMIC failed),
> + * returns false — the entry remains in the tree and the caller must
> + * not free the struct iova.
> + */
> +static bool remove_iova(struct iova_domain *iovad, struct iova *iova)
>  {
>  	MA_STATE(mas, &iovad->mtree, iova->pfn_lo, iova->pfn_hi);
>  
> @@ -165,7 +175,36 @@ static void remove_iova(struct iova_domain *iovad, struct iova *iova)
>  	if (iova->pfn_lo < iovad->dma_32bit_pfn)
>  		iovad->max32_alloc_size = iovad->dma_32bit_pfn;
>  
> -	mas_store_gfp(&mas, NULL, GFP_ATOMIC);
> +	if (mas_store_gfp(&mas, NULL, GFP_ATOMIC))
> +		return false;

But why does it use mas_store(NULL) instead of mas_erase()? I thought
the iova alloc/free has to be pair wise, we don't split allocations?

Jason
