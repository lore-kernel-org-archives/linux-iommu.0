Received: from mail-qk2-f41.google.com (mail-qk2-f41.google.com [74.125.230.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9607D493644
	for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 11:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.233
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789991718; cv=none; b=LE1JX15xa4ixGPK41VY0cyrNIFmHU5xhyjk2Pjdw811b4DYVbh669lQM9Q+fdUeuXR/Q9/GfxAtrhb427IMX3T2WbvzhPLD6mr6e5Sp7nRWZSluHDJ0BTaoW/plh5Joeafo6opL1Lx0r6m6v0vZ0VFBsuFGGG2VrQMzqc8qpFcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789991718; c=relaxed/simple;
	bh=x4ZR/35KD2CxuvtsQBW7vNL6jE8skBPQeFvOsLTptis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aOv0zYqM/5DYFti4SgcdJD98XC2sknOFPqZYA+KbGUU4sf6hOXSr3l90JpwZOER1qTTIJ6UiO1XSHJ8MpvxKCgx53QEYYWwaT1M+D8PcGYjjz358QsKFL461JSyLffrBL92LTlTVDwdgsfMpPlnlvyUOLGlH6b3KXgbespzZ3ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=iXyHXNFm; arc=none smtp.client-ip=74.125.230.233
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="iXyHXNFm"
Received: by mail-qk2-f41.google.com with SMTP id d75a77b69052e-532d63f434fso3025471cf.2
        for <iommu@lists.linux.dev>; Mon, 21 Sep 2026 04:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789991715; x=1790596515; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qZHfowJU9Gcgjx9yDF775AN/BbRSMKh2T0yPRE0+ftE=;
        b=iXyHXNFmPLZZGGp6W/eT8Vl9MU8/joOV8j6u7LAYUYOcekijA40Lhb3rSEGAnlMsJ/
         oGlpCHxZTrv/uwXffNdEe6XKwM3lv11tC8/vB4KdZrVLrR+mz1S0WUW5igL4sk6Cx/+M
         cRvlM1Zd6KzQBdZq9aUU3SOvFA47jwMBRK3DJxPGp+vQHg6fbP3Yhens4mmUh82MSquH
         UucRdQkf/AWLo57oDs8yNVPu6wJa+JTB5SpqgLjklHClISf2+fKVOz15qfLRwNl2jmI5
         SeaBsUaqmpPjYeoc4UiiZZRqWWiyKuU6QmnEbEoCznGtA2E5pOyX31FC1+vtt1+8mjjw
         LRXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789991715; x=1790596515;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qZHfowJU9Gcgjx9yDF775AN/BbRSMKh2T0yPRE0+ftE=;
        b=TA8H2dCUQ1guW76jRfU4oya+0XxEe3C5ft4TQXYLuRND54v9UHIiApZc1FKdFG+SFf
         d4Fwf7BINLyNSAXQsTQMQHjKJFrgoUMk8UePfis0qyXLTaPEfa8fpWi4QaJ4qBvWio3/
         DD669w6voHNfJHO3oz2ODECAPCd9p/J2WXWlCxGhhK1E5tARMg6T+QCI6Tk0oadySf69
         vbRlrl8TnHAvh5FMFqJ7zgCjj5y2mrqd/jqmWpskS+Yy5YzDuMFyBxQq0ZGmdsrak8wv
         p6sGhxmY4ZRLQ45yrcJ8ASR7hR6achYKCV+NJwllcOKeWVe3AWgH5OZ8QfbHwW2xwL2a
         T0Cw==
X-Forwarded-Encrypted: i=1; AKwUvBxpqR6nyKWSo2MeRwXKUScBCdsuCzu1IN2Sxsa8x16Zs4wheA5714+G18f+Z967qgbQVOA7/w==@lists.linux.dev
X-Gm-Message-State: AFuF++kIog4cizPnwt03rzkrSk2AdzbS007cbsqWWM1mUlf60blQmBE9
	JiBb5WOpcOKZy1CRrHv6ik4onziWNlI/HV+bqgIquXOJdMMAtxQWk1K2NQzEX1K7dWg=
X-Gm-Gg: AYBFou2jOp785GEZWtVPKII7ddKY/SISy7zXl2EPKzC5Eg+VSUyI/JSPoWg+nCYtIfw
	8/xAtrlgzPIwKaRLxbkJtcAbLFOyUb85AGzD3oDI47EH4xJ0oiOqXlitaAxOEsloprzfDekJaji
	2HeXk1J7/urWsFKC4EAswU1LiYfOsv1eMx4zBeBeE6LGFV7OUwfOXfojH6NJTC+u+taeWkP7c1M
	/e/dLMIBD6xTZp1lxU2ZAkPe7hH2cnANGoLzfhCaXUNY/UfpbhTLSvjgAuHhqwSOdzkk4BEtOrN
	i2k158660RvIeTWgu2pMgIKj1lWgtBjrBHaTlF613jFL/TmbRre6PjRw9pSvLH+2hgxTC6D1Lyd
	dYovzu+m2t3xNsab6Zz7g6BOSBsIaeLjVxaUzScmojgOAVixD6uOPI7kgrwYDttgZfprIz7uxcI
	98ZTUJXdpMW9nuf939uJj7Qs7XCXnXEc4nNw5A88XTVR9TrtjyaMyWPHlpNQogm3h4Pu25PZzYZ
	0Hop0BPngH5XN3yyL0+h67VjScamQcI/40/PvuOAiVgCESi4QQE9Wxt
X-Received: by 2002:a05:620a:4492:b0:93b:c22a:e98a with SMTP id af79cd13be357-93c15d9e687mr22451485a.2.1789991715373;
        Mon, 21 Sep 2026 04:55:15 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93beda70a1esm612157385a.11.2026.09.21.04.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 04:55:14 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x8cc5-00000006EDj-1rtR;
	Mon, 21 Sep 2026 08:55:13 -0300
Date: Mon, 21 Sep 2026 08:55:13 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Guanghui Feng <guanghuifeng@linux.alibaba.com>, kevin.tian@intel.com,
	alex@shazbot.org, joro@8bytes.org, will@kernel.org,
	iommu@lists.linux.dev, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] iommu: Reserve PCI host bridge MMIO windows for
 IOVA
Message-ID: <20260921115513.GK11599@ziepe.ca>
References: <20260921070234.897736-1-guanghuifeng@linux.alibaba.com>
 <20260921103922.1113752-1-guanghuifeng@linux.alibaba.com>
 <a82c3113-cee1-4e27-8c10-b7616f860a93@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a82c3113-cee1-4e27-8c10-b7616f860a93@arm.com>

On Mon, Sep 21, 2026 at 12:24:13PM +0100, Robin Murphy wrote:
> On 21/09/2026 11:39 am, Guanghui Feng wrote:
> > The DMA IOVA layer reserves PCI host bridge MMIO windows via
> > iova_reserve_pci_windows() to keep IOVA allocations from overlapping
> > those address ranges.  As commit fade1ec055dc ("iommu/dma: Avoid PCI
> > host bridge windows") explains, a host bridge may interpret addresses
> > falling within its MMIO windows as peer-to-peer DMA, leading to
> > faults, data corruption, or DMA transactions being misrouted to the
> > wrong PCIe device.  This is especially dangerous when a device sits
> > behind a PCIe switch and ACS Upstream Forwarding is not fully enabled.
> > 
> > Passthrough paths that let userspace pick IOVAs did not honour these
> > windows: VFIO type1 and iommufd only excluded IOMMU driver-level
> > reserved regions (RMRR, unity maps, MSI), not PCI host bridge MMIO
> > windows.
> 
> This was intentional - I forget where the exact discussion happened, but at
> the time we decided that exposing reserved regions for entire windows was
> the wrong thing to do, as being pessimistically inaccurate might be OK for
> the internal DMA API, but restricting userspace is another matter, and I
> think the consensus was that it wasn't really the IOMMU layer's job to get
> deep into PCI details anyway. Such "accidental" P2P can only happen within a
> group that's assigned to VFIO as a whole, so IIRC the conclusion was that
> users should already have enough information at the VFIO level to avoid BAR
> addresses if they need to.

Yes, but we never did a a very good job to make the information
visible to the VFIO userspace level, and I don't think anyone ever
implemented some sysfs parsing to try to get it.

It would be a nice improvement to expose these pessimistic ranges to
userspace through iommufd so it can choose to opt into them if it
wants. Some kind of helper that the dma-iommu.c and iommufd can call
perhaps.

Jason
