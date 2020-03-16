Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75781C18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3591720679
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:50:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bLP9tzXH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3591720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1859220529;
	Mon, 16 Mar 2020 15:50:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Vyy8oGnwABJH; Mon, 16 Mar 2020 15:50:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id D0670203D3;
	Mon, 16 Mar 2020 15:50:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A28E7C1D7C;
	Mon, 16 Mar 2020 15:50:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40E5EC013E
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:49:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2C6ED87141
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:49:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UCb4hbpt0MuE for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:49:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6139F87122
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:49:58 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id a141so18638865wme.2
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:49:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=cOIEYtWNEzlYYthtD0spEjkukXqfmxlfoFYyEio2yD4=;
 b=bLP9tzXHgsnZOO+gQY30NTwMxHujM+PxDf2Pr2BsRs9UN3PNl67882FriKQhyCzQBr
 TQvoYRDzZIEuZjT7HWvj9ryRh0wafj4b7mSPg86iUfXDu3MNCvfAIbQ4I6SS/cLilfBh
 zMVdnQIcxINkndSo9MyT7JC/g4ws4131+16aS9y6jaXhUaO7tb8k1sGg+cmElZUSjHvf
 nKD3AWMMSBYWgumDkjJNP77sHEVHIJpLXozOmkpGlN6fzZlvjPS6WDKFGpj2t6vQjwFm
 6iyRvLJuu8HH4z1PQSOJsYFBsODpIu2hXolpCRed+/OXwkJGe0xQdQ4Mvpx9JFxwkUU9
 wcFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=cOIEYtWNEzlYYthtD0spEjkukXqfmxlfoFYyEio2yD4=;
 b=I3pKazzbO/wq7it9AmY4oMX6d+snwarsZUOXc76ff+6VOXgOZMXLnOPwW7kjOdiX0l
 cHK6LxT1Vg6ccSThYUdEzSPzZuGGdsNZggdtr/UOBSXGlXtvdRy5C2o7AQmqq+RScW++
 /HL5ZGTL93pA/FuvjVV0mOynre2Ty3+PK0lqQpU4JTRyml/Ltmks0/bm544Z4kYoa7sw
 /ssd1/1QOxCT/SDsCvieeXkcBHOcV0aODDQXHWU45BF89Og/aIGC6Ila8BhiVbgiSJTs
 RVijt0dQwHCz3YHRN/dUN46Fc+noQSAadse6zvOh4S2KuNOMOAZLUiq11Jov9tl7xSMI
 cEqA==
X-Gm-Message-State: ANhLgQ3e2GdEHiFWtW2yqLzFjKIj2DlSlmphQcFQvaViIRSoFMo9R34J
 8IB3/FCbNjR7HmqDX4Kpwajy8w==
X-Google-Smtp-Source: ADFU+vv4N7xQNm1wFNrIZmN2Kg+Ua4DIBj8t6C6sgaFA18dYvUkMu368tWpVIaA4w1ORNN6r5eo5hg==
X-Received: by 2002:a1c:7c05:: with SMTP id x5mr28123545wmc.67.1584373796917; 
 Mon, 16 Mar 2020 08:49:56 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id 9sm127395wmx.32.2020.03.16.08.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:49:56 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:49:48 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 09/15] iommu/arm-smmu-v3: Use accessor functions for
 iommu private data
Message-ID: <20200316154948.GJ304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-10-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-10-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:23AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Make use of dev_iommu_priv_set/get() functions in the code.
> 
> Tested-by: Hanjun Guo <guohanjun@huawei.com>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/iommu/arm-smmu-v3.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iommu/arm-smmu-v3.c b/drivers/iommu/arm-smmu-v3.c
> index aa3ac2a03807..2b68498dfb66 100644
> --- a/drivers/iommu/arm-smmu-v3.c
> +++ b/drivers/iommu/arm-smmu-v3.c
> @@ -2659,7 +2659,7 @@ static int arm_smmu_attach_dev(struct iommu_domain *domain, struct device *dev)
>  	if (!fwspec)
>  		return -ENOENT;
>  
> -	master = fwspec->iommu_priv;
> +	master = dev_iommu_priv_get(dev);
>  	smmu = master->smmu;
>  
>  	arm_smmu_detach_dev(master);
> @@ -2795,7 +2795,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>  		return -ENODEV;
>  
> -	if (WARN_ON_ONCE(fwspec->iommu_priv))
> +	if (WARN_ON_ONCE(dev_iommu_priv_get(dev)))
>  		return -EBUSY;
>  
>  	smmu = arm_smmu_get_by_fwnode(fwspec->iommu_fwnode);
> @@ -2810,7 +2810,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	master->smmu = smmu;
>  	master->sids = fwspec->ids;
>  	master->num_sids = fwspec->num_ids;
> -	fwspec->iommu_priv = master;
> +	dev_iommu_priv_set(dev, master);
>  
>  	/* Check the SIDs are in range of the SMMU and our stream table */
>  	for (i = 0; i < master->num_sids; i++) {
> @@ -2852,7 +2852,7 @@ static int arm_smmu_add_device(struct device *dev)
>  	iommu_device_unlink(&smmu->iommu, dev);
>  err_free_master:
>  	kfree(master);
> -	fwspec->iommu_priv = NULL;
> +	dev_iommu_priv_set(dev, NULL);
>  	return ret;
>  }
>  
> @@ -2865,7 +2865,7 @@ static void arm_smmu_remove_device(struct device *dev)
>  	if (!fwspec || fwspec->ops != &arm_smmu_ops)
>  		return;
>  
> -	master = fwspec->iommu_priv;
> +	master = dev_iommu_priv_get(dev);
>  	smmu = master->smmu;
>  	arm_smmu_detach_dev(master);
>  	iommu_group_remove_device(dev);
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
