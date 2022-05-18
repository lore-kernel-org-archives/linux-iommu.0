Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07C6BC433F5
	for <iommu@archiver.kernel.org>; Wed, 18 May 2022 01:42:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AD3D783403;
	Wed, 18 May 2022 01:42:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nk5aLL6djjZl; Wed, 18 May 2022 01:42:17 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A38D7813CB;
	Wed, 18 May 2022 01:42:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72D36C0032;
	Wed, 18 May 2022 01:42:16 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 290DAC002D
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:42:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1352983403
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:42:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DJrkx6EuKMs2 for <iommu@lists.linux-foundation.org>;
 Wed, 18 May 2022 01:42:15 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com
 [209.85.160.42])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 8D5E4813CB
 for <iommu@lists.linux-foundation.org>; Wed, 18 May 2022 01:42:15 +0000 (UTC)
Received: by mail-oa1-f42.google.com with SMTP id
 586e51a60fabf-e5e433d66dso902991fac.5
 for <iommu@lists.linux-foundation.org>; Tue, 17 May 2022 18:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=crkI7+HwsdAoc3Iq1GjjnJUYtoumtzV3pILJENOsucw=;
 b=k6+K5R+1UNwVPVzAk8xcaYVZadMKIuFza5GgPLvkxVYus4luiq4ehDwojjN5vgagxd
 iIR+bHMuDF6qIQh/a08jCCy+VqcqZQNP7ByN8O4KutH9dC6IOWC8nMWujmItquMeJq9w
 JaUsC0FanN7e3q1GrFsm5Qly6cVXbaSojqO4Ebo8a0lrnnk7PQRSBX8YGVXqdQSEGX5j
 o13T/KzgzH59kokqJpX5LybSW0TKJRLFrifA1gq6ZUQiuhHL/2LT0pvcNjvnn9OL0XKA
 EYf3kgK1f3Tu1sUJL5IwUvVDJ8Rw2s/rUm0PpRfJJWcUmD7919TJG3pVugSuGqPotckz
 1X7Q==
X-Gm-Message-State: AOAM533974OHu3glW+d2EW6cRahd4Xh8GLqLR8cGZzlaNQXYUecGDaNm
 b/qU//PLe5hh/RL6jJ3Ydg==
X-Google-Smtp-Source: ABdhPJxdxYNaSg4qceB2OCZjxphvGORaZqyQisZZrLDaSde4Qt++qmPmm1WVwJIhjbJG92ClP0kR9g==
X-Received: by 2002:a05:6870:65a5:b0:f1:9153:c355 with SMTP id
 fp37-20020a05687065a500b000f19153c355mr8456281oab.163.1652838134589; 
 Tue, 17 May 2022 18:42:14 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 r41-20020a05687017a900b000f15ca674b2sm406734oae.52.2022.05.17.18.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 18:42:13 -0700 (PDT)
Received: (nullmailer pid 2045103 invoked by uid 1000);
 Wed, 18 May 2022 01:42:12 -0000
Date: Tue, 17 May 2022 20:42:12 -0500
From: Rob Herring <robh@kernel.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH 8/8] dt-bindings: iommu: mediatek: Require
 mediatek,pericfg for mt8195-infra
Message-ID: <20220518014212.GA2045069-robh@kernel.org>
References: <20220517132107.195932-1-angelogioacchino.delregno@collabora.com>
 <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220517132107.195932-9-angelogioacchino.delregno@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com, will@kernel.org
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

On Tue, 17 May 2022 15:21:07 +0200, AngeloGioacchino Del Regno wrote:
> The MT8195 SoC has IOMMU related registers in the pericfg_ao iospace:
> require a phandle to that.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---
> 
> Note for Rob: as of now, there's no iommu node in upstream mt8195 devicetrees yet.
> 
>  .../devicetree/bindings/iommu/mediatek,iommu.yaml      | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
