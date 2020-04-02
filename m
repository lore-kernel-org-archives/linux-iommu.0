Return-Path: <SRS0=urD1=5S=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A6CBC2BA15
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 13:52:55 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4BF702073B
	for <iommu@archiver.kernel.org>; Thu,  2 Apr 2020 13:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WYfXg3X3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BF702073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 07A4287F00;
	Thu,  2 Apr 2020 13:52:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7EI8ry6xOiDO; Thu,  2 Apr 2020 13:52:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A749687EAC;
	Thu,  2 Apr 2020 13:52:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EFBBC1AE2;
	Thu,  2 Apr 2020 13:52:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27587C07FF
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:52:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 1EDC2883E2
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:52:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9qrU8uHYtg8S for <iommu@lists.linux-foundation.org>;
 Thu,  2 Apr 2020 13:52:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD98087EA9
 for <iommu@lists.linux-foundation.org>; Thu,  2 Apr 2020 13:52:50 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id i19so3781997wmb.0
 for <iommu@lists.linux-foundation.org>; Thu, 02 Apr 2020 06:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=Af2JSDwihc8nF6h/8r9tRfhzK4NkNkC7mPnujbacA4E=;
 b=WYfXg3X36AvqTwJlAkbyeB6mKBOAK4tblKRvp+PMMksyR0S+HJiQ8pBMj3B8ZUuAyx
 9iFRCYbcf7lfCQMiTODRucJHoBZHdViAHeeudHlctD3QMK3Nk6uqA4b6yPPC3ZrtUD/Z
 c5vy1wJM/9q0Xg/l6zOKJJ7K9Pdum8Yk6zYxbAJLfrX1bgMDIBsISAHQ93Ww2aOTyF9H
 jwL2pYynj7Sy+tGf70y/BhPAtrsRWlqoxT2kL2R3v3862E9vGOtoAK7yFFk4nfSD0oAw
 Ksv7LLgk+aMBu8EqTzLL7LcEDcdMqxpBUaNqyrkWiOHrfRYMiOPaqTtrrkwRGO7ljpMl
 KCHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Af2JSDwihc8nF6h/8r9tRfhzK4NkNkC7mPnujbacA4E=;
 b=iP/QaP3YFJSLU1UO8hPEBDC/V3dk+dvsu4gq6/zoGWwLaGTZBLvZQ7T6ggQ3G+MMlW
 AdaPDD0hvLmRCQI5cEBZcoqLCEdClWFpTcW5qqbCVFFrt/1Q6M2+riIy4DwtyEaA0IRe
 RcgVuYdZ/BZiiQyNZTYXDOv83hdQGSRpx5x8/4jvul3kDl0zvZQ4UCOowmgeyPXKm/h5
 JafUtbYJHfa4gn8MUJgO+kO9FSj5a49PDl0mB30bC4+H/b7Qsuuh0b6ZejV/o4vzisyE
 SZmRG8erGI+pAKrCjLHYBD7oLAFrN9TeUjH3mu0+csFrOEW3h5a1vWMRXsZtpfBnO/fT
 FsPw==
X-Gm-Message-State: AGi0PubJs//8ut+8yRoWCD54X/2LoYTh2y4h1yFSc/93q1/f5p61PSsF
 VgithxvVUuYYE2cpi+rO+3acxA==
X-Google-Smtp-Source: APiQypLNnVYOD2AZt87qLBOpKyN+9iazNk3xW8ANrER0HUdIDL6UmjerB/gZbsECOzD4MivOwsvPlw==
X-Received: by 2002:a1c:2285:: with SMTP id i127mr3827555wmi.152.1585835569034; 
 Thu, 02 Apr 2020 06:52:49 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:6097:1406:6470:33b5])
 by smtp.gmail.com with ESMTPSA id w204sm7370919wma.1.2020.04.02.06.52.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Apr 2020 06:52:48 -0700 (PDT)
Date: Thu, 2 Apr 2020 15:52:40 +0200
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [PATCH v1 1/8] vfio: Add VFIO_IOMMU_PASID_REQUEST(alloc/free)
Message-ID: <20200402135240.GE1176452@myrica>
References: <1584880325-10561-1-git-send-email-yi.l.liu@intel.com>
 <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1584880325-10561-2-git-send-email-yi.l.liu@intel.com>
Cc: kevin.tian@intel.com, ashok.raj@intel.com, kvm@vger.kernel.org,
 yi.y.sun@intel.com, linux-kernel@vger.kernel.org, alex.williamson@redhat.com,
 iommu@lists.linux-foundation.org, jun.j.tian@intel.com, hao.wu@intel.com
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

Hi Yi,

On Sun, Mar 22, 2020 at 05:31:58AM -0700, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
> 
> For a long time, devices have only one DMA address space from platform
> IOMMU's point of view. This is true for both bare metal and directed-
> access in virtualization environment. Reason is the source ID of DMA in
> PCIe are BDF (bus/dev/fnc ID), which results in only device granularity
> DMA isolation. However, this is changing with the latest advancement in
> I/O technology area. More and more platform vendors are utilizing the PCIe
> PASID TLP prefix in DMA requests, thus to give devices with multiple DMA
> address spaces as identified by their individual PASIDs. For example,
> Shared Virtual Addressing (SVA, a.k.a Shared Virtual Memory) is able to
> let device access multiple process virtual address space by binding the
> virtual address space with a PASID. Wherein the PASID is allocated in
> software and programmed to device per device specific manner. Devices
> which support PASID capability are called PASID-capable devices. If such
> devices are passed through to VMs, guest software are also able to bind
> guest process virtual address space on such devices. Therefore, the guest
> software could reuse the bare metal software programming model, which
> means guest software will also allocate PASID and program it to device
> directly. This is a dangerous situation since it has potential PASID
> conflicts and unauthorized address space access.

It's worth noting that this applies to Intel VT-d with scalable mode, not
IOMMUs that use one PASID space per VM

> It would be safer to
> let host intercept in the guest software's PASID allocation. Thus PASID
> are managed system-wide.
> 
> This patch adds VFIO_IOMMU_PASID_REQUEST ioctl which aims to passdown
> PASID allocation/free request from the virtual IOMMU. Additionally, such
> requests are intended to be invoked by QEMU or other applications which
> are running in userspace, it is necessary to have a mechanism to prevent
> single application from abusing available PASIDs in system. With such
> consideration, this patch tracks the VFIO PASID allocation per-VM. There
> was a discussion to make quota to be per assigned devices. e.g. if a VM
> has many assigned devices, then it should have more quota. However, it
> is not sure how many PASIDs an assigned devices will use. e.g. it is
> possible that a VM with multiples assigned devices but requests less
> PASIDs. Therefore per-VM quota would be better.
> 
> This patch uses struct mm pointer as a per-VM token. We also considered
> using task structure pointer and vfio_iommu structure pointer. However,
> task structure is per-thread, which means it cannot achieve per-VM PASID
> alloc tracking purpose. While for vfio_iommu structure, it is visible
> only within vfio. Therefore, structure mm pointer is selected. This patch
> adds a structure vfio_mm. A vfio_mm is created when the first vfio
> container is opened by a VM. On the reverse order, vfio_mm is free when
> the last vfio container is released. Each VM is assigned with a PASID
> quota, so that it is not able to request PASID beyond its quota. This
> patch adds a default quota of 1000. This quota could be tuned by
> administrator. Making PASID quota tunable will be added in another patch
> in this series.
> 
> Previous discussions:
> https://patchwork.kernel.org/patch/11209429/
> 
> Cc: Kevin Tian <kevin.tian@intel.com>
> CC: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Alex Williamson <alex.williamson@redhat.com>
> Cc: Eric Auger <eric.auger@redhat.com>
> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> ---
>  drivers/vfio/vfio.c             | 130 ++++++++++++++++++++++++++++++++++++++++
>  drivers/vfio/vfio_iommu_type1.c | 104 ++++++++++++++++++++++++++++++++
>  include/linux/vfio.h            |  20 +++++++
>  include/uapi/linux/vfio.h       |  41 +++++++++++++
>  4 files changed, 295 insertions(+)
> 
> diff --git a/drivers/vfio/vfio.c b/drivers/vfio/vfio.c
> index c848262..d13b483 100644
> --- a/drivers/vfio/vfio.c
> +++ b/drivers/vfio/vfio.c
> @@ -32,6 +32,7 @@
>  #include <linux/vfio.h>
>  #include <linux/wait.h>
>  #include <linux/sched/signal.h>
> +#include <linux/sched/mm.h>
>  
>  #define DRIVER_VERSION	"0.3"
>  #define DRIVER_AUTHOR	"Alex Williamson <alex.williamson@redhat.com>"
> @@ -46,6 +47,8 @@ static struct vfio {
>  	struct mutex			group_lock;
>  	struct cdev			group_cdev;
>  	dev_t				group_devt;
> +	struct list_head		vfio_mm_list;
> +	struct mutex			vfio_mm_lock;
>  	wait_queue_head_t		release_q;
>  } vfio;
>  
> @@ -2129,6 +2132,131 @@ int vfio_unregister_notifier(struct device *dev, enum vfio_notify_type type,
>  EXPORT_SYMBOL(vfio_unregister_notifier);
>  
>  /**
> + * VFIO_MM objects - create, release, get, put, search
> + * Caller of the function should have held vfio.vfio_mm_lock.
> + */
> +static struct vfio_mm *vfio_create_mm(struct mm_struct *mm)
> +{
> +	struct vfio_mm *vmm;
> +	struct vfio_mm_token *token;
> +	int ret = 0;
> +
> +	vmm = kzalloc(sizeof(*vmm), GFP_KERNEL);
> +	if (!vmm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	/* Per mm IOASID set used for quota control and group operations */
> +	ret = ioasid_alloc_set((struct ioasid_set *) mm,

Hmm, either we need to change the token of ioasid_alloc_set() to "void *",
or pass an actual ioasid_set struct, but this cast doesn't look good :)

As I commented on the IOASID series, I think we could embed a struct
ioasid_set into vfio_mm, pass that struct to all other ioasid_* functions,
and get rid of ioasid_sid.

> +			       VFIO_DEFAULT_PASID_QUOTA, &vmm->ioasid_sid);
> +	if (ret) {
> +		kfree(vmm);
> +		return ERR_PTR(ret);
> +	}
> +
> +	kref_init(&vmm->kref);
> +	token = &vmm->token;
> +	token->val = mm;

Why the intermediate token struct?  Could we just store the mm_struct
pointer within vfio_mm?

Thanks,
Jean

> +	vmm->pasid_quota = VFIO_DEFAULT_PASID_QUOTA;
> +	mutex_init(&vmm->pasid_lock);
> +
> +	list_add(&vmm->vfio_next, &vfio.vfio_mm_list);
> +
> +	return vmm;
> +}
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
