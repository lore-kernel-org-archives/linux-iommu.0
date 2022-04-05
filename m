Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B23ACC433EF
	for <iommu@archiver.kernel.org>; Tue,  5 Apr 2022 19:10:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C31D61044;
	Tue,  5 Apr 2022 19:10:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OqkfM141pZUG; Tue,  5 Apr 2022 19:10:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 502D060B4C;
	Tue,  5 Apr 2022 19:10:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D800C0012;
	Tue,  5 Apr 2022 19:10:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD1AC0012
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:10:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6CE8C4151E
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:10:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vy-0n4qgftrx for <iommu@lists.linux-foundation.org>;
 Tue,  5 Apr 2022 19:10:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5FDCA40A03
 for <iommu@lists.linux-foundation.org>; Tue,  5 Apr 2022 19:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1649185850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
 b=i4sxydNzBzlt+RbQ8mFFxcb6emuA4HilpqZDkJBC1AbeKU0V9Kjw7xmgskakUyPnT5zVxc
 vxqDFrmoTIDOCIN5oayzjMhM3KKLW4g5tNYnh92A1I2xwDwkqC3aYF2pNcsshL3cHZe/nt
 xvWQ4gOZvAH+9cWlRGrK/RvGUzSChi0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-563-5BKK9o0HPxSMqVxE8AVuVg-1; Tue, 05 Apr 2022 15:10:47 -0400
X-MC-Unique: 5BKK9o0HPxSMqVxE8AVuVg-1
Received: by mail-io1-f71.google.com with SMTP id
 y3-20020a056602178300b00645d25c30c1so143578iox.6
 for <iommu@lists.linux-foundation.org>; Tue, 05 Apr 2022 12:10:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:organization:mime-version:content-transfer-encoding;
 bh=ufYYfNJ31ZxJiptHxZVI0cJDY245GxkfqBFvOLAxMek=;
 b=oZIdgXT/FJouWqtqY9YDomhNVAuf9IuFQx+sYvpo7DBlb8chYyK5asEj3+wgXj2XNH
 I+I8N5a4FBeTwGjSuKkL3ZnlRVIaUEXHKrltIrWaSD9zDvClq2mTebQa2h32BhKsNAc4
 rS6sSexWPYAm+2Uj+WnndriJY9Gg4SwBmz1rjNqpHdqsTDD261JIOVtKgvkFZFsDB9ph
 RjQrjWFx+oG0+oMamTsz2ERmIch+pmlWPtN5/6G3ucGtUgzqSTTcdL2MmqxSulN6yGHj
 CMw525r0xRFgRN2mPG+peCny7RJ2DotOxxT/DRyY17hzWfqcoUDs4yYTXz+NLcBAWzmY
 /JZw==
X-Gm-Message-State: AOAM53036KHQVVmTGvBpliYj7HfeQ6nhaQ+k09YU1PatPg4MztXJJT1p
 SgXsBeOeUrhrtNrIN7qjR58PEY+bR2Al8HSxzdl5HMfH2m6XJq4k1s1RQ2o98FWxo69aFvxb3hS
 CBl5ATjCVbncpeGARbhQQtZEN61teHQ==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr2568134ild.5.1649185846542; 
 Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxocs2ZVaXF5YVJwjGBcLRqnK5UBIr3mQlWSQgNmkFdgGBC2rjlpWZLrLl9AI2wrgBUaUJw1w==
X-Received: by 2002:a92:cdad:0:b0:2c6:7b76:a086 with SMTP id
 g13-20020a92cdad000000b002c67b76a086mr2568112ild.5.1649185846282; 
 Tue, 05 Apr 2022 12:10:46 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 x2-20020a056602160200b006463c1977f9sm9314961iow.22.2022.04.05.12.10.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Apr 2022 12:10:45 -0700 (PDT)
Date: Tue, 5 Apr 2022 13:10:44 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH 2/5] vfio: Require that devices support DMA cache coherence
Message-ID: <20220405131044.23910b77.alex.williamson@redhat.com>
In-Reply-To: <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
References: <0-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
 <2-v1-ef02c60ddb76+12ca2-intel_no_snoop_jgg@nvidia.com>
Organization: Red Hat
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Nelson Escobar <neescoba@cisco.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, virtualization@lists.linux-foundation.org,
 Will Deacon <will@kernel.org>, Christoph Hellwig <hch@lst.de>,
 linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-rdma@vger.kernel.org,
 iommu@lists.linux-foundation.org,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 David Woodhouse <dwmw2@infradead.org>, "Tian, Kevin" <kevin.tian@intel.com>,
 linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Christian Benvenuti <benve@cisco.com>, Robin Murphy <robin.murphy@arm.com>
X-BeenThere: iommu@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Development issues for Linux IOMMU support
 <iommu.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu@lists.linux-foundation.org>
List-Help: <mailto:iommu-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
 <mailto:iommu-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: iommu-bounces@lists.linux-foundation.org
Sender: "iommu" <iommu-bounces@lists.linux-foundation.org>

On Tue,  5 Apr 2022 13:16:01 -0300
Jason Gunthorpe <jgg@nvidia.com> wrote:

> dev_is_dma_coherent() is the control to determine if IOMMU_CACHE can be
> supported.
> 
> IOMMU_CACHE means that normal DMAs do not require any additional coherency
> mechanism and is the basic uAPI that VFIO exposes to userspace. For
> instance VFIO applications like DPDK will not work if additional coherency
> operations are required.
> 
> Therefore check dev_is_dma_coherent() before allowing a device to join a
> domain. This will block device/platform/iommu combinations from using VFIO
> that do not support cache coherent DMA.
> 
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/vfio/vfio.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index a4555014bd1e72..2a3aa3e742d943 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -32,6 +32,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
> +#include <linux/dma-map-ops.h>
>  #include "vfio.h"
>  
>  #define DRIVER_VERSION	"0.3"
> @@ -1348,6 +1349,11 @@ static int vfio_group_get_device_fd(struct vfio_group *group, char *buf)
>  	if (IS_ERR(device))
>  		return PTR_ERR(device);
>  
> +	if (group->type == VFIO_IOMMU && !dev_is_dma_coherent(device->dev)) {
> +		ret = -ENODEV;
> +		goto err_device_put;
> +	}
> +

Failing at the point where the user is trying to gain access to the
device seems a little late in the process and opaque, wouldn't we
rather have vfio bus drivers fail to probe such devices?  I'd expect
this to occur in the vfio_register_group_dev() path.  Thanks,

Alex

>  	if (!try_module_get(device->dev->driver->owner)) {
>  		ret = -ENODEV;
>  		goto err_device_put;

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
