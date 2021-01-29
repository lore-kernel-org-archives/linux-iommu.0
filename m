Return-Path: <SRS0=1cKf=HA=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 808D8C433DB
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:28:07 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F2564FEA
	for <iommu@archiver.kernel.org>; Fri, 29 Jan 2021 11:28:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2F2564FEA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 62A8786A22;
	Fri, 29 Jan 2021 11:28:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaNxBlZ6gm23; Fri, 29 Jan 2021 11:28:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DD9DA86A42;
	Fri, 29 Jan 2021 11:28:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5A33C0FA8;
	Fri, 29 Jan 2021 11:28:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 97FFDC08A1
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:28:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 8639586A42
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:28:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 41zpmNPlif9N for <iommu@lists.linux-foundation.org>;
 Fri, 29 Jan 2021 11:28:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 01A0C86A22
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 11:28:02 +0000 (UTC)
Received: by mail-pj1-f50.google.com with SMTP id s24so5641428pjp.5
 for <iommu@lists.linux-foundation.org>; Fri, 29 Jan 2021 03:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=UKt/ubY4NcKHPSuooMktGXNsT6JEg6MKsXcex2sGKe8=;
 b=gqMrIqM9RHMHldMrUnjAkN1fRmF4cjPTc0J0+QOB+VbL7iXONd3CsW9r7nRoIz1upF
 t1zUZXpX+e6By1m8iojw872Krj/assjDWoiEQ0X4dydPOQkKpmah0xz5+Qe/9DPSPjOs
 nIk3KYBVdlNHnb/HFAlrb1xqghvbiRfnw6ars=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UKt/ubY4NcKHPSuooMktGXNsT6JEg6MKsXcex2sGKe8=;
 b=LBUek3mXMG/Csx/43kc7jRQO8kbtGSD+Wpo9bnpIzEc8Gy85kYxANDvAsfgLuYF+n9
 xpejxplRmvfGGi9VQustGgFMAqfp1C7mkHmdZ8dLK6YQbn/IMAVw/S6XZ8m4rT2UtW1o
 BX9LGIMK86VuORSDyP9BYbdv0J1H+APOdckhNLBnllA6wREok1BoXV9SCVCPLY1FURng
 sG3o0OpuRoF+cXiwNqC5VkXLQ7AOL/R+avUe0YTrIoGZp7u/OzJlj0kquqNypVxjpMMh
 W2A1KyRVRlVcVdQZY+uQNn4Z5+IymzR5bw/F8hfJg+d89Uk3RxuMVU+v3w35rb8y2sHI
 9X+Q==
X-Gm-Message-State: AOAM532w+Wu96sNBYuAX7FYM0kWbVOBGrzWdWdsByKFH7PIxOKBDpt6x
 4mm5NLMQnr1YgjBfnpuRwPk5+A==
X-Google-Smtp-Source: ABdhPJwyI1sjiVYZFaaB20NTokFieNiqqD/prZv9gC82hFlSGp+vl+GcwyLFrLO+OaPzTpe3i2d+ew==
X-Received: by 2002:a17:902:ec82:b029:de:8483:50b4 with SMTP id
 x2-20020a170902ec82b02900de848350b4mr3786253plg.41.1611919682569; 
 Fri, 29 Jan 2021 03:28:02 -0800 (PST)
Received: from chromium.org ([2401:fa00:8f:2:7150:e37b:6e7f:9e9e])
 by smtp.gmail.com with ESMTPSA id k11sm8695097pgt.83.2021.01.29.03.27.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Jan 2021 03:28:01 -0800 (PST)
Date: Fri, 29 Jan 2021 20:27:56 +0900
From: Tomasz Figa <tfiga@chromium.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v6 00/33] MT8192 IOMMU support
Message-ID: <YBPxPAQK29cr69+r@chromium.org>
References: <20210111111914.22211-1-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210111111914.22211-1-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Evan Green <evgreen@chromium.org>,
 chao.hao@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, anan.sun@mediatek.com,
 Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
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

Hi Yong,

On Mon, Jan 11, 2021 at 07:18:41PM +0800, Yong Wu wrote:
> This patch mainly adds support for mt8192 Multimedia IOMMU and SMI.
> 
> mt8192 also is MTK IOMMU gen2 which uses ARM Short-Descriptor translation
> table format. The M4U-SMI HW diagram is as below:
> 
>                           EMI
>                            |
>                           M4U
>                            |
>                       ------------
>                        SMI Common
>                       ------------
>                            |
>   +-------+------+------+----------------------+-------+
>   |       |      |      |       ......         |       |
>   |       |      |      |                      |       |
> larb0   larb1  larb2  larb4     ......      larb19   larb20
> disp0   disp1   mdp    vdec                   IPE      IPE
> 
> All the connections are HW fixed, SW can NOT adjust it.
> 
> Comparing with the preview SoC, this patchset mainly adds two new functions:
> a) add iova 34 bits support.
> b) add multi domains support since several HW has the special iova
> region requirement.
> 
> change note:
> v6:a) base on v5.11-rc1. and tlb v4:
>       https://lore.kernel.org/linux-mediatek/20210107122909.16317-1-yong.wu@mediatek.com/T/#t 
>    b) Remove the "domain id" definition in the binding header file.
>       Get the domain from dev->dma_range_map.
>       After this, Change many codes flow.
>    c) the patchset adds a new common file(mtk_smi-larb-port.h).
>       This version changes that name into mtk-memory-port.h which reflect 
>       its file path. This only changes the file name. no other change.
>       thus I keep all the Reviewed-by Tags.
>       (another reason is that we will add some iommu ports unrelated with
>        smi-larb)
>    d) Refactor the power-domain flow suggestted by Tomasz.
>    e) Some other small fix. use different oas for different soc; Change the
>    macro for 34bit iova tlb flush.
> 

Thanks for the fixes.

I still think the concept of dma-ranges is not quire right for the
problem we need to solve here, but it certainly works for the time being
and it's possible to remove it in a follow up patch, so I'm fine with
merging this as is.

Reviewed-by: Tomasz Figa <tfiga@chromium.org>

I'll comment on my suggestion for a replacement for the dma-ranges that
doesn't need hardcoding arbitrary address ranges in DT in a separate
reply.

Best regards,
Tomasz
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
