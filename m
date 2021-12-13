Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D22DBC433F5
	for <iommu@archiver.kernel.org>; Mon, 13 Dec 2021 19:02:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5CC1F400D0;
	Mon, 13 Dec 2021 19:02:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hntBSG5fY2GV; Mon, 13 Dec 2021 19:02:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 2A17940022;
	Mon, 13 Dec 2021 19:02:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1F06C002F;
	Mon, 13 Dec 2021 19:02:10 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8E0AC0012
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 19:02:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D279B401BE
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 19:02:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GlSrwELoa6uE for <iommu@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 19:02:08 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com
 [209.85.167.177])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4A7A2401BB
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 19:02:08 +0000 (UTC)
Received: by mail-oi1-f177.google.com with SMTP id bf8so24448592oib.6
 for <iommu@lists.linux-foundation.org>; Mon, 13 Dec 2021 11:02:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tEbAdn5YlO0byAH0oTEvYwIYFWP4wTzxxA3rKsMqgPI=;
 b=MFciIIrZim+0tZhQ4Q1MyWjCoPzoHcsx4zZIE+PXNkhLAZmmiGLrJG3Y5gn+bK99JO
 6OqE/t6jnOWicZ4T1xmZ4X4CcalRMSjo3/dY2Ej2SVN9dJanAPAhL0Ajpbg4fu8kKQF+
 UUH4Hj7wWuG+cC0CLyTQjhkEVF5ScrNpjeMuXbmgPeKqZDjR/RP9gU/1TIj9REm3ygBi
 oYaHC275Vx2BGpFtM3CB89oY3JkntpHsnPc00drYuwL6Z5XJb/U7h+q+DXkameP8H9Gl
 Tta/5ORdtUXXoqkhE402DH+Gyq4UOecxAtdjTrAAuFx4yNrZ7AryvDBo2DxH5JxwggGD
 ZvVA==
X-Gm-Message-State: AOAM533fzp2WNhUiisqJwxuf/jVGJg/m3fhh2x9SUkNgXBCFMGsgQeL4
 t6A/tpiHv11UiLWM+T91aw==
X-Google-Smtp-Source: ABdhPJwfmZKhTcyermRckjwVUR51Q+PIrNv5i9wFZsuWFt3sXBmR8hmteTCR1F2dx8sSDJV29rTUsg==
X-Received: by 2002:aca:581:: with SMTP id 123mr440392oif.13.1639422127396;
 Mon, 13 Dec 2021 11:02:07 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net.
 [66.90.148.213])
 by smtp.gmail.com with ESMTPSA id a17sm2989012oiw.43.2021.12.13.11.02.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Dec 2021 11:02:06 -0800 (PST)
Received: (nullmailer pid 1386389 invoked by uid 1000);
 Mon, 13 Dec 2021 19:02:05 -0000
Date: Mon, 13 Dec 2021 13:02:05 -0600
From: Rob Herring <robh@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Subject: Re: [PATCH 1/2] dt-bindings: arm-smmu: Add compatible for SM8450 SoC
Message-ID: <YbeYrZmavBECxE/O@robh.at.kernel.org>
References: <20211201073943.3969549-1-vkoul@kernel.org>
 <20211201073943.3969549-2-vkoul@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211201073943.3969549-2-vkoul@kernel.org>
Cc: devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
 linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org,
 Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
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

On Wed, 01 Dec 2021 13:09:42 +0530, Vinod Koul wrote:
> Add the SoC specific compatible for SM8450 implementing
> arm,mmu-500.
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>  Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
