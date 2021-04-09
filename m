Return-Path: <SRS0=LjD4=JG=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D4EC433B4
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 13:36:01 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CFF2610E5
	for <iommu@archiver.kernel.org>; Fri,  9 Apr 2021 13:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CFF2610E5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D0BA684ACB;
	Fri,  9 Apr 2021 13:36:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8wXLd4oFGGhd; Fri,  9 Apr 2021 13:36:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 995FF84867;
	Fri,  9 Apr 2021 13:35:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6CE44C000C;
	Fri,  9 Apr 2021 13:35:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 25FC5C000A
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 13:35:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A33BA401C0
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 13:35:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YKhsRJRDL-Vj for <iommu@lists.linux-foundation.org>;
 Fri,  9 Apr 2021 13:35:34 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E4C4B40E96
 for <iommu@lists.linux-foundation.org>; Fri,  9 Apr 2021 13:35:33 +0000 (UTC)
Received: from mail-ot1-f47.google.com ([209.85.210.47]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MFKX3-1lK8z545U1-00FjUR for <iommu@lists.linux-foundation.org>; Fri, 09 Apr
 2021 15:35:31 +0200
Received: by mail-ot1-f47.google.com with SMTP id
 y19-20020a0568301d93b02901b9f88a238eso5663208oti.11
 for <iommu@lists.linux-foundation.org>; Fri, 09 Apr 2021 06:35:30 -0700 (PDT)
X-Gm-Message-State: AOAM530JOvmbKl2enp58AWomExNKQOlUq0RbYyE8cvCdZ48PsLoSNIz+
 3aYSRzZ+eeH97UkIXeq6qsE2cu8ydMLUKNP66gw=
X-Google-Smtp-Source: ABdhPJynlbx4kLNikSNjAjnCb5vtFq6G/850R+R5+xWMARHqWLy+tfY7F0Z+Hrp7Hz4KWDmPvvGBCrUcX4hM8LkZWnk=
X-Received: by 2002:a9d:758b:: with SMTP id s11mr12240759otk.305.1617975319390; 
 Fri, 09 Apr 2021 06:35:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210409112035.27221-1-david@redhat.com>
In-Reply-To: <20210409112035.27221-1-david@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Fri, 9 Apr 2021 15:35:03 +0200
X-Gmail-Original-Message-ID: <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
Message-ID: <CAK8P3a31uKNcim0n99=yt3zjZ+LQSw4V4+8PS8daLsBdS0iSYg@mail.gmail.com>
Subject: Re: [PATCH v3] drivers: introduce and use WANT_DMA_CMA for soft
 dependencies on DMA_CMA
To: David Hildenbrand <david@redhat.com>
X-Provags-ID: V03:K1:OMAF1FO98rpK/VrW1T2O2Tq8Wv51pZhAa8YqWUZyqINkuHbsS0X
 9LyFZ0+VuvDHNICSW5CyPf0lboMrJyQzbGqEl9r1mvuebjNM85cDvGejCsfsFbl0wlWKjiW
 53rRNzQw3ZOiTWfAusitxIKi/6k6igdRuIf0n1Pq7n72dmqVM4k+KU7Xd2xz/6LGoh04JJm
 EpVesAa7gaMXP0s5IiCww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VcyZhBwg+9o=:bBsdt/ixMtx5NmZOYpGOuo
 9GWPLNgyG3qa6dtU07rJpF6Q/HyAvzR/MO6V3v0j13QgUmzetrZkMqAqPWbH9gDeVO5BwcVuJ
 QBP8uXo0ulAnYCzsKB5mLebxkbHCDjitrHG9us3i9E0MgBNX/aHE7zdlCNWKS17R4O4ICmXXc
 SkaOJY80T/tLPJDfXiPYFRrWCYzK8XeqR7nE3jLBJaULltBmOtxkTCsKkyBa13EdWqujpkfLJ
 TcsnTz+GsG72h9X4dL5TVW/eF3zj+iTEGcwYYj69qG/1Vvq4jQ9nTYxBww2E5T4TyRgFmaCLo
 JSmXeYhCE7tJrMRk6qCkk2CP+hofCdrogHzFaKlmI7wI3DxcAZgXZzJGpRvv5as+GST3CGvjU
 IRWwoaP2NGav/wMZKMoDbqVYg7VI8z0OAECfKIKcvBwKG5ACBg7mJ6iT90qiwJzJJAgVeIO0H
 3UjJXjhQ0OY1hNULjxHVj0A6hs7Hmra3XK4U02j/6mH4dxMl8QgktvpTwxQLMNCrjcpW5ISsY
 qjWogXFu7PIDRPvYXLXxkxmo4EFC3WTY4HESwAYKNXGbkAwZ2GUKobAq2MxLLzPhby7Jtw219
 6uFLnsimRb5lLAnmo7+D5PxKRosV1W51YV
Cc: Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
 linux-aspeed <linux-aspeed@lists.ozlabs.org>, David Airlie <airlied@linux.ie>,
 Linus Walleij <linus.walleij@linaro.org>,
 dri-devel <dri-devel@lists.freedesktop.org>,
 "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
 Paul Cercueil <paul@crapouillou.net>, Eric Anholt <eric@anholt.net>,
 Christoph Hellwig <hch@lst.de>, Masahiro Yamada <masahiroy@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Joel Stanley <joel@jms.id.au>, Russell King <linux+etnaviv@armlinux.org.uk>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 The etnaviv authors <etnaviv@lists.freedesktop.org>,
 Maxime Ripard <mripard@kernel.org>,
 Christian Gmeiner <christian.gmeiner@gmail.com>,
 Peter Collingbourne <pcc@google.com>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 "Alexander A. Klimov" <grandmaster@al2klimov.de>,
 Linux-MM <linux-mm@kvack.org>, Andrew Jeffery <andrew@aj.id.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "open list:IOMMU DRIVERS" <iommu@lists.linux-foundation.org>,
 Daniel Vetter <daniel@ffwll.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Robin Murphy <robin.murphy@arm.com>, Mike Rapoport <rppt@kernel.org>,
 Lucas Stach <l.stach@pengutronix.de>
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

On Fri, Apr 9, 2021 at 1:21 PM David Hildenbrand <david@redhat.com> wrote:
>
> Random drivers should not override a user configuration of core knobs
> (e.g., CONFIG_DMA_CMA=n). Applicable drivers would like to use DMA_CMA,
> which depends on CMA, if possible; however, these drivers also have to
> tolerate if DMA_CMA is not available/functioning, for example, if no CMA
> area for DMA_CMA use has been setup via "cma=X". In the worst case, the
> driver cannot do it's job properly in some configurations.
>
> For example, commit 63f5677544b3 ("drm/etnaviv: select CMA and DMA_CMA if
> available") documents
>         While this is no build dependency, etnaviv will only work correctly
>         on most systems if CMA and DMA_CMA are enabled. Select both options
>         if available to avoid users ending up with a non-working GPU due to
>         a lacking kernel config.
> So etnaviv really wants to have DMA_CMA, however, can deal with some cases
> where it is not available.
>
> Let's introduce WANT_DMA_CMA and use it in most cases where drivers
> select CMA/DMA_CMA, or depend on DMA_CMA (in a wrong way via CMA because
> of recursive dependency issues).
>
> We'll assume that any driver that selects DRM_GEM_CMA_HELPER or
> DRM_KMS_CMA_HELPER would like to use DMA_CMA if possible.
>
> With this change, distributions can disable CONFIG_CMA or
> CONFIG_DMA_CMA, without it silently getting enabled again by random
> drivers. Also, we'll now automatically try to enabled both, CONFIG_CMA
> and CONFIG_DMA_CMA if they are unspecified and any driver is around that
> selects WANT_DMA_CMA -- also implicitly via DRM_GEM_CMA_HELPER or
> DRM_KMS_CMA_HELPER.
>
> For example, if any driver selects WANT_DMA_CMA and we do a
> "make olddefconfig":
>
> 1. With "# CONFIG_CMA is not set" and no specification of
>    "CONFIG_DMA_CMA"
>
> -> CONFIG_DMA_CMA won't be part of .config
>
> 2. With no specification of CONFIG_CMA or CONFIG_DMA_CMA
>
> Contiguous Memory Allocator (CMA) [Y/n/?] (NEW)
> DMA Contiguous Memory Allocator (DMA_CMA) [Y/n/?] (NEW)
>
> 3. With "# CONFIG_CMA is not set" and "# CONFIG_DMA_CMA is not set"
>
> -> CONFIG_DMA_CMA will be removed from .config
>
> Note: drivers/remoteproc seems to be special; commit c51e882cd711
> ("remoteproc/davinci: Update Kconfig to depend on DMA_CMA") explains that
> there is a real dependency to DMA_CMA for it to work; leave that dependency
> in place and don't convert it to a soft dependency.

I don't think this dependency is fundamentally different from the others,
though davinci machines tend to have less memory than a lot of the
other machines, so it's more likely to fail without CMA.

Regardless of this,

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
