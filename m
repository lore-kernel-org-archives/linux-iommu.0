Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB7715AFB
	for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 23:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JaW7Rb7s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1697672193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wwq4pN/s/i/zMbfkzPRCH3hAZNaKCKuiLB6gGgcmPE4=;
	b=JaW7Rb7sx7Odo9oaQ09PS6isNUilQUoueiZ0GEYmuDIBAqwSpOoB0M3Bdohm3mU44tJKoD
	9IsXltuNMRi5EMOrLWwEEQC+2CIAXaN509TTS4l7896ZEFmUzWOHR3PO6ncSZ4RPajSeY3
	XOmjyxuGEs2mE0QfMCyJBYO6gVka/Vg=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-J8azIKHrOQ-eeIrJEHyWWw-1; Wed, 18 Oct 2023 19:36:26 -0400
X-MC-Unique: J8azIKHrOQ-eeIrJEHyWWw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7789405320fso131335585a.0
        for <iommu@lists.linux.dev>; Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697672186; x=1698276986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wwq4pN/s/i/zMbfkzPRCH3hAZNaKCKuiLB6gGgcmPE4=;
        b=eUU3W+NwinL4GEa2myAiWaPS1qXWERMJGZTehorVOiXhm1zxO1kJSGFfuWtoTCCM51
         0/XpRvfZphEI8tI4OtgeByp6O/AMXRKacfEneV6s8n2Un5RhZkWxktUX7HGCnECj4JVh
         CUvx82ORCX220Bp2uTC1kkCAepM6dgjkZ7AXMpOqCLgACoVMk9ryTpxJdf+6V8xGxrY2
         S8UqXPBjURn9ahjH0x3vyQmsCXIXL6OhbMsHLaSVhs/gEnPXIaohxZwTSjVlrc/NKAqW
         1zuhqY3i8IklhHKU+dU8UWuIItxz/ZEnwJFKM4Ni0fwEMgf/68upfBQgQclPc+8YNLZZ
         BU/A==
X-Gm-Message-State: AOJu0YwZaWaYkqi3pv3nnVa1J9DU0UIzFP03cBkiUiFGdfRyrsAwEn3o
	Pnp2KxXwBbwGyj7Fn30zFTA/F70QOe8Sk/JhfdJkZkZ49eONBQwXiFxyKAanGnxrDApXO2yMCMU
	UVpRyZEzgb8DADAU=
X-Received: by 2002:a05:620a:469f:b0:776:fad0:cc3b with SMTP id bq31-20020a05620a469f00b00776fad0cc3bmr723753qkb.1.1697672186297;
        Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPO7Vqth8t9yy/v3L0mG5MziEBsmxEMVxzKc33ywKWfOCVkngG2TzL+rbFxuOxZ3T5/4javQ==
X-Received: by 2002:a05:620a:469f:b0:776:fad0:cc3b with SMTP id bq31-20020a05620a469f00b00776fad0cc3bmr723743qkb.1.1697672186039;
        Wed, 18 Oct 2023 16:36:26 -0700 (PDT)
Received: from localhost (ip98-179-76-75.ph.ph.cox.net. [98.179.76.75])
        by smtp.gmail.com with ESMTPSA id bl11-20020a05620a1a8b00b00773fe8971bbsm324650qkb.90.2023.10.18.16.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 16:36:25 -0700 (PDT)
Date: Wed, 18 Oct 2023 16:36:24 -0700
From: Jerry Snitselaar <jsnitsel@redhat.com>
To: Robin Murphy <robin.murphy@arm.com>
Cc: joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev, 
	jgg@nvidia.com, baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org, 
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Christoph Hellwig <hch@lst.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v5 6/7] iommu: Retire bus ops
Message-ID: <63s3zurkwuq66szkc6wnvzbh75d5vxek3fzzsxbufd4ytdnkke@2gnfjb3b6ufk>
References: <cover.1697047261.git.robin.murphy@arm.com>
 <2411f20c801140b3cff37193ec2c08393a754997.1697047261.git.robin.murphy@arm.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <2411f20c801140b3cff37193ec2c08393a754997.1697047261.git.robin.murphy@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 11, 2023 at 07:14:53PM +0100, Robin Murphy wrote:
> With the rest of the API internals converted, it's time to finally
> tackle probe_device and how we bootstrap the per-device ops association
> to begin with. This ends up being disappointingly straightforward, since
> fwspec users are already doing it in order to find their of_xlate
> callback, and it works out that we can easily do the equivalent for
> other drivers too. Then shuffle the remaining awareness of iommu_ops
> into the couple of core headers that still need it, and breathe a sigh
> of relief.
> 
> Ding dong the bus ops are gone!
> 
> CC: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v4: Don't forget new reference in iommu_device_register_bus()
> ---
>  drivers/iommu/iommu.c       | 31 ++++++++++++++++++-------------
>  include/acpi/acpi_bus.h     |  2 ++
>  include/linux/device.h      |  1 -
>  include/linux/device/bus.h  |  5 -----
>  include/linux/dma-map-ops.h |  1 +
>  5 files changed, 21 insertions(+), 19 deletions(-)
> 

Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

