Return-Path: <SRS0=Ln9J=CK=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB1CC433E7
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:14 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E65206EB
	for <iommu@archiver.kernel.org>; Tue,  1 Sep 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TBqWWrSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E65206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E2C48220B2;
	Tue,  1 Sep 2020 15:53:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QJbczhVhFtAE; Tue,  1 Sep 2020 15:53:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0064120010;
	Tue,  1 Sep 2020 15:53:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAAADC07FF;
	Tue,  1 Sep 2020 15:53:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CCACBC0051
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:53:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id B812420010
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:53:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y3hpBrr0BZsc for <iommu@lists.linux-foundation.org>;
 Tue,  1 Sep 2020 15:53:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 2548E274B0
 for <iommu@lists.linux-foundation.org>; Tue,  1 Sep 2020 15:53:06 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id t10so1270471wrv.1
 for <iommu@lists.linux-foundation.org>; Tue, 01 Sep 2020 08:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BY4bXKc0xSgKW8hDeDD9u95KOuc3RBx/gc2Fu/W48eQ=;
 b=TBqWWrSB1mvUqsytHINsQUCpaD6PqLh3UsHJMRUkGwH/66biENmlSfUhshtvyFx1Jl
 Xm0W8v8iKkFOcdwlTL6nLnBqWo29CyX2TENRlw+7jc3NGK86XiruLidBhNmVttRUPs36
 LfzPsLKO8sOVbxnG5K3VaHG3CgZEMEConRc7AIKSnvCz2lQI2jXmSmo47D3DH2EVKIe7
 +716NNemet7lsA6Cel/JHnqqvzqRw7d6Q0bdmZn91FGsOYklnoY9Pd5xUlgENa1Qnr3l
 Vr9BpGca6oaWmy2J9JHDdL7RKAd04P1S/x/kgTGyfh+1EOOPBVSqethI5oTYr8bLFwhE
 x5mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BY4bXKc0xSgKW8hDeDD9u95KOuc3RBx/gc2Fu/W48eQ=;
 b=STnZWHkAg8VpICa4EHtShyv254wHtZdaOuZyinJsyhDRUUerv/m0+Wnk2S/vRNMRbf
 eUu3d16mg7MyQJ5RwSQLJWMR1KiWcb7bC6agqcm96WS2LUjzcBA19Nog6HsVjcgl6WS+
 +cinqJgPFObr2MG02bgwxaMIOMJu/ZFBwN7wA8HlTxo8VVKo5Dqp4XMkeI9sYhfEabIJ
 2YOsIpDzMT5hZeL6oR5r9U2bSz2Jd1AYtgWhKFC3q+Cfw+Zsri4ESW53tP2k5mHTlZUF
 x/jfZm1qXcowr0DvaII4qBqZHjvNVmFi9w5d3smPdl2sLJHHmK+O19OFU+zWmUMa9k3x
 +dEQ==
X-Gm-Message-State: AOAM531+MB0wz8jTyfYrxXSqJhxG3H5Lvf4XVscpw/0kMJsLRlY6C81d
 rK1t9ieqYGi8+4CryDRxYhbjWmmLneAMWyMEHE4=
X-Google-Smtp-Source: ABdhPJzDoeC0Pb4kh7G7ViZBofzjFA7/roqtprdLHZ43CwlP1yJxepquJBwNWHIMnMPZtjY/Vti5ADETxrYodXZvEfo=
X-Received: by 2002:adf:f382:: with SMTP id m2mr2458894wro.327.1598975584169; 
 Tue, 01 Sep 2020 08:53:04 -0700 (PDT)
MIME-Version: 1.0
References: <20200810222657.1841322-1-jcrouse@codeaurora.org>
 <20200814024114.1177553-7-robdclark@gmail.com> <20200901043211.GN3715@yoga>
In-Reply-To: <20200901043211.GN3715@yoga>
From: Rob Clark <robdclark@gmail.com>
Date: Tue, 1 Sep 2020 08:53:50 -0700
Message-ID: <CAF6AEGthzRwUZby6XsToNpSbx0ad3hZWN2QM+qipR2zDDi-ySw@mail.gmail.com>
Subject: Re: [PATCH 06/19] drm/msm/gpu: add dev_to_gpu() helper
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: David Airlie <airlied@linux.ie>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 Vivek Gautam <vivek.gautam@codeaurora.org>,
 AngeloGioacchino Del Regno <kholk11@gmail.com>, Will Deacon <will@kernel.org>,
 Rob Clark <robdclark@chromium.org>, Jonathan Marek <jonathan@marek.ca>,
 Sibi Sankar <sibis@codeaurora.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>,
 Sharat Masetty <smasetty@codeaurora.org>, Stephen Boyd <swboyd@chromium.org>,
 Sean Paul <sean@poorly.run>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 freedreno <freedreno@lists.freedesktop.org>,
 open list <linux-kernel@vger.kernel.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Shawn Guo <shawn.guo@linaro.org>,
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

On Mon, Aug 31, 2020 at 9:32 PM Bjorn Andersson
<bjorn.andersson@linaro.org> wrote:
>
> On Thu 13 Aug 21:41 CDT 2020, Rob Clark wrote:
>
> > From: Rob Clark <robdclark@chromium.org>
> >
> > In a later patch, the drvdata will not directly be 'struct msm_gpu *',
> > so add a helper to reduce the churn.
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  drivers/gpu/drm/msm/adreno/adreno_device.c | 10 ++++------
> >  drivers/gpu/drm/msm/msm_gpu.c              |  6 +++---
> >  drivers/gpu/drm/msm/msm_gpu.h              |  5 +++++
> >  3 files changed, 12 insertions(+), 9 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/msm/adreno/adreno_device.c b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > index 9eeb46bf2a5d..26664e1b30c0 100644
> > --- a/drivers/gpu/drm/msm/adreno/adreno_device.c
> > +++ b/drivers/gpu/drm/msm/adreno/adreno_device.c
> > @@ -282,7 +282,7 @@ struct msm_gpu *adreno_load_gpu(struct drm_device *dev)
> >       int ret;
> >
> >       if (pdev)
> > -             gpu = platform_get_drvdata(pdev);
> > +             gpu = dev_to_gpu(&pdev->dev);
> >
> >       if (!gpu) {
> >               dev_err_once(dev->dev, "no GPU device was found\n");
> > @@ -425,7 +425,7 @@ static int adreno_bind(struct device *dev, struct device *master, void *data)
> >  static void adreno_unbind(struct device *dev, struct device *master,
> >               void *data)
> >  {
> > -     struct msm_gpu *gpu = dev_get_drvdata(dev);
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >
> >       pm_runtime_force_suspend(dev);
> >       gpu->funcs->destroy(gpu);
> > @@ -490,16 +490,14 @@ static const struct of_device_id dt_match[] = {
> >  #ifdef CONFIG_PM
> >  static int adreno_resume(struct device *dev)
> >  {
> > -     struct platform_device *pdev = to_platform_device(dev);
> > -     struct msm_gpu *gpu = platform_get_drvdata(pdev);
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >
> >       return gpu->funcs->pm_resume(gpu);
> >  }
> >
> >  static int adreno_suspend(struct device *dev)
> >  {
> > -     struct platform_device *pdev = to_platform_device(dev);
> > -     struct msm_gpu *gpu = platform_get_drvdata(pdev);
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >
> >       return gpu->funcs->pm_suspend(gpu);
> >  }
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.c b/drivers/gpu/drm/msm/msm_gpu.c
> > index d5645472b25d..6aa9e04e52e7 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.c
> > +++ b/drivers/gpu/drm/msm/msm_gpu.c
> > @@ -24,7 +24,7 @@
> >  static int msm_devfreq_target(struct device *dev, unsigned long *freq,
> >               u32 flags)
> >  {
> > -     struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >       struct dev_pm_opp *opp;
> >
> >       opp = devfreq_recommended_opp(dev, freq, flags);
> > @@ -45,7 +45,7 @@ static int msm_devfreq_target(struct device *dev, unsigned long *freq,
> >  static int msm_devfreq_get_dev_status(struct device *dev,
> >               struct devfreq_dev_status *status)
> >  {
> > -     struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >       ktime_t time;
> >
> >       if (gpu->funcs->gpu_get_freq)
> > @@ -64,7 +64,7 @@ static int msm_devfreq_get_dev_status(struct device *dev,
> >
> >  static int msm_devfreq_get_cur_freq(struct device *dev, unsigned long *freq)
> >  {
> > -     struct msm_gpu *gpu = platform_get_drvdata(to_platform_device(dev));
> > +     struct msm_gpu *gpu = dev_to_gpu(dev);
> >
> >       if (gpu->funcs->gpu_get_freq)
> >               *freq = gpu->funcs->gpu_get_freq(gpu);
> > diff --git a/drivers/gpu/drm/msm/msm_gpu.h b/drivers/gpu/drm/msm/msm_gpu.h
> > index 0db117a7339b..8bda7beaed4b 100644
> > --- a/drivers/gpu/drm/msm/msm_gpu.h
> > +++ b/drivers/gpu/drm/msm/msm_gpu.h
> > @@ -141,6 +141,11 @@ struct msm_gpu {
> >       struct msm_gpu_state *crashstate;
> >  };
> >
> > +static inline struct msm_gpu *dev_to_gpu(struct device *dev)
>
> That's a fairly generic name for a driver-global helper :)

tbf, it is only global to the gpu part of the driver..

thanks for the review

BR,
-R

> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
>
> Regards,
> Bjorn
>
> > +{
> > +     return dev_get_drvdata(dev);
> > +}
> > +
> >  /* It turns out that all targets use the same ringbuffer size */
> >  #define MSM_GPU_RINGBUFFER_SZ SZ_32K
> >  #define MSM_GPU_RINGBUFFER_BLKSIZE 32
> > --
> > 2.26.2
> >
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
