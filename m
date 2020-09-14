Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324DAC2BBD1
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:08:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A06B32193E
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 22:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A06B32193E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 3C212203F0;
	Mon, 14 Sep 2020 22:08:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5yJL6P2w65U9; Mon, 14 Sep 2020 22:08:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 5AF7A2001E;
	Mon, 14 Sep 2020 22:08:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3467BC0864;
	Mon, 14 Sep 2020 22:08:34 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7DCD2C0051
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:08:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A0F58628A
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:08:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9-t2ReAFYy+7 for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 22:08:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-io1-f66.google.com (mail-io1-f66.google.com
 [209.85.166.66])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D9DD186225
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 22:08:32 +0000 (UTC)
Received: by mail-io1-f66.google.com with SMTP id y13so1874778iow.4
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 15:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HfVeQ81fFlvBzyeQzVxZZpi/9tbQOUKFJsP3PWI05Uc=;
 b=Wa1MAMbBvjgkeJJJ2hjee2PVxQLUNpS++zz2EKBspNSbJuIBcy5d0JmLSSknZ++a8v
 NsiAX+pOvkQHWEEl+WF9JtrtggWdk9QnKRTinl67ySF9nXBNBIPnBxXZm/04uEafUhcm
 sRpuVi9aEBr68QzmNugsj5PKsGwtBpoZKJBxt0GZavCNBv1IVv9l8DYQlUww7sXu8wVR
 MJ3JIA6iINr0Xl9vCO5KuVGYYy0AuP/KtucgryRiPUpa/IqUOVuHSz0Qf2YhN2pbXWIF
 NrBn6W1N9PZtOVutqBkKGvYYbkoc8xnNTUlg60OX0lkEzJytIYDBr3xhDcI6lvzj9uYR
 vK6g==
X-Gm-Message-State: AOAM531XsMGQ3oF8ZHPKww0QsNAE/F7fM1AAtRIX2P2I60LWVyiegM+D
 x6Nj9oeAql19TwCZovMoIQ==
X-Google-Smtp-Source: ABdhPJzOEWAxnZG+kDpP3Y4L1MtUa0ni/O8Jr2Ub5j+QdhNiZ4nS4jkbiRz6otnEmg9u4/zC1QacmQ==
X-Received: by 2002:a05:6602:15c5:: with SMTP id
 f5mr11938387iow.42.1600121312167; 
 Mon, 14 Sep 2020 15:08:32 -0700 (PDT)
Received: from xps15 ([64.188.179.253])
 by smtp.gmail.com with ESMTPSA id m15sm7558130ild.8.2020.09.14.15.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2020 15:08:31 -0700 (PDT)
Received: (nullmailer pid 346892 invoked by uid 1000);
 Mon, 14 Sep 2020 22:08:29 -0000
Date: Mon, 14 Sep 2020 16:08:29 -0600
From: Rob Herring <robh@kernel.org>
To: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: reserved-memory: Document "active"
 property
Message-ID: <20200914220829.GA330122@bogus>
References: <20200904130000.691933-1-thierry.reding@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200904130000.691933-1-thierry.reding@gmail.com>
Cc: devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
 Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, Will Deacon <will@kernel.org>
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

On Fri, Sep 04, 2020 at 02:59:57PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Reserved memory regions can be marked as "active" if hardware is
> expected to access the regions during boot and before the operating
> system can take control. One example where this is useful is for the
> operating system to infer whether the region needs to be identity-
> mapped through an IOMMU.

I like simple solutions, but this hardly seems adequate to solve the 
problem of passing IOMMU setup from bootloader/firmware to the OS. Like 
what is the IOVA that's supposed to be used if identity mapping is not 
used?

If you know enough about the regions to assume identity mapping, then 
can't you know if active or not?

> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../bindings/reserved-memory/reserved-memory.txt           | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> index 4dd20de6977f..163d2927e4fc 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> +++ b/Documentation/devicetree/bindings/reserved-memory/reserved-memory.txt
> @@ -63,6 +63,13 @@ reusable (optional) - empty property
>        able to reclaim it back. Typically that means that the operating
>        system can use that region to store volatile or cached data that
>        can be otherwise regenerated or migrated elsewhere.
> +active (optional) - empty property
> +    - If this property is set for a reserved memory region, it indicates
> +      that some piece of hardware may be actively accessing this region.
> +      Should the operating system want to enable IOMMU protection for a
> +      device, all active memory regions must have been identity-mapped
> +      in order to ensure that non-quiescent hardware during boot can
> +      continue to access the memory.
>  
>  Linux implementation note:
>  - If a "linux,cma-default" property is present, then Linux will use the
> -- 
> 2.28.0
> 
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
