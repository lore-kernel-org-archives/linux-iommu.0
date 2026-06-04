Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C53337D137
	for <iommu@lists.linux.dev>; Thu,  4 Jun 2026 07:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780559214; cv=none; b=Df33GZTXTpzCDg0dojqUO0Aq85RGCEa8E8h1YU7fHAJeSw4+hiHAkPmzcH06f5f0TCZ15HGxmd0iGw9OUnfSojx9yM8gbUpo3vAXAFFR5zS/LCJV/37BXjzkDi/Ezs//yrQioHAwC4Ky/gNspYC6Jeu7KWmHVJVH8cLWkSw3Zz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780559214; c=relaxed/simple;
	bh=QuQ6yd+qiTMx7wu9ukvpMClIGTQzcrTyFNlcmK2JTcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6gQipfJsd8c79zSKWtrxlfiaglZebqBAuj9I+7qiGv6vHjXzMDbYqMwAYnDO19M7sNCJ90AwPWXs2VcyCi9wZrxMChrTbSOESE+rRzS0UYHIFDMlhvjF6RJMOrgkmzj3FpMy6I+6gdeweJNwwFCk47JYBbp0TWBRTEnC2KlBso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vPeUfVw3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vPeUfVw3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2bf2911f93cso49855ad.1
        for <iommu@lists.linux.dev>; Thu, 04 Jun 2026 00:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780559212; x=1781164012; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OEvlqMLJ2/4sje01Hu61egtPwYlipbO9vTjEeFPQIjM=;
        b=vPeUfVw3DCNKOcc75/4zJNZlkpTiNUgO+1MphBoXOKGDiGjCBOMnI0IzBitJycW55p
         nP1++HxnfuQT/XoVGqhSOxBUPpMpP1rWVDN30RzeDVoWTT+uyoNDTwCWXYQT+wVlojR5
         /Fn+zhMW1RBpqdkya1xx1DGaDsX5dmhYReW5omUYgQquy/qPNpm/6vNK2XYfQ6Wq/pKH
         O1ttMADv7xl4YevcJk/WweRuc0XsES6d01RlUQFB2f2Ywzd+xaQbTdDZbsFpmDV/SQlV
         3PRurA1lV6GmlJsr0yovekAWjr9xgSzPW+77fEkJ8z+OyC6e/1Iu1FAtvcw5RQfmIp6u
         6UtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780559212; x=1781164012;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEvlqMLJ2/4sje01Hu61egtPwYlipbO9vTjEeFPQIjM=;
        b=rhfgd1QVSU2zrYWC6ucBtofNpyqJYwGtxHY5lcyvKt6UgJzsGY365vUuRcAFjgEFKX
         ocFhM+vWB//ozIS0Mm7J9234mLBoIIh7wHNHaCHvzUBYbgH3DzdgnG/zmDv9JnzLEyXK
         1tZvHmaCjT2r2qpBzAP85aWN5I9WhJ/poVwlvrCYwQzqNQ4fwmvBN9mCdEpIw5sihQvp
         JxdY1AN4Ns2AAJMhNokXzOlukYjRsjAG3DVHtukafVXdCSafqjMScSkEeQjlcfDZZW+H
         CBZCwc7QrjPZJwfoSQnyB6rBFgO8OVhjSOgbtFEta8OlZWxAfgLvtKG54nVBBQI6mqke
         fgag==
X-Forwarded-Encrypted: i=1; AFNElJ8l/40to2+OLj4GXypt6sZStphZZz7IqJsRR9QxdCxgf+lVveIcKK/IlSozDkaUVmouIg3DnA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyEHGiDNnro8344zh+rljLsSQteP33GIJTNdJwo604t+3gMWuKv
	oqqPcOU7x0y3uA5h7h7wHDKoynQ1ni5U7YyRQC8w59bvewUz5YOsI0JeBvYarMG1IA==
X-Gm-Gg: Acq92OF+PW5Vx5X+fsIpp7MsdKUH3JG9PVFZKEgG2x/0HSwU1JkafLkL5fReARD36p2
	MKr9/bwC5IbNxxL3E29qTsnG0+uH7CahSOnE4fwxlKzBUMAyB3XKWm6q5nQXu5ECvTkgNx6voXD
	IHEdqZLZl38nwt4/yEYGKGKRY5hB59RwfQVsgs4NovvwkVJm/5C3ODiHDrSV/trD3JL3oDaIaIN
	tbLIY+eBaUXS0R7R//S3VUYAcZ5AROYWjYfXLsIw1K6xbRK+t6ov7QU0bkpdJQ8xBZD23FH1tJB
	q72KzBYff85Ohkq2d8pdhp4BxQUjwvQOQvHSocj1BIfh2rY2Ls7KH2L1BkWpZztXFyycMwx6ULd
	cgiAy1cmwzBpN3Oe1GB4QwFgZzB+GBiG/z7wmr5J9zv4cw2yIWbEDxO8A9gmOLE9LZqvY21uJjm
	nht+ciH6Qfu8ncX2xzoRXbHEce+iSNWdujK7wWA0j5g0bz+IRJ2zLlILqgvyu+8gfV7AlpXZa8l
	0TjT6VYYg==
X-Received: by 2002:a17:902:ea10:b0:2c0:b19c:2e10 with SMTP id d9443c01a7336-2c198ab2908mr2379365ad.0.1780559211598;
        Thu, 04 Jun 2026 00:46:51 -0700 (PDT)
Received: from google.com (199.255.142.34.bc.googleusercontent.com. [34.142.255.199])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84282916b10sm5271203b3a.58.2026.06.04.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 00:46:51 -0700 (PDT)
Date: Thu, 4 Jun 2026 07:46:45 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	lirongqing <lirongqing@baidu.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Lu Baolu <baolu.lu@linux.intel.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	Bjorn Helgaas <bhelgaas@google.com>, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH] dma-mapping: direct: fix missing mapping for
 THRU_HOST_BRIDGE segments
Message-ID: <aiEtZddAA1dDJ5RG@google.com>
References: <CGME20260603013739eucas1p2acd3cd59c1083639deb58723d57558af@eucas1p2.samsung.com>
 <20260603013723.2439-1-lirongqing@baidu.com>
 <d5b8f939-02d5-4016-9ccb-dd0be0714abb@samsung.com>
 <20260604071856.GA245424@unreal>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604071856.GA245424@unreal>

On Thu, Jun 04, 2026 at 10:18:56AM +0300, Leon Romanovsky wrote:
> On Wed, Jun 03, 2026 at 06:25:22PM +0200, Marek Szyprowski wrote:
> > On 03.06.2026 03:37, lirongqing wrote:
> > > From: Li RongQing <lirongqing@baidu.com>
> > >
> > > In dma_direct_map_sg(), the case PCI_P2PDMA_MAP_THRU_HOST_BRIDGE
> > > incorrectly used 'break' instead of falling through to MAP_NONE.
> > > As a result, segments traversing the host bridge skipped the required
> > > dma_direct_map_phys() call entirely, leaving sg->dma_address
> > > uninitialized and leading to DMA failures. Fix this by using
> > > 'fallthrough;'.
> > >
> > > Fixes: a25e7962db0d79 ("PCI/P2PDMA: Refactor the p2pdma mapping helpers")
> > > Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> > > Signed-off-by: Li RongQing <lirongqing@baidu.com>
> > 
> > Applied to dma-mapping-fixes, thanks!
> 
> The change looks correct, but it will be better if this change will
> improve d0d08f4bd7f6 ("dma-direct: Fix missing sg_dma_len assignment in
> P2PDMA bus mappings") too.

I was thinking the same and was about to post a fix.

> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index ec887f443741..e98b6547c950 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -489,9 +489,8 @@ int dma_direct_map_sg(struct device *dev, struct scatterlist *sgl, int nents,
>                 case PCI_P2PDMA_MAP_BUS_ADDR:
>                         sg->dma_address = pci_p2pdma_bus_addr_map(
>                                 p2pdma_state.mem, sg_phys(sg));
> -                       sg_dma_len(sg) = sg->length;
>                         sg_dma_mark_bus_address(sg);
> -                       continue;
> +                       break;
>                 default:
>                         ret = -EREMOTEIO;
>                         goto out_unmap;
> 
> Thanks
> 

For this fix:
Reviewed-by: Pranjal Shrivastava <praan@google.com>

Thanks,
Praan
