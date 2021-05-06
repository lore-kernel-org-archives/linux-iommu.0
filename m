Return-Path: <SRS0=J567=KB=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F0EC433ED
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 20:35:45 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A73B6112F
	for <iommu@archiver.kernel.org>; Thu,  6 May 2021 20:35:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A73B6112F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 358AA83D96;
	Thu,  6 May 2021 20:35:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hv9wjCh9SQwe; Thu,  6 May 2021 20:35:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86B1E83D85;
	Thu,  6 May 2021 20:35:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B78AC000E;
	Thu,  6 May 2021 20:35:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 712B5C0001
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 20:35:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6004C83D85
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 20:35:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 23drLjmnXk1c for <iommu@lists.linux-foundation.org>;
 Thu,  6 May 2021 20:35:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D559B83D19
 for <iommu@lists.linux-foundation.org>; Thu,  6 May 2021 20:35:41 +0000 (UTC)
Received: by mail-oi1-f169.google.com with SMTP id b25so1461169oic.0
 for <iommu@lists.linux-foundation.org>; Thu, 06 May 2021 13:35:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=XviLvGpJFaRdXjUf+47jXRg5BSAJvuUIHuWDGU5d4Yg=;
 b=Z9yf9w7UcOgEgoMUQNahM7XVlnNC5k9Il+d0M/86LE1GIRWYOJQ9AUxqWJOFheeLRO
 bheK+IAq/ziptJvFPY+KCXlSdrRcYhXO1bbdfg5fqZSqtKJLefPl/Od0ucG/qn3rfjZy
 O1R9mhL/log6ZMuQXXAaFbPfKDKswLkQhgXKcepnCHZXCoK++efAKqYWMciFMYQECsnE
 Vn1bvzycA9MRd3rc6BbJ1zIWl2uOzyYOk2zITwMlBPZ5w+A5uXtt8fcmGI7ZbspSNhMn
 lNsMLFcxG/BEIbamJFt2iKXCKD6060ZwAHuFdijgB3UBQfAOX656+TOrluWpTZLGiYcS
 ksgg==
X-Gm-Message-State: AOAM532qrTVUmZBs6/ESl8S6k9XdDyfKnC98YfLT1UFWUPAGs/DTy2o3
 qSSQJGnTYFDGSFaT4llzkA==
X-Google-Smtp-Source: ABdhPJxRy2L+/BAoxrnnJOdfWaZK4QI9+BE9wFOUThILsEgKO/rZw4PbKWcnlhOXEaSb+96gFpBsWQ==
X-Received: by 2002:a54:4017:: with SMTP id x23mr4483952oie.13.1620333340966; 
 Thu, 06 May 2021 13:35:40 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id w66sm716019ooa.37.2021.05.06.13.35.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 May 2021 13:35:40 -0700 (PDT)
Received: (nullmailer pid 759479 invoked by uid 1000);
 Thu, 06 May 2021 20:35:39 -0000
Date: Thu, 6 May 2021 15:35:39 -0500
From: Rob Herring <robh@kernel.org>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: Re: [PATCH v3 2/4] dt-bindings: iommu: rockchip: Add compatible for v2
Message-ID: <20210506203539.GA759432@robh.at.kernel.org>
References: <20210504084124.131884-1-benjamin.gaignard@collabora.com>
 <20210504084124.131884-3-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210504084124.131884-3-benjamin.gaignard@collabora.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org, iommu@lists.linux-foundation.org,
 robh+dt@kernel.org, kernel@collabora.com, will@kernel.org,
 linux-arm-kernel@lists.infradead.org, heiko@sntech.de
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

On Tue, 04 May 2021 10:41:22 +0200, Benjamin Gaignard wrote:
> Add compatible for the second version of IOMMU hardware block.
> RK356x IOMMU can also be link to a power domain.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
> version 3:
>  - Rename compatible with SoC name
> 
> version 2:
>  - Add power-domains property
> 
>  .../devicetree/bindings/iommu/rockchip,iommu.yaml          | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
