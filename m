Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822210;
	b=Afut5xLGF0gw+/PY5UImhJhqf9DlQp9cFnb3D9ZrHJAVyI87MTUSyqKIDDITfSbgxwwV
	 OmMG+mhqANBMfhRekpu/gdSZ7JspFqw4VIeSeNiKKARZFitj1Qg6WESm7c/M2gHKdW45K
	 Bhue+mAOMknrOh1QJ5ZQC+vOY1dcErHNLldMwsrfT9mCX8xpzzznSFYLxBUS0pniG4H8w
	 YVax3GfEFvA5J5HHB3tap5D19bcbMAtUIIIz1pkLebow2LZpCjT6+lFha9vmawF7p8T+2
	 C5USURm4l/yaqPa/mbgU7Oplfgr8e0cpM+gy3USALI1tIBtgcLyI0yMfrNRQL6LKvrQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822210;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
	b=FtF/bYdliHAZWnyEQdHwcccY3bkRcuiJ0VUrjKKW/4xZ+gvw0rQAWW9yaFPOA6IHyCGJ
	 of1PSufzbxrq9WAJWUlaZfMBFPrwbakg48LDQE9tUjabhQX1F5MD3c4I39E+Jf1X39IO+
	 +/M5UXEM34J3ltCtGRZc6Gbyeo7sl9kFzi6heTDDrCNm9F8Dkn9vO4C4B1fD+OqyA4Aip
	 JaAB9Vp8Dnl796ggq2LB7S+SB6qGRJ9utgn0mSbBZEkIp2Ttmdgln/MpIRr2BSM0GpSXi
	 2BzbQPRFECRhclEQoP9bMnfitJ87ty6aohlQpdyvc93I4qt1vXNSCnSA6+9mxRtYUBw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=ziepe.ca;
	spf=pass smtp.mailfrom=ziepe.ca;
	dkim=pass header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FKmyTyXt;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5ABB60E7519
	for <iommu@lists.linux.dev>; Wed,  4 Nov 2026 19:56:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5ABB60E7519
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=FKmyTyXt
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-917aca1aee5so14517086d6.2
        for <iommu@lists.linux.dev>; Wed, 04 Nov 2026 11:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1793822208; x=1794427008; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=FKmyTyXtU7wSIX5ltluoTsYn7Jom/pgniiTPhZ9sgwUqFdE7QZ8CFtdcq9E6BsYVW1
         7v7AvyhYyqDYMyef62Grql32CH/nsE84/6sSAs/aVdNM9PlduTH8agTWST9Cte73OC0Z
         JZcnmcDVcvxFsvC+nvh1oiSFxBqHY7NesLLy5y1cEanurOhWKgHHyFZlCzT2LyprGwOt
         EJWZu0ov2pzNZCb60Ggco2PJpOiIgDnngOyCF+vCTs6DXHK1eMtJKD04DpRDvBm2e772
         jEvtac8fvL1tY1CpDzNkdNyzDXaHnE3YoBhiHIPfm9QAzV0iDkooGY0085mZ6yHBaES3
         ptcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822208; x=1794427008;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=H4EFhcspofR4b1uKve6jkW0t06ZcJnK+4e01jxgUvKY=;
        b=W8dcMbNysX7nFXW7xWiF8rRB25430pic6bJmWEEWdF7jRbs7+lmJ7tzQ52CpTh91eR
         972tzssNVHkATkOI2xu2Mq9d38glD9eK0cmE32uw5amSocNvXTQZl2uePD3AZuQr8EAg
         gHprCiA8grlKe6dZx3RRRjzO9dpaF6yk0SqRb/K4/dwEUG+pa1iRO9jxL4c40ayRlsuE
         NpI1dFDt98d/KTb1TI3dXgKIxq25nZfmx2tWeHuJRTpN8DYI5slSwc32os3sPTtOifw6
         5wdAgixe6CpEE5Yz/C9M0P5zVAqkJKxoSggXq1JC7RjTfCittJJJbYij36+nMlyYtsOm
         Bbsw==
X-Forwarded-Encrypted: i=1; AKwUvBzFe91UOakIcgW8Frg1JFm0hsIQdEGFLOG4MOQYsiikHsLSm0JyDcLRTJrt7jrxpRaF6+b3dg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+ZBtgtNVE+TPcybfiPpQa1DAIdD4DJfwrPzEUPYBQ6LQwR2vlE
	/4iswpC7COZbs0oR+9pU+7QkfbWwcPcryA2Q8OXgG/aKeb3tBEQoghE/oL33PMk7ezs=
X-Gm-Gg: AYBFou0cdvJ8+HfsWNUOFdhf5OCfCo9DnA+uictVNFHZWyv5hL0ta1b0HcGZ0mxVCON
	xj8yJp/nRXZbWhDD/z1gOWZCqYisj7oEFOJIVAsYwe5E6JmEXPRUgXHB1NnTEyqY0CteY70JZXy
	mw1XKItSFrWo22C2GFl/6geKE9KJH4RoHFfxgfbpamnpAZTbxAAgv4+319GypXoDppbacaA8Plb
	rpYLK6GeodEd1uu0KcCmu5k1tL65zYzAocEkt7SEqU4Y9xX78s+WPI+6hndxTn8/vlA+Rrv3OeU
	C8QTTWYOfcpnHaMC6qHlBf7vrQpb1G2+rQHCWhjpZJmqlWlhmzzkdnyXddQR0x2SUpBhHdU5EP9
	+IvbmKCSfZLO4NqVP1uTc12tnOpAhEIdbllpDrsnXjbOsIMWnKE2ss7vGtCSGPPuaOID6t6m7b3
	VcNBk7VZgGaW7e61E/+JsoJIpKrh9eVO3/DKaSY+hNEGDqEenZ48N7t2Z7uaHhByVlhvjDewNOA
	V8Ol+X7qwZzBVm1RHgPeTOVnwnL+wfbIH1f4W4M+oxG8L09NpxWv9DbkTLgDcT0cYG6dNCXQo2p
	yjT3eFFcFGNvIo7K+WzmNd6Fd8eAx7hBOG5bQ/Ss3sihQaGBkg94hTncx4c9r1sT6CNAxTWZNYm
	TCd8A5/uuQg==
X-Received: by 2002:a05:6214:2dc2:b0:917:9cd8:f26f with SMTP id 6a1803df08f44-91ca4b1b1afmr281180966d6.25.1793822208495;
        Wed, 04 Nov 2026 11:56:48 -0800 (PST)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e7b1e92sm27199686d6.45.2026.11.04.11.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 11:56:47 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1xOh6F-0000000HJlF-1F1D;
	Wed, 04 Nov 2026 15:56:47 -0400
Date: Wed, 4 Nov 2026 15:56:47 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [PATCH v12 00/19] PCI/P2PDMA: Route peer-to-peer DMA by TLP class
Message-ID: <20261104195647.GD3889730@ziepe.ca>
References: <20261104084328.GP264423@unreal>
 <20261104171412.GA1247928@bhelgaas>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261104171412.GA1247928@bhelgaas>

On Wed, Nov 04, 2026 at 11:14:12AM -0600, Bjorn Helgaas wrote:
> On Wed, Nov 04, 2026 at 10:43:28AM +0200, Leon Romanovsky wrote:
> > On Tue, Nov 03, 2026 at 05:37:42PM -0600, Bjorn Helgaas wrote:
> > > On Tue, Nov 03, 2026 at 10:29:39AM +0200, Leon Romanovsky wrote:
> > > > PCI P2PDMA applies Request and Completion Redirect throughout
> > > > both paths.  This misclassifies asymmetric and nested switches,
> > > > and reports one answer for every kind of TLP.
> > > > 
> > > > Three ACS controls act on TLP attributes the Requester chooses
> > > > rather than on the topology: Translation Blocking and Direct
> > > > Translated P2P act on a Request's Address Type, and Completion
> > > > Redirect skips Completions carrying Relaxed Ordering.
> > > > 
> > > > Evaluate each direction at the path divergence, decide every
> > > > class from the one walk, and treat a client with ATS enabled as
> > > > translating unless its driver declares per-mapping ATS.
> > > > 
> > > > This completes the P2PDMA side; dma-buf and mlx5 follow
> > > > separately.
> > > 
> > > Is there a one- or two-sentence explainer of why we want this?
> > > I'm thinking in terms of what Linus will want in the merge
> > > request: a fix for something that's broken or some new
> > > functionality.  It sounds like this is solving a problem, but I
> > > don't know enough to translate the nitty-gritty details to the
> > > higher-level user-visible problem or feature.
> > 
> > Not AI; these are my own words with grammar fixes from AI:
> > 
> > "The existing implementation of PCI peer-to-peer assumed that all
> > PCI TLPs were the same: ordered and carrying untranslated addresses.
> > It did not account for the variety of traffic types defined by the
> > PCI specification. As a result, only simple systems supported
> > peer-to-peer transfers in the upstream kernel; real-world systems
> > required out-of-tree patches and careful platform design.
> 
> Can we be any more specific?  E.g., what makes real-world systems
> different from simple ones?  What does careful platform design mean?
> Something about ordering beyond what PCIe requires?
> 
> ACS P2P Completion Redirect affects Relaxed Ordering (RO) Completions.
> Translation Blocking and Direct Translated P2P affect Requests with
> Translated addresses.
> 
> So I assume the existing P2P implementation breaks somehow when RO or
> Translated addresses are used?  How does it break?

Let me try, something short for Linus:

"Enhance detecting if the PCI fabric can support a peer to peer path
by evaluating the full bi-directional fabric path over each of the
three traffic type ACS controls. Expand the number of fabric
configurations where the P2P algorithm makes the correct determination
of support to include non-uniform ACS and situations where translated
takes different routes from untranslated."

Jason
