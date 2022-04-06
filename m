Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523A6C4332F
	for <iommu@archiver.kernel.org>; Wed,  6 Apr 2022 16:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 0894D610B9;
	Wed,  6 Apr 2022 16:06:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uBdDS5EJntoc; Wed,  6 Apr 2022 16:06:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 00DB960EE5;
	Wed,  6 Apr 2022 16:06:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D0E52C002C;
	Wed,  6 Apr 2022 16:06:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ACA7DC0012
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 16:06:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9AE9B4190D
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 16:06:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QPqyLOoKmfhL for <iommu@lists.linux-foundation.org>;
 Wed,  6 Apr 2022 16:06:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A07C9418DC
 for <iommu@lists.linux-foundation.org>; Wed,  6 Apr 2022 16:06:34 +0000 (UTC)
Received: by mail-wr1-x42a.google.com with SMTP id w21so3985758wra.2
 for <iommu@lists.linux-foundation.org>; Wed, 06 Apr 2022 09:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=c6IFtJoccYowp2SPFkLYl7fBTN/gyRfnIU15c9wrgHI=;
 b=grM1c17B0+b10VDghHxy8oPE55Scxin6NssMWayxOjNDQoqugsgbLfxFLwL8WGZxT0
 nQKyhL51D6/3Zvs37Htp607mvGk3e4EqwSuojcAvtXGfITqyx2pbWetI2tPgjx2s3Nq0
 L2AxpxCPyahMH9H19Uv9QemuQi7JT+OpwJvACkjwKZaJYDcWMCXBGPgqOFNldl6gFV2h
 NOwQHgJoADY7iqKi4gUlYYFbMg9PhKfCY1KVaaQY+BogPv8zofz36D/LGuH9WsEmsXB0
 19rRpPGUf1LyuIz3lPAwY/Gkbs57SYBCjmbpWCdNYI5wl4JiwnUuUBFDXTLXx7sk7Xs4
 DA4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=c6IFtJoccYowp2SPFkLYl7fBTN/gyRfnIU15c9wrgHI=;
 b=PtZcmFOYXjmzvuLlED6RZeDD6LFgq8wVcl7/f+7NXDBniNm8SzR2KnD0Zk/ChJg4tN
 3sjYJ9fD5ZTwjqGabpZn1mXptWR/XWhxTdZK2YVqJr1IgoPhjZZUM/LKkHGaJ9juhnAF
 ATmSK0xv6Ae8UYEK+QesLoWM5YtoWX2vkY0MGbjRNVM0ZCM14HV/I3gXB1pj8ISqL7IL
 RrKnkPPYKIRH5JQV/v8iq5s0vkblrpTNO4IWRx/ENFkUs9/In3jXL449Ikq07/6o9Ifz
 YccRfGtl11tE//vDHMh1yE0FMPLQ9y7HEH2odoYL3a+z8UjOEybY+VIpkIMljQTW7mEI
 OqbA==
X-Gm-Message-State: AOAM531gVExBl4tSDJnHEjQVHQOMHcQhBK25rsYcy0oSxJLVL+AENLlP
 N+ARhL5m2+Qd9SkBAhZ/dY1qmDRbILOzhJ29Rc8=
X-Google-Smtp-Source: ABdhPJwtoCa6agm4ae7x3ltTqzFBJvsMB5pyzwvMFqAyEOix6fNa73x/0iOZLqFrV58zC6dyFRZPjkcrKrbc4E9GDio=
X-Received: by 2002:a5d:6dad:0:b0:204:154d:c93d with SMTP id
 u13-20020a5d6dad000000b00204154dc93dmr7070237wrs.574.1649261192659; Wed, 06
 Apr 2022 09:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <5ab4f4574d7f3e042261da702d493ee40d003356.1649168268.git.robin.murphy@arm.com>
In-Reply-To: <5ab4f4574d7f3e042261da702d493ee40d003356.1649168268.git.robin.murphy@arm.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 6 Apr 2022 09:07:26 -0700
Message-ID: <CAF6AEGvgfqFrXHji6R1sTsxOFSdvA7HQSxa1QCXWVmEL1qcK9w@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: Stop using iommu_present()
To: Robin Murphy <robin.murphy@arm.com>
Cc: freedreno <freedreno@lists.freedesktop.org>,
 "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>,
 Joerg Roedel <joro@8bytes.org>, " <iommu@lists.linux-foundation.org>,
 Sean Paul <sean@poorly.run>, Abhinav Kumar <quic_abhinavk@quicinc.com>,
 dri-devel <dri-devel@lists.freedesktop.org>
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

On Tue, Apr 5, 2022 at 7:17 AM Robin Murphy <robin.murphy@arm.com> wrote:
>
> Even if some IOMMU has registered itself on the platform "bus", that
> doesn't necessarily mean it provides translation for the device we
> care about. Replace iommu_present() with a more appropriate check.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Reviewed-by: Rob Clark <robdclark@gmail.com>

> ---
>  drivers/gpu/drm/msm/msm_drv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_drv.c b/drivers/gpu/drm/msm/msm_drv.c
> index affa95eb05fc..9c36b505daab 100644
> --- a/drivers/gpu/drm/msm/msm_drv.c
> +++ b/drivers/gpu/drm/msm/msm_drv.c
> @@ -274,7 +274,7 @@ bool msm_use_mmu(struct drm_device *dev)
>         struct msm_drm_private *priv = dev->dev_private;
>
>         /* a2xx comes with its own MMU */
> -       return priv->is_a2xx || iommu_present(&platform_bus_type);
> +       return priv->is_a2xx || device_iommu_mapped(dev->dev);
>  }
>
>  static int msm_init_vram(struct drm_device *dev)
> --
> 2.28.0.dirty
>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
