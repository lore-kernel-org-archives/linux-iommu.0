Return-Path: <SRS0=LARK=EF=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEE3C4363A
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 13:53:12 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 016FE2076E
	for <iommu@archiver.kernel.org>; Fri, 30 Oct 2020 13:53:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 016FE2076E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3DE2986A89;
	Fri, 30 Oct 2020 13:53:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xk9vMpU6hQ5y; Fri, 30 Oct 2020 13:53:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E128986A94;
	Fri, 30 Oct 2020 13:53:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C31ECC0859;
	Fri, 30 Oct 2020 13:53:09 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F20D2C0051
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 13:53:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E04FF874A3
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 13:53:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FEbEVuOmsKGB for <iommu@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 13:53:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com
 [209.85.210.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D3172874B5
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 13:53:07 +0000 (UTC)
Received: by mail-ot1-f67.google.com with SMTP id h62so5578755oth.9
 for <iommu@lists.linux-foundation.org>; Fri, 30 Oct 2020 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ggiAUaruNw1YhH2l2hRk36w59nO1Oq/R58cjSZ0WsS0=;
 b=UpiQkiHUyWZmzyy2PuZOZ7rhYgs28deIT/DFuNsjzUUW163IXxPP/hvta4piXj1xd/
 CeeiEmVqt6PMZoipcIsov0PSHWuwRiY0u8fCylS/MFIkYhP71C0x4y2wR/s24S8fkkro
 OhOAlZYB5bkD54pHqwQCURyVEgMVQNgidGi2Yn1LXG3FtyuqGxBdACEuvq3yrP1lz6ah
 Htz/oCW5y/UmdMhGdlw76PVW7gZmKC0v+4MImDafa9Fy/7xxWtn3XPs7T4tTH/Pj8Gl/
 tckHdT6XyrDBvx4e82BPLT4yT40orX5fO6BaAamMf0u6IBhXcCz4KltZMsi5YCi2J2G5
 Tf6Q==
X-Gm-Message-State: AOAM530uEjzWPDJ/8NU0o9H/n77RhH+j+LZo0xjeQutqMe7c29dG/rP3
 aSd1SF4AvBlOYDUqN14Fsg==
X-Google-Smtp-Source: ABdhPJxq/KhYrqN/T8NyxVmXEavGpBaGULf6IaWMFkIEntoJ3gOZgHkdXrgULkZisLkAOY1u63cuMg==
X-Received: by 2002:a9d:75d6:: with SMTP id c22mr1672627otl.213.1604065987144; 
 Fri, 30 Oct 2020 06:53:07 -0700 (PDT)
Received: from xps15 (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id j184sm1386766oih.8.2020.10.30.06.53.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 06:53:06 -0700 (PDT)
Received: (nullmailer pid 3747758 invoked by uid 1000);
 Fri, 30 Oct 2020 13:53:05 -0000
Date: Fri, 30 Oct 2020 08:53:05 -0500
From: Rob Herring <robh@kernel.org>
To: Yong Wu <yong.wu@mediatek.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: memory: mediatek: Convert SMI to DT
 schema
Message-ID: <20201030135305.GA3746616@bogus>
References: <20201030091254.26382-1-yong.wu@mediatek.com>
 <20201030091254.26382-2-yong.wu@mediatek.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201030091254.26382-2-yong.wu@mediatek.com>
Cc: youlin.pei@mediatek.com, anan.sun@mediatek.com,
 Nicolas Boichat <drinkcat@chromium.org>, srv_heupstream@mediatek.com,
 Tomasz Figa <tfiga@google.com>, devicetree@vger.kernel.org,
 Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
 Krzysztof Kozlowski <krzk@kernel.org>, Fabien Parent <fparent@baylibre.com>,
 iommu@lists.linux-foundation.org, Rob Herring <robh+dt@kernel.org>,
 linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>,
 ming-fan.chen@mediatek.com, Robin Murphy <robin.murphy@arm.com>,
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

On Fri, 30 Oct 2020 17:12:52 +0800, Yong Wu wrote:
> Convert MediaTek SMI to DT schema.
> 
> CC: Fabien Parent <fparent@baylibre.com>
> CC: Ming-Fan Chen <ming-fan.chen@mediatek.com>
> CC: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  .../mediatek,smi-common.txt                   |  50 -------
>  .../mediatek,smi-common.yaml                  | 140 ++++++++++++++++++
>  .../memory-controllers/mediatek,smi-larb.txt  |  50 -------
>  .../memory-controllers/mediatek,smi-larb.yaml | 129 ++++++++++++++++
>  4 files changed, 269 insertions(+), 100 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml
>  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.txt
>  create mode 100644 Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml
> 


My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml:84:8: [warning] wrong indentation: expected 6 but found 7 (indentation)
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-common.yaml:98:13: [warning] wrong indentation: expected 10 but found 12 (indentation)
./Documentation/devicetree/bindings/memory-controllers/mediatek,smi-larb.yaml:41:8: [warning] wrong indentation: expected 6 but found 7 (indentation)

dtschema/dtc warnings/errors:


See https://patchwork.ozlabs.org/patch/1390887

The base for the patch is generally the last rc1. Any dependencies
should be noted.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
