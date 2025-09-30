Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0994A24DD17
	for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 16:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759251177; cv=none; b=lQX0bBQNN50GSfJnGH1hVOpTg1q07VB95AhYVcyJZong4pB35Et4lP+63zKYSnIGywm1k8f/G1BAdh0jLr3kJOIHn/vPCxVbvhAg2Wswtf3vc7DfsistSiGyvGG4lExP6q+Pbm+Hf+CxpaJWGcVEvikvpf/AuhW7nz9sgJDrGxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759251177; c=relaxed/simple;
	bh=XRHExvG/tHB5daSSKAmQDIMiwtytKVKqlEgrmiHYtGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qSyw7WXaPIFEJcOqCnIsV+OHTlcADybNFjcYdl4VpC6jk6+TQwedQx3xSjCPmYXHY0dTqy2zsY4DUA51HmLu/uRQlBhtU0lGFuXwTzfb7emp6MOPywg1uZI8W0eZbpE482nDLAPZqzcQ0TS8TW3sDnPCzU0scyVh04wbt5egAWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vqv5fCoP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vqv5fCoP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759251174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
	b=Vqv5fCoPJsFpQpOcGi4QzlO6fyB6h4baM9yeez1DkF2ghIxKbNAvlgfjGzFcKGqOTaIegB
	2eioKTpINTx3jiv+2qishAg/z9Wt9+QCnTUWpOS6dsabugPFICwoyDw/20KTMgHvuzBw7Y
	0kCMNIutvEjIkGFgFww8bwAtUgZOMno=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-uWNcWKupMe-eST_rhMfqRw-1; Tue, 30 Sep 2025 12:52:51 -0400
X-MC-Unique: uWNcWKupMe-eST_rhMfqRw-1
X-Mimecast-MFC-AGG-ID: uWNcWKupMe-eST_rhMfqRw_1759251171
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7aba0808204so1557670a34.3
        for <iommu@lists.linux.dev>; Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759251171; x=1759855971;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JryoONnZtvrch8iWe5kQa/bp3US7CnLH1VFoC2oPQRw=;
        b=phf8U1Fl1R0ps2i6euVzqLanYwVHKXhWUSj0OehxynvprcFd4HsczR5yzLBDCWSb2s
         S0s8c/i5YDXwEyoTJR+mfIcm8e2aei0y3LOSD2jzeeJd7B+4hfVKR2bJri6Lqx/qrTGI
         tP9umDRIMKTslKU6ZUht0cNfgjzbJl4TUBQIsAP+nlqoRckssGdPtEUudSjQSFWV4AAm
         3ZzqT7jaacdptc6ljEmNsTU5bG1S6dJZL6pcxPWKZY9EI/dNKyD49TvTWqDnFVYO3Uhm
         QgCI/uvCC55LE8arnRqsSGiUNnLzmRP5tPH8OalGOlGYnXv1/ArWeQQjE1ky8i0GqN6e
         69Jg==
X-Forwarded-Encrypted: i=1; AJvYcCUs6FhF2eTYRqdLbHquU4+J3BGcOGA5A5ObI1mHwk8jWvvB/pHE0aCEZIbYkNOLKEcSlOykeQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx2y096W8JaxQpzaKr1p5LYceaVuacHuKOqo3fq753aIvz9dwbI
	WV0N2OIebJFzYytXIV65nrbUQoZUZq6yYpMkJs7k7tUsZVDJVEgJkuvMvhZHy5voQ0WCKtHnrdA
	zrLP3l+ePGAOSYI8aOTxuTXR3PVbAshc0vhpNFwd7WEhosyh/i2uVagjK
X-Gm-Gg: ASbGncu5vMK/bPvDsPYrNKN7boqXfHzDNmynHB8gv7GG6N7KIP37ColCWfQ2d6saWH3
	PRZy7YXuNtbK8NBM8JVEo9EXLztFIQ2PqKSH2U/dXm530qMjOnLcPoc0lbvIK/kf3gGmq3TUh2s
	BWlEEE7df9GRroCKRsNCzvjZph8PirS3NI2dt+9+iqWaZZa4lWMj8XgBChgByCpDuDio6Egc5is
	bJbQe7Bdv9gNVKrAp4iQmlprFvNjXTZFOQ/BHe2WaC6/7e5kXiQXx+XN1v5pde33hhrD+HVnTiN
	FcRm3xkx6GCDtVXfQ7t4RgY3MghoFD3zX8lsgGGlxVlLVcWt
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82470b6e.3.1759251171052;
        Tue, 30 Sep 2025 09:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwZ3/lKZz7Fdu2TvHNlTbKRk5qveSl6rvSejYaxAMAP02EZ6HQb/uugFp+9XcOcN4obhcZxg==
X-Received: by 2002:a05:6808:f86:b0:438:33fd:317c with SMTP id 5614622812f47-43fa41bd61fmr82463b6e.3.1759251170626;
        Tue, 30 Sep 2025 09:52:50 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-43f51238c63sm2746753b6e.22.2025.09.30.09.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 09:52:49 -0700 (PDT)
Date: Tue, 30 Sep 2025 10:52:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Shameer Kolothum <skolothumtho@nvidia.com>, Leon Romanovsky
 <leon@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, Jens Axboe <axboe@kernel.dk>, Joerg Roedel
 <joro@8bytes.org>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Logan Gunthorpe <logang@deltatee.com>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v4 10/10] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20250930105247.1935b553.alex.williamson@redhat.com>
In-Reply-To: <20250930143408.GI2942991@nvidia.com>
References: <cover.1759070796.git.leon@kernel.org>
	<53f3ea1947919a5e657b4f83e74ca53aa45814d4.1759070796.git.leon@kernel.org>
	<20250929151749.2007b192.alex.williamson@redhat.com>
	<20250930090048.GG324804@unreal>
	<CH3PR12MB754801DC65227CC39A3CB1F3AB1AA@CH3PR12MB7548.namprd12.prod.outlook.com>
	<20250930143408.GI2942991@nvidia.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Not5ZIGIIdvJ2bawUcWmAACPiAjJKAu1tRpwUFhb5Y_1759251171
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 30 Sep 2025 11:34:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Tue, Sep 30, 2025 at 12:50:47PM +0000, Shameer Kolothum wrote:
> 
> > This is where hisi_acc reports a different BAR size as it tries to hide
> > the migration control region from Guest access.  
> 
> I think for now we should disable DMABUF for any PCI driver that
> implements a VFIO_DEVICE_GET_REGION_INFO
> 
> For a while I've wanted to further reduce the use of the ioctl
> multiplexer, so maybe this series:
> 
> https://github.com/jgunthorpe/linux/commits/vfio_get_region_info_op/
> 
> And then the dmabuf code can check if the ops are set to the generic
> or not and disable itself automatically.
> 
> Otherwise perhaps route the dmabuf through an op and deliberately omit
> it (with a comment!) from hisi, virtio, nvgrace.
> 
> We need to route it through an op anyhow as those three drivers will
> probably eventually want to implement their own version.

Can't we basically achieve the same by testing the ioctl is
vfio_pci_core_ioctl?  Your proposal would have better granularity, but
we'd probably want an ops callback that we can use without a userspace
buffer to get the advertised region size if we ever want to support a
device that both modifies the size of the region relative to the BAR
and supports p2p.  Thanks,

Alex

