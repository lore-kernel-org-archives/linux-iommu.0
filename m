Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA71BC433E2
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 754EE208CA
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 05:42:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OAbWCK0Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 754EE208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 4DDC68702D;
	Tue,  1 Sep 2020 05:42:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z28F-4S55wb7; Tue,  1 Sep 2020 05:42:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id CCC1587028;
	Tue,  1 Sep 2020 05:42:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6863C088B;
	Tue,  1 Sep 2020 05:42:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D8BAC0052
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:42:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 13E7D86E17
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:42:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rswLpJF0yMmH for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 05:42:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 9B18886973
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 05:42:45 +0000 (UTC)
Received: by mail-qk1-f194.google.com with SMTP id f142so4042886qke.13
 for <iommu@lists.linux-foundation.org>; Mon, 31 Aug 2020 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=TjPySNIpD++R3nIfiDfbAnLHmr0c9i/LGC5Y9ogD0v8=;
 b=OAbWCK0Yezbsh/mzcgeE7sC/EeQQhZZ8WSfMp/Fmv/B7Lk2xTWpDZL7ez5bf5UDPWK
 4Tue7VtzfuaCr5qUWiEay3FADaV89uAXqiEQ2f0UU/LKgixPCrQhkFXl83SKtXawRPug
 3VswzBVU7BhUiPiBt4EI5sghR0SBrIxLZku0fNksghFQsFPBBSKTndX/FfB6TpJMrVJJ
 TE/FJhQHMSxivxBOC5CwlJvVL2inpaqTLLxgpXo2oLYU/jPdXYGaBWizv/c5P/4Twm4n
 oUcO4KIExFshItVD3J8hb+p6lpoDxm4JTY8Saz2oGC55/ChiWAPX6WIBTSDYFkqzsCAo
 81SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TjPySNIpD++R3nIfiDfbAnLHmr0c9i/LGC5Y9ogD0v8=;
 b=FRdP4OeEw4exqZagZH79D+ce9oThWG0N4hwfSf5osb06Cua3Y25SBzz9R7SnSHDj72
 RaFd0/aEN+D2i24VGP1GqcZXwTIwg20uw6hYdvH5mgRq954oDvmNWZxF9HEZ4TfI7GJh
 RB1gvkDT+rvCvCdNdX4JxOocAKIHXETPpArMKbp6efx8VnSSrIBqNNUYnx/Gr0U/QHXJ
 sGmKK5/9Za+Fn/Ff03CWNoA0aGwDduxDNBnhovPBZExDPO5tyovR0l43EiE+aX0/ofNw
 rcJFsfx0dhlt6OxecqPmacm0WVBvi+H8O+6gBMdDzDSNJ+lf9VQ2xqnuZxo43kdxolX2
 BjkA==
X-Gm-Message-State: AOAM530nT31aoBOoDv6pueCYLrM2LTbumNarHhDC1xf4cbzFY11oWjOq
 0RdmLTeRwOiWwgE++M7tH0vGSA==
X-Google-Smtp-Source: ABdhPJzptDekz3V1QxRTxrgjsN9RM1EoaAMnK6eUWK4D92iBVLom/mgdEqgNNG4GBVYJ/DvH3YX36g==
X-Received: by 2002:a37:b307:: with SMTP id c7mr270811qkf.33.1598938964675;
 Mon, 31 Aug 2020 22:42:44 -0700 (PDT)
Received: from uller (ec2-34-197-84-77.compute-1.amazonaws.com. [34.197.84.77])
 by smtp.gmail.com with ESMTPSA id s20sm354299qkg.65.2020.08.31.22.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 22:42:44 -0700 (PDT)
Date: Tue, 1 Sep 2020 05:42:42 +0000
From: Bjorn Andersson <bjorn.andersson@linaro.org>
To: Rob Clark <robdclark@gmail.com>
Subject: Re: [PATCH 01/19] drm/msm: remove dangling submitqueue references
Message-ID: <20200901054242.GC54956@uller>
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-2-robdclark@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200814024114.1177553-2-robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>,
 Will Deacon <will@kernel.org>, David Airlie <airlied@linux.ie>,
 linux-arm-msm@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
 dri-devel@lists.freedesktop.org, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>, iommu@lists.linux-foundation.org,
 Sibi Sankar <sibis@codeaurora.org>, Vivek Gautam <vivek.gautam@codeaurora.org>,
 freedreno@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org
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

On Fri 14 Aug 02:40 UTC 2020, Rob Clark wrote:

> From: Rob Clark <robdclark@chromium.org>
> 
> Currently it doesn't matter, since we free the ctx immediately.  But
> when we start refcnt'ing the ctx, we don't want old dangling list
> entries to hang around.
> 
> Signed-off-by: Rob Clark <robdclark@chromium.org>

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> ---
>  drivers/gpu/drm/msm/msm_submitqueue.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index a1d94be7883a..90c9d84e6155 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
>  	 * No lock needed in close and there won't
>  	 * be any more user ioctls coming our way
>  	 */
> -	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> +	list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> +		list_del(&entry->node);
>  		msm_submitqueue_put(entry);
> +	}
>  }
>  
>  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
> -- 
> 2.26.2
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
