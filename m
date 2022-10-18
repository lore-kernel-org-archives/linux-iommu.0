Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A595386
	for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 21:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666130281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4dmGN2ClYG8b9hKGjnfBlOmjS2ytfWR3jFMVVszIM0=;
	b=bkbQ17WaFM3LKiF/iNS89FKSi6N86QKO+yZ2G6Mvcs138kBOySWwzMnUs1Uin9qgRXv/iF
	JSkrGs7QcTzQakUUx4c6hpN+J/TLFky7gmhYioKJJsJouODvGxSaOZDfttsKJHfTtS0Wn5
	9+fh1vCuZv94dihlyxLFfEU87rlCdT0=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-615-z2i0ZNOrNJSHo0flDBxvIA-1; Tue, 18 Oct 2022 17:57:59 -0400
X-MC-Unique: z2i0ZNOrNJSHo0flDBxvIA-1
Received: by mail-io1-f72.google.com with SMTP id i21-20020a6bf415000000b006bc987bf9faso10875549iog.6
        for <iommu@lists.linux.dev>; Tue, 18 Oct 2022 14:57:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4dmGN2ClYG8b9hKGjnfBlOmjS2ytfWR3jFMVVszIM0=;
        b=Wzh86bQuhft6oeqJWFLi3P7cTSoOX5ltOxjDphyDdQlQ0i0a6Cv7xpB1qMlQXfj6j5
         13VxB14WNRB0EhRApyMpodgFKGRUVRLux4+YmCnFMYhPmrxkcIWwJsVjKdFP94tceGA3
         dhWNiHTqgmcC9L35Vk1A8yLasQ0Qekw809IqCTjTeoS+Q1M78+LQCY//kwlaUdkCbbIi
         G8AIBlAQ7ZhbamMvkt7/K4941zb5dypo73DDQSGq0Dm6GIXm17IOl2EROWLbuc+hBs92
         rsdpEMmX89sLJBWwrDJ0WtINi83/sJ9FlkAA/9a4s9FnHU/VE+GbYkaC/0wfhZENF3AU
         stUw==
X-Gm-Message-State: ACrzQf2XNk7Zsbsc50x3Qj189ck/8bkVOkO53QzA8YZtPIVKwzlaplwk
	2uu08zhCqBZ8RZhFXO2+sMF2n/qlm5dBYH6ige6P8iQtM5G6+U5Cf6WX/In87wzECvFV3fH9A+x
	XIZjjxElrnaBcFow=
X-Received: by 2002:a05:6e02:16c8:b0:2fa:d5f4:e9cb with SMTP id 8-20020a056e0216c800b002fad5f4e9cbmr3265926ilx.108.1666130279233;
        Tue, 18 Oct 2022 14:57:59 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sxQp2rOy4BFy7AIHM7b9ZbzGpb8deVvbnULkqR7SItJ/yiO005oP58/68D6+gf6/YlFZvkA==
X-Received: by 2002:a05:6e02:16c8:b0:2fa:d5f4:e9cb with SMTP id 8-20020a056e0216c800b002fad5f4e9cbmr3265908ilx.108.1666130278972;
        Tue, 18 Oct 2022 14:57:58 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id e9-20020a028609000000b003636cb862d0sm1477855jai.42.2022.10.18.14.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Oct 2022 14:57:58 -0700 (PDT)
Date: Tue, 18 Oct 2022 15:57:56 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Lu Baolu <baolu.lu@linux.intel.com>
Cc: Joerg Roedel <joro@8bytes.org>, Kevin Tian <kevin.tian@intel.com>, Will
 Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] iommu/vt-d: Fix lockdep splat in intel_iommu_init()
Message-ID: <20221018155756.55095893.alex.williamson@redhat.com>
In-Reply-To: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
References: <20220927053109.4053662-1-baolu.lu@linux.intel.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Sep 2022 13:31:07 +0800
Lu Baolu <baolu.lu@linux.intel.com> wrote:

> Hi folks,
> 
> As commit c919739ce472 ("iommu/vt-d: Handle race between registration
> and device probe") highlights, a lockdep splat issue happens after
> moving iommu probing device process into iommu_device_register().
> 
> This is due to a conflict that get_resv_regions wants hold the
> dmar_global_lock, but it's also possible to be called from within a
> section where intel_iommu_init() already holds the lock.
> 
> Historically, before commit 5f64ce5411b46 ("iommu/vt-d: Duplicate
> iommu_resv_region objects per device list"), the rcu_lock is used in
> get_resv_regions. This commit converted it to dmar_global_lock in order
> to allowing sleeping in iommu_alloc_resv_region().
> 
> This aims to fix the lockdep issue by making iommu_alloc_resv_region()
> available in critical section and rolling dmar_global_lock back to rcu
> lock in get_resv_regions of the Intel IOMMU driver.
> 
> Best regards,
> baolu
> 
> Lu Baolu (2):
>   iommu: Add gfp parameter to iommu_alloc_resv_region
>   iommu/vt-d: Use rcu_lock in get_resv_regions
> 
>  include/linux/iommu.h                       |  2 +-
>  drivers/acpi/arm64/iort.c                   |  3 ++-
>  drivers/iommu/amd/iommu.c                   |  7 ++++---
>  drivers/iommu/apple-dart.c                  |  2 +-
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |  2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  2 +-
>  drivers/iommu/intel/iommu.c                 | 12 +++++++-----
>  drivers/iommu/iommu.c                       |  7 ++++---
>  drivers/iommu/mtk_iommu.c                   |  3 ++-
>  drivers/iommu/virtio-iommu.c                |  9 ++++++---
>  10 files changed, 29 insertions(+), 20 deletions(-)

Resolves the regression for me.  Hopefully Joerg will queue this for
6.1-rc.  Thanks!

Tested-by: Alex Williamson <alex.williamson@redhat.com>

