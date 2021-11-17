Return-Path: <SRS0=sOBO=QE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE13C433F5
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 07:51:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE2A361BCF
	for <iommu@archiver.kernel.org>; Wed, 17 Nov 2021 07:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE2A361BCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 749FD4090B;
	Wed, 17 Nov 2021 07:51:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HMDif2iQ-fd; Wed, 17 Nov 2021 07:51:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4B9764093E;
	Wed, 17 Nov 2021 07:51:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BCFBC001E;
	Wed, 17 Nov 2021 07:51:06 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26322C0012
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 07:51:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 0251180FF8
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 07:51:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0J7GR5qE0tSH for <iommu@lists.linux-foundation.org>;
 Wed, 17 Nov 2021 07:51:04 +0000 (UTC)
X-Greylist: delayed 00:07:38 by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.13])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DDA5680FEF
 for <iommu@lists.linux-foundation.org>; Wed, 17 Nov 2021 07:51:03 +0000 (UTC)
Received: from mail-wr1-f42.google.com ([209.85.221.42]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MFspV-1mtXJJ3c35-00HL58 for <iommu@lists.linux-foundation.org>; Wed, 17
 Nov 2021 08:38:14 +0100
Received: by mail-wr1-f42.google.com with SMTP id c4so2745248wrd.9
 for <iommu@lists.linux-foundation.org>; Tue, 16 Nov 2021 23:38:14 -0800 (PST)
X-Gm-Message-State: AOAM532wZrWkME7UkTRTqEcB1IM1B833+H7PUHJi5/9qjlIpDc8ilFov
 LbY1Wn3y8Jr7fu2Afj8UdL7d8iZxHZwQ32GulNM=
X-Google-Smtp-Source: ABdhPJyDzFzUZ26UQ9WxGi2mM9RgY/r6prCrnT92LA3jbLR4805/P5X5Rjrcv3jyDIe0oztp/vyy6t17ke0ttd8f6lw=
X-Received: by 2002:adf:d1c2:: with SMTP id b2mr17637588wrd.369.1637134694103; 
 Tue, 16 Nov 2021 23:38:14 -0800 (PST)
MIME-Version: 1.0
References: <1637104560-37432-1-git-send-email-quic_c_gdjako@quicinc.com>
 <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
In-Reply-To: <1637104560-37432-2-git-send-email-quic_c_gdjako@quicinc.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 17 Nov 2021 08:37:58 +0100
X-Gmail-Original-Message-ID: <CAK8P3a3W13wb5B_FMSCEp0JTUFrPk=Fp8N59oa58wxn+WeTroA@mail.gmail.com>
Message-ID: <CAK8P3a3W13wb5B_FMSCEp0JTUFrPk=Fp8N59oa58wxn+WeTroA@mail.gmail.com>
Subject: Re: [RFC 2/2] drm/msm/gem: Make use of the system cache
To: Georgi Djakov <quic_c_gdjako@quicinc.com>
X-Provags-ID: V03:K1:yCWRZ6y5KR94eOe+4C0YnNytbC8uf3graXWn5i8wEeAJRqS6I9f
 yV6c5q5s07GgORteuWjvhYfV9Y8mcAB6CYxa+iSTP1Fn4QJzf7+werMRoEHDhzh9WNp4yFV
 9U7eYPZcClx+ZIvovKpirXScqyxS6wYNH5F6SWcpoWYji1Y2+Z+m6Y3FbuY/p9jS39IBPHT
 hfbtjmWT+PEqur+f/PTvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eW/J2z92mv8=:mEoQxZ46vSG7gFQ796DJnT
 aJeLG+99FNX4Hkz2nMcrrG8telLvYJAe0f4/NfDbcXo8DRSFIoD3ciUrNQMs50nMDvIloqCoC
 1J1WuQcVVmaY7RQ+o+b7Vk6yITn3QhIOjghYukJwpM0/gDRNENU0+VIgtpxiwjOLQqzFbTSv3
 YyiI8pDJ2uSe7PaBVPDLl/wfi2Glo9qsg6m9pgJC1DtDv5Y4n4PlRPJgVhbQdzFlthhRBjbL+
 XLGzmKl2eEETtrdLD4Rr7/TIxN18UXOv2IW0PLicKrGr4hyukAHZOyMGeTZy12+sRf9lZKf0c
 htxuseHNExHT06e8EeGI5YLW8O1y5EyjZs9F+u1ypUeBnbAjnYUCNb0hkzyoASx8wtOKXrWzV
 TtiPDw71KbnCNFbAoTdDlpOZO3bOatghT/LvjL7kfOJLrR8A+dV5L5zi0yLxtsDK1f7sgTG35
 C1vMbve57mYMh5lfZAyG3EDZzeG8E+ei+DR+buVLY3C6eeh8tMe9w0RX6QRdSY1f8A005T7Ag
 Ptf5DTJhouI48GWYeLgEEsM798x1Snlw44E8ZQzc9smWBvOZW3+Yx2WukpnrKGKn1wnss8HKN
 Zjw7lIgJWDGRQYqlapcBdCfyV1EjIk4B911xnEYz/0ckdsPfznyY5HDqfet/tHtp9V5rc1qZN
 qU8HG1UfzKCwmwbvDVwUNLG6WdvA7Cs3pY6sKIFL9cjN//P85SKTEmAafeEbiAoUHQtwGScG9
 Tixy5w4CeattKNNBIeq8/a1nmBrNUo4IvgdN7utXfpvcso2yLkxktAPgaayMqFKEgrl2hErup
 6joeG5alf8iXoJ6x33iu8u8mi+K4/aoVyxKdS8yusk11cljsVc=
Cc: Arnd Bergmann <arnd@arndb.de>, Will Deacon <will@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Robin Murphy <robin.murphy@arm.com>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Marc Zyngier <maz@kernel.org>, Sean Paul <sean@poorly.run>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>
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

On Wed, Nov 17, 2021 at 12:16 AM Georgi Djakov
<quic_c_gdjako@quicinc.com> wrote:
>
> Instead of writing to WC cmdstream buffers that go all the way to the main
> memory, let's use the system cache to improve the performance.
>
> Signed-off-by: Georgi Djakov <quic_c_gdjako@quicinc.com>
> ---
>  drivers/gpu/drm/msm/msm_gem.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/msm/msm_gem.c b/drivers/gpu/drm/msm/msm_gem.c
> index 104fdfc14027..921a1c24721e 100644
> --- a/drivers/gpu/drm/msm/msm_gem.c
> +++ b/drivers/gpu/drm/msm/msm_gem.c
> @@ -214,7 +214,7 @@ void msm_gem_put_pages(struct drm_gem_object *obj)
>  static pgprot_t msm_gem_pgprot(struct msm_gem_object *msm_obj, pgprot_t prot)
>  {
>         if (msm_obj->flags & (MSM_BO_WC|MSM_BO_UNCACHED))
> -               return pgprot_writecombine(prot);
> +               return pgprot_syscached(prot);
>         return prot;
>  }

Based on the definition in patch 1, doesn't this mean that 32-bit
kernels degrade
from writecombined to uncached, making them a lot slower?

My feeling about this series is that there should be a clearer
definition of what
exactly happens on systems with and without system cache.

         Arnd
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
