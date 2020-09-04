Return-Path: <SRS0=mVMG=CN=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E4AEC433E2
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:15 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D10EF20722
	for <iommu@archiver.kernel.org>; Fri,  4 Sep 2020 14:56:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6yn0s+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10EF20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 91C5E2E1A7;
	Fri,  4 Sep 2020 14:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6EWirzM9jxKo; Fri,  4 Sep 2020 14:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 2E2DE27266;
	Fri,  4 Sep 2020 14:56:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16D86C07FF;
	Fri,  4 Sep 2020 14:56:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 449F7C0051
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2CF7B8753C
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mqP99n+rPgCi for <iommu@lists.linux-foundation.org>;
 Fri,  4 Sep 2020 14:56:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 5EE7387538
 for <iommu@lists.linux-foundation.org>; Fri,  4 Sep 2020 14:56:11 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id h17so5307239otr.1
 for <iommu@lists.linux-foundation.org>; Fri, 04 Sep 2020 07:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=vpKrUehbWkjhPrh2kJL3X4EVOaqPrDgkRZZZ122pDdg=;
 b=B6yn0s+mws5yiJzwUUdi885QZASFwaiPFQ4rw178/C+vYsxKsD6OlCOQ8UusjKl5nC
 O71NudexpsbPHvDy4sOCqwfRv85Lmq7SoKLP7nbqBY7hWMbPYYCBgOd5tnipoxJ8k8xR
 +2ifRFPJpDL8t0Qamvrya8MEmtSeQq6xsha0fJn2qq1S47aR9uWZ25hYEvC5NMg33Ici
 MyBBSqMBy0egea5fj14vVnPMan1YkXWnLMqyUjHcx8OgRxx4rkAfkRnSdiPQoRPXKAh9
 F0i4miDyQu+Ub91wJctr7EeT/cikmNeHYmZQ7pet1w9Ej8ZzDuWYdwG0KwYhzSil6lfB
 J+tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=vpKrUehbWkjhPrh2kJL3X4EVOaqPrDgkRZZZ122pDdg=;
 b=F2TPTcVUwCc/KDq7Cku5twM/Gy2/oQUlxzTiRXz7BsYTxJPqTAD6r3OiauxV+SX0EP
 6p4G51D2W8HjM7zKZWQHnVrWJAekoUWW7NkawFzP4H8QtTj4zAqKfIWsnMs34JZ6OqT7
 3qBqqQwzE5TGB3gJu8Z9ftu02Hj4d/4o2i4ux+qzl0KaKzgTzVaBXie1+f3Hmc+TS1Ma
 nYgSwIIxuuWjHpq7Y3OH/20CvDCbqYQlFWXOryTSyN6pcp9ye13Ift675hMc22Nd9GlB
 JPvm4P17ZBUNdXV9kGbGOoXEiZry9OM6WjMPHEwSgqLBlj2WD6M2gPJlqJ/j7a/ydpY8
 Z/hA==
X-Gm-Message-State: AOAM531iP60ALw5TGwT5VW2qX9Dmm6+E7/8BP63gPe83pMVAU0yh1ppN
 7IJyCi48HW+h+tOAAXbPU6htDw==
X-Google-Smtp-Source: ABdhPJypgpCZE8ik17Yt/cCswx06ecF47ejD0yq+nJtCASFxNBLNc1X2qdkI+lwn+VrKOkbHiWi1JQ==
X-Received: by 2002:a9d:7a96:: with SMTP id l22mr5682951otn.220.1599231370498; 
 Fri, 04 Sep 2020 07:56:10 -0700 (PDT)
Received: from yoga ([2605:6000:e5cb:c100:8898:14ff:fe6d:34e])
 by smtp.gmail.com with ESMTPSA id o7sm1262068otl.63.2020.09.04.07.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2020 07:56:09 -0700 (PDT)
Date: Fri, 4 Sep 2020 09:56:03 -0500
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 3/3] iommu: qcom: Drop of_match_ptr to fix
 -Wunused-const-variable
Message-ID: <20200904145603.GE3715@yoga>
References: <20200728170859.28143-1-krzk@kernel.org>
 <20200728170859.28143-3-krzk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200728170859.28143-3-krzk@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, iommu@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>,
 David Woodhouse <dwmw2@infradead.org>
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

On Tue 28 Jul 12:08 CDT 2020, Krzysztof Kozlowski wrote:

> The of_device_id is included unconditionally by of.h header and used
> in the driver as well.  Remove of_match_ptr to fix W=1 compile test
> warning with !CONFIG_OF:
> 
>     drivers/iommu/qcom_iommu.c:910:34: warning: 'qcom_iommu_of_match' defined but not used [-Wunused-const-variable=]
>       910 | static const struct of_device_id qcom_iommu_of_match[] = {
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  drivers/iommu/qcom_iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/qcom_iommu.c b/drivers/iommu/qcom_iommu.c
> index af6bec3ace00..9535a6af7553 100644
> --- a/drivers/iommu/qcom_iommu.c
> +++ b/drivers/iommu/qcom_iommu.c
> @@ -752,7 +752,7 @@ static const struct of_device_id ctx_of_match[] = {
>  static struct platform_driver qcom_iommu_ctx_driver = {
>  	.driver	= {
>  		.name		= "qcom-iommu-ctx",
> -		.of_match_table	= of_match_ptr(ctx_of_match),
> +		.of_match_table	= ctx_of_match,
>  	},
>  	.probe	= qcom_iommu_ctx_probe,
>  	.remove = qcom_iommu_ctx_remove,
> @@ -915,7 +915,7 @@ static const struct of_device_id qcom_iommu_of_match[] = {
>  static struct platform_driver qcom_iommu_driver = {
>  	.driver	= {
>  		.name		= "qcom-iommu",
> -		.of_match_table	= of_match_ptr(qcom_iommu_of_match),
> +		.of_match_table	= qcom_iommu_of_match,
>  		.pm		= &qcom_iommu_pm_ops,
>  	},
>  	.probe	= qcom_iommu_device_probe,
> -- 
> 2.17.1
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
