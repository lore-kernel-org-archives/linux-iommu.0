Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3166DC5517A
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A78B4208B3
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A78B4208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 0265386C55;
	Wed, 11 Nov 2020 21:30:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tDoXkSbIY96Y; Wed, 11 Nov 2020 21:30:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 5796885BA3;
	Wed, 11 Nov 2020 21:30:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 368E8C088B;
	Wed, 11 Nov 2020 21:30:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81560C016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7422686C55
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eUUch0VEhR+E for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 21:30:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com
 [209.85.208.65])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4520185BA3
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:12 +0000 (UTC)
Received: by mail-ed1-f65.google.com with SMTP id t11so3821860edj.13
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:30:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HXTmIvGpS6O2JN7ZP+tV8NA98uj/d24NOFx2y9hbQXo=;
 b=bJyBGn4CDDeF7ixF2jmy1fSMNb6sy0zWeq8RucPafYOPx0QhKGgR1t8/3WZHAgTeLV
 oM1iWVHsMn5/2NYkbUC5btxpAX89cUd2tUCEfxqd9zg170yMhQQ093OhspG5GyxXlCdm
 +W2CTEt2Qc6HO0l+ikqNjJUhKGL4OrR+N89tlc4tu1oXzjgI3AFnCTg+MZ8cnwPRbq4P
 e9WU/qZMtURwIMmltnocoX9TLM3zBbU19rTiaQ+tetIuQLE08m4Fep6mRtRPP8XS3uRo
 WOvs6nMNXMi5zFCbK+kdKo6TgDgyaCcoSXQQotFk7t4q11+Vt3oKizbHrof1u0WyXq9V
 Afxw==
X-Gm-Message-State: AOAM530Lk26mX3eNq8X3I2amjH5Vkynt1qSEnVZlq70q1g0ZNP+uVGQk
 as8/W+0Acmf25H26Z3GWLdE=
X-Google-Smtp-Source: ABdhPJzZenTK1Rz6VyR60TpP7GxdbeoRs2AcpvlAu6VCtNPuHEDus85c+Hal/IVl6aOsp2lRL06b2Q==
X-Received: by 2002:a50:fe14:: with SMTP id f20mr1601079edt.61.1605130210735; 
 Wed, 11 Nov 2020 13:30:10 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id z2sm1433060edr.47.2020.11.11.13.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 13:30:09 -0800 (PST)
Date: Wed, 11 Nov 2020 22:30:07 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 02/24] dt-bindings: memory: mediatek: Add a common
 larb-port header file
Message-ID: <20201111213007.GA287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-3-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, Will Deacon <will@kernel.org>,
 Greg Kroah-Hartman <gregkh@google.com>, linux-kernel@vger.kernel.org,
 Evan Green <evgreen@chromium.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 kernel-team@android.com, anan.sun@mediatek.com,
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

On Wed, Nov 11, 2020 at 08:38:16PM +0800, Yong Wu wrote:
> Put all the macros about smi larb/port togethers, this is a preparing
> patch for extending LARB_NR and adding new dom-id support.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  include/dt-bindings/memory/mt2712-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt6779-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8167-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8173-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mt8183-larb-port.h  |  2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h | 15 +++++++++++++++
>  6 files changed, 20 insertions(+), 5 deletions(-)
>  create mode 100644 include/dt-bindings/memory/mtk-smi-larb-port.h
> 
> diff --git a/include/dt-bindings/memory/mt2712-larb-port.h b/include/dt-bindings/memory/mt2712-larb-port.h

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
