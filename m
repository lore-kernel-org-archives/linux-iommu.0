Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00921305065
	for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 17:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399784; cv=none; b=kJGlWW1dBVRPkUKzHF6UTpH8o5sIVsD1VLcn/fdljbWvnxvWJ5BMJvqFLAJTtsxoY5WCgCSRuDD/PNLtohgoMA4KCMzJK/Dqp6e+FwIgsSVjr0Nyvmj4Ol+6jzLn77j9Suv30qFC/sEpdw/Qu4+/DKrrIxX6xDCFwvhwBrsxh84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399784; c=relaxed/simple;
	bh=2sNLnkk8V5VHxiND7V+FoGQrjFZ2T5dAZtQ/cFM2bC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SKJDzS8dVrqiOzrX7YBMkm81oYV5Sfzei3ghR+TZu80DLF/FvGUvNm+lq6lPIKDkU5NSlw8wcsrvYJpp973lSyurqMqnNu6g/j0h1+WZBovXOruIw2ualjUqs81kpUeJ9RXSZccwAzG3rBLfl4CyqAzQs16UsMah2QK30275c24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=VWwq7IHx; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="VWwq7IHx"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8b28f983333so468243885a.3
        for <iommu@lists.linux.dev>; Mon, 17 Nov 2025 09:16:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763399780; x=1764004580; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P1EKuTl21MaZwOVAnrWkECo68IZFcqZRr/UNlppTPmo=;
        b=VWwq7IHxdHd/zEuD/AOerGa+VeVxiWPSKDLiZ8ApUEs6DPTmbdj5COsq9cYY/TtDVG
         sJNt34zty1m/Sk9LqKwCVhhYhhrHRv2SWZI4d8HV/90/rG0MNYDmY/x78exs0G9c/XJY
         dU7LqlgXv7smn4SPHbVrLZxOqMnu696OTNXsnNMbN5P/kcgJpvIKkuau+agDRSMzEi3Q
         TCgfF9Ay7gcm1AT9ic3Lvw9kG43dL+QgLQyUPxMcyrjtQ+l4drsiipN8RWY2vQ6LLPs+
         VOrWVTX5pPvu90UnktjOItHeYkbZjf7aw408Str4YWGqRQyxz0jQKSiE6udlniQC5Zmh
         r+Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399780; x=1764004580;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P1EKuTl21MaZwOVAnrWkECo68IZFcqZRr/UNlppTPmo=;
        b=pF+6k+g8KwtW5TsvJXXYS2+pEmVVJeu6TMAgqsLxrM5sfo7P+afdwyDCQz/SS5FAdw
         gjyno3WX8aIsJk9g2BuO+tTzP+U2KI00oX/GrPy4qtJHlkBIxxMr+Xq/lCtj/m7ZJfem
         jjDAS6eJ9P5HL2jZdsgzXOKMZ0871N/82Z/M2I8TfAnxsEtX0JiK4cqfI1uaGVHqrqIS
         iG6O6tEADVxpMO9hazWVwXvt7ylvFPMh1BCL8KBsoD7P8sKZmEt4wF7G7c5x5i/4Njth
         auE/QZC9U5l4RBwv99TYCa6sYfKZBq2/rWBpBPlwHHCKNsceyEHAAnP01j7ZJ+0BQtvy
         LXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcjU1WIzMXa7tZOUmGKB4Iw03MDC/lw0jDGsJ1iw0a+2jB9QlXrrcF7h/EYCDs59rb2iJNeg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzE0Rwf4HTlboD8INIOUpr9kIKJA4ML6PyqrGJZVSKrbtE0fSo
	9mhxw8iuq2/jHrwMZxz1mhdxTFWi406AM3NRdooVy5v4smBwEFdLJ0gjenpjM3+F3Lw=
X-Gm-Gg: ASbGnctighF7T+A5Tyygz7wrSm0EUM2F9RKPnYLOiRB9K2sA60lUr3gDiWQQmGdvApS
	SvgelGL27yMnfSNsBKTa+SWTmCVrFPusMg6V53tml7I/ZEyIXbn8/9h5ZA5w7NS7OsTexKPxKtZ
	Krhtt8lM4l3tq17mrhLQD+i4G9wT+fVt8qvw60rjUBkrJIHFH3QPPPprtYEZw3qVOihx+4oQcv8
	6M8fNaH6mQ3pX9OSOBG6sxyCPCQYrFcHXLV4EzgP4KznMwgdxBVvoEYspPxidzGhxkcDfGt8Ddl
	v9htSk3sSZYQmfoQoSF+pMIEGO+FZCgBEs5DYdFXZdCD8ZRVcvwu4GcNA4JGpXNZ++Gon+4co/e
	ezzFPf/bN/MS2/qXFvGhsNGHo7/W6G5sq2iVHgehs4+Q56jnsuC6Duu9UnBpZ0k83QFN9ZdAnty
	QwYV5lB0esRVoZVr6E2DmeYZXj4TZ2nEiCUyRQROz3ei2iwnq+zIIf7u8Q
X-Google-Smtp-Source: AGHT+IHdomOA3fXFLRj5Qifi24Z8ILoy1R2tZQWL9HXByV1pnhKykseLX/aaxM1vhUTUzCoPwrvJjg==
X-Received: by 2002:a05:622a:22aa:b0:4ec:ef20:ac52 with SMTP id d75a77b69052e-4edfc87511cmr159168241cf.79.1763399780286;
        Mon, 17 Nov 2025 09:16:20 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4ee1c21ea34sm32656311cf.30.2025.11.17.09.16.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:16:19 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vL2pv-000000005PX-0G4a;
	Mon, 17 Nov 2025 13:16:19 -0400
Date: Mon, 17 Nov 2025 13:16:19 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Leon Romanovsky <leon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>, Kees Cook <kees@kernel.org>,
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
	linux-hardening@vger.kernel.org, Alex Mastro <amastro@fb.com>,
	Nicolin Chen <nicolinc@nvidia.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>
Subject: Re: [PATCH v7 00/11] vfio/pci: Allow MMIO regions to be exported
 through dma-buf
Message-ID: <20251117171619.GB17968@ziepe.ca>
References: <20251106-dmabuf-vfio-v7-0-2503bf390699@nvidia.com>
 <20251110134218.5e399b0f.alex@shazbot.org>
 <da399efa-ad5b-4bdc-964d-b6cc4a4fc55d@amd.com>
 <20251117083620.4660081a.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251117083620.4660081a.alex@shazbot.org>

On Mon, Nov 17, 2025 at 08:36:20AM -0700, Alex Williamson wrote:
> On Tue, 11 Nov 2025 09:54:22 +0100
> Christian König <christian.koenig@amd.com> wrote:
> 
> > On 11/10/25 21:42, Alex Williamson wrote:
> > > On Thu,  6 Nov 2025 16:16:45 +0200
> > > Leon Romanovsky <leon@kernel.org> wrote:
> > >   
> > >> Changelog:
> > >> v7:
> > >>  * Dropped restore_revoke flag and added vfio_pci_dma_buf_move
> > >>    to reverse loop.
> > >>  * Fixed spelling errors in documentation patch.
> > >>  * Rebased on top of v6.18-rc3.
> > >>  * Added include to stddef.h to vfio.h, to keep uapi header file independent.  
> > > 
> > > I think we're winding down on review comments.  It'd be great to get
> > > p2pdma and dma-buf acks on this series.  Otherwise it's been posted
> > > enough that we'll assume no objections.  Thanks,  
> > 
> > Already have it on my TODO list to take a closer look, but no idea when that will be.
> > 
> > This patch set is on place 4 or 5 on a rather long list of stuff to review/finish.
> 
> Hi Christian,
> 
> Gentle nudge.  Leon posted v8[1] last week, which is not drawing any
> new comments.  Do you foresee having time for review that I should
> still hold off merging for v6.19 a bit longer?  Thanks,

I really want this merged this cycle, along with the iommufd part,
which means it needs to go into your tree by very early next week on a
shared branch so I can do the iommufd part on top.

It is the last blocking kernel piece to conclude the viommu support
roll out into qemu for iommufd which quite a lot of people have been
working on for years now.

IMHO there is nothing profound in the dmabuf patch, it was written by
the expert in the new DMA API operation, and doesn't form any
troublesome API contracts. It is also the same basic code as from the
v1 in July just moved into dmabuf .c files instead of vfio .c files at
Christoph's request.

My hope is DRM folks will pick up the baton and continue to improve
this to move other drivers away from dma_map_resource(). Simona told
me people have wanted DMA API improvements for ages, now we have them,
now is the time!

Any remarks after the fact can be addressed incrementally.

If there are no concrete technical remarks please take it. 6 months is
long enough to wait for feedback.

Thanks,
Jason
