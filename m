Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B92D226D18
	for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 22:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749853870; cv=none; b=GdkrVpc8MWzCnewI9vjXmgNPXO1Z0FxiLCLvUWogIDDMzs9u2hNNYXWVjm4mKU9nlDyxflA2OPVuSGrm7umBT4tFLC3HE2UVENnQeznWK8oe26RoUsGCWXsnla0zUJUmYfPPg7llGs16UN5TOHzvCDoD4NWtZZkUXXfXHZ51RuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749853870; c=relaxed/simple;
	bh=Nk6jcOHWQ9XN0LoO6Grgu9gvLJ9kvVaW7vPp8steIhM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LIUFYxwJuNLgfXCm2zHd5g+56xM5DaGgTFruU2KQx8qMZDkYweUX2MHcgD8ABgrPHBo/d8IgJ9woJbLKHxoXu3gY+EjyqU+1VjlSRwYcF9wqPNFHEU24VrJYcXYM4m3Vyz6HWcIouh5LTdEZ/UNHTQal+2xz/AOe8xwm9igt2TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ICbcrucE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ICbcrucE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749853867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUxRtcllWvBP7izZoQXjnv9sUomqrHqol6vrBAIVRAY=;
	b=ICbcrucEyneLQMxFZfLvlKCCswOtGzhkBN7cIdR1eWExkodCAikiAcTiXPT0xpxfAoc3q5
	6BJ3JkgwTxEMdZVvpt4FTYnink/7FAYqtobk+x44N6bKDeNTUlhDN4wPCk4+vZ3gWElE2o
	liMhu4ywcviw565jMeB20l2dOLMFAXc=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-j8lDuSu2Pt2k4PoQQnC1Eg-1; Fri, 13 Jun 2025 18:31:06 -0400
X-MC-Unique: j8lDuSu2Pt2k4PoQQnC1Eg-1
X-Mimecast-MFC-AGG-ID: j8lDuSu2Pt2k4PoQQnC1Eg_1749853865
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3ddccf64e44so3466595ab.3
        for <iommu@lists.linux.dev>; Fri, 13 Jun 2025 15:31:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749853865; x=1750458665;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUxRtcllWvBP7izZoQXjnv9sUomqrHqol6vrBAIVRAY=;
        b=d1bdembUc0cpuQpkbQfhgYgY+n5qQjSs6tZU/lITBqpYWW0uGwgiM0TSLYPkL2uWKs
         l8bvxGX7/WS0skwvOBst1QpZwrZcvaBLksZKSEYgA2+4GES4KiulvC3suQ8AMQm4+Vhu
         TwexdnIRpJG3OCoGYvwnuTcTAA45ESsBfVX21eiF2pDJIy8DBdPfjJX1d+pqwvEg1W8M
         UgG+vvpPOU+H32+6tFsw0+mL2uyyBqLUPVcNVwbWXqW34ze2kCo4WnEm6uAEQULBWSZK
         Ke2azd8y2SRDfxPbdpG3uHG5OvrOyQHG+A0ItCWGnZalipG/35FLX8ALt6hWhYOsYypb
         N3tg==
X-Forwarded-Encrypted: i=1; AJvYcCU4GUZ0zjG+0iqQoYNMBWdom7li9Jvnhm5jidsSzR0/mS2Dc1Afm/2ZP45jAyBnMOUb3aCTbQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywg8TmHBBik8hwMNEBuXOP/FaWR740iACD47LVMRFpQm4ei6q6N
	jXOmpITZqbMmWMZo05B993RVsM0FKR1MORNIiW3tMhjZMt31otz1fLpHYPmP+mDZYKv6NSc/rAL
	2iy0V8S73gRItBFdDAwhABdrbq2RgzevAD+rCpvR7tgM7nRQ3CkrxxF4B
X-Gm-Gg: ASbGncsEKLjAp27HNjynZDCRBIY3yXCT/urQOoei1Hpq090YfDmu030g5oXE4klvUh+
	7t9mDYbrxB/mNyWguIiOdXgNqrr5ufm5yYSqd3RQaslwq9IfRAKHy3BBor/l+sWViJA49uTqYlI
	7As+HKfrxtVndQEkvGv5sHKKbfMmGY2wCiv6WggiS+2X/1bXZRiSCyUymQ8Nd2fod5iRDBvoFlf
	pwy4St8ORQBimCSmkOdCWfnSl1Ld+O/zqRlhNEtdA4xp/Uqdax0DSLGviwEgI/Oqh5wSSRBL1ud
	S0byfhW/MPZbbWQPpzneLZ6gzg==
X-Received: by 2002:a05:6e02:1c25:b0:3db:72f7:d7c3 with SMTP id e9e14a558f8ab-3de07da97f8mr4097155ab.3.1749853865236;
        Fri, 13 Jun 2025 15:31:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IELB0lUo8vO+HVO2w9/4P3nC6P0X2L0fugmGtGj/i2U/ixkoMFD+NrQuKaOoRdrPP2V26s/MA==
X-Received: by 2002:a05:6e02:1c25:b0:3db:72f7:d7c3 with SMTP id e9e14a558f8ab-3de07da97f8mr4097075ab.3.1749853864853;
        Fri, 13 Jun 2025 15:31:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-3de019b44b3sm5340065ab.10.2025.06.13.15.31.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 15:31:03 -0700 (PDT)
Date: Fri, 13 Jun 2025 16:31:00 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jacob Pan <jacob.pan@linux.microsoft.com>
Cc: linux-kernel@vger.kernel.org, "iommu@lists.linux.dev"
 <iommu@lists.linux.dev>, "Liu, Yi L" <yi.l.liu@intel.com>, "jgg@nvidia.com"
 <jgg@nvidia.com>, Zhang Yu <zhangyu1@microsoft.com>, Easwar Hariharan
 <eahariha@linux.microsoft.com>, Saurabh Sengar
 <ssengar@linux.microsoft.com>
Subject: Re: [PATCH v2 1/2] vfio: Prevent open_count decrement to negative
Message-ID: <20250613163100.7efa6528.alex.williamson@redhat.com>
In-Reply-To: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
References: <20250603152343.1104-1-jacob.pan@linux.microsoft.com>
Organization: Red Hat
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dlIlPk3HOv0X4xRopVRledk2yTs6PdLTMR_zh2tmMTQ_1749853865
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jacob,

On Tue,  3 Jun 2025 08:23:42 -0700
Jacob Pan <jacob.pan@linux.microsoft.com> wrote:

> When vfio_df_close() is called with open_count=0, it triggers a warning in
> vfio_assert_device_open() but still decrements open_count to -1. This
> allows a subsequent open to incorrectly pass the open_count == 0 check,
> leading to unintended behavior, such as setting df->access_granted = true.
> 
> For example, running an IOMMUFD compat no-IOMMU device with VFIO tests
> (https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c)
> results in a warning and a failed VFIO_GROUP_GET_DEVICE_FD ioctl on the
> first run, but the second run succeeds incorrectly.
> 
> Add checks to avoid decrementing open_count below zero.

The example above suggests to me that this is a means by which we could
see this, but in reality it seems it is the only means by which we can
create this scenario, right?

Why does VFIO_GROUP_GET_DEVICE_FD fail on the first iteration?  It
seems like things are pretty broken, we won't have access_granted set,
but I don't spot why the ioctl fails.

Doesn't this also (begin) to fix 6086efe73498 as well?  I think that
introduced skipping vfio_df_open() entirely for noiommu devices.  It
seems like this should have a Fixes: tag and the warning in the
assertion was unreachable until 608... so maybe it should be linked
here.  Thanks,

Alex


> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Yi Liu <yi.l.liu@intel.com>
> Signed-off-by: Jacob Pan <jacob.pan@linux.microsoft.com>
> ---
> v2: Added Reviewed-by tags
> ---
>  drivers/vfio/vfio_main.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 1fd261efc582..5046cae05222 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -583,7 +583,8 @@ void vfio_df_close(struct vfio_device_file *df)
>  
>  	lockdep_assert_held(&device->dev_set->lock);
>  
> -	vfio_assert_device_open(device);
> +	if (!vfio_assert_device_open(device))
> +		return;
>  	if (device->open_count == 1)
>  		vfio_df_device_last_close(df);
>  	device->open_count--;

