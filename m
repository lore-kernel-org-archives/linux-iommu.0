Return-Path: <SRS0=vHAQ=BX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71C7C433E1
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:34 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F18220658
	for <iommu@archiver.kernel.org>; Thu, 13 Aug 2020 17:03:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZK6Xnm68"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F18220658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5E6DF86D87;
	Thu, 13 Aug 2020 17:03:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gCHnoxKirbY9; Thu, 13 Aug 2020 17:03:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id D765685193;
	Thu, 13 Aug 2020 17:03:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1BC7C07FF;
	Thu, 13 Aug 2020 17:03:33 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CC136C004D
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 17:03:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3C59F88798
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 17:03:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OOqtjY+9JK9U for <iommu@lists.linux-foundation.org>;
 Thu, 13 Aug 2020 17:03:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 25AAD887A7
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 17:03:21 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id f12so5918734wru.13
 for <iommu@lists.linux-foundation.org>; Thu, 13 Aug 2020 10:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=f2OcjbUQiolvvjtdbVSQNs7Tp8xSogd0JfYY2T8Mi5A=;
 b=ZK6Xnm68XM2Weqtgt+oy3WcBDmBJh4lWuF7ScdBCNMZtV8MrK+cZ+1LJEGHPT2ytSK
 tp/+w+gZYNpoViq7ImvjHNu8E7fY6uYz3Akw85Q3r0hc/J+QsRASf9v/kyU8jzmG5j2B
 9nsKgs+z0spe3DYv+WKNqKQ7PfS15szCOW+9fYB5VdGm7W0WitS+HSAyudQvZVOOWFm+
 /SWJGA27fdofLe5npVil/Q17mLoctp20Yq6pwOyU8qH91l8DLctei8TLNk3yrkPtfGvt
 qq7SlDif8CyQDYsl5hNTWGFbzQDt3HFxHqMv6/x0PB6fuxphRpvHlnk9LPaAYLEfD9oY
 Q1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=f2OcjbUQiolvvjtdbVSQNs7Tp8xSogd0JfYY2T8Mi5A=;
 b=c5K+nUQGCS+p4TVdrteps/aZ0n1MtMM95nOsXUziYc13M6IOLgIU4WBDmETLY3f8rm
 +A/9EacM9sAycfIbZEqv1weN21UTXnV2uCMbLJNF6HkVRH0Xd2RVDXiaa/09AIHID+ug
 mUWLR7CSabNxPXs0kDcBnqC7LWZ8wiGwNtvQLWYze499lE8mOkTaZK/EhsFL1mR9JOMt
 XcQG88OiInkaEzPagejuiOF6Zw7FW/n28ehFdEyUoYzmC630Ji7DSOgJj8QkIP0cdEI8
 MZQCb57jpijzRyk8fYFVyjc3PRYB4KGpXlpwdGVL3HJStOPr7HOr8q7HZXv+2XGSsYPE
 u7Zw==
X-Gm-Message-State: AOAM531ioaGYkv6IAVs+h7bUSGtkAD8uQmem/GMq4Frf/WCWhc3HXb7i
 K41B0FxFnxYOztBMv1wNN5gVrOcKPMqfrEo/9gQ=
X-Google-Smtp-Source: ABdhPJwPNi4Dk4hbn8MvomzE5XprOKkd1JdsgDq0RR0BsrBUKWcJC//EUB0I4UQXhY2gfAX3taxczNZaZKNnP7WG/N8=
X-Received: by 2002:a5d:4ad1:: with SMTP id y17mr5227777wrs.132.1597338199356; 
 Thu, 13 Aug 2020 10:03:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200810222657.1841322-8-jcrouse@codeaurora.org>
In-Reply-To: <20200810222657.1841322-8-jcrouse@codeaurora.org>
From: Rob Clark <robdclark@gmail.com>
Date: Thu, 13 Aug 2020 10:04:05 -0700
Message-ID: <CAF6AEGv+X88Jrha7zhQ+78RbGqK78Ghi49a_V6zE-fmRDvcGFw@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH v12 07/13] drm/msm: Add a context pointer to
 the submitqueue
To: Jordan Crouse <jcrouse@codeaurora.org>
Cc: David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>, Eric Anholt <eric@anholt.net>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>,
 Sam Ravnborg <sam@ravnborg.org>, Emil Velikov <emil.velikov@collabora.com>,
 Jonathan Marek <jonathan@marek.ca>, Will Deacon <will@kernel.org>,
 Ben Dooks <ben.dooks@codethink.co.uk>,
 Wambui Karuga <wambui.karugax@gmail.com>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Brian Masney <masneyb@onstation.org>,
 Sean Paul <sean@poorly.run>, Robin Murphy <robin.murphy@arm.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawn.guo@linaro.org>,
 freedreno <freedreno@lists.freedesktop.org>
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

On Mon, Aug 10, 2020 at 3:27 PM Jordan Crouse <jcrouse@codeaurora.org> wrote:
>
> Each submitqueue is attached to a context. Add a pointer to the
> context to the submitqueue at create time and refcount it so
> that it stays around through the life of the queue.
>
> GPU submissions can access the active context via the submitqueue
> instead of requiring it to be passed around from function to
> function.
>
> Signed-off-by: Jordan Crouse <jcrouse@codeaurora.org>
> ---
>
>  drivers/gpu/drm/msm/adreno/a5xx_gpu.c   | 12 +++++-------
>  drivers/gpu/drm/msm/adreno/a6xx_gpu.c   |  5 ++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c |  5 ++---
>  drivers/gpu/drm/msm/adreno/adreno_gpu.h |  3 +--
>  drivers/gpu/drm/msm/msm_drv.c           |  3 ++-
>  drivers/gpu/drm/msm/msm_drv.h           |  8 ++++++++
>  drivers/gpu/drm/msm/msm_gem.h           |  1 +
>  drivers/gpu/drm/msm/msm_gem_submit.c    |  8 ++++----
>  drivers/gpu/drm/msm/msm_gpu.c           |  9 ++++-----
>  drivers/gpu/drm/msm/msm_gpu.h           |  7 +++----
>  drivers/gpu/drm/msm/msm_submitqueue.c   |  8 +++++++-
>  11 files changed, 39 insertions(+), 30 deletions(-)
>

[snip]

> diff --git a/drivers/gpu/drm/msm/msm_submitqueue.c b/drivers/gpu/drm/msm/msm_submitqueue.c
> index a1d94be7883a..10f557225a3e 100644
> --- a/drivers/gpu/drm/msm/msm_submitqueue.c
> +++ b/drivers/gpu/drm/msm/msm_submitqueue.c
> @@ -49,8 +49,10 @@ void msm_submitqueue_close(struct msm_file_private *ctx)
>          * No lock needed in close and there won't
>          * be any more user ioctls coming our way
>          */
> -       list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node)
> +       list_for_each_entry_safe(entry, tmp, &ctx->submitqueues, node) {
> +               kref_put(&ctx->ref, msm_file_private_destroy);
>                 msm_submitqueue_put(entry);
> +       }

oh, this is the problem I mentioned in the last email.. we are
dropping the queue's reference to the ctx, when the device file is
closed, not on the last unref of the queue.  So the queue stays live
until all associated submits are retired, but the ctx ref (and
therefore the aspace) get destroyed earlier

BR,
-R

>  }
>
>  int msm_submitqueue_create(struct drm_device *drm, struct msm_file_private *ctx,
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
