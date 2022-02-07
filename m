Return-Path: <iommu-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B140C433F5
	for <iommu@archiver.kernel.org>; Mon,  7 Feb 2022 14:27:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 314AF60810;
	Mon,  7 Feb 2022 14:27:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KMazYilhBE9r; Mon,  7 Feb 2022 14:27:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 17FF660769;
	Mon,  7 Feb 2022 14:27:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C67B6C0011;
	Mon,  7 Feb 2022 14:27:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E606C000B
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:27:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3C07240167
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:27:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wREyfwA1vLTe for <iommu@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 14:27:17 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E8EB540153
 for <iommu@lists.linux-foundation.org>; Mon,  7 Feb 2022 14:27:16 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id o15so7926426vki.2
 for <iommu@lists.linux-foundation.org>; Mon, 07 Feb 2022 06:27:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cjodH+zCyALNPMiBPcK9ULdaejBlXthJyh10D4W5H+s=;
 b=Egd0vnlh5CMbSHFDpzP8Ria0ZF3p4GV0F/bcdBhTKOeHelgoe2lwtKW8cfiM5FLCCl
 EZDGAEFwvoQiAUqTGdeZ4YjWhasR/TLMQ5w35nzKyo18hTTbtFXGAHci3Ec6G8FN0Dda
 7MK27Lq3ggVgY2Bacj5aUsXE7sJahEulcbkp9uzdbUDh9WJGI97XBvSvyx0zE90uQSEn
 N1K+or0BuCJRzeIFaUb8zZQqBpFwjdGAbqHUDSqE+HLNDy5vjV8Vi+Ogu1P03X5pldab
 OiJQa8tgpFASgsx3MTtGNX/hPbYvphnua3RbEo2ro7bKSvLl6YWR6Q3khqYiQDQBtDm+
 aD1Q==
X-Gm-Message-State: AOAM533VGv/PWDtEslq8mEYiTcTUEM0A/8HQlfTFBt/oQD0MxcDyu7QN
 0GeAgjfK/e2/gdBftiJekt7L5Ewjz/LP4Q==
X-Google-Smtp-Source: ABdhPJznmNpbB7gxi10ArfJ3vIzGUDhByyokbrCHMH6zRc3mZZg69i2Z83mH8hmWea9jMFa7sMsEyg==
X-Received: by 2002:a05:6122:91b:: with SMTP id
 j27mr5182650vka.32.1644244035624; 
 Mon, 07 Feb 2022 06:27:15 -0800 (PST)
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com.
 [209.85.222.44])
 by smtp.gmail.com with ESMTPSA id r132sm2328683vkr.33.2022.02.07.06.27.15
 for <iommu@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Feb 2022 06:27:15 -0800 (PST)
Received: by mail-ua1-f44.google.com with SMTP id f13so10757246uab.10
 for <iommu@lists.linux-foundation.org>; Mon, 07 Feb 2022 06:27:15 -0800 (PST)
X-Received: by 2002:a67:c198:: with SMTP id h24mr4669413vsj.5.1644244035167;
 Mon, 07 Feb 2022 06:27:15 -0800 (PST)
MIME-Version: 1.0
References: <20220204125653.1194249-1-yoshihiro.shimoda.uh@renesas.com>
 <20220204125653.1194249-3-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20220204125653.1194249-3-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Feb 2022 15:27:04 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXmcbv2Foo8njcCv2hrbG=09uff=WduVa3VDRn331LQSw@mail.gmail.com>
Message-ID: <CAMuHMdXmcbv2Foo8njcCv2hrbG=09uff=WduVa3VDRn331LQSw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] iommu/ipmmu-vmsa: Add support for R-Car Gen4
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

On Fri, Feb 4, 2022 at 4:49 PM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add support for R-Car Gen4 like r8a779f0 (R-Car S4-8). The IPMMU
> hardware design of r8a779f0 is the same as r8a779a0. So, rename
> "r8a779a0" to "rcar_gen4".
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
