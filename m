Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151BD247291
	for <iommu@lists.linux.dev>; Fri, 21 Nov 2025 00:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684629; cv=none; b=sem9j7GcmvtZnnPVAkuvgcXM1Exsailsdm+3qqToKbNQNbFbac5jyOyKryGcRUZqca/l6VB3QN0js/V86r1d5HNcyzcGIkZ/32/NKog3/wQZ1VEkVvtFh/kVWkWWuqvjBYyWdZ9oB3MLBTTxZExKd+J2s7LafbpfE1of+5xmOCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684629; c=relaxed/simple;
	bh=rSFCVYBQGHYIVw4AaRKYw6Ay38HyAtjHDSJOWPLks+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ANSMFktBmjJjzVahrG5RhY4gLyrzNSdG2G+MGp55ScBaplrnzDexbnglq8prCliJFzN7rnMPAPM8tAfrFVo1qbasy+JZHvd6Zf9TiTPFGXUoVRg7TaxREB0hplkF2+wlyUfIyV4EytfO2+LuZSffHUbggiHi23rNonEIxQYi//E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=YHKt73de; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="YHKt73de"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-88242fc32c9so17085806d6.1
        for <iommu@lists.linux.dev>; Thu, 20 Nov 2025 16:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1763684626; x=1764289426; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=YHKt73de3HNBDUse9r5ZWpVmdT7GwfAyZa9R09ZyADzJeene6Kc5PlD14Vb9UYOowc
         6UKQFLLQwzS3ejTm3fVEScgrIXuS9DUedIzP9OgCwj1akc0LkfU3BuINx07wqLuWE1wk
         SAku4w7en48FzW+a8/aeLoauBQj0dELB/YVETj2sCOC9CK4N6gVoauHCPK95NahJGLHr
         X7Aw36hQRSCKZXYFv3KYL4E6qwWjFHmNtdliqndmxUsvLbUK7Ys1tPMddE43zzm8JahT
         dCh/4xteeWGHS3eiOLk3JKJcsnZ0THJI2W43US3Mg/e5XwKYx2uXKCZqyNWXbbigiAkE
         ZVVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684626; x=1764289426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HeoQ6A9zQA47pPVQ4WN0R1Mr0WB5BGBDvzJz+/SIjn4=;
        b=PIMlGFQRWiex7ezbMR6SGWrjXfFNrTqI2tUK4EttGR80KLC06/SAJJWFY99/5PoXCd
         AaXpiRmmjdSCf7VQfI/MThPTnu9eA9FvQNQHHUf7e9Cfc5RQZioFAAIPXYlTrfUYSm6M
         5CI9WHLVWjgK5RFxtRKtjOsw8k34XzUqH2kCM+5SjP2NqCEKSmEOx7kGkOFaFVjX2aVD
         NYBeF4UUCjj3a4bFq0oAXtJwfAMnmONf+AVEJRUQfXVNLbmh7WMqBQ/Qc+FSF8W9wm4j
         Hw404Vb/7laDBLvEj8TKRMc9vDE6f2/Wh5Z4U3Hx856YEo6K7LqmQbsE0gi98lAOCpjz
         ls8w==
X-Forwarded-Encrypted: i=1; AJvYcCUNj2QSPsoa+9FXLhk34XT/pynYTNT5ntYCGw/WzoTUqkfh2CV3/njH4nizbKYxUUNJ0TF7HQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxcnVbx7qKAJB3psirreien8US9YtbqQETsjVbbiJ2OP6JASE8P
	1c55me1au3jxH/bPWiptHXc7jCsnH+8W+DmyWI7oRQD+a4BVkshtdhbuPliqqdxYE38=
X-Gm-Gg: ASbGncutyGCaTVhsaJYwdxY4rbVnXrMNYJRFu+A1ci99AeykNJFsqfy1AEgGRzEwj98
	/9S4vWta2WxO41mqXzjd/9tsnv7CoU9n0XeTqRB3mCFy2v68I9ZGQiZZljL2x5qqEcAulXtGac/
	ge+MlZ3DqesRo/VqL8UFajlAY6P1j43tqDj/DMl2DVOC1Td8bvM9Vv2T9lgRRjILFcrkvnm3m62
	Mdf2FkuQnYd34eMEiNLS12+WQR4nexlcTKWNTU8nqp3eRZ/kKf//lkJIFDex+edMNsuV5FaXF2/
	0rsu5eoxb8uaMW/RmhBABPA+qjgbU9XLtSvaKBlbjkVqjAkOSx/u8yovHgXbVOMRYOy4tAfSUvr
	EjeJo3XvEHTrfO1D8BxVZ2EKKGHQCzDSNHu9TM/QobrMbdiJ0nepRVHbjeAsHH6fcdumYkb140Z
	PAi44i3NkaFKpeQ5TX4s73pLFDuIshGgUnePIYGCxcGarO09l4RincqZSL
X-Google-Smtp-Source: AGHT+IF9fpUZC0KSEi60qYSTXqU5TN/0kv3Br6v+7st2smYcT5XQOEwOWy/F2amvDq4QuChbOli5Vg==
X-Received: by 2002:ad4:5d42:0:b0:880:2c08:88e with SMTP id 6a1803df08f44-8847c5206f8mr8425876d6.45.1763684625945;
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8846e472ae1sm27645766d6.22.2025.11.20.16.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:23:45 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vMEwC-000000016i7-2ZE0;
	Thu, 20 Nov 2025 20:23:44 -0400
Date: Thu, 20 Nov 2025 20:23:44 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, Jens Axboe <axboe@kernel.dk>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
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
Subject: Re: [PATCH v9 10/11] vfio/pci: Add dma-buf export support for MMIO
 regions
Message-ID: <20251121002344.GC233636@ziepe.ca>
References: <20251120-dmabuf-vfio-v9-0-d7f71607f371@nvidia.com>
 <20251120-dmabuf-vfio-v9-10-d7f71607f371@nvidia.com>
 <20251120170413.050ccbb5.alex@shazbot.org>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120170413.050ccbb5.alex@shazbot.org>

On Thu, Nov 20, 2025 at 05:04:13PM -0700, Alex Williamson wrote:

> @@ -2501,7 +2501,7 @@ static int vfio_pci_dev_set_hot_reset(struct vfio_device_set *dev_set,
>  err_undo:
>         list_for_each_entry_from_reverse(vdev, &dev_set->device_list,
>                                          vdev.dev_set_list) {
> -               if (__vfio_pci_memory_enabled(vdev))
> +               if (vdev->vdev.open_count && __vfio_pci_memory_enabled(vdev))
>                         vfio_pci_dma_buf_move(vdev, false);
>                 up_write(&vdev->memory_lock);
>         }
> 
> Any other suggestions?  This should be the only reset path with this
> nuance of affecting non-opened devices.  Thanks,

Seems reasonable, but should it be in __vfio_pci_memory_enabled() just
to be robust?

Jason
