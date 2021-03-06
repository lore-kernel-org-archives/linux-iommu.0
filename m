Return-Path: <SRS0=X0Rt=IE=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5307FC433E0
	for <iommu@archiver.kernel.org>; Sat,  6 Mar 2021 00:04:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF0E5650AC
	for <iommu@archiver.kernel.org>; Sat,  6 Mar 2021 00:04:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF0E5650AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=nxp.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78F0B6FB9C;
	Sat,  6 Mar 2021 00:04:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oU6Q5nhaNiAB; Sat,  6 Mar 2021 00:04:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6A864605ED;
	Sat,  6 Mar 2021 00:04:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 37BC8C000A;
	Sat,  6 Mar 2021 00:04:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B421C0001;
 Sat,  6 Mar 2021 00:04:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 5744F60596;
 Sat,  6 Mar 2021 00:04:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id e1aKdaDFiRBo; Sat,  6 Mar 2021 00:03:59 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com
 [209.85.210.41])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A7E9360017;
 Sat,  6 Mar 2021 00:03:59 +0000 (UTC)
Received: by mail-ot1-f41.google.com with SMTP id j8so3546427otc.0;
 Fri, 05 Mar 2021 16:03:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=FCbBlEEqgxfjPjtQfKvWFaWJOfXoBc2uhQxuYQUH8F0=;
 b=bzcfT0peu5CTKW+UHdJvcXy1IW420ImswRbHwIN8TnkeEhNARI9B01ljtZ6hCqfY6s
 XgPY38UTKR7Fi0QK8WAsHNxOPEiRvcq5HGrPy1efOShAu8S4xyHeY1hcPFju1wRAVhsK
 IjnDYXq0YBTNldOZxEHHaEDlFEtKThHZwxt0n0T0FZZfufGgDbhaWp5aKT16CEGMW5Tr
 kpRVMAtYXgRSxEO1phY4ZPoyk7LWf2KcDPHku2Pcng0J++Wf1iNUAYMnoI3i5FRGlIpV
 HkIdUsSgcI7m1/ZjXLo3LH7CGmA0pejMkxj4irxzYwgK+N/jAV0ah4EgbyXcKECmSVWA
 DPzg==
X-Gm-Message-State: AOAM532nEpnR5OAWEyLEVWJJu04TKYGMJMe5WL7Eu5ogH5GSbq8u4MCA
 izhDOPCTGl14CVuE8bBTRlNqZMp3St6AGg==
X-Google-Smtp-Source: ABdhPJwJsbz6pcu6ZxpziZ0YYH4K9ex/xGljDIUiWdx64IOuv0RM6RnGCd4e5oQu1lPV0gziK0b+eQ==
X-Received: by 2002:a9d:80e:: with SMTP id 14mr10184078oty.211.1614989038181; 
 Fri, 05 Mar 2021 16:03:58 -0800 (PST)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com.
 [209.85.167.178])
 by smtp.gmail.com with ESMTPSA id m14sm340814otn.69.2021.03.05.16.03.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Mar 2021 16:03:57 -0800 (PST)
Received: by mail-oi1-f178.google.com with SMTP id a13so4490496oid.0;
 Fri, 05 Mar 2021 16:03:56 -0800 (PST)
X-Received: by 2002:a54:4794:: with SMTP id o20mr9228337oic.51.1614989036851; 
 Fri, 05 Mar 2021 16:03:56 -0800 (PST)
MIME-Version: 1.0
References: <20210301084257.945454-1-hch@lst.de>
In-Reply-To: <20210301084257.945454-1-hch@lst.de>
From: Li Yang <leoyang.li@nxp.com>
Date: Fri, 5 Mar 2021 18:03:45 -0600
X-Gmail-Original-Message-ID: <CADRPPNTSzuuqW97_vd3h5cpHe7gOLyw3zCaqapb8YVqPF-rOfA@mail.gmail.com>
Message-ID: <CADRPPNTSzuuqW97_vd3h5cpHe7gOLyw3zCaqapb8YVqPF-rOfA@mail.gmail.com>
Subject: Re: cleanup unused or almost unused IOMMU APIs and the FSL PAMU driver
To: Christoph Hellwig <hch@lst.de>
Cc: kvm@vger.kernel.org, Will Deacon <will@kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>, Netdev <netdev@vger.kernel.org>,
 freedreno@lists.freedesktop.org, David Woodhouse <dwmw2@infradead.org>,
 linux-arm-msm <linux-arm-msm@vger.kernel.org>
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

On Mon, Mar 1, 2021 at 2:44 AM Christoph Hellwig <hch@lst.de> wrote:
>
> Hi all,
>
> there are a bunch of IOMMU APIs that are entirely unused, or only used as
> a private communication channel between the FSL PAMU driver and it's only
> consumer, the qbman portal driver.
>
> So this series drops a huge chunk of entirely unused FSL PAMU
> functionality, then drops all kinds of unused IOMMU APIs, and then
> replaces what is left of the iommu_attrs with properly typed, smaller
> and easier to use specific APIs.

It looks like the unused APIs were added for functionality that were
never completed later on.  So

Acked-by: Li Yang <leoyang.li@nxp.com>

>
> Diffstat:
>  arch/powerpc/include/asm/fsl_pamu_stash.h   |   12
>  drivers/gpu/drm/msm/adreno/adreno_gpu.c     |    2
>  drivers/iommu/amd/iommu.c                   |   23
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c |   85 ---
>  drivers/iommu/arm/arm-smmu/arm-smmu.c       |  122 +---
>  drivers/iommu/dma-iommu.c                   |    8
>  drivers/iommu/fsl_pamu.c                    |  264 ----------
>  drivers/iommu/fsl_pamu.h                    |   10
>  drivers/iommu/fsl_pamu_domain.c             |  694 ++--------------------------
>  drivers/iommu/fsl_pamu_domain.h             |   46 -
>  drivers/iommu/intel/iommu.c                 |   55 --
>  drivers/iommu/iommu.c                       |   75 ---
>  drivers/soc/fsl/qbman/qman_portal.c         |   56 --
>  drivers/vfio/vfio_iommu_type1.c             |   31 -
>  drivers/vhost/vdpa.c                        |   10
>  include/linux/iommu.h                       |   81 ---
>  16 files changed, 214 insertions(+), 1360 deletions(-)
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
