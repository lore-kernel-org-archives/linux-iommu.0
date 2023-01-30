Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FDF0746A
	for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 19:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1675106945;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kMw/XElnCxdmLp42oBJRMNFt89bRqi3exLedbUEk6Ms=;
	b=ZJcCq+T4lMovHbFblFcOFacEDwdS67o6c+CdRlMdHQdzdA5fPtsM0lNDQNmdvxSMTZCxJo
	vwly+aeU8I6kf3dYL0+4wfTgIsjeaVZYtQ5Alt8oBTVWsK2J1HhXEji6sY8G9ijel/kxWT
	6pJCfaoiSpfRBlghCxO1dmfnQBY9Vxg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-640-rogOxAKMNLqgJX0MMYj_xQ-1; Mon, 30 Jan 2023 14:29:04 -0500
X-MC-Unique: rogOxAKMNLqgJX0MMYj_xQ-1
Received: by mail-il1-f200.google.com with SMTP id m6-20020a056e021c2600b0030f19e3764cso7893552ilh.5
        for <iommu@lists.linux.dev>; Mon, 30 Jan 2023 11:29:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kMw/XElnCxdmLp42oBJRMNFt89bRqi3exLedbUEk6Ms=;
        b=1b0NGz5LtVIhbHQgoMOfY4gIo+VKMdNecGvjcW2En4xqD1cq9fOP2ybmDNyiRXBW0G
         0hz+5CjYnN20L+SYNDPcoHEffjcml7sdXbF4jcAWJHwGZv+R7qdhdZC4ieOJ2ddb1K5Y
         4EfUzWSdvG8pcjlCbj7reUa/aX6W+Y21UUQ9ZuhczLtlXgHVaWCpAJYPJcp60HPZnnDh
         USRh3LWfi9gQM7cl61/lMXizDrnhHXbkSmUUPXo5u2Urq9ckCw37O2cF+HzLUnA43sBA
         tzQCphRgzLxqexq8U9rOABoTTRcz9ET6YDxl+THqLIbGoyT5eB5xRPLMwRU/tk4187TC
         NJeA==
X-Gm-Message-State: AO0yUKVY/4yVzuMbhdr+76dTB1elXOL892attVdvF9CXQTW2fVVEracw
	rVsN3ZjMfA3luFGQfHA61uTVxP8V7oWGlXS2o2DgD7NJeWnmpjJ3UvOmm6sQQOjY9y6he1RbPPP
	CRnS0hsLLTrSI24U=
X-Received: by 2002:a6b:b502:0:b0:71b:4ff1:8b65 with SMTP id e2-20020a6bb502000000b0071b4ff18b65mr3257646iof.20.1675106944052;
        Mon, 30 Jan 2023 11:29:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+JhLwG+4uNghaktgYIvfj5Eaa7V5ujje6ekVHXlMk8M7KoAq74HIqfWN54rhVkCtWE9U8zlw==
X-Received: by 2002:a6b:b502:0:b0:71b:4ff1:8b65 with SMTP id e2-20020a6bb502000000b0071b4ff18b65mr3257635iof.20.1675106943827;
        Mon, 30 Jan 2023 11:29:03 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id s12-20020a5d928c000000b0070b32c4e242sm4468133iom.31.2023.01.30.11.29.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 11:29:03 -0800 (PST)
Date: Mon, 30 Jan 2023 12:29:01 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3] vfio: Support VFIO_NOIOMMU with iommufd
Message-ID: <20230130122901.5baff572.alex.williamson@redhat.com>
In-Reply-To: <Y9gMZmvFDOW5LaWv@nvidia.com>
References: <0-v3-480cd64a16f7+1ad0-iommufd_noiommu_jgg@nvidia.com>
	<Y9gMZmvFDOW5LaWv@nvidia.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
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

On Mon, 30 Jan 2023 14:28:54 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:

> On Wed, Jan 18, 2023 at 01:50:28PM -0400, Jason Gunthorpe wrote:
> > Add a small amount of emulation to vfio_compat to accept the SET_IOMMU to
> > VFIO_NOIOMMU_IOMMU and have vfio just ignore iommufd if it is working on a
> > no-iommu enabled device.
> > 
> > Move the enable_unsafe_noiommu_mode module out of container.c into
> > vfio_main.c so that it is always available even if VFIO_CONTAINER=n.
> > 
> > This passes Alex's mini-test:
> > 
> > https://github.com/awilliam/tests/blob/master/vfio-noiommu-pci-device-open.c
> > 
> > Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> > Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> > ---
> >  drivers/iommu/iommufd/Kconfig           |   2 +-
> >  drivers/iommu/iommufd/iommufd_private.h |   2 +
> >  drivers/iommu/iommufd/vfio_compat.c     | 105 +++++++++++++++++++-----
> >  drivers/vfio/Kconfig                    |   2 +-
> >  drivers/vfio/container.c                |   7 --
> >  drivers/vfio/group.c                    |   7 +-
> >  drivers/vfio/iommufd.c                  |  19 ++++-
> >  drivers/vfio/vfio.h                     |   8 +-
> >  drivers/vfio/vfio_main.c                |   7 ++
> >  include/linux/iommufd.h                 |  12 ++-
> >  10 files changed, 136 insertions(+), 35 deletions(-)
> > 
> > v3:
> >  - Missed kdoc
> >  - Incorrect indent
> >  - Consolidate duplicate code into vfio_device_is_noiommu()
> > v2: https://lore.kernel.org/r/0-v2-568c93fef076+5a-iommufd_noiommu_jgg@nvidia.com
> >  - Passes Alex's test
> >  - Fix a spelling error for s/CONFIG_VFIO_NO_IOMMU/CONFIG_VFIO_NOIOMMU/
> >  - Prevent type1 mode from being requested and prevent a compat IOAS from being
> >    auto created with an additional context global trap door flag
> >  - Make it so VFIO_CONTAINER=n still creates the module option and related machinery
> >  - Comment updates
> > v1: https://lore.kernel.org/all/0-v1-5cde901db21d+661fe-iommufd_noiommu_jgg@nvidia.com
> > 
> > Alex, if you are good with this can you ack it and I'll send you a PR. Yi will
> > need to rebase his series on top of it.  
> 
> Alex are we OK?


Sure.

Acked-by: Alex Williamson <alex.williamson@redhat.com>

