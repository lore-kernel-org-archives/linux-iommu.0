Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CAA5C433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 20:31:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E08BC81252;
	Mon, 13 Dec 2021 20:31:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2lvbZS157n3K; Mon, 13 Dec 2021 20:31:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CF8848124F;
	Mon, 13 Dec 2021 20:31:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA102C002F;
	Mon, 13 Dec 2021 20:31:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D1E6C0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:31:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7E5CA60B26
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:31:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id c-7WqGcNgLLT for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 20:31:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com
 [209.85.161.53])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 57581606F5
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 20:31:30 +0000 (UTC)
Received: by mail-oo1-f53.google.com with SMTP id
 v19-20020a4a2453000000b002bb88bfb594so4468076oov.4
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 12:31:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=6Jz4O5bCit+lttjk1cWgGeasdedfgCU+0At2jS7RFSQ=;
 b=8Bd+NRq+Db1KBlNNpLPi9bqe3PYJOCsv95pFx5Y29tm+uC3uFCor++Gz4yW45yUmCe
 KnB0RPTy1wjNOb5AeHvkRuz6Rk0N37t/e4PppUXu0TKtKHupQmPlOOYWDEaQRApS/crf
 uNQZvKlcE1P7Pfw+UHPtQxpcuy6f3thlRHzIO4ftJZl4aWWQGGOYWLPWLvXMehaXH7yM
 QbLJjZ7mQqd69ZKRsjKqUZZgTRsnjM9XBSyRWqDCDh8kKJnLCzdmJ4YlhJN/8D5DZ1k6
 igdZlnqQy/D0gGiIOxb6ZnhgBBSAW9eGGbDqbtQgGxNU8QMy0J6bVrx1IMRcS1ZjBo7T
 Au4Q==
X-Gm-Message-State: AOAM532G3OCOlo0LTvjQJNwNfZ4xeOVoMNqkSGo4MUM8lwaZnpEwCZeT
 h08mJO2wboG3DV785KhESw==
X-Google-Smtp-Source: ABdhPJx7lUq1A20jc5mI60hoJ2qUBaBDpxbjw29ueJ948efm/GYtUpX11ooAyBeEUo7gl9BXh/sNbQ==
X-Received: by 2002:a05:6820:151b:: with SMTP id
 ay27mr535785oob.22.1639427489902; 
 Mon, 13 Dec 2021 12:31:29 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id m22sm2534192ooj.8.2021.12.13.12.31.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 12:31:29 -0800 (PST)
Received: (nullmailer pid 1520651 invoked by uid 1000);
 Mon, 13 Dec 2021 20:31:28 -0000
Date: Mon, 13 Dec 2021 14:31:28 -0600
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH 2/4] dt-bindings: memory: mediatek: Add mt8186 support
Message-ID: <YbetoA2JJtnXj7gm@robh.at.kernel.org>
References: <20211203064027.14993-1-yong.wu@mediatek.com>
 <20211203064027.14993-3-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211203064027.14993-3-yong.wu@mediatek.com>
Cc: anan.sun@mediatek.com, youlin.pei@mediatek.com, srv_heupstream@mediatek.com,
 Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
 devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>,
 yi.kuo@mediatek.com, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org,
 lc.kan@mediatek.com, Matthias Brugger <matthias.bgg@gmail.com>,
 anthony.huang@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, 03 Dec 2021 14:40:25 +0800, Yong Wu wrote:
> Add mt8186 smi support in the bindings.
> 
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../bindings/memory-controllers/mediatek,smi-common.yaml      | 4 +++-
>  .../bindings/memory-controllers/mediatek,smi-larb.yaml        | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
