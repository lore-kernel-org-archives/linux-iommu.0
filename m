Return-Path: <SRS0=CZco=62=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99C15C54E8D
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 05:41:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19F3620736
	for <iommu@archiver.kernel.org>; Tue, 12 May 2020 05:41:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pwq8HShO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19F3620736
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id C153F1FE0A;
	Tue, 12 May 2020 05:41:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fU0+vmJ72Nt5; Tue, 12 May 2020 05:41:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CDD871FCA0;
	Tue, 12 May 2020 05:41:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AFA6FC088A;
	Tue, 12 May 2020 05:41:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2850CC016F
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:41:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 10F7087019
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:41:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xsEzWV5IqUoZ for <iommu@lists.linux-foundation.org>;
 Tue, 12 May 2020 05:41:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com
 [209.85.210.196])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6663287008
 for <iommu@lists.linux-foundation.org>; Tue, 12 May 2020 05:41:40 +0000 (UTC)
Received: by mail-pf1-f196.google.com with SMTP id z1so5839912pfn.3
 for <iommu@lists.linux-foundation.org>; Mon, 11 May 2020 22:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=d3pM/Dyxuk8f8jV5C8y4lxDkycZGVCo+a29+hT7GDn8=;
 b=Pwq8HShOoEzwpj3h4Z2GIyav26gGErQQ5WACO+rZuY1f7UHBsSeweImNHvFTmwUu+3
 RtPex/zc6nGXKFOSDhiPYBQvoO8wzf3lrrZ4Q0mekaNJs/8CR6xLPZh+wLHp0Gyd9Pvx
 QRQj8wnuoP0fKCg5vPmAFKsJIziKrif1enlKLHaH1vkudYaKCzVmNlgcree26/ynY7d7
 rWZG0Fp9p2lsh3xcVB5/waAsty2XByE5+mW9SrW9SzIXcj10imYgrlhwXa4tJyFg0hh5
 rR3XtQtcDHcO+jVEbcqSUd0K55s74l1VokXaBhfFgthdrnHEqTRknjqB21L3NUEKk/vY
 hCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=d3pM/Dyxuk8f8jV5C8y4lxDkycZGVCo+a29+hT7GDn8=;
 b=dpR0cQ4tARUZQfdSbqvfjcbqbHQpioTxFSSIa37qq3bqA1BxbuH22xOUvjb+Wzmz8U
 mP2y+GRJDJlyKyhynsxL9xNIPWfBpyPryxm5AYUVkYadFTED/KUQm6l7qk+lUYbvUilf
 QF6yXIMTK/6BdJBYH+4UU6l+KLZrx/MFjsUWmQlMTXondFVQAZ7QazniY562Ufldzgc3
 q2HdmOm6tGqsrIUiQiX0N2rvSJjWhzCJRzhHQfSipeJPs6bUcEKr99gU5LlZBjJKf7wA
 GC1SVVMowOBWkoh0mTJnMyc0bIZ4DPKKrU1amtCSWzspW42iNZFhx3k+1UnrVFLLtKj8
 8R9w==
X-Gm-Message-State: AGi0PuZRsVCCBti5VPFAzFlzUJjv6hk4noW/WJviicExOmvmePTTh7AC
 mPTq3DMP68LY8Uw9O1KrIFTG3g==
X-Google-Smtp-Source: APiQypJKtsy5n1xHuqBuAnAZAju4AgPcTdVCfwg0NsY3d395BxTqYBF2Ss/gmJPySFaJazTsGI45gA==
X-Received: by 2002:a62:808d:: with SMTP id j135mr18779432pfd.53.1589262099940; 
 Mon, 11 May 2020 22:41:39 -0700 (PDT)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net.
 [104.188.17.28])
 by smtp.gmail.com with ESMTPSA id h11sm10684616pfo.120.2020.05.11.22.41.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2020 22:41:39 -0700 (PDT)
Date: Mon, 11 May 2020 22:41:37 -0700
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Samuel Zou <zou_wei@huawei.com>
Subject: Re: [PATCH -next] iommu/msm: Make msm_iommu_lock static
Message-ID: <20200512054137.GI1302550@yoga>
References: <1589249839-105820-1-git-send-email-zou_wei@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1589249839-105820-1-git-send-email-zou_wei@huawei.com>
Cc: linux-arm-msm@vger.kernel.org, agross@kernel.org,
 iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
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

On Mon 11 May 19:17 PDT 2020, Samuel Zou wrote:

> Fix the following sparse warning:
> 
> drivers/iommu/msm_iommu.c:37:1: warning: symbol 'msm_iommu_lock' was not declared.
> 
> The msm_iommu_lock has only call site within msm_iommu.c
> It should be static
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> Fixes: 0720d1f052dc ("msm: Add MSM IOMMU support")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Samuel Zou <zou_wei@huawei.com>
> ---
>  drivers/iommu/msm_iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/msm_iommu.c b/drivers/iommu/msm_iommu.c
> index 10cd4db..3d8a635 100644
> --- a/drivers/iommu/msm_iommu.c
> +++ b/drivers/iommu/msm_iommu.c
> @@ -34,7 +34,7 @@ __asm__ __volatile__ (							\
>  /* bitmap of the page sizes currently supported */
>  #define MSM_IOMMU_PGSIZES	(SZ_4K | SZ_64K | SZ_1M | SZ_16M)
>  
> -DEFINE_SPINLOCK(msm_iommu_lock);
> +static DEFINE_SPINLOCK(msm_iommu_lock);
>  static LIST_HEAD(qcom_iommu_devices);
>  static struct iommu_ops msm_iommu_ops;
>  
> -- 
> 2.6.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
