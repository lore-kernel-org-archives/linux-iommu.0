Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7525AC433EF
	for <iommu@archiver.kernel.org>; Mon, 16 May 2022 16:27:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2F82240B7E;
	Mon, 16 May 2022 16:27:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S0LUbYkdeSye; Mon, 16 May 2022 16:27:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 10CF3404F8;
	Mon, 16 May 2022 16:27:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DDCBBC0032;
	Mon, 16 May 2022 16:27:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19F00C002D
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:27:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id EA84C610CA
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7wVf56uLNXqX for <iommu@lists.linux-foundation.org>;
 Mon, 16 May 2022 16:27:50 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com
 [209.85.160.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 67982610A5
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 16:27:50 +0000 (UTC)
Received: by mail-oa1-f53.google.com with SMTP id
 586e51a60fabf-f165bc447fso10919104fac.6
 for <iommu@lists.linux-foundation.org>; Mon, 16 May 2022 09:27:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=osVfxhsQi2p2dlDrhzZDuOBV7X+Ps662PG/MDdJu9W0=;
 b=aLgydF9DvOLJ1l+AqaDmAwjrHJ8/Uj/87n6OZ+BhwTKiWq2+bTriB7IM5LaS5wGGso
 ml6saWtqeq/A8dfp5lyHLj18KbNOMURBc5IUx28DP+d2sRZbM7edpuLZKcYE0tWc+JSd
 kjgc+dQ6jfK686KT09PboZg3OelHP1eB4nGDwj3px/ou37RRP22CrakqwCu3OCgUOTl7
 KWceo4o6jxpkwLivK3JNyHRPGNFlozN39in6+Oz3rVn+/SiPEkMcOv7lDk7VKONfKpEz
 1YfjQo4j3ItELcb2r3/gmbblw/VN8OwvPHo7XCiLEtV0eeLEBRwEDYFzTGfJPhv6SxGb
 epgQ==
X-Gm-Message-State: AOAM5307tvoLtJ7PPH4v4dyh5oRoKRUjwfi+OMjEWJgfMA0aW/ytk9pC
 sLlWxPFhh334JZpOybRYtA==
X-Google-Smtp-Source: ABdhPJxaunhi1VLlqHvgFaK+EgjKjq0gVMM8ayHjAQzaIw/eUPKQEHsbfeLNaMcAuwFJet/LLjQYYg==
X-Received: by 2002:a05:6870:890f:b0:e1:c92d:d84 with SMTP id
 i15-20020a056870890f00b000e1c92d0d84mr9757652oao.49.1652718469152; 
 Mon, 16 May 2022 09:27:49 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net.
 [66.90.144.107]) by smtp.gmail.com with ESMTPSA id
 b18-20020a9d6b92000000b00606b1f72fcbsm4071686otq.31.2022.05.16.09.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 09:27:48 -0700 (PDT)
Received: (nullmailer pid 2793161 invoked by uid 1000);
 Mon, 16 May 2022 16:27:47 -0000
Date: Mon, 16 May 2022 11:27:47 -0500
From: Rob Herring <robh@kernel.org>
To: cyndis@kapsi.fi
Subject: Re: [PATCH v5 1/9] dt-bindings: host1x: Add iommu-map property
Message-ID: <20220516162747.GA2793126-robh@kernel.org>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
 <20220516085258.1227691-2-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516085258.1227691-2-cyndis@kapsi.fi>
Cc: devicetree@vger.kernel.org, krzysztof.kozlowski@canonical.com,
 will@kernel.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 jonathanh@nvidia.com, robh+dt@kernel.org, iommu@lists.linux-foundation.org,
 thierry.reding@gmail.com, linux-tegra@vger.kernel.org,
 Mikko Perttunen <mperttunen@nvidia.com>, robin.murphy@arm.com,
 linux-arm-kernel@lists.infradead.org
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

On Mon, 16 May 2022 11:52:50 +0300, cyndis@kapsi.fi wrote:
> From: Mikko Perttunen <mperttunen@nvidia.com>
> 
> Add schema information for specifying context stream IDs. This uses
> the standard iommu-map property.
> 
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> Reviewed-by: Robin Murphy <robin.murphy@arm.com>
> ---
> v3:
> * New patch
> v4:
> * Remove memory-contexts subnode.
> ---
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml        | 5 +++++
>  1 file changed, 5 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
