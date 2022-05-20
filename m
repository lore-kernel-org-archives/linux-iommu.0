Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DC84C433EF
	for <iommu@archiver.kernel.org>; Fri, 20 May 2022 11:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 17AA3424C3;
	Fri, 20 May 2022 11:29:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 95ZTlDqrbYTu; Fri, 20 May 2022 11:29:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 702DE41BF0;
	Fri, 20 May 2022 11:29:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F7C0C0039;
	Fri, 20 May 2022 11:29:13 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 65090C002D
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:29:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 40B2684490
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:29:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jHJkl7D-a7pH for <iommu@lists.linux-foundation.org>;
 Fri, 20 May 2022 11:29:11 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D0E3884488
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 11:29:10 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id k126so4381495wme.2
 for <iommu@lists.linux-foundation.org>; Fri, 20 May 2022 04:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=klBbWS7sRcqocWfFmSjhAhD7LMdlQzVYNuKtndTufmQ=;
 b=KKmuhkyrGGxRgDW7vHnZYTwIp2VhohRT0q11wWXZHehcaBkzga7Nl6OyoZwFE81jNa
 E9Ikujmsjw702GL2sYWRWvNdS0gW+WYirXnO6mmz3STYVfv2zHOBednXNpqUSuKW6cKA
 51NdWv4hKPYvE1IM/9zcFmKQuMGsu5y1zFFTfEwzPO7KyfSlMX4mkajOd3Wwdtl+yc8F
 yDktKpxUiPugXBP0G0BPS53KgEdg13IjPijWpp7Jg0COAgNsIIwfSyb09VWlu0xvIdFr
 rFEgPXIYAFkK4DPtc+Vn5rnmTNOp52plyyrF4gBvdd6Mfj/pNfrZ9V/JVSfWShAMx8Tg
 0mYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=klBbWS7sRcqocWfFmSjhAhD7LMdlQzVYNuKtndTufmQ=;
 b=JsXrHAdnPwrv6d9fc648sjzOOr8uchpRdqu5BlLnWUrLxZQpXaQbktdSPLYjZet5Yd
 LohImzCeXj7zjhgUfZJUBm6YFtQFbBcWvOv9lKvLX5cseAxP7+Nq9jIhXYzoPA0OghUf
 ooZ10wvF7gDZBsIEp0idYiuGclrWtKx8nb4jwadmEAvhQxrZJJXZ35jJQDtYKDLEa8ZE
 BGzYJIE6r55fyzK4C7YAWnW+W1BtmsnARzoFWLgM1W5e7WL3cfOLQMae/J/SrT/7XgjB
 hdNO7QItux/x703zLWpsXYxwg7PKQImQe0PFLMV6TrU0jswIcvLxDMdB06rtLe89FQ4B
 ZBFQ==
X-Gm-Message-State: AOAM531F/VEcLXcU+L2gcLrybKy2ehUm8A9LXi2AdIukysdjww3HfZWN
 Fx40U4XuPmh8QUcNUUKNvVbDbA==
X-Google-Smtp-Source: ABdhPJy+XnCF6eA4cXPfHENATkzczZ6M9sLEqwQ1G4NPiVcFc5KVYiwAtyE/Mwnl1pZea/pFW1cCwg==
X-Received: by 2002:a05:600c:382:b0:394:6172:59dc with SMTP id
 w2-20020a05600c038200b00394617259dcmr8356943wmd.120.1653046149008; 
 Fri, 20 May 2022 04:29:09 -0700 (PDT)
Received: from myrica (cpc92880-cmbg19-2-0-cust679.5-4.cable.virginm.net.
 [82.27.106.168]) by smtp.gmail.com with ESMTPSA id
 r17-20020adfa151000000b0020d00174eabsm2181977wrr.94.2022.05.20.04.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 May 2022 04:29:08 -0700 (PDT)
Date: Fri, 20 May 2022 12:28:44 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Subject: Re: [PATCH v7 06/10] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yod6/ceSMIeela/x@myrica>
References: <20220519072047.2996983-1-baolu.lu@linux.intel.com>
 <20220519072047.2996983-7-baolu.lu@linux.intel.com>
 <YoZyvVxJLiYOjBHw@myrica>
 <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3636ac5e-4f52-26a9-db73-5858a27f61b8@linux.intel.com>
Cc: Kevin Tian <kevin.tian@intel.com>, Dave Jiang <dave.jiang@intel.com>,
 Ashok Raj <ashok.raj@intel.com>, Robin Murphy <robin.murphy@arm.com>,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.com>,
 Vinod Koul <vkoul@kernel.org>, Jacob jun Pan <jacob.jun.pan@intel.com>,
 Jason Gunthorpe <jgg@nvidia.com>, Will Deacon <will@kernel.org>
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

On Fri, May 20, 2022 at 02:38:12PM +0800, Baolu Lu wrote:
> On 2022/5/20 00:39, Jean-Philippe Brucker wrote:
> > > +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> > > +{
> > > +	struct iommu_sva_domain *sva_domain;
> > > +	struct iommu_domain *domain;
> > > +	ioasid_t max_pasid = 0;
> > > +	int ret = -EINVAL;
> > > +
> > > +	/* Allocate mm->pasid if necessary. */
> > > +	if (!dev->iommu->iommu_dev->pasids)
> > > +		return ERR_PTR(-EOPNOTSUPP);
> > > +
> > > +	if (dev_is_pci(dev)) {
> > > +		max_pasid = pci_max_pasids(to_pci_dev(dev));
> > > +		if (max_pasid < 0)
> > > +			return ERR_PTR(max_pasid);
> > > +	} else {
> > > +		ret = device_property_read_u32(dev, "pasid-num-bits",
> > > +					       &max_pasid);
> > > +		if (ret)
> > > +			return ERR_PTR(ret);
> > > +		max_pasid = (1UL << max_pasid);
> > > +	}
> > The IOMMU driver needs this PASID width information earlier, when creating
> > the PASID table (in .probe_device(), .attach_dev()). Since we're moving it
> > to the IOMMU core to avoid code duplication, it should be done earlier and
> > stored in dev->iommu
> 
> Yes, really. How about below changes?
> 
> From f1382579e8a15ca49acdf758d38fd36451ea174d Mon Sep 17 00:00:00 2001
> From: Lu Baolu <baolu.lu@linux.intel.com>
> Date: Mon, 28 Feb 2022 15:01:35 +0800
> Subject: [PATCH 1/1] iommu: Add pasids field in struct dev_iommu
> 
> Use this field to save the number of PASIDs that a device is able to
> consume. It is a generic attribute of a device and lifting it into the
> per-device dev_iommu struct could help to avoid the boilerplate code
> in various IOMMU drivers.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 15 +++++++++++++++
>  include/linux/iommu.h |  2 ++
>  2 files changed, 17 insertions(+)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e49c5a5b8cc1..6b731171d42f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -20,6 +20,7 @@
>  #include <linux/idr.h>
>  #include <linux/err.h>
>  #include <linux/pci.h>
> +#include <linux/pci-ats.h>
>  #include <linux/bitops.h>
>  #include <linux/property.h>
>  #include <linux/fsl/mc.h>
> @@ -194,6 +195,8 @@ EXPORT_SYMBOL_GPL(iommu_device_unregister);
>  static struct dev_iommu *dev_iommu_get(struct device *dev)
>  {
>  	struct dev_iommu *param = dev->iommu;
> +	u32 max_pasids = 0;
> +	int ret;
> 
>  	if (param)
>  		return param;
> @@ -202,6 +205,18 @@ static struct dev_iommu *dev_iommu_get(struct device
> *dev)
>  	if (!param)
>  		return NULL;
> 
> +	if (dev_is_pci(dev)) {
> +		ret = pci_max_pasids(to_pci_dev(dev));
> +		if (ret > 0)
> +			max_pasids = ret;
> +	} else {
> +		ret = device_property_read_u32(dev, "pasid-num-bits",
> +					       &max_pasids);
> +		if (!ret)
> +			max_pasids = (1UL << max_pasids);
> +	}
> +	param->pasids = max_pasids;
> +

we could also do a min() with the IOMMU PASID size here

>  	mutex_init(&param->lock);
>  	dev->iommu = param;
>  	return param;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 45f274b2640d..d4296136ba75 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -371,6 +371,7 @@ struct iommu_fault_param {
>   * @fwspec:	 IOMMU fwspec data
>   * @iommu_dev:	 IOMMU device this device is linked to
>   * @priv:	 IOMMU Driver private data
> + * @pasids:	 number of supported PASIDs

'max_pasids' to stay consistent?

Thanks,
Jean

>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> @@ -382,6 +383,7 @@ struct dev_iommu {
>  	struct iommu_fwspec		*fwspec;
>  	struct iommu_device		*iommu_dev;
>  	void				*priv;
> +	u32				pasids;
>  };
> 
>  int iommu_device_register(struct iommu_device *iommu,
> -- 
> 2.25.1
> 
> Best regards,
> baolu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
