Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E5B7C2BB1D
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:45:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5FAD2051A
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:45:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hxXhoxAr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5FAD2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2E14B871C6;
	Mon, 16 Mar 2020 15:45:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Raq6kkJTenkx; Mon, 16 Mar 2020 15:45:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 60D3E8716B;
	Mon, 16 Mar 2020 15:45:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F6D6C1D88;
	Mon, 16 Mar 2020 15:45:20 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2EE6C013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:45:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id A1E62883D4
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:45:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwLr6Je48+jR for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:45:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1666B883D3
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:45:17 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z15so21819668wrl.1
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=hEmn41e48jqvaiXw5xLaWp2S+l0O2jS39TBL03MNI00=;
 b=hxXhoxArp91c63USSVFsklYGXMgLrrsjkhu5g1UGp1zyy2n8XTBfkiR1Trc0tz1WDB
 7rlFlfA3mTHUn9N/PzaQY4rBvksNd1syevhlYwAUW3Ru2jaBWBY+0Xosvk28KeTgjJ5j
 jqJylm90J/u+L5kQGPjfiHUCGLkj+K1nTT8AIFuI+hnVn5ICTQeRsbvUyOUlfQCpoJEb
 oKmfyotDHtwV15SBsR6EOXaEANsTKHX+WqTAugb9REmnvneIy//03pcbyRK6jF1YaIkL
 E1kIK+f+hMAdAicfTbCRpa//PRNo1gqmMgex84Csuk7ee/H88bIWixhXbf+II68tzgDr
 +Y1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=hEmn41e48jqvaiXw5xLaWp2S+l0O2jS39TBL03MNI00=;
 b=GMjRGFjMuwFvwU93YVjbAYlmn5hFlG+ZWc7QBnQ9OCLj7KXLg1iaoLHqSVKsgY0JhD
 IwY1bcxsS2MzEwQ+tUjp1o2HN4QuO7CeQjEOEqkHGCMmu880iQ2GvxnAvG3Bv5IFr4LU
 cH5W4P08wprIAvr1pZXIq8IfdCRxZfgV7+eIpG3oTYiCG5KvWx9QNgpucW9uZxQcNN7b
 4QkYwRpCfdGsrqPv+yG2lMXYC8Og+R7th0GjFnipUOJQCJ9/EjaSFRDXiTaXVbmjLJRk
 g78WIAGFhf0t3DUHYXV595qVD215l/hgWTYFRrkqrMjQXju9Jo845LjKg0zkhUpqCuxd
 /b0g==
X-Gm-Message-State: ANhLgQ0i8PfIXczhOU5yAh/Eu5Srj5sagzR+yqVBwZO3zEaddV7eG1ae
 LNW35+r1AJ+PFai+VYb9Tlddfw==
X-Google-Smtp-Source: ADFU+vuSIPxQ2tXAem/Xsf3GS6Qs55Yq15VaQJIudTFkEtog7LxN1oleC+jlmpa06uPiU5W3lvjDZw==
X-Received: by 2002:a05:6000:1212:: with SMTP id
 e18mr20630902wrx.371.1584373515410; 
 Mon, 16 Mar 2020 08:45:15 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id b12sm407322wro.66.2020.03.16.08.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:45:14 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:45:07 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 05/15] iommu: Rename struct iommu_param to dev_iommu
Message-ID: <20200316154507.GF304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-6-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-6-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:19AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The term dev_iommu aligns better with other existing structures and
> their accessor functions.
> 
> Tested-by: Will Deacon <will@kernel.org> # arm-smmu
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/iommu.c  | 28 ++++++++++++++--------------
>  include/linux/device.h |  6 +++---
>  include/linux/iommu.h  |  4 ++--
>  3 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 3e3528436e0b..beac2ef063dd 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -152,9 +152,9 @@ void iommu_device_unregister(struct iommu_device *iommu)
>  }
>  EXPORT_SYMBOL_GPL(iommu_device_unregister);
>  
> -static struct iommu_param *iommu_get_dev_param(struct device *dev)
> +static struct dev_iommu *dev_iommu_get(struct device *dev)
>  {
> -	struct iommu_param *param = dev->iommu_param;
> +	struct dev_iommu *param = dev->iommu;
>  
>  	if (param)
>  		return param;
> @@ -164,14 +164,14 @@ static struct iommu_param *iommu_get_dev_param(struct device *dev)
>  		return NULL;
>  
>  	mutex_init(&param->lock);
> -	dev->iommu_param = param;
> +	dev->iommu = param;
>  	return param;
>  }
>  
> -static void iommu_free_dev_param(struct device *dev)
> +static void dev_iommu_free(struct device *dev)
>  {
> -	kfree(dev->iommu_param);
> -	dev->iommu_param = NULL;
> +	kfree(dev->iommu);
> +	dev->iommu = NULL;
>  }
>  
>  int iommu_probe_device(struct device *dev)
> @@ -183,7 +183,7 @@ int iommu_probe_device(struct device *dev)
>  	if (!ops)
>  		return -EINVAL;
>  
> -	if (!iommu_get_dev_param(dev))
> +	if (!dev_iommu_get(dev))
>  		return -ENOMEM;
>  
>  	if (!try_module_get(ops->owner)) {
> @@ -200,7 +200,7 @@ int iommu_probe_device(struct device *dev)
>  err_module_put:
>  	module_put(ops->owner);
>  err_free_dev_param:
> -	iommu_free_dev_param(dev);
> +	dev_iommu_free(dev);
>  	return ret;
>  }
>  
> @@ -211,9 +211,9 @@ void iommu_release_device(struct device *dev)
>  	if (dev->iommu_group)
>  		ops->remove_device(dev);
>  
> -	if (dev->iommu_param) {
> +	if (dev->iommu) {
>  		module_put(ops->owner);
> -		iommu_free_dev_param(dev);
> +		dev_iommu_free(dev);
>  	}
>  }
>  
> @@ -972,7 +972,7 @@ int iommu_register_device_fault_handler(struct device *dev,
>  					iommu_dev_fault_handler_t handler,
>  					void *data)
>  {
> -	struct iommu_param *param = dev->iommu_param;
> +	struct dev_iommu *param = dev->iommu;
>  	int ret = 0;
>  
>  	if (!param)
> @@ -1015,7 +1015,7 @@ EXPORT_SYMBOL_GPL(iommu_register_device_fault_handler);
>   */
>  int iommu_unregister_device_fault_handler(struct device *dev)
>  {
> -	struct iommu_param *param = dev->iommu_param;
> +	struct dev_iommu *param = dev->iommu;
>  	int ret = 0;
>  
>  	if (!param)
> @@ -1055,7 +1055,7 @@ EXPORT_SYMBOL_GPL(iommu_unregister_device_fault_handler);
>   */
>  int iommu_report_device_fault(struct device *dev, struct iommu_fault_event *evt)
>  {
> -	struct iommu_param *param = dev->iommu_param;
> +	struct dev_iommu *param = dev->iommu;
>  	struct iommu_fault_event *evt_pending = NULL;
>  	struct iommu_fault_param *fparam;
>  	int ret = 0;
> @@ -1104,7 +1104,7 @@ int iommu_page_response(struct device *dev,
>  	int ret = -EINVAL;
>  	struct iommu_fault_event *evt;
>  	struct iommu_fault_page_request *prm;
> -	struct iommu_param *param = dev->iommu_param;
> +	struct dev_iommu *param = dev->iommu;
>  	struct iommu_domain *domain = iommu_get_domain_for_dev(dev);
>  
>  	if (!domain || !domain->ops->page_response)
> diff --git a/include/linux/device.h b/include/linux/device.h
> index fa04dfd22bbc..405a8f11bec1 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -44,7 +44,7 @@ struct iommu_ops;
>  struct iommu_group;
>  struct iommu_fwspec;
>  struct dev_pin_info;
> -struct iommu_param;
> +struct dev_iommu;
>  
>  /**
>   * struct subsys_interface - interfaces to device functions
> @@ -514,7 +514,7 @@ struct dev_links_info {
>   * 		device (i.e. the bus driver that discovered the device).
>   * @iommu_group: IOMMU group the device belongs to.
>   * @iommu_fwspec: IOMMU-specific properties supplied by firmware.
> - * @iommu_param: Per device generic IOMMU runtime data
> + * @iommu:	Per device generic IOMMU runtime data
>   *
>   * @offline_disabled: If set, the device is permanently online.
>   * @offline:	Set after successful invocation of bus type's .offline().
> @@ -614,7 +614,7 @@ struct device {
>  	void	(*release)(struct device *dev);
>  	struct iommu_group	*iommu_group;
>  	struct iommu_fwspec	*iommu_fwspec;
> -	struct iommu_param	*iommu_param;
> +	struct dev_iommu	*iommu;
>  
>  	bool			offline_disabled:1;
>  	bool			offline:1;
> diff --git a/include/linux/iommu.h b/include/linux/iommu.h
> index 3c4ca041d7a2..1c9fa5c1174b 100644
> --- a/include/linux/iommu.h
> +++ b/include/linux/iommu.h
> @@ -365,7 +365,7 @@ struct iommu_fault_param {
>  };
>  
>  /**
> - * struct iommu_param - collection of per-device IOMMU data
> + * struct dev_iommu - Collection of per-device IOMMU data
>   *
>   * @fault_param: IOMMU detected device fault reporting data
>   *
> @@ -373,7 +373,7 @@ struct iommu_fault_param {
>   *	struct iommu_group	*iommu_group;
>   *	struct iommu_fwspec	*iommu_fwspec;
>   */
> -struct iommu_param {
> +struct dev_iommu {
>  	struct mutex lock;
>  	struct iommu_fault_param *fault_param;
>  };
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
