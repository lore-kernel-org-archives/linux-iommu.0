Return-Path: <SRS0=U628=6F=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46C51C2BA19
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 07:19:48 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0BB942074B
	for <iommu@archiver.kernel.org>; Tue, 21 Apr 2020 07:19:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BB942074B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id A3FC7227FC;
	Tue, 21 Apr 2020 07:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id T24ZbGo2zf+D; Tue, 21 Apr 2020 07:19:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id F0B831FEB7;
	Tue, 21 Apr 2020 07:19:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5F86C1D91;
	Tue, 21 Apr 2020 07:19:45 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A4D5C0175
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 07:19:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 5B184220EF
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 07:19:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RZ4Ki-y+BW31 for <iommu@lists.linux-foundation.org>;
 Tue, 21 Apr 2020 07:19:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ot1-f68.google.com (mail-ot1-f68.google.com
 [209.85.210.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 4CA4D1FEB7
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 07:19:42 +0000 (UTC)
Received: by mail-ot1-f68.google.com with SMTP id j26so10441290ots.0
 for <iommu@lists.linux-foundation.org>; Tue, 21 Apr 2020 00:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=veb+c1epeetzdg6zofKI0cevmUaJQHxspqLhCZkderQ=;
 b=GPNe6SqJuDX49NMB+yUVvqjvDTqm4L/ZYiz+YG5H9+lx9xTp7ir68+P9HWVR0uDO/P
 a/IAnB3vPP8mOQumaz4TMpC+Ly7fXu/pH83pzJuiPdWI8FhCMwqXI65FPv5b/qv6R5mi
 lxOS6aT9NQTSOcfJrGb/TESXpeVFQXJNem9RVBhZ//ubcW7p+CrdCwg1YB+6zQqjGID0
 18rAHZtjs0Xe/qp+cHc3QskKl4ulrrm0u0SgVclgvslEoUmRbgFZmgqvwD7oPs8hhsbK
 mdJ1z0Of15pflPOfkAwaWmd7EFVDuAJz1PC2+X/9PsR0+lYDts+qVeA4GNySAuWMEbwM
 3wYA==
X-Gm-Message-State: AGi0PuYN0zCAqk7Xu8UVfP5raJ8U7aq7xRc9HXmgbnuGxY6n30hlL5Dx
 pmdYrLFN9e38MPm7GgJcINSAy9lrSIAScHYMa4I=
X-Google-Smtp-Source: APiQypLzOp3GKz0WqE0yA707ywSnKhIAt8Y1SJIGp1YtyySWFoWR+keaq+xo+4clNPhU5Y70hNXNgaXr4Cv7dzv7JVU=
X-Received: by 2002:a9d:76c7:: with SMTP id p7mr12300178otl.145.1587453581546; 
 Tue, 21 Apr 2020 00:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <1587446152-23886-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1587446152-23886-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 21 Apr 2020 09:19:30 +0200
Message-ID: <CAMuHMdWcMqsP-77qSFoVmKDi6Sfjk-p3UXbdhjSODkkG+kn09Q@mail.gmail.com>
Subject: Re: [PATCH v5] dt-bindings: iommu: renesas,
 ipmmu-vmsa: convert to json-schema
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>
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

On Tue, Apr 21, 2020 at 7:16 AM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Convert Renesas VMSA-Compatible IOMMU bindings documentation
> to json-schema.
>
> Note that original documentation doesn't mention renesas,ipmmu-vmsa
> for R-Mobile APE6. But, R-Mobile APE6 is similar to the R-Car
> Gen2. So, renesas,ipmmu-r8a73a4 belongs the renesas,ipmmu-vmsa
> section.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
_______________________________________________
iommu mailing list
iommu@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/iommu
