Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A4DF277011
	for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 22:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758839500; cv=none; b=CL8LTI4YWEb3VqJbEY5PhwyaoAnYcsCBUwEZmkuRPY5KFdz1CMR8EKGsk/q2Z/Ggzcx10jRfjfeApxQQuTyyiFpUSxSb7R8t1Yc0mflBxqsUbEVBRPXbmPaTogdyl+gwVE9iE8nU6d76Uc99r1XfA06XW/rvaYgRkfgeEwLtcTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758839500; c=relaxed/simple;
	bh=0Alswmfe1zq7N80PnOB6XtFxyNuFoZwrMxHbgdTZfVk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rE2MQIIoy8/+VYjRVhK1BMrJTBX+/PyQXL2WQZfpx9XMJ4h4rBGoIxqRsKRi2pRhCe5QaPqo5Q/mjFyW2ydn3xzv/ksS8D/XpQ4mZXlW2Z4mN7478gEBY7EuGw2uDVyDlB8447BYDCh1ZBVdU9cOamXA/Cbp7FHyFj+cSoRiqPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+yZubRg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+yZubRg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758839497;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pPGBYTkBK6lmMsctQg86rFzc+ubUYRnHqSeaFKAdA0w=;
	b=C+yZubRgK7Xuwq8ZYbAwrcRYC9QJmxmKZYhbFEgZZzGy0wcSpRtZdmQIn5cJi+4/kE7I0b
	H7LRxQ7lvfwPszHznmJsqnXlq31xtlX1UeKVoTth1DoVwhxeCom1E1069qr7z2twjZ/ElL
	OZg7vgVrWNEhfNV/vmzboGSLcCUVDtI=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-497-Wm3S2FNrNOuORmHf6VNLKQ-1; Thu, 25 Sep 2025 18:31:36 -0400
X-MC-Unique: Wm3S2FNrNOuORmHf6VNLKQ-1
X-Mimecast-MFC-AGG-ID: Wm3S2FNrNOuORmHf6VNLKQ_1758839495
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42571642af9so5015115ab.0
        for <iommu@lists.linux.dev>; Thu, 25 Sep 2025 15:31:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758839495; x=1759444295;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pPGBYTkBK6lmMsctQg86rFzc+ubUYRnHqSeaFKAdA0w=;
        b=oaoYjWCeLtm9N0q23VHJNKY8qKlzIHtykuD3knm5Hxz6yn4b1ZbiU7Drg9bIFmUHzf
         fs8UKlTrdRQxS7IvBEqwV2pzPy+xMoYAMqd7NJhD/fSLTBvbtwkAYTqEDGdZ6kgR/g6Z
         vNz+rocV3bTC0f3TArlWg8G8xPrlFuYRwcWAQzllx8cEqoFh8/X2GRxpB+SOtR9sIxkk
         tIYccYI5cm5ZunraRZFAbEIKlN5ztBzsH7i3J2zp18/CzHYMvSgQzveOI3LzxqyP7JE5
         eQlQBGERf1CmH5BmeF3Q44zczYXWWcaUuT5z7RBge4q1pB6yN1rfvLA3pQQ4U1L1TOvp
         5RIA==
X-Forwarded-Encrypted: i=1; AJvYcCXT/FDyrJOHexqX2TgGW6ebOccrtlE6Dyp54ixjNn4WfpBkRgelKQN+3Sbtxwwhwt1isv7sHw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyc5YbU4Cc3i5cxr86AxIzVa1pOBZl42g1VFblAwZEH9tRHh+IT
	KGDw5WBjLFPn6OD1NEUvqljgmOw9OFZFuWByTYSPanVseJLmo4BG6ABbN9+7BAO6cnPffMJEQws
	S5o9/jvG9yzjuvtYvigtWnU8XpLzdFtRreyX9Bv3IbRfrDoAqaNoLzBkj
X-Gm-Gg: ASbGncsyHBLn2rDJgEPhZdhOx5d9aPxnHHtOJZT2OedL4ZVs0Rj2dBHvDf+0cvFFmK3
	CvPh2z2LG9v+niAo6sUJVPZme5DCCh/EDfx0oQ9pEjaVPirQmXIIkDOw3ZAMFCyjfpiGSbkhs2R
	WrJ9Xa0xFEtYx+TpkG5gWda0Ki3Hh6GdPBsUM164N8cRfBLWuZEEHwihxQ46mi994pJcW6K9G5w
	TsfWvKsLB7AwbrVK+hDPK2eZP9RelD82gPbTqJTKuvJc13rJe+IE+oGBdZo2dHBIh02rCm4oSp1
	Uua/jSs74K+fgc82Hf0c/vJbaGBnIc3IOaId4IqYgLk=
X-Received: by 2002:a92:d987:0:b0:424:80e6:9e8b with SMTP id e9e14a558f8ab-42595661562mr24720225ab.7.1758839495373;
        Thu, 25 Sep 2025 15:31:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGBjWzVlsd5kVvaGcIPZVt9Dy5vtGZ7X7lNybnyhnS6f36pgd3Q/xbJFuK0zszjvTKZaW8Iag==
X-Received: by 2002:a92:d987:0:b0:424:80e6:9e8b with SMTP id e9e14a558f8ab-42595661562mr24719995ab.7.1758839494991;
        Thu, 25 Sep 2025 15:31:34 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-56a69a1c574sm1211405173.40.2025.09.25.15.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 15:31:34 -0700 (PDT)
Date: Thu, 25 Sep 2025 16:31:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leon@kernel.org>, Andrew Morton
 <akpm@linux-foundation.org>, Bjorn Helgaas <bhelgaas@google.com>, Christian
 =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev, Jens Axboe
 <axboe@kernel.dk>, Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org, linux-block@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pci@vger.kernel.org, Logan Gunthorpe
 <logang@deltatee.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Robin
 Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/P2PDMA: Refactor to separate core P2P
 functionality from memory allocation
Message-ID: <20250925163131.22a2c09b.alex.williamson@redhat.com>
In-Reply-To: <20250925115308.GT2617119@nvidia.com>
References: <cover.1757589589.git.leon@kernel.org>
	<1e2cb89ea76a92949d06a804e3ab97478e7cacbb.1757589589.git.leon@kernel.org>
	<20250922150032.3e3da410.alex.williamson@redhat.com>
	<20250923150414.GA2608121@nvidia.com>
	<20250923113041.38bee711.alex.williamson@redhat.com>
	<20250923174333.GE2608121@nvidia.com>
	<20250923120932.47df57b2.alex.williamson@redhat.com>
	<20250925070314.GA12165@unreal>
	<20250925115308.GT2617119@nvidia.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: YwHp6RD0Zf9V_tnWd-3kzAP-tPirENMHOIHoECv4Lu8_1758839495
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 25 Sep 2025 08:53:08 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Thu, Sep 25, 2025 at 10:03:14AM +0300, Leon Romanovsky wrote:
> 
> > > It would at least make sense to me then to store the provider on the
> > > vfio_pci_dma_buf object at the time of the get feature call rather than
> > > vfio_pci_core_init_dev() though.  That would eliminate patch 08/ and
> > > the inline #ifdefs.  
> > 
> > I'll change it now. If "enable" function goes to be "get" function, we
> > won't need to store anything in vfio_pci_dma_buf too. At the end, we
> > have exactly two lines "provider = priv->vdev->provider[priv->bar];",
> > which can easily be changed to be "provider = pcim_p2pdma_provider(priv->vdev->pdev, priv->bar)"  
> 
> Not without some kind of locking change. I'd keep the
> priv->vdev->provider[priv->bar] because setup during probe doesn't
> need special locking.

Why do we need to store the provider on the vfio_pci_core_device at
probe though, we can get it later via pcim_p2pdma_provider().  Ideally
we'd take the opportunity to pull out the setup part of the _provider
function to give us an initialization interface to use at probe time
without an unnecessary BAR# arg.  Thanks,

Alex

