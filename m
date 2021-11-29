Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC49C433F5
	for <iommu@archiver.kernel.org>; Mon, 29 Nov 2021 22:50:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7584340480;
	Mon, 29 Nov 2021 22:50:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ophcHdcvYIQQ; Mon, 29 Nov 2021 22:50:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 63EE84057D;
	Mon, 29 Nov 2021 22:50:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 313DDC001C;
	Mon, 29 Nov 2021 22:50:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D710C000A
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 22:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5934B401E4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 22:50:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nm2XtqRjwe8J for <iommu@lists.linux-foundation.org>;
 Mon, 29 Nov 2021 22:50:34 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C340F400D4
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 22:50:34 +0000 (UTC)
Received: by mail-ot1-f42.google.com with SMTP id
 u18-20020a9d7212000000b00560cb1dc10bso27599838otj.11
 for <iommu@lists.linux-foundation.org>; Mon, 29 Nov 2021 14:50:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qWL8hJC/A0AV1km5eJc7hYhQ5lsLfhkwDnG1R3lL5ts=;
 b=ms586C83SxLweDU/tayBooKMpWXjf81K5BDUz9zNGlk/5y3Ue3bQ/8pgl3V8MNbX8z
 bIbGcQYpQ+hxJI14ygV0wTK2bqAZkA4THNJPm7fC+5iGEEiwHuXXHBKcpMW7Rcmnf1vd
 iBG565gaTj/k5OIB0TMJ+4e1JbQEfVvd4khtTZVnz4yuqUcHckAHdAq1pSJXGsMDGBqf
 VjpTZL33CUY6FKENeHgKiSUdTukRTMuKVVbTyoxEaJBeBVfagq9eO9hHtou4c1ITVzed
 ecnj3d9zTFWtuGl7Zt/8fDlqY4N+lvoSePS+Ew6l0m/1HO3Uo4ODIxs/t6edgTYzarbP
 cWeQ==
X-Gm-Message-State: AOAM533nJA3HwGWvIze46QXZaMYprDydYcEO0OP/IZllduXV+ptUX56C
 j8TboSYRqoB1lzg7sUT1PQ==
X-Google-Smtp-Source: ABdhPJxzqxONDfPdEwnHa6GDEi1xkdkjaDaXuvyWIphExGSHtIKZoPxZeNKfoBdPp+P+6gnsXeEcnw==
X-Received: by 2002:a9d:6358:: with SMTP id y24mr48961705otk.369.1638226233869; 
 Mon, 29 Nov 2021 14:50:33 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id r26sm2865774otn.15.2021.11.29.14.50.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Nov 2021 14:50:33 -0800 (PST)
Received: (nullmailer pid 756915 invoked by uid 1000);
 Mon, 29 Nov 2021 22:50:32 -0000
Date: Mon, 29 Nov 2021 16:50:32 -0600
From: Rob Herring <robh@kernel.org>
To: Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH 1/4] dt-bindings: iommu: dart: add t6000 compatible
Message-ID: <YaVZOOUNuglM5TYy@robh.at.kernel.org>
References: <20211117211509.28066-1-sven@svenpeter.dev>
 <20211117211509.28066-2-sven@svenpeter.dev>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211117211509.28066-2-sven@svenpeter.dev>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 Hector Martin <marcan@marcan.st>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>,
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

On Wed, 17 Nov 2021 22:15:06 +0100, Sven Peter wrote:
> The M1 Max/Pro SoCs come with a new DART variant that is incompatible with
> the previous one. Add a new compatible for those.
> 
> Signed-off-by: Sven Peter <sven@svenpeter.dev>
> ---
>  Documentation/devicetree/bindings/iommu/apple,dart.yaml | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
