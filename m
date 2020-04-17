Return-Path: <SRS0=1rof=6B=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426B3C2BB1D
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:42:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1594120857
	for <iommu@archiver.kernel.org>; Fri, 17 Apr 2020 07:42:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1594120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DAF6A86302;
	Fri, 17 Apr 2020 07:42:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7r-YzLqbxaVh; Fri, 17 Apr 2020 07:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1BF64862C1;
	Fri, 17 Apr 2020 07:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F05BEC1AE8;
	Fri, 17 Apr 2020 07:42:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A2CF8C0172
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 88B1C20526
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:42:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8uLVqc4lEY1L for <iommu@lists.linux-foundation.org>;
 Fri, 17 Apr 2020 07:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f66.google.com (mail-oo1-f66.google.com
 [209.85.161.66])
 by silver.osuosl.org (Postfix) with ESMTPS id 8402D20413
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 07:42:09 +0000 (UTC)
Received: by mail-oo1-f66.google.com with SMTP id y131so275754ooa.2
 for <iommu@lists.linux-foundation.org>; Fri, 17 Apr 2020 00:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fWeUFKxDD1hklpuXtyjSbQe5r1FNrLFqKnrYsB3o+7o=;
 b=ZKM8K5EZglT3E5wY1v3i2pvSn3V00p9fwXrMIYYBFkDqGAOSkOxl3uC0Dd+LIEfvHw
 GOB/h4GGhMwr2RWaonHPrIfLZP2HxObxlg5+1zQ8M6YdTxvMk3ZOjG1Z++H4FZ96mIRp
 dEswAgg9wYRfGVVk39BpNaLX8Y2+B2zMjcPOki/XhypmaqiQHEBb9G0LfWNPG1hQSXn4
 pU3obDbaa47eu4tV3+TMSQzcyPLdZFYzYX2INWxejoKKD7uAh2z4ZbTGh6Kh7ZFrXYh8
 WwXaeeSt/4VgQn/5U9HC5VIGJlK8e2GD5WWbfvE3gXEkx8z1+jzAp5Qf+320LJpggwMT
 jkxw==
X-Gm-Message-State: AGi0PuZRl70FhSV5qbnfsHuPW1pZDntRSsdV5rX95vINMEk1bRClr2Uq
 UyeZjMmxmPNjT4q9YlIrylyw1nuuNUu+suiUyq8=
X-Google-Smtp-Source: APiQypL6pte3YrpH31dxcJOLGJ4OzC7E+jLbjM9wD8LHbLYj4M4+F8lMJVezlZjUGLPOpeozMSGWEZYlLuLGneBOdN0=
X-Received: by 2002:a4a:e1af:: with SMTP id 15mr1519223ooy.40.1587109328784;
 Fri, 17 Apr 2020 00:42:08 -0700 (PDT)
MIME-Version: 1.0
References: <1587106953-1415-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <1587106953-1415-1-git-send-email-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Fri, 17 Apr 2020 09:41:57 +0200
Message-ID: <CAMuHMdUZxWCF2tr1jQLzNn8MzoDOJ4BNDwm=MD3+3+60g4Bbaw@mail.gmail.com>
Subject: Re: [PATCH v4] dt-bindings: iommu: renesas,
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

On Fri, Apr 17, 2020 at 9:03 AM Yoshihiro Shimoda
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
