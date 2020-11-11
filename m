Return-Path: <SRS0=hwFB=ER=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC80C5517A
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:33 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7311520825
	for <iommu@archiver.kernel.org>; Wed, 11 Nov 2020 21:30:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7311520825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id EF5AB86D24;
	Wed, 11 Nov 2020 21:30:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AExcOdPdXMnv; Wed, 11 Nov 2020 21:30:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8506B86D22;
	Wed, 11 Nov 2020 21:30:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 72158C088B;
	Wed, 11 Nov 2020 21:30:31 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D63CBC016F
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id BC72B2E176
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XaMxGliGe7fk for <iommu@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 21:30:29 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com
 [209.85.208.67])
 by silver.osuosl.org (Postfix) with ESMTPS id E19E12E174
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 21:30:28 +0000 (UTC)
Received: by mail-ed1-f67.google.com with SMTP id ay21so3883969edb.2
 for <iommu@lists.linux-foundation.org>; Wed, 11 Nov 2020 13:30:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=VXU2Y8um07dYkZOSE2h8yApKemYd1SjZEtR4nU/PGP4=;
 b=CXWUF/a4mu5eeoll2ywUJ/jeGRg+UADZ6tsujMCDMEKrcFrqfpzXnabK2EBL2Rc10t
 6Q3FvjcrhiNt+/KTTK13uNK24WnCzOTT0mCUCIbJNxz5L9eUfj90ELGi/qhxPLeXogmy
 Sa/4htFmdpTrk78TySv/suITbNXMmPjoNnLetSKY/NnVd+fc7CZnAikR6cEOmqgAYwo5
 Iw+JVPQT53c20bcwQ8pxw1UPlOmqJ8pj/O3v7SQM18ajxYAzDFMOeRBlDBb5xIHoiCPK
 EiqoZ5qJ5yrzmOKptmMi6A1SBfwh59oJRF5zH84GEMEnUe0uHS7uT4cP4YHb11f+fkct
 Mcgw==
X-Gm-Message-State: AOAM532UczMORBAfVN2w7f8QwzZ0xHCTeVA9HV6DwEtDGL3K9GemIR1W
 Ek0Z7IR06wknl+h1vZETeLU=
X-Google-Smtp-Source: ABdhPJwVSGs92SscCBCPBRoMp1HtHTNhBg0G7orwBTU8eK0jeXqo9NPvVCdZIMkZeStonb8IonVcFg==
X-Received: by 2002:a50:b761:: with SMTP id g88mr1638344ede.387.1605130227345; 
 Wed, 11 Nov 2020 13:30:27 -0800 (PST)
Received: from kozik-lap (adsl-84-226-167-205.adslplus.ch. [84.226.167.205])
 by smtp.googlemail.com with ESMTPSA id k12sm1319337ejz.48.2020.11.11.13.30.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Nov 2020 13:30:26 -0800 (PST)
Date: Wed, 11 Nov 2020 22:30:24 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 03/24] dt-bindings: memory: mediatek: Extend
 LARB_NR_MAX to 32
Message-ID: <20201111213024.GB287176@kozik-lap>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-4-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-4-yong.wu@mediatek.com>
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

On Wed, Nov 11, 2020 at 08:38:17PM +0800, Yong Wu wrote:
> Extend the max larb number definition as mt8192 has larb_nr over 16.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml | 2 +-
>  include/dt-bindings/memory/mtk-smi-larb-port.h              | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
