Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434E41A0719
	for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 23:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720740109; cv=none; b=jSxpeZeffbgpZUT71fSdyGn+fZe5A9iI3RKK8GWB7VtwBd592WwmmblKNeN4e/KdyrBKsnJ80x4exU8FDrXqgDAVlwGcY4xO3JSyd7XIBQrGyQE/DiFSWibFb4jgO3lAGVPrTmFym1+eGa9xJ++jmfcuYGTnR68iOyPhAItpt7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720740109; c=relaxed/simple;
	bh=yBzw/fpawDv/KPcPaY2/FkE3DGz3iFhkQCMcidhYJy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WTDoXEWj4/cVPtyOIzzigmV11YJJFBio5t+0nvv1Qsayh71YxCmyk7zseKpdoENk7n3P4sQLaajCkONv8MEivYpSqLDxp9qPeEoYskwEd/zXH+1PLeSSsjHzDzzROcTqpLxUsGWe0Uu8U/n7Q1QzLn9WUQ/ctr8tlUxF1cX9dyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=DLSLiCs3; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="DLSLiCs3"
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-447fd75f9aeso7553271cf.1
        for <iommu@lists.linux.dev>; Thu, 11 Jul 2024 16:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1720740107; x=1721344907; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iA5EkoKdOMHWMqTqv30k2JtFjPGSRguy2LMuZP+mDPQ=;
        b=DLSLiCs3nq3uUN7coJNeTMsHMwWzUgkQFT19iiBxXppt5MuUXZ+61H+14LL8RJQsVf
         Uz9u3eHQn8hodHJImjaNrVRkMWxh6iLlJFuFQKnj9xZjxVQKmm419XmH+iccheBv9hfo
         kbtnjY7wTKFcppOurnMACFYGsuPyHLOKF009gcF4GY1KOUr2yncoqhusTQkT7C0zy77t
         WUEYQ3CLS6NUcwbxzsJSNGJatglDHuRHiqNNo5cxd5CYDGbfFBnkPgC38UkDPPguqBxn
         5jgZoxtr0E1QVhNBXeI/FvrTsKOJ4OoOosXRkTmKtq3L5GKjRLr6iRYW7+hunhPfyMQC
         qBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720740107; x=1721344907;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA5EkoKdOMHWMqTqv30k2JtFjPGSRguy2LMuZP+mDPQ=;
        b=u31kgfZ8k6T0fvFJolmjupWzqPVK+4D9sGseiydcwbSV+LiOWo/JS/2RJmQFES/79D
         XHX6etf/Fk5rwPVdQJtqy47GcG2OO3nQ11JsaCe9Y8sj+I7LoaXTJD+gjPhGR5/C6221
         1XapuJr/KDndSLVvsXFZIZFAjF9ddwRLXSJxt/w5IFi/nyYsJtWCcDnOSKydpHtbuqxB
         3QFV4sEcfefqpDz2KQpevhV3B1wsWj28gEs/lPlOrY4WJIGx3VHZruL43yDuzdSxHXyj
         9+Ow5FJnY5jkw0n7teafF1wfqJq1xdedF+G85mAKG7IXuEGzMwmoA10BeeV4hL8nCXS5
         hCmw==
X-Forwarded-Encrypted: i=1; AJvYcCV1ae6ZK2mCj6zD2HkwFZxZu8xrIoUaWdkp0WSnqJ+62Ac6Ujj4Ml+kOqtO9h/GLB6p4xzuV/Tfye8//Gyt6iFyBiWhhro=
X-Gm-Message-State: AOJu0YxfMtf0H1DBOnamiBRe9DINQuIGlQoD5MEQ8lwujqB1gtid9+fo
	CqM/3l8Qy16n2FzK4ThwcUwD0D/mtEXI/lrGVkrVhh7fhwoecRSP2WBDD6eHlD4=
X-Google-Smtp-Source: AGHT+IE3EReOFfP9Gp9yOBbEQdd9ZoxHQTHmzRvm3onKx9Jai/yPhMccTCjhIICDfGTUxTuCo6A+VA==
X-Received: by 2002:a05:6214:1c83:b0:6b0:6a57:c982 with SMTP id 6a1803df08f44-6b61bcff6edmr121290886d6.28.1720740107241;
        Thu, 11 Jul 2024 16:21:47 -0700 (PDT)
Received: from ziepe.ca ([128.77.69.90])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b61ba7a437sm29827036d6.85.2024.07.11.16.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 16:21:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sS36e-00FPgi-P3;
	Thu, 11 Jul 2024 20:21:44 -0300
Date: Thu, 11 Jul 2024 20:21:44 -0300
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
Message-ID: <20240711232144.GQ14050@ziepe.ca>
References: <cover.1719909395.git.leon@kernel.org>
 <20240703054238.GA25366@lst.de>
 <20240703105253.GA95824@unreal>
 <20240703143530.GA30857@lst.de>
 <20240703155114.GB95824@unreal>
 <20240704074855.GA26913@lst.de>
 <20240708165238.GE14050@ziepe.ca>
 <20240709061721.GA16180@lst.de>
 <20240709185315.GM14050@ziepe.ca>
 <20240710062704.GA25953@lst.de>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710062704.GA25953@lst.de>

On Wed, Jul 10, 2024 at 08:27:04AM +0200, Christoph Hellwig wrote:
> On Tue, Jul 09, 2024 at 03:53:15PM -0300, Jason Gunthorpe wrote:
> > > That whole thing of course opens the question if we want a pure
> > > in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
> > > way to migrate and allows to share code easily.  We can look into ways
> > > to avoiding that more for drivers that care, but most drivers are
> > > probably best serve with it to keep the code simple and make the
> > > conversion easier.
> > 
> > My feeling has been that this RFC is the low level interface and we
> > can bring our own data structure on top.
> >
> > It would probably make sense to build a scatterlist v2 on top of this
> > that has an in-memory dma_addr_t/len list close to today
> 
> Yes, the usage of the dma_vec would be in a higher layer.  But I'd
> really like to see it from the beginning.

Well, lets start with agreeing on this layer's API and be confident it
can succeed.

Then I'd say to look at RDMA as it is a logical place to build such a
data structure and we can build something that at least does what RDMA
needs.

I need something anyhow to plumb through to DMABUF and over to iommufd
and VFIO, can't skip out on it :)

> Yes, I don't think the dma_vec should be the low-level interface.
> I think a low-level interface based on physical address is the right
> one.  I'll see what I can do to move the single segment map interface
> to be physical address based instead of page based so that we can
> unify them.

Yeah, I've been talking to Matthew explaining that starting at the DMA
API makes the most sense and lets remove mandatory struct page
entanglements there. Then we can start to examine other layers. Having
a consistent option in the DMA API to be physically based with a
memory type fits with that plan.

Jason
