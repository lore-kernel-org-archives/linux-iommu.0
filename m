Return-Path: <SRS0=kPPe=6T=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F892C47247
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 19:11:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7B54206B9
	for <iommu@archiver.kernel.org>; Tue,  5 May 2020 19:11:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7B54206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9396887E8F;
	Tue,  5 May 2020 19:11:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5uB4s2buZM3i; Tue,  5 May 2020 19:11:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 79CD087C65;
	Tue,  5 May 2020 19:11:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5550DC088B;
	Tue,  5 May 2020 19:11:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 50F7EC0175
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 19:11:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 3854188702
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 19:11:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ONB0SQupg-wy for <iommu@lists.linux-foundation.org>;
 Tue,  5 May 2020 19:11:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oi1-f196.google.com (mail-oi1-f196.google.com
 [209.85.167.196])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 998D3886E1
 for <iommu@lists.linux-foundation.org>; Tue,  5 May 2020 19:11:01 +0000 (UTC)
Received: by mail-oi1-f196.google.com with SMTP id s202so3003099oih.3
 for <iommu@lists.linux-foundation.org>; Tue, 05 May 2020 12:11:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=sPZdlJTtTRQJiLlibAWVzC2KCD6dgBidSCLi0OcybB8=;
 b=tCbMOePyqgqsx8df0P94ziH/idD6b7+qXOk5WsQ50N0ebVGYeR5UU7uf1cr6QO1E+y
 oQqCeNb5sUPCH4ViuSpkVVA4DhcSYev0GYVnHPGYzEQI+ZqMPQMpkM4E+Gg7QsZuxuOl
 RmtE6qqKXpFLqvvw3fqlzZ8a03sp7GzWhn8h1oVzKqwf546gbCOTArQmtS3H29Vq+QjH
 cplyJqBt7cB+ck0PpGlt+NIaeOwaWCno5KidDvuh6SRWXkBrRkLIMUV7Tzfk66AZwjLT
 3NIgpy2/k5DYnte50ZEIQocUJA9d1BVhLhspuuYkoK4VtR2R84nHODCPeO7/b/AxnKkm
 xM/g==
X-Gm-Message-State: AGi0PubUIiC9V/IGhTfPWE9+//iSjP+xEU2a39WeEkJG6SzqpdYHaTiG
 isryARX541J8QRW0OgV9ew==
X-Google-Smtp-Source: APiQypIXGxmvcD4gphth8NXIPfPGvEQixA24pgsZd0empG7WGJlIZgA64cPSpqiIpycAgPTrfluZQw==
X-Received: by 2002:aca:53cd:: with SMTP id h196mr84159oib.104.1588705860814; 
 Tue, 05 May 2020 12:11:00 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id y2sm799299oot.16.2020.05.05.12.10.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2020 12:10:59 -0700 (PDT)
Received: (nullmailer pid 25300 invoked by uid 1000);
 Tue, 05 May 2020 19:10:58 -0000
Date: Tue, 5 May 2020 14:10:58 -0500
From: Rob Herring <robh@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: Re: [PATCH v5] dt-bindings: iommu: renesas,ipmmu-vmsa: convert to
 json-schema
Message-ID: <20200505191058.GA25129@bogus>
References: <1587446152-23886-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1587446152-23886-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Cc: devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 iommu@lists.linux-foundation.org, robh+dt@kernel.org
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

On Tue, 21 Apr 2020 14:15:52 +0900, Yoshihiro Shimoda wrote:
> Convert Renesas VMSA-Compatible IOMMU bindings documentation
> to json-schema.
> 
> Note that original documentation doesn't mention renesas,ipmmu-vmsa
> for R-Mobile APE6. But, R-Mobile APE6 is similar to the R-Car
> Gen2. So, renesas,ipmmu-r8a73a4 belongs the renesas,ipmmu-vmsa
> section.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  Changes from v4:
>  - Fix description about cell counts on #iommu-cells and renesas,ipmmu-main.
>  - Fix node name on the example. 
>  https://patchwork.kernel.org/patch/11494231/
> 
>  Changes from v3:
>  - Fix renesas,ipmmu-r8a7795's section
>  https://patchwork.kernel.org/patch/11494079/
> 
>  Changes from v2:
>  - Add a description for R-Mobile APE6 on the commit log.
>  - Change renesas,ipmmu-r8a73a4 section on the compatible.
>  - Add items on the interrupts.
>  - Add power-domains to required.
>  - Add oneOf for interrupts and renesas,ipmmu-main
>  https://patchwork.kernel.org/patch/11490581/
> 
>  Changes from v1:
>  - Fix typo in the subject.
>  - Add a description on #iommu-cells.
>  https://patchwork.kernel.org/patch/11485415/
> 
>  .../bindings/iommu/renesas,ipmmu-vmsa.txt          | 73 ----------------
>  .../bindings/iommu/renesas,ipmmu-vmsa.yaml         | 98 ++++++++++++++++++++++
>  2 files changed, 98 insertions(+), 73 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.txt
>  create mode 100644 Documentation/devicetree/bindings/iommu/renesas,ipmmu-vmsa.yaml
> 

Applied, thanks.

Rob
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
