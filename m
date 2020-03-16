Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA4DC18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:09 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F06B20679
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:47:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lWNxgXfi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F06B20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 5073B21567;
	Mon, 16 Mar 2020 15:47:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0AzWF-RSInN8; Mon, 16 Mar 2020 15:47:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 9957D2156C;
	Mon, 16 Mar 2020 15:47:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81241C1D88;
	Mon, 16 Mar 2020 15:47:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84EA6C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 819A287286
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id EtoFWKHMqbol for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:47:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com
 [209.85.128.66])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 94D30872A4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:47:03 +0000 (UTC)
Received: by mail-wm1-f66.google.com with SMTP id a132so18217120wme.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=GYsjb8wyMpitfSH0f8PA0mHjVYM9QWEBO9gCjay1L20=;
 b=lWNxgXfim4KYtEIBQRfki0eiyE/BWsrHh3mBkMGppzItkVPtihwUMSFvFNJ8xZBe/a
 brVy81DoW/z2tKhjRZCiCm/G+1HhJ4ivW/m8mNYUQ+5UJU0ouy6jtCyhH/U78JntPD50
 wA8YP4LnsMZBrluKad4Gdo4I6gdkfckXd+n28BgxyvvOZK40MupWY1itrZtSmK4bF7X3
 Lf8kgqGrtsTg2Pm92hWC3TpUqUqzFNt3JRDsmfiXg94brnBo2XJWC7QC0YLSYk8SkyIu
 pOSYqrLqVT2tAJ803lgFos/Qzi2xRy+O8Q6vbrgrPbyuCSc1hNAso5Tb2xZB8RKLPxC4
 BJkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GYsjb8wyMpitfSH0f8PA0mHjVYM9QWEBO9gCjay1L20=;
 b=f68DNUN1j4131gSX6cYNVBII4Sb/iYqmweg7sGAhcmelTCc/SAWksdYTEJ8ZJ5dB8v
 OxFlIs5ClsJrgh2NHMP15Z1q4OFQqZ4GSctLOkcT7sb2tKEzL/+CwtSVkaL/9ozMqXI0
 YxqxHBUVc+KaesH+wlB1RkBvi2AeZXeNinqQJLexCqXjb9nieqNJvicVCeEQhj09jngn
 TOEymtzIq18peVuzVTd8iKdVIrjovADN3XHqb3zeq+C8PChZQXeECp+5RwCSvE4z7PIA
 ewZIuNLB238n6ETrzdcuZA/Wpz+UCBe9pWhFysIYBaslnGKk6ne5CuuYG7xZUnjyR33k
 S0cw==
X-Gm-Message-State: ANhLgQ2NIYaCvbtbd50SP1TUP3uwot+DchWbhUErzfFTs4wCOcMfsCOh
 2ozmhP3rmXs4QEfOn3z/P+QU0w==
X-Google-Smtp-Source: ADFU+vug65fGoL5TKdymAh0vmL/kEClqE8KiEqVXS5gBbtx7HyWfeUkjQSmjqTq49k3w6tjjBOsBAA==
X-Received: by 2002:a7b:c019:: with SMTP id c25mr28919018wmb.126.1584373622085; 
 Mon, 16 Mar 2020 08:47:02 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id l8sm164858wmj.2.2020.03.16.08.47.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:47:01 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:46:54 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 06/15] iommu: Move iommu_fwspec to struct dev_iommu
Message-ID: <20200316154654.GG304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-7-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-7-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:20AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Move the iommu_fwspec pointer in struct device into struct dev_iommu.
> This is a step in the effort to reduce the iommu related pointers in
> struct device to one.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/iommu/iommu.c  |  3 +++
>  include/linux/device.h |  1 -
>  include/linux/iommu.h  | 12 ++++++++----
>  3 files changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index beac2ef063dd..826a67ba247f 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -2405,6 +2405,9 @@ int iommu_fwspec_init(struct device *dev, struct fwnode_handle *iommu_fwnode,
>  	if (fwspec)
>  		return ops == fwspec->ops ? 0 : -EINVAL;
>  
> +	if (!dev_iommu_get(dev))
> +		return -ENOMEM;
> +
>  	fwspec = kzalloc(sizeof(*fwspec), GFP_KERNEL);
>  	if (!fwspec)
>  		return -ENOMEM;
> diff --git a/include/linux/device.h b/include/linux/device.h
> index 405a8f11bec1..ca29c39a6480 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -613,7 +613,6 @@ struct device {
>  
>  	void	(*release)(struct device *dev);
>  	struct iommu_group	*iommu_group;
> -	struct iommu_fwspec	*iommu_fwspec;
>  	struct dev_iommu	*iommu;
>  
>  	bool			offline_disabled:1;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 1c9fa5c1174b..f5edc21a644d 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -368,14 +368,15 @@ struct iommu_fault_param {
>   * struct dev_iommu - Collection of per-device IOMMU data
>   *
>   * @fault_param: IOMMU detected device fault reporting data
> + * @fwspec:	 IOMMU fwspec data
>   *
>   * TODO: migrate other per device data pointers under iommu_dev_data, e.g.
>   *	struct iommu_group	*iommu_group;
> - *	struct iommu_fwspec	*iommu_fwspec;
>   */
>  struct dev_iommu {
>  	struct mutex lock;
> -	struct iommu_fault_param *fault_param;
> +	struct iommu_fault_param	*fault_param;
> +	struct iommu_fwspec		*fwspec;
>  };
>  
>  int  iommu_device_register(struct iommu_device *iommu);
> @@ -614,13 +615,16 @@ const struct iommu_ops *iommu_ops_from_fwnode(struct fwnode_handle *fwnode);
>  
>  static inline struct iommu_fwspec *dev_iommu_fwspec_get(struct device *dev)
>  {
> -	return dev->iommu_fwspec;
> +	if (dev->iommu)
> +		return dev->iommu->fwspec;
> +	else
> +		return NULL;
>  }
>  
>  static inline void dev_iommu_fwspec_set(struct device *dev,
>  					struct iommu_fwspec *fwspec)
>  {
> -	dev->iommu_fwspec = fwspec;
> +	dev->iommu->fwspec = fwspec;

It may be worth moving the set() to iommu.c and prevent any misuse.
Regardless:

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

>  }
>  
>  int iommu_probe_device(struct device *dev);
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
