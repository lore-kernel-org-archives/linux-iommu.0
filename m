Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E323D75AB
	for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038258; cv=none; b=pj2X6jIL+fttD5F9KgdIra93xk1IiG7f7keli62IXLfNx7jJpB6AEoRRBYcRqpG12tHkM90ovWc9GrX4R/iZyKdag93XekIumXPiEomGlITvakEPLWKqtA8wn62PDDc+OaVzQcpB+IZoyNBHG6GauD4IXXEU+id0hshzufwbDag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038258; c=relaxed/simple;
	bh=i1i2c485F0Qe0xpZ3iilWtVCakNDvIIadcOceyICV/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNCYqLu2ruU/jdg27K+k8sY/f/5FWtWlWqKIG1fDO1zJMNtFrvl0tc9hNVFQyA+PCOQ1+BJCl2Hj1rEUn/VVt/9NN6vyBiekTnB39/71CVmXee4gNGaHyzDV6HB3MQgAOqvByM40ci3Mr9Bhltj+Smxdqw5/wGGIAburAKf55nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Un6nKdhz; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Un6nKdhz"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-899a9f445cbso93830246d6.0
        for <iommu@lists.linux.dev>; Fri, 24 Apr 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1777038256; x=1777643056; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Zv88UvTgiwZqXaUOezK9Ft5EGGZMSyJ0Ff2r4iX0Lmc=;
        b=Un6nKdhzsQgzEHyuNC/wr7SPQOJYCDIt8S/6HbhuVBeKId88pt293uhmMbsqE9AhdP
         WAzGrhxLIiJHwgHuf5LiH0Nl/IaMw7xxQjOVBbLad7UlQRMZQJf23m1IYX8nV43f9Boi
         1O4HCcp85tcFpPi0HWzGXc7utt1VLwCh4pWWXej6MFguJleq8YLxvudp0ezTmSyxCduJ
         xP9kSK5i9GB7C73p9jJVJbomFKl30jCQtI6KMsiNiHE39ycjlvLkB7B4eEUFaFyAjuQZ
         Zf9dmJqU/Kymsj/WmMVdagnjNT5ewpv6YwecZ0usEFQZS/89UXyRj4pXbhpBYDYatxWc
         ZAPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777038256; x=1777643056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zv88UvTgiwZqXaUOezK9Ft5EGGZMSyJ0Ff2r4iX0Lmc=;
        b=bRZKFTQ9lz8+fOaVjNfMVjUv2IB86iIEu34Rb+ZNeTxotgnFz+v1Kgvku/7CzwYUWV
         wTgpYQ0mdYpq2CdZHILQMGAEv3ZHKQEELwxHraIBYIUzmGZhwW2h26VnuezYcBKhBZDn
         ceNv9P3Ikk3QoimRz4hoIO+k+HRzxg9eAsHYHhldJObxmFay6ge0GHLjgx0kKaaqJkBL
         h51jcBQc3/CkoMsAVsg3EniohJfW/KR+WJc7Bdbv6tDiGIyxf5vf6ebUg8ukfzzhJ+7L
         wRYwolKZwWJYdYENm3HS73fdNi1mlDaWr6h1XVLHY4U7dakES6jgGpJmKHFCfPOnx51H
         Ee1Q==
X-Forwarded-Encrypted: i=1; AFNElJ+r+E33LIaniRIU6cdthGfGe9w0VBtc/iQf6xNE0FVWDBRpiE4JRz0ooyL2iDKSQR9ODQjSww==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw2dfjfN/Uwm4zykSnmerN5rkwkFBmx5J+LKOPIbBfMoZOiolON
	c19cZ7rDAAEtlXyLtxvrk77HUlPFIgWZT03B0qCAtR5szVDDH2gN1FoLByVrK9bIKAA=
X-Gm-Gg: AeBDievLPPVU1jq3M6+r8Fd0ffbJ47mxpWxaaSTMCKonTBv2+EQTNxDSIvKPJne/zkd
	7SraYTnOVakC9n76p/nrEwLGKf0i1SEhae40RlFtfEeBuHIURN91NcqEvQkMIsVpwaG49dyGJGg
	daaowuN4yalm+chBZAsbnCLfsQYeFAhXcuPJL2Qxz+9PH9Gv8pdpKZiAi1cNRsTCyhz/3hux0W2
	C7dkqVtzJ4pD0alEU5vOLyKIlCb+kyhQDmgD92q7FQn/XLMMQEo2RxjU+YfOMn4gQvRCTzvTFhr
	RShLIPNKT7Q14g9FPhRaMtPh+tUtS3833phVXJJ6kvTtuQ7tkhXytKo5PsSnfSTAVV1lItGrNly
	E6LAMJIKsrrHTy6CSH0/UAcwX0zHVVNVviZEMQfs5KVOIj1qm7Ity5WXFwZOC4t6T9p356QGD8+
	6ZBK/8Y/81jrdG+nIYf8Hvw72p8kLvzcvFa0aB+qRLlDmwAekZDzDZCFhgrEpR7ejaFXTCcYsjr
	hVqcoVFqBRIr47Cp+5HTelsWfo=
X-Received: by 2002:a05:6214:20a8:b0:8ac:a914:c2cd with SMTP id 6a1803df08f44-8b0280808cfmr513452986d6.20.1777038256324;
        Fri, 24 Apr 2026 06:44:16 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b02ac6c3e7sm188611786d6.13.2026.04.24.06.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 06:44:15 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wGGpL-00000002Zm3-0EMP;
	Fri, 24 Apr 2026 10:44:15 -0300
Date: Fri, 24 Apr 2026 10:44:15 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Peng Fan <peng.fan@oss.nxp.com>
Cc: Juergen Gross <jgross@suse.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
	xen-devel@lists.xenproject.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH RFC] xen/swiotlb: avoid arch_sync_dma_* on per-device DMA
 memory
Message-ID: <20260424134415.GZ3611611@ziepe.ca>
References: <20260415-xen-swiotlb-v1-1-de24eda3c0fd@nxp.com>
 <20260420230137.GQ2577880@ziepe.ca>
 <aesUTxAl2qWZiqoT@shlinux89>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aesUTxAl2qWZiqoT@shlinux89>

On Fri, Apr 24, 2026 at 02:57:19PM +0800, Peng Fan wrote:
> Hi Jason,
> 
> On Mon, Apr 20, 2026 at 08:01:37PM -0300, Jason Gunthorpe wrote:
> >On Wed, Apr 15, 2026 at 11:08:36PM +0800, Peng Fan (OSS) wrote:
> >> From: Peng Fan <peng.fan@nxp.com>
> >> 
> >> On ARM64, arch_sync_dma_for_{cpu,device}() assumes that the
> >> physical address passed in refers to normal RAM that is part of the
> >> kernel linear(direct) mapping, as it unconditionally derives a CPU
> >> virtual address via phys_to_virt().
> >> 
> >> With Xen swiotlb, devices may use per-device coherent DMA memory,
> >> such as reserved-memory regions described by 'shared-dma-pool',
> >> which are assigned to dev->dma_mem. These regions may be marked
> >> no-map in DT and therefore are not part of the kernel linear map.
> >> In such cases, pfn_valid() still returns true, but phys_to_virt()
> >> is not valid and cache maintenance via arch_sync_dma_* will fault.
> >> 
> >> Prevent this by excluding devices with a private DMA memory pool
> >> (dev->dma_mem) from the arch_sync_dma_* fast path, and always
> >> fall back to xen_dma_sync_* for those devices to avoid invalid
> >> phys_to_virt() conversions for no-map DMA memory while preserving the
> >> existing fast path for normal, linear-mapped RAM.
> >
> >I think this is the same sort of weirdness the other two CC threads are
> >dealing with.. We already have two different flags indicating the
> >cache flush should be skipped, it would make more sense to have the
> >swiotlb mangle the flags, just like for cc.
> >
> >https://lore.kernel.org/r/20260420061415.3650870-1-aneesh.kumar@kernel.org
> >
> >Then you know that the swiotlb was used and it should flow down to
> >here.
> 
> Xen fully implements dev->dma_ops and does not leak hypervisor-specific
> semantics outside of it.

It may have its own re-implementation but the same remarks apply. The
flags in attrs should be correct and you should not be putting random
boolean checks all over the place to make up for incorrect flags.

Jason
