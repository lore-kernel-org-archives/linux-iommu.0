Return-Path: <SRS0=N4Nm=5B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03033C18E5B
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:42:23 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C233920663
	for <iommu@archiver.kernel.org>; Mon, 16 Mar 2020 15:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SuBjR7SX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C233920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 697A687141;
	Mon, 16 Mar 2020 15:42:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sXT8c-KlUnSJ; Mon, 16 Mar 2020 15:42:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD82187149;
	Mon, 16 Mar 2020 15:42:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C33B3C1D88;
	Mon, 16 Mar 2020 15:42:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0CB1C1D7C
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:42:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id AF57188CE6
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:42:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UBm7KzOY2Nnn for <iommu@lists.linux-foundation.org>;
 Mon, 16 Mar 2020 15:42:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D09D488CCD
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 15:42:18 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id h6so1498118wrs.6
 for <iommu@lists.linux-foundation.org>; Mon, 16 Mar 2020 08:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=EuH2JuinWmp99M5kgpRBVbGMWPMpSteTL2l8ALHXOxA=;
 b=SuBjR7SXVaKqCALkd1H8UtvNwExNZJ6zJgrMM6mOmR/V8duV2z/Ny/rgwl/ICWYmHv
 RWBK+M3PyiJlb3+IMItQHsDQF5jSLhvuAHwNcv6LMVHk4wOfYJKCJcuzotqrz3dAGYH1
 ZoMfxYPhj1aGisNVytbbz16FGd19F/GLWWKqmyz5QVUWCH852OZkHrnPPIWPrqC4neyS
 a7v3wobNSSlJVCWjnzCdEU/vJKwAqNo9QlJDdZZzhe6JJt9HI/Adz/aIlbUVRlVc5+r/
 Wh3K+T1U8mRgzEN73lsQyDrC/jgt58bTBPttxWkvcuF/uHNDyFjl6FzCmQvD6Dy4PO5f
 8Mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EuH2JuinWmp99M5kgpRBVbGMWPMpSteTL2l8ALHXOxA=;
 b=csaHMc0PpYvRue7DsAI2vNiAXxgwf1qp6no/JO1y3WuMEbEknac6atKahWl7822oYw
 s8PLBDVSui4qUxou14CzqiABSX/RCsXvBN7f2z0YB9zgr6FfVXtcJzL6/P9dvCsIJoXF
 UwPY3XCVXrR0IeypDTpZkylMYOLf28qLfxxvYdAfrD1VFWgTnD6A+BwibXlQ2bpYTGIQ
 otFxybp/fSf5k7sxAutQ/5SUuXl8xHsTv3Oq8LSnz9AO1CriEafQM7+MhCj1hu59qT4U
 fXPHhm4wPto7KgsKzC+f1ZcZ8dDeVc2lyuhjfduH0CNFxj2ggQeEiy9T6jZLmh6vZ53Y
 1EKg==
X-Gm-Message-State: ANhLgQ2YrGxA5nUXiSp2mAAk5SLWmw8O85vGZ/yJ2KSpBg5xND6BNfUO
 hT7X/Zy6tHBUWjY6YDBMKlwY4g==
X-Google-Smtp-Source: ADFU+vtvdsyytNA9HXn2kU8Gc/Wj/vUyTOW35SEjh5aHAlAPKupONXAmkHYxA+n8rH6jwZStjuAuGg==
X-Received: by 2002:adf:9e8b:: with SMTP id a11mr9088wrf.32.1584373337353;
 Mon, 16 Mar 2020 08:42:17 -0700 (PDT)
Received: from myrica ([2001:171b:226b:54a0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id y80sm85174wmc.45.2020.03.16.08.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2020 08:42:16 -0700 (PDT)
Date: Mon, 16 Mar 2020 16:42:09 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH 03/15] drm/msm/mdp5: Remove direct access of
 dev->iommu_fwspec
Message-ID: <20200316154209.GD304669@myrica>
References: <20200310091229.29830-1-joro@8bytes.org>
 <20200310091229.29830-4-joro@8bytes.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200310091229.29830-4-joro@8bytes.org>
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

On Tue, Mar 10, 2020 at 10:12:17AM +0100, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> Use the accessor functions instead of directly dereferencing
> dev->iommu_fwspec.
> 
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> index e43ecd4be10a..1252e1d76340 100644
> --- a/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> +++ b/drivers/gpu/drm/msm/disp/mdp5/mdp5_kms.c
> @@ -725,7 +725,7 @@ struct msm_kms *mdp5_kms_init(struct drm_device *dev)
>  
>  	if (config->platform.iommu) {
>  		iommu_dev = &pdev->dev;
> -		if (!iommu_dev->iommu_fwspec)
> +		if (!dev_iommu_fwspec_get(iommu_dev))
>  			iommu_dev = iommu_dev->parent;
>  
>  		aspace = msm_gem_address_space_create(iommu_dev,
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
