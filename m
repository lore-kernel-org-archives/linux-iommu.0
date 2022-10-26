Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED1B259C
	for <iommu@lists.linux.dev>; Wed, 26 Oct 2022 21:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1666819499;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ys5yrKnSWNrdXyOIt/+2hibuD6RgZdYjr5anEvm87I=;
	b=LtqFzzp14WfeSnWvKxREB7Rx+aDjPwYGyCOQ+8appuHvB/PXNY6YJmRmxpYrV9xazC7dny
	lWIwFbZCM+bsz3/wfVN3CN36m/idrbseiz9c8JYwmovAUCYlPIwSTao6euShzbgLoUk+Ct
	9ah2CYoTRHUHcmlyPL09O0zfaf5oGIg=
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com
 [209.85.166.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-86-pz7PDMOGNYu_yIBWChrnmA-1; Wed, 26 Oct 2022 17:24:58 -0400
X-MC-Unique: pz7PDMOGNYu_yIBWChrnmA-1
Received: by mail-il1-f200.google.com with SMTP id w15-20020a056e021c8f00b003006eca5e09so1399163ill.11
        for <iommu@lists.linux.dev>; Wed, 26 Oct 2022 14:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ys5yrKnSWNrdXyOIt/+2hibuD6RgZdYjr5anEvm87I=;
        b=ulzAoY2CS/kzkBW0bbvW+IltyrQFu+z/Y34lv2fkGJt/Svl5vHVHd6U0dPt/L55alC
         APBcmF6alQVfxM2lUCGv4OxxYPIUDJe32QCc0yBNbTF1LEpKRoBtowalRleMJ9XwytUA
         6KI5nWhC0p7RdMhXTWmQRWjr4P3YcG8MNK9zrQcq8FnOlyXJ102ck5GV4jbkJmLkGWq5
         H06MBUdB6TYkFC2vu788sDPW5fskpGXTZ3AKp5CsLraaTxWWXdf9me3mn4l0pzzLPccx
         arGuKgjXhH+1BpBPuJIr2oOVnaY9xLHPHPrzPzboCB7yf/LSQxI7cAMbD50F6SGigOnV
         5QZg==
X-Gm-Message-State: ACrzQf06lqESpb7vRsnMMVpDv5oK8mqZZQUus7cvcJ49dMl0Zt0B9sZg
	iS2DXQp8I8TaGbVB1onJ23znsTidho929cwNmzAOjb4EnvQ2FhnkqGPYyEXWizj38FBWDPzv37L
	6pCGU4ydR/m+myKk=
X-Received: by 2002:a05:6602:134f:b0:6a4:cd04:7842 with SMTP id i15-20020a056602134f00b006a4cd047842mr27841962iov.172.1666819497438;
        Wed, 26 Oct 2022 14:24:57 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM78B1N1rhquL7I27LvLWaJii8bhooCw6yJ0rMTPt8axTAAIzjlyMmOikhzath1gqGNuTiEASg==
X-Received: by 2002:a05:6e02:1b08:b0:2fc:4df6:e468 with SMTP id i8-20020a056e021b0800b002fc4df6e468mr27916129ilv.148.1666819486067;
        Wed, 26 Oct 2022 14:24:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239])
        by smtp.gmail.com with ESMTPSA id x13-20020a02948d000000b0036c8a246f54sm2409348jah.142.2022.10.26.14.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:24:45 -0700 (PDT)
Date: Wed, 26 Oct 2022 15:24:42 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, David Airlie
 <airlied@gmail.com>, Tony Krowiak <akrowiak@linux.ibm.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>,
 Daniel Vetter <daniel@ffwll.ch>, Diana Craciun <diana.craciun@oss.nxp.com>,
 dri-devel@lists.freedesktop.org, Eric Auger <eric.auger@redhat.com>, Eric
 Farman <farman@linux.ibm.com>, Harald Freudenberger <freude@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
 intel-gfx@lists.freedesktop.org, intel-gvt-dev@lists.freedesktop.org,
 iommu@lists.linux.dev, Jani Nikula <jani.nikula@linux.intel.com>, Jason
 Herne <jjherne@linux.ibm.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Kevin
 Tian <kevin.tian@intel.com>, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, Longfang Liu <liulongfang@huawei.com>, Matthew
 Rosato <mjrosato@linux.ibm.com>, Peter Oberparleiter
 <oberpar@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, Robin Murphy
 <robin.murphy@arm.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, Shameer
 Kolothum <shameerali.kolothum.thodi@huawei.com>, Sven Schnelle
 <svens@linux.ibm.com>, Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Vineeth Vijayan <vneethv@linux.ibm.com>, Will Deacon <will@kernel.org>,
 Yishai Hadas <yishaih@nvidia.com>, Zhenyu Wang <zhenyuw@linux.intel.com>,
 Zhi Wang <zhi.a.wang@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>,
 Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: [PATCH 04/10] vfio: Move storage of allow_unsafe_interrupts to
 vfio_main.c
Message-ID: <20221026152442.4855c5de.alex.williamson@redhat.com>
In-Reply-To: <4-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
References: <0-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
	<4-v1-4991695894d8+211-vfio_iommufd_jgg@nvidia.com>
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

On Tue, 25 Oct 2022 15:17:10 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> This legacy module knob has become uAPI, when set on the vfio_iommu_type1
> it disables some security protections in the iommu drivers. Move the
> storage for this knob to vfio_main.c so that iommufd can access it too.

I don't really understand this, we're changing the behavior of the
iommufd_device_attach() operation based on the modules options of
vfio_iommu_type1, which may not be loaded or even compiled into the
kernel.  Our compatibility story falls apart when VFIO_CONTAINER is not
set, iommufd sneaks in to usurp /dev/vfio/vfio, and the user's module
options for type1 go unprocessed.

I hate to suggest that type1 becomes a module that does nothing more
than maintain consistency of this variable when the full type1 isn't
available, but is that what we need to do?  Thanks,

Alex

> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.h             | 2 ++
>  drivers/vfio/vfio_iommu_type1.c | 5 ++---
>  drivers/vfio/vfio_main.c        | 3 +++
>  3 files changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index f95f4925b83bbd..54e5a8e0834ccb 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -130,4 +130,6 @@ extern bool vfio_noiommu __read_mostly;
>  enum { vfio_noiommu = false };
>  #endif
>  
> +extern bool vfio_allow_unsafe_interrupts;
> +
>  #endif
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 23c24fe98c00d4..186e33a006d314 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -44,9 +44,8 @@
>  #define DRIVER_AUTHOR   "Alex Williamson <alex.williamson@redhat.com>"
>  #define DRIVER_DESC     "Type1 IOMMU driver for VFIO"
>  
> -static bool allow_unsafe_interrupts;
>  module_param_named(allow_unsafe_interrupts,
> -		   allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
> +		   vfio_allow_unsafe_interrupts, bool, S_IRUGO | S_IWUSR);
>  MODULE_PARM_DESC(allow_unsafe_interrupts,
>  		 "Enable VFIO IOMMU support for on platforms without interrupt remapping support.");
>  
> @@ -2282,7 +2281,7 @@ static int vfio_iommu_type1_attach_group(void *iommu_data,
>  		    iommu_group_for_each_dev(iommu_group, (void *)IOMMU_CAP_INTR_REMAP,
>  					     vfio_iommu_device_capable);
>  
> -	if (!allow_unsafe_interrupts && !msi_remap) {
> +	if (!vfio_allow_unsafe_interrupts && !msi_remap) {
>  		pr_warn("%s: No interrupt remapping support.  Use the module param \"allow_unsafe_interrupts\" to enable VFIO IOMMU support on this platform\n",
>  		       __func__);
>  		ret = -EPERM;
> diff --git a/drivers/vfio/vfio_main.c b/drivers/vfio/vfio_main.c
> index 8d809ecd982b39..1e414b2c48a511 100644
> --- a/drivers/vfio/vfio_main.c
> +++ b/drivers/vfio/vfio_main.c
> @@ -51,6 +51,9 @@ static struct vfio {
>  	struct ida			device_ida;
>  } vfio;
>  
> +bool vfio_allow_unsafe_interrupts;
> +EXPORT_SYMBOL_GPL(vfio_allow_unsafe_interrupts);
> +
>  static DEFINE_XARRAY(vfio_device_set_xa);
>  static const struct file_operations vfio_group_fops;
>  

