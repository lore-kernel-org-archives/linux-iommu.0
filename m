Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EAF82FA0F5
	for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 18:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758650981; cv=none; b=qajSpbXjzpstN4atXN7B+79auW9gbU4nUGQL+qkyuDkROaXGObK3PdyI+tcwOSycacCDbvphEfrreBTMYdVWW8L4M3dELT3xhQKrQLkJlBGG26jUttgUdmrR24tp3/qF9CtHeQr9T9r6zDrTYI3aNJ4YpitjF38kU3m41wVwyyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758650981; c=relaxed/simple;
	bh=heNGPwMdoK/TojT+3JCMQol9WuwGJyrL7m6JFryZsqs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGgi8QPG88Xzqw4MURLPqe7R6MSeTUerDan4PVopCodcaBOwIUPZOgWL8xjmHbHlqwcuCfRK9CZtVtP7HZj+RelCXdjlZsgkRAe80X/gFLPZZ3ILJBSyFVUOBc28nrJy4k3pbFn83vq8fzClIdUZkR8Gg/hcJh7L1iV7FS3aCMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Wu3+Idr1; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wu3+Idr1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758650979;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mQIcre9d/GLURHCzSftYDLgKY/Tx/WICcqQ2djA+XCg=;
	b=Wu3+Idr1vgL45fO3YQWIOOMDHVJsR4H6CYGAhb0Kdp23K6JVmXyszsv9AfqcMhW8pKHX28
	xMDYRfyaOIJSEeR2ryJCm8+2cKdyPGQdKkNYCQkQXGKWBf4Ll89ORGtHBQDg2CHF8fS9Xt
	brAIwhdqX/rDu7Xd/xNHo+ytfx94tn4=
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com
 [209.85.166.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-5I11-2KyM--hKTPr-tpbvg-1; Tue, 23 Sep 2025 14:09:35 -0400
X-MC-Unique: 5I11-2KyM--hKTPr-tpbvg-1
X-Mimecast-MFC-AGG-ID: 5I11-2KyM--hKTPr-tpbvg_1758650975
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-889252db9feso108046539f.0
        for <iommu@lists.linux.dev>; Tue, 23 Sep 2025 11:09:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758650975; x=1759255775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mQIcre9d/GLURHCzSftYDLgKY/Tx/WICcqQ2djA+XCg=;
        b=iS1DFr6pchK7mTsj5j4IIbhZu03ZI1+9D1Nchy5eR11FVF0nGtjC9te1Z2R7XtOD9h
         n6/zQ7NC6SJllp60dLrcotLdqP7hLfpErJeGJDcqJpjaYywpIczg193KHmO/sfmPNAIA
         NTzTCBnI3QTw0XqvZRQXW/3myY5nkrQqvqgU7PoCc/TGQtbz8BD5RWXkniSER9L1OjQ6
         oV/pr3Vyu0GotgN+NPWmsEVa8Ewn19rqeFzATM92AxZs76ChfO07jV20IE2jAmMd2eCp
         8TAqU5Kswb1cryHu/OJQgYuq3dKqXvX2KiKnTfbM8fPMj6dfPp6M7EkTCDxcdpN2qbQu
         ozXA==
X-Forwarded-Encrypted: i=1; AJvYcCXRET6zhTeTtmE2pYikXxqxk7OB4Vk8mdVmt3lktJSg4jQ4bWeqS0fH8xgYkJs2DgQb+b5kXg==@lists.linux.dev
X-Gm-Message-State: AOJu0YxfHwgPltxjdT0cd72bUNh+HJuq8IRCbuWQFABHK/I+1uVcOkV0
	zxubaZnuVVR5+Pd+uBZzJBHwPnzibn7Cf+Sic0Hf+ynMQ8dAFK263mXh9P6h5Lij2ebwaD78LVQ
	FFhDSAFXPzVU6ulTE9vSO5lIeYDHPChAV6/YUh/ypOLePZ3VUT3HJ7erM
X-Gm-Gg: ASbGncvppjw+L4COnGgcrycQBVDNzgfDr3kMQWCL9/6fGOsX+vLjesdHquYusJ32Wx1
	EbgWu1pp4c3prbSRHIo2foutIJvvKIR5HLr5CUSoSpA0GW/Rx9R3FFrEFPS0CxeTd2kEfLpcFUg
	xO/jA/OD0xcVuVPNIYkWPZbN8Y+lEKYmZnYq/O7FW+7J/wptzem/g4/Epnzz7JhbAc3/4TggGPG
	oQlaNkvElKcy4x+FVMrKsmpAMzskPqctKOxG6Dgdxl2moNHkTj7vJOpDw7BDWZW5PoGDj4CQ1e/
	0+Oke9PPbwCz/2tBANswDl6Kt+mcwCLhm+VV9TVitZ0=
X-Received: by 2002:a05:6e02:1528:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-42581ea129fmr20080535ab.5.1758650975103;
        Tue, 23 Sep 2025 11:09:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFq8NLMhZ8QXjx/u5jq96UNETG/D0tlVJnMFlvqXnog3t1PaipQH1rILjZIuw/YRGMbPtKiFQ==
X-Received: by 2002:a05:6e02:1528:b0:412:5782:c7c1 with SMTP id e9e14a558f8ab-42581ea129fmr20080265ab.5.1758650974546;
        Tue, 23 Sep 2025 11:09:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-54f69c6262esm5209728173.79.2025.09.23.11.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 11:09:33 -0700 (PDT)
Date: Tue, 23 Sep 2025 12:09:32 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, dri-devel@lists.freedesktop.org,
 iommu@lists.linux.dev, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, kvm@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org, linux-pci@vger.kernel.org,
 Logan Gunthorpe <logang@deltatee.com>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, Sumit
 Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250923120932.47df57b2.alex.williamson@redhat.com>
In-Reply-To: <20250923174333.GE2608121@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
	<20250923113041.38bee711.alex.williamson@redhat.com>
	<20250923174333.GE2608121@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kIg2C-BZi2Lh1grZcP-dRvt9enQN4E5krmqJDXJmtDo_1758650975
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 14:43:33 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 23, 2025 at 11:30:41AM -0600, Alex Williamson wrote:
> > On Tue, 23 Sep 2025 12:04:14 -0300
> > Jason Gunthorpe <jgg@nvidia.com> wrote:
> >   
> > > On Mon, Sep 22, 2025 at 03:00:32PM -0600, Alex Williamson wrote:  
> > > > But then later in patch 8/ and again in 10/ why exactly do we cache
> > > > the provider on the vfio_pci_core_device rather than ask for it on
> > > > demand from the p2pdma?    
> > > 
> > > It makes the most sense if the P2P is activated once during probe(),
> > > it is just a cheap memory allocation, so no reason not to.
> > > 
> > > If you try to do it on-demand then it will require more locking.  
> > 
> > I'm only wondering about splitting to an "initialize/setup" function
> > where providers for each BAR are setup, and a "get provider" interface,
> > which doesn't really seem to be a hot path anyway.  Batching could
> > still be done to setup all BAR providers at once.  
> 
> I agree it is a weird interface, but it is close to the existing weird
> interface :\

Seems like it would help if we just positioned it as a "get provider
for BAR" function that happens to initialize all the providers on the
first call, rather than an "enable" function with some strange BAR
argument and provider return.  pcim_p2pdma_provider(pdev, bar)?

It would at least make sense to me then to store the provider on the
vfio_pci_dma_buf object at the time of the get feature call rather than
vfio_pci_core_init_dev() though.  That would eliminate patch 08/ and
the inline #ifdefs.

> > However, the setup isn't really once per probe(), even in the case of a
> > new driver probing we re-use the previously setup providers.    
> 
> It uses devm to call pci_p2pdma_release() which NULL's pdev->p2pdma.

Ah, right.  So the /* PCI device was "rebound" to the driver */ comment
is further misleading, a new probe would do a new setup.  Thanks,

Alex

