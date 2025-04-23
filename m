Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E0525C825
	for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 17:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745427624; cv=none; b=dDPKeBJzSAMH6p8xtOjbQXfn4+NJYPfTM2cBH1YnpV5t4gWZxEV+AuA45AR7qH2fPOIfkz6YJKmn/+6FgzLGJTkvBZ492NI40nkefZMV3G3rW/2aEwbxyLhr3dM1oOV2vLGxGNfQMuoNzODaQeaAwhEuc5mSZjeBrIJU+G4xsWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745427624; c=relaxed/simple;
	bh=Oq+RUVKXoierg4o0zQGaueU+iLWLxzwb7ZA+t/XFi9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JdDamWCZweHXydtbnwb6gv4yD37n9CiME2nHEziUuhYgFFp+69qz59d2e5sjCfK7Paud/kxXULrcBT4n0ObRigdreKNw7YP5YDlFV5ODOCjTiLHADeETYVMZXpefbyYD/ebOoADGNv1ADIUflbhKX3IhyLmQK0XR2IAxkpZJToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=AHTVNFMq; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="AHTVNFMq"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4772f48f516so13363901cf.1
        for <iommu@lists.linux.dev>; Wed, 23 Apr 2025 10:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1745427621; x=1746032421; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=AHTVNFMqBzP4RTyUH+Yu2ze2j/0TsSucBENmDduRpeag2SN4A5H8riMZTIDd9y/c0e
         pvCAvnmCE7aY6fckrRQoy+SxiUuGSz+LkjYULwGWfRLePxCOoyluOsAjFqktKz4gFQ0R
         ZxRxxPIdPvUjU26o3dCTUYSW78L4wyPxZd/kk111rS7bWG/nosmj+oHIrMD9t9TcjUQk
         7RRctSbbxApr2FGcCVIL+fpjOCY1A6Faxxqmu+wba9mwAsBD9hOm3e4XnlRe4uQimE6a
         W2PYlMhq1AsC/jCzeluGymcwnqBv3YMYUeDtILI1KPxsk9XTK2Vn94tEwZvUeCzBnEvj
         GkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745427621; x=1746032421;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wWxVg46eMCFdiWQ6X6K5wh7BwyllE/TFgcnWyILw7vo=;
        b=BsbzppsHuwTqOf5W84DefQpl/iC40pHft80Ybx3kE4tDS3R3nFsD6nYJxXJlSsnN6q
         /JvPFQZKvfJeXJN1sBg/tlUNp0K6VcX1vpEoTqIJnEkIqgzjguswMICSPHQ+8hqJMSu9
         yUFXS5MMkea1N7+sVnxlr1VoaGJ3rGy0DNmlD9SWSGmPGr/lTn6V9VfF/LTHKHa7VYak
         1XtFVdXYTEgnyvbFZqKTpnPE+f6NAPpYNTvwi5RJX53qkrU88Rq6lq07vvpEwL1cFY+F
         UKs7cDqPc31s8Ke6P+cRqMPQqet9euJzKNL5fQkalvuJr5tdj+Kz+pB8Z6YYt1CcO1/4
         tiAg==
X-Forwarded-Encrypted: i=1; AJvYcCV3f09UbtgYnueSNwaMoZaE3503coBKhyw1kMwy4Hft/5Dm79+JA6P0/HEHTkkzOPZ5j7YimQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9jP911zBwVhORtoY6KtAes+ieBERffk1nI+AVmXn9vImdoZja
	KLzO/GkgVh11RP96Mpfx4NFOhnFjg25j5iKxPijbkWlgOyid1r1H8ijEvy+FjPk=
X-Gm-Gg: ASbGnctpmnmr7JWAFRyEeQnu1u34NIV4tGmTBNsLBRyaFfK4d234KMkSvs+1m/8J203
	NmSC9N1vOr9ZlVr0GSwylzj7aznGtOwF157euXM7Hr8roqeILRf1HdRb0EnKM755tpw+A4DTRvu
	Q6fJmC7CnrKnmmSZAEB91Ne/MMPTGw7lZJfFm1PEY8ytm+IcvMxxJRoxtOs5cl5LUW6gc9PZSG1
	QbR85d+1+k2nV8EI1a6ftZ06uQueYmfVqm5s7+3mVCBGMkIWT4z9ZBc6z/MwQ9HJ7icPs+Tjrnp
	6uww23pNXU/7497Zkcfds3uQOM5q7MNAqS2XgHlH8qZMi3wBh0vwoJkK7hnKtVf/RSnXbylqlEi
	VTNdkt9lFa/XeWKpgHRe4teMQSxh0mQ==
X-Google-Smtp-Source: AGHT+IHksHmB8zXVAbJv0K8R7XmlcjQan86yStXGt3YpvcZVpCrvagDTNNdOsaaJ2R0ZGC6sR1O+4g==
X-Received: by 2002:a05:622a:118f:b0:47e:641:9665 with SMTP id d75a77b69052e-47e0641979dmr20773641cf.5.1745427621264;
        Wed, 23 Apr 2025 10:00:21 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-167-219-86.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.167.219.86])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2c2bfcfd0sm72347416d6.82.2025.04.23.10.00.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Apr 2025 10:00:20 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1u7dSO-00000007LHo-0vIz;
	Wed, 23 Apr 2025 14:00:20 -0300
Date: Wed, 23 Apr 2025 14:00:20 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [PATCH v9 23/24] nvme-pci: convert to blk_rq_dma_map
Message-ID: <20250423170020.GI1213339@ziepe.ca>
References: <cover.1745394536.git.leon@kernel.org>
 <7c5c5267cba2c03f6650444d4879ba0d13004584.1745394536.git.leon@kernel.org>
 <20250423092437.GA1895@lst.de>
 <20250423100314.GH48485@unreal>
 <20250423154712.GA32009@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423154712.GA32009@lst.de>

On Wed, Apr 23, 2025 at 05:47:12PM +0200, Christoph Hellwig wrote:
> On Wed, Apr 23, 2025 at 01:03:14PM +0300, Leon Romanovsky wrote:
> > On Wed, Apr 23, 2025 at 11:24:37AM +0200, Christoph Hellwig wrote:
> > > I don't think the meta SGL handling is quite right yet, and the
> > > single segment data handling also regressed.  Totally untested
> > > patch below, I'll try to allocate some testing time later today.
> > 
> > Christoph,
> > 
> > Can we please progress with the DMA patches and leave NVMe for later?
> > NVMe is one the users for new DMA API, let's merge API first.
> 
> We'll need to merge the block/nvme patches through the block tree
> anyway to avoid merges from hell, so yes.

RDMA has been having conflicts on the ODP patches too, so yeah we need
a shared branch and this thing into each trees. I'd rely on Marek to
make the shared branch and I'll take the RDMA parts on top.

Thanks,
Jason
