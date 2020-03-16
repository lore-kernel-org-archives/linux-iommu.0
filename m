Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC509C18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:56:55 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72E542071C
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uq3aC7rP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E542071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 22A03204EF;
	Mon, 16 Mar 2020 15:56:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3-uDBgB3DG1l; Mon, 16 Mar 2020 15:56:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id DF3CF204D1;
	Mon, 16 Mar 2020 15:56:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D31E9C1D7C;
	Mon, 16 Mar 2020 15:56:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE99BC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:56:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 95476204EF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4WxfdBTSDtvK for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:56:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 62F3A204D1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:56:51 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id n8so18251898wmc.4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=xMvs0/HoidPNJcKREH4cxPQfySQhzOIJtF8I7+UM558=;
 b=uq3aC7rP8Gi0hWD2k9GTvb304Urdg7HWJq+1GajWwKZFGsN2rAJMGURBxedQKUW4jd
 asGhdTqUUsTBsHFqdt9E3rUbuOPH9LnplZyIROCXZts0Altk+BtOGfxVnQG2zCkEVKBq
 NAuI2JAjicGhKKjGeoT4CC5ZB2QqLarkq2Zu2k9kjsXdW+uN+BMXxoUU5u4N96yU44fx
 tCZDJoxX8PkOf/gkX0aCFzGDyygT+xsCtaCtEDXLQvT6XUdDgAn69Z6zXz1IbnDjfIOR
 mq+n2Ab7QrOC31UPcgX0gGxqUx4OOFYTI0TN6BbHpW3S45c2GIHm7KEYESWZoQ3DPMJV
 MY7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xMvs0/HoidPNJcKREH4cxPQfySQhzOIJtF8I7+UM558=;
 b=WMqQUcZifuePDM3bpKK7h25slc4JH7M6PkEYgKKCq078AAI7TKBB5VpQYh22ku4mPE
 qijZdkov/To6tEnIJBYze5WP/vFab7bqga0rAG5os/ApiEIteivoU2903yzxtUGjoTTr
 jNaBfGYmrhQBfz/VB2JkFwK9X2tIYzd65K1nH0I+IyLSSjFYcClh68QY+TyctFKnYX+N
 5bhETD1QU3Wg+56qXNqdrX1nwKzo2o6jK2DeTNWR8bNwM/4nxArCkBsAEb0QQs3JKXeQ
 VfRBUFWmzX4UX558DMYXD5CxUxExWoijAUPyKyYepgYEIkSpohVGhtmiW+XXXjmrVUZi
 zi8g==
X-Gm-Message-State: ANhLgQ2zSBdPfKaQcHH0pRy/VeXBScRdOV8Iezp8jDuno0cfmBYyq9dw
 wKaZIPmFZzR+XYhxn/9w8N0rRg==
X-Google-Smtp-Source: ADFU+vtb9SuXzA1/Pyl3fT36qeOkgagpJNuCxgpPrVNo6inRK/YVmejfWVsaU34AB8eJFzzgsz2mCw==
X-Received: by 2002:a1c:4d13:: with SMTP id o19mr28587408wmh.186.1584374209825; 
 Mon, 16 Mar 2020 08:56:49 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id w16sm531971wrp.8.2020.03.16.08.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:56:49 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:56:41 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 14/15] iommu/virtio: Use accessor functions for iommu
 private data
Message-ID: <20200316155641.GN304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-15-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-15-joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>, linux-arm-msm@vger.kernel.org,
 Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, iommu@lists.linux-foundation.org,
 Thierry Reding <thierry.reding@gmail.com>, linux-mediatek@lists.infradead.org,
 Andy Gross <agross@kernel.org>, Joerg Roedel <jroedel@suse.de>,
 Hanjun Guo <guohanjun@huawei.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, Sean Paul <sean@poorly.run>,
 Robin Murphy <robin.murphy@arm.com>
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

On Tue, Mar 10, 2020 at 10:12:28AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

And tested on QEMU

> ---
>  drivers/iommu/virtio-iommu.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index cce329d71fba..8ead57f031f5 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -466,7 +466,7 @@ static int viommu_probe_endpoint(struct viommu_dev *viommu, struct device *dev)
>  	struct virtio_iommu_req_probe *probe;
>  	struct virtio_iommu_probe_property *prop;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct viommu_endpoint *vdev = fwspec->iommu_priv;
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  
>  	if (!fwspec->num_ids)
>  		return -EINVAL;
> @@ -648,7 +648,7 @@ static int viommu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	int ret = 0;
>  	struct virtio_iommu_req_attach req;
>  	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct viommu_endpoint *vdev = fwspec->iommu_priv;
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  	struct viommu_domain *vdomain = to_viommu_domain(domain);
>  
>  	mutex_lock(&vdomain->mutex);
> @@ -807,8 +807,7 @@ static void viommu_iotlb_sync(struct iommu_domain *domain,
>  static void viommu_get_resv_regions(struct device *dev, struct list_head *head)
>  {
>  	struct iommu_resv_region *entry, *new_entry, *msi = NULL;
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
> -	struct viommu_endpoint *vdev = fwspec->iommu_priv;
> +	struct viommu_endpoint *vdev = dev_iommu_priv_get(dev);
>  	int prot = IOMMU_WRITE | IOMMU_NOEXEC | IOMMU_MMIO;
>  
>  	list_for_each_entry(entry, &vdev->resv_regions, list) {
> @@ -876,7 +875,7 @@ static int viommu_add_device(struct device *dev)
>  	vdev->dev = dev;
>  	vdev->viommu = viommu;
>  	INIT_LIST_HEAD(&vdev->resv_regions);
> -	fwspec->iommu_priv = vdev;
> +	dev_iommu_priv_set(dev, vdev);
>  
>  	if (viommu->probe_size) {
>  		/* Get additional information for this endpoint */
> @@ -920,7 +919,7 @@ static void viommu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &viommu_ops)
>  		return;
>  
> -	vdev = fwspec->iommu_priv;
> +	vdev = dev_iommu_priv_get(dev);
>  
>  	iommu_group_remove_device(dev);
>  	iommu_device_unlink(&vdev->viommu->iommu, dev);
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
