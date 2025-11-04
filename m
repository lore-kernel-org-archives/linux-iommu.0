Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C0C2D47F1
	for <iommu@lists.linux.dev>; Tue,  4 Nov 2025 19:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762284380; cv=none; b=BxgraQh7UNyDCc6jr/Stf0JNjN8WMucnFfvR/8aHDJ3wtxTxGSat2t0a3DE/fp77ejaGGdhB6iCiRjmQ2rI6Mm+upDaoVsS/UksGQQ0UxhxFxi2uPfsxkzb6QTOJvGQhGjZl6Xm2kQOl3nuSc/+6m7cyVSB+d4jOcIr2nIpFaZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762284380; c=relaxed/simple;
	bh=cCkLeU8n/VC4gjMMSvE8Q9FQGCPzymEWRBS/d9chZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8kfdqmPPvnf7D9R/sMamSohw6ydxj2dEJeLdn8nR4XJRorGGZ1U+3AKlStLgkbXP8lKFZmna6IC/rpED6evnyvSvSMDfA5/8X/pT1DdYeS/PZ4D3kamrOwVyl6AJfFn3HZwmUWCCmhSgbFTOWT1+kuECsijcS2cyybbDc2SiXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PqmrBisD; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PqmrBisD"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8909f01bd00so693334985a.0
        for <iommu@lists.linux.dev>; Tue, 04 Nov 2025 11:26:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1762284378; x=1762889178; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=PqmrBisDjsWc0dHrqy07Faks2iEE5ZapGgt1FumtJHvTfRLkmMRl23xk4TSVJXBaiI
         eND2cT8ftTDx0elH5JQdkVTKvQaLiNC0ZBfbg7VC1MHxYsuns+YQhdZtZLGv0v8/4f5Z
         /ygFgCSSjtvHCVKPjg2CFn8X3vJdcYrvGDcxp0bIWgNV6vH9Bv8DvT9+2hwDulGWb9hv
         TOW248QT0GWXHz/yM4b6hIsXpLs6zjyYufBSDOxSs/t4E3DM/rPxivGdvVUWGvL5pAoC
         je+JWRYuS+IuIRe7fATs2KCQ9g4ZV0et0AFg4XK5l9yM/tmGO0xi4gHTPuqAnRn+h24S
         XH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762284378; x=1762889178;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3vZ52GkNsJGLOkvon3L18RWVKcEn1c510aPuA199YI=;
        b=jJ+iSXeUgdFNYgAA11ihGker2TYCWJV2mj2zqDda0xC0m0nNPAlA5Iy3FE9b+lK9lW
         FL+xRgzL79KSveqQalDgPPEXH3Kg0JCNsoT+1BTzEYJ4HaIBn1zvMTMlbq5bhxoVAbHR
         VUZsHDZMBPKQVBms+bAjRtwkXOFQTyrrEDLju78QIgUw9+EAhbwc7hZaHHG/rjhIMT2R
         2YLsqad4XQuipDvxX00kQMBOdZf9gAzP2NYQ8OgA075KluGoeC6S0bj0fEcLkZhshhAZ
         kAdPIfvtk2o10eJzj5kexMJKyzKlqhyz4RnMXVKd2YAWhToun4lEvBpPPBo5GtG2MUXy
         mGpw==
X-Forwarded-Encrypted: i=1; AJvYcCUro0gWIHUTQv6+/jt44N5MQ/qC4isf40JX3QRlVaf8iHlZMDCkFe5XZ4IjLW6+dtXEPzh9MA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwPymrngqVY7kDkZ01Ir3QEzAAsbnvOaIzZklp9abGMZJUW5fBR
	1VoXnMyB+8FLfZ6b7e94kYGeeWheAbwc/rI61uaeFxjiol/wr8n0NlZLo9GKCLK/Vds=
X-Gm-Gg: ASbGncuQUe8/guiLsLz/I95st6NRS+A3fwl3hrjm0gagtvE4P4LCTQIYAupwEq0VeQH
	hYUSkaOOlsBpyvYId+gHkuhf/20jK1Imx4IZGYVKyA1nQB3oTR+7dRsYVmoqhdks/0PTxvFXEzg
	7tGUAu6vPHUMlF18RR3Asv2RcKGtkXgHZXeBcZkmsILSRgcnmGrLT4znLrC4rZJCI9ZRLw8blaQ
	ugLb84ARFKrrxgkZuZKUPGUBOerY9Dl0K4xNLaH3LxBP9AXzT7r7zS8cz7D/t7wAVrx9IxYyjFx
	a0LSjSZmRMOsc4yJGDdR6bF7IwO5vFnN6JvYJGKtyMear/KgpqFgHPuZSv/GEbxXOcP+tAujbWW
	UqAmp9gVMLbO5rnsWZGCZfdInDOA+f/vM3qjxT0ChcKuQUQsbTPbpgX2r6txNcOQ1016PPcjjOy
	frkjCOnHwTdbsz4+KMxtemc3mCI1jwjSSdUaPp1w4DIfvkxA==
X-Google-Smtp-Source: AGHT+IFUVGYM+r9VlnujjXwSiyntNScv3JSZn85Gft/uvY+ZvhCxVbalAnSefdp5Rhr2H4+z2gOTFg==
X-Received: by 2002:a05:620a:2a06:b0:86f:aee8:fcbc with SMTP id af79cd13be357-8b220b9ef27mr103417385a.79.1762284377655;
        Tue, 04 Nov 2025 11:26:17 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b0f7bb3e33sm250495385a.39.2025.11.04.11.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Nov 2025 11:26:16 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vGMfY-000000073Bk-1Ldv;
	Tue, 04 Nov 2025 15:26:16 -0400
Date: Tue, 4 Nov 2025 15:26:16 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Ankit Agrawal <ankita@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <skolothumtho@nvidia.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Krishnakant Jaju <kjaju@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, iommu@lists.linux.dev,
	linux-mm@kvack.org, linux-doc@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org, kvm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v6 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251104192616.GJ1204670@ziepe.ca>
References: <20251102-dmabuf-vfio-v6-0-d773cff0db9f@nvidia.com>
 <aQpRz74RurfhZK15@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQpRz74RurfhZK15@Asurada-Nvidia>

On Tue, Nov 04, 2025 at 11:19:43AM -0800, Nicolin Chen wrote:
> On Sun, Nov 02, 2025 at 10:00:48AM +0200, Leon Romanovsky wrote:
> > Changelog:
> > v6:
> >  * Fixed wrong error check from pcim_p2pdma_init().
> >  * Documented pcim_p2pdma_provider() function.
> >  * Improved commit messages.
> >  * Added VFIO DMA-BUF selftest.
> >  * Added __counted_by(nr_ranges) annotation to struct vfio_device_feature_dma_buf.
> >  * Fixed error unwind when dma_buf_fd() fails.
> >  * Document latest changes to p2pmem.
> >  * Removed EXPORT_SYMBOL_GPL from pci_p2pdma_map_type.
> >  * Moved DMA mapping logic to DMA-BUF.
> >  * Removed types patch to avoid dependencies between subsystems.
> >  * Moved vfio_pci_dma_buf_move() in err_undo block.
> >  * Added nvgrace patch.
> 
> I have verified this v6 using Jason's iommufd dmabuf branch:
> https://github.com/jgunthorpe/linux/commits/iommufd_dmabuf/
> 
> by drafting a QEMU patch on top of Shameer's vSMMU v5 series:
> https://github.com/nicolinc/qemu/commits/wip/iommufd_dmabuf/
> 
> with that, I see GPU BAR memory be correctly fetched in the QEMU:
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 0", offset: 0x0, size: 0x1000000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 2", offset: 0x0, size: 0x44f00000
> vfio_region_dmabuf Device 0009:01:00.0, region "0009:01:00.0 BAR 4", offset: 0x0, size: 0x17a0000000

Great thanks! This means we finally have a solution to that follow_pfn
lifetime problem in type 1! What a long journey :)

For those following along this same flow will be used with KVM to
allow it to map VFIO as well. Confidential Compute will require this
because some arches can't put confidential MMIO (or RAM) into a VMA.

Jason
