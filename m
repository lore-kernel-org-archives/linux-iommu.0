Return-Path: <SRS0=C6HT=CX=lists.linux-foundation.org=iommu-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 686FBC433E2
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 12:12:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4CDE21655
	for <iommu@archiver.kernel.org>; Mon, 14 Sep 2020 12:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4CDE21655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=iommu-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6D1B61FEAE;
	Mon, 14 Sep 2020 12:12:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JiOkqt1ws9VJ; Mon, 14 Sep 2020 12:12:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 85A7C20014;
	Mon, 14 Sep 2020 12:10:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 670A9C088B;
	Mon, 14 Sep 2020 12:10:13 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A50F8C0859
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 12:10:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 93FDB84595
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 12:10:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BsZ241M1gzEQ for <iommu@lists.linux-foundation.org>;
 Mon, 14 Sep 2020 12:10:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-oo1-f65.google.com (mail-oo1-f65.google.com
 [209.85.161.65])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D1F1D858FC
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 12:10:09 +0000 (UTC)
Received: by mail-oo1-f65.google.com with SMTP id h8so3958003ooc.12
 for <iommu@lists.linux-foundation.org>; Mon, 14 Sep 2020 05:10:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=sdE+LuX+2Qm0gSEGuHp+5gVUIvIevbsDt3zyJVz18a8=;
 b=Sn+vFFUTkMcfzzEf7MzOHuOAMhbCdwBCL4Ic03Xlwfk8in2UgeyOAXkhgPJL+uCqKC
 3zsHGaa8nh0gLtzlGv1PmEgc5htK8TduG1xdUCeU6eOIqFEc1euY36jrRzdtzFNsggyR
 tU1YaUdAZXUyhxTZaxh8k2TN5r5ukpRu66T1+IqkPCHpLUnC7u/4ngSRP44t7Aew+hqS
 EZAbVLQJx2E/RLpleLyxesxyuIk6E6GcjpxNuHEVttyg968ixcx3/xQcvuR1+rQu+dW+
 GCDu8auvYA/TtKT/JwfhkE/rV6z+aLFzkI8IGWCoMzDS2PrFC4aLc8QWPDx650y+RI2N
 nLKg==
X-Gm-Message-State: AOAM530w/btygqcot9XEkR1oQ6e7JuYBOq6QFMbg9sk0WW5IIruTJ1Eb
 msjm+1C7a8CQ3yP9dEi3yYD2VtYC8HPOBP8nqP4=
X-Google-Smtp-Source: ABdhPJzUxCOjVtmAzH9z/y7jXufNCW8ofbrULZBtHNZfFSSc9+zcC9VH4EYPvpflzezGIBdaiPfjNspKcpw1qV1m7Vc=
X-Received: by 2002:a4a:5d84:: with SMTP id w126mr8304418ooa.1.1600085409099; 
 Mon, 14 Sep 2020 05:10:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200911101912.20701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
In-Reply-To: <20200911101912.20701-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 14 Sep 2020 14:09:57 +0200
Message-ID: <CAMuHMdU0YuF2DqndABE5RGS1ymK2hqFyim6aYsqnPkW_PHe9xQ@mail.gmail.com>
Subject: Re: [PATCH] iommu: Kconfig: Update help description for IPMMU_VMSA
 config
To: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Fri, Sep 11, 2020 at 12:19 PM Lad Prabhakar
<prabhakar.mahadev-lad.rj@bp.renesas.com> wrote:
> ipmmu-vmsa driver is also used on Renesas RZ/G{1,2} Soc's, update the
> same to reflect the help description for IPMMU_VMSA config.

... update the help description for the IPMMU_VMSA config symbol to reflect
this?

>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> Reviewed-by: Chris Paterson <Chris.Paterson2@renesas.com>

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
