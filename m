Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E6C3C433EF
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 14:26:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6416607FE;
	Mon,  7 Feb 2022 14:26:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ktsKhbrDm0-4; Mon,  7 Feb 2022 14:26:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B12E2606F9;
	Mon,  7 Feb 2022 14:26:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8B51CC0011;
	Mon,  7 Feb 2022 14:26:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4283DC000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:26:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1F81781699
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:26:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wa8MtiiED0u9 for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 14:26:42 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com
 [209.85.222.47])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3316A81460
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:26:42 +0000 (UTC)
Received: by mail-ua1-f47.google.com with SMTP id r8so23238650uaj.0
 for <iommu@lists.linux-foundation.org>; Mon, 07 Feb 2022 06:26:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qJ6gtmWsE0qbWiYsJQ66pdtMsX/wOuo4autMcLLjsHk=;
 b=VqT7a0sMOjy7NTAJ7K5n/630q78VcyOW68b2nxTIfqhcpnSwvfBnF6SRC52OPZLb1G
 96RPWczusy1dOz+1nSbwNwX/nsm6wlurBVdu53MYtRNH/pS3yJpcye8guUCHAGXcFkJf
 UWk59sSxL0gJJGwkTKV7PXCtXKqvYtp+e7hSl9jna4HLolIsF+oOmweFlFPsdWz5ysy1
 eWjdxE8heX1C835Xf7+o1loR9eWJUVULQpf88H1lmvpUAJK+GKBY94vpdRTDF3hV0UV+
 7REZ+AFI8l1E6CRcnLpvl0qoFDU4dAdVPcFbq4o3Mt6J7INtKZNOI7CL/O/cuVArvQLD
 Qzyw==
X-Gm-Message-State: AOAM5314Lgr+UGHrjJQhFvlouNf9a1Y9JX3hxXK+cwFCCurdCVvBAuHj
 qlBFCTe4hWnE01VuD/x2BaGC2yIT1zZBsQ==
X-Google-Smtp-Source: ABdhPJx7wbDNqoVc0SEQ/GxdmI47f7TFWKxfuvynWmJR6HhdLoxP4vuyT3f6FEgYDsiJkyirW2Mnwg==
X-Received: by 2002:ab0:184a:: with SMTP id j10mr3470582uag.124.1644244001030; 
 Mon, 07 Feb 2022 06:26:41 -0800 (PST)
Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com.
 [209.85.222.45])
 by smtp.gmail.com with ESMTPSA id s11sm2324049vke.47.2022.02.07.06.26.40
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 06:26:40 -0800 (PST)
Received: by mail-ua1-f45.google.com with SMTP id 60so23154619uae.1
 for <iommu@lists.linux-foundation.org>; Mon, 07 Feb 2022 06:26:40 -0800 (PST)
X-Received: by 2002:a67:fd63:: with SMTP id h3mr4173263vsa.77.1644244000192;
 Mon, 07 Feb 2022 06:26:40 -0800 (PST)
MIME-Version: 1.0
References: <20220204125653.1194249-1-yoshihiro.shimoda.uh@renesas.com>
 <20220204125653.1194249-2-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220204125653.1194249-2-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Feb 2022 15:26:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUc_VmwR43CgYhwKZ+t_GCXzj9+9vaEBZR-2-ui1PC-1Q@mail.gmail.com>
Message-ID: <CAMuHMdUc_VmwR43CgYhwKZ+t_GCXzj9+9vaEBZR-2-ui1PC-1Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iommu: renesas,ipmmu-vmsa: add
 r8a779f0 support
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Linux IOMMU <iommu@lists.linux-foundation.org>,
 Rob Herring <robh+dt@kernel.org>, Will Deacon <will@kernel.org>
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

On Fri, Feb 4, 2022 at 2:54 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Document the compatible values for the IPMMU-VMSA blocks in
> the Renesas R-Car S4-8 (R8A779F0) SoC and R-Car Gen4.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> 3fbefb9570325500dbf3faff80ded6d0d46f48b2

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
