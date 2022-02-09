Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CCD8C433F5
	for <iommu@archiver.kernel.org>; Wed,  9 Feb 2022 03:15:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0A8644151D;
	Wed,  9 Feb 2022 03:15:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JeOOzGN3Iaq5; Wed,  9 Feb 2022 03:15:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1737B409E3;
	Wed,  9 Feb 2022 03:15:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C55D4C0011;
	Wed,  9 Feb 2022 03:15:26 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48527C000B
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:15:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 26EBD41512
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:15:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8gUoWqOQiHQK for <iommu@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 03:15:23 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 24D61409E3
 for <iommu@lists.linux-foundation.org>; Wed,  9 Feb 2022 03:15:23 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id x193so1264780oix.0
 for <iommu@lists.linux-foundation.org>; Tue, 08 Feb 2022 19:15:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MJCtSboYT6/FzFkykJymBzPa+HtdV+toCECownbioaY=;
 b=loIPAWLvUkdtNuLMpVfAiRIh0V/H4mUK8c9aFavhcEfriaHd17KwjRe8Mx3CIxYcn+
 0gr8Oy96KkOrrbapGioaduqxyYZGgcnqSn2vnEbWmsZejGXVtxoPXFunowmxaNjHFTFJ
 0lSU6naLAj4Ee7MEzaMVbVv+gQwuh0eIl9Z5zUbylxarKe7o0/4OAMsDsksqOVusmCUC
 i2WTIvO6ksQSHGCWIsUgXhWfcfyV/JxZXFt0/LSYF4wKkq4LAEjYMIv8ti32ZfnM2hwl
 bYtEbKW8sTMZD54CXJU1WD8K+Zl2Xicrsbhwbksv/gFWQzXQDuFhakVR9q7/4WlJXDga
 FFug==
X-Gm-Message-State: AOAM531yxNWn7gP0q1Kl2d1bLE7I9ml9qEqGy8og/Do9tVcKn9FqyYzI
 cem7CPimRPD4WKXrTnS2bA==
X-Google-Smtp-Source: ABdhPJwdf+t06UGFJrNWAzD6ZQ6SffxtFCOI3Zx37S5Z0p0n4x6v109e9VJ4zIoDm5w0/CB30nKSmA==
X-Received: by 2002:a05:6808:2214:: with SMTP id
 bd20mr461324oib.159.1644376521985; 
 Tue, 08 Feb 2022 19:15:21 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id s3sm6096547otg.67.2022.02.08.19.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Feb 2022 19:15:21 -0800 (PST)
Received: (nullmailer pid 3560138 invoked by uid 1000);
 Wed, 09 Feb 2022 03:15:19 -0000
Date: Tue, 8 Feb 2022 21:15:19 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 1/2] dt-bindings: mediatek: mt8186: Add binding for MM
 iommu
Message-ID: <YgMxxx+b77IHQIbq@robh.at.kernel.org>
References: <20220125093244.18230-1-yong.wu@mediatek.com>
 <20220125093244.18230-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220125093244.18230-2-yong.wu@mediatek.com>
Cc: yf.wang@mediatek.com, yen-chang.chen@mediatek.com,
 Will Deacon <will@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 xueqi.zhang@mediatek.com, mingyuan.ma@mediatek.com, devicetree@vger.kernel.org,
 chengci.xu@mediatek.com, libo.kang@mediatek.com,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 Hsin-Yi Wang <hsinyi@chromium.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-arm-kernel@lists.infradead.org,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 anan.sun@mediatek.com, srv_heupstream@mediatek.com,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
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

On Tue, 25 Jan 2022 17:32:43 +0800, Yong Wu wrote:
> Add mt8186 iommu binding. "-mm" means the iommu is for Multimedia.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.yaml        |   4 +
>  .../dt-bindings/memory/mt8186-memory-port.h   | 217 ++++++++++++++++++
>  2 files changed, 221 insertions(+)
>  create mode 100644 include/dt-bindings/memory/mt8186-memory-port.h
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
