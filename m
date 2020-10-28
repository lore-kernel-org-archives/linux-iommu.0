Return-Path: <SRS0=WwkY=ED=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A5C5C4363A
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 09:14:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6409F2468F
	for <iommu@archiver.kernel.org>; Wed, 28 Oct 2020 09:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nOEA62LX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6409F2468F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id C21E786AFF;
	Wed, 28 Oct 2020 09:14:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YSxKfEFMwWY6; Wed, 28 Oct 2020 09:14:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3484A866E9;
	Wed, 28 Oct 2020 09:14:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1F528C0859;
	Wed, 28 Oct 2020 09:14:20 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9C9E6C0051
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 09:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 96F8620414
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 09:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W8Jcd4mYSuye for <iommu@lists.linux-foundation.org>;
 Wed, 28 Oct 2020 09:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by silver.osuosl.org (Postfix) with ESMTPS id 6BCA5203F4
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 09:14:18 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id w14so818354wrs.9
 for <iommu@lists.linux-foundation.org>; Wed, 28 Oct 2020 02:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=XxrzQX3BzJOYNo3ryQvKP9GXKFL7YZjWkWILZ8le+eE=;
 b=nOEA62LX8zuX3fjRZDQb47TSG2bsbdVQJiK3Wc2KnY+MiOncROWA/OS69XLWYuVSCN
 znHpWRURnyci9cZvWLBc09JevmMkYW8DmdW0pthtQTP53hUoABaB0U3CLdea2w9p5qYh
 05v/FxKVUKELY+HxH1pfTw8YCx9CzXoy1+5Z3II5viUnjNOdKLnt363gj34QMEGpGHj2
 39CGMwmA4scUpEVaR4fCmOyxuWhaI+nOQ1vRc6FIfbKZ/MDscKSzbdpu3LUnuAUpvEKE
 qqrYxHcavIKxtvFvs7lM9wk+/2+1gJAJ7pk56vD3JQXkWD6m5+h3S2O5l1DcfDcuA3X/
 L0wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XxrzQX3BzJOYNo3ryQvKP9GXKFL7YZjWkWILZ8le+eE=;
 b=W25vzNjE5666lpH8EhFTU1O+O9mzTV8hQm5uo1n4Kse8lPOjsj+R1vFZzhsulBa8sj
 buRDMKSJ1eis54xiQd2qTotPTcAbk/lx/2P4UBKbcBGbX9HvQJQ75jViFW5yz9l0fj3Q
 DubEykGijX6l6lXxcodzzxDZF+o2WKvJSo5GAx1fA+CzRhETJWpmgSZYFzt752D0ja79
 8rpAp0NsGaAr/sSIy2WGFxHQag42zOBVoBeUghPewPHm+pbh1bnwnsBsCAud5TDpYli3
 xBOgZm/kExmVZ3UffN8gx+pjgHI2vobThE+W8AlfpYUZR1Ly6nMU+GsxW/H9DKJglpqQ
 NO4A==
X-Gm-Message-State: AOAM5312UkOfNdjL9cKHeetEyiZ4CtwIAyBJZH+dVgwI9FMPcoMlrmZk
 d1pLqB4WZZ9QRhLCzRGaAy3PLA==
X-Google-Smtp-Source: ABdhPJxmYxNUTo2Fwgp2nMPtc9QpYwPLn5MShu2QN0UiC8tH6b7M5njy4aWgP1GqIguNpetjw+gxsA==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr7275297wro.328.1603876456793; 
 Wed, 28 Oct 2020 02:14:16 -0700 (PDT)
Received: from myrica ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id e5sm5709509wrw.93.2020.10.28.02.14.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 02:14:16 -0700 (PDT)
Date: Wed, 28 Oct 2020 10:13:56 +0100
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Yi Sun <yi.y.sun@linux.intel.com>
Subject: Re: [PATCH v1 2/3] iommu: Fix an issue in iommu_page_response()
 flags check
Message-ID: <20201028091356.GB2328726@myrica>
References: <1603849018-6578-1-git-send-email-yi.y.sun@linux.intel.com>
 <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1603849018-6578-3-git-send-email-yi.y.sun@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, dwmw2@infradead.org,
 iommu@lists.linux-foundation.org
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

Hi,

On Wed, Oct 28, 2020 at 09:36:57AM +0800, Yi Sun wrote:
> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
> 
> original code fails when LAST_PAGE is set in flags.

LAST_PAGE is not documented to be a valid flags for page_response.
So isn't failing the right thing to do?

> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>
> Signed-off-by: Yi Sun <yi.y.sun@linux.intel.com>
> ---
>  drivers/iommu/iommu.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 8c470f4..053cec3 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1200,9 +1200,11 @@ int iommu_page_response(struct device *dev,
>  		return -EINVAL;
>  
>  	if (msg->version != IOMMU_PAGE_RESP_VERSION_1 ||
> -	    msg->flags & ~IOMMU_PAGE_RESP_PASID_VALID)
> +		!(msg->flags & IOMMU_PAGE_RESP_PASID_VALID)) {

It should be OK not to have PASID_VALID set, we're just checking for
undefined flags here.

Thanks,
Jean

> +		dev_warn_ratelimited(dev, "%s:Invalid ver %x: flags %x\n",
> +				__func__, msg->version, msg->flags);
>  		return -EINVAL;
> -
> +	}
>  	/* Only send response if there is a fault report pending */
>  	mutex_lock(&param->fault_param->lock);
>  	if (list_empty(&param->fault_param->faults)) {
> -- 
> 2.7.4
> 
> _______________________________________________
> iommu mailing list
> iommu@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/iommu
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
