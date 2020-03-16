Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B21BFC0044D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:29 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A94520679
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:51:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ql9YUBVP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A94520679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5633C872E7;
	Mon, 16 Mar 2020 15:51:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ON91Gmlepj0O; Mon, 16 Mar 2020 15:51:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A317387285;
	Mon, 16 Mar 2020 15:51:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FBCFC1D88;
	Mon, 16 Mar 2020 15:51:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71385C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:51:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6D19A88447
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:51:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofGT1bFquJJI for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:51:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 41C1688443
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:51:26 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id 6so18238028wmi.5
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=KkyluvbCo1smPziuTMI1rpctD2ZygqnkeyljtuoXeEw=;
 b=Ql9YUBVPAc49FI42xu2eB/uVJuxhsY9YoQnZ0XtFjXM6HeXXOBU835hweTKfAEM9zr
 ot/OVovpdvovqb2hWye7+Dj/qnKTGEkRPtuI0NO5twoZx0/MwgjkoH50sjShfw/4xGDj
 q1qnW1Z1JfMLv111SRHS2M4QOxcIoR8jkUpSGfneogiiGz5Pr0uTllS+/TIx635iELsG
 u6YJoIDM7d3hVfVFSBh5x6kT2cHR+EaZwyTgm6kbxv7LY9h4Q+f0ytoQ41X42SgS4HLo
 Rq7GsvA0EhReqsXX/ReWo+oazsMqbZTNhtJUGHfm5pRqt+vWwkp5C2wusM4Pinn9EBm/
 MsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KkyluvbCo1smPziuTMI1rpctD2ZygqnkeyljtuoXeEw=;
 b=lTA8XybW2HBMPYiShm13aQk8LmqCWGr9knIfyvqvOn/1SLQN8Ng7cPQrzHsrAvdF+a
 2Q1BOtB6CCsSB/8Hg6gaACK7DjVE7PraDQ82jRxrzRDXSFvyKoHMO2mEG8sHCAdDF4dN
 RvtRNTJEYU55+iqc0EgN63YAuwwhPdTnywU09CvXibEU71Oz1/tiwr+ZbAeMkIGlqVpw
 1FbhkyMZoDr2n+eD6MMEFVo0pzwqOa4w6Ia/h1SiaWJbgCZQkTzWXRaRTfDQ6sGD1BbX
 IHOWptSg/hIXZWNS2uKhds+n6lBRBKsTCJ4hV6KxeLroi/7mis+m6jom3KJs34A1LRqw
 s+RQ==
X-Gm-Message-State: ANhLgQ1Iettb8j3f5dn0Byf8G6NmS69H4UiJbGrMZcZLmobCf/iB/lJ+
 zLshLxT0pV+67mriwU+hArhXDQ==
X-Google-Smtp-Source: ADFU+vsOzPwdH8tCDCurHNefcxT+FZBJmWj2HiUatr8Ym5ck83x1h29ClX9491yXix2EVw/gHBFPRA==
X-Received: by 2002:a1c:ab04:: with SMTP id u4mr28315891wme.88.1584373884542; 
 Mon, 16 Mar 2020 08:51:24 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id s22sm143823wmc.16.2020.03.16.08.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:51:23 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:51:16 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 12/15] iommu/mediatek: Use accessor functions for iommu
 private data
Message-ID: <20200316155116.GL304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-13-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-13-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:26AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/mtk_iommu.c    | 13 ++++++-------
>  drivers/iommu/mtk_iommu_v1.c | 14 +++++++-------
>  2 files changed, 13 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/iommu/mtk_iommu.c b/drivers/iommu/mtk_iommu.c
> index 95945f467c03..5f4d6df59cf6 100644
> --- a/drivers/iommu/mtk_iommu.c
> +++ b/drivers/iommu/mtk_iommu.c
> @@ -358,8 +358,8 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
>  static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  				   struct device *dev)
>  {
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> -	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
>  
>  	if (!data)
>  		return -ENODEV;
> @@ -378,7 +378,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  static void mtk_iommu_detach_device(struct iommu_domain *domain,
>  				    struct device *dev)
>  {
> -	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  
>  	if (!data)
>  		return;
> @@ -450,7 +450,7 @@ static int mtk_iommu_add_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>  		return -ENODEV; /* Not a iommu client device */
>  
> -	data = fwspec->iommu_priv;
> +	data = dev_iommu_priv_get(dev);
>  	iommu_device_link(&data->iommu, dev);
>  
>  	group = iommu_group_get_for_dev(dev);
> @@ -469,7 +469,7 @@ static void mtk_iommu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>  		return;
>  
> -	data = fwspec->iommu_priv;
> +	data = dev_iommu_priv_get(dev);
>  	iommu_device_unlink(&data->iommu, dev);
>  
>  	iommu_group_remove_device(dev);
> @@ -496,7 +496,6 @@ static struct iommu_group *mtk_iommu_device_group(struct device *dev)
>  
>  static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  {
> -	struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
>  	struct platform_device *m4updev;
>  
>  	if (args->args_count != 1) {
> @@ -505,13 +504,13 @@ static int mtk_iommu_of_xlate(struct device *dev, struct of_phandle_args *args)
>  		return -EINVAL;
>  	}
>  
> -	if (!fwspec->iommu_priv) {
> +	if (!dev_iommu_priv_get(dev)) {
>  		/* Get the m4u device */
>  		m4updev = of_find_device_by_node(args->np);
>  		if (WARN_ON(!m4updev))
>  			return -EINVAL;
>  
> -		fwspec->iommu_priv = platform_get_drvdata(m4updev);
> +		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
>  	}
>  
>  	return iommu_fwspec_add_ids(dev, args->args, 1);
> diff --git a/drivers/iommu/mtk_iommu_v1.c b/drivers/iommu/mtk_iommu_v1.c
> index e93b94ecac45..9930ac7413cc 100644
> --- a/drivers/iommu/mtk_iommu_v1.c
> +++ b/drivers/iommu/mtk_iommu_v1.c
> @@ -263,8 +263,8 @@ static void mtk_iommu_domain_free(struct iommu_domain *domain)
>  static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  				   struct device *dev)
>  {
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  	struct mtk_iommu_domain *dom = to_mtk_domain(domain);
> -	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
>  	int ret;
>  
>  	if (!data)
> @@ -286,7 +286,7 @@ static int mtk_iommu_attach_device(struct iommu_domain *domain,
>  static void mtk_iommu_detach_device(struct iommu_domain *domain,
>  				    struct device *dev)
>  {
> -	struct mtk_iommu_data *data = dev_iommu_fwspec_get(dev)->iommu_priv;
> +	struct mtk_iommu_data *data = dev_iommu_priv_get(dev);
>  
>  	if (!data)
>  		return;
> @@ -387,20 +387,20 @@ static int mtk_iommu_create_mapping(struct device *dev,
>  		return -EINVAL;
>  	}
>  
> -	if (!fwspec->iommu_priv) {
> +	if (!dev_iommu_priv_get(dev)) {
>  		/* Get the m4u device */
>  		m4updev = of_find_device_by_node(args->np);
>  		if (WARN_ON(!m4updev))
>  			return -EINVAL;
>  
> -		fwspec->iommu_priv = platform_get_drvdata(m4updev);
> +		dev_iommu_priv_set(dev, platform_get_drvdata(m4updev));
>  	}
>  
>  	ret = iommu_fwspec_add_ids(dev, args->args, 1);
>  	if (ret)
>  		return ret;
>  
> -	data = fwspec->iommu_priv;
> +	data = dev_iommu_priv_get(dev);
>  	m4udev = data->dev;
>  	mtk_mapping = m4udev->archdata.iommu;
>  	if (!mtk_mapping) {
> @@ -459,7 +459,7 @@ static int mtk_iommu_add_device(struct device *dev)
>  	if (err)
>  		return err;
>  
> -	data = fwspec->iommu_priv;
> +	data = dev_iommu_priv_get(dev)
>  	mtk_mapping = data->dev->archdata.iommu;
>  	err = arm_iommu_attach_device(dev, mtk_mapping);
>  	if (err) {
> @@ -478,7 +478,7 @@ static void mtk_iommu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &mtk_iommu_ops)
>  		return;
>  
> -	data = fwspec->iommu_priv;
> +	data = dev_iommu_priv_get(dev)
>  	iommu_device_unlink(&data->iommu, dev);
>  
>  	iommu_group_remove_device(dev);
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
