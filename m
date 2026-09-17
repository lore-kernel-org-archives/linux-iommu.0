Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F258A4E73D6
	for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 15:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658148; cv=none; b=GHtG8exS8ZYr1kpMXfYIF0AZ09rZzeVeSaAGSLwX6ckDugtNpnsbP7WSPTYDHW18DiSml2jeRi1Ak4zRLcm8qEzhm6gPBzf6Itq5ANa25LbtUcycA3vVGwI9u5k3F3kp2KlIrMeu/dBAAVt1bTwwm47xLT+bmx8gnEco0son4C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658148; c=relaxed/simple;
	bh=jmjcmemHiZ7FQbMcc82ajlGpQ++hpMbdtAMvlMwreUA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2SboltMJf/V080bQHQw1EDHC6+y2US2aU8/J1NDKN0/3eHSmazUrv0ZFaoHFVLI4/xq4SIosu+1zXgyO1sL5xwdwhxblmB3XEsVyNkybY3D/cYSq4pxI/zb1lVotAyH7idOa82Wjr4+/cbTRqgZwSNrMgJ8vKL3OTK1E8s7S3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=U+6FSN7L; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="U+6FSN7L"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530c602630bso7827951cf.3
        for <iommu@lists.linux.dev>; Thu, 17 Sep 2026 08:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1789658139; x=1790262939; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eNGwdDF4ki7ojFW7+l1TCezZJgsNPf4Ld7gCqIxw2+Y=;
        b=U+6FSN7Lq/459OaQzIZEu8rAllWY6wLmk1LFRhTwLJcjxlJloGCAj+kGvKjvNzS3Fc
         8bguBQX7UWz5TV+azn/IfXUg8iDO6arVKLJFocrd8XmeiFzyo3oF2jABSrkEEUvh4Thi
         eJPvcrxAH6n0JdeXKDlg36Ea3pjze/lZNoEZowJsH7P7ryR0lVwt0Nj89Hyofrm+b/+b
         TQU+rky0LG/tIGlVpbFrbGK4CBGNOlQ1qvBENFvgjDiPlcUFUpFHPeJxLpAhNnAxo6U7
         DGjwYYr+/dFXE7Rw1ulWy4Ztp8Nn60FjtXzo9S933dvBw+2Mim4LzMrznFq7BQyEELxW
         B7Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789658139; x=1790262939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=eNGwdDF4ki7ojFW7+l1TCezZJgsNPf4Ld7gCqIxw2+Y=;
        b=KJ4Bth7LHkHSyWLbdFKqBrvj+dTnqzT1LJHNvo6Gazt2uZ5OZ3EgwSipSiODdvd/v9
         XsSItUrnZaNZP8uXfglKREMXYgjYlp15phdXLqokG0VCZz6ss5lpJC+L5GZqh2a20hHS
         6xTZQaSWpEDlKUWVnwVG7glzEG3dpnmX7RurTfXkg6CSSz6sBpjSMh4BBgw40qFDo3Ss
         Oq+oanfaJBfgIkow3GV/91QgYvUReULuh6VR/JjCNVd/B7SZG9wdKI7b4LE9YR3YZKR1
         vFfcFwkI6ujso/NNxmJamXqPUQa+x5MJFKAKNTjq0jGne+bStMF4uLyL/CibmVdHaxE2
         FRdg==
X-Forwarded-Encrypted: i=1; AKwUvBzzkFNjRlQWtwwkPDPZvqXV8m5bpo8Uinh0XE8yBk3bx4GYpeAWZwM39e8gIZCRytFBwMV5cA==@lists.linux.dev
X-Gm-Message-State: AFuF++m55TkSpYSl0GQ4CQQ5H154zYp1z0hTzmw7UxSnazMfloWPOGu2
	lZhs1hcpK8h/mXwngOQllaIHSOx32QhliKQU5I/sqRSEzHhC9CGPnfennMW84rZSIqo=
X-Gm-Gg: AYBFou3dw5G43+rUccam92vJqc09FiYORVtdfV/79Id+a/ggdikGLek0J8fn6uwpDOl
	bzKlvAmrNLivLWNiCg9ddiyAdsQaFlbYlzpM9wHScjNUdhLvGgZ88HFj2PAoQ8GbR70H88qM+uQ
	6pYqXKfKeqwJ3q/JVp1dNw9HpoCmhi6O9xsyP1ihoqHjsGk9Ka6jPMbXfFjSA6nLdnKJBKClxYP
	D9K8u04UslmIXP92hgBldnx/Pk+I7HyvywoK/Wc1oUEfA5/Nyc12ndm1M3hQ2iXBpvINuskDREk
	pkTnMXyo2ZiqUihkZLa5QSpB+UtEJx8H7qHpv0gLGYHZbWU8w9dxOHIO/iAmG85/SbbqyPg5ilU
	GSvR9XJNVPF2OO1Pz5mTZdhxjIaJA6pQ2korXefQdS+kMuw8AXXyb97LT8ZImaQEYilcWA23eRB
	QPjfUvze6GD10PAbgu6llb0n2FpE9ojP2EGt8cvsRqGBwsrVJqqTmS2y4cj/f2fCqtJuNcqkV3Y
	aNSPnpz+wz8tBA1SxgUJrfmiDaDQs6lNiTB4bJUcadsS0SxGrbOVLV7
X-Received: by 2002:a05:6214:5903:b0:90e:8be9:c384 with SMTP id 6a1803df08f44-9123d7b301dmr139360466d6.27.1789658138557;
        Thu, 17 Sep 2026 08:15:38 -0700 (PDT)
Received: from ziepe.ca (hlfxns010zw-159-2-239-150.pppoe-dynamic.high-speed.ns.bellaliant.net. [159.2.239.150])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91252cb0b52sm26856d6.28.2026.09.17.08.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 08:15:37 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x7Dpp-0000000CyZf-0zOc;
	Thu, 17 Sep 2026 12:15:37 -0300
Date: Thu, 17 Sep 2026 12:15:37 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jens Axboe <axboe@kernel.dk>, Alex Williamson <alex@shazbot.org>,
	Ankit Agrawal <ankita@nvidia.com>, Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, iommu@lists.linux.dev,
	Tushar Dave <tdave@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-rdma@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v6 18/18] RDMA/mlx5: Ask P2PDMA whether ATS takes a
 direct peer-to-peer route
Message-ID: <20260917151537.GJ3196566@ziepe.ca>
References: <20260914-fix-p2p-acs-v4-0-v6-0-5ef07ec9ef06@nvidia.com>
 <20260914-fix-p2p-acs-v4-0-v6-18-5ef07ec9ef06@nvidia.com>
 <321890690ce83d1943b2f678bd9bee9b8c895b66.camel@linux.intel.com>
 <20260917140253.GG3196566@ziepe.ca>
 <7d8118ee06f29b73988108c0892022b3a2626f1d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7d8118ee06f29b73988108c0892022b3a2626f1d.camel@linux.intel.com>

On Thu, Sep 17, 2026 at 04:16:57PM +0200, Thomas Hellström wrote:
> On Thu, 2026-09-17 at 11:02 -0300, Jason Gunthorpe wrote:
> > On Thu, Sep 17, 2026 at 03:56:12PM +0200, Thomas Hellström wrote:
> > 
> > > That is, a flag to tell the topology check that some transactions
> > > *will* take the host-bridge path due to IOVA being used, and that
> > > the
> > > computations including pci_p2pdma_distance() need to check whether
> > > that
> > > is possible (checking whitelist etc.) and return the corresponding
> > > THRU_HOST_BRIDGE mapping type. Translated transactions taking a
> > > short-
> > > cut using the bus-address would then be hidden from the driver.
> > 
> > I imagined it would work by the driver passing in what modes it
> > supports and Intel GPU would simply pass in ATS only.
> > 
> > Even something like mlx has variation, only some operations can opt
> > into ATS, many others are never-ATS.
> > 
> > Driver should not make statements like " *will* take the host-bridge
> > path" since it has no idea.
> 
> Yes, agreed, but anyway DMA-BUF would then, as part of the
> dynamic_attach negotiation have an interface that takes an ATS only
> flag and use it to determine whether P2P is possible at all, and use
> them at mapping time to set up the correct SG list (IOVA or BUS
> address).

Yeah, where I was going with mapping type was to have the core code
"DMA buf PCI bus mapping type" perform the pci p2p operations,
(especially the calc distance that has been open coded in GPU
drivers!!) and I imagined it would take in information from the
exporter and importer about things like ATS capabilities.

There is worse coming here soon people are working on multi-path PCI
and we even already have such systems. Multi-path PCI means you have
to select the best quality path from a NxM matrix of options and then
inform both sides which path you picked.

> Similarly the dma_map_page() needs to know these flags for p2pdma pages
> so that it never sets up a BUS_ADDRESS to an ATS-enabled device that
> didn't explicitly ask for it?

You don't use dma_map_page() with P2P, use the new interface and then
the details are visible and the mapper can do the right logic.

> And this all (and in addition the previous discussion around pcie
> subsystems calls from within dma-buf, and data-types for mapping
> information) makes me think that abstracting fast dma-buf interconnects
> along with our previous discussions is a good thing. Then interconnect
> details and cross-subsystem dependencies can be hidden in the
> interconnect implementations, suitably placed in the tree.

Right exactly, I guess Christain will be more comfortable if we have a
dma-mapping-type-pci.c that has all of this and only PCI drivers use
that code so it makes logical layering sense with the needs of the
embedded non-PCI drivers..

Jason
