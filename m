Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30CA3A27B
	for <iommu@lists.linux.dev>; Mon,  8 Jul 2024 23:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720483045; cv=none; b=f9bX2LtgN8xQj0/9rS0JOo8GEbx5Yx28moC32P5S45Z5s+38XXIUgrGjtSfcGjPqSk37yvywf/ffaoSbxusulXp8/wFkBFHf5sG8Y3owCTxz/KMtKrpZJQGToDUv9f81xP42QWMNc491IYzxr2JJggGbtbiUo+Ka7hvkwKUcTJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720483045; c=relaxed/simple;
	bh=p7iQjHJ2M5dwP07IVo/MoA0+Dlglnl6jpSoHPFEK4Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V9K3esKMNBpM/0ckNQTfK88wzSg3sxhS8vthNlYyXVAW/8bo8Iyi6XuWh7r5AdvmRzVvPoR8cwIKtUHakw8MRD9ZQbNQ2tD3xq+2jmfvSi2iZgSkXXuEMjF2q+21pfqp5MFQCKjZvMppeyNWSKuBiPx9kde0O8FgmA/Mz+qjVQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DH++N1Hw; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DH++N1Hw"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-df4d5d0b8d0so4423732276.2
        for <iommu@lists.linux.dev>; Mon, 08 Jul 2024 16:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720483042; x=1721087842; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=DH++N1HwxDek7HjLT+ZhtgfGSmKkAsdtF4s0P1I7lQwKK4SnQOrBten21zJagQ5snw
         Uk4gZJMZfvx6JZMnuTFrg2CTzeJ78pls3b8vtN2qlYriuYGRm7BswGLYez9sN5/XRfxc
         OeZFMWeKlOEkSwTex8tbzYe6jTOT7/3XgbanarKdmnUe3mdats0kNrzGiy2ZvAHO27nl
         ndmGROEFieweg/5sQXncuWkkLz8TcUHE417TgWN/iAfKdfObHvmRVK4c6GCDQjTiRCET
         iTm4Igv42usKv0uYP+z31laCu65Q7eNYTludYkMLT/D1cJ4lR3wTdv/g7Ul+zNd+FuvM
         KSvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720483042; x=1721087842;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w81yhK/4eC4FICM5BdCB5730Wjijfv+GUBmbab3qDKE=;
        b=B21BrsR4rtYg/kAwbXZJqpQF6q7Hqlulzu9AyJ0vFUVqp+V2iMl4NdRpy7hyNhi5ev
         SCiUBXKRJbXxY292mwMmkjx5S+VEvt1YDxP76Eejz3DOb2pamuGSfDLGlJzZ9CDDswK0
         OrgIGkoSKflCH/IXkbjY5WoyyA7RbuNgB/iDKe0woztTNwUOgIQs/BaZrHl1WOJZImy5
         ekKFVW9Il31nuip7+uUUnBwpUBxWKkHG0psqukUagQ1AQ+zfht1CULe1Zhy0T+K+a/Lp
         4UW566iUA2wuAC3W+mvpHv6u9mVxzvmkB5VG0brZP0fcmCZ/9ksPMlLWzFP7JQgewewO
         GnmA==
X-Forwarded-Encrypted: i=1; AJvYcCVTg1E1EAD+aWiOV5oARRxO3Xt6zJ8pN95kIT/6hYqheBeIFh9b1LAO+6Q7KQRZyJI0uPwdhupGgjWTE/U3EmPq232JN4Q=
X-Gm-Message-State: AOJu0Ywq9pK9rQJTGat285CcjC6NOWXeMxLSIksQzvO2kLp0D+a+ZaqJ
	khuAJmZuoFO9/IjGPHlsnbQgjD9pdLnTtN5T9+lLTNrlOEFXD9ZxfnK8xtODXp0=
X-Google-Smtp-Source: AGHT+IFVd0YPFm+CFj+OFAbn4VlgzR0c7GB9Ja/EMJb3su7krIj2ap0s4sP+8C7C1jj96rzmX8e+3g==
X-Received: by 2002:a25:d694:0:b0:e03:b14e:350f with SMTP id 3f1490d57ef6-e041b125e84mr1427037276.50.1720483042570;
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba8ad1esm3902106d6.105.2024.07.08.16.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 16:57:22 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sQyET-0014tP-5Q;
	Mon, 08 Jul 2024 20:57:21 -0300
Date: Mon, 8 Jul 2024 20:57:21 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Keith Busch <kbusch@kernel.org>,
	"Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240708235721.GF14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240705063910.GA12337@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240705063910.GA12337@lst.de>

On Fri, Jul 05, 2024 at 08:39:10AM +0200, Christoph Hellwig wrote:
> Review from the NVMe driver consumer perspective.  I think if all these
> were implement we'd probably end up with less code than before the
> conversion.

One of the topics that came up with at LSF is what to do with the
dma_memory_type data?

The concept here was that the new DMA API would work on same-type
memory only, meaning the caller would have to split up by type.

I understand the block stack already does this using P2P and !P2P, but
that isn't quite enough here as we want to split principally based on
IOMMU or !IOMMU.

Today that boils down to splitting based on a few things, like
grouping encrypted memory, and grouping by P2P provider.

So the idea was the "struct dma_memory_type" would encapsulate
whatever grouping was needed and the block layer would drive its
splitting on this, same structs can be merged.

I didn't notice this got included in this RFC..

The trivial option is to store the dma_memory_type per-BIO and drive
the de-duplication like that. The other could be to derive it from
first entry in the bio_vect every time a new page is added.

This same-type design is one of the key elements of this API
arrangement - for RDMA I expect we will need a data structure storing
a list of types with a list of pages, and we will DMA map type by
type.

Jason
