Return-Path: <SRS0=dfl9=EW=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43FC2D0A3
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 17:43:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 895DA22265
	for <iommu@archiver.kernel.org>; Mon, 16 Nov 2020 17:43:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 895DA22265
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 346E485E77;
	Mon, 16 Nov 2020 17:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IcgOAluDghJy; Mon, 16 Nov 2020 17:43:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id BA9CE85569;
	Mon, 16 Nov 2020 17:43:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F0DCC0891;
	Mon, 16 Nov 2020 17:43:40 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 762B7C07FF
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 17:43:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5D67085E77
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 17:43:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SAnFol88iqNG for <iommu@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 17:43:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 64B5F85569
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 17:43:38 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id 79so16792132otc.7
 for <iommu@lists.linux-foundation.org>; Mon, 16 Nov 2020 09:43:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bFSVgx8WStUFGQnq+FjDm6HcOkdzT+U43PMkQHH3/Aw=;
 b=sCwba1DcF6U3YB8tXB7pXfdrBMgTqITn4vZaxiNW3sjwvk9JgM/r3EF1an2YtDYD52
 cY5AuPHJeBcaos5MY0jCMKYiCTPymCFHjHgRdjSBEnEqPAMeXeMEx8urR4kXLbM9RTti
 EZgeE2skqa7k5WEyfNotcG094eoypN6RIV2XMTSobGc4G6OiXq4CHWJ19hegiDbMXMQa
 nE/E67xyYd2zIDYTtDZpxntOykR1701pbXyhXV8w7DnegC1rsk47HdysURlVevJrDYnQ
 hSgZeflgEpwPFQ9V/EYpRK2/J9xs2f/xwLB50siXUpBsbCE4Lm3iELlkd6JQqZ8a7JQK
 jTcA==
X-Gm-Message-State: AOAM531ihoRAr7m0FYRLkccLEmztOQsspGRWyuVctxRF/UhV83R1bglG
 o+NdchNSlpnGtGjsefZFpg==
X-Google-Smtp-Source: ABdhPJwh1KaqZEZLdQqP4EWjEctBZTixLBC9FyUTW+gl0aAyhKJKwMO7/5rESwI4HpgWTlAqXMMXlg==
X-Received: by 2002:a05:6830:1259:: with SMTP id
 s25mr332017otp.66.1605548617729; 
 Mon, 16 Nov 2020 09:43:37 -0800 (PST)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id t5sm4921770oth.16.2020.11.16.09.43.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 09:43:37 -0800 (PST)
Received: (nullmailer pid 1861365 invoked by uid 1000);
 Mon, 16 Nov 2020 17:43:35 -0000
Date: Mon, 16 Nov 2020 11:43:35 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 01/24] dt-bindings: iommu: mediatek: Convert IOMMU to
 DT schema
Message-ID: <20201116174335.GA1861314@bogus>
References: <20201111123838.15682-1-yong.wu@mediatek.com>
 <20201111123838.15682-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201111123838.15682-2-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, devicetree@vger.kernel.org,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 chao.hao@mediatek.com, kernel-team@android.com, youlin.pei@mediatek.com,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Tomasz Figa <tfiga@google.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Evan Green <evgreen@chromium.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Greg Kroah-Hartman <gregkh@google.com>, Robin Murphy <robin.murphy@arm.com>,
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

On Wed, 11 Nov 2020 20:38:15 +0800, Yong Wu wrote:
> Convert MediaTek IOMMU to DT schema.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/iommu/mediatek,iommu.txt         | 105 -----------
>  .../bindings/iommu/mediatek,iommu.yaml        | 167 ++++++++++++++++++
>  2 files changed, 167 insertions(+), 105 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/mediatek,iommu.yaml
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
