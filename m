Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12D4B53A7
	for <iommu@lists.linux.dev>; Wed, 18 Jan 2023 18:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1674068315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwaWlIaPebdK8DNpQuuvVjS8artPxBM6nDox3pZmeN8=;
	b=gg8gz4QPbMrIO4R+JJHtF5wyO9KcPI9E95pBKvNR1ihWw6VQ9sdoMtt5dZPXndqBkTb7uj
	OlM8UrRCQ99JRB2eq4bn3AM87WSi2CjS9YETLHft7amg1tfDswPPNUExOFn/pSfcYC0luJ
	DVKyE08pNXKjbh7iZ/fKJzCnO08nMIw=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-250-UfZBdUj8OA6Vvzkuh_V4Fw-1; Wed, 18 Jan 2023 13:58:34 -0500
X-MC-Unique: UfZBdUj8OA6Vvzkuh_V4Fw-1
Received: by mail-il1-f200.google.com with SMTP id 9-20020a056e0220c900b0030f1b0dfa9dso4344940ilq.4
        for <iommu@lists.linux.dev>; Wed, 18 Jan 2023 10:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jwaWlIaPebdK8DNpQuuvVjS8artPxBM6nDox3pZmeN8=;
        b=zEqTMhz5csU90v6KuGW40eM5eTsYfo7VL/IIIMGCFntNz9vtuSVoI2JwUSTBEeQSXg
         oiKFpvUJ9/MIli6azuu/09tfBNZlZW8VDRWxhIrodzmUdH+oKbQ+cfjPt4VP3N1St4uq
         gr1JFvKcXf39k7WGGr7atMLqGXe4BwP7C01/W4uZ614PI9CGDqWP7b+V0QHntw+1G3SI
         SmLKLOhu7kIB40+AH9qW8sxuZegJSVIl3SaWXGWgPMBxxL4uOJkQsTzz5ftlb6yz4I3b
         hUthrEAykE3Ld6JjBV+Ugmi3I8nZ2PLJgmTSKrlfOVf7uTwRBjX8nasuqoAboPU+08SY
         HNuQ==
X-Gm-Message-State: AFqh2krcqL9yHaQs/0ANpHTntj+BYP1tw/Ckc/75D/ck1ZR13O19a2jU
	OZ6CGOD/IcdbdhNJMtiX24JBIyM0S3WYztvTgTOzDKXd9X4HW+4WiXHPB8/bhv1l4qzW52KHe+v
	lZ8aqnhpowKBAAQk=
X-Received: by 2002:a5d:9f0c:0:b0:704:b286:64c3 with SMTP id q12-20020a5d9f0c000000b00704b28664c3mr5357196iot.16.1674068313897;
        Wed, 18 Jan 2023 10:58:33 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuD3FNjIe8uZwiymfGir/K6vuU0PbE/oIAy9VURoxPULmWGDYCX5CqFDoljCfgmrCuNOhASOg==
X-Received: by 2002:a5d:9f0c:0:b0:704:b286:64c3 with SMTP id q12-20020a5d9f0c000000b00704b28664c3mr5357187iot.16.1674068313655;
        Wed, 18 Jan 2023 10:58:33 -0800 (PST)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id h7-20020a05660208c700b00704a77b7b28sm3952149ioz.54.2023.01.18.10.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 10:58:33 -0800 (PST)
Date: Wed, 18 Jan 2023 11:58:31 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Cornelia Huck <cohuck@redhat.com>, iommu@lists.linux.dev, Kevin Tian
 <kevin.tian@intel.com>, kvm@vger.kernel.org, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH v3] vfio: Support VFIO_NOIOMMU with iommufd
Message-ID: <20230118115831.3e76742d.alex.williamson@redhat.com>
In-Reply-To: <0-v3-480cd64a16f7+1ad0-iommufd_noiommu_jgg@nvidia.com>
References: <0-v3-480cd64a16f7+1ad0-iommufd_noiommu_jgg@nvidia.com>
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

On Wed, 18 Jan 2023 13:50:28 -0400
Jason Gunthorpe <jgg@nvidia.com> wrote:
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index f8219a438bfbf5..9e94abcf8ee1a8 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -10,10 +10,10 @@
>  #include <linux/device.h>
>  #include <linux/cdev.h>
>  #include <linux/module.h>
> +#include <linux/vfio.h>
>  
>  struct iommufd_ctx;
>  struct iommu_group;
> -struct vfio_device;
>  struct vfio_container;
>  
>  void vfio_device_put_registration(struct vfio_device *device);
> @@ -88,6 +88,12 @@ bool vfio_device_has_container(struct vfio_device *device);
>  int __init vfio_group_init(void);
>  void vfio_group_cleanup(void);
>  
> +static inline bool vfio_device_is_noiommu(struct vfio_device *vdev)
> +{
> +	return IS_ENABLED(CONFIG_VFIO_NOIOMMU) &&
> +	       vdev->group->type == VFIO_NO_IOMMU;
> +}


What about:

static inline bool vfio_group_type_is_noiommu(struct vfio_group *group)

which would allow us to pickup the group.c use with only extending the
callers here as s/vdev/vdev->group/?  Or we could even make a
vfio_device_group_type_is_noiommu(struct vfio_device*) calling the
above if we want a device specific interface.  Thanks,

Alex

