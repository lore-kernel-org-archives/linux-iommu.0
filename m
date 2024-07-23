Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3BD13D882
	for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721738932; cv=none; b=lA9WDl/MWVa+dz4osgx5V0uak5YEt/2oCtvbT6S1F8osLMEWIsUIpeugf5YHnrB6TOoHb3zfmihicg9CUQBHn45L5wNSqXzZs4+1WwJiqVVZBvAqrGNL4mkMBnx0Yy/iy+fpykKcJ7W8oDnyn3UWKhm4a2+HONPCvfIkvR9h0nA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721738932; c=relaxed/simple;
	bh=wOnEDwriZwx7rcrgs7goLJqWn3w6wpuD6g0gePLwJz4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KmTwfB/1TVxCdtkaxZVIvzxWfnUbogVId67CUYEwUvBmTHshl8obYJFtIr95Ii1lBZ4htAVl7Eg7tRNYV9mjck6ZIfuC3s6jqWcSHQaQAknCeKekgSdOxe9uUoFLM3Kc0tx72yc+Y1xzv8K7tC7YmZibFjY/h+ygKQNhWAQjiSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jXwkk+TQ; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jXwkk+TQ"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-6b79fc76d03so31884846d6.1
        for <iommu@lists.linux.dev>; Tue, 23 Jul 2024 05:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1721738928; x=1722343728; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=citEK9Go0HIAzipsNA6lBMcHdejRwaj6BfJz7T/qnx4=;
        b=jXwkk+TQcWNO4TYOt2HoeojHNuwGkacasaJZwIZG6tR7TtecFWfQo0mQXc4Q9YUWzE
         90L2dq09OZd/gbZWXPsyDSj2yu0d5OnDdAwmBCRFAwN1/EfLi5eqlstRYbyBah6/XYnH
         THgp/6XK9MIi1IFn5THAB82YgcLTg4j4KwM3IVDxtmRsu1s4t/ZNLoKROmmKHbpX4Jj6
         JyXeK0zNpr2+G8mKFiBg55jSyJQDnU6SWYZ+x7SXGyCKswChR8yHrtZFl4SE5esIQOb9
         iZWYszFqRKfEEH4HYMA1NGgte+NJaBYPyeHLU9wmaOacgPqVH1eT553Q9iZAdvMax9Mo
         9c6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721738928; x=1722343728;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=citEK9Go0HIAzipsNA6lBMcHdejRwaj6BfJz7T/qnx4=;
        b=Sy4NC5ThED0WNA6ruLsDgBSah4ytrolhraOaeCMQS/UrrkXbEOzjSWRIEs8M+doDL5
         tx9YOE/lfgCZdSE1malfq3do6RaRijKFYmIZHckieybN1V+J5AcA4tIdl+kT0of+uvqW
         NUUcDxmvTrUXp+0l4gBN/83hb4zxQZb74J6H/AN3s5+Hf0dbzLxnT61OMA6FHQIqRNwc
         cA4Dgql16BxgWRbCI4NkwORBoBcUad8n163TeIYW6MSTkx/8KMEHyYoxQxIiDXo9Voog
         L/OZIcB0AKPASdroKU5wVdvX1xwuTVPmRMxxUlUWCFCgiWzCY6WMxtoLJ13Ra+3Nd5Zr
         0V6Q==
X-Gm-Message-State: AOJu0YybNoR8z1qTND7Ker32uBhkKMb/CJtFr/+Q1LdaY9KNNhUedHvG
	rIaBcfwyHyYsaVxtXJEsRJvRenVCjKygYcWzsRcDSlPRpghxEvBRK15bimafq5c=
X-Google-Smtp-Source: AGHT+IEX96lHdd0DWkn0FXEyNT+jCN0/cyM7mvneY6HnU7zwgVDWg/LIVInpvM/dab3JWaoHnjPjPA==
X-Received: by 2002:ad4:5ba9:0:b0:6b7:a8ef:e366 with SMTP id 6a1803df08f44-6b981a0930cmr33696166d6.9.1721738928555;
        Tue, 23 Jul 2024 05:48:48 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.80.239])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44f9cdbce43sm43109371cf.87.2024.07.23.05.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jul 2024 05:48:47 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1sWEwh-003boP-2B;
	Tue, 23 Jul 2024 09:48:47 -0300
Date: Tue, 23 Jul 2024 09:48:47 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: iommu@lists.linux.dev, Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC V1 0/4] iommufd live update
Message-ID: <20240723124847.GI14050@ziepe.ca>
References: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1721501805-86928-1-git-send-email-steven.sistare@oracle.com>

On Sat, Jul 20, 2024 at 11:56:40AM -0700, Steve Sistare wrote:
> Live update is a technique wherein an application saves its state, launches
> an updated version of itself, and restores its state.  Clients of the
> application experience a brief suspension of service, on the order of
> 100's of milliseconds, but are otherwise unaffected.
> 
> Define the IOMMU_IOAS_CHANGE_PROCESS ioctl to allow management and use
> of an iommufd device to be transferred from one process to another.  The
> application is responsible for transferring the device descriptor to the new
> process, eg either by preservation across fork and exec or via SCM_RIGHTS.
> 
> All memory objects that were mapped for iommufd DMA in the old process
> must also be mapped in the new process, but they may have different virtual
> addresses in the new.  The application passes an array of new addresses to
> IOMMU_IOAS_CHANGE_PROCESS, and it atomically updates everything to the current
> process, grabbing the new mm, transferring pinned page counts, and recording
> new virtual addresses.
> 
> If the application directly exec's the new version of itself, it must take
> special care if the mappings may be accessed by kernel threads, such as by
> vfio mdevs.  The original process must fork an identical caretaker
> process which calls VFIO_IOAS_CHANGE_PROCESS to take temporary ownership
> of the mappings without changing VA's.  The original process then exec's
> its successor, which calls VFIO_IOAS_CHANGE_PROCESS with new VA's to take
> ownership from the caretaker.  
> 
> Thanks to Jason Gunthorpe for code and ideas in this series.
> 
> This is implemented in QEMU by the patch series "Live update: iommufd"
>   https://lore.kernel.org/qemu-devel   (to be posted shortly)
> 
> Steve Sistare (4):
>   iommufd: Export do_update_pinned
>   iommufd: Lock all objects
>   iommufd: Add IOMMU_IOAS_CHANGE_PROCESS
>   iommufd: update VA

Oh, this should also be covered in the iommufd selftests..

Jason
